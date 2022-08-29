import { Denops } from "https://deno.land/x/denops_std@v3.8.1/mod.ts";
import { isString } from "https://deno.land/x/unknownutil@v2.0.0/mod.ts";

export async function run(
  denops: Denops,
  options: Record<string, unkown>,
  source: string[],
): Promise<void> {
  await denops.call(
    "tataku#emitter#nvim_floatwin#open",
    source,
    { ...defaults, ...options },
  );
}

function resolveBorder(
  border: Border,
): string | [string, string, string, string, string, string, string, string] {
  if (isString(border)) {
    return border;
  }
  return directions.map((d) => border[d]);
}

const defaults: Required<Option> = {
  border: "none",
  autoclose: true,
};

type Option = {
  border?: Border;
  autoclose?: boolean;
};

const directions = [
  "topleft",
  "top",
  "topright",
  "right",
  "bottomright",
  "bottom",
  "bottomleft",
  "left",
] as const;

type Border =
  | "none"
  | "single"
  | "double"
  | "rounded"
  | "solid"
  | "shadow"
  | Record<typeof directions[number], string>;
