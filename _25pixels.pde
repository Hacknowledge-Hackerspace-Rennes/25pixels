/*
/
/     ATTENTION ceci est un code Quick'n'Dirty, codé suivant le fameuse méthode de Larrache.
/       
/     TODO : utiliser les interruptions et les timers pour le rafraichissement et les changements de frame
/     TODO : reflechir 
/
/
*/

#define TAILLEMAX 16
#define ENTREE 13


char textString[] = "  Hacknowledge -- tous les mardi 20h /\/\  ";
const int  arrayheight = 5;
const int  arraywidth  = 5;
const int  carwidth    = 5;

 
int nbloop,x ;


int index ;
char messageRecu[TAILLEMAX+1];


byte image[arrayheight] = {
  0b00001010,  
  0b00011111,
  0b00001010,
  0b00011111,
  0b00001010,
} ;

// fonte inspiré de http://www.dafont.com/5x5-dots.font

const byte font[][arrayheight] = {
        {0b00000000,0b00000000,0b00000000,0b00000000,0b00000000},   //   0x20 32 ok
        {0b00000100,0b00000100,0b00000100,0b00000000,0b00000100},   // ! 0x21 33 ok
        {0b00001010,0b00001010,0b00000000,0b00000000,0b00000000},   // " 0x22 34 ok
        {0b00001010,0b00011111,0b00001010,0b00011111,0b00001010},   // # 0x23 35 ok
        {0b00001111,0b00010100,0b00001110,0b00000101,0b00011110},   // $ 0x24 36 ok
        {0b00010001,0b00000010,0b00000100,0b00001000,0b00010001},   // % 0x25 37 ok
        {0b00001100,0b00010010,0b00001111,0b00010010,0b00001111},   // & 0x26 38 ok
        {0b00000100,0b00000100,0b00000000,0b00000000,0b00000000},   // ' 0x27 39 ok
        {0b00000010,0b00000100,0b00000100,0b00000100,0b00000010},   // ( 0x28 40 ok
        {0b00001000,0b00000100,0b00000100,0b00000100,0b00001000},   // ) 0x29 41 ok
        {0b00000100,0b00010101,0b00001110,0b00010101,0b00000100},   // * 0x2a 42 ok
        {0b00000100,0b00000100,0b00011111,0b00000100,0b00000100},   // + 0x2b 43 ok
        {0b00000000,0b00000000,0b00000000,0b00000100,0b00001000},   // , 0x2c 44 ok
        {0b00000000,0b00000000,0b00011111,0b00000000,0b00000000},   // - 0x2d 45 ok
        {0b00000000,0b00000000,0b00000000,0b00000000,0b00000100},   // . 0x2e 46 ok
        {0b00000001,0b00000010,0b00000100,0b00001000,0b00010000},   // / 0x2f 47 ok
        {0b00001110,0b00010011,0b00010101,0b00011001,0b00001110},   // 0 0x30 48 ok
        {0b00000100,0b00001100,0b00000100,0b00000100,0b00001110},   // 1 0x31 49 ok
        {0b00011110,0b00000001,0b00001110,0b00010000,0b00011111},   // 2 0x32 50 ok
        {0b00011110,0b00000001,0b00000110,0b00000001,0b00011110},   // 3 0x33 51 ok
        {0b00010001,0b00010001,0b00001111,0b00000001,0b00000001},   // 4 0x34 52 ok
        {0b00011111,0b00010000,0b00011110,0b00000001,0b00011110},   // 5 0x35 53 ok
        {0b00001111,0b00010000,0b00011110,0b00010001,0b00001110},   // 6 0x36 54 ok
        {0b00011111,0b00000001,0b00000010,0b00000010,0b00000010},   // 7 0x37 55 ok
        {0b00001110,0b00010001,0b00001110,0b00010001,0b00001110},   // 8 0x38 56 ok
        {0b00001110,0b00010001,0b00001111,0b00000001,0b00000110},   // 9 0x39 57 ok
        {0b00000000,0b00000100,0b00000000,0b00000100,0b00000000},   // : 0x3a 58 ok
        {0b00000000,0b00000100,0b00000000,0b00000100,0b00001000},   // ; 0x3b 59 ok
        {0b00000010,0b00000100,0b00001000,0b00000100,0b00000010},   // < 0x3c 60 ok
        {0b00000000,0b00011111,0b00000000,0b00011111,0b00000000},   // = 0x3d 61 ok
        {0b00001000,0b00000100,0b00000010,0b00000100,0b00001000},   // > 0x3e 62 ok
        {0b00001110,0b00010001,0b00000110,0b00000000,0b00000100},   // ? 0x3f 63 ok
        {0b00001110,0b00010001,0b00010101,0b00010011,0b00001100},   // @ 0x40 64 ok
        {0b00001110,0b00010001,0b00011111,0b00010001,0b00010001},   // A 0x41 65 ok
        {0b00011110,0b00010001,0b00011110,0b00010001,0b00011110},   // B 0x42 66 ok
        {0b00001111,0b00010000,0b00010000,0b00010000,0b00001111},   // C 0x43 67 ok
        {0b00011110,0b00010001,0b00010001,0b00010001,0b00011110},   // D 0x44 68 ok
        {0b00011111,0b00010000,0b00011111,0b00010000,0b00011111},   // E 0x45 69 ok
        {0b00011111,0b00010000,0b00011100,0b00010000,0b00010000},   // F 0x46 70 ok
        {0b00001111,0b00010000,0b00010111,0b00010001,0b00001111},   // G 0x47 71 ok
        {0b00010001,0b00010001,0b00011111,0b00010001,0b00010001},   // H 0x48 72 ok
        {0b00001110,0b00000100,0b00000100,0b00000100,0b00001110},   // I 0x49 73 ok
        {0b00000111,0b00000001,0b00000001,0b00010001,0b00001110},   // J 0x4a 74 ok
        {0b00010010,0b00010100,0b00011110,0b00010001,0b00010001},   // K 0x4b 75 ok
        {0b00010000,0b00010000,0b00010000,0b00010000,0b00011111},   // L 0x4c 76 ok
        {0b00010001,0b00011011,0b00010101,0b00010001,0b00010001},   // M 0x4d 77 ok
        {0b00011001,0b00010101,0b00010101,0b00010101,0b00010011},   // N 0x4e 78 ok
        {0b00001110,0b00010001,0b00010001,0b00010001,0b00001110},   // O 0x4f 79 ok
        {0b00011110,0b00010001,0b00011110,0b00010000,0b00010000},   // P 0x50 80 ok
        {0b00001100,0b00010010,0b00010010,0b00010010,0b00001111},   // Q 0x51 81 ok
        {0b00011110,0b00010001,0b00011110,0b00010010,0b00010001},   // R 0x52 82 ok
        {0b00001111,0b00010000,0b00001110,0b00000001,0b00011110},   // S 0x53 83 ok
        {0b00011111,0b00000100,0b00000100,0b00000100,0b00000100},   // T 0x54 84 ok
        {0b00010001,0b00010001,0b00010001,0b00010001,0b00001110},   // U 0x55 85 ok
        {0b00010001,0b00010001,0b00001010,0b00001010,0b00000100},   // V 0x56 86 ok
        {0b00010001,0b00010001,0b00010101,0b00011011,0b00010001},   // W 0x57 87 ok
        {0b00010001,0b00001010,0b00000100,0b00001010,0b00010001},   // X 0x58 88 ok
        {0b00010001,0b00010001,0b00001110,0b00000100,0b00000100},   // Y 0x59 89 ok
        {0b00011111,0b00000001,0b00001110,0b00010000,0b00011111},   // Z 0x5a 90 ok
        {0b00000110,0b00000100,0b00000100,0b00000100,0b00000110},   // [ 0x5b 91 ok
        {0b00010000,0b00001000,0b00000100,0b00000010,0b00000001},   // \ 0x5c 92 ok
        {0b00001100,0b00000100,0b00000100,0b00000100,0b00001100},   // ] 0x5d 93 ok
        {0b00000100,0b00001010,0b00000000,0b00000000,0b00000000},   // ^ 0x5e 94 ok
        {0b00000000,0b00000000,0b00000000,0b00000000,0b00011111},   // _ 0x5f 95 ok
        {0b00001000,0b00000100,0b00000000,0b00000000,0b00000000},   // ` 0x60 96 ok
        {0b00011110,0b00000001,0b00001111,0b00010001,0b00001111},   // a 0x61 97 ok
        {0b00010000,0b00011110,0b00010001,0b00010001,0b00011110},   // b 0x62 98 ok
        {0b00001110,0b00010001,0b00010000,0b00010001,0b00001110},   // c 0x63 99 ok
        {0b00000001,0b00001111,0b00010001,0b00010001,0b00001111},   // d 0x64 100 ok
        {0b00001110,0b00010001,0b00011111,0b00010000,0b00001111},   // e 0x65 101 ok
        {0b00001111,0b00010000,0b00011100,0b00010000,0b00010000},   // f 0x66 102 ok
        {0b00001110,0b00010001,0b00001111,0b00000001,0b00011110},   // g 0x67 103 ok
        {0b00010000,0b00011110,0b00010001,0b00010001,0b00010001},   // h 0x68 104 ok
        {0b00000100,0b00000000,0b00000100,0b00000100,0b00000100},   // i 0x69 105 ok
        {0b00000001,0b00000001,0b00000001,0b00000001,0b00011110},   // j 0x6a 106 ok
        {0b00010001,0b00010010,0b00011100,0b00010010,0b00010001},   // k 0x6b 107 ok
        {0b00010000,0b00010000,0b00010000,0b00010000,0b00001111},   // l 0x6c 108 ok
        {0b00001010,0b00010101,0b00010101,0b00010101,0b00010101},   // m 0x6d 109 ok
        {0b00011110,0b00010001,0b00010001,0b00010001,0b00010001},   // n 0x6e 110 ok
        {0b00001110,0b00010001,0b00010001,0b00010001,0b00001110},   // o 0x6f 111 ok
        {0b00011110,0b00010001,0b00010001,0b00011110,0b00010000},   // p 0x70 112 ok
        {0b00001111,0b00010001,0b00010001,0b00001111,0b00000001},   // q 0x71 113 ok
        {0b00010110,0b00011001,0b00010000,0b00010000,0b00010000},   // r 0x72 114 ok
        {0b00001111,0b00010000,0b00001110,0b00000001,0b00011110},   // s 0x73 115 ok
        {0b00010000,0b00011100,0b00010000,0b00010001,0b00001110},   // t 0x74 116 ok
        {0b00010001,0b00010001,0b00010001,0b00010011,0b00001101},   // u 0x75 117 ok
        {0b00010001,0b00010001,0b00001010,0b00001010,0b00000100},   // v 0x76 118 ok
        {0b00010101,0b00010101,0b00010101,0b00010101,0b00001010},   // w 0x77 119 ok
        {0b00010001,0b00010001,0b00001110,0b00010001,0b00010001},   // x 0x78 120 ok
        {0b00010001,0b00010001,0b00001111,0b00000001,0b00011110},   // y 0x79 121 ok
        {0b00011111,0b00000010,0b00000100,0b00001000,0b00011111},   // z 0x7a 122 ok
        {0b00000010,0b00000100,0b00001100,0b00000100,0b00000010},   // { 0x7b 123 ok
        {0b00000100,0b00000100,0b00000100,0b00000100,0b00000100},   // | 0x7c 124 ok
        {0b00001000,0b00000100,0b00000110,0b00000100,0b00001000},   // } 0x7d 125 ok
        {0b00000000,0b00001010,0b00010100,0b00000000,0b00000000},   // ~ 0x7e 126 ok
        {0b00000000,0b00000000,0b00000000,0b00000000,0b00000000},   // DEL 0x7f 127 
        
        
        
    };



