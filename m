Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C31C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Mar 2022 05:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiCOFiB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Mar 2022 01:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345065AbiCOFhx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Mar 2022 01:37:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12F684990F;
        Mon, 14 Mar 2022 22:36:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48D001476;
        Mon, 14 Mar 2022 22:36:31 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.34.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC7943F766;
        Mon, 14 Mar 2022 22:36:25 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, acme@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V4 10/10] perf/tools: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform
Date:   Tue, 15 Mar 2022 11:05:16 +0530
Message-Id: <20220315053516.431515-11-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315053516.431515-1-anshuman.khandual@arm.com>
References: <20220315053516.431515-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This updates the perf tool with arch specific branch type classification
used for BRBE on arm64 platform as added in the kernel earlier.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 tools/include/uapi/linux/perf_event.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 193dba2ecdc1..4cf1c8e22cab 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -282,6 +282,12 @@ enum {
 	PERF_BR_PRIV_HV		= 3,
 };
 
+#define PERF_BR_ARM64_FIQ		PERF_BR_NEW_ARCH_1
+#define PERF_BR_ARM64_DEBUG_HALT	PERF_BR_NEW_ARCH_2
+#define PERF_BR_ARM64_DEBUG_EXIT	PERF_BR_NEW_ARCH_3
+#define PERF_BR_ARM64_DEBUG_INST	PERF_BR_NEW_ARCH_4
+#define PERF_BR_ARM64_DEBUG_DATA	PERF_BR_NEW_ARCH_5
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
-- 
2.25.1

