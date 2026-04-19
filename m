Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3892631D381
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643174; cv=none; b=aV9eF4j4N1K8e4aoR2M/3LMlu1dLaTsS4JDCSCPknuxI6T+bv5Jt7na+sTFMl5Xz98tmYnUQEQqqj9nVdCGDVI9skewDuT0DqcHIPRZfHOUK6JYQZpASRcYl1FVkg6Uw8qEdB3J1pymratGE5Uh2QNrrtiR25Z6T3l7zLufin6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643174; c=relaxed/simple;
	bh=RKK6cVva0Z4VEIHxf1kReK6n565VgJDFohJGQxnBdYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hQj4b0KMYwTijSvOxJWUv/tZmIhKm5z0wktiCBitk5elyGEbxgLoO2giddJ+a4XgZ0vF65EIHO/POzZHMwnUUzU/djYoPvCCI7f2FSSHuGWdvpwrke1XXHzXNa9Dwnklwtji+Oh64AKhcSv8Ga2kEXi6Sl9giV9Y1DfV85I+Uzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EpVhV9Tu; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpVhV9Tu"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so3058879eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 16:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643172; x=1777247972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxPO4/CiV3rqVfF0eQ3yGnvdFEcDh2/hnJ+p9b2gjoc=;
        b=EpVhV9Tub+GfSgnjzFX1pK3AJt1Ew7nb5xQf31K5L0M7JESzH8BLQJsYgTS0HcMeaY
         iBPG8esLbaT/gboVncAxQBuk/CeFYXy9+Oh2xeGZScL8xRME5gf0q0ECXbSypGM6lRBO
         TZ0a4UG6BtJMxCyGnuBJcBrd44Ap/TcZBz1c+3fZ5Oaa2PlG21gx5SYqIgJ/mbqE8s/F
         wFki3H6aVxRkipnkzRkhqIiuqmbjmqrlvKABZOCqxx3mWTw6HVCYMiUZ9bQdtebr33dR
         hsN9uDciZuO58Ipsm82OIf6JdL95sA0LwrnEOvbKIgZZJDBRQ5YIGLZzT/hz4PE/q1fR
         ahTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643172; x=1777247972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxPO4/CiV3rqVfF0eQ3yGnvdFEcDh2/hnJ+p9b2gjoc=;
        b=ogx15T6dMezTjAJTKeebKqe8YbjFvoyVq8qn1+58/wkqZXp91Bxf6OP9WQApIXJs7B
         ke/lmdwzJfSaxB4AEogkwITEMVI/abd79Q3bGp8UOmXzKzlsefWGc/XHI3mLfOfZDfth
         oekK61XeybsQGvHc9/fj5mVat5c/4EPmPhzk+WV3TMlUfv0e/XLJsi+X8XomCjIjH8V+
         RqOpC7AYJKKe1RhTkEcz1c6Sv4Gh9r7tjdPb93XbcTc+rdNl5RO07aQTApSGc/jp4+cZ
         pO+w0O6TsFHQVjQ2zoaPsKrZ72ISWFdbaMU1Ianlwp6z/Tdw2bpuT8aWME+H1yizpxpe
         pWYg==
X-Forwarded-Encrypted: i=1; AFNElJ8CZlgJc1HWvxR8O3IhfxrnIhMIHAFB+njlijUbR/WVtxWJnieNNYVY1tpMAcc2H6LROdjcuusUwHmEcDQuSTG4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ekmnWIBUU2I+Sny1q9sVhi7a/+bSDr39d99ScorWZLq6yhLW
	fWHHioj6zgFkwoKoCJ7rWvS2RwX0geu2j+NXeWS3z7ioQvPvTBiSX7GEW4TB1DhTsVUXZQm3imk
	XJoWT2C6jDw==
X-Received: from dybzy3.prod.google.com ([2002:a05:7301:e103:b0:2df:af:8fde])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2b04:b0:2e2:a4ba:84ae
 with SMTP id 5a478bee46e88-2e479017499mr5537629eec.25.1776643172009; Sun, 19
 Apr 2026 16:59:32 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:17 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-6-irogers@google.com>
Subject: [PATCH v1 05/58] perf script: Sort includes and add missed explicit dependencies
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

