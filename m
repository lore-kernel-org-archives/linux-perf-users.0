Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334373E120E
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881818; cv=none; b=Npd+uUgw5UG/PYjtr0sia+Ergj9HrBIUHMlKUc44uWf5onyjKhoOqWi6816cQwa2QX+ekVZ3Mq3T8er/z8hbVTJaH42CSoy2oyX3Ts0C8CqyHOAIGRwmEMtEp6GOTmgXRViq9Kr0HgjQ6HNfkaEHMoZmqj1ylHmzridbpzQcx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881818; c=relaxed/simple;
	bh=oFUKQdzRPt0lKsOfeD4roXrBNtLd0gqNuPOn6z2YOYM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JQqWmSZEJHcrqvWQZ2lo0qUd0vXLGJ4tkXEVohV4V8JsZekeVv0jJNBlB1hkFWPF8PG8dR9gK9kWBrIAsFXodyBjZFYmGzYV8R4IPCpNIFT+zCWpcz1bRcLm7bsW/vtALl1yyexVtqsM5FaC1quTTixyZhmvqMHhgYYfNoH2a10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sxhbexH6; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxhbexH6"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso3774746a91.0
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881814; x=1790486614; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPhB6c1iOvOV+KJ+XHJ/b0xUm+6wqH+kev5/AMV/aYI=;
        b=sxhbexH6oQFvT3QVdPcig6O4u3GYiYni1zZwEJcpYaT5eYkpF0i+ZxYv8ilCjOv+lU
         qgEgZsn8dokRyjdeDBI2CQfhjYisqOZihUNt+cegnBsrKbSVEMxuk5+DxMGWzw5vdNEh
         +xMJYaWFqc7hiSdEUK/fk7D6eMWFlXdeE8x/sfZlpfpKVm+/a3W3dIe0n3+oPxZcr02U
         4+KWmJAeREr8ahp1rFIGML2EalcoS3ziHparcfUT5XhLDPwk/mmThvSF8AviskZrja+e
         RfCdk/IvW7m5T1r+BA4Aj0dpZZ5ol4rMwDflxiuhSK+BOsdQW7Fd1bdhQG1uV3DaQ3hb
         10eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881814; x=1790486614;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPhB6c1iOvOV+KJ+XHJ/b0xUm+6wqH+kev5/AMV/aYI=;
        b=rnEUkThZH1WhHP6dfl4xkDQGyBjgy8Lm27XjImyi/fNs5KVOrK+o01BC2Vw/cwr+eh
         Wwp8JbFJYAmd5P+tdk8sc6vuygGj4yQRuue15qihq/BVNqdEAv62u49CnAgo8Z5xmyd8
         tGo6tvMFZOiM+ELAQmK4Wps5GGtNHO+8fhkZcN2xwI2r5xbaFV5wpfz+yj3LkRtBaenh
         sYHBzobvDS2VQjng5HefDnM6Zz4rRPJ4xfGCBhzxgceAyeLud4WMUki640+2YWH3RsXj
         RVbk5Qx0xgCfcsRqfcjmE2YtBdSPTZItxJoDfMYJ+3gjlhTkPVj53wmhpJGMQsVN4Nqk
         Vbow==
X-Forwarded-Encrypted: i=1; AKwUvBy30Bi3FC2z70f0STdAl3Qjs5Li7fxiU8jj0G2//cTo9sFTKoADp32DUK1N070CkUUHNKfQGICLwEJkSyJj8kmY@vger.kernel.org
X-Gm-Message-State: AFuF++kzvsqb746Z3RvqREu25AR2HQ5CW/CTGANd9rDOnmT7kjPpt4tL
	q/958Ibhk+grAYMQwba8e0w5G9rxvr261YRbFqgN33/hRZT6oF7/kcm41sr2oDP2n40afzq7D7q
	MRWYaHPN1bg==
X-Received: from dldnz4.prod.google.com ([2002:a05:701a:ca04:b0:143:75c2:6d21])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c03:b0:39e:4c80:44ba
 with SMTP id 98e67ed59e1d1-39e54dcc3ccmr12235841a91.29.1789881814008; Sat, 19
 Sep 2026 22:23:34 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:23 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <492549293c5943ab7cf573695f308955da130be8.1789880842.git.irogers@google.com>
Subject: [PATCH v1 31/49] perf python: Port task-analyzer to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port task-analyzer.py from tools/perf/scripts/python/ to a standalone
script in tools/perf/python/ refactored into a class-based architecture.

Improvements compared to the legacy script:
- Support both offline perf.data file analysis (using perf.session) and
  live trace capture (using evlist.read_on_cpu), accessing
  sched:sched_switch tracepoint fields directly from sample objects.
- Automatically disable ANSI terminal color escape sequences when --csv
  or --csv-summary is enabled so CSV column headers ('Comm,',
  'Time Out-Out,', etc.) are never polluted by color codes when running
  interactively on a TTY (e.g. as root).
- Sanitize non-printable characters and leading CSV formula characters
  (=, +, -, @) in task comm strings.
- Emit a one-time warning to stderr if sched:sched_switch samples are
  missing tracepoint fields (such as when recorded without libtraceevent
  support).

Update test_task_analyzer.sh to invoke the standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/task-analyzer.py           | 881 +++++++++++++++++++
 tools/perf/tests/shell/test_task_analyzer.sh |  97 +-
 2 files changed, 945 insertions(+), 33 deletions(-)
 create mode 100755 tools/perf/python/task-analyzer.py

