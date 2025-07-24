# Example file showing a circle moving on screen
import pygame
import random

# pygame setup
pygame.init()

#scenes
# 0 = title, 1 = game, 2 = gameover/replay
scene = 2

#load ufo images
ufo = pygame.image.load("sprites/ufo/ufo_purple.png")
ufo2 = pygame.image.load("sprites/ufo/ufo_green.png")
ufo3 = pygame.image.load("sprites/ufo/ufo_blue.png")

ufos = [ufo, ufo2, ufo3]

bomb = pygame.image.load("sprites/items/bomb.png")

# Setup the screen
width = 1024
height = 768
screen = pygame.display.set_mode((width, height))
pygame.display.set_caption("UFO Drop")
pygame.display.set_icon(ufo)

#define colors
title_color = (200, 120, 220)
quit_fg = (150, 80, 60)
quit_bg = (243, 121, 78)
btn_bg = (64, 64, 64)
background = (0, 0, 0)


#------------------------------
#Title and Gameover Page Stuff
titleY = 100
titleFont = pygame.font.SysFont("Arial", 65)
ufoTitle = titleFont.render("UFOs are attacking", False, title_color)
gameOverTitle = titleFont.render("UFOs broke through", False, title_color)

playY = 300
btnMargin = 10
btnFont = pygame.font.SysFont("Arial", 30)
playWord = btnFont.render("PLAY", False, title_color)
quitWord = btnFont.render("QUIT", False, quit_fg)
restartWord = btnFont.render("RESTART", False, quit_bg)

#rect = screen, color, (x, y, width, height, curve)
playBtn = pygame.draw.rect(screen, btn_bg,((width/2)-(playWord.get_width()/2)- btnMargin, playY-btnMargin, playWord.get_width() + (btnMargin*2), playWord.get_height() + (btnMargin *2)), 0)
quitBtn = pygame.draw.rect(screen, btn_bg,((width/4)-(quitWord.get_width()/2)- btnMargin, playY-btnMargin, quitWord.get_width() + (btnMargin*2), quitWord.get_height() + (btnMargin *2)), 0)
restartBtn = pygame.draw.rect(screen, quit_fg,((width * .75)-(restartWord.get_width()/2)- btnMargin, playY-btnMargin, restartWord.get_width() + (btnMargin*2), restartWord.get_height() + (btnMargin *2)), 0)
#------------------

#------------------
#Game Play Setup
clock = pygame.time.Clock()
running = True
dt = 0

numOfThings = 7 #controls number of ufos that exist
ufoImage = []
ufoX = []
ufoY = []
ufoSpeed = []
baseSpeed = 20
speedMulti = 1.2

# Powerup
powerupVisible = False
powerupX = 0 # Where at (x)
powerupY = 0 # Where at (y)

powerupCooldown = 3               # The cool down before the powerup can spawn again
powerupSpawnOffsetMax = 4         # The max offset for the cooldown
powerupSpawnOffset = 0            # The randomized offset for the powerup spawn cooldown
powerupLastActivatedTime = 0 # The time the powerup was last activated


for i in range(numOfThings):
    #add a random ufo to the ufo pool
    ufoImage.append(random.choice(ufos))
    #randomized x value between screen size
    ufoX.append(random.randint(0, width - ufo.get_width()))
    #randomized y value between screen size
    ufoY.append(random.randint(ufo.get_height(), ufo.get_height() * 2 ))
    #randomized speed
    ufoSpeed.append((baseSpeed + random.random())/100)


