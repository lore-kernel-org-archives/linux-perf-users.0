Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE471495042
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187238; cv=none; b=u3GcuW26aUJ3W/qMbXmI4d0ZcIvrN5IeMg+G6OxlsaZlcA+XTYKPFqfBLzuYAw16HSl2Qe+mWfivkxFNTz4C+euJl0/QtMa7v9Y4LrODw6UFlMiQaiNvsSeesmq5KXzMB9iZ2a0YADv2O+JD/VthgWgS2bAc2EUGnq4O16/FUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187238; c=relaxed/simple;
	bh=PCoZS4hYLNKyS2/J0zNmrX67ReirwGEQHba41+qzYdI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NB6zOdrrnHR+/vL0KwvkluhjcfvMSJ/ssg1WLEunG4gixGstwkaekJOWwfgHCllGjwhQRD4CpQd5Z5aejNpHu5nKrqGOaIJqPfw7tNxfbp5iEImi0DMOg6/5jE40/tQYcnOmufPJqtFu3oLdnxxR09fkGyxfkYQyGpZL4XaEe6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IbPbFp/6; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IbPbFp/6"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1438fef603cso2364788c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187224; x=1790792024; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e8ZzEnXiAriAz3I2b2+FYE+wrUl61cx7qAsXLfK/CdM=;
        b=IbPbFp/6nMDpQ29Vmicz7a7ArJqhf059kJ7vDJrhatqHxJ6zI2Xh0X5x/LzVwhBekT
         uun+G/fD7bGXRlofAXVg5hrEMU/vE8+q7hCJlufGHgoqFm5KX71Yt7lTd4A/W1GvHi2Q
         hwFwQyKj65P+wLv6CCEasgMAX2AIhHuNl3WgaapBXEhzctjLxTCFDhTXcARawD20Mw6e
         xbCvmHRj90bPOZ21FWdpec25AUw2HpE/SgOFCWfRotLRJLECC3heIRKHbwjTE5FZkfqa
         Gh+X+rYyE1wt2x0Y1wyEVmVl4JCr2AYDiq7qAMJdgAFLzvnyl4R3j/3yw9rdgdfsVzRP
         g8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187224; x=1790792024;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e8ZzEnXiAriAz3I2b2+FYE+wrUl61cx7qAsXLfK/CdM=;
        b=o2dbMoQyzvYGTsymUvMjGq+wEaHdpkCNXO0w8C7IU8AigdqYfKZvQ4BoFSg9hUqYqV
         5lrL54/M+FFuJcuKA+mWvxHWQ3MDvFFqtEmuBjg5WT0EKCjCDn+ocLTSLSKZLQhSDXLR
         DzzqNJVVlkMJ5P1E/pREh5jNp1yGNRNNV1vgqA3zfajXGiDnLHB7jPONpaxyyJvcVArQ
         VhjHapSCJ16AfTDnLS1Xg9bS2W5fAwQNlquzhfDt1FXOYKNzsqSXIRA/qpBzV1TNg8aL
         ZhAKnEJ8apFIIqeCel9OY/l/csh2jsNb8j7HUmpTyaGUr60OEpudEB6z3fJo2VBFMlMG
         CJ3Q==
X-Forwarded-Encrypted: i=1; AKwUvBy/GlSvMZnpWKvoDMCMD2f+wFCFzrNgifrlUOHB7DuTvJGFNMSpRA1Vux7kEBd0b/Q8TwEZWCjY1y7C3pVbXAy3@vger.kernel.org
X-Gm-Message-State: AFuF++kiLYxeaLK4pkW4PeUxBVFYZkXcUYtkaI2UWfco7C7wzw4TMYS5
	bI/ShlULivfZWQudbMaSiZi0a/03LBBfs5C5foge5b1gZZJivuaDFohOpmkqkpLD/zStew3yGUS
	+/ig8sYrNhg==
