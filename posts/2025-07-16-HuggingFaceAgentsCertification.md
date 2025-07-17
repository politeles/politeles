---
categories:
- GenAI
- Agentic
- HuggingFace
- SmolAgent
date: '2025-07-16'
description: My notes for the Hugging Face Agents course
layout: post
title: Hugging Face Agents Course
toc: true

---

# What's an agent

The first question to ask would be "What's an agent". Then, why do we use them, and finally what are the benefits of using an agent over a language model (LLM) with plugins.

I'll try to ask all of these questions.

## what's an agent?

An agent is a set of at least three things:
 - The Brain: a large language model (LLM). Could be open source or commercial. The LLM is in charge for the planning of actions.
 - The heart: These tools provide the connection between the LLM and the external world. A tool could be something as simple as a calculator, but it could be more complex, something like a sheet reader or a Wikipedia article reader.
- A lifecycle: Most of the agents implement the so-called [ReAct approach](https://huggingface.co/learn/agents-course/en/unit1/thoughts) (Reasoning and Acting). This approach ask the model to think step by step providing a plan that leads to the final solution rather than a final solution. 

## Why do we use them?

There are several reasons why an agentic approach is superior to a LLM:

 - The agent has a specific workflow. The most common pattern is ReAct (but there are others). We give the agent a task, then the agent produces a plan using the LLM, acts in the world using the tools and observe the result of the action. At the end of the cycle, the agent uses the observation to feed back the LLM, generating or updating the action plan. Once the agent considers the output to be correct, it produces a final answer.
 - Agents can use tools: Tools are functions that can interact with the real world. We can write these functions (or we can use third-party). Possibilities are endless. For example, we could develop a tool that allows the model to watch a Youtube video (by splitting the video in frames and the audio track) and then ask questions about that video. Or we could define a tool that browses the Internet and take screenshots. We can also use the MCP protocol to communicate with the outside world.
 - Token ussage: If we combine multiple agents for specific tasks, then we could reduce the context window of each of them. In other words, instead of having one single model dealing with all the information in its context window, we could use multiple agents with smaller context windows.
 - Multi-agent: An agent can communicate with others agents to resolve more complex tasks.