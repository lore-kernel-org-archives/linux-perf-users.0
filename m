Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A43D6CB9
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360858; cv=none; b=jmtx7asEe+jLH1kCHFzbvoDrukWI+iUe3U51Xkj30VGX6L4gfRhh6rAFuouOTlQtycY0umNiCq5NMFLOom0kDeYYib12iDFYaIv61e2SUMgLhaMxdNd/7nptB4Nz9kIib6ymnKtuZwVKCdGy4YDHu6yMLjULNw2WI7SaeicTYK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360858; c=relaxed/simple;
	bh=j+1DPJ7hHqMkCRtiNL7ZTTuDpfoCTqlYLmFWD1lm5jM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h/UnosW59jx0SUdNbCE+Bv/a6D2SpgkSMg0Gx0M+mcF6MuO/FPssWUANChRu/3NFCBCXAIQDH+maD4iSusQ+TyiJ7NtMgsfp/TdxM+46XJRXyeBep1ePpVknXQM2aCIPStGGOhRSOiCQp5N6igokhsm6qZWchBc3D81c4kVMRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VdJiEpw1; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VdJiEpw1"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-126e8ee6227so12482746c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360855; x=1777965655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8uDU0iX99Tgv3o+fYqZ9yp1w2za7K0HbBrM8LxB5IA=;
        b=VdJiEpw1P8DtdyrkgX4MnVdD4AjRW5dmSwDd9NtJuurLWN7VydjJ6roxU7mIN0R1/t
         Z/ICgULFXWOvpi2+rv2lIXbr9IfXjGfUi1uscQMvq2mN05J+3muyQDP2OEGOhBcQit1C
         dv+V6iu3nNfXwGyQPhluWbvMt4TeZqdrCDtMe/9bnbjQ16Dvb6cCAYMEPNM3/AQfqoJl
         9joLwyuWtTev5on2xijo/+ttPu5XiedUe/+lLYWIlxBgNnXkRnhVkuNh5xIO7wYjEDrM
         ZzN974MjCb7KhNZmO/z96MA+7SfDGVkrwmgs7l7g1brnBuz4tE10Kh3ueFs7Ph5V6gnx
         oddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360855; x=1777965655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8uDU0iX99Tgv3o+fYqZ9yp1w2za7K0HbBrM8LxB5IA=;
        b=BEOabY2cy452SygynOV2bXOptZEFqMpOocZiT3WKtaTpd0115dGSsZw3xlwZ+kwisf
         +u/WM3iNh5tQdmFAXyWdlwamvTj1QzHUpeNfrjOJszjYUqD+bq+2HxZAp2IT4KGE70Fl
         LGkuA7InJUQ+SYAQfNBgOAXvTzdgyTNSj9YDwe2xb78zpWykmpxj+diAlrcFbDmXaiAS
         SKuJgR/aeq+W5LhGrLpF+oG3QiXzLzVvqbrxKXf0UxfuZyIYWc9BdNe+nCLmCafSr01g
         VCQE71lIIzGK5/8Y/9AbpbixRJ2/8b5t98UU689iu2D8g9SC158oKagVJ8xd/JQ4lJAL
         HUHg==
X-Forwarded-Encrypted: i=1; AFNElJ9qBMrKN+K71ZsoVBJJcd0xNSxEI08o/jgxWw/JJ4K+E/zjLpgprcA37fxybE+WOFV34WNEmgNr7fwhQeJhTYRk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fiQvhxwCNJVWnxGfQAZNBT68kxb78R18vBa3Dz6XpZcx+1r/
	B2RnhA+YFUciTIglMXefg962K6frY9t4vtxF8zsxuoKqMEkxaNLomyrCUoj3/KEljBADxcX6nf/
	N+XwhZljQhw==
X-Received: from dlad28.prod.google.com ([2002:a05:701b:221c:b0:12a:7f44:d2e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2385:b0:12c:8b9:71d9
 with SMTP id a92af1059eb24-12ddd9b5758mr797120c88.27.1777360855127; Tue, 28
 Apr 2026 00:20:55 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:53 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-49-irogers@google.com>
Subject: [PATCH v8 48/58] perf rw-by-file: Port rw-by-file to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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

