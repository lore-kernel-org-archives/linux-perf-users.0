Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968AD37FF77
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960620; cv=none; b=raSay3/mCWHk69MScX529WyCh03PybbzUpTVo40VSSMQN44QBLWj/hqJiIyyrnZuct2Wre5ToUiGa5OtPv+2M5VaLHdyfdmskbfLXd9owbWyIJs3QLJFbsySCi7KmTl/2KLXBFnvMqeOulZhVCO8jfTvVYaUOSYlHz0F9JUaBZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960620; c=relaxed/simple;
	bh=hrAjNolC0iaq3aSVv4WnJjdjsDXqgYkOVIUqOStvgy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lnQOwP9YMSNnA8t+cAzYcuLxUVbzBVYtglPc4Bjosqm1ubm8rMOinyiJFHvuQjLGDjSP92g0G5mdzDWA7OSQIato4fInSdH3e+6xbh07yjjHi/mzovXS5gVbEwtheEJCiIcDGueEK2tyWvbLrxxhsUmpUYGMZhWbzWWpVwn+h7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UCDunaj5; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UCDunaj5"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2cc75e79b97so17067702eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960618; x=1777565418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5m9P0eQK13hDDll4bE92a18P2ZsPdXyB9r7+GyZ44Nk=;
        b=UCDunaj5YtxpTRsP7mTkm80g3e05N48/0hKQOPaCR4uD4LQyabqHCdjlqGQnnw2luI
         2TFI5xkf4/RThm39oX6owDUY7GSHYvKV3aaCPvhFtSNaxqixGb+J58c4iZT+eGHricgI
         ucGcjhiMLYc5eAl+NKOsLGSvYfcIrUegkqabkMdAl9YDtx82ew+0EgQe887ZU3vdE+sr
         44ZKPliBR2tm7GZyWlwYbjA+ggQuN8cCHe4nX3XeYDmoApVENrNqkyQcGV6mz50mAjUP
         ptgvmmQdmC4CsCKFmWJNKN2KmINxwuMlBaCw0f87E3kMa4xxi4tcsFbqoSqDypLrd80y
         nrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960618; x=1777565418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5m9P0eQK13hDDll4bE92a18P2ZsPdXyB9r7+GyZ44Nk=;
        b=EwWP40/9mwcRRxO1kkWHmxPhpN5Qi3d1O20b3T2mRaa8U+kilqz5Idpbsf3ULbuDop
         RY4wQLFiGiZPS0zzTZ+WTjJ7WEG/Jj++6iVJXqpUyHtcN4Ul9WgWVe5Y78kBWPsL2Bfm
         7tOF0b4P9MF4cSwTdMyqZ5PmroLsIC+45UOvIYbKpXcDnIDDyqRktmIH8GzD9f11wma9
         OvcC4q+NU54WHRpMhEi++xbIukKijcOSCrmcNK9q17DG0HJDDsiRbjIKNummA6XvMBPd
         /iy8kUW21F0jqkQJVrL6OeZHprQWzRzFKgBNUjTv4I0anACrpV4ABKw1CDqRBk6QW3pl
         8Rfw==
X-Forwarded-Encrypted: i=1; AFNElJ+BQKCCGMEQMgoOFPiOQfl5baATRkRUS0h6AXfBohZRSe8NKZLsiYgv5JWrNhwDy/LxJhAJU937Zkyemj1JK+fI@vger.kernel.org
X-Gm-Message-State: AOJu0YzLjgoD9ktOWHOXxMUUmB+xOxxNv0FC/qF6VpUed9vjz9BcI6gx
	XkTClLPtfL56uYpoQAJgPpa7QEBaBYEw4FOENR+m6jpU8uJy+T1LBFebfyWgiJHwb3Ubt8QArsy
	zpo3GnuVhnA==
X-Received: from dybss20.prod.google.com ([2002:a05:7301:7214:b0:2e5:ce71:32c4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:bc9a:b0:2d8:c521:c157
 with SMTP id 5a478bee46e88-2e478a2f0b7mr14885332eec.18.1776960617059; Thu, 23
 Apr 2026 09:10:17 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:11 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-5-irogers@google.com>
Subject: [PATCH v3 04/58] perf script: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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
2.54.0.rc2.533.g4f5dca5207-goog

