Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B478DC1B0D9
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Dec 2020 08:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F6B225AB
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Dec 2020 08:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgLNIqI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Dec 2020 03:46:08 -0500
Received: from foss.arm.com ([217.140.110.172]:44556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407115AbgLNIqG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Dec 2020 03:46:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97C6E1FB;
        Mon, 14 Dec 2020 00:45:16 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.30.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC4BC3F66E;
        Mon, 14 Dec 2020 00:45:13 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, will@kernel.org,
        leo.yan@linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Grant <al.grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2] drivers/perf: Enable PID_IN_CONTEXTIDR with SPE
Date:   Mon, 14 Dec 2020 10:45:02 +0200
Message-Id: <20201214084502.19954-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Enable PID_IN_CONTEXTIDR by default when Arm SPE is enabled.
This flag is required to get PID data in the SPE trace. Without
it the perf tool will report 0 for PID which isn't very useful,
especially when doing system wide profiling or profiling
applications that fork.

There is a small performance overhead when enabling
PID_IN_CONTEXTIDR, but SPE itself is optional and not enabled by
default so the impact is minimised.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Al Grant <al.grant@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 265c4461031f..b030bb21a0bb 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -2,6 +2,7 @@
 
 config PID_IN_CONTEXTIDR
 	bool "Write the current PID to the CONTEXTIDR register"
+	default y if ARM_SPE_PMU
 	help
 	  Enabling this option causes the kernel to write the current PID to
 	  the CONTEXTIDR register, at the expense of some additional
-- 
2.28.0