void setup() {
  
  Serial.begin(9600);
  DDRB  = 0x3E ;
  PORTB = 0x00 ;
  DDRC  = 0x1F ;
  PORTC = 0x00 ;
  
  for (int p = 0 ; p<TAILLEMAX ; p++){
   messageRecu[p] = 88 ;
    
  
  }
  
  
}

void loop() {
  

  
  messageAlien();
  Serial.println("texte ordinaire");
  writeMessage(textString);
  
    //lireSerie();
  
  
}

void lireSerie(){
  // TODO : finir
  index = 0 ;
  
 while (Serial.available() > 0 && index < TAILLEMAX) {
    
         messageRecu[index] = char(Serial.read());
         index++;

    }
  
     messageRecu[index] = 0;  
     
     Serial.print("message Recu : ");
    Serial.println( messageRecu );
     writeMessage(messageRecu);
    
    
  /*
  do {
    while (!Serial.available());             // wait for input
    messageRecu[index] = Serial.read();       // get it
    if (messageRecu[index] == ENTREE) break;
  } while (++index < TAILLEMAX);
  messageRecu[index] = 0;                     // null terminate the string
   */
   
}
  
  


void messageAlien(){
  for (int be = 0; be<3 ;be++){
    nbloop = random(1,12);
    randImage();
    clearImage();
    refreshScreen();
    delay(200);
  }
}



