Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0128C7619A
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Mar 2023 12:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjC0M0D (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Mar 2023 08:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjC0M0B (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Mar 2023 08:26:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2310040E4
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 05:25:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5419fb7d6c7so85409647b3.11
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 05:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679919957;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F7KwqhB1vW6BH51xVF/fdSxFumYyZJBQssq1TBoQEZ0=;
        b=jCqIKrYQ++vHclnoR5Z3K24d2RWJsLIECqFtVTdzzcrDXBDreTS1wY/do4t4ygkj+t
         VkKmmZ8uMaraSUPH6nOxeyiS0dd8WyRGl77HGeuXCH9grkd0W1TvaOX6sECVOkcW4SaR
         rpNJ+jxSS/AiFxpvfttBf2AqYTSAw9y2Up4aHbAixoLmzK7M+iJtHUw1KhUv6tvi9f9g
         s7WDDWFxbjrwu/utdcBqwr/TV9vcVAzjC3Yd2WYcIMA5Ry1L1Jr4XiJ7TUguvI0sTInW
         el7KY4qA5XdTokqXBNAY9fUwqnZTY8b8CHwD7/TRfZI2lrikL3s2VJykV8utOYJUMu98
         dkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679919957;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7KwqhB1vW6BH51xVF/fdSxFumYyZJBQssq1TBoQEZ0=;
        b=6JHYq/VKoXdVGqfCB2FJ9Kbd/bs7RnKvfj5XLI0iDM4bvg87h5kutPqaT5aP4Tr/GD
         aYhu2JIhMbNM9MGW2slxrhQQKMYjZIKt7EmYmYSP8VnL6ttJ3KM1SnjkfszK4aGY8rc7
         8tnUEHQEGq+QSNxEpiqamFkrK92AqU8AIow0pnhba6Ju5ai99ry3jp6V9UtgfMgiYIVB
         fWxcXknvMgTzSrJpm6AZuOGLwJf7wvok6ppqDOWtn3UaTZSAGZnaz5e9En4w5Erdei09
         AwuXGey+ErgpetBrYoRI07PsgxXwlgY/9OqM14tXP8gFGZuF0KS88VNaYrFW5wP4xv/0
         jdJw==
X-Gm-Message-State: AAQBX9cf/jvvE2HR6Io7+Kb3D2MAlPuHbaAECr0dY7J9dENQLE68xp+E
        HLzrJGbb4N5RcaboHJwLsrswBszGgcWXpjPilCnAyna/qmlb+7iya7ws1SrxiX7Ar4rCyIYlo1p
        iY/FS/Ar/MdGoYies3kQl0JDlt5m+Cn8kTeQq1w0IloGwiW7tZJVeyHPu+iuwBGpdDiN/YnIUov
        b12SEA+e7ZhZg5
X-Google-Smtp-Source: AKy350bG5KKjQlAp39nyxZ43kANITFetPAQJjpaH4v1idSB6TScOvV9AiJiVJPYIh2UdvjCxwWmSvlrTJoa78dMLfw==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:4a95:5d5f:79e2:4a49])
 (user=peternewman job=sendgmr) by 2002:a05:6902:70d:b0:b45:5cbe:48b3 with
 SMTP id k13-20020a056902070d00b00b455cbe48b3mr7254180ybt.0.1679919957281;
 Mon, 27 Mar 2023 05:25:57 -0700 (PDT)
Date:   Mon, 27 Mar 2023 14:25:27 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230327122527.3913496-1-peternewman@google.com>
Subject: [PATCH v4] arm64: pmuv3: dynamically map PERF_COUNT_HW_BRANCH_INSTRUCTIONS
From:   Peter Newman <peternewman@google.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        will@kernel.org, catalin.marinas@arm.com, eranian@google.com,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

The mapping of perf_events generic hardware events to actual PMU events on
ARM PMUv3 may not always be correct. This is in particular true for the
PERF_COUNT_HW_BRANCH_INSTRUCTIONS event. Although the mapping points to an
architected event, it may not always be available. This can be seen with a
simple:

$ perf stat -e branches sleep 0
 Performance counter stats for 'sleep 0':

   <not supported>      branches

       0.001401081 seconds time elapsed

Yet the hardware does have an event that could be used for branches.

Dynamically check for a supported hardware event which can be used for
PERF_COUNT_HW_BRANCH_INSTRUCTIONS at mapping time.

And with that:

$ perf stat -e branches sleep 0

 Performance counter stats for 'sleep 0':

           166,739      branches

       0.000832163 seconds time elapsed

Based-on: https://lore.kernel.org/all/YvunKCJHSXKz%2FkZB@FVFF77S0Q05N
Based-on-patch-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Newman <peternewman@google.com>
---
v3->v4:
 - splice Mark's patch with Stephane's problem statement
v2->v3:
 - removed prints per Will's suggestion
 
[v3] https://lore.kernel.org/all/20220816130221.885920-1-peternewman@google.com/
[v2] https://lore.kernel.org/lkml/20220324181458.3216262-1-eranian@google.com/

 arch/arm64/kernel/perf_event.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index dde06c0f97f3..ee63f8e719ea 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -45,7 +45,6 @@ static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
 	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
 	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
 	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
 	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
@@ -1048,6 +1047,28 @@ static void armv8pmu_reset(void *info)
 	armv8pmu_pmcr_write(pmcr);
 }
 
+static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
+				      struct perf_event *event)
+{
+	if (event->attr.type == PERF_TYPE_HARDWARE &&
+	    event->attr.config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS) {
+
+		if (test_bit(ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
+			     armpmu->pmceid_bitmap))
+			return ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED;
+
+		if (test_bit(ARMV8_PMUV3_PERFCTR_BR_RETIRED,
+			     armpmu->pmceid_bitmap))
+			return ARMV8_PMUV3_PERFCTR_BR_RETIRED;
+
+		return HW_OP_UNSUPPORTED;
+	}
+
+	return armpmu_map_event(event, &armv8_pmuv3_perf_map,
+				&armv8_pmuv3_perf_cache_map,
+				ARMV8_PMU_EVTYPE_EVENT);
+}
+
 static int __armv8_pmuv3_map_event(struct perf_event *event,
 				   const unsigned (*extra_event_map)
 						  [PERF_COUNT_HW_MAX],
@@ -1059,9 +1080,7 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 	int hw_event_id;
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 
-	hw_event_id = armpmu_map_event(event, &armv8_pmuv3_perf_map,
-				       &armv8_pmuv3_perf_cache_map,
-				       ARMV8_PMU_EVTYPE_EVENT);
+	hw_event_id = __armv8_pmuv3_map_event_id(armpmu, event);
 
 	/*
 	 * CHAIN events only work when paired with an adjacent counter, and it
-- 
2.40.0.348.gf938b09366-goog

