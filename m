Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E00CC83F18
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Aug 2023 13:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbjH2NVt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Aug 2023 09:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbjH2NV0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Aug 2023 09:21:26 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 314B4CCF
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 06:21:19 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8BxnuvO8O1k2cQcAA--.56356S3;
        Tue, 29 Aug 2023 21:21:18 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc_K8O1k9nxmAA--.51623S5;
        Tue, 29 Aug 2023 21:21:18 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     acme@kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
Subject: [PATCH v4 3/3] perf/trace: Use "test -f" instead of "[-f FILE]"
Date:   Tue, 29 Aug 2023 21:21:13 +0800
Message-Id: <f9be0afa0c6aa653dc8024aa33b1388c746a7681.1693315043.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1693315043.git.siyanteng@loongson.cn>
References: <cover.1693315043.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxDc_K8O1k9nxmAA--.51623S5
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuryfWr1Uur13Kry3GFWDWrX_yoW5Kryxpw
        n5A398Gr47Xr1UAw1IqF90qF45Kwn2q3WUuw4kArZrCF1UGry7JrZ8ZwnIyF18XwsIg3yI
        93yDuFy8tF4vqFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
        xVW0oVCq3wAaw2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_
        ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jDl1kUUUUU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

"[" is part of the shell builtin test (and a synonym for it),
 not a link to the external command /usr/bin/test.

Using the "test" is simpler because it avoids a lot of "[]".

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

