Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88C7C7EE22
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 May 2023 10:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjEJKZ4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 06:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbjEJKZz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 06:25:55 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B92AD2D7E
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 03:25:54 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.74])
        by gateway (Coremail) with SMTP id _____8DxyOkxcVtkXFQHAA--.12472S3;
        Wed, 10 May 2023 18:25:53 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.74])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfTsvcVtk9PJTAA--.19149S3;
        Wed, 10 May 2023 18:25:53 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     acme@kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 17/17] tools arch arm64: Sync the perf_regs headers with the kernel sources
Date:   Wed, 10 May 2023 18:25:24 +0800
Message-Id: <84e48c9d165a71c30b7a299baaa87a22c578ca0a.1683712945.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683712944.git.siyanteng@loongson.cn>
References: <cover.1683712944.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfTsvcVtk9PJTAA--.19149S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kryftr48ArykCr1fWryxAFb_yoW8WrW5p3
        s7uwn3Cr4Uua4jy3yrAa1kXFW5Jay7XF4vv34fC3y2gF10qF18Xw4fKF1Yk3WxAFW8tayj
        kFy2vrWrZas09r7anT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bkAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r45tVCq3wAv7VC2
        z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7
        xvrVCFI7AF6II2Y40_Zr0_Gr1UMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_
        Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUvM
        qcUUUUU
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Picking the changes from:

  commit aa3e49b606e0796a ("arm64: asm/perf_regs.h: Avoid C++-style
   comment in UAPI header")
  commit 2ee0d7fd36a3f87b ("ARM64: perf: add support for perf
   registers API")
  commit cbb0c02caf4bd98b ("perf: arm64: Add SVE vector granule
   register to user regs")

Silencing these perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi
   /asm/perf_regs.h' differs from latest version at 'arch/arm64
    /include/uapi/asm/perf_regs.h'
  diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64
   /include/uapi/asm/perf_regs.h

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/arch/arm64/include/uapi/asm/perf_regs.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/arch/arm64/include/uapi/asm/perf_regs.h b/tools/arch/arm64/include/uapi/asm/perf_regs.h
index fd157f46727e..86e556429e0e 100644
--- a/tools/arch/arm64/include/uapi/asm/perf_regs.h
+++ b/tools/arch/arm64/include/uapi/asm/perf_regs.h
@@ -36,11 +36,13 @@ enum perf_event_arm_regs {
 	PERF_REG_ARM64_LR,
 	PERF_REG_ARM64_SP,
 	PERF_REG_ARM64_PC,
+	PERF_REG_ARM64_MAX,
 
 	/* Extended/pseudo registers */
-	PERF_REG_ARM64_VG = 46, // SVE Vector Granule
-
-	PERF_REG_ARM64_MAX = PERF_REG_ARM64_PC + 1,
-	PERF_REG_ARM64_EXTENDED_MAX = PERF_REG_ARM64_VG + 1
+	PERF_REG_ARM64_VG = 46,				/* SVE Vector Granule */
+	PERF_REG_ARM64_EXTENDED_MAX
 };
+
+#define PERF_REG_EXTENDED_MASK	(1ULL << PERF_REG_ARM64_VG)
+
 #endif /* _ASM_ARM64_PERF_REGS_H */
-- 
2.31.4

