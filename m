Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E54C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Jul 2022 20:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiGGUMU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Jul 2022 16:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiGGUMS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Jul 2022 16:12:18 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E68F60521
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Jul 2022 13:12:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31c95f27403so85337237b3.6
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Jul 2022 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=R39MoO0H4i1puFWmocsrFgtr9MK3/WkIb4geb14BnSE=;
        b=Q/k598i7pvIY73IwAUUaDL6o5KD5RFPeQ1CNdhkbg3b8lniKssp1gzozKJMb/1XPwP
         MWem40hzDD0i7G95dBMEqBqbZR7k5REWqMqEaxFsJF+NlJmhFD/Ovh9J1J/6PIyg0pSQ
         /05bFOFsiIBT4dcEh3YoNuenMDXY48Dx63SkcbOaio+g+ixq5KQy7UL+2/vr9UbOczDC
         rB8YAYoIKFGCFiKUaPxtKJ30J0dKcUoovKVhdGx2wSWS13nB2MXfMKw9SzXTJD8eMZCP
         dy+CTDka0LK8VVineqsxL183/5bH/YFkHxxmtmzev1312mbIp3KmXfTVQacevvwD1e+Z
         cCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=R39MoO0H4i1puFWmocsrFgtr9MK3/WkIb4geb14BnSE=;
        b=vxuxGe7Pj5d9/lU+16GyDAM6NmjY1xH/2eD+1894xUnRAaAP/QCeynEf0kDA5u+BY4
         aza5Hd/sSMssK3oiqvc7wryGl9BkGCKQy0G/zOiOfNLtoDQlSo/FYIsjoRxcCtUWDBrm
         WeLCG5uhdAl7rB3pUvrHPvr2cjibLFZdAbKoPJOtGZwpsI27YCb04I9ZVFr7o9uARauJ
         XJfkr6me/SoCECp795nxGvsg0m/iSoG8ufd+xV2LvQeT7AId/E6QNpLSMx+JrVMHtowi
         X38JuYgIpt8N82FsX79C0iy3Cro7GI0Nxi6jU3Tbom1IBca+g5jdk3btMGnHHh+XxyTu
         jKTA==
X-Gm-Message-State: AJIora+6a2Ws5U46JQBlcLTBvVnEAFlw1JL9O7rKGAEtarww1IxjhvYl
        FiTtj6pL1ypxCWzBfHcmXoz5Fw5MiY8T
X-Google-Smtp-Source: AGRyM1vegzrGHxeJIXn4vdSZXtKkNGyhIThba54BjBCbstdGnx5+rLTxfP6LdRW03Y/Ia6KGGkCZGnFA4uW4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf75:f79:d509:a8d1])
 (user=irogers job=sendgmr) by 2002:a25:f50b:0:b0:668:27cd:ed38 with SMTP id
 a11-20020a25f50b000000b0066827cded38mr50880125ybe.606.1657224737360; Thu, 07
 Jul 2022 13:12:17 -0700 (PDT)
Date:   Thu,  7 Jul 2022 13:12:11 -0700
Message-Id: <20220707201213.331663-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v6 0/2] JSON output for perf stat
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
2.37.0.rc0.161.g10f37bed90-goog

