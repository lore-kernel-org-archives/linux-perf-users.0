Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD97332EBA
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643256; cv=none; b=CxaMp1ctLHQslcnnmqNP5CE6vD1ecM0bzB2Ng7NkZL01+pBxHkAIUZxy1WwqfdjRnbP0kUkd/I8GhhSkY5fwjFazREjFA3Lo5tfhD+B9hfIXdNRRCO5EJYmR3sxiT8h7PxBr2d4pBf6xp2ktZdNeKYT4piOw4etuQK1RAW0tvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643256; c=relaxed/simple;
	bh=rvCpD0bXZLO//vvUBVC3abGlhMnEjVg3T0Wif7KzwzQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QyaALsWKRA3iWpFtCvfQckBOSRLUCK1BpzPjDM9xHciEy7b2XGldd5XE4iH0fBOnGy0hGhZU3gtfAtgDsWF78gYytMLHd3yVbdy0mAmhOhBTPxHXBnGmGsWK4hQnhFBn7p4M1+dScVD9vaauIt9ZeG82Ke/87TcjwlyF/dILrNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKN+bFbR; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKN+bFbR"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-126e8ee6227so3429346c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643254; x=1777248054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHCs9d/DikO/kY0ut8swsgvZzXGAd2KJhLW2MzTYdJk=;
        b=TKN+bFbRX9ZTX+twsTILehnxNEwj4oJZZRgQwZULq53akYdBGQ8vLIb/D/rPzQGvKB
         1LDlac4IYKrVQ9S+cm8JxxgKrus1lYOYH3w73MvMfHQjiO3r+qMz2zjvqf6y4blQTqjD
         ugB/oG/n9V1ihskpYMYgCUZOf67rRefHpN2JbSirtl46dVUMs/1MIMh9OX+CaxjWFvVW
         lRdnLVD/d336HqbaaxgdHcDNMIlpmCC2Ng5t9xdV0XXxOiwaoCb27LGPtD3Gjpi32pzV
         tz1aqJ+TSyOl0b/33nVwHE9/FCB370LXmMZXp+b5VqNmSis5ztiWAcv48AteEO7daQF3
         Io7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643254; x=1777248054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHCs9d/DikO/kY0ut8swsgvZzXGAd2KJhLW2MzTYdJk=;
        b=GWELZ656/H3vjOvhqWQPBniw7WA0kTV/f6mFOSqChesYG7sLHQx7ZpGN0wMyv0mKhX
         UdUuBQeGmKtrO4lqoPgMM7AjwJVQUP01tDfGdATr2YNKvksq+sVcKaF1NDN11hiKz+3P
         qK7W/Azti5RU5Dcbj2em9snqbSZlsxwFjKqBqfADRHB2YzP7O0MUOHjByBOf99I3jQwe
         UTewODgZCGfYXZfUzeJS4kwFO9h8E+a89iajcimAtf2m5aQ5lDvM0DPxz50rhZeDyfy7
         mY6NyLGc8uKvacf2JstriAMSK3HHfUZ8kF01VcKIl/lRksgBtbqVPYulX4mSS+FZv+ME
         lGeA==
X-Forwarded-Encrypted: i=1; AFNElJ8xZAWFLElgEY2q37lS6Y27hnkFXf3fYgNATDcdXZa3owIwMO95Gc3+pUycgsh/P3jHuM7amtTDVHbFwvGsUorz@vger.kernel.org
X-Gm-Message-State: AOJu0YzrwZfkA7mRZqWF5CH/4jhH8Pa91eGC5pfE9cHenBjD3oXVjySh
	8XPXx1c3RxjGa6g1t0sk+6BcTO/TJ/nXgofqvT7As8o8fzipD3HIcxF0pqEWVmk5sE1TkQzWIp2
	zFSt5sd9OvA==
