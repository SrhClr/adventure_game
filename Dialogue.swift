import Foundation

class Dialogue {
    //REGLE DU JEU 
    static func afficherReglesEtObjectif(){
        print("""
        ╔══════════════════════════════════════════════════════════╗
                 🎮 BIENVENUE DANS L'AVENTURE DE PETER PAN         
        ╚══════════════════════════════════════════════════════════╝

        🧭 Objectif :
        Depuis l’ombre d’un tiroir oublié jusqu’aux confins du Pays Imaginaire,
        tu incarneras Peter Pan dans sa quête la plus périlleuse.

        Les Enfants Perdus ont disparu.
        Wendy doute.
        Le capitaine Crochet complote dans les ténèbres.

        Ton but ? Rassembler les morceaux d’une vérité oubliée, percer les énigmes du Pays Imaginaire,
        et sauver ceux que tu aimes avant que le temps ne s’arrête… à jamais.

        Chaque indice compte.
        Chaque erreur se paie.
        Et seule une âme courageuse pourra regagner la voie du retour.

        ════════════════════════════════════════════════════════════

        ❤️ Vies :
        Tu commences avec 3 vies. Si tu les perds toutes, tu recommences depuis le début,
        et il sera impossible de sauvegarder ta partie.

        💯 Score :
        Tu gagnes ou perds des points selon tes choix. Ton score détermine si tu perds ou gagnes des vies.

        📊 Grille de points :

        | Action                         | Points |
        |-------------------------------|--------|
        | Bonne réponse simple          | +2     |
        | Bonne réponse difficile       | +4     |
        | Mauvaise réponse simple       | -2     |
        | Mauvaise réponse difficile    | -1     |
        | 8 points gagnés               | +1 vie |
        | 8 points perdus               | -1 vie |

        🕰️ Chronomètre :
        Certaines épreuves sont limitées dans le temps. Si tu réussis à temps, tu gagnes plus de points.
        Sinon, tu perds du temps… ou pire, tu recommences.

        📌 Sauvegarde :
        Tu peux quitter et sauvegarder ta partie à tout moment… sauf si tu n’as plus de vies.

        ════════════════════════════════════════════════════════════

        ✨ Es-tu prêt à devenir une légende ?

        """)
    }

    // PARTIE VIE
    static func scenePerteTotale(){
        print("""
        ☠️ Vous avez perdu toutes vos vies…
        Une brume épaisse vous enveloppe…

        🏠 Vous vous réveillez dans la chambre des Darling. Tout est à recommencer…
        🔒 Sauvegarde désactivée.
        """)

    }

    //PARTIE SAUVEGARDE
    static func sauvegardeImpossible(){
        print("❌ Vous ne pouvez pas sauvegarder : toutes vos vies ont été perdues.")

    }

    static func finAvecSauvegarde(){
        print("✅ Sauvegarde effectuée. Merci d’avoir joué ! À bientôt !")

    }

    static func finSansSauvegarde(){
        print("👋 Merci d’avoir joué ! À bientôt !")

    }

    static func retourJeu(){
        print("🔁 Retour au jeu.")
    }

    static func choixInvalideRetourJeu(){
        print("❌ Choix invalide. Retour au jeu.")

    }

    // PARTIE JEU
    static func sceneIntro() {
        print("""
        🌌 Une nuit calme flotte sur Londres.
        🏡 Dans la maison des Darling, les enfants dorment paisiblement...

        Quand soudain...CLAC ! La fenêtre se referme brutalement.

        Peter Pan vient d’atterrir maladroitement dans la chambre. Wendy se redresse brusquement, les yeux écarquillés.

        Wendy : Qui êtes-vous ?! Un voleur ? Je vais crier !
        Peter (chuchotant, paniqué) : Non ! S’il te plaît... ne crie pas.
        (Peter met doucement sa main sur la bouche de Wendy)
        Peter : Si tu m’ouvres ce tiroir... je te prouverai que j’ai raison. Mon ombre s’y cache peut-être.

        Wendy (soupçonneuse) : Ton ombre ? Quelle histoire ridicule...
        Bon, très bien. Je te donne la clé... mais seulement si tu réponds à mon énigme.
        """)
    }

    static func sceneEnigmeWendy() {
        print("""
        Wendy : Il ne peut être arrêté, ni vu, ni touché, mais il change tout. Qui suis-je ?
        a) Le vent
        b) Le temps
        c) Le destin
        """)
    }

