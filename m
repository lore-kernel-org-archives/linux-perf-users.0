Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB153F0A83
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413958; cv=none; b=s6QxIkoii0ZdWpWnfWbnCVAHPItkUc6NTPcUJgeLT6SkEO14usAIRNAgyplJ8O5HKH0QKDPWSLAOPQotA3HMFlRZn6Sq3hrXLouctPLVHQXKpqWLEaBq/c+sMeLInIlxMB66Lbik7Ig6uoUEvn0nRUQxlYGutBC571uoegl+gvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413958; c=relaxed/simple;
	bh=F2CPix35dUffd03PpiODYF/Y/HMWspE7itJrwYnRzhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oVsdcZevi3KpUZlvh0BZHPX/7cO2ODDEXj7SL1jaM7DlRSeIqKtSa4DTy3Cprw0WATNSqGLoHBO7Xxej53z4tQqddyYbxF2160K0jbu2RT0R+5fvbmzRxtKOBpeCEq9P2Ndu9n2xrHnvHtIu+D42pH2WU1ZJEu+ofu/MwhMEkGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekN9WwZe; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekN9WwZe"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e7fc90b1so4363595eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413956; x=1781018756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=amlPmLXVpdwhmAERUmH3g/HD3HbPai/uUl8j2YKLcm4=;
        b=ekN9WwZe9vgxhiSymjEgDXS81b7P/iklusnYLDLAD9J2mHHKujbhioOhrFW+n8GDFs
         QeFEx4KtGuiu1DKwYYsBTqhMgQRntUozcV23KSP5C4vFuLR6qkJlKz1aPJusj2dBUMvb
         1ces9Df/FU9+V9w5Xm6zLSt53awWFkVxMouBbDsmuNVlEWtWTcXf2IsaP59lVG/+RRBG
         LPAddkaVWwwPdYsmMRX+oBw2ekP6qrWyqGPoUD5+XxsGdBqwljqSoriO2Kz71C2W1DPd
         iIQ7Y6Qs8FqcU2D0QTsc+sU2K5XPsX/8gDOQVDR+6XVH4smoEPaUE0Hy05Qy4mYn4u4b
         /+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413956; x=1781018756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amlPmLXVpdwhmAERUmH3g/HD3HbPai/uUl8j2YKLcm4=;
        b=sr5k972MjZQSw6YhmducaQUl5hnuItA+/67sv9AbUHsjQlJcZONFYDap9Z+Zy9T+V5
         E5d0+pePsw0ttUQGrzXChKo+0vVPwDZUtDkQXD41m0zfwaKnktkDcnJRIpdivtxMB0hP
         AeRo1eSJWzd8lsQahCZitTl73c2SDbiJs8zj+2UWWqjwSwSavyCivuOhMkkCHbKRi7TI
         4mnxeYBNL1/UByVbMtYHTFdctW6uU11YakwAucxfOhtonmDxyundLCZfBYM60pm/5IFz
         rWDnhxJcm5H3KcNkKE4AW6Z3UcZDV6Za6Dq2+TrLwrdziADKTcFzl18a1PdTZ+rL1MzS
         RgKw==
X-Forwarded-Encrypted: i=1; AFNElJ8fsIgDyMdf8ec8bL5JtRfv9XWbmYulo+HAHLhsY4ywsZU5iE/L8JLKJqCcjjCejic8s/kboG6v5Bx2DHsSK3Ed@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa0zPA5HMFBJxCMqM4C2Y8y3mTBKb0lRbGD8m2LjFS3AjDD6pt
	oTdpQo943Tppg9lI8nS5oY0Z8637IGhJhp9t/WHPysTwlqFIPO+g0059PLWLJ6SCpe3GmJ1nL0Q
	dWFGSiI7kRg==
X-Received: from dleb5-n1.prod.google.com ([2002:a05:701b:4245:10b0:136:23d8:d537])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b81:b0:137:ed87:817e
 with SMTP id a92af1059eb24-137ed878419mr2517652c88.28.1780413955440; Tue, 02
 Jun 2026 08:25:55 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:06 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-10-irogers@google.com>
Subject: [PATCH v12 09/19] perf sort: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than the arch to determine x86 or PPC types.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sort.c | 58 +++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 0020089cb13c..90bc4a31bb55 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1,40 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "sort.h"
+
 #include <ctype.h>
 #include <errno.h>
 #include <inttypes.h>
-#include <regex.h>
 #include <stdlib.h>
+
+#include <elf.h>
+#include <linux/kernel.h>
 #include <linux/mman.h>
+#include <linux/string.h>
 #include <linux/time64.h>
+
+#include <regex.h>
+
+#include "annotate-data.h"
+#include "annotate.h"
+#include "branch.h"
+#include "cacheline.h"
+#include "cgroup.h"
+#include "comm.h"
 #include "debug.h"
 #include "dso.h"
-#include "sort.h"
+#include "event.h"
+#include "evlist.h"
+#include "evsel.h"
 #include "hist.h"
-#include "cacheline.h"
-#include "comm.h"
+#include "machine.h"
 #include "map.h"
-#include "maps.h"
-#include "symbol.h"
 #include "map_symbol.h"
-#include "branch.h"
-#include "thread.h"
-#include "evsel.h"
-#include "evlist.h"
-#include "srcline.h"
-#include "strlist.h"
-#include "strbuf.h"
+#include "maps.h"
 #include "mem-events.h"
 #include "mem-info.h"
-#include "annotate.h"
-#include "annotate-data.h"
-#include "event.h"
-#include "time-utils.h"
-#include "cgroup.h"
-#include "machine.h"
 #include "session.h"
+#include "srcline.h"
+#include "strbuf.h"
+#include "strlist.h"
+#include "symbol.h"
+#include "thread.h"
+#include "time-utils.h"
 #include "trace-event.h"
-#include <linux/kernel.h>
-#include <linux/string.h>
 
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
@@ -2673,9 +2678,10 @@ struct sort_dimension {
 
 static int arch_support_sort_key(const char *sort_key, struct perf_env *env)
 {
-	const char *arch = perf_env__arch(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_eflags=*/NULL);
 
-	if (!strcmp("x86", arch) || !strcmp("powerpc", arch)) {
+	if (e_machine == EM_X86_64 || e_machine == EM_386 || e_machine == EM_PPC64 ||
+	    e_machine == EM_PPC) {
 		if (!strcmp(sort_key, "p_stage_cyc"))
 			return 1;
 		if (!strcmp(sort_key, "local_p_stage_cyc"))
@@ -2686,14 +2692,14 @@ static int arch_support_sort_key(const char *sort_key, struct perf_env *env)
 
 static const char *arch_perf_header_entry(const char *se_header, struct perf_env *env)
 {
-	const char *arch = perf_env__arch(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_eflags=*/NULL);
 
-	if (!strcmp("x86", arch)) {
+	if (e_machine == EM_X86_64 || e_machine == EM_386) {
 		if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
 			return "Local Retire Latency";
 		else if (!strcmp(se_header, "Pipeline Stage Cycle"))
 			return "Retire Latency";
-	} else if (!strcmp("powerpc", arch)) {
+	} else if (e_machine == EM_PPC64 || e_machine == EM_PPC) {
 		if (!strcmp(se_header, "Local INSTR Latency"))
 			return "Finish Cyc";
 		else if (!strcmp(se_header, "INSTR Latency"))
-- 
2.54.0.929.g9b7fa37559-goog