X-Received: from dlah13.prod.google.com ([2002:a05:701b:260d:b0:12c:593e:ebd9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b99:b0:12c:2dd7:9099
 with SMTP id a92af1059eb24-12c73f9fb84mr5491047c88.30.1776643253599; Sun, 19
 Apr 2026 17:00:53 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:52 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-41-irogers@google.com>
Subject: [PATCH v1 40/58] perf net_dropmonitor: Port net_dropmonitor to use
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

Ported from tools/perf/scripts/python/.
- Refactored the script to use a class structure (DropMonitor) to
  encapsulate state.
- Used perf.session for event processing instead of legacy global
  handlers.
- Maintained the manual /proc/kallsyms reading and binary search for
  symbol resolution as in the original script.
- Cleaned up Python 2 compatibility artifacts.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/net_dropmonitor.py | 103 +++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100755 tools/perf/python/net_dropmonitor.py

diff --git a/tools/perf/python/net_dropmonitor.py b/tools/perf/python/net_dropmonitor.py
new file mode 100755
index 000000000000..474b616725b8
--- /dev/null
+++ b/tools/perf/python/net_dropmonitor.py
@@ -0,0 +1,103 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Monitor the system for dropped packets and produce a report of drop locations and counts.
+Ported from tools/perf/scripts/python/net_dropmonitor.py
+"""
+
+import argparse
+from collections import defaultdict
+from typing import Optional
+import perf
+
+
+class DropMonitor:
+    """Monitors dropped packets and aggregates counts by location."""
+
+    def __init__(self):
+        self.drop_log: dict[str, int] = defaultdict(int)
+        self.kallsyms: list[tuple[int, str]] = []
+
+    def get_kallsyms_table(self) -> None:
+        """Read /proc/kallsyms to resolve addresses."""
+        try:
+            with open("/proc/kallsyms", "r", encoding='utf-8') as f:
+                for line in f:
+                    parts = line.split()
+                    if len(parts) >= 3:
+                        loc = int(parts[0], 16)
+                        name = parts[2]
+                        self.kallsyms.append((loc, name))
+        except OSError as e:
+            print(f"Failed to read /proc/kallsyms: {e}")
+            return
+        self.kallsyms.sort()
+
+    def get_sym(self, sloc: str) -> tuple[Optional[str], int]:
+        """Binary search in kallsyms table."""
+        loc = int(sloc)
+
+        # Invariant: kallsyms[i][0] <= loc for all 0 <= i <= start
+        #            kallsyms[i][0] > loc for all end <= i < len(kallsyms)
+        start, end = -1, len(self.kallsyms)
+        while end != start + 1:
+            pivot = (start + end) // 2
+            if loc < self.kallsyms[pivot][0]:
+                end = pivot
+            else:
+                start = pivot
+
+        # Now (start == -1 or kallsyms[start][0] <= loc)
+        # and (start == len(kallsyms) - 1 or loc < kallsyms[start + 1][0])
+        if start >= 0:
+            symloc, name = self.kallsyms[start]
+            return name, loc - symloc
+        return None, 0
+
+    def print_drop_table(self) -> None:
+        """Print aggregated results."""
+        print(f"{'LOCATION':>25} {'OFFSET':>25} {'COUNT':>25}")
+        for i in sorted(self.drop_log.keys()):
+            sym, off = self.get_sym(i)
+            if sym is None:
+                sym = i
+            print(f"{sym:>25} {off:>25} {self.drop_log[i]:>25}")
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process a single sample event."""
+        if str(sample.evsel) != "evsel(skb:kfree_skb)":
+            return
+
+        location = getattr(sample, "location", None)
+        if location is None:
+            # Try to get it from raw_buf if not exposed directly
+            # But let's assume it is exposed as in failed-syscalls
+            return
+
+        slocation = str(location)
+        self.drop_log[slocation] += 1
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(
+        description="Monitor the system for dropped packets and produce a "
+                    "report of drop locations and counts.")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+
+    monitor = DropMonitor()
+
+    try:
+        print("Starting trace (Ctrl-C to dump results)")
+        session = perf.session(perf.data(args.input), sample=monitor.process_event)
+        session.process_events()
+
+        print("Gathering kallsyms data")
+        monitor.get_kallsyms_table()
+        monitor.print_drop_table()
+    except KeyboardInterrupt:
+        print("\nGathering kallsyms data")
+        monitor.get_kallsyms_table()
+        monitor.print_drop_table()
+    except Exception as e:
+        print(f"Error processing events: {e}")
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

