Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C274C77B75
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 May 2023 08:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjELI6J (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 May 2023 04:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbjELI6I (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 May 2023 04:58:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B128210C2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 May 2023 01:58:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30644c18072so6476133f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 May 2023 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683881877; x=1686473877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcoGNF7JhrmxjCUJ31ZWLSLoY1qQtRXBvkDSeKWeoAE=;
        b=j0DLCCtMEV6UXHGMXtA6jElCfmVNii679kPYYZsmKm9aD75PHOebwGkVrc6Gfiboyx
         RvCFvQmdeuzdeOvfXCdQOXwLou3CT6k5zHrydjFCJOM4CfLlm23nYTXhdENsRytg1bw2
         M+WUTSR3utlqD0vuCxQR2w2Ifa3W3yUVTfIhLcL+gs4ADta+RZD/IzA7ThYOKELeV3hw
         /YXVPvWlRyErSS21CkUFyhAfXahfWVYARbMIE9VKbydkHTCJT+v3ZtI+4FtUTpkIkXTZ
         uUkHKb7RdfHC8Q06kUAnddmIThthmriXlIOQgdPdvAX5tb59HXmbwuvIUmyRBi8UL7kz
         2WdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683881877; x=1686473877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcoGNF7JhrmxjCUJ31ZWLSLoY1qQtRXBvkDSeKWeoAE=;
        b=GsvHoRF6NGs4EPpnaH1H68Dh2TSvYC9uGB1My+ox/geLQwkLJeuuuTg1SPnn5e+b7L
         5FU1D3p53fOyAugUEtay5zvlToShMA1Wy/y1+l7wkbKMTcsjtjGCulAj4v74rMw3vs4k
         DcSbfDVfGPVAPkCqDSMHfdCLtJLzs6OPOcJIaVGZux2wXhHhpQALm7SbAJ8zcVwbL3ZI
         xDHNDjyXv/ejrSTUPSGmOheEiwjaa9K6wL46OeTUwoUwQTSuPOg10wQ3F8B3mgawWbpl
         WLeEjDvaTNC6/bglNIeBETGHeUSflyVYCIv85QZo/wW/RYkcSJ7+YpXPXSpgrAP9kWAO
         oVLQ==
X-Gm-Message-State: AC+VfDzzopDqs9aWcA+mT+hdJ0OfofG8Fb08QRQk/i7WflaHrZ4dGVcT
        2GqirTJXnt4Z22MgZb38B+duLQ==
X-Google-Smtp-Source: ACHHUZ59QZ/d2h0X4opjouOE+vww3Ww10su+H5NJb68TnAb4iZVlA+QJrLsykQHhtEpQNw67FT9wNQ==
X-Received: by 2002:adf:e941:0:b0:307:a8e8:ca6c with SMTP id m1-20020adfe941000000b00307a8e8ca6cmr8411496wrn.35.1683881877661;
        Fri, 12 May 2023 01:57:57 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc7d6000000b003f42813b315sm12616421wmk.32.2023.05.12.01.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:57:57 -0700 (PDT)
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
Subject: [PATCH v2 04/10] drivers: perf: Rename riscv pmu driver
Date:   Fri, 12 May 2023 10:53:15 +0200
Message-Id: <20230512085321.13259-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230512085321.13259-1-alexghiti@rivosinc.com>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In addition to being more pretty, it will be useful in upcoming commits
to distinguish those pmu drivers from the other pmu drivers.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/perf/riscv_pmu_legacy.c | 2 +-
 drivers/perf/riscv_pmu_sbi.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index 0d8c9d8849ee..ffe09d857366 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -95,7 +95,7 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
 	pmu->ctr_clear_idx = NULL;
 	pmu->ctr_read = pmu_legacy_read_ctr;
 
-	perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
+	perf_pmu_register(&pmu->pmu, RISCV_PMU_LEGACY_PDEV_NAME, PERF_TYPE_RAW);
 }
 
 static int pmu_legacy_device_probe(struct platform_device *pdev)
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 70cb50fd41c2..3b0ee2148054 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -897,7 +897,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_unregister;
 
-	ret = perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
+	ret = perf_pmu_register(&pmu->pmu, RISCV_PMU_PDEV_NAME, PERF_TYPE_RAW);
 	if (ret)
 		goto out_unregister;
 
-- 
2.37.2

