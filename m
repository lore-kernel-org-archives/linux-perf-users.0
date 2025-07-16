Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EF1DE2C9;
	Wed, 16 Jul 2025 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687802; cv=none; b=WqUwkjircpQjFey13DWdY0mIPdqDMTrtVFGcbtvMMuWFOI0G9v7rFj/AanV6UVBrcEETwu/o0SS17F9gBTZTQFfnZ2CPeUu9ZjI/3H8aQKPxXR/NqaZOOZhl2XszRY1kl/CSB6BLUG9kbbNS03xKmJ1iHYicSDLMG/w1Ej4BcfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687802; c=relaxed/simple;
	bh=pVUgd83X7O2yW0R+ZVk/AgaBdop9yiXyxkXpur3QzKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdEjEqZj4Zm730ilLtQn2ZxDwj1i8wT5P09aucFxWI7hUckASJd8jTGD3MMyS0Ni6VN5FtguDxL0qEGUJbU+S0aqEXJ5rFHU/o+r0kgaYr03LDReCwOwcryr+66OCOA6/t2GJpYahDgXV7LR1ruxb3NpwUPRWkIOcUUH0SnudMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCgegwrw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCgegwrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920F1C4CEE7;
	Wed, 16 Jul 2025 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752687802;
	bh=pVUgd83X7O2yW0R+ZVk/AgaBdop9yiXyxkXpur3QzKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCgegwrwu8HbioIGoh4qhjg2GTG/TX1pCmUv9DjiV5NF9spFCtLW3DyxTqkHyWPO8
	 i+KSVbsj8zeNKBTXd8qiX1RDPGJ5QNWyZCQMYiQGcONn7jPFRLJKQHmpKNaze5Dxd+
	 4D1w4Kv34wECtYtAAUu7/wmJZMmOq/Q9n04PxRgNVE5UNC6wvVx4bXvzk/qToLcVM5
	 zpma5uC3BjSqu0wKLpi6+36qfv+QUmIHe6Lq7Sg1wzgapRQ78VuWKHBv+u34mLyiJG
	 j2XkTshqdYDzkROu7FtHWKPyLQTaof/zCLp+xy8vfy7PuJjKONFQxHLbEf/wHdl3fo
	 SrO9n6zRP8FmA==
Date: Wed, 16 Jul 2025 10:43:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Zhiguo Zhou <zhiguo.zhou@intel.com>,
	Tianyou Li <tianyou.li@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf flamegraph: Fix minor pylint/type hint issues
Message-ID: <aHfkuHCVk74XQ09F@google.com>
References: <20250716004635.31161-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716004635.31161-1-irogers@google.com>

On Tue, Jul 15, 2025 at 05:46:35PM -0700, Ian Rogers wrote:
> Switch to assuming python3. Fix minor pylint issues on line length,
> repeated compares, not using f-strings and variable case. Add type
> hints and check with mypy.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

