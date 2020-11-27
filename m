Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59795C2D0E4
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Nov 2020 15:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B83520795
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Nov 2020 15:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbgK0Pjf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 27 Nov 2020 10:39:35 -0500
Received: from foss.arm.com ([217.140.110.172]:44846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730980AbgK0Pjf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 Nov 2020 10:39:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83A1F1516;
        Fri, 27 Nov 2020 07:39:34 -0800 (PST)
Received: from e125528.arm.com (unknown [10.57.62.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 154973F70D;
        Fri, 27 Nov 2020 07:39:32 -0800 (PST)
From:   Alexandre Truong <alexandre.truong@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     james.clark@arm.com, Alexandre Truong <alexandre.truong@arm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf tools: add aarch64 registers to --user-regs
Date:   Fri, 27 Nov 2020 15:39:23 +0000
Message-Id: <20201127153923.26717-1-alexandre.truong@arm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Previously, this command returns no help message on aarch64:

  -> ./perf record --user-regs=?

  available registers:
  Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

With this change, the registers are listed.

  -> ./perf record --user-regs=?

  available registers: x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28 x29 lr sp pc

It's also now possible to record subsets of registers on aarch64:

  -> ./perf record --user-regs=x4,x5 ls
  -> ./perf report --dump-raw-trace

  12801163749305260 0xc70 [0x40]: PERF_RECORD_SAMPLE(IP, 0x2): 51956/51956: 0xffffaa6571f0 period: 145785 addr: 0
  ... user regs: mask 0x30 ABI 64-bit
  .... x4    0x000000000000006c
  .... x5    0x0000001001000001
   ... thread: ls:51956
    ...... dso: /usr/lib64/ld-2.17.so

Cc: John Garry <john.garry@huawei.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
---
 tools/perf/arch/arm64/util/perf_regs.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
index 2833e101a..54efa12fd 100644
--- a/tools/perf/arch/arm64/util/perf_regs.c
+++ b/tools/perf/arch/arm64/util/perf_regs.c
@@ -2,5 +2,38 @@
 #include "../../../util/perf_regs.h"
 
 const struct sample_reg sample_reg_masks[] = {
+	SMPL_REG(x0, PERF_REG_ARM64_X0),
+	SMPL_REG(x1, PERF_REG_ARM64_X1),
+	SMPL_REG(x2, PERF_REG_ARM64_X2),
+	SMPL_REG(x3, PERF_REG_ARM64_X3),
+	SMPL_REG(x4, PERF_REG_ARM64_X4),
+	SMPL_REG(x5, PERF_REG_ARM64_X5),
+	SMPL_REG(x6, PERF_REG_ARM64_X6),
+	SMPL_REG(x7, PERF_REG_ARM64_X7),
+	SMPL_REG(x8, PERF_REG_ARM64_X8),
+	SMPL_REG(x9, PERF_REG_ARM64_X9),
+	SMPL_REG(x10, PERF_REG_ARM64_X10),
+	SMPL_REG(x11, PERF_REG_ARM64_X11),
+	SMPL_REG(x12, PERF_REG_ARM64_X12),
+	SMPL_REG(x13, PERF_REG_ARM64_X13),
+	SMPL_REG(x14, PERF_REG_ARM64_X14),
+	SMPL_REG(x15, PERF_REG_ARM64_X15),
+	SMPL_REG(x16, PERF_REG_ARM64_X16),
+	SMPL_REG(x17, PERF_REG_ARM64_X17),
+	SMPL_REG(x18, PERF_REG_ARM64_X18),
+	SMPL_REG(x19, PERF_REG_ARM64_X19),
+	SMPL_REG(x20, PERF_REG_ARM64_X20),
+	SMPL_REG(x21, PERF_REG_ARM64_X21),
+	SMPL_REG(x22, PERF_REG_ARM64_X22),
+	SMPL_REG(x23, PERF_REG_ARM64_X23),
+	SMPL_REG(x24, PERF_REG_ARM64_X24),
+	SMPL_REG(x25, PERF_REG_ARM64_X25),
+	SMPL_REG(x26, PERF_REG_ARM64_X26),
+	SMPL_REG(x27, PERF_REG_ARM64_X27),
+	SMPL_REG(x28, PERF_REG_ARM64_X28),
+	SMPL_REG(x29, PERF_REG_ARM64_X29),
+	SMPL_REG(lr, PERF_REG_ARM64_LR),
+	SMPL_REG(sp, PERF_REG_ARM64_SP),
+	SMPL_REG(pc, PERF_REG_ARM64_PC),
 	SMPL_REG_END
 };
-- 
2.23.0

