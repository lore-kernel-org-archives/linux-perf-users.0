Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7127DC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 00:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574DB61350
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 00:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbhIWAMJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 20:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbhIWAMI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 20:12:08 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3B1C061756
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 17:10:37 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id bj32-20020a05620a192000b00433162e24d3so14567369qkb.8
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 17:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0fQ8TCUq2nIKYsU5pQLtTTkuNxp/JAtlPHlUXR9S+Vg=;
        b=iI7qtmAmICkCCgLQogFaAY+iqk/g0Dx4kqDujqKKmXN0v1JFPQUul3NCyww0gCz+bh
         soWX/aTviRUIArTACFx4jx2YDtC/FS+VH3xG3lrhqQKz3eDY/Sf/na5CMpzHV3Jp6p+S
         vmwGIU1AFGE3XDfVSQi8SR+UxDkFdXWtVTTPHUsQziKUCV3Dxz7MnHRmmpsJ4yOsl5Nv
         e7G4Jco/RdvVPH/WvqiK+eu0wuw79xzZu6/fWm9FtXX38e3qGYteTYv37xU2cugbDrLf
         Fvl+PiIY7HA+F+tjRhBEA2R330mEZqzv0HZLdyulB7WvxnDh2bArBW9ZPsjbmHAaFuH8
         0Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0fQ8TCUq2nIKYsU5pQLtTTkuNxp/JAtlPHlUXR9S+Vg=;
        b=RakBlT077PvvlyC9KgrJvcT2eADPwU/Pem9oqntKoU1RImlBOD9ahMNV6XVMUpmOzh
         cplz16ybpNVMdn9d06cRpCeT/ZICpsS+8snZ2bwNLbZRPvp2HWemqEH+NvX+8jQfWwys
         BbKfIvLudUf3mWUiKi1XmzBfs35iO1Cp48OWwtfmge+GfU2ekv00iCMASO9s7Bm/5g/7
         yDJbHzG2m/tijloEZKB9D1wfbMPiHmtujF1cM4LYvhetbHCcydC2KtzN5yyMRNwFIJC7
         /rMhxeehvPo6KMBZzNY4naMfpDSyyTtwtN2s3FwFrJtpkx8j8SzUo1Jy4gbrmcH+31jb
         RNxQ==
X-Gm-Message-State: AOAM531StoY74ocepWYGFIB9ZJiybuFNR4endLnk3qwhVXCBY5hZqyzV
        pqI3PbCJmaDbXOa0st7onU1+bqKr2hjf
X-Google-Smtp-Source: ABdhPJy3RyfRfsylWhaJSckwnbpuVOrAcbDqdc5Kw2u184AKjwVFqJK7ZhO8wo5+A2EsARnq9Dm++Cv3pPH7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a05:6214:6a7:: with SMTP id
 s7mr1648022qvz.34.1632355836614; Wed, 22 Sep 2021 17:10:36 -0700 (PDT)
Date:   Wed, 22 Sep 2021 17:10:23 -0700
In-Reply-To: <20210923001024.550263-1-irogers@google.com>
Message-Id: <20210923001024.550263-3-irogers@google.com>
Mime-Version: 1.0
References: <20210923001024.550263-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 3/4] perf: Add define for libtracefs version
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This will allow version specific support of libtracefs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 2001c315f0db..0ae2e3d8b832 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1108,6 +1108,12 @@ ifdef LIBTRACEFS_DYNAMIC
   $(call feature_check,libtracefs)
   ifeq ($(feature-libtracefs), 1)
     EXTLIBS += -ltracefs
+    LIBTRACEFS_VERSION := $(shell $(PKG_CONFIG) --modversion libtracefs)
+    LIBTRACEFS_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEFS_VERSION)))
+    LIBTRACEFS_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEFS_VERSION)))
+    LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
+    LIBTRACEFS_VERSION_CPP := $(shell expr $(LIBTRACEFS_VERSION_1) \* 255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
+    CFLAGS += -DLIBTRACEFS_VERSION=$(LIBTRACEFS_VERSION_CPP)
   else
     dummy := $(error Error: No libtracefs devel library found, please install libtracefs-dev);
   endif
-- 
2.33.0.464.g1972c5931b-goog

