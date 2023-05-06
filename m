Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECDAC77B75
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 May 2023 11:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjEFLFs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 May 2023 07:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjEFLFr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 May 2023 07:05:47 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED29959E2
        for <linux-perf-users@vger.kernel.org>; Sat,  6 May 2023 04:05:45 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.110.102])
        by gateway (Coremail) with SMTP id _____8AxX+uINFZkbr0FAA--.9501S3;
        Sat, 06 May 2023 19:05:44 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxDbOFNFZkSmxNAA--.10164S5;
        Sat, 06 May 2023 19:05:44 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     peterz@infradead.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH 12/18] tools arch x86: Sync the disabled-features with the kernel sources
Date:   Sat,  6 May 2023 19:05:16 +0800
Message-Id: <d205da18ea5ac6f868db30e6e49319d7a4a116d5.1683370076.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683370076.git.siyanteng@loongson.cn>
References: <cover.1683370076.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxDbOFNFZkSmxNAA--.10164S5
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGFyUXFWUXw1UtrWrWw4UJwb_yoW5GFy7p3
        WkZFyvy3yY9F1Skw1xJFn5JFW3Jr1xGr1Ykr47Gr4kXFWYkw17ur1IyFs3AryDX393JFy2
        gF1kKwn5ZFnIkwUanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bkkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_ZF0_GryDMcIj6I8E
        87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjc
        xG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWx
        Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07bYoG
        QUUUUU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Picking the changes from:

  commit ac591488436ec62d ("x86/shstk: Add user control-protection fault
   handler")
  commit d1b5e84f943c7b5b ("x86/cpufeatures: Add CPU feature flags for
   shadow stacks")
  commit e0bddc19ba9578bc ("x86/mm: Reduce untagged_addr() overhead for
   systems without LAM")

Silencing these perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm
   /disabled-features.h' differs from latest version at 'arch/x86/include
   /asm/disabled-features.h'
  diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include
   /asm/disabled-features.h

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../arch/x86/include/asm/disabled-features.h  | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 5dfa4fb76f4b..702d93fdd10e 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -75,6 +75,12 @@
 # define DISABLE_CALL_DEPTH_TRACKING	(1 << (X86_FEATURE_CALL_DEPTH & 31))
 #endif
 
+#ifdef CONFIG_ADDRESS_MASKING
+# define DISABLE_LAM		0
+#else
+# define DISABLE_LAM		(1 << (X86_FEATURE_LAM & 31))
+#endif
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 # define DISABLE_ENQCMD		0
 #else
@@ -99,6 +105,18 @@
 # define DISABLE_TDX_GUEST	(1 << (X86_FEATURE_TDX_GUEST & 31))
 #endif
 
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+#define DISABLE_USER_SHSTK	0
+#else
+#define DISABLE_USER_SHSTK	(1 << (X86_FEATURE_USER_SHSTK & 31))
+#endif
+
+#ifdef CONFIG_X86_KERNEL_IBT
+#define DISABLE_IBT	0
+#else
+#define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -114,15 +132,15 @@
 #define DISABLED_MASK9	(DISABLE_SGX)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
-			 DISABLE_CALL_DEPTH_TRACKING)
-#define DISABLED_MASK12	0
+			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
+#define DISABLED_MASK12	(DISABLE_LAM)
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
 			 DISABLE_ENQCMD)
 #define DISABLED_MASK17	0
-#define DISABLED_MASK18	0
+#define DISABLED_MASK18	(DISABLE_IBT)
 #define DISABLED_MASK19	0
 #define DISABLED_MASK20	0
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
-- 
2.31.4

