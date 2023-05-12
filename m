Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73810C77B75
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 May 2023 08:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbjELI5O (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 May 2023 04:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240244AbjELI5I (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 May 2023 04:57:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2364D10E52
        for <linux-perf-users@vger.kernel.org>; Fri, 12 May 2023 01:56:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f315735514so312634195e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 May 2023 01:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683881816; x=1686473816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbhrF1vaRRoJzYyea1JBFcTA2VAH3WkbBcvliTXkyWM=;
        b=acVr4rEpZzh5BDTE3sCn1nL2V53Rd6FEEhr9YcXuVFfaaqCmyAiwlO95PasYfT0SGj
         kGR1ZV2BHmTa2qKvGMrDop8XWV7YinIqdDnGqQQT74v6MaiI5j7pik4jo+/fqg21x6f0
         YOS1AvpcZbF6yUuI/szDxFNTKKScZXq+a/zfEYSFViTnUDJdJ1o3AV440ACM5WinqbA8
         N/jROH4LvspGZDwgbqPZoypXDcNLEuNf+RYM0lESX4aGNXX0YNItu2rVcEGI8MUL3qDh
         lexX4ho58ebwc2SbO9qrSxysj8oD6C6z3V6mt7Uq7e5Oo7aQxDVJW6zfRgi0o8Kp+MwO
         2M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683881816; x=1686473816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbhrF1vaRRoJzYyea1JBFcTA2VAH3WkbBcvliTXkyWM=;
        b=fKVD4CpvnL+rk/qNCPg+Af+rJ3UYL3py3A/nUAuwLMDe864h3sGuCI7GVGrpKAxcjm
         Z//6S9fK6x58uJbEWaVjufYiyovUbtlQbQAAwZnGcIWfL3xEAdvlVKySbdGGroZfxNDN
         pfOiiML7wYgQw2/yV4uVOvnDpQKO1Xg0qV/D5ah/b9CNYy0LXiVzwxt+RsOmD1yQnWMS
         umk2FLCvVLw6796dvU56YEgyyVAeEaE/1Ku/E3ZcKJ1ql835axXvR6eWwBKT5ZEPeRTS
         OrNh7L0zJRnaIEruuVOHKRHXUjEydwSdopFgo6O6vtu0R6XAk2YFd6AjjE5ya59c6eJB
         fk9g==
X-Gm-Message-State: AC+VfDxwOMngpIyUOZApzgYw8z9aHHdSzd71rjz/SZItw3YQZD2eKnge
        XObulBWUeg+hjr3VImQpFo9d+w==
X-Google-Smtp-Source: ACHHUZ5iEPG/+h+duX0vfpwWwpJ/AAziiXGkzegiSPOBvbbch/qAjATyDjuRLujdEH9ME1cg+vOqzw==
X-Received: by 2002:a05:600c:4f45:b0:3f4:2bcf:e19 with SMTP id m5-20020a05600c4f4500b003f42bcf0e19mr8250663wmq.8.1683881816508;
        Fri, 12 May 2023 01:56:56 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id s7-20020a1cf207000000b003e91b9a92c9sm27963429wmc.24.2023.05.12.01.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:56:56 -0700 (PDT)
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
Subject: [PATCH v2 03/10] riscv: Make legacy counter enum match the HW numbering
Date:   Fri, 12 May 2023 10:53:14 +0200
Message-Id: <20230512085321.13259-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230512085321.13259-1-alexghiti@rivosinc.com>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

RISCV_PMU_LEGACY_INSTRET used to be set to 1 whereas the offset of this
hardware counter from CSR_CYCLE is actually 2: make this offset match the
real hw offset so that we can directly expose those values to userspace.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/perf/riscv_pmu_legacy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index ca9e20bfc7ac..0d8c9d8849ee 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -12,8 +12,11 @@
 #include <linux/perf/riscv_pmu.h>
 #include <linux/platform_device.h>
 
-#define RISCV_PMU_LEGACY_CYCLE		0
-#define RISCV_PMU_LEGACY_INSTRET	1
+enum {
+	RISCV_PMU_LEGACY_CYCLE,
+	RISCV_PMU_LEGACY_TIME,
+	RISCV_PMU_LEGACY_INSTRET
+};
 
 static bool pmu_init_done;
 
-- 
2.37.2