// image "bruit"
void randImage(){
     for (int y = 0 ; y<nbloop ; y++){  
      for (int z = 0; z < 100 ;z++){  
        refreshScreen();             // each 0.5 ms  
      }  
      for (int r = 0; r < 5 ;r++) {
        image[r] = byte(random(255));
      }
    } 
}


// ecrire le message


void writeMessage(char* myMessage){
  Serial.print("longueur de la chaine : " );
    Serial.println( strlen(myMessage));

  
  // on décale la fenetre d'affichage sur la largeur totale du texte en pixel -> variable "i"
  for (int i=0; i< (strlen(myMessage)*(carwidth + 1) - arraywidth ) ; i++){
    
        //decaller le buffer de l'image d'un bit vers la gauche
    for (int r = 0; r < 5 ;r++) {
      image[r] <<= 1;
    }
    
    // quel est le bit actif de la lettre en cours
    // i est dans { 0;1;2;3;4;5 }
    int letterbit = i % (carwidth + 1);

    // si letterbit=5 alors c'est l'espace interlettre, on passe le tour
    if(letterbit != 5 ) { 
    
        int letterindex = int(i/(carwidth + 1)) ;
        char lettre = myMessage[letterindex];
        
        // index de la lettre voulu dans le tableau des lettres
         lettre -= 32;

         // rempli le bit laisse vide par le bon bit de la bonne lettre
        for (int r = 0 ; r < 5 ; r++ ) {    
          image[r] |= ((font[lettre][r] >> (carwidth - letterbit - 1)) & 0b00000001 );
        }
      
    }
          for (int x = 0; x < 80;x++){   // 
        refreshScreen();             // each 0.5 ms  
      }  
  }
}
    
void clearImage(){
  for (int r = 0; r < 5 ;r++) {
      image[r] = byte(0);
  }
}

void refreshScreen() {
  for (int r = 0; r < 5; r++) {
    PORTB = 1 << (r+1) ;
    PORTC = image[r] & 0b00011111;
    delayMicroseconds(400); 
  }
}
