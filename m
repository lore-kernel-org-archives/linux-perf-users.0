Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1FDC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Feb 2022 10:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiBBK5l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Feb 2022 05:57:41 -0500
Received: from foss.arm.com ([217.140.110.172]:50992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbiBBK5k (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Feb 2022 05:57:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 635921FB;
        Wed,  2 Feb 2022 02:57:40 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 467BC3F40C;
        Wed,  2 Feb 2022 02:57:36 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     james.clark@arm.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: tools: Add missing branch_sample_type
Date:   Wed,  2 Feb 2022 16:27:23 +0530
Message-Id: <1643799443-15109-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This updates branch sample type with missing PERF_SAMPLE_BRANCH_TYPE_SAVE.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 tools/perf/util/perf_event_attr_fprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 47b7531f51da..98af3fa4ea35 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -52,7 +52,7 @@ static void __p_branch_sample_type(char *buf, size_t size, u64 value)
 		bit_name(ABORT_TX), bit_name(IN_TX), bit_name(NO_TX),
 		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
 		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
-		bit_name(HW_INDEX),
+		bit_name(TYPE_SAVE), bit_name(HW_INDEX),
 		{ .name = NULL, }
 	};
 #undef bit_name
-- 
2.20.1