    static func sceneTiroir() {
        print("""
        🔓 Vous ouvrez le tiroir... L’ombre saute et se débat !
        Peter essaie de la tenir... Elle se débat !
        Wendy : Attends... Je vais chercher un dé à coudre.

        Wendy attrape le dé à coudre et s’approche doucement.
        Wendy : Ne bouge pas, Peter... Voilà...
        (Après quelques points discrets, l’ombre est recousue.)

        De l’extérieur, une lueur observe la scène... C’est Clochette. Elle fronce les sourcils.
        CLAC ! La fenêtre du salon s’ouvre et une lumière vive entre à toute vitesse.
        Peter : Clochette ! Attends !
        (La fée s’arrête juste avant de toucher Wendy.)
        Peter : Elle m’a aidé. C’est une amie.
        (Clochette regarde Wendy, boudeuse... puis hoche la tête.)

        Peter (s’adressant à Wendy) : Nous devons retourner au Pays Imaginaire.

        (À ces mots, les deux frères de Wendy se réveillent.)

        Jean : Le Pays Imaginaire ? Avec le capitaine Crochet ?!
        Michel : Emmène-nous avec toi !
        Wendy : Non ! Papa et maman vont être furieux...
        Jean : Allez Wendy, s’il te plaît...
        Wendy (soupirant) : Bon... D’accord.

        Peter : Clochette, un peu de poussière de fée !
        (La magie opère... Ils sont prêts à s’envoler.)
        """)
    }

    static func sceneForet() {
        print("""
        Clochette saupoudre tout le monde... Vous vous envolez vers le ciel étoilé !
        Mais soudain... Vous tombez dans une forêt dense et mystérieuse.

        🪶 Des Amérindiens surgissent et vous capturent, vous prenant pour des pirates !
        Peter : Attendez ! Je ne suis pas un pirate. Je les combats ! Je suis Peter Pan !
        Chef : De belles paroles... Si tu es vraiment Peter Pan, réponds à ceci :
        """)
    }

    static func sceneEnigmeForet() {
        print("""
        Chef : Quelle arme utilise Peter Pan pour combattre le capitaine Crochet ?
        a) Une arbalète
        b) Une épée courte
        c) Une fronde
        """)
    }
    
    static func sceneCombat() {
        print("""
        (Peter saisit l’épée courte tendue par le chef. Les Amérindiens se rassemblent en cercle autour de lui.)

        Chef : Prouve-nous que tu es Peter Pan…
        (Peter effectue une roulade rapide, bondit sur un tronc renversé, puis exécute un enchaînement d’attaques.)
        Un jeune guerrier : Il vole comme le vent…
        Chef : …et frappe comme l’éclair. C’est lui.

        (Le chef s’incline respectueusement.)
        Chef : Peter Pan, nous te reconnaissons. Tu es l’ennemi du capitaine Crochet, pas un des siens.
        Chef : Tu es libre. Que la forêt s’écarte, et que la nuit reste calme.

        (Vous êtes escortés jusqu'à la sortie de la forêt, et bientôt vous apercevez le grand arbre creux…)
        """)
    }

    static func sceneRepaire() {
        print("""
        🌳 Vous êtes maintenant dans : Le Repaire des Enfants Perdus

        (Le repaire semble étrangement vide. Une atmosphère lourde pèse sur les lieux. Le vent fait craquer les branches. Peter avance prudemment.)

        (Nibs surgit soudainement d’un buisson, le visage pâle.)

        Nibs : Peter ! Tu es revenu… C’est affreux...

        Peter : Qu’est-ce qui s’est passé ici ?

        Nibs : Ce matin, avec Curly, Toby, Finn et les jumeaux, on est partis dans la forêt. C’était notre tour d’aller chercher de quoi manger — des baies, de l’eau fraîche, quelques lapins si on avait de la chance.

        Peter : Et les autres ?

        Nibs : Quand on est revenus, le repaire était dans un chaos total. Des affaires renversées, les couvertures arrachées... Et surtout… plus personne. Les plus jeunes... envolés. Pas une trace.

        (Peter regarde autour de lui, inquiet.)

        Nibs : On a fouillé partout. On a rien vu, rien entendu. Juste ce jouet… par terre. Cassé...

        (Nibs tend à Peter un jouet brisé, sa surface griffée, couverte de poussière.)

        (Peter serre les poings.)

        Peter : On va les retrouver.

        (Nibs hoche la tête, les yeux remplis d'espoir.)

        (Peter reste silencieux. Il observe la pièce.)

        Ses yeux balaient lentement le repaire. Quelque chose ne tourne pas rond.

        Il voit :
        - une table renversée
        - un rideau déchiré
        - une couverture froissée
        - un coffre entrouvert
        - une plume abandonnée
        - un cigare écrasé
        - des hamacs encore suspendus

        Tout semble figé… mais chaque détail peut compter.

        """)
    }

