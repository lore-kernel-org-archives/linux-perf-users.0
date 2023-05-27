Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D9CC77B73
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 01:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjE0Bm6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 21:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242767AbjE0Bmt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 21:42:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F60E4C
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 18:42:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso1214080b3a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 18:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151750; x=1687743750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhZKQ5chvzZjdXAK7yuxvuaTNwo4ZylkC6Gy3ujvEec=;
        b=Aa2FnlO7cA7GOt4jdHYmDdd1WDaYmdWhcVEaBF5A+6UaJVFXdOsQgbvTyfqoPjk4bh
         xDmNcaix5P9IJQEn4sRdp17S3cm+b5XkOk0LLoDg2dgEdaX2+JASBn14gthkz9JJvjeq
         /e8LlbDE1Czum9F+Yjho76XQANK+Ly3h8sjUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151750; x=1687743750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhZKQ5chvzZjdXAK7yuxvuaTNwo4ZylkC6Gy3ujvEec=;
        b=RQOky4l+ZPGT8IPRQ2TkSxVNegBoYGlAREP+njkgf988e8yx7J0IjOaEKOVuGqr/lB
         t7IUDkYEJFQaNNqU9MV1tuRWe4b8pp00CGbqmrZ9/twb18u1s73KyozC4tN849cfth6e
         5BqfoD9ITkp+gHF+/dPQp2mdwaXjPI09zl7u9yBGUDBcJvIgjdR4B91bn8kmcH007nn+
         EiR+NDDjiedqLr18ia+qoLbGrR0O55a4Ol9mW1myFfqLEX83+gh2/1HiGmxpOTMixof1
         MxxDUvEnOrrnChLqf0J442+ijyO73ey9n9vBu9qbxyTdARlD6y+I4OFKO7ghCfCbWe6W
         b1Kw==
X-Gm-Message-State: AC+VfDxIK7UG84D6y2ryVZ8XuhFkqqNZzerAGz92d2m+WiIwlYd+3i93
        e7DMPSfwJQ6ukXwHD7fIjdSu3g==
X-Google-Smtp-Source: ACHHUZ76rNf6n7Cx97qFMKMnLQrSEH7QLJeo9anNJyrNS+vARlA10YQ6Hwp4TAKjsYTO1yI+mRUWlQ==
X-Received: by 2002:a05:6a00:3911:b0:63d:2f13:200 with SMTP id fh17-20020a056a00391100b0063d2f130200mr6100546pfb.16.1685151750426;
        Fri, 26 May 2023 18:42:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:29 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 08/10] watchdog/buddy: Simplify the dependency for HARDLOCKUP_DETECTOR_PREFER_BUDDY
Date:   Fri, 26 May 2023 18:41:38 -0700
Message-ID: <20230526184139.8.I49d5b483336b65b8acb1e5066548a05260caf809@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230527014153.2793931-1-dianders@chromium.org>
References: <20230527014153.2793931-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The dependency for HARDLOCKUP_DETECTOR_PREFER_BUDDY was more
complicated than it needed to be. If the "perf" detector is available
and we have SMP then we have a choice, so enable the config based on
just those two config items.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c9df93402237..eb1edd5905bc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1065,7 +1065,7 @@ config HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
 
 config HARDLOCKUP_DETECTOR_PREFER_BUDDY
 	bool "Prefer the buddy CPU hardlockup detector"
-	depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH && HAVE_HARDLOCKUP_DETECTOR_PERF && SMP
+	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && SMP
 	help
 	  Say Y here to prefer the buddy hardlockup detector over the perf one.
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

