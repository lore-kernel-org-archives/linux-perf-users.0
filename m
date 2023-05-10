Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418ABC77B7D
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 May 2023 10:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjEJKZ1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 06:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjEJKZZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 06:25:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B312F2D7B
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 03:25:23 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.74])
        by gateway (Coremail) with SMTP id _____8DxyOkScVtkKVQHAA--.12469S3;
        Wed, 10 May 2023 18:25:22 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.74])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx8a8PcVtkpvJTAA--.19327S3;
        Wed, 10 May 2023 18:25:21 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     acme@kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 13/17] tools arch x86: Sync the memcpy_64 with the kernel sources
Date:   Wed, 10 May 2023 18:24:50 +0800
Message-Id: <c1d2cde32b89c3bdb822ab5d1638f2b0f5513902.1683712945.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683712944.git.siyanteng@loongson.cn>
References: <cover.1683712944.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx8a8PcVtkpvJTAA--.19327S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF4ftr18tF43JryUWr4rZrb_yoW7JrW3pw
        1fCasrKr1vqwn5Jr97Jw1UtrZa9an7Aay5Ka1qkFWkZw1UGa9rZryIkw4UXFy3J39ag34f
        KF4kury8AFWkZaUanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bkAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26Fy26r45twAv7VC2
        z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7
        xvrVCFI7AF6II2Y40_Zr0_Gr1UMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_
        Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUgc
        _-DUUUU
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Picking the changes from:

  commit 68674f94ffc9dddc ("x86: don't use REP_GOOD or ERMS for small
   memory copies")

Silencing these perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs
   from latest version at 'arch/x86/lib/memcpy_64.S'
  diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
  Warning: Kernel ABI header at 'tools/arch/x86/lib/memset_64.S' differs
   from latest version at 'arch/x86/lib/memset_64.S'
  diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/arch/x86/lib/memcpy_64.S | 35 ++++++++-----------------
 tools/arch/x86/lib/memset_64.S | 47 ++++++++--------------------------
 2 files changed, 22 insertions(+), 60 deletions(-)

diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index a91ac666f758..8f95fb267caa 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -2,6 +2,7 @@
 /* Copyright 2002 Andi Kleen */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
@@ -9,13 +10,6 @@
 
 .section .noinstr.text, "ax"
 
-/*
- * We build a jump to memcpy_orig by default which gets NOPped out on
- * the majority of x86 CPUs which set REP_GOOD. In addition, CPUs which
- * have the enhanced REP MOVSB/STOSB feature (ERMS), change those NOPs
- * to a jmp to memcpy_erms which does the REP; MOVSB mem copy.
- */
-
 /*
  * memcpy - Copy a memory block.
  *
@@ -26,17 +20,21 @@
  *
  * Output:
  * rax original destination
+ *
+ * The FSRM alternative should be done inline (avoiding the call and
+ * the disgusting return handling), but that would require some help
+ * from the compiler for better calling conventions.
+ *
+ * The 'rep movsb' itself is small enough to replace the call, but the
+ * two register moves blow up the code. And one of them is "needed"
+ * only for the return value that is the same as the source input,
+ * which the compiler could/should do much better anyway.
  */
 SYM_TYPED_FUNC_START(__memcpy)
-	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
-		      "jmp memcpy_erms", X86_FEATURE_ERMS
+	ALTERNATIVE "jmp memcpy_orig", "", X86_FEATURE_FSRM
 
 	movq %rdi, %rax
 	movq %rdx, %rcx
-	shrq $3, %rcx
-	andl $7, %edx
-	rep movsq
-	movl %edx, %ecx
 	rep movsb
 	RET
 SYM_FUNC_END(__memcpy)
@@ -45,17 +43,6 @@ EXPORT_SYMBOL(__memcpy)
 SYM_FUNC_ALIAS(memcpy, __memcpy)
 EXPORT_SYMBOL(memcpy)
 
-/*
- * memcpy_erms() - enhanced fast string memcpy. This is faster and
- * simpler than memcpy. Use memcpy_erms when possible.
- */
-SYM_FUNC_START_LOCAL(memcpy_erms)
-	movq %rdi, %rax
-	movq %rdx, %rcx
-	rep movsb
-	RET
-SYM_FUNC_END(memcpy_erms)
-
 SYM_FUNC_START_LOCAL(memcpy_orig)
 	movq %rdi, %rax
 
diff --git a/tools/arch/x86/lib/memset_64.S b/tools/arch/x86/lib/memset_64.S
index 6143b1a6fa2c..7c59a704c458 100644
--- a/tools/arch/x86/lib/memset_64.S
+++ b/tools/arch/x86/lib/memset_64.S
@@ -18,27 +18,22 @@
  * rdx   count (bytes)
  *
  * rax   original destination
+ *
+ * The FSRS alternative should be done inline (avoiding the call and
+ * the disgusting return handling), but that would require some help
+ * from the compiler for better calling conventions.
+ *
+ * The 'rep stosb' itself is small enough to replace the call, but all
+ * the register moves blow up the code. And two of them are "needed"
+ * only for the return value that is the same as the source input,
+ * which the compiler could/should do much better anyway.
  */
 SYM_FUNC_START(__memset)
-	/*
-	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
-	 * to use it when possible. If not available, use fast string instructions.
-	 *
-	 * Otherwise, use original memset function.
-	 */
-	ALTERNATIVE_2 "jmp memset_orig", "", X86_FEATURE_REP_GOOD, \
-		      "jmp memset_erms", X86_FEATURE_ERMS
+	ALTERNATIVE "jmp memset_orig", "", X86_FEATURE_FSRS
 
 	movq %rdi,%r9
+	movb %sil,%al
 	movq %rdx,%rcx
-	andl $7,%edx
-	shrq $3,%rcx
-	/* expand byte value  */
-	movzbl %sil,%esi
-	movabs $0x0101010101010101,%rax
-	imulq %rsi,%rax
-	rep stosq
-	movl %edx,%ecx
 	rep stosb
 	movq %r9,%rax
 	RET
@@ -48,26 +43,6 @@ EXPORT_SYMBOL(__memset)
 SYM_FUNC_ALIAS(memset, __memset)
 EXPORT_SYMBOL(memset)
 
-/*
- * ISO C memset - set a memory block to a byte value. This function uses
- * enhanced rep stosb to override the fast string function.
- * The code is simpler and shorter than the fast string function as well.
- *
- * rdi   destination
- * rsi   value (char)
- * rdx   count (bytes)
- *
- * rax   original destination
- */
-SYM_FUNC_START_LOCAL(memset_erms)
-	movq %rdi,%r9
-	movb %sil,%al
-	movq %rdx,%rcx
-	rep stosb
-	movq %r9,%rax
-	RET
-SYM_FUNC_END(memset_erms)
-
 SYM_FUNC_START_LOCAL(memset_orig)
 	movq %rdi,%r10
 
-- 
2.31.4

