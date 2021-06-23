Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33FFC4743C
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Jun 2021 05:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC6661166
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Jun 2021 05:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhFWFVg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Jun 2021 01:21:36 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:59493
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229758AbhFWFVf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Jun 2021 01:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=23r9F1TgqkTLVqbFFEF4jfmzbMnL/seddS+4OeomPiM=; b=V
        R3aMTtsvLnmL5xiw4aO0uUAJU2f9glWPLRjHbvNKjbalZftxsuJxeaxfbrRSa8Fv
        fH4cqSnxzozK7igilybKQ+7AxH6004Ro0mFQ0fgABsSS0gceTd/Wz859pa7H8Q6e
        5ieDO4z66oSva42k4mCn0s751j860FLcSV2TXDco6w=
Received: from ubuntu (unknown [10.177.89.109])
        by app1 (Coremail) with SMTP id XAUFCgCXeCUZxNJgKlIbAA--.7071S3;
        Wed, 23 Jun 2021 13:18:17 +0800 (CST)
From:   Jiajun Cao <jjcao20@fudan.edu.cn>
Cc:     yuanxzhang@fudan.edu.cn, Jiajun Cao <jjcao20@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch: nds32: Add IRQ check for platform_get_irq()
Date:   Wed, 23 Jun 2021 13:17:10 +0800
Message-Id: <20210623051711.104410-1-jjcao20@fudan.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: XAUFCgCXeCUZxNJgKlIbAA--.7071S3
X-Coremail-Antispam: 1UD129KBjvJXoWrtr4UJr4UXr13KF1xJr4Dtwb_yoW8JrWUpr
        4Dur9YyFy8WFy8t3s2y3ykZr1UuF1kursrJr40q3yfArs0qrWDtFZ0yr12gr1xAry8Xa47
        Ja1YgrZ2gFyUua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwC2zVAIFx02awCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRAl1kUUUUU
X-CM-SenderInfo: isqsiiasuqikmw6i3vldqovvfxof0/
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The function cpu_pmu_request_irq() neglects to check the return
value of platform_get_irq().

The error code (a negative number) of platform_get_irq(), i.e.,
irq, will be passed to request_irq(), which will cause the function
cpu_pmu_request_irq() to fail with -EINVAL, overriding the original
error code irq.

Fix it by adding a IRQ check before calling request_irq().

Signed-off-by: Jiajun Cao <jjcao20@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 arch/nds32/kernel/perf_event_cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/nds32/kernel/perf_event_cpu.c b/arch/nds32/kernel/perf_event_cpu.c
index 0ce6f9f307e6..6a6cbebaf5aa 100644
--- a/arch/nds32/kernel/perf_event_cpu.c
+++ b/arch/nds32/kernel/perf_event_cpu.c
@@ -1083,6 +1083,9 @@ static int cpu_pmu_request_irq(struct nds32_pmu *cpu_pmu, irq_handler_t handler)
 	}
 
 	irq = platform_get_irq(pmu_device, 0);
+	if (irq < 0)
+		return irq;
+
 	err = request_irq(irq, handler, IRQF_NOBALANCING, "nds32-pfm",
 			  cpu_pmu);
 	if (err) {
-- 
2.17.1

Please check whether it's meaningful to propagate the error code of platform_get_irq() or stop calling request_irq() early when irq is invalid. Thanks!

