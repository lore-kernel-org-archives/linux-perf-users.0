Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830B0C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Jan 2022 04:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiAXEcM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 23 Jan 2022 23:32:12 -0500
Received: from foss.arm.com ([217.140.110.172]:47182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241437AbiAXEcJ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 23 Jan 2022 23:32:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91F28113E;
        Sun, 23 Jan 2022 20:32:08 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.119.34.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E32203F73B;
        Sun, 23 Jan 2022 20:32:00 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [RFC V1 04/11] arm64/perf: Update struct pmu_hw_events for BRBE
Date:   Mon, 24 Jan 2022 10:00:46 +0530
Message-Id: <1642998653-21377-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A single perf event instance BRBE related contexts and data will be tracked
in struct pmu_hw_events. Hence update the structure to accommodate required
details related to BRBE.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/perf/arm_pmu.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index c0dd0d6c5883..c4a705d3d054 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -41,6 +41,11 @@
 	},								\
 }
 
+/*
+ * Maximum branch records in BRBE
+ */
+#define BRBE_MAX_ENTRIES 64
+
 /* The events for a given PMU register set. */
 struct pmu_hw_events {
 	/*
@@ -67,6 +72,23 @@ struct pmu_hw_events {
 	struct arm_pmu		*percpu_pmu;
 
 	int irq;
+
+	/* Detected BRBE attributes */
+	bool				v1p1;
+	int				brbe_cc;
+	int				brbe_nr;
+
+	/* Evaluated BRBE configuration */
+	u64				brbfcr;
+	u64				brbcr;
+
+	/* Tracked BRBE context */
+	unsigned int			brbe_users;
+	void				*brbe_context;
+
+	/* Captured BRBE buffer - copied as is into perf_sample_data */
+	struct perf_branch_stack	brbe_stack;
+	struct perf_branch_entry	brbe_entries[BRBE_MAX_ENTRIES];
 };
 
 enum armpmu_attr_groups {
-- 
2.25.1

