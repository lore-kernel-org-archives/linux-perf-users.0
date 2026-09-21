Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED4373C12
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967280; cv=none; b=mW09gLZ4wwfoH0aZcBzYDtQ8ffA1uQmfpr7bLZY1dMsRSnc30W6as7+wWKIKIpyvUTMO7RMAUp/pSBzXrqZ8CZoNO9jkKPgwZH+p+mmOLGS8vzFl3dRps9tv+u0hhlKGaZy01XcC5V/Vtt6iNxDgO1D8Q11Q9LbmvFTMRhxTfR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967280; c=relaxed/simple;
	bh=dqdt4eL3NzLnDABJ2cbGc/7HH5eiTvPq+6ooxwTXkE8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=daarNygl6swnfqsai2TRbYPfqcFnCTXMpUkMfjzs0pX8ZPG/tDwXiWF8GPcHZTX4dWjfepVWYg4eFI2+JmiiqgzTBrJa0sQ5HK0xW0GYC7v+voPSaHnYq3Og9cOCbEdsQ3YnGyuuVwIY3Tns+tvZ5FdqPcVNjxW9EbaoefjRBVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lazQWoG5; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lazQWoG5"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dd753a52bbso49970375ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967277; x=1790572077; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CG7kdFvi3buwFTk5R1qSip6zpPmYYM+n3ZmiEScrVOg=;
        b=lazQWoG5+dzJwNneVWXe9kMzoDcF05oiQDqFG2+I47TU5jmmtXi/HicigmXyU+Bo00
         b/XGLrW0bUIEVVkJb4T8PK43trAxEJffsM9mYaGeCtNsKCIctYz65iz89hMlxn5s/Q5y
         OafIni6gd9EGEffKtpeHhEk6i08611eTlncOlhZxD4pOE+nwFWrmu8SqYw2B4Lr6S8uG
         3HuYWXFZAn1W/biG4MC04CrT34wiOL4EDhcOJIfXWF6ewkQlbbz3CkHO/I2Y98m41CT6
         EQkQ+M8+MFeBiq6CGFy45U72/w6wYzqkpfyRrkepIAG/5mGiLoyYpS68jOQHrAukr1/8
         Y+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967277; x=1790572077;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CG7kdFvi3buwFTk5R1qSip6zpPmYYM+n3ZmiEScrVOg=;
        b=qw3jTcDxxCCCJ8f7DHSyouRl1GTcKPTuVN/E7BOeYCO4cJd8sD8QLawg5efEWDASRY
         vIu/TszbNAOZyoJaKW5DHRSyCsaYV1z1jCVmJTxsnOgwG3VF35bRP4LIS1YLNXp8GXTL
         JLX8quaETOEgNz4Hbtyk86RckcCPD/d77obYtF/J4ZY9CgjDF+6mwNJ86fSMsVjMkr/+
         WWmuIiBbn0p9RAVrpMWIPD/J5Jyz445E/OPdKSwLvw2s63cmGet63/aa4wqvct14I5HU
         OZBgyqZ8iMDeyxipVm1qGHmpbuOBqnLaVs42tdR6jU9cDzyQNrLCuETarUQiYpOTDvgz
         Dadw==
X-Forwarded-Encrypted: i=1; AKwUvBxxSUIOWHZXSra2q4sZx/ZcTs1WFotkxETqI+UKwZ1V7oNvqQJZs8qocXqx84iskkg59jLulrYd5QMnquh70MN5@vger.kernel.org
X-Gm-Message-State: AFuF++lf+fU1o72hMPWOeelOCmy13LgCFfpPES+liHMQMKJrlwKH7xYS
	Xd389B5P52YdNo+8K0dmjXce9EkbbPvdiTK44DLD+5XnEHNMZHhZN+ZAjDwDaMb6bURXos9OVFD
	HbIMCoGuGgA==
X-Received: from dldyr1-n2.prod.google.com ([2002:a05:701b:4501:20b0:144:c737:6f14])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380a:b0:39e:6a7f:1dc7
 with SMTP id 98e67ed59e1d1-39e6a7f224bmr9153764a91.35.1789967277157; Sun, 20
 Sep 2026 22:07:57 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:38 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <8af8c6b81a2fccae0cfb2fbf359e3ef65d8647ed.1789966896.git.irogers@google.com>
Subject: [PATCH v2 20/49] perf python: Port gecko to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port gecko.py to a standalone script in tools/perf/python/ that uses
the perf module directly to convert perf.data profiles into Firefox
Gecko profile format.

