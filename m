Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296153F5BCB
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413966; cv=none; b=FSgOMRSiyxOXjyGejpha4IpCcEoOzsnv9pxj/rkZdFbft3Oo1JiRNYEKR3xAxdbxBm2lQ5ge8U4AZA5c33zqcP5EdBbZYPcn7OyBLG1ORbHhirz+TLtPbo1mM959kFuEtuHg7n4RAKk5Xib9qv0rEqwropqviNDErXn2sXmNpcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413966; c=relaxed/simple;
	bh=bD79XLC74sOKkh5WkeXQ/YhX86xrlFEHMGX/zIPcIz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YHDT5hzwYP+R4Axyiy3xfnLPhFKaGvvdszwLRKhlc6deQdPFOUjq9gab9utCaP+WP3cU4/t/tcwDS+23eIsdukNQmggY4vaAndODDHxEH6xINgl279OiADjnOLX8BmUJT3GICbzmHkimVO+gAoGuyX8KyqnlxCXrmYEco6/cwKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Km5DRfsv; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Km5DRfsv"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304f1820babso5367865eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413964; x=1781018764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CY84B4INAWbD1Cf/mmc/o03IBqOHUDgX8UA9AM+aba4=;
        b=Km5DRfsv+f5xxRu2ihHNHYWx/KUOA7T7M55QEisEBRe4HjTvX5NL8Ed/hetGsP3Z5g
         y2nLh38kQw6nUfqggRizl5CDUP9OuEh/eLJlPzD8RTA/anYniKcXUTUiC21qCGjG2E0o
         W+KYIxYf4a5riLW9MWP4+8WSbiUAtfLhypldW/D8BZaF18gsbwNZdgOGtutpuwYRMjHs
         J7y5lLpDosLQyE+4fVrqGGNKt5jC3EUQ3WvMXC9AbAc+mbxvcwKF4PkyXrbUic1dXSVp
         rgMEs1Pf619D5KOT9KJs0+L/Uh7ufSNeYr00UTwkUAIH/NUYxEfSG1UrIBeXkgQdou7j
         FnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413964; x=1781018764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CY84B4INAWbD1Cf/mmc/o03IBqOHUDgX8UA9AM+aba4=;
        b=hiOWaLjWFXCM+MgUqhciKDEKzqYVY0CwVwrMaSv6VZwO2mBaRwda7RmtuNwlt9NkEO
         zqlZUJcJ5L00iru2u36HfixLnqavN+un1WdwiFpL7Hec/yo5Bci6tLr/ZTs70gmCobiO
         9onHJlmVK9e3mCkLFPs6NCXMrnBx+mk20FbUCotFutuBBwq7GqC54yx7jJ8b5FxbEYcF
         vJj19uDkr4z6X77SxniYBJbe94QDFh/OEyMf5LzB+0f7VnOF8FaIAPZQKGixPR2y3DA5
         kFLlAYkuUE/gqJujDBGHUz0KYXoKSc24XOk4i1085dQGjBk0mENJjV1kijmh5A9BVmzD
         A7iA==
X-Forwarded-Encrypted: i=1; AFNElJ84kue99StGpgMBVNr2e123+V7ci1cuU6GqXhEaMXF0qgcjlQcJVliCfTgbtQ9drSQkPSYK+QFhjCAM/0pvdYfb@vger.kernel.org
X-Gm-Message-State: AOJu0YxC3RSlVaGaFijdTlcMn4hu0n0M9XFXffqWDiQs8v6gpBAFzfEQ
	EGEzibz9p62ufgF+WScdzUm/Ks464JddhrJ3K5yvA4E6O42rK3RuzmNOQp+Zh35kP56dbNsHlz9
	Xpt0PUsjHPQ==
X-Received: from dyclw21.prod.google.com ([2002:a05:693c:2115:b0:304:3262:502a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3b05:b0:304:df0e:9dba
 with SMTP id 5a478bee46e88-304fa6a755cmr7709352eec.31.1780413963910; Tue, 02
 Jun 2026 08:26:03 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:09 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-13-irogers@google.com>
Subject: [PATCH v12 12/19] perf c2c: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than arch string matching for AARCH64.

Add include of dwarf-regs.h in case the EM_AARCH64 isn't defined, sort
the headers given this include.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 36f386949923..def5ed395f17 100644
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
2.54.0.929.g9b7fa37559-goog

