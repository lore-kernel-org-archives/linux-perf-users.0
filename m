Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74885C001B0
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Jul 2023 05:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGQFoE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Jul 2023 01:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGQFn4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Jul 2023 01:43:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14013171A
        for <linux-perf-users@vger.kernel.org>; Sun, 16 Jul 2023 22:43:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-55b1238a013so3240503a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 16 Jul 2023 22:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689572624; x=1692164624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJVMF1IIkNq63VwvS5LTa45fwtvPnCXPypevGA/AZ+Y=;
        b=L+R5P/xPEW0wjozR2kzFcZdpWJhNejB9kiLqQzpHpyDisrfJd5pIExqibJDEvtVzr9
         b45LK/6gVDJbuWTQH4CdYY47A0pnJ7mCwwGWoC/LfsB/jH4Nw4gQfeQHqDWfV9OkwHc5
         t1sjrBkExaRxHaANVDnpcKetedtv6OMxRwhpme6NRUUqQFRVvJekapOfLlCqQfxJudSt
         tYaQyEuUcYYf41lIaDcXmCaxddVE5VIatGQbi9Q2aQ+U7Mu/S/nQae6gzYckC03yLhla
         BqMFZwzN4xzIS6fbTHrfuJoZLkMhZ0MjTxNATQwzgYTNhARZGI+qoaN+paHOCnb96gYF
         1+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689572624; x=1692164624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJVMF1IIkNq63VwvS5LTa45fwtvPnCXPypevGA/AZ+Y=;
        b=MsXm1mTmDWl8N6FtZjeuKbkQPIJ94Xq1wu+nu7PDhHXixnKsA2AIPQUUjJJbbyz0U4
         qx3GR1DikcHozh4Uxph9k7eXLL3O/y3V9vkv2F+pBATrmEkGEUvRnQGyewjvv1nJLh5S
         ycCcB7k8Vlvzn/xflrHA6aFHB/OHmitN3NWlFko/2ecnuiwAJVEHle2L8iUKSXWFID7C
         8Dte4J4ArqDT6BppAMi0ee19AXYjoHKd3DmA4IhUE+38dNiw9m20YglUV2vM/yL/PKkX
         PPLJwI9Y8yLgnK8T2tL6ke579I9NPadEpe21SoYmAz3etNVCRiFSH/6zDuzvInuqhCPu
         TkAA==
X-Gm-Message-State: ABy/qLaGx4HCBRfP7XmA1KeeeGWqyySot0EeoDYmAtTqCaQdOQ+muTPt
        V6rdCZgAvWSJ7tfd/1BWHa/HSnCbDZcJvjG/GP+GSP1/
X-Google-Smtp-Source: APBJJlHaE3CrjE0PQjnJgiVJCZQ1oF2x5SJZrfn3kEyWzBRSj741G4imf6hUkP9gS98SZzfAjMp/8w==
X-Received: by 2002:a17:90a:7f82:b0:263:f748:21c3 with SMTP id m2-20020a17090a7f8200b00263f74821c3mr10708679pjl.36.1689572624415;
        Sun, 16 Jul 2023 22:43:44 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090a2a0e00b00263e59c1a9fsm4625849pjd.34.2023.07.16.22.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 22:43:44 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Marc Zyngier <maz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, fissure2010@gmail.com
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/3] arm64: Add Cortex-X4 CPU part definitions
Date:   Mon, 17 Jul 2023 13:43:25 +0800
Message-Id: <20230717054327.79815-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717054327.79815-1-leo.yan@linaro.org>
References: <20230717054327.79815-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add the part number and MIDR definitions for Cortex-X4.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 5f6f84837a49..415be1a000c6 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -84,6 +84,7 @@
 #define ARM_CPU_PART_CORTEX_X2		0xD48
 #define ARM_CPU_PART_NEOVERSE_N2	0xD49
 #define ARM_CPU_PART_CORTEX_A78C	0xD4B
+#define ARM_CPU_PART_CORTEX_X4		0xD82
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -153,6 +154,7 @@
 #define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
 #define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
 #define MIDR_CORTEX_A78C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78C)
+#define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-- 
2.34.1

