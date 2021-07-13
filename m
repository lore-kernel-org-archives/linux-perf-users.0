Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E199C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 16:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E73E611AC
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 16:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhGMQPq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 12:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhGMQPq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 12:15:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DD1C0613DD;
        Tue, 13 Jul 2021 09:12:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o3-20020a17090a6783b0290173ce472b8aso1748160pjj.2;
        Tue, 13 Jul 2021 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uPbiGzKPO1oysP6Oz16xru36WpoY5+bVcfpKk30dYBA=;
        b=c/mq5KMSxsPqq8MJgF2SaVMVFbIkIw1QAxKemZBF2lISxrgxcZWEpJtKHoC8Sw6fkc
         YaIDbHYlc2aLzVgiFYD3X61f7Ylc4ByoKXzs9ME3as+8Z7vuOjCQORZ+b8IcJy2uySsh
         vulFnuqVOtiCABhqWDIrTkUYSeuLB+YngtXqneawp2o5q9BHAU90/fNn3dS3qDwyCu36
         8+NM0l1q33U7aGcYOYDZO3BnEDwLGyo1MXlwI4bK376hhpyCYCgH2VTchnwF/b5iUOGX
         fQS8SNCDoynATm3dgQGAdy6xshQs14UKFPRuxMEoQh9LuVuvYpRxQO55tidOXamE1YOM
         iy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uPbiGzKPO1oysP6Oz16xru36WpoY5+bVcfpKk30dYBA=;
        b=k0/26oHy7BJkvC1rR29Z6ADf5nOB2b1ZG+VJrv+2355AWBvBft/sKbwvQSVyKMhTRm
         2zH0wLeCq2OAqCIyh8XWigojbpgInNn75yCFXNE9KVIyChbQ6wZ9qiNtBG8dkH7KGtMi
         n2bMgjK7ZKs1RIc6rVJ7+c1i1EJZWGXvB6Ijn/O49ez9SIjwWo524zNF5eolTy1lCZB2
         CYOBITrHQOcuFzJzc/cpqhq5c96h6jkYje9mOzdAEnpCsCAuNE0YEz4kY0DjE1mP7OnP
         CFJFVJ9sojAl/T3ZUww8VRSXaHaLxtAlc47qFMjtx3qfKi2sCVm2i3M6gq+pehzSHtuD
         7XLg==
X-Gm-Message-State: AOAM532O4tGo41DVAjA0zSrgZJYyFUvwpNAfVi6oI2FbU3oImyiRIix3
        M79Ydw5Ub0ISTeE5pxy0log=
X-Google-Smtp-Source: ABdhPJzwV7JfFyRh2DVu2o9yhuT51P6VrctbSjkjYIoZi9jh8m4omtzckVvjppsRGWzL7Mov9z6KVw==
X-Received: by 2002:a17:90a:5916:: with SMTP id k22mr101095pji.139.1626192775226;
        Tue, 13 Jul 2021 09:12:55 -0700 (PDT)
Received: from localhost ([113.87.14.231])
        by smtp.gmail.com with ESMTPSA id v25sm21404964pga.35.2021.07.13.09.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 09:12:54 -0700 (PDT)
From:   He Kuang <korenheg@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, acme@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kornehe@outlook.com, He Kuang <korenhe@tencent.com>
Subject: [PATCH] perf events, x86: Add stalled-cycles-frontend events to supported micro-architectures
Date:   Wed, 14 Jul 2021 00:12:47 +0800
Message-Id: <20210713161247.29536-1-korenheg@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: He Kuang <korenhe@tencent.com>

Extend the Intel PMU driver for generic front-end stall events. According
to performance monitoring event files for Intel processors
(https://download.01.org/perfmon/), Haswell, Broadwell, SkyLake and Sunny
Cove, these four types of micro-architectures support
UOPS_ISSUED.STALL_CYCLES but not set, this patch fixes that.

Signed-off-by: He Kuang <korenhe@tencent.com>
---
 arch/x86/events/intel/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fca7a6e2242f..c3c945a7a26d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5912,6 +5912,11 @@ __init int intel_pmu_init(void)
 			hsw_format_attr : nhm_format_attr;
 		td_attr  = hsw_events_attrs;
 		mem_attr = hsw_mem_events_attrs;
+
+		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
+		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
+			X86_CONFIG(.event=0x0e, .umask=0x01, .inv=1, .cmask=1);
+
 		tsx_attr = hsw_tsx_events_attrs;
 		pr_cont("Haswell events, ");
 		name = "haswell";
@@ -5954,6 +5959,11 @@ __init int intel_pmu_init(void)
 			hsw_format_attr : nhm_format_attr;
 		td_attr  = hsw_events_attrs;
 		mem_attr = hsw_mem_events_attrs;
+
+		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
+		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
+			X86_CONFIG(.event=0x0e, .umask=0x01, .inv=1, .cmask=1);
+
 		tsx_attr = hsw_tsx_events_attrs;
 		pr_cont("Broadwell events, ");
 		name = "broadwell";
@@ -6016,6 +6026,11 @@ __init int intel_pmu_init(void)
 		extra_skl_attr = skl_format_attr;
 		td_attr  = hsw_events_attrs;
 		mem_attr = hsw_mem_events_attrs;
+
+		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
+		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
+			X86_CONFIG(.event=0x0e, .umask=0x01, .inv=1, .cmask=1);
+
 		tsx_attr = hsw_tsx_events_attrs;
 		intel_pmu_pebs_data_source_skl(pmem);
 
@@ -6065,6 +6080,11 @@ __init int intel_pmu_init(void)
 			hsw_format_attr : nhm_format_attr;
 		extra_skl_attr = skl_format_attr;
 		mem_attr = icl_events_attrs;
+
+		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
+		intel_perfmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
+			X86_CONFIG(.event=0x0e, .umask=0x01, .inv=1, .cmask=1);
+
 		td_attr = icl_td_events_attrs;
 		tsx_attr = icl_tsx_events_attrs;
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
-- 
2.31.1

