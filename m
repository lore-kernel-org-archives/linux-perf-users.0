Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653BE39A7F5
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156957; cv=none; b=SACOWJhHq+zQ2Z3LTa7Ya4e7HL62fHYVTLa6w9VrTFqT+xJ2Q/ybarD224iziO28W0gGtx9zd62pr9okqJ9B9j4r4JeH0TQ3OWcJ13Q5AROxWWvhNZj5j6CgGHB2eIUzGJ0TiKMfyubDhjwgJnU5hAvePRIk4uU00ZUWttfffT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156957; c=relaxed/simple;
	bh=y2GLChekV4PMMYmANDUuSYZhvvMXHJinf6rXMFkaxwE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CufUFPKoGBVjMPIxCaj138sMrjqYUdMMNOuqpDdjLh9h+LOVSNbji8GRUArPhZ8++24cmqyYU8FqNNBXaAJnRhIXxCuS2dReNZ+h7Y0ZIsMXaiYgWau0/dSpwGPCr78ff6Bw1xsQlvaqhsBqF2Z+/ITHj6zzawSadjYOnRT0N4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N2C/cTXn; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2C/cTXn"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1273dfdaf5dso7499522c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156955; x=1777761755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NR1gzF3F6kI5f0yQJQV926hkNwQ4+t7RNPW4Qp/LJSM=;
        b=N2C/cTXnebbxXUtLYZE+/nQZydxYBOM+6KfNULU+Mw59FeK3XLos6OGgnm0p1wSQu5
         zbJxOaFCQyzjWDosRaXNnoOiYb4lk4Fj3Nkb0Tk/fz9hto9u0G7l5TND3x+JSvWzvQY+
         n9ByUk3qGgi9ILptHmwBnqykD3p4hS1FZtCHODTRRpZWAR9eyv+MHrECk4sd5P1QXJLx
         wfzlZb96HrNmDyKOIRMw1NNs6gSvM0zN4UOijrvsfG9pnuzAV+tHpEa0LRePD30gl9Ee
         4TGBD8D1uSPo8OsCfXIiEvPXlp4rnoceHxVhoDn8KeigN7qH1NBqeVC3HmVdIl0WZli5
         7+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156955; x=1777761755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NR1gzF3F6kI5f0yQJQV926hkNwQ4+t7RNPW4Qp/LJSM=;
        b=Z08mU7zNBAeFBaCMXL9R3gxa9J+qZ0i+tPaj0+JAsrfh99B9iZbXZUnN2ZzyrNvTXb
         Bj254e52xTRQBk+Z0RevQ6DO7HsyBOPEPtScrJbNovSWm3hF/WyKrxfzeZQ/07I7Lk7q
         igKCLAPi8ODHSbyw9MNuiTzrkQUsbVicjxPuUG8jkBSzp6FwQ8dvHJkW6tegTVtBwhPv
         VrGpOgnuwf0HSZpJAK5tYiO5z9HeW2xmjzV5uO7UUQ7rbpQypgrmZNfdEag0C+4UyBu7
         cv9Dm9GUW/8fBuZGmA7m1Q5ZUdmU1hNmSWoBzNqseGYvNU1uNZHSdBN2qbRlmjh7n7sK
         wyYA==
X-Forwarded-Encrypted: i=1; AFNElJ/r8cdrLa62SU3ZWlc7uHkok2GZ+0e1cIbXGFDkr2j5hCwwOaCwK4n4kMb7tz1Rpjgo6N1AVFgt+RNlAvDLP8cD@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNsEzCoGv8Sz0lT3J4xS7aBAKcr0/j+xs6m6Lj9BnFtnCjPUS
	XT63xMKv6xJ2LUM599yKZ+Xmaj1dvfcOT/iUyzEbnF5ktvFO/8b1LkIW/wNbh9NWHUM7xZv/l2f
	TxfSmYrsp2g==
