Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23058C678D5
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Mar 2023 06:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCKG66 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 01:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCKG6s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 01:58:48 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971FE4D2BD
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:58:35 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c039f859so77817127b3.21
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517914;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PA482r9MJe7vZyw+QOZf0rTvnugvk46HQTM8cqZhnKs=;
        b=tldDHr30uJ+HiUcXonL+iNvGzmn8jN/lqDwYD7A6znThCex6+p0hhXyH2E22r7ju24
         AKhEubUuV2ehF+HSJjPO2WNGupZA5GO3JpYAXJpNraNPd7wa27oEdnCM+YdBFgcv5DKJ
         AsIoeg13+loP7lUeb/pjdh0s/uGID0gWNy3wlLtGsAkG6jn5JPbZ92vQKHkCzzWl/2Za
         3MiqRrVtE4tceeZZ4X9S4TCY0MIHrZZCPHVUrf6aejhC2/SbfwSHLPygjhbnhP0J4LCi
         EKXq9nuSRtoMohBRC90vWQ8ldGj5RPu0mlDlZyx4M/gBKozzjbEps+beBWrfCdTGndQV
         SKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517914;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PA482r9MJe7vZyw+QOZf0rTvnugvk46HQTM8cqZhnKs=;
        b=GH9TwIcfVDH2h4uzDeAX9OEVya5qLTzGRc34kHfnGVm1MRB4KnE036fq9HL+zX2SEo
         4SU6dDdgXNOKdxKF9pD7N8foEN0Cd8qDDiXrTvQo/eUg6ZKH9TRfo4XD9tzt+WAEgY6a
         QYLRrwcLyS5ri1RaAGZYuqvYktVLdojyLjLFvD4fc/bWIRNmrUaIJu4E4USkRVw/RO9/
         cEn/GGI2h3J2Y9LDQ8qdlNAE3Yib5SWtbhsXNZDQGT2rZU701FKa1wCw1n58cybLsY+/
         lWMdwD4Bq7uesnmvz/kM9T9iIcxVyXJy4d+lhdlZEbWk9Z/tjFWA/s52Rf8JcqV2+h8l
         cEiA==
X-Gm-Message-State: AO0yUKVBvkGcy6byDuLbygjs7XQI1ysB8ssIYsmuzVYSZJ5ILnW0Q7h/
        MCJt2DgTWQRqAdJAbgEcfBjWf5W5zCBg
X-Google-Smtp-Source: AK7set9RA8SRXgCLcrsgukIbaEmnGpzcWQbxU3olQ8XTZGn0+orP5MYTuo3BIQ/YJ5keXXYT5pRAQOa65JN9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a5b:ccf:0:b0:a6f:9156:5579 with SMTP id
 e15-20020a5b0ccf000000b00a6f91565579mr14131802ybr.12.1678517914694; Fri, 10
 Mar 2023 22:58:34 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:44 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-5-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 04/13] perf build: Error if no libelf and NO_LIBELF isn't set
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Building without libelf support is going disable a lot of
functionality. Require that the NO_LIBELF=1 build option is passed if
this is intentional.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a68a3e9b47ae..5691e2ffb1b9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -426,15 +426,7 @@ else
       LIBC_SUPPORT := 1
     endif
     ifeq ($(LIBC_SUPPORT),1)
-      msg := $(warning No libelf found. Disables 'probe' tool, jvmti and BPF support in 'perf record'. Please install libelf-dev, libelf-devel or elfutils-libelf-devel);
-
-      NO_LIBELF := 1
-      NO_DWARF := 1
-      NO_DEMANGLE := 1
-      NO_LIBUNWIND := 1
-      NO_LIBDW_DWARF_UNWIND := 1
-      NO_LIBBPF := 1
-      NO_JVMTI := 1
+      msg := $(error ERROR: No libelf found. Disables 'probe' tool, jvmti and BPF support. Please install libelf-dev, libelf-devel, elfutils-libelf-devel or build with NO_LIBELF=1.)
     else
       ifneq ($(filter s% -fsanitize=address%,$(EXTRA_CFLAGS),),)
         ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
-- 
2.40.0.rc1.284.g88254d51c5-goog

