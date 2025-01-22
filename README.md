# Objective-C Crash: ViewController Deallocated Before Network Request Completion

This repository demonstrates a common Objective-C memory management issue that leads to crashes.  The problem occurs when a view controller is deallocated before a network request completes, and the network manager still holds a strong reference to the view controller.

## Problem

A `ViewController` creates a `NetworkManager` instance. The `NetworkManager` uses a delegate pattern to communicate with the `ViewController` upon request completion. If the `ViewController` is deallocated while the network request is in progress, and the `NetworkManager` still has a strong reference to it, attempting to access the deallocated `ViewController`'s methods or properties will result in a crash.

## Solution

The solution involves using `weak` references to prevent strong cycles. By making the delegate property in `NetworkManager` `weak`, we avoid retaining the `ViewController` after it's been deallocated.