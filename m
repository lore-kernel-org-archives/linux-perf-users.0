Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2127BCCA479
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jul 2022 16:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiGRQnW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiGRQnW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jul 2022 12:43:22 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89078F5BA
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 09:43:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e559f6840so1980077b3.6
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZrBjT07dxIxrj4xoTKfpB0Ct6tpCXJxcmpau/yJexmM=;
        b=S6zHrx6t+ZkJpKmrvIJhWRpogS8H62QCsoKZ0hAUqXZsejr12rXHvEF1MonOtNg8VC
         Vjo81NGOQPl5UQSDtPau54CUtopvPA2WDke1UO3K3zjA+R3oiVONmJO77SPJNmip/crl
         sfbd+eYL6KQqY2xPNJUvSFGYIHT+Kc/QHSEeGJ8hnR65spWMpga/l+fJdbdTlFfCoMhd
         9OqXE3Aedb6LxuGLGE5dtLGIctTSDw6hRKgNSbCCcPrXfh+2MFrTTNNZtOB0ixUK7NGm
         i8nTnKx819GhPtgxxW9GIrV2WGahtpGnOIbpPmaqajif6VFVxbqp785k9+4HvmxMps+K
         ATFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZrBjT07dxIxrj4xoTKfpB0Ct6tpCXJxcmpau/yJexmM=;
        b=FpJxJ8kct4wW0uhnYI1KIigcf/HSZlx3dQVzQ6mvGPYDOo9L1KEtstIFO/g7h3vl+0
         NE5JV2BW/3Mj452mx2NKEmwM2enb7eVDvjf2vX8TYaMsOpqn6Iz0Uwo1TOU/fHk07vq6
         ExGX9miu8hLsp0oZfLKRQvaV7kClLaWDrcCKPKgrSxGXR1zs/9co3bdTVLTK0JHeK3jd
         15bHxg+XlmYrioNW7K3dSLceb/fT3+xCJiZ5Wy6RJVStDEwITbaZZ6T4U7DiNzQ7YOp1
         j9LO5chBPkWcbme0y9Ndi8HVFOGFIjfEQYnqua6WZHUNVxiecIUL5MaxalVhU1DTRAGR
         0ReA==
X-Gm-Message-State: AJIora+l3QFJQdMdP1qneHHjz8aBn+KOnck2oxRkSsgAOmr9MGSXOyEd
        q6VblkbVFaEtqfx+6HkVF3yEkVTl14tN
X-Google-Smtp-Source: AGRyM1uxrBpupOE8dccxuc9QlExJA45WmzxrSVukJNRZwiiOaKgZ7ZscrIWsx4Gf/Z+6d5SxcWfQDnTvDe1o
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:922:90e9:167f:1ccd])
 (user=irogers job=sendgmr) by 2002:a05:6902:4d0:b0:66e:4fef:cc3f with SMTP id
 v16-20020a05690204d000b0066e4fefcc3fmr26060990ybs.20.1658162599830; Mon, 18
 Jul 2022 09:43:19 -0700 (PDT)
Date:   Mon, 18 Jul 2022 09:43:10 -0700
In-Reply-To: <20220718164312.3994191-1-irogers@google.com>
Message-Id: <20220718164312.3994191-2-irogers@google.com>
Mime-Version: 1.0
References: <20220718164312.3994191-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 1/3] perf tsc: Add arch TSC frequency information
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The TSC frequency information is required for the event metrics with
the literal, system_tsc_freq. For the newer Intel platform, the TSC
frequency information can be retrieved from the CPUID leaf 0x15.
If the TSC frequency information isn't present the /proc/cpuinfo
approach is used.

Refactor cpuid for this use. Note, the previous stack pushing/popping
approach was broken on x86-64 that has stack red zones that would be
clobbered.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/cpuid.h  | 34 +++++++++++++++++++++++++++++++
 tools/perf/arch/x86/util/header.c | 27 ++++++++++--------------
 tools/perf/arch/x86/util/tsc.c    | 33 ++++++++++++++++++++++++++++++
 tools/perf/util/expr.c            | 13 ++++++++++++
 tools/perf/util/tsc.h             |  1 +
 5 files changed, 92 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/cpuid.h

diff --git a/tools/perf/arch/x86/util/cpuid.h b/tools/perf/arch/x86/util/cpuid.h
new file mode 100644
index 000000000000..0a3ae0ace7e9
--- /dev/null
+++ b/tools/perf/arch/x86/util/cpuid.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef PERF_CPUID_H
+#define PERF_CPUID_H 1
+
+
+static inline void
+cpuid(unsigned int op, unsigned int op2, unsigned int *a, unsigned int *b,
+	unsigned int *c, unsigned int *d)
+{
+	/*
+	 * Preserve %ebx/%rbx register by either placing it in %rdi or saving it
+	 * on the stack - x86-64 needs to avoid the stack red zone. In PIC
+	 * compilations %ebx contains the address of the global offset
+	 * table. %rbx is occasionally used to address stack variables in
+	 * presence of dynamic allocas.
+	 */
+	asm(
+#if defined(__x86_64__)
+		"mov %%rbx, %%rdi\n"
+		"cpuid\n"
+		"xchg %%rdi, %%rbx\n"
+#else
+		"pushl %%ebx\n"
+		"cpuid\n"
+		"movl %%ebx, %%edi\n"
+		"popl %%ebx\n"
+#endif
+		: "=a"(*a), "=D"(*b), "=c"(*c), "=d"(*d)
+		: "a"(op), "2"(op2));
+}
+
+void get_cpuid_0(char *vendor, unsigned int *lvl);
+
+#endif
diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index 578c8c568ffd..a51444a77a5f 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -9,18 +9,17 @@
 
 #include "../../../util/debug.h"
 #include "../../../util/header.h"
