Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05D3E9295
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049333; cv=none; b=bSbT4qqXaxkZ1kz+rukl3hr/4uziu1U48aifJzcjAhdh++gHKmUt6IKAYzoaDEfPhPAparsWLzZGaovac7clph7V6/FKephK2IdO7tsWpduFwqmuCc6qmb/9CkrvPyvr9hNvQwp1Za1oepVbHcrJRqmG30xNc/NKIqX5a7Hk7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049333; c=relaxed/simple;
	bh=Oo6L+ce+16FOXnBcyDJloDoQI1Pk0mWh0Eu86kTdno4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R/lZLshedwPqmVUkzaBWciyDmJpm9He5qyP1EBfc2y2wPMhQ31yWFP+pFTWeW4PFn36INNS5E8OWO16BWAo3A4htS3cnxPhKkuUv12Fzen0NeJacEIUQLsUFlTx0hY2i4/0FdLRKT+y1/3TLG9KRd++uZGoR2awZ/C3udqDFTNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3AV1+Ci; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3AV1+Ci"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0ba59a830so12542590eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049329; x=1777654129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qIyMdvfEuVLSlCtK3ockYvp3dfRKOH458jee3KpqxRs=;
        b=g3AV1+Ci3hLRHqafmFMspBxkDJgpcvqhKyYi5CEtBuG96B80yNSokHx/AbpHXsI75B
         4Yd+SkA6OuYUARpDZZz3gjqtJC+EDF0YG0ykWrsWyk//nKEHX5gQ+KxbgMOIMdzfo38R
         llhZEuww/tzeBhDuMPoYAmLUWgM9n2nRzeORPYhYgKlIKwfg6BSgmREdFajKf1luYvHK
         ZfEIy00F7Z62hoE/wxoKAfVkI7o1EfGPNAaU1LJq2TQbx3xJ0gBPUNquSg/AJWZy8htn
         UYobgGeHGOhPVKe8q0aWanv/828YAIn1yFb2FR3tmCZpPnK3omtXdy5PBZ0TFXolVnh2
         18ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049329; x=1777654129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIyMdvfEuVLSlCtK3ockYvp3dfRKOH458jee3KpqxRs=;
        b=q8VTwVETSVzWTC+pX1QbHm8JYnNua+Dj4BOU+XxK7IJ4Yiq0V4gbtpb2quhPx1Jje0
         kr4Za9S+lZ0ZtvhdqbtqhdiFEcHZW8rNntMF4BBWdWcZmMxnzXshfk5DEwHde79MFJnO
         JrBqWS2jI4hpdx7vSdHuJQIO5IM4j8JfhRnO/9Pr1UhMj0AgrmIUgMhV48zILOD9d9YU
         j96v0X4bNpQb6ppwD1/ikOs1qlLL4TJOIWmgUX6waQ4MPHXp9SxarNbt8/z6WdK1A5IH
         /uswakk0JITWxJYAnT7nxiltUL3o52OHDop83pKA3SHGIVAiToHtFGg8uCCO51hs9sRD
         Qs0w==
X-Forwarded-Encrypted: i=1; AFNElJ8fb91XvBKu+fsAy5HywE0EwMToKGil6T1yalo2GwA1AeMtVoCGBnWhd6/YZ6Jh/m8fk8LvAJCXWJ2ZyrGojpeW@vger.kernel.org
X-Gm-Message-State: AOJu0Yybo+zBNjZQbMrFCAtHctuiRyNNRahNgGkBypWYcKXZRuOyqIWG
	mhk0/4cAj3RhGgPlMryKlPDhxyGe3EQpErBTKy9UGEA93uur7xJlIOHivFtAdXp958sgZkVpHch
	ZYYKsD7roiQ==
