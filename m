Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6704C77B73
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 May 2023 10:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjE3KKm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 May 2023 06:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjE3KK0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 May 2023 06:10:26 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D1C3113
        for <linux-perf-users@vger.kernel.org>; Tue, 30 May 2023 03:10:06 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cx_Op9y3Vk94UCAA--.1251S3;
        Tue, 30 May 2023 18:10:05 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axo8B6y3Vk_WqAAA--.12905S7;
        Tue, 30 May 2023 18:10:05 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, loongarch@lists.linux.dev
Subject: [PATCH RESEND v3 5/5] perf LoongArch: Simplify mksyscalltbl
Date:   Tue, 30 May 2023 18:10:01 +0800
Message-Id: <1685441401-8709-6-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1685441401-8709-1-git-send-email-yangtiezhu@loongson.cn>
References: <1685441401-8709-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Axo8B6y3Vk_WqAAA--.12905S7
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zry5GF45JrWUKry5XFyUAwb_yoW8uF47pF
        sak3srtan5ur1xCwnF9r42qFyrCw4kJr15tFyvkrWfZw43C34Fyr18Was3JFyxG3yxtFWF
        vryIqryUKa10vaDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b3kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS
        14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
        67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
        WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
        07j1pBfUUUUU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In order to print the numerical entries of the syscall table,
there is no need to call the host compiler to build and then
run a program, this can be done directly by the shell script.

This is similar with commit 9854e7ad35fe ("perf arm64: Simplify
mksyscalltbl"). For now, the mksyscalltbl file of LoongArch is
almost same with arm64.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
---
 .../arch/loongarch/entry/syscalls/mksyscalltbl     | 38 +++++++---------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
index 5fb83bd..c10ad35 100755
--- a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
@@ -18,44 +18,28 @@ if ! test -r $input; then
 	exit 1
 fi
 
-create_table_from_c()
+create_sc_table()
 {
-	local sc nr last_sc
-
-	create_table_exe=`mktemp ${TMPDIR:-/tmp}/create-table-XXXXXX`
-
-	{
-
-	cat <<-_EoHEADER
-		#include <stdio.h>
-		#include "$input"
-		int main(int argc, char *argv[])
-		{
-	_EoHEADER
+	local sc nr max_nr
 
 	while read sc nr; do
-		printf "%s\n" "	printf(\"\\t[%d] = \\\"$sc\\\",\\n\", $nr);"
-		last_sc=$nr
+		printf "%s\n" "	[$nr] = \"$sc\","
+		max_nr=$nr
 	done
 
-	printf "%s\n" "	printf(\"#define SYSCALLTBL_LOONGARCH_MAX_ID %d\\n\", $last_sc);"
-	printf "}\n"
-
-	} | $hostcc -I $incpath/include/uapi -o $create_table_exe -x c -
-
-	$create_table_exe
-
-	rm -f $create_table_exe
+	echo "#define SYSCALLTBL_LOONGARCH_MAX_ID $max_nr"
 }
 
 create_table()
 {
+	echo "#include \"$input\""
 	echo "static const char *const syscalltbl_loongarch[] = {"
-	create_table_from_c
+	create_sc_table
 	echo "};"
 }
 
-$gcc -E -dM -x c  -I $incpath/include/uapi $input	       \
-	|sed -ne 's/^#define __NR_//p' \
-	|sort -t' ' -k2 -n \
+$gcc -E -dM -x c -I $incpath/include/uapi $input \
+	|awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
+		sub("^#define __NR(3264)?_", "");
+		print | "sort -k2 -n"}' \
 	|create_table
-- 
2.1.0

