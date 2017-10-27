/*
    --------------------------------------------------------------
    amino_to_dna.c

    Amino acid sequences to DNA sequence.

    Notes: 1. The file's name that contains the aminoacids sequence
              must be not longer of 79 chars.

           2. The aminoacids sequence must contain a maximum
              of 1364 chars.

    (c) Darío Monestel C. , Jeffrey Alvarado , Ricardo Dávila P.
        Costa Rica Institute of Technology.
		ll S 2017.
    --------------------------------------------------------------
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#define NELEMS(arr) (sizeof(arr) / sizeof((arr)[0]))

static bool sorted = false;

/* Genetic code */
struct code {
    const char *codon;
    const char aminoacid;
};

static struct code codes[] = {
    {"UUU", 'F'},	/* F - Phenylalanine */
    {"UUC", 'F'},
    {"UUA", 'L'},	/* L - Leucine */
    {"UUG", 'L'},
    {"CUU", 'L'},
    {"CUC", 'L'},
    {"CUA", 'L'},
    {"CUG", 'L'},
    {"AUU", 'I'},	/* I - Isoleucine */
    {"AUC", 'I'},
    {"AUA", 'I'},
    {"AUG", 'M'},	/* M - Methionine */
    {"GUU", 'V'},	/* V - Valine */
    {"GUC", 'V'},
    {"GUA", 'V'},
    {"GUG", 'V'},
    {"UCU", 'S'},	/* S - Serina */
    {"UCC", 'S'},
    {"UCA", 'S'},
    {"UCG", 'S'},
    {"AGU", 'S'},
    {"AGC", 'S'},
    {"CCU", 'P'},	/* P - Proline */
    {"CCC", 'P'},
    {"CCA", 'P'},
    {"CCG", 'P'},
    {"ACU", 'T'},	/* T - Threonine */
    {"ACC", 'T'},
    {"ACA", 'T'},
    {"ACG", 'T'},
    {"GCU", 'A'},	/* A - Alanina */
    {"GCC", 'A'},
    {"GCA", 'A'},
    {"GCG", 'A'},
    {"UAU", 'Y'},	/* Y - Tirosina */
    {"UAC", 'Y'},
    {"UAA", '.'},	/* . - Ocre Stop */
    {"UAG", '.'},	/* . - Amber Stop */
    {"CAU", 'H'},	/* H - Histidine */
    {"CAC", 'H'},
    {"CAA", 'Q'},	/* Q - Glutamine */
    {"CAG", 'Q'},
    {"AAU", 'N'},	/* N - Asparagine */
    {"AAC", 'N'},
    {"AAA", 'K'},	/* K- Lysine */
    {"AAG", 'K'},
    {"GAU", 'D'},	/* D - Aspartic acid */
    {"GAC", 'D'},
    {"GAA", 'E'},	/* E - Glutamic acid */
    {"GAG", 'E'},
    {"UGU", 'C'},	/* C - Cysteine */
    {"UGC", 'C'},
    {"UGA", '.'},	/* . - Opal Stop */
    {"UGG", 'W'},	/* W - Tryptophan */
    {"CGU", 'R'},	/* R - Arginine */
    {"CGC", 'R'},
    {"CGA", 'R'},
    {"CGG", 'R'},
    {"AGA", 'R'},
    {"AGG", 'R'},
    {"GGU", 'G'},	/* G - Glycine */
    {"GGC", 'G'},
    {"GGA", 'G'},
    {"GGG", 'G'}
};

static int compare(const void *p1, const void *p2)
{
    return strcmp(*((const char **)p1), *((const char **)p2));
}

char get_aminoacid(const char *codon)
{
    if (!sorted) {
        qsort(codes, NELEMS(codes), sizeof(*codes), compare);
        sorted = true;
    }
    struct code *code = bsearch(&codon, codes, NELEMS(codes),
        sizeof(*codes), compare);
    return code ? code->aminoacid : '\0';
}

/*

    TO DO


         get_aminoacid  (review)
         are_aminoacids
         Funtion RNA_to_aminoacids
         Funtion permutations_aux
         Funtion permutations
                 generate_RNA
                 get_valid_RNA   (get file)
                 RNA_to_DNA
                 translate_file_with_aminoacids()







*/


int main()
{
    translate_file_with_aminoacids();
}
