import { Denops } from "https://deno.land/x/denops_std@v3.8.1/mod.ts";
import { isString } from "https://deno.land/x/unknownutil@v2.0.0/mod.ts";
import { Emitter } from "https://raw.githubusercontent.com/Omochice/tataku.vim/master/denops/tataku/interface.ts";

export default class implements Emitter {
  constructor(private readonly option: Record<string, unknown>) {
  }

  async run(denops: Denops, source: string[]) {
    await denops.call(
      "tataku#emitter#nvim_floatwin#open",
      source,
      {
        border: resolveBorder(this.option.border ?? defaults.border),
        autoclose: this.option.autoclose ?? defaults.autoclose,
      },
    );
  }
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
