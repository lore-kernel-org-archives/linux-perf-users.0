Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1DDC61DA4
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Mar 2023 07:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCKHAg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 02:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCKHAM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 02:00:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15B114487C
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:59:42 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t25-20020a252d19000000b00b341ad1b626so2260184ybt.19
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517980;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwWoTjR86AKucZnLsGNUcUMK7gNda6D+/S/cfRQfBgg=;
        b=eElZEpPqgYjQPT+2OgFJo3tJTboFaG9WiNPK5qqArvz4zn9dLkynGNEg6xMvjQpfsB
         8VIgGN8gT1K2LA+1w7FACJ0oeu6GJzCk6x/Vt4K39kUe3JaWwQa4UIkDfsMp/3+5GeZD
         POGSCqaKPVtzV1MJgMTx/ERlkg8AW6eJHa0x4KZ9NvMfRLGV/n6sIZSu/Rc1VFz/zCw2
         RPvH3408SaVcFcAVh7ctiB/PTEKu9bWodiOA/MRIf7PQJt3QfR1SCsRAPLFDcGxQ1lZK
         2+TirLZ0YCwlUl+CgZIoAF0cdAF0x2AJwBmMMewK3EFLb1duc+Sk7cL+Xd3VtmemShtt
         1XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517980;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwWoTjR86AKucZnLsGNUcUMK7gNda6D+/S/cfRQfBgg=;
        b=l2VNIc2wzLWTiwv5A0Eu4vKi06/V+g5uvU71MGDTkViIfnq2iX8/UsMfI0QAuEBQf4
         z3B0Eg7Z9Zq1ljSIOmyJKGU8Xgull5xWHVa6w8pTVo2hATcEFQuJYA4/CvKpl3UrmRXB
         UVKNl65+FbeckKdvtO585brNV3CIFdRkR4G4pzuT//psXj6KRqSOCkW4c7qEBF0vaTcp
         MtV9LNBRGzS1ow//3Z0y0JPITW/X0aEsg55kFe4S99hh5lwXTmMr8YXyMoAjDWoaNxX3
         PLCeKTWvRuIc8D4BUz5mn3l4Bq4Twyd6XIGLoXkWPzf/ax2Wd07uQKfohH/4SBBYz5ed
         TQag==
X-Gm-Message-State: AO0yUKUdEQXocR2vMYYWvALb9w6sAu/5t6X0SPzNJbw4P8EOCpby/XTe
        5+0w8y88QiWepl5A9g5OZFvAuwWx8KHk
X-Google-Smtp-Source: AK7set8Vrv9NAbTX9LeVvPN5FFdwJH1Tgz4a3yXybmJZZZuxkA7pyjWm68DJOp93hT5QF5cnEQsir9bGAKm4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a81:ed06:0:b0:540:e6c5:5118 with SMTP id
 k6-20020a81ed06000000b00540e6c55118mr1450560ywm.2.1678517980596; Fri, 10 Mar
 2023 22:59:40 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:51 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-12-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 11/13] perf build: If libtraceevent isn't present error the build
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

If libtraceevent isn't present, the build will warn and continue. This
disables a number of features and so isn't desirable. This change
makes the build error for this case. The build can still be made to
happen by adding NO_LIBTRACEEVENT=1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9754218bd418..1b598c5e68eb 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1156,7 +1156,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
     $(call detected,CONFIG_LIBTRACEEVENT)
   else
-    dummy := $(warning Warning: libtraceevent is missing limiting functionality, please install libtraceevent-dev/libtraceevent-devel)
+    dummy := $(error ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel or build with NO_LIBTRACEEVENT=1)
   endif
 
   $(call feature_check,libtracefs)
-- 
2.40.0.rc1.284.g88254d51c5-goog

