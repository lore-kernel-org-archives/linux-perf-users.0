From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf script flamegraph: python2 support, update cli args
Date: Mon, 13 Apr 2020 10:59:54 -0300
Message-ID: <20200413135954.GA17690@kernel.org>
References: <20200406151118.GC32649@kernel.org>
 <20200409165734.165260-1-agerstmayr@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200409165734.165260-1-agerstmayr@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Gerstmayr <agerstmayr@redhat.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Apr 09, 2020 at 06:57:31PM +0200, Andreas Gerstmayr escreveu:
> * removed --indent argument
> * renamed -F to -f argument to be consistent with other arguments

Ok, since I hadn't push the original patch, I've combined this one with
it it so that in systems with python2 it starts working and we can
bisect things from a good starting point.

- Arnaldo
 
> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
> ---
>  tools/perf/scripts/python/flamegraph.py | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> index 5835d190ca42..61f3be9add6b 100755
> --- a/tools/perf/scripts/python/flamegraph.py
> +++ b/tools/perf/scripts/python/flamegraph.py
> @@ -14,6 +14,7 @@
>  # Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
>  # Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.com>
>  
> +from __future__ import print_function
>  import sys
>  import os
>  import argparse
> @@ -43,11 +44,11 @@ class FlameGraphCLI:
>  
>          if self.args.format == "html" and \
>                  not os.path.isfile(self.args.template):
> -            print(f"Flame Graph template {self.args.template} does not " +
> -                  f"exist. Please install the js-d3-flame-graph (RPM) or " +
> -                  f"libjs-d3-flame-graph (deb) package, specify an " +
> -                  f"existing flame graph template (--template PATH) or " +
> -                  f"another output format (--format FORMAT).",
> +            print("Flame Graph template {} does not exist. Please install "
> +                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
> +                  "package, specify an existing flame graph template "
> +                  "(--template PATH) or another output format "
> +                  "(--format FORMAT).".format(self.args.template),
>                    file=sys.stderr)
>              sys.exit(1)
>  
> @@ -76,8 +77,7 @@ class FlameGraphCLI:
>          node.value += 1
>  
>      def trace_end(self):
> -        json_str = json.dumps(self.stack, default=lambda x: x.toJSON(),
> -                              indent=self.args.indent)
> +        json_str = json.dumps(self.stack, default=lambda x: x.toJSON())
>  
>          if self.args.format == "html":
>              try:
> @@ -85,7 +85,7 @@ class FlameGraphCLI:
>                      output_str = f.read().replace("/** @flamegraph_json **/",
>                                                    json_str)
>              except IOError as e:
> -                print(f"Error reading template file: {e}", file=sys.stderr)
> +                print("Error reading template file: {}".format(e), file=sys.stderr)
>                  sys.exit(1)
>              output_fn = self.args.output or "flamegraph.html"
>          else:
> @@ -95,24 +95,22 @@ class FlameGraphCLI:
>          if output_fn == "-":
>              sys.stdout.write(output_str)
>          else:
> -            print(f"dumping data to {output_fn}")
> +            print("dumping data to {}".format(output_fn))
>              try:
>                  with open(output_fn, "w") as out:
>                      out.write(output_str)
>              except IOError as e:
> -                print(f"Error writing output file: {e}", file=sys.stderr)
> +                print("Error writing output file: {}".format(e), file=sys.stderr)
>                  sys.exit(1)
>  
>  
>  if __name__ == "__main__":
>      parser = argparse.ArgumentParser(description="Create flame graphs.")
> -    parser.add_argument("-F", "--format",
> +    parser.add_argument("-f", "--format",
>                          default="html", choices=["json", "html"],
>                          help="output file format")
>      parser.add_argument("-o", "--output",
>                          help="output file name")
> -    parser.add_argument("--indent",
> -                        type=int, help="JSON indentation")
>      parser.add_argument("--template",
>                          default="/usr/share/d3-flame-graph/d3-flamegraph-base.html",
>                          help="path to flamegraph HTML template")
> -- 
> 2.25.2
> 

-- 

- Arnaldo
