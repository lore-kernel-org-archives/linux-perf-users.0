Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9124C77B75
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 May 2023 11:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjEFLHH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 May 2023 07:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjEFLHG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 May 2023 07:07:06 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 643FA30FA
        for <linux-perf-users@vger.kernel.org>; Sat,  6 May 2023 04:07:04 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.110.102])
        by gateway (Coremail) with SMTP id _____8CxuOnXNFZkr70FAA--.9453S3;
        Sat, 06 May 2023 19:07:03 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHLfWNFZkcmxNAA--.10016S2;
        Sat, 06 May 2023 19:07:03 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     peterz@infradead.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH 16/18] tools arch x86: Sync the prctl headers with the kernel sources
Date:   Sat,  6 May 2023 19:06:31 +0800
Message-ID: <7cff9f72da3e9aa078824545f5936c82464bdba3.1683370076.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683370076.git.siyanteng@loongson.cn>
References: <cover.1683370076.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHLfWNFZkcmxNAA--.10016S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zw18AryrJryUKrW5Jr18Xwb_yoW8trWfpr
        4q9as3Gr45WrWakr1F93WkAa43Z3ykCr4Dtry2q34xX3WUA34kJr1xCrsa9FyvganYq3W8
        KF1kX34UW39YvFUanT9S1TB71UUUU8UqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bkkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
        w2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Gryq6s0DMcIj6I8E
        87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjc
        xG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWx
        Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07bd1v
        3UUUUU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
Message-ID: <20230506110631.dxT5_DiyU_GiknBpKrSc0yf44LYQpHJNg8-GsI_CUf4@z>

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

