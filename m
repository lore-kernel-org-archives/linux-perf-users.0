Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6858346AE5
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643279; cv=none; b=Fxdad5UIi83o+zwe30fv8jyAOWdoHKkD5YyEoLV2fMkr3p57xzxRh9Xx+4VQikKUf80e409Xfy6S1hdmpdKBxapdm2niCMRI+c0OMfEJkG43vHR0v4mUyUVk1Gw0xxEcDbLNKq/detC0EueMKQG0ndAAxduJmvY9yFaYzkBGh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643279; c=relaxed/simple;
	bh=rpIEVA9jSFnrVRzQK06MfKf38ltxaMyFxbTnYqm8ucc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c8AJuJ9dcyudI+XCNHTftl4f6jMqzyH0EplAI6z/AIE2c8kyGRsKefR1X5P8iF5h7hJz007r1axMSL24LwDmCId6HCj6tQv4Qh1SSMg2POsuz4KRl1Z8oo6o1R6L4UebWeZm4SQ/jGnqh+SgL88SP4HJlD3xw8HRqHeWlaweCko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cOXq9KXQ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cOXq9KXQ"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c8de02a4dso1159027c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643277; x=1777248077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3pAV2aO/ywH7sA8/DmC18gHblIoCvRksZB2RLc506A=;
        b=cOXq9KXQDi68lemGzEBoSUIj7Oc1yrzlEN85VywPAHVlY7v3KHKrV6SUvC5b3nUmOU
         3Ec/tgWV04RACRxQ8c1+ZuKB4nG510AFtUrHjL387M1fgrhIZgxXFCmf/EKXBD4FQA48
         C8iaCp9dNfCWup1KQ+SpZqglCy/YH72ifdG4LZqhfBtct+3Ce0jgfwvbjqKLfWhYFzGa
         cdYg/MnL8QfxAiKGtbW+kAmp+5VygrRmaEBRihFIUrK2gaPYadhJYnHU1uhGS3QEDKtW
         Od00C5oZ+1/l262nPZx839VxB87qcGSqO/0p8MoIhUZ5Sa1BkQEuds7VLEnsysDk2+bX
         lkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643277; x=1777248077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3pAV2aO/ywH7sA8/DmC18gHblIoCvRksZB2RLc506A=;
        b=psDEi0l6nsDQcWDe9qTiCJ/JwZcnEuHR4YdBhll7UxAtsu67u1tJrQQOkG7Pih5t9F
         bdIpmuYVRPHHnJvvRQiIQSViU+5ARi50/Ou5+06x2OYpLdSM+subCphdbIDVI9sB6Oc0
         SkEix0i7AmzdL2uQj5bjiaUvhgGNbbHFo26i/fCt4Lf5I65SEvcKcwpTTEmOYZk3jFvk
         /QhKyRJA8ybLMmPPjoFHh6i9HjPogKT7f1tknsIErj+7luQHLmo6cjaTxQLtenZkrTl4
         6QTV+3JK7F9glA5msMhYgLnRRar2miaHfv2xYyhULWv81xe8sbydFXNZ/MIoPM0iQsra
         WyVg==
X-Forwarded-Encrypted: i=1; AFNElJ8cQJuDkPZ12E7pXBz1/gWNmc32Pc9kXbeF1k01tw3ditPIZGMEad//BMWdViN0aPUZBRsi8r+bT+xsRM9fR026@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8gGnrzM33Je9ZkZfWSdX4rvigv9MIqsF9IDUwEZRB7/GocmOl
	dxryZdVEhgf2nzuKn30D1D5f1V2EufyRB8M9fDlE8uvwuO6Ypj7rTiTKVPuK3AgcduAG9YzbNju
	I0r0TT/CuBg==
