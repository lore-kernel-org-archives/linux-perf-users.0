Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC53ACF14
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157514; cv=none; b=CK9s5ki7XObZN7L1AhKZPT1C1AHrVoHXbUFtdNaWKdccU/Y5MglacgDi303mJB5GAu/BZC3OclJBYyynW5ZeA3ox5sxxF1CbGwfXsw0WzsModQC5dJRHfKXiVD28xB7tuOxPWwT1rjekpxi4a1JoFDfq2q+iEAIhtgzIQNRX188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157514; c=relaxed/simple;
	bh=HIj/4KwQviJzAdb5/BAWEjqXZ2sYv3oOaIee/0kObPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e26CPqHPMDnpVXBKz7IQocXTuFI06s50A7neUT4vCJ0p5wBShYDxG4IxFPfc46+oMQ0UwaEyG5pHOMjUr3XbR51988Ui2RX/ofkDLRyfl6CLKLV+sXJZBHbS1mcefj1Fij/tK7c/kYfMmW5HRdpd6/sDoEJ7PZSdv83+QiThFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hW5unVs6; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hW5unVs6"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2de07c12745so25491148eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157512; x=1777762312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22aR7BdMkfc4F5hxQy/Qmu6pnO70TcMwJUmCFfE13QY=;
        b=hW5unVs6NGeFlrO5z2mB2/6XGy1wUrvtarLjLRBHAwS/t2+UhV8WGyoaTEWgMk+kI0
         rFROc0TYiB1QSlZjhA44Hbme67+NEV+qboaPGILBhmodopqXvTHPt9hn9E6FqiXhzAA8
         tMuhu8ev2PsqBHAaZL9usuYGXCVFX0UiWC1c8NH2mLYtTSG2v6LhO8sRTeApGKpkbYf2
         vJXJitGr1pypIj1pccJO6ociLtQrxCCuH6pnAaoiTG96Q/1TyYXH6/IaR6i/E2kLNPZ9
         6UijUixx1kfv6z5AFAOi6CDWVnDTCpuhBohmI0lZOFOCV+5dFeuxL0qqw9epMzU7lUlQ
         lLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157512; x=1777762312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22aR7BdMkfc4F5hxQy/Qmu6pnO70TcMwJUmCFfE13QY=;
        b=r4osSax2jDG70VEJqv3F3IGQj27PrmVFZTUzI3SURZ0peLZ4Z4Kft6tj/+5Q70P3BV
         0FAHZ+8qr9qb+yRvJB1GtdWNUigqmdVMCzJgwQEZ6jmUpTX6J9kqRl5KNLR1mRmz+ckZ
         pz9qEBX6f+YxKc3+3BPjacblg3o+3PkkYJO9kxrI79ODsj8xMwejEmIj6GzBQ0+nXWft
         pgq0Y1kj/4dnSKvIuOXUt4TDN5nkgUmvGz60LHGLWQe4gzzjg6W62aZHIvpWL/4Kg8yg
         V3g0mvHeN6MvOPU5gOV8QSRXUxVLN88jkGCecQHB2pN4gIopISNDvPSy/4lYzE1XgTuJ
         gIpw==
X-Forwarded-Encrypted: i=1; AFNElJ8Ry851UIRxxwMNWaZ1FT9Or57N0PqntBK+6MahS3M3Ndlx7kCt8LS/x3UEMYMQl7aal3Vy4Alu2fYlQNM4+FNe@vger.kernel.org
X-Gm-Message-State: AOJu0YzjazHpW6U5V4WosHmR1ZyRR6WoG+kY/ZOwummZdt8/wbP7CIxh
	DaQuuf1k3ZuVYqiNuyMq+jRgyoT6TJvMVhOARPQpC5gFdkTTj0/Bxmv8WFWUaejePFhymd1BdAg
	45TUtYupVTQ==
X-Received: from dyblf37.prod.google.com ([2002:a05:7301:a25:b0:2da:4e8f:1752])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6da7:b0:2c7:8e1c:956a
 with SMTP id 5a478bee46e88-2e479d076b0mr21143652eec.19.1777157511536; Sat, 25
 Apr 2026 15:51:51 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:39 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-48-irogers@google.com>
Subject: [PATCH v7 47/59] perf failed-syscalls: Port failed-syscalls to use
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

