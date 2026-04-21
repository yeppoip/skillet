import time
import random
import os
import msvcrt

WIDTH = 60
GROUND = 7
PLAYER_X = 5

def clear():
    os.system('cls')

def draw(player_y, obstacles, score, speed, dead=False):
    grid = [[' '] * WIDTH for _ in range(GROUND + 1)]
    for x in range(WIDTH):
        grid[GROUND][x] = '-'
    cube = '[X]' if dead else '[>]'
    for i, ch in enumerate(cube):
        if PLAYER_X + i < WIDTH:
            grid[player_y][PLAYER_X + i] = ch
    for ox, oh in obstacles:
        for row in range(oh):
            oy = GROUND - 1 - row
            if 0 <= oy <= GROUND and 0 <= ox < WIDTH:
                grid[oy][ox] = '#'
    print('=' * WIDTH)
    for row in grid:
        print(''.join(row))
    print('=' * WIDTH)
    print(f'  Score: {score}   Speed: {speed:.1f}   SPACE to jump  Q to quit')

def run():
    clear()
    print("GD DASH - Press SPACE to start")
    while True:
        if msvcrt.kbhit():
            if msvcrt.getch() == b' ':
                break

    player_y = GROUND - 1
    vel = 0
    obstacles = []
    score = 0
    speed = 1.0
    obstacle_timer = 20
    alive = True

    while alive:
        if msvcrt.kbhit():
            key = msvcrt.getch()
            if key == b' ' and player_y >= GROUND - 1:
                vel = -3
            elif key == b'q':
                return

        vel += 1
        player_y += vel
        if player_y >= GROUND - 1:
            player_y = GROUND - 1
            vel = 0

        obstacles = [(ox - 1, oh) for ox, oh in obstacles if ox - 1 > 0]

        obstacle_timer -= 1
        if obstacle_timer <= 0:
            obstacles.append((WIDTH - 1, random.randint(1, 2)))
            obstacle_timer = random.randint(int(20 / speed), int(35 / speed))

        for ox, oh in obstacles:
            for row in range(oh):
                oy = GROUND - 1 - row
                if abs(ox - PLAYER_X) < 3 and player_y == oy:
                    alive = False

        score += 1
        speed = 1.0 + score / 200

        clear()
        draw(player_y, obstacles, score, speed)
        time.sleep(0.05 / speed)

    clear()
    draw(player_y, obstacles, score, speed, dead=True)
    print(f'\n  YOU DIED! Score: {score}')
    print('  SPACE to retry  Q to quit')

    while True:
        if msvcrt.kbhit():
            key = msvcrt.getch()
            if key == b' ':
                run()
                return
            elif key == b'q':
                return

run()