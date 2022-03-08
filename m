Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6ACC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Mar 2022 01:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244675AbiCHBxB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Mar 2022 20:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiCHBxA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Mar 2022 20:53:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 986D33D498
        for <linux-perf-users@vger.kernel.org>; Mon,  7 Mar 2022 17:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646704323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YigIe8c8hOAKKacESi+Zjw0uljbvggEbAvpckywstDg=;
        b=XD6Vcz1BRv0K3AARSaAPNDalz/439VHwqdi5NUFO6ywZ7U1GkWz26bKqvVRBofA52TFh5W
        5UPydltfuOxtK59BgaZtSUDfg0MKjMqcPbQKshMR27ZfTkIkagJuiDHulyn2WK8vUGBfQe
        7Y3frG1m1QqPC85z/WNofbwd6eQ/U/s=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-wTZ-W9TMPRuyd7-WGLebjA-1; Mon, 07 Mar 2022 20:52:02 -0500
X-MC-Unique: wTZ-W9TMPRuyd7-WGLebjA-1
Received: by mail-oo1-f71.google.com with SMTP id x8-20020a4a3948000000b00320c4f9ae47so5678789oog.15
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Mar 2022 17:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YigIe8c8hOAKKacESi+Zjw0uljbvggEbAvpckywstDg=;
        b=WXh0y7K5h92Ob/Z8Zarh0drJG6sEQG2iq0keMpQAr59YvCoQNxAxq5wkO/+TPbVT0N
         PDyx21+kBIIJAgxnIOeo72+7bEcOO36SH03baFDPPPXTxlajYrXeOAhNe4EftTastsUz
         3toZsc66V7TCVy8uJ4/wryekhI1LUVFv0Q0MsK41itxxScUiAUYfr0mClVwWN06AG625
         ny6tsCJHiBTASog4KgexNb6CDZ7eD0+ux+veccVi7AngVhvb8MejTKb0NWibeL1YBCOn
         n4kCoOxaqPrRzcSa5pwf1F1rKZaQ5BYYajIrUcj3JgO1bKOXXgQKGIvitfzH5ToT2lLq
         5qkw==
X-Gm-Message-State: AOAM530TVpaTM7QOnfTIwuvyb45QvIrqTuEogP92inROtLs4NUmDDqFU
        aS041oABpMLxYLPXtLnwepB+SxdA/I4ztjRMMdZ8gv53tRoXI31nki6CkNeBN7yQa24StTpHvMK
        xZ3xYCfUcFb6Mm1mGBw+iou9EdUCWjg==
X-Received: by 2002:a05:6870:339f:b0:da:b3f:2b19 with SMTP id w31-20020a056870339f00b000da0b3f2b19mr1126259oae.184.1646704321774;
        Mon, 07 Mar 2022 17:52:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrMmwqQe+R36LQN0jd/vWIKxh3lTAUPdo6YjsPlvXNKtxY4xyc9myjGWqQMMSKayQXrzOAuQ==
X-Received: by 2002:a05:6870:339f:b0:da:b3f:2b19 with SMTP id w31-20020a056870339f00b000da0b3f2b19mr1126244oae.184.1646704321573;
        Mon, 07 Mar 2022 17:52:01 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id ds3-20020a0568705b0300b000d9c70e5275sm5183853oab.54.2022.03.07.17.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 17:52:01 -0800 (PST)
From:   trix@redhat.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] perf/x86: cleanup comments
Date:   Mon,  7 Mar 2022 17:51:48 -0800
Message-Id: <20220308015148.924521-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Tom Rix <trix@redhat.com>

For spdx, // for *.c

Replacements
certan to certain
fecthes to fetches
funning to running
dont to don't

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/x86/events/amd/core.c               | 2 +-
 arch/x86/events/core.c                   | 2 +-
 arch/x86/events/intel/p4.c               | 2 +-
 arch/x86/events/intel/uncore.c           | 2 +-
 arch/x86/events/intel/uncore_discovery.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 9687a8aef01c5..aec3a6134f745 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -81,7 +81,7 @@ static __initconst const u64 amd_hw_cache_event_ids
  },
  [ C(ITLB) ] = {
 	[ C(OP_READ) ] = {
-		[ C(RESULT_ACCESS) ] = 0x0080, /* Instruction fecthes        */
+		[ C(RESULT_ACCESS) ] = 0x0080, /* Instruction fetches        */
 		[ C(RESULT_MISS)   ] = 0x0385, /* L1_ITLB_AND_L2_ITLB_MISS.ALL */
 	},
 	[ C(OP_WRITE) ] = {
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index eef816fc216d3..0b05317d3fc91 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1416,7 +1416,7 @@ int x86_perf_event_set_period(struct perf_event *event)
 		wrmsrl(x86_pmu_event_addr(idx + 1), 0xffff);
 
 	/*
-	 * Due to erratum on certan cpu we need
+	 * Due to erratum on certain cpu we need
 	 * a second write to be sure the register
 	 * is updated properly
 	 */
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 7951a5dc73b63..e21c7e1684933 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -960,7 +960,7 @@ static void __p4_pmu_enable_event(struct perf_event *event)
 	escr_addr = bind->escr_msr[thread];
 
 	/*
-	 * - we dont support cascaded counters yet
+	 * - we don't support cascaded counters yet
 	 * - and counter 1 is broken (erratum)
 	 */
 	WARN_ON_ONCE(p4_is_event_cascaded(hwc->config));
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e497da9bf4270..79bfc87f2939e 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -573,7 +573,7 @@ int uncore_pmu_event_add(struct perf_event *event, int flags)
 		return -ENODEV;
 
 	/*
-	 * The free funning counter is assigned in event_init().
+	 * The free running counter is assigned in event_init().
 	 * The free running counter event and free running counter
 	 * are 1:1 mapped. It doesn't need to be tracked in event_list.
 	 */
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 5fd72d4b8bbb0..955d5a48554da 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Support Intel uncore PerfMon discovery mechanism.
  * Copyright(c) 2021 Intel Corporation.
-- 
2.26.3

