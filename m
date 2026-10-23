Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731736;
	b=R3f55RJtXLtLOqEgEl7baUS0IKmnmH6d4GIMSALhqUHvO7FKGLI72BAItyMJWm3rtubI
	 Q0RfCR06zde5xMnAtimsBl5uPGFyFsLRXFa2Z+brmKj34OJ3rCUKzeC+NZMTI/+SVynZU
	 ZOsG/BWZhgQ2B6bDsJKW9Vc1PbywcouCsNeXimi6YDh8HaPSCmZ0PW1WmROk0DWMrfyXD
	 PU9//PDyJN7bUZM958P/Lwhep8Gb3kAeSZNNjWTbdEQgpRLmC9/dybFQPfC1IpMBQS2N9
	 Y+V4tO4B2h1JaXEQh/E9jyVTauN4yP7EisU6TXluuZ9Ub4yyZNyqyagCj/LVxxOdang==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=zMLXkCbJqgf5UI8MMENb8mJ8ibJK+EZw9B9zaAJmabc=;
	b=rV/e/knlAVSflJeA4DzQSVoydB3MrSgkh/vcWvuG7Xk1mFq/zB4cw6OfDrny6UuOLdKK
	 nGzu6wY9U3SXokYJu3mhF13F5Cu77k+i9kS1WVFVbryFf4d4NXq/m7wWQgoWCQee1pJ96
	 tclXilocmqyEYKn2xRg9KNKXa4aVimoS2exWmV6AtLh88F/XPGF3UFgxq4b+Ia2SdZpfx
	 cMo2po9eSp1j/3QI+QrUeV4CD5RHIqlGv+WRHCnxtVpQ9W2uwGXIzRF16B12vwJoGaBAW
	 7zEmZsCJmnSikKLR4ntGESPmY3qziZ6m9dy8Y9YsCmdfCj+YaOgYEBJqT6zdOe38Q7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WcWx1MlR;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8CA606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 05:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A8CA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WcWx1MlR
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so1254935eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 22:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792731733; x=1793336533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zMLXkCbJqgf5UI8MMENb8mJ8ibJK+EZw9B9zaAJmabc=;
        b=WcWx1MlRaI9vKlqwz6Psdsz1pxfXOTKIjeshBGT401V94DD0W22uqyX865kHAzuxyN
         nNlHvFe21eY01bF6BQUpFlWMLMLpHvqAKdnMSiOSx3ivs4r4jbj0fcqbCEOZq8ZG+vKo
         mbXaNomPxxMd6f+iZ0XWnR9Kyn7AkrB8MsN33+3BJMFQWoyDTi1gFM6YmYE5Y3z9fkFy
         zUdeTD2/1Je5ksDbeGs0ilKZJmItSCKCDaeU+JX2TyA8+8Ke+Kq9uSoMDDgxUNyxyaqR
         Nao7GR3CCkLOVE33YbGofY8YUxXvGVeJhLSazRrLyoCSJxwOrtQhUbQt1t26phdr/kB6
         kTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792731733; x=1793336533;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zMLXkCbJqgf5UI8MMENb8mJ8ibJK+EZw9B9zaAJmabc=;
        b=IZLmIhXJBCFL/eG+FC8YrgREYSCxWfLvBJ6v3BCnQ2gZYQEvgBwDE4UbTLxS7zKynR
         mjw4NSDOUxPochGDucHqcJAwwpbIQohxMiAZ36b0w8xVHR1/8odT53GNaz5s4cw4ixUd
         E4lIegke45KqvQL6yOBp1XIUxwqorCpLgDu1dhOuarDltUzPfqkBzm+JPZl2j6E2/H5v
         Iqyw6AkHXA4hxxtVzl1R49HOaCTPwlpb9fstzSUzYG2/03fCGT56cyyhEaMxCPhryfe8
         /TQiwngC+VDWkJs+bGe61Il2vzbSn+swYAbrpk9cPy9mYZye0gOU9F/U+LdazZ04NSTO
         EONw==
X-Forwarded-Encrypted: i=1; AKwUvBz6wKjouy9Krqk3BeuctUgRaHoSjWYBg2DSsCr27aYTXpLzrlAAhOIZd1x0vsUK4emnaeGMIf2Z6Cx2Ko/WywS+@vger.kernel.org
X-Gm-Message-State: AFq9FYIhC3JrDRrUzGjlrsu7fiVJ3cMzNFbgVjIWNW9PLgnw5Bl2KZMs
	X90ecoq6OqQAWOFJvOCDuLviN7LipcuigXNxmtjpH3tsiKbuVWBCDnhreKtJKzt/Zb0f78oR1jo
	wHu5ywN2Geg==
