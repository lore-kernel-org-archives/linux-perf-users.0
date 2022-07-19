Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0AAC43334
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jul 2022 22:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiGSWkB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jul 2022 18:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbiGSWj7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jul 2022 18:39:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623516053E
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Jul 2022 15:39:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31e62bc916aso15569927b3.19
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Jul 2022 15:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VRrF+dBSPDqcThaK0WqPXtrk76bsoHtC+fEeOWlRUzU=;
        b=pwfZ3CGHR27Qu5kUsnkQ8LbcGR9WKjs93MVlEqd8s9FGYtSL1N0bObEsuUkPfQw7eg
         Wu+p8oNFONOzXApB0PJ1V3d6o5HOSofXMWpEqSp0QMvBoOJ3+HZFANNz0F85qyZv38aF
         ex3+GiFbRGe9DdiHGAMetBrj0qqt4/CXFgOUwmcRdPbGvsWtDefJFUtmvvmewwG4Mf1c
         1ELBwcDQdzvJwI5mQrqyExoywmtl6so4/uQfocLuCveeUXd5Tm1Tr9gNmlGZvYq1twUA
         wXdAFF5YPseidYMAF14jyrqT+l0BxJcYisnKotGXE7U/2N+xCsAzCIu/zYvcGcvke+4C
         Xg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VRrF+dBSPDqcThaK0WqPXtrk76bsoHtC+fEeOWlRUzU=;
        b=YOWEFvpsKYthb8FzZDVK0VHnfQNcGCASSuRrOgfOP4ooph8LSIHYKLrGPVxW2A6B/d
         V21X7r9e6v6TfXPzgzQe17T1j1YFJjKEXs68v2ANwj93r+/2S/B5FBRmumZeuqZ/00mD
         sXLVqJD7H6Q+wDaYd0YRJeo6Ze012kiLemP7YFmtraq1pfUMOadsMxwkvmRA3m5Qun76
         2dxsU4/FOEGaXeepdrGdd4wiLIjZETK6lWHd7wwnteKUUzDu7jtiKcagIoLWZtO+lrhn
         bdPwIVlpW6CiYpsmgvFxjCr/uOn+s794g2MEn5MHU0ojSlUuGTrECycHW/MVonHkFgIj
         qwUg==
X-Gm-Message-State: AJIora97paiHp5Ua3XpSEXGQVMXh7wT12eMV9xtq6c5MozTOoiAh+QqC
        p5JMZe20xQRa+atiCdaF5xhicGpISGPo
X-Google-Smtp-Source: AGRyM1urOvWBOjiXSlx4irMb/Gn3dwgNWJ1brN64nNXliYOtdD7bolN1rdUdPa5p9mIBdqN0Edp6Nut/Bwkf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1251:e27b:f589:696c])
 (user=irogers job=sendgmr) by 2002:a25:76c9:0:b0:66f:f3f0:5feb with SMTP id
 r192-20020a2576c9000000b0066ff3f05febmr21322768ybc.23.1658270397678; Tue, 19
 Jul 2022 15:39:57 -0700 (PDT)
Date:   Tue, 19 Jul 2022 15:39:45 -0700
In-Reply-To: <20220719223946.176299-1-irogers@google.com>
Message-Id: <20220719223946.176299-3-irogers@google.com>
Mime-Version: 1.0
References: <20220719223946.176299-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v3 2/3] perf test: Remove x86 rdpmc test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This test has been superseded by test_stat_user_read in:
tools/lib/perf/tests/test-evsel.c
The updated test doesn't divide-by-0 when running time of a counter is
0. It also supports ARM64.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/Build        |   1 -
 tools/perf/arch/x86/tests/arch-tests.c |   2 -
 tools/perf/arch/x86/tests/rdpmc.c      | 182 -------------------------
 3 files changed, 185 deletions(-)
 delete mode 100644 tools/perf/arch/x86/tests/rdpmc.c

diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 28d793390198..70b5bcbc15df 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -2,7 +2,6 @@ perf-$(CONFIG_DWARF_UNWIND) += regs_load.o
 perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-y += arch-tests.o
-perf-y += rdpmc.o
 perf-y += sample-parsing.o
 perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-pkt-decoder-test.o
 perf-$(CONFIG_X86_64) += bp-modify.o
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index 64fb73d14d2f..04018b8aa85b 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -3,7 +3,6 @@
 #include "tests/tests.h"
 #include "arch-tests.h"
 
-DEFINE_SUITE("x86 rdpmc", rdpmc);
 #ifdef HAVE_AUXTRACE_SUPPORT
 DEFINE_SUITE("x86 instruction decoder - new instructions", insn_x86);
 DEFINE_SUITE("Intel PT packet decoder", intel_pt_pkt_decoder);
