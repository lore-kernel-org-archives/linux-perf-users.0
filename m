Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E3AC77B73
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 May 2023 11:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjEFLGu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 May 2023 07:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjEFLGs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 May 2023 07:06:48 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C0F67EF0
        for <linux-perf-users@vger.kernel.org>; Sat,  6 May 2023 04:06:41 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.110.102])
        by gateway (Coremail) with SMTP id _____8Ax3erBNFZkg70FAA--.9389S3;
        Sat, 06 May 2023 19:06:41 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxD7+_NFZkZWxNAA--.10396S2;
        Sat, 06 May 2023 19:06:40 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     peterz@infradead.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH 13/18] tools arch x86: Sync the memcpy_64 with the kernel sources
Date:   Sat,  6 May 2023 19:06:10 +0800
Message-Id: <4c88321d9f0fc1f74e25ae8e1f713ca71213d028.1683370076.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683370076.git.siyanteng@loongson.cn>
References: <cover.1683370076.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxD7+_NFZkZWxNAA--.10396S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF4ftr18tF43JryUWr4rZrb_yoW7JrW3pw
        1fCasrKr1vqwn5Jr97Jw1UtrZa9an7Aay5Ka1qkFWkZw1UGa9rZryIkw4UXFy3J39ag34f
        KF4kury8AFWkZaUanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

