// TAMPA PARA TELEMÓVEL COM ENCAIXE
// Variáveis personalizáveis

// Dimensões do telemóvel (com folga de 0.5mm)
comprimento_tele = 75;    // Comprimento do telemóvel
altura_tele = 150;        // Altura do telemóvel  
profundidade_tele = 10;   // Profundidade/espessura do telemóvel
folga = 0.5;              // Folga para encaixe

// Parâmetros da tampa
espessura_fundo = 1.5;    // Espessura do fundo
altura_borda = 3;         // Altura das bordas laterais
espessura_borda = 2;      // Espessura das bordas

// Buraco da câmera
percentual_camera = 0.15; // 15% das dimensões

// Trinco de encaixe
largura_trinco = 5;       // Largura do trinco
altura_trinco = 2;        // Altura do trinco
profundidade_trinco = 2;  // Profundidade do trinco

// ========== CÁLCULOS AUTOMÁTICOS ==========
comprimento_com_folga = comprimento_tele + 2*folga;
altura_com_folga = altura_tele + 2*folga;
profundidade_com_folga = profundidade_tele + folga;

// Dimensões do buraco da câmera
largura_camera = comprimento_tele * percentual_camera;
altura_camera = altura_tele * percentual_camera;

// ========== MÓDULOS PRINCIPAIS ==========

// Fundo da tampa
module fundo() {
    color("Yellow")
    cube([comprimento_com_folga, altura_com_folga, espessura_fundo]);
}

// Bordas laterais
module bordas() {
    color("Yellow")
    // Borda inferior
    translate([0, 0, espessura_fundo])
    cube([comprimento_com_folga, espessura_borda, altura_borda]);
    color("Yellow")
    // Borda superior
    translate([0, altura_com_folga - espessura_borda, espessura_fundo])
    cube([comprimento_com_folga, espessura_borda, altura_borda]);
    color("Yellow")
    // Borda esquerda
    translate([0, 0, espessura_fundo])
    cube([espessura_borda, altura_com_folga, altura_borda]);
    color("Yellow")
    // Borda direita
    translate([comprimento_com_folga - espessura_borda, 0, espessura_fundo])
    cube([espessura_borda, altura_com_folga, altura_borda]);
}

// Buraco para câmera (centralizado no topo)
module buraco_camera() {
    translate([
        comprimento_com_folga/2 - largura_camera/2,
        altura_com_folga - altura_camera - 5,  // 5mm da borda superior
        -1
    ])
    cube([largura_camera, altura_camera, espessura_fundo + 2]);
}

// Trincos de encaixe
module trincos() {
    color("Yellow")
    // Trinco esquerdo (superior)
    translate([
        espessura_borda,
        altura_com_folga - espessura_borda - profundidade_trinco,
        espessura_fundo + altura_borda
    ])
    cube([largura_trinco, profundidade_trinco, altura_trinco]);
    color("Yellow")
    // Trinco direito (superior)
    translate([
        comprimento_com_folga - espessura_borda - largura_trinco,
        altura_com_folga - espessura_borda - profundidade_trinco,
        espessura_fundo + altura_borda
    ])
    cube([largura_trinco, profundidade_trinco, altura_trinco]);
    color("Yellow")
    // Trincos inferiores (opcionais - para melhor fixação)
    // Trinco esquerdo (inferior)
    translate([
        espessura_borda,
        espessura_borda,
        espessura_fundo + altura_borda
    ])
    cube([largura_trinco, profundidade_trinco, altura_trinco]);
    color("Yellow")
    // Trinco direito (inferior)
    translate([
        comprimento_com_folga - espessura_borda - largura_trinco,
        espessura_borda,
        espessura_fundo + altura_borda
    ])
    cube([largura_trinco, profundidade_trinco, altura_trinco]);
}

// ========== MODELO FINAL ==========
difference() {
    union() {
        fundo();
        bordas();
        trincos();
    }
    buraco_camera();
}

// ========== VISUALIZAÇÃO DO TELEMÓVEL ==========
// (apenas para referência - remova o % para ver)
%translate([folga, folga, espessura_fundo + altura_borda])
color("Yellow", 0.3)
cube([comprimento_tele, altura_tele, profundidade_tele]);

// ========== LEGENDA EXPLICATIVA ==========
echo("=== ESPECIFICAÇÕES DA TAMPA ===");
echo(str("Dimensões externas: ", comprimento_com_folga, "mm x ", altura_com_folga, "mm"));
echo(str("Área da câmera: ", largura_camera, "mm x ", altura_camera, "mm"));
echo(str("Número de trincos: 4 (2 superiores + 2 inferiores)"));
echo(str("Folga aplicada: ", folga, "mm em todas as dimensões"));

/*
INSTRUÇÕES DE USO:
1. Ajuste as variáveis no início conforme seu telemóvel
2. Renderize (F6) e exporte como STL
3. Imprima com o fundo na cama de impressão

PERSONALIZAÇÕES:
- Aumente 'folga' para um encaixe mais frouxo
- Ajuste 'percentual_camera' para o tamanho da sua câmera
- Modifique 'altura_borda' para maior proteção lateral
*/