Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D557FC43334
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Jun 2022 22:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiFHWoT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Jun 2022 18:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbiFHWoO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Jun 2022 18:44:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736A531212
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Jun 2022 15:44:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p70-20020a257449000000b006639f94498fso8253495ybc.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jun 2022 15:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=92Ap8HPAB8/MDXHmk/KascZglACyrXnQYkxdMYEdECc=;
        b=e99nTxwzmHI8yebHt+bbgofhp8aiUOekQygtiQN9XVjtflMrSYrSxwUnYhMDVL025Z
         M3h6iW3nbPYbQT3tOE1FIm8plo1TrsMnyVTfADBzqDQntVwHcGKU8+TBm6d5k4x7CEmH
         v9KbRZ7jVYm/t/tLpV/xBFHFPZurF1Hy8Jdh3Hxv8ZqtO4xp00LCarmiLo+abbE4k0cZ
         2txF2ryyWgDGWLnW08thypUFOCfLKLKsaz3PwIzj91vCu8VCJs/DxajOJq/rsgouSHT4
         xXEHIq2PyfH2pBaidi1w6y5VI7asiz89GopJYDV9zzYiszeQ91//MJEneWiwUsczB1O5
         DWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=92Ap8HPAB8/MDXHmk/KascZglACyrXnQYkxdMYEdECc=;
        b=vgRlU2oZpgBnasnM7KI4oDHaS6Mp2rOsUWEbp7xJrAudKMcU98fCoMFTnNaWbs/sSm
         mhfHUB4r4OsC6aiCgIIkHtrRCtnRcC+IWjfxt/i5eRiV6eES+bOQHPRDSonOnfdGGSK/
         JRGKaD9YzP9aBZBV9DxHlnFKzb4gPl/yvWiBrkM07bH357/ifQV123o0zLBvaoUdnBSK
         1zsLwJ3t0+8qXtfRm2sz17WHx4w4H3np2M4bZSEM05mMUFWXsr4FYnC2CQ5er5KOt4t1
         2ngRKCknibyJ5EUknzTG1i2NJ1v5ng6B4XAp/K2DlevX/zjoRJkCeB1Nq1BAu5c9R9Pz
         rxag==
X-Gm-Message-State: AOAM530b1KK1X6YU5dSQEFeO4/R/z0yEn+1qwzjGzQWD/DJQCKX/G3UY
        F/uknTn4hE9WkaS6dCuQiFiqC2daKpLf
X-Google-Smtp-Source: ABdhPJxMTueI/fWmU45+M23F3qCnjJDGJHxta8YxrKZGEvI7f7QC8ZqBbTtRq6zU6Ra68YgqHXiCfr8LgW9Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:de48:5efa:e4a1:2219])
 (user=irogers job=sendgmr) by 2002:a05:690c:108:b0:2e5:b91a:195b with SMTP id
 bd8-20020a05690c010800b002e5b91a195bmr41183210ywb.44.1654728252702; Wed, 08
 Jun 2022 15:44:12 -0700 (PDT)
Date:   Wed,  8 Jun 2022 15:43:51 -0700
In-Reply-To: <20220608224353.1176079-1-irogers@google.com>
Message-Id: <20220608224353.1176079-3-irogers@google.com>
Mime-Version: 1.0
References: <20220608224353.1176079-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 2/4] perf: Align user space counter reading with code
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

