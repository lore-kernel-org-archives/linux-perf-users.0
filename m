Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D36C32772
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Aug 2022 22:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiHWWNQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 18:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiHWWMm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2022 18:12:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E867D1D7
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 15:11:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-335ff2ef600so261891847b3.18
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=vpCoIyKRZsG9sSnwmRTlOTB6YRSjIw+Qbk8jvYcuaVE=;
        b=XvSozB/DWuMKSbNHJ9l9xde2KRhs2B7hPE+zZEBJfJd7Fr6E4lDsopXJvIdm2+oO9j
         jr31g9cAChKqFWsNNLIHJdF30A0bR3Cv2hneJzi8ReQowFjtktbkfhgyuILUR7cXFQvA
         PjhFeFqrLVQ6dfX4gTRChIm+bE3ZoENvEXXD1WXoSW40LGANh/e2+thBWHo9naOHrsJq
         PyBkagsL2dz4ZfnZRB88Ff4UDmD7DseC9LNSz8vpLyrAH8a45cAWOGDS4JmAcqncLx9g
         k6mivrsUv+Wz/1aLhsPxsuwDEOf0RevYE/lwTzq/W/n8zvM1Bbnbo1lXkXaDP2Gg24/M
         AFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=vpCoIyKRZsG9sSnwmRTlOTB6YRSjIw+Qbk8jvYcuaVE=;
        b=H12Va3rMuz+JFzm7N3XewwPpuFXSj9fFZBQP/AyUQNEd44n5kqF+xyQl/hPDa/uJkR
         Lu2gdHXRrmbRWkIeYcOBF8BS/+vr7rhC+AIcAp1HbJYmehWMOkBl1yl+qygfVwlupX7D
         ChFTyLde5aOuw+A37uYy6EsK4mRaM8wgyvk5YzBpmDBaYYy+IHUV6Lr0DSVkH5DyysYy
         im0frosY7x4TUHAehrvEujo+PXr56NPYdYck/LJBJCN1JI1wD6VgRGP/n/eYRksS4eXv
         lWppDRPllfItGOBDZnMzOsTZAqkVI9FBYl8/MUsrT9b2cWp4vOy9gdQf73o0Dscl70KM
         80uA==
X-Gm-Message-State: ACgBeo0s3SQ8K08Bg7JuJqWJjwRqC//L5F9n+RfrOikhGK3bZ7VkzvBm
        CtW7WDJbIq+U+G9zhbX2XiDawukjYXm1
X-Google-Smtp-Source: AA6agR6f5ty3lYMH2Y4qqlqwT9nA65Tc33n67UyVYg+Dgbepp9Cr8MCejsQA/hDfvv7R/YglXQcwvFGYYPpa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a25:cf4b:0:b0:68e:fea1:9fdc with SMTP id
 f72-20020a25cf4b000000b0068efea19fdcmr26259610ybg.643.1661292684631; Tue, 23
 Aug 2022 15:11:24 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:09:22 -0700
In-Reply-To: <20220823220922.256001-1-irogers@google.com>
Message-Id: <20220823220922.256001-19-irogers@google.com>
Mime-Version: 1.0
References: <20220823220922.256001-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v2 18/18] perf build: Enable -Wthread-safety with clang
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If building with clang then enable -Wthread-safety warnings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0661a1cf9855..0ef6f572485d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -19,6 +19,11 @@ detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 
+# Enabled Wthread-safety analysis for clang builds.
+ifeq ($(CC_NO_CLANG), 0)
+  CFLAGS += -Wthread-safety
+endif
+
 include $(srctree)/tools/scripts/Makefile.arch
 
 $(call detected_var,SRCARCH)
-- 
2.37.2.609.g9ff673ca1a-goog