    static func sceneCouverture(){
        print("Peter soulève doucement la couverture... Une bouteille en verre brisée, couverte d'une substance rouge sombre, se dévoile.")

    }

    static func sceneBouteille(){
        print("Peter observe la bouteille en verre... Elle est couverte de sang. À côté, une traînée rougeâtre attire son attention.")

    }

    static func sceneTraceDeSang(){
        print("Peter observe la trace de sang... Elle semble s’éloigner, vers l'exterieur du repaire. Peut-être une piste à suivre...")

    }

    static func sceneHamacs(){
        print("Peter observe les hamacs accrochés aux branches. Ils sont restés intacts. Il passe sa main dessus, pensif, mais n’y trouve rien.")

    }

    static func sceneRocher() {
        print("""
        Vous sortez du repaire en silence, guidé par la fine traînée rougeâtre.
        Les arbres se resserrent autour de vous tandis que la forêt devient plus sombre.

        Derrière le brouillard, se dessine une silhouette massive… un rocher.
        Mais pas n'importe lequel. Une tête de mort sculptée...

        ⚓ Vous êtes arrivé au Rocher du Crâne.

        Au centre, une vieille horloge est encastrée dans la pierre.
        Les aiguilles sont figées sur 6h30.

        Souhaitez-vous examiner l’horloge ?
        """)
    }

    static func enigmeHorloge() {
        print("""
        Peter s’approche de l’horloge...
        Il remarque alors une étrange gravure sur les aiguilles :

        « Quand la nuit a chanté quinze fois,
        et que la lune s’est levée deux fois…
        le temps s’est arrêté pour moi. »
        """)
    }

    static func sceneHorlogeNon() {
        print("""
        Peter détourne les yeux de l’horloge et observe les alentours…
        Mais il n’y a que les roches, le vide, et la mer déchaînée.
        Rien d’autre ne semble vouloir lui répondre.

        Peut-être devrait-il examiner cette horloge après tout…
        """)
    }

    static func sceneMemoireHorloge(){
        print("""
        🧭 Quelques souvenirs remontent à la surface…

        - Les nuits en mer sont rythmées par les chants de cloche.
        → 1 chant = 15 minutes
        → 4 chants = 1 heure

        - Les pirates parlent des lunes comme des repères du jour.
        → 1ère lune = midi
        → 2e lune = minuit

        Que signifiait cette gravure déjà ?
        « La nuit a chanté quinze fois… la lune s’est levée deux fois… »
        """)
    }

    static func trappeOuverte(){
        print("""
        🕳️ Une trappe s’ouvre lentement, dévoilant un escalier.

        Peter descend. L'air se fait plus froid. Et au loins les Enfants Perdus sont prisonniers. Peter fait face à Crochet dans la pénombre de la caverne.
        """)
    }

    static func jokerHorloge(){
        print("""
        🃏 Un opérateur mathématique est à appliquer entre les deux parties de l’énigme…

        Peut-être que la clé réside dans une addition ?
        """)
    }

    static func aideRefusee(){
        print("🔁 Très bien, continuez votre réflexion.")

    }

