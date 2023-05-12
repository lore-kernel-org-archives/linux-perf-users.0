Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557A2C77B75
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 May 2023 09:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbjELJAE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 May 2023 05:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjELJAD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 May 2023 05:00:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC9610C2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 May 2023 02:00:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f315735514so312731795e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 May 2023 02:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683882000; x=1686474000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0tm6iJdFnSKQ00W/5tPio7/nVBToic+wNQP1K4Mncg=;
        b=EGtRl3XrbxwPlKsaGMLrPknplRMIUf/2v48QERTJWbAD5fZ6GwtIvHIuGTaOG1VkJx
         kr78QJ1OuWm946zWh0NfAb1XA92r4iYXhlDqOTRD8e5naPGzqvesBFjl8ANthMtqZvyn
         rCW4QZEIHMW6oTNtVjIOzkDkZTY7gjMVsfoSf10DVc344cFbkshpKLK11/lZioz5cA0w
         rGI1kujd9CYkfXoc+o4IfNWBEV1VgQo3P7YkIkELNm8PRjZSW13dPvrOX2qyhMv6rzDy
         c0REunbjflDrF+oa/zPx9fvZWY/Jza2dK2akiNcUCpgBJ6AqW0SVayj0kqJRmerbop3q
         LKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683882000; x=1686474000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0tm6iJdFnSKQ00W/5tPio7/nVBToic+wNQP1K4Mncg=;
        b=cllTsLcu6vthOAuH+EAfs3b3fSfVOgVEH0YtV0jvIqRWZlD6uIASAwdI49gcngwwex
         3pDE1SjMklS8wf7ZsrJC3gIZcnD5TeFhz5s58n9sGXCyd85fM6KUama+HbVUG94+NIBD
         7RYIBYDYvGdroTkp6H2xaRTGWHXCLEIWIYC/WVLxjB8mlfcAH1vWfFJbarAE79jH+VU5
         x4D28IQzO6+M9wLloZjF797x7SaU0jK+pnSRYD+dDydZ66zpeT3iz/j7r00wgYOlX/sO
         SDYTT31T9Vch5QAr4/4zw0P58cvWRL+OtRzjkxZwOaGow0TSaL6J9MYQeUorPGn8WYYd
         jTlQ==
X-Gm-Message-State: AC+VfDyDoHrHJhR5AWR2UXUigKVX/CpTFh+j93M9LIzr7jB3E35pfIzK
        kSh1m14khqsD2kL1ZguaCTuCcQ==
X-Google-Smtp-Source: ACHHUZ4c3dRq1nnfDX2koyQfsjybOGXM/NcLT4dCbSX1o/SxrWN5Q1AZ4RiqcUhGigpJb9/i7nqMIg==
X-Received: by 2002:adf:ff8c:0:b0:2f8:33bd:a170 with SMTP id j12-20020adfff8c000000b002f833bda170mr21283755wrr.32.1683882000138;
        Fri, 12 May 2023 02:00:00 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id g8-20020adff3c8000000b003078354f774sm21229104wrp.36.2023.05.12.01.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:59:59 -0700 (PDT)
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
Subject: [PATCH v2 06/10] drivers: perf: Implement perf event mmap support in the legacy backend
Date:   Fri, 12 May 2023 10:53:17 +0200
Message-Id: <20230512085321.13259-7-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230512085321.13259-1-alexghiti@rivosinc.com>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Implement the needed callbacks in the legacy driver so that we can
directly access the counters through perf in userspace.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/perf/riscv_pmu_legacy.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index ffe09d857366..f0f5bd856f66 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -74,6 +74,31 @@ static void pmu_legacy_ctr_start(struct perf_event *event, u64 ival)
 	local64_set(&hwc->prev_count, initial_val);
 }
 
+static uint8_t pmu_legacy_csr_index(struct perf_event *event)
+{
+	return event->hw.idx;
+}
+
+static void pmu_legacy_event_mapped(struct perf_event *event, struct mm_struct *mm)
+{
+	/* In legacy mode, the first 3 CSRs are available. */
+	if (event->attr.config != PERF_COUNT_HW_CPU_CYCLES &&
+	    event->attr.config != PERF_COUNT_HW_INSTRUCTIONS)
+		return;
+
+	event->hw.flags |= PERF_EVENT_FLAG_USER_READ_CNT;
+}
+
+static void pmu_legacy_event_unmapped(struct perf_event *event, struct mm_struct *mm)
+{
+	/* In legacy mode, the first 3 CSRs are available. */
+	if (event->attr.config != PERF_COUNT_HW_CPU_CYCLES &&
+	    event->attr.config != PERF_COUNT_HW_INSTRUCTIONS)
+		return;
+
+	event->hw.flags &= ~PERF_EVENT_FLAG_USER_READ_CNT;
+}
+
 /*
  * This is just a simple implementation to allow legacy implementations
  * compatible with new RISC-V PMU driver framework.
@@ -94,6 +119,9 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
 	pmu->ctr_get_width = NULL;
 	pmu->ctr_clear_idx = NULL;
 	pmu->ctr_read = pmu_legacy_read_ctr;
+	pmu->event_mapped = pmu_legacy_event_mapped;
+	pmu->event_unmapped = pmu_legacy_event_unmapped;
+	pmu->csr_index = pmu_legacy_csr_index;
 
 	perf_pmu_register(&pmu->pmu, RISCV_PMU_LEGACY_PDEV_NAME, PERF_TYPE_RAW);
 }
-- 
2.37.2

