Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9341AC77B7A
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jun 2023 08:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjFAIaP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 04:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjFAIaK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jun 2023 04:30:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1046BFB
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Jun 2023 01:30:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565c380565dso16407827b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jun 2023 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685608205; x=1688200205;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AJYoAZgPIiDuHSYNOWGMDwA/YHr80AahR9Q3zVEDTVM=;
        b=IF2Q6WpNHXGykYNxyjo9CKJ30iM6bJuTd0E/lD8fUzwVbibgyfXzaplSgph4zbwRR3
         ues5qwpJzCPps/4yXt+RektwBqd88CoOX88TUBahSwN/aC2OKxALnkh+pHXqd4FHlFzh
         iO1eEA5oNWtcTillM3wP1fURdHYSJrPLZpQrtBK55z384G0U4XsiNcW7RIdp1hYquMfK
         Q9Tbe3RG0f6KgO/NKqcKtQENCQmGB4QiYLkI12YBu78j+AyBk6ynttPouxPQ+9pyTCmR
         Q/cauB+fj4yrnY8b/LC+O7LMalhfz1lsh+k8nwt2ajcPDP2L4B9+1qW9sBO3qw8GnIV+
         KHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608205; x=1688200205;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJYoAZgPIiDuHSYNOWGMDwA/YHr80AahR9Q3zVEDTVM=;
        b=GdXmldtAi+voDBRO4NO3mKC+pJZijtNGbkyWLpvs7tl12C09xsTFsDyRm29sNpzeuU
         dePU7iXLHCqwbex1hFHLmPuAbvrF0BI0DXeqB9SuP43zNAPLf8fdK8DWha3pnEJoxpTG
         RsoIbmtZpeYftIn0DMvx51O3rAI8WaES7QgxG6wdtXnVvi7qoMXCCK3mBvcJyjQkway9
         CHLB5+0iOGPSyDV96DwXBJ7mWQkEWt7bID8gSlUpYELS3trrvxknEWEuDF3COCBujMne
         Io5VvM9jdHb8oC/ZjojnNcY02ZkyMWe2txjtDCYJDGCirP9VpdbSlHGNjHaa/BUwHFCw
         C1vQ==
X-Gm-Message-State: AC+VfDwk6C8TNDHWJ/ttuPqHVJEkLYuCyvL18idub4qSU+qSlniH9Gld
        8nUOh84gPBVDx0w96vUtECtI/pExDr7J
X-Google-Smtp-Source: ACHHUZ76F7YvzmYpsM2JRZi38NeqyIDY1FwbqlhWATkUQt6KUt5LS2Vbu6BDVQe9rMyV9NvlW7HiskEUssqB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a344:94b4:9b8d:a089])
 (user=irogers job=sendgmr) by 2002:a81:414b:0:b0:568:ed75:8b2f with SMTP id
 f11-20020a81414b000000b00568ed758b2fmr720776ywk.0.1685608205264; Thu, 01 Jun
 2023 01:30:05 -0700 (PDT)
Date:   Thu,  1 Jun 2023 01:29:50 -0700
Message-Id: <20230601082954.754318-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 0/4] Hybrid event parsing fixes
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
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Correct various issues that have come up in mailing list discussions,
the most impactful of which is the wildcard opening of events of type
PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE. But also try to avoid a
parse-error without a warning, have more fall-back behaviors and be
liberal with the definition of software events.

The majority of the change is in correcting the parse-event test to
match the new hybrid parsing.

Ian Rogers (4):
  perf pmu: Correct perf_pmu__auto_merge_stats affecting hybrid
  perf evsel: Add verbose 3 print of evsel name when opening
  perf parse-events: Wildcard most "numeric" events
  perf test: Update parse-events expectations

 tools/perf/tests/parse-events.c | 1108 ++++++++++++++++---------------
 tools/perf/util/evsel.c         |    1 +
 tools/perf/util/parse-events.c  |  104 ++-
 tools/perf/util/parse-events.y  |   10 +-
 tools/perf/util/pmu.c           |   18 +-
 tools/perf/util/pmu.h           |    5 +
 tools/perf/util/pmus.c          |    5 +
 tools/perf/util/pmus.h          |    1 +
 8 files changed, 698 insertions(+), 554 deletions(-)

-- 
2.41.0.rc0.172.g3f132b7071-goog

