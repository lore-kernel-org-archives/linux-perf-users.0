Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E226C12002
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 09:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81FA06121F
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 09:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbhGUImK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 04:42:10 -0400
Received: from foss.arm.com ([217.140.110.172]:49252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236762AbhGUI0y (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jul 2021 04:26:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55EC211B3;
        Wed, 21 Jul 2021 02:07:29 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.38.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B46CD3F694;
        Wed, 21 Jul 2021 02:07:26 -0700 (PDT)
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
Subject: [PATCH 3/6] perf cs-etm: Save TRCDEVARCH register
Date:   Wed, 21 Jul 2021 10:07:02 +0100
Message-Id: <20210721090706.21523-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210721090706.21523-1-james.clark@arm.com>
References: <20210721090706.21523-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Now that the metadata has a length field we can add extra registers
without breaking any previous versions of perf.

Save the TRCDEVARCH register so that it can be used to configure the ETE
decoder in the next commit. If the sysfs file doesn't exist then 0 will
be saved which is an impossible register value and can also be used to
signify that the file couldn't be read.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 13 ++++++++++++-
 tools/perf/util/cs-etm.c          |  1 +
 tools/perf/util/cs-etm.h          |  5 +++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 85168d87b2d7..65a863bdf5cc 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -53,6 +53,7 @@ static const char *metadata_etmv4_ro[CS_ETMV4_PRIV_MAX] = {
 	[CS_ETMV4_TRCIDR2]		= "trcidr/trcidr2",
 	[CS_ETMV4_TRCIDR8]		= "trcidr/trcidr8",
 	[CS_ETMV4_TRCAUTHSTATUS]	= "mgmt/trcauthstatus",
+	[CS_ETE_TRCDEVARCH]		= "mgmt/trcdevarch"
 };
 
 static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
@@ -73,7 +74,7 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
 	if (!cs_etm_is_etmv4(itr, cpu))
 		goto out;
 
-	/* Get a handle on TRCIRD2 */
+	/* Get a handle on TRCIDR2 */
 	snprintf(path, PATH_MAX, "cpu%d/%s",
 		 cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR2]);
 	err = perf_pmu__scan_file(cs_etm_pmu, path, "%x", &val);
@@ -643,6 +644,16 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
 			cs_etm_get_ro(cs_etm_pmu, cpu,
 				      metadata_etmv4_ro
 				      [CS_ETMV4_TRCAUTHSTATUS]);
+		/*
+		 * ETE uses the same registers as ETMv4 plus TRCDEVARCH. It's also backwards
+		 * compatible, so don't change the magic number otherwise that will reduce the
+		 * number of versions of perf that can open it. Just append TRCDEVARCH to the end of
+		 * the register block and allow newer versions of perf to make use. cs_etm_get_ro()
+		 * returns 0 if it couldn't be read.
+		 */
+		info->priv[*offset + CS_ETE_TRCDEVARCH] =
+			cs_etm_get_ro(cs_etm_pmu, cpu,
+				      metadata_etmv4_ro[CS_ETE_TRCDEVARCH]);
 
 		/* How much space was used */
 		increment = CS_ETMV4_PRIV_MAX;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 62769a84a53f..68978f6707a8 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2508,6 +2508,7 @@ static const char * const cs_etmv4_priv_fmts[] = {
 	[CS_ETMV4_TRCIDR2]	= "	TRCIDR2			       %llx\n",
 	[CS_ETMV4_TRCIDR8]	= "	TRCIDR8			       %llx\n",
 	[CS_ETMV4_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
+	[CS_ETE_TRCDEVARCH]	= "	TRCDEVARCH                     %llx\n"
 };
 
 static const char * const param_unk_fmt =
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index d65c7b19407d..52d82dce9d59 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -59,7 +59,7 @@ enum {
 /* define fixed version 0 length - allow new format reader to read old files. */
 #define CS_ETM_NR_TRC_PARAMS_V0 (CS_ETM_ETMIDR - CS_ETM_ETMCR + 1)
 
-/* ETMv4 metadata */
+/* ETMv4 + ETE metadata */
 enum {
 	/* Dynamic, configurable parameters */
 	CS_ETMV4_TRCCONFIGR = CS_ETM_COMMON_BLK_MAX_V1,
@@ -70,7 +70,8 @@ enum {
 	CS_ETMV4_TRCIDR2,
 	CS_ETMV4_TRCIDR8,
 	CS_ETMV4_TRCAUTHSTATUS,
-	CS_ETMV4_PRIV_MAX,
+	CS_ETE_TRCDEVARCH,
+	CS_ETMV4_PRIV_MAX
 };
 
 /* define fixed version 0 length - allow new format reader to read old files. */
-- 
2.28.0