Fix missing #include of pmu.h found while cleaning the evsel/evlist
header files. Sort the remaining header files for consistency with the
rest of the code. Doing this exposed a missing forward declaration of
addr_location in print_insn.h, add this and sort the forward
declarations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c  | 111 ++++++++++++++++++-----------------
 tools/perf/util/print_insn.h |   5 +-
 2 files changed, 60 insertions(+), 56 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c8ac9f01a36b..853b141a0d50 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1,74 +1,77 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "builtin.h"
+#include <errno.h>
+#include <inttypes.h>
+#include <signal.h>
+#include <stdio.h>
+
+#include <dirent.h>
+#include <fcntl.h>
+#include <linux/bitmap.h>
+#include <linux/compiler.h>
+#include <linux/ctype.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/stringify.h>
+#include <linux/time64.h>
+#include <linux/unaligned.h>
+#include <linux/zalloc.h>
+#include <sys/param.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/utsname.h>
+#include <unistd.h>
 
+#include <perf/evlist.h>
+#include <subcmd/exec-cmd.h>
+#include <subcmd/pager.h>
+#include <subcmd/parse-options.h>
+
+#include "asm/bug.h"
+#include "builtin.h"
+#include "perf.h"
+#include "print_binary.h"
+#include "print_insn.h"
+#include "ui/ui.h"
+#include "util/annotate.h"
+#include "util/auxtrace.h"
+#include "util/cgroup.h"
+#include "util/color.h"
 #include "util/counts.h"
+#include "util/cpumap.h"
+#include "util/data.h"
 #include "util/debug.h"
+#include "util/dlfilter.h"
 #include "util/dso.h"
-#include <subcmd/exec-cmd.h>
-#include "util/header.h"
-#include <subcmd/parse-options.h>
-#include "util/perf_regs.h"
-#include "util/session.h"
-#include "util/tool.h"
-#include "util/map.h"
-#include "util/srcline.h"
-#include "util/symbol.h"
-#include "util/thread.h"
-#include "util/trace-event.h"
+#include "util/dump-insn.h"
 #include "util/env.h"
+#include "util/event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/evsel_fprintf.h"
 #include "util/evswitch.h"
+#include "util/header.h"
+#include "util/map.h"
+#include "util/mem-events.h"
+#include "util/mem-info.h"
+#include "util/metricgroup.h"
+#include "util/path.h"
+#include "util/perf_regs.h"
+#include "util/pmu.h"
+#include "util/record.h"
+#include "util/session.h"
 #include "util/sort.h"
-#include "util/data.h"
-#include "util/auxtrace.h"
-#include "util/cpumap.h"
-#include "util/thread_map.h"
+#include "util/srcline.h"
 #include "util/stat.h"
-#include "util/color.h"
 #include "util/string2.h"
+#include "util/symbol.h"
 #include "util/thread-stack.h"
+#include "util/thread.h"
+#include "util/thread_map.h"
 #include "util/time-utils.h"
-#include "util/path.h"
-#include "util/event.h"
-#include "util/mem-info.h"
-#include "util/metricgroup.h"
-#include "ui/ui.h"
-#include "print_binary.h"
-#include "print_insn.h"
-#include <linux/bitmap.h>
-#include <linux/compiler.h>
-#include <linux/kernel.h>
-#include <linux/stringify.h>
-#include <linux/time64.h>
-#include <linux/zalloc.h>
-#include <linux/unaligned.h>
-#include <sys/utsname.h>
-#include "asm/bug.h"
-#include "util/mem-events.h"
-#include "util/dump-insn.h"
-#include <dirent.h>
-#include <errno.h>
-#include <inttypes.h>
-#include <signal.h>
-#include <stdio.h>
-#include <sys/param.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <subcmd/pager.h>
-#include <perf/evlist.h>
-#include <linux/err.h>
-#include "util/dlfilter.h"
-#include "util/record.h"
+#include "util/tool.h"
+#include "util/trace-event.h"
 #include "util/util.h"
-#include "util/cgroup.h"
-#include "util/annotate.h"
-#include "perf.h"
 
-#include <linux/ctype.h>
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
 #endif
diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
index 07d11af3fc1c..a54f7e858e49 100644
--- a/tools/perf/util/print_insn.h
+++ b/tools/perf/util/print_insn.h
@@ -5,10 +5,11 @@
 #include <stddef.h>
 #include <stdio.h>
 
-struct perf_sample;
-struct thread;
+struct addr_location;
 struct machine;
 struct perf_insn;
+struct perf_sample;
+struct thread;
 
 #define PRINT_INSN_IMM_HEX		(1<<0)
 
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

