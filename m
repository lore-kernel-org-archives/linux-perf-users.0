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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CB3C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 07:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 886F260E76
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 07:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhHBHJP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 03:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhHBHJL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Aug 2021 03:09:11 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11495C06175F;
        Mon,  2 Aug 2021 00:09:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j1so23934797pjv.3;
        Mon, 02 Aug 2021 00:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AOZsXW9hACOugC8V16L56rF4ZBxWoq+nLcBwRkl2cto=;
        b=HwJQrN8r9lqPPo8iQqAfHbUzAX50uItU3ykESKsSsauMl2NuEodC5PssntDI5v0uo9
         ITM8jMZqaSyy98giZaI6A/ZKTAvAl2SQzNBF2ySdXZvD7IO4iBy+b4TJBL+xmAHWIf9E
         MOHuFDmp0AzrccCuSmpUAYt/uuQr0/hqA8SzLTOrVX4Tn0sQnz4r64Fy35v217V1Okz1
         M8GoAHHRcVJYKPwRfaS5MMoOi0RLw2KNEutmZcTeqr6pnuvjEcp+S2ERFvAZyvWjuyEL
         W73z/AtuUqLHQbsGo021uxb0fCA08br/ejB4gfG9Cpcnq+v0mdmcvc9sJx5+apZDNoO5
         PJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AOZsXW9hACOugC8V16L56rF4ZBxWoq+nLcBwRkl2cto=;
        b=PG7QDCYPT/euREx9jW/kmCU52bhIH9axlYAl2AsXu90tPpyqBDGxkWzvYPbrrJz2N/
         9X3l1ID0FfrMs1X8wwN7CM9f9i/217XWlKwuEtA5cOJ1fxnVb7NaDJeaR4MwpkPZomI7
         7PpSuhPH9zo+KXCL9+fYUz0X57HfvB8ziNoSg+WLNwMqwrDo8APGF+EGuJo1muFF4+9S
         QNuqEbtqaeztd4QtSyV5NYsNCLJIa8g1kVv8I2uYtiNakuGFsTb4ei220NZWM+7uZ7lU
         MNrEnNR4dIALCJP7QjRDlaIz8Jm0LJ9imEqy6LqVfew34LHFIe9o6Qmh7Zvj9KBBKuRC
         gnGg==
X-Gm-Message-State: AOAM533wBgs5WXK1Bi4asaT36rATOodxCBSjpoVNltcYEak1b4WFNFSX
        8WDqT57BIlNSUTVkt/SvVnM=
X-Google-Smtp-Source: ABdhPJzoCwMmpm+/FNSS9UEX0Mvdxk+Tn3aYpFcqdzxgnySrWhGudGNvYNOfUpjyJwBzO1VrD5jl7Q==
X-Received: by 2002:a05:6a00:1307:b029:308:1e2b:a24b with SMTP id j7-20020a056a001307b02903081e2ba24bmr15371208pfu.57.1627888141449;
        Mon, 02 Aug 2021 00:09:01 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id g20sm10391238pfj.69.2021.08.02.00.08.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Aug 2021 00:09:00 -0700 (PDT)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <joerg.roedel@amd.com>
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
Subject: [PATCH v2] perf/x86/amd: Don't touch the AMD64_EVENTSEL_HOSTONLY bit inside the guest
Date:   Mon,  2 Aug 2021 15:08:50 +0800
Message-Id: <20210802070850.35295-1-likexu@tencent.com>
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

Fixes: 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled")
Signed-off-by: Like Xu <likexu@tencent.com>
Tested-by: Kim Phillips <kim.phillips@amd.com>
---
v2: Add Fixes tag and Tested-by from Kim.
v1: https://lore.kernel.org/lkml/20210720112605.63286-1-likexu@tencent.com/

 arch/x86/events/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index d6003e08b055..1c3ae954a230 100644
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

