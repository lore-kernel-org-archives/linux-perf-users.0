Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05A4C48BE5
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 04:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEFF5600D1
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 04:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFVEkq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 00:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhFVEkm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 00:40:42 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125C6C061574
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 21:38:27 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ef14-20020a0562140a6eb0290264197f11d4so8592324qvb.12
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 21:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nyVTW/NfJ2wkCeZoen2ILlMbYSDECf1cn5qBJJZCWd0=;
        b=StjSZaMiKwuHNW8eRDB3FLTFwf8cjEhtxJu6FkU92v+Z3/7nJFcKNz5XjgNJGC5F9m
         WPizMhjjmX598C8vs5Nuj2zz7H4cK+KVQqxx1SoOMdqE+DH4makOO32AROQnmIb7WntS
         E1Bn+sH17u9n70ZIpxXFVeBG8MPlWl6PL0SPyd/CDK9gO0uqOhMLXQxYmGILkzZs6y2A
         miU8D7FdzWkr+8/E3G43img0A6ubEPbHJL9Qn6fWibplgP653T23dP81deqAIa5gkXLA
         MVPZ3FQpPifveFlwchkeXCOvOgxgXiRBeNN8NTYrPbKuF57XJAJdfpeq6LBxECyPdgAI
         D8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nyVTW/NfJ2wkCeZoen2ILlMbYSDECf1cn5qBJJZCWd0=;
        b=EJC1CFiUNu9OeySOlWo6SJsCYuJNoBskDuU4ji6e0JCchcd562afFxBMNsIK8c+wch
         FUbeiokWry3+9ZUpYJhyO5/03ftZh++wgr5BQBAakrdvWCFzx5+mruuoT3osQuyJubJ0
         9EJTmC9dtMEopRwfPdCi4ZZXSyuO6+8ASdg7lT5eV7MygXkyur/CwIVrJxhU3H/v16fK
         VRT5dDx0flJtVc99zvWLYSRDM/PCjh1HRe3eIy8wUnXoCTu3UuGT/aS/YiTlpcw4wumF
         BFaxyI6vjChsR6G1HRSiR1P62bHtNhT0jd3iC2xcI2wBoH4QmIb5L/KXaC8kKOqioW84
         QgSg==
X-Gm-Message-State: AOAM531aKRmkWhzfEjinPOy/Rs42jnVWSIBQ77nGfRwkwiJt0yBljRL3
        rNN7BJPDPEMY9bR/kV5ozHiDwh0+o2i3
X-Google-Smtp-Source: ABdhPJyHs4a5JhBga/7EW6l/pbrlQ9A5LjpNk6gVqEAvuhNxI6xpHsW2C3GuiUPfAZksMXwqwd/WKy4G+TQk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ffd6:b7f5:87ee:7be2])
 (user=irogers job=sendgmr) by 2002:a0c:e8cc:: with SMTP id
 m12mr6473299qvo.27.1624336706133; Mon, 21 Jun 2021 21:38:26 -0700 (PDT)
Date:   Mon, 21 Jun 2021 21:38:09 -0700
In-Reply-To: <20210622043811.3108564-1-irogers@google.com>
Message-Id: <20210622043811.3108564-2-irogers@google.com>
Mime-Version: 1.0
References: <20210622043811.3108564-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 2/4] perf: Add define for libtraceevent version
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-users@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Claire Jensen <cjense@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The definition is derived from pkg-config as discussed in:
https://lore.kernel.org/lkml/20210610155915.20a252d3@oasis.local.home/
The definition is computed using expr rather than passed to be computed
in C code, this avoids complications with quote  in the variable
expansions. For example see the target python/perf.so in Makefile.perf.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3a8a54b71654..6f318c16e8f1 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1093,6 +1093,12 @@ ifdef LIBTRACEEVENT_DYNAMIC
   $(call feature_check,libtraceevent)
   ifeq ($(feature-libtraceevent), 1)
     EXTLIBS += -ltraceevent
+    LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent)
+    LIBTRACEEVENT_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
+    LIBTRACEEVENT_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
+    LIBTRACEEVENT_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
+    LIBTRACEEVENT_VERSION_CPP := $(shell expr $(LIBTRACEEVENT_VERSION_1) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VERSION_3))
+    CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
   else
     dummy := $(error Error: No libtraceevent devel library found, please install libtraceevent-devel);
   endif
-- 
2.32.0.288.g62a8d224e6-goog

