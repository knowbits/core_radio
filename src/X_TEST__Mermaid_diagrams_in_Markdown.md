# VS Code: Showing Mermaid diagrams in Markdown documents

Install extension:
"Markdown Preview Mermaid Support"

CTRL+SHIFT+V : Toggle preview mode.

## EXAMPLE 1

```mermaid
graph TD;
    A[Start] --> B{Decision};
    B -->|Yes| C[Do Task];
    B -->|No| D[Stop];

```

## EXAMPLE 2

```mermaid

graph TD

  A[Preheat AeroPress and cup,<br> discard water] --> B[Heat water to 88-90°C]
  B --> C[Pour most of the water<br> #40;150-200g#41; into AeroPress]
  C --> D[Add 20g coffee grounds<br> on top of the water]
  D --> E[Pour a small amount of water<br> #40;30-50g#41; to make the coffee bloom]
  E --> F[Bloom for 15-30 seconds]
  F --> G[Stir for 10-15 seconds]
  G --> H[Steep for 1-2 minutes]
  H --> I[Press gently for 20-30 seconds]
  I --> J[Enjoy your AeroPress coffee!]

```

---

## TEST

hello
