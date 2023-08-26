Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E98C83F15
	for <linux-perf-users@archiver.kernel.org>; Sat, 26 Aug 2023 09:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjHZJmo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 26 Aug 2023 05:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjHZJmY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 26 Aug 2023 05:42:24 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87C372D48
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Aug 2023 02:41:55 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8BxY_B8yOlkDyccAA--.57512S3;
        Sat, 26 Aug 2023 17:40:12 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHCN4yOlkVCFkAA--.26955S5;
        Sat, 26 Aug 2023 17:40:11 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     acme@kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
Subject: [PATCH v3 3/3] perf/trace: Use "test -f" instead of "[-f FILE]"
Date:   Sat, 26 Aug 2023 17:40:02 +0800
Message-Id: <b9fc1affbca15cbf18cc23905f823047b4e2f1b6.1693040967.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1693040967.git.siyanteng@loongson.cn>
References: <cover.1693040967.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHCN4yOlkVCFkAA--.26955S5
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw4xCr4xWFWkZF1xtFyrAFc_yoW5tF17pw
        n5A398Gr47XryUA34IqF90qF45Kwn2q3W5uw4kCrZrCF18Gry7JrZ8ZwnIyF18WwsIg3yI
        93yDuFy8tF4vqFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY
        6Fy7McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
        k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jDl1kUUUUU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It will be simpler without that extra subshell, so
let's use "test -f".

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/perf/trace/beauty/mmap_flags.sh | 9 ++++++---
 tools/perf/trace/beauty/mmap_prot.sh  | 5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
index d035b29fc5ec..6ecdb3c5a99e 100755
--- a/tools/perf/trace/beauty/mmap_flags.sh
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -19,7 +19,8 @@ arch_mman=${arch_header_dir}/mman.h
 
 printf "static const char *mmap_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MAP_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
-([ -f ${arch_mman} ] && grep -E -q $regex ${arch_mman}) && \
+test -f ${arch_mman} && \
+grep -E -q $regex ${arch_mman} && \
 (grep -E $regex ${arch_mman} | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
@@ -28,12 +29,14 @@ grep -E -q $regex ${linux_mman} && \
 	grep -E -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g" | \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
-([ ! -f ${arch_mman} ] || grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*' ${arch_mman}) &&
+( ! test -f ${arch_mman} || \
+grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*' ${arch_mman}) &&
 (grep -E $regex ${header_dir}/mman-common.h | \
 	grep -E -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
-([ ! -f ${arch_mman} ] || grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.h>.*' ${arch_mman}) &&
+( ! test -f ${arch_mman} || \
+grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.h>.*' ${arch_mman}) &&
 (grep -E $regex ${header_dir}/mman.h | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
diff --git a/tools/perf/trace/beauty/mmap_prot.sh b/tools/perf/trace/beauty/mmap_prot.sh
index 49e8c865214b..4436fcd6e861 100755
--- a/tools/perf/trace/beauty/mmap_prot.sh
+++ b/tools/perf/trace/beauty/mmap_prot.sh
@@ -17,12 +17,13 @@ prefix="PROT"
 
 printf "static const char *mmap_prot[] = {\n"
 regex=`printf '^[[:space:]]*#[[:space:]]*define[[:space:]]+%s_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*' ${prefix}`
-([ ! -f ${arch_mman} ] || grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*' ${arch_mman}) &&
+( ! test -f ${arch_mman} \
+|| grep -E -q '#[[:space:]]*include[[:space:]]+.*uapi/asm-generic/mman.*' ${arch_mman}) &&
 (grep -E $regex ${common_mman} | \
 	grep -E -vw PROT_NONE | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef ${prefix}_%s\n#define ${prefix}_%s %s\n#endif\n")
-[ -f ${arch_mman} ] && grep -E -q $regex ${arch_mman} &&
+test -f ${arch_mman} && grep -E -q $regex ${arch_mman} &&
 (grep -E $regex ${arch_mman} | \
 	grep -E -vw PROT_NONE | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
-- 
2.31.4

