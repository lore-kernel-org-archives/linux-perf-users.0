Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6B23A5432
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157478; cv=none; b=ZvhO2h9P+uVwQeyDUh0qzWZQOB7YVLduqS2d4b2zqlFJfF6CPjFZkRXLOZfGh/eBYoev3ye77o3RpHRHZXjfvqw4bnoqWUl+rooLP37jGYE8HEa6OxGgBCjAdMHgfKKhM9PkRMdVBZX6+i7iR3O9dC/EcM+SbnzHcaAi6yQlZ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157478; c=relaxed/simple;
	bh=4/G4WOpWLeIY4Q1/giU7GTp/xIECo8qdANOUyVELEPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fFBhLw/+U4IIIP7UBmAxlx9OQ9yp7I+NMPqA1BeoZoFPsN7oDWRJ4xRsbQnedxOE9c50ySBMtqK7FhQ+JJdkgH/8bNuEwIo7ZjlGjhUMEziCo/prTscTrNt2QS/I0nlldBRi7fBi8ZKBaDSxV2760CxnNiUS4uwEK0stm5bcEUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmq9VulB; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmq9VulB"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d889997495so23992404eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157475; x=1777762275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=efNil+PNmmmvTcZKEec15sBNEnsydHEhEYd+ZnlvuZ8=;
        b=qmq9VulBdBFM/9W8z8q8r0EjIMgs2o4mVL5PDo4URTd2aeOotyZUSwn4N7qaPPDhL1
         e0V4zpuF6tcFf2IJJzlA3DlXZen0QsIHW2oWGldNsNRKbOlGE3/4p9AWLui2vihtKj9c
         A2uo5N2RyIHkBCtYk0jiXowsskLE79ZzXy16CyhYh37uYoQLJDZsiRXrciAhgpe7mFYG
         v4fqEL5ZGWoqT+BctJBp8obgMEJeKqbnBb7/cluFp+SVro6QLwbolVLd8efZcZ8jerA/
         8aRp5YQyLrcBbKzxnLbePVT40KgyWK3hbxrIlLtzB43hd2e1KZwQ7vUd7wbNhouSc/pH
         V0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157475; x=1777762275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efNil+PNmmmvTcZKEec15sBNEnsydHEhEYd+ZnlvuZ8=;
        b=p0+8XgBfP296o0m+2bnyDNQnp16LYhIoZZ6VEvuo7UetDcNbZldq4ofkGpkipXx75s
         J5fSNwF80B/YLj/4fxIh4B5GfQkaSQmkh9nr3IknxX/n7DKeLD/+JclG9ZYelEfgpfWu
         Cum1u4mJyYrL4zytEj5NRw+j0N8ejuTXBAR8XmU4eFEHqR/xwvqOUEMh/IPwllDDOzZa
         7KQQN611m8h7b4yCBTUcrylblCaMuC0dwjZa2TXk4Qe9fLgzcEs/KYCUi+VF59bqCI9s
         vU1jAKwO8PNrtSBWPLyT4uzQYcl9CihgtbOZqKSZd3+MphuDJYqo2RCYHX6BACa33nLW
         LA5w==
X-Forwarded-Encrypted: i=1; AFNElJ+u26ThjcID21cpaSTYVV8RPQyZ9Ahcq1ACjRQvfOWom3+J2JnnzOcj/jbl8v617OZHRrlmfNCLpXi6y6ROSQc2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyje0XP8uue+k+oCq7x2aBFTE16V+ZoeNruXwow9XEw2yqU5DS3
	rybszp3+3uj51xUcQHTdn42gW0pmqRyuDWSHber5LJJHdjiGDWrbFBWCvTJpoLlEBU2x1paRMhs
	oHeri1rQOzA==
X-Received: from dycf28.prod.google.com ([2002:a05:7300:50dc:b0:2d9:6c52:c24a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4186:b0:2de:cc07:e99
 with SMTP id 5a478bee46e88-2e464dafc4cmr18867631eec.7.1777157475156; Sat, 25
 Apr 2026 15:51:15 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:22 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-31-irogers@google.com>
Subject: [PATCH v7 30/59] perf flamegraph: Port flamegraph to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a port of the flamegraph script that uses the perf python module
directly. This approach improves performance by avoiding intermediate
dictionaries for event fields.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v5:
1. Fix Event Filtering: Corrected event filtering check to search for a
   substring match within the parsed event string, preventing all events
   from being dropped due to the `evsel(...)` wrapper.

v6:
- Fixed terminal injection risk by not printing unverified content in
  prompt.
---
 tools/perf/python/flamegraph.py | 250 ++++++++++++++++++++++++++++++++
 1 file changed, 250 insertions(+)
 create mode 100755 tools/perf/python/flamegraph.py

diff --git a/tools/perf/python/flamegraph.py b/tools/perf/python/flamegraph.py
new file mode 100755
index 000000000000..b0eb5844b772
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
+        if self.args.event_name and self.args.event_name not in str(sample.evsel):
+            return
+
+        pid = sample.sample_pid
+        dso_type = ""
+        try:
+            thread = self.session.find_thread(sample.sample_tid)
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
+{template}
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

