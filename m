Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927063B95FF
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960716; cv=none; b=DD/DFBijMlGfKNCcbyIjzsaKW/3TqQw0SnoydV5qn/OwwXsNU3pDSYaLs5YWhQAZXc/0D/B6S2LVzudXp5gbKgNqVU7YAJFEQu6ApF9P7wgUI0+OqpxUpCIOd2n12jqJmHSYNL10QOemaCwrQEC0qrGogvqdTGDHFUAqRD42/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960716; c=relaxed/simple;
	bh=NMqsKicJTuqtdYFfXPtWuoov4B0G8lfLcJ3XRwJCIyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PxlOppGRqBtpkIQ9nfQDR5eah5qF2JtCQM9+gnvm9PWEpBXN6I1I7dhH0sdp/OTWz4XwBlfnpEY6DVlOS9AOIiQbtvaPNBiDaHVDT2yrUKSP04+GqB8vHTCG8JY0RfJHY+lZRaPpEIv8DAd3QoGnbaYzXYOoj0ufnzHeXJ+DT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aGvekPtj; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aGvekPtj"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12db218e265so2383808c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960714; x=1777565514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ukc5CMlv1Gxs4NWpWueaT52blfG4//jTmS7zbd0Bxpo=;
        b=aGvekPtjPurL38Tpvau2kzvcGVsElnI+ypkxbYAeXFiLTZ1xxjaDD6yQJBQf3dZ2Go
         iWMoiMG+UPQ9Zo9kKdwIlklgzAid40DO5RM6gQASQOGPH+1NnhTom3f85jaJqqAkWtDz
         vHnWjIcm2uXEFVXT5kmsDceUbw9HYdYfkv7d9w3cX9reI631X/p3o6mRSrgEAWkBNvNq
         ZKP3SfV1UJVjjmHJLL5CNbUyb3Bex1zkcwMUxspk6tcCy66e2dm1Qf9C31JvBN/ZC+Oa
         mpTAVADhswuGCiG1++cgjB+Zyn49lB+dppRcw9g1laVZbneryHfL2e0IOLIViFaeWVdN
         AdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960714; x=1777565514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukc5CMlv1Gxs4NWpWueaT52blfG4//jTmS7zbd0Bxpo=;
        b=XlATiuriTCHTr7tYqL2VlyxZjrLkPCkt/FiB5U1yO0JsYfY415LRqIiADEUC4FxvrS
         uxYeVgzen9ZM+qPrUk84cpE/mUYsIvyMUOVHK0+PIxrgjp52CZbJ7a9c0DQzDfqyXWaW
         NGCHetbRXQCUoigZzbbTOVM4/KysBH7ZS72/PN/31sjtXnmO2iigjfym7+A5jT9L44AJ
         9TFXD0qacrneL1FQ7+xLx9FB/riwk0vpWC6ojVlaUFr9doIRmvfoxiVR3mpyRkJ0H0tH
         Bmvm63hYrvNw8NotZqbIDSEd88YgyySsg4sgy8XtwSJGVr5tzqEd7yNS1nQRcsQhAJ7F
         4MjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8v7VHbq7ySUqMR9fJ6MYgtfZ5v6wOc+RmhsimSo1Mk4jW9EguWTrtFsebi9puCkMPBY1RUzc3eQEE/hUhqRFnt@vger.kernel.org
X-Gm-Message-State: AOJu0YzNJnAyXnMYErVXfNPLoi0JHWYcruGp2847+RZsDGEoz5VlbUhV
	jUCpm7H+uGjbI4+1d/Fk3IHo5Ds33989kI5qvjrGDr73fB5p3jQf7WgqyHU52dRr0T/UzUeNuzH
	5JC/Mf/ZBbA==
X-Received: from dlbvg2.prod.google.com ([2002:a05:7022:7f02:b0:12a:9ef0:93ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6984:b0:12d:b66f:35d7
 with SMTP id a92af1059eb24-12db66f3983mr6416425c88.10.1776960713339; Thu, 23
 Apr 2026 09:11:53 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:57 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-51-irogers@google.com>
Subject: [PATCH v3 50/58] perf wakeup-latency: Port wakeup-latency to use
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

