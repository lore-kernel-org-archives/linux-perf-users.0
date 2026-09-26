Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8613ACA43
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403725; cv=none; b=VEKInd4O9L5l5iAN1eBrpGkmG4xRdb9y25fl/JV5Zq++gyGY2Vj11y1z2wUFLXpgfpe+g38Xjttq+mJJ5id4n7WS00krDC5LNgjqZsIVrxrwY3/2UGc6+Vnf+Soh7CZBAUgTYFm+F/InyUZCAi1JNqw7aJGyRU8bHl8oO12ajUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403725; c=relaxed/simple;
	bh=Wv41qWaA3PMHJhjvPAg67l6olbreeZZ1POF35u9dqms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lRGv1hgIceK1FZPuf1NVuPLk48AbJjB0LO0Nl7aGvLmfRQhHzQr+DhNbpEYkZ/siJ8sXLv3mN3nx6Ep5kpvxYFNysqHSLN6SWPEHJuYmOvgXXlvaEyE0GV0a3S4oA6b06CfbWygA8m9H0kQFXeGds41FP3ULexAN1B72p1c4meY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dt5vswZd; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dt5vswZd"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14383177746so2198997c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403720; x=1791008520; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cOyJhSdSdEnQAn3nys8/f1ZxPYPg13jNFMCxox3ohvM=;
        b=Dt5vswZdydrgDfFMwRd/kuPSFpWpy2W91QhtPXD7voxizwwLmJoOZ+ORsHz8n143Go
         pP/yfdke0YyTXbFzTFHtpFKRTeI62tsAXwDrXAqMms4otKZP/BWPKR5VVrMVyi+pAdV/
         QlrgiVOWqZJ+O+fyJz/mXByNP9FWJGGCH9K9YiIe/N2/IHdkxVFODOfPrNk8WO3Y4hEP
         0TH5zlVz5AfNGPSkIrnyBwlsW/BTzR5Cqnpy5DQDqhAoOVqkKwcTrBOKKZyr7jISO9TN
         WrbwEVWUDzgw8SxJawRvFEANig/lW4mz8b5Jz8m8JqGSqRZLlKHkQTTkdEUuxrsHyRya
         qzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403720; x=1791008520;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cOyJhSdSdEnQAn3nys8/f1ZxPYPg13jNFMCxox3ohvM=;
        b=D0MUI25CWCiLGA5IW6MYh4RbEDTkh6Tlxa2JfcwbvbzCbNrelILA47TbUV1QPgiwxn
         oapFEZ6hdqr1zCtB+RAjJRWyXAAW1dPKVQDELD6ryFl4ouFksYNsBz9dJF6KPqtw0jmC
         ZuGk5gsZMI1Xk1YDs2Ecm9ZWgIvr9CYFNBMtoqhT37YKLG5sKIonwnu/a9R4BK/5B90V
         GvgIZgtp4sxM2t2sqQVUAy+Q6UZsewdalJ0K87tOuLg4qcRzVxkYpgNVc+/luKOSTrDi
         hDf7jugSMAnGRpVIdLFK6j5bKLS/Okr7htdZLmaXhEI8l4rty0muSri/2eGQUu4GfGB9
         q4wg==
X-Forwarded-Encrypted: i=1; AKwUvBylxCwZdV4OU5ojrnCBg0/7/uXYQSNIihbB26EE1zbsep7tik+OSxUBatvOu8nQzujTvLdcmmMlmRSpp55aYo/8@vger.kernel.org
X-Gm-Message-State: AFuF++nUDwH21BmPSZRMC4pClcuz9lPbn4vKCLR958l1N8TKqTvsr05H
	tRZuI00ppQLbGhBmIdbV9oH20E6Jih+KlPSnlT5/gAvViuiQ/txVDCFXLEQn8rZf9TJJFYKcdEg
	gPELWJlMEXA==
X-Received: from dlbem1.prod.google.com ([2002:a05:7022:1001:b0:144:cc99:5883])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:298:b0:144:eb46:c40
 with SMTP id a92af1059eb24-146cddbd24amr1912933c88.9.1790403719387; Fri, 25
 Sep 2026 23:21:59 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:58 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-32-irogers@google.com>
