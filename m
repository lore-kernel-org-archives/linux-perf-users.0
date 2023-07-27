Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0300AC0015E
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 Jul 2023 14:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjG0OXX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 Jul 2023 10:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjG0OXW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Jul 2023 10:23:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1CD2D47
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 07:23:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso11487315e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690467800; x=1691072600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7afbVzdz7i3XV0LSy+5KsI/iNIynDErY3gG58bPEFNo=;
        b=jiXIaZRUV4ZcDLMCv3xDF3i+GqWkJoXWGxtAGVL7Xo8vcyG/kYEmgtcjb4fIsTElLK
         g1OEILDNGfZCusiNUv8aGtWOljEAq03jBINfyYlDcmD8IULiEUxGzQmCVXkF3ovYAGyj
         DwEi4R0UarCzu22BkyJTXfJuFu5Ip42Wvt06lRAUyxfT8UNTI8YERqaCFS5Xp2MIiQmT
         KgVgzwE4T348xj1YtQ3szGeUX2k2Lsha+L9BCUtGDK038+qNXI7v9C+/5hWsb9UGqch6
         GPoNOfcjdS015aDDKnIJZnLSVXbqH4IGtMBgX5QCQZG042E/cY0ldJOrkvNp1h1dJ92c
         PHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690467800; x=1691072600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7afbVzdz7i3XV0LSy+5KsI/iNIynDErY3gG58bPEFNo=;
        b=AOnVkHgMkniRBq6aKmdqS982Xmy4Xt1XQPLAE8xQlP22PJQbFah2Z2+oNvtl1srKLg
         W3DaIOnfMXZpntO5hPFsvbGxxiBJqMZ37w+p066zzxloCPn2tpcbS9qvmKxfdu36smDO
         ueALbqnS4z5Mt9fs8vNSoqI5oRpWsyjfyuyYpUSqgJjYbNgRLlVlnuszIyoFknhR2sE8
         bG0j0wZOxni47UXKf73aZoNLRCGOEBryIqpeJ4SuKIM68SIVe/z8uSxoGjaW3A+LkaOJ
         gn7BgQTfEogcEL1p6pMbIh6jf4gEJ/dEI7O8qeWuoz65cbghz87EP5+PHKuMMyfINDkE
         5oew==
X-Gm-Message-State: ABy/qLZuqFYVmOuAbuxe4WtPKi0B00M628GzfotU+znEXVBkhc8A71sc
        3bLfFI64KqOvZXs06Wm4PKcuUg==
X-Google-Smtp-Source: APBJJlGikz6Uzb01etZh969p33aRgZBYo6IYUFkhDpg/l74+0vYkHOZqghwB+xmqCKIRMhgeQSCPOw==
X-Received: by 2002:a7b:c4d3:0:b0:3f8:fac0:ad40 with SMTP id g19-20020a7bc4d3000000b003f8fac0ad40mr1859880wmk.29.1690467799801;
        Thu, 27 Jul 2023 07:23:19 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id q10-20020a1cf30a000000b003fbb618f7adsm1985627wmq.15.2023.07.27.07.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:23:19 -0700 (PDT)
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
        =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 06/10] drivers: perf: Implement perf event mmap support in the legacy backend
Date:   Thu, 27 Jul 2023 16:14:24 +0200
Message-Id: <20230727141428.962286-7-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727141428.962286-1-alexghiti@rivosinc.com>
References: <20230727141428.962286-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Implement the needed callbacks in the legacy driver so that we can
directly access the counters through perf in userspace.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_legacy.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index 6a000abc28bb..79fdd667922e 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -71,6 +71,29 @@ static void pmu_legacy_ctr_start(struct perf_event *event, u64 ival)
 	local64_set(&hwc->prev_count, initial_val);
 }
 
+static uint8_t pmu_legacy_csr_index(struct perf_event *event)
+{
+	return event->hw.idx;
+}
+
+static void pmu_legacy_event_mapped(struct perf_event *event, struct mm_struct *mm)
+{
+	if (event->attr.config != PERF_COUNT_HW_CPU_CYCLES &&
+	    event->attr.config != PERF_COUNT_HW_INSTRUCTIONS)
+		return;
+
+	event->hw.flags |= PERF_EVENT_FLAG_USER_READ_CNT;
+}
+
+static void pmu_legacy_event_unmapped(struct perf_event *event, struct mm_struct *mm)
+{
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
@@ -91,6 +114,9 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
 	pmu->ctr_get_width = NULL;
 	pmu->ctr_clear_idx = NULL;
 	pmu->ctr_read = pmu_legacy_read_ctr;
+	pmu->event_mapped = pmu_legacy_event_mapped;
+	pmu->event_unmapped = pmu_legacy_event_unmapped;
+	pmu->csr_index = pmu_legacy_csr_index;
 
 	perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
 }
-- 
2.39.2

