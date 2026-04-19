Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520833BBD2
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643221; cv=none; b=ojY3A5As/RA8qUcIgamhXHIwahbg/XOQT/h1fzjYUjly4iBfkNkH6aLLZzvBCn/uMtCQICWLPsTetx0RT9CHoEYbhOGzSb2FtxJ7Y7Ah/Zi4cEkADtYYvNRuiHzbQ4QQQ+/ObKhwrRFJiNWlGEKEhWAeHW/xcJ3X4EpxQpCnq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643221; c=relaxed/simple;
	bh=TKBt91by0ASHDouqC2QvWoLh1rQghpG6sFJWOZkRT8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UZmAe9DvhnCugV6xwG2HV2YOvrsEBzbSuI+vJgqN69DEC5twaZ5iHUjvRJ87W324fl9gZWUEscqNbiBmTjGyE00i0JsiNsSOlwSzCmxNmUdrjKZuKA0Q6nvZgpbgV0UmJkafK+FYp6rzeFakIu1Y1025cgDhFR2RNyH8yVB4P2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eg9qXpnx; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eg9qXpnx"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2e60238adb1so918608eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643219; x=1777248019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EuEIGZNS/N0CIixILejBNz5VJmoW/Pts7HVmIwyB1Sw=;
        b=Eg9qXpnx0/UvC4YpVREave722rjdjV/C8/WUAor3A6gzVx/NwemlptrjmyjDrXlpcr
         Od68gQun4xMbVywGvy2PLpn4+fvwdQqPk2//oED4ll5sOm2j8ZA7CxA9OKLNCqiA8JZx
         BG/5CR7XeeOAB9krxXT1qcr8G9Pq9/mCzl82m8JOAa8c/6cifjDBJyggI11yZoyCa/J7
         W2pjj8boQNzH1v2Bv3U+Cn1RpcoJE3bVeEzssfmMgTPPRGl+wqd+rfU2JsFMolSQSLOI
         lB+gjUyel2GQFug46FDVJgmfraNweNcOVj2RTN/LL2avTTocjyk1dkYCItp2ksPY0WCx
         s26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643219; x=1777248019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EuEIGZNS/N0CIixILejBNz5VJmoW/Pts7HVmIwyB1Sw=;
        b=aaU46A3f1kc/1GJGCW2fwDzxl269qQgUlPwihxvNCS3Tc7caDcT4hzTnjUYx/kc1I6
         et6MWgthF0BqxCYgIUcRNgO4JvxC+gEZY4qC75n7XImfXjZfzw2y6eMFGPRWvTzVjfMl
         VqXeHImO2/NTqjVA/V0yxIc6pQuQTWfemE2zwoVM9P1IZChGZzdr0z9ndhnH8JwsJRE1
         0iRGzhbQrCIqRjKkQG8B0iaUITf37+buCsA/YXjPkezIJSVRTOmzDveFF0pHXwCBda5M
         PW1RoqSWSAsqZaQy0gR/ojI1uLsBo3YVPUh3TizsqIeRZnUJcT17w2KHU+jLtEFC1Z+z
         a7dQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dxWdwllKRclw+OVCBlfpa2sjG5fyTFLTao9RQFpYkSsnrR7biCGukCQmxdc9bA2M7XlpVGy5GTA0HttxAlI6t@vger.kernel.org
X-Gm-Message-State: AOJu0YzY6cUVnMOTT+QTLl+ualhPeT3AB3Do9wLM8ME3r/c5OrMpLTkP
	RU0CcwY4baLlsJh0NtcIf3LSs2Q7G+ZxTsvgji1J/liZNrcCk/wtk9GYUTVLuE1pObIIfq5TTpU
	W9Xvwq/Lfiw==
X-Received: from dybnj5.prod.google.com ([2002:a05:7300:d085:b0:2dd:4573:2897])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8628:b0:2d8:1efe:51dc
 with SMTP id 5a478bee46e88-2e464ea8c23mr6449187eec.6.1776643218636; Sun, 19
 Apr 2026 17:00:18 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:37 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-26-irogers@google.com>
Subject: [PATCH v1 25/58] perf stat-cpi: Port stat-cpi to use python module
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

Port stat-cpi.py from the legacy framework to a standalone script.
Support both file processing mode (using perf.session) and live mode
(reading counters directly via perf.parse_events and evsel.read). Use
argparse for command line options handling. Calculate and display CPI
(Cycles Per Instruction) per interval per CPU/thread.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/stat-cpi.py | 139 ++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100755 tools/perf/python/stat-cpi.py

