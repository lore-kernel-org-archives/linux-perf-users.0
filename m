Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731AF3AF656
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504202; cv=none; b=Kjt9VheE2eo/w4UtQ/VmEb5jNlp6SKvIa+z4ea6pfrUcfP50y/IA7l3bDQXNtbpaHcpj3dsJtS69lBdM/shgxvyKCS43FMyTnwO+EBg2yRyvne265saS23+tOuwW4AsY1rcTfQrS4lpnJhfZeZ0yF3/6Rkv1RZc32T1Wkl0ohDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504202; c=relaxed/simple;
	bh=H6bwtJ2C6+1+XZrMDYNTqA9vOpa4fGupu5BK7K6cYPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gP4nWGK1ifSXsMpVIwHZiLOZMDFhOoODHcEEDaHcxssH1+GCIjGgPT+wHFee+71+oFgeACu4+SlT9Zp/kJWBgA09GXrOrZgnrMDrQ3dBbJx2LJa8xCH28YCaaxyHECr+xHkc3muDKQ4T0bB4PdqeBY26Qmefob6pAB7JP+2CMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iSjFAxOj; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSjFAxOj"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304d8613efbso3580579eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 23:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781504199; x=1782108999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8ZZr5/kHTP8AME7TbpDnum2m/d0OHSaO2Xhj4KNO6Y=;
        b=iSjFAxOjPQdI1wVD2yTuDq4iHyEomiPLLJSPoGuQfebdHS1JrqppOkGPET4rbAADtJ
         nRykD0IJwWAhAPh7CsMzSHMgkDJfbPPsucxVME3jFXh6uRw7A0tpE/ahW5k2NnBi/J5D
         HtezEbHKiyHFLADt8Lc1N5Tju7vFNA4u+tEpRoGeFkaNPY26LOzkPsYgQYyasxwG+pKi
         IFIoGXMWcrnERuxeQx01myfbTbEy1Vj35+9PcR3HBnsVhWDbrO8g0hTlwjLwT9kH5xHB
         iNDbRUCogsrfFMxOSW9qEdxkTcDy2vHI3Qz7VQfXm5YjoVhlALGm/jt2zwu4+tXZyrtc
         yr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504199; x=1782108999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8ZZr5/kHTP8AME7TbpDnum2m/d0OHSaO2Xhj4KNO6Y=;
        b=Zvh8tLIL5/jA6ir0UryA1yhVhrWmX6QIG9jb2e9kB3WZYDWZl8DLzQRZdVG0Za6VeP
         mrp6x95ggtl2p0Gpm2g+MeSudb6JUfbjN1STqGUCTomD55QizM0pnmWQEJ575sufEoLB
         wsv946cNlfCWDr9MPZ90G9TMbJrF4hquLfVOblcedCmd0NjIOB2spqAMgCzFvvF+i5k1
         20ShDpPoJigovBq+RemvLUxrDE8zgazYN+hThzSZSomdVxKT1EZsqAuqG8UmoTFvRU24
         b+4I5W1ylog/1s3fwWdRpTSzMOO8O2z5z6DnPb3P8PNwSX5WCuTzPvjY2/Uru2zLHf1m
         KuWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/oPMJnBp8lCxW0zNR9uBlAJK6HtVhISTashk10x5cCw7PgT2yZGe+OUmdkoA6WM556xIk5pKGetINygipD3yOu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8rgH+18SJWiGT2w3zsyT4h2wBzowSUAHjCW9blSlRf+tDZlP7
	wZd1qYrKLQ0UccFWViVtvvJbjgxLBfET4IqYWBVDSdq9ZVcg9v+Ye/1vBGDZBZYcwOXxlOUJqZC
	qc3256im/TA==
X-Received: from dyji23.prod.google.com ([2002:a05:7300:7a17:b0:2f6:ff42:df28])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:320f:b0:304:de94:1c2c
 with SMTP id 5a478bee46e88-308200c908cmr7336259eec.34.1781504199213; Sun, 14
 Jun 2026 23:16:39 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:16:11 -0700
In-Reply-To: <20260615061631.2382079-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615002812.2234795-1-irogers@google.com> <20260615061631.2382079-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615061631.2382079-2-irogers@google.com>
Subject: [PATCH v19 01/20] perf util: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Fix missing includes found while cleaning the evsel/evlist header
files. Sort the remaining header files for consistency with the rest
of the code.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_off_cpu.c       | 30 +++++-----
 tools/perf/util/bpf_trace_augment.c |  8 +--
 tools/perf/util/evlist.c            | 91 +++++++++++++++--------------
 tools/perf/util/map.h               |  9 ++-
 tools/perf/util/perf_api_probe.c    | 18 +++---
 tools/perf/util/s390-sample-raw.c   | 19 +++---
 tools/perf/util/stat-shadow.c       | 20 ++++---
 tools/perf/util/stat.c              | 16 +++--
 8 files changed, 113 insertions(+), 98 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index a3b699a5322f..48cb930cdd2e 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -1,23 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "util/bpf_counter.h"
