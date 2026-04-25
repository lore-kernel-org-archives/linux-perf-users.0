Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD26396B98
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139432; cv=none; b=PJegsLdYSdiU45oKeT5TZ5QP2DNqzfk32QNbJYMzGpG5+daefZal54QAsGrSoQWrEw1WrrVALtC8SWSntYjWuX38X3uofgohFjVj10rR/eWA4UT8TKYRHbZas8/UBBxCEhwC4HIFNrbLCch3bBZ4kva/DKfQh9ksZ2nMi9yH9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139432; c=relaxed/simple;
	bh=3OzyHhDflAGnhfcPd/Cdhu5Dl9jWi1PgdqDYN/G82GU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hP0UIQbeeiDkqNOMfXOVu/eqXuZAk5iQ39uS+PulFP/4k/KX0bO7wLbjg3SjuO46WPZKllfgCHnjTzRTmevcwTVj2NjmHscVhBOkDVKjQdGcPg6JBkrgNgvuN6BLmGiYejHyZNBkFfoZpnka6TC3RhxdsRLsGzAHFlUYIqvPa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyyKIPrd; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyyKIPrd"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d889997495so23553941eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139430; x=1777744230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1LwLJ/S5+yYNXf1JRm+e96X+YoT2PYO4quJ+4E0ZMc=;
        b=nyyKIPrdTV1idZLzER+vii1CiTkauSKzULtsy8LYQ3+h1U/9S97C5C73dZ/PD6hWa2
         phDPudm7J0l4M4NWMiVRKX2fxDFECdzw12e89D6UptF2OVpRAf+l2jW+uNN54S4IdO8z
         6/d9frqDbXt+1n7B/oA2Vk7hkRMNcduG5AK+5ytGc0TXuMxy74cBVSkzbh/d5si04qBA
         Vude3TlPnPbcx1tAKwhd73eZAZT1ilDLnbX+Eg07ikrR4BZxEp2i8fZBVuofpPteAUHK
         lhiHLbeCFBUE8H4P94dbmsAU+r4lwiqZ7vN9OmBm28lNArsGQjJhV7j/9wkwx/Zmz78s
         BfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139430; x=1777744230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1LwLJ/S5+yYNXf1JRm+e96X+YoT2PYO4quJ+4E0ZMc=;
        b=SHV0DtRTdeoLYqX0q+2BemDlpgHvZ92YZeSlWXRSaUDgOJtj+GyoHjEvlWKOR8Dbsy
         dILwuK0+aXDwhFD/v3ChotF12+JbW8NMnStudYLyqWSITGH7SM4IkZet1EWIzUtvV21F
         MH0XufyfRa7EWz1YxxUdYZ8lKFGQNzL+vfkhISNEqLPz9v+Y8eFw4/0R45kMQ3+W830e
         XRb/5OBBWAshqGnFZE3PgZjQYxS++gN8gbnqvjRwaLo9CkXpm4/4zKvUZyVnELRiICxA
         VzSTQ3R+j4dGT30XtDmr1lehZnkw9toVtQY7lifv1NA5PwbH7nVjaLaQ327gKfNlbxy8
         SGPA==
X-Forwarded-Encrypted: i=1; AFNElJ9kxdiLTG/7jAWcoeKjGHhFLbY4W8unM0Ajoy+rSoP7YZUK0qnTzoY66iQpXHN0Vu0c2feqtgClckuj+yfUxJAi@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsi1tJrLrKOhfQzNHFcifOs+6oWQvZMeT0L3/LCxu1aoBMYv6f
	b59vJD1S/8jc7wPNQe3dAnHnU8ABqv7YylVXTyxkCvJV0GL4UN/VoZmW0XISqoGoS/o4L8nTak2
	SMNcRsgTpww==
X-Received: from dybso7.prod.google.com ([2002:a05:7301:6907:b0:2d8:e3a6:d707])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2b04:b0:2e1:f72:3f2a
 with SMTP id 5a478bee46e88-2e4647d03admr19946258eec.4.1777139429395; Sat, 25
 Apr 2026 10:50:29 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:42 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-45-irogers@google.com>
Subject: [PATCH v6 44/59] perf sctop: Port sctop to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

This commit ports sctop.py from tools/perf/scripts/python/ to
tools/perf/python/ using a class-based structure. It also adds live mode
support using the LiveSession helper with a fallback strategy for
tracepoint names.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v5:
1. Fix Fallback Logic: Check `__syscall_nr` and `nr` fields for syscall ID
   if `id` is missing on fallback tracepoints.
2. Fix Thread Lookup Crash: Added try-except block around `session.process()`
   to handle missing PIDs gracefully.
---
 tools/perf/python/sctop.py | 186 +++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100755 tools/perf/python/sctop.py

diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
new file mode 100755
index 000000000000..b94f66a8307d
--- /dev/null
+++ b/tools/perf/python/sctop.py
@@ -0,0 +1,186 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+System call top
+
+Periodically displays system-wide system call totals, broken down by
+syscall.  If a [comm] arg is specified, only syscalls called by
+[comm] are displayed. If an [interval] arg is specified, the display
+will be refreshed every [interval] seconds.  The default interval is
+3 seconds.
+
+Ported from tools/perf/scripts/python/sctop.py
+"""
+
+import argparse
+from collections import defaultdict
+import sys
+import threading
+from typing import Optional
+import perf
+from perf_live import LiveSession
+
+
+
+
+class SCTopAnalyzer:
+    """Periodically displays system-wide system call totals."""
+
+    def __init__(self, for_comm: str | None, interval: int, offline: bool = False):
+        self.for_comm = for_comm
+        self.interval = interval
+        self.syscalls: dict[int, int] = defaultdict(int)
+        self.lock = threading.Lock()
+        self.stop_event = threading.Event()
+        self.thread = threading.Thread(target=self.print_syscall_totals)
+        self.offline = offline
+        self.last_print_time: int | None = None
+        self.session: Optional[perf.session] = None
+
+    def syscall_name(self, syscall_id: int) -> str:
+        """Lookup syscall name by ID."""
+        try:
+            return perf.syscall_name(syscall_id)
+        except Exception:  # pylint: disable=broad-exception-caught
+            pass
+        return str(syscall_id)
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Collect syscall events."""
+        name = str(sample.evsel)
+        syscall_id = getattr(sample, "id", -1)
+        if syscall_id == -1:
+            syscall_id = getattr(sample, "__syscall_nr", -1)
+        if syscall_id == -1:
+            syscall_id = getattr(sample, "nr", -1)
+
+        if syscall_id == -1:
+            return
+
+        comm = "Unknown"
+        if hasattr(self, 'session') and self.session:
+            try:
+                proc = self.session.find_thread(sample.sample_pid)
+                if proc:
+                    comm = proc.comm()
+            except (TypeError, AttributeError):
+                pass
+        else:
+            comm = getattr(sample, "comm", "Unknown")
+
+        if name in ("evsel(raw_syscalls:sys_enter)", "evsel(syscalls:sys_enter)"):
+            if self.for_comm is not None and comm != self.for_comm:
+                return
+            with self.lock:
+                self.syscalls[syscall_id] += 1
+
+        if self.offline and hasattr(sample, "time"):
+            interval_ns = self.interval * (10 ** 9)
+            if self.last_print_time is None:
+                self.last_print_time = sample.time
+            elif sample.time - self.last_print_time >= interval_ns:
+                self.print_current_totals()
+                self.last_print_time = sample.time
+
+    def print_current_totals(self):
+        """Print current syscall totals."""
+        # Clear terminal
+        print("\x1b[2J\x1b[H", end="")
+
+        if self.for_comm is not None:
+            print(f"\nsyscall events for {self.for_comm}:\n")
+        else:
+            print("\nsyscall events:\n")
+
+        print(f"{'event':40s}  {'count':10s}")
+        print(f"{'-' * 40:40s}  {'-' * 10:10s}")
+
+        with self.lock:
+            current_syscalls = list(self.syscalls.items())
+            self.syscalls.clear()
+
+        current_syscalls.sort(key=lambda kv: (kv[1], kv[0]), reverse=True)
+
+        for syscall_id, val in current_syscalls:
+            print(f"{self.syscall_name(syscall_id):<40s}  {val:10d}")
+
+    def print_syscall_totals(self):
+        """Periodically print syscall totals."""
+        while not self.stop_event.is_set():
+            self.print_current_totals()
+            self.stop_event.wait(self.interval)
+        # Print final batch
+        self.print_current_totals()
+
+    def start(self):
+        """Start the background thread."""
+        self.thread.start()
+
+    def stop(self):
+        """Stop the background thread."""
+        self.stop_event.set()
+        self.thread.join()
+
+
+def main():
+    """Main function."""
+    ap = argparse.ArgumentParser(description="System call top")
+    ap.add_argument("args", nargs="*", help="[comm] [interval] or [interval]")
+    ap.add_argument("-i", "--input", help="Input file name")
+    args = ap.parse_args()
+
+    for_comm = None
+    default_interval = 3
+    interval = default_interval
+
+    if len(args.args) > 2:
+        print("Usage: perf script -s sctop.py [comm] [interval]")
+        sys.exit(1)
+
+    if len(args.args) > 1:
+        for_comm = args.args[0]
+        try:
+            interval = int(args.args[1])
+        except ValueError:
+            print(f"Invalid interval: {args.args[1]}")
+            sys.exit(1)
+    elif len(args.args) > 0:
+        try:
+            interval = int(args.args[0])
+        except ValueError:
+            for_comm = args.args[0]
+            interval = default_interval
+
+    analyzer = SCTopAnalyzer(for_comm, interval, offline=bool(args.input))
+
+    if not args.input:
+        analyzer.start()
+
+    try:
+        if args.input:
+            session = perf.session(perf.data(args.input), sample=analyzer.process_event)
+            analyzer.session = session
+            session.process_events()
+        else:
+            try:
+                live_session = LiveSession(
+                    "raw_syscalls:sys_enter", sample_callback=analyzer.process_event
+                )
+            except OSError:
+                live_session = LiveSession(
+                    "syscalls:sys_enter", sample_callback=analyzer.process_event
+                )
+            live_session.run()
+    except KeyboardInterrupt:
+        pass
+    except IOError as e:
+        print(f"Error: {e}")
+    finally:
+        if args.input:
+            analyzer.print_current_totals()
+        else:
+            analyzer.stop()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.54.0.545.g6539524ca2-goog

