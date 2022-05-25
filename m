Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DD3C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 May 2022 15:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbiEYPl4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 May 2022 11:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245229AbiEYPlz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 May 2022 11:41:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE0592BB24;
        Wed, 25 May 2022 08:41:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 792DF152B;
        Wed, 25 May 2022 08:41:52 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.8.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DEDDD3F73D;
        Wed, 25 May 2022 08:41:48 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     broonie@kernel.org, german.gomez@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/5] perf tools: arm64: Copy perf_regs.h from the kernel
Date:   Wed, 25 May 2022 16:41:11 +0100
Message-Id: <20220525154114.718321-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220525154114.718321-1-james.clark@arm.com>
References: <20220525154114.718321-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Get the updated header for the newly added VG register.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/arch/arm64/include/uapi/asm/perf_regs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/arch/arm64/include/uapi/asm/perf_regs.h b/tools/arch/arm64/include/uapi/asm/perf_regs.h
index d54daafa89e3..fd157f46727e 100644
--- a/tools/arch/arm64/include/uapi/asm/perf_regs.h
+++ b/tools/arch/arm64/include/uapi/asm/perf_regs.h
@@ -36,6 +36,11 @@ enum perf_event_arm_regs {
 	PERF_REG_ARM64_LR,
 	PERF_REG_ARM64_SP,
 	PERF_REG_ARM64_PC,
-	PERF_REG_ARM64_MAX,
+
+	/* Extended/pseudo registers */
+	PERF_REG_ARM64_VG = 46, // SVE Vector Granule
+
+	PERF_REG_ARM64_MAX = PERF_REG_ARM64_PC + 1,
+	PERF_REG_ARM64_EXTENDED_MAX = PERF_REG_ARM64_VG + 1
 };
 #endif /* _ASM_ARM64_PERF_REGS_H */
-- 
2.28.0

