Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AF3C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 00:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FCB61247
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 00:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhKKAYF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhKKAYD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 19:24:03 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A92C061767
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 16:21:15 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id k63-20020a628442000000b004812ea67c34so2896740pfd.2
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 16:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=B4UOtBBGhwmFrPOJWP3A1UYwMSaQEiu5wNaDtht975w=;
        b=RLcalrnYrMgV+HOP9Q0u3v6VRm1BeSgsihRjym6UaOXaWJ8BXzqHlOFQ/EA56CoAz7
         sMXmVgc28aypxk1q3Qy5Djzzt29xcodDbsVzT7Iz0RuYkbK60druwwJOWbhDloxXEBnR
         7B8mzzXxvke4FD5AA7ro7oUhLtHSKQel6+PkTeJC5V/Mn25oRDm1gnnRwlcNuCZstngs
         FzlUHm8wwxStwrWJDlm7SOYHJ9B5e98skVr8ck6Rd7ly1bZR8iRwM0QzhqPp/h4bX0+E
         qRBQJVMk9vEL5Pgj59LN+68FQ8UoxrTqcKgQUhp7FDq873ahtGNdQwLykXtG4bv2sQ0c
         4VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=B4UOtBBGhwmFrPOJWP3A1UYwMSaQEiu5wNaDtht975w=;
        b=vjPYzzybu7iHi8dPz5szwODAT9+zfT6IFCL5MJoZkV9WuhqpFcUGR/dsL9d/el7Rkk
         fv11kbCOvTKJsvaq+wcQSc8l52JMCKwANZZrALZYUlapVOfwrdzZt1BeltAKNvs60QZS
         f3XLzsSXdNiQ5ZzbYRuP0YH+xD8UR6xWwGZJXVTHOLYZwuYFohIflkQE+hWofPPoTTAD
         v+QHG7VZpYC35N1DA/FVSmMcTOXEfcHEY2YfLV5+wv5YH9Q9JKnHKPapYMT1QzgnFlQ9
         rQwKDvAT9Hv1i9nSmdO/7OZgEf+RcI6CJgG2AUoazoRFr0qFbDKMJtQGA3BDwWuXgMMd
         yRig==
X-Gm-Message-State: AOAM530uRipXHio+UbdM7erVrRvKRT1UBemhLAIPjhmMOKBqT2TZ8GLL
        hd+ZN0LsOH1zfApFykfI4Tyeb30qrG7T
X-Google-Smtp-Source: ABdhPJxyr9glynTfEax3JRIPMW8SOOucQ0kEAcAAFvFY6h/WeRJ8AqbCxSOpNAe6C/+xnCzT/4p8LVIXqtAK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9510:b6b5:241:e409])
 (user=irogers job=sendgmr) by 2002:a65:4bca:: with SMTP id
 p10mr1870204pgr.391.1636590074888; Wed, 10 Nov 2021 16:21:14 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:21:01 -0800
Message-Id: <20211111002109.194172-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v2 0/8]  New function and literals for metrics
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a test for hyphenated events that are common with Intel's icelake
topdown events.

Try to tidy the existing cputopo code and make it more consistent with
the sysfs ABI. Refactor the #smt_on literal parsing into a general
literal token that we can use for more literals. This is then used for
num_cpus, num_cores, num_dies and num_packages literals that use the
existing topology code. Finally, a source_count function is added
which is used to determine the number of events contributing to an
aggregate event. The intent for these new literals and function is for
them to be used in upcoming metrics.

v2. Split the handle_id function refactor out of adding the
    source_count function as suggested-by Jiri Olsa <jolsa@kernel.org>.

Ian Rogers (8):
  perf test: Add expr test for events with hyphens
  perf cputopo: Update to use pakage_cpus
  perf cputopo: Match die_siblings to topology ABI name
  perf cputopo: Match thread_siblings to topology ABI name
  perf expr: Add literal values starting with #
  perf expr: Add metric literals for topology.
  perf expr: Move ID handling to its own function
  perf expr: Add source_count for aggregating events

 tools/perf/tests/expr.c       | 34 ++++++++++++++-
 tools/perf/util/cputopo.c     | 78 ++++++++++++++++++-----------------
 tools/perf/util/cputopo.h     | 33 ++++++++++++---
 tools/perf/util/evsel.c       | 12 ++++++
 tools/perf/util/evsel.h       |  1 +
 tools/perf/util/expr.c        | 65 ++++++++++++++++++++++++++---
 tools/perf/util/expr.h        |  4 ++
 tools/perf/util/expr.l        | 16 ++++++-
 tools/perf/util/expr.y        | 72 ++++++++++++++++++--------------
 tools/perf/util/header.c      | 20 ++++-----
 tools/perf/util/stat-shadow.c |  7 +++-
 11 files changed, 250 insertions(+), 92 deletions(-)

-- 
2.34.0.rc1.387.gb447b232ab-goog

