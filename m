Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4262B2FD1AA
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 05:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716070; cv=none; b=taqE97qV3XZoO7kWmVap5SPtrimGhXzycTfng7RZrOkT9/i5iVbWaJtMC00BH+J0VYNRudjqVxOJ06OzBl3o2+KLZ7B9de1wegZ8AU4ORi0AT2OCwSbWxq3DmqbqngeqF2PbPuhzfGxuZuRfEm2nw/b1z2wmSAkME1WplB6tffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716070; c=relaxed/simple;
	bh=RCOWYW0eWdVan8nSdNr58xSEWGyXHpqrK98TvRvgRaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JMM8w0/dYiV1sL33egUR75HvpGIzGok3+YqKOP4ZK86Lx4YbA63kyo7We7q09DG+ouvM3oMpHSu0y3GNQ2/+mPy5IQ06TqV78v2qVMAJFga4MZWVoFDYhX6Is2cwC0EFAlDJytP4Dtxb9+vRoOFce/qd09+EqPtp7OQGWAI4Ifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XL6z7IoN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XL6z7IoN"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-784adcfe127so98080157b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 22:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716067; x=1762320867; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THSPkwfdbOYwyEt2kIyr7orJhsGJmegrl3TMMEOJz4M=;
        b=XL6z7IoNE9pixp20OYkuIjGlaEAuHfUOuw4HLQsQGCmmd6aTtxBKTzYJjnGiKJ5ocT
         yem2GuD4ypEaK2r3yYabJi5LVMyQ1Y2mWu5NUAJKgRfIIjPqkBOvkdfY8mWG3YY9BoBr
         NgpYeukZHvEblIyvZKuzT9Pa/0MVJoXFgGRWjB0GAdYZ6PQQ7S+5AhFak4fz5e3q6gCF
         vzfqkcx8aZWRDpkKH+UYpHdASAOyufCAFYUwgWokO9HupOxZ9ZAQkagLoSUH66oqRdJJ
         EVBxSUqFYvpEtpR1UcwezEQaYc6i7btMnMG8axHXogvJfHmogbTXvJsjhIDQSsIAkr4A
         1elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716067; x=1762320867;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THSPkwfdbOYwyEt2kIyr7orJhsGJmegrl3TMMEOJz4M=;
        b=YvU5nPABeQ4MxMMiq9/0wxgGOCJTErIqAjedUtjCQEOKqXl0E6//NZr1GO4+UUYLct
         ToVVb0CXVQMCjCzJF5WcadjqByFJA62ydODgz5XytTgbxQrDWWqTAglllb7+WWZ/tHDD
         QCYMw3tvyTgANgaIfJezkNy51qQN0zzyleMZ3o4hf6fWELrjqvzaULaiw8Vxz7mxFnm3
         uwxHWpAeHj041hn6WQzAw9aKBIb55fDe/pSTUW+Q54qAqPcFLxOOOugYgCqrw57HsJvQ
         GxnEz1QDM9/PbB+qIhOyGO1orZHZEJh5j00//znuUsVM4rfKK5xRs61ZWI/gBV72Q0LV
         XH5A==
X-Forwarded-Encrypted: i=1; AJvYcCU1lcWENXDIdkHbSUgE3PR3eo388pBEPmWzETaZRREFHjwxY5dVXd5tm3VUbzNVMhD9F+jrLK7sCrxHUcGZTur0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Zq0VjM+d07tZmD1gLOb33VCwF3xy+SSYdMg+n0Txp28vvSgg
	ITAq1YqU5Nn83b4pv0g5HAdwNIIGfzdxhkfZ3Nzaq3n3jlF9FrxZ52nNo3HQRVKa/Q6Y9BNQmOO
	Y7xaawK8cPw==
