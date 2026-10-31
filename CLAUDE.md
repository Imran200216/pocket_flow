# Pocket Flow – Project Rules

Flutter app, Android and iOS only. Always use FVM: `fvm flutter ...`, `fvm dart ...` (never bare `flutter`/`dart`).

## Architecture (strict)

Code MUST strictly follow Clean Architecture. No exceptions without explicit user approval.

Feature-first layout, each feature split into three layers:

```
lib/features/<feature>/
  data/            # datasources, models (DTOs), repository implementations
  domain/          # entities, repository contracts (abstract), use cases
  presentation/    # screens, widgets, bloc/cubit (state)
    screens/
    widgets/
    bloc/
```

Shared code lives in `lib/core` (router, DI, errors, utils, theme) and `lib/common` (reusable widgets/constants).

### Dependency rule
- `presentation` -> `domain` only. `data` -> `domain` only. `domain` depends on nothing (pure Dart, no Flutter, no packages except tiny ones like equatable/freezed_annotation).
- Presentation must never import from `data`. Domain must never import from `data` or `presentation`.
- Screens/widgets never call datasources, Hive, or network directly. Flow is: UI -> Bloc/Cubit -> UseCase -> Repository (interface) -> Repository impl -> DataSource.
- Models (data layer) map to/from entities (domain layer). UI uses entities only.
- Business logic goes in use cases / blocs, never in widgets.
- Dependencies are wired via `get_it` + `injectable`; depend on abstractions, not implementations.

## Screen file size limit

- A screen file MUST NOT exceed **300 lines**.
- If a screen approaches the limit, split it into smaller widgets under `presentation/widgets/` (one widget per file) or extract logic into the bloc/cubit.
- Check line counts before finishing any screen change.

## Imports

- ALWAYS use full package imports: `import 'package:pocket_flow/...';`
- NEVER use relative imports (`../`, `./`). Applies to every file in `lib/` and `test/`.
- Generated `part` files are the only exception.

## Naming (STRICT)

- Variables, parameters, and fields MUST have meaningful, descriptive names that say what they hold.
- NEVER use single-letter or cryptic abbreviations (`r`, `c`, `p`, `x`, `e`, `tmp`, `val`). Write `responsive`, `colors`, `controller`, `error`, etc.
- Applies everywhere: screens, widgets, blocs, use cases, utils, tests. Only exceptions: the unused-parameter `_` and short loop indices (`i`) in trivial loops.

## Enums (STRICT)

- ALL enums in the app live in `lib/core/enums/`, one enum per file, named `snake_case.dart` after the enum (e.g. `DeviceType` -> `device_type.dart`).
- NEVER declare an enum inside a screen, widget, bloc, model, util, or any other file. Create it in `lib/core/enums/` and import it with a full package import.
- Use enums instead of magic strings/ints/booleans for any fixed set of values (types, statuses, modes, tabs, etc.) app-wide.
- Existing enums: `DeviceType` (`device_type.dart`). Add new ones here as they are created.

## Responsive design (STRICT)

The app MUST be responsive for both mobile and tablet. Every screen, no exceptions.

- All responsive logic lives in `lib/core/utils/responsive_utils.dart` (`ResponsiveUtils`, accessed via `context.responsive`). Do not duplicate or reimplement breakpoints elsewhere.
- NEVER read `MediaQuery` / `LayoutBuilder` sizes directly in screens or widgets to decide layout; use `context.responsive` (`isTablet`, `isMobile`, `value(mobile:, tablet:)`, `horizontalPadding`, `verticalSpacing`, `contentMaxWidth`). Add new helpers to `ResponsiveUtils` if something is missing.
- NEVER hardcode paddings, spacings, font sizes, or image sizes that differ by device; use `context.responsive.value(...)` or the `ResponsiveUtils` getters.
- Wrap every screen body in `ResponsiveBody` (`lib/common/widgets/responsive_body.dart`) so content is centered and width-limited on tablets.
- Screens must not overflow on small phones or tablets (portrait and landscape); use `Expanded`/`Flexible`/scrolling as needed.
- A screen is not finished until it has been checked for both mobile and tablet.

