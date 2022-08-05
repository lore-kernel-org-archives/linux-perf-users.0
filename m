Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4DCC00140
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Aug 2022 20:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbiHEUBO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 16:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiHEUBN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Aug 2022 16:01:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF691056E
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Aug 2022 13:01:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f5960500bso29011667b3.14
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Aug 2022 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=TPA4kjSFICsXn08bp2O8DbS7GVoepT7HUImvMZXgtUc=;
        b=EUJQVBq8wQGUbeoC4LM+a0ZcItK4i5z4aVeVexPII27T+uNox8Tf2dlXuziWqyiJi2
         mULJwKXbqzl4PAZM2Mx+8r3018AdvVEcd2NvSMqNhddnhhHlP7BiPodoWgbO+wJa8PCu
         2KpsETx1bAUUxeVGhPKfCHrPfCyqV52DJJpEGY/aoIPtIBJSiqYjTlAiCMyNZSqfkN4I
         aWeTA0xIe/WU/9T1scu1183OthQi79d7eoF/BsHlgAmJwc5Jju2FyCkGD7NPVWTa8EXx
         mp55SKPRcXiZ+cvaorxsseL9zoKVKkrs0sVzDDemi960/yW6RRxiQpHZIrjUZnBPIDo7
         NRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=TPA4kjSFICsXn08bp2O8DbS7GVoepT7HUImvMZXgtUc=;
        b=P+C93jb/KezXs46fsSkgdUVa9jG7HLHTIHxNZTwhJA+CSfEIuXvyFo8je/M2BkpL/O
         HR6eNnS8lQ3WtiBSUxzKadUAdTAAlKjZwRCjGJtpcG1AmnNg4yp5f1k6oIinnDRXoeOr
         n02XycSHP0yxugWqFtBoL5H5uA6RR/jUiwM6DvIMkbbGAeTlOAz/YVMVrcfVL9f4HPS5
         dEMp5X0KIh2O7H1Ud6jICkly8k5CqF0eZu06fFM5JdG6sO1EpKcruWWclTdFTs/eFm7T
         CM1gnLm6l2Y3OzMVt694/TjOqr3KN6cQzlHz7cYOsK5Tqq3ADGaaBHXzojKzFDwgntHg
         C3tA==
X-Gm-Message-State: ACgBeo3Yh0o9uwdVXzm++/+iQfIrlwnf+SNAiD5APg78XebeiLTcmJ6y
        yDm/FcamcA56jlhR/+vzlh6ADW0jVCNt
X-Google-Smtp-Source: AA6agR6wefHb9/O/zaH25unXrOmpQ/k1hD+rfs0qrcehr5pdfSE9Ye83YI8613ejU7SEZ9MKhC9LifZubUVC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7470:b814:73a6:b6b9])
 (user=irogers job=sendgmr) by 2002:a25:50c3:0:b0:67a:6eb7:1f14 with SMTP id
 e186-20020a2550c3000000b0067a6eb71f14mr6617352ybb.246.1659729671847; Fri, 05
 Aug 2022 13:01:11 -0700 (PDT)
Date:   Fri,  5 Aug 2022 13:01:03 -0700
Message-Id: <20220805200105.2020995-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v7 0/2] JSON output for perf stat
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Parsing the CSV or text output of perf stat can be problematic when
new output is added (columns in CSV format). JSON names values and
simplifies the job of parsing. Add a JSON output option to perf-stat
then add unit test that parses and validates the output.

This is a resend of two v2 patches:
https://lore.kernel.org/lkml/20210813220754.2104922-1-cjense@google.com/
https://lore.kernel.org/lkml/20210813220936.2105426-1-cjense@google.com/
with a few formatting changes and improvements to the linter.

v7. Weakens a test and adds a Makefile.perf change Suggested-by:
    Arnaldo Carvalho de Melo <acme@kernel.org>.

v6. Is a rebase.

v5. Drops the merged CSV check, fixes a json test issue found by
    Arnaldo and a typo.

v4. Does some minor fixes to the json linter.

v3. There is some tidy up of CSV code including a potential memory
    over run in the os.nfields set up caught by sanitizers. To
    facilitate this an AGGR_MAX value is added. v3 also adds the CSV
    testing.

v2. Fixes the system wide no aggregation test to not run if the
    paranoia is wrong. It also makes the counter-value check handle
    the "<not counted>" and "<not supported>" cases.

Claire Jensen (2):
  perf stat: Add JSON output option
  perf test: Json format checking

 tools/perf/Documentation/perf-stat.txt        |  21 +
 tools/perf/Makefile.perf                      |   3 +-
 tools/perf/builtin-stat.c                     |   6 +
 .../tests/shell/lib/perf_json_output_lint.py  |  96 +++++
 tools/perf/tests/shell/stat+json_output.sh    | 147 +++++++
 tools/perf/util/stat-display.c                | 383 +++++++++++++-----
 tools/perf/util/stat.c                        |   1 +
 tools/perf/util/stat.h                        |   2 +
 8 files changed, 552 insertions(+), 107 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+json_output.sh

-- 
2.37.1.559.g78731f0fdb-goog