X-Received: from dybbs35.prod.google.com ([2002:a05:7300:a223:b0:369:7ef0:57a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c3a4:b0:34e:e7f4:cc78
 with SMTP id 5a478bee46e88-369d954ad83mr1397959eec.5.1792731732608; Thu, 22
 Oct 2026 22:02:12 -0700 (PDT)
Date: Thu, 22 Oct 2026 22:02:05 -0700
In-Reply-To: <20261023050207.2449976-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023041819.2361900-1-irogers@google.com> <20261023050207.2449976-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023050207.2449976-2-irogers@google.com>
Subject: [PATCH v4 1/2] perf timechart: Add a --live mode to the TUI
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, atrajeev@linux.ibm.com, changbin.du@huawei.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tanze@kylinos.cn, 
	thomas.falcon@intel.com, wutengda@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Alice Rogers <alice.mei.rogers@gmail.com>

Add a --live option to perf timechart and ttimechart.py that runs 'perf
record' writing CLOCK_MONOTONIC scheduler and power events, or I/O
syscall events when -I/--io-only is given, to a pipe and displays them
in the TUI as they happen. Only the most recent --window seconds of
history (default 10) are kept in memory, pruning older segments and
tasks that have no remaining history in the window.

Pressing space pauses and resumes recording using perf record's
--control pipe. Because perf record only reads its ring buffers when a
watermark is reached, periodic 'ping' commands are sent on the control
pipe to flush events promptly. The refresh interval adapts to the
measured screen refresh cost and backs off if unprocessed data builds up
in the pipe, with two flushes per refresh to account for ordered-event
buffering across rounds.

An optional workload may be given after '--' to record just that command
rather than the whole system, and '-o' optionally saves a copy of the
recorded perf.data stream.

Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
Co-developed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-timechart.txt |  20 +-
 tools/perf/builtin-timechart.c              |  81 +-
 tools/perf/python/ttimechart.py             | 883 ++++++++++++++++++--
 3 files changed, 909 insertions(+), 75 deletions(-)

diff --git a/tools/perf/Documentation/perf-timechart.txt b/tools/perf/Docum=
entation/perf-timechart.txt
index f768ee8acf47..8b5c65770479 100644
--- a/tools/perf/Documentation/perf-timechart.txt
+++ b/tools/perf/Documentation/perf-timechart.txt
@@ -47,6 +47,9 @@ TIMECHART OPTIONS
 -T::
 --tasks-only::
         Don't output processor state transitions
+-I::
+--io-only::
+        In '--live' or '--tui' mode, only record or show I/O activity
 -p::
 --process::
         Select the processes to display, by name or PID
@@ -59,8 +62,21 @@ TIMECHART OPTIONS
 	linkperf:perf-script[1]). The script requires the perf python module
 	and the python 'textual' library. The CPU, task, I/O and summary views
 	can be zoomed ('+'/'-'), panned (shift+arrows) and the state of the
-	selected row at the cursor is described. The -i, -P, -T and -p options
-	are passed to the script, other output options are ignored.
+	selected row at the cursor is described. The -i, -P, -T, -I and -p
+	options are passed to the script, other output options are ignored.
+--live::
+	Record scheduler and power events, or I/O events with '-I', with
+	linkperf:perf-record[1] and display them as they happen in the
+	terminal timechart, implying --tui. Only the most recent '--window'
+	seconds of events are kept and shown. Pressing space pauses and
+	resumes recording; zooming or panning stops the view following the
+	latest events until '0' is pressed. If a command is given after '--'
+	then only that workload is recorded and recording stops when it exits,
+	otherwise the whole system is recorded until the UI is quit. If '-o'
+	is given the recorded perf data is also saved to that file.
+--window=3D<seconds>::
+	In '--live' mode, the number of seconds of recent events kept in
+	memory and shown in the timeline (default: 10).
 --symfs=3D<directory[,layout]>::
         Look for files with symbols relative to this directory. The option=
al
         layout can be 'hierarchy' (default, matches full path) or 'flat'
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.=
c
index 9eb335d9db16..8a61ea8621cc 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -10,7 +10,10 @@
=20
 #include <errno.h>
 #include <inttypes.h>
+#include <limits.h>
 #include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
=20
 #include "builtin.h"
 #include "util/color.h"
@@ -70,6 +73,9 @@ struct timechart {
 				topology;
 	bool			force;
 	bool			use_tui;
+	/* Live --tui mode settings */
+	bool			live;
+	const char		*live_window;
 	/* IO related settings */
 	bool			io_only,
 				skip_eagain;
@@ -1761,16 +1767,25 @@ static int __cmd_timechart(struct timechart *tchart=
, const char *output_name)
 /*
  * Launch the interactive textual based python script via 'perf script' th=
at
  * finds the script, sets up the python environment and passes the global
- * input_name (set by -i) to the script as '-i <input_name>'.
+ * input_name (set by -i) to the script as '-i <input_name>'. In live mode=
 the
+ * script runs 'perf record', so pass this perf's path, the optional data =
output
+ * file and the workload given in argc/argv.
  */
-static int timechart__tui(struct timechart *tchart)
+static int timechart__tui(struct timechart *tchart, const char *live_outpu=
t,
+			  int argc, const char **argv)
 {
 	struct process_filter *filt;
 	const char **script_argv;
-	int script_argc =3D 0, nr_args =3D 5, ret;
+	int script_argc =3D 0, nr_args =3D 6, ret, i;
+	char perf_exe[PATH_MAX];
+	ssize_t len;
=20
 	for (filt =3D process_filter; filt; filt =3D filt->next)
 		nr_args +=3D 2;
+	if (tchart->live_window)
+		nr_args +=3D 2;
+	if (tchart->live)
+		nr_args +=3D 6 + argc;
=20
 	script_argv =3D calloc(nr_args + 1, sizeof(*script_argv));
 	if (!script_argv)
@@ -1783,10 +1798,34 @@ static int timechart__tui(struct timechart *tchart)
 		script_argv[script_argc++] =3D "-P";
 	if (tchart->tasks_only)
 		script_argv[script_argc++] =3D "-T";
+	if (tchart->io_only)
+		script_argv[script_argc++] =3D "-I";
 	for (filt =3D process_filter; filt; filt =3D filt->next) {
 		script_argv[script_argc++] =3D "-p";
 		script_argv[script_argc++] =3D filt->name;
 	}
+	if (tchart->live_window) {
+		script_argv[script_argc++] =3D "--window";
+		script_argv[script_argc++] =3D tchart->live_window;
+	}
+	if (tchart->live) {
+		script_argv[script_argc++] =3D "--live";
+		if (live_output) {
+			script_argv[script_argc++] =3D "-o";
+			script_argv[script_argc++] =3D live_output;
+		}
+		len =3D readlink("/proc/self/exe", perf_exe, sizeof(perf_exe) - 1);
+		if (len > 0) {
+			perf_exe[len] =3D '\0';
+			script_argv[script_argc++] =3D "--perf";
+			script_argv[script_argc++] =3D perf_exe;
+		}
+		if (argc) {
+			script_argv[script_argc++] =3D "--";
+			for (i =3D 0; i < argc; i++)
+				script_argv[script_argc++] =3D argv[i];
+		}
+	}
=20
 	ret =3D cmd_script(script_argc, script_argv);
 	free(script_argv);
@@ -2084,11 +2123,13 @@ int cmd_timechart(int argc, const char **argv)
 		.min_time =3D NSEC_PER_MSEC,
 		.merge_dist =3D 1000,
 	};
-	const char *output_name =3D "output.svg";
+	const char *default_output_name =3D "output.svg";
+	const char *output_name =3D default_output_name;
 	const char *output_record_data =3D "perf.data";
 	const struct option timechart_common_options[] =3D {
 	OPT_BOOLEAN('P', "power-only", &tchart.power_only, "output power data onl=
y"),
 	OPT_BOOLEAN('T', "tasks-only", &tchart.tasks_only, "output processes data=
 only"),
+	OPT_BOOLEAN('I', "io-only", &tchart.io_only, "record only IO data"),
 	OPT_END()
 	};
 	const struct option timechart_options[] =3D {
@@ -2118,6 +2159,10 @@ int cmd_timechart(int argc, const char **argv)
 	OPT_BOOLEAN('f', "force", &tchart.force, "don't complain, do it"),
 	OPT_BOOLEAN(0, "tui", &tchart.use_tui,
 		    "interactive terminal timechart using the ttimechart python script")=
,
+	OPT_BOOLEAN(0, "live", &tchart.live,
+		    "record and show events as they happen, implies --tui"),
+	OPT_STRING(0, "window", &tchart.live_window, "seconds",
+		   "seconds of recent events kept and shown in live mode, default 10"),
 	OPT_PARENT(timechart_common_options),
 	};
 	const char * const timechart_subcommands[] =3D { "record", NULL };
@@ -2126,8 +2171,6 @@ int cmd_timechart(int argc, const char **argv)
 		NULL
 	};
 	const struct option timechart_record_options[] =3D {
-	OPT_BOOLEAN('I', "io-only", &tchart.io_only,
-		    "record only IO data"),
 	OPT_BOOLEAN('g', "callchain", &tchart.with_backtrace, "record callchain")=
,
 	OPT_STRING('o', "output", &output_record_data, "file", "output data file =
name"),
 	OPT_PARENT(timechart_common_options),
@@ -2165,8 +2208,13 @@ int cmd_timechart(int argc, const char **argv)
 		ret =3D -1;
 		goto out;
 	}
+	if (tchart.io_only && (tchart.power_only || tchart.tasks_only)) {
+		pr_err("-I cannot be used with -P or -T.\n");
+		ret =3D -1;
+		goto out;
+	}
=20
-	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
+	if (!tchart.live && argc && strlen(argv[0]) > 2 && strstarts("record", ar=
gv[0])) {
 		argc =3D parse_options(argc, argv, timechart_record_options,
 				     timechart_record_usage,
 				     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -2176,17 +2224,30 @@ int cmd_timechart(int argc, const char **argv)
 			ret =3D -1;
 			goto out;
 		}
+		if (tchart.io_only && (tchart.power_only || tchart.tasks_only)) {
+			pr_err("-I cannot be used with -P or -T.\n");
+			ret =3D -1;
+			goto out;
+		}
=20
 		if (tchart.io_only)
 			ret =3D timechart__io_record(argc, argv, output_record_data);
 		else
 			ret =3D timechart__record(&tchart, argc, argv, output_record_data);
 		goto out;
-	} else if (argc)
+	} else if (argc && !tchart.live)
 		usage_with_options(timechart_usage, timechart_options);
=20
-	if (tchart.use_tui) {
-		ret =3D timechart__tui(&tchart);
+	if (tchart.use_tui || tchart.live) {
+		/* In live mode -o names the file to save the recorded data to. */
+		ret =3D timechart__tui(&tchart,
+				     output_name !=3D default_output_name ? output_name : NULL,
+				     argc, argv);
+		goto out;
+	}
+	if (tchart.live_window) {
+		pr_err("--window requires --live.\n");
+		ret =3D -1;
 		goto out;
 	}
=20
diff --git a/tools/perf/python/ttimechart.py b/tools/perf/python/ttimechart=
.py
index 34ecf84e68c1..168f64c6b0fe 100755
--- a/tools/perf/python/ttimechart.py
+++ b/tools/perf/python/ttimechart.py
@@ -2,32 +2,44 @@
 # SPDX-License-Identifier: GPL-2.0
 """ttimechart.py - interactive perf timechart written using textual.
=20
-Reads a perf.data file, typically created with 'perf timechart record', an=
d
-displays per-CPU and per-task timelines in the terminal. Scheduler
-(sched:sched_switch, sched:sched_wakeup), power (power:cpu_idle,
-power:cpu_frequency) and I/O syscall (perf timechart record -I) tracepoint=
s
-are understood. Unlike 'perf timechart', which writes an SVG file, the
-timeline can be zoomed, panned and queried interactively.
+Reads a perf.data file, typically created with 'perf timechart record', or
+records events in live mode, and displays per-CPU and per-task timelines i=
n
+the terminal. Scheduler (sched:sched_switch, sched:sched_wakeup), power
+(power:cpu_idle, power:cpu_frequency) and I/O syscall (perf timechart reco=
rd
+-I) tracepoints are understood. Unlike 'perf timechart', which writes an S=
VG
+file, the timeline can be zoomed, panned and queried interactively.
=20
 Usage:
-    perf timechart record -- <workload>
+    perf timechart record [-I] -- <workload>
     perf timechart --tui
+    perf timechart --live [-I] [--window <seconds>] [-- <workload>]
 or:
     perf script ttimechart [-i perf.data]
+    perf script ttimechart -- --live [-I] [--window <seconds>] [-- <worklo=
ad>]
 """
 from __future__ import annotations
=20
 from abc import ABC, abstractmethod
 import argparse
+import array
 import bisect
 from collections import defaultdict
 from dataclasses import dataclass, replace
+import fcntl
 import math
 import os
+import queue
+import select
+import shutil
+import signal
+import subprocess
 import sys
+import tempfile
+import termios
 import threading
-from time import monotonic
-from typing import Any, Callable, Dict, List, Mapping, Optional, Sequence,=
 Tuple
+from time import monotonic, monotonic_ns
+from typing import (Any, Callable, Dict, List, Mapping, NoReturn, Optional=
, Sequence, Set, Tuple,
+                    Union)
=20
 import perf
 from rich.segment import Segment
@@ -93,6 +105,23 @@ LABEL_WIDTH =3D 28
 BARS =3D " =E2=96=81=E2=96=82=E2=96=83=E2=96=84=E2=96=85=E2=96=86=E2=96=87=
=E2=96=88"
 NSEC_PER_SEC =3D 1_000_000_000
=20
+# Default seconds of history kept and shown in live mode.
+LIVE_WINDOW =3D 10.0
+# Bounds on the seconds between refreshes of the live display. Within them
+# the time is adapted to the measured cost of a refresh, which reflects th=
e
+# machine's speed and load, so that refreshing takes about
+# LIVE_REFRESH_FRACTION of the time and the rest is left for processing ev=
ents.
+LIVE_MIN_REFRESH =3D 0.1
+LIVE_MAX_REFRESH =3D 2.0
+LIVE_REFRESH_FRACTION =3D 0.2
+# If processing events falls behind, refreshes are slowed by up to this fa=
ctor.
+LIVE_MAX_BACKOFF =3D 8.0
+# Bounds on the seconds between asking perf record to read its buffers.
+LIVE_MIN_FLUSH =3D 0.05
+LIVE_MAX_FLUSH =3D 1.0
+# Size requested for the pipe of recorded data, to absorb bursts of events=
.
+LIVE_PIPE_SIZE =3D 1 << 20
+
=20
 def fmt_duration(nsecs: float) -> str:
     """Format a duration in nanoseconds with an appropriate unit."""
@@ -142,10 +171,18 @@ class SegmentList:
         return len(self.starts)
=20
     def add(self, start: int, end: int, key: int, data: Any =3D None) -> N=
one:
-        """Append a segment, segments must be added in time order."""
+        """Append a segment, segments must be added in time order.
+
+        A segment continuing the last one with the same key and data exten=
ds
+        it, such as when live mode closes a still open state, see
+        TimechartData.checkpoint().
+        """
         if end <=3D start:
             return
-        if self.ends and start < self.ends[-1]:
+        if self.ends and start <=3D self.ends[-1]:
+            if start =3D=3D self.ends[-1] and key =3D=3D self.keys[-1] and=
 data =3D=3D self.data[-1]:
+                self.ends[-1] =3D end
+                return
             # Clip overlaps caused by inconsistent data.
             start =3D self.ends[-1]
             if end <=3D start:
@@ -162,6 +199,21 @@ class SegmentList:
             return i
         return -1
=20
+    def num_ending_by(self, time: float) -> int:
+        """Number of segments ending at or before time, which are the firs=
t ones."""
+        return bisect.bisect_right(self.ends, time)
+
+    def prune(self, time: int) -> None:
+        """Remove segments ending at or before time and clip any straddlin=
g time."""
+        num =3D self.num_ending_by(time)
+        if num:
+            del self.starts[:num]
+            del self.ends[:num]
+            del self.keys[:num]
+            del self.data[:num]
+        if self.starts and self.starts[0] < time:
+            self.starts[0] =3D time
+
     def last_before(self, time: float) -> int:
         """Index of the last segment starting at or before time or -1."""
         return bisect.bisect_right(self.starts, time) - 1
@@ -265,6 +317,42 @@ class Task:
             return True
         return any(f =3D=3D str(self.tid) or f in self.comms for f in filt=
ers)
=20
+    def prune(self, time: int) -> None:
+        """Discard history ending at or before time, removing it from the =
totals."""
+        segs =3D self.segs
+        num =3D segs.num_ending_by(time)
+        # A still running task's last segment, extended by checkpoint(), e=
nds
+        # at since. It hasn't been switched out yet.
+        open_edge =3D len(segs) - 1 if self.state =3D=3D STATE_RUNNING and=
 segs and \
+            segs.ends[-1] =3D=3D self.since else -1
+        for i in range(num):
+            state =3D segs.keys[i]
+            self.totals[state] -=3D segs.ends[i] - segs.starts[i]
+            if state =3D=3D STATE_RUNNING and i !=3D open_edge:
+                # Running segments end when the task is switched out.
+                self.switches =3D max(self.switches - 1, 0)
+        if num < len(segs.starts) and segs.starts[num] < time:
+            self.totals[segs.keys[num]] -=3D time - segs.starts[num]
+        segs.prune(time)
+        io =3D self.io
+        for i in range(io.num_ending_by(time)):
+            ret =3D io.data[i][1]
+            if ret > 0 and io.keys[i] in (IOTYPE_READ, IOTYPE_WRITE, IOTYP=
E_TX, IOTYPE_RX):
+                self.io_bytes -=3D ret
+        io.prune(time)
+        if self.io_pending and self.io_pending[0] < time:
+            self.io_pending =3D (time, self.io_pending[1], self.io_pending=
[2])
+        del self.wakeups[:bisect.bisect_right(self.wakeups, (time, sys.max=
size))]
+        if self.since <=3D time:
+            self.since =3D time
+            if not segs and self.state !=3D STATE_RUNNING:
+                self.state =3D STATE_UNKNOWN
+
+    def is_empty(self) -> bool:
+        """Is there no history or pending state, so the task can be forgot=
ten?"""
+        return (not self.segs and not self.io and not self.wakeups and
+                self.io_pending is None and self.state in (STATE_SLEEPING,=
 STATE_UNKNOWN))
+
=20
 class Cpu:
     """Activity on a single CPU."""
@@ -281,6 +369,17 @@ class Cpu:
         self.pstate =3D SegmentList()
         self.pstate_cur: Optional[Tuple[int, int]] =3D None
=20
+    def prune(self, time: int) -> None:
+        """Discard history ending at or before time."""
+        self.run.prune(time)
+        self.cstate.prune(time)
+        self.pstate.prune(time)
+        self.since =3D max(self.since, time)
+        if self.cstate_cur and self.cstate_cur[0] < time:
+            self.cstate_cur =3D (time, self.cstate_cur[1])
+        if self.pstate_cur and self.pstate_cur[0] < time:
+            self.pstate_cur =3D (time, self.pstate_cur[1])
+
=20
 class LoadCancelled(Exception):
     """Raised from the sample callback to stop processing events early."""
@@ -326,21 +425,83 @@ class TimechartData:
         self.progress: Optional[Callable[[], None]] =3D None
         self.start_progress =3D monotonic()
         self.last_progress =3D self.start_progress
+        # History before this time has been discarded, see prune().
+        self.pruned_to =3D 0
+        # Recording was paused until this time, see mark_gap().
+        self.resumed_at =3D 0
+        # Recording is resumed at this time, the states are closed when th=
e
+        # first event after it is processed, see mark_gap().
+        self.gap_at =3D 0
+        # Process and thread IDs whose I/O events should be ignored.
+        self.ignore_pids: Set[int] =3D set()
=20
     def has_events(self) -> bool:
         """Were any events that can be displayed processed?"""
         return bool(self.sched_events or self.power_events or self.io_even=
ts)
=20
+    def start_time(self) -> int:
+        """Start of the history that is kept."""
+        return max(self.first_time, self.pruned_to)
+
+    def state_start(self) -> int:
+        """Start of the recorded history in which a state was first seen."=
""
+        return max(self.start_time(), self.resumed_at)
+
+    def mark_gap(self, time: int) -> None:
+        """Note that recording, paused for a while, resumes at time, the l=
ock must be held.
+
+        Events weren't recorded while paused, so the states at the pause a=
ren't
+        known to have continued. They are closed before the first event af=
ter
+        time is processed, the events are processed in time order.
+        """
+        self.gap_at =3D time
+
+    def _close_gap(self) -> None:
+        """Close open states at the last event before the gap, see mark_ga=
p()."""
+        end =3D self.last_time
+        for task in self.tasks.values():
+            task.change_state(end, STATE_UNKNOWN)
+            task.io_pending =3D None
+        for c in self.cpus.values():
+            if c.cur_tid > 0:
+                c.run.add(c.since, end, 1, c.cur_tid)
+            c.cur_tid =3D -1
+            if c.cstate_cur:
+                c.cstate.add(c.cstate_cur[0], end, 1, c.cstate_cur[1])
+                c.cstate_cur =3D None
+            if c.pstate_cur:
+                c.pstate.add(c.pstate_cur[0], end, 1, c.pstate_cur[1])
+                c.pstate_cur =3D None
+        self.resumed_at =3D self.gap_at
+        self.gap_at =3D 0
+
+    def prune(self, time: int) -> None:
+        """Discard history ending at or before time, the lock must be held=
.
+
+        Live mode uses this to bound the memory used to the displayed wind=
ow.
+        Tasks left without history are forgotten, if they run again they a=
re
+        recreated.
+        """
+        if time <=3D self.pruned_to:
+            return
+        self.pruned_to =3D time
+        for c in self.cpus.values():
+            c.prune(time)
+        for tid, task in list(self.tasks.items()):
+            task.prune(time)
+            if task.is_empty():
+                del self.tasks[tid]
+
     def task(self, tid: int, comm: Optional[str] =3D None) -> Task:
         """Find or create a task."""
         task =3D self.tasks.get(tid)
+        if not comm and self.session and (task is None or task.comm =3D=3D=
 f"[{tid}]"):
+            try:
+                thread =3D self.session.find_thread(tid, tid)
+                comm =3D thread.comm() if thread else None
+            except (OSError, ValueError, KeyError, RuntimeError, TypeError=
, AttributeError):
+                comm =3D None
         if task is None:
-            if not comm and self.session:
-                try:
-                    thread =3D self.session.find_thread(tid, tid)
-                    comm =3D thread.comm() if thread else None
-                except (OSError, ValueError, KeyError, RuntimeError, TypeE=
rror, AttributeError):
-                    comm =3D None
             task =3D Task(tid, comm or f"[{tid}]")
             self.tasks[tid] =3D task
         else:
@@ -363,9 +524,14 @@ class TimechartData:
         if c.cur_tid =3D=3D -1 and prev_tid !=3D 0:
             # Assume the task was running from the start of the trace.
             c.cur_tid =3D prev_tid
-            c.since =3D self.first_time
+            c.since =3D self.state_start()
         if c.cur_tid > 0:
             c.run.add(c.since, time, 1, c.cur_tid)
+            if c.cur_tid !=3D prev_tid:
+                # The switch away from the task that was running was lost.
+                old =3D self.tasks.get(c.cur_tid)
+                if old and old.state =3D=3D STATE_RUNNING and old.cpu =3D=
=3D cpu:
+                    old.change_state(time, STATE_UNKNOWN)
         c.cur_tid =3D next_tid
         c.since =3D time
=20
@@ -373,7 +539,7 @@ class TimechartData:
             prev =3D self.task(prev_tid, prev_comm)
             if prev.state =3D=3D STATE_UNKNOWN:
                 prev.state =3D STATE_RUNNING
-                prev.since =3D self.first_time
+                prev.since =3D self.state_start()
                 prev.cpu =3D cpu
             # Ignore bits like TASK_REPORT_MAX used to report preemption.
             state =3D prev_state & 0xff
@@ -429,13 +595,17 @@ class TimechartData:
         self.max_freq =3D max(self.max_freq, freq)
         self.min_freq =3D freq if not self.min_freq else min(self.min_freq=
, freq)
=20
-    def io_enter(self, time: int, tid: int, iotype: int, fd: int) -> None:
+    def io_enter(self, time: int, tid: int, iotype: int, fd: int, pid: int=
 =3D 0) -> None:
         """Entry to an I/O syscall."""
+        if tid in self.ignore_pids or (pid and pid in self.ignore_pids):
+            return
         self.io_events +=3D 1
         self.task(tid).io_pending =3D (time, iotype, fd)
=20
-    def io_exit(self, time: int, tid: int, iotype: int, ret: int) -> None:
+    def io_exit(self, time: int, tid: int, iotype: int, ret: int, pid: int=
 =3D 0) -> None:
         """Exit from an I/O syscall."""
+        if tid in self.ignore_pids or (pid and pid in self.ignore_pids):
+            return
         self.io_events +=3D 1
         task =3D self.task(tid)
         pending =3D task.io_pending
@@ -497,11 +667,13 @@ class TimechartData:
         if name.startswith("syscalls:sys_enter_") and name[19:] in IO_SYSC=
ALLS:
             iotype =3D IO_SYSCALLS[name[19:]]
             return lambda time, sample: self.io_enter(time, sample.sample_=
tid, iotype,
-                                                      getattr(sample, "fd"=
, -1))
+                                                      getattr(sample, "fd"=
, -1),
+                                                      getattr(sample, "sam=
ple_pid", 0))
         if name.startswith("syscalls:sys_exit_") and name[18:] in IO_SYSCA=
LLS:
             iotype =3D IO_SYSCALLS[name[18:]]
             return lambda time, sample: self.io_exit(time, sample.sample_t=
id, iotype,
-                                                     sample.ret)
+                                                     sample.ret,
+                                                     getattr(sample, "samp=
le_pid", 0))
         return None
=20
     def process_event(self, sample: perf.sample_event) -> None:
@@ -527,6 +699,8 @@ class TimechartData:
     def _process_event(self, sample: perf.sample_event) -> None:
         """Update the data from a sample, the lock must be held."""
         time =3D sample.sample_time
+        if self.gap_at and time >=3D self.gap_at:
+            self._close_gap()
         if not self.first_time or time < self.first_time:
             self.first_time =3D time
         self.last_time =3D max(self.last_time, time)
@@ -562,6 +736,32 @@ class TimechartData:
             except (OSError, ValueError, KeyError, RuntimeError, TypeError=
, AttributeError):
                 pass
=20
+    def checkpoint(self) -> None:
+        """Extend open running, idle and frequency states to last_time.
+
+        Live mode calls this before displaying and pruning so that states =
that
+        haven't changed recently are shown up to the latest event, rather =
than
+        only once they end. The lock must be held.
+        """
+        end =3D self.last_time
+        if not end:
+            return
+        for task in self.tasks.values():
+            if task.state =3D=3D STATE_RUNNING and end > task.since:
+                task.segs.add(task.since, end, STATE_RUNNING, task.cpu)
+                task.totals[STATE_RUNNING] +=3D end - task.since
+                task.since =3D end
+        for c in self.cpus.values():
+            if c.cur_tid > 0 and end > c.since:
+                c.run.add(c.since, end, 1, c.cur_tid)
+                c.since =3D end
+            if c.cstate_cur and end > c.cstate_cur[0]:
+                c.cstate.add(c.cstate_cur[0], end, 1, c.cstate_cur[1])
+                c.cstate_cur =3D (end, c.cstate_cur[1])
+            if c.pstate_cur and end > c.pstate_cur[0]:
+                c.pstate.add(c.pstate_cur[0], end, 1, c.pstate_cur[1])
+                c.pstate_cur =3D (end, c.pstate_cur[1])
+
     def finish(self) -> None:
         """Close open segments at the end of the trace."""
         with self.lock:
@@ -604,7 +804,8 @@ class TimechartData:
                        if len(t.io) and t.passes_filter(filters)),
                       key=3Dlambda t: -len(t.io))
=20
-    def dump(self, power_only: bool, tasks_only: bool, filters: Sequence[s=
tr]) -> None:
+    def dump(self, power_only: bool, tasks_only: bool, filters: Sequence[s=
tr],
+             io_only: bool =3D False) -> None:
         """Print a plain text summary, for use without a terminal UI."""
         duration =3D self.last_time - self.first_time
         span =3D max(duration, 1)
@@ -613,7 +814,7 @@ class TimechartData:
         print(f"Duration: {fmt_duration(duration)}, CPUs: {len(self.cpus)}=
, "
               f"tasks: {len(tasks) or len(io_tasks)}, sched events: {self.=
sched_events}, "
               f"power events: {self.power_events}, I/O events: {self.io_ev=
ents}")
-        if not tasks_only:
+        if not tasks_only and not io_only:
             for c in sorted(self.cpus.values(), key=3Dlambda c: c.cpu):
                 busy =3D sum(e - s for s, e in zip(c.run.starts, c.run.end=
s))
                 print(f"CPU {c.cpu}: busy {busy * 100 / span:.1f}%, "
@@ -621,14 +822,15 @@ class TimechartData:
                       f"{len(c.pstate)} frequency periods")
         if power_only:
             return
-        print(f"{'Task':<24} {'TID':>8} {'Running':>12} {'Waiting':>12} {'=
Blocked':>12} "
-              f"{'Switches':>9} {'Wakeups':>8}")
-        for task in sorted(tasks, key=3Dlambda t: -t.totals[STATE_RUNNING]=
):
-            print(f"{task.comm[:24]:<24} {task.tid:>8} "
-                  f"{fmt_duration(task.totals[STATE_RUNNING]):>12} "
-                  f"{fmt_duration(task.totals[STATE_WAITING]):>12} "
-                  f"{fmt_duration(task.totals[STATE_BLOCKED]):>12} "
-                  f"{task.switches:>9} {len(task.wakeups):>8}")
+        if not io_only:
+            print(f"{'Task':<24} {'TID':>8} {'Running':>12} {'Waiting':>12=
} {'Blocked':>12} "
+                  f"{'Switches':>9} {'Wakeups':>8}")
+            for task in sorted(tasks, key=3Dlambda t: -t.totals[STATE_RUNN=
ING]):
+                print(f"{task.comm[:24]:<24} {task.tid:>8} "
+                      f"{fmt_duration(task.totals[STATE_RUNNING]):>12} "
+                      f"{fmt_duration(task.totals[STATE_WAITING]):>12} "
+                      f"{fmt_duration(task.totals[STATE_BLOCKED]):>12} "
+                      f"{task.switches:>9} {len(task.wakeups):>8}")
         for task in io_tasks:
             print(f"I/O {task.name()}: {len(task.io)} syscalls, {task.io_b=
ytes} bytes")
=20
@@ -1128,7 +1330,7 @@ class TimelineView(ScrollView):
         """Change the window shared by all views, owned by the app."""
         app =3D self.app
         if isinstance(app, TimechartApp):
-            app.window =3D window
+            app.user_window(window)
=20
     def ruler(self, width: int) -> Strip:
         """The time axis, labeled in seconds relative to the trace start."=
""
@@ -1296,6 +1498,8 @@ class TimechartApp(App):
         Binding("s", "sort", "Sort tasks", tooltip=3D"Cycle task sort orde=
r"),
         Binding("w", "goto_waker", "Go to waker",
                 tooltip=3D"Select the task that last woke the selected tas=
k"),
+        Binding("space", "toggle_pause", "Pause/resume", key_display=3D"sp=
ace",
+                tooltip=3D"Pause or resume live recording"),
         Binding(key=3D"^q", action=3D"quit", description=3D"Quit", tooltip=
=3D"Quit the app"),
     ]
=20
@@ -1325,15 +1529,20 @@ class TimechartApp(App):
     sort_order: reactive[int] =3D reactive(0, init=3DFalse)
=20
     def __init__(self, input_name: str, power_only: bool, tasks_only: bool=
,
-                 filters: Sequence[str], data: Optional[TimechartData] =3D=
 None) -> None:
+                 filters: Sequence[str], data: Optional[TimechartData] =3D=
 None,
+                 live: Optional[LiveRecorder] =3D None, window: float =3D =
LIVE_WINDOW,
+                 io_only: bool =3D False) -> None:
         """Create the app, if data isn't given it is loaded from input_nam=
e.
=20
-        While the data is loading the views show what has been read so far=
.
+        While the data is loading the views show what has been read so far=
. In
+        live mode the data is read from the started recorder and only the =
last
+        window seconds of it are kept.
         """
         super().__init__()
         self.input_name =3D input_name
         self.power_only =3D power_only
         self.tasks_only =3D tasks_only
+        self.io_only =3D io_only
         self.filters =3D filters
         # The data being displayed, possibly still being loaded.
         self.data =3D data if data else TimechartData()
@@ -1349,6 +1558,29 @@ class TimechartApp(App):
         # Does the summary table need updating before it is next shown?
         self.summary_stale =3D True
         self.theme_colors =3D ThemeColors(self.theme_variables)
+        # Live mode state.
+        self.live =3D live
+        self.live_window =3D int(window * NSEC_PER_SEC)
+        # Is perf record still running?
+        self.recording =3D live is not None
+        # CLOCK_MONOTONIC time when paused, or 0.
+        self.paused_at =3D 0
+        # CLOCK_MONOTONIC time when recording finished, or 0.
+        self.finished_at =3D 0
+        # Does the view follow the latest events? Zooming or panning stops=
 it.
+        self.following =3D True
+        self.follow_cursor =3D True
+        # Seconds between refreshes, adapted to their cost, see tune_refre=
sh().
+        self.refresh_interval =3D LIVE_MIN_REFRESH
+        self.refresh_cost =3D 0.0
+        self.backoff =3D 1.0
+        self.refreshed_samples =3D -1
+        if live:
+            self.data.first_time =3D live.origin
+            self.data.ignore_pids.add(os.getpid())
+            proc =3D getattr(live, "proc", None)
+            if proc:
+                self.data.ignore_pids.add(proc.pid)
=20
     def cached_row(self, cls: Callable[[TimechartData, Any], Row], num: in=
t, obj: Any) -> Row:
         """Find or create the row of type cls for the CPU or task obj numb=
ered num."""
@@ -1388,17 +1620,18 @@ class TimechartApp(App):
         """Composes the user interface of the application."""
         yield Header()
         with TabbedContent():
-            if not self.tasks_only:
+            if not self.tasks_only and not self.io_only:
                 with TabPane("CPUs", id=3D"cpus"):
                     yield Static(id=3D"cpus_legend", classes=3D"legend")
                     yield TimelineView(self.data, [],
                                        id=3D"cpus_view").data_bind(Timecha=
rtApp.window)
             if not self.power_only:
-                with TabPane("Tasks", id=3D"tasks"):
-                    yield Static(id=3D"tasks_legend", classes=3D"legend")
-                    yield TimelineView(self.data, [],
-                                       id=3D"tasks_view").data_bind(Timech=
artApp.window)
-                # Hidden until there are tasks doing I/O.
+                if not self.io_only:
+                    with TabPane("Tasks", id=3D"tasks"):
+                        yield Static(id=3D"tasks_legend", classes=3D"legen=
d")
+                        yield TimelineView(self.data, [],
+                                           id=3D"tasks_view").data_bind(Ti=
mechartApp.window)
+                # Hidden until there are tasks doing I/O, unless in I/O-on=
ly mode.
                 with TabPane("I/O", id=3D"io"):
                     yield Static(id=3D"io_legend", classes=3D"legend")
                     yield TimelineView(self.data, [],
@@ -1418,6 +1651,11 @@ class TimechartApp(App):
             view.focus()
         if self.loaded:
             self.finish_loading()
+        elif self.live:
+            self.update_live_status()
+            self.loading =3D self.data
+            self.record_events()
+            self.set_timer(self.refresh_interval, self.live_refresh)
         else:
             self.sub_title =3D f"Loading {self.input_name}"
             self.loading =3D self.data
@@ -1486,6 +1724,204 @@ class TimechartApp(App):
             return
         self.call_from_thread(self.data_loaded)
=20
+    @work(thread=3DTrue, exclusive=3DTrue)
+    def record_events(self) -> None:
+        """Process events from perf record as they arrive, until it exits.
+
+        Unlike loading a file, the views are refreshed by live_refresh() o=
n a
+        timer, as events may arrive slowly.
+        """
+        data =3D self.loading or self.data
+        live =3D self.live
+        assert live
+        self.loading =3D data
+        error =3D None
+        try:
+            read_events(data, live.data_fd)
+        except LoadCancelled:
+            return
+        except (OSError, ValueError, RuntimeError) as e:
+            error =3D f"Error processing the recorded events: {e}"
+        finally:
+            self.loading =3D None
+            live.stop()
+        if data.cancelled:
+            return
+        if error or not data.has_events():
+            details =3D live.error_text()
+            if not data.has_events() and details:
+                msg =3D f"Error: perf record failed:\n{details}"
+            else:
+                msg =3D error or "Error: no scheduler, power or I/O events=
 were recorded."
+                if details:
+                    msg =3D f"{msg}\n{details}"
+            try:
+                self.call_from_thread(self.exit, None, 1, msg)
+            except RuntimeError:
+                pass
+            return
+        try:
+            self.call_from_thread(self.recording_finished)
+        except RuntimeError:
+            # The app is no longer running.
+            pass
+
+    def recording_finished(self) -> None:
+        """Called on the UI thread when perf record exits, such as when th=
e workload ends."""
+        # Keep showing the window at the end of recording, or when paused,
+        # which is after the history already discarded.
+        self.finished_at =3D self.paused_at or monotonic_ns()
+        self.data.finish()
+        self.recording =3D False
+        self.paused_at =3D 0
+        self.loaded =3D True
+        with self.data.lock:
+            # Discard history from events flushed when perf record exited.
+            self.live_prune()
+        self.refresh_bindings()
+        self.update_views()
+        self.update_live_status()
+
+    def live_bounds(self) -> Tuple[int, int]:
+        """The time range kept and shown in live mode, the last window of =
the recording.
+
+        Until a window of time has been recorded the range is the first wi=
ndow,
+        so the timeline fills from the left, after that it moves with time=
.
+        """
+        assert self.live
+        if self.paused_at:
+            now =3D self.paused_at
+        elif self.recording:
+            now =3D monotonic_ns()
+        else:
+            now =3D self.finished_at
+        last =3D max(now, self.live.origin + self.live_window)
+        return max(self.live.origin, last - self.live_window), last
+
+    def live_prune(self) -> None:
+        """Discard history before the live window, the data's lock must be=
 held.
+
+        Open states are only extended up to the last event, see checkpoint=
(),
+        so history after it isn't discarded. Otherwise, when events haven'=
t
+        been seen for a window, a still open state would lose its history.
+        """
+        self.data.prune(min(self.live_bounds()[0], self.data.last_time))
+        self.prune_rows()
+
+    def live_refresh(self) -> None:
+        """Show newly recorded events and discard those no longer in the w=
indow."""
+        start =3D monotonic()
+        with self.data.lock:
+            samples =3D self.data.nr_samples
+        # When paused, once the buffered events are shown there's nothing =
new.
+        if not self.paused_at or samples !=3D self.refreshed_samples:
+            self.refreshed_samples =3D samples
+            with self.data.lock:
+                self.data.checkpoint()
+                if self.recording and not self.paused_at:
+                    self.live_prune()
+            self.update_views()
+            self.update_live_status()
+        # Measure the cost of the refresh including drawing the screen.
+        self.call_after_refresh(self.live_refreshed, start)
+
+    def live_refreshed(self, start: float) -> None:
+        """Schedule the next refresh after the screen is drawn."""
+        if not self.recording:
+            return
+        self.tune_refresh(monotonic() - start)
+        self.set_timer(self.refresh_interval, self.live_refresh)
+
+    def tune_refresh(self, cost: float) -> None:
+        """Adapt the time between refreshes, and flushes, to the machine a=
nd its load.
+
+        The cost of a refresh grows with the number of events shown, the
+        speed of the machine and how loaded it is, including by processing
+        events in the other thread. The time between refreshes is chosen s=
o
+        that refreshing takes about LIVE_REFRESH_FRACTION of the time. If =
data
+        builds up in the pipe then processing events is falling behind, so
+        refreshes are slowed further to give it more time.
+        """
+        assert self.live
+        self.refresh_cost =3D cost if not self.refresh_cost else \
+            0.7 * self.refresh_cost + 0.3 * cost
+        if self.live.backlog() > 0.25:
+            self.backoff =3D min(self.backoff * 1.5, LIVE_MAX_BACKOFF)
+        else:
+            self.backoff =3D max(self.backoff / 1.25, 1.0)
+        interval =3D self.refresh_cost / LIVE_REFRESH_FRACTION * self.back=
off
+        self.refresh_interval =3D min(max(interval, LIVE_MIN_REFRESH), LIV=
E_MAX_REFRESH)
+        # Events are only processed once a later flush shows that the
+        # earlier ones have all been read, so flush twice per refresh.
+        self.live.flush_interval =3D min(max(self.refresh_interval / 2, LI=
VE_MIN_FLUSH),
+                                       LIVE_MAX_FLUSH)
+
+    def prune_rows(self) -> None:
+        """Forget the rows of tasks that the data forgot, the data's lock =
must be held."""
+        tasks =3D self.data.tasks
+        self.row_cache =3D {key: row for key, row in self.row_cache.items(=
)
+                          if not isinstance(row, (TaskRow, IoRow)) or
+                          tasks.get(row.task.tid) is row.task}
+
+    def update_live_status(self) -> None:
+        """Describe the state of live recording in the sub-title."""
+        if self.paused_at:
+            state =3D "=E2=9D=9A=E2=9D=9A Paused (space to resume)"
+        elif not self.recording:
+            state =3D "Finished"
+        elif self.following:
+            state =3D "=E2=97=8F Live"
+        else:
+            state =3D "=E2=97=8F Live (not following, press 0 to follow)"
+        data =3D self.data
+        nr_tasks =3D len(self.tasks) or len(self.io_tasks)
+        self.sub_title =3D (f"{state}: {data.nr_samples:,} events, {len(da=
ta.cpus)} CPUs, "
+                          f"{nr_tasks} tasks, refreshing every "
+                          f"{self.refresh_interval * 1000:.0f}ms")
+
+    def check_action(self, action: str, parameters: Tuple[object, ...]) ->=
 Optional[bool]:
+        """Only show pausing while live recording."""
+        if action =3D=3D "toggle_pause":
+            return self.recording
+        return True
+
+    def action_toggle_pause(self) -> None:
+        """Pause or resume live recording, resuming shows the latest event=
s again."""
+        if not self.live or not self.recording:
+            return
+        if self.paused_at:
+            self.paused_at =3D 0
+            self.following =3D True
+            self.follow_cursor =3D True
+            with self.data.lock:
+                # Events after this are recorded once perf record is enabl=
ed.
+                self.data.mark_gap(monotonic_ns())
+        else:
+            self.paused_at =3D monotonic_ns()
+        self.live.set_paused(bool(self.paused_at))
+        self.update_views()
+        self.update_live_status()
+
+    def user_window(self, window: TimeWindow) -> None:
+        """Change the window for the user.
+
+        In live mode, zooming or panning so that the whole window isn't sh=
own
+        stops the view following the latest events.
+        """
+        if self.live:
+            whole =3D window.start =3D=3D window.first and window.end =3D=
=3D window.last
+            if window.cursor !=3D self.window.cursor:
+                self.follow_cursor =3D False
+            elif whole and not self.following:
+                self.follow_cursor =3D True
+                if self.data.last_time:
+                    window =3D replace(window, cursor=3Dmin(max(self.data.=
last_time, window.first),
+                                                        window.last))
+            if self.following !=3D whole:
+                self.following =3D whole
+                self.update_live_status()
+        self.window =3D window
+
     def data_loaded(self) -> None:
         """Called on the UI thread when loading completes."""
         self.loaded =3D True
@@ -1512,10 +1948,15 @@ class TimechartApp(App):
                           f"{len(self.data.cpus)} CPUs, {nr_tasks} tasks")
=20
     def cancel_loading(self) -> None:
-        """Stop a background load, the worker notices at the next progress=
 interval."""
+        """Stop a background load, the worker notices at the next progress=
 interval.
+
+        In live mode stop perf record, the worker then sees the end of the=
 data.
+        """
         loading =3D self.loading
         if loading is not None:
             loading.cancelled =3D True
+        if self.live:
+            self.live.stop()
=20
     async def action_quit(self) -> None:
         """Quit, stopping any background load."""
@@ -1569,14 +2010,23 @@ class TimechartApp(App):
                 view.set_rows(rows)
         for static in self.query("#cpus_legend").results(Static):
             static.update(legend)
-        if self.query("#io") and bool(self.io_tasks) !=3D self.io_tab_show=
n:
-            self.io_tab_shown =3D bool(self.io_tasks)
+        show_io =3D bool(self.io_tasks) or self.io_only
+        if self.query("#io") and show_io !=3D self.io_tab_shown:
+            self.io_tab_shown =3D show_io
             tabbed =3D self.query_one(TabbedContent)
             if self.io_tab_shown:
                 tabbed.show_tab("io")
             else:
                 tabbed.hide_tab("io")
-        if first or last:
+        if self.live:
+            live_first, live_last =3D self.live_bounds()
+            win =3D self.window.extend(live_first, live_last)
+            if self.following:
+                win =3D win.reset()
+            if self.follow_cursor and last:
+                win =3D replace(win, cursor=3Dmin(max(last, live_first), l=
ive_last))
+            self.window =3D win
+        elif first or last:
             self.window =3D self.window.extend(first, last)
         self.summary_stale =3D True
         tabs =3D self.query(TabbedContent)
@@ -1651,7 +2101,8 @@ class TimechartApp(App):
             with self.data.lock:
                 text +=3D row.describe(win.cursor, win.start, win.end)
         elif view is None:
-            text +=3D "Select a task and press enter to show it in the Tas=
ks timeline"
+            tab =3D "I/O" if self.io_only or (not self.tasks and self.io_t=
asks) else "Tasks"
+            text +=3D f"Select a task and press enter to show it in the {t=
ab} timeline"
         details.first(Static).update(text)
=20
     @on(TabbedContent.TabActivated)
@@ -1727,52 +2178,358 @@ class TimechartApp(App):
         self.goto_task(waker, wake_time)
=20
=20
+class LiveRecorder:
+    """Runs 'perf record' writing events to a pipe for live display.
+
+    perf record is controlled through its --control file descriptors. It o=
nly
+    reads its ring buffers when a watermark is reached, so a periodic 'pin=
g'
+    makes it read them, bounding the delay before events are displayed.
+    'disable' and 'enable' pause and resume recording. Timestamps use
+    CLOCK_MONOTONIC so that they can be compared with the current time.
+    """
+    def __init__(self, perf_exe: str, power_only: bool, tasks_only: bool,
+                 workload: Sequence[str], output: Optional[str],
+                 io_only: bool =3D False) -> None:
+        self.perf_exe =3D perf_exe
+        self.power_only =3D power_only
+        self.tasks_only =3D tasks_only
+        self.io_only =3D io_only
+        self.workload =3D list(workload)
+        self.output =3D output
+        self.proc: Optional[subprocess.Popen] =3D None
+        # perf record's stderr, and the workload's output, to explain erro=
rs.
+        self.stderr =3D tempfile.TemporaryFile()
+        self.ctl_fd =3D -1
+        self.ack_fd =3D -1
+        # Read end of the pipe that the recorded data is processed from.
+        self.data_fd =3D -1
+        # Read end of the pipe from the tee thread when saving the data, o=
r -1.
+        self.tee_r =3D -1
+        # CLOCK_MONOTONIC time in nanoseconds when recording started.
+        self.origin =3D 0
+        # Seconds between flushes of perf record's buffers, tuned by the a=
pp.
+        self.flush_interval =3D LIVE_MIN_REFRESH / 2
+        self.paused =3D False
+        # Commands to send from the control thread, see control_loop().
+        self.commands: queue.Queue[str] =3D queue.Queue()
+        self.stopping =3D threading.Event()
+        self.fd_lock =3D threading.Lock()
+        self.control_thread: Optional[threading.Thread] =3D None
+        self.tee_thread: Optional[threading.Thread] =3D None
+
+    def close_control_fds(self) -> None:
+        """Close the control and acknowledgment pipe file descriptors."""
+        with self.fd_lock:
+            ctl_fd, self.ctl_fd =3D self.ctl_fd, -1
+            ack_fd, self.ack_fd =3D self.ack_fd, -1
+        for fd in (ctl_fd, ack_fd):
+            if fd >=3D 0:
+                try:
+                    os.close(fd)
+                except OSError:
+                    pass
+
+    def events(self) -> List[str]:
+        """Tracepoints to record, those that the kernel lacks are skipped.=
"""
+        if self.io_only:
+            names =3D [f"syscalls:sys_{direction}_{sc}"
+                     for sc in IO_SYSCALLS
+                     for direction in ("enter", "exit")]
+        else:
+            names =3D []
+            if not self.power_only:
+                names +=3D ["sched:sched_switch", "sched:sched_wakeup", "s=
ched:sched_wakeup_new"]
+            if not self.tasks_only:
+                names +=3D ["power:cpu_idle", "power:cpu_frequency"]
+        present =3D [n for n in names if perf.tracepoint(*n.split(":")) >=
=3D 0]
+        # If none are found tracefs may not be readable, let perf record
+        # report the problem.
+        return present or names
+
+    def start(self) -> None:
+        """Start perf record, the data is then read from data_fd."""
+        output =3D open(self.output, "wb") if self.output else None
+        # perf record's ends of the control pipes, closed once it is start=
ed.
+        child_fds: List[int] =3D []
+        try:
+            ctl_r, self.ctl_fd =3D os.pipe()
+            child_fds.append(ctl_r)
+            self.ack_fd, ack_w =3D os.pipe()
+            child_fds.append(ack_w)
+            # Quiet so that only errors are written to stderr, see error_t=
ext().
+            cmd =3D [self.perf_exe, "record", "-q", "-o", "-", "-R", "-c",=
 "1", "-k", "mono",
+                   "--synth=3Dtask", "--control", f"fd:{ctl_r},{ack_w}"]
+            filt =3D f"common_pid !=3D {os.getpid()}"
+            for name in self.events():
+                cmd +=3D ["-e", name]
+                if name.startswith("syscalls:"):
+                    cmd +=3D ["--filter", filt]
+            # Without a workload record the whole system until stopped.
+            cmd +=3D ["--", *self.workload] if self.workload else ["-a"]
+            self.origin =3D monotonic_ns()
+            # A new session so that signals for the terminal aren't receiv=
ed.
+            self.proc =3D subprocess.Popen(cmd, stdin=3Dsubprocess.DEVNULL=
, stdout=3Dsubprocess.PIPE,
+                                         stderr=3Dself.stderr, pass_fds=3D=
(ctl_r, ack_w),
+                                         start_new_session=3DTrue)
+            assert self.proc.stdout
+            self.data_fd =3D self.proc.stdout.fileno()
+            self.grow_pipe(self.data_fd)
+            if output:
+                # Save the data as it is passed on to be processed.
+                self.tee_r, tee_w =3D os.pipe()
+                self.tee_thread =3D threading.Thread(target=3Dself.tee,
+                                                   args=3D(self.data_fd, t=
ee_w, output),
+                                                   daemon=3DTrue)
+                try:
+                    self.tee_thread.start()
+                except BaseException:
+                    self.tee_thread =3D None
+                    os.close(tee_w)
+                    raise
+                # Closed by the tee thread.
+                output =3D None
+                self.data_fd =3D self.tee_r
+                self.grow_pipe(self.data_fd)
+            self.control_thread =3D threading.Thread(target=3Dself.control=
_loop, daemon=3DTrue)
+            self.control_thread.start()
+        except BaseException:
+            self.stop()
+            if output:
+                output.close()
+            raise
+        finally:
+            for fd in child_fds:
+                os.close(fd)
+
+    @staticmethod
+    def grow_pipe(fd: int) -> None:
+        """Make the pipe bigger, if allowed, to absorb bursts of events.""=
"
+        try:
+            fcntl.fcntl(fd, fcntl.F_SETPIPE_SZ, LIVE_PIPE_SIZE)
+        except OSError:
+            pass
+
+    def tee(self, src: int, dst: int, output: Any) -> None:
+        """Copy the data from src to dst and the output file."""
+        os.set_blocking(dst, False)
+        forwarding =3D True
+        try:
+            while True:
+                try:
+                    buf =3D os.read(src, 1 << 16)
+                except OSError:
+                    break
+                if not buf:
+                    break
+                output.write(buf)
+                view =3D memoryview(buf)
+                while forwarding and not self.stopping.is_set() and view:
+                    try:
+                        view =3D view[os.write(dst, view):]
+                    except BlockingIOError:
+                        select.select([], [dst], [], 0.1)
+                    except OSError:
+                        # The data is no longer processed, keep saving it.
+                        forwarding =3D False
+        finally:
+            output.close()
+            os.close(dst)
+
+    def send(self, cmd: str) -> bool:
+        """Send a command to perf record and wait for its acknowledgment."=
""
+        try:
+            os.write(self.ctl_fd, f"{cmd}\n".encode())
+            # The acknowledgment is "ack\n" followed by a NUL, which may b=
e
+            # read before or with the next acknowledgment.
+            ack =3D b""
+            while b"\n" not in ack:
+                # perf record may be slow to respond if it is blocked writ=
ing
+                # data, so wait until it exits or recording is stopped.
+                if self.stopping.is_set() or (self.proc and self.proc.poll=
() is not None):
+                    return False
+                ready, _, _ =3D select.select([self.ack_fd], [], [], 0.5)
+                if ready:
+                    buf =3D os.read(self.ack_fd, 16)
+                    if not buf:
+                        return False
+                    ack +=3D buf
+        except OSError:
+            return False
+        return True
+
+    def control_loop(self) -> None:
+        """Send queued commands, otherwise pings that flush perf record's =
buffers."""
+        try:
+            while not self.stopping.is_set():
+                try:
+                    cmd =3D self.commands.get(timeout=3Dself.flush_interva=
l)
+                except queue.Empty:
+                    if self.paused:
+                        continue
+                    cmd =3D "ping"
+                if not cmd or self.stopping.is_set() or not self.send(cmd)=
:
+                    break
+        finally:
+            self.close_control_fds()
+
+    def set_paused(self, paused: bool) -> None:
+        """Pause or resume recording."""
+        self.paused =3D paused
+        self.commands.put("disable" if paused else "enable")
+
+    def backlog(self) -> float:
+        """The fraction of the data pipe filled with data waiting to be pr=
ocessed."""
+        try:
+            pending =3D array.array("i", [0])
+            fcntl.ioctl(self.data_fd, termios.FIONREAD, pending)
+            size =3D fcntl.fcntl(self.data_fd, fcntl.F_GETPIPE_SZ)
+        except OSError:
+            return 0.0
+        return pending[0] / max(size, 1)
+
+    def stop(self) -> None:
+        """Stop recording, perf record then writes any remaining data and =
exits."""
+        self.stopping.set()
+        self.commands.put("")
+        proc =3D self.proc
+        if proc is not None and proc.poll() is None:
+            try:
+                proc.send_signal(signal.SIGINT)
+                proc.wait(timeout=3D1)
+            except subprocess.TimeoutExpired:
+                # Probably blocked writing data that is no longer processe=
d.
+                proc.kill()
+                proc.wait()
+        if self.tee_thread and self.tee_thread is not threading.current_th=
read():
+            self.tee_thread.join(timeout=3D1)
+        if self.control_thread and self.control_thread is not threading.cu=
rrent_thread():
+            self.control_thread.join(timeout=3D1)
+        self.close_control_fds()
+        self.close_data_fds()
+
+    def close_data_fds(self) -> None:
+        """Close the read ends of the data pipes.
+
+        perf.data() duplicates the file descriptor it reads from, so they
+        aren't needed once processing has started. Closing them means writ=
es
+        to them fail, rather than block, once they are no longer read.
+        """
+        self.data_fd =3D -1
+        tee_r, self.tee_r =3D self.tee_r, -1
+        if tee_r >=3D 0:
+            try:
+                os.close(tee_r)
+            except OSError:
+                pass
+        # Unless the tee thread is still reading from it.
+        if self.proc and self.proc.stdout and not (self.tee_thread and
+                                                   self.tee_thread.is_aliv=
e()):
+            self.proc.stdout.close()
+
+    def error_text(self) -> str:
+        """The last lines written to stderr by perf record, to explain fai=
lures.
+
+        Usage text that follows an error in the options is dropped.
+        """
+        self.stderr.seek(0)
+        lines =3D self.stderr.read().decode(errors=3D"replace").strip().sp=
litlines()
+        for i, line in enumerate(lines):
+            if line.strip().startswith("Usage: perf record"):
+                lines =3D lines[:i]
+                break
+        return "\n".join(line for line in lines[-10:] if line.strip())
+
+
 def main() -> None:
     """Parse arguments, read the perf.data file and run the app."""
     parser =3D argparse.ArgumentParser(
         description=3D"Interactive timechart of CPU, task and I/O activity=
.")
-    parser.add_argument("-i", "--input", default=3D"perf.data", help=3D"in=
put perf.data file")
+    parser.add_argument("-i", "--input", help=3D"input perf.data file, def=
ault perf.data")
     parser.add_argument("-P", "--power-only", action=3D"store_true",
                         help=3D"only show CPU power information")
     parser.add_argument("-T", "--tasks-only", action=3D"store_true",
                         help=3D"only show task information")
+    parser.add_argument("-I", "--io-only", action=3D"store_true",
+                        help=3D"only record or show I/O information")
     parser.add_argument("-p", "--process", action=3D"append", default=3D[]=
,
                         help=3D"only show processes with the given name or=
 PID, may be repeated")
     parser.add_argument("--dump", action=3D"store_true",
                         help=3D"print a text summary rather than running t=
he interactive UI")
+    parser.add_argument("--live", action=3D"store_true",
+                        help=3D"record events with perf record and show th=
em as they happen")
+    parser.add_argument("--window", type=3Dfloat,
+                        help=3Df"seconds of recent events kept and shown i=
n live mode, "
+                        f"default {LIVE_WINDOW:g}")
+    parser.add_argument("-o", "--output",
+                        help=3D"in live mode, also save the recorded event=
s to this file")
+    parser.add_argument("--perf", help=3D"perf executable used to record i=
n live mode")
+    parser.add_argument("workload", nargs=3Dargparse.REMAINDER,
+                        help=3D"in live mode, a command to record rather t=
han the whole system")
     args =3D parser.parse_args()
+    workload =3D args.workload[1:] if args.workload[:1] =3D=3D ["--"] else=
 args.workload
=20
-    if args.power_only and args.tasks_only:
-        print("Error: -P and -T options cannot be used at the same time.",=
 file=3Dsys.stderr)
+    def error(msg: str) -> NoReturn:
+        print(f"Error: {msg}", file=3Dsys.stderr)
         sys.exit(1)
=20
-    if args.input =3D=3D "-":
+    if args.power_only and args.tasks_only:
+        error("-P and -T options cannot be used at the same time.")
+    if args.io_only and (args.power_only or args.tasks_only):
+        error("-I cannot be used with -P or -T.")
+
+    if args.live:
+        if args.input or args.dump:
+            error("--live can't be used with -i or --dump.")
+        window =3D LIVE_WINDOW if args.window is None else args.window
+        if not math.isfinite(window * NSEC_PER_SEC) or window <=3D 0:
+            error("--window must be a positive number of seconds.")
+        perf_exe =3D args.perf or shutil.which("perf") or "perf"
+        recorder =3D LiveRecorder(perf_exe, args.power_only, args.tasks_on=
ly, workload,
+                                args.output, io_only=3Dargs.io_only)
+        try:
+            recorder.start()
+        except OSError as e:
+            error(f"failed to start '{perf_exe} record': {e}")
+        try:
+            app =3D TimechartApp("live", args.power_only, args.tasks_only,=
 args.process,
+                               live=3Drecorder, window=3Dwindow, io_only=
=3Dargs.io_only)
+            app.run()
+        finally:
+            recorder.stop()
+        sys.exit(app.return_code or 0)
+
+    if args.window is not None or args.output or workload:
+        error("--window, -o and a workload require --live.")
+    input_name =3D args.input or "perf.data"
+    if input_name =3D=3D "-":
         if not args.dump:
             # The interactive UI reads the keyboard from stdin.
-            print("Error: reading perf.data from stdin requires --dump.", =
file=3Dsys.stderr)
-            sys.exit(1)
-    elif not os.path.exists(args.input):
-        print(f"Error: {args.input} not found. (try 'perf timechart record=
' first)",
-              file=3Dsys.stderr)
-        sys.exit(1)
+            error("reading perf.data from stdin requires --dump.")
+    elif not os.path.exists(input_name):
+        error(f"{input_name} not found. (try 'perf timechart record' first=
)")
=20
     if args.dump:
-        data =3D load_data(args.input)
-        data.dump(args.power_only, args.tasks_only, args.process)
+        data =3D load_data(input_name)
+        data.dump(args.power_only, args.tasks_only, args.process, io_only=
=3Dargs.io_only)
         return
=20
     # The app starts immediately and loads the data in the background.
-    app =3D TimechartApp(args.input, args.power_only, args.tasks_only, arg=
s.process)
+    app =3D TimechartApp(input_name, args.power_only, args.tasks_only, arg=
s.process,
+                       io_only=3Dargs.io_only)
     app.run()
     sys.exit(app.return_code or 0)
=20
=20
-def read_events(data: TimechartData, input_name: str) -> None:
-    """Process the events in input_name into data, raising on errors."""
+def read_events(data: TimechartData, source: Union[str, int]) -> None:
+    """Process the events in the named file, or pipe file descriptor, into=
 data.
+
+    Raises on errors.
+    """
     if data.cancelled:
         raise LoadCancelled()
     try:
-        data.session =3D perf.session(perf.data(input_name), sample=3Ddata=
.process_event)
+        pdata =3D perf.data(source) if isinstance(source, str) else perf.d=
ata(fd=3Dsource)
+        data.session =3D perf.session(pdata, sample=3Ddata.process_event)
         data.session.process_events()
         data.finish()
     finally:
--=20
2.56.0.307.g5fe7bd680c-goog