X-Google-Smtp-Source: AGHT+IHO5ntVJHgND97kqmZAzJ3mDz13n7CAuE5Jwt6yaOfFz/tSrxBkFQnE5UX83bEG1um2uV9otIRx1dPA
X-Received: from ywbik2.prod.google.com ([2002:a05:690c:4a02:b0:783:777f:c91f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:23c6:b0:781:c87:c2fe
 with SMTP id 00721157ae682-78628fd908dmr17341407b3.56.1761716067252; Tue, 28
 Oct 2025 22:34:27 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:03 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-6-irogers@google.com>
Subject: [RFC PATCH v1 05/15] perf util: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix missing includes found while cleaning the evsel/evlist header
files. Sort the remaining header files for consistency with the rest
of the code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_off_cpu.c       | 28 ++++++-----
 tools/perf/util/bpf_trace_augment.c |  7 +--
 tools/perf/util/evlist.c            | 78 ++++++++++++++---------------
 tools/perf/util/evsel.c             | 77 ++++++++++++++--------------
 tools/perf/util/map.h               |  6 +--
 tools/perf/util/perf_api_probe.c    | 17 ++++---
 tools/perf/util/s390-sample-raw.c   | 15 +++---
 tools/perf/util/stat-shadow.c       |  1 +
 tools/perf/util/stat.c              | 15 +++---
 9 files changed, 127 insertions(+), 117 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 88e0660c4bff..707ab14aa4ca 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -1,22 +1,24 @@
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
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <internal/xyarray.h>
 #include <linux/time64.h>
 
+#include "bpf_counter.h"
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
+
 #include "bpf_skel/off_cpu.skel.h"
 
 #define MAX_STACKS  32
diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
index 56ed17534caa..c2d502c1c358 100644
--- a/tools/perf/util/bpf_trace_augment.c
+++ b/tools/perf/util/bpf_trace_augment.c
@@ -1,9 +1,10 @@
 #include <bpf/libbpf.h>
 #include <internal/xyarray.h>
 
-#include "util/debug.h"
-#include "util/evlist.h"
-#include "util/trace_augment.h"
+#include "debug.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "trace_augment.h"
 
 #include "bpf_skel/augmented_raw_syscalls.skel.h"
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e8217efdda53..d99a3f12606f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -5,66 +5,66 @@
  * Parts came from builtin-{top,stat,record}.c, see those files for further
  * copyright notes.
  */
-#include <api/fs/fs.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <inttypes.h>
 #include <poll.h>
-#include "cpumap.h"
-#include "util/mmap.h"
-#include "thread_map.h"
-#include "target.h"
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
-#include <signal.h>
-#include <unistd.h>
 #include <sched.h>
+#include <signal.h>
 #include <stdlib.h>
-
-#include "parse-events.h"
-#include <subcmd/parse-options.h>
-
-#include <fcntl.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/prctl.h>
 #include <sys/timerfd.h>
 #include <sys/wait.h>
+#include <unistd.h>
 
+#include <api/fs/fs.h>
+#include <internal/lib.h> // page_size
+#include <internal/xyarray.h>
 #include <linux/bitops.h>
+#include <linux/err.h>
 #include <linux/hash.h>
 #include <linux/log2.h>
-#include <linux/err.h>
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
+#include <perf/cpumap.h>
 #include <perf/evlist.h>
 #include <perf/evsel.h>
-#include <perf/cpumap.h>
 #include <perf/mmap.h>
+#include <subcmd/parse-options.h>
+
+#include "../perf.h"
+#include "affinity.h"
+#include "asm/bug.h"
+#include "bpf-event.h"
+#include "bpf_counter.h"
+#include "cpumap.h"
+#include "debug.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "parse-events.h"
+#include "record.h"
+#include "target.h"
+#include "thread_map.h"
+#include "units.h"
+#include "bpf-filter.h"
+#include "env.h"
+#include "event.h"
+#include "evsel_fprintf.h"
+#include "intel-tpebs.h"
+#include "metricgroup.h"
+#include "mmap.h"
+#include "perf_api_probe.h"
+#include "pmu.h"
+#include "pmus.h"
+#include "sample.h"
+#include "stat.h"
+#include "strbuf.h"
+#include "string2.h"
+#include "util.h"
 
-#include <internal/xyarray.h>
 
 #ifdef LACKS_SIGQUEUE_PROTOTYPE
 int sigqueue(pid_t pid, int sig, const union sigval value);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ad11cbfcbff1..6769cd27b6e4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -12,66 +12,67 @@
 #define __SANE_USERSPACE_TYPES__
 
 #include <byteswap.h>
+#include <dirent.h>
 #include <errno.h>
 #include <inttypes.h>
-#include <linux/bitops.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <sys/resource.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+
 #include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
-#include <linux/hw_breakpoint.h>
-#include <linux/perf_event.h>
+#include <internal/lib.h>
+#include <internal/threadmap.h>
+#include <internal/xyarray.h>
+#include <linux/bitops.h>
 #include <linux/compiler.h>
+#include <linux/ctype.h>
 #include <linux/err.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
 #include <linux/zalloc.h>
-#include <sys/ioctl.h>
-#include <sys/resource.h>
-#include <sys/syscall.h>
-#include <sys/types.h>
-#include <dirent.h>
-#include <stdlib.h>
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
+#include "evsel.h"
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
index 979b3e11b9bc..7cd5188fe628 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -2,13 +2,11 @@
 #ifndef __PERF_MAP_H
 #define __PERF_MAP_H
 
-#include <linux/refcount.h>
-#include <linux/compiler.h>
-#include <linux/list.h>
-#include <linux/rbtree.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdbool.h>
+
+#include <linux/refcount.h>
 #include <linux/types.h>
 #include <internal/rc_check.h>
 
diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 6ecf38314f01..3345145a9307 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -1,13 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <errno.h>
 
-#include "perf-sys.h"
-#include "util/cloexec.h"
-#include "util/evlist.h"
-#include "util/evsel.h"
-#include "util/parse-events.h"
-#include "util/perf_api_probe.h"
 #include <perf/cpumap.h>
-#include <errno.h>
+
+#include "cloexec.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "parse-events.h"
+#include "perf-sys.h"
+#include "perf_api_probe.h"
+#include "pmu.h"
+#include "pmus.h"
 
 typedef void (*setup_probe_fn_t)(struct evsel *evsel);
 
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 335217bb532b..a2d6a1f93cce 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -12,21 +12,22 @@
  * sample was taken from.
  */
 
-#include <unistd.h>
+#include <inttypes.h>
 #include <stdio.h>
 #include <string.h>
-#include <inttypes.h>
+#include <unistd.h>
 
-#include <sys/stat.h>
-#include <linux/compiler.h>
 #include <asm/byteorder.h>
+#include <linux/compiler.h>
+#include <sys/stat.h>
 
+#include "color.h"
 #include "debug.h"
-#include "session.h"
 #include "evlist.h"
-#include "color.h"
-#include "sample-raw.h"
+#include "pmus.h"
 #include "s390-cpumcf-kernel.h"
+#include "sample-raw.h"
+#include "session.h"
 #include "util/pmu.h"
 #include "util/sample.h"
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index abaf6b579bfc..3588b469de9d 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -6,6 +6,7 @@
 #include "color.h"
 #include "debug.h"
 #include "pmu.h"
+#include "pmus.h"
 #include "rblist.h"
 #include "evlist.h"
 #include "expr.h"
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 101ed6c497bc..c1c44c417c93 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -1,21 +1,24 @@
 // SPDX-License-Identifier: GPL-2.0
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
+#include "stat.h"
 #include "target.h"
-#include "evlist.h"
-#include "evsel.h"
 #include "thread_map.h"
-#include "util/hashmap.h"
-#include <linux/zalloc.h>
 
 void update_stats(struct stats *stats, u64 val)
 {
-- 
2.51.1.851.g4ebd6896fd-goog

