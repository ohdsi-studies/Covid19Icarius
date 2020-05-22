fin = open("C:\\Users\\mconove1\\Documents\\Projects_Requests\\Phenotype-a-thon for covid-19\\PythonTest\\Revised JSON Files\\Covid19ComplicationsRasInhibitors\\COVID_ACE_ID64.json", "rt")
#read file contents to string
data = fin.read()
#replace all occurrences of the required string
# [LEGEND] dCCBs and thiazides/thiazide-like diuretics
data = data.replace('''        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1332418,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "17767",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Amlodipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1395058,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "2409",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Chlorthalidone",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1353776,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "4316",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Felodipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 974166,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "5487",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Hydrochlorothiazide",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 978555,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "5764",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Indapamide",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1326012,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "33910",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Isradipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 907013,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "6916",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Metolazone",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1318137,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "7396",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Nicardipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1318853,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "7417",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Nifedipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1319880,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "7435",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Nisoldipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        }
      ]},
      "name": "[LEGEND] dCCBs and thiazides/thiazide-like diuretics",''', 
'''        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1332418,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "17767",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Amlodipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1395058,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "2409",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Chlorthalidone",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1353776,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "4316",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Felodipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 974166,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "5487",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Hydrochlorothiazide",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 978555,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "5764",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Indapamide",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1326012,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "33910",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Isradipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 907013,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "6916",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Metolazone",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1318137,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "7396",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Nicardipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1318853,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "7417",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Nifedipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1319880,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "7435",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Nisoldipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1316354,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "1369",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Bendroflumethiazide",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 19010493,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "11371",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Xipamide",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 19004539,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "28382",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "lacidipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 19015802,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "135056",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "lercanidipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        }
      ]},
      "name": "[LEGEND] dCCBs and thiazides/thiazide-like diuretics",''').replace(
# [LEGEND] Thiazide or thiazide-like diuretics
'''        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1395058,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "2409",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Chlorthalidone",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 974166,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "5487",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Hydrochlorothiazide",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 978555,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "5764",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Indapamide",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 907013,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "6916",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Metolazone",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        }
      ]},
      "name": "[LEGEND] Thiazide or thiazide-like diuretics",''', 
'''        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1395058,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "2409",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Chlorthalidone",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 974166,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "5487",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Hydrochlorothiazide",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 978555,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "5764",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Indapamide",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 907013,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "6916",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Metolazone",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1316354,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "1369",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Bendroflumethiazide",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 19010493,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "11371",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Xipamide",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        }
      ]},
      "name": "[LEGEND] Thiazide or thiazide-like diuretics",''').replace(
# [LEGEND] Dihydropyridine calcium channel blockers (dCCB)
'''        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1332418,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "17767",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Amlodipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1353776,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "4316",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Felodipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1326012,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "33910",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Isradipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1318137,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "7396",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Nicardipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1318853,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "7417",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Nifedipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1319880,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "7435",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Nisoldipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        }
      ]},
      "name": "[LEGEND] Dihydropyridine calcium channel blockers (dCCB)",''', 
'''        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1332418,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "17767",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Amlodipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1353776,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "4316",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Felodipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1326012,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "33910",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Isradipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1318137,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "7396",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Nicardipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1318853,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "7417",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Nifedipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 1319880,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "7435",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "Nisoldipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 19004539,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "28382",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "lacidipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        },
        {
          "isExcluded": false,
          "concept": {
            "INVALID_REASON_CAPTION": "Valid",
            "CONCEPT_ID": 19015802,
            "STANDARD_CONCEPT": "S",
            "CONCEPT_CODE": "135056",
            "VOCABULARY_ID": "RxNorm",
            "CONCEPT_NAME": "lercanidipine",
            "DOMAIN_ID": "Drug",
            "STANDARD_CONCEPT_CAPTION": "Standard",
            "CONCEPT_CLASS_ID": "Ingredient",
            "INVALID_REASON": "V"
          },
          "includeMapped": false,
          "includeDescendants": true
        }
      ]},
      "name": "[LEGEND] Dihydropyridine calcium channel blockers (dCCB)",''')
#close the input file
fin.close()
#open the input file in write mode
fin = open("C:\\Users\\mconove1\\Documents\\Projects_Requests\\Phenotype-a-thon for covid-19\\PythonTest\\Revised JSON Files\\Covid19ComplicationsRasInhibitors\\COVID_ACE_ID64.json", "wt")
#overrite the input file with the resulting data
fin.write(data)
#close the file
fin.close()


##input file
#fin = open("C:\\Users\\mconove1\\Documents\\Projects_Requests\\Phenotype-a-thon for covid-19\\PythonTest\\COVID_ACE_ID60.json", "rt")
##output file to write the result to
#fout = open("C:\\Users\\mconove1\\Documents\\Projects_Requests\\Phenotype-a-thon for covid-19\\PythonTest\\COVID_ACE_ID60_2.json", "wt")
##for each line in the input file
#for line in fin:
#	#read replace the string and write to output file
#	fout.write(line.replace('INVALID_REASON_CAPTION', 'hamster').replace('"ConceptSets"', 'hopethisworks!'))
##close input and output files
#fin.close()
#fout.close()
