Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F722C43334
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 05:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiFIFYL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 01:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiFIFYK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 01:24:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B1D2C650
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Jun 2022 22:24:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-30047b94aa8so193967417b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jun 2022 22:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=92Ap8HPAB8/MDXHmk/KascZglACyrXnQYkxdMYEdECc=;
        b=c+zLR0wVXL9kWNiEJ57kdQibv8Zr0VL9IAwXHVwAVZyRLzSx4FHmS08R8X92ZplbmI
         JwWF11N1zwiHTbW9SmZ4vb/QH4ZKShWHaH/YgSkPyTt2dpuEuLZxGAC4HzpAJIlK8g1F
         vzBlyDuOohjGG5ZK/cNkxV6wGysCTSaUjckk9Wmp8VXiGLRSNOZYW1/AXTWBn6yZGFc4
         2Rib8pTuoWepYbhadEw+NZZlEayCVyc+nwqJ/flEGluYAL7WbBTYW1f+86at6Cy47Q5n
         nyKHKvQLgkVDkXo+19wYo+iKLuU7doOb4y0GRrkQCrmqdPP/G9OITHbvlijbbos7QKwR
         xNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=92Ap8HPAB8/MDXHmk/KascZglACyrXnQYkxdMYEdECc=;
        b=0Sh73IrxmC+Rch5VYwX5v+aMtkj5eVOsUgte3b+ATYI46o5Ma5lmY2Ivmgh5cz4P26
         n8sWbI1pmWXxFZ9VHyPdaprt2Vf/FVtBXGdeL2WU1OM37AOsOLpjW3HKZlLPDmv2VOhA
         qEyTwefGtYKY9/f5xe4JMi5OQswAJ5EdPqEhPwnxhBB+fMI/PIoZZDfe0yvm/Ns9JKMC
         l0+Ed3w5LsZs8PGwJHoAU6yhry5bET6TIRh3juijTBje9KH9e/pNr1Cmg+dsy87auVaI
         fiCFHFib4kQYF4mnSFsOYkXUYwAVQ/uG+6h1ZlzZzndo6nzNgKI7Tfk2n+X87g0pH2LN
         MTJg==
X-Gm-Message-State: AOAM532ncloQWEx6N+pnxbE2jXKUx8jOqcU6SGG3irHP5/Ho5VdxN18+
        tvDRnme6+krg1UkXvUXpeDpjCx7dFBs0
X-Google-Smtp-Source: ABdhPJyNkg3gb8kG/ZewVhB0Qss0toz5dRxqodcpwXpCLk+fIrqos5bELAzypdRYZvj9VrwV05oVuaVHTLzK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ae20:7578:fb21:976b])
 (user=irogers job=sendgmr) by 2002:a25:6583:0:b0:660:3a01:84f7 with SMTP id
 z125-20020a256583000000b006603a0184f7mr35986524ybb.130.1654752246414; Wed, 08
 Jun 2022 22:24:06 -0700 (PDT)
Date:   Wed,  8 Jun 2022 22:23:53 -0700
In-Reply-To: <20220609052355.1300162-1-irogers@google.com>
Message-Id: <20220609052355.1300162-3-irogers@google.com>
Mime-Version: 1.0
References: <20220609052355.1300162-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 2/4] perf: Align user space counter reading with code
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

