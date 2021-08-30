Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14EEC4320A
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 18:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898AC60241
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 18:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhH3Sqw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232138AbhH3Sqw (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Aug 2021 14:46:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C973260C40;
        Mon, 30 Aug 2021 18:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630349158;
        bh=uBSqmFdAAvqpL3av2pDy+f24B29zTi1og4QtJoIO2H0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcYMTZXAnWMKj9vjjcRqhotfgJYr53vL80894AcY5P3YpMtYgM2shKtoaghzTgevl
         SkBFVEhGw/DC7OWG8s8tjOr1Stje0//T2aaevB3yj1/2RwgiRX+Uf3/IY5tBc+2HST
         Hz3iZaY17x8wAHrFDZnJ8ii+Dm8eLJHwgaCUC6im2HdOO2dD2ArfVNdp8R1stsKtJF
         9eVmLeipkbi7J/oU2/SR7Tucz9QNhymF5FOzlB33cCM+mf6os+0zc4GC5pvgsCyx3p
         pqzfN0Z2bZgf0Dg1lcR950n/TJLQ7+TZu0UHjhYL5O7BI1wPozY/XMaEiOjk39HdY6
         PFdULeR92V/iA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E83C4007E; Mon, 30 Aug 2021 15:45:54 -0300 (-03)
Date:   Mon, 30 Aug 2021 15:45:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andreas Gerstmayr <agerstmayr@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: flamegraph.py script improvements
Message-ID: <YS0nYpDjPJwT1XYo@kernel.org>
References: <20210830164729.116049-1-agerstmayr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830164729.116049-1-agerstmayr@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 30, 2021 at 06:47:27PM +0200, Andreas Gerstmayr escreveu:
> * display perf.data header
> * display PIDs of user stacks
> * added option to change color scheme
> * default to blue/green color scheme to improve accessibility
> * correctly identify kernel stacks when kernel-debuginfo is installed

I'll apply this but please next time split these changes in separate
patches, this way we can find and fix problems faster by using 'git
bisect'.

- Arnaldo
 
> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
> ---
> Tested with Fedora 34, RHEL 8.5 & 9-beta, and Ubuntu 20.04.
> 
> The updated flamegraph.py script works with the current d3-flame-graph template, but in order to use the new features (perf header, new color scheme), please run `wget -O /usr/share/d3-flame-graph/d3-flamegraph-base.html https://gist.githubusercontent.com/andreasgerstmayr/1f84a6ac04e6391bfc653a546cf3e1aa/raw/f67accc1873be66d14e90360c9b8cd15faa551f6/d3-flamegraph-base.html`
> I'll update the js-d3-flame-graph package soon.
> 
> 
>  tools/perf/scripts/python/flamegraph.py | 108 ++++++++++++++++++------
>  1 file changed, 81 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> index 65780013f745..b6af1dd5f816 100755
> --- a/tools/perf/scripts/python/flamegraph.py
> +++ b/tools/perf/scripts/python/flamegraph.py
> @@ -13,6 +13,10 @@
>  # Written by Andreas Gerstmayr <agerstmayr@redhat.com>
>  # Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
>  # Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.com>
> +#
> +# pylint: disable=missing-module-docstring
> +# pylint: disable=missing-class-docstring
> +# pylint: disable=missing-function-docstring
>  
>  from __future__ import print_function
>  import sys
> @@ -20,16 +24,19 @@ import os
>  import io
>  import argparse
>  import json
> +import subprocess
>  
> -
> +# pylint: disable=too-few-public-methods
>  class Node:
> -    def __init__(self, name, libtype=""):
> +    def __init__(self, name, libtype):
>          self.name = name
> +        # "root" | "kernel" | ""
> +        # "" indicates user space
>          self.libtype = libtype
>          self.value = 0
>          self.children = []
>  
> -    def toJSON(self):
> +    def to_json(self):
>          return {
>              "n": self.name,
>              "l": self.libtype,
> @@ -41,7 +48,7 @@ class Node:
>  class FlameGraphCLI:
>      def __init__(self, args):
>          self.args = args
> -        self.stack = Node("root")
> +        self.stack = Node("all", "root")
>  
>          if self.args.format == "html" and \
>                  not os.path.isfile(self.args.template):
> @@ -53,13 +60,21 @@ class FlameGraphCLI:
>                    file=sys.stderr)
>              sys.exit(1)
>  
> -    def find_or_create_node(self, node, name, dso):
> -        libtype = "kernel" if dso == "[kernel.kallsyms]" else ""
> -        if name is None:
> -            name = "[unknown]"
> +    @staticmethod
> +    def get_libtype_from_dso(dso):
> +        """
> +        when kernel-debuginfo is installed,
> +        dso points to /usr/lib/debug/lib/modules/*/vmlinux
> +        """
> +        if dso and (dso == "[kernel.kallsyms]" or dso.endswith("/vmlinux")):
> +            return "kernel"
>  
> +        return ""
> +
> +    @staticmethod
> +    def find_or_create_node(node, name, libtype):
>          for child in node.children:
> -            if child.name == name and child.libtype == libtype:
> +            if child.name == name:
>                  return child
>  
>          child = Node(name, libtype)
> @@ -67,30 +82,65 @@ class FlameGraphCLI:
>          return child
>  
>      def process_event(self, event):
> -        node = self.find_or_create_node(self.stack, event["comm"], None)
> +        pid = event.get("sample", {}).get("pid", 0)
> +        # event["dso"] sometimes contains /usr/lib/debug/lib/modules/*/vmlinux
> +        # for user-space processes; let's use pid for kernel or user-space distinction
> +        if pid == 0:
> +            comm = event["comm"]
> +            libtype = "kernel"
> +        else:
> +            comm = "{} ({})".format(event["comm"], pid)
> +            libtype = ""
> +        node = self.find_or_create_node(self.stack, comm, libtype)
> +
>          if "callchain" in event:
> -            for entry in reversed(event['callchain']):
> -                node = self.find_or_create_node(
> -                    node, entry.get("sym", {}).get("name"), event.get("dso"))
> +            for entry in reversed(event["callchain"]):
> +                name = entry.get("sym", {}).get("name", "[unknown]")
> +                libtype = self.get_libtype_from_dso(entry.get("dso"))
> +                node = self.find_or_create_node(node, name, libtype)
>          else:
> -            node = self.find_or_create_node(
> -                node, entry.get("symbol"), event.get("dso"))
> +            name = event.get("symbol", "[unknown]")
> +            libtype = self.get_libtype_from_dso(event.get("dso"))
> +            node = self.find_or_create_node(node, name, libtype)
>          node.value += 1
>  
> +    def get_report_header(self):
> +        if self.args.input == "-":
> +            # when this script is invoked with "perf script flamegraph",
> +            # no perf.data is created and we cannot read the header of it
> +            return ""
> +
> +        try:
> +            output = subprocess.check_output(["perf", "report", "--header-only"])
> +            return output.decode("utf-8")
> +        except Exception as err:  # pylint: disable=broad-except
> +            print("Error reading report header: {}".format(err), file=sys.stderr)
> +            return ""
> +
>      def trace_end(self):
> -        json_str = json.dumps(self.stack, default=lambda x: x.toJSON())
> +        stacks_json = json.dumps(self.stack, default=lambda x: x.to_json())
>  
>          if self.args.format == "html":
> +            report_header = self.get_report_header()
> +            options = {
> +                "colorscheme": self.args.colorscheme,
> +                "context": report_header
> +            }
> +            options_json = json.dumps(options)
> +
>              try:
> -                with io.open(self.args.template, encoding="utf-8") as f:
> -                    output_str = f.read().replace("/** @flamegraph_json **/",
> -                                                  json_str)
> -            except IOError as e:
> -                print("Error reading template file: {}".format(e), file=sys.stderr)
> +                with io.open(self.args.template, encoding="utf-8") as template:
> +                    output_str = (
> +                        template.read()
> +                        .replace("/** @options_json **/", options_json)
> +                        .replace("/** @flamegraph_json **/", stacks_json)
> +                    )
> +            except IOError as err:
> +                print("Error reading template file: {}".format(err), file=sys.stderr)
>                  sys.exit(1)
>              output_fn = self.args.output or "flamegraph.html"
>          else:
> -            output_str = json_str
> +            output_str = stacks_json
>              output_fn = self.args.output or "stacks.json"
>  
>          if output_fn == "-":
> @@ -101,8 +151,8 @@ class FlameGraphCLI:
>              try:
>                  with io.open(output_fn, "w", encoding="utf-8") as out:
>                      out.write(output_str)
> -            except IOError as e:
> -                print("Error writing output file: {}".format(e), file=sys.stderr)
> +            except IOError as err:
> +                print("Error writing output file: {}".format(err), file=sys.stderr)
>                  sys.exit(1)
>  
>  
> @@ -115,12 +165,16 @@ if __name__ == "__main__":
>                          help="output file name")
>      parser.add_argument("--template",
>                          default="/usr/share/d3-flame-graph/d3-flamegraph-base.html",
> -                        help="path to flamegraph HTML template")
> +                        help="path to flame graph HTML template")
> +    parser.add_argument("--colorscheme",
> +                        default="blue-green",
> +                        help="flame graph color scheme",
> +                        choices=["blue-green", "orange"])
>      parser.add_argument("-i", "--input",
>                          help=argparse.SUPPRESS)
>  
> -    args = parser.parse_args()
> -    cli = FlameGraphCLI(args)
> +    cli_args = parser.parse_args()
> +    cli = FlameGraphCLI(cli_args)
>  
>      process_event = cli.process_event
>      trace_end = cli.trace_end
> -- 
> 2.31.1

-- 

- Arnaldo