+#include "cpuid.h"
 
-static inline void
-cpuid(unsigned int op, unsigned int *a, unsigned int *b, unsigned int *c,
-      unsigned int *d)
+void get_cpuid_0(char *vendor, unsigned int *lvl)
 {
-	__asm__ __volatile__ (".byte 0x53\n\tcpuid\n\t"
-			      "movl %%ebx, %%esi\n\t.byte 0x5b"
-			: "=a" (*a),
-			"=S" (*b),
-			"=c" (*c),
-			"=d" (*d)
-			: "a" (op));
+	unsigned int b, c, d;
+
+	cpuid(0, 0, lvl, &b, &c, &d);
+	strncpy(&vendor[0], (char *)(&b), 4);
+	strncpy(&vendor[4], (char *)(&d), 4);
+	strncpy(&vendor[8], (char *)(&c), 4);
+	vendor[12] = '\0';
 }
 
 static int
@@ -31,14 +30,10 @@ __get_cpuid(char *buffer, size_t sz, const char *fmt)
 	int nb;
 	char vendor[16];
 
-	cpuid(0, &lvl, &b, &c, &d);
-	strncpy(&vendor[0], (char *)(&b), 4);
-	strncpy(&vendor[4], (char *)(&d), 4);
-	strncpy(&vendor[8], (char *)(&c), 4);
-	vendor[12] = '\0';
+	get_cpuid_0(vendor, &lvl);
 
 	if (lvl >= 1) {
-		cpuid(1, &a, &b, &c, &d);
+		cpuid(1, 0, &a, &b, &c, &d);
 
 		family = (a >> 8) & 0xf;  /* bits 11 - 8 */
 		model  = (a >> 4) & 0xf;  /* Bits  7 - 4 */
diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index 559365f8fe52..b69144f22489 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
+#include <string.h>
 
 #include "../../../util/tsc.h"
+#include "cpuid.h"
 
 u64 rdtsc(void)
 {
@@ -11,3 +13,34 @@ u64 rdtsc(void)
 
 	return low | ((u64)high) << 32;
 }
+
+double arch_get_tsc_freq(void)
+{
+	unsigned int a, b, c, d, lvl;
+	static bool cached;
+	static double tsc;
+	char vendor[16];
+
+	if (cached)
+		return tsc;
+
+	cached = true;
+	get_cpuid_0(vendor, &lvl);
+	if (!strstr(vendor, "Intel"))
+		return 0;
+
+	/*
+	 * Don't support Time Stamp Counter and
+	 * Nominal Core Crystal Clock Information Leaf.
+	 */
+	if (lvl < 0x15)
+		return 0;
+
+	cpuid(0x15, 0, &a, &b, &c, &d);
+	/* TSC frequency is not enumerated */
+	if (!a || !b || !c)
+		return 0;
+
+	tsc = (double)c * (double)b / (double)a;
+	return tsc;
+}
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 675f318ce7c1..c15a9852fa41 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -12,6 +12,7 @@
 #include "expr-bison.h"
 #include "expr-flex.h"
 #include "smt.h"
+#include "tsc.h"
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
@@ -402,6 +403,13 @@ double expr_id_data__source_count(const struct expr_id_data *data)
 	return data->val.source_count;
 }
 
+#if !defined(__i386__) && !defined(__x86_64__)
+double arch_get_tsc_freq(void)
+{
+	return 0.0;
+}
+#endif
+
 double expr__get_literal(const char *literal)
 {
 	static struct cpu_topology *topology;
@@ -417,6 +425,11 @@ double expr__get_literal(const char *literal)
 		goto out;
 	}
 
+	if (!strcasecmp("#system_tsc_freq", literal)) {
+		result = arch_get_tsc_freq();
+		goto out;
+	}
+
 	/*
 	 * Assume that topology strings are consistent, such as CPUs "0-1"
 	 * wouldn't be listed as "0,1", and so after deduplication the number of
diff --git a/tools/perf/util/tsc.h b/tools/perf/util/tsc.h
index 7d83a31732a7..88fd1c4c1cb8 100644
--- a/tools/perf/util/tsc.h
+++ b/tools/perf/util/tsc.h
@@ -25,6 +25,7 @@ int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
 u64 perf_time_to_tsc(u64 ns, struct perf_tsc_conversion *tc);
 u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc);
 u64 rdtsc(void);
+double arch_get_tsc_freq(void);
 
 size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp);
 
-- 
2.37.0.170.g444d1eabd0-goog