X-Received: from dlah23.prod.google.com ([2002:a05:701b:2617:b0:12b:f569:153f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e29:b0:12d:c4b7:5625
 with SMTP id a92af1059eb24-12dc4b756cfmr3694407c88.9.1777156954313; Sat, 25
 Apr 2026 15:42:34 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:56 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-32-irogers@google.com>
Subject: [PATCH v7 31/59] perf gecko: Port gecko to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a port of the gecko script that uses the perf python module
directly. This approach is significantly faster than using perf script
callbacks as it avoids creating intermediate dictionaries for all
event fields.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Improved Portability: Replaced the non-portable uname -op call with
   platform.system() and platform.machine() , preventing potential
   crashes on non-Linux platforms like macOS or BSD.

2. Robust Fallbacks: Fixed getattr calls for symbol and dso to
   explicitly handle None values, preventing literal "None (in None)"
   strings in the output when resolution fails.

3. Network Security: Bound the HTTP server to 127.0.0.1 (localhost)
   instead of 0.0.0.0 (all interfaces), ensuring the current directory
   is not exposed to the local network.

4. Avoided Port Conflicts: Switched from hardcoded port 8000 to port
   0, allowing the operating system to automatically select an
   available free port.

5. Fixed Race Condition: Moved HTTPServer creation to the main thread,
   ensuring the server is bound and listening before the browser is
   launched to fetch the file.

6. Browser Spec Compliance: Used 127.0.0.1 instead of localhost in the
   generated URL to ensure modern browsers treat the connection as a
   secure origin, avoiding mixed content blocks.

v6:
- Fixed CWD exposure and symlink attack risks by using a secure
  temporary directory for the HTTP server.
---
 tools/perf/python/gecko.py | 385 +++++++++++++++++++++++++++++++++++++
 1 file changed, 385 insertions(+)
 create mode 100755 tools/perf/python/gecko.py

diff --git a/tools/perf/python/gecko.py b/tools/perf/python/gecko.py
new file mode 100755
index 000000000000..1f152e1eca52
--- /dev/null
+++ b/tools/perf/python/gecko.py
@@ -0,0 +1,385 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+gecko.py - Convert perf record output to Firefox's gecko profile format
+"""
+
+import argparse
+import functools
+import json
+import os
+import platform
+import sys
+import tempfile
+import threading
+import urllib.parse
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
+    def end_headers(self):
+        self.send_header('Access-Control-Allow-Origin', 'https://profiler.firefox.com')
+        super().end_headers()
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
+    def __init__(self, args):
+        self.args = args
+        self.tid_to_thread: Dict[int, Thread] = {}
+        self.start_time_ms: Optional[float] = None
+        self.session = None
+        self.product = f"{platform.system()} {platform.machine()}"
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
+            thread_info = self.session.find_thread(tid)
+            comm = thread_info.comm()
+        except Exception:
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
+                symbol = getattr(sample, 'symbol', '[unknown]') or '[unknown]'
+                dso = getattr(sample, 'dso', '[unknown]') or '[unknown]'
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
+        if not os.path.exists(input_file):
+            print(f"Error: {input_file} not found.", file=sys.stderr)
+            sys.exit(1)
+
+        try:
+            self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        except Exception as e:
+            print(f"Error opening session: {e}", file=sys.stderr)
+            sys.exit(1)
+
+        self.session.process_events()
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
+            filename = os.path.join(tmp_dir_name, 'gecko_profile.json')
+            
+            with open(filename, 'w', encoding='utf-8') as f:
+                json.dump(profile, f, indent=2)
+                
+            handler = functools.partial(CORSRequestHandler, directory=tmp_dir_name)
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
+            # Open the browser
+            safe_string = urllib.parse.quote_plus(f'http://127.0.0.1:{port}/gecko_profile.json')
+            url = f'https://profiler.firefox.com/from-url/{safe_string}'
+            webbrowser.open(url)
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
-- 
2.54.0.545.g6539524ca2-goog

