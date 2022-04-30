Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4004BC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 30 Apr 2022 06:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiD3G0y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 30 Apr 2022 02:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiD3G0x (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 30 Apr 2022 02:26:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129A867D2D
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Apr 2022 23:23:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f4dfd09d7fso94036737b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Apr 2022 23:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ilFEwIrkZL4LC9Sgb4TefT5GSI3sDjL/JSRtfwvlYk8=;
        b=XKxfKiZWKR26TghXaE9JP/9B5Y+sDfK8pIqWwQVnmRr6tCybeUfbhZjxRpo0ucJoo/
         HTpIgSk64JCRj/FOflHY/fZXfzW6VC7cvQ2zlrJLdJlWGheLb9PgBsTqCzpB6JL1UG9j
         vGRXPlYkNgQO84nOlc6SdulmwuBBYiL1lGrgt6Y0K4GvsTvEIMF6bUwMy1DSQ1VjSZrV
         q6dc0BEbETWghfoSGWwNDCXUZCr+fC0Mswr9CRsnJZNJ8ENNnMsRGY/KifCHphJHTfJY
         VfY1dZQOk620wlICkjZiha3wuTpC/d5dD+5+YUFXQmFc/0smlYICvBuJmuYb7X18BmCy
         vCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ilFEwIrkZL4LC9Sgb4TefT5GSI3sDjL/JSRtfwvlYk8=;
        b=krJPmTG2TwYDDw4VNvQ38++G/wSgcVf0v6plkeuCCV7NaLrJWIYAXdx4PDA6nYwSxP
         zdQPVBgSk5bBNC5HtYbeSTWse6PZugeLew+IxnF0DZuvI/8VAuWGxoIyu0Dbf46YvqYt
         Umv6lP6/R52vYFew1PKtcytcIIfxYGWRnJz40zf6g6CFw+MddMdHQ7J7KqhHIXb6YB9Z
         zrwaHUhOXQERs98kdGT4WEDguNmieHKiAOg3246W7DZajYJzziTc5/WtLFlVlMLUvd+V
         7LRivBPn3fXgaOzoVN/rYTfeLF9CaHZMAue9FSAhmg7cy3Bnl82RzvOhm6LYKGHlUjoT
         c/7Q==
X-Gm-Message-State: AOAM5311cEbT4rNtKg4NspMF4Nyd1L30+QX65/d6Y9zfCbLh1HjpR75k
        ZER4CxohbVqU66scCehD+97ZN9k7AnJx
X-Google-Smtp-Source: ABdhPJxVabPnLRHKvnLALt55nPTm67ZCtR+e4Nldv4elgYdhSGX2Db3giMv00gcSHR4wcL9mKDMfLYiP6UHF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2481:caab:4fd5:232b])
 (user=irogers job=sendgmr) by 2002:a25:6a05:0:b0:648:f6c0:2c19 with SMTP id
 f5-20020a256a05000000b00648f6c02c19mr2504236ybc.55.1651299811215; Fri, 29 Apr
 2022 23:23:31 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:23:18 -0700
Message-Id: <20220430062324.1565215-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 0/6] Make evlist CPUs more accurate
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Based on the thread:
https://lore.kernel.org/linux-perf-users/CAP-5=fVMHzTfKdpWMXtbtx7t14u2f4WzNak+F0Q93cQ7CZfhbg@mail.gmail.com/

First patch is a cherry-pick to avoid a conflict of:
https://lore.kernel.org/linux-perf-users/20220414014642.3308206-2-irogers@google.com/
Second patch makes all_cpus more accurate when there are command line CPUs.
The third patch fixes perf stat metric-only output for uncore metrics.
The fourth patch makes cleans up merging of dummy CPU maps.
The fifth and sixth patch try to make user_requested_cpus and all_cpus
clearer with documentation and by renaming all_cpus.

The code no longer needs to add an intersect function and so the API
is removed and the merged API left unchangaged.

Ian Rogers (6):
  perf cpumap: Switch to using perf_cpu_map API
  perf evlist: Clear all_cpus before propagating
  perf stat: Avoid printing cpus with no counters
  perf cpumap: Handle dummy maps as empty in subset
  perf evlist: Add to user_requested_cpus documentation
  perf evlist: Rename all_cpus

 tools/lib/perf/cpumap.c                  |  4 +--
 tools/lib/perf/evlist.c                  | 14 ++++++----
 tools/lib/perf/include/internal/evlist.h |  5 ++--
 tools/perf/builtin-record.c              | 13 +++++----
 tools/perf/tests/cpumap.c                | 10 ++++++-
 tools/perf/util/bpf_counter_cgroup.c     | 35 ++++++++++++------------
 tools/perf/util/evlist.c                 |  6 ++--
 tools/perf/util/evlist.h                 |  4 +--
 tools/perf/util/stat-display.c           |  7 +++--
 9 files changed, 56 insertions(+), 42 deletions(-)

-- 
2.36.0.464.gb9c8b46e94-goog

