Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC863EB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon,  3 Jul 2023 12:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjGCMt4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 3 Jul 2023 08:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjGCMtz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 3 Jul 2023 08:49:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF44CA
        for <linux-perf-users@vger.kernel.org>; Mon,  3 Jul 2023 05:49:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3143b70d6easo406382f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Jul 2023 05:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688388593; x=1690980593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ/nerEaJdoYRd5ld9GUr9ghotX2eSIq7nKEUZxClAs=;
        b=VDQ8BEKOua2MPOeh7UBCA5TLJ/SQzpLxqtHvvtIg9IqrzRgS7zzfIxI4bW61B3TpT/
         MYsOJpsJcMfRcGvKTaEPdwM9HmFspVAwIChFvV8xQi9MAA9nH5gSHhp80hpeuCfLbGf8
         9/OhuweNy85U8eaY0Jm0RwCTxGVuVZPevxQQRXlfQX++Ypoahdq5JQYRcm7UHC++5W+W
         l93VRH6OcveCipTB6jLSZNnSNUII5M5aWbj8X325YjIIJJjL2CRByrBR4aOgWEsP0cUV
         smHrq0CD3JYoL/Ab9OgZfTvhxLFJyHAxAkJmtKFeFSubj0NjZvWaAVGpYRgSX99lLhAP
         Uk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388593; x=1690980593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZ/nerEaJdoYRd5ld9GUr9ghotX2eSIq7nKEUZxClAs=;
        b=fCvbsJQTmwlFZTJYEfAZUMq1NIK1VWXupSzGwb4sX0Ul1DHCcuvSfH07oUtymc3nSt
         c5rezti6dCL/o+pglwMWXE2RZ/+wPUjd8fdRYtSPhJQaQIuV8Y3RKWQvzxa5yvmSwPI4
         DGL+HjCxjxNfOHYzS9ZPNR1poIeoWijJ/e/NtYJ+3sorcFmsQWVmJlN9ZCZIFMCTmMz2
         Cd/4Z/VVuSuhtbmDiM6+bNz7TQBzbdV6Z0XCNOJjhB1DUkymHzr2SJ3Hagufy9G7Z9T2
         GEf7fEmyNkFkaOc96DmeyKl8Tcyll1tw2R4pBRjj/EnVie3TjrLc5yPRnGYBEfZaBz9G
         jF6Q==
X-Gm-Message-State: AC+VfDyf5LehrMxuzdoD2SUnD/Adgu2uWz8xnatB8XvRiunZ+cbK9NrZ
        c5QOXY6s2PTuNh9Bc7l7ch0edA==
X-Google-Smtp-Source: ACHHUZ62WvlA3047ray8oXCOSgpbSvwQjyuzYzr8ddqDY560e4nA5mtjjXKgLaeaLCURCwTViq3JeQ==
X-Received: by 2002:a1c:770d:0:b0:3fb:a506:5656 with SMTP id t13-20020a1c770d000000b003fba5065656mr7785924wmi.32.1688388592878;
        Mon, 03 Jul 2023 05:49:52 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c220700b003fa999cefc0sm21128205wml.36.2023.07.03.05.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:49:52 -0700 (PDT)
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
Subject: [PATCH v4 03/10] riscv: Make legacy counter enum match the HW numbering
Date:   Mon,  3 Jul 2023 14:46:40 +0200
Message-Id: <20230703124647.215952-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703124647.215952-1-alexghiti@rivosinc.com>
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

RISCV_PMU_LEGACY_INSTRET used to be set to 1 whereas the offset of this
hardware counter from CSR_CYCLE is actually 2: make this offset match the
real hw offset so that we can directly expose those values to userspace.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/perf/riscv_pmu_legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index ca9e20bfc7ac..6a000abc28bb 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 
 #define RISCV_PMU_LEGACY_CYCLE		0
-#define RISCV_PMU_LEGACY_INSTRET	1
+#define RISCV_PMU_LEGACY_INSTRET	2
 
 static bool pmu_init_done;
 
-- 
2.39.2

