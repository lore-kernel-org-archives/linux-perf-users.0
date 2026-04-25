Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8EA39A04D
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139440; cv=none; b=oGO47AMFVDl+6sZsE+1beBmEj+fe2A4xAX8QRzOAXRgrUro6Q/a7R1PBRdYUjhZK6DOK6ZrMRjQy/TI9RzcgXHcPnfFSkm8nakb6T3cZOYXu84qprqHLL5XQ3hAG33AwFMpRHas9e1F18foBRvgfNlsDRmpZekv0Az7uQnJAg74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139440; c=relaxed/simple;
	bh=j+1DPJ7hHqMkCRtiNL7ZTTuDpfoCTqlYLmFWD1lm5jM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZoUbLH3ecl5N1AkvLuu+yAt6FFL5+BXxm7L2T84XVUBY4F06qQqz2EH1q6NDuSmZXbDWczIaY21C0+x8SDdeedHc8Dy0K8UBmqr4OK9yup9HsZFQCqwRuXgDQ9vYmDJmlxvD0pn1idVNnv8EIWC9dEn5+9S8RNc0NfWVJvFt47o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkGBrNS9; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkGBrNS9"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdd327d970so5447408eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139437; x=1777744237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8uDU0iX99Tgv3o+fYqZ9yp1w2za7K0HbBrM8LxB5IA=;
        b=CkGBrNS9DfwEYIgzcnrsTVUfo3OyNG2br4ksck+wLnsGC/Wnd3t8YtU6wIXO9qeFA8
         q/KGIBaVG93gpFztE0FLFuywnOZzSvByWM1AopQzpOw0l/vBc3VOYVeZKFg4E4fPlsbT
         dLJyU+eDVf/iMi/kKjy/lW8jFM3UF2xDq1iEJPdJWrHHYIssdpE7YMpD1Av+cDEwU0zx
         Cr2EpgXuIkucrigTBTkG1K/uo0pXt/iaqSIjImMVD3UNr7f0n+5zAVtrtovFAAbDRSld
         WF+LxLx6Rpdra3GuFexQ/9H65WVKlyNQ5B6PtVvGHoHlYjzv/effUKcwDzegffe/xL6a
         /QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139437; x=1777744237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8uDU0iX99Tgv3o+fYqZ9yp1w2za7K0HbBrM8LxB5IA=;
        b=PM6K8b7PxOzccAa1BZyMOE6tnEKJ6jtjewXX0Ipu58OyPWXPybGkWX6rMeKwAtOQL+
         6NYnSo/M5cp8LBFDaqB9q2EW9qHew0FCwipHdnye4kS7wbK3xsD4u/4rVnN7vnLuJG1w
         tNYlUvOHL3j8Gt7WYdOm437MLJkJ4lH0KAKecQgjl0Ia+a14bt/J+UovCoDzdkU+jb6g
         WDMAWhdhjDOLWzUkKwUKjj8bwB/uL+Dr+u7c2lX1NNmQT7jA/68fRoZrC3eVBkV7beQc
         zYdBEqAq0d61+2UHQRBWLnWRDpHLc1fhaEz2VMnGr2k/qYGf+kNpq5wPJHNljw6UrXLi
         euWg==
X-Forwarded-Encrypted: i=1; AFNElJ9gG8uw8Ysa+oPDDKgsV0KqjwvVI8Blepq1mUVC2zTiAxwEzoga++zrA226Ag7uuTdsF7ZXXObkbHTlVL4NWnXw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr065CZiSTmBkb3o5Ww4BejovtU/5RWNsZ1CulI428URb/88b+
	zUVJU7nDw+wMUahEFvkwcuJWoSNwwWjBiRXsxbLJ8SPHbMMIulLH9eRploY1mALQwzmFvyCRTFo
	svEAj3kqucA==
X-Received: from dybrp14.prod.google.com ([2002:a05:7301:460e:b0:2ca:9b08:e7c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7493:b0:2de:e194:5fb1
 with SMTP id 5a478bee46e88-2e42ce4214bmr16715192eec.7.1777139437220; Sat, 25
 Apr 2026 10:50:37 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:46 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-49-irogers@google.com>
Subject: [PATCH v6 48/59] perf rw-by-file: Port rw-by-file to use python module
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

