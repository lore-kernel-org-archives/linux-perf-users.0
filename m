Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A1471416
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965631; cv=none; b=aF/zQes6egzFinL4bJrfoj/pCTZXp8JyCrbhNgg9RCHX0jZc2HX7sCt0jOO3jiDU4zG7vjO6k053Z0hH5z0o925vgANfW3Srwxi4GIrIUCyTqM2GYKCuqbAOpbvSYT/2C1gEupFtK8p6GHKrLj0AdF/RNG8zprs2ggQE9a7T1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965631; c=relaxed/simple;
	bh=9fYQurBh9PhAkyPFZbvsj/QKe92/oSp7TiE1O6fCQKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CFpLC7sQyKozYuycYq2ur/s8ZgybMdXPLrpSLoOwIItx+h5uVmQ9iyfKYfZDEHI1OJNWw5VUkx1uCT5Vfq8JEbR9JxV3OF468jdDqYEPV0/D3FXE/j7qoWokt2FLrwJNMSArJbq573iivZGg044PVaHjMnOwsQ6fRWW1LGxK+DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G48S+4zH; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G48S+4zH"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1438fef603cso18278400c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790965625; x=1791570425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HkMtmqbEe90LkSr3CWCSeY8CtC4NgvStTyN9WlBkSnI=;
        b=G48S+4zHODX6iu57HwI9AGdQAH7Z7bgEbJNDMdaZO2VfcVgUcQZd9YxgCxE6kapKxX
         3IFBJ/Ys2MGq4abcdqom6oSmFi5paOr+4wEcPxzD5wu6uu9jXr5VXIAMErNG+rKa9N6u
         wVMCU08RLEynnS/mfO6lsCNr+Kx/q9u10rsw3fY0Lu808VSCZj+RLvn4gBW1Vo8IFtJe
         bDvKba+xQ8/2pfoC1XfCuhcyGNUTJUko9H1ArmMIe02dUXISPr9N6yETa9ToFsJv24UD
         7m+lKBjjul+wi+Z6q3Q/pe6um7Q/AKI0a3DpjkpLMRD8Eg/ZFf5EzE6MkmN7K+pUcp7s
         AyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965625; x=1791570425;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HkMtmqbEe90LkSr3CWCSeY8CtC4NgvStTyN9WlBkSnI=;
        b=TN2q/8z28jEqso7IxszTKC3F7NUYsmHD2t29zFI7DXKz6+kXPIesfsDPIZx6i8ze00
         bJq6KZkgr6RmujRQT5+X5qzrpm8Nb8aEbcHMSwvkaYdhRt68qAivcAG8X38rBFVVHYF3
         PQh80OPgZJFpGsqrXED/lv1zbKWaIMosemesd92IpAhuMKOShcQ8glLH9wiCMoa4C0jH
         Gl1vzVuawEClqQUclua2ZAbwtDTFiWipyHzVHTCz1kVfmuG/0WJb5sN5N7F/gk4M+8Jy
         DQHzDKpLhqwPERt4VEk7sx0Fu2hiL84DV/v6oZHMX88tplhkt3ELDV4qUf1WkyQ/F84J
         zZ1w==
X-Forwarded-Encrypted: i=1; AKwUvBy7cRUDNhNyWd2YWMBKYh9grjgPd9Ibvj410zpNTx8Td+709MCdEJk4tgz2dLiawUQ+brskls5yUmc42tgYKpV8@vger.kernel.org
X-Gm-Message-State: AFuF++mDA0spgXxfo/EcM1lYil2iiBOKuCrZrT5PkexRyDLFZ8SqZ+N/
	T6CoDHopWA3bYlTajCrNZRqDUYBxddTNsLeyK6pNDxBRVsDP7UfTJMYRg4Bnb0sWSpjwMjpaM3H
	R858jq2UAKA==
X-Received: from dlev19.prod.google.com ([2002:a05:701b:4653:b0:150:b1c4:8521])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:21d3:20b0:144:c127:dd1a
 with SMTP id a92af1059eb24-14f5d1b796dmr3439874c88.38.1790965624172; Fri, 02
 Oct 2026 11:27:04 -0700 (PDT)
Date: Fri,  2 Oct 2026 11:26:19 -0700
In-Reply-To: <20261002182624.3259797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002182624.3259797-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002182624.3259797-11-irogers@google.com>
Subject: [PATCH v1 10/13] perf timechart: Add an interactive --tui mode
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Changbin Du <changbin.du@huawei.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, tanze <tanze@kylinos.cn>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Alice Rogers <alice.mei.rogers@gmail.com>

Add ttimechart.py, a textual based interactive timechart, and a --tui
option to perf timechart that launches it through perf script. Rather
than writing an SVG file, per-CPU (busy, frequency and idle state),
per-task (running, runnable and blocked) and I/O timelines are shown in
the terminal along with a summary table. The timelines can be zoomed,
panned and the state of the selected row at the cursor is described,
including the task that woke it. The -i, -P, -T and -p options are
passed to the script.

The data is loaded in a background thread and the timelines are shown
and updated as it loads. A --dump option prints a text summary without
the UI.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
Co-developed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-timechart.txt |    8 +
 tools/perf/builtin-timechart.c              |   44 +
 tools/perf/python/ttimechart.py             | 1807 +++++++++++++++++++
 3 files changed, 1859 insertions(+)
 create mode 100755 tools/perf/python/ttimechart.py

diff --git a/tools/perf/Documentation/perf-timechart.txt b/tools/perf/Docum=
entation/perf-timechart.txt
index bacc5df3c400..f768ee8acf47 100644
--- a/tools/perf/Documentation/perf-timechart.txt
+++ b/tools/perf/Documentation/perf-timechart.txt
@@ -53,6 +53,14 @@ TIMECHART OPTIONS
 -f::
 --force::
 	Don't complain, do it.
+--tui::
+	Rather than writing an SVG file, interactively display the timechart
+	in the terminal using the 'ttimechart' python script (see
+	linkperf:perf-script[1]). The script requires the perf python module
+	and the python 'textual' library. The CPU, task, I/O and summary views
+	can be zoomed ('+'/'-'), panned (shift+arrows) and the state of the
+	selected row at the cursor is described. The -i, -P, -T and -p options
+	are passed to the script, other output options are ignored.
 --symfs=3D<directory[,layout]>::
         Look for files with symbols relative to this directory. The option=
al
         layout can be 'hierarchy' (default, matches full path) or 'flat'
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.=
c
index 3d88c90c6573..9eb335d9db16 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -10,6 +10,7 @@
=20
 #include <errno.h>
 #include <inttypes.h>
+#include <stdlib.h>
=20
 #include "builtin.h"
 #include "util/color.h"
@@ -68,6 +69,7 @@ struct timechart {
 				with_backtrace,
 				topology;
 	bool			force;
+	bool			use_tui;
 	/* IO related settings */
 	bool			io_only,
 				skip_eagain;
@@ -1756,6 +1758,41 @@ static int __cmd_timechart(struct timechart *tchart,=
 const char *output_name)
 	return ret;
 }
=20
+/*
+ * Launch the interactive textual based python script via 'perf script' th=
at
+ * finds the script, sets up the python environment and passes the global
+ * input_name (set by -i) to the script as '-i <input_name>'.
+ */
+static int timechart__tui(struct timechart *tchart)
+{
+	struct process_filter *filt;
+	const char **script_argv;
+	int script_argc =3D 0, nr_args =3D 5, ret;
+
+	for (filt =3D process_filter; filt; filt =3D filt->next)
+		nr_args +=3D 2;
+
+	script_argv =3D calloc(nr_args + 1, sizeof(*script_argv));
+	if (!script_argv)
+		return -ENOMEM;
+
+	script_argv[script_argc++] =3D "script";
+	script_argv[script_argc++] =3D "ttimechart";
+	script_argv[script_argc++] =3D "--";
+	if (tchart->power_only)
+		script_argv[script_argc++] =3D "-P";
+	if (tchart->tasks_only)
+		script_argv[script_argc++] =3D "-T";
+	for (filt =3D process_filter; filt; filt =3D filt->next) {
+		script_argv[script_argc++] =3D "-p";
+		script_argv[script_argc++] =3D filt->name;
+	}
+
+	ret =3D cmd_script(script_argc, script_argv);
+	free(script_argv);
+	return ret;
+}
+
 static int timechart__io_record(int argc, const char **argv, const char *o=
utput_data)
 {
 	unsigned int rec_argc, i;
@@ -2079,6 +2116,8 @@ int cmd_timechart(int argc, const char **argv)
 		     "merge events that are merge-dist us apart",
 		     parse_time),
 	OPT_BOOLEAN('f', "force", &tchart.force, "don't complain, do it"),
+	OPT_BOOLEAN(0, "tui", &tchart.use_tui,
+		    "interactive terminal timechart using the ttimechart python script")=
,
 	OPT_PARENT(timechart_common_options),
 	};
 	const char * const timechart_subcommands[] =3D { "record", NULL };
@@ -2146,6 +2185,11 @@ int cmd_timechart(int argc, const char **argv)
 	} else if (argc)
 		usage_with_options(timechart_usage, timechart_options);
=20
+	if (tchart.use_tui) {
+		ret =3D timechart__tui(&tchart);
+		goto out;
+	}
+
 	setup_pager();
=20
 	ret =3D __cmd_timechart(&tchart, output_name);
