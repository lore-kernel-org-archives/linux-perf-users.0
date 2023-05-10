Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD45FC77B7D
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 May 2023 10:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjEJKXk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 06:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjEJKXd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 06:23:33 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A8761FE6
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 03:23:29 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.74])
        by gateway (Coremail) with SMTP id _____8CxvOqgcFtkzlMHAA--.12109S3;
        Wed, 10 May 2023 18:23:28 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.74])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfTuXcFtkafJTAA--.19141S3;
        Wed, 10 May 2023 18:23:27 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     acme@kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 05/17] tools headers UAPI: Sync the coresight-pmu headers copy with the kernel sources
Date:   Wed, 10 May 2023 18:22:50 +0800
Message-Id: <3fffc3f39619d060dfbaa348904e1149f379638c.1683712945.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683712944.git.siyanteng@loongson.cn>
References: <cover.1683712944.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfTuXcFtkafJTAA--.19141S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7trWxZry7Ar4kGrWrGFyUKFg_yoW8GFW8pr
        sxuw4xCF43WFy8Zw4xJws5tFy2q3W7WF4qqry2gw4UCFW2yrs3XryUKr4Fyr97uFWqkFWj
        9ryIkryjkFyUWw7anT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bh8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E
        87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I
        0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCI
        bckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7
        xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4j
        6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxfHUUUUUU
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Removing CORESIGHT_TRACE_ID_UNUSED_FLAG and CORESIGHT_TRACE_ID_UNUSED_VAL.

Silencing these perf build warnings:

  Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h'
   differs from latest version at 'include/linux/coresight-pmu.h'
  diff -u tools/include/linux/coresight-pmu.h include/linux
   /coresight-pmu.h

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/include/linux/coresight-pmu.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index cef3b1c25335..51ac441a37c3 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -21,19 +21,6 @@
  */
 #define CORESIGHT_LEGACY_CPU_TRACE_ID(cpu)  (0x10 + (cpu * 2))
 
-/* CoreSight trace ID is currently the bottom 7 bits of the value */
-#define CORESIGHT_TRACE_ID_VAL_MASK	GENMASK(6, 0)
-
-/*
- * perf record will set the legacy meta data values as unused initially.
- * This allows perf report to manage the decoders created when dynamic
- * allocation in operation.
- */
-#define CORESIGHT_TRACE_ID_UNUSED_FLAG	BIT(31)
-
-/* Value to set for unused trace ID values */
-#define CORESIGHT_TRACE_ID_UNUSED_VAL	0x7F
-
 /*
  * Below are the definition of bit offsets for perf option, and works as
  * arbitrary values for all ETM versions.
-- 
2.31.4

