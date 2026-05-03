Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA14201113
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767791; cv=none; b=Tb5J+/h1jK5yML74+RBkpX4roy2vNl+a3NIwPSaARthcE6Zr2wXkQ4d8jV/wGyP+O4kpltWBpZC9JkXxLhPYnGCpuLAet9RlttEEprne3mNbs7rRaC/QcN12afMmqdiqYjvyWj9gLt0LsuM6vnAwG/arEt9chE61XOthdf3SyvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767791; c=relaxed/simple;
	bh=6xq1XvZTYkhssOORuD8+pN+gvzmbIFzNJbcBBfSr9dY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UoqWcbNRFHGpdjaETVMMOe1c5LsqUV7pbKzbE82PpdbQVsP+0WBQKQY75nOEDzE67oUuyutS9JkG3K3WAVQDtnWxSQ33gKbwKCA1JaHkbpXTdcPdbY4LU3LQkzAjl6FhqetvKxEjZI6cIST0yvoSvlqySm2P3Ni0+CtS7Q/+9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JlR5Sme9; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JlR5Sme9"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2edfb206494so2629879eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 17:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767789; x=1778372589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkO8i+3RSnAMWHfyM3s9GsrhLkxGMQAxj7N6Sn6bOa4=;
        b=JlR5Sme98+/ZqwN1B0KJel9NcQFfNMXtUoqX01qnzhSnp/XEi81uHK1+0hH3ORFJ9I
         2i8yOIKmnjpM4RkjeK7VrjlEBetJsROJ6y99isQ5u4iWo2EHA2GvurcPOt6eNGtOJ7Yg
         tX8to1IjMyO4+XnnAbGv44uubV+aK1ivwo0QqgKZxhNIUmaPxssHKRz8mbtyiui9Qtf3
         HkHwJ2q5Bfob4V39+eezHlwIYk3phMbWBROvZExzaXCXRkChYSifWtwly9m6QegyGMM+
         dJ2iLMEH9Ke/zj0VJHN0jHLunZpQRS+YI02U8eYYdZMmZ7L9xftHhNB8NSPnXw0+3Kla
         nxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767789; x=1778372589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkO8i+3RSnAMWHfyM3s9GsrhLkxGMQAxj7N6Sn6bOa4=;
        b=X7d/tXPx1WRjYng4jxsU6WZKq0KeLQBHqClNZE0WVPsXWy4bD4j746RSrnqAaDvhuu
         crPzwWmCflQObyUc8/kAuQAJy/Coa/V/Kcla8sbxiQAKYjAurzlkaSrl168vsJDmJJ8G
         TaU25Hmyer4E74jQuKp+jSy/VKtoROFF3aTgAYWMonHGtb6xoAwTMVXZQdFwgaeJSvvx
         cLt3eRuiRwHOilbPUJYNK9XlGpAGboUyV1U8sK47Fag0ksJsOvwrTuZAMr/4hg4EHG9e
         4XrjC3RfPg+r9OFWnsJEJiVqB/sM6xIxbBDVf/BeyCNm0co+8LsqnIHK1hA8CZCGycdY
         ed5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8e75P+d1dRnlSzS/N7MBm6gvBpzefQ/tM7pkEYg8exx+C62TIauM+PVr+j5AZqVXrBFKrE8KtIIopKtVuNqwtF@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXv5KyCFJEe5ioduGP2D9bFhA1y7DBGHInnmGQNKicGtlQvdj
	Q3ba8WRhWukAy66CKTE/pJQ3ixPHf3Fo4EU5cCdEdKwexzP+eb1ruVIVM1qvk/g/tlL0MaTALNP
	sMDKm6u4pHw==
X-Received: from dlww3.prod.google.com ([2002:a05:7022:ea23:b0:12b:eb91:8863])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e1e:b0:11d:f89d:85a0
 with SMTP id a92af1059eb24-12dfd81a598mr2313415c88.27.1777767788829; Sat, 02
 May 2026 17:23:08 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:38 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-9-irogers@google.com>
Subject: [PATCH v9 08/18] perf sample-raw: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than the arch to determine S390 and x86 types.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sample-raw.c | 21 +++++++++++----------
 tools/perf/util/sample-raw.h |  6 +++++-
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/sample-raw.c b/tools/perf/util/sample-raw.c
index bcf442574d6e..be998c713a0d 100644
--- a/tools/perf/util/sample-raw.c
+++ b/tools/perf/util/sample-raw.c
@@ -1,11 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include "sample-raw.h"
 
-#include <string.h>
+#include <elf.h>
 #include <linux/string.h>
-#include "evlist.h"
+
 #include "env.h"
+#include "evlist.h"
 #include "header.h"
-#include "sample-raw.h"
 #include "session.h"
 
 /*
@@ -14,14 +15,14 @@
  */
 void evlist__init_trace_event_sample_raw(struct evlist *evlist, struct perf_env *env)
 {
-	const char *arch_pf = perf_env__arch(env);
-	const char *cpuid = perf_env__cpuid(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_eflags=*/NULL);
 
-	if (arch_pf && !strcmp("s390", arch_pf))
+	if (e_machine == EM_S390) {
 		evlist->trace_event_sample_raw = evlist__s390_sample_raw;
-	else if (arch_pf && !strcmp("x86", arch_pf) &&
-		 cpuid && strstarts(cpuid, "AuthenticAMD") &&
-		 evlist__has_amd_ibs(evlist)) {
-		evlist->trace_event_sample_raw = evlist__amd_sample_raw;
+	} else if (e_machine == EM_X86_64 || e_machine == EM_386) {
+		const char *cpuid = perf_env__cpuid(env);
+
+		if (cpuid && strstarts(cpuid, "AuthenticAMD") && evlist__has_amd_ibs(evlist))
+			evlist->trace_event_sample_raw = evlist__amd_sample_raw;
 	}
 }
diff --git a/tools/perf/util/sample-raw.h b/tools/perf/util/sample-raw.h
index 896e9a87e373..c8d38c841c8c 100644
--- a/tools/perf/util/sample-raw.h
+++ b/tools/perf/util/sample-raw.h
@@ -2,7 +2,10 @@
 #ifndef __SAMPLE_RAW_H
 #define __SAMPLE_RAW_H 1
 
+#include <stdbool.h>
+
 struct evlist;
+struct perf_env;
 union perf_event;
 struct perf_sample;
 
@@ -12,4 +15,5 @@ bool evlist__has_amd_ibs(struct evlist *evlist);
 void evlist__amd_sample_raw(struct evlist *evlist, union perf_event *event,
 			    struct perf_sample *sample);
 void evlist__init_trace_event_sample_raw(struct evlist *evlist, struct perf_env *env);
-#endif /* __PERF_EVLIST_H */
+
+#endif /* __SAMPLE_RAW_H */
-- 
2.54.0.545.g6539524ca2-goog

