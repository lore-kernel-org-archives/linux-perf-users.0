Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921813ACA4A
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960674; cv=none; b=E5SgPelXpUoW6KDbXV0CcrgasNg73scAgdEkfCzhHm+m9MUnqUjBj9Q3VceGhUj8l5Yh93nrgYqEbmcnA7O1mf6lT5v3WT3v9cqUScNhVwevVcIW0ikp6AACLIawO5pM0KWhZP8B+Npf0bOrKhTeSE7MnfNB6NUdlpvvlXsMdgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960674; c=relaxed/simple;
	bh=aTJWP2en8u3aj8NVo9rSRz5H6tmLcD8c7RQ3dX5VpXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ft/9idZZgOid+z7BWJKdknuSLUosnSJqFzsPWz4zNVrrqALaCGeGEtbmmUUd2XztWKKoc/6LnnuUojRu7NkChgOHLjJIvEspmnEfq/n4CC5oqLBjPM/Ld7mLhjqUp0kY0ZwMJvqSH6qbryzZRedOjQOCfymZVjlYbRv1yvSyAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJH+mniB; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJH+mniB"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c20d5d7f4so31468808c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960671; x=1777565471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7bLQwsmlqVDpRTAl9gEsW6zXdb8CQSakza6w5XcFux0=;
        b=lJH+mniBuXIQBMlW365RGG9mCmAk9rrFS6hKl1c/Sj3kRq8Ir9F0QVwGLfA91YPUkd
         obXbk0j+2c9690lwb+xaYNU4dpJiFpu9EsAoSPbeQtWBiTWZHbVHaw8qVm4vC8dsRrfe
         ZzBHlJnuA5RSZqUehGZHuw3M6uJjyVqjbeCyMoTZ5jQPOAA6J7AUQ4q2obe5/jTpvy51
         2G4a/MMUmYmWkoLJ+L4uw4dQgABGSEPUJp4gTanyMDHlIC4J9NV6mKAPsi3qyzLS7HT7
         gkxNS8IW8YAlwnmMLpLKvfYtUZU2SuGd/60hT22/xvVcCiowiV3Mw1ut0e0yqIS/uOJt
         Jk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960671; x=1777565471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bLQwsmlqVDpRTAl9gEsW6zXdb8CQSakza6w5XcFux0=;
        b=De31942kkiP6rs4wV4KZZD2d19DqXasdrDFRmPIZc/lhcUdKetRUw65xqLO4JUuZi2
         EIkn80+BY6e+3NVpNJHueA+6aoL/ZNgtxlGrUpboeu+pbKQCpTs5Az1NqQMi03GZiHTB
         kWb+Riasg/WLllQ8p6hhteD6/6pz5VJ2LI+HEBhzRNqkJjkD1+7PnSIzadaNdALEITTw
         fwaOHhsmiPQGnQROEfJrlnWj3cQKIhApiv4srSQypXMB46RjMb2aB2suTDFflGH2ht+H
         9eFHP2/hOSiJsHspjEOr5TAePR8F+zAZ/ERLh+oHaQNk0l+lrTzjm/gOFXRt9ZgtwYxS
         AVLA==
X-Forwarded-Encrypted: i=1; AFNElJ9gYbVdR0I+9Ab/uZaGGUW8p36iANfTNnSC3zedwM6Urxjo3rC6MQYKfIyxQmfbjBD3oR8tIYAHevA2ZCmiThTn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe33uyPJMwuNAkZLNmcoLJQUKBnt3uDLWhAlLsd8OeNlPg8Gi8
	g6UDWZfDNjQsiOemYJxl51yRR9EtEphvlnzb09g3aQ7y80pi9Z1jHK4ExlEml4znCURYe+QwVWZ
	+iGaKJ1zU0Q==
X-Received: from dlbtu24.prod.google.com ([2002:a05:7022:3c18:b0:12c:3dfa:518e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:68d:b0:12a:6902:ddb8
 with SMTP id a92af1059eb24-12c73f683c5mr13678697c88.4.1776960670346; Thu, 23
 Apr 2026 09:11:10 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:36 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-30-irogers@google.com>
Subject: [PATCH v3 29/58] perf flamegraph: Port flamegraph to use python module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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
2.54.0.rc2.533.g4f5dca5207-goog

