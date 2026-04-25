Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E28392C21
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157120; cv=none; b=JbRRp2lgfgwnT+sYczJwZJIJTx4iIIblEVV3ccjHHaMIyhso+xVcvzSjn+bt2dXQ3LDn6WQRTCwW8xPzMyLhGkgN4rlWXNZH9BVC3S9HytNspZBsydeFAFKZOze7cvzTqGv0rlaz6q1aKNH02PogcSGIeK6HLYalTXpo02MGupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157120; c=relaxed/simple;
	bh=j+1DPJ7hHqMkCRtiNL7ZTTuDpfoCTqlYLmFWD1lm5jM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mDKQSMuZqmzYAnr9oYARuopzAHJZlDh2NRT/R1YsuHWUgYWC76jVRAwn3dW7vwxsmokqF+13mmbFpsHr1IYSPeqhnLNwynRk+VbrkxKw2A6uVAoN6R+tBJPFSnrOvFzLo+XwarYeXuvnKd3+1pEE3vUTuOro2Jy4zt9hhuWSS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oaEcY6Sf; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaEcY6Sf"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d93379001eso20013667eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157118; x=1777761918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8uDU0iX99Tgv3o+fYqZ9yp1w2za7K0HbBrM8LxB5IA=;
        b=oaEcY6Sf1fOjW2wcWjhGBC5uILQInmvN724GbAZ4egnB//y9S4QTVbGSz5EsZS1znr
         mwPizBSHzJpG3cEMonbn8yr40Bm76KpT3zwNhZE+02yYbbd+r0RjH1nwQLvjCRqm755K
         2XPtuCe9QeE0GtibA6jADsnOLyqBRz9oV2WbkyBI92eUwq6HfIbYBxHocUkVNCKQyyt/
         +4y3BMrzvgHibmMhMiXvkCoA7XOCvJTLH5xXI5zX/R8CyuonWoMRF0FTshjO/yjX7GI0
         dKkesp44rFngw7nMIm+H/2ohhXwgthe7aeMsOkT5QkzVAlD6TGbgBv1eESy2S8Dqg52G
         8g/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157118; x=1777761918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8uDU0iX99Tgv3o+fYqZ9yp1w2za7K0HbBrM8LxB5IA=;
        b=UdEFQkjTCZELt8EA0LT2K74iXB9BEL4ZVcSgAlwvj6AoHg5dF+jedYXX4RgiFqrmcL
         tgVAe9Jl7sZJ9N9390USejbBmhJBuKJ1/NgU2nJk6wzalCJw/Q9+5YnZFcMjdYOuG+Eh
         baTtnnQ16ttmMlAZaLgctmOiAtViUtVx8pLvlR6xIHralJuf/9sbeJpN2euVkZW1pWv6
         TOyYLwLrB2wH65/5/Amt+/IukN+dZhykoSCNTOaioNe7o6HhfV1ZDrM2GGAh1RThDPp5
         gG0CCBizfNftKCkXLRB5ey9SuWoq9FAe/FHp8RCqOiVYLNTukNzuTyRJeNhHbJmJF88S
         NK7g==
X-Forwarded-Encrypted: i=1; AFNElJ/2vxj+gCEZxw7Kal7sWuihLVVT9gH06j48bWcadSwIV03ZHLysbKy1B9hfyHS22OnDdtgPbqfvS1tuTmk9+4yM@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8/14TlTgRvvdjGLYoTc4LOMwNtY12bzi+jm74/my4DLTI93h
	+p13sTewh8DjVOEUMFcTsDyQWYVcA/WB1OLmZhAm01y07HCOijNMlifLsS/dYvhADCkn6DCMTPj
	Pb8URrPF+ow==