## Form fields (STRICT)

- ALL dropdowns MUST use `KDropdownTextFormField` (`lib/common/widgets/k_dropdown_text_form_field.dart`), built on the `dropdown_button2` package. NEVER use `DropdownButton`, `DropdownButtonFormField`, or `DropdownMenu` directly.
- Currency selection MUST use `KCurrencyPickerFormField` (`lib/common/widgets/k_currency_picker_form_field.dart`), built on the `currency_picker` package.
- Field styling (fill, borders, hint, error) comes from `InputDecorationTheme` in `lib/core/themes`; never style fields with hardcoded colors in screens.
- Reusable form widgets belong in `lib/common/widgets/`; prefix app-wide shared form widgets with `K`.

- ALL text inputs MUST use `KTextFormField` (`lib/common/widgets/k_text_form_field.dart`); NEVER use a raw `TextFormField`/`TextField` in screens.
- Every `K` field shows a label on top (`KLabeledField`): a `Text` label, a gap, then the field. Always pass `label` and `hintText` from l10n.

- ALL filled buttons MUST use `KFilledBtn` (`lib/common/widgets/k_filled_btn.dart`); NEVER use a raw `FilledButton`. It has `isLoading`, which shows `CircularProgressIndicator.adaptive` and ignores taps; drive it from state (e.g. `state.isLoading`).

## Bloc usage (STRICT)

- ALWAYS use `BlocConsumer`. NEVER use `BlocBuilder`, `BlocListener`, or `BlocSelector` directly (pass an empty `listener` if only building, and `buildWhen` / `listenWhen` to limit work).
- NEVER wrap a `Scaffold` or a whole screen/form in a `BlocConsumer`. Wrap ONLY the smallest widget that needs to rebuild or react (a single field, a button), with a narrow `buildWhen`.
- ALL blocs/cubits are registered in `lib/core/providers/app_bloc_providers.dart` (`AppBlocProviders.providers`), which `main.dart` passes to `MultiBlocProvider` above the app. NEVER create a `BlocProvider` inside a screen/route; add the bloc to that list instead.
- Side effects (navigation, snackbars) go in the `listener` of the nearest `BlocConsumer` with a precise `listenWhen`.
- Use enums (`lib/core/enums/`) for statuses, e.g. `initial / loading / success`, not booleans/strings.

## Spacing (STRICT)

- Use `Gap` (`package:gap/gap.dart`) for ALL spacing between widgets in a `Column`/`Row`/`Flex`. NEVER use `SizedBox` as a spacer (`SizedBox(height: ...)` / `SizedBox(width: ...)`).
- Device-dependent gaps use `Gap(context.responsive.elementSpacing)` etc. (see Responsive design).
- `SizedBox` is only allowed for fixed-size boxes (e.g. an icon/image size), never for spacing.

## Hooks (STRICT)

- Use `flutter_hooks` for widget-local state and disposables. NEVER write `initState` / `dispose` / `StatefulWidget` for this; use `HookWidget`.
- Controllers: `useTextEditingController()`, `usePageController()`, `useScrollController()`, `useFocusNode()`, `useAnimationController()` (they dispose themselves).
- Local state: `useState`, `useValueNotifier`, `useMemoized` (e.g. `useMemoized(GlobalKey<FormState>.new)`), `useEffect` for side effects.
- Only fall back to `StatefulWidget` when a hook cannot express it, and ask the user first.

## Conventions

- Navigation: `auto_route`. Annotate pages with `@RoutePage()`; register in `lib/core/router/app_router.dart`. Regenerate with `fvm dart run build_runner build --delete-conflicting-outputs`.
- State management: `bloc` / `flutter_bloc` (`hydrated_bloc` where persistence is needed).
- Models: `freezed` + `json_serializable`. Local DB: `hive`.
- Localization: all user-facing strings go in `lib/l10n/app_en.arb` (no hardcoded text); use `AppLocalizations.of(context)`.
- Run `fvm flutter analyze` and `fvm flutter test` before finishing; both must pass.
