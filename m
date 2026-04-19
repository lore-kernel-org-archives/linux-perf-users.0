Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C3D34403A
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643277; cv=none; b=tbd2PEsEaKPCIRnm0igruguu226ESdbZ8xrZc/WRPwe4PjvErb8SRPDSdVWkRbnhh8LsltQ6TNM41MHJicdXi1ch7JgSZxnaHYEZ0ZC0K1gfYALSfPRz6U5pc8EI/FqIJgEbzeWcyfcVtpv0oPxidozFAvF3U0vodlM7utslUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643277; c=relaxed/simple;
	bh=Wms2iut2NEEogam0qsMKGb4EPklD72Bx8+FrJakfa60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lwIMnDR/2PjnevPwXKr30pYqrM0S/TB8ZOPs22CP5bZ1ItiS5HOXnXvsXKde9imnibrD5qzV+Aj8hm2wu/XiE+rtcBemahTF9aGMah3loF9SeKIPRZUZLAeJ8S+NrYd4f85GMQkwxcfY6t0jwNMZG7uLC18+05lUA7eWKIHZcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kWLzq8X4; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kWLzq8X4"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so3566402eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643275; x=1777248075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d3ZDFQD/M8Q1MsFXzh7U0nnMvPxLz4QA5cfHiT9rvXc=;
        b=kWLzq8X4wPL9MVLnmYEFRoh5xS1fwdKb+ItLC0xhs+5Xysb/hND+GkPgak63RA3mON
         z+bmvaBZ39PeOUBJrjNiNPJIwCNdFe2GsFGa5K+jq6TU3WUOyEvKwNB0OE8kYxOr9HXM
         BxTWMMG+onjEhdZNUa28yir43+6Ttc5RegUxzroZECQe2IWMuTrsHe55Rxjjbk0nztn+
         1szXMXx6tnWm+zZjRDzmZ1GevcqUuWGB4b/GL7VTwUevDRazi1r1J9dd4Jc8n1SAtDY5
         zMIGEUNDQMzQZ0HCfOUuNPh7DT9oyQLKtNrX2Nm9nzGxHKyKfh7IhgPHDSv84bDVplVd
         mBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643275; x=1777248075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3ZDFQD/M8Q1MsFXzh7U0nnMvPxLz4QA5cfHiT9rvXc=;
        b=elTyurR2K/nYBBNkgReTVnEE6LXsHoB2uKE0suuMRTDUUeKTlN3gdKSnwrKoUNlqzK
         pqUlYAfyMmrroiPS8x78lhqr3fGfgfTDevi61upzhKSJ6Gpa15RSC4N4KKIqZLwiLnX8
         b0N3JyHhZ62rsazhxi0FmqywX8GC3vK7nukaNWNNJbMomn9yYcote1aH48meIImPac4/
         Gx3zhAlH8bYXASCAmd5HFFRmaJwsr3kpNkOj1DSylSotTxcG7KKLCxcT7QqQ3ASkl+Qj
         T2TjRoWFdTzipWWfFWZaQaoVCBGbeKc5KsIN1cJPpzKzrtaW4xE2qiIFFFI9jsvcPGdr
         +8vw==
X-Forwarded-Encrypted: i=1; AFNElJ+e8f1aEuV6WeT4dbNnUSoco1d1NY+HCyJpnkFRhOdtcu2+dkgZxUzI/gINNQm+Lg1YnQyHqBOcKsNjw+tv7c3o@vger.kernel.org
X-Gm-Message-State: AOJu0YxHOz2RLQ4vHC4RKe73ecxZsCCXxhMfi1CQuStrkRWlOzBoguml
	a0UyfgtOwkkIG4EBMMYCyw+P/XFVlRAfCw/ZcXRF0cE/jMRi6G6AxW3aAg5eoWLPdshjbMPRDx0
	PBA9INf9yzQ==
