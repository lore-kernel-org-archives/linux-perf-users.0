Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A276C1F2B8D
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767803; cv=none; b=SH70SAk3XJJd0oAilhtS1+ZhG57DA3Lm+iBR0tHfjcasgMChzvY8c41KaUpqXHVy+cf7X0aqziouJ680KgT3MCdaXDMWwFg6n+E1lUnWxJ56N4Dg7g+lkOk1AUb9scKP23MWHufGrcDJ/QsUjmHBdU3yhoUHhk9mJxv7WctFY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767803; c=relaxed/simple;
	bh=d95RN7/rMJzrpe1UoXLER23VbQTmBzaPGsXRYVYoWgg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XbxIUzakiTcpjCvX01I6wvpw6l9GgXM9h+MJ581CXJpF2yC0hn3trVT/O7xBEIz5lw8/K40LGJWQKhQLogYy2h83vyok5v9QqgGRVjGqHYvhXqfPm1wjJfIr4aezBfOY+9juUuSUIosrBk7oZDhDERaoH26HBwGHe3gfYvewSt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LTe7jf/1; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTe7jf/1"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12df9e440d3so2899965c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 17:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767797; x=1778372597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22j8DoF2fXHm+jGHFBjOBjrvQEypyYf+IRlyHBjQD5I=;
        b=LTe7jf/1QwwTcq36henFTWK9JftSDZjimq6F8m7MIncX1q3HEUR70vzMv5CVFzqMMU
         KBx2XUBi+ooEB7mCnWbG0697ntMEDAmrnyVMFSlQRAuGMN+Zb7gcB31bPHVm2lDdANDk
         OZQsrUbFI+SJUXco1EW35iKy/iOThveGvvuP1VinxIxigTyHm0pRdsGq812TvrBKb7HL
         m1Ye1H+6bK8KWVHkOxnEQWJYQZ4b0fJDsMam1paea6b2EtnL8Y8j5pEdAQtvSynqWvXL
         GCHt4T01oC9DfJ5ISfs6nyyo2RO+J/UJX6FcMGwq7NFq9X+2agHZXq0YvRhymsYy4Yqu
         ttWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767797; x=1778372597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22j8DoF2fXHm+jGHFBjOBjrvQEypyYf+IRlyHBjQD5I=;
        b=dAgQOwqcDyD3w/517Vb80tsl6hSrO9+DA4wjk7d0IzGwVPyMK4pk9HPDKYEZsrOpTt
         atpImRk3GUmKi03d+dUXHOThpmeUg8t9PlcFhQVc/eFYVlgwW5gi4nUDtp79s2h8GvG8
         juXfQRff6ad22hEY8HXtn3tAF03m3+S3x1Bj8sRXy61W8JAYQlTXC0NNiWA/vdR91FaE
         8tVA1IYVD2bwAoDr0fGds/f5GEZ/Y59xf5m5FMi2kDpaQcvCdE5SXcnnl8PGcXyWfBFs
         uFgoNmGP80bu2hmhXAzo1+KnPHu+zDhtr4TSgeWmIHEcQNyq8Ya5qv/L9cWfQKeKmEIk
         f7yA==
X-Forwarded-Encrypted: i=1; AFNElJ8rYz1V6FTmUJw3dQo3jrGVpgq2/chV7aYiIfGnwy+/msQLPCUFL3f4UuW+bdaUpeV/E5coJ7vT3nvt/wQTyK6q@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEV67z+G+6C/ay34pQBAr2OPDhyHT/QetLuqC6P6ShKdE8Rlq
	xlWYIvaxcFCqLUpyd0qtWcEorl2xOatCknVxmtqtZnmsrkJhX9JcEgzd+FMo4B99SEo22N2Aj0j
	kzV2Hep0JgA==
X-Received: from dll26.prod.google.com ([2002:a05:7022:21a:b0:12d:b48e:8597])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:68a1:b0:128:dcbd:e27c
 with SMTP id a92af1059eb24-12dfd823241mr2253597c88.20.1777767796555; Sat, 02
 May 2026 17:23:16 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:42 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-13-irogers@google.com>
Subject: [PATCH v9 12/18] perf c2c: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than arch string matching for AARCH64.

Add include of dwarf-regs.h in case the EM_AARCH64 isn't defined, sort
the headers given this include.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 72a7802775ee..c55cab53531b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -12,41 +12,45 @@
  */
 #include <errno.h>
 #include <inttypes.h>
+
+#include <asm/bug.h>
 #include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/zalloc.h>
-#include <asm/bug.h>
 #include <sys/param.h>
-#include "debug.h"
-#include "builtin.h"
+
+#include <dwarf-regs.h>
 #include <perf/cpumap.h>
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
-#include "map_symbol.h"
-#include "mem-events.h"
-#include "session.h"
-#include "hist.h"
-#include "sort.h"
-#include "tool.h"
+
+#include "builtin.h"
 #include "cacheline.h"
 #include "data.h"
+#include "debug.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "ui/browsers/hists.h"
-#include "thread.h"
-#include "mem2node.h"
+#include "hist.h"
+#include "map_symbol.h"
+#include "mem-events.h"
 #include "mem-info.h"
-#include "symbol.h"
-#include "ui/ui.h"
-#include "ui/progress.h"
+#include "mem2node.h"
 #include "pmus.h"
+#include "session.h"
+#include "sort.h"
 #include "string2.h"
-#include "util/util.h"
-#include "util/symbol.h"
+#include "symbol.h"
+#include "thread.h"
+#include "tool.h"
+#include "ui/browsers/hists.h"
+#include "ui/progress.h"
+#include "ui/ui.h"
 #include "util/annotate.h"
+#include "util/symbol.h"
+#include "util/util.h"
 
 struct c2c_hists {
 	struct hists		hists;
@@ -3202,7 +3206,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	 * default display type.
 	 */
 	if (!display) {
-		if (!strcmp(perf_env__arch(env), "arm64"))
+		if (perf_env__e_machine(env, /*e_flags=*/NULL) == EM_AARCH64)
 			display = "peer";
 		else
 			display = "tot";
-- 
2.54.0.545.g6539524ca2-goog

