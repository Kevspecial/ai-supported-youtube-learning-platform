# Frontend Specification

## Current State

The platform currently uses a basic single-page HTML/CSS/JS frontend served by Flask with:
- YouTube video embedding
- Module extraction from transcripts
- Quiz generation per module

## Vision: Modern Learning Experience

Transform the frontend into an engaging, interactive learning dashboard that maximizes retention and tracks progress.

---

## Proposed Features

### 1. **Learning Dashboard**
- **Progress Tracker**: Visual progress bar showing completion across videos and modules
- **Streak Counter**: Gamification element showing daily learning streaks
- **Recent Activity**: Quick access to recently watched videos and incomplete quizzes

### 2. **Enhanced Video Player Section**
- **Timestamped Notes**: Allow users to add notes at specific timestamps
- **Bookmark Moments**: Save key moments for quick review
- **Playback Speed Controls**: Visible speed adjustment (0.5x - 2x)
- **Chapter Markers**: Visual markers on the video timeline showing module boundaries

### 3. **Interactive Module View**
- **Accordion-style Modules**: Expandable sections with previews
- **Module Status Indicators**: Not started / In progress / Completed / Quiz passed
- **Estimated Time**: Show estimated duration per module
- **Key Concepts Tags**: AI-extracted keywords displayed as chips/tags

### 4. **Improved Quiz Experience**
- **Quiz Modes**:
  - Practice Mode (instant feedback)
  - Test Mode (results at end)
  - Spaced Repetition (resurface missed questions)
- **Visual Feedback**: Animations for correct/incorrect answers
- **Explanations**: Show AI-generated explanations for wrong answers
- **Score History**: Track quiz scores over time per module

### 5. **Dark/Light Theme**
- System preference detection
- Manual toggle with persistence
- High contrast mode for accessibility

### 6. **Mobile-First Responsive Design**
- Collapsible sidebar navigation
- Touch-friendly quiz interactions
- Swipe gestures for navigation between modules

---

## Technical Recommendations

### Option A: Enhanced Vanilla JS (Low Effort)
- Keep current Flask templates
- Add modern CSS (CSS Grid, custom properties for theming)
- Use Web Components for reusable UI elements
- LocalStorage for user preferences and progress

### Option B: Lightweight Framework (Medium Effort)
- **Alpine.js** or **htmx** for reactivity without heavy build steps
- Keep server-side rendering, enhance with interactivity
- Progressive enhancement approach

### Option C: SPA Migration (High Effort)
- **Vue.js** or **React** with Vite
- REST API consumption from Flask backend
- Better state management for complex quiz flows
- Potential for PWA capabilities (offline mode)

---

## UI Component Ideas

```
┌─────────────────────────────────────────────────────────────┐
│  🎓 YouTube Learning Platform          [🌙] [👤] [⚙️]      │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                                                     │   │
│  │              [  YouTube Player  ]                   │   │
│  │                                                     │   │
│  └─────────────────────────────────────────────────────┘   │
│  ▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░  Module markers         │
│                                                             │
│  ┌──────────────────────┐  ┌──────────────────────────┐    │
│  │ 📚 Modules           │  │ 📝 Quiz                  │    │
│  │                      │  │                          │    │
│  │ ▼ 1. Introduction ✅ │  │  Question 3 of 10        │    │
│  │   └─ Key: AI, ML     │  │                          │    │
│  │                      │  │  What is the primary...  │    │
│  │ ► 2. Core Concepts ⏳│  │                          │    │
│  │                      │  │  ○ Option A              │    │
│  │ ► 3. Advanced   🔒   │  │  ● Option B              │    │
│  │                      │  │  ○ Option C              │    │
│  │ ► 4. Summary    🔒   │  │                          │    │
│  │                      │  │  [Submit Answer]         │    │
│  └──────────────────────┘  └──────────────────────────┘    │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ 📊 Your Progress: 45% │ 🔥 5-day streak │ ⭐ 230 pts│   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

---

## Priority Roadmap

| Phase | Features | Effort |
|-------|----------|--------|
| 1 | Dark theme, progress indicators, better quiz feedback | Low |
| 2 | Notes/bookmarks, module status tracking | Medium |
| 3 | Spaced repetition, score history, PWA | High |

---

## Design Principles

1. **Minimal Cognitive Load**: Clean interface, one primary action per screen
2. **Immediate Feedback**: Every interaction should have visual response
3. **Progress Visibility**: Users should always know where they are and what's next
4. **Accessibility First**: WCAG 2.1 AA compliance, keyboard navigation, screen reader support
