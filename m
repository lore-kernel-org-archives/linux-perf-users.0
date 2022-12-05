Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33E9C4708C
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Dec 2022 23:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiLEXAg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiLEXA2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Dec 2022 18:00:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C9D1DF3F
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Dec 2022 15:00:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k7-20020a256f07000000b006cbcc030bc8so13951488ybc.18
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Dec 2022 15:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJd3unxth988O4ChzrsMI/KkhK+0qKkYIwY6FEhWnkw=;
        b=FRqWAbY73AhNd8V+YTBgN6yaWg8iUzX4pU80v+SCHpgI/CTXgfdrQ3K6fT+cpHj3uK
         EN5s0GjjgdzS3hy6tkwp/DWOzWu+WGEE2iu2CtwpTOxyXZvJlrJAR2lxwYo/kuruMZDo
         wXqcmeVWRRne58FdQ0dMiMTDtw4d25znA2BSldV2h539ICJgz5EFcbcAWd47VKBxVWHh
         vb1IRENH3hhu4plY23kCwlQSIOeMOPcxCGTPNVPZfP0cZyczVVfL/MnAW1TT2q0pMdvn
         NVnISfXhPsjcX8e5ezltJY7owSrNOQW6J8CidR0+9LbOp8S0MHg6xScCsZFP4rKQX0uq
         dgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJd3unxth988O4ChzrsMI/KkhK+0qKkYIwY6FEhWnkw=;
        b=0C/ydqoowFF5ujAsG1hFsJgMclEuKaIM5BuXTF8+9/2QGhNEFGMM0tCkKHlSdkrOVR
         rHIPpB/5Tm+QWmgKCr0a8joAoCUYkUSKazihldas3siB60hU4xgCmi7ltdLA1YegWetS
         Le3hS4TZUEDG30l8ddjVZlHp3+l6VeAC9tK1NXrIeLRMkypLQK76nczop4Djo+qFvsJj
         I8+TBLd8WaZF9Uv6P6dIF0QMHa3lmGq118gDARrVixHtrBAomo+iIv+o4yrAr8IqRdJO
         9GWLyyaamevvyhZ80Cl5FokcxRL5gmUEL58i7B+ANp0QlT5Kg0nOvTVfu43P61yOTpC3
         He5g==
X-Gm-Message-State: ANoB5pnymlim8+rBaKJp+UQXT76we/Gr1iaXSwCndzYQa/ygeNDSe0tR
        P3qIFXWSUoGl9M297Me0HOVfEBDK0CIQ
X-Google-Smtp-Source: AA0mqf6kYPN63s6r/LmOIdeoVrRTHGNcj1Yc84GK+j2U35wrcRGViI6T6nHPkyENWehvnR8R/w7RcTbddD1g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d2ab:5fbb:e81a:9151])
 (user=irogers job=sendgmr) by 2002:a25:d906:0:b0:6f9:bd14:f0b4 with SMTP id
 q6-20020a25d906000000b006f9bd14f0b4mr26845398ybg.408.1670281226358; Mon, 05
 Dec 2022 15:00:26 -0800 (PST)
Date:   Mon,  5 Dec 2022 14:59:38 -0800
In-Reply-To: <20221205225940.3079667-1-irogers@google.com>
Message-Id: <20221205225940.3079667-2-irogers@google.com>
Mime-Version: 1.0
References: <20221205225940.3079667-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 1/3] perf build: Fixes for LIBTRACEEVENT_DYNAMIC
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If LIBTRACEEVENT_DYNAMIC is enabled then avoid the install step for
the plugins. If disabled correct DESTDIR so that the plugins are
installed under <lib>/traceevent/plugins.

Fixes: ef019df01e20 ("perf build: Install libtraceevent locally when building")
Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a17a6ea85e81..6689f644782f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -884,7 +884,7 @@ $(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins
 
 install-traceevent-plugins: libtraceevent_plugins
 	$(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
-		DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
+		DESTDIR=$(DESTDIR_SQ)$(prefix) prefix= \
 		$(LIBTRACEEVENT_FLAGS) install
 endif
 
@@ -1093,7 +1093,11 @@ install-tests: all install-gtk
 		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
 	$(Q)$(MAKE) -C tests/shell/coresight install-tests
 
-install-bin: install-tools install-tests install-traceevent-plugins
+install-bin: install-tools install-tests
+
+ifndef LIBTRACEEVENT_DYNAMIC
+install-bin: install-traceevent-plugins
+endif
 
 install: install-bin try-install-man
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

