Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B2CC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 May 2022 14:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbiEIOrf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 May 2022 10:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbiEIOre (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 May 2022 10:47:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BAA31ED2A4;
        Mon,  9 May 2022 07:43:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06DD5153B;
        Mon,  9 May 2022 07:43:40 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.4.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9EF4C3F73D;
        Mon,  9 May 2022 07:43:37 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org
Cc:     german.gomez@arm.com, James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH v1 3/6] perf tools: arm64: Copy perf_regs.h from the kernel
Date:   Mon,  9 May 2022 15:42:51 +0100
Message-Id: <20220509144257.1623063-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220509144257.1623063-1-james.clark@arm.com>
References: <20220509144257.1623063-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Get the updated header for the newly added VG register.

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

