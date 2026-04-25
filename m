Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651DD285C8B
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139355; cv=none; b=P8ZnPtkQLvYZzYJ3zPCJ/NqxcBHlug5qzpJFTIqKkO1S1lCvK3js0szUzk6U37pWt3oGeYmpwfkuWorKbGiDzTeavF0HhEna/fukccd3ZrLOx6iIZbQQLLqO0e7u/mefp57nZkF94DMsijyHxn9NqxYMJD7PCV5EGoK6L7flQlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139355; c=relaxed/simple;
	bh=QHTZx5MPgaaZQHiX00rro2INAj+zmier+jw6hcgWdKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aHaLGLCdw5SEpHz8g5b7fG3smZ0G6vekTNVT4fpl2K1iV3ncdiFCpfhNyWFy/I24U/OJ+mFSvp/gj2FHaV4Yh4XFoqbgH4M3pRzloiocmKUEKiH0zTxt2BocYt/wlSdz+Wbd0IVMqUEgLHqR/pFW00q7lNgHVTauBSrRRU9tEUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dm+z3woT; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dm+z3woT"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2cc75e79b97so24050363eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139351; x=1777744151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PdL5J++jQFS0WI1Hq1Y43G2dZXRWh1hnOIKdQUKwLiY=;
        b=Dm+z3woT/L0ZoKhOoWavjYlgLftbSqsUpfUwK/Ae3mLVe+MBpFnYKI5kAad4DasVPR
         Ph28p5R6t4CdfK38wmRkI55Hh8DIdXhumfQFOkKpPvrVaiC4MySOL9OQTU35Wmpj6Js+
         rTeIbr0c12XAaPJjgTB7sJhVxT6iD00CJUMVDF2Kl4QZwG0EmEgTiq2Ch+Ja+zMUtg7R
         8hF20Mc6AVnakHUiGtAaHqy+Q2J7lwuSPMoG9cLf9+K/bKbrxn/tYPrfh8SMC2sZxZzS
         4JKStmcjOdaBBMgVIq/vGewOOterB65Rz3/+bGYL0qblYXuJA1z2DVaxuyo4VCPGFd+W
         OukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139351; x=1777744151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdL5J++jQFS0WI1Hq1Y43G2dZXRWh1hnOIKdQUKwLiY=;
        b=bmr4YOzPLggRp+xSiP1lxy0lOa9kyGFmi1jumqN/6P5/XASZ9cBU1ofAHnsG4hv6P1
         wl6PMg/WxpTLRhPuLhCSW6JFGRBgSMtNYtc+wPF83m+WKEIgA2QkXoE4UYCBkb0iukDl
         eJaXBJdHIs5Jku4dDRjwu4FHiw1LpeN15GSLuX+Z+mDdshPCm5Bxu0d8Zsv+ejGR9Akc
         aLVWneHGirRVMZtIfEk9fLMBX7GGPA2UR6z0lyKqSY6cprCAu04DWFg14BTlmY4Pj55m
         kTd5FuXBxuiC3Un169LA3ZlReg8DLzekZw/Z2tWBcWDsdx6Mfr6hnhgzY34U1xB8mSg4
         Z5Fw==
X-Forwarded-Encrypted: i=1; AFNElJ/zL2XaMzF/SF9BeG0HKB4oNvftfBejk8k8yrOHOiXsL1VuLOta30cRS++y2U5ZAqfDry/EgB8vhk+42UTVPPu2@vger.kernel.org
X-Gm-Message-State: AOJu0YwwoqjwP2jYz7Bf1uTWIDkgY+M4+51QRhbuwxWYS4dP0IYJg8Uu
	WPF6EF+QRR8HqisVpqaFYay5oP6cBay6ytuJ/ADGYUM7SkFyQ5g7gKRGgrrq/BwipdjqfBkhzkP
	mntnXegKgxg==
X-Received: from dybbs6.prod.google.com ([2002:a05:7300:a206:b0:2df:75ae:2719])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2392:b0:2ce:f3d7:221
 with SMTP id 5a478bee46e88-2e478a2f29cmr22827355eec.17.1777139351325; Sat, 25
 Apr 2026 10:49:11 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:03 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-6-irogers@google.com>
Subject: [PATCH v6 05/59] perf script: Sort includes and add missed explicit dependencies
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

