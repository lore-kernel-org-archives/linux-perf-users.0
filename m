Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8978EC47088
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Dec 2022 04:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiLBE65 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Dec 2022 23:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiLBE6e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Dec 2022 23:58:34 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2FD7555
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Dec 2022 20:58:29 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-37360a6236fso38350137b3.12
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Dec 2022 20:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fILq8A5qrz+unrhULUsXFNDjXn/1W1i4JLQUQRTfzvo=;
        b=acO/rNicqUru8CkyXkWALo/Fo2ksQ8hWFQGgauAkCDH9CYAjhXMx2G6uXmAEFKIYU1
         FEDkyb6VhGSOK4t1tK46XWBuCchhlS1aJSGEKIH79Q+G/OhDs4MXMewZmk34Rn8E1vM/
         mSRisawQckSeTp2MkhOMqYTigFB1Z9FMDVqpWaX9U4M39HG23S3FBx4aLE4ndNeqEnCI
         2BRkONxouTflHYDQgx1iDO6qwz3B2MTCqeeRsAc8W36Zm+6Dhabs1ZY+Fmqatd0/KZZx
         M1DWpDDg0SjO4hCaqS04mv5+k9MacTqZ3R0iYJO3mfBnIj0cw0trCdA7okWKg6xa1xsf
         YqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fILq8A5qrz+unrhULUsXFNDjXn/1W1i4JLQUQRTfzvo=;
        b=TPpV1TaUAep7CdYqcE1FFZRHJ/khIowoDqTQlb/w6WNGbqfiPp95zi+SXi7WGP3zRV
         6GpdNd9GPDHoWy6zVSR+oXgGPiXkbbia/qr6h5HCtU0srn3rW3EGrh4jePr9Zq/8TICe
         u5rFhhfvopr1Vru6Nk+BHf6Qc8bv84JhQ0+99mksU/d1mqNfL5JQD9sCcN96naOrrNPQ
         uGhDZCNHN2wf86F5Yt6HKlylkRQYKVcxIqN/hC+uAqiOIFf7oQ8zui3WaL6cpqn3s0ZF
         sbOW1qeXMTdB/O1RpCKc27b3g1FWmk7WiLMxqy1p92z6uB5ledUwZqbnM+d6OqD3x4yz
         WjLw==
X-Gm-Message-State: ANoB5pm6GYpfP/M1ndyBkngU1Tgv2LpZ7wDUns5a55KUMeHPOeGY7gF5
        REJf6WA6qDSRq2iDCLcbYcZT62f4xXn9
X-Google-Smtp-Source: AA0mqf6J88v0jQ/vpUt8gWXuYLzszh3xJz4A/psqOw9CH17kaOd1Hvy7pJ8mWpeUGZogqM+Y2HcWcehDaIV6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e3b0:e3d1:6040:add2])
 (user=irogers job=sendgmr) by 2002:a05:690c:8:b0:391:c415:f872 with SMTP id
 bc8-20020a05690c000800b00391c415f872mr47275258ywb.318.1669957108981; Thu, 01
 Dec 2022 20:58:28 -0800 (PST)
Date:   Thu,  1 Dec 2022 20:57:42 -0800
In-Reply-To: <20221202045743.2639466-1-irogers@google.com>
Message-Id: <20221202045743.2639466-5-irogers@google.com>
Mime-Version: 1.0
References: <20221202045743.2639466-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 4/5] tools lib symbol: Add dependency test to install_headers
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Compute the headers to be installed from their source headers and make
each have its own build target to install it. Using dependencies
avoids headers being reinstalled and getting a new timestamp which
then causes files that depend on the header to be rebuilt.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/symbol/Makefile | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
index ea8707b3442a..13d43c6f92b4 100644
--- a/tools/lib/symbol/Makefile
+++ b/tools/lib/symbol/Makefile
@@ -89,10 +89,10 @@ define do_install_mkdir
 endef
 
 define do_install
-	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
-	fi;                                             \
-	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+	if [ ! -d '$2' ]; then             \
+		$(INSTALL) -d -m 755 '$2'; \
+	fi;                                \
+	$(INSTALL) $1 $(if $3,-m $3,) '$2'
 endef
 
 install_lib: $(LIBFILE)
@@ -100,9 +100,16 @@ install_lib: $(LIBFILE)
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
-install_headers:
-	$(call QUIET_INSTALL, libsymbol_headers) \
-		$(call do_install,kallsyms.h,$(prefix)/include/symbol,644);
+HDRS := kallsyms.h
+INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/symbol
+INSTALL_HDRS := $(addprefix $(INSTALL_HDRS_PFX)/, $(HDRS))
+
+$(INSTALL_HDRS): $(INSTALL_HDRS_PFX)/%.h: %.h
+	$(call QUIET_INSTALL, $@) \
+		$(call do_install,$<,$(INSTALL_HDRS_PFX)/,644)
+
+install_headers: $(INSTALL_HDRS)
+	$(call QUIET_INSTALL, libsymbol_headers)
 
 install: install_lib install_headers
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