X-Received: from dybtv6.prod.google.com ([2002:a05:7300:f486:b0:2d8:5b05:964b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc05:b0:2c0:bfe3:b95c
 with SMTP id 5a478bee46e88-2e466044086mr5214764eec.4.1776643274319; Sun, 19
 Apr 2026 17:01:14 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:59:01 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-50-irogers@google.com>
Subject: [PATCH v1 49/58] perf rw-by-pid: Port rw-by-pid to use python module
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

Port the legacy Perl script rw-by-pid.pl to a python script using the
perf module in tools/perf/python.

The new script uses a class-based architecture and leverages the
perf.session API for event processing.

It tracks read and write activity by PID for all processes,
aggregating bytes requested, bytes read, total reads, and errors.

Complications:
- Refactored process_event to extract helper methods
  (_handle_sys_enter_read, etc.) to reduce the number of branches and
  satisfy pylint.
- Split long lines to comply with line length limits.
- pylint warns about the module name not being snake_case, but it is
  kept for consistency with the original script name.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/rw-by-pid.py | 170 +++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100755 tools/perf/python/rw-by-pid.py

diff --git a/tools/perf/python/rw-by-pid.py b/tools/perf/python/rw-by-pid.py
new file mode 100755
index 000000000000..7bb51d15eb8d
--- /dev/null
+++ b/tools/perf/python/rw-by-pid.py
@@ -0,0 +1,170 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+"""Display r/w activity for all processes."""
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional, Dict, List, Tuple, Any
+import perf
+
+class RwByPid:
+    """Tracks and displays read/write activity by PID."""
+    def __init__(self) -> None:
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
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process events."""
+        event_name = str(sample.evsel)
+        pid = sample.sample_pid
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
+        print("read counts by pid:\n")
+        print(
+            f"{'pid':>6s}  {'comm':<20s}  {'# reads':>10s}  "
+            f"{'bytes_requested':>15s}  {'bytes_read':>10s}"
+        )
+        print(f"{'-'*6}  {'-'*20}  {'-'*10}  {'-'*15}  {'-'*10}")
+
+        for pid, data in sorted(self.reads.items(),
+                                key=lambda kv: kv[1]["bytes_read"], reverse=True):
+            print(
+                f"{pid:6d}  {data['comm']:<20s}  {data['total_reads']:10d}  "
+                f"{data['bytes_requested']:15d}  {data['bytes_read']:10d}"
+            )
+
+        print("\nfailed reads by pid:\n")
+        print(f"{'pid':>6s}  {'comm':<20s}  {'error #':>6s}  {'# errors':>10s}")
+        print(f"{'-'*6}  {'-'*20}  {'-'*6}  {'-'*10}")
+
+        errcounts: List[Tuple[int, str, int, int]] = []
+        for pid, data in self.reads.items():
+            for error, count in data["errors"].items():
+                errcounts.append((pid, data["comm"], error, count))
+
+        for pid, comm, error, count in sorted(errcounts, key=lambda x: x[3], reverse=True):
+            print(f"{pid:6d}  {comm:<20s}  {error:6d}  {count:10d}")
+
+        print("\nwrite counts by pid:\n")
+        print(f"{'pid':>6s}  {'comm':<20s}  {'# writes':>10s}  {'bytes_written':>15s}")
+        print(f"{'-'*6}  {'-'*20}  {'-'*10}  {'-'*15}")
+
+        for pid, data in sorted(self.writes.items(),
+                                key=lambda kv: kv[1]["bytes_written"], reverse=True):
+            print(
+                f"{pid:6d}  {data['comm']:<20s}  "
+                f"{data['total_writes']:10d}  {data['bytes_written']:15d}"
+            )
+
+        print("\nfailed writes by pid:\n")
+        print(f"{'pid':>6s}  {'comm':<20s}  {'error #':>6s}  {'# errors':>10s}")
+        print(f"{'-'*6}  {'-'*20}  {'-'*6}  {'-'*10}")
+
+        errcounts = []
+        for pid, data in self.writes.items():
+            for error, count in data["errors"].items():
+                errcounts.append((pid, data["comm"], error, count))
+
+        for pid, comm, error, count in sorted(errcounts, key=lambda x: x[3], reverse=True):
+            print(f"{pid:6d}  {comm:<20s}  {error:6d}  {count:10d}")
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
+    parser = argparse.ArgumentParser(description="Trace r/w activity by PID")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file")
+    args = parser.parse_args()
+
+    analyzer = RwByPid()
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

