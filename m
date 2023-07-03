Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B536FC0015E
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Jul 2023 12:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjGCMu6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Jul 2023 08:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjGCMu5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Jul 2023 08:50:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC69E54
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Jul 2023 05:50:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so40608695e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Jul 2023 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688388654; x=1690980654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ourpCES+L8D+Sf3DlwDnrKMPgPuj2Rb0Ie1m7RKO9o=;
        b=R2mmycKhbCyBcolm5337go0SS5yH7iKYlFTh6vaXqDAT2thZh7dS4t9EB+dJWDtLzc
         oWybcyPhuJ95UPdczXfLx72iJy0OYIZx9KkWN2hkFjzTrvlHnbolmOlStyFSgGcRIjOT
         MGxUJEI/Bp63Snk+jy/fDQUHTUGk+V4sQqTJ5D7WxT16CNXYHi5/IbRNkr7xQqTPQp82
         u2IGDpKnncM3esjHkd+KkORsr9U5ommVCQrACrcM1rq0hTyVqHo7BZsH2/0z/IJAh+DK
         iV+HPPbfvnjf90vemg2bcsGOyo4nX7umFqfnGcDfcdTz5pZ6KOBpMEGK0wFUmJQ0j+WA
         eMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388654; x=1690980654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ourpCES+L8D+Sf3DlwDnrKMPgPuj2Rb0Ie1m7RKO9o=;
        b=HAMJO5k8SewoRQ7XIOr3KgvJ8jt53Wh2z0xGsTy1ydW+6gFikn0k1mEF7h83tbF62Y
         g9YyQxGbcNir+mIVJ7nOkZSdEAIf/6WmVUcdpRcewIb9f7h//BIbNeaPtlfsPoAwCoWQ
         olY1dccSK+gXQuT+7iTDZMREm/y07xPA9R+/mhxmjpzsdBO4TISBXiImsRmIRd1dYXlV
         dcu3IE9ag6A1ZodJDhK4cb45T09LRW67MPfm+JCyvoOsx5ijgWf1hGKtoROZOSnv/coN
         REz1SwUhUcc+xPP6RAWZ2cxqQgEge3AVjkcPcsESk7NcgxvpF41hHfk5lWtkkBJiPBTP
         BE3g==
X-Gm-Message-State: AC+VfDx2OzkK2Awa94xyvRL7EuCAORVgTO18yAdBZeu2DcG9h8GZ/xcK
        MAC2xuuYJco1Y6uPNEtp8TmDCg==
X-Google-Smtp-Source: ACHHUZ72K+0MoLXDbC0yNCWkxDT9b84sSKqy9wgEkUDqJtCshD9xmcD8/7T8ejldgsm5oOBMR3qFnA==
X-Received: by 2002:a05:600c:220c:b0:3f5:1728:bde9 with SMTP id z12-20020a05600c220c00b003f51728bde9mr7765354wml.2.1688388654013;
        Mon, 03 Jul 2023 05:50:54 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d50cd000000b003143b7449ffsm786576wrt.25.2023.07.03.05.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:50:53 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 04/10] drivers: perf: Rename riscv pmu sbi driver
Date:   Mon,  3 Jul 2023 14:46:41 +0200
Message-Id: <20230703124647.215952-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703124647.215952-1-alexghiti@rivosinc.com>
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

That's just cosmetic, no functional changes.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/perf/riscv_pmu_sbi.c   | 4 ++--
 include/linux/perf/riscv_pmu.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 4f3ac296b3e2..83c3f1c4d2f1 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -914,7 +914,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 static struct platform_driver pmu_sbi_driver = {
 	.probe		= pmu_sbi_device_probe,
 	.driver		= {
-		.name	= RISCV_PMU_PDEV_NAME,
+		.name	= RISCV_PMU_SBI_PDEV_NAME,
 	},
 };
 
@@ -941,7 +941,7 @@ static int __init pmu_sbi_devinit(void)
 	if (ret)
 		return ret;
 
-	pdev = platform_device_register_simple(RISCV_PMU_PDEV_NAME, -1, NULL, 0);
+	pdev = platform_device_register_simple(RISCV_PMU_SBI_PDEV_NAME, -1, NULL, 0);
 	if (IS_ERR(pdev)) {
 		platform_driver_unregister(&pmu_sbi_driver);
 		return PTR_ERR(pdev);
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 9f70d94942e0..5deeea0be7cb 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -21,7 +21,7 @@
 
 #define RISCV_MAX_COUNTERS	64
 #define RISCV_OP_UNSUPP		(-EOPNOTSUPP)
-#define RISCV_PMU_PDEV_NAME	"riscv-pmu"
+#define RISCV_PMU_SBI_PDEV_NAME	"riscv-pmu-sbi"
 #define RISCV_PMU_LEGACY_PDEV_NAME	"riscv-pmu-legacy"
 
 #define RISCV_PMU_STOP_FLAG_RESET 1
-- 
2.39.2

