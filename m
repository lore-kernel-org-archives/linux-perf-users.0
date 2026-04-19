Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941BD32D7FF
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643281; cv=none; b=g4OwjePQx/o6GvVHRydJ0ZtRN1TQsL+fJDI9m+XCUjodl/aiDJttflavGA9bYCFWPC/gnYyhBqwhEHEnafgOepXR8V7RtGe9vqK6p+TWkAyXaIHsz7eWRYGY4o/dr1MXDoOz0edSv08wCpYhsVkLKkk9PbeRAJMRH6nQyDI4/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643281; c=relaxed/simple;
	bh=Sn4+LeY0ODnIndOnCfmThi5vqMdglt8za7OAJSnSy0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=brVjIS1yQOkl1nCddkgWdzmDR8UxuPAVkvdAWQ30beWu/m/iCTuPT9sxZ6ad4EjKWifWM1/SAXEEX3QjrHg7NmlRfRavEZ/NsqwO12Y3KlboQ1HdKMMfypax+NaZhQcZKtv3PWrpnKqL6RU3gDjUMdcoFEY2Bhxhe9OqRR2PXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qDOChBDf; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qDOChBDf"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so2416199eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643279; x=1777248079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4c3EE2JSunfO1fNqxfJC2CHz+XlCxLEqTgj5XpptBd0=;
        b=qDOChBDfdnWXwfx2bOwdcUU8kzHENXIX8pZ4a/MfLfPuR81iAXyJZJZjD4epzl42sk
         MOkweloDq27vXoBRjSNBmRqER3BYea+XTAxustSC4q16ubqN/meh72gue01lZgcUFmeF
         sQyjEYhkLqJNit1sSMBb2XTyL2zY3XMkTEU7mtjaHeykN/t3gE0J3uw7tQnhgrgtYBXB
         zO+WtnUfTQamy34NHKjsl0HpbGi3Izyhs7GR3dbHi4HKMod5/AUAllLt24JjzWtBGQMx
         CEElgIAbZGDrT2PW5yt7Dx06tYYR6R+ekhfEu4S0Z9htrbaZhPmop1V3KkefGcraibxa
         Tr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643279; x=1777248079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4c3EE2JSunfO1fNqxfJC2CHz+XlCxLEqTgj5XpptBd0=;
        b=leu/Kp3PDlfhfSeFe8v2UFcYj6dV5M3xvjPZ5Lrjr6cj2qZWrMdZCqstZfu1GbG3wF
         T+XbYyyP5iHt5jyhUvG8bfo9GU/VXfDX4o8hZVQM284Ro1+Xsvbt6G9MiDzDmwaof0c1
         vjND6SK7niTz+/U+Wq+6k+lF6KDqAWttRtaPm5KROp1dEInl616k3Fq1ffzOCiGrzZRB
         gt+PH89UQxUUymB3E3sTgm14zdcQ39kXaUy676L/Br6LGg/QbdLIFmfntBcx5zIeAyTc
         VX2SXM9UJvDsBzXSjdk1YoTL+u1ThcOHIO1uJ6VhJYEP3NEZnxx3ayAIFCoDLfja2V8p
         4uaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+TzSDcYU/B6A2nwYkdLH2RJVeTA7cD13fH6Qw1Em2tUqTpWPYimtUjlf26vVRIYBipt0+DUUmpMBjyJzltGlev@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz9jCmBg8S5iH0GSlIX3PppUqOgp2iqnEIrw85TEMOhIZHfL6h
	8dvAHvm8xINW/RhHXYu1MrZDLYF5vri8JalM6elNIaLFJ7Byh7OPAigrvqRF+bwFk71EcT5h5dH
	gOHafGQpCcg==
X-Received: from dycpq4.prod.google.com ([2002:a05:7301:fd04:b0:2df:6abf:7cee])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2b12:b0:2d9:cfa6:3d34
 with SMTP id 5a478bee46e88-2e478a3370fmr5034461eec.23.1776643278439; Sun, 19
 Apr 2026 17:01:18 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:59:03 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-52-irogers@google.com>
Subject: [PATCH v1 51/58] perf wakeup-latency: Port wakeup-latency to use
 python module
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
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
 tools/perf/python/wakeup-latency.py | 85 +++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100755 tools/perf/python/wakeup-latency.py

diff --git a/tools/perf/python/wakeup-latency.py b/tools/perf/python/wakeup-latency.py
new file mode 100755
index 000000000000..109b751aefb3
--- /dev/null
+++ b/tools/perf/python/wakeup-latency.py
@@ -0,0 +1,85 @@
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
+        cpu = sample.sample_cpu
+
+        if "sched:sched_wakeup" in event_name:
+            try:
+                target_cpu = sample.target_cpu
+                self.last_wakeup[target_cpu] = sample_time
+            except AttributeError:
+                pass
+        elif "sched:sched_switch" in event_name:
+            wakeup_ts = self.last_wakeup[cpu]
+            if wakeup_ts:
+                latency = sample_time - wakeup_ts
+                self.max_wakeup_latency = max(self.max_wakeup_latency, latency)
+                self.min_wakeup_latency = min(self.min_wakeup_latency, latency)
+                self.total_wakeup_latency += latency
+                self.total_wakeups += 1
+            self.last_wakeup[cpu] = 0
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
2.54.0.rc1.513.gad8abe7a5a-goog

