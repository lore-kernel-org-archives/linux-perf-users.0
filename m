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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A42C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jul 2021 11:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FBE6113C
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Jul 2021 11:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhGTKph (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Jul 2021 06:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhGTKpg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Jul 2021 06:45:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B70EC061574;
        Tue, 20 Jul 2021 04:26:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u126so11578677pfb.8;
        Tue, 20 Jul 2021 04:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYswrRmNXFnD7iaIAgBbcYDCMDGk0Lr5a5LmLLvQOT0=;
        b=pmXini3fllAe6dKP0sa3VGlf6kqajhL2LCwoTOEz6al3xca1jUYdD7g7epBILaFbQo
         OxbyEItpTqVNcYDT9yw1Ns3D3LfUc615MbQtNwfACVr+gefsprNjIe8qYW74ozWeIqoZ
         8R4tGgP8XsgaxsjPcFjbTTgEuQSGFOP2JbtNgIlP6jpo959NSADOLy7uIHf3DTNVCNuE
         Vl5xtwk6Xy4AFzUdx7lcR0v5Y+GKa/R0YPLB0nBONlh/DBfB6n4yTdrXSmtsR8cs+5Cj
         68SYJ72fsIZMk+kBv9oHtncAMv7CziEImdwUnH8JZN5jaP0BplVUH+tw0o4V2QGIPRqC
         NPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYswrRmNXFnD7iaIAgBbcYDCMDGk0Lr5a5LmLLvQOT0=;
        b=EFLdW7mZWzMrkRbUrH3r7IISeQtR1tRWINkitpGY6liDTEmmewiHnthua0Ok52wib2
         GpmsYdfo/mdzLPkKTsjxK1YGFC889XvuDQtlVnugvFe/iv5dFl+fhncZ0jCkty+4mTK0
         qYVIl4CT/WmGHqyWqziwamOaJmi2NoJ4unBJYbKpSLKWdxDmmn6fvZWf7G2oburMPnqh
         ElbqZnb9kNPC9Ge15zmO8KpRD9vEvGgNSWZA4cQhaRlOzXB5Hge5HjSbLnAiii2WAGXo
         KS2sXUUG+vtBh2Ufpu1et5YFlrQcvF3juKz81uPii0TFngmbkCvkiWqqnFfVRf8Putu0
         K4OA==
X-Gm-Message-State: AOAM533vn0L7X0vSLyMJ8hMWYoBki9e0OtSm9PCizUmR5ikwFYhwrFil
        vA7f9fhJB9hq6aYqkCqYLqw=
X-Google-Smtp-Source: ABdhPJw5md11+Ii1G8Bhy3jUs93vi7NkgN2xfyQ0lWdTsDFleJsGtbOnjfPFHcuGgR0fM0ZPg7iqeg==
X-Received: by 2002:a62:8283:0:b029:336:6e7a:9c73 with SMTP id w125-20020a6282830000b02903366e7a9c73mr22325718pfd.45.1626780374946;
        Tue, 20 Jul 2021 04:26:14 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id b22sm19215688pje.1.2021.07.20.04.26.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jul 2021 04:26:14 -0700 (PDT)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] perf/x86/amd: Do not touch the AMD64_EVENTSEL_HOSTONLY bit inside the guest
Date:   Tue, 20 Jul 2021 19:26:05 +0800
Message-Id: <20210720112605.63286-1-likexu@tencent.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Like Xu <likexu@tencent.com>

If we use "perf record" in an AMD Milan guest, dmesg reports a #GP
warning from an unchecked MSR access error on MSR_F15H_PERF_CTLx:

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

