Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF5C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Nov 2021 17:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E64261216
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Nov 2021 17:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhKERMa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 13:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbhKERM2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Nov 2021 13:12:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEB7C061205
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Nov 2021 10:09:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b126-20020a251b84000000b005bd8aca71a2so14433492ybb.4
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Nov 2021 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wacezEpCKQOT7J0uXwLpWPgWJZoDmBOEitRRyB3vpok=;
        b=pWmaD7cr3Jh/On3VifbtQpfF2PGdjeJDLDLDeiC0UJq94aNCyl8W4XXmdhcGR9G7MC
         FvQD7t+CXP1PVwa+oFwRtYQbB1egZLdB6quuO0DcYjIEwdI9xz+bLmpXgI4ijj6JXqbp
         QyJ1EWlS5ICPkcL9wlEFTl1OeVyqS5+Ya9HgtEPiG4bcoPOD0zihfv0mcqRkMBcLnSge
         dEjnj3umhTGeqPmMD+pkWtiBwqW7b+RDh/7MLUsKMxutIy93R0ueZPKG1pLKPt4mFE4T
         ypj4aFtOJRGGRa7uLDyMgyNsR05gOFI2BqXrFyE14buaQ3ZrdFDfiUfuzACZwa4HPdMV
         436Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wacezEpCKQOT7J0uXwLpWPgWJZoDmBOEitRRyB3vpok=;
        b=N3YxYtFmJ5Mq2yFsybqev3qdHPywqCX2q1Zl7G0nfEfs+6YY+hzcYsWl16FVehZgbz
         RP0hL7yHIFWjsL5GW44ekzX2QQGp6sMuBDdS7P9rJ7dlXnePCwdQHeRodwbjSKW+zcHd
         vAXMpdimuCeLw/63zNsFyE/b1mYZBs02TWzE3lcYK4YqYbbQPj8FsPQLuj3E0IPFbOAU
         Tw0EsSJh6Q+KlLpSi0E4SQQgPkbw6XLPyL/Yc1lREM9fYNTk6n5gTp8XV8juD3xXCfi0
         7rKQmIYwewexL727TcrNcwKIatsC+NknxJS08SqW+SB+LcixU1D9mXzVT/59i0lNZvxA
         conQ==
X-Gm-Message-State: AOAM5316bh9w49+86iHOrWitGNN/B+z9P9OPuMvFeSSiv4Qu0dyrrFzZ
        Vr7tuLm0obkLpXw3vwZSZVJGKAJEgN9Q
X-Google-Smtp-Source: ABdhPJxPfYTMK2qfpEvH2rBPLEMClJc0cLuJc3Xqgtjmo1MyvTcaTUXQp8Ip14yuncTFnb8bBvgyfp73BfDA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4cee:beb8:1744:5207])
 (user=irogers job=sendgmr) by 2002:a25:4bc3:: with SMTP id
 y186mr60456831yba.74.1636132188166; Fri, 05 Nov 2021 10:09:48 -0700 (PDT)
Date:   Fri,  5 Nov 2021 10:09:36 -0700
Message-Id: <20211105170943.3479315-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 0/7] New function and literals for metrics
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
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
        Changbin Du <changbin.du@intel.com>,
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

Ian Rogers (7):
  perf test: Add expr test for events with hyphens
  perf cputopo: Update to use pakage_cpus
  perf cputopo: Match die_siblings to topology ABI name
  perf cputopo: Match thread_siblings to topology ABI name
  perf expr: Add literal values starting with #
  perf expr: Add metric literals for topology.
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
2.34.0.rc0.344.g81b53c2807-goog

