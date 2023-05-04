Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15006C7EE2A
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 22:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjEDWPb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 18:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjEDWPa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 18:15:30 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B7B12082
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 15:15:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64115eef620so15686929b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 15:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683238528; x=1685830528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhHtU5MlgVkLZBN593zWW2dHO7raDMa9z0DGkh7aQQA=;
        b=AZfJjOvlBRLPq35PSplJJ+JYRGZt7OefDhVJlRBHr9EYYdVNT51FCHscN9mOVWJ7+X
         2XnR0HqhUhDmrlmX4oNHyvCzSNHTlLNyfKHQ8biB/hGV6PVWpiFIzyZaQ0nZtQgYNML8
         QgmfxWJsTrrtszemd5AoyBsyIti+tLvC+QSk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683238528; x=1685830528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhHtU5MlgVkLZBN593zWW2dHO7raDMa9z0DGkh7aQQA=;
        b=F/vCpoR7wpnP8YYYZQjtsshPmrspdHo+6hhAiN/LaiXlV1gwlL4Y1xUOw3ny9x/tgl
         TtE05g3yE12h6fzu/cCSt3uCpM+f8SteGhTdiPaVlN76wFOWSjBYy6CkocjujQlpEtyf
         rI5yTQFYkM5iAKMVDicUo/tJFWs46mXTfbOgkt/vf/wKl7BnE/B0x1tq8TRqNim2gmnZ
         RicU+dfJ+LCEKb1a7pZ3Ctta7WR6g0HB3bQMFO/IBGrkBfL8xD/xPih41AvNRDaFvgIz
         LTjzDS0fVL9/epjNJl4DpXYLBxualXaVOiazPQUdpRIufg7i/cUmK3QNOz1lcY1V5BW0
         foMA==
X-Gm-Message-State: AC+VfDwg6KtKfbwIM24GbstPgRmr5RD/HdkzAWHEfssk9nEQLecEG56a
        fMRjEFM9M83YkvssqRGtQSNSCw==
X-Google-Smtp-Source: ACHHUZ4biFdgijoXhRdQ+wzTyW9etdV3w75397sev3cW79igPU1T0GmbQpPqaTum52xSmugcqsSXFw==
X-Received: by 2002:a05:6a00:234b:b0:63d:3c39:ecc2 with SMTP id j11-20020a056a00234b00b0063d3c39ecc2mr4256892pfj.12.1683238527839;
        Thu, 04 May 2023 15:15:27 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:edf0:7321:6b9e:d5e7])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b006437c0edf9csm169615pfi.16.2023.05.04.15.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 15:15:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Stephen Boyd <swboyd@chromium.org>, ricardo.neri@intel.com,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wens@csie.org>, christophe.leroy@csgroup.eu,
        davem@davemloft.net, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, Will Deacon <will@kernel.org>,
        ravi.v.shankar@intel.com, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v4 14/17] watchdog/perf: Add a weak function for an arch to detect if perf can use NMIs
Date:   Thu,  4 May 2023 15:13:46 -0700
Message-ID: <20230504151100.v4.14.Ic55cb6f90ef5967d8aaa2b503a4e67c753f64d3a@changeid>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230504221349.1535669-1-dianders@chromium.org>
References: <20230504221349.1535669-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On arm64, NMI support needs to be detected at runtime. Add a weak
function to the perf hardlockup detector so that an architecture can
implement it to detect whether NMIs are available.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
While I won't object to this patch landing, I consider it part of the
arm64 perf hardlockup effort. I would be OK with the earlier patches
in the series landing and then not landing ${SUBJECT} patch nor
anything else later.

I'll also note that, as an alternative to this, it would be nice if we
could figure out how to make perf_event_create_kernel_counter() fail
on arm64 if NMIs aren't available. Maybe we could add a "must_use_nmi"
element to "struct perf_event_attr"?

Changes in v4:
- ("Add a weak function for an arch to detect ...") new for v4.

 include/linux/nmi.h    |  1 +
 kernel/watchdog_perf.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 90aa33317b4c..9caea5ba494d 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -212,6 +212,7 @@ static inline bool trigger_single_cpu_backtrace(int cpu)
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
 u64 hw_nmi_get_sample_period(int watchdog_thresh);
+bool arch_perf_nmi_is_available(void);
 #endif
 
 #if defined(CONFIG_HARDLOCKUP_CHECK_TIMESTAMP) && \
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index a55a6eab1b3a..0d1c292a655d 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -234,12 +234,22 @@ void __init hardlockup_detector_perf_restart(void)
 	}
 }
 
+bool __weak __init arch_perf_nmi_is_available(void)
+{
+	return true;
+}
+
 /**
  * watchdog_hardlockup_probe - Probe whether NMI event is available at all
  */
 int __init watchdog_hardlockup_probe(void)
 {
-	int ret = hardlockup_detector_event_create();
+	int ret;
+
+	if (!arch_perf_nmi_is_available())
+		return -ENODEV;
+
+	ret = hardlockup_detector_event_create();
 
 	if (ret) {
 		pr_info("Perf NMI watchdog permanently disabled\n");
-- 
2.40.1.521.gf1e218fcd8-goog