Subject: [PATCH v4 31/49] perf python: Port task-analyzer to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
 tools/perf/python/task-analyzer.py           | 908 +++++++++++++++++++
 tools/perf/tests/shell/test_task_analyzer.sh |  96 +-
 2 files changed, 971 insertions(+), 33 deletions(-)
 create mode 100755 tools/perf/python/task-analyzer.py

diff --git a/tools/perf/python/task-analyzer.py b/tools/perf/python/task-analyzer.py
new file mode 100755
index 000000000000..fedba36b5ced
--- /dev/null
+++ b/tools/perf/python/task-analyzer.py
@@ -0,0 +1,908 @@
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
+        Output is aligned using the formatted column widths in self.db.
+        '''
+        len_tasks = max(
+            len("Task Information"),
+            sum(self.db["task_info"].values()) + len(self.db["task_info"]) - 1,
+        )
+        fmt = "{{:^{}}}".format(len_tasks)
+        fmt += " {{:^{}}}".format(
+            sum(self.db["runtime_info"].values()) + len(self.db["runtime_info"]) - 1
+        )
+        _header = ("Task Information", "Runtime Information")
+
+        if self.args.summary_extended:
+            fmt += " {{:^{}}}".format(
+                sum(self.db["inter_times"].values()) + len(self.db["inter_times"]) - 1
+            )
+            _header += ("Max Inter Task Times",)
+        self.fd_sum.write(fmt.format(*_header) + "\n")
+
+    def _column_titles(self):
+        """
+        Cells are being processed and displayed in different way so an alignment adjust
+        is implemented depeding on the choice of the timeunit. The positions of the max
+        values are being displayed in grey. Thus in their format two additional {},
+        are placed for color set and reset.
+        """
+        separator, fix_csv_align = self.analyzer.prepare_fmt_sep(is_summary=True)
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
+            separator, self.db["runtime_info"]["min"] * fix_csv_align
+        )
+        fmt += "{}{{:>{}}}".format(
+            separator, self.db["runtime_info"]["max"] * fix_csv_align
+        )
+        fmt += "{}{{}}{{:>{}}}{{}}".format(
+            separator, self.db["runtime_info"]["max_at"] * fix_csv_align
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
+                self.db["inter_times"]["out_in"] * fix_csv_align
+            )
+            fmt += "{}{{}}{{:>{}}}{{}}".format(
+                separator,
+                self.db["inter_times"]["inter_at"] * fix_csv_align
+            )
+            fmt += "{}{{:>{}}}".format(
+                separator,
+                self.db["inter_times"]["out_out"] * fix_csv_align
+            )
+            fmt += "{}{{:>{}}}".format(
+                separator,
+                self.db["inter_times"]["in_in"] * fix_csv_align
+            )
+            fmt += "{}{{:>{}}}".format(
+                separator,
+                self.db["inter_times"]["in_out"] * fix_csv_align
+            )
+
+            column_titles += (
+                "Out-In", grey, "Max At",
+                reset, "Out-Out", "In-In", "In-Out"
+            )
+
+        self.fd_sum.write(fmt.format(*column_titles) + "\n")
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
+        len_min = self.db["runtime_info"]["min"] * fix_csv_align
+        len_max = self.db["runtime_info"]["max"] * fix_csv_align
+        len_max_at = self.db["runtime_info"]["max_at"] * fix_csv_align
+        if self.args.summary_extended:
+            len_out_in = self.db["inter_times"]["out_in"] * fix_csv_align
+            len_inter_at = self.db["inter_times"]["inter_at"] * fix_csv_align
+            len_out_out = self.db["inter_times"]["out_out"] * fix_csv_align
+            len_in_in = self.db["inter_times"]["in_in"] * fix_csv_align
+            len_in_out = self.db["inter_times"]["in_out"] * fix_csv_align
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
+    def _calc_alignments_summary(self, align_helper):
+        # Measure the formatted string widths (e.g. f"{val:.{decimal_precision}f}"
+        # and f"{val:.{time_precision}f}") rather than str(val), because Decimal's
+        # default string representation may include unrounded fractional digits or
+        # omit trailing zeros that _format_stats() renders with fixed precision.
+        decimal_precision, time_precision = self.analyzer.prepare_fmt_precision()
+        for key in self.db["task_info"]:
+            val_len = len(str(getattr(align_helper, key)))
+            if val_len > self.db["task_info"][key]:
+                self.db["task_info"][key] = val_len
+        for key in self.db["runtime_info"]:
+            val = getattr(align_helper, key)
+            if key == "runs":
+                val_len = len(str(val))
+            elif key == "max_at":
+                val_len = len(f"{val:.{decimal_precision}f}")
+            else:
+                val_len = len(f"{val:.{time_precision}f}")
+            if val_len > self.db["runtime_info"][key]:
+                self.db["runtime_info"][key] = val_len
+        if self.args.summary_extended:
+            for key in self.db["inter_times"]:
+                val = getattr(align_helper, key)
+                if key == "inter_at":
+                    val_len = len(f"{val:.{decimal_precision}f}")
+                else:
+                    val_len = len(f"{val:.{time_precision}f}")
+                if val_len > self.db["inter_times"][key]:
+                    self.db["inter_times"][key] = val_len
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
+        # Strip non-printable characters, whitespace control characters
+        # (\r\n\t\x0b\x0c), quotes (", '), and ';' because --csv and
+        # --csv-summary emit unquoted ';'-delimited columns. Also replace a
+        # leading '=', '+', '-', or '@' with '_' to mitigate CSV formula / DDE
+        # injection attacks if an attacker-controlled process comm is opened in
+        # a spreadsheet program.
+        if isinstance(unfiltered, (bytearray, bytes)):
+            unfiltered = unfiltered.decode('utf-8', 'ignore')
+        filtered = ""
+        for char in unfiltered:
+            if char in string.printable and char not in "\r\n\t\x0b\x0c;\"'":
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
+        # fix_csv_align multiplies format field widths: 0 in CSV mode collapses
+        # {:>N} padding to {:>0} (no extra spaces around ';'), while 1 in
+        # standard text mode preserves fixed-width column alignment.
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
+        if tid == 0 and (not self.args.tid_renames or 0 not in self.args.tid_renames):
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
+        if tid == 0 and (not self.args.tid_renames or 0 not in self.args.tid_renames):
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
+        # Task finish for previous task. Resolve TGID (process ID) from TID:
+        # in file mode we query perf.session.find_thread() (checking thread.pid > 0
+        # so an unresolved -1 does not overwrite the prev_pid fallback), whereas in
+        # live mode (self.session is None) we read /proc/<tid>/status and cache
+        # the lookup in _tgid_cache.
+        prev_tgid = prev_pid  # Fallback
+        if prev_pid != 0:
+            if self.session:
+                try:
+                    thread = self.session.find_thread(-1, prev_pid)
+                    if thread and thread.pid > 0:
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
+        try:
+            session.process_events()
+        except KeyboardInterrupt:
+            pass
+        finally:
+            # Break the reference cycle between self.session and the bound
+            # self.process_event callback so the C perf.session object is freed.
+            self.session = None
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
+        # Per-CPU perf ring buffers are drained sequentially in a loop, so events
+        # read from CPU N may have timestamps slightly earlier than events just
+        # read from CPU 0. Buffer events in pending_events and only dispatch those
+        # older than a 50 ms watermark behind max_ts so cross-CPU migrations and
+        # switches are processed in global timestamp order.
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
index 0314412e63b4..3a97d58eec74 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -1,19 +1,24 @@
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
+  perfdir="$(dirname "$0")/../.."
+  if [ -f "$perfdir/python/task-analyzer.py" ]; then
+    export PERF_EXEC_PATH="$perfdir"
+  fi
+else
+  perfdir="$PERF_EXEC_PATH"
 fi
 
 # Disable lsan to avoid warnings about python memory leaks.
@@ -76,85 +81,106 @@ prepare_perf_data() {
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
 
@@ -165,7 +191,11 @@ if [ $err -ne 0 ]; then
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
2.56.0.rc1.315.gc6ed9934b7-goog