I've confirmed that it generated the exactly same output.

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/scripts/python/flamegraph.py | 61 +++++++++++++------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> index e49ff242b779..ad735990c5be 100755
> --- a/tools/perf/scripts/python/flamegraph.py
> +++ b/tools/perf/scripts/python/flamegraph.py
> @@ -18,7 +18,6 @@
>  # pylint: disable=missing-class-docstring
>  # pylint: disable=missing-function-docstring
>  
> -from __future__ import print_function
>  import argparse
>  import hashlib
>  import io
> @@ -26,9 +25,10 @@ import json
>  import os
>  import subprocess
>  import sys
> +from typing import Dict, Optional, Union
>  import urllib.request
>  
> -minimal_html = """<head>
> +MINIMAL_HTML = """<head>
>    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
>  </head>
>  <body>
> @@ -50,20 +50,20 @@ minimal_html = """<head>
>  
>  # pylint: disable=too-few-public-methods
>  class Node:
> -    def __init__(self, name, libtype):
> +    def __init__(self, name: str, libtype: str):
>          self.name = name
>          # "root" | "kernel" | ""
>          # "" indicates user space
>          self.libtype = libtype
> -        self.value = 0
> -        self.children = []
> +        self.value: int = 0
> +        self.children: list[Node] = []
>  
> -    def to_json(self):
> +    def to_json(self) -> Dict[str, Union[str, int, list[Dict]]]:
>          return {
>              "n": self.name,
>              "l": self.libtype,
>              "v": self.value,
> -            "c": self.children
> +            "c": [x.to_json() for x in self.children]
>          }
>  
>  
> @@ -73,7 +73,7 @@ class FlameGraphCLI:
>          self.stack = Node("all", "root")
>  
>      @staticmethod
> -    def get_libtype_from_dso(dso):
> +    def get_libtype_from_dso(dso: Optional[str]) -> str:
>          """
>          when kernel-debuginfo is installed,
>          dso points to /usr/lib/debug/lib/modules/*/vmlinux
> @@ -84,7 +84,7 @@ class FlameGraphCLI:
>          return ""
>  
>      @staticmethod
> -    def find_or_create_node(node, name, libtype):
> +    def find_or_create_node(node: Node, name: str, libtype: str) -> Node:
>          for child in node.children:
>              if child.name == name:
>                  return child
> @@ -93,7 +93,7 @@ class FlameGraphCLI:
>          node.children.append(child)
>          return child
>  
> -    def process_event(self, event):
> +    def process_event(self, event) -> None:
>          # ignore events where the event name does not match
>          # the one specified by the user
>          if self.args.event_name and event.get("ev_name") != self.args.event_name:
> @@ -106,7 +106,7 @@ class FlameGraphCLI:
>              comm = event["comm"]
>              libtype = "kernel"
>          else:
> -            comm = "{} ({})".format(event["comm"], pid)
> +            comm = f"{event['comm']} ({pid})"
>              libtype = ""
>          node = self.find_or_create_node(self.stack, comm, libtype)
>  
> @@ -121,7 +121,7 @@ class FlameGraphCLI:
>              node = self.find_or_create_node(node, name, libtype)
>          node.value += 1
>  
> -    def get_report_header(self):
> +    def get_report_header(self) -> str:
>          if self.args.input == "-":
>              # when this script is invoked with "perf script flamegraph",
>              # no perf.data is created and we cannot read the header of it
> @@ -131,7 +131,8 @@ class FlameGraphCLI:
>              # if the file name other than perf.data is given,
>              # we read the header of that file
>              if self.args.input:
> -                output = subprocess.check_output(["perf", "report", "--header-only", "-i", self.args.input])
> +                output = subprocess.check_output(["perf", "report", "--header-only",
> +                                                  "-i", self.args.input])
>              else:
>                  output = subprocess.check_output(["perf", "report", "--header-only"])
>  
> @@ -140,10 +141,10 @@ class FlameGraphCLI:
>                  result += "\nFocused event: " + self.args.event_name
>              return result
>          except Exception as err:  # pylint: disable=broad-except
> -            print("Error reading report header: {}".format(err), file=sys.stderr)
> +            print(f"Error reading report header: {err}", file=sys.stderr)
>              return ""
>  
> -    def trace_end(self):
> +    def trace_end(self) -> None:
>          stacks_json = json.dumps(self.stack, default=lambda x: x.to_json())
>  
>          if self.args.format == "html":
> @@ -167,7 +168,8 @@ graph template (--template PATH) or use another output format (--format
>  FORMAT).""",
>                                file=sys.stderr)
>                          if self.args.input == "-":
> -                            print("""Not attempting to download Flame Graph template as script command line
> +                            print(
> +"""Not attempting to download Flame Graph template as script command line
>  input is disabled due to using live mode. If you want to download the
>  template retry without live mode. For example, use 'perf record -a -g
>  -F 99 sleep 60' and 'perf script report flamegraph'. Alternatively,
> @@ -176,37 +178,40 @@ https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-b
>  and place it at:
>  /usr/share/d3-flame-graph/d3-flamegraph-base.html""",
>                                    file=sys.stderr)
> -                            quit()
> +                            sys.exit(1)
>                          s = None
> -                        while s != "y" and s != "n":
> -                            s = input("Do you wish to download a template from cdn.jsdelivr.net? (this warning can be suppressed with --allow-download) [yn] ").lower()
> +                        while s not in ["y", "n"]:
> +                            s = input("Do you wish to download a template from cdn.jsdelivr.net?" +
> +                                      "(this warning can be suppressed with --allow-download) [yn] "
> +                                      ).lower()
>                          if s == "n":
> -                            quit()
> -                    template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
> +                            sys.exit(1)
> +                    template = ("https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/"
> +                                "d3-flamegraph-base.html")
>                      template_md5sum = "143e0d06ba69b8370b9848dcd6ae3f36"
>  
>              try:
> -                with urllib.request.urlopen(template) as template:
> +                with urllib.request.urlopen(template) as url_template:
>                      output_str = "".join([
> -                        l.decode("utf-8") for l in template.readlines()
> +                        l.decode("utf-8") for l in url_template.readlines()
>                      ])
>              except Exception as err:
>                  print(f"Error reading template {template}: {err}\n"
>                        "a minimal flame graph will be generated", file=sys.stderr)
> -                output_str = minimal_html
> +                output_str = MINIMAL_HTML
>                  template_md5sum = None
>  
>              if template_md5sum:
>                  download_md5sum = hashlib.md5(output_str.encode("utf-8")).hexdigest()
>                  if download_md5sum != template_md5sum:
>                      s = None
> -                    while s != "y" and s != "n":
> +                    while s not in ["y", "n"]:
>                          s = input(f"""Unexpected template md5sum.
>  {download_md5sum} != {template_md5sum}, for:
>  {output_str}
>  continue?[yn] """).lower()
>                      if s == "n":
> -                        quit()
> +                        sys.exit(1)
>  
>              output_str = output_str.replace("/** @options_json **/", options_json)
>              output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
> @@ -220,12 +225,12 @@ continue?[yn] """).lower()
>              with io.open(sys.stdout.fileno(), "w", encoding="utf-8", closefd=False) as out:
>                  out.write(output_str)
>          else:
> -            print("dumping data to {}".format(output_fn))
> +            print(f"dumping data to {output_fn}")
>              try:
>                  with io.open(output_fn, "w", encoding="utf-8") as out:
>                      out.write(output_str)
>              except IOError as err:
> -                print("Error writing output file: {}".format(err), file=sys.stderr)
> +                print(f"Error writing output file: {err}", file=sys.stderr)
>                  sys.exit(1)
>  
>  
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
