Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D748C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 May 2022 22:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbiEZWpY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 May 2022 18:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349239AbiEZWpX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 May 2022 18:45:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A4CEAD0B
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 15:45:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-303edea0bfaso17475497b3.16
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jIodQqUTF1PbRDw3tEZrxjW1DLcLvwsf51++gy81Ao4=;
        b=bNc21YHtZhA4cFqL30hsg2EWcyiLMHiFXOvUEvo5TRQdcrDz2miWUbOMV6eJ+u2jVu
         EVBUVtyxyc2BRrBLopwThdnen4+59PTwuFeE3zxbXLjfRAf8q9UVtXqv74rVGgB3yd+l
         1ieknSdYsychMF6Asnzyy+oB7RDHRyopKdhL2MR+JvLaHsw/Dyzd78vXISwJFt27b9OO
         XH2NGFzf64P8QmnroL2jHkFSvr4oSFvjFkAXKYJKACC++9SnxQTefNU4wUn3dA+hHXru
         ifDqPoASXGOOx7cKkG6n9VvxrekXo6axJ2ezthjQTILlBJZw3RA6RvjHTt0FqqrNR654
         L/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jIodQqUTF1PbRDw3tEZrxjW1DLcLvwsf51++gy81Ao4=;
        b=kxAWj+ABqaj9sKup+Rff3sP3SnxaHIMeADrjILpZuYm1mU4xEMru5C0v7h7ghjycTo
         bHG/7eaGVhWji5+9wb20fWfQdFdhx5uhXQ8lFKD0UXYswafB+C7h1v2lmfPLLop9JGBb
         U3buJjLNSbD43jkd8FWRxC4lMj4qT8oog8KnI5VSLj4CZQhiwEa3Lty3GNX0U7AKvdlt
         lytPbWBRHLQVS28752ecfrymWP1AlIKui8Z3k53vrZaTmf1UK5FTp8SKvz9GHFLUDfB+
         iOY4Rr/cdHbRPdlVtD6asESlaKoE/8s72knvoTOxG6xkjbnIni3LjKDr/my/qdkCSuZ5
         vlQA==
X-Gm-Message-State: AOAM532lXWjkXtjOJourPL3n1cwbVU0c+x5+LOHk8lM06eY6nOIKL3dv
        hBFzUP4XRNdX+Oa/ziB47kpZUO/WTZVI
X-Google-Smtp-Source: ABdhPJzKyc8d19p/UH4LZ48Y6J8deQk/1R55EgGQCFn24MD4VK/AYiqWqd3iOZGVgYjSkftP4Pw9OLSBaMvF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4b39:e167:e698:7d4])
 (user=irogers job=sendgmr) by 2002:a25:3204:0:b0:65b:2c0d:3983 with SMTP id
 y4-20020a253204000000b0065b2c0d3983mr29828yby.89.1653605119079; Thu, 26 May
 2022 15:45:19 -0700 (PDT)
Date:   Thu, 26 May 2022 15:45:13 -0700
Message-Id: <20220526224515.4088240-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v5 0/2] JSON output for perf stat
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
 tools/perf/builtin-stat.c                     |   6 +
 .../tests/shell/lib/perf_json_output_lint.py  |  95 +++++
 tools/perf/tests/shell/stat+json_output.sh    | 147 +++++++
 tools/perf/util/stat-display.c                | 384 +++++++++++++-----
 tools/perf/util/stat.c                        |   1 +
 tools/perf/util/stat.h                        |   2 +
 7 files changed, 550 insertions(+), 106 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+json_output.sh

-- 
2.36.1.124.g0e6072fb45-goog

