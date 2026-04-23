Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041D3D47AB
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916650; cv=none; b=hQvk8p1IWeXKUj+iIaEIJbRvSbAvAVW2KDGahdJvcRB2S+d9zA3aKlfe0eNaHaj7v7Yyxv0MfGYsMVFY++nipn0wUONw1jg7rOeOVRfVH95mRo/AaNJHRffPWZFSQD9qfC0L7erRjzDds7qk/1dBrFa646FGiLT7mjDtbK06jpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916650; c=relaxed/simple;
	bh=NMqsKicJTuqtdYFfXPtWuoov4B0G8lfLcJ3XRwJCIyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ptE3TrmFx5vJgpvecbIUj9zGCVEquZOLFzfPlS//VqMqhKVqIQwj5jgUR4IieeAhhVNAfq3/gJPMFd0Ev1mv5mBQdG834/7asYZwoX6KHLuhCZNZUtuwEsx1ajw7dGjQRmfTX3w3YW4oyEjkrp5bw3viSu3cNCC81s1bbO8U7SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QCb3Ij0z; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QCb3Ij0z"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c8ccc7593so6404408c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916647; x=1777521447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ukc5CMlv1Gxs4NWpWueaT52blfG4//jTmS7zbd0Bxpo=;
        b=QCb3Ij0z3hPyWCJHILtF9YO10gxHh8iF1nIUqBEhXsGD0k66CpXgth79NB85qluMJv
         O3lXkNsCzx7T+7vmYnQkAHa8Lgzo5vKk1FcknSXquGODlrsO2EPGo8OeTCb2N5esP/Z+
         g8Ms7fpa6y5kxcdvJwnobo1updDA2+vrVlnxqXsPYB5nKgECL+EdTvmzc3ntisWrFMHe
         FKrvDxRQSp0aXqJLRebEHkDB1K940WACIK1LZZDk+sTJHGegWjC3Xg2R+7hDeJRbzf+J
         LhrZAuoA4GeQDnmOAs48OBKOxPiHW2hMH7Kw6wWnykhc0jtewGggJAWrTdM4fBSGbMqc
         hqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916647; x=1777521447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukc5CMlv1Gxs4NWpWueaT52blfG4//jTmS7zbd0Bxpo=;
        b=Mx3IrGDt5CGteWu43v1Iya0R0xm8dyBayM1D+WpP5XuXNf/nixxaIgS1xnhlx5yJpK
         DaztrPX/+pJV1Dr4KTBUfBBTL2E0SIKxcW2bvVdsWamQMDOwSJRgWzV9N+Og9tHPDmAI
         /rFx+0BBKgN9/NmRK46yP1mHXXW/xlaUy8gn7Xgwj01aUfKsWqAzvg0dVUVsfXXW+vfP
         u+wE5a4gqvNzbjwVlAj55Og2dFgnv3UltJ3JnNqFn6kCO6RBa6HBJ6XQbDq7oy2nRwiG
         UsJ7wS4HbkThnZItUuIQhsoF+kxQlPlgEhF1z1nPy3V/dq8LdPGdXcaoMjImgwCxdYQN
         t40A==
X-Forwarded-Encrypted: i=1; AFNElJ+nG1OnW9GKGIzyj9KGBb/m42wZqGxGH18dYN2vJIvBhNEWr5Ar0ghJ4QJqM4icpV/gj0AE6Wg4GiIV3uPhq+Y4@vger.kernel.org
X-Gm-Message-State: AOJu0YypB6Nzy97/JeuHzCvpPX6cmNNv1YXy90LOPBvwG1xPhMxh/tcz
	119hZYSsEE/uRwUepSKCEh/rsHJclRq7iColrqKPr7zwQVe9wxh0bY1qP5HTKBNt9gH8V2/CMd1
	X6byeO4infg==