diff --git a/tools/perf/python/stat-cpi.py b/tools/perf/python/stat-cpi.py
new file mode 100755
index 000000000000..6f9c2343520e
--- /dev/null
+++ b/tools/perf/python/stat-cpi.py
@@ -0,0 +1,139 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Calculate CPI from perf stat data or live."""
+
+import argparse
+import sys
+import time
+from typing import Any, Optional
+import perf
+
+class StatCpiAnalyzer:
+    """Accumulates cycles and instructions and calculates CPI."""
+
+    def __init__(self, args: argparse.Namespace) -> None:
+        self.args = args
+        self.data: dict[str, tuple[int, int, int]] = {}
+        self.cpus: list[int] = []
+        self.threads: list[int] = []
+
+    def get_key(self, event: str, cpu: int, thread: int) -> str:
+        """Get key for data dictionary."""
+        return f"{event}-{cpu}-{thread}"
+
+    def store_key(self, cpu: int, thread: int) -> None:
+        """Store CPU and thread IDs."""
+        if cpu not in self.cpus:
+            self.cpus.append(cpu)
+        if thread not in self.threads:
+            self.threads.append(thread)
+
+    def store(self, event: str, cpu: int, thread: int, counts: tuple[int, int, int]) -> None:
+        """Store counter values."""
+        self.store_key(cpu, thread)
+        key = self.get_key(event, cpu, thread)
+        self.data[key] = counts
+
+    def get(self, event: str, cpu: int, thread: int) -> int:
+        """Get counter value."""
+        key = self.get_key(event, cpu, thread)
+        return self.data[key][0] if key in self.data else 0
+
+    def process_stat_event(self, event: Any, name: Optional[str] = None) -> None:
+        """Process PERF_RECORD_STAT and PERF_RECORD_STAT_ROUND events."""
+        if event.type == perf.RECORD_STAT:
+            if name:
+                if "cycles" in name:
+                    event_name = "cycles"
+                elif "instructions" in name:
+                    event_name = "instructions"
+                else:
+                    return
+                self.store(event_name, event.cpu, event.thread, (event.val, event.ena, event.run))
+        elif event.type == perf.RECORD_STAT_ROUND:
+            timestamp = getattr(event, "time", 0)
+            self.print_interval(timestamp)
+            self.data.clear()
+            self.cpus.clear()
+            self.threads.clear()
+
+    def print_interval(self, timestamp: int) -> None:
+        """Print CPI for the current interval."""
+        for cpu in self.cpus:
+            for thread in self.threads:
+                cyc = self.get("cycles", cpu, thread)
+                ins = self.get("instructions", cpu, thread)
+                cpi = 0.0
+                if ins != 0:
+                    cpi = cyc / float(ins)
+                t_sec = timestamp / 1000000000.0
+                print(f"{t_sec:15f}: cpu {cpu}, thread {thread} -> cpi {cpi:f} ({cyc}/{ins})")
+
+    def read_counters(self, evlist: Any) -> None:
+        """Read counters live."""
+        for evsel in evlist:
+            name = str(evsel)
+            if "cycles" in name:
+                event_name = "cycles"
+            elif "instructions" in name:
+                event_name = "instructions"
+            else:
+                continue
+
+            for cpu in evsel.cpus():
+                for thread in evsel.threads():
+                    try:
+                        counts = evsel.read(cpu, thread)
+                        self.store(event_name, cpu, thread,
+                                   (counts.val, counts.ena, counts.run))
+                    except OSError:
+                        pass
+
+    def run_file(self) -> None:
+        """Process events from file."""
+        session = perf.session(perf.data(self.args.input), stat=self.process_stat_event)
+        session.process_events()
+
+    def run_live(self) -> None:
+        """Read counters live."""
+        evlist = perf.parse_events("cycles,instructions")
+        if not evlist:
+            print("Failed to parse events", file=sys.stderr)
+            return
+        try:
+            evlist.open()
+        except OSError as e:
+            print(f"Failed to open events: {e}", file=sys.stderr)
+            return
+
+        print("Live mode started. Press Ctrl+C to stop.")
+        try:
+            while True:
+                time.sleep(self.args.interval)
+                timestamp = time.time_ns()
+                self.read_counters(evlist)
+                self.print_interval(timestamp)
+                self.data.clear()
+                self.cpus.clear()
+                self.threads.clear()
+        except KeyboardInterrupt:
+            print("\nStopped.")
+        finally:
+            evlist.close()
+
+def main() -> None:
+    """Main function."""
+    ap = argparse.ArgumentParser(description="Calculate CPI from perf stat data or live")
+    ap.add_argument("-i", "--input", help="Input file name (enables file mode)")
+    ap.add_argument("-I", "--interval", type=float, default=1.0,
+                    help="Interval in seconds for live mode")
+    args = ap.parse_args()
+
+    analyzer = StatCpiAnalyzer(args)
+    if args.input:
+        analyzer.run_file()
+    else:
+        analyzer.run_live()
+
+if __name__ == "__main__":
+    main()
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