X-Received: from dybfe3.prod.google.com ([2002:a05:7300:bf83:b0:2e6:1dc6:691e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:168a:b0:2d1:815f:19c1
 with SMTP id 5a478bee46e88-2e479c0427dmr15813370eec.15.1777049329006; Fri, 24
 Apr 2026 09:48:49 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:52 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-31-irogers@google.com>
Subject: [PATCH v5 30/58] perf flamegraph: Port flamegraph to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a port of the flamegraph script that uses the perf python module
directly. This approach is significantly faster than using perf script
callbacks as it avoids creating intermediate dictionaries for all
event fields.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Performance Optimization: Changed Node.children from a list to a
   dictionary, reducing the lookup time in find_or_create_node from
   O(N) to O(1) and avoiding performance bottlenecks on wide call
   graphs.

2. Callchain Fallback: Added a fallback to use the sample's top-level
   symbol or instruction pointer if no callchain is present, ensuring
   the script still generates meaningful output rather than just
   process names.

3. Template Downloading Fix: Corrected the logic handling the
   --allow-download flag and custom HTTP URLs. It no longer warns
   about missing local files when a URL is provided, and won't
   silently overwrite custom URLs with the default one.

4. Output Stream Separation: Moved informational warnings to
   sys.stderr to prevent them from corrupting the resulting HTML/JSON
   file when the user streams the output to stdout (e.g., using -o -
   ).

5. XSS Protection: Added basic HTML entity escaping for < , > , and &
   within the embedded JSON data blocks. This mitigates the risk of
   cross-site scripting if trace data contains maliciously formed
   process or symbol names.
---
 tools/perf/python/flamegraph.py | 250 ++++++++++++++++++++++++++++++++
 1 file changed, 250 insertions(+)
 create mode 100755 tools/perf/python/flamegraph.py

diff --git a/tools/perf/python/flamegraph.py b/tools/perf/python/flamegraph.py
new file mode 100755
index 000000000000..f3f69e5a88c2
--- /dev/null
+++ b/tools/perf/python/flamegraph.py
@@ -0,0 +1,250 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+flamegraph.py - create flame graphs from perf samples using perf python module
+"""
+
+import argparse
+import hashlib
+import json
+import os
+import subprocess
+import sys
+import urllib.request
+from typing import Dict, Optional, Union
+import perf
+
+MINIMAL_HTML = """<head>
+  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
+</head>
+<body>
+  <div id="chart"></div>
+  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
+  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
+  <script type="text/javascript">
+  const stacks = [/** @flamegraph_json **/];
+  // Note, options is unused.
+  const options = [/** @options_json **/];
+
+  var chart = flamegraph();
+  d3.select("#chart")
+        .datum(stacks[0])
+        .call(chart);
+  </script>
+</body>
+"""
+
+class Node:
+    """A node in the flame graph tree."""
+    def __init__(self, name: str, libtype: str):
+        self.name = name
+        self.libtype = libtype
+        self.value: int = 0
+        self.children: dict[str, Node] = {}
+
+    def to_json(self) -> Dict[str, Union[str, int, list[Dict]]]:
+        """Convert the node to a JSON-serializable dictionary."""
+        return {
+            "n": self.name,
+            "l": self.libtype,
+            "v": self.value,
+            "c": [x.to_json() for x in self.children.values()]
+        }
+
+
+class FlameGraphCLI:
+    """Command-line interface for generating flame graphs."""
+    def __init__(self, args):
+        self.args = args
+        self.stack = Node("all", "root")
+        self.session = None
+
+    @staticmethod
+    def get_libtype_from_dso(dso: Optional[str]) -> str:
+        """Determine the library type from the DSO name."""
+        if dso and (dso == "[kernel.kallsyms]" or dso.endswith("/vmlinux") or dso == "[kernel]"):
+            return "kernel"
+        return ""
+
+    @staticmethod
+    def find_or_create_node(node: Node, name: str, libtype: str) -> Node:
+        """Find a child node with the given name or create a new one."""
+        if name in node.children:
+            return node.children[name]
+        child = Node(name, libtype)
+        node.children[name] = child
+        return child
+
+    def process_event(self, sample) -> None:
+        """Process a single perf sample event."""
+        if self.args.event_name and str(sample.evsel) != self.args.event_name:
+            return
+
+        pid = sample.sample_pid
+        dso_type = ""
+        try:
+            thread = self.session.process(sample.sample_tid)
+            comm = thread.comm()
+        except Exception:
+            comm = "[unknown]"
+
+        if pid == 0:
+            comm = "swapper"
+            dso_type = "kernel"
+        else:
+            comm = f"{comm} ({pid})"
+
+        node = self.find_or_create_node(self.stack, comm, dso_type)
+
+        callchain = sample.callchain
+        if callchain:
+            # We want to traverse from root to leaf.
+            # perf callchain iterator gives leaf to root.
+            # We collect them and reverse.
+            frames = list(callchain)
+            for entry in reversed(frames):
+                name = entry.symbol or "[unknown]"
+                libtype = self.get_libtype_from_dso(entry.dso)
+                node = self.find_or_create_node(node, name, libtype)
+        else:
+            # Fallback if no callchain
+            name = getattr(sample, "symbol", "[unknown]")
+            libtype = self.get_libtype_from_dso(getattr(sample, "dso", "[unknown]"))
+            node = self.find_or_create_node(node, name, libtype)
+
+        node.value += 1
+
+    def get_report_header(self) -> str:
+        """Get the header from the perf report."""
+        try:
+            input_file = self.args.input or "perf.data"
+            output = subprocess.check_output(["perf", "report", "--header-only", "-i", input_file])
+            result = output.decode("utf-8")
+            if self.args.event_name:
+                result += "\nFocused event: " + self.args.event_name
+            return result
+        except Exception:
+            return ""
+
+    def run(self) -> None:
+        """Run the flame graph generation."""
+        input_file = self.args.input or "perf.data"
+        if not os.path.exists(input_file):
+            print(f"Error: {input_file} not found. (try 'perf record' first)", file=sys.stderr)
+            sys.exit(1)
+
+        try:
+            self.session = perf.session(perf.data(input_file),
+                                        sample=self.process_event)
+        except Exception as e:
+            print(f"Error opening session: {e}", file=sys.stderr)
+            sys.exit(1)
+
+        self.session.process_events()
+
+        stacks_json = json.dumps(self.stack, default=lambda x: x.to_json())
+        # Escape HTML special characters to prevent XSS
+        stacks_json = stacks_json.replace("<", "\\u003c") \
+            .replace(">", "\\u003e").replace("&", "\\u0026")
+
+        if self.args.format == "html":
+            report_header = self.get_report_header()
+            options = {
+                "colorscheme": self.args.colorscheme,
+                "context": report_header
+            }
+            options_json = json.dumps(options)
+            options_json = options_json.replace("<", "\\u003c") \
+                .replace(">", "\\u003e").replace("&", "\\u0026")
+
+            template = self.args.template
+            template_md5sum = None
+            output_str = None
+
+            if not os.path.isfile(template):
+                if template.startswith("http://") or template.startswith("https://"):
+                    if not self.args.allow_download:
+                        print("Warning: Downloading templates is disabled. "
+                              "Use --allow-download.", file=sys.stderr)
+                        template = None
+                else:
+                    print(f"Warning: Template file '{template}' not found.", file=sys.stderr)
+                    if self.args.allow_download:
+                        print("Using default CDN template.", file=sys.stderr)
+                        template = (
+                            "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/"
+                            "d3-flamegraph-base.html"
+                        )
+                        template_md5sum = "143e0d06ba69b8370b9848dcd6ae3f36"
+                    else:
+                        template = None
+
+            use_minimal = False
+            try:
+                if not template:
+                    use_minimal = True
+                elif template.startswith("http"):
+                    with urllib.request.urlopen(template) as url_template:
+                        output_str = "".join([l.decode("utf-8") for l in url_template.readlines()])
+                else:
+                    with open(template, "r", encoding="utf-8") as f:
+                        output_str = f.read()
+            except Exception as err:
+                print(f"Error reading template {template}: {err}\n", file=sys.stderr)
+                use_minimal = True
+
+            if use_minimal:
+                print("Using internal minimal HTML that refers to d3's web site. JavaScript " +
+                      "loaded this way from a local file may be blocked unless your " +
+                      "browser has relaxed permissions. Run with '--allow-download' to fetch" +
+                      "the full D3 HTML template.", file=sys.stderr)
+                output_str = MINIMAL_HTML
+
+            elif template_md5sum:
+                assert output_str is not None
+                download_md5sum = hashlib.md5(output_str.encode("utf-8")).hexdigest()
+                if download_md5sum != template_md5sum:
+                    s = None
+                    while s not in ["y", "n"]:
+                        s = input(f"""Unexpected template md5sum.
+{download_md5sum} != {template_md5sum}, for:
+{output_str}
+continue?[yn] """).lower()
+                    if s == "n":
+                        sys.exit(1)
+
+            assert output_str is not None
+            output_str = output_str.replace("/** @options_json **/", options_json)
+            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
+            output_fn = self.args.output or "flamegraph.html"
+        else:
+            output_str = stacks_json
+            output_fn = self.args.output or "stacks.json"
+
+        if output_fn == "-":
+            sys.stdout.write(output_str)
+        else:
+            print(f"dumping data to {output_fn}")
+            with open(output_fn, "w", encoding="utf-8") as out:
+                out.write(output_str)
+
+
+if __name__ == "__main__":
+    parser = argparse.ArgumentParser(description="Create flame graphs using perf python module.")
+    parser.add_argument("-f", "--format", default="html", choices=["json", "html"],
+                        help="output file format")
+    parser.add_argument("-o", "--output", help="output file name")
+    parser.add_argument("--template",
+                        default="/usr/share/d3-flame-graph/d3-flamegraph-base.html",
+                        help="path to flame graph HTML template")
+    parser.add_argument("--colorscheme", default="blue-green",
+                        help="flame graph color scheme", choices=["blue-green", "orange"])
+    parser.add_argument("-i", "--input", help="input perf.data file")
+    parser.add_argument("--allow-download", default=False, action="store_true",
+                        help="allow unprompted downloading of HTML template")
+    parser.add_argument("-e", "--event", default="", dest="event_name", type=str,
+                        help="specify the event to generate flamegraph for")
+
+    cli_args = parser.parse_args()
+    cli = FlameGraphCLI(cli_args)
+    cli.run()
-- 
2.54.0.545.g6539524ca2-goog

