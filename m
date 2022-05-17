Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006E4C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 16:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351217AbiEQQvn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 12:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351212AbiEQQvm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 12:51:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA12403E6
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 09:51:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2fee45054e4so63259427b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=g2f4uvZg1OcpFGX2p8frlvTRX1+Tckj3KS/ktxrHk0U=;
        b=KBtLDSOQDN4CFp4UIghgcQ3ZBvT6TcmYf/vyAAE00IVbD8yOelUIzlITkm2MKrJhVg
         EuQZsVUoCNk/2XD7/A7mN6pUw1Sb5tvJGl10A5Hvodn/A5p5RGqaQGn7epS3fk2/dd8p
         wARMBv0ZqnZIXVGmuv1xOPpbgUozdHYDCNSpzf8FM/nOIqf4m6RDY+YJZr817HfMOI71
         gsqB0p1zGCP+Syyhu66PGxrra2f2/FUTGFHtKMmMQhjJuMiEpluBooZiw4DyPWGaTQXv
         q5bS5VYrVdwFHrDR3DmDEWmpmKdJUffZrdYCPLdxuB0zYeGxTtQl6STIU3QFhmqiXlls
         M7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=g2f4uvZg1OcpFGX2p8frlvTRX1+Tckj3KS/ktxrHk0U=;
        b=yWwUT/5opZICloeBCbeV4Rbx5rqyVoDqzJH+qikhHhcQlURyCQhRuGwuJ3tfn/vYwy
         7iEC5R93I2HKaHbXicOU5pxrNvuKPv11FmYkmbuGPkB555LgeHsrzyPUAgMneQ62Jukt
         OtwpC3WtxmhMOWwZYAN6+rlyH94fkNCJwuwl1Mmqtn+xM69p1vbIhRaTLKB9nd9Q7lUm
         WUIKmKCPCtjBw1kgfkIQ78yn/2xMkUu8Nn/QdvSSbreV3Qrdlp+ZI9H07F/3ZPlhF99t
         daYahzjx+WKtXQvYz4QAi0WcQPclFEfyPal442QH0ITvD/knY1Fg0z6aTnhwMMOYfrAY
         uCyw==
X-Gm-Message-State: AOAM532RA5inE4U43Ls9GDHkfvhpn2CaYqTBOeBkcRAmUqsHt0q69qKg
        j8cOxOKvsEIJMHYXwp8dLbKT4u9Irbav
X-Google-Smtp-Source: ABdhPJxnIXgI1cz6JmZ4YxDm1wQ3taF1Gug1SeXiL9AUaVPryKXUYqnzY8V+X518Ny5XwSUKJivzkTnhHYkw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a05:6902:114d:b0:644:ba0d:e95c with SMTP
 id p13-20020a056902114d00b00644ba0de95cmr24868885ybu.516.1652806300551; Tue,
 17 May 2022 09:51:40 -0700 (PDT)
Date:   Tue, 17 May 2022 09:51:34 -0700
Message-Id: <20220517165136.479226-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 0/2] JSON output for perf stat
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

v2. Fixes the system wide no aggregation test to not run if the
    paranoia is wrong. It also makes the counter-value check handle
    the "<not counted>" and "<not supported>" cases.

Claire Jensen (2):
  perf stat: Add JSON output option
  perf test: Json format checking

 tools/perf/Documentation/perf-stat.txt        |  21 +
 tools/perf/builtin-stat.c                     |   2 +
 .../tests/shell/lib/perf_json_output_lint.py  |  92 +++++
 tools/perf/tests/shell/stat+json_output.sh    | 147 +++++++
 tools/perf/util/stat-display.c                | 365 +++++++++++++-----
 tools/perf/util/stat.h                        |   1 +
 6 files changed, 542 insertions(+), 86 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
 create mode 100755 tools/perf/tests/shell/stat+json_output.sh

-- 
2.36.0.550.gb090851708-goog