   // MARK: - Scène du piège de Crochet
    static func sceneCrochetPiege() {
        print("""

        Peter (s’approche lentement, les poings serrés) :
        — Tu n’en as pas assez, Crochet ? Les pièges, la haine... Tu as perdu ta main, ton honneur,
        et maintenant tu t’en prends à des enfants ?

        Capitaine Crochet (sourire en coin, voix grave) :
        — Fatigué ? Non, Peter. Je suis plus proche que jamais de ce que je cherche.
        Tu crois vraiment que tout cela n’est qu’un jeu de vengeance ?

        (Il s’approche, son visage à moitié éclairé par une lanterne vacillante.)

        — Je veux le trésor gardé par les fées. Et toi, Peter, tu as la clé : Clochette.

        Voici mon marché :
        Conduis-moi jusqu’à ce trésor, et je ne ferai de mal ni à tes amis... ni à aucune fée.

        Peter (abasourdi) :
        — JAMAIS !

        Crochet :
        — Dans ce cas... libère-les. Si tu peux.
        Mais si tu échoues... ils mourront tous. Et toi avec.

        (Il recule d’un pas, regarde ses hommes.)

        — Oh, j’ai laissé un petit cadeau. 💣 Une bombe. Attachée à l’un de tes précieux camarades.
        La grille porte un code... de 1 à 5. Chaque chiffre désigne un enfant.
        Un seul bon chiffre, et ils vivent. Tu as trois essais. Sinon ? BOOM.

        (Crochet siffle. Ses hommes le suivent vers la sortie.)

        — Je m’en vais. Je déteste les adieux.
        """)
    }

   static func observerEnfants() {
        print("""
        Peter observe les Enfants Perdus, enfermés derrière la grille.

        1 - Will serre les dents. Il tremble, mais soutient le regard de Peter avec courage.
        2 - Clotere regarde fixement le sol, les larmes aux yeux. Il semble murmurer une prière.
        3 - Nino tente de sourire, mais ses mains crispées trahissent sa panique.
        4 - Snow regarde Peter sans ciller. Il paraît étrangement calme.
        5 - Kenny semble figé de peur.

        Chaque expression, chaque geste pourrait être un indice…
        """)
    }

   // MARK: - Réussite du défi de la bombe
    static func reussiteDefiBombe() {
        print("""
        🔓 *CLIC !* La grille se déverrouille…

        Les enfants se jettent dans les bras de Peter, en larmes. Il les serre contre lui, soulagé.

        💣 La bombe est désamorcée juste à temps par Peter.

        👏 Félicitation tu les as sauvés. Cette victoire te vaudra des points… et peut-être davantage.
        """)
    }

    // MARK: - Échec du défi de la bombe
    static func echecDefiBombe() {
        print("""
        ⏳ *BIP... BIP... BIP...* 💣

        Peter tente une dernière combinaison… Trop tard.

        💥 Une explosion secoue la caverne.

        🩸 Trop tard…
        """)
    }
    // RETOUR AU REPAIRE 
    static func sceneRetourAuRepaire() {
    print("""
    🌌 La nuit tombe doucement sur le Pays Imaginaire. Peter conduit les Enfants Perdus hors du Rocher du Crâne.

    👣  Ils traversent la forêt, rieurs, portés par l’excitation du retour.

    🌿 Les branches familières s’écartent, révélant le Repaire des Enfants Perdus. Une délicieuse odeur flotte dans l’air.

    🔥 Près du feu de bois, une silhouette s’active, une louche à la main. C’est Wendy.

    👧 Wendy : "Peter ! Vous voilà enfin… Ils avaient si faim. Je vous ai préparé un ragoût."

    🍲 Les enfants s’installent en cercle, rient, se chamaillent gentiment, et dévorent chaque bouchée avec appétit.

    📖 Une fois les assiettes vides, Peter et Wendy les guident en bas, dans la grande chambre. Tout le monde s’installe dans les lits, blottis sous les couvertures.

    ✨ Wendy s’assied, un livre usé entre les mains. Les enfants se taisent aussitôt, les yeux brillants d’attente.

    "Au sommet d’un nuage qu’aucun adulte ne peut voir, il existe une île qui ne figure sur aucune carte… Là-bas, les rêves ne se perdent jamais, et le temps oublie de passer."

    😴 À mesure que Wendy lit, les paupières se ferment. Un à un, les Enfants Perdus s’endorment.

    🌠 Peter, assis non loin, regarde Wendy.

    🧚‍♂️ Peter (à voix basse) : "Viens. J’ai quelque chose à te montrer."

    👣 Tous deux se lèvent discrètement et s’éclipsent sans bruit, vers un lieu secret…

    """)
    }


     //LAGUNE DES SIRENES
    static func sceneForetVersLagune() {
        print("""
        🌲 Peter et Wendy marchent dans la Forêt Enchantée.

        La végétation s’éclaircit peu à peu. Une lumière aquatique se reflète sur leurs visages.

        🧜‍♀️ Peter : "Nous y sommes..."

        🎶 Une douce mélodie flotte dans l'air...

        📍 Vous êtes arrivé au **Lagune des Sirènes**.
        """)
      
    }

