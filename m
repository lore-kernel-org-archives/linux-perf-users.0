Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD32C6FD18
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Mar 2023 23:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjC1X4e (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Mar 2023 19:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjC1X43 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Mar 2023 19:56:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1640930F6
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Mar 2023 16:56:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 204-20020a250fd5000000b00b6d6655dc35so13572707ybp.6
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Mar 2023 16:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680047769;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwhWDPXvx6cfkb5reLksh9jCAury04O7LzcSvRbB8Zs=;
        b=Ltgu8Ff4auNliuT5UliaEkAuq9i2Tzu+5U2BQzip1AZokzyNRdwHBLrr0A1q1TCteh
         6HA8rQWn2amyDpZCOcWkijg0aV3wa7oBLO7ki4rM6Xzr9cqFtUVrftkblee0rzPjMb+L
         wJ4eW8t3SAEsbCXRcXZGpnQH05BULFCsjjs0PkcoeeHAo5P4f+L0tmwiyGtOxdqtUqwk
         lRhAg5051knYmNhbu0rixPc04ElVILRM6fmL1sequabHkJhfYFow2m9eE4OC/NNGI7D5
         M1zB/Iu+BE5dCWofkvweIXTenU0zYzPftguEROrDBdX8QE4rvu1TaHyUsk4TFKeXBN50
         OHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680047769;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwhWDPXvx6cfkb5reLksh9jCAury04O7LzcSvRbB8Zs=;
        b=b7XPbA6e87hwz0Lo24a53wuJAX7Aa4aj7smoku4r7pDDn1xhg2JnBkFRQjhjwHYTjm
         ghGgwOVhkw9jUoCLJ34tsmh2eFo8sqw23EqCCklpN6aDq/Tjn0Z2RvmbnTSzqGFSmcOv
         Dnv5KCRkB/vWNQO76swif8rBbdYEWzDvIHpGfBeFXiuzgHlI36okB8vu5kbvbWpusl1u
         z8gMMmIY8Kt4mh6kk5EXMJmYbbuTyHJ+vaAAm+KRuzeGR7xJ2DdcEgpJmJ4RWXfJPl4g
         WpXKgBabkjBHEy/4CN3O2+dD3kBQj8qNyAMU8QAZpyrZWo7LuR4ynVk12AkUo9rZkj1S
         lbcg==
X-Gm-Message-State: AAQBX9c5nzOA2ITqqMZoaNJ1Xg0llUwRD6vJ00ZS7D9cq72QkBRi3J4U
        63C255d6SpTHqMMob/9uusCioYN8subt
X-Google-Smtp-Source: AKy350bPHWqR7CBnjrbpMPu6sWr+4djUlu6CbJ9r9CJVXCNAz4PB6GrJeq1BsxI9gq7g43uy2Tw/VjdqKiJY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6519:f0d3:9540:5c31])
 (user=irogers job=sendgmr) by 2002:a05:6902:1003:b0:b1d:5061:98e3 with SMTP
 id w3-20020a056902100300b00b1d506198e3mr11705976ybt.6.1680047769358; Tue, 28
 Mar 2023 16:56:09 -0700 (PDT)
Date:   Tue, 28 Mar 2023 16:55:38 -0700
In-Reply-To: <20230328235543.1082207-1-irogers@google.com>
Message-Id: <20230328235543.1082207-2-irogers@google.com>
Mime-Version: 1.0
References: <20230328235543.1082207-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 1/6] perf annotate: Delete session for debug builds
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
        Tom Rix <trix@redhat.com>, James Clark <james.clark@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Andres Freund <andres@anarazel.de>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use the debug build indicator as the guide to free the session. This
implements a behavior described in a comment, which is consequentially
removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 4750fac7bf93..98d1b6379230 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -692,16 +692,12 @@ int cmd_annotate(int argc, const char **argv)
 
 out_delete:
 	/*
-	 * Speed up the exit process, for large files this can
-	 * take quite a while.
-	 *
-	 * XXX Enable this when using valgrind or if we ever
-	 * librarize this command.
-	 *
-	 * Also experiment with obstacks to see how much speed
-	 * up we'll get here.
-	 *
-	 * perf_session__delete(session);
+	 * Speed up the exit process by only deleting for debug builds. For
+	 * large files this can save time.
 	 */
+#ifndef NDEBUG
+	perf_session__delete(annotate.session);
+#endif
+
 	return ret;
 }
-- 
2.40.0.348.gf938b09366-goog

