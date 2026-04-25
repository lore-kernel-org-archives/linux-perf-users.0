Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DB238D019
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156905; cv=none; b=qN9tKxnAMPXb3vSHclugknTH27kX6EmtrxTebx6L61TnCeKje3mW/WOImlBdQK9CghX8iOBASKqmfgO032lsr6HtWNqt1lwxtN5/lQ0QQoeVcuV8pkJxOZWuQK6tawIUS+1Rz3WnTw/BJsJ6/Z7gzvEAyuUy7cruQgqk3XI9MfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156905; c=relaxed/simple;
	bh=bCaeAHwSbM97Ifxo1Dx//tE+XP8ZfBYmMdOmVKj+DdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fCG5RNbXp+cYgIgD0ZnE6GXDHVlLOJl5dq0FFdnmtqZe0P4kiUaLcTRFG+oY0cEliICsFr1ZafBnstasRJ+vta9YbugJ0caQcfodscjHrA1kKE80DHmZwij51fMU+mWOUy3wjqMFCVcsgl2VZE7a9TMgMheTjVl61KeZ5yBCabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ncb6Sn57; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ncb6Sn57"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdd327d970so5510076eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156903; x=1777761703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=viZhgTNNP2buRGy766mhoKyGu3Atkn7DPzIJmPMe5kc=;
        b=ncb6Sn57KdYY0RwhR+BdwlXyPSIZ0daCsqYTg+B1paFXaicRZHCuz9eJOypBmiRiZP
         c8X4JoFxoXw6vfNPY4WZZpZhM0dLaJdNUsVGXStep0harrIRZhwktt1kdwtM2NT1f0vR
         Jd7RrSkcQBt3V4oVNtxuYgOhsIF+wEyr7hoPDOkP10ZPudZLssprpJKOfW43Y2RX65xA
         o8Z446+ffl8O+CVl7THUv6rCvYo5jc9fuFbMGMF7w2isEheXe6GIlgliueSSttaiKo++
         YSLBnSjA+Ko2g+6XYLEFnbkr+ny0KEQIYR+zTK0Pd7QUrI05oc6ei7TVpbHZpzGaDbEm
         /Srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156903; x=1777761703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viZhgTNNP2buRGy766mhoKyGu3Atkn7DPzIJmPMe5kc=;
        b=gDJ6AiPsSF6hTnZR9MauqgArGyS/2jp9QEMeMTg4/2UGYZENr4DgJdBIHc90RM3wr9
         MxYlaYMbMxiF58LZktLc/Swqlm0RSgABJfBaFVg8D8/4TnZChEabcR7G4hBKDOD2c78S
         uGJr1ZqDKFngfA3uEptaugm3QViZENR0kDU2IZwN/NXvWK2EWjGRFTQSMDM/IRMTNU5O
         uj/pFG1X9tMnkaTLh9uoLosAuTvrKhWR0cZyDpIw3GXh2xoVMmdB9cljCVGnhLcg+F4w
         /yiIetuVq3kj1zLe4/+oo/PgoDNgXmYwUqIpUvUBmmDXdveIZBKXJeSAzD7T1qgfoSxg
         knrQ==
X-Forwarded-Encrypted: i=1; AFNElJ82o1Xcfmzw1jrd9Y70eHMRwyu5dW/1pE1VmChDZBPx0kiiBJeckeUpuERQpXKyQQT52rrYTz7EzhNmSEHXy2w0@vger.kernel.org
X-Gm-Message-State: AOJu0YyITNrOMkZuOFcZs71pwOFg3FOwipiwCSBzFmfz3cmL2AkidSXJ
	1pMQrpnsEXis3u1iRYPZPIRTA+lreC6FjzhF3enpqi3y0kIWDUaqSahk73lLUzSZhRsWftV2hYc
	gO2CfPy107g==