diff --git a/tools/perf/python/ttimechart.py b/tools/perf/python/ttimechart=
.py
new file mode 100755
index 000000000000..34ecf84e68c1
--- /dev/null
+++ b/tools/perf/python/ttimechart.py
@@ -0,0 +1,1807 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""ttimechart.py - interactive perf timechart written using textual.
+
+Reads a perf.data file, typically created with 'perf timechart record', an=
d
+displays per-CPU and per-task timelines in the terminal. Scheduler
+(sched:sched_switch, sched:sched_wakeup), power (power:cpu_idle,
+power:cpu_frequency) and I/O syscall (perf timechart record -I) tracepoint=
s
+are understood. Unlike 'perf timechart', which writes an SVG file, the
+timeline can be zoomed, panned and queried interactively.
+
+Usage:
+    perf timechart record -- <workload>
+    perf timechart --tui
+or:
+    perf script ttimechart [-i perf.data]
+"""
+from __future__ import annotations
+
+from abc import ABC, abstractmethod
+import argparse
+import bisect
+from collections import defaultdict
+from dataclasses import dataclass, replace
+import math
+import os
+import sys
+import threading
+from time import monotonic
+from typing import Any, Callable, Dict, List, Mapping, Optional, Sequence,=
 Tuple
+
+import perf
+from rich.segment import Segment
+from rich.style import Style
+from textual import events, on, work
+from textual.app import App, ComposeResult
+from textual.binding import Binding
+from textual.color import Color
+from textual.geometry import Size
+from textual.message import Message
+from textual.reactive import reactive
+from textual.scroll_view import ScrollView
+from textual.strip import Strip
+from textual.widgets import DataTable, Footer, Header, Static, TabbedConte=
nt, TabPane
+from textual.widgets.data_table import CellDoesNotExist, RowDoesNotExist
+
+# Task states, SLEEPING and UNKNOWN aren't drawn.
+STATE_UNKNOWN =3D -1
+STATE_SLEEPING =3D 0
+STATE_RUNNING =3D 1
+STATE_WAITING =3D 2
+STATE_BLOCKED =3D 3
+NUM_STATES =3D 4
+STATE_NAMES =3D {
+    STATE_UNKNOWN: "unknown",
+    STATE_SLEEPING: "sleeping",
+    STATE_RUNNING: "running",
+    STATE_WAITING: "runnable (waiting for a CPU)",
+    STATE_BLOCKED: "blocked (uninterruptible)",
+}
+
+# I/O types, matching builtin-timechart.c.
+IOTYPE_READ =3D 0
+IOTYPE_WRITE =3D 1
+IOTYPE_SYNC =3D 2
+IOTYPE_TX =3D 3
+IOTYPE_RX =3D 4
+IOTYPE_POLL =3D 5
+NUM_IOTYPES =3D 6
+IOTYPE_NAMES =3D ["read", "write", "sync", "tx", "rx", "poll"]
+
+IO_SYSCALLS =3D {
+    "read": IOTYPE_READ, "pread64": IOTYPE_READ, "readv": IOTYPE_READ,
+    "preadv": IOTYPE_READ,
+    "write": IOTYPE_WRITE, "pwrite64": IOTYPE_WRITE, "writev": IOTYPE_WRIT=
E,
+    "pwritev": IOTYPE_WRITE,
+    "sync": IOTYPE_SYNC, "sync_file_range": IOTYPE_SYNC, "fsync": IOTYPE_S=
YNC,
+    "msync": IOTYPE_SYNC,
+    "recvfrom": IOTYPE_RX, "recvmmsg": IOTYPE_RX, "recvmsg": IOTYPE_RX,
+    "sendto": IOTYPE_TX, "sendmsg": IOTYPE_TX, "sendmmsg": IOTYPE_TX,
+    "epoll_pwait": IOTYPE_POLL, "epoll_wait": IOTYPE_POLL, "poll": IOTYPE_=
POLL,
+    "ppoll": IOTYPE_POLL, "pselect6": IOTYPE_POLL, "select": IOTYPE_POLL,
+}
+
+# Trace flags for interrupt context in the common_flags tracepoint field.
+TRACE_FLAG_HARDIRQ =3D 0x08
+TRACE_FLAG_SOFTIRQ =3D 0x10
+# Value of state in power:cpu_idle when leaving idle.
+PWR_EVENT_EXIT =3D 0xffffffff
+# Width of the row label column.
+LABEL_WIDTH =3D 28
+# Characters for drawing fractional bars.
+BARS =3D " =E2=96=81=E2=96=82=E2=96=83=E2=96=84=E2=96=85=E2=96=86=E2=96=87=
=E2=96=88"
+NSEC_PER_SEC =3D 1_000_000_000
+
+
+def fmt_duration(nsecs: float) -> str:
+    """Format a duration in nanoseconds with an appropriate unit."""
+    if nsecs >=3D NSEC_PER_SEC:
+        return f"{nsecs / NSEC_PER_SEC:.3f}s"
+    if nsecs >=3D 1_000_000:
+        return f"{nsecs / 1_000_000:.3f}ms"
+    if nsecs >=3D 1_000:
+        return f"{nsecs / 1_000:.3f}us"
+    return f"{nsecs:.0f}ns"
+
+
+def escape(text: str) -> str:
+    """Escape text, such as a task name, for use in textual markup.
+
+    rich.markup.escape doesn't escape tags like "[1]", the name given to t=
asks
+    with an unknown command, but textual fails to parse them.
+    """
+    return text.replace("[", "\\[")
+
+
+def make_fixed_length_string(s: str, length: int, pad_char: str =3D ' ') -=
> str:
+    """Truncate or right pad s so that it is length characters long."""
+    return s[:length] if len(s) > length else s.ljust(length, pad_char)
+
+
+def bar_char(frac: float) -> str:
+    """A block character whose height represents frac, in the range [0, 1]=
."""
+    if frac <=3D 0:
+        return BARS[0]
+    return BARS[max(1, min(8, round(frac * 8)))]
+
+
+class SegmentList:
+    """A time ordered list of non-overlapping [start, end) segments.
+
+    Each segment has a small integer key, used for computing coverage, and
+    arbitrary associated data.
+    """
+    def __init__(self) -> None:
+        self.starts: List[int] =3D []
+        self.ends: List[int] =3D []
+        self.keys: List[int] =3D []
+        self.data: List[Any] =3D []
+
+    def __len__(self) -> int:
+        return len(self.starts)
+
+    def add(self, start: int, end: int, key: int, data: Any =3D None) -> N=
one:
+        """Append a segment, segments must be added in time order."""
+        if end <=3D start:
+            return
+        if self.ends and start < self.ends[-1]:
+            # Clip overlaps caused by inconsistent data.
+            start =3D self.ends[-1]
+            if end <=3D start:
+                return
+        self.starts.append(start)
+        self.ends.append(end)
+        self.keys.append(key)
+        self.data.append(data)
+
+    def find(self, time: float) -> int:
+        """Index of the segment containing time or -1."""
+        i =3D bisect.bisect_right(self.starts, time) - 1
+        if i >=3D 0 and time < self.ends[i]:
+            return i
+        return -1
+
+    def last_before(self, time: float) -> int:
+        """Index of the last segment starting at or before time or -1."""
+        return bisect.bisect_right(self.starts, time) - 1
+
+    def next_change(self, time: float) -> Optional[int]:
+        """The first segment start or end after time."""
+        candidates =3D []
+        i =3D bisect.bisect_right(self.starts, time)
+        if i < len(self.starts):
+            candidates.append(self.starts[i])
+        i =3D bisect.bisect_right(self.ends, time)
+        if i < len(self.ends):
+            candidates.append(self.ends[i])
+        return min(candidates) if candidates else None
+
+    def prev_change(self, time: float) -> Optional[int]:
+        """The last segment start or end before time."""
+        candidates =3D []
+        i =3D bisect.bisect_left(self.starts, time) - 1
+        if i >=3D 0:
+            candidates.append(self.starts[i])
+        i =3D bisect.bisect_left(self.ends, time) - 1
+        if i >=3D 0:
+            candidates.append(self.ends[i])
+        return max(candidates) if candidates else None
+
+    def coverage(self, t0: float, dt: float, width: int, nkeys: int,
+                 weight_fn=3DNone) -> List[List[float]]:
+        """Time covered by each key in each of width columns of size dt.
+
+        If weight_fn is given then, rather than the time covered, the time
+        covered multiplied by weight_fn(data) is accumulated.
+        """
+        cols =3D [[0.0] * nkeys for _ in range(width)]
+        t1 =3D t0 + dt * width
+        i =3D bisect.bisect_right(self.ends, t0)
+        num =3D len(self.starts)
+        while i < num and self.starts[i] < t1:
+            start =3D max(self.starts[i], t0)
+            end =3D min(self.ends[i], t1)
+            key =3D self.keys[i]
+            weight =3D weight_fn(self.data[i]) if weight_fn else 1.0
+            x0 =3D min(int((start - t0) / dt), width - 1)
+            x1 =3D min(int((end - t0) / dt), width - 1)
+            if x0 =3D=3D x1:
+                cols[x0][key] +=3D (end - start) * weight
+            else:
+                cols[x0][key] +=3D (t0 + (x0 + 1) * dt - start) * weight
+                for x in range(x0 + 1, x1):
+                    cols[x][key] +=3D dt * weight
+                cols[x1][key] +=3D (end - (t0 + x1 * dt)) * weight
+            i +=3D 1
+        return cols
+
+
+class Task:
+    """Scheduling and I/O history of a single thread."""
+    def __init__(self, tid: int, comm: str) -> None:
+        self.tid =3D tid
+        self.comm =3D comm
+        self.comms: List[str] =3D [comm]
+        self.state =3D STATE_UNKNOWN
+        self.since =3D 0
+        self.cpu =3D -1
+        # Segments with a state key and the CPU as data.
+        self.segs =3D SegmentList()
+        # Segments with an I/O type key and (fd, ret) as data.
+        self.io =3D SegmentList()
+        self.io_pending: Optional[Tuple[int, int, int]] =3D None
+        # Wakeups of this task as (time, waker tid) pairs.
+        self.wakeups: List[Tuple[int, int]] =3D []
+        self.totals =3D [0] * NUM_STATES
+        self.switches =3D 0
+        self.io_bytes =3D 0
+
+    def name(self) -> str:
+        """Name for the task used in labels."""
+        return f"{self.comm} ({self.tid})"
+
+    def set_comm(self, comm: Optional[str]) -> None:
+        """Update the task's command name."""
+        if not comm or comm =3D=3D self.comm:
+            return
+        self.comm =3D comm
+        if comm not in self.comms:
+            self.comms.append(comm)
+
+    def change_state(self, time: int, state: int, cpu: int =3D -1) -> None=
:
+        """Record the current state as a segment and switch to a new state=
."""
+        if self.state in (STATE_RUNNING, STATE_WAITING, STATE_BLOCKED) and=
 time > self.since:
+            self.segs.add(self.since, time, self.state, self.cpu)
+            self.totals[self.state] +=3D time - self.since
+        self.state =3D state
+        self.since =3D time
+        if cpu >=3D 0:
+            self.cpu =3D cpu
+
+    def passes_filter(self, filters: Sequence[str]) -> bool:
+        """Does the task match one of the process filters (pid or name)?""=
"
+        if not filters:
+            return True
+        return any(f =3D=3D str(self.tid) or f in self.comms for f in filt=
ers)
+
+
+class Cpu:
+    """Activity on a single CPU."""
+    def __init__(self, cpu: int) -> None:
+        self.cpu =3D cpu
+        self.cur_tid =3D -1
+        self.since =3D 0
+        # Busy segments, key 1, with the running tid as data.
+        self.run =3D SegmentList()
+        # Idle state segments, key 1, with the C-state as data.
+        self.cstate =3D SegmentList()
+        self.cstate_cur: Optional[Tuple[int, int]] =3D None
+        # Frequency segments, key 1, with the frequency in kHz as data.
+        self.pstate =3D SegmentList()
+        self.pstate_cur: Optional[Tuple[int, int]] =3D None
+
+
+class LoadCancelled(Exception):
+    """Raised from the sample callback to stop processing events early."""
+
+
+class TimechartData:
+    """Builds per-task and per-CPU timelines from perf events.
+
+    The data may be displayed while it is loaded in another thread, lock m=
ust
+    be held when modifying it or when reading it from another thread.
+    """
+    # Number of samples between checks for cancellation and progress.
+    PROGRESS_INTERVAL =3D 1000
+    # Minimum and maximum time between calls to the progress callback.
+    PROGRESS_SECONDS =3D 1.0
+    PROGRESS_MAX_SECONDS =3D 10.0
+    # Updating the views costs more as more data is loaded, so the time be=
tween
+    # progress calls grows as this fraction of the time spent loading. Thi=
s
+    # bounds the fraction of the load time spent updating the views.
+    PROGRESS_FRACTION =3D 0.25
+
+    def __init__(self) -> None:
+        self.tasks: Dict[int, Task] =3D {}
+        self.cpus: Dict[int, Cpu] =3D {}
+        self.first_time =3D 0
+        self.last_time =3D 0
+        self.min_freq =3D 0
+        self.max_freq =3D 0
+        self.max_cstate =3D 0
+        self.sched_events =3D 0
+        self.power_events =3D 0
+        self.io_events =3D 0
+        self.nr_samples =3D 0
+        self.unhandled: Dict[str, int] =3D defaultdict(int)
+        self.session: Optional[perf.session] =3D None
+        # Evsel name and event handler, keyed by sample ID.
+        self._handlers: Dict[int, Tuple[str, Optional[Callable[[int, perf.=
sample_event],
+                                                               None]]]] =
=3D {}
+        self.lock =3D threading.Lock()
+        # Set, possibly from another thread, to stop processing events.
+        self.cancelled =3D False
+        # Called periodically, see PROGRESS_FRACTION, while processing eve=
nts.
+        self.progress: Optional[Callable[[], None]] =3D None
+        self.start_progress =3D monotonic()
+        self.last_progress =3D self.start_progress
+
+    def has_events(self) -> bool:
+        """Were any events that can be displayed processed?"""
+        return bool(self.sched_events or self.power_events or self.io_even=
ts)
+
+    def task(self, tid: int, comm: Optional[str] =3D None) -> Task:
+        """Find or create a task."""
+        task =3D self.tasks.get(tid)
+        if task is None:
+            if not comm and self.session:
+                try:
+                    thread =3D self.session.find_thread(tid, tid)
+                    comm =3D thread.comm() if thread else None
+                except (OSError, ValueError, KeyError, RuntimeError, TypeE=
rror, AttributeError):
+                    comm =3D None
+            task =3D Task(tid, comm or f"[{tid}]")
+            self.tasks[tid] =3D task
+        else:
+            task.set_comm(comm)
+        return task
+
+    def cpu(self, cpu: int) -> Cpu:
+        """Find or create a CPU."""
+        c =3D self.cpus.get(cpu)
+        if c is None:
+            c =3D Cpu(cpu)
+            self.cpus[cpu] =3D c
+        return c
+
+    def sched_switch(self, time: int, cpu: int, prev_tid: int, prev_comm: =
Optional[str],
+                     prev_state: int, next_tid: int, next_comm: Optional[s=
tr]) -> None:
+        """Process a sched:sched_switch event."""
+        self.sched_events +=3D 1
+        c =3D self.cpu(cpu)
+        if c.cur_tid =3D=3D -1 and prev_tid !=3D 0:
+            # Assume the task was running from the start of the trace.
+            c.cur_tid =3D prev_tid
+            c.since =3D self.first_time
+        if c.cur_tid > 0:
+            c.run.add(c.since, time, 1, c.cur_tid)
+        c.cur_tid =3D next_tid
+        c.since =3D time
+
+        if prev_tid !=3D 0:
+            prev =3D self.task(prev_tid, prev_comm)
+            if prev.state =3D=3D STATE_UNKNOWN:
+                prev.state =3D STATE_RUNNING
+                prev.since =3D self.first_time
+                prev.cpu =3D cpu
+            # Ignore bits like TASK_REPORT_MAX used to report preemption.
+            state =3D prev_state & 0xff
+            if state =3D=3D 0:
+                new_state =3D STATE_WAITING
+            elif state & 2:
+                new_state =3D STATE_BLOCKED
+            else:
+                new_state =3D STATE_SLEEPING
+            prev.change_state(time, new_state)
+            prev.switches +=3D 1
+
+        if next_tid !=3D 0:
+            nxt =3D self.task(next_tid, next_comm)
+            nxt.change_state(time, STATE_RUNNING, cpu)
+
+    def sched_wakeup(self, time: int, wakee: int, comm: Optional[str], wak=
er: int) -> None:
+        """Process a sched:sched_wakeup or sched:sched_wakeup_new event.""=
"
+        self.sched_events +=3D 1
+        if wakee =3D=3D 0:
+            return
+        task =3D self.task(wakee, comm)
+        task.wakeups.append((time, waker))
+        if task.state in (STATE_UNKNOWN, STATE_SLEEPING, STATE_BLOCKED):
+            task.change_state(time, STATE_WAITING)
+
+    def cstate_start(self, time: int, cpu: int, state: int) -> None:
+        """Enter an idle state."""
+        self.power_events +=3D 1
+        c =3D self.cpu(cpu)
+        if c.cstate_cur:
+            c.cstate.add(c.cstate_cur[0], time, 1, c.cstate_cur[1])
+        c.cstate_cur =3D (time, state)
+        self.max_cstate =3D max(self.max_cstate, state)
+
+    def cstate_end(self, time: int, cpu: int) -> None:
+        """Leave an idle state."""
+        self.power_events +=3D 1
+        c =3D self.cpu(cpu)
+        if c.cstate_cur:
+            c.cstate.add(c.cstate_cur[0], time, 1, c.cstate_cur[1])
+            c.cstate_cur =3D None
+
+    def pstate_change(self, time: int, cpu: int, freq: int) -> None:
+        """Change of CPU frequency, freq is in kHz."""
+        if freq <=3D 0 or freq > 8000000:
+            return
+        self.power_events +=3D 1
+        c =3D self.cpu(cpu)
+        if c.pstate_cur:
+            c.pstate.add(c.pstate_cur[0], time, 1, c.pstate_cur[1])
+        c.pstate_cur =3D (time, freq)
+        self.max_freq =3D max(self.max_freq, freq)
+        self.min_freq =3D freq if not self.min_freq else min(self.min_freq=
, freq)
+
+    def io_enter(self, time: int, tid: int, iotype: int, fd: int) -> None:
+        """Entry to an I/O syscall."""
+        self.io_events +=3D 1
+        self.task(tid).io_pending =3D (time, iotype, fd)
+
+    def io_exit(self, time: int, tid: int, iotype: int, ret: int) -> None:
+        """Exit from an I/O syscall."""
+        self.io_events +=3D 1
+        task =3D self.task(tid)
+        pending =3D task.io_pending
+        task.io_pending =3D None
+        if not pending or pending[1] !=3D iotype:
+            return
+        start =3D pending[0]
+        task.io.add(start, max(time, start + 1), iotype, (pending[2], ret)=
)
+        if ret > 0 and iotype in (IOTYPE_READ, IOTYPE_WRITE, IOTYPE_TX, IO=
TYPE_RX):
+            task.io_bytes +=3D ret
+
+    def _on_sched_switch(self, time: int, sample: perf.sample_event) -> No=
ne:
+        self.sched_switch(time, sample.sample_cpu, sample.prev_pid,
+                          getattr(sample, "prev_comm", None), sample.prev_=
state,
+                          sample.next_pid, getattr(sample, "next_comm", No=
ne))
+
+    def _on_sched_wakeup(self, time: int, sample: perf.sample_event) -> No=
ne:
+        waker =3D getattr(sample, "common_pid", sample.sample_tid)
+        flags =3D getattr(sample, "common_flags", 0)
+        if flags & (TRACE_FLAG_HARDIRQ | TRACE_FLAG_SOFTIRQ):
+            waker =3D -1
+        self.sched_wakeup(time, sample.pid, getattr(sample, "comm", None),=
 waker)
+
+    def _cstate(self, time: int, cpu: int, state: int) -> None:
+        if (state & 0xffffffff) =3D=3D PWR_EVENT_EXIT:
+            self.cstate_end(time, cpu)
+        else:
+            self.cstate_start(time, cpu, state)
+
+    def _on_cpu_idle(self, time: int, sample: perf.sample_event) -> None:
+        self._cstate(time, sample.cpu_id, sample.state)
+
+    def _on_power_start(self, time: int, sample: perf.sample_event) -> Non=
e:
+        self._cstate(time, sample.cpu_id, sample.value)
+
+    def _on_power_end(self, time: int, sample: perf.sample_event) -> None:
+        self.cstate_end(time, sample.sample_cpu)
+
+    def _on_cpu_frequency(self, time: int, sample: perf.sample_event) -> N=
one:
+        self.pstate_change(time, sample.cpu_id, sample.state)
+
+    def _on_power_frequency(self, time: int, sample: perf.sample_event) ->=
 None:
+        self.pstate_change(time, sample.cpu_id, sample.value)
+
+    def _handler_for(self, name: str) -> Optional[Callable[[int, perf.samp=
le_event], None]]:
+        """Find the handler for events with the given evsel name."""
+        handlers: Dict[str, Callable[[int, perf.sample_event], None]] =3D =
{
+            "sched:sched_switch": self._on_sched_switch,
+            "sched:sched_wakeup": self._on_sched_wakeup,
+            "sched:sched_wakeup_new": self._on_sched_wakeup,
+            "power:cpu_idle": self._on_cpu_idle,
+            "power:power_start": self._on_power_start,
+            "power:power_end": self._on_power_end,
+            "power:cpu_frequency": self._on_cpu_frequency,
+            "power:power_frequency": self._on_power_frequency,
+        }
+        if name in handlers:
+            return handlers[name]
+        if name.startswith("syscalls:sys_enter_") and name[19:] in IO_SYSC=
ALLS:
+            iotype =3D IO_SYSCALLS[name[19:]]
+            return lambda time, sample: self.io_enter(time, sample.sample_=
tid, iotype,
+                                                      getattr(sample, "fd"=
, -1))
+        if name.startswith("syscalls:sys_exit_") and name[18:] in IO_SYSCA=
LLS:
+            iotype =3D IO_SYSCALLS[name[18:]]
+            return lambda time, sample: self.io_exit(time, sample.sample_t=
id, iotype,
+                                                     sample.ret)
+        return None
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Callback from perf.session for each sample."""
+        self.nr_samples +=3D 1
+        if self.nr_samples % self.PROGRESS_INTERVAL =3D=3D 0:
+            if self.cancelled:
+                raise LoadCancelled()
+            now =3D monotonic()
+            interval =3D min(max(self.PROGRESS_SECONDS,
+                               (now - self.start_progress) * self.PROGRESS=
_FRACTION),
+                           self.PROGRESS_MAX_SECONDS)
+            if self.progress and now - self.last_progress >=3D interval:
+                with self.lock:
+                    self.update_comms()
+                # Must not hold the lock as the callback may read the data=
.
+                self.progress()
+                # Time from when the callback, that may block, returns.
+                self.last_progress =3D monotonic()
+        with self.lock:
+            self._process_event(sample)
+
+    def _process_event(self, sample: perf.sample_event) -> None:
+        """Update the data from a sample, the lock must be held."""
+        time =3D sample.sample_time
+        if not self.first_time or time < self.first_time:
+            self.first_time =3D time
+        self.last_time =3D max(self.last_time, time)
+
+        # Computing the evsel name and matching it is relatively expensive=
,
+        # so cache the result by sample ID. Each ID belongs to a single ev=
sel.
+        sample_id =3D sample.sample_id
+        cached =3D self._handlers.get(sample_id)
+        if cached is None:
+            name =3D str(sample.evsel)
+            if name.startswith("evsel(") and name.endswith(")"):
+                name =3D name[6:-1]
+            cached =3D (name, self._handler_for(name))
+            self._handlers[sample_id] =3D cached
+        name, handler =3D cached
+        if handler is None:
+            self.unhandled[name] +=3D 1
+            return
+        try:
+            handler(time, sample)
+        except AttributeError:
+            self.unhandled[name] +=3D 1
+
+    def update_comms(self) -> None:
+        """Refresh task command names from the session, the lock must be h=
eld."""
+        if not self.session:
+            return
+        for tid, task in self.tasks.items():
+            try:
+                thread =3D self.session.find_thread(tid, tid)
+                if thread:
+                    task.set_comm(thread.comm())
+            except (OSError, ValueError, KeyError, RuntimeError, TypeError=
, AttributeError):
+                pass
+
+    def finish(self) -> None:
+        """Close open segments at the end of the trace."""
+        with self.lock:
+            self.update_comms()
+            end =3D self.last_time
+            for task in self.tasks.values():
+                task.change_state(end, STATE_UNKNOWN)
+            for c in self.cpus.values():
+                if c.cur_tid > 0:
+                    c.run.add(c.since, end, 1, c.cur_tid)
+                if c.cstate_cur:
+                    c.cstate.add(c.cstate_cur[0], end, 1, c.cstate_cur[1])
+                    c.cstate_cur =3D None
+                if c.pstate_cur:
+                    c.pstate.add(c.pstate_cur[0], end, 1, c.pstate_cur[1])
+                    c.pstate_cur =3D None
+
+    def fmt_time(self, time: float) -> str:
+        """Format an absolute timestamp relative to the trace start."""
+        return f"{(time - self.first_time) / NSEC_PER_SEC:.6f}s"
+
+    def task_name(self, tid: int) -> str:
+        """Name of a task, or a description for special tids."""
+        if tid =3D=3D 0:
+            return "idle"
+        if tid < 0:
+            return "interrupt"
+        task =3D self.tasks.get(tid)
+        return task.name() if task else f"[{tid}]"
+
+    def sched_tasks(self, filters: Sequence[str]) -> List[Task]:
+        """Tasks with scheduling history passing the filters, sorted by ti=
d."""
+        return sorted((t for t in self.tasks.values()
+                       if len(t.segs) and t.passes_filter(filters)),
+                      key=3Dlambda t: t.tid)
+
+    def io_tasks(self, filters: Sequence[str]) -> List[Task]:
+        """Tasks with I/O passing the filters, most I/O first."""
+        return sorted((t for t in self.tasks.values()
+                       if len(t.io) and t.passes_filter(filters)),
+                      key=3Dlambda t: -len(t.io))
+
+    def dump(self, power_only: bool, tasks_only: bool, filters: Sequence[s=
tr]) -> None:
+        """Print a plain text summary, for use without a terminal UI."""
+        duration =3D self.last_time - self.first_time
+        span =3D max(duration, 1)
+        tasks =3D self.sched_tasks(filters)
+        io_tasks =3D self.io_tasks(filters)
+        print(f"Duration: {fmt_duration(duration)}, CPUs: {len(self.cpus)}=
, "
+              f"tasks: {len(tasks) or len(io_tasks)}, sched events: {self.=
sched_events}, "
+              f"power events: {self.power_events}, I/O events: {self.io_ev=
ents}")
+        if not tasks_only:
+            for c in sorted(self.cpus.values(), key=3Dlambda c: c.cpu):
+                busy =3D sum(e - s for s, e in zip(c.run.starts, c.run.end=
s))
+                print(f"CPU {c.cpu}: busy {busy * 100 / span:.1f}%, "
+                      f"{len(c.run)} runs, {len(c.cstate)} idle periods, "
+                      f"{len(c.pstate)} frequency periods")
+        if power_only:
+            return
+        print(f"{'Task':<24} {'TID':>8} {'Running':>12} {'Waiting':>12} {'=
Blocked':>12} "
+              f"{'Switches':>9} {'Wakeups':>8}")
+        for task in sorted(tasks, key=3Dlambda t: -t.totals[STATE_RUNNING]=
):
+            print(f"{task.comm[:24]:<24} {task.tid:>8} "
+                  f"{fmt_duration(task.totals[STATE_RUNNING]):>12} "
+                  f"{fmt_duration(task.totals[STATE_WAITING]):>12} "
+                  f"{fmt_duration(task.totals[STATE_BLOCKED]):>12} "
+                  f"{task.switches:>9} {len(task.wakeups):>8}")
+        for task in io_tasks:
+            print(f"I/O {task.name()}: {len(task.io)} syscalls, {task.io_b=
ytes} bytes")
+
+
+Cell =3D Tuple[str, Style]
+
+
+class ThemeColors:
+    """Colors and Rich styles derived from the active Textual theme."""
+    def __init__(self, theme_variables: Mapping[str, str]) -> None:
+        self.running =3D theme_variables["primary"]
+        self.waiting =3D theme_variables["error"]
+        self.blocked =3D theme_variables["warning"]
+        self.idle_light =3D theme_variables["secondary-lighten-2"]
+        self.idle_dark =3D theme_variables["secondary-darken-2"]
+        self.freq_low =3D theme_variables["success"]
+        self.freq_high =3D theme_variables["error"]
+        self.io =3D [
+            theme_variables["success"],
+            theme_variables["error"],
+            theme_variables["warning"],
+            theme_variables["accent"],
+            theme_variables["primary"],
+            theme_variables["secondary-lighten-2"],
+        ]
+        run_color =3D Color.parse(self.running).rich_color
+        wait_color =3D Color.parse(self.waiting).rich_color
+        block_color =3D Color.parse(self.blocked).rich_color
+        self.run_style =3D Style(color=3Drun_color)
+        self.wait_style =3D Style(color=3Drun_color, bgcolor=3Dwait_color)
+        self.block_style =3D Style(color=3Drun_color, bgcolor=3Dblock_colo=
r)
+        low =3D Color.parse(self.freq_low)
+        high =3D Color.parse(self.freq_high)
+        self.freq_styles =3D [Style(color=3Dlow.blend(high, x / 8).rich_co=
lor) for x in range(9)]
+        light =3D Color.parse(self.idle_light)
+        dark =3D Color.parse(self.idle_dark)
+        self.idle_styles =3D [Style(color=3Dlight.blend(dark, x / 8).rich_=
color) for x in range(9)]
+        self.io_styles =3D [Style(color=3DColor.parse(c).rich_color) for c=
 in self.io]
+        self.io_err_styles =3D [Style(color=3DColor.parse(c).rich_color, u=
nderline=3DTrue)
+                              for c in self.io]
+        accent =3D Color.parse(theme_variables["accent"]).rich_color
+        accent_muted =3D Color.parse(theme_variables["accent-muted"]).rich=
_color
+        self.selected_style =3D Style(color=3Daccent, bgcolor=3Daccent_mut=
ed, bold=3DTrue)
+
+
+class Row(ABC):
+    """A row within a timeline view."""
+    def __init__(self, label: str) -> None:
+        self._label =3D label
+
+    def label(self) -> str:
+        """Label shown to the left of the row."""
+        return self._label
+
+    @abstractmethod
+    def segments(self) -> SegmentList:
+        """Segments used for navigating between changes."""
+
+    @abstractmethod
+    def cells(self, t0: float, dt: float, width: int, colors: ThemeColors)=
 -> List[Cell]:
+        """Cells for the columns starting at time t0 and dt wide."""
+
+    @abstractmethod
+    def describe(self, time: float, t0: float, t1: float) -> str:
+        """Rich markup describing the row at time within the window [t0, t=
1)."""
+
+
+class TaskRow(Row):
+    """Row showing the running, waiting and blocked states of a task.
+
+    The height of the bar shows the fraction of the time running, the
+    background shows waiting for a CPU or being blocked.
+    """
+    def __init__(self, data: TimechartData, task: Task) -> None:
+        super().__init__(task.name())
+        self.data =3D data
+        self.task =3D task
+
+    def label(self) -> str:
+        return self.task.name()
+
+    def segments(self) -> SegmentList:
+        return self.task.segs
+
+    def cells(self, t0: float, dt: float, width: int, colors: ThemeColors)=
 -> List[Cell]:
+        result =3D []
+        for col in self.task.segs.coverage(t0, dt, width, NUM_STATES):
+            run =3D col[STATE_RUNNING] / dt
+            wait =3D col[STATE_WAITING]
+            block =3D col[STATE_BLOCKED]
+            if wait > 0 and wait >=3D block:
+                style =3D colors.wait_style
+            elif block > 0:
+                style =3D colors.block_style
+            else:
+                style =3D colors.run_style
+            result.append((bar_char(run), style))
+        return result
+
+    def describe(self, time: float, t0: float, t1: float) -> str:
+        task =3D self.task
+        i =3D task.segs.find(time)
+        if i >=3D 0:
+            state =3D task.segs.keys[i]
+            desc =3D STATE_NAMES[state]
+            if state =3D=3D STATE_RUNNING:
+                desc +=3D f" on CPU {task.segs.data[i]}"
+            elif state =3D=3D STATE_WAITING and task.segs.data[i] >=3D 0:
+                desc +=3D f", last ran on CPU {task.segs.data[i]}"
+            start =3D task.segs.starts[i]
+            end =3D task.segs.ends[i]
+            desc +=3D (f" from {self.data.fmt_time(start)} for "
+                     f"{fmt_duration(end - start)}")
+        else:
+            desc =3D "sleeping or not traced"
+        window =3D task.segs.coverage(t0, max(t1 - t0, 1), 1, NUM_STATES)[=
0]
+        span =3D max(t1 - t0, 1)
+        lines =3D [
+            f"[b]{escape(task.name())}[/b]: {desc}",
+            f"In view: running {window[STATE_RUNNING] * 100 / span:.1f}%, =
"
+            f"waiting {window[STATE_WAITING] * 100 / span:.1f}%, "
+            f"blocked {window[STATE_BLOCKED] * 100 / span:.1f}%",
+            f"Total: running {fmt_duration(task.totals[STATE_RUNNING])}, "
+            f"waiting {fmt_duration(task.totals[STATE_WAITING])}, "
+            f"blocked {fmt_duration(task.totals[STATE_BLOCKED])}, "
+            f"{task.switches} switches, {len(task.wakeups)} wakeups",
+        ]
+        idx =3D bisect.bisect_right(task.wakeups, (time, sys.maxsize)) - 1
+        if idx >=3D 0:
+            wake_time, waker =3D task.wakeups[idx]
+            lines.append(f"Last woken at {self.data.fmt_time(wake_time)} b=
y "
+                         f"{escape(self.data.task_name(waker))} (press 'w'=
 to go to waker)")
+        if len(task.comms) > 1:
+            lines.append(f"Names: {escape(', '.join(task.comms))}")
+        return "\n".join(lines)
+
+
+class CpuRow(Row):
+    """Row showing how busy a CPU is, colored by frequency if known."""
+    def __init__(self, data: TimechartData, cpu: Cpu) -> None:
+        super().__init__(f"CPU {cpu.cpu}")
+        self.data =3D data
+        self.cpu =3D cpu
+
+    def segments(self) -> SegmentList:
+        return self.cpu.run
+
+    def cells(self, t0: float, dt: float, width: int, colors: ThemeColors)=
 -> List[Cell]:
+        busy =3D self.cpu.run.coverage(t0, dt, width, 2)
+        freqs: Optional[List[List[float]]] =3D None
+        weighted: Optional[List[List[float]]] =3D None
+        if len(self.cpu.pstate) and self.data.max_freq > self.data.min_fre=
q:
+            freqs =3D self.cpu.pstate.coverage(t0, dt, width, 2)
+            weighted =3D self.cpu.pstate.coverage(t0, dt, width, 2, weight=
_fn=3Dfloat)
+        result =3D []
+        for x in range(width):
+            style =3D colors.run_style
+            if freqs and weighted and freqs[x][1] > 0:
+                freq =3D weighted[x][1] / freqs[x][1]
+                frac =3D (freq - self.data.min_freq) / (self.data.max_freq=
 - self.data.min_freq)
+                style =3D colors.freq_styles[max(0, min(8, round(frac * 8)=
))]
+            result.append((bar_char(busy[x][1] / dt), style))
+        return result
+
+    def describe(self, time: float, t0: float, t1: float) -> str:
+        c =3D self.cpu
+        i =3D c.run.find(time)
+        if i >=3D 0:
+            desc =3D (f"running {escape(self.data.task_name(c.run.data[i])=
)} from "
+                    f"{self.data.fmt_time(c.run.starts[i])} for "
+                    f"{fmt_duration(c.run.ends[i] - c.run.starts[i])}")
+        else:
+            desc =3D "idle"
+        i =3D c.cstate.find(time)
+        if i >=3D 0:
+            desc +=3D f", C-state C{c.cstate.data[i]}"
+        i =3D c.pstate.find(time)
+        if i >=3D 0:
+            desc +=3D f", {c.pstate.data[i] / 1000:.0f} MHz"
+        span =3D max(t1 - t0, 1)
+        window =3D c.run.coverage(t0, span, 1, 2)[0]
+        return "\n".join([
+            f"[b]CPU {c.cpu}[/b]: {desc}",
+            f"In view: busy {window[1] * 100 / span:.1f}%",
+            "Bar height is the fraction of time busy" +
+            (", color is the frequency from low to high"
+             if len(c.pstate) else ""),
+        ])
+
+
+class CStateRow(Row):
+    """Row showing the idle states of a CPU."""
+    def __init__(self, data: TimechartData, cpu: Cpu) -> None:
+        super().__init__(f"  CPU {cpu.cpu} idle")
+        self.data =3D data
+        self.cpu =3D cpu
+
+    def segments(self) -> SegmentList:
+        return self.cpu.cstate
+
+    def cells(self, t0: float, dt: float, width: int, colors: ThemeColors)=
 -> List[Cell]:
+        cov =3D self.cpu.cstate.coverage(t0, dt, width, 2)
+        depth =3D self.cpu.cstate.coverage(t0, dt, width, 2, weight_fn=3Df=
loat)
+        max_cstate =3D max(self.data.max_cstate, 1)
+        result =3D []
+        for x in range(width):
+            frac =3D cov[x][1] / dt
+            style =3D colors.idle_styles[0]
+            if cov[x][1] > 0:
+                avg =3D depth[x][1] / cov[x][1]
+                style =3D colors.idle_styles[max(0, min(8, round(avg * 8 /=
 max_cstate)))]
+            result.append((bar_char(frac), style))
+        return result
+
+    def describe(self, time: float, t0: float, t1: float) -> str:
+        c =3D self.cpu
+        i =3D c.cstate.find(time)
+        if i >=3D 0:
+            desc =3D (f"C{c.cstate.data[i]} from {self.data.fmt_time(c.cst=
ate.starts[i])} for "
+                    f"{fmt_duration(c.cstate.ends[i] - c.cstate.starts[i])=
}")
+        else:
+            desc =3D "not idle"
+        span =3D max(t1 - t0, 1)
+        window =3D c.cstate.coverage(t0, span, 1, 2)[0]
+        return "\n".join([
+            f"[b]CPU {c.cpu} idle state[/b]: {desc}",
+            f"In view: idle {window[1] * 100 / span:.1f}%",
+            "Bar height is the fraction of time idle, darker colors are de=
eper C-states",
+        ])
+
+
+class FreqRow(Row):
+    """Row showing the frequency of a CPU."""
+    def __init__(self, data: TimechartData, cpu: Cpu) -> None:
+        super().__init__(f"  CPU {cpu.cpu} freq")
+        self.data =3D data
+        self.cpu =3D cpu
+
+    def segments(self) -> SegmentList:
+        return self.cpu.pstate
+
+    def cells(self, t0: float, dt: float, width: int, colors: ThemeColors)=
 -> List[Cell]:
+        cov =3D self.cpu.pstate.coverage(t0, dt, width, 2)
+        weighted =3D self.cpu.pstate.coverage(t0, dt, width, 2, weight_fn=
=3Dfloat)
+        max_freq =3D max(self.data.max_freq, 1)
+        min_freq =3D self.data.min_freq
+        result =3D []
+        for x in range(width):
+            if cov[x][1] <=3D 0:
+                result.append((" ", colors.freq_styles[0]))
+                continue
+            freq =3D weighted[x][1] / cov[x][1]
+            frac =3D (freq - min_freq) / (max_freq - min_freq) if max_freq=
 > min_freq else 1.0
+            result.append((bar_char(max(freq / max_freq, 1 / 8)),
+                           colors.freq_styles[max(0, min(8, round(frac * 8=
)))]))
+        return result
+
+    def describe(self, time: float, t0: float, t1: float) -> str:
+        c =3D self.cpu
+        i =3D c.pstate.find(time)
+        if i >=3D 0:
+            desc =3D (f"{c.pstate.data[i] / 1000:.0f} MHz from "
+                    f"{self.data.fmt_time(c.pstate.starts[i])} for "
+                    f"{fmt_duration(c.pstate.ends[i] - c.pstate.starts[i])=
}")
+        else:
+            desc =3D "unknown"
+        return "\n".join([
+            f"[b]CPU {c.cpu} frequency[/b]: {desc}",
+            f"Range: {self.data.min_freq / 1000:.0f} - {self.data.max_freq=
 / 1000:.0f} MHz",
+            "Bar height is the frequency relative to the maximum",
+        ])
+
+
+class IoRow(Row):
+    """Row showing the I/O syscalls of a task."""
+    def __init__(self, data: TimechartData, task: Task) -> None:
+        super().__init__(task.name())
+        self.data =3D data
+        self.task =3D task
+
+    def label(self) -> str:
+        return self.task.name()
+
+    def segments(self) -> SegmentList:
+        return self.task.io
+
+    def cells(self, t0: float, dt: float, width: int, colors: ThemeColors)=
 -> List[Cell]:
+        errs =3D self.task.io.coverage(t0, dt, width, NUM_IOTYPES,
+                                     weight_fn=3Dlambda d: 1.0 if d[1] < 0=
 else 0.0)
+        result =3D []
+        for x, col in enumerate(self.task.io.coverage(t0, dt, width, NUM_I=
OTYPES)):
+            total =3D sum(col)
+            if total <=3D 0:
+                result.append((" ", colors.io_styles[0]))
+                continue
+            iotype =3D col.index(max(col))
+            styles =3D colors.io_err_styles if sum(errs[x]) > 0 else color=
s.io_styles
+            result.append((bar_char(max(total / dt, 1 / 8)), styles[iotype=
]))
+        return result
+
+    def describe(self, time: float, t0: float, t1: float) -> str:
+        task =3D self.task
+        i =3D task.io.find(time)
+        if i < 0:
+            i =3D task.io.last_before(time)
+            prefix =3D "last I/O"
+        else:
+            prefix =3D "in"
+        if i >=3D 0:
+            fd, ret =3D task.io.data[i]
+            result =3D f"returned {ret}" if ret >=3D 0 else f"failed with =
error {-ret}"
+            desc =3D (f"{prefix} {IOTYPE_NAMES[task.io.keys[i]]} fd=3D{fd}=
 at "
+                    f"{self.data.fmt_time(task.io.starts[i])} for "
+                    f"{fmt_duration(task.io.ends[i] - task.io.starts[i])},=
 {result}")
+        else:
+            desc =3D "no I/O"
+        span =3D max(t1 - t0, 1)
+        window =3D task.io.coverage(t0, span, 1, NUM_IOTYPES)[0]
+        in_view =3D ", ".join(f"{IOTYPE_NAMES[t]} {window[t] * 100 / span:=
.1f}%"
+                            for t in range(NUM_IOTYPES) if window[t] > 0)
+        return "\n".join([
+            f"[b]{escape(task.name())}[/b]: {desc}",
+            f"In view: {in_view or 'no I/O'}",
+            f"Total: {len(task.io)} I/O syscalls, {task.io_bytes} bytes",
+        ])
+
+
+@dataclass(frozen=3DTrue)
+class TimeWindow:
+    """The visible time range and the cursor, shared between views.
+
+    Immutable so that it can be a reactive value, the methods return new w=
indows.
+    """
+    first: int
+    last: int
+    start: float
+    end: float
+    cursor: float
+
+    @staticmethod
+    def whole(first: int, last: int) -> "TimeWindow":
+        """A window showing the whole trace with the cursor at the start."=
""
+        last =3D max(last, first + 1)
+        return TimeWindow(first, last, first, last, first)
+
+    def span(self) -> float:
+        """Length of the visible time range."""
+        return self.end - self.start
+
+    def reset(self) -> "TimeWindow":
+        """Show the whole trace."""
+        return replace(self, start=3Dself.first, end=3Dself.last)
+
+    def with_range(self, start: float, span: float) -> "TimeWindow":
+        """Set the visible range clamped to the trace."""
+        span =3D min(max(span, 100.0), self.last - self.first)
+        start =3D min(max(start, self.first), self.last - span)
+        return replace(self, start=3Dstart, end=3Dstart + span)
+
+    def zoom(self, factor: float) -> "TimeWindow":
+        """Zoom by factor keeping the cursor at the same position."""
+        cursor =3D self.cursor
+        if not self.start <=3D cursor <=3D self.end:
+            cursor =3D (self.start + self.end) / 2
+        rel =3D (cursor - self.start) / self.span()
+        span =3D self.span() * factor
+        return replace(self, cursor=3Dcursor).with_range(cursor - rel * sp=
an, span)
+
+    def pan(self, frac: float) -> "TimeWindow":
+        """Pan the view by the fraction of the visible span."""
+        delta =3D self.span() * frac
+        win =3D self.with_range(self.start + delta, self.span())
+        return replace(win, cursor=3Dmin(max(self.cursor + delta, win.star=
t), win.end))
+
+    def with_cursor(self, time: float) -> "TimeWindow":
+        """Move the cursor, scrolling to keep it visible."""
+        win =3D replace(self, cursor=3Dmin(max(time, self.first), self.las=
t))
+        if win.cursor < win.start:
+            return win.with_range(win.cursor, win.span())
+        if win.cursor >=3D win.end:
+            return win.with_range(win.cursor - win.span() * 0.9, win.span(=
))
+        return win
+
+    def extend(self, first: int, last: int) -> "TimeWindow":
+        """Change the bounds of the trace as more of it is loaded.
+
+        If the whole trace was visible then it still is, otherwise the vis=
ible
+        range is kept.
+        """
+        last =3D max(last, first + 1)
+        whole =3D self.start =3D=3D self.first and self.end =3D=3D self.la=
st
+        win =3D replace(self, first=3Dfirst, last=3Dlast, cursor=3Dmin(max=
(self.cursor, first), last))
+        return win.reset() if whole else win.with_range(self.start, self.s=
pan())
+
+
+class TimelineView(ScrollView):
+    """A scrollable view of rows against a time axis.
+
+    Line 0 is a time ruler that stays at the top, the other lines are rows=
.
+    """
+    BINDINGS =3D [
+        Binding("up,k", "row_up", "Up", show=3DFalse),
+        Binding("down,j", "row_down", "Down", show=3DFalse),
+        Binding("left,h", "cursor_left", "Cursor =E2=86=90", key_display=
=3D"=E2=86=90"),
+        Binding("right,l", "cursor_right", "Cursor =E2=86=92", key_display=
=3D"=E2=86=92"),
+        Binding("shift+left,H", "pan_left", "Pan left", show=3DFalse),
+        Binding("shift+right,L", "pan_right", "Pan right", show=3DFalse),
+        Binding("plus,equals_sign", "zoom_in", "Zoom in", key_display=3D"+=
"),
+        Binding("minus", "zoom_out", "Zoom out", key_display=3D"-"),
+        Binding("0,escape", "zoom_reset", "Reset zoom", key_display=3D"0")=
,
+        Binding("n", "next_change", "Next change"),
+        Binding("p", "prev_change", "Prev change"),
+        Binding("pageup", "page_up", "Page up", show=3DFalse),
+        Binding("pagedown", "page_down", "Page down", show=3DFalse),
+    ]
+
+    DEFAULT_CSS =3D """
+    TimelineView {
+        width: 100%;
+        height: 1fr;
+    }
+    """
+
+    class SelectionChanged(Message):
+        """Posted when the selected row changes."""
+
+    # Bound to TimechartApp.window, changing it repaints the view.
+    window: reactive[TimeWindow] =3D reactive(TimeWindow.whole(0, 1))
+    # Index of the selected row.
+    selected: reactive[int] =3D reactive(0)
+
+    def __init__(self, data: TimechartData, rows: List[Row], *pos_args, **=
kwargs) -> None:
+        super().__init__(*pos_args, **kwargs)
+        self.can_focus =3D True
+        self.data =3D data
+        self.rows =3D rows
+        self.cache: Dict[int, List[Cell]] =3D {}
+        self.cache_key: Tuple[float, float, int, Optional[ThemeColors]] =
=3D (0.0, 0.0, 0, None)
+        self.label_style =3D Style()
+        self.ruler_style =3D Style(dim=3DTrue)
+        self.cursor_style =3D Style(reverse=3DTrue)
+
+    def selected_row(self) -> Optional[Row]:
+        """The selected row, if any."""
+        if 0 <=3D self.selected < len(self.rows):
+            return self.rows[self.selected]
+        return None
+
+    def timeline_width(self) -> int:
+        """Number of columns used for the timeline."""
+        return max(self.scrollable_content_region.width - LABEL_WIDTH, 1)
+
+    def update_size(self) -> None:
+        """Update the virtual size after rows change or the widget resizes=
."""
+        self.virtual_size =3D Size(self.scrollable_content_region.width, l=
en(self.rows) + 1)
+
+    def on_mount(self) -> None:
+        """Size the view when mounted."""
+        self.update_size()
+
+    def on_resize(self) -> None:
+        """Size the view when resized."""
+        self.update_size()
+        self.refresh()
+
+    def set_rows(self, rows: List[Row]) -> None:
+        """Replace the rows, after sorting or as more data is loaded.
+
+        The selected row is kept, if it moves watch_selected scrolls to it=
.
+        """
+        selected =3D self.selected_row()
+        self.rows =3D rows
+        self.cache.clear()
+        self.update_size()
+        self.selected =3D rows.index(selected) if selected in rows else 0
+        self.refresh()
+
+    def validate_selected(self, idx: int) -> int:
+        """Keep the selection within the rows."""
+        return max(0, min(idx, len(self.rows) - 1))
+
+    def watch_selected(self) -> None:
+        """Keep the selection visible and tell the app."""
+        self.scroll_to_selected()
+        self.post_message(self.SelectionChanged())
+
+    def scroll_to_selected(self) -> None:
+        """Scroll so that the selected row is visible below the ruler."""
+        _, scroll_y =3D self.scroll_offset
+        visible =3D max(self.scrollable_content_region.height - 1, 1)
+        if self.selected < scroll_y:
+            self.scroll_to(y=3Dself.selected, animate=3DFalse)
+        elif self.selected >=3D scroll_y + visible:
+            self.scroll_to(y=3Dself.selected - visible + 1, animate=3DFals=
e)
+
+    def set_window(self, window: TimeWindow) -> None:
+        """Change the window shared by all views, owned by the app."""
+        app =3D self.app
+        if isinstance(app, TimechartApp):
+            app.window =3D window
+
+    def ruler(self, width: int) -> Strip:
+        """The time axis, labeled in seconds relative to the trace start."=
""
+        win =3D self.window
+        dt =3D win.span() / width
+        tick =3D 14
+        decimals =3D max(0, min(9, 1 - math.floor(math.log10(max(dt * tick=
, 1) / NSEC_PER_SEC))))
+        chars =3D [" "] * width
+        x =3D 0
+        while x < width:
+            label =3D f"|{(win.start + x * dt - self.data.first_time) / NS=
EC_PER_SEC:.{decimals}f}"
+            if x + len(label) > width:
+                break
+            chars[x:x + len(label)] =3D list(label)
+            x +=3D max(tick, len(label) + 2)
+        segments =3D [Segment(make_fixed_length_string("Time (s)", LABEL_W=
IDTH), self.ruler_style)]
+        cursor_x =3D self.cursor_column(width)
+        if 0 <=3D cursor_x < width:
+            segments.append(Segment("".join(chars[:cursor_x]), self.ruler_=
style))
+            segments.append(Segment("=E2=96=BC"))
+            segments.append(Segment("".join(chars[cursor_x + 1:]), self.ru=
ler_style))
+        else:
+            segments.append(Segment("".join(chars), self.ruler_style))
+        return Strip(segments)
+
+    def cursor_column(self, width: int) -> int:
+        """Column of the cursor or -1 if not visible."""
+        win =3D self.window
+        if not win.start <=3D win.cursor < win.end:
+            return -1
+        return min(int((win.cursor - win.start) * width / win.span()), wid=
th - 1)
+
+    def render_line(self, y: int) -> Strip:
+        """Render the ruler or a row."""
+        width =3D self.timeline_width()
+        if y =3D=3D 0:
+            return self.ruler(width)
+        _, scroll_y =3D self.scroll_offset
+        idx =3D scroll_y + y - 1
+        if idx >=3D len(self.rows):
+            return Strip.blank(self.scrollable_content_region.width)
+
+        colors =3D self.app.theme_colors if isinstance(self.app, Timechart=
App) else \
+            ThemeColors(self.app.theme_variables)
+        win =3D self.window
+        key =3D (win.start, win.end, width, colors)
+        if key !=3D self.cache_key:
+            self.cache.clear()
+            self.cache_key =3D key
+        row =3D self.rows[idx]
+        with self.data.lock:
+            cells =3D self.cache.get(idx)
+            if cells is None:
+                cells =3D row.cells(win.start, win.span() / width, width, =
colors)
+                self.cache[idx] =3D cells
+            label =3D row.label()
+
+        label_style =3D colors.selected_style if idx =3D=3D self.selected =
else self.label_style
+        segments =3D [Segment(make_fixed_length_string(label, LABEL_WIDTH =
- 1) + " ",
+                            label_style)]
+        cursor_x =3D self.cursor_column(width)
+        # Merge runs of cells with the same style into one segment.
+        text =3D ""
+        style: Optional[Style] =3D None
+        for x, (char, cell_style) in enumerate(cells):
+            if x =3D=3D cursor_x:
+                cell_style =3D cell_style + self.cursor_style
+            if cell_style is not style and text:
+                segments.append(Segment(text, style))
+                text =3D ""
+            text +=3D char
+            style =3D cell_style
+        if text:
+            segments.append(Segment(text, style))
+        return Strip(segments)
+
+    def column_time(self, x: int) -> float:
+        """Time at the center of the column containing screen offset x."""
+        width =3D self.timeline_width()
+        return self.window.start + (x - LABEL_WIDTH + 0.5) * self.window.s=
pan() / width
+
+    def on_click(self, click: events.Click) -> None:
+        """Select the clicked row and move the cursor to the clicked time.=
"""
+        if click.x >=3D LABEL_WIDTH:
+            self.set_window(self.window.with_cursor(self.column_time(click=
.x)))
+        if click.y > 0:
+            _, scroll_y =3D self.scroll_offset
+            self.selected =3D scroll_y + click.y - 1
+
+    def action_row_up(self) -> None:
+        """Select the previous row."""
+        self.selected -=3D 1
+
+    def action_row_down(self) -> None:
+        """Select the next row."""
+        self.selected +=3D 1
+
+    def action_page_up(self) -> None:
+        """Select a row a page up."""
+        self.selected -=3D max(self.scrollable_content_region.height - 2, =
1)
+
+    def action_page_down(self) -> None:
+        """Select a row a page down."""
+        self.selected +=3D max(self.scrollable_content_region.height - 2, =
1)
+
+    def action_cursor_left(self) -> None:
+        """Move the cursor one column left."""
+        win =3D self.window
+        self.set_window(win.with_cursor(win.cursor - win.span() / self.tim=
eline_width()))
+
+    def action_cursor_right(self) -> None:
+        """Move the cursor one column right."""
+        win =3D self.window
+        self.set_window(win.with_cursor(win.cursor + win.span() / self.tim=
eline_width()))
+
+    def action_pan_left(self) -> None:
+        """Pan a quarter of the view left."""
+        self.set_window(self.window.pan(-0.25))
+
+    def action_pan_right(self) -> None:
+        """Pan a quarter of the view right."""
+        self.set_window(self.window.pan(0.25))
+
+    def action_zoom_in(self) -> None:
+        """Halve the visible time range around the cursor."""
+        self.set_window(self.window.zoom(0.5))
+
+    def action_zoom_out(self) -> None:
+        """Double the visible time range around the cursor."""
+        self.set_window(self.window.zoom(2))
+
+    def action_zoom_reset(self) -> None:
+        """Show the whole trace."""
+        self.set_window(self.window.reset())
+
+    def action_next_change(self) -> None:
+        """Move the cursor to the next change in the selected row."""
+        row =3D self.selected_row()
+        if row:
+            # Skip changes within the cursor's column.
+            win =3D self.window
+            with self.data.lock:
+                time =3D row.segments().next_change(
+                    win.cursor + win.span() / self.timeline_width() / 2)
+            if time is not None:
+                self.set_window(win.with_cursor(time))
+
+    def action_prev_change(self) -> None:
+        """Move the cursor to the previous change in the selected row."""
+        row =3D self.selected_row()
+        if row:
+            win =3D self.window
+            with self.data.lock:
+                time =3D row.segments().prev_change(
+                    win.cursor - win.span() / self.timeline_width() / 2)
+            if time is not None:
+                self.set_window(win.with_cursor(time))
+
+
+class TimechartApp(App):
+    """A Textual application to display a timechart."""
+    TITLE =3D "perf timechart"
+
+    BINDINGS =3D [
+        Binding("s", "sort", "Sort tasks", tooltip=3D"Cycle task sort orde=
r"),
+        Binding("w", "goto_waker", "Go to waker",
+                tooltip=3D"Select the task that last woke the selected tas=
k"),
+        Binding(key=3D"^q", action=3D"quit", description=3D"Quit", tooltip=
=3D"Quit the app"),
+    ]
+
+    CSS =3D """
+    TabbedContent, TabbedContent > ContentSwitcher, TabPane {
+        height: 1fr;
+    }
+    TabPane {
+        padding: 0;
+    }
+    .legend {
+        height: 1;
+        padding: 0 1;
+    }
+    #details {
+        height: 8;
+        border: round $primary;
+        padding: 0 1;
+    }
+    """
+
+    SORT_ORDERS =3D ["run time", "tid", "name", "first run"]
+
+    # The visible time range and cursor, bound to each TimelineView's wind=
ow.
+    window: reactive[TimeWindow] =3D reactive(TimeWindow.whole(0, 1), init=
=3DFalse)
+    # Index into SORT_ORDERS for the tasks view.
+    sort_order: reactive[int] =3D reactive(0, init=3DFalse)
+
+    def __init__(self, input_name: str, power_only: bool, tasks_only: bool=
,
+                 filters: Sequence[str], data: Optional[TimechartData] =3D=
 None) -> None:
+        """Create the app, if data isn't given it is loaded from input_nam=
e.
+
+        While the data is loading the views show what has been read so far=
.
+        """
+        super().__init__()
+        self.input_name =3D input_name
+        self.power_only =3D power_only
+        self.tasks_only =3D tasks_only
+        self.filters =3D filters
+        # The data being displayed, possibly still being loaded.
+        self.data =3D data if data else TimechartData()
+        self.loaded =3D data is not None
+        # The data being loaded in a background thread.
+        self.loading: Optional[TimechartData] =3D None
+        self.tasks: List[Task] =3D []
+        self.io_tasks: List[Task] =3D []
+        # Rows keyed by type and CPU or tid. They are reused as the data l=
oads
+        # so that the views can keep the selected row.
+        self.row_cache: Dict[Tuple[str, int], Row] =3D {}
+        self.io_tab_shown =3D True
+        # Does the summary table need updating before it is next shown?
+        self.summary_stale =3D True
+        self.theme_colors =3D ThemeColors(self.theme_variables)
+
+    def cached_row(self, cls: Callable[[TimechartData, Any], Row], num: in=
t, obj: Any) -> Row:
+        """Find or create the row of type cls for the CPU or task obj numb=
ered num."""
+        key =3D (getattr(cls, "__name__", ""), num)
+        row =3D self.row_cache.get(key)
+        if row is None:
+            row =3D cls(self.data, obj)
+            self.row_cache[key] =3D row
+        return row
+
+    def cpu_rows(self) -> List[Row]:
+        """Rows for the CPUs tab, the data's lock must be held."""
+        rows: List[Row] =3D []
+        for cpu in sorted(self.data.cpus.values(), key=3Dlambda c: c.cpu):
+            if len(cpu.run) or len(cpu.cstate) or len(cpu.pstate):
+                rows.append(self.cached_row(CpuRow, cpu.cpu, cpu))
+            if len(cpu.cstate):
+                rows.append(self.cached_row(CStateRow, cpu.cpu, cpu))
+            if len(cpu.pstate):
+                rows.append(self.cached_row(FreqRow, cpu.cpu, cpu))
+        return rows
+
+    def task_rows(self) -> List[Row]:
+        """Rows for the tasks tab in the current sort order, the data's lo=
ck must be held."""
+        order =3D self.SORT_ORDERS[self.sort_order]
+        if order =3D=3D "run time":
+            tasks =3D sorted(self.tasks, key=3Dlambda t: -t.totals[STATE_R=
UNNING])
+        elif order =3D=3D "name":
+            tasks =3D sorted(self.tasks, key=3Dlambda t: (t.comm, t.tid))
+        elif order =3D=3D "first run":
+            tasks =3D sorted(self.tasks, key=3Dlambda t: t.segs.starts[0])
+        else:
+            tasks =3D self.tasks
+        return [self.cached_row(TaskRow, t.tid, t) for t in tasks]
+
+    def compose(self) -> ComposeResult:
+        """Composes the user interface of the application."""
+        yield Header()
+        with TabbedContent():
+            if not self.tasks_only:
+                with TabPane("CPUs", id=3D"cpus"):
+                    yield Static(id=3D"cpus_legend", classes=3D"legend")
+                    yield TimelineView(self.data, [],
+                                       id=3D"cpus_view").data_bind(Timecha=
rtApp.window)
+            if not self.power_only:
+                with TabPane("Tasks", id=3D"tasks"):
+                    yield Static(id=3D"tasks_legend", classes=3D"legend")
+                    yield TimelineView(self.data, [],
+                                       id=3D"tasks_view").data_bind(Timech=
artApp.window)
+                # Hidden until there are tasks doing I/O.
+                with TabPane("I/O", id=3D"io"):
+                    yield Static(id=3D"io_legend", classes=3D"legend")
+                    yield TimelineView(self.data, [],
+                                       id=3D"io_view").data_bind(Timechart=
App.window)
+                with TabPane("Summary", id=3D"summary"):
+                    yield DataTable(id=3D"summary_table", cursor_type=3D"r=
ow")
+        yield Static(id=3D"details")
+        yield Footer()
+
+    def on_mount(self) -> None:
+        """Show the data, loading it in the background if it wasn't given.=
"""
+        self.theme_changed_signal.subscribe(self, self.on_theme_changed)
+        self.update_legends()
+        self.update_views()
+        view =3D self.active_view()
+        if view:
+            view.focus()
+        if self.loaded:
+            self.finish_loading()
+        else:
+            self.sub_title =3D f"Loading {self.input_name}"
+            self.loading =3D self.data
+            self.load_events()
+
+    def on_theme_changed(self, _theme: Any) -> None:
+        """Update colors, legends and timeline views when the theme change=
s."""
+        self.theme_colors =3D ThemeColors(self.theme_variables)
+        self.update_legends()
+        for view in self.query(TimelineView):
+            view.refresh()
+
+    def update_legends(self) -> None:
+        """Update the legend strings using the active theme's colors."""
+        c =3D self.theme_colors
+        with self.data.lock:
+            cpus_legend =3D self.cpu_legend()
+        for static in self.query("#cpus_legend").results(Static):
+            static.update(cpus_legend)
+        tasks_legend =3D (f"[{c.running}]=E2=96=88[/] running   "
+                        f"[on {c.waiting}] [/] runnable   "
+                        f"[on {c.blocked}] [/] blocked   "
+                        "(bar height is the fraction of time running)")
+        for static in self.query("#tasks_legend").results(Static):
+            static.update(tasks_legend)
+        io_legend =3D ("   ".join(f"[{c.io[t]}]=E2=96=88[/] {IOTYPE_NAMES[=
t]}"
+                                for t in range(NUM_IOTYPES)) +
+                     "   (underline is an error)")
+        for static in self.query("#io_legend").results(Static):
+            static.update(io_legend)
+
+    @work(thread=3DTrue, exclusive=3DTrue)
+    def load_events(self) -> None:
+        """Read the perf.data file in a thread so the UI stays responsive.=
"""
+        data =3D self.loading or self.data
+        self.loading =3D data
+
+        def progress() -> None:
+            try:
+                # Blocks until the UI has shown the data read so far.
+                self.call_from_thread(self.update_progress, data)
+            except RuntimeError:
+                # The app is no longer running.
+                data.cancelled =3D True
+
+        data.progress =3D progress
+        data.start_progress =3D data.last_progress =3D monotonic()
+        try:
+            read_events(data, self.input_name)
+        except LoadCancelled:
+            return
+        except (OSError, ValueError, RuntimeError) as e:
+            self.call_from_thread(self.exit, None, 1,
+                                  f"Error processing {self.input_name}: {e=
}")
+            return
+        finally:
+            data.progress =3D None
+            self.loading =3D None
+        if data.cancelled:
+            return
+        if not data.has_events():
+            self.call_from_thread(self.exit, None, 1,
+                                  f"Error: no scheduler, power or I/O even=
ts found in "
+                                  f"{self.input_name}.\n"
+                                  "Record them with 'perf timechart record=
'.")
+            return
+        self.call_from_thread(self.data_loaded)
+
+    def data_loaded(self) -> None:
+        """Called on the UI thread when loading completes."""
+        self.loaded =3D True
+        self.finish_loading()
+
+    def update_progress(self, data: TimechartData) -> None:
+        """Show how much of the file has been processed and the data so fa=
r."""
+        self.sub_title =3D (f"Loading {self.input_name}: {data.nr_samples:=
,} samples, "
+                          f"{fmt_duration(data.last_time - data.first_time=
)} of trace")
+        self.update_views()
+
+    def finish_loading(self) -> None:
+        """Show all of the data and a summary of it."""
+        self.update_views()
+        views =3D self.query("#cpus_view")
+        if views and not views.first(TimelineView).rows:
+            self.query_one(TabbedContent).hide_tab("cpus")
+        task_views =3D self.query("#tasks_view")
+        if task_views and not task_views.first(TimelineView).rows and self=
.io_tasks:
+            self.query_one(TabbedContent).hide_tab("tasks")
+        nr_tasks =3D len(self.tasks) or len(self.io_tasks)
+        self.sub_title =3D (f"{self.input_name}: "
+                          f"{fmt_duration(self.data.last_time - self.data.=
first_time)}, "
+                          f"{len(self.data.cpus)} CPUs, {nr_tasks} tasks")
+
+    def cancel_loading(self) -> None:
+        """Stop a background load, the worker notices at the next progress=
 interval."""