X-Received: from dybss20.prod.google.com ([2002:a05:7301:7214:b0:2e5:ce71:32c4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2327:b0:2d8:97d6:6ac8
 with SMTP id 5a478bee46e88-2e478c1ff0cmr23453474eec.21.1777157117979; Sat, 25
 Apr 2026 15:45:17 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:44:52 -0700
In-Reply-To: <20260425224503.170337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224503.170337-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224503.170337-6-irogers@google.com>
Subject: [PATCH v7 48/59] perf rw-by-file: Port rw-by-file to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Port the legacy Perl script rw-by-file.pl to a python script using the
perf module in tools/perf/python.

The new script uses a class-based architecture and leverages the
perf.session API for event processing.

It tracks read and write activity by file descriptor for a given
program name, aggregating bytes requested/written and total counts.

Complications:
- Had to split long lines in __init__ to satisfy pylint.
- pylint warns about the module name not being snake_case, but it is
  kept for consistency with the original script name.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

 - Fixed Substring Matching: Replaced if "sys_enter_read" in
   event_name: with an exact match against syscalls:sys_enter_read and
   raw_syscalls:sys_enter_read using sample.evsel.name . This prevents
   variants like readv or readlink from incorrectly triggering the
   read logic. Similar fixes were applied for write events.

 - Fixed Silent Error Dropping: Instead of silently returning when
   expected fields are missing (causing AttributeError ), the script
   now increments the self.unhandled counter for that event. This
   ensures that missing data or unexpected event variants are reported
   to the user instead of quietly skewing the results.

v6:
- Fixed `AttributeError` by using `str(sample.evsel)` to get event name.
---
 tools/perf/python/rw-by-file.py | 103 ++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100755 tools/perf/python/rw-by-file.py

diff --git a/tools/perf/python/rw-by-file.py b/tools/perf/python/rw-by-file.py
new file mode 100755
index 000000000000..2103ac0412bb
--- /dev/null
+++ b/tools/perf/python/rw-by-file.py
@@ -0,0 +1,103 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+"""Display r/w activity for files read/written to for a given program."""
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional, Dict
+import perf
+
+class RwByFile:
+    """Tracks and displays read/write activity by file descriptor."""
+    def __init__(self, comm: str) -> None:
+        self.for_comm = comm
+        self.reads: Dict[int, Dict[str, int]] = defaultdict(
+            lambda: {"bytes_requested": 0, "total_reads": 0}
+        )
+        self.writes: Dict[int, Dict[str, int]] = defaultdict(
+            lambda: {"bytes_written": 0, "total_writes": 0}
+        )
+        self.unhandled: Dict[str, int] = defaultdict(int)
+        self.session: Optional[perf.session] = None
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process events."""
+        event_name = str(sample.evsel)[6:-1]
+
+        pid = sample.sample_pid
+        assert self.session is not None
+        try:
+            comm = self.session.find_thread(pid).comm()
+        except Exception: # pylint: disable=broad-except
+            comm = "unknown"
+
+        if comm != self.for_comm:
+            return
+
+        if event_name in ("syscalls:sys_enter_read", "raw_syscalls:sys_enter_read"):
+            try:
+                fd = sample.fd
+                count = sample.count
+                self.reads[fd]["bytes_requested"] += count
+                self.reads[fd]["total_reads"] += 1
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        elif event_name in ("syscalls:sys_enter_write", "raw_syscalls:sys_enter_write"):
+            try:
+                fd = sample.fd
+                count = sample.count
+                self.writes[fd]["bytes_written"] += count
+                self.writes[fd]["total_writes"] += 1
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        else:
+            self.unhandled[event_name] += 1
+
+    def print_totals(self) -> None:
+        """Print summary tables."""
+        print(f"file read counts for {self.for_comm}:\n")
+        print(f"{'fd':>6s}  {'# reads':>10s}  {'bytes_requested':>15s}")
+        print(f"{'-'*6}  {'-'*10}  {'-'*15}")
+
+        for fd, data in sorted(self.reads.items(),
+                               key=lambda kv: kv[1]["bytes_requested"], reverse=True):
+            print(f"{fd:6d}  {data['total_reads']:10d}  {data['bytes_requested']:15d}")
+
+        print(f"\nfile write counts for {self.for_comm}:\n")
+        print(f"{'fd':>6s}  {'# writes':>10s}  {'bytes_written':>15s}")
+        print(f"{'-'*6}  {'-'*10}  {'-'*15}")
+
+        for fd, data in sorted(self.writes.items(),
+                               key=lambda kv: kv[1]["bytes_written"], reverse=True):
+            print(f"{fd:6d}  {data['total_writes']:10d}  {data['bytes_written']:15d}")
+
+        if self.unhandled:
+            print("\nunhandled events:\n")
+            print(f"{'event':<40s}  {'count':>10s}")
+            print(f"{'-'*40}  {'-'*10}")
+            for event_name, count in self.unhandled.items():
+                print(f"{event_name:<40s}  {count:10d}")
+
+    def run(self, input_file: str) -> None:
+        """Run the session."""
+        self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        self.session.process_events()
+        self.print_totals()
+
+def main() -> None:
+    """Main function."""
+    parser = argparse.ArgumentParser(description="Trace r/w activity by file")
+    parser.add_argument("comm", help="Filter by command name")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    args = parser.parse_args()
+
+    analyzer = RwByFile(args.comm)
+    try:
+        analyzer.run(args.input)
+    except IOError as e:
+        print(e, file=sys.stderr)
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
-- 
2.54.0.545.g6539524ca2-goog

