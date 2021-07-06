Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC5FC07E9B
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 19:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E07C61C23
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 19:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhGFTDO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhGFTDN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jul 2021 15:03:13 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71491C06175F
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Jul 2021 12:00:33 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u11so451205oiv.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jul 2021 12:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYqXeCbxfuybGK62bv3hAjB3EwNsrsPCCNHRlyOcG8Q=;
        b=SZDOnd82dh3+2n0fe48q5ZarUx6lX6BybOllKe1C3ezf752oddc2y8MINhFxAt3mIz
         qf6lyXwFzTHDe/G6j3FnMtjEeRoG2k+4weigV0vGziiwFm86Wc1YCzC9J4chsa1HUBYu
         CTDlWF1xKDjkcHKq3gPXddE0tCz2RKSWLxf4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=MYqXeCbxfuybGK62bv3hAjB3EwNsrsPCCNHRlyOcG8Q=;
        b=K9sMv5FhFwce2joTBWyPXtM/hR/p3Nzmeoq8XLqurDRbCSHA4H5x+7YnSrty6Uivo0
         uh0sUOevvdRCKMgnszC592bE2H9EHpHhByDTp7rZnPNSKvbJD5ZPT02BsFSu7jva2Kau
         5XvlBE0wVdBJNOh67+9DIHKk6NeEqEyJ1LyAKpIXgdBYr7bOF8obGHpx6Gm6yOKZn1f+
         9rbsLLX80O7RqYjUKWJ53MDRC/yUU305pmYgO8eKtkt9Ls6EDyKt1nmKYs6c+bECLPWS
         Rf9Nqpwfh4I+djZEfK3yWv6XJhwapo6NOg4wwMKD8mnM2un6Rtsn1fvaAfrXSf8zC3iv
         lN1Q==
X-Gm-Message-State: AOAM530JjVYn+/SYGrDa0wk3ni2IzHGc7nDX4GBy5yRZs4HNhIt3sJs5
        NG52SPwUz8+QpSTmhP63w5noog==
X-Google-Smtp-Source: ABdhPJwNSVBif6ncE0Xa4cvgNggvIOjnq3TNMxm/WAFC8jYHux3tTbOntJHGKfqlEknZOlPLy3FpFw==
X-Received: by 2002:aca:c74a:: with SMTP id x71mr1553537oif.35.1625598032637;
        Tue, 06 Jul 2021 12:00:32 -0700 (PDT)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id q26sm3470186oiw.25.2021.07.06.12.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 12:00:32 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
From:   "Justin M. Forbes" <jforbes@fedoraproject.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jforbes@fedoraproject.org, jmforbes@linuxtx.org
Subject: [PATCH] Fix the perf trace link location
Date:   Tue,  6 Jul 2021 13:59:51 -0500
Message-Id: <20210706185952.116121-1-jforbes@fedoraproject.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The install perf_dlfilter.h patch included what seems to be
a typo in the Makefile.perf, which changed the location of the trace
link from '$(DESTDIR_SQ)$(bindir_SQ)/trace' to
'$(DESTDIR_SQ)$(dir_SQ)/trace' This reverts it back to the correct
location.

Fixes: 0beb218315e06 ("perf build: Install perf_dlfilter.h")
Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c9e0de5b00c1..a1b9be78a1e0 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -923,7 +923,7 @@ install-tools: all install-gtk
 	$(call QUIET_INSTALL, binaries) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'; \
 		$(INSTALL) $(OUTPUT)perf '$(DESTDIR_SQ)$(bindir_SQ)'; \
-		$(LN) '$(DESTDIR_SQ)$(bindir_SQ)/perf' '$(DESTDIR_SQ)$(dir_SQ)/trace'; \
+		$(LN) '$(DESTDIR_SQ)$(bindir_SQ)/perf' '$(DESTDIR_SQ)$(bindir_SQ)/trace'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(includedir_SQ)/perf'; \
 		$(INSTALL) util/perf_dlfilter.h -t '$(DESTDIR_SQ)$(includedir_SQ)/perf'
 ifndef NO_PERF_READ_VDSO32
-- 
2.31.1

