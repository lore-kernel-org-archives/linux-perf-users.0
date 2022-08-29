Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82410ECAAD4
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Aug 2022 12:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiH2M5K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiH2M43 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Aug 2022 08:56:29 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4F97E011
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Aug 2022 05:48:13 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id y12-20020a056402358c00b00448898f1c33so1044122edc.7
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Aug 2022 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=xCb3PCmBWSP36RKUEWOlpZN7hfh85Z1tvKAaYcX0zpk=;
        b=bkzY5qKI18VWd4mlwWM1vsviFVP4q78HrnTxrdtR5mo9H6pfnRG17R5qugpXfL7a3C
         wCeY287TAp6qkMpaEvrmcs8dRYfSWwV8oWll0gU0C2+YoURGAMIxPu5xp4rjPy+bUaaA
         Pe7ln30jJ/atykyMBocwI9/fKS382484rx9GtCgqO1avY7pHIQ5SHOMiGbCVqPIvYzgc
         vum+2/Q5MVS6eBFJN4+hVCuVqfedsJUjTaeXPMQ2Z03LEk0tk/b+PnLwtSM5gTRlKVFJ
         4wj5vAGL/ISBuJFFNcV6QXU/h0GHjtdWdo2nTY8203whs27GL67Jq5Zsc5AZdNjCjL6M
         R2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=xCb3PCmBWSP36RKUEWOlpZN7hfh85Z1tvKAaYcX0zpk=;
        b=7QZgZxj25RFOuExmBwqGMwo6MsSuG0RbZiIObheUsuEA06+7MPotyqvLA1tUGohosg
         cxdYjuCFoUwNv0H/2LftfCrPtym/9qAVWP/PAbJMMrLxzOC82P2B7ndkxTvNfHqe95oP
         Y0MHwn1/vbwZPVdShO7KdeUmydIW693XHcRk/tejMVg+OAdcMefSzMSoXDEkqpqFTpGa
         cl47tFWFi8b8n4SMAoNB/iCTJ0SNMEW2qEQgM1EQHfxN6Q8QNaq9vyf3orRXR1l04WzZ
         lwVZxDsBFTSbvanduuSSLHDXvnMAaQkZGZ5Tmi4mLCFS9aD9inIIRLg79k2sW5uDdWLH
         PzWQ==
X-Gm-Message-State: ACgBeo1g76ojbdVXOcdciRnVWXwlaKeLa2rY/ZT/PMTL6KhI/YAxCgR+
        D0cm9iLkwGLQzkOnb0WsETRQqdYpLQ==
X-Google-Smtp-Source: AA6agR7i/RJsfaE6+mHqdwn3xeEjB0tlbiv/szuLIYXZ6XN1jxpVHA+uSIe33NebngMb8iQE2cPcnN59JA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:196d:4fc7:fa9c:62e3])
 (user=elver job=sendgmr) by 2002:a17:906:ef90:b0:730:9d18:17b3 with SMTP id
 ze16-20020a170906ef9000b007309d1817b3mr13769351ejb.141.1661777292013; Mon, 29
 Aug 2022 05:48:12 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:47:10 +0200
In-Reply-To: <20220829124719.675715-1-elver@google.com>
Mime-Version: 1.0
References: <20220829124719.675715-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829124719.675715-6-elver@google.com>
Subject: [PATCH v4 05/14] perf/hw_breakpoint: Mark data __ro_after_init
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Mark read-only data after initialization as __ro_after_init.

While we are here, turn 'constraints_initialized' into a bool.

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 kernel/events/hw_breakpoint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6d09edc80d19..7df46b276452 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -46,7 +46,7 @@ struct bp_cpuinfo {
 };
 
 static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
-static int nr_slots[TYPE_MAX];
+static int nr_slots[TYPE_MAX] __ro_after_init;
 
 static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
 {
@@ -62,7 +62,7 @@ static const struct rhashtable_params task_bps_ht_params = {
 	.automatic_shrinking = true,
 };
 
-static int constraints_initialized;
+static bool constraints_initialized __ro_after_init;
 
 /* Gather the number of total pinned and un-pinned bp in a cpuset */
 struct bp_busy_slots {
@@ -739,7 +739,7 @@ int __init init_hw_breakpoint(void)
 	if (ret)
 		goto err;
 
-	constraints_initialized = 1;
+	constraints_initialized = true;
 
 	perf_pmu_register(&perf_breakpoint, "breakpoint", PERF_TYPE_BREAKPOINT);
 
-- 
2.37.2.672.g94769d06f0-goog

