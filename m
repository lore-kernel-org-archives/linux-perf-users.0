Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3381EE49AE
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Aug 2023 21:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjHVVbB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Aug 2023 17:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjHVVbA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Aug 2023 17:31:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1E2E4A
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 14:30:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf6ea270b2so19519455ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692739855; x=1693344655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHNo52jMQHCTTXv1njx0att1y1oc+xWVwUeLIRRfBAg=;
        b=YC0PScEPND5aZfA24ZoaI8wC1TSlRy2EYibMqFd2iUs8w7ZRXT3RKFlha3o6KDnWYU
         nghvF99uhQidPrOCTS7kFbZPlAlehSol1ZWc0mEDaepO6A4obV5tBwUEQIFSbbZWPuUB
         UgSIx4tkrAH1Cw/lnH0Vt27I3n+AIHy+x0WXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692739855; x=1693344655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHNo52jMQHCTTXv1njx0att1y1oc+xWVwUeLIRRfBAg=;
        b=HIOn9B3POwNcpI0VGULmQDVJBhHqwecu0XDC6qllZ+cwfbQyTBvp2YscGN6yDT0xbx
         oRKPeBMXKecVhlmCFgGHkoV1yN93TRD9D9qv6tN0ITYoZh5xhRkc9xgRe9VXEHKG+lvz
         wmOyeEYhtoTxEEptwLe7LKxARmIkewtoLGk3BUrMFnRIFj2F1Xex0KaHET2Q1v+UF+Pt
         4QtAlFr+eV00m3rCBDwTzQesSN64F33FO+aSFr4EZak00y+BKe37UmWfHOvJo8JfMCKg
         BJaEaQ/mC7XJNZYr4AuT1QvPh0mBug+ah1lFQtKzVPl39aqqrYE1s33M5bt1ytIvMbPt
         QFVw==
X-Gm-Message-State: AOJu0Yyhu6o8thycm83U3puWQoHKXgf36bF6sb/IKLVxcvVziSqiL9Ez
        TqMql5SxNBv6YQr4Oy+qYlXXLA==
X-Google-Smtp-Source: AGHT+IHswwKksNgSxyqElMvXEh66yr67LTxIGthRXPjy6R7WvznnHL9O4TkqksLBbcEBtlvUxYpXTg==
X-Received: by 2002:a17:902:e842:b0:1b8:63c6:84ab with SMTP id t2-20020a170902e84200b001b863c684abmr9273364plg.61.1692739854952;
        Tue, 22 Aug 2023 14:30:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:83f0:2bc5:38c4:a9de])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b001befac3b3cbsm9451475plg.290.2023.08.22.14.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 14:30:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 5/6] arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI
Date:   Tue, 22 Aug 2023 14:27:00 -0700
Message-ID: <20230822142644.v10.5.Ifadbfd45b22c52edcb499034dd4783d096343260@changeid>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822212927.249645-1-dianders@chromium.org>
References: <20230822212927.249645-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There's no reason why IPI_CPU_STOP and IPI_CPU_CRASH_STOP can't be
handled as NMI. They are very simple and everything in them is
NMI-safe. Mark them as things to use NMI for if NMI is available.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't actually have any good way to test/validate this patch. It's
added to the series at Mark's request.

Changes in v10:
- ("IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI") new for v10.

 arch/arm64/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 15b66dc1391b..c51d54019f5f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -946,6 +946,8 @@ static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
 		return false;
 
 	switch (ipi) {
+	case IPI_CPU_STOP:
+	case IPI_CPU_CRASH_STOP:
 	case IPI_CPU_BACKTRACE:
 		return true;
 	default:
-- 
2.42.0.rc1.204.g551eb34607-goog

