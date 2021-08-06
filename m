Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2039FC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 13:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CC260C41
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 13:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244498AbhHFNlp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:41:45 -0400
Received: from foss.arm.com ([217.140.110.172]:33024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244465AbhHFNlp (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 09:41:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 602BF31B;
        Fri,  6 Aug 2021 06:41:29 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 63E083F40C;
        Fri,  6 Aug 2021 06:41:26 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org
Cc:     acme@kernel.org, suzuki.poulose@arm.com,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] perf cs-etm: Refactor out ETMv4 header saving
Date:   Fri,  6 Aug 2021 14:41:03 +0100
Message-Id: <20210806134109.1182235-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210806134109.1182235-1-james.clark@arm.com>
References: <20210806134109.1182235-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Extract a function for saving the ETMv4 header because this will be used
for ETE in a later commit.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 46 +++++++++++++++----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 85168d87b2d7..ecb6fa55a210 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -607,6 +607,28 @@ static int cs_etm_get_ro(struct perf_pmu *pmu, int cpu, const char *path)
 	return val;
 }
 
+static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr, int cpu)
+{
+	struct cs_etm_recording *ptr = container_of(itr, struct cs_etm_recording, itr);
+	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
+
+	/* Get trace configuration register */
+	data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_get_config(itr);
+	/* Get traceID from the framework */
+	data[CS_ETMV4_TRCTRACEIDR] = coresight_get_trace_id(cpu);
+	/* Get read-only information from sysFS */
+	data[CS_ETMV4_TRCIDR0] = cs_etm_get_ro(cs_etm_pmu, cpu,
+					       metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
+	data[CS_ETMV4_TRCIDR1] = cs_etm_get_ro(cs_etm_pmu, cpu,
+					       metadata_etmv4_ro[CS_ETMV4_TRCIDR1]);
+	data[CS_ETMV4_TRCIDR2] = cs_etm_get_ro(cs_etm_pmu, cpu,
+					       metadata_etmv4_ro[CS_ETMV4_TRCIDR2]);
+	data[CS_ETMV4_TRCIDR8] = cs_etm_get_ro(cs_etm_pmu, cpu,
+					       metadata_etmv4_ro[CS_ETMV4_TRCIDR8]);
+	data[CS_ETMV4_TRCAUTHSTATUS] = cs_etm_get_ro(cs_etm_pmu, cpu,
+						     metadata_etmv4_ro[CS_ETMV4_TRCAUTHSTATUS]);
+}
+
 static void cs_etm_get_metadata(int cpu, u32 *offset,
 				struct auxtrace_record *itr,
 				struct perf_record_auxtrace_info *info)
@@ -620,29 +642,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
 	/* first see what kind of tracer this cpu is affined to */
 	if (cs_etm_is_etmv4(itr, cpu)) {
 		magic = __perf_cs_etmv4_magic;
-		/* Get trace configuration register */
-		info->priv[*offset + CS_ETMV4_TRCCONFIGR] =
-						cs_etmv4_get_config(itr);
-		/* Get traceID from the framework */
-		info->priv[*offset + CS_ETMV4_TRCTRACEIDR] =
-						coresight_get_trace_id(cpu);
-		/* Get read-only information from sysFS */
-		info->priv[*offset + CS_ETMV4_TRCIDR0] =
-			cs_etm_get_ro(cs_etm_pmu, cpu,
-				      metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
-		info->priv[*offset + CS_ETMV4_TRCIDR1] =
-			cs_etm_get_ro(cs_etm_pmu, cpu,
-				      metadata_etmv4_ro[CS_ETMV4_TRCIDR1]);
-		info->priv[*offset + CS_ETMV4_TRCIDR2] =
-			cs_etm_get_ro(cs_etm_pmu, cpu,
-				      metadata_etmv4_ro[CS_ETMV4_TRCIDR2]);
-		info->priv[*offset + CS_ETMV4_TRCIDR8] =
-			cs_etm_get_ro(cs_etm_pmu, cpu,
-				      metadata_etmv4_ro[CS_ETMV4_TRCIDR8]);
-		info->priv[*offset + CS_ETMV4_TRCAUTHSTATUS] =
-			cs_etm_get_ro(cs_etm_pmu, cpu,
-				      metadata_etmv4_ro
-				      [CS_ETMV4_TRCAUTHSTATUS]);
+		cs_etm_save_etmv4_header(&info->priv[*offset], itr, cpu);
 
 		/* How much space was used */
 		increment = CS_ETMV4_PRIV_MAX;
-- 
2.28.0

