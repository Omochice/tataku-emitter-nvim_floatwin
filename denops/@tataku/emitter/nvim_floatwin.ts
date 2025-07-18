import { Denops } from "jsr:@denops/std@7.6.0";
import {
  $array,
  $boolean,
  $object,
  $opt,
  $string,
  $union,
  access,
  type Infer,
} from "npm:lizod@0.2.7";

function resolveBorder(
  border: Border,
): string | string[] {
  if (typeof border === "string") {
    return border;
  }
  return directions.map((d) => border[d]);
}

const defaults: Required<Option> = {
  border: "none",
  autoclose: true,
};

const isOption = $object({
  border: $opt($union([$string, $array($string)])),
  autoclose: $opt($boolean),
});

type Option = Infer<typeof isOption>;

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

const emitter = (denops: Denops, option: unknown) => {
  const ctx = { errors: [] };
  if (!isOption(option, ctx)) {
    throw new Error(
      ctx.errors
        .map((err) => `error at ${err} ${access(option, err)}`)
        .join("\n"),
    );
  }
  return new WritableStream<string[]>({
    write: async (chunk: string[]) => {
      const lines = chunk.join("")
        .split(/\r?\n/);
      await denops.call(
        "tataku#emitter#nvim_floatwin#open",
        lines,
        {
          // @ts-ignore: workaround
          border: resolveBorder(option.border ?? defaults.border),
          autoclose: option.autoclose ?? defaults.autoclose,
        },
      );
    },
  });
};

export default emitter;