@@ -14,7 +13,6 @@ DEFINE_SUITE("x86 bp modify", bp_modify);
 DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
 
 struct test_suite *arch_tests[] = {
-	&suite__rdpmc,
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 	&suite__dwarf_unwind,
 #endif
diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
deleted file mode 100644
index 498413ad9c97..000000000000
--- a/tools/perf/arch/x86/tests/rdpmc.c
+++ /dev/null
@@ -1,182 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <errno.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <sys/mman.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include "perf-sys.h"
-#include "debug.h"
-#include "tests/tests.h"
-#include "cloexec.h"
-#include "event.h"
-#include <internal/lib.h> // page_size
-#include "arch-tests.h"
-
-static u64 rdpmc(unsigned int counter)
-{
-	unsigned int low, high;
-
-	asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (counter));
-
-	return low | ((u64)high) << 32;
-}
-
-static u64 rdtsc(void)
-{
-	unsigned int low, high;
-
-	asm volatile("rdtsc" : "=a" (low), "=d" (high));
-
-	return low | ((u64)high) << 32;
-}
-
-static u64 mmap_read_self(void *addr)
-{
-	struct perf_event_mmap_page *pc = addr;
-	u32 seq, idx, time_mult = 0, time_shift = 0;
-	u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
-
-	do {
-		seq = pc->lock;
-		barrier();
-
-		enabled = pc->time_enabled;
-		running = pc->time_running;
-
-		if (enabled != running) {
-			cyc = rdtsc();
-			time_mult = pc->time_mult;
-			time_shift = pc->time_shift;
-			time_offset = pc->time_offset;
-		}
-
-		idx = pc->index;
-		count = pc->offset;
-		if (idx)
-			count += rdpmc(idx - 1);
-
-		barrier();
-	} while (pc->lock != seq);
-
-	if (enabled != running) {
-		u64 quot, rem;
-
-		quot = (cyc >> time_shift);
-		rem = cyc & (((u64)1 << time_shift) - 1);
-		delta = time_offset + quot * time_mult +
-			((rem * time_mult) >> time_shift);
-
-		enabled += delta;
-		if (idx)
-			running += delta;
-
-		quot = count / running;
-		rem = count % running;
-		count = quot * enabled + (rem * enabled) / running;
-	}
-
-	return count;
-}
-
-/*
- * If the RDPMC instruction faults then signal this back to the test parent task:
- */
-static void segfault_handler(int sig __maybe_unused,
-			     siginfo_t *info __maybe_unused,
-			     void *uc __maybe_unused)
-{
-	exit(-1);
-}
-
-static int __test__rdpmc(void)
-{
-	volatile int tmp = 0;
-	u64 i, loops = 1000;
-	int n;
-	int fd;
-	void *addr;
-	struct perf_event_attr attr = {
-		.type = PERF_TYPE_HARDWARE,
-		.config = PERF_COUNT_HW_INSTRUCTIONS,
-		.exclude_kernel = 1,
-	};
-	u64 delta_sum = 0;
-        struct sigaction sa;
-	char sbuf[STRERR_BUFSIZE];
-
-	sigfillset(&sa.sa_mask);
-	sa.sa_sigaction = segfault_handler;
-	sa.sa_flags = 0;
-	sigaction(SIGSEGV, &sa, NULL);
-
-	fd = sys_perf_event_open(&attr, 0, -1, -1,
-				 perf_event_open_cloexec_flag());
-	if (fd < 0) {
-		pr_err("Error: sys_perf_event_open() syscall returned "
-		       "with %d (%s)\n", fd,
-		       str_error_r(errno, sbuf, sizeof(sbuf)));
-		return -1;
-	}
-
-	addr = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
-	if (addr == (void *)(-1)) {
-		pr_err("Error: mmap() syscall returned with (%s)\n",
-		       str_error_r(errno, sbuf, sizeof(sbuf)));
-		goto out_close;
-	}
-
-	for (n = 0; n < 6; n++) {
-		u64 stamp, now, delta;
-
-		stamp = mmap_read_self(addr);
-
-		for (i = 0; i < loops; i++)
-			tmp++;
-
-		now = mmap_read_self(addr);
-		loops *= 10;
-
-		delta = now - stamp;
-		pr_debug("%14d: %14Lu\n", n, (long long)delta);
-
-		delta_sum += delta;
-	}
-
-	munmap(addr, page_size);
-	pr_debug("   ");
-out_close:
-	close(fd);
-
-	if (!delta_sum)
-		return -1;
-
-	return 0;
-}
-
-int test__rdpmc(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
-{
-	int status = 0;
-	int wret = 0;
-	int ret;
-	int pid;
-
-	pid = fork();
-	if (pid < 0)
-		return -1;
-
-	if (!pid) {
-		ret = __test__rdpmc();
-
-		exit(ret);
-	}
-
-	wret = waitpid(pid, &status, 0);
-	if (wret < 0 || status)
-		return -1;
-
-	return 0;
-}
-- 
2.37.0.170.g444d1eabd0-goog

