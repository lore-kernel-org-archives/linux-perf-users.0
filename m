Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870EAC83F01
	for <linux-perf-users@archiver.kernel.org>; Sat, 26 Aug 2023 09:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjHZJmq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 26 Aug 2023 05:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjHZJmd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 26 Aug 2023 05:42:33 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7E4A2108
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Aug 2023 02:42:10 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8Ax1fB7yOlkBSccAA--.57399S3;
        Sat, 26 Aug 2023 17:40:11 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHCN4yOlkVCFkAA--.26955S4;
        Sat, 26 Aug 2023 17:40:10 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     acme@kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v3 2/3] perf/trace: Fix mmap_flags for archs use generic mman.h
Date:   Sat, 26 Aug 2023 17:40:01 +0800
Message-Id: <f9f54f799a9248717b411d60b076cc7cfde1fb6f.1693040967.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1693040967.git.siyanteng@loongson.cn>
References: <cover.1693040967.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHCN4yOlkVCFkAA--.26955S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GrW8urW5JrWDCF43XFW8GrX_yoWkXrb_K3
        yI9w10k345Jry2yanxu3s8Cw1kXan8AF9akr10gw18AFy8tF18W3y7Cas7Ar15K3s0gFn7
        ur1fXr4kAwsxJosvyTuYvTs0mTUanT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Cr1j6rxdM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
        xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Silence this warning:

grep: /root/linux-next/tools/arch/xxxxx/include/uapi/asm//mman.h:
No such file or directory

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
---
 tools/perf/trace/beauty/mmap_flags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
index 3022597c8c17..d035b29fc5ec 100755
--- a/tools/perf/trace/beauty/mmap_flags.sh
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -19,7 +19,7 @@ arch_mman=${arch_header_dir}/mman.h
 
 printf "static const char *mmap_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MAP_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
-grep -E -q $regex ${arch_mman} && \
+([ -f ${arch_mman} ] && grep -E -q $regex ${arch_mman}) && \
 (grep -E $regex ${arch_mman} | \
 	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
-- 
2.31.4

