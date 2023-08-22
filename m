Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30861EE49A8
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Aug 2023 09:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjHVJci (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Aug 2023 05:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjHVJch (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Aug 2023 05:32:37 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85770E47
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 02:32:20 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8Bxd+ijgORkCt8aAA--.18954S3;
        Tue, 22 Aug 2023 17:32:19 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB82ZgORkHzRgAA--.30982S4;
        Tue, 22 Aug 2023 17:32:17 +0800 (CST)
From:   Yanteng Si <siyanteng@loongson.cn>
To:     acme@kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>, mingo@redhat.com,
        peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
Subject: [PATCH v1 2/2] perf/tools: Allow to use cpuinfo on loongarch
Date:   Tue, 22 Aug 2023 17:32:07 +0800
Message-Id: <fbb71a04bf3b19b1d1b239e464c1acbcc572e9a8.1692694595.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1692694595.git.siyanteng@loongson.cn>
References: <cover.1692694595.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxB82ZgORkHzRgAA--.30982S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr45Gw4UWr4xKFWxGFW7GFX_yoW8XFWDpF
        WDC3yUt3W3WF9xKas3tanYqFW3Xrs7XFy3Wws3K34rZr1Skw17XryxXFs8KF47Xa4kJ34j
        9r1DGr4qvFW8JrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Define these macros so that the CPU name can be displayed
when running perf report and perf timechart.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 tools/perf/util/header.c    | 2 ++
 tools/perf/util/svghelper.c | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

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
index 5c62d3118c41..0259715ad6a6 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -322,6 +322,11 @@ void svg_waiting(int Yslot, int cpu, u64 start, u64 end, const char *backtrace)
 
 static char *cpu_model(void)
 {
+#if defined(__loongarch__)
+#define CPU_TYPE	"Model Name"
+#else
+#define CPU_TYPE	"model name"
+#endif
 	static char cpu_m[255];
 	char buf[256];
 	FILE *file;
@@ -331,7 +336,7 @@ static char *cpu_model(void)
 	file = fopen("/proc/cpuinfo", "r");
 	if (file) {
 		while (fgets(buf, 255, file)) {
-			if (strstr(buf, "model name")) {
+			if (strstr(buf, CPU_TYPE)) {
 				strlcpy(cpu_m, &buf[13], 255);
 				break;
 			}
-- 
2.31.4

