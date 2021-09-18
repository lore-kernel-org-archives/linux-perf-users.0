Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1820FC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 18 Sep 2021 06:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E422461108
	for <linux-perf-users@archiver.kernel.org>; Sat, 18 Sep 2021 06:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbhIRGgu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 18 Sep 2021 02:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIRGgs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 18 Sep 2021 02:36:48 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9079EC061757
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 23:35:25 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id bm12-20020a05620a198c00b00432e14ddb99so37848085qkb.21
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 23:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Lm32FmRYTHzwDihLRfn9gVMwmM49x/wBngpw8Rp/W6Q=;
        b=tJLHBkovRav5ZhOJdQajhKGUP08CrIfsv3MLj0kPOK8ZHtDd2zKrBsK4XItYlBg2vA
         2/Jj+CNdROPm76DViwjJ2+9W1prI26o7szI7RDHJEQitbNRtkG8C9tXXuBLsuYwB6Jnv
         bA+de5pXnNGFpvi51Yc8vXMwDJsTAcNxElpnJEqh6MwszZtdrxlMgKEgRolqz503mJds
         iZmTrJ2OmRZv8DrItm6o+U/+qRe783JQKaHukuDSxucxM1o1sBe6lcoDVMadKiYVLJbo
         5K7+xyU/n15BEfjaOBiDFyU61rRE4C8QhO5ZD1D91DBfz1CquM09xbv6vxYdLO/s1r6o
         OGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Lm32FmRYTHzwDihLRfn9gVMwmM49x/wBngpw8Rp/W6Q=;
        b=C7yfUCb5117u8RHXh74DVHiVdTFnWqMaoB9HZSguO1MWtBUQjl5wGdTBmstmprqIWt
         N9Bd84PupHnjiTHKaSVgEOHHlHxhgvXFsIVbukj7k5J3L9F8W4fQGoAaJCNAVOhBtIhE
         VZ/YNWLtCTM5fVnaUuKU8LvMO+MhlQsge/JWmLWxL3DHG57k8VslO3r2tBPTVJscWLUZ
         UqP+0I3qjt5V6cmWkgLxo6ZeoHzlDTL6ryynENEUhQoMp5AyudxaFqjREhoTqr6MUJtM
         xYH1jBA/zJI5t0Xpyo/QDkglEnhQwEOhM35JNYhZEF6Xoz/jEc6kVr21AcFG3JP2dgEO
         jJUQ==
X-Gm-Message-State: AOAM532CZqH9b9d1EmdqxEShmpVB35MQ4gB5nN8PgmILtlQy1owQfNNd
        NCY6YumjJV3K6CzMnMTIdpJQ6qABh3cK
X-Google-Smtp-Source: ABdhPJyuKTmrHN5hLAl5zKKANvCUexbBu5o+5EnfM8fZFQAP6rCjS1cN50iw+A9pP9uqHVIsy3VpDYIPbVyp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6399:5df3:21d3:3cca])
 (user=irogers job=sendgmr) by 2002:ad4:4ab1:: with SMTP id
 i17mr14700349qvx.11.1631946923742; Fri, 17 Sep 2021 23:35:23 -0700 (PDT)
Date:   Fri, 17 Sep 2021 23:35:05 -0700
Message-Id: <20210918063513.2356923-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v8 0/8] Don't compute events that won't be used in a metric.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

    
For a metric like:
  EVENT1 if #smt_on else EVENT2
    
currently EVENT1 and EVENT2 will be measured and then when the metric
is reported EVENT1 or EVENT2 will be printed depending on the value
from smt_on() during the expr parsing. Computing both events is
unnecessary and can lead to multiplexing as discussed in this thread:
https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/

This change modifies expression parsing so that constants are
considered when building the set of ids (events) and only events not
contributing to a constant value are measured.

v8. rebases, adds an ability to compute metrics with no events and
    further breaks apart the "Don't compute unused events" part of the
    change as requested by Jiri Olsa <jolsa@redhat.com>.

v7. fixes the fix to be in the correct patch.

v6. rebases and fixes issues raised by Namhyung Kim <namhyung@kernel.org>,
a memory leak and a function comment.

v5. uses macros to reduce boiler plate in patch 5/5 as suggested by
Andi Kleen <ak@linux.intel.com>.

v4. reduces references to BOTTOM/NAN in patch 5/5 by using utility
functions. It improves comments and fixes an unnecessary union in a
peephole optimization.

v3. fixes an assignment in patch 2/5. In patch 5/5 additional comments
are added and useless frees are replaced by asserts. A new peephole
optimization is added for the case CONST IF expr ELSE CONST, where the
the constants are identical, as we don't need to evaluate the IF
condition.

v2. is a rebase.

Ian Rogers (8):
  perf metric: Restructure struct expr_parse_ctx.
  perf metric: Use NAN for missing event IDs.
  perf expr: Modify code layout
  perf metric: Rename expr__find_other.
  perf metric: Add utilities to work on ids map.
  perf metric: Allow metrics with no events
  perf metric: Don't compute unused events.
  perf test: Add metric test for eliminating events

 tools/perf/tests/expr.c       | 159 +++++++++++-----
 tools/perf/tests/pmu-events.c |  50 ++---
 tools/perf/util/expr.c        | 137 ++++++++++++--
 tools/perf/util/expr.h        |  21 ++-
 tools/perf/util/expr.l        |   9 -
 tools/perf/util/expr.y        | 343 ++++++++++++++++++++++++++--------
 tools/perf/util/metricgroup.c | 145 +++++++-------
 tools/perf/util/stat-shadow.c |  54 ++++--
 8 files changed, 650 insertions(+), 268 deletions(-)

-- 
2.33.0.464.g1972c5931b-goog