Align the user space counter reading documentation with the code in
perf_mmap__read_self. Previously the documentation was based on the perf
rdpmc test, but now general purpose code is provided by libperf.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/uapi/linux/perf_event.h       | 32 ++++++++++++++++-----------
 tools/include/uapi/linux/perf_event.h | 32 ++++++++++++++++-----------
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index d37629dbad72..3b84e0ad0723 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -538,9 +538,13 @@ struct perf_event_mmap_page {
 	 *
 	 *     if (pc->cap_usr_time && enabled != running) {
 	 *       cyc = rdtsc();
-	 *       time_offset = pc->time_offset;
 	 *       time_mult   = pc->time_mult;
 	 *       time_shift  = pc->time_shift;
+	 *       time_offset = pc->time_offset;
+	 *       if (pc->cap_user_time_short) {
+	 *         time_cycles = pc->time_cycles;
+	 *         time_mask = pc->time_mask;
+	 *       }
 	 *     }
 	 *
 	 *     index = pc->index;
@@ -548,6 +552,9 @@ struct perf_event_mmap_page {
 	 *     if (pc->cap_user_rdpmc && index) {
 	 *       width = pc->pmc_width;
 	 *       pmc = rdpmc(index - 1);
+	 *       pmc <<= 64 - width;
+	 *       pmc >>= 64 - width;
+	 *       count += pmc;
 	 *     }
 	 *
 	 *     barrier();
@@ -590,25 +597,24 @@ struct perf_event_mmap_page {
 	 * If cap_usr_time the below fields can be used to compute the time
 	 * delta since time_enabled (in ns) using rdtsc or similar.
 	 *
-	 *   u64 quot, rem;
-	 *   u64 delta;
-	 *
-	 *   quot = (cyc >> time_shift);
-	 *   rem = cyc & (((u64)1 << time_shift) - 1);
-	 *   delta = time_offset + quot * time_mult +
-	 *              ((rem * time_mult) >> time_shift);
+	 *   cyc = time_cycles + ((cyc - time_cycles) & time_mask);
+	 *   delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
 	 *
 	 * Where time_offset,time_mult,time_shift and cyc are read in the
 	 * seqcount loop described above. This delta can then be added to
-	 * enabled and possible running (if index), improving the scaling:
+	 * enabled and possible running (if index) to improve the scaling. Due
+	 * to event multiplexing, running maybe zero and so care is needed to
+	 * avoid division by zero.
 	 *
 	 *   enabled += delta;
-	 *   if (index)
+	 *   if (idx)
 	 *     running += delta;
 	 *
-	 *   quot = count / running;
-	 *   rem  = count % running;
-	 *   count = quot * enabled + (rem * enabled) / running;
+	 *   if (running != 0) {
+	 *     quot = count / running;
+	 *     rem  = count % running;
+	 *     count = quot * enabled + (rem * enabled) / running;
+	 *   }
 	 */
 	__u16	time_shift;
 	__u32	time_mult;
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index d37629dbad72..3b84e0ad0723 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -538,9 +538,13 @@ struct perf_event_mmap_page {
 	 *
 	 *     if (pc->cap_usr_time && enabled != running) {
 	 *       cyc = rdtsc();
-	 *       time_offset = pc->time_offset;
 	 *       time_mult   = pc->time_mult;
 	 *       time_shift  = pc->time_shift;
+	 *       time_offset = pc->time_offset;
+	 *       if (pc->cap_user_time_short) {
+	 *         time_cycles = pc->time_cycles;
+	 *         time_mask = pc->time_mask;
+	 *       }
 	 *     }
 	 *
 	 *     index = pc->index;
@@ -548,6 +552,9 @@ struct perf_event_mmap_page {
 	 *     if (pc->cap_user_rdpmc && index) {
 	 *       width = pc->pmc_width;
 	 *       pmc = rdpmc(index - 1);
+	 *       pmc <<= 64 - width;
+	 *       pmc >>= 64 - width;
+	 *       count += pmc;
 	 *     }
 	 *
 	 *     barrier();
@@ -590,25 +597,24 @@ struct perf_event_mmap_page {
 	 * If cap_usr_time the below fields can be used to compute the time
 	 * delta since time_enabled (in ns) using rdtsc or similar.
 	 *
-	 *   u64 quot, rem;
-	 *   u64 delta;
-	 *
-	 *   quot = (cyc >> time_shift);
-	 *   rem = cyc & (((u64)1 << time_shift) - 1);
-	 *   delta = time_offset + quot * time_mult +
-	 *              ((rem * time_mult) >> time_shift);
+	 *   cyc = time_cycles + ((cyc - time_cycles) & time_mask);
+	 *   delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
 	 *
 	 * Where time_offset,time_mult,time_shift and cyc are read in the
 	 * seqcount loop described above. This delta can then be added to
-	 * enabled and possible running (if index), improving the scaling:
+	 * enabled and possible running (if index) to improve the scaling. Due
+	 * to event multiplexing, running maybe zero and so care is needed to
+	 * avoid division by zero.
 	 *
 	 *   enabled += delta;
-	 *   if (index)
+	 *   if (idx)
 	 *     running += delta;
 	 *
-	 *   quot = count / running;
-	 *   rem  = count % running;
-	 *   count = quot * enabled + (rem * enabled) / running;
+	 *   if (running != 0) {
+	 *     quot = count / running;
+	 *     rem  = count % running;
+	 *     count = quot * enabled + (rem * enabled) / running;
+	 *   }
 	 */
 	__u16	time_shift;
 	__u32	time_mult;
-- 
2.36.1.255.ge46751e96f-goog

