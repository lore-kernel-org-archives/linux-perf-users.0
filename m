Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AFEC83F01
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Aug 2023 19:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjH3T4I (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Aug 2023 15:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbjH3Tzu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Aug 2023 15:55:50 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ACC67E6C
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 12:26:20 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64bd231c95cso602066d6.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 12:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693423508; x=1694028308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbk9s2ed2Gi+5NJ1qOCnDItkdATQhrhodWS8k0Aq0HQ=;
        b=c4GU1GcE73JajOMrqra6IgWpPg0DWx13IzfTorEvUS/o1BzpybJ5wfrrn9B1O5GhAG
         pA64VwbLLHjJSfkiU5HBbaao2c7LnjymkbNu4ZsejOhdawspFKWl47B9kjJx9hdfY2O2
         TeAu6umxkiX0jpW04vEc5+8MMkaQnx9Lo25pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693423508; x=1694028308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbk9s2ed2Gi+5NJ1qOCnDItkdATQhrhodWS8k0Aq0HQ=;
        b=OnYrErT7HwIH2R19E/bWyyOU2cThrgjqqmL1Kq9RQ9W6AggeqhJeQQG9SSxhNFOzK0
         xEuummxxUid+huXRj/QXF4HUWsWuHG1DQMx9Rx66UcNfv82Ry5CUaxixntNsH8mlpQHw
         xNwbuLrS2TQ7yjTv9eObjwQupxUiscnK2SwKn7jF5fjq0By47BmLWGYW+uHD/g6OQSCs
         qNJ2b4PRnGDwN5v+Wsh1lgwzSE6TPwHAyaP1crGQZ4XH0HG0pEGsmWVYFKEUKXqu8zZV
         fj7zRI94ZrUabhUWhQwtPKgOsKbW3boGQngczk2/LCm3AiWbIF70N0z++qS+vdl1B2I+
         RpPw==
X-Gm-Message-State: AOJu0Yz/DCBg39WgYX359M5n2KAf+CsDOOZj22iXlWoiyCKSNEuSECkF
        rD0ks1W6qpM6LFNr676Z6FNkYntoDs5+kaH9L/F8GXdI
X-Google-Smtp-Source: AGHT+IHxDYoiWwRcFzk/j68VpzJh4FWcDcrG2boIQK6MYRCAWrovwACH3eHvWMJCrnBJyQGiUD8tUw==
X-Received: by 2002:a05:6a20:7f9b:b0:14c:40d1:e911 with SMTP id d27-20020a056a207f9b00b0014c40d1e911mr3916569pzj.42.1693422827426;
        Wed, 30 Aug 2023 12:13:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e315:dec6:467c:83c5])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001bbdf32f011sm11338928plg.269.2023.08.30.12.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:13:46 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, ito-yuichi@fujitsu.com,
        linux-perf-users@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 5/7] arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI
Date:   Wed, 30 Aug 2023 12:11:26 -0700
Message-ID: <20230830121115.v12.5.Ifadbfd45b22c52edcb499034dd4783d096343260@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230830191314.1618136-1-dianders@chromium.org>
References: <20230830191314.1618136-1-dianders@chromium.org>
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
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't actually have any good way to test/validate this patch. It's
added to the series at Mark's request.

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