X-Received: from dlbqc1.prod.google.com ([2002:a05:7023:a81:b0:12c:87ba:191d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2213:b0:128:cf80:deea
 with SMTP id a92af1059eb24-12c73f697edmr13039924c88.1.1776916646007; Wed, 22
 Apr 2026 20:57:26 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:55:18 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-52-irogers@google.com>
Subject: [PATCH v2 51/58] perf wakeup-latency: Port wakeup-latency to use
 python module
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

Port the legacy Perl script wakeup-latency.pl to a python script using
the perf module in tools/perf/python.

The new script uses a class-based architecture and leverages the
perf.session API for event processing.

It measures wakeup latency by tracking timestamps of
sched:sched_wakeup and sched:sched_switch events.

Complications:
- Used min() and max() built-in functions instead of if blocks to
  satisfy pylint recommendations.
- pylint warns about the module name not being snake_case, but it is
  kept for consistency with the original script name.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

 - Fixed Wakeup Latency Logic: Modified the script to track wakeup
   timestamps per task (using sample.pid as the key) instead of per
   CPU.  This ensures that context switches are correctly paired with
   the specific task that was woken up, even if multiple tasks are
   woken up on the same CPU or if a task is migrated to a different
   CPU before running.

 - Prevented Memory Growth: Added del self.last_wakeup[next_pid] after
   successful latency calculation to prevent the dictionary from
   growing unbounded over time.

 - Added Error Tracking: Added try-except blocks around tracepoint
   field access in process_event() and tracked missing fields in self.
   unhandled instead of ignoring them.
---
 tools/perf/python/wakeup-latency.py | 88 +++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100755 tools/perf/python/wakeup-latency.py

diff --git a/tools/perf/python/wakeup-latency.py b/tools/perf/python/wakeup-latency.py
new file mode 100755
index 000000000000..1b0db115abcf
--- /dev/null
+++ b/tools/perf/python/wakeup-latency.py
@@ -0,0 +1,88 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+"""Display avg/min/max wakeup latency."""
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional, Dict
+import perf
+
+class WakeupLatency:
+    """Tracks and displays wakeup latency statistics."""
+    def __init__(self) -> None:
+        self.last_wakeup: Dict[int, int] = defaultdict(int)
+        self.max_wakeup_latency = 0
+        self.min_wakeup_latency = 1000000000
+        self.total_wakeup_latency = 0
+        self.total_wakeups = 0
+        self.unhandled: Dict[str, int] = defaultdict(int)
+        self.session: Optional[perf.session] = None
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process events."""
+        event_name = str(sample.evsel)
+        sample_time = sample.sample_time
+
+        if "sched:sched_wakeup" in event_name:
+            try:
+                pid = sample.pid
+                self.last_wakeup[pid] = sample_time
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        elif "sched:sched_switch" in event_name:
+            try:
+                next_pid = sample.next_pid
+                wakeup_ts = self.last_wakeup.get(next_pid, 0)
+                if wakeup_ts:
+                    latency = sample_time - wakeup_ts
+                    self.max_wakeup_latency = max(self.max_wakeup_latency, latency)
+                    self.min_wakeup_latency = min(self.min_wakeup_latency, latency)
+                    self.total_wakeup_latency += latency
+                    self.total_wakeups += 1
+                    del self.last_wakeup[next_pid]
+            except AttributeError:
+                self.unhandled[event_name] += 1
+        else:
+            self.unhandled[event_name] += 1
+
+    def print_totals(self) -> None:
+        """Print summary statistics."""
+        print("wakeup_latency stats:\n")
+        print(f"total_wakeups: {self.total_wakeups}")
+        if self.total_wakeups:
+            avg = self.total_wakeup_latency // self.total_wakeups
+            print(f"avg_wakeup_latency (ns): {avg}")
+        else:
+            print("avg_wakeup_latency (ns): N/A")
+        print(f"min_wakeup_latency (ns): {self.min_wakeup_latency}")
+        print(f"max_wakeup_latency (ns): {self.max_wakeup_latency}")
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
+    parser = argparse.ArgumentParser(description="Trace wakeup latency")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    args = parser.parse_args()
+
+    analyzer = WakeupLatency()
+    try:
+        analyzer.run(args.input)
+    except IOError as e:
+        print(e, file=sys.stderr)
+        sys.exit(1)
+
+if __name__ == "__main__":
+    main()
-- 
2.54.0.rc2.533.g4f5dca5207-goog

