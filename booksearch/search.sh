#!/bin/bash

DIRECTORY="$1"
DEBUG="$2"

if [ -z "$DIRECTORY" ]; then
    echo "Please provide a directory."
    exit 1
fi

WORDS=("BAND" "OATH" "EXISTENCE" "BRIDE" "EQUALS" "IGNORANT" "TRANSIT" "IMPRESSION" "PURPOSE" "NOTICE" "POSSIBILITIES" "CHESS" "STOLEN" "TOGETHER" "WEALTHIER" "HUMILIATED" "HANDLED" "CLIFF" "SPENT" "COMPARED")

PDF_LIST=()
PDF_WORD_COUNT=()
FOUND_WORDS=()

while IFS= read -r -d '' file; do
    word_count=0
    for word in "${WORDS[@]}"; do
        MATCH=$(pdfgrep -iP "\b$word\b[.,;:]?" "$file" | wc -l | tr -d ' ')
        if [ "$MATCH" -gt 0 ]; then
            word_count=$((word_count+1))
            FOUND_WORDS+=("$word")
        fi

    done
    if [ "$word_count" -gt 0 ]; then
        PDF_LIST+=("$file")
        PDF_WORD_COUNT+=("$word_count")
    fi
done < <(find "$DIRECTORY" -type f -iname "*.pdf" -print0)


# Sort and display results
echo "Report:"
for i in "${!PDF_LIST[@]}"; do
    for j in "${!PDF_LIST[@]}"; do
        if [ "${PDF_WORD_COUNT[$i]}" -gt "${PDF_WORD_COUNT[$j]}" ]; then
            # Swap PDFs
            tmp="${PDF_LIST[$i]}"
            PDF_LIST[$i]="${PDF_LIST[$j]}"
            PDF_LIST[$j]="$tmp"

            # Swap counts
            tmp="${PDF_WORD_COUNT[$i]}"
            PDF_WORD_COUNT[$i]="${PDF_WORD_COUNT[$j]}"
            PDF_WORD_COUNT[$j]="$tmp"
        fi
    done
done

for i in "${!PDF_LIST[@]}"; do
    echo "${PDF_LIST[$i]} has matches for ${PDF_WORD_COUNT[$i]} words."
done


# Print out the found words and the words not in WORDS=() array
if [ "$DEBUG" = "debug" ]; then
    echo "Found words:"
    for word in "${FOUND_WORDS[@]}"; do
        echo -e "\t$word"
    done

    echo "Not found words:"
    for word in "${WORDS[@]}"; do
        if [[ ! " ${FOUND_WORDS[@]} " =~ " ${word} " ]]; then
            echo -e "\t$word"
        fi
    done
fi