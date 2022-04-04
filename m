Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AB9C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Apr 2022 04:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377192AbiDDExW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Apr 2022 00:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377249AbiDDEw7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Apr 2022 00:52:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCACA33A01;
        Sun,  3 Apr 2022 21:51:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A94811FB;
        Sun,  3 Apr 2022 21:51:04 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.36.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E3293F5A1;
        Sun,  3 Apr 2022 21:50:57 -0700 (PDT)
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
Subject: [PATCH V5 4/8] perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform
Date:   Mon,  4 Apr 2022 10:20:42 +0530
Message-Id: <20220404045046.634522-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404045046.634522-1-anshuman.khandual@arm.com>
References: <20220404045046.634522-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

BRBE captured branch types will overflow perf_branch_entry.type and generic
branch types in perf_branch_entry.new_type. So override each available arch
specific branch type in the following manner to comprehensively process all
reported branch types in BRBE.

PERF_BR_ARM64_FIQ            PERF_BR_NEW_ARCH_1
PERF_BR_ARM64_DEBUG_HALT     PERF_BR_NEW_ARCH_2
PERF_BR_ARM64_DEBUG_EXIT     PERF_BR_NEW_ARCH_3
PERF_BR_ARM64_DEBUG_INST     PERF_BR_NEW_ARCH_4
PERF_BR_ARM64_DEBUG_DATA     PERF_BR_NEW_ARCH_5

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/uapi/linux/perf_event.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 193dba2ecdc1..4cf1c8e22cab 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
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

