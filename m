Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F23EB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 06:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjG1GuY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 02:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjG1GuM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2023 02:50:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E693ABD
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 23:49:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c6db61f7f64so1722196276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 23:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690526996; x=1691131796;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCTbKLxJE0e0fl2gNVl7kq0Lz7zE9dDnQokd98Af9Ns=;
        b=X3zNA1RyzLTULsNbdzaguab4z5QUbvoNMUV1EWAEh8ykQMS+N/lSrXKHrjXCDjAIW0
         b8fAsPrrPrZUyGp2r2JOgYtx0Iyu2JRCxWsXHm0VA9DEhKb90ArH81bKpFGytwmaegL/
         ahLqi1dWB0gpwXhL71JAr4ayzjdZNvmRpaOg3DNpfus2x79fe2cK/zPF8M4yzx8dle8/
         lgYRqJGe5+65cNJgMBcb6mUsE4h8lwi7sFbN5W2Ys+inxantP8VFhm0mjMLMGq0MIX+3
         Q2qJAkJzldydQMadbHTKbjY/T5QuIThGF37ugL0IfZXuyIkE+c2o8kYT/YKIo3X65Ptf
         4j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526996; x=1691131796;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCTbKLxJE0e0fl2gNVl7kq0Lz7zE9dDnQokd98Af9Ns=;
        b=bTE0DAcx8TNl4KmZHXS9jDq6zlfoAo14AohJGbtFKMC+DkbVcOLdfq0L5s5L68qpaY
         zW+0x0++47adh/xDUpBudA32HuRsrO9ExZEcfhSEGLkJHmuNlG4fmfFxFCkuht0pX2pg
         JUoLuj1akeo/Rt7xjvpoMD/dxYFZgqLy6GQc3SBH6MxIZU4JOVeC5kZpZgJ0vS+aJETi
         7sNLkd+FGCHzL0rDlCt5rVONmLaDaYdV41Aic2cnbobPJOpH8jfj3DxPry2hNIHTmtXW
         O9Xx5GZZ15X3Kq0YgChHWN1rz96WiRlXrA3nqH9C7QHy3GdGEb+e1nU8YreZTc+O7QlO
         Ccjw==
X-Gm-Message-State: ABy/qLYbkmbJwkMRL8LeVvlJCZzTr5lJJ+HUMBp7HrI1HGGqn6U0G8ex
        dqXi4Y4w4iaRIIoH72seKl5W3pltRifW
X-Google-Smtp-Source: APBJJlF1VBO/nA6o0F1Sw4iDyXLL+nD10wzaY2iHSF0gHcJmj7AOkP0CJ29sQFCewflEsjHmJprWtoE0EOv5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a25:7392:0:b0:d1e:721b:469d with SMTP id
 o140-20020a257392000000b00d1e721b469dmr4543ybc.7.1690526996428; Thu, 27 Jul
 2023 23:49:56 -0700 (PDT)
Date:   Thu, 27 Jul 2023 23:49:17 -0700
In-Reply-To: <20230728064917.767761-1-irogers@google.com>
Message-Id: <20230728064917.767761-7-irogers@google.com>
Mime-Version: 1.0
References: <20230728064917.767761-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 6/6] perf build: Remove -Wno-redundant-decls in 2 cases
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Properly fix a warning and remove the -Wno-redundant-decls C flag.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build          | 2 --
 tools/perf/util/parse-events.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 20aa8545b127..b8f1e9ba8c6f 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -312,8 +312,6 @@ CFLAGS_find_bit.o      += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ET
 CFLAGS_rbtree.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_libstring.o     += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 CFLAGS_hweight.o       += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
-CFLAGS_parse-events.o  += -Wno-redundant-decls
-CFLAGS_expr.o          += -Wno-redundant-decls
 CFLAGS_header.o        += -include $(OUTPUT)PERF-VERSION-FILE
 CFLAGS_arm-spe.o       += -I$(srctree)/tools/arch/arm64/include/
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 926d3ac97324..ac315e1be2bc 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -35,7 +35,6 @@
 #ifdef PARSER_DEBUG
 extern int parse_events_debug;
 #endif
-int parse_events_parse(void *parse_state, void *scanner);
 static int get_config_terms(struct list_head *head_config,
 			    struct list_head *head_terms __maybe_unused);
 
-- 
2.41.0.487.g6d72f3e995-goog

