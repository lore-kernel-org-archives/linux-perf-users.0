Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6A3E6DD0
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049366; cv=none; b=FBCMG2PUuU2IRWtg2RmFG7hkPv+OUZcNtWTc0BwlP5U30r30hiPRTt9sH1Qcjzg5tEY8zik5T8cG729kU6xYumaovJy92I0n/yBWcpKfk9jqViQ3W2ZtLMQ4LeWx8dVt6JQl2nmMjGBRL9Ub+zu44nqgnHJsU37y90h3iQTc/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049366; c=relaxed/simple;
	bh=a1mvrTE1F1UvzC7GKYNiFbXgOitkFsrolW/jmSj894M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RM3S/givQBVTWM94asDaqqTKbkt94JTbi4TnbUDF9JxDH94Ot9zCLwCf5Q3Fw1huPhn46v2BE0oDJr9rfdWWq6/rAlavE+YjQplXW394/zUbHyyM8Ea1iLpVtiSIorGdJd1wxWjPOWd6Ncc8/oniBnjsNKwLGu5Biv6w3fNCSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h5qD52Nf; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5qD52Nf"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c20d5d7f4so38129948c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049364; x=1777654164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIATP8XFfjDQHugGpOui2zhnlJg5I0nHGF4GsUacwsg=;
        b=h5qD52NfoVY/g2oh5MzFLfNb+7MBp0Yhp83o9paldZNrf7hpowgyC6RKmoingdnuEK
         25eVt51EjCqQUsUjdh90rXCcwCrHQg0LZ2UIZqTOK9NbqqE2xbl7zu/3ovDmZnYu/B7G
         y2jJMEF6vXKV+1nTPtt4MdBO8nrxQ+poCoefa/hfWLBSwQK9qMP8wOw4wLAStTOoqaVW
         6b+Qp/IxcpNiUXgLPa/bIMU3vokL55ELPRtKRbi/lfdL0eqJO9owoUgY8BTeKziRkI9c
         61zMQMeHX5xuKfZyQKOaWAZGfuLZ7AY61jwh25YJfBMAdXmcL3Y0FxqJHkjaS0kYZ9Zl
         3zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049364; x=1777654164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIATP8XFfjDQHugGpOui2zhnlJg5I0nHGF4GsUacwsg=;
        b=YMOBCLARX1Ps5AcJ9f7tJiX5WELDHaI0WK1sx9Vcq6PVveVZk+eJpKdbhzeNVL+JFx
         erC+wZbZ5kETiCtukK8f0ilwdrHYInHBSq59VaBE07+EQEbSI/KS0I/BUpWXLF4Xj7mg
         LsrfOlVVLCQsk5dGo33arTSL5tMM3Wqmb/4oqwMZV45hEhif7d2JqFtQncOr1HKix4k+
         WKNsYHZbESsR9XpW0ViNIxD0W6Q0tXuZgCI9wESbpnTJT7OC+YdMHjpN03A0krBgkeFc
         8o/lJvtYznAtHCBiuQTIwZ8fGDRLhpwHmpI1mhRZ6kOh6i3yjOSmJ4pAgOBZTaE++hZ1
         ILMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/k6UN9/4/tIL+/lwCoNwfumac1TvS5f86IqzlvRewbmIRZZ88b+W1skdwslsBfCLz8cAtZ0GxAGzQYpG433Hx5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Qv7GQ7028ONUj7O6Vcv+D14MUUtmKEcogYTSHTscsRH+7OdH
	4+7h4f2h33jrHxX5XBpdm+SiXVUBJL16dbYic2MFSkZz4+ViqiOhBBjOrokGN7DfHXfOHN32JrO
	00eMxvjOLHg==
X-Received: from dlaj3.prod.google.com ([2002:a05:701b:2803:b0:12d:b48e:8597])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eac8:b0:128:d714:3ca6
 with SMTP id a92af1059eb24-12c73f7167cmr19495331c88.12.1777049364049; Fri, 24
 Apr 2026 09:49:24 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:09 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-48-irogers@google.com>
Subject: [PATCH v5 47/58] perf failed-syscalls: Port failed-syscalls to use
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
index 000000000000..178c1458430a
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
+            comm = self.session.process(pid).comm()
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