diff --git a/tools/perf/python/task-analyzer.py b/tools/perf/python/task-analyzer.py
new file mode 100755
index 000000000000..a39bdfe32fc1
--- /dev/null
+++ b/tools/perf/python/task-analyzer.py
@@ -0,0 +1,881 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# task-analyzer.py - comprehensive perf tasks analysis
+# Copyright (c) 2022, Hagen Paul Pfeifer <hagen@jauu.net>
+# Licensed under the terms of the GNU GPL License version 2
+#
+# Usage:
+#
+#     perf record -e sched:sched_switch -a -- sleep 10
+#     ./task-analyzer.py
+#
+"""Comprehensive perf tasks analysis."""
+from __future__ import annotations
+
+import argparse
+from contextlib import contextmanager
+import decimal
+
+from typing import List, Dict, Union
+
+def _median(numbers: List[decimal.Decimal]) -> decimal.Decimal:
+    """phython3 hat statistics module - we have nothing"""
+    n = len(numbers)
+    index = n // 2
+    if n % 2:
+        return sorted(numbers)[index]
+    return sum(sorted(numbers)[index - 1 : index + 1]) / decimal.Decimal(2)
+
+def _mean(numbers: List[decimal.Decimal]) -> decimal.Decimal:
+    return sum(numbers) / decimal.Decimal(len(numbers))
+
+import os
+import string
+import sys
+from typing import Any, Optional
+import perf
+
+
+# Columns will have a static size to align everything properly
+# Support of 116 days of active update with nano precision
+LEN_SWITCHED_IN = len("9999999.999999999")
+LEN_SWITCHED_OUT = len("9999999.999999999")
+LEN_CPU = len("000")
+LEN_PID = len("maxvalue")
+LEN_TID = len("maxvalue")
+LEN_COMM = len("max-comms-length")
+LEN_RUNTIME = len("999999.999")
+# Support of 3.45 hours of timespans
+LEN_OUT_IN = len("99999999999.999")
+LEN_OUT_OUT = len("99999999999.999")
+LEN_IN_IN = len("99999999999.999")
+LEN_IN_OUT = len("99999999999.999")
+
+class Timespans:
+    """Tracks elapsed time between occurrences of the same task."""
+    def __init__(self, args: argparse.Namespace, time_unit: str) -> None:
+        self.args = args
+        self.time_unit = time_unit
+        self._last_start: Optional[decimal.Decimal] = None
+        self._last_finish: Optional[decimal.Decimal] = None
+        self.current = {
+            'out_out': decimal.Decimal(-1),
+            'in_out': decimal.Decimal(-1),
+            'out_in': decimal.Decimal(-1),
+            'in_in': decimal.Decimal(-1)
+        }
+        if args.summary_extended:
+            self._time_in: decimal.Decimal = decimal.Decimal(-1)
+            self.max_vals = {
+                'out_in': decimal.Decimal(-1),
+                'at': decimal.Decimal(-1),
+                'in_out': decimal.Decimal(-1),
+                'in_in': decimal.Decimal(-1),
+                'out_out': decimal.Decimal(-1)
+            }
+
+    def feed(self, task: 'Task') -> None:
+        """Calculate timespans from chronological task occurrences."""
+        if not self._last_finish:
+            self._last_start = task.time_in(self.time_unit)
+            self._last_finish = task.time_out(self.time_unit)
+            return
+        assert self._last_start is not None
+        assert self._last_finish is not None
+        self._time_in = task.time_in()
+        time_in = task.time_in(self.time_unit)
+        time_out = task.time_out(self.time_unit)
+        self.current['in_in'] = time_in - self._last_start
+        self.current['out_in'] = time_in - self._last_finish
+        self.current['in_out'] = time_out - self._last_start
+        self.current['out_out'] = time_out - self._last_finish
+        if self.args.summary_extended:
+            self.update_max_entries()
+        self._last_finish = task.time_out(self.time_unit)
+        self._last_start = task.time_in(self.time_unit)
+
+    def update_max_entries(self) -> None:
+        """Update maximum timespans."""
+        self.max_vals['in_in'] = max(self.max_vals['in_in'], self.current['in_in'])
+        self.max_vals['out_out'] = max(self.max_vals['out_out'], self.current['out_out'])
+        self.max_vals['in_out'] = max(self.max_vals['in_out'], self.current['in_out'])
+        if self.current['out_in'] > self.max_vals['out_in']:
+            self.max_vals['out_in'] = self.current['out_in']
+            self.max_vals['at'] = self._time_in
+
+class Task:
+    """Handles information of a given task."""
+    def __init__(self, task_id: str, tid: int, cpu: int, comm: str) -> None:
+        self.id = task_id
+        self.tid = tid
+        self.cpu = cpu
+        self.comm = comm
+        self.pid: Optional[int] = None
+        self._time_in: Optional[decimal.Decimal] = None
+        self._time_out: Optional[decimal.Decimal] = None
+
+    def schedule_in_at(self, time_ns: int) -> None:
+        """Set schedule in time."""
+        self._time_in = decimal.Decimal(time_ns) / decimal.Decimal(1e9)
+
+    def schedule_out_at(self, time_ns: int) -> None:
+        """Set schedule out time."""
+        self._time_out = decimal.Decimal(time_ns) / decimal.Decimal(1e9)
+
+    def time_out(self, unit: str = "s") -> decimal.Decimal:
+        """Return schedule out time."""
+        factor = TaskAnalyzer.time_uniter(unit)
+        return self._time_out * decimal.Decimal(factor) if self._time_out else decimal.Decimal(0)
+
+    def time_in(self, unit: str = "s") -> decimal.Decimal:
+        """Return schedule in time."""
+        factor = TaskAnalyzer.time_uniter(unit)
+        return self._time_in * decimal.Decimal(factor) if self._time_in else decimal.Decimal(0)
+
+    def runtime(self, unit: str = "us") -> decimal.Decimal:
+        """Return runtime."""
+        factor = TaskAnalyzer.time_uniter(unit)
+        if self._time_out is not None and self._time_in is not None:
+            return (self._time_out - self._time_in) * decimal.Decimal(factor)
+        return decimal.Decimal(0)
+
+    def update_pid(self, pid: int) -> None:
+        """Update PID."""
+        self.pid = pid
+
+class Summary:
+    """
+    Primary instance for calculating the summary output. Processes the whole trace to
+    find and memorize relevant data such as mean, max et cetera. This instance handles
+    dynamic alignment aspects for summary output.
+    """
+
+    def __init__(self, analyzer):
+        self.analyzer = analyzer
+        self.args = analyzer.args
+        self.db = analyzer.db
+        self.time_unit = analyzer.time_unit
+        self.fd_sum = analyzer.fd_sum
+        self._body = []
+
+    class AlignmentHelper:
+        """
+        Used to calculated the alignment for the output of the summary.
+        """
+        def __init__(self, pid, tid, comm, runs, acc, mean,
+                    median, min_val, max_val, max_at):
+            self.pid = pid
+            self.tid = tid
+            self.comm = comm
+            self.runs = runs
+            self.acc = acc
+            self.mean = mean
+            self.median = median
+            self.min = min_val
+            self.max = max_val
+            self.max_at = max_at
+            self.out_in = None
+            self.inter_at = None
+            self.out_out = None
+            self.in_in = None
+            self.in_out = None
+
+    def _print_header(self):
+        '''
+        Output is trimmed in _format_stats thus additional adjustment in the header
+        is needed, depending on the choice of timeunit. The adjustment corresponds
+        to the amount of column titles being adjusted in _column_titles.
+        '''
+        decimal_precision = 6 if not self.args.ns else 9
+        fmt = " {{:^{}}}".format(sum(self.db["task_info"].values()))
+        fmt += " {{:^{}}}".format(
+            max(0, sum(self.db["runtime_info"].values()) - 2 * decimal_precision)
+            )
+        _header = ("Task Information", "Runtime Information")
+
+        if self.args.summary_extended:
+            fmt += " {{:^{}}}".format(
+                max(0, sum(self.db["inter_times"].values()) - 4 * decimal_precision)
+                )
+            _header += ("Max Inter Task Times",)
+        self.fd_sum.write(fmt.format(*_header) +  "\n")
+
+    def _column_titles(self):
+        """
+        Cells are being processed and displayed in different way so an alignment adjust
+        is implemented depeding on the choice of the timeunit. The positions of the max
+        values are being displayed in grey. Thus in their format two additional {},
+        are placed for color set and reset.
+        """
+        separator, fix_csv_align = self.analyzer.prepare_fmt_sep(is_summary=True)
+        decimal_precision, time_precision = self.analyzer.prepare_fmt_precision()
+        fmt = "{{:>{}}}".format(self.db["task_info"]["pid"] * fix_csv_align)
+        fmt += "{}{{:>{}}}".format(separator, self.db["task_info"]["tid"] * fix_csv_align)
+        fmt += "{}{{:>{}}}".format(separator, self.db["task_info"]["comm"] * fix_csv_align)
+        fmt += "{}{{:>{}}}".format(separator, self.db["runtime_info"]["runs"] * fix_csv_align)
+        fmt += "{}{{:>{}}}".format(separator, self.db["runtime_info"]["acc"] * fix_csv_align)
+        fmt += "{}{{:>{}}}".format(separator, self.db["runtime_info"]["mean"] * fix_csv_align)
+        fmt += "{}{{:>{}}}".format(
+            separator, self.db["runtime_info"]["median"] * fix_csv_align
+        )
+        fmt += "{}{{:>{}}}".format(
+            separator, max(0, self.db["runtime_info"]["min"] - decimal_precision) * fix_csv_align
+        )
+        fmt += "{}{{:>{}}}".format(
+            separator, max(0, self.db["runtime_info"]["max"] - decimal_precision) * fix_csv_align
+        )
+        fmt += "{}{{}}{{:>{}}}{{}}".format(
+            separator, max(0, self.db["runtime_info"]["max_at"] - time_precision) * fix_csv_align
+        )
+
+        grey = "" if self.args.csv_summary else TaskAnalyzer.COLORS["grey"]
+        reset = "" if self.args.csv_summary else TaskAnalyzer.COLORS["reset"]
+        column_titles = ("PID", "TID", "Comm")
+        column_titles += ("Runs", "Accumulated", "Mean", "Median", "Min", "Max")
+        column_titles += (grey, "Max At", reset)
+
+        if self.args.summary_extended:
+            fmt += "{}{{:>{}}}".format(
+                separator,
+                max(0, self.db["inter_times"]["out_in"] - decimal_precision) * fix_csv_align
+            )
+            fmt += "{}{{}}{{:>{}}}{{}}".format(
+                separator,
+                max(0, self.db["inter_times"]["inter_at"] - time_precision) * fix_csv_align
+            )
+            fmt += "{}{{:>{}}}".format(
+                separator,
+                max(0, self.db["inter_times"]["out_out"] - decimal_precision) * fix_csv_align
+            )
+            fmt += "{}{{:>{}}}".format(
+                separator,
+                max(0, self.db["inter_times"]["in_in"] - decimal_precision) * fix_csv_align
+            )
+            fmt += "{}{{:>{}}}".format(
+                separator,
+                max(0, self.db["inter_times"]["in_out"] - decimal_precision) * fix_csv_align
+            )
+
+            column_titles += (
+                "Out-In", grey, "Max At",
+                reset, "Out-Out", "In-In", "In-Out"
+            )
+
+        self.fd_sum.write(fmt.format(*column_titles) + "\n")
+
+
+    def _task_stats(self):
+        """calculates the stats of every task and constructs the printable summary"""
+        grey = "" if self.args.csv_summary else TaskAnalyzer.COLORS["grey"]
+        reset = "" if self.args.csv_summary else TaskAnalyzer.COLORS["reset"]
+        for tid in sorted(self.db["tid"]):
+            color_one_sample = grey
+            color_reset = reset
+            no_executed = 0
+            runtimes = []
+            time_in = []
+            timespans = Timespans(self.args, self.time_unit)
+            for task in self.db["tid"][tid]:
+                pid = task.pid
+                comm = task.comm
+                no_executed += 1
+                runtimes.append(task.runtime(self.time_unit))
+                time_in.append(task.time_in())
+                timespans.feed(task)
+            if len(runtimes) > 1:
+                color_one_sample = ""
+                color_reset = ""
+            time_max = max(runtimes)
+            time_min = min(runtimes)
+            max_at = time_in[runtimes.index(max(runtimes))]
+
+            # The size of the decimal after sum,mean and median varies, thus we cut
+            # the decimal number, by rounding it. It has no impact on the output,
+            # because we have a precision of the decimal points at the output.
+            time_sum = round(sum(runtimes), 3)
+            time_mean = round(_mean(runtimes), 3)
+            time_median = round(_median(runtimes), 3)
+
+            align_helper = self.AlignmentHelper(pid, tid, comm, no_executed, time_sum,
+                                    time_mean, time_median, time_min, time_max, max_at)
+            self._body.append([
+                pid, tid, comm, no_executed, time_sum, color_one_sample,
+                time_mean, time_median, time_min, time_max,
+                grey, max_at,
+                reset, color_reset
+            ])
+            if self.args.summary_extended:
+                self._body[-1].extend([timespans.max_vals['out_in'],
+                                grey, timespans.max_vals['at'],
+                                reset, timespans.max_vals['out_out'],
+                                timespans.max_vals['in_in'],
+                                timespans.max_vals['in_out']])
+                align_helper.out_in = timespans.max_vals['out_in']
+                align_helper.inter_at = timespans.max_vals['at']
+                align_helper.out_out = timespans.max_vals['out_out']
+                align_helper.in_in = timespans.max_vals['in_in']
+                align_helper.in_out = timespans.max_vals['in_out']
+            self._calc_alignments_summary(align_helper)
+
+    def _format_stats(self):
+        separator, fix_csv_align = self.analyzer.prepare_fmt_sep(is_summary=True)
+        decimal_precision, time_precision = self.analyzer.prepare_fmt_precision()
+        len_pid = self.db["task_info"]["pid"] * fix_csv_align
+        len_tid = self.db["task_info"]["tid"] * fix_csv_align
+        len_comm = self.db["task_info"]["comm"] * fix_csv_align
+        len_runs = self.db["runtime_info"]["runs"] * fix_csv_align
+        len_acc = self.db["runtime_info"]["acc"] * fix_csv_align
+        len_mean = self.db["runtime_info"]["mean"] * fix_csv_align
+        len_median = self.db["runtime_info"]["median"] * fix_csv_align
+        len_min = max(0, self.db["runtime_info"]["min"] - decimal_precision) * fix_csv_align
+        len_max = max(0, self.db["runtime_info"]["max"] - decimal_precision) * fix_csv_align
+        len_max_at = max(0, self.db["runtime_info"]["max_at"] - time_precision) * fix_csv_align
+        if self.args.summary_extended:
+            len_out_in = max(0,
+                self.db["inter_times"]["out_in"] - decimal_precision
+            ) * fix_csv_align
+            len_inter_at = max(0,
+                self.db["inter_times"]["inter_at"] - time_precision
+            ) * fix_csv_align
+            len_out_out = max(0,
+                self.db["inter_times"]["out_out"] - decimal_precision
+            ) * fix_csv_align
+            len_in_in = max(0, self.db["inter_times"]["in_in"] - decimal_precision) * fix_csv_align
+            len_in_out = max(0,
+                self.db["inter_times"]["in_out"] - decimal_precision
+            ) * fix_csv_align
+
+        fmt = "{{:{}d}}".format(len_pid)
+        fmt += "{}{{:{}d}}".format(separator, len_tid)
+        fmt += "{}{{:>{}}}".format(separator, len_comm)
+        fmt += "{}{{:{}d}}".format(separator, len_runs)
+        fmt += "{}{{:{}.{}f}}".format(separator, len_acc, time_precision)
+        fmt += "{}{{}}{{:{}.{}f}}".format(separator, len_mean, time_precision)
+        fmt += "{}{{:{}.{}f}}".format(separator, len_median, time_precision)
+        fmt += "{}{{:{}.{}f}}".format(separator, len_min, time_precision)
+        fmt += "{}{{:{}.{}f}}".format(separator, len_max, time_precision)
+        fmt += "{}{{}}{{:{}.{}f}}{{}}{{}}".format(
+            separator, len_max_at, decimal_precision
+        )
+        if self.args.summary_extended:
+            fmt += "{}{{:{}.{}f}}".format(separator, len_out_in, time_precision)
+            fmt += "{}{{}}{{:{}.{}f}}{{}}".format(
+                separator, len_inter_at, decimal_precision
+            )
+            fmt += "{}{{:{}.{}f}}".format(separator, len_out_out, time_precision)
+            fmt += "{}{{:{}.{}f}}".format(separator, len_in_in, time_precision)
+            fmt += "{}{{:{}.{}f}}".format(separator, len_in_out, time_precision)
+        return fmt
+
+
+    def _calc_alignments_summary(self, align_helper):
+        # Length is being cut in 3 groups so that further addition is easier to handle.
+        # The length of every argument from the alignment helper is being checked if it
+        # is longer than the longest until now. In that case the length is being saved.
+        for key in self.db["task_info"]:
+            if len(str(getattr(align_helper, key))) > self.db["task_info"][key]:
+                self.db["task_info"][key] = len(str(getattr(align_helper, key)))
+        for key in self.db["runtime_info"]:
+            if len(str(getattr(align_helper, key))) > self.db["runtime_info"][key]:
+                self.db["runtime_info"][key] = len(str(getattr(align_helper, key)))
+        if self.args.summary_extended:
+            for key in self.db["inter_times"]:
+                if len(str(getattr(align_helper, key))) > self.db["inter_times"][key]:
+                    self.db["inter_times"][key] = len(str(getattr(align_helper, key)))
+
+
+    def print(self):
+        self._task_stats()
+        fmt = self._format_stats()
+
+        if not self.args.csv_summary:
+            print("\nSummary", file=self.fd_sum)
+            self._print_header()
+        self._column_titles()
+        for i in range(len(self._body)):
+            self.fd_sum.write(fmt.format(*tuple(self._body[i])) + "\n")
+
+
+
+
+class TaskAnalyzer:
+
+    """Main class for task analysis."""
+
+    COLORS = {
+        "grey": "\033[90m",
+        "red": "\033[91m",
+        "green": "\033[92m",
+        "yellow": "\033[93m",
+        "blue": "\033[94m",
+        "violet": "\033[95m",
+        "reset": "\033[0m",
+    }
+
+    def __init__(self, args: argparse.Namespace) -> None:
+        self.args = args
+        self.db: Dict[str, Any] = {}
+        self.session: Optional[perf.session] = None
+        self._tgid_cache: Dict[int, int] = {}
+        self.time_unit = "us"
+        if args.ns:
+            self.time_unit = "ns"
+        elif args.ms:
+            self.time_unit = "ms"
+        self._init_db()
+        self._check_color()
+        self.fd_task = sys.stdout
+        self.fd_sum = sys.stdout
+
+    @contextmanager
+    def open_output(self, filename: str, default: Any):
+        """Context manager for file or stdout."""
+        if filename:
+            with open(filename, "w", encoding="utf-8") as f:
+                yield f
+        else:
+            yield default
+
+    def _init_db(self) -> None:
+        self.db["running"] = {}
+        self.db["tid"] = {}
+        self.db["global"] = []
+        if (self.args.summary or self.args.summary_extended or
+                self.args.summary_only or self.args.csv_summary):
+            self.db["task_info"] = {}
+            self.db["runtime_info"] = {}
+            self.db["task_info"]["pid"] = len("PID")
+            self.db["task_info"]["tid"] = len("TID")
+            self.db["task_info"]["comm"] = len("Comm")
+            self.db["runtime_info"]["runs"] = len("Runs")
+            self.db["runtime_info"]["acc"] = len("Accumulated")
+            self.db["runtime_info"]["max"] = len("Max")
+            self.db["runtime_info"]["max_at"] = len("Max At")
+            self.db["runtime_info"]["min"] = len("Min")
+            self.db["runtime_info"]["mean"] = len("Mean")
+            self.db["runtime_info"]["median"] = len("Median")
+            if self.args.summary_extended:
+                self.db["inter_times"] = {}
+                self.db["inter_times"]["out_in"] = len("Out-In")
+                self.db["inter_times"]["inter_at"] = len("Max At")
+                self.db["inter_times"]["out_out"] = len("Out-Out")
+                self.db["inter_times"]["in_in"] = len("In-In")
+                self.db["inter_times"]["in_out"] = len("In-Out")
+
+    def _check_color(self) -> None:
+        """Check if color should be enabled."""
+        if self.args.csv:
+            TaskAnalyzer.COLORS = {k: "" for k in TaskAnalyzer.COLORS}
+            return
+        if sys.stdout.isatty() and self.args.stdio_color != "never":
+            return
+        if self.args.stdio_color == "always":
+            return
+        TaskAnalyzer.COLORS = {k: "" for k in TaskAnalyzer.COLORS}
+
+    @staticmethod
+    def time_uniter(unit: str) -> float:
+        """Return time unit factor."""
+        picker = {"s": 1, "ms": 1e3, "us": 1e6, "ns": 1e9}
+        return picker[unit]
+
+    def _task_id(self, pid: int, cpu: int) -> str:
+        return f"{pid}-{cpu}"
+
+    def _filter_non_printable(self, unfiltered: Union[str, bytearray]) -> str:
+        if isinstance(unfiltered, (bytearray, bytes)):
+            unfiltered = unfiltered.decode('utf-8', 'ignore')
+        filtered = ""
+        for char in unfiltered:
+            if char in string.printable and char not in "\r\n\t\x0b\x0c;":
+                filtered += char
+        stripped = filtered.lstrip()
+        if stripped and stripped[0] in "=+-@":
+            filtered = "_" + stripped[1:]
+        return filtered
+
+    def prepare_fmt_precision(self) -> tuple[int, int]:
+        if self.args.ns:
+            return 9, 0
+        return 6, 3
+
+    def prepare_fmt_sep(self, is_summary: bool = False) -> tuple[str, int]:
+        if (is_summary and self.args.csv_summary) or (not is_summary and self.args.csv):
+            return ";", 0
+        return " ", 1
+
+    def _fmt_header(self) -> str:
+        separator, fix_csv_align = self.prepare_fmt_sep()
+        fmt = f"{{:>{LEN_SWITCHED_IN*fix_csv_align}}}"
+        fmt += f"{separator}{{:>{LEN_SWITCHED_OUT*fix_csv_align}}}"
+        fmt += f"{separator}{{:>{LEN_CPU*fix_csv_align}}}"
+        fmt += f"{separator}{{:>{LEN_PID*fix_csv_align}}}"
+        fmt += f"{separator}{{:>{LEN_TID*fix_csv_align}}}"
+        fmt += f"{separator}{{:>{LEN_COMM*fix_csv_align}}}"
+        fmt += f"{separator}{{:>{LEN_RUNTIME*fix_csv_align}}}"
+        fmt += f"{separator}{{:>{LEN_OUT_IN*fix_csv_align}}}"
+        if self.args.extended_times:
+            fmt += f"{separator}{{:>{LEN_OUT_OUT*fix_csv_align}}}"
+            fmt += f"{separator}{{:>{LEN_IN_IN*fix_csv_align}}}"
+            fmt += f"{separator}{{:>{LEN_IN_OUT*fix_csv_align}}}"
+        return fmt
+
+    def _fmt_body(self) -> str:
+        separator, fix_csv_align = self.prepare_fmt_sep()
+        decimal_precision, time_precision = self.prepare_fmt_precision()
+        fmt = f"{{}}{{:{LEN_SWITCHED_IN*fix_csv_align}.{decimal_precision}f}}"
+        fmt += f"{separator}{{:{LEN_SWITCHED_OUT*fix_csv_align}.{decimal_precision}f}}"
+        fmt += f"{separator}{{:{LEN_CPU*fix_csv_align}d}}"
+        fmt += f"{separator}{{:{LEN_PID*fix_csv_align}d}}"
+        fmt += f"{separator}{{}}{{:{LEN_TID*fix_csv_align}d}}{{}}"
+        fmt += f"{separator}{{}}{{:>{LEN_COMM*fix_csv_align}}}"
+        fmt += f"{separator}{{:{LEN_RUNTIME*fix_csv_align}.{time_precision}f}}"
+        if self.args.extended_times:
+            fmt += f"{separator}{{:{LEN_OUT_IN*fix_csv_align}.{time_precision}f}}"
+            fmt += f"{separator}{{:{LEN_OUT_OUT*fix_csv_align}.{time_precision}f}}"
+            fmt += f"{separator}{{:{LEN_IN_IN*fix_csv_align}.{time_precision}f}}"
+            fmt += f"{separator}{{:{LEN_IN_OUT*fix_csv_align}.{time_precision}f}}{{}}"
+        else:
+            fmt += f"{separator}{{:{LEN_OUT_IN*fix_csv_align}.{time_precision}f}}{{}}"
+        return fmt
+
+    def _print_header(self) -> None:
+        fmt = self._fmt_header()
+        header = ["Switched-In", "Switched-Out", "CPU", "PID", "TID", "Comm",
+                  "Runtime", "Time Out-In"]
+        if self.args.extended_times:
+            header += ["Time Out-Out", "Time In-In", "Time In-Out"]
+        self.fd_task.write(fmt.format(*header) + "\n")
+
+    def _print_task_finish(self, task: Task) -> None:
+        c_row_set = ""
+        c_row_reset = ""
+        out_in: Any = -1
+        out_out: Any = -1
+        in_in: Any = -1
+        in_out: Any = -1
+        fmt = self._fmt_body()
+
+        if str(task.tid) in self.args.highlight_tasks_map:
+            c_row_set = TaskAnalyzer.COLORS.get(self.args.highlight_tasks_map[str(task.tid)], '')
+            c_row_reset = TaskAnalyzer.COLORS["reset"]
+        if task.comm in self.args.highlight_tasks_map:
+            c_row_set = TaskAnalyzer.COLORS.get(self.args.highlight_tasks_map[task.comm], '')
+            c_row_reset = TaskAnalyzer.COLORS["reset"]
+
+        c_tid_set = ""
+        c_tid_reset = ""
+        if task.pid == task.tid:
+            c_tid_set = TaskAnalyzer.COLORS["grey"]
+            c_tid_reset = TaskAnalyzer.COLORS["reset"]
+
+        if task.tid in self.db["tid"]:
+            last_tid_task = self.db["tid"][task.tid][-1]
+            timespan_gap_tid = Timespans(self.args, self.time_unit)
+            timespan_gap_tid.feed(last_tid_task)
+            timespan_gap_tid.feed(task)
+            out_in = timespan_gap_tid.current['out_in']
+            out_out = timespan_gap_tid.current['out_out']
+            in_in = timespan_gap_tid.current['in_in']
+            in_out = timespan_gap_tid.current['in_out']
+
+        if self.args.extended_times:
+            line_out = fmt.format(c_row_set, task.time_in(), task.time_out(), task.cpu,
+                            task.pid, c_tid_set, task.tid, c_tid_reset, c_row_set, task.comm,
+                            task.runtime(self.time_unit), out_in, out_out, in_in, in_out,
+                            c_row_reset) + "\n"
+        else:
+            line_out = fmt.format(c_row_set, task.time_in(), task.time_out(), task.cpu,
+                            task.pid, c_tid_set, task.tid, c_tid_reset, c_row_set, task.comm,
+                            task.runtime(self.time_unit), out_in, c_row_reset) + "\n"
+        self.fd_task.write(line_out)
+
+    def _record_cleanup(self, _list: list[Any]) -> list[Any]:
+        need_summary = (self.args.summary or self.args.summary_extended or
+                        self.args.summary_only or self.args.csv_summary)
+        if not need_summary and len(_list) > 1:
+            return _list[len(_list) - 1:]
+        return _list
+
+    def _record_by_tid(self, task: Task) -> None:
+        tid = task.tid
+        if tid not in self.db["tid"]:
+            self.db["tid"][tid] = []
+        self.db["tid"][tid].append(task)
+        self.db["tid"][tid] = self._record_cleanup(self.db["tid"][tid])
+
+    def _record_global(self, task: Task) -> None:
+        self.db["global"].append(task)
+        self.db["global"] = self._record_cleanup(self.db["global"])
+
+    def _handle_task_finish(self, tid: int, cpu: int, time_ns: int, pid: int) -> None:
+        if tid == 0:
+            return
+        _id = self._task_id(tid, cpu)
+        if _id not in self.db["running"]:
+            return
+        task = self.db["running"][_id]
+        task.schedule_out_at(time_ns)
+        task.update_pid(pid)
+        del self.db["running"][_id]
+
+        if not self._limit_filtered(tid, pid, task.comm):
+            if not self.args.summary_only:
+                self._print_task_finish(task)
+            self._record_by_tid(task)
+            self._record_global(task)
+
+    def _handle_task_start(self, tid: int, cpu: int, comm: str, time_ns: int) -> None:
+        if tid == 0:
+            return
+        if tid in self.args.tid_renames:
+            comm = self._filter_non_printable(self.args.tid_renames[tid])
+        _id = self._task_id(tid, cpu)
+        if _id in self.db["running"]:
+            return
+        task = Task(_id, tid, cpu, comm)
+        task.schedule_in_at(time_ns)
+        self.db["running"][_id] = task
+
+    def _limit_filtered(self, tid: int, pid: int, comm: str) -> bool:
+        """Filter tasks based on CLI arguments."""
+        match_filter = False
+        if self.args.filter_tasks:
+            if (str(tid) in self.args.filter_tasks or
+                str(pid) in self.args.filter_tasks or
+                comm in self.args.filter_tasks):
+                match_filter = True
+
+        match_limit = False
+        if self.args.limit_to_tasks:
+            if (str(tid) in self.args.limit_to_tasks or
+                str(pid) in self.args.limit_to_tasks or
+                comm in self.args.limit_to_tasks):
+                match_limit = True
+
+        if self.args.filter_tasks and match_filter:
+            return True
+        if self.args.limit_to_tasks and not match_limit:
+            return True
+        return False
+
+    def _is_within_timelimit(self, time_ns: int) -> bool:
+        if not self.args.time_limit:
+            return True
+        time_s = decimal.Decimal(time_ns) / decimal.Decimal(1e9)
+        bounds = self.args.time_limit.split(":")
+        lower_bound = bounds[0] if len(bounds) > 0 else ""
+        upper_bound = bounds[1] if len(bounds) > 1 else ""
+        if lower_bound and time_s < decimal.Decimal(lower_bound):
+            return False
+        if upper_bound and time_s > decimal.Decimal(upper_bound):
+            return False
+        return True
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process sched:sched_switch events."""
+        if "sched:sched_switch" not in str(sample.evsel):
+            return
+
+        time_ns = sample.sample_time
+        if not self._is_within_timelimit(time_ns):
+            return
+
+        # Access tracepoint fields directly from sample object
+        try:
+            prev_pid = sample.prev_pid
+            next_pid = sample.next_pid
+            next_comm = sample.next_comm
+            common_cpu = sample.sample_cpu
+        except AttributeError:
+            if not self.db.get("warned_missing_fields"):
+                self.db["warned_missing_fields"] = True
+                print("Warning: sched:sched_switch sample missing tracepoint fields "
+                      "(is libtraceevent support enabled?).", file=sys.stderr)
+            return
+
+        next_comm = self._filter_non_printable(next_comm)
+
+        # Task finish for previous task
+        prev_tgid = prev_pid  # Fallback
+        if prev_pid != 0:
+            if self.session:
+                try:
+                    thread = self.session.find_thread(-1, prev_pid)
+                    if thread:
+                        prev_tgid = thread.pid
+                except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError):
+                    pass
+            elif prev_pid in self._tgid_cache:
+                prev_tgid = self._tgid_cache[prev_pid]
+            else:
+                if len(self._tgid_cache) >= 4096:
+                    self._tgid_cache.pop(next(iter(self._tgid_cache)))
+                self._tgid_cache[prev_pid] = prev_tgid
+                try:
+                    with open(f"/proc/{prev_pid}/status", encoding="utf-8") as f:
+                        for line in f:
+                            if line.startswith("Tgid:"):
+                                prev_tgid = int(line.split()[1])
+                                self._tgid_cache[prev_pid] = prev_tgid
+                                break
+                except (OSError, ValueError, KeyError, RuntimeError):
+                    pass
+        self._handle_task_finish(prev_pid, common_cpu, time_ns, prev_tgid)
+        # Task start for next task
+        self._handle_task_start(next_pid, common_cpu, next_comm, time_ns)
+
+    def print_summary(self) -> None:
+        """Calculate and print summary."""
+        need_summary = (self.args.summary or self.args.summary_extended or
+                        self.args.summary_only or self.args.csv_summary)
+        if not need_summary:
+            return
+
+        Summary(self).print()
+
+    def _run_file(self) -> None:
+        if not self.args.summary_only:
+            self._print_header()
+
+        session = perf.session(perf.data(self.args.input), sample=self.process_event)
+        self.session = session
+        session.process_events()
+
+        if not self.db["global"]:
+            print(f"Warning: No sched:sched_switch trace events found in '{self.args.input}'.",
+                  file=sys.stderr)
+
+        self.print_summary()
+
+    def _run_live(self) -> None:
+        if not self.args.summary_only:
+            self._print_header()
+
+        cpus = perf.cpu_map()
+        threads = perf.thread_map(-1)
+        evlist = perf.parse_events("sched:sched_switch", cpus, threads)
+        evlist.config()
+
+        evlist.open()
+        evlist.mmap()
+        evlist.enable()
+
+        pending_events: list[perf.sample_event] = []
+        print("Live mode started. Press Ctrl+C to stop.", file=sys.stderr)
+        try:
+            while True:
+                try:
+                    evlist.poll(timeout=100)
+                except InterruptedError:
+                    continue
+                for cpu in cpus:
+                    while True:
+                        event = evlist.read_on_cpu(cpu)
+                        if not event:
+                            break
+                        if not isinstance(event, perf.sample_event):
+                            continue
+                        pending_events.append(event)
+                if pending_events:
+                    pending_events.sort(
+                        key=lambda e: getattr(e, 'sample_time', getattr(e, 'time', 0))
+                    )
+                    max_ts = getattr(
+                        pending_events[-1], 'sample_time', getattr(pending_events[-1], 'time', 0)
+                    )
+                    cutoff_ts = max_ts - 50_000_000
+                    ready_idx = 0
+                    for event in pending_events:
+                        ev_ts = getattr(event, 'sample_time', getattr(event, 'time', 0))
+                        if ev_ts <= cutoff_ts:
+                            self.process_event(event)
+                            ready_idx += 1
+                        else:
+                            break
+                    del pending_events[:ready_idx]
+        except KeyboardInterrupt:
+            print("\nStopping live mode...", file=sys.stderr)
+        finally:
+            pending_events.sort(key=lambda e: getattr(e, 'sample_time', getattr(e, 'time', 0)))
+            for event in pending_events:
+                self.process_event(event)
+            evlist.close()
+            self.print_summary()
+
+    def run(self) -> None:
+        """Run the session."""
+        is_live = (self.args.live or
+                   (not os.path.exists(self.args.input) and self.args.input == "perf.data"))
+        with self.open_output(self.args.csv, sys.stdout) as fd_task:
+            if self.args.csv and self.args.csv == self.args.csv_summary:
+                self.fd_task = fd_task
+                self.fd_sum = fd_task
+                if is_live:
+                    self._run_live()
+                else:
+                    self._run_file()
+            else:
+                with self.open_output(self.args.csv_summary, sys.stdout) as fd_sum:
+                    self.fd_task = fd_task
+                    self.fd_sum = fd_sum
+                    if is_live:
+                        self._run_live()
+                    else:
+                        self._run_file()
+
+def main() -> None:
+    """Main function."""
+    parser = argparse.ArgumentParser(description="Analyze tasks behavior")
+    parser.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    parser.add_argument("--time-limit", default="", help="print tasks only in time window")
+    parser.add_argument("--summary", action="store_true",
+                        help="print additional runtime information")
+    parser.add_argument("--summary-only", action="store_true",
+                        help="print only summary without traces")
+    parser.add_argument("--summary-extended", action="store_true",
+                        help="print extended summary")
+    parser.add_argument("--ns", action="store_true", help="show timestamps in nanoseconds")
+    parser.add_argument("--ms", action="store_true", help="show timestamps in milliseconds")
+    parser.add_argument("--live", action="store_true",
+                        help="force live mode (ignores -i/perf.data)")
+    parser.add_argument("--extended-times", action="store_true",
+                        help="Show elapsed times between schedule in/out")
+    parser.add_argument("--filter-tasks", default="", help="filter tasks by tid, pid or comm")
+    parser.add_argument("--limit-to-tasks", default="", help="limit output to selected tasks")
+    parser.add_argument("--highlight-tasks", default="", help="colorize special tasks")
+    parser.add_argument("--rename-comms-by-tids", default="", help="rename task names by using tid")
+    parser.add_argument("--stdio-color", default="auto", choices=["always", "never", "auto"],
+                        help="configure color output")
+    parser.add_argument("--csv", default="", help="Write trace to file")
+    parser.add_argument("--csv-summary", default="", help="Write summary to file")
+
+    args = parser.parse_args()
+    args.tid_renames = {}
+    args.highlight_tasks_map = {}
+    args.filter_tasks = args.filter_tasks.split(",") if args.filter_tasks else []
+    args.limit_to_tasks = args.limit_to_tasks.split(",") if args.limit_to_tasks else []
+
+    if args.rename_comms_by_tids:
+        for item in args.rename_comms_by_tids.split(","):
+            try:
+                tid, name = item.split(":", 1)
+                args.tid_renames[int(tid)] = name
+            except ValueError:
+                print(f"Error: Invalid format for --rename-comms-by-tids '{item}', "
+                      "expected tid:name", file=sys.stderr)
+                sys.exit(1)
+
+    if args.highlight_tasks:
+        for item in args.highlight_tasks.split(","):
+            parts = item.split(":")
+            if len(parts) == 1:
+                parts.append("red")
+            key, color = parts[0], parts[1]
+            args.highlight_tasks_map[key] = color
+
+    analyzer = TaskAnalyzer(args)
+    analyzer.run()
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
index 0314412e63b4..519885dfa073 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -1,21 +1,27 @@
 #!/bin/bash
-# perf script task-analyzer tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
+# task-analyzer python test
+
+# shellcheck source=lib/setup_python.sh
+. "$(dirname "$0")"/lib/setup_python.sh
 
 tmpdir=$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
-# TODO: perf script report only supports input from the CWD perf.data file, make
-# it support input from any file.
-perfdata="perf.data"
+perfdata="$tmpdir/perf.data"
 csv="$tmpdir/csv"
 csvsummary="$tmpdir/csvsummary"
 err=0
 
-# set PERF_EXEC_PATH to find scripts in the source directory
-perfdir=$(dirname "$0")/../..
-if [ -e "$perfdir/scripts/python/Perf-Trace-Util" ]; then
-  export PERF_EXEC_PATH=$perfdir
+# Set up perfdir and PERF_EXEC_PATH
+if [ "x$PERF_EXEC_PATH" = "x" ]; then
+  perfdir=$(dirname "$0")/../..
+  if [ -f $perfdir/python/task-analyzer.py ]; then
+    export PERF_EXEC_PATH=$perfdir
+  fi
+else
+  perfdir=$PERF_EXEC_PATH
 fi
 
+
 # Disable lsan to avoid warnings about python memory leaks.
 export ASAN_OPTIONS=detect_leaks=0
 
@@ -76,85 +82,106 @@ prepare_perf_data() {
 # check standard inkvokation with no arguments
 test_basic() {
 	out="$tmpdir/perf.out"
-	perf script report task-analyzer > "$out"
-	check_exec_0 "perf script report task-analyzer"
+	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" > "$out"
+	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata}"
 	find_str_or_fail "Comm" "$out" "${FUNCNAME[0]}"
 }
 
 test_ns_rename(){
 	out="$tmpdir/perf.out"
-	perf script report task-analyzer --ns --rename-comms-by-tids 0:random > "$out"
-	check_exec_0 "perf script report task-analyzer --ns --rename-comms-by-tids 0:random"
+	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" \
+		--ns \
+		--rename-comms-by-tids 0:random > "$out"
+	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} \
+		--ns \
+		--rename-comms-by-tids 0:random"
 	find_str_or_fail "Comm" "$out" "${FUNCNAME[0]}"
 }
 
 test_ms_filtertasks_highlight(){
 	out="$tmpdir/perf.out"
-	perf script report task-analyzer --ms --filter-tasks perf --highlight-tasks perf \
+	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" \
+		--ms --filter-tasks perf --highlight-tasks perf \
 	> "$out"
-	check_exec_0 "perf script report task-analyzer --ms --filter-tasks perf --highlight-tasks perf"
+	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} \
+		--ms --filter-tasks perf --highlight-tasks perf"
 	find_str_or_fail "Comm" "$out" "${FUNCNAME[0]}"
 }
 
 test_extended_times_timelimit_limittasks() {
 	out="$tmpdir/perf.out"
-	perf script report task-analyzer --extended-times --time-limit :99999 \
+	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" --extended-times \
+		--time-limit :99999 \
 	--limit-to-tasks perf > "$out"
-	check_exec_0 "perf script report task-analyzer --extended-times --time-limit :99999 --limit-to-tasks perf"
+	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} \
+		--extended-times \
+		--time-limit :99999 --limit-to-tasks perf"
 	find_str_or_fail "Out-Out" "$out" "${FUNCNAME[0]}"
 }
 
 test_summary() {
 	out="$tmpdir/perf.out"
-	perf script report task-analyzer --summary > "$out"
-	check_exec_0 "perf script report task-analyzer --summary"
+	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" --summary > "$out"
+	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} --summary"
 	find_str_or_fail "Summary" "$out" "${FUNCNAME[0]}"
 }
 
 test_summaryextended() {
 	out="$tmpdir/perf.out"
-	perf script report task-analyzer --summary-extended > "$out"
-	check_exec_0 "perf script report task-analyzer --summary-extended"
+	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" --summary-extended > "$out"
+	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} --summary-extended"
 	find_str_or_fail "Inter Task Times" "$out" "${FUNCNAME[0]}"
 }
 
 test_summaryonly() {
 	out="$tmpdir/perf.out"
-	perf script report task-analyzer --summary-only > "$out"
-	check_exec_0 "perf script report task-analyzer --summary-only"
+	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" --summary-only > "$out"
+	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} --summary-only"
 	find_str_or_fail "Summary" "$out" "${FUNCNAME[0]}"
 }
 
 test_extended_times_summary_ns() {
 	out="$tmpdir/perf.out"
-	perf script report task-analyzer --extended-times --summary --ns > "$out"
-	check_exec_0 "perf script report task-analyzer --extended-times --summary --ns"
+	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" --extended-times \
+		--summary --ns > "$out"
+	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} \
+		--extended-times \
+		--summary \
+		--ns"
 	find_str_or_fail "Out-Out" "$out" "${FUNCNAME[0]}"
 	find_str_or_fail "Summary" "$out" "${FUNCNAME[0]}"
 }
 
 test_csv() {
-	perf script report task-analyzer --csv "${csv}" > /dev/null
-	check_exec_0 "perf script report task-analyzer --csv ${csv}"
+	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" --csv "${csv}" > /dev/null
+	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} --csv ${csv}"
 	find_str_or_fail "Comm;" "${csv}" "${FUNCNAME[0]}"
 }
 
 test_csv_extended_times() {
-	perf script report task-analyzer --csv "${csv}" --extended-times > /dev/null
-	check_exec_0 "perf script report task-analyzer --csv ${csv} --extended-times"
+	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" \
+		--csv "${csv}" \
+		--extended-times > /dev/null
+	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} \
+		--csv ${csv} \
+		--extended-times"
 	find_str_or_fail "Out-Out;" "${csv}" "${FUNCNAME[0]}"
 }
 
 test_csvsummary() {
-	perf script report task-analyzer --csv-summary "${csvsummary}" > /dev/null
-	check_exec_0 "perf script report task-analyzer --csv-summary ${csvsummary}"
+	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" \
+		--csv-summary "${csvsummary}" > /dev/null
+	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} \
+		--csv-summary ${csvsummary}"
 	find_str_or_fail "Comm;" "${csvsummary}" "${FUNCNAME[0]}"
 }
 
 test_csvsummary_extended() {
-	perf script report task-analyzer --csv-summary "${csvsummary}" --summary-extended \
+	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" \
+		--csv-summary "${csvsummary}" --summary-extended \
 	>/dev/null
-	check_exec_0 "perf script report task-analyzer --csv-summary ${csvsummary} --summary-extended"
+	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} \
+		--csv-summary ${csvsummary} --summary-extended"
 	find_str_or_fail "Out-Out;" "${csvsummary}" "${FUNCNAME[0]}"
 }
 
@@ -165,7 +192,11 @@ if [ $err -ne 0 ]; then
 	cleanup
 	exit $err
 fi
-prepare_perf_data
+prepare_perf_data || {
+	echo "Skipping tests, failed to prepare perf.data"
+	cleanup
+	exit 2
+}
 test_basic
 test_ns_rename
 test_ms_filtertasks_highlight
-- 
2.55.0.1082.g2b9226bbc0-goog