+        loading =3D self.loading
+        if loading is not None:
+            loading.cancelled =3D True
+
+    async def action_quit(self) -> None:
+        """Quit, stopping any background load."""
+        self.cancel_loading()
+        await super().action_quit()
+
+    def on_unmount(self) -> None:
+        """Stop any background load when the app exits."""
+        self.cancel_loading()
+
+    def cpu_legend(self) -> str:
+        """Legend for the CPUs tab, saying which power events are missing.
+
+        The data's lock must be held.
+        """
+        c =3D self.theme_colors
+        data =3D self.data
+        has_pstate =3D any(len(cpu.pstate) for cpu in data.cpus.values())
+        has_cstate =3D any(len(cpu.cstate) for cpu in data.cpus.values())
+        parts =3D [f"[{c.running}]=E2=96=88[/] busy"]
+        if has_pstate and data.max_freq > data.min_freq:
+            parts.append(f"[{c.freq_low}]=E2=96=88[/]=E2=86=92[{c.freq_hig=
h}]=E2=96=88[/] frequency")
+        elif has_pstate:
+            parts.append(f"frequency constant at {data.max_freq / 1000:.0f=
} MHz")
+        if has_cstate:
+            parts.append(f"[{c.idle_light}]=E2=96=88[/]=E2=86=92[{c.idle_d=
ark}]=E2=96=88[/] idle state")
+        missing =3D []
+        if not has_pstate:
+            missing.append("power:cpu_frequency")
+        if not has_cstate:
+            missing.append("power:cpu_idle")
+        if missing:
+            parts.append(f"[dim](no {' or '.join(missing)} events)[/dim]")
+        return "   ".join(parts)
+
+    def update_views(self) -> None:
+        """Update the views from the data, which may still be loading."""
+        data =3D self.data
+        with data.lock:
+            first, last =3D data.first_time, data.last_time
+            self.tasks =3D data.sched_tasks(self.filters)
+            self.io_tasks =3D data.io_tasks(self.filters)
+            all_rows =3D {
+                "cpus_view": self.cpu_rows(),
+                "tasks_view": self.task_rows(),
+                "io_view": [self.cached_row(IoRow, t.tid, t) for t in self=
.io_tasks],
+            }
+            legend =3D self.cpu_legend()
+        for view_id, rows in all_rows.items():
+            for view in self.query(f"#{view_id}").results(TimelineView):
+                view.set_rows(rows)
+        for static in self.query("#cpus_legend").results(Static):
+            static.update(legend)
+        if self.query("#io") and bool(self.io_tasks) !=3D self.io_tab_show=
n:
+            self.io_tab_shown =3D bool(self.io_tasks)
+            tabbed =3D self.query_one(TabbedContent)
+            if self.io_tab_shown:
+                tabbed.show_tab("io")
+            else:
+                tabbed.hide_tab("io")
+        if first or last:
+            self.window =3D self.window.extend(first, last)
+        self.summary_stale =3D True
+        tabs =3D self.query(TabbedContent)
+        if tabs and tabs.first(TabbedContent).active =3D=3D "summary":
+            self.update_summary()
+        self.update_details()
+
+    def update_summary(self) -> None:
+        """Fill in the summary table keeping the selected task."""
+        tables =3D self.query("#summary_table")
+        if not tables:
+            return
+        self.summary_stale =3D False
+        table =3D tables.first(DataTable)
+        if not table.columns:
+            table.add_columns("Task", "TID", "Running", "Waiting", "Blocke=
d",
+                              "Switches", "Wakeups", "I/O bytes")
+        selected =3D None
+        if table.row_count:
+            try:
+                selected =3D table.coordinate_to_cell_key(table.cursor_coo=
rdinate).row_key
+            except CellDoesNotExist:
+                pass
+        summary_tasks =3D self.tasks if self.tasks else self.io_tasks
+        with self.data.lock:
+            rows =3D [(task.comm, task.tid,
+                     fmt_duration(task.totals[STATE_RUNNING]),
+                     fmt_duration(task.totals[STATE_WAITING]),
+                     fmt_duration(task.totals[STATE_BLOCKED]),
+                     task.switches, len(task.wakeups), task.io_bytes)
+                    for task in sorted(summary_tasks,
+                                       key=3Dlambda t: (-t.totals[STATE_RU=
NNING], -t.io_bytes))]
+        table.clear()
+        for row in rows:
+            table.add_row(*row, key=3Dstr(row[1]))
+        if selected is not None:
+            try:
+                table.move_cursor(row=3Dtable.get_row_index(selected), ani=
mate=3DFalse)
+            except RowDoesNotExist:
+                pass
+
+    def active_view(self) -> Optional[TimelineView]:
+        """The timeline view in the active tab, if any."""
+        tabs =3D self.query(TabbedContent)
+        if not tabs:
+            return None
+        active =3D tabs.first(TabbedContent).active
+        views =3D self.query(f"#{active}_view") if active else None
+        return views.first(TimelineView) if views else None
+
+    def watch_window(self) -> None:
+        """The bound views repaint themselves, update the details."""
+        self.update_details()
+
+    @on(TimelineView.SelectionChanged)
+    def on_selection_changed(self) -> None:
+        """Describe the newly selected row."""
+        self.update_details()
+
+    def update_details(self) -> None:
+        """Describe the selected row at the cursor."""
+        details =3D self.query("#details")
+        if not details:
+            return
+        win =3D self.window
+        text =3D (f"Cursor [b]{self.data.fmt_time(win.cursor)}[/b]   "
+                f"View {self.data.fmt_time(win.start)} - {self.data.fmt_ti=
me(win.end)} "
+                f"({fmt_duration(win.span())})\n")
+        view =3D self.active_view()
+        row =3D view.selected_row() if view else None
+        if row:
+            with self.data.lock:
+                text +=3D row.describe(win.cursor, win.start, win.end)
+        elif view is None:
+            text +=3D "Select a task and press enter to show it in the Tas=
ks timeline"
+        details.first(Static).update(text)
+
+    @on(TabbedContent.TabActivated)
+    def on_tab_activated(self) -> None:
+        """Focus the view in the newly active tab."""
+        view =3D self.active_view()
+        if view:
+            view.focus()
+        else:
+            if self.summary_stale:
+                self.update_summary()
+            tables =3D self.query("#summary_table")
+            if tables:
+                tables.first(DataTable).focus()
+        self.update_details()
+
+    @on(DataTable.RowSelected)
+    def on_row_selected(self, event: DataTable.RowSelected) -> None:
+        """Show the selected summary task in the tasks timeline."""
+        if event.row_key.value is not None:
+            self.goto_task(int(event.row_key.value), None)
+
+    def goto_task(self, tid: int, time: Optional[float]) -> None:
+        """Select the task in the tasks or I/O view, optionally moving the=
 cursor."""
