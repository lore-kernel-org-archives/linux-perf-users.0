Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D529379EC6
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139438; cv=none; b=CUNLGI0Mhz5QyQjw5VmYY8esM+IStHYzt/ri96EYKnuFlapHBf7PRzxoWohkgX+UIQ5AQKJTE+OW578Q7YEh4vIG6/Yc8BRNUbB65W05uu/k00oMyrfQzSZyPdZ6qqMFNqdAG0nckYXW8bGrS8E16pgckMSokOZKfvZYdMS6QkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139438; c=relaxed/simple;
	bh=HIj/4KwQviJzAdb5/BAWEjqXZ2sYv3oOaIee/0kObPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FjJam1umImsuL5owoMlVEA+hqjEVKnytD0zPAAp5eI9lWC0OlPD94OL9IFhHIIuEztaeeAay+3DlT89nRglCh6aIdp6nWoSv2y2YwV8UHZ/K118rel9qM2/DCakr6lFFY9U2BX9EiX4Hjx4xKc4VbejQxdYHNal4FAU1c9lfcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YqoBh1ay; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqoBh1ay"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d93379001eso19590405eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139435; x=1777744235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22aR7BdMkfc4F5hxQy/Qmu6pnO70TcMwJUmCFfE13QY=;
        b=YqoBh1ayGubeZm3JVUJxHFSRg1TGE4v6hdXzenqq2kgLOQPVVUPW3Yiy8Ck5lCFZ95
         rbrAjuLopAiUjeZPHhUbtXZdyh2oGw9GVKPd7Uyad/AOE8V81cfpWn5r/Ucj/2lCw91i
         dcXoLEkqzTRLMr9JNrl/h1ASGCu53Qz/nOvfR+VhhD0QvKr+0RxJXYzcFgp4pNha4nVu
         u89HTD1EIiybyKf+feepVadv9aDb2Ujx3otm49VVeg+SC3xrcyRcRYtsHdcuWswkPaaC
         D6fFf8+vaRq1FWaDVtOtkP9GGsbyAbB6mLsfB3a5iJp/tqrTf1EWxbaXHrQ9lHzxbkE/
         VFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139435; x=1777744235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22aR7BdMkfc4F5hxQy/Qmu6pnO70TcMwJUmCFfE13QY=;
        b=pVEc4GU7QSwWRrneyMfnpDxvNFXF3DnivonIOh5M1HekjMx9urz0qWfQD2McHiAJoj
         tfE7QdyiMtCpHBaSdCsLOW8k7xjk5oYtGg5zpwi2QscA/XhS7I861WVTAmVsQheT1ZRl
         jQOkjzaelG3U9UNQOssPmhGoDFMMZra+iu4OpEkKJ9MTc7lAagIZl/GeltGHgZCbmt4J
         Jk/MlVQkKzS63Xeg+2riOyM5OXPXt9lDw61gvpxsp3M7FH43imQZfqlczIDUvQ2Hp7qq
         ma91foxe2N5ckogf3OCetayRTREPpXJq5kS7UoemyVbjT3Xk6J764KmC8nFwqFB8Tw4U
         TTgA==
X-Forwarded-Encrypted: i=1; AFNElJ9ZCuJVZE66ytJn9k5iM67TtZsN0/zqVGDGAvcGe/6Amodctg7aLOiZ8rK3vm+/tfOxHZPs/9nKxTDrxlo3sCbk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvjp+CMwTuHFwv3IB7M+LeTm9OcOq79zY7/+Z9w7FaAsuU9CO4
	YeZac5X37mbZFRAX0iFkhslQ+cCY8NUfX/N4YOgVUkBMMEGMLrSwHcaaCFK65JzlgRfs7GbvZfp
	0oBKru28yyw==
X-Received: from dyji40.prod.google.com ([2002:a05:7300:7a28:b0:2d8:dd18:baee])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6587:b0:2ea:6361:8981
 with SMTP id 5a478bee46e88-2ea63618b8bmr14661160eec.22.1777139435077; Sat, 25
 Apr 2026 10:50:35 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:45 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-48-irogers@google.com>
Subject: [PATCH v6 47/59] perf failed-syscalls: Port failed-syscalls to use
 python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Port the legacy Perl script failed-syscalls.pl to a python script
using the perf module in tools/perf/python.

The new script uses a class-based architecture and leverages the
perf.session API for event processing, making it a standalone script
that reads perf.data files.

It filters for sys_exit events, checks for failed syscalls (where
return value ret < 0), and aggregates counts per command name.

Complications:
- The script is designed for file-based processing using perf.session.
- pylint warns about the module name not being snake_case, but it is
  kept for consistency with the original script name.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/failed-syscalls.py | 78 ++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100755 tools/perf/python/failed-syscalls.py

diff --git a/tools/perf/python/failed-syscalls.py b/tools/perf/python/failed-syscalls.py
new file mode 100755
index 000000000000..c3b58664eb57
--- /dev/null
+++ b/tools/perf/python/failed-syscalls.py
@@ -0,0 +1,78 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Failed system call counts."""
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional
+import perf
+
+class FailedSyscalls:
+    """Tracks and displays failed system call totals."""
+    def __init__(self, comm: Optional[str] = None) -> None:
+        self.failed_syscalls: dict[str, int] = defaultdict(int)
+        self.for_comm = comm
+        self.session: Optional[perf.session] = None
+        self.unhandled: dict[str, int] = defaultdict(int)
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process sys_exit events."""
+        event_name = str(sample.evsel)
+        if not event_name.startswith("evsel(syscalls:sys_exit_") and \
+           not event_name.startswith("evsel(raw_syscalls:sys_exit_"):
+            return
+
+        try:
+            ret = sample.ret
+        except AttributeError:
+            self.unhandled[event_name] += 1
+            return
+
+        if ret >= 0:
+            return
+
+        pid = sample.sample_pid
+        assert self.session is not None
+        try:
+            comm = self.session.find_thread(pid).comm()
+        except Exception: # pylint: disable=broad-except
+            comm = "unknown"
+
+        if self.for_comm and comm != self.for_comm:
+            return
+
+        self.failed_syscalls[comm] += 1
+
+    def print_totals(self) -> None:
+        """Print summary table."""
+        print("\nfailed syscalls by comm:\n")
+        print(f"{'comm':<20s}  {'# errors':>10s}")
+        print(f"{'-'*20}  {'-'*10}")
+
+        for comm, val in sorted(self.failed_syscalls.items(),
+                                key=lambda kv: (kv[1], kv[0]), reverse=True):
+            print(f"{comm:<20s}  {val:10d}")
+
+    def run(self, input_file: str) -> None:
+        """Run the session."""
+        self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        self.session.process_events()
+        self.print_totals()
+
+def main() -> None:
+    """Main function."""
+    parser = argparse.ArgumentParser(description="Trace failed syscalls")
+    parser.add_argument("comm", nargs="?", help="Filter by command name")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    args = parser.parse_args()
+
+    analyzer = FailedSyscalls(args.comm)
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

