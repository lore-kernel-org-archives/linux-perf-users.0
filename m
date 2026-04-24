Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E23EFD00
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049368; cv=none; b=YEdzb7GKV0kQQ4f2n1HbWp2+BFA8BX+lbznrGq3B7a6hCBx8X94OEJVjE94o31S1RCXuZ3JNP2qHVdIq4o1/oZ+7Fqp6lrNN4uksJlNaBtr70gJD3dhOw1xn3l5IIXgtqzahaah2i4X9gDhNsM2Enh6dmtDgrcOh7g8CDZ9QUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049368; c=relaxed/simple;
	bh=1jHa4HYK0G7iZ5Loj9OlxNIyriBUkZMFKOg3o08CrTg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=er/cHelee26zP3fSqgo6YP7Lp+VhLcTFvX01vGG2CpU8Vqq6uxU/v4FAfcEMs7t34TTTZSpXZWo94a4FngzQ9sV7UnIaOZSjKB9zr8/0X+7tT8l40h/VZEZ7ELj2opZ6lIhD1zETCPrkNwyqwacTLWhgkURtwz4JJHtnivO4HXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NwDW45Ib; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwDW45Ib"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12db37213daso11884844c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049367; x=1777654167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Cc1jZjiNz6qIzGkr9ZYmlIDRLWz0J6P2q+qfe2/eFk=;
        b=NwDW45Ib1WKY1/rvaGDOnIdrjKF7LlSDDfT++bOCwVzNFOQ9uF7ygnYKUGIZhTSQew
         BmcxiZNmhdcDPAHOPhkykuHndUIWzSWi1lzw+E2a8CAqxFBe1YTZM6OUwQqeh7Db1q5i
         s7tFWCsHN8vR5fvutgtTaznMDYcEI52NU8Linmf6cd++idCXSBxg4rB4eLA7Uoq19eYN
         52fBbWIYca9BWPUyLP9onu91ye3LRlWk1HvTEWocAGIdyGDyL1u1WE6uluaK1Cp1dnDH
         cTQupQhkuwpJliQ/fmf0KafJuXUL+q6XUfzjelw650S1PM11x4p20WKlnhHbDMhruKET
         HxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049367; x=1777654167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Cc1jZjiNz6qIzGkr9ZYmlIDRLWz0J6P2q+qfe2/eFk=;
        b=PdiKejssPGFyFq7lZ8WNZqDA2GWdeXnsqegqiUOZNUYCkw8NPaGKdMZv9T6fgOlmak
         YO4dTikQiKgZahcAZOdR/6aGLzFXcAAgfRJf4HrgKj9PQ5cQF0MvpZ6000cPP4xtQ0JF
         0bsdfR17bIpKuHOr59osCQmqhG5zLws1y8Cn63OcMk71TqFt1vJx/0RTQHZN6D/qwtI4
         pWH7mFqQIPyUEYEohh8DU0JlsvvMafSXBh1iFl5emXS4ucobltAiJDM2Q6OBcrODrME5
         xF6vKHvag3cV5ni1eq2QBlx2jHz4Nad0xQ0yV9FowN/MAwXMhtabKZEJUF+iBuMf14c6
         uz5A==
X-Forwarded-Encrypted: i=1; AFNElJ82EDy/BW2k/PvWs+a0nTOznMjAhHqf3vmwlPStunK30uUXuTk9NYywDM4tUJd7PegBR5yfdIWU+Eiy/F3e5yK4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Yte6B253vRTgdsKGSaGXQ1WJtRGIqUn7Hfyx3Sx0ich9qoDW
	SViKlQTnZajDOTz/LFFiDaQquEUsPneLtDjZlpMKZSMwP0x755w7U1jBd+rgfz+vDlNKcMzHiUd
	/FusNH9k06w==
X-Received: from dlbpu10.prod.google.com ([2002:a05:7022:e88a:b0:12b:fba9:5eb0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4199:b0:12c:8b9:71db
 with SMTP id a92af1059eb24-12c73f97587mr18037107c88.21.1777049366351; Fri, 24
 Apr 2026 09:49:26 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:10 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-49-irogers@google.com>
Subject: [PATCH v5 48/58] perf rw-by-file: Port rw-by-file to use python module
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
---
 tools/perf/python/rw-by-file.py | 103 ++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100755 tools/perf/python/rw-by-file.py

diff --git a/tools/perf/python/rw-by-file.py b/tools/perf/python/rw-by-file.py
new file mode 100755
index 000000000000..f71e0b21f64e
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
+        event_name = sample.evsel.name  # type: ignore
+
+        pid = sample.sample_pid
+        assert self.session is not None
+        try:
+            comm = self.session.process(pid).comm()
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