+        for tab_id, view_id, row_type in (("tasks", "#tasks_view", TaskRow=
),
+                                          ("io", "#io_view", IoRow)):
+            views =3D self.query(view_id)
+            if not views:
+                continue
+            view =3D views.first(TimelineView)
+            for idx, row in enumerate(view.rows):
+                if isinstance(row, row_type) and row.task.tid =3D=3D tid:
+                    self.query_one(TabbedContent).active =3D tab_id
+                    if time is not None:
+                        self.window =3D self.window.with_cursor(time)
+                    view.selected =3D idx
+                    view.focus()
+                    return
+        self.notify(f"Task {tid} isn't shown in the tasks view", severity=
=3D"warning")
+
+    def action_sort(self) -> None:
+        """Cycle the sort order of the tasks view."""
+        self.sort_order =3D (self.sort_order + 1) % len(self.SORT_ORDERS)
+
+    def watch_sort_order(self) -> None:
+        """Re-sort the tasks view."""
+        views =3D self.query("#tasks_view")
+        if not views:
+            return
+        with self.data.lock:
+            rows =3D self.task_rows()
+        views.first(TimelineView).set_rows(rows)
+        self.notify(f"Tasks sorted by {self.SORT_ORDERS[self.sort_order]}"=
)
+        self.update_details()
+
+    def action_goto_waker(self) -> None:
+        """Select the task that woke the selected task before the cursor."=
""
+        view =3D self.active_view()
+        row =3D view.selected_row() if view else None
+        if not isinstance(row, (TaskRow, IoRow)):
+            return
+        with self.data.lock:
+            wakeups =3D row.task.wakeups
+            idx =3D bisect.bisect_right(wakeups, (self.window.cursor, sys.=
maxsize)) - 1
+            wake_time, waker =3D wakeups[idx] if idx >=3D 0 else (0, 0)
+        if idx < 0:
+            self.notify("No wakeup before the cursor", severity=3D"warning=
")
+            return
+        if waker <=3D 0:
+            self.notify(f"Woken by {self.data.task_name(waker)} at "
+                        f"{self.data.fmt_time(wake_time)}")
+            return
+        self.goto_task(waker, wake_time)
+
+
+def main() -> None:
+    """Parse arguments, read the perf.data file and run the app."""
+    parser =3D argparse.ArgumentParser(
+        description=3D"Interactive timechart of CPU, task and I/O activity=
.")
+    parser.add_argument("-i", "--input", default=3D"perf.data", help=3D"in=
put perf.data file")
+    parser.add_argument("-P", "--power-only", action=3D"store_true",
+                        help=3D"only show CPU power information")
+    parser.add_argument("-T", "--tasks-only", action=3D"store_true",
+                        help=3D"only show task information")
+    parser.add_argument("-p", "--process", action=3D"append", default=3D[]=
,
+                        help=3D"only show processes with the given name or=
 PID, may be repeated")
+    parser.add_argument("--dump", action=3D"store_true",
+                        help=3D"print a text summary rather than running t=
he interactive UI")
+    args =3D parser.parse_args()
+
+    if args.power_only and args.tasks_only:
+        print("Error: -P and -T options cannot be used at the same time.",=
 file=3Dsys.stderr)
+        sys.exit(1)
+
+    if args.input =3D=3D "-":
+        if not args.dump:
+            # The interactive UI reads the keyboard from stdin.
+            print("Error: reading perf.data from stdin requires --dump.", =
file=3Dsys.stderr)
+            sys.exit(1)
+    elif not os.path.exists(args.input):
+        print(f"Error: {args.input} not found. (try 'perf timechart record=
' first)",
+              file=3Dsys.stderr)
+        sys.exit(1)
+
+    if args.dump:
+        data =3D load_data(args.input)
+        data.dump(args.power_only, args.tasks_only, args.process)
+        return
+
+    # The app starts immediately and loads the data in the background.
+    app =3D TimechartApp(args.input, args.power_only, args.tasks_only, arg=
s.process)
+    app.run()
+    sys.exit(app.return_code or 0)
+
+
+def read_events(data: TimechartData, input_name: str) -> None:
+    """Process the events in input_name into data, raising on errors."""
+    if data.cancelled:
+        raise LoadCancelled()
+    try:
+        data.session =3D perf.session(perf.data(input_name), sample=3Ddata=
.process_event)
+        data.session.process_events()
+        data.finish()
+    finally:
+        # Break the reference cycle between the session and the callback.
+        data.session =3D None
+
+
+def load_data(input_name: str) -> TimechartData:
+    """Read the perf.data file exiting on errors or if there's nothing to =
show."""
+    if input_name !=3D "-" and not os.path.exists(input_name):
+        print(f"Error: {input_name} not found. (try 'perf timechart record=
' first)",
+              file=3Dsys.stderr)
+        sys.exit(1)
+
+    data =3D TimechartData()
+    try:
+        read_events(data, input_name)
+    except (OSError, ValueError, RuntimeError) as e:
+        print(f"Error processing {input_name}: {e}", file=3Dsys.stderr)
+        sys.exit(1)
+    except KeyboardInterrupt:
+        data.finish()
+
+    if not data.has_events():
+        print(f"Error: no scheduler, power or I/O events found in {input_n=
ame}.\n"
+              "Record them with 'perf timechart record'.", file=3Dsys.stde=
rr)
+        sys.exit(1)
+    return data
+
+
+if __name__ =3D=3D "__main__":
+    main()
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

