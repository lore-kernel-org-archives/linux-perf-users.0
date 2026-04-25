Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB63F3921D0
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157118; cv=none; b=ShSzmmNxlU/iM+xZDyJjt+MPrvYQtS0BB63fOsJhpQZTfuxb/1OWiEQ2elAFST7kSEq60B531cX34mQIwbWXDykHm32AIhCV0GSCKygDeZ/t6FahbaCtq4Wn5kgb3ZBOukgML+HIB/7uU8uTKXI8I44EKaDRl29DUQQICphrzpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157118; c=relaxed/simple;
	bh=HIj/4KwQviJzAdb5/BAWEjqXZ2sYv3oOaIee/0kObPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bbzXcjbF7ZtNNO9UW3PpkHmOGqjyvXi4CAmxfEkyPRuzPICbc9yoiy8dV0W1qw5WvyWLtKdA+rrAyxsLdHTV9dB4yzg65LwGV7s9jSjguFUaNZ8nfzg5M7g2GAsuuF7UcML9Zx5+GyVgvxhhoDlEwbH16q/oURGvCNp6cFBR8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qxj770s6; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qxj770s6"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2cc75e79b97so24541210eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157116; x=1777761916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22aR7BdMkfc4F5hxQy/Qmu6pnO70TcMwJUmCFfE13QY=;
        b=Qxj770s6P80ofGNki5HBfdeL1fCWHT+s2S3ZHOCSQl17S/E8RoX3q5sKLFc+nQUD3N
         sfTCJWCgmAk/kXRt5NmsttcpOxBBDvRgBPZI+OB+QnzKj0N4iBiUgIx9TFEVJYYC1uER
         R49QNiDSLsi+uRBJWL+TNkH0RxEaFB0L8orTbkcIbmJ+kt1pndrGcwaE/qawaVlcVcyu
         dwEBax3JAwJKZPGsL4XlshvmmYEu1yuAlInPbz+gFYAsZRAvw1ltKCTMUYFNsPuSlC2x
         ahX76yz6AJFTvnHxC9eG88qdaUkgV3KQSDmV2Exj9XpBGitB7QK4HD4p1/whVsZ/d3uh
         WyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157116; x=1777761916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22aR7BdMkfc4F5hxQy/Qmu6pnO70TcMwJUmCFfE13QY=;
        b=VyQ1lKGTKbN2cw3pJbVUD8MK/zsEJTgB7KVPBmFR/yZ6nA83U4jeq5Q7ZcXiDc4ITl
         Fmi1oR6L+xzwcK+aNIzFlGUTb8v7si58grIJ20X5T7lR51GG8fZ8mpK9q8TPjo5Qw0fy
         XY4hrXDX15GhGioyqKuzDa+7dmfDa46e4LXiAuwX2iJmj/MDDnc8JsRuFF4vBTCMo3eA
         SqERQXITIwSK4Vj2g7OVcYxMFGz9Qc3YIoEdFpo6spplqJ0T1LR6+KMQTkBLEt4XGEnx
         CVb3YJ5wTDSSqPUZsMNpq3TgXElkUSt78nTJ4mOtJZ50IyXTcm392HA6f4jKdBdZ3kRv
         B+pw==
X-Forwarded-Encrypted: i=1; AFNElJ8V29F5H19svDDLU6I/SamWFz8rUZ0HfwPPGGfQU8SXDQKaP4G0VrzFkhI7qacDz+06Lwufmxa/ktAG0ZmBT1tH@vger.kernel.org
X-Gm-Message-State: AOJu0YyiTEawgPk5xmCMZlZ5cIu74UPwxiIbbTiD1ehPJuPhssc7v+Mb
	fp3ZeYpvPFK4nCIsyFz044fF4wDvZvswbqKnxhJwwlRT0TbvYGf/HrGl/67UD55CULcwnfMbgJo
	0GZGsctbarQ==
X-Received: from dyhd3.prod.google.com ([2002:a05:7300:8283:b0:2e2:b79e:ed06])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f193:b0:2da:1874:f39c
 with SMTP id 5a478bee46e88-2e4657728eamr20326591eec.12.1777157116025; Sat, 25
 Apr 2026 15:45:16 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:44:51 -0700
In-Reply-To: <20260425224503.170337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224503.170337-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224503.170337-5-irogers@google.com>
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

