Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDBCC7EE22
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 May 2023 10:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbjEJKXl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 06:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbjEJKXf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 06:23:35 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A2086189
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 03:23:30 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.74])
        by gateway (Coremail) with SMTP id _____8DxZPChcFtk11MHAA--.12326S3;
        Wed, 10 May 2023 18:23:29 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.74])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfTuXcFtkafJTAA--.19141S4;
        Wed, 10 May 2023 18:23:28 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     acme@kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 06/17] tools headers UAPI: Sync the linux/const.h with the kernel headers
Date:   Wed, 10 May 2023 18:22:51 +0800
Message-Id: <33e963df304394f932d9108a1b0bb327f23a4eca.1683712945.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683712944.git.siyanteng@loongson.cn>
References: <cover.1683712944.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfTuXcFtkafJTAA--.19141S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvdXoW7Jryruw4rGw4DXF4fWF1kGrg_yoWkArcEk3
        yfGr4kCr1kuFySgr4jyFyDur10gF17AFyqgw1fJr1rZa9Fya15Gw1xCr9xJFZ8u39rCFWI
        qF1rXrWFq39rWjkaLaAFLSUrUUUU5b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        t7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2
        jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
        0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
        Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2XdUUUUUU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Picking the changes from:

  commit 31088f6f7906253e ("uapi/linux/const.h: prefer ISO-friendly
   __typeof__")

Silencing these perf build warnings::

  Warning: Kernel ABI header at 'tools/include/uapi/linux/const.h' differs
   from latest version at 'include/uapi/linux/const.h'
  diff -u tools/include/uapi/linux/const.h include/uapi/linux/const.h

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/include/uapi/linux/const.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/const.h b/tools/include/uapi/linux/const.h
index af2a44c08683..a429381e7ca5 100644
--- a/tools/include/uapi/linux/const.h
+++ b/tools/include/uapi/linux/const.h
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
-#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
+#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
 #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 
 #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-- 
2.31.4

