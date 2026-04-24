Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA133D6F7
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049281; cv=none; b=inN3JixjiqtlktGe8J8ZSYkYLwlbHxbB3K46J+m7LbPAh1tCwTVQREKOv1PnAw957Efj1knVp8NSqDurxTAJS9XzGXatgh8nd1U10y6ZSR06E2F+wZPjXlbE+G8ghJuxO3ESgrErfYk3ryfE4gws6HWyJMk0GCf4A8bu1pjR4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049281; c=relaxed/simple;
	bh=QHTZx5MPgaaZQHiX00rro2INAj+zmier+jw6hcgWdKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XWeo2JW+oJhCTAM3L00fyFoYYHEThRe/dMkWiAp6GB2s8/n08sKxqxX3/LAdjkYf+dvWtrj/1CRFNM5Xppu7vM/228/Sh8+37OSucFkdhxrKUvQ7I6fvLMSHLgK224HqaALp6CcyynFgNzZUb7yKj7M3vjvPWMTZLtcjfxCX+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/gmfkHu; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/gmfkHu"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2de07c12745so19743376eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049276; x=1777654076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PdL5J++jQFS0WI1Hq1Y43G2dZXRWh1hnOIKdQUKwLiY=;
        b=S/gmfkHuqk6sgeutp26y5tq/iUYWhpZxYrnzB72FXsHZAMbBzOnVwtxG+yoSZk62Ig
         eQcG8X97mYVaGMhe5SySV3H+Mt9Bs5jHT08/3yWGx4aUqol36XAi3AOtseTeC3ir+XeI
         cNc+cO3/u9X+oiFL3eSB8tH/A5S73VpQ7OrdaKnAGwL08qdPWFp9eXlm+5X3SiX8a0t1
         5sfvh9FMKoOwQlMhJ7bPpqYMI2oFcFP3bmb0bWnayAK6upzDzTFeOk43uDZHClrDZE4i
         tO0tp8S/l3PlVjoSemJ4UPAM1l6fCrZOX+JjkxGBa2k2iy0llVj25jzBGwxZ5nsU7tlx
         J59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049276; x=1777654076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdL5J++jQFS0WI1Hq1Y43G2dZXRWh1hnOIKdQUKwLiY=;
        b=aRylulVdyEeh9ekNyBQxAfl452Ikm46QHZFxmyZpyXUW6dms54TbQ80YLukJa//OaU
         5aVhGw+3T/F+ylmKNx38mpQSzcAaaPtGr/uQHUWnt0JRYlwqbeQ0v1X/owYZmqoQlySZ
         j7P2D1FuKdv02t4qgbsTgOONx92wgqs/FQDTpiHKMDDctdPtPxLbDMk7IMN7ObQq7h/a
         VYD3I1HL7jHaCvzPP50XqfUVFiH62ewIseN1aEDX/8Th5P6PNhe2omqQlILeTR1uaLFU
         xNzE+IYq4CXItnJ6tEoSALZDGOr0azlYboRIZdDmrlpYgbqcI++cPvTUQYZbSQW7kzTF
         HTAA==
X-Forwarded-Encrypted: i=1; AFNElJ+ztAEbCi5ZtCGFOv4IIQamuoiVmAb5daTlk2OP1ZXW91as2V2SgotsidEjU/ZUfLwWKlkel6ztV9NXI0i+e2dO@vger.kernel.org
X-Gm-Message-State: AOJu0YzrJe6S65duBfCTYfgk6RLTxkvzy7k+5TUHtam0pJZ7vEIEoQQ9
	RD6AiNBHjXl/TWE3hnlJk0uVto+oUod5ON/cIFpsZqHryEpbu6tbsxRl9KKNA2ODiD9u6SAZo/N
	IKXJV2cQmqw==
X-Received: from dybmf46.prod.google.com ([2002:a05:7301:92e:b0:2d9:3c6b:a26b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6c27:b0:2da:1a81:5ae
 with SMTP id 5a478bee46e88-2e475b3994cmr19522429eec.10.1777049275591; Fri, 24
 Apr 2026 09:47:55 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:27 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-6-irogers@google.com>
Subject: [PATCH v5 05/58] perf script: Sort includes and add missed explicit dependencies
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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
2.54.0.545.g6539524ca2-goog

