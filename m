Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AFBC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 857AC61019
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbhIWHsH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 03:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239676AbhIWHsH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Sep 2021 03:48:07 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5A9C061574
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:46:35 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 61-20020aed2143000000b002a6a0f52ce7so16882108qtc.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Sep 2021 00:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+00qEAwj7mfYfdJDyJ+kXVnL3ArsXZPVilwVl9NY3fc=;
        b=R8UCPAQRXKhCZXjEr4RxtJbqiJIC+ZzHziQJcQeaQ+K8VGsh0IFvAxv6mt8JkLohme
         4ul7XHLunuw9gvOdZw7SHJvGICIZTIkMrhuKWTuRZsCtf8gY96aSkL5n4UQJ+4UFuDOA
         TwAQ5rIWcazPzDhHVQFPvKveA/6YLsIE75ZaNVUKk4GbSkYWALSvnqznMH+FOmJfRYyS
         pM+p1F2CwO/NJ8nJ2GMdeGWN594TnU5eZ77buhIszvA9TQpQURMTcbyPyUBANlzdhUxK
         In/pVWcnYsQFgKNiMaEysj0JNfb2PHpxagaQXMmSGmRgR+iM7hpT2Nbou30ODdhY69dM
         lOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+00qEAwj7mfYfdJDyJ+kXVnL3ArsXZPVilwVl9NY3fc=;
        b=CEtIiXc/NKh06fBYZ3RuLZdXlztrB2YyBULFuoaZtweD7w2Tp3r3rSs5SIOHzqxsbk
         YYxrHy8TvEZLX1q1Y01Wxo095qZ0tgMmCtwq2aM8+3fr5S3Ng6KFuJimJRRNHwOJ8pmc
         1LffZGo6bHugNgCJNdmXpBeTWemO0k+uDdfPBoUVb54TcLs/kAVYPTUbKa4KmUlaXde0
         Y7Gpl2KA11QK8DaenUIqxaNIhKNTTu+hDrKChhd5WDgLa80/TColsehmnN4AXhM7Ckiw
         kl8/WDtt5+i0IgR5dcIWcDrWSxUfFvjb8l8PH6VYxWAI6YnpUxr5Psu1/iCSdRkKNKLM
         6q2Q==
X-Gm-Message-State: AOAM5320FXG4lyvfTu8K0P3dtYglEGdbZQwR9lvq6k/aj1SoferSLZd8
        O88Z2ru2mn69QNjR7GpKV1l5VVOAZBM+
X-Google-Smtp-Source: ABdhPJyEdvAC9RQ0uY3GzFfIYbmX4cXrTL5crIWju53GGYbD3tZh0BK6E4d6XOrjTOgD83VWKFY1oovyeGdQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:ad4:560b:: with SMTP id
 ca11mr3259794qvb.10.1632383194984; Thu, 23 Sep 2021 00:46:34 -0700 (PDT)
Date:   Thu, 23 Sep 2021 00:46:03 -0700
Message-Id: <20210923074616.674826-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v9 00/13] Don't compute events that won't be used in a metric.
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

v9. adds a missing memory allocation failure check in the pmu-metrics
    test.  A memory allocation failure in union returns NULL. Some
    parser debug on IDs is removed. "Modify code layout" is broken
    apart into 3 changes.  "Don't compute unused events" is broken
    apart into 4 changes with the tests merged into the change that
    adds the corresponding optimization. This is trying to address
    feedback from Jiri Olsa <jolsa@redhat.com>.  The unmodified
    patches have Reviewed-by: Andi Kleen <ak@linux.intel.com> added,
    although the overall patch set is largely the same as v8 which was
    fully reviewed-by.

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

Ian Rogers (13):
  perf metric: Restructure struct expr_parse_ctx.
  perf metric: Use NAN for missing event IDs.
  perf expr: Remove unused headers and inline d_ratio
  perf expr: Separate token declataion from type
  perf expr: Use macros for operators
  perf expr: Move actions to the left.
  perf metric: Rename expr__find_other.
  perf metric: Add utilities to work on ids map.
  perf metric: Allow metrics with no events
  perf expr: Merge find_ids and regular parsing
  perf expr: Propagate constants for binary operations
  perf metric: Don't compute unused events
  perf metric: Avoid events for an 'if' constant result

 tools/perf/tests/expr.c       | 160 ++++++++++++-----
 tools/perf/tests/pmu-events.c |  54 +++---
 tools/perf/util/expr.c        | 121 +++++++++++--
 tools/perf/util/expr.h        |  20 ++-
 tools/perf/util/expr.l        |   9 -
 tools/perf/util/expr.y        | 325 +++++++++++++++++++++++++---------
 tools/perf/util/metricgroup.c | 145 ++++++++-------
 tools/perf/util/stat-shadow.c |  54 +++---
 8 files changed, 620 insertions(+), 268 deletions(-)

-- 
2.33.0.464.g1972c5931b-goog

