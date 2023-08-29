Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2CCC83F1A
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Aug 2023 13:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjH2NVx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Aug 2023 09:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbjH2NVX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Aug 2023 09:21:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56483187
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 06:21:18 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8DxBfHM8O1kw8QcAA--.58939S3;
        Tue, 29 Aug 2023 21:21:16 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc_K8O1k9nxmAA--.51623S3;
        Tue, 29 Aug 2023 21:21:16 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     acme@kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v4 1/3] perf/tools: Allow to use cpuinfo on LoongArch
Date:   Tue, 29 Aug 2023 21:21:11 +0800
Message-Id: <76cfe6d6f89a2ad8fd863e02e495637c4e30556d.1693315043.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1693315043.git.siyanteng@loongson.cn>
References: <cover.1693315043.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxDc_K8O1k9nxmAA--.51623S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw4ktw4DZw43ur4UJFyrGrX_yoW8JFW7pr
        WDC3y7tw45GF9xK3Zayan5XFW3Xrs7XFWfuws5K3y5Zr1Sywn7XryxXFs8KF47Xa4DJw1j
        9r1DWr4DZFW8JrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
        xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Define these macros so that the CPU name can be displayed
when running perf report and perf timechart.

Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/perf/util/header.c    | 2 ++
 tools/perf/util/svghelper.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 52fbf526fe74..c6e19192bd28 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -456,6 +456,8 @@ static int write_cpudesc(struct feat_fd *ff,
 #define CPUINFO_PROC	{ "Processor", }
 #elif defined(__xtensa__)
 #define CPUINFO_PROC	{ "core ID", }
+#elif defined(__loongarch__)
+#define CPUINFO_PROC	{ "Model Name", }
 #else
 #define CPUINFO_PROC	{ "model name", }
 #endif
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 5c62d3118c41..2e141126b0d6 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -331,7 +331,7 @@ static char *cpu_model(void)
 	file = fopen("/proc/cpuinfo", "r");
 	if (file) {
 		while (fgets(buf, 255, file)) {
-			if (strstr(buf, "model name")) {
+			if (strcasestr(buf, "model Name")) {
 				strlcpy(cpu_m, &buf[13], 255);
 				break;
 			}
-- 
2.31.4