Improvements compared to the legacy script:
- Encapsulate profiler state in GeckoCLI and CategoryData classes with
  full type annotations, removing global variables.
- Harden the local HTTP server in _write_and_launch(): write the
  temporary profile to an isolated tempfile.TemporaryDirectory() with a
  randomized UUID filename instead of the current working directory,
  bind HTTPServer exclusively to 127.0.0.1 on an OS-assigned ephemeral
  port (0), restrict CORS Access-Control-Allow-Origin to
  'https://profiler.firefox.com' instead of '*', and restrict HTTP GET
  requests exclusively to the randomized profile filename (returning
  HTTP 403 for directory listings and any other path).
- Add -i/--input and -e/--event CLI options via argparse.

Add a shell test (test_gecko_python.sh) to verify the standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/gecko.py                  | 415 ++++++++++++++++++++
 tools/perf/tests/shell/test_gecko_python.sh |  95 +++++
 2 files changed, 510 insertions(+)
 create mode 100755 tools/perf/python/gecko.py
 create mode 100755 tools/perf/tests/shell/test_gecko_python.sh

diff --git a/tools/perf/python/gecko.py b/tools/perf/python/gecko.py
new file mode 100755
index 000000000000..d01f68825f90
--- /dev/null
+++ b/tools/perf/python/gecko.py
@@ -0,0 +1,415 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+gecko.py - Convert perf record output to Firefox's gecko profile format
+"""
+from __future__ import annotations
+
+import argparse
+import functools
+import json
+import os
+import sys
+import tempfile
+import threading
+import urllib.parse
+import uuid
+import webbrowser
+from dataclasses import dataclass, field
+from http.server import HTTPServer, SimpleHTTPRequestHandler
+from typing import Dict, List, NamedTuple, Optional, Tuple
+
+import perf
+
+
+# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L156
+class Frame(NamedTuple):
+    """A single stack frame in the gecko profile format."""
+    string_id: int
+    relevantForJS: bool
+    innerWindowID: int
+    implementation: None
+    optimizations: None
+    line: None
+    column: None
+    category: int
+    subcategory: Optional[int]
+
+
+# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L216
+class Stack(NamedTuple):
+    """A single stack in the gecko profile format."""
+    prefix_id: Optional[int]
+    frame_id: int
+
+
+# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L90
+class Sample(NamedTuple):
+    """A single sample in the gecko profile format."""
+    stack_id: Optional[int]
+    time_ms: float
+    responsiveness: int
+
+
+@dataclass
+class Tables:
+    """Interned tables for the gecko profile format."""
+    frame_table: List[Frame] = field(default_factory=list)
+    string_table: List[str] = field(default_factory=list)
+    string_map: Dict[str, int] = field(default_factory=dict)
+    stack_table: List[Stack] = field(default_factory=list)
+    stack_map: Dict[Tuple[Optional[int], int], int] = field(default_factory=dict)
+    frame_map: Dict[str, int] = field(default_factory=dict)
+
+
+@dataclass
+class Thread:
+    """A builder for a profile of the thread."""
+    comm: str
+    pid: int
+    tid: int
+    user_category: int
+    kernel_category: int
+    samples: List[Sample] = field(default_factory=list)
+    tables: Tables = field(default_factory=Tables)
+
+    def _intern_stack(self, frame_id: int, prefix_id: Optional[int]) -> int:
+        """Gets a matching stack, or saves the new stack. Returns a Stack ID."""
+        key = (prefix_id, frame_id)
+        stack_id = self.tables.stack_map.get(key)
+        if stack_id is None:
+            stack_id = len(self.tables.stack_table)
+            self.tables.stack_table.append(Stack(prefix_id=prefix_id, frame_id=frame_id))
+            self.tables.stack_map[key] = stack_id
+        return stack_id
+
+    def _intern_string(self, string: str) -> int:
+        """Gets a matching string, or saves the new string. Returns a String ID."""
+        string_id = self.tables.string_map.get(string)
+        if string_id is not None:
+            return string_id
+        string_id = len(self.tables.string_table)
+        self.tables.string_table.append(string)
+        self.tables.string_map[string] = string_id
+        return string_id
+
+    def _intern_frame(self, frame_str: str) -> int:
+        """Gets a matching stack frame, or saves the new frame. Returns a Frame ID."""
+        frame_id = self.tables.frame_map.get(frame_str)
+        if frame_id is not None:
+            return frame_id
+        frame_id = len(self.tables.frame_table)
+        self.tables.frame_map[frame_str] = frame_id
+        string_id = self._intern_string(frame_str)
+
+        category = self.user_category
+        if (frame_str.find('kallsyms') != -1 or
+                frame_str.find('/vmlinux') != -1 or
+                frame_str.endswith('.ko)')):
+            category = self.kernel_category
+
+        self.tables.frame_table.append(Frame(
+            string_id=string_id,
+            relevantForJS=False,
+            innerWindowID=0,
+            implementation=None,
+            optimizations=None,
+            line=None,
+            column=None,
+            category=category,
+            subcategory=None,
+        ))
+        return frame_id
+
+    def add_sample(self, comm: str, stack: List[str], time_ms: float) -> None:
+        """Add a timestamped stack trace sample to the thread builder."""
+        if self.comm != comm:
+            self.comm = comm
+
+        prefix_stack_id: Optional[int] = None
+        for frame in stack:
+            frame_id = self._intern_frame(frame)
+            prefix_stack_id = self._intern_stack(frame_id, prefix_stack_id)
+
+        if prefix_stack_id is not None:
+            self.samples.append(Sample(stack_id=prefix_stack_id,
+                                       time_ms=time_ms,
+                                       responsiveness=0))
+
+    def to_json_dict(self) -> Dict:
+        """Converts current Thread to GeckoThread JSON format."""
+        return {
+            "tid": self.tid,
+            "pid": self.pid,
+            "name": self.comm,
+            "markers": {
+                "schema": {
+                    "name": 0,
+                    "startTime": 1,
+                    "endTime": 2,
+                    "phase": 3,
+                    "category": 4,
+                    "data": 5,
+                },
+                "data": [],
+            },
+            "samples": {
+                "schema": {
+                    "stack": 0,
+                    "time": 1,
+                    "responsiveness": 2,
+                },
+                "data": self.samples
+            },
+            "frameTable": {
+                "schema": {
+                    "location": 0,
+                    "relevantForJS": 1,
+                    "innerWindowID": 2,
+                    "implementation": 3,
+                    "optimizations": 4,
+                    "line": 5,
+                    "column": 6,
+                    "category": 7,
+                    "subcategory": 8,
+                },
+                "data": self.tables.frame_table,
+            },
+            "stackTable": {
+                "schema": {
+                    "prefix": 0,
+                    "frame": 1,
+                },
+                "data": self.tables.stack_table,
+            },
+            "stringTable": self.tables.string_table,
+            "registerTime": 0,
+            "unregisterTime": None,
+            "processType": "default",
+        }
+
+
+class CORSRequestHandler(SimpleHTTPRequestHandler):
+    """Enable CORS for requests from profiler.firefox.com."""
+    def __init__(self, *args, allowed_file: Optional[str] = None, **kwargs):
+        self.allowed_file = allowed_file
+        super().__init__(*args, **kwargs)
+
+    def end_headers(self):
+        self.send_header('Access-Control-Allow-Origin', 'https://profiler.firefox.com')
+        super().end_headers()
+
+    def do_GET(self):
+        if self.allowed_file and self.path.split('?')[0] != f'/{self.allowed_file}':
+            self.send_error(403, "Access denied")
+            return
+        super().do_GET()
+
+    def list_directory(self, path):
+        self.send_error(403, "Directory listing forbidden")
+        return None
+
+
+@dataclass
+class CategoryData:
+    """Category configuration for the gecko profile."""
+    user_index: int = 0
+    kernel_index: int = 1
+    categories: List[Dict] = field(default_factory=list)
+
+
+class GeckoCLI:
+    """Command-line interface for converting perf data to Gecko format."""
+    def __init__(self, args: argparse.Namespace) -> None:
+        self.args = args
+        self.tid_to_thread: Dict[int, Thread] = {}
+        self.start_time_ms: Optional[float] = None
+        self.session: Optional[perf.session] = None
+        self.product = args.product
+        self.cat_data = CategoryData(
+            categories=[
+                {
+                    "name": 'User',
+                    "color": args.user_color,
+                    "subcategories": ['Other']
+                },
+                {
+                    "name": 'Kernel',
+                    "color": args.kernel_color,
+                    "subcategories": ['Other']
+                },
+            ]
+        )
+
+    def process_event(self, sample) -> None:
+        """Process a single perf sample event."""
+        if self.args.event_name and self.args.event_name not in str(sample.evsel):
+            return
+
+        # sample_time is in nanoseconds. Gecko wants milliseconds.
+        time_ms = sample.sample_time / 1000000.0
+        pid = sample.sample_pid
+        tid = sample.sample_tid
+
+        if self.start_time_ms is None:
+            self.start_time_ms = time_ms
+
+        try:
+            thread_info = self.session.find_thread(tid) if self.session else None
+            comm = (thread_info.comm() if thread_info is not None else None) or "[unknown]"
+        except AttributeError:
+            comm = "[unknown]"
+
+        stack = []
+        callchain = sample.callchain
+        if callchain:
+            for entry in callchain:
+                symbol = entry.symbol or "[unknown]"
+                dso = entry.dso or "[unknown]"
+                stack.append(f"{symbol} (in {dso})")
+            # Reverse because Gecko wants root first.
+            stack.reverse()
+        else:
+            # Fallback if no callchain is present
+            try:
+                # If the perf module exposes symbol/dso directly on sample
+                # when callchain is missing, we use them.
+                symbol = (sample.symbol or '[unknown]')
+                dso = (sample.dso or '[unknown]')
+                stack.append(f"{symbol} (in {dso})")
+            except AttributeError:
+                stack.append("[unknown] (in [unknown])")
+
+        thread = self.tid_to_thread.get(tid)
+        if thread is None:
+            thread = Thread(comm=comm, pid=pid, tid=tid,
+                            user_category=self.cat_data.user_index,
+                            kernel_category=self.cat_data.kernel_index)
+            self.tid_to_thread[tid] = thread
+        thread.add_sample(comm=comm, stack=stack, time_ms=time_ms)
+
+    def run(self) -> None:
+        """Run the conversion process."""
+        input_file = self.args.input or "perf.data"
+        if input_file != "-" and not os.path.exists(input_file):
+            print(f"Error: {input_file} not found.", file=sys.stderr)
+            sys.exit(1)
+
+        try:
+            self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        except (OSError, RuntimeError, ValueError) as e:
+            print(f"Error opening session: {e}", file=sys.stderr)
+            sys.exit(1)
+
+        if self.session:
+            try:
+                self.session.process_events()
+            finally:
+                self.session = None
+
+        threads = [t.to_json_dict() for t in self.tid_to_thread.values()]
+
+        gecko_profile = {
+            "meta": {
+                "interval": 1,
+                "processType": 0,
+                "product": self.product,
+                "stackwalk": 1,
+                "debug": 0,
+                "gcpoison": 0,
+                "asyncstack": 1,
+                "startTime": self.start_time_ms,
+                "shutdownTime": None,
+                "version": 24,
+                "presymbolicated": True,
+                "categories": self.cat_data.categories,
+                "markerSchema": [],
+            },
+            "libs": [],
+            "threads": threads,
+            "processes": [],
+            "pausedRanges": [],
+        }
+
+        output_file = self.args.save_only
+        if output_file is None:
+            self._write_and_launch(gecko_profile)
+        else:
+            print(f'[ perf gecko: Captured and wrote into {output_file} ]')
+            with open(output_file, 'w', encoding='utf-8') as f:
+                json.dump(gecko_profile, f, indent=2)
+
+    def _write_and_launch(self, profile: Dict) -> None:
+        """Write the profile to a file and launch the Firefox profiler."""
+        print("Starting Firefox Profiler on your default browser...")
+
+        with tempfile.TemporaryDirectory() as tmp_dir_name:
+            profile_name = f'gecko_profile_{uuid.uuid4().hex}.json'
+            filename = os.path.join(tmp_dir_name, profile_name)
+
+            with open(filename, 'w', encoding='utf-8') as f:
+                json.dump(profile, f, indent=2)
+
+            handler = functools.partial(
+                CORSRequestHandler, directory=tmp_dir_name, allowed_file=profile_name
+            )
+            try:
+                httpd = HTTPServer(('127.0.0.1', 0), handler)
+            except OSError as e:
+                print(f"Error starting HTTP server: {e}", file=sys.stderr)
+                sys.exit(1)
+
+            port = httpd.server_port
+
+            def start_server():
+                httpd.serve_forever()
+
+            thread = threading.Thread(target=start_server, daemon=True)
+            thread.start()
+
+            safe_string = urllib.parse.quote_plus(f'http://127.0.0.1:{port}/{profile_name}')
+            url = f'https://profiler.firefox.com/from-url/{safe_string}'
+            print(f"Please open the following URL in your browser to view the profile:\n\n{url}\n")
+            launch_html = os.path.join(tmp_dir_name, 'launch.html')
+            with open(launch_html, 'w', encoding='utf-8') as f:
+                f.write(f'<!DOCTYPE html><html><head>'
+                        f'<meta http-equiv="refresh" content="0;url={url}">'
+                        f'<script>window.location.replace({json.dumps(url)});</script>'
+                        f'</head><body>Redirecting to Firefox Profiler...</body></html>')
+            if not webbrowser.open(f'file://{launch_html}'):
+                print("Failed to open browser, please open the URL manually.")
+
+            print(f'[ perf gecko: Captured and wrote into {filename} ]')
+            print("Press Ctrl+C to stop the local server.")
+            try:
+                # Keep the main thread alive so the daemon thread can serve requests
+                stop_event = threading.Event()
+                while True:
+                    stop_event.wait(1)
+            except KeyboardInterrupt:
+                print("\nStopping server...")
+                httpd.shutdown()
+
+
+if __name__ == "__main__":
+    parser = argparse.ArgumentParser(
+        description="Convert perf.data to Firefox's Gecko Profile format"
+    )
+    parser.add_argument('--product', default='perf', help='Product name (e.g. perf)')
+    parser.add_argument('--user-color', default='yellow',
+                        help='Color for the User category',
+                        choices=['yellow', 'blue', 'purple', 'green', 'orange', 'red',
+                                 'grey', 'magenta'])
+    parser.add_argument('--kernel-color', default='orange',
+                        help='Color for the Kernel category',
+                        choices=['yellow', 'blue', 'purple', 'green', 'orange', 'red',
+                                 'grey', 'magenta'])
+    parser.add_argument('--save-only',
+                        help='Save the output to a file instead of opening Firefox\'s profiler')
+    parser.add_argument("-i", "--input", help="input perf.data file")
+    parser.add_argument("-e", "--event", default="", dest="event_name", type=str,
+                        help="specify the event to generate gecko profile for")
+
+    cli_args = parser.parse_args()
+    cli = GeckoCLI(cli_args)
+    cli.run()
diff --git a/tools/perf/tests/shell/test_gecko_python.sh b/tools/perf/tests/shell/test_gecko_python.sh
new file mode 100755
index 000000000000..eac9b2f8e3c7
--- /dev/null
+++ b/tools/perf/tests/shell/test_gecko_python.sh
@@ -0,0 +1,95 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# gecko python test
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
+script_path="${script_dir}/gecko.py"
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, gecko.py not found at $script_path"
+	exit 2
+fi
+
+err=0
+temp_data=""
+temp_json=""
+
+cleanup() {
+	rm -f "${temp_data}" "${temp_json}"
+}
+
+trap 'cleanup' EXIT TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+temp_json=$(mktemp /tmp/perf.gecko.json.XXXXXX)
+
+test_file_mode() {
+	echo "Testing gecko.py..."
+
+	# Generate some events with callchains
+	if ! perf record -g -o "${temp_data}" -- perf test -w noploop >/dev/null 2>&1; then
+		echo "Skipping test, perf record -g failed (permissions or lack of support)"
+		exit 2
+	fi
+
+	# Run the script in save-only mode with custom product and category colors
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" \
+		--product "perf-test-product" --user-color blue --kernel-color red \
+		--save-only "${temp_json}" >/dev/null; then
+		echo "File mode test failed."
+		err=1
+	else
+		# Validate JSON schema and custom CLI option values
+		if ! "$PYTHON" - "$script_path" "${temp_json}" << 'PYEOF'
+import importlib.util
+import json
+import sys
+
+with open(sys.argv[2], encoding="utf-8") as f:
+    data = json.load(f)
+
+assert data["meta"]["product"] == "perf-test-product"
+assert data["meta"]["version"] == 24
+assert isinstance(data["threads"], list) and len(data["threads"]) > 0
+
+spec = importlib.util.spec_from_file_location("gecko", sys.argv[1])
+mod = importlib.util.module_from_spec(spec)
+sys.modules[spec.name] = mod
+spec.loader.exec_module(mod)
+
+class DummyHandler:
+    headers = []
+    error_code = None
+    def send_header(self, k, v):
+        self.headers.append((k, v))
+    def send_error(self, code, _msg):
+        self.error_code = code
+
+dummy = DummyHandler()
+mod.CORSRequestHandler.list_directory(dummy, "/tmp")
+assert dummy.error_code == 403
+PYEOF
+		then
+			echo "Gecko JSON and CORSRequestHandler validation failed."
+			err=1
+		else
+			echo "File mode JSON and CORSRequestHandler test passed."
+		fi
+	fi
+}
+
+test_file_mode
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