-#include "util/debug.h"
-#include "util/evsel.h"
-#include "util/evlist.h"
-#include "util/off_cpu.h"
-#include "util/perf-hooks.h"
-#include "util/record.h"
-#include "util/session.h"
-#include "util/target.h"
-#include "util/cpumap.h"
-#include "util/thread_map.h"
-#include "util/cgroup.h"
-#include "util/strlist.h"
+#include <linux/time64.h>
+
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <internal/xyarray.h>
-#include <linux/time64.h>
 
+#include "bpf_counter.h"
 #include "bpf_skel/off_cpu.skel.h"
+#include "cgroup.h"
+#include "cpumap.h"
+#include "debug.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "off_cpu.h"
+#include "parse-events.h"
+#include "perf-hooks.h"
+#include "record.h"
+#include "session.h"
+#include "strlist.h"
+#include "target.h"
+#include "thread_map.h"
 
 #define MAX_STACKS  32
 #define MAX_PROC  4096
diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
index 9e706f0fa53d..a9cf2a77ded1 100644
--- a/tools/perf/util/bpf_trace_augment.c
+++ b/tools/perf/util/bpf_trace_augment.c
@@ -1,11 +1,11 @@
 #include <bpf/libbpf.h>
 #include <internal/xyarray.h>
 
-#include "util/debug.h"
-#include "util/evlist.h"
-#include "util/trace_augment.h"
-
 #include "bpf_skel/augmented_raw_syscalls.skel.h"
+#include "debug.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "trace_augment.h"
 
 static struct augmented_raw_syscalls_bpf *skel;
 static struct evsel *bpf_output;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1a238b245b3a..ab6bf5e935f4 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -5,67 +5,68 @@
  * Parts came from builtin-{top,stat,record}.c, see those files for further
  * copyright notes.
  */
-#include <api/fs/fs.h>
+#include "evlist.h"
+
 #include <errno.h>
 #include <inttypes.h>
-#include <poll.h>
-#include "cpumap.h"
-#include "util/mmap.h"
-#include "thread_map.h"
-#include "target.h"
-#include "dwarf-regs.h"
-#include "evlist.h"
-#include "evsel.h"
-#include "record.h"
-#include "debug.h"
-#include "units.h"
-#include "bpf_counter.h"
-#include <internal/lib.h> // page_size
-#include "affinity.h"
-#include "../perf.h"
-#include "asm/bug.h"
-#include "bpf-event.h"
-#include "util/event.h"
-#include "util/string2.h"
-#include "util/perf_api_probe.h"
-#include "util/evsel_fprintf.h"
-#include "util/pmu.h"
-#include "util/sample.h"
-#include "util/bpf-filter.h"
-#include "util/stat.h"
-#include "util/util.h"
-#include "util/env.h"
-#include "util/intel-tpebs.h"
-#include "util/metricgroup.h"
-#include "util/strbuf.h"
 #include <signal.h>
-#include <unistd.h>
-#include <sched.h>
 #include <stdlib.h>
 
-#include "parse-events.h"
-#include <subcmd/parse-options.h>
-
 #include <fcntl.h>
-#include <sys/ioctl.h>
-#include <sys/mman.h>
-#include <sys/prctl.h>
-#include <sys/timerfd.h>
-#include <sys/wait.h>
-
 #include <linux/bitops.h>
+#include <linux/err.h>
 #include <linux/hash.h>
 #include <linux/log2.h>
-#include <linux/err.h>
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
+#include <poll.h>
+#include <sched.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/timerfd.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <api/fs/fs.h>
+#include <internal/lib.h> // page_size
+#include <internal/xyarray.h>
+#include <perf/cpumap.h>
 #include <perf/evlist.h>
 #include <perf/evsel.h>
-#include <perf/cpumap.h>
 #include <perf/mmap.h>
+#include <subcmd/parse-options.h>
 
