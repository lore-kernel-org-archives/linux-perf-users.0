Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF96BC678D5
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Mar 2023 06:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCKG6r (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 01:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjCKG6m (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 01:58:42 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D0D1F4A6
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:58:28 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-541665e581cso11467727b3.14
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517907;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3NhwBTfmVglAZRqsQmhfe71Rzl22nzSJC9LqarCaKaI=;
        b=fElNmip0BTpEUcUnQZTbwScWF+byjtbSTr1v+/fNKXShFigaOgNUsPUyepDifsXFRM
         GjtYEjMaWAmilGB5L+qcsVGjEjSGMd/LeJ4G4PISm/Qcr6mSeFSRGXMwIFTXlqpoDxqx
         uvOL6laMJmAF+1dp81n9lTMrmeOS29PZsukS94k2PzLInHyjjAn0Ikca29z18M4cqC9P
         pDbHtcs1qt0NwF2biwm7j/d3u91cLM2DA31ZRrxK9fk59zZkHZNyQju0Itf0+jXrviS2
         yX4IFl6BnsYqfYyCOaJ7WasvY5zSSdx4oLpfJ3YYqOWxo4POEGnix1tjSlJfAFmpqAK2
         kvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517907;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NhwBTfmVglAZRqsQmhfe71Rzl22nzSJC9LqarCaKaI=;
        b=McY6IhIXen9kpp7JMKQf+0/sitqqF/WPA1p1HJr3hiUsMvlCitJjrDhI5VyNdE+HuJ
         /QcD0ZtkvfCKyfBD66icYO1rI7iBFLDweOsYECVWmIS/rJly3smaKv59GUBFhOz5Dd0L
         Hcd4z1jb+YfBYqaeUwrkGPj1bF1m8/MV7dxJSUXP4zm0oq+PLXnvzNC/duNMCAUd9/kQ
         9qA5zgMMsUrCMxiM0n0+Vf6+yk8g1kwqxlm3ZDBgvGmAHU49Sn57ep+hbg2qTAwMjieE
         zxLcXbUcnMuQyWNPFLNDYeKr71s21Vfak8C0bK4+QXCATm5jV7vyMdK0WgvA/UtySOkn
         bzKw==
X-Gm-Message-State: AO0yUKXHy6JPe045mrpP3o85anH4mqMDFnzAvn5Smmte1tplOsskGxeG
        Mk1K3UwVD+YauMCdJvl1H6HTnGooUWr8
X-Google-Smtp-Source: AK7set/X4UK55tnSLb9uuZbddCfKNh6XVFOEDglMCEuZ2GT7wllVSHfNLypT6L+5C1w62Dki84zNDe5aQALx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a81:ac1a:0:b0:533:cf4e:9a80 with SMTP id
 k26-20020a81ac1a000000b00533cf4e9a80mr17706404ywh.6.1678517907341; Fri, 10
 Mar 2023 22:58:27 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:43 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-4-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 03/13] perf build: Remove unused HAVE_GLIBC_SUPPORT
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

HAVE_GLIBC_SUPPORT is only used in `perf version --build-options` but
doesn't control any behavior. Remove from the build to simplify it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config   | 4 ----
 tools/perf/builtin-version.c | 1 -
 2 files changed, 5 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 33d62d542fd5..a68a3e9b47ae 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -476,10 +476,6 @@ else
   endif # libelf support
 endif # NO_LIBELF
 
-ifeq ($(feature-glibc), 1)
-  CFLAGS += -DHAVE_GLIBC_SUPPORT
-endif
-
 ifeq ($(feature-libaio), 1)
   ifndef NO_AIO
     CFLAGS += -DHAVE_AIO_SUPPORT
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 0d9cda238c07..c5d03a11e565 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -59,7 +59,6 @@ static void library_status(void)
 {
 	STATUS(HAVE_DWARF_SUPPORT, dwarf);
 	STATUS(HAVE_DWARF_GETLOCATIONS_SUPPORT, dwarf_getlocations);
-	STATUS(HAVE_GLIBC_SUPPORT, glibc);
 #ifndef HAVE_SYSCALL_TABLE_SUPPORT
 	STATUS(HAVE_LIBAUDIT_SUPPORT, libaudit);
 #endif
-- 
2.40.0.rc1.284.g88254d51c5-goog

