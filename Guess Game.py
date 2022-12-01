print(" WELCOME TO GUESS THE NUMBER!\n")
print(" I'm thinking of a number between 1 and 100\n")
print(" If your guess is more than 10 away from my number, I'll tell you you're COLD\n")
print(" If your guess is within 10 of my number, I'll tell you you're WARM\n")
print(" If your guess is farther than your most recent guess, I'll say you're getting COLDER\n")
print(" If your guess is closer than your most recent guess, I'll say you're getting WARMER\n")
print(" LET'S PLAY!\n")
 


from random import randint #IMPORTING BUILT-IN FUNCTION THAT RETURNS A RANDOM NUMBER
num = randint(1,100) #GENERATE THE RANDOM NUMBER
guesses = [0] #INITIALIZE LIST IN WHICH THE GUESSES ARE STORED 

while True: #LOOP THAT NEEDS A BREAK TO CLOSE IT
    
    guess = int(input(" I'm thinking of a number between 1 and 100.\n What is your guess? ")) #INSERT FIRST GUESS

    if guess < 1 or guess > 100: #CHECK IF THE USER INPUT IS IN RANGE
        print('OUT OF BOUNDS! Please try again: ')
        continue


    if guess == num: #COMPARE THE GUESS WITH THE RANDOMLY GENERATED NUMBER 

        print(f'CONGRATULATIONS, YOU GUESSED IT IN ONLY {len(guesses)} GUESSES!!') # NUMBER OF GUESSES = NO. OF ELEMENTS IN THE GUESSES LIST
        choice = input(' Do you want to play again? Y/N: ') 
        if choice =='y'or choice == 'Y': #COMPARE THE DESIRED ANSWER WITH THE ACTUAL ANSWER OF THE PLAYER
            num = randint(1,100) #GENERATE A NEW NUMBER
            guesses = [0] #RE-INITIALIZE THE GUESSES LIST
            continue
        else:
            print(' Thanks for playing, hope you had fun!')
            break #EXIT WHILE TRUE LOOP --> EXIT GAME


    guesses.append(guess) #adds the guess to the guesses list

    # when the player makes his first guess guesses[-2]==0 (which returns False) so the first if will not execute


    if guesses[-2]:  
        if abs(num-guess) < abs(num-guesses[-2]): # ABS returns the Absolute value of a number (positive number)
            #COMPARES THE LAST AND PENULTIMATE GUESS (WHICH ONE IS CLOSER TO THE GENERATED NUMBER)
            print('WARMER!')
        else:
            print('COLDER!')

    else:
        if abs(num-guess) <= 10: #THIS IS RUNNING ONLY WHEN PLAYER MAKES HIS FIRST GUESS
            print('WARM!')
        else:
            print('COLD!')