-#include <internal/xyarray.h>
+#include "../perf.h"
+#include "affinity.h"
+#include "asm/bug.h"
+#include "bpf-event.h"
+#include "bpf-filter.h"
+#include "bpf_counter.h"
+#include "cpumap.h"
+#include "debug.h"
+#include "dwarf-regs.h"
+#include "env.h"
+#include "event.h"
+#include "evsel.h"
+#include "evsel_fprintf.h"
+#include "intel-tpebs.h"
+#include "metricgroup.h"
+#include "mmap.h"
+#include "parse-events.h"
+#include "perf_api_probe.h"
+#include "pmu.h"
+#include "pmus.h"
+#include "record.h"
+#include "sample.h"
+#include "stat.h"
+#include "strbuf.h"
+#include "string2.h"
+#include "target.h"
+#include "thread_map.h"
+#include "units.h"
+#include "util.h"
 
 #ifdef LACKS_SIGQUEUE_PROTOTYPE
 int sigqueue(pid_t pid, int sig, const union sigval value);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 979b3e11b9bc..fb0279810ae9 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -2,14 +2,13 @@
 #ifndef __PERF_MAP_H
 #define __PERF_MAP_H
 
-#include <linux/refcount.h>
-#include <linux/compiler.h>
-#include <linux/list.h>
-#include <linux/rbtree.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <string.h>
-#include <stdbool.h>
+
+#include <linux/refcount.h>
 #include <linux/types.h>
+
 #include <internal/rc_check.h>
 
 struct dso;
diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 6ecf38314f01..e1904a330b28 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -1,14 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include "perf_api_probe.h"
 
-#include "perf-sys.h"
-#include "util/cloexec.h"
-#include "util/evlist.h"
-#include "util/evsel.h"
-#include "util/parse-events.h"
-#include "util/perf_api_probe.h"
-#include <perf/cpumap.h>
 #include <errno.h>
 
+#include <perf/cpumap.h>
+
+#include "cloexec.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "parse-events.h"
+#include "perf-sys.h"
+#include "pmu.h"
+#include "pmus.h"
+
 typedef void (*setup_probe_fn_t)(struct evsel *evsel);
 
 static int perf_do_probe_api(setup_probe_fn_t fn, struct perf_cpu cpu, const char *str)
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 52bbca5c56c8..01111c4e3488 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -12,25 +12,26 @@
  * sample was taken from.
  */
 
-#include <unistd.h>
+#include <inttypes.h>
 #include <stdio.h>
 #include <string.h>
-#include <inttypes.h>
 
-#include <sys/stat.h>
+#include <asm/byteorder.h>
 #include <linux/compiler.h>
 #include <linux/err.h>
-#include <asm/byteorder.h>
+#include <sys/stat.h>
+#include <unistd.h>
 
+#include "color.h"
 #include "debug.h"
-#include "session.h"
 #include "evlist.h"
-#include "color.h"
 #include "hashmap.h"
-#include "sample-raw.h"
+#include "pmu.h"
+#include "pmus.h"
 #include "s390-cpumcf-kernel.h"
-#include "util/pmu.h"
-#include "util/sample.h"
+#include "sample-raw.h"
+#include "sample.h"
+#include "session.h"
 
 static size_t ctrset_size(struct cf_ctrset_entry *set)
 {
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index c17373bb0e1e..35062f964618 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -2,20 +2,24 @@
 #include <errno.h>
 #include <math.h>
 #include <stdio.h>
-#include "evsel.h"
-#include "stat.h"
+
+#include <linux/zalloc.h>
+
+#include "cgroup.h"
 #include "color.h"
 #include "debug.h"
-#include "pmu.h"
-#include "rblist.h"
 #include "evlist.h"
+#include "evsel.h"
 #include "expr.h"
-#include "metricgroup.h"
-#include "cgroup.h"
-#include "units.h"
+#include "hashmap.h"
 #include "iostat.h"
-#include "util/hashmap.h"
+#include "metricgroup.h"
+#include "pmu.h"
+#include "pmus.h"
+#include "rblist.h"
+#include "stat.h"
 #include "tool_pmu.h"
+#include "units.h"
 
 static bool tool_pmu__is_time_event(const struct perf_stat_config *config,
 				   const struct evsel *evsel, int *tool_aggr_idx)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 14d169e22e8f..66eb9a66a4f7 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -1,21 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "stat.h"
+
 #include <errno.h>
-#include <linux/err.h>
 #include <inttypes.h>
 #include <math.h>
 #include <string.h>
+
+#include <linux/err.h>
+#include <linux/zalloc.h>
+
 #include "counts.h"
 #include "cpumap.h"
 #include "debug.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "hashmap.h"
 #include "header.h"
-#include "stat.h"
+#include "pmu.h"
 #include "session.h"
 #include "target.h"
-#include "evlist.h"
-#include "evsel.h"
 #include "thread_map.h"
-#include "util/hashmap.h"
-#include <linux/zalloc.h>
 
 void update_stats(struct stats *stats, u64 val)
 {
-- 
2.54.0.1136.gdb2ca164c4-goog

