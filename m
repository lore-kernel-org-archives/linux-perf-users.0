Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51190C07E9B
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 09:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE80611CE
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 09:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhGUIly (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 04:41:54 -0400
Received: from foss.arm.com ([217.140.110.172]:49234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236241AbhGUI0s (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jul 2021 04:26:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B880F1042;
        Wed, 21 Jul 2021 02:07:25 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.38.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 262ED3F694;
        Wed, 21 Jul 2021 02:07:23 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.org, al.grant@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/6] perf cs-etm: Initialise architecture based on TRCIDR1
Date:   Wed, 21 Jul 2021 10:07:01 +0100
Message-Id: <20210721090706.21523-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210721090706.21523-1-james.clark@arm.com>
References: <20210721090706.21523-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently the architecture is hard coded as ARCH_V8, but with the
introduction of ETE we want to pick ARCH_AA64. And this change is also
applicable to ETM v4.4 onwards as well.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 30889a9d0165..5972a8afcc6b 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -126,6 +126,18 @@ static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
 	return 0;
 }
 
+#define TRCIDR1_TRCARCHMIN_SHIFT 4
+#define TRCIDR1_TRCARCHMIN_MASK  GENMASK(7, 4)
+#define TRCIDR1_TRCARCHMIN(x)    (((x) & TRCIDR1_TRCARCHMIN_MASK) >> TRCIDR1_TRCARCHMIN_SHIFT)
+static enum _ocsd_arch_version cs_etm_decoder__get_arch_ver(u32 reg_idr1)
+{
+	/*
+	 * If the ETM trace minor version is 4 or more then we can assume
+	 * the architecture is ARCH_AA64 rather than just V8
+	 */
+	return TRCIDR1_TRCARCHMIN(reg_idr1) >= 4 ? ARCH_AA64 : ARCH_V8;
+}
+
 static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
 					     ocsd_etmv4_cfg *config)
 {
@@ -140,7 +152,7 @@ static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
 	config->reg_idr11 = 0;
 	config->reg_idr12 = 0;
 	config->reg_idr13 = 0;
-	config->arch_ver = ARCH_V8;
+	config->arch_ver = cs_etm_decoder__get_arch_ver(params->etmv4.reg_idr1);
 	config->core_prof = profile_CortexA;
 }
 
-- 
2.28.0

