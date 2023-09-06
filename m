Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EADEE14AC
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Sep 2023 16:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbjIFQGn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Sep 2023 12:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241224AbjIFQGm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Sep 2023 12:06:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307341733
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Sep 2023 09:06:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bdc19b782aso22349045ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Sep 2023 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694016374; x=1694621174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj/cLRwqRCqHI6A0+VpIGgNKYM1V9qr45vJe0jTCZJg=;
        b=cEhT/7znXR/2B3xM4G7FlP1sywa5OPN6DwgJEe7KycUG9SjyFT8vgkCFHT/RKh4PXc
         TYH0fGuurRMd11mFt6yFa5KsiotUIDFld4O8I5W3mehH1yDJxHvqDBHRevEmEhh7CsXX
         kWyOIYlZMlLPvkWIa4wqennjPxU5IXLf37ES4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694016374; x=1694621174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj/cLRwqRCqHI6A0+VpIGgNKYM1V9qr45vJe0jTCZJg=;
        b=Wqbh9S/XFMxNRvH35tXfrO/pghvpPWGvnGYXCF6NhtD5U8qfLPg91Ja+sx8+Q6nBvw
         PbwOu9hiom+1O2aLLRmVLZjOQM9rhxZjqBUrd1pJuupb/YMdb/q0ZNgUrxiaCTYiQcOM
         2GscEOQP463NZpqHZzoYnW46ALzBPjHhEv8GaL+SSzpP66vhiTPgcOjJQIatEqGo6qTP
         O061vH7zaEo9pOk4uwLAgpD5quLSuhizNPzy5uUHTVgtL76ATYSN4QRyujtVtgXo+9ae
         TZrcfCvpN1Guy8yC6hdiTEmUZ8dAKAW6PuPJ68/S9Xmp4TonFsGBvYDOMeNLOJYxIwdu
         tEsg==
X-Gm-Message-State: AOJu0YwqfeozKJB84xqNdwD5klsiFo7Dr6Gu/U/ArSkKMmg6CqcWPG0f
        p95OyuOZwh8dun3aQSO2NPJpNw==
X-Google-Smtp-Source: AGHT+IH8tU2R8ed2JHyL2LLKGxknTebDB1XNgq+5JhdlRzNQTuRPiDweqaRM4tYwRz/RnbnKvuWVOQ==
X-Received: by 2002:a17:903:32c6:b0:1bd:c931:8c32 with SMTP id i6-20020a17090332c600b001bdc9318c32mr15979784plr.62.1694016374620;
        Wed, 06 Sep 2023 09:06:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4a07:e00a:fdae:750b])
        by smtp.gmail.com with ESMTPSA id ju19-20020a170903429300b001b8c689060dsm11338859plb.28.2023.09.06.09.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 09:06:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephen Boyd <swboyd@chromium.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, ito-yuichi@fujitsu.com,
        Douglas Anderson <dianders@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, scott@os.amperecomputing.com,
        vschneid@redhat.com
Subject: [PATCH v13 5/7] arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI
Date:   Wed,  6 Sep 2023 09:03:00 -0700
Message-ID: <20230906090246.v13.5.Ifadbfd45b22c52edcb499034dd4783d096343260@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230906160505.2431857-1-dianders@chromium.org>
References: <20230906160505.2431857-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There's no reason why IPI_CPU_STOP and IPI_CPU_CRASH_STOP can't be
handled as NMI. They are very simple and everything in them is
NMI-safe. Mark them as things to use NMI for if NMI is available.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Misono Tomohiro <misono.tomohiro@fujitsu.com>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This patch is tested by Mark Rutland's LKDTM test [1].

[1] http://lore.kernel.org/lkml/20230831101026.3122590-1-mark.rutland@arm.com

(no changes since v10)

Changes in v10:
- ("IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI") new for v10.

 arch/arm64/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 28c904ca499a..800c59cf9b64 100644
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
2.42.0.283.g2d96d420d3-goog

