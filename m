Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C4AC47080
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 11:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73757613CB
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 11:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhFALzv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 07:55:51 -0400
Received: from mail.loongson.cn ([114.242.206.163]:46770 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230288AbhFALzv (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 07:55:51 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxkOLVH7Zge0QIAA--.5303S2;
        Tue, 01 Jun 2021 19:53:57 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH] perf tools: Copy uapi/asm/perf_regs.h from the kernel for MIPS
Date:   Tue,  1 Jun 2021 19:53:56 +0800
Message-Id: <1622548436-12472-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9BxkOLVH7Zge0QIAA--.5303S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF45uF4xGF1UGrWfGry3Arb_yoW5Zry7pF
        ZrC34rJw4v93yak3yFyFyUWr13trWxXFZFv3yfCry7ZF42yF1rXwn7Kr13Kw1xJr4xta17
        CFyxWr4UAF10yw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUsyCJUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

To allow the build to complete on older systems, where those files are
either not uptodate, lacking some recent additions or not present at
all.

And check if the copy drifts from the kernel.

This commit is similar with
commit 12f020338a2c ("tools: Copy uapi/asm/perf_regs.h from the kernel")

With this commit, we can avoid the following build error in any case:

tools/perf/arch/mips/include/perf_regs.h:7:10:
fatal error: asm/perf_regs.h: No such file or directory
 #include <asm/perf_regs.h>
          ^~~~~~~~~~~~~~~~~
compilation terminated.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/arch/mips/include/uapi/asm/perf_regs.h | 40 ++++++++++++++++++++++++++++
 tools/perf/Makefile.config                   |  1 -
 tools/perf/check-headers.sh                  |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 tools/arch/mips/include/uapi/asm/perf_regs.h

diff --git a/tools/arch/mips/include/uapi/asm/perf_regs.h b/tools/arch/mips/include/uapi/asm/perf_regs.h
new file mode 100644
index 0000000..d0f4ecd
--- /dev/null
+++ b/tools/arch/mips/include/uapi/asm/perf_regs.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_MIPS_PERF_REGS_H
+#define _ASM_MIPS_PERF_REGS_H
+
+enum perf_event_mips_regs {
+	PERF_REG_MIPS_PC,
+	PERF_REG_MIPS_R1,
+	PERF_REG_MIPS_R2,
+	PERF_REG_MIPS_R3,
+	PERF_REG_MIPS_R4,
+	PERF_REG_MIPS_R5,
+	PERF_REG_MIPS_R6,
+	PERF_REG_MIPS_R7,
+	PERF_REG_MIPS_R8,
+	PERF_REG_MIPS_R9,
+	PERF_REG_MIPS_R10,
+	PERF_REG_MIPS_R11,
+	PERF_REG_MIPS_R12,
+	PERF_REG_MIPS_R13,
+	PERF_REG_MIPS_R14,
+	PERF_REG_MIPS_R15,
+	PERF_REG_MIPS_R16,
+	PERF_REG_MIPS_R17,
+	PERF_REG_MIPS_R18,
+	PERF_REG_MIPS_R19,
+	PERF_REG_MIPS_R20,
+	PERF_REG_MIPS_R21,
+	PERF_REG_MIPS_R22,
+	PERF_REG_MIPS_R23,
+	PERF_REG_MIPS_R24,
+	PERF_REG_MIPS_R25,
+	PERF_REG_MIPS_R26,
+	PERF_REG_MIPS_R27,
+	PERF_REG_MIPS_R28,
+	PERF_REG_MIPS_R29,
+	PERF_REG_MIPS_R30,
+	PERF_REG_MIPS_R31,
+	PERF_REG_MIPS_MAX = PERF_REG_MIPS_R31 + 1,
+};
+#endif /* _ASM_MIPS_PERF_REGS_H */
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 406a951..73df23d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -90,7 +90,6 @@ endif
 ifeq ($(ARCH),mips)
   NO_PERF_REGS := 0
   CFLAGS += -I$(OUTPUT)arch/mips/include/generated
-  CFLAGS += -I../../arch/mips/include/uapi -I../../arch/mips/include/generated/uapi
   LIBUNWIND_LIBS = -lunwind -lunwind-mips
 endif
 
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index dd8ff28..c783558 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -39,6 +39,7 @@ arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
 arch/arm/include/uapi/asm/perf_regs.h
 arch/arm64/include/uapi/asm/perf_regs.h
+arch/mips/include/uapi/asm/perf_regs.h
 arch/powerpc/include/uapi/asm/perf_regs.h
 arch/s390/include/uapi/asm/perf_regs.h
 arch/x86/include/uapi/asm/perf_regs.h
-- 
2.1.0

