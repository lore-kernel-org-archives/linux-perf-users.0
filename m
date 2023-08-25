Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E82C7EE2C
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 11:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241038AbjHYL3D (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 07:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244558AbjHYL2r (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 07:28:47 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B52E2D67
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 04:28:23 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8Cxh+hTkOhkpdAbAA--.21201S3;
        Fri, 25 Aug 2023 19:28:19 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF81QkOhk0l1jAA--.41739S3;
        Fri, 25 Aug 2023 19:28:18 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     acme@kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
Subject: [PATCH v2 1/3] perf/tools: Allow to use cpuinfo on LoongArch
Date:   Fri, 25 Aug 2023 19:28:02 +0800
Message-Id: <db968a186a10e4629fe10c26a1210f7126ad41ec.1692962043.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1692962043.git.siyanteng@loongson.cn>
References: <cover.1692962043.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF81QkOhk0l1jAA--.41739S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr45Gw4UWr4xKFWxGFW7GFX_yoW8Gr1kpr
        WDC3y7tw43WF9xKasayFsYqFW3Xrs7JFWfWrs0k3yrZr4Syrn7XryxXr45KF47XayDXw1j
        9r1DWr4DZFW8JrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1ln4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
        McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
        1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUstxhDUUUU
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Define these macros so that the CPU name can be displayed
when running perf report and perf timechart.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/perf/util/header.c    | 2 ++
 tools/perf/util/svghelper.c | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

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
index 5c62d3118c41..5744a3036b01 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -331,7 +331,10 @@ static char *cpu_model(void)
 	file = fopen("/proc/cpuinfo", "r");
 	if (file) {
 		while (fgets(buf, 255, file)) {
-			if (strstr(buf, "model name")) {
+			if (strcasestr(buf, "Model Name")) {
+				strlcpy(cpu_m, &buf[13], 255);
+				break;
+			} else if (strcasestr(buf, "model name")) {
 				strlcpy(cpu_m, &buf[13], 255);
 				break;
 			}
-- 
2.31.4