X-Received: from dlbox9.prod.google.com ([2002:a05:7022:1209:b0:144:f706:dbd4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f51c:b0:144:c127:dd1a
 with SMTP id a92af1059eb24-144f9193f01mr3178179c88.38.1790187223661; Wed, 23
 Sep 2026 11:13:43 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:42 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-20-irogers@google.com>
Subject: [PATCH v3 19/49] perf python: Port flamegraph to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port flamegraph.py to a standalone script in tools/perf/python/ that
uses the perf module directly, avoiding intermediate dictionary
allocations for event fields.

Improvements compared to the legacy script:
- Add Subresource Integrity (integrity="sha256-...") and
  crossorigin="anonymous" attributes to external CDN stylesheet and
  script tags in MINIMAL_HTML.
- Upgrade CDN HTML template hash verification from weak MD5
  (hashlib.md5) to cryptographic SHA-256 (hashlib.sha256).
- Escape '<', '>', and '&' ('\u003c', '\u003e', '\u0026') in embedded
  JSON payloads (stacks_json and options_json) to prevent HTML script
  injection / XSS when rendering untrusted symbol or command names.
- Skip invoking 'perf report --header-only' when the input is stdin
  ('-'), a FIFO pipe, or a character device (S_ISFIFO / S_ISCHR) so
  non-seekable streams do not hang or fail.

Add a shell test (test_flamegraph_python.sh) to verify the standalone
script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/flamegraph.py               | 283 ++++++++++++++++++
 .../tests/shell/test_flamegraph_python.sh     | 110 +++++++
 2 files changed, 393 insertions(+)
 create mode 100755 tools/perf/python/flamegraph.py
 create mode 100755 tools/perf/tests/shell/test_flamegraph_python.sh

diff --git a/tools/perf/python/flamegraph.py b/tools/perf/python/flamegraph.py
new file mode 100755
index 000000000000..1b06a11fa86c
--- /dev/null
+++ b/tools/perf/python/flamegraph.py
@@ -0,0 +1,283 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+flamegraph.py - create flame graphs from perf samples using perf python module
+"""
+from __future__ import annotations
+
+import argparse
+import hashlib
+import json
+import os
+import re
+import subprocess
+import sys
+import urllib.request
+from typing import Dict, Optional, Union
+import perf
+
+MINIMAL_HTML = """<head>
+  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css" integrity="sha256-fXXWjLZigZo3QBJIhjEA3Z2zUfS+vzMQhF2Rlvurfio=" crossorigin="anonymous">
+</head>
+<body>
+  <div id="chart"></div>
+  <script type="text/javascript" src="https://d3js.org/d3.v7.js" integrity="sha256-DA1YviEGwU4kL8dbwJoXRngAYwdRWAZl9ulVKgwGTqI=" crossorigin="anonymous"></script>
+  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js" integrity="sha256-GEbx5jbtG9LDL8h9HiTWOv9+Txhim0u9gZNR8J6iI1M=" crossorigin="anonymous"></script>
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
+            thread = self.session.find_thread(sample.sample_pid, sample.sample_tid)
+            comm = (thread.comm() if thread else None) or "[unknown]"
+        except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError):
+            comm = "[unknown]"
+
+        if pid == 0:
+            comm = comm if comm != "[unknown]" else "swapper"
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
+            name = (sample.symbol or '[unknown]')
+            libtype = self.get_libtype_from_dso((sample.dso or '[unknown]'))
+            node = self.find_or_create_node(node, name, libtype)
+
+        node.value += 1
+
+    def get_report_header(self) -> str:
+        """Get the header from the perf report."""
+        try:
+            input_file = self.args.input or "perf.data"
+            if input_file == "-":
+                return ""
+            mode = os.stat(input_file).st_mode
+            import stat
+            if stat.S_ISFIFO(mode) or stat.S_ISCHR(mode):
+                return ""
+            output = subprocess.check_output(["perf", "report", "--header-only", "-i", input_file])
+            result = output.decode("utf-8")
+            if self.args.event_name:
+                result += "\nFocused event: " + self.args.event_name
+            return result
+        except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError,
+                subprocess.CalledProcessError):
+            return ""
+
+    def run(self) -> None:
+        """Run the flame graph generation."""
+        input_file = self.args.input or "perf.data"
+        if input_file != "-" and not os.path.exists(input_file):
+            print(f"Error: {input_file} not found. (try 'perf record' first)", file=sys.stderr)
+            sys.exit(1)
+
+        try:
+            self.session = perf.session(perf.data(input_file),
+                                        sample=self.process_event)
+        except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError) as e:
+            print(f"Error opening session: {e}", file=sys.stderr)
+            sys.exit(1)
+
+        try:
+            self.session.process_events()
+        finally:
+            # perf.session is a C extension type that holds a strong reference to the
+            # bound method self.process_event (which references self) and does not
+            # implement cyclic GC (tp_traverse). Explicitly clear self.session to break
+            # the reference cycle and free the underlying session resources deterministically.
+            self.session = None
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
+            template_sha256sum = None
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
+                        template_sha256sum = (
+                            "f6a4aa7edffda4fb9bd71eb0eb75bc44d0bb34cd9efbd053f6095bc5c28d702b"
+                        )
+                    else:
+                        template = None
+
+            use_minimal = False
+            try:
+                if not template:
+                    use_minimal = True
+                elif template.startswith(("http://", "https://")):
+                    with urllib.request.urlopen(template) as url_template:
+                        output_str = "".join([l.decode("utf-8") for l in url_template.readlines()])
+                else:
+                    with open(template, "r", encoding="utf-8") as f:
+                        output_str = f.read()
+            except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError) as err:
+                print(f"Error reading template {template}: {err}\n", file=sys.stderr)
+                use_minimal = True
+
+            if use_minimal:
+                print("Using internal minimal HTML that refers to d3's web site. JavaScript " +
+                      "loaded this way from a local file may be blocked unless your " +
+                      "browser has relaxed permissions. Run with '--allow-download' to fetch " +
+                      "the full D3 HTML template.", file=sys.stderr)
+                output_str = MINIMAL_HTML
+
+            elif template_sha256sum:
+                assert output_str is not None
+                download_sha256sum = hashlib.sha256(
+                    output_str.encode("utf-8")
+                ).hexdigest()
+                if download_sha256sum != template_sha256sum:
+                    s = None
+                    while s not in ["y", "n"]:
+                        try:
+                            s = input(f"""Unexpected template sha256sum.
+{download_sha256sum} != {template_sha256sum}, for:
+{template}
+continue?[yn] """).lower()
+                        except EOFError:
+                            s = "n"
+                    if s == "n":
+                        sys.exit(1)
+
+            assert output_str is not None
+            replacements = {
+                "/** @options_json **/": options_json,
+                "/** @flamegraph_json **/": stacks_json,
+            }
+            # Use a lambda replacement so re.sub does not interpret backslashes
+            # in the JSON strings (such as \n or \u003c) as regex escape sequences.
+            output_str = re.sub(
+                r"/\*\* @(?:options_json|flamegraph_json) \*\*/",
+                lambda m: replacements[m.group(0)],
+                output_str,
+            )
+            output_fn = self.args.output or "flamegraph.html"
+        else:
+            output_str = stacks_json
+            output_fn = self.args.output or "stacks.json"
+
+        if output_fn == "-":
+            with open(sys.stdout.fileno(), "w", encoding="utf-8", closefd=False) as out:
+                out.write(output_str)
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
diff --git a/tools/perf/tests/shell/test_flamegraph_python.sh b/tools/perf/tests/shell/test_flamegraph_python.sh
new file mode 100755
index 000000000000..3733d53b916b
--- /dev/null
+++ b/tools/perf/tests/shell/test_flamegraph_python.sh
@@ -0,0 +1,110 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# flamegraph python test
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+# If we don't have the perf python module, we can't test
+if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
+	echo "Skipping test, perf python module not found"
+	exit 2
+fi
+
+script_dir="$(dirname "$0")/../../python"
+script_path="${script_dir}/flamegraph.py"
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, flamegraph.py not found at $script_path"
+	exit 2
+fi
+
+err=0
+temp_data=""
+temp_json=""
+temp_html=""
+temp_tpl=""
+
+cleanup() {
+	rm -f "${temp_data}" "${temp_json}" "${temp_html}" "${temp_tpl}"
+}
+
+trap 'cleanup' EXIT TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+temp_json=$(mktemp /tmp/perf.flamegraph.json.XXXXXX)
+temp_html=$(mktemp /tmp/perf.flamegraph.html.XXXXXX)
+temp_tpl=$(mktemp /tmp/perf.flamegraph.tpl.XXXXXX)
+
+test_file_mode() {
+	echo "Testing flamegraph.py..."
+
+	# Generate some events with callchains
+	if ! perf record -g -o "${temp_data}" -- perf test -w noploop >/dev/null 2>&1; then
+		echo "Skipping test, perf record -g failed (permissions or lack of support)"
+		exit 2
+	fi
+
+	# Run the script, dump as json to temp_json (testing both file mode and pipe '-' mode)
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" -f json -o "${temp_json}" >/dev/null; then
+		echo "File mode JSON test failed."
+		err=1
+	elif ! perf record -g -o - -- perf test -w noploop 2>/dev/null | \
+		"$PYTHON" "$script_path" -i - -f json -o "${temp_json}" >/dev/null; then
+		echo "Pipe stdin JSON mode test failed."
+		err=1
+	else
+		# Validate JSON
+		if ! "$PYTHON" -m json.tool "${temp_json}" /dev/null >/dev/null 2>&1; then
+			echo "JSON validation failed."
+			err=1
+		elif ! "$PYTHON" -c "import json, sys
+d = json.load(open(sys.argv[1]))
+assert d.get('v', 0) > 0 or len(d.get('c', [])) > 0" "${temp_json}" >/dev/null 2>&1; then
+			echo "JSON flamegraph structure is empty."
+			err=1
+		else
+			echo "File and pipe mode JSON tests passed."
+		fi
+	fi
+
+	# Run the script, dump as html to temp_html using MINIMAL_HTML fallback
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" -f html \
+		--template /nonexistent/template.html -o "${temp_html}" >/dev/null 2>&1; then
+		echo "File mode HTML test failed."
+		err=1
+	else
+		if ! grep -q "<head>" "${temp_html}" || \
+		   ! grep -q 'crossorigin="anonymous"' "${temp_html}"; then
+			echo "HTML validation failed."
+			err=1
+		else
+			echo "File mode HTML test passed."
+		fi
+	fi
+
+	# Test custom local HTML template and --colorscheme option
+	cat << 'EOF' > "${temp_tpl}"
+<html><body><script>
+const opts = /** @options_json **/;
+const data = /** @flamegraph_json **/;
+</script></body></html>
+EOF
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" -f html --template "${temp_tpl}" \
+		--colorscheme blue-green -o "${temp_html}" >/dev/null 2>&1; then
+		echo "Custom template HTML test failed."
+		err=1
+	elif ! grep -q "blue-green" "${temp_html}"; then
+		echo "Custom template colorscheme substitution failed."
+		err=1
+	else
+		echo "Custom template HTML test passed."
+	fi
+}
+
+test_file_mode
+
+exit $err
-- 
2.56.0.rc1.310.g51773c2048-goog

