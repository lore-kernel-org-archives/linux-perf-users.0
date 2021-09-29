Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E8EC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 07:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A70613C8
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 07:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244505AbhI2HGP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Sep 2021 03:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244489AbhI2HGP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Sep 2021 03:06:15 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7726DC061749
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Sep 2021 00:04:34 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 62-20020aed2044000000b002a6aa209efaso7181233qta.18
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Sep 2021 00:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=485aqyMaDhgNS2O/IDjEvg+jxK02XiMi7beDqYxp0oU=;
        b=pn51I8FoCpp0r1PED2fZr8xnbRt/fFAtSye7wwHS3v5i7peflI0195y+mVTHkFdmsB
         xWM1nb/BQrYjDfZtCi1N79y0Ov8BNZsLNkLTCxd0q8qUr+HLUnGb4iKYmCZgmsZVpy9f
         3Ab9kA3sTdmkF/RT516ifCN162EU88z1b5BxNP/wsRKvOYBYAhgXebURobTSNG3mFggG
         T3mfnkBSQMb9SBBsCcsnHkqjNP+vvmc665nRH3Vs7/rWZm9zi2Cksri2yDHW/gK/edoL
         KnozByn9nPtxgxgS2du9I31tptg0QWOAnr7ji5UwKsgw9/6GPHrSlxotgZEXvQh20Vbv
         IaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=485aqyMaDhgNS2O/IDjEvg+jxK02XiMi7beDqYxp0oU=;
        b=lNRWkB4WbE0WqnTzq7Zs/vr72MYPYxbWBCQWmh135VDJbO08nFTRSR+IC8pJTx1NOT
         0qE4zCt2xE5t4nau66ojvqj37OwU8MQbtdjaVmb6XQxMDSOscM69yg+rYCkOLDjz3ZA5
         Nu7NoI3GT6esCAAF83W6jDW9oL5tfmKCYnRq0yt+DMOkxMwo1iKQob9tFfez9vYRFdAK
         4zMCTsvYKkmfvNB8htdkylpEiMIdogIb2GyoG3UB2Zbz4xDIMHoj2zrV6Ye7MtazxEuE
         bmogajg8eLp6KkExQNk6QoJ/LTOWo5FGDT1zvQDpw+uQowE2ctif91qmPHkgf3gorCxK
         O6aw==
X-Gm-Message-State: AOAM5336PI1W0joFnKiqstnzA7nwhqy2CsJ0Hfgmj2CPg7Mo4fqfc2/D
        SX6U34TygCnbeLKNJCH9YRand50Zzt67M1/KEfIOWYm7P5R3XR99MxSqe3cbNEOqE3rL6x0chbX
        UGZ6KEr+paJy/bGGaX3XoEqN/fcO5ONHVJr+iyA50wm1xeiW/WPUe6GPfeWvgtlqOeORmouco2v
        Sh6Q==
X-Google-Smtp-Source: ABdhPJz2Q+RMRv8+ZBVLFet3MQ700VtyYjtKz5H2PNxHN4Iu/cz1l5TyAVcm2tlliSB/aDALbhTqgbx4QCnX
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:846e:ae82:9f80:179b])
 (user=amistry job=sendgmr) by 2002:a05:6214:17d1:: with SMTP id
 cu17mr10202777qvb.14.1632899073573; Wed, 29 Sep 2021 00:04:33 -0700 (PDT)
Date:   Wed, 29 Sep 2021 17:04:21 +1000
Message-Id: <20210929170405.1.I078b98ee7727f9ae9d6df8262bad7e325e40faf0@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH] perf/x86: Reset destroy callback on event init failure
From:   Anand K Mistry <amistry@google.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Anand K Mistry <amistry@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_init_event tries multiple init callbacks and does not reset the
event state between tries. When x86_pmu_event_init runs, it
unconditionally sets the destroy callback to hw_perf_event_destroy. On
the next init attempt after x86_pmu_event_init, in perf_try_init_event,
if the pmu's capabilities includes PERF_PMU_CAP_NO_EXCLUDE, the destroy
callback will be run. However, if the next init didn't set the destroy
callback, hw_perf_event_destroy will be run (since the callback wasn't
reset).

Looking at other pmu init functions, the common pattern is to only set
the destroy callback on a successful init. Resetting the callback on
failure tries to replicate that pattern.

This was discovered after commit f11dd0d80555 ("perf/x86/amd/ibs: Extend
PERF_PMU_CAP_NO_EXCLUDE to IBS Op") when the second (and only second)
run of the perf tool after a reboot results in 0 samples being
generated. The extra run of hw_perf_event_destroy results in
active_events having an extra decrement on each perf run. The second run
has active_events == 0 and every subsequent run has active_events < 0.
When active_events == 0, the NMI handler will early-out and not record
any samples.

Signed-off-by: Anand K Mistry <amistry@google.com>
---

 arch/x86/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e6db1a1f22d7..1f5d96ba4866 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2284,6 +2284,7 @@ static int x86_pmu_event_init(struct perf_event *event)
 	if (err) {
 		if (event->destroy)
 			event->destroy(event);
+		event->destroy = NULL;
 	}
 
 	if (READ_ONCE(x86_pmu.attr_rdpmc) &&
-- 
2.33.0.800.g4c38ced690-goog

