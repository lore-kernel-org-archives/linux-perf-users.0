Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91B3D34AC
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916606; cv=none; b=pyvjOW2H3Wa+vdbRvQCNrLJ067zlmoGa85bOR9V4imfsKTWmqrOHKMXAXnjKXIGBqETBaWeU9D/COnP3BZzrfze/mV7d/7a0xauIIrTaVyco3n6lz7BPMHFuYSwn4KJF2VkXZ2QQoPuh+L35u3pa5FM8TFPDDjXduFL0Pg4Blv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916606; c=relaxed/simple;
	bh=NymkaNMY6/gpAsI2sRfQ/kn4bOAY6aEffNRezePWEdA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I6gqg1+x5ove0q3sm873xXUCpB1L4FRBuBiVg4QEz6UDk118xq1aPeDFh6XFnVVKd5PpMRf1HEvtzSsZnaVTjcG6wBI32bW2byhg6zvip3wJmgz+a+hkV9FARTMuPcO6/JTEqWvGTWU8PLgloAwps5plxksElCz0kJ0/Uuweqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwlKEYql; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwlKEYql"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d99c2908cso6093620a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916604; x=1777521404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/ytelFxWMxAULKaA3eq1rX3PKrk3jbCA4V1L2AANL0=;
        b=MwlKEYqlaJr6Po4Is9w2BGcqWNTlOTPpFu2YIefsyhJSG+kCg99KErchCTGl7UoNJr
         WjF0ACXA3+hGtGa5ks6I3xZa5W344yyVwlPVfwVvMiJb3cS0w4hQszyU0a8rCnv/6HEg
         MKJzmBye5Fx/IOhxzbyQeSZ0MtWIwciW6K7dq/mZYHR5Ugv1tvfkLtBLZSdZYfjDTPUE
         ocC9YbCehTO2LCLcyf8qBTIdG4v1qdRSMl8Ng0Lso841lJvGW/xTESINDfj3raA23SN0
         q7kjQAFRgZLTlSLKy5xucAb2LzTR7OWWvDNR9Fd72mc1YU7uSLKF9atOxPkKRHKKv4k/
         9u5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916604; x=1777521404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/ytelFxWMxAULKaA3eq1rX3PKrk3jbCA4V1L2AANL0=;
        b=niAVasyW0rJB8MXQv2p+bVc5+ILhfMnTHg4rjK6qu8+1/34iE/N4EOoa2Rh3L4X8Z9
         /pYhvEWsVjkFrr+s6UTi95oYbNR/HUYqwGmfWc4ZtMpjcF67SWPog9n3+bIrsLFE4fcS
         W13u3sYPZPAqRsSXMrT/uXT3spWxianu5rHLlhDW+UxcySTHkRwAnlLQ73lz/24l0DVs
         JT7FfsDdkRQC50QM6thLkVoxtqb8gG04wpih+LhMjWvXeRRzl1SOkZvpxLPOPJqiVhdd
         3krxwBD0ooDI+ut6JgUol+dnABO6/ySxTimcijCHoCRGCwyOBOdFAH49MmONdkDZ5Wm5
         A2Bg==
X-Forwarded-Encrypted: i=1; AFNElJ/pJdqb7o33FOUzPKBKRtuPnZ3AST5crMnoBmeP8mBt2gHuRrKRvPar4Oy2lTh5vl33V2DUFWeAB3/HaPVrPGPI@vger.kernel.org
X-Gm-Message-State: AOJu0YzvmwtJ9l3M7WqCKMLJSd2XEUg8dMnYtIRya2P4FSYYGbjkZFdy
	anZ2jgFO1N6MyQtFBg776nB/7aSYp1/HeX7clOCZwEP2gxwyzH276B3Uhg0WliVKWoK5gRV4FX6
	Jev50FrAZaA==
X-Received: from pjtz17.prod.google.com ([2002:a17:90a:cb11:b0:35d:a707:becc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc6:b0:35b:e51b:1935
 with SMTP id 98e67ed59e1d1-36140462ab5mr23820724a91.17.1776916603539; Wed, 22
 Apr 2026 20:56:43 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:54:58 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-32-irogers@google.com>
Subject: [PATCH v2 31/58] perf gecko: Port gecko to use python module
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
---
 tools/perf/python/gecko.py | 380 +++++++++++++++++++++++++++++++++++++
 1 file changed, 380 insertions(+)
 create mode 100755 tools/perf/python/gecko.py

diff --git a/tools/perf/python/gecko.py b/tools/perf/python/gecko.py
new file mode 100755
index 000000000000..15b0198e4e1c
--- /dev/null
+++ b/tools/perf/python/gecko.py
@@ -0,0 +1,380 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+gecko.py - Convert perf record output to Firefox's gecko profile format
+"""
+
+import argparse
+import json
+import os
+import platform
+import sys
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
+        if self.args.event_name and str(sample.evsel) != self.args.event_name:
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
+            thread_info = self.session.process(tid)
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
+            output_file = 'gecko_profile.json'
+            self._write_and_launch(gecko_profile, output_file)
+        else:
+            print(f'[ perf gecko: Captured and wrote into {output_file} ]')
+            with open(output_file, 'w', encoding='utf-8') as f:
+                json.dump(gecko_profile, f, indent=2)
+
+    def _write_and_launch(self, profile: Dict, filename: str) -> None:
+        """Write the profile to a file and launch the Firefox profiler."""
+        print("Starting Firefox Profiler on your default browser...")
+        with open(filename, 'w', encoding='utf-8') as f:
+            json.dump(profile, f, indent=2)
+
+        # Create server in main thread to avoid race condition and find free port
+        server_address = ('127.0.0.1', 0)
+        try:
+            httpd = HTTPServer(server_address, CORSRequestHandler)
+        except OSError as e:
+            print(f"Error starting HTTP server: {e}", file=sys.stderr)
+            sys.exit(1)
+
+        port = httpd.server_port
+
+        def start_server():
+            httpd.serve_forever()
+
+        thread = threading.Thread(target=start_server, daemon=True)
+        thread.start()
+
+        # Open the browser
+        safe_string = urllib.parse.quote_plus(f'http://127.0.0.1:{port}/{filename}')
+        url = f'https://profiler.firefox.com/from-url/{safe_string}'
+        webbrowser.open(url)
+
+        print(f'[ perf gecko: Captured and wrote into {filename} ]')
+        print("Press Ctrl+C to stop the local server.")
+        try:
+            # Keep the main thread alive so the daemon thread can serve requests
+            stop_event = threading.Event()
+            while True:
+                stop_event.wait(1)
+        except KeyboardInterrupt:
+            print("\nStopping server...")
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
2.54.0.rc2.533.g4f5dca5207-goog