X-Received: from dyjf14.prod.google.com ([2002:a05:7300:680e:b0:2d9:9fa3:5aa6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ec07:b0:2d8:4dee:6ad0
 with SMTP id 5a478bee46e88-2e42e20295amr14506669eec.16.1777156902822; Sat, 25
 Apr 2026 15:41:42 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:31 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-7-irogers@google.com>
Subject: [PATCH v7 06/59] perf util: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix missing includes found while cleaning the evsel/evlist header
files. Sort the remaining header files for consistency with the rest
of the code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_off_cpu.c       | 30 +++++-----
 tools/perf/util/bpf_trace_augment.c |  8 +--
 tools/perf/util/evlist.c            | 91 +++++++++++++++--------------
 tools/perf/util/evsel.c             | 75 ++++++++++++------------
 tools/perf/util/map.h               |  9 ++-
 tools/perf/util/perf_api_probe.c    | 18 +++---
 tools/perf/util/s390-sample-raw.c   | 19 +++---
 tools/perf/util/stat-shadow.c       | 20 ++++---
 tools/perf/util/stat.c              | 16 +++--
 9 files changed, 152 insertions(+), 134 deletions(-)

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
index ee971d15b3c6..35d65fe50e06 100644
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
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2ee87fd84d3e..e03727d395e9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -11,68 +11,71 @@
  */
 #define __SANE_USERSPACE_TYPES__
 
-#include <byteswap.h>
+#include "evsel.h"
+
 #include <errno.h>
 #include <inttypes.h>
+#include <stdlib.h>
+
+#include <dirent.h>
 #include <linux/bitops.h>
-#include <api/fs/fs.h>
-#include <api/fs/tracing_path.h>
-#include <linux/hw_breakpoint.h>
-#include <linux/perf_event.h>
 #include <linux/compiler.h>
+#include <linux/ctype.h>
 #include <linux/err.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
 #include <linux/zalloc.h>
 #include <sys/ioctl.h>
 #include <sys/resource.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
-#include <dirent.h>
-#include <stdlib.h>
+
+#include <api/fs/fs.h>
+#include <api/fs/tracing_path.h>
+#include <byteswap.h>
+#include <internal/lib.h>
+#include <internal/threadmap.h>
+#include <internal/xyarray.h>
+#include <perf/cpumap.h>
 #include <perf/evsel.h>
+
+#include "../perf-sys.h"
 #include "asm/bug.h"
+#include "bpf-filter.h"
 #include "bpf_counter.h"
 #include "callchain.h"
 #include "cgroup.h"
 #include "counts.h"
+#include "debug.h"
+#include "drm_pmu.h"
 #include "dwarf-regs.h"
+#include "env.h"
 #include "event.h"
-#include "evsel.h"
-#include "time-utils.h"
-#include "util/env.h"
-#include "util/evsel_config.h"
-#include "util/evsel_fprintf.h"
 #include "evlist.h"
-#include <perf/cpumap.h>
-#include "thread_map.h"
-#include "target.h"
+#include "evsel_config.h"
+#include "evsel_fprintf.h"
+#include "hashmap.h"
+#include "hist.h"
+#include "hwmon_pmu.h"
+#include "intel-tpebs.h"
+#include "memswap.h"
+#include "off_cpu.h"
+#include "parse-branch-options.h"
 #include "perf_regs.h"
+#include "pmu.h"
+#include "pmus.h"
 #include "record.h"
-#include "debug.h"
-#include "trace-event.h"
+#include "rlimit.h"
 #include "session.h"
 #include "stat.h"
 #include "string2.h"
-#include "memswap.h"
-#include "util.h"
-#include "util/hashmap.h"
-#include "off_cpu.h"
-#include "pmu.h"
-#include "pmus.h"
-#include "drm_pmu.h"
-#include "hwmon_pmu.h"
+#include "target.h"
+#include "thread_map.h"
+#include "time-utils.h"
 #include "tool_pmu.h"
 #include "tp_pmu.h"
-#include "rlimit.h"
-#include "../perf-sys.h"
-#include "util/parse-branch-options.h"
-#include "util/bpf-filter.h"
-#include "util/hist.h"
-#include <internal/xyarray.h>
-#include <internal/lib.h>
-#include <internal/threadmap.h>
-#include "util/intel-tpebs.h"
-
-#include <linux/ctype.h>
+#include "trace-event.h"
+#include "util.h"
 
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
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
index c6ae0ae8d86a..6bf0edf80d4e 100644
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
index bc2d44df7baf..48524450326d 100644
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
2.54.0.545.g6539524ca2-goog

