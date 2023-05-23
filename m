Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10820C7EE2D
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 May 2023 18:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbjEWSiN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 May 2023 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbjEWSiD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 May 2023 14:38:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD5012B
        for <linux-perf-users@vger.kernel.org>; Tue, 23 May 2023 11:37:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8a5cbb012so38112276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 23 May 2023 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684867058; x=1687459058;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ju7buyPyJ9bvfLq2NXpIgvtkH/8MxLmzehUoAiaTnJI=;
        b=hd8e7t1TYCr/xTBnGqf8GFehA5Y5dtwvU+0APhsLejJVh90Ku7PUpaawCfsLYkwNvD
         jeeGavanQeFaI6yeSm7F1SkpYEjy6UjaS+Tc1zqypdyHft89nZe9uVlBucdsusaOPgBl
         yyROA9mzDpWVpZrRqAsnQGwX6OJ6Csy8nUbqBQdnGSghwoK6zZphgva0mvRSKnWJjJmE
         OA5ubXiDDQLrAM1JtYNdkBEQXo80NJYLaua8uH8gpAbY5V129X+GcTAthonYzxVDtRjT
         ILPQI1msOOOXgmjry3zcZND+/95zIb4DI3qMZm0T7cbXVgsecWdUXt9QLcRUxgcPjTTN
         M9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684867058; x=1687459058;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ju7buyPyJ9bvfLq2NXpIgvtkH/8MxLmzehUoAiaTnJI=;
        b=X3v0JazI/4qbPFjJgNCIqb4obRN3+mo6beMl2Vc5WoQcuiszZiIgY7X0oOSelcL9XU
         FJEDZuVIAtZXgMCuMSN3E/Kf2A1lJVjnLE0KAN5cJDiC09ie/5XSM6Fx3z/YNMmsTYgu
         c2vOAZqLrcnlO0m3O6iz9o+aJ+4LjvMe3nlpoegfSblCCYrDalQ6Zfxk3GQznAA0rO70
         ztgpo8xjrhbTuE9t7S+0tN2qF/s8q6a1MiDtIKXxxQKhI6cxQjtWteynzWbW+OQH3whZ
         lE77w94AhItWjDc6pIWhyQee7S26IqFS4opwCIl/ubzd0Xe1iCz3PsJjEPNT7QuRyyCj
         pRuQ==
X-Gm-Message-State: AC+VfDwiczaYWXTVx42SVAiaDN/9w1DOuS6NqvsJjpM0IOTfgU+jFIoc
        wSQN1v81qXVCtZKfwSP5vUX62lAWqUEC
X-Google-Smtp-Source: ACHHUZ7gAW0NgmgzC954y/kQURbul/qKfWeKJcsete1Zyvyt7XR1Df22FwWl4aeTveeUuNeGAnOOpUHZE5aL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:235b:5195:e7b8:a5c2])
 (user=irogers job=sendgmr) by 2002:a05:6902:14f:b0:ba8:6148:4300 with SMTP id
 p15-20020a056902014f00b00ba861484300mr6219631ybh.6.1684867057943; Tue, 23 May
 2023 11:37:37 -0700 (PDT)
Date:   Tue, 23 May 2023 11:36:18 -0700
Message-Id: <20230523183620.1147607-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 0/2] Fixes from evsel__group_pmu_name asan error
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
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Changbin Du <changbin.du@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

evsel__group_pmu_name triggered an asan error as a list_head was cast
to an evsel, when it was the head, and the accessed as if it were a
full evsel. Further investigation showed problematic list iteration
for evsel__group_pmu_name whilst the list was being sorted so switch
to pre-computation.

v2: Address review comments/feedback from Adrian Hunter
    <adrian.hunter@intel.com>.

Ian Rogers (2):
  perf evsel: evsel__group_pmu_name fixes
  perf evsel: for_each_group fixes

 tools/perf/util/evsel.c         | 31 ++++-----------
 tools/perf/util/evsel.h         | 26 +++++++-----
 tools/perf/util/evsel_fprintf.c |  1 +
 tools/perf/util/parse-events.c  | 70 +++++++++++++++++++++++++++------
 4 files changed, 84 insertions(+), 44 deletions(-)

-- 
2.40.1.698.g37aff9b760-goog

