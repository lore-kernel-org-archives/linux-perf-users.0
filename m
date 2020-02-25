From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC] perf script: add flamegraph.py script
Date: Tue, 25 Feb 2020 20:54:18 +0100
Message-ID: <20200225195418.GA160300@krava>
References: <20200221175500.83774-1-agerstmayr@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200221175500.83774-1-agerstmayr@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Gerstmayr <agerstmayr@redhat.com>
Cc: linux-kernel@vger.kernel.org, kabbott@redhat.com, skozina@redhat.com, mpetlan@redhat.com, nathans@redhat.com, mgoodwin@redhat.com, linux-perf-users@vger.kernel.org, bgregg@netflix.com, mspier@netflix.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Feb 21, 2020 at 06:55:01PM +0100, Andreas Gerstmayr wrote:
> This script works in tandem with d3-flame-graph to generate flame graphs
> from perf. It supports two output formats: JSON and HTML (the default).
> The HTML format will look for a standalone d3-flame-graph template file in
> /usr/share/d3-flame-graph/template.html and fill in the collected stacks.
> 
> Usage:
> 
>     perf script flamegraph -a -F 99 sleep 60
> 
> Alternative usage:
> 
>     perf record -a -g -F 99 sleep 60
>     perf script report flamegraph

nice, could this output the output file, like:

     # perf script report flamegraph --output krava.html
     dumping data to krava.html

or something in that sense

other than that it looks good to me

thanks,
jirka


> 
> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
> 
> I'm currently preparing packages for d3-flame-graph. For Fedora, the copr
> at
> https://copr.fedorainfracloud.org/coprs/agerstmayr/reviews/package/js-d3-flame-graph/
> can be installed, or alternatively the prebuilt standalone d3-flame-graph
> template can be downloaded from
> https://raw.githubusercontent.com/andreasgerstmayr/specs/master/reviews/js-d3-flame-graph/template.html
> and moved into /usr/share/d3-flame-graph/template.html
> 
>  .../perf/scripts/python/bin/flamegraph-record |   2 +
>  .../perf/scripts/python/bin/flamegraph-report |   3 +
>  tools/perf/scripts/python/flamegraph.py       | 117 ++++++++++++++++++
>  3 files changed, 122 insertions(+)
>  create mode 100755 tools/perf/scripts/python/bin/flamegraph-record
>  create mode 100755 tools/perf/scripts/python/bin/flamegraph-report
>  create mode 100755 tools/perf/scripts/python/flamegraph.py
> 
> diff --git a/tools/perf/scripts/python/bin/flamegraph-record b/tools/perf/scripts/python/bin/flamegraph-record
> new file mode 100755
> index 000000000000..725d66e71570
> --- /dev/null
> +++ b/tools/perf/scripts/python/bin/flamegraph-record
> @@ -0,0 +1,2 @@
> +#!/usr/bin/sh
> +perf record -g "$@"
> diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
> new file mode 100755
> index 000000000000..b1a79afd903b
> --- /dev/null
> +++ b/tools/perf/scripts/python/bin/flamegraph-report
> @@ -0,0 +1,3 @@
> +#!/usr/bin/sh
> +# description: create flame graphs
> +perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> new file mode 100755
> index 000000000000..2e9139ef2c4a
> --- /dev/null
> +++ b/tools/perf/scripts/python/flamegraph.py
> @@ -0,0 +1,117 @@
> +# flamegraph.py - create flame graphs from perf samples
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Usage:
> +#
> +#  perf record -a -g -F 99 sleep 60
> +#  perf script report flamegraph
> +#
> +# Combined data collection and flamegraph generation:
> +#
> +#  perf script flamegraph -a -F 99 sleep 60
> +#
> +# Written by Andreas Gerstmayr <agerstmayr@redhat.com>
> +# Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
> +# Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.com>
> +
> +import sys
> +import os
> +import argparse
> +import json
> +
> +
> +class Node:
> +    def __init__(self, name, libtype=""):
> +        self.name = name
> +        self.libtype = libtype
> +        self.value = 0
> +        self.children = []
> +
> +
> +class FlameGraphCLI:
> +    def __init__(self, args):
> +        self.args = args
> +        self.stack = Node("root")
> +
> +        if self.args.format == "html" and \
> +                not os.path.isfile(self.args.template):
> +            print(f"Flame Graph template '{self.args.template}' does not " +
> +                  f"exist. Please install the d3-flame-graph package, " +
> +                  f"specify an existing flame graph template " +
> +                  f"(--template PATH) or another output format " +
> +                  f"(--format FORMAT).", file=sys.stderr)
> +            sys.exit(1)
> +
> +    def find_or_create_node(self, node, name, dso):
> +        libtype = "kernel" if dso == "[kernel.kallsyms]" else ""
> +        if name is None:
> +            name = "[unknown]"
> +
> +        for child in node.children:
> +            if child.name == name and child.libtype == libtype:
> +                return child
> +
> +        child = Node(name, libtype)
> +        node.children.append(child)
> +        return child
> +
> +    def process_event(self, event):
> +        node = self.find_or_create_node(self.stack, event["comm"], None)
> +        if "callchain" in event:
> +            for entry in reversed(event['callchain']):
> +                node = self.find_or_create_node(
> +                    node, entry.get("sym", {}).get("name"), event.get("dso"))
> +        else:
> +            node = self.find_or_create_node(
> +                node, entry.get("symbol"), event.get("dso"))
> +        node.value += 1
> +
> +    def trace_end(self):
> +        def encoder(x): return x.__dict__
> +        json_str = json.dumps(self.stack, default=encoder,
> +                              indent=self.args.indent)
> +
> +        if self.args.format == "html":
> +            try:
> +                with open(self.args.template) as f:
> +                    output_str = f.read().replace("/** @flamegraph_params **/",
> +                                                  json_str)
> +            except IOError as e:
> +                print(f"Error reading template file: {e}", file=sys.stderr)
> +                sys.exit(1)
> +            output_fn = self.args.output or "flamegraph.html"
> +        else:
> +            output_str = json_str
> +            output_fn = self.args.output or "stacks.json"
> +
> +        if output_fn == "-":
> +            sys.stdout.write(output_str)
> +        else:
> +            try:
> +                with open(output_fn, "w") as out:
> +                    out.write(output_str)
> +            except IOError as e:
> +                print(f"Error writing output file: {e}", file=sys.stderr)
> +                sys.exit(1)
> +
> +
> +if __name__ == "__main__":
> +    parser = argparse.ArgumentParser(description="Create flame graphs.")
> +    parser.add_argument("-F", "--format",
> +                        default="html", choices=["json", "html"],
> +                        help="output file format")
> +    parser.add_argument("-o", "--output",
> +                        help="output file name")
> +    parser.add_argument("--indent",
> +                        type=int, help="JSON indentation")
> +    parser.add_argument("--template",
> +                        default="/usr/share/d3-flame-graph/template.html",
> +                        help="path to flamegraph HTML template")
> +    parser.add_argument("-i", "--input",
> +                        help=argparse.SUPPRESS)
> +
> +    args = parser.parse_args()
> +    cli = FlameGraphCLI(args)
> +
> +    process_event = cli.process_event
> +    trace_end = cli.trace_end
> -- 
> 2.24.1
> 
