Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C36C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jul 2021 03:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C4D6108B
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jul 2021 03:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbhGTClu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 22:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346409AbhGTCkW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jul 2021 22:40:22 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1483DC061762;
        Mon, 19 Jul 2021 20:21:01 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s18so21257889pgg.8;
        Mon, 19 Jul 2021 20:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gjZSaF3RXySa1uirQyy8STm6C8ddpC3urY/fbzCQUXc=;
        b=XseHADv0++kRb+kSNwrb3v0X4VVhmQ4uSd1tnGhlh18VmYAjeGz1/kTi+jaQJ9AdsJ
         SertRRPrsL+Wkb373CVhz4BDOmvsP90wYEYWyjaEZzcpFzyG6ecIm72fZtNT+WMHV1D8
         cog6vS6VNHJYL/5t1wFMQ0rcczKN3neLIyhBX7N4ScwWlBmE6R0eV9EaOmwdeL+3eBSD
         qcHhgKgBwyre6neBpjrhkrg5xT05kikmQJ0tJN9r+jSbZpD9d6cA/wok1TBBNJTjMkjC
         P1PBRFP5ew2GFjlmrLvYhKWrjv3gpM2bjpNwV5/Lhnq/Cdtmf2tXh71aVv9BYEoqV5IG
         VifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gjZSaF3RXySa1uirQyy8STm6C8ddpC3urY/fbzCQUXc=;
        b=kjy6UmD9ign1vKZuRYETUD+tvEVdZ3yqSa14v4gRGy/AOLQ/8H2+9TZyA+BHwhZVwx
         lG0ELjK/lTg25dvo4G/J8zWApvCVZtPKR0wqWTxF3waxwnf0FJ/I/1QN7xMIituwiixQ
         /namVjdavSxmKJKaMyXGGfbxJ3Mmr6wgnC8KVz66J2VhvVoBoMb7fs/PNc6voHkFTYP4
         he94tKUqyaCe3tmgpEG//eLZIgBS9BBu1Tvz3qbE3gHJRYkRBvHEPO8vxbWV2sP6r5sF
         o4bLfJxYQTecdp0JpocT33q/9gmaG4w7HhjXsjWJ4RdRhpdkIvMJJ5QqocQBkUk7ZhPo
         v6ug==
X-Gm-Message-State: AOAM533Uhe+ncSTa1rLJyzL2tw0/ko10MTmehCFUMHD7o/7FcgUti5m3
        x6Wu8qNx71es7Ik0PttIJlQ=
X-Google-Smtp-Source: ABdhPJyzJvpYTOYuIWrFwJI+qv5A0h900M++L6KlKXy25fOba4f/yYi5GNtEYVkLuy/XcXQ5gH+XEw==
X-Received: by 2002:a05:6a00:1c6d:b029:338:322:137d with SMTP id s45-20020a056a001c6db02903380322137dmr19547938pfw.38.1626751260573;
        Mon, 19 Jul 2021 20:21:00 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id i8sm947324pjh.36.2021.07.19.20.20.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jul 2021 20:21:00 -0700 (PDT)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 0001-perf-x86-amd-Do-not-touch-the-AMD64_EVENTSEL_HOSTONL.patchFrom 9f724a38754d3f99a1b332c11e72e9dd213289d7 Mon Sep 17 00:00:00 2001
Date:   Tue, 20 Jul 2021 11:20:48 +0800
Message-Id: <20210720032048.90815-1-likexu@tencent.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Like Xu <likexu@tencent.com>

If we use "perf record" in an AMD Milan guest, dmesg reports a #GP warning
from an unchecked MSR access error on MSR_F15H_PERF_CTLx:

[] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write
0x0000020000110076) at rIP: 0xffffffff8106ddb4 (native_write_msr+0x4/0x20)
[] Call Trace:
[]  amd_pmu_disable_event+0x22/0x90
[]  x86_pmu_stop+0x4c/0xa0
[]  x86_pmu_del+0x3a/0x140

The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host,
while the guest perf driver should avoid such use.

Signed-off-by: Like Xu <likexu@tencent.com>
---
 arch/x86/events/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2bf1c7ea2758..795f4779023c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1116,8 +1116,9 @@ void x86_pmu_stop(struct perf_event *event, int flags);
 static inline void x86_pmu_disable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
+	u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
 
-	wrmsrl(hwc->config_base, hwc->config);
+	wrmsrl(hwc->config_base, hwc->config & ~disable_mask);
 
 	if (is_counter_pair(hwc))
 		wrmsrl(x86_pmu_config_addr(hwc->idx + 1), 0);
-- 
2.32.0

