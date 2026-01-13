using System;
using System.Collections.Generic;
using System.Linq;

class Node
{
    public int Valor;
    public Node Esquerda;
    public Node Direita;

    public Node(int valor)
    {
        Valor = valor;
    }
}

class ArvoreBuilder
{
    public static Node Construir(int[] array)
    {
        int raizValor = array.Max();
        int indiceRaiz = Array.IndexOf(array, raizValor);

        var esquerda = array.Take(indiceRaiz)
                            .OrderByDescending(x => x)
                            .ToList();

        var direita = array.Skip(indiceRaiz + 1)
                           .OrderByDescending(x => x)
                           .ToList();

        Node raiz = new Node(raizValor);

        Node atual = raiz;
        foreach (var v in esquerda)
        {
            var novo = new Node(v);
            atual.Esquerda = novo;
            atual = novo;
        }

        atual = raiz;
        foreach (var v in direita)
        {
            var novo = new Node(v);
            atual.Direita = novo;
            atual = novo;
        }

        return raiz;
    }
}

class Program
{
    static void Main(string[] args)
    {        
        int[] array1 = { 3, 2, 1, 6, 0, 5 };
        Console.WriteLine("Cenário 1:");
        var raiz1 = ArvoreBuilder.Construir(array1);
        ImprimirArvore(raiz1);

        Console.WriteLine("\n---------------------------\n");

        int[] array2 = { 7, 5, 13, 9, 1, 6, 4 };
        Console.WriteLine("Cenário 2:");
        var raiz2 = ArvoreBuilder.Construir(array2);
        ImprimirArvore(raiz2);

        Console.ReadKey();
    }
    static void ImprimirArvore(Node raiz)
    {
        int altura = Altura(raiz);
        int largura = (int)Math.Pow(2, altura + 1);

        List<Node> nivelAtual = new List<Node> { raiz };

        for (int nivel = 0; nivel < altura; nivel++)
        {
            int espacoEntre = largura / (int)Math.Pow(2, nivel + 1);

            ImprimirEspacos(espacoEntre / 2);

            List<Node> proximoNivel = new List<Node>();

            foreach (var no in nivelAtual)
            {
                if (no == null)
                {
                    Console.Write(" ");
                    proximoNivel.Add(null);
                    proximoNivel.Add(null);
                }
                else
                {
                    Console.Write(no.Valor);
                    proximoNivel.Add(no.Esquerda);
                    proximoNivel.Add(no.Direita);
                }

                ImprimirEspacos(espacoEntre);
            }

            Console.WriteLine();


            ImprimirEspacos(espacoEntre / 2);

            foreach (var no in nivelAtual)
            {
                if (no == null)
                {
                    ImprimirEspacos(2);
                }
                else
                {
                    Console.Write(no.Esquerda != null ? "/" : " ");
                    Console.Write(no.Direita != null ? "\\" : " ");
                }

                ImprimirEspacos(espacoEntre - 1);
            }

            Console.WriteLine();

            nivelAtual = proximoNivel;
        }
    }

    static int Altura(Node no)
    {
        if (no == null) return 0;
        return 1 + Math.Max(Altura(no.Esquerda), Altura(no.Direita));
    }

    static void ImprimirEspacos(int qtd)
    {
        for (int i = 0; i < qtd; i++)
            Console.Write(" ");
    }


}