while running:
    # poll for events
    # pygame.QUIT event means the user clicked X to close your window
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
    
    curr_time_s = pygame.time.get_ticks() / 1000

    ###
    ### On mouse clicked
    ###
    if pygame.mouse.get_pressed()[0]: # Left click
        click_pos = pygame.mouse.get_pos()
        if scene == 0: # Title screen
            if pygame.Rect.collidepoint(playBtn, click_pos):
                powerupLastActivatedTime = curr_time_s
                scene = 1 # Goto gameplay
        
        elif scene == 1: # Gameplay
            # Powerup
            if powerupVisible:
                if click_pos[0] >= powerupX and click_pos[0] <= powerupX + ufo.get_width() and click_pos[1] >= powerupY and click_pos[1] <= powerupY + ufo.get_height():
                    powerupVisible = False
                    powerupLastActivatedTime = curr_time_s
                    powerupSpawnOffset = random.randint(0, powerupSpawnOffsetMax)

                    # Randomize ufos
                    for i in range(numOfThings):
                        #Send it back to top with new identity
                        ufoImage[i] = random.choice(ufos)
                        ufoX[i] = random.randint(0, width - ufo.get_width())
                        ufoY[i] = 0 - random.randint(ufo.get_height(), ufo.get_height() * 2)
                        #increase the speed
                        ufoSpeed[i] *= speedMulti
                    
            # UFOs
            for i in range(numOfThings):
                #box collision check
                if click_pos[0] >= ufoX[i] and click_pos[0] <= ufoX[i] + ufo.get_width() and click_pos[1] >= ufoY[i] and click_pos[1] <= ufoY[i] + ufo.get_height():
                    #Send it back to top with new identity
                    ufoImage[i] = random.choice(ufos)
                    ufoX[i] = random.randint(0, width - ufo.get_width())
                    ufoY[i] = 0 - random.randint(ufo.get_height(), ufo.get_height() * 2 )
                    #increase the speed
                    ufoSpeed[i] *= speedMulti

        else: # Game over screen
            # Quit button
            if pygame.Rect.collidepoint(quitBtn, click_pos):
                running = False
            # Restart Button
            if pygame.Rect.collidepoint(restartBtn, click_pos):
                for i in range(numOfThings):
                    #add a random ufo to the ufo pool
                    ufoImage[i] = random.choice(ufos)
                    #randomized x value between screen size
                    ufoX[i] = random.randint(0, width - ufo.get_width())
                    #randomized y value between screen size
                    ufoY[i] = 0 - random.randint(ufo.get_height(), ufo.get_height() * 2)
                    #randomized speed
                    ufoSpeed[i] = (baseSpeed + random.random())/100
                scene = 0

    ###
    ### On Update
    ###
    
    if scene == 1: # Gameplay
        for i in range(numOfThings):
            # Reached bottom of screen
            if ufoY[i] + ufo.get_height() > height:
                scene = 2 # Game over
            # Move
            ufoY[i] += ufoSpeed[i]# * dt

        timeSinceActivated = curr_time_s - powerupLastActivatedTime
        
        if timeSinceActivated > powerupCooldown:
            # Hide the powerup after having been visible for (cooldown) seconds
            if powerupVisible:
                powerupVisible = False # Hide the powerup
                powerupLastActivatedTime = curr_time_s                   # The time the powerup was last activated
                powerupSpawnOffset = random.randint(0, powerupSpawnOffsetMax) # Set the timer offset for next spawn

            elif timeSinceActivated > (powerupCooldown + powerupSpawnOffset):
                powerupX = random.randint(0, width - bomb.get_width())
                powerupY = random.randint(0, height - bomb.get_height())

                powerupVisible = True # Show the powerup
                powerupLastActivatedTime = curr_time_s # The time the powerup was last activated

    ###
    ### Draw
    ###

    screen.fill(background)

    if scene == 0: # Title
        # Centered Title
        screen.blit(ufoTitle, ((width/2)-(ufoTitle.get_width()/2), titleY))
        # UFO left
        screen.blit(ufo, ((width/2)-(ufoTitle.get_width()/2)-ufo.get_width(), titleY+ (ufoTitle.get_height()-ufo.get_height())))       
        screen.blit(ufo2, ((width/2) + (ufoTitle.get_width()/2), titleY+ (ufoTitle.get_height()-ufo.get_height())))

        #button changes if mouse is hovering over it
        coords = pygame.mouse.get_pos()
        if pygame.Rect.collidepoint(playBtn, coords): #green button
            playBtn = pygame.draw.rect(screen, title_color,((width/2)-(playWord.get_width()/2)- btnMargin, playY-btnMargin, playWord.get_width() + (btnMargin*2), playWord.get_height() + (btnMargin *2)), 0)
        else: #normal button
            playBtn = pygame.draw.rect(screen, btn_bg,((width/2)-(playWord.get_width()/2)- btnMargin, playY-btnMargin, playWord.get_width() + (btnMargin*2), playWord.get_height() + (btnMargin *2)), 0)
            screen.blit(playWord, ((width/2)-(playWord.get_width()/2), playY))

    elif scene == 1: # Gameplay
        # Draw UFOS
        for i in range(numOfThings):
            screen.blit(ufoImage[i], (ufoX[i], ufoY[i]))
        
        if powerupVisible:
            screen.blit(bomb, (powerupX, powerupY))

    else: # Game Over
        screen.blit(gameOverTitle, (width/2 - gameOverTitle.get_width()/2, titleY))
        screen.blit(ufo, ((width/2)-(gameOverTitle.get_width()/2)-ufo.get_width(), titleY+ (gameOverTitle.get_height()-ufo.get_height())))       
        screen.blit(ufo2, ((width/2) + (gameOverTitle.get_width()/2), titleY+ (gameOverTitle.get_height()-ufo.get_height())))

        #buttons
        #Quit
        coords = pygame.mouse.get_pos()
        if pygame.Rect.collidepoint(quitBtn, coords):
            #if mouse hovers over quit button it'll be green
            quitBtn = pygame.draw.rect(screen, quit_fg,((width/4)-(quitWord.get_width()/2)- btnMargin, playY-btnMargin, quitWord.get_width() + (btnMargin*2), quitWord.get_height() + (btnMargin *2)), 0)
        else:
            quitBtn = pygame.draw.rect(screen, quit_bg,((width/4)-(quitWord.get_width()/2)- btnMargin, playY-btnMargin, quitWord.get_width() + (btnMargin*2), quitWord.get_height() + (btnMargin *2)), 0)
            screen.blit(quitWord, ((width/4) - (quitWord.get_width()/2), playY))
        
        #Restart
        if pygame.Rect.collidepoint(restartBtn, coords):
            #if mouse hovers over restart, turn button orange
            restartBtn = pygame.draw.rect(screen, quit_bg,((width * .75)-(restartWord.get_width()/2)- btnMargin, playY-btnMargin, restartWord.get_width() + (btnMargin*2), restartWord.get_height() + (btnMargin *2)), 0)
        else:
            restartBtn = pygame.draw.rect(screen, quit_fg,((width * .75)-(restartWord.get_width()/2)- btnMargin, playY-btnMargin, restartWord.get_width() + (btnMargin*2), restartWord.get_height() + (btnMargin *2)), 0)
            screen.blit(restartWord,((width *.75) - (restartWord.get_width()/2), playY))


    # flip() the display to put your work on screen
    pygame.display.flip()

    # limits FPS to 60
    # dt is delta time in seconds since last frame, used for framerate-
    # independent physics.
    dt = clock.tick(60) / 1000

pygame.quit()