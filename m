Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BBCC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Apr 2022 10:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiD0LDA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Apr 2022 07:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiD0LCy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Apr 2022 07:02:54 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5456022294;
        Wed, 27 Apr 2022 03:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651056320; x=1682592320;
  h=from:to:cc:subject:date:message-id;
  bh=grvj6tMyw3S/5nbVT6GQKTs8XupqF2xocGWEN8DyBms=;
  b=Otq4jIWnc+3joBGa6If+Qwj3xK4vvTJFpOAsbm6JyaLikC3wOYYeN2wa
   O9zmxO7UFxb6OETRCFEETYhHnPJvjbzeF/ZbAJntWJxnEUGVSWPcJI+QU
   SsdrfWviZ+4WSmwRBBbHgwB9uGReVL9CZGgnrN2Gj9org/NPq3aBdD/6B
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Apr 2022 02:53:17 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 Apr 2022 02:53:15 -0700
X-QCInternal: smtphost
Received: from hu-c-spathi-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.108.59])
  by ironmsg02-blr.qualcomm.com with ESMTP; 27 Apr 2022 15:22:59 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
        id 271763B1A; Wed, 27 Apr 2022 15:22:58 +0530 (+0530)
From:   Srinivasarao Pathipati <quic_spathi@quicinc.com>
To:     will@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srinivasarao Pathipati <quic_spathi@quicinc.com>
Subject: [PATCH V1] arm64: perf: Change PMCR write to read-modify-write
Date:   Wed, 27 Apr 2022 15:21:45 +0530
Message-Id: <1651053105-11557-1-git-send-email-quic_spathi@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Preserve the bitfields of PMCR_EL0 during PMU reset.
Reset routine should set only PMCR.C, PMCR.P and PMCR.LC fields only
to reset the counters. Other fields should not be changed
as they could be set before PMU initialization and their value must
be preserved even after reset.

Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cb69ff1..9e22326 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1047,7 +1047,7 @@ static void armv8pmu_reset(void *info)
 	if (armv8pmu_has_long_event(cpu_pmu))
 		pmcr |= ARMV8_PMU_PMCR_LP;
 
-	armv8pmu_pmcr_write(pmcr);
+	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | pmcr);
 }
 
 static int __armv8_pmuv3_map_event(struct perf_event *event,
-- 
2.7.4