X-Received: from dlae1.prod.google.com ([2002:a05:701b:2301:b0:12a:6959:fb9b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2204:b0:12c:8f92:c6c2
 with SMTP id a92af1059eb24-12c8f92c95bmr172899c88.30.1776643276551; Sun, 19
 Apr 2026 17:01:16 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:59:02 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-51-irogers@google.com>
Subject: [PATCH v1 50/58] perf rwtop: Port rwtop to use python module
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

Port the legacy Perl script rwtop.pl to a python script using the perf
module in tools/perf/python.

The new script uses a class-based architecture and leverages the
perf.session API for event processing.

It periodically displays system-wide r/w call activity, broken down by
PID, refreshed every interval.

Complications:
- Implemented periodic display based on event timestamps
  (sample.sample_time) instead of relying on SIGALRM, making it robust
  for file-based processing.
- Used ANSI escape codes (\x1b[H\x1b[2J) to clear the terminal.
- Fixed unused imports and indentation issues identified by pylint.
- pylint warns about the module name not being snake_case, but it is
  kept for consistency with the original script name.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/rwtop.py | 179 +++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)
 create mode 100755 tools/perf/python/rwtop.py

diff --git a/tools/perf/python/rwtop.py b/tools/perf/python/rwtop.py
new file mode 100755
index 000000000000..e895b34b7114
--- /dev/null
+++ b/tools/perf/python/rwtop.py
@@ -0,0 +1,179 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+"""Periodically displays system-wide r/w call activity, broken down by pid."""
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional, Dict, Any
+import perf
+
+class RwTop:
+    """Periodically displays system-wide r/w call activity."""
+    def __init__(self, interval: int = 3, nlines: int = 20) -> None:
+        self.interval_ns = interval * 1000000000
+        self.nlines = nlines
+        self.reads: Dict[int, Dict[str, Any]] = defaultdict(
+            lambda: {
+                "bytes_requested": 0,
+                "bytes_read": 0,
+                "total_reads": 0,
+                "comm": "",
+                "errors": defaultdict(int),
+            }
+        )
+        self.writes: Dict[int, Dict[str, Any]] = defaultdict(
+            lambda: {
+                "bytes_written": 0,
+                "total_writes": 0,
+                "comm": "",
+                "errors": defaultdict(int),
+            }
+        )
+        self.unhandled: Dict[str, int] = defaultdict(int)
+        self.session: Optional[perf.session] = None
+        self.last_print_time: int = 0
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process events."""
+        event_name = str(sample.evsel)
+        pid = sample.sample_pid
+        sample_time = sample.sample_time
+
+        if self.last_print_time == 0:
+            self.last_print_time = sample_time
+
+        # Check if interval has passed
+        if sample_time - self.last_print_time >= self.interval_ns:
+            self.print_totals()
+            self.last_print_time = sample_time
+
+        assert self.session is not None
+        try:
+            comm = self.session.process(pid).comm()
+        except Exception:  # pylint: disable=broad-except
+            comm = "unknown"
+
+        if "sys_enter_read" in event_name:
+            self._handle_sys_enter_read(sample, pid, comm)
+        elif "sys_exit_read" in event_name:
+            self._handle_sys_exit_read(sample, pid)
+        elif "sys_enter_write" in event_name:
+            self._handle_sys_enter_write(sample, pid, comm)
+        elif "sys_exit_write" in event_name:
+            self._handle_sys_exit_write(sample, pid)
+        else:
+            self.unhandled[event_name] += 1
+
+    def _handle_sys_enter_read(self, sample: perf.sample_event, pid: int, comm: str) -> None:
+        try:
+            count = sample.count
+            self.reads[pid]["bytes_requested"] += count
+            self.reads[pid]["total_reads"] += 1
+            self.reads[pid]["comm"] = comm
+        except AttributeError:
+            pass
+
+    def _handle_sys_exit_read(self, sample: perf.sample_event, pid: int) -> None:
+        try:
+            ret = sample.ret
+            if ret > 0:
+                self.reads[pid]["bytes_read"] += ret
+            else:
+                self.reads[pid]["errors"][ret] += 1
+        except AttributeError:
+            pass
+
+    def _handle_sys_enter_write(self, sample: perf.sample_event, pid: int, comm: str) -> None:
+        try:
+            count = sample.count
+            self.writes[pid]["bytes_written"] += count
+            self.writes[pid]["total_writes"] += 1
+            self.writes[pid]["comm"] = comm
+        except AttributeError:
+            pass
+
+    def _handle_sys_exit_write(self, sample: perf.sample_event, pid: int) -> None:
+        try:
+            ret = sample.ret
+            if ret <= 0:
+                self.writes[pid]["errors"][ret] += 1
+        except AttributeError:
+            pass
+
+    def print_totals(self) -> None:
+        """Print summary tables."""
+        # Clear terminal using ANSI escape codes
+        print("\x1b[H\x1b[2J", end="")
+
+        print("read counts by pid:\n")
+        print(
+            f"{'pid':>6s}  {'comm':<20s}  {'# reads':>10s}  "
+            f"{'bytes_req':>10s}  {'bytes_read':>10s}"
+        )
+        print(f"{'-'*6}  {'-'*20}  {'-'*10}  {'-'*10}  {'-'*10}")
+
+        count = 0
+        for pid, data in sorted(self.reads.items(),
+                                key=lambda kv: kv[1]["bytes_read"], reverse=True):
+            print(
+                f"{pid:6d}  {data['comm']:<20s}  {data['total_reads']:10d}  "
+                f"{data['bytes_requested']:10d}  {data['bytes_read']:10d}"
+            )
+            count += 1
+            if count >= self.nlines:
+                break
+
+        print("\nwrite counts by pid:\n")
+        print(f"{'pid':>6s}  {'comm':<20s}  {'# writes':>10s}  {'bytes_written':>13s}")
+        print(f"{'-'*6}  {'-'*20}  {'-'*10}  {'-'*13}")
+
+        count = 0
+        for pid, data in sorted(self.writes.items(),
+                                key=lambda kv: kv[1]["bytes_written"], reverse=True):
+            print(
+                f"{pid:6d}  {data['comm']:<20s}  "
+                f"{data['total_writes']:10d}  {data['bytes_written']:13d}"
+            )
+            count += 1
+            if count >= self.nlines:
+                break
+
+        # Reset counts
+        self.reads.clear()
+        self.writes.clear()
+
+    def run(self, input_file: str) -> None:
+        """Run the session."""
+        self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        self.session.process_events()
+
+        # Print final totals if there are any left
+        if self.reads or self.writes:
+            self.print_totals()
+
+        if self.unhandled:
+            print("\nunhandled events:\n")
+            print(f"{'event':<40s}  {'count':>10s}")
+            print(f"{'-'*40}  {'-'*10}")
+            for event_name, count in self.unhandled.items():
+                print(f"{event_name:<40s}  {count:10d}")
+
+def main() -> None:
+    """Main function."""
+    parser = argparse.ArgumentParser(description="Trace r/w activity by PID")
+    parser.add_argument(
+        "interval", type=int, nargs="?", default=3, help="Refresh interval in seconds"
+    )
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    args = parser.parse_args()
+
+    analyzer = RwTop(args.interval)
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

