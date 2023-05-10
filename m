Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B919C77B7D
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 May 2023 10:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjEJKWX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 06:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbjEJKWW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 06:22:22 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54E342D7E
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 03:22:20 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.74])
        by gateway (Coremail) with SMTP id _____8BxKupbcFtknVMHAA--.12319S3;
        Wed, 10 May 2023 18:22:19 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.74])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxMuVXcFtkGfJTAA--.18233S3;
        Wed, 10 May 2023 18:22:19 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     acme@kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 01/17] tools headers UAPI: Sync the linux/in.h with the kernel sources
Date:   Wed, 10 May 2023 18:21:44 +0800
Message-Id: <23aabc69956ac94fbf388b05c8be08a64e8c7ccc.1683712945.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1683712944.git.siyanteng@loongson.cn>
References: <cover.1683712944.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxMuVXcFtkGfJTAA--.18233S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvdXoWrZF4xGrW7Xr47WFW7AFy3CFg_yoWfAFg_C3
        4S9rWkCr4Uur1Ig3yjkF1kXFyrK3W8Zr1qgrn3Gw10ya1DWw43Kan7Ar9rJws8Ww1DCrZ2
        qF1rXry0q3sxWjkaLaAFLSUrUUUU5b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        A7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUAVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4
        kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j
        6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8BuWPUUUUU==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Picking the changes from:

  commit 91d0b78c5177f3e4 ("inet: Add IP_LOCAL_PORT_RANGE socket option")

Silencing these perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs
   from latest version at 'include/uapi/linux/in.h'
  diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/include/uapi/linux/in.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index 07a4cb149305..4b7f2df66b99 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -162,6 +162,7 @@ struct in_addr {
 #define MCAST_MSFILTER			48
 #define IP_MULTICAST_ALL		49
 #define IP_UNICAST_IF			50
+#define IP_LOCAL_PORT_RANGE		51
 
 #define MCAST_EXCLUDE	0
 #define MCAST_INCLUDE	1
-- 
2.31.4

