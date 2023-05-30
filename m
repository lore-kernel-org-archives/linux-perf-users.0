Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456D8C7EE31
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 May 2023 10:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjE3KKl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 May 2023 06:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjE3KKX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 May 2023 06:10:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE625106
        for <linux-perf-users@vger.kernel.org>; Tue, 30 May 2023 03:10:05 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bx2fF8y3Vk5YUCAA--.5785S3;
        Tue, 30 May 2023 18:10:04 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axo8B6y3Vk_WqAAA--.12905S3;
        Tue, 30 May 2023 18:10:03 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, loongarch@lists.linux.dev
Subject: [PATCH RESEND v3 1/5] perf tools: Declare syscalltbl_*[] as const for all archs
Date:   Tue, 30 May 2023 18:09:57 +0800
Message-Id: <1685441401-8709-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1685441401-8709-1-git-send-email-yangtiezhu@loongson.cn>
References: <1685441401-8709-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Axo8B6y3Vk_WqAAA--.12905S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKw4kurWxJr4UJF17Aw4fKrg_yoWxGr1Dp3
        Z2kw1kJ3Z5Wr1rA34Igw4jqFyrurn7Gr12qryjkrZxArsxJ343trWUXa95tFWfX34xGrWj
        vrW8Xry5GF1IqF7anT9S1TB71UUUU87qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JFv_Jw1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS
        14v26r4a6rW5M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
        67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4
        kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j
        6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jgKsUUUUUU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

syscalltbl_*[] should never be changing, let us declare it as const.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl     |  2 +-
 tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl |  2 +-
 tools/perf/arch/mips/entry/syscalls/mksyscalltbl      |  2 +-
 tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl   |  2 +-
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl      |  2 +-
 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh      |  2 +-
 tools/perf/util/syscalltbl.c                          | 14 +++++++-------
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
index 22cdf91..4edcdf6 100755
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -34,7 +34,7 @@ create_table_from_c()
 create_table()
 {
 	echo "#include \"$input\""
-	echo "static const char *syscalltbl_arm64[] = {"
+	echo "static const char *const syscalltbl_arm64[] = {"
 	create_table_from_c
 	echo "};"
 }
diff --git a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
index c52156f..5fb83bd 100755
--- a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
@@ -50,7 +50,7 @@ create_table_from_c()
 
 create_table()
 {
-	echo "static const char *syscalltbl_loongarch[] = {"
+	echo "static const char *const syscalltbl_loongarch[] = {"
 	create_table_from_c
 	echo "};"
 }
diff --git a/tools/perf/arch/mips/entry/syscalls/mksyscalltbl b/tools/perf/arch/mips/entry/syscalls/mksyscalltbl
index fb1f494..c0d93f9 100644
--- a/tools/perf/arch/mips/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/mips/entry/syscalls/mksyscalltbl
@@ -18,7 +18,7 @@ create_table()
 {
 	local max_nr nr abi sc discard
 
-	echo 'static const char *syscalltbl_mips_n64[] = {'
+	echo 'static const char *const syscalltbl_mips_n64[] = {'
 	while read nr abi sc discard; do
 		printf '\t[%d] = "%s",\n' $nr $sc
 		max_nr=$nr
diff --git a/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl b/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
index 6c58060..0eb316f 100755
--- a/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
@@ -23,7 +23,7 @@ create_table()
 	max_nr=-1
 	nr=0
 
-	echo "static const char *syscalltbl_powerpc_${wordsize}[] = {"
+	echo "static const char *const syscalltbl_powerpc_${wordsize}[] = {"
 	while read nr abi sc discard; do
 		if [ "$max_nr" -lt "$nr" ]; then
 			printf '\t[%d] = "%s",\n' $nr $sc
diff --git a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl b/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
index 72ecbb6..52eb88a 100755
--- a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
@@ -18,7 +18,7 @@ create_table()
 {
 	local max_nr nr abi sc discard
 
-	echo 'static const char *syscalltbl_s390_64[] = {'
+	echo 'static const char *const syscalltbl_s390_64[] = {'
 	while read nr abi sc discard; do
 		printf '\t[%d] = "%s",\n' $nr $sc
 		max_nr=$nr
diff --git a/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh b/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh
index 029a72c..fa526a9 100755
--- a/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh
@@ -18,7 +18,7 @@ emit() {
     syscall_macro "$nr" "$entry"
 }
 
-echo "static const char *syscalltbl_${arch}[] = {"
+echo "static const char *const syscalltbl_${arch}[] = {"
 
 sorted_table=$(mktemp /tmp/syscalltbl.XXXXXX)
 grep '^[0-9]' "$in" | sort -n > $sorted_table
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 313ecce..63be7b5 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -17,31 +17,31 @@
 #if defined(__x86_64__)
 #include <asm/syscalls_64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_x86_64_MAX_ID;
-static const char **syscalltbl_native = syscalltbl_x86_64;
+static const char *const *syscalltbl_native = syscalltbl_x86_64;
 #elif defined(__s390x__)
 #include <asm/syscalls_64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_S390_64_MAX_ID;
-static const char **syscalltbl_native = syscalltbl_s390_64;
+static const char *const *syscalltbl_native = syscalltbl_s390_64;
 #elif defined(__powerpc64__)
 #include <asm/syscalls_64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_64_MAX_ID;
-static const char **syscalltbl_native = syscalltbl_powerpc_64;
+static const char *const *syscalltbl_native = syscalltbl_powerpc_64;
 #elif defined(__powerpc__)
 #include <asm/syscalls_32.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_32_MAX_ID;
-static const char **syscalltbl_native = syscalltbl_powerpc_32;
+static const char *const *syscalltbl_native = syscalltbl_powerpc_32;
 #elif defined(__aarch64__)
 #include <asm/syscalls.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_ARM64_MAX_ID;
-static const char **syscalltbl_native = syscalltbl_arm64;
+static const char *const *syscalltbl_native = syscalltbl_arm64;
 #elif defined(__mips__)
 #include <asm/syscalls_n64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_MIPS_N64_MAX_ID;
-static const char **syscalltbl_native = syscalltbl_mips_n64;
+static const char *const *syscalltbl_native = syscalltbl_mips_n64;
 #elif defined(__loongarch__)
 #include <asm/syscalls.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
-static const char **syscalltbl_native = syscalltbl_loongarch;
+static const char *const *syscalltbl_native = syscalltbl_loongarch;
 #endif
 
 struct syscall {
-- 
2.1.0

