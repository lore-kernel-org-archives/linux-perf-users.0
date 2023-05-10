Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08AEC77B7D
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 May 2023 10:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbjEJKZ4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 06:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbjEJKZz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 06:25:55 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D82692D7B
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 03:25:53 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.74])
        by gateway (Coremail) with SMTP id _____8AxnOowcVtkU1QHAA--.12182S3;
        Wed, 10 May 2023 18:25:52 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.74])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfTsvcVtk9PJTAA--.19149S2;
        Wed, 10 May 2023 18:25:52 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     acme@kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 16/17] tools arch x86: Sync the prctl headers with the kernel sources
Date:   Wed, 10 May 2023 18:25:23 +0800
Message-Id: <51a2eb7bd160c4ff1acf57f88247aafafd449e05.1683712945.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683712944.git.siyanteng@loongson.cn>
References: <cover.1683712944.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfTsvcVtk9PJTAA--.19149S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zw18AryrJryUKrW5Jr18Xwb_yoW8trWfpr
        4q9as3Gr45WrWakr1F93WkAa43Z3ykCr4Dtry2q34xX3WUA34kJr1xCrsa9FyvganYq3W8
        KF1kX34UW39YvFUanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

  commit a03c376ebaf38394 ("x86/arch_prctl: Add AMX feature numbers as ABI
   constants")
  commit b642e9e5f0dc797f ("x86/shstk: Add ARCH_SHSTK_STATUS")
  commit d30299329def886f ("x86/shstk: Add ARCH_SHSTK_UNLOCK")
  commit 44600eec3f2b708c ("x86/shstk: Support WRSS for userspace")
  commit 2e30e007142374b6 ("x86/shstk: Add user-mode shadow stack
   support")
  commit c40a7569ad82fb47 ("x86: Introduce userspace API for shadow
   stack")
  commit 23e5d9ec2bab53c4 ("x86/mm/iommu/sva: Make LAM and SVA mutually
   exclusive")
  commit 2f8794bd087e7958 ("x86/mm: Provide arch_prctl() interface for
   LAM")

Silencing these perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/prctl.h'
   differs from latest version at 'arch/x86/include/uapi/asm/prctl.h'
  diff -u tools/arch/x86/include/uapi/asm/prctl.h arch/x86/include/uapi
   /asm/prctl.h

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/arch/x86/include/uapi/asm/prctl.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/arch/x86/include/uapi/asm/prctl.h b/tools/arch/x86/include/uapi/asm/prctl.h
index 500b96e71f18..384e2cc6ac19 100644
--- a/tools/arch/x86/include/uapi/asm/prctl.h
+++ b/tools/arch/x86/include/uapi/asm/prctl.h
@@ -16,8 +16,28 @@
 #define ARCH_GET_XCOMP_GUEST_PERM	0x1024
 #define ARCH_REQ_XCOMP_GUEST_PERM	0x1025
 
+#define ARCH_XCOMP_TILECFG		17
+#define ARCH_XCOMP_TILEDATA		18
+
 #define ARCH_MAP_VDSO_X32		0x2001
 #define ARCH_MAP_VDSO_32		0x2002
 #define ARCH_MAP_VDSO_64		0x2003
 
+/* Don't use 0x3001-0x3004 because of old glibcs */
+
+#define ARCH_GET_UNTAG_MASK		0x4001
+#define ARCH_ENABLE_TAGGED_ADDR		0x4002
+#define ARCH_GET_MAX_TAG_BITS		0x4003
+#define ARCH_FORCE_TAGGED_SVA		0x4004
+
+#define ARCH_SHSTK_ENABLE		0x5001
+#define ARCH_SHSTK_DISABLE		0x5002
+#define ARCH_SHSTK_LOCK			0x5003
+#define ARCH_SHSTK_UNLOCK		0x5004
+#define ARCH_SHSTK_STATUS		0x5005
+
+/* ARCH_SHSTK_ features bits */
+#define ARCH_SHSTK_SHSTK		(1ULL <<  0)
+#define ARCH_SHSTK_WRSS			(1ULL <<  1)
+
 #endif /* _ASM_X86_PRCTL_H */
-- 
2.31.4

