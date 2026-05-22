Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48272363C50
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487496; cv=none; b=oBemT/Uvzl0nP/bB1uAZ7KCoxUwVIzcD5iKu28Oynl2G3do/HPzWAAYt9DGDSsQB3RusTCVWMlvjdynpPHXUE/TQGPPlN9nf5MwOp6QflSO98hTkhe0IK6UdfU5sE1bi6WtMHID/38Qx/sZx6OIdCJhf023Vndcfb4VKMXsOrDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487496; c=relaxed/simple;
	bh=2FEiYgRloAO+itB1RzuEhbQ8K3QggZNls0cui+7Sh1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l7xLsbry3euSjhn7SRdcHQlIAPcl7tCS/r+e/eSclC9/O6pQ6fVpKV03WIfvbbKiiLULGFipOD+Zio3wM5cG+Xus6iUHkgjq7pJntjQDq0uZ8pCwnK8GicP20n0Z7rrTwZWNk2gMa6pAgl02uf5KS7beSiJxdyYNH0l3sl8HiYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SzctptTu; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SzctptTu"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f3eb8f3419so7890329eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487488; x=1780092288; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RZckQ+HwuCc0wRxxb6eUJU/ilfr6Pz3oy2PsBDZSEIc=;
        b=SzctptTuHmAAVXX3bb8w1ZSPJ0fc+KFF39mLvZ1BHmiIReEvTp+l+t0ZWwfzZ/v3Sq
         gapyk4kVcleUUZ55XcjoYGmST3fyKep1RkCU+EJ4/1V5hqVawKpVqj+Iuv85xv6QB8uV
         SqOuinUO8BueQeYuxFqy0oCDtv4lVzFY0liglzfXb1QfM45jFnZ0zSgnblK85IA/uDfq
         /Gbey3q+IFPrtCDgFdvLrqvt2AFAtJF2GqJvGd/zE4OMjvrn/82iSBD8Ds3Y8Srq4oKv
         k75+CwI6celZCSsNEo0J4hvAuJNyqMjG46ERZgwt4kUXv4XWqTWDNi746DZ8ZpJb15ex
         7TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487488; x=1780092288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZckQ+HwuCc0wRxxb6eUJU/ilfr6Pz3oy2PsBDZSEIc=;
        b=bj3X+9xOE5kVNWIVFF5U49ZTrCmmZRQsm0oDkfYItvaG4epKrRRcblc/0qBzBun9ok
         GkF9JCFJwnSJlmmnibgjtdmTAm+hg42AsERxCPUDLGOcG4ARJQsGJuuOlG4KHyRd6HYr
         0dBMXV5EYYJIdmwoORumwBnSR/FiHfrhN6IUNqu5p1NY+AXx+tXDSpQatAstOqS3FQiS
         SLdRNC0CevIi82MPEitgtmtfcs/BMmMsOv+ALSc+ft3CKl6qBXbDt8UK2IVk5q07CJPh
         CpRw9NGPfDvS3LpVdX6BOjiIORgjJEIFTM8vSIsSNIgnFpCO91K5GUhPe+RK4BaSui60
         lBNA==
X-Forwarded-Encrypted: i=1; AFNElJ/CeTkxP/wqceg9F7iB9n3UV6hBGmB9++uo+Z2gr5XnVhXwwgGgSKuOvojAB+9eOCefl7+mje5QQ9GJjw/HsbQ7@vger.kernel.org
X-Gm-Message-State: AOJu0YxlnTZnqd+qz3DsvEKaArfsHUFVTNWs/J1VwJ7xNbrs5Vv6Y5CL
	kwZkpooVNqIHCdLbVKvrJpVmD4VOc0OICoGzEG14AZX7g2LwkvgVyxzAptOyZwfLYt1xG9GWUJC
	45Un0l/2ROQ==
X-Received: from dyaz19-n1.prod.google.com ([2002:a05:693c:6393:10b0:303:98b0:efec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:650b:b0:2b8:5159:eca5
 with SMTP id 5a478bee46e88-30449024b3bmr3046039eec.14.1779487487711; Fri, 22
 May 2026 15:04:47 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:15 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-5-irogers@google.com>
Subject: [PATCH v9 04/23] perf script: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
index c0918006e0ab..e330ae7f725e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1,75 +1,78 @@
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
 #include "util/unwind.h"
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
2.54.0.794.g4f17f83d09-goog