    static func sceneJeuDesPerles() {
        print("""
        🧜‍♀️ Les sirènes surgissent des eaux, leurs cheveux ruisselants.

        Sirène : "Oh, quel joli minois... Viens jouer avec nous."

        ✨ Peter s’interpose : "Ne l’approchez pas. Wendy fait attention ce sont des menteuses."

        😈 En colère, les sirènes ricanent et proposent un défi :
        "Nous allons te montrer 8 perles de couleurs différentes 🔴 🔵 🟢 🟡 🟣 🟠 ⚪ ⚫
         que nous irons chercher dans l'eau . Tu auras 3 secondes pour les voir."

        🎯 "Si tu retrouves l’ordre exact... tu repars. Sinon, tu restes pour le dîner..."
        """)
    }
      static func reussiteJeuDesPerles() {
        print("""
        🌟 Wendy a réussi !

        Les sirènes, frustrées, s’enfoncent dans le lagune .

        Peter : "Je savais que tu étais exceptionnelle."

        Vous pouvez maintenant continuer vers l’Île aux Fées.
        """)
    }

    static func echecJeuDesPerles() {
        print("""
        💀 Wendy s’est trompée...

        Les sirènes s’approchent, prêtes à la dévorer.

        Peter crie : "NON !"

        🔁 Vous êtes renvoyé au Repaire des Enfants Perdus. Essayez encore...
        """)
    }
    // TRANSITIION  AVANT ILE AU FEE
    static func sceneIleAuxFees() {
        print("""
        🧚‍♀️ Un long passage de lumière s’ouvre... Il mène tout droit vers la Grande Île aux Fées.

        ✨ Des petites fées accueillent Peter et Wendy en voltigeant autour d’eux.

        Fées : "Peter ! Tu es revenu !"

        Elles les saupoudrent de poussière féérique.

        Un bouclier magique se lève, s’ouvre… et les laisse passer.

        🌳 Au cœur de l’île, une immense fête bat son plein.

        Les fées dansent autour du Grand Arbre pour fêter 🎉 le 500 000e anniversaire du Grand Arbre de Vie du Pays Imaginaire

        Wendy (curieuse) : "Pourquoi les fées dansent-elles autour de cet arbre ?"

        Peter : "Cet arbre contient la magie originelle. Les fées veillent sur lui depuis la nuit des temps."

        Wendy : "...Pour le protéger de qui ?"

        Peter : "De ceux qui ne croient plus. Si quelqu’un disait un jour que les fées n’existent pas... et le pensait vraiment..."

        "... Elles mourraient. Le bouclier tomberait. Et tout le Pays Imaginaire changerait à jamais."

        Wendy reste silencieuse.

        🎶 Peter lui tend la main : "Danse avec moi."

        Ils tournent ensemble au rythme des fées. Puis, dans un souffle :

        Wendy : "Peter... Je t’aime."

        😧 Peter s’arrête net, recule.

        Peter : "Non. Je ne veux pas grandir. Je ne veux pas aimer. Je veux juste rester un enfant."

        Il s’envole à toute vitesse, hors de l’île.

        💔 Wendy, le cœur brisé, quitte à son tour l’île, erre dans la forêt... et se perd.

        🏴‍☠️ Dans la lumière de la lune... une silhouette se dessine. 
        
        Crochet.

        Crochet (d’une voix douce) : "Pourquoi pleures-tu, ma douce ? C’est Peter, n’est-ce pas ? Il t’a fait du mal ?"

        "Moi aussi, je l’ai aimé, autrefois. Et lui aussi, m’a trahi."

        "Ce garçon... ne sait pas aimer. Il ne rêve que d’une chose : rester un enfant."

        Wendy reste figée, silencieuse, le regard perdu.
        """)
    }
    
    static func sceneArriveeJollyRoger() {
        print("""
        🏴‍☠️ Crochet : "Tu devrais rentrer chez toi, Wendy. Tu n’as pas ta place dans le cœur de Peter."

        "Mais avant cela… j’aimerais te montrer quelque chose."

        Il lui tend la main.

        "Un vrai bateau de pirate. Un navire comme on n’en voit qu’une fois dans une vie."

        Wendy, bouleversée, accepte en silence.

        🌫️ Ils traversent la forêt. Le Jolly Roger appairait, il les attend.

        Crochet : "Monte à bord. Nous avons une cabine libre, rien que pour toi."

        "Repose-toi cette nuit. Demain, je te reconduirai à la maison."

        🛳️ Wendy monte sur le pont. Un pirate s’approche.

        Crochet : "Oh qui vois-je. Je vous laisse donc faire plus ample connaissance.

        🧔‍♂️ "Bonjour jeune fille. Je m'appelle Mousse, et toi ?"
        """)
    }

