"""
Agent-based model assignment 
"""
import random

class Agent:
    def __init__(self, id, energy):
        self.id = id
        self.energy = energy

    def __str__(self):
        return f"{self.id}, {self.energy}"

def create_population():
    '''create population of 100 agents, each with unique id and random energy'''
    return [Agent(i, random.randint(0, 100)) for i in range(100)]

def exchange_energy(agent1, agent2):
    '''higher energy agent should generally gain from lower energy,
    exchange is fixed 10% of lower energy agent'''
    if (agent1.energy > agent2.energy) and (random.random() < 0.9):
        agent1.energy += .1 * agent2.energy
        agent2.energy -= .1 * agent2.energy
    else:
        agent2.energy += .1 * agent1.energy
        agent1.energy -= .1 * agent1.energy

# test_agent1 = Agent(1, 90)
# test_agent2 = Agent(2, 10)
# exchange_energy(test_agent1, test_agent2)

def interact(agent_pop):
    '''simulates one round of interactions between agents in list agent_pop'''
    # problem here is that it's not simultaneous - earlier agents update before later agents
    for agent in agent_pop:
        without_agent = list(agent_pop)
        without_agent.remove(agent)
        target = random.choice(without_agent)
        exchange_energy(agent, target)

# interact(population)
# for agent in population:
#     print(agent)

# simulate 10 rounds of interactions for population of 100 agents
test_pop = create_population()
for agent in test_pop:
    print(agent)
for i in range(1, 10):
    interact(test_pop)
for agent in test_pop:
    print(agent)