    static func scenePremiereDialogueMousse(){
    print("""
        🧔‍♂️ Je ne souhaite pas vous importuner, mais vous m'avez l'air bien chagrinée.

        Souhaitez-vous que je vous fasse une visite du bateau pour vous changer les idées,
        ou préférez-vous monter dans votre chambre et vous coucher ?
        """)
    }

    static func sceneVisiteMousse() {
        print("""
        ⚓ Mousse vous fait découvrir le Jolly Roger : la vigie, les canons, la cabine du capitaine...

        🧔‍♂️ Mousse : "Alors, jeune passagère... dites-moi ce qui vous tracasse. Je suis un pirate, mais j'ai bon coeur."
        """)
    }

    // DIALOGUE NAVIRE QUE MOUSSE 
    static func mousseComprendPas() {
        print("🧔‍♂️ Hmm... Je ne suis pas sûr d’avoir bien compris. Tu veux bien répéter, Wendy ? Ou préfères-tu que je te laisse tranquille ce soir et que je te montre ta chambre ?")
    }

    static func moussePeterAime() {
        print("🧔‍♂️ Ah... le capitaine m’a souvent dit que Peter ne voulait pas grandir. Peut-être qu’il a peur de l’amour.")
    }

    static func moussePeterSimple() {
        print("🧔‍♂️ Ah... Peter Pan... Il laisse parfois des cœurs derrière lui, sans s’en rendre compte.")
    }

    static func mousseTriste() {
        print("🧔‍♂️ La mer aussi a ses chagrins. Mais elle finit toujours par se calmer, Wendy.")
    }

    static func mousseRien() {
        print("🧔‍♂️ Parfois, on dit que ce n’est rien, mais les yeux en disent plus long que les mots.")
    }

    static func mousseRentrer() {
        print("🧔‍♂️ Le capitaine t’y reconduira. Mais sache que tous les ports ne valent pas le Jolly Roger.")
    }

    static func moussePerdue() {
        print("🧔‍♂️ Même en pleine mer, on finit toujours par trouver une étoile qui nous guide.")
    }

    static func mousseMal() {
        print("🧔‍♂️ Les blessures du cœur ne saignent pas, mais elles laissent des cicatrices profondes.")
    }

    static func mousseVieDure() {
        print("🧔‍♂️ Peut-être... mais parfois, un seul moment suffit à la rendre douce.")
    }

    static func moussePasDeCoeur() {
        print("🧔‍♂️ Tous les cœurs ne battent pas bruyamment. Certains sont silencieux, mais ils existent.")
    }

    static func mousseAimeEncore() {
        print("🧔‍♂️ L’amour est une voile fragile. Quand le vent tourne, il faut savoir l’orienter ou la replier.")
    }

    static func mousseAimait() {
        print("🧔‍♂️ L’amour passé est un trésor... qu’on garde même dans les tempêtes.")
    }

    static func mousseJaiCru() {
        print("🧔‍♂️ Croire en quelqu’un, c’est le plus grand des cadeaux. Même si cette personne l’oublie.")
    }
    static func mousseTour2Merci() {
        print("🧔‍♂️ Pas de quoi. Même les pirates savent écouter.")
    }

    static func mousseTour2Fatigue() {
        print("🧔‍♂️ Alors tu as bien mérité un peu de repos.")
    }

    static func mousseTour2Oublier() {
        print("🧔‍♂️ Le vent emporte tout, avec le temps. Même les souvenirs trop lourds.")
    }

    static func mousseTour2Silence() {
        print("🧔‍♂️ Tu n’es pas obligée de tout dire ce soir. Le silence vaut parfois plus que les mots.")
    }

    static func mousseConclusionRespectueuse() {
        print("""
        🧔‍♂️ Je ne me permettrai pas de creuser davantage...

        🧔‍♂️ Allons-y. Il se fait tard, et tu dois être épuisée.
        """)
    }

    static func sceneReveilWendySurLeBateau() {
        print("""
        🌅 Le soleil entre par le hublot.
        Wendy ouvre les yeux.
        Elle se lève, puis sort dans le couloir, jusqu’au bureau du capitaine.
        🏴‍☠️ Crochet est déjà là, assis derrière son bureau.
        Il lui sourit
        """)
    }

    static func questionDormirCrochet(nomJoueur: String) {
        print("""
        🏴‍☠️ Crochet : "Ma très chère \(nomJoueur), as-tu bien dormi ?"
        """)
    }

    static func reponseOuiDormir() {
         print("""
        🏴‍☠️ Crochet : "Très bien. Comme promis, je te raccompagnerai chez toi.
        
        Mais avant cela... prends cette plume et cette carte.
        
        Écris aux Enfants Perdus. Dis-leur que tu souhaites leur faire tes adieux, 
        et demande-leur de ramener tes frères ici, sans revoir Peter.

        N'oublie pas d'ajouter :
        'Vous trouverez le morceau manquant de cette lettre derrière le buisson, à côté du grand chêne. Il vous indiquera le lieu du rendez-vous.'"
        """)
    }

    static func reponseNonDormir() {
        print("""
        🏴‍☠️ Crochet : "Oh, je suis désolé d'entendre cela... Mais comme promis, je te raccompagnerai chez toi.

        Mais avant cela... prends cette plume et cette carte.
        
        Écris aux Enfants Perdus. Dis-leur que tu souhaites leur faire tes adieux, 
        et demande-leur de ramener tes frères ici, sans revoir Peter.

        N'oublie pas d'ajouter :
        'Vous trouverez le morceau manquant de cette lettre derrière le buisson, à côté du grand chêne. Il vous indiquera le lieu du rendez-vous.'"
        """)
    }

    static func sceneCrochetRecupereLettre() {
        print("""
        Wendy tend la lettre à Crochet qui la prend délicatement. Puis elle sort de son bureau. 

        ✂️ Il sort une petite lame de sa poche, et coupe une partie du message.

        🏴‍☠️ Crochet (souriant) : "Mieux vaut parfois simplifier les choses…"

        Il cache soigneusement le morceau découpé et appel ses hommes. 
        """)
    }

    static func sceneCaptureEnfantsEtWendy() {
        print("""
        🏴‍☠️ Sous les ordres de Crochet, les pirates se faufilent jusqu'au Repaire des Enfants Perdus.

        📜 Derrière un buisson, près du grand chêne, ils déposent le morceau de la lettre ...

        👣 Quelques temps plus tard, Nibs découvre le message.

        Nibs (s'écriant) : "Venez vite ! Une lettre de Wendy !"

        👦👧 Les Enfants Perdus et les frères de Wendy se rassemblent, fébriles.

        📍 Ils suivent les indications... jusqu'à la Clairière.

        🌳 Mais une embuscade les attend.

        🏴‍☠️ Les hommes de Crochet surgissent des hautes herbes, encerclent les enfants, et les capturent sans leur laisser la moindre chance.

        🌊 Pendant ce temps, sur la Plage...

        🧍‍♀️ Wendy, fidèle au lieu de rendez-vous, attend, le regard tourné vers l'horizon.

        🏴‍☠️ D'un coup, des pirates surgissent et l'encerclent elle aussi.

        🏴‍☠️ Wendy est capturée.

        🚢 Tous sont emmenés discrètement jusqu'au Jolly Roger...   
        """)
    }

    static func sceneRetourPeterRepaire() {
        print("""
        🌑 La nuit est tombée.

        🧚‍♂️ Peter Pan rentre au Repaire des Enfants Perdus.

        🌌 Le silence est étrange. Le feu est éteint. Le repaire est désert.

        📜 Près du grand chêne, une lettre.

        🧚‍♂️ Peter la ramasse... et lit :

        (La lettre est incomplète... des mots semblent manquer.)

        ❗ Peter ressent un frisson d'alerte.

        🧚‍♂️ Peter : "Quelque chose ne tourne pas rond... Crochet est derrière tout ça, j'en suis sûr."

        🔥 Il décide de foncer directement au Jolly Roger.
        """)
    }

    // ce code est faux a modifier plus tard 
    static func sceneCarteComplete() {
        print("""
    📝 En dépliant la carte complète, vous découvrez la vérité :
    "Je voulais revenir... mais quelque chose m'en a empêchée. Vous me trouverez là où tout a commencé."
    """)
    }
} 
