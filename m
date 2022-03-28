Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC9C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Mar 2022 23:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiC1X2g (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Mar 2022 19:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiC1X2f (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Mar 2022 19:28:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6835A2D1F7
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Mar 2022 16:26:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e6402f436cso131315477b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Mar 2022 16:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YjjZotq4RCxi1HEGt8XYTGKtlbxI8vX9wo23gAEItRk=;
        b=iHXjgH4UzFDWEG0VHQDrhIabSELk0bK1+ReWsLVjckUkLaaZk1/SR1Dm/fmDU/EGQ5
         n6XbhQwEbI5NhrZ3ERc7lqctlyLWj9GiSVc1uMpwLlG/gugGDBG+ZPCRO9tT2ACHtol4
         UtKOlHUM7PAHHtQQJtLe+J/nJDwTlbySOP0rsk1VpKIYBztcZ/KzpzNdYsPVLi0ca936
         TTymvZNYzc5cLvDYHXTP7amxRu8GbWPq/odwhZ/OSWuf10gChn09zIeQwezhicl02gyw
         OM7ZA+J5x0DikEYrxOWl6iyKUuRcWvxFYOBWsR+U9FQNPDa9WjrkdDV6tp00cunKv26W
         CoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YjjZotq4RCxi1HEGt8XYTGKtlbxI8vX9wo23gAEItRk=;
        b=X6mj4O1KvxTl/FW2/Rz84bce1wIou4wiKEtvnD84gM8flvacK7at2Vf8dfSSlmelmT
         BV5kzks9w7H04QXWPUmiH232QPJXjG1SnurZDHVtDzerhGvpgmGzdIZaAGchwms+WDwp
         9yKBoiFtpIRjmAV4KU0vJwyg1aDVTw3QmioF3OqvY7vsFcH/UgejT8dfyzBtisQkX+f+
         TsXSGEgdkOjajzYwLvz7ORfMvX3KBHjL+tV9OQZkcwWGXnru1WpkbgtRZsuE/rXnW8ZV
         VBOz2bhDoUyKMkVJx2ApJCr+BpeAVjuMfbFmTPVUybtP1a3lo0SM5rxUdTj62eSJZlzr
         ZjzA==
X-Gm-Message-State: AOAM531j/NpnwjOnKaZUMhy7t2L/pIjKu4ofXNrIczzYD1nvQhKOeeXw
        ancih50pHHLC6zR7q56ymx4sjHZjI1h8
X-Google-Smtp-Source: ABdhPJxVFhSI4U7NuLu+ZUaT4BpRjxW9SfXEvu4f1Ek8WdduDSegs7W19jH9xH8Bes9Ma1a3gJwRe2risubi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9d6a:527d:cf46:71e2])
 (user=irogers job=sendgmr) by 2002:a25:32cc:0:b0:633:c9ed:9e1a with SMTP id
 y195-20020a2532cc000000b00633c9ed9e1amr25234403yby.179.1648510012493; Mon, 28
 Mar 2022 16:26:52 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:26:42 -0700
Message-Id: <20220328232648.2127340-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 0/6] Make evlist CPUs more accurate
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

evlist has all_cpus, computed to be the merge of all evsel CPU maps,
and cpus. cpus may contain more CPUs than all_cpus, as by default cpus
holds all online CPUs whilst all_cpus holds the merge/union from
evsels. For an uncore event there may just be 1 CPU per socket, which
will be a far smaller CPU map than all online CPUs.

These patches change cpus to be called user_requested_cpus, to reflect
their potential user specified nature. The user_requested_cpus are set
to be the current value intersected with all_cpus, so that
user_requested_cpus is always a subset of all_cpus. This fixes
printing code for metrics so that unnecessary blank lines aren't
printed.

To make the intersect function perform well, a perf_cpu_map__is_subset
function is added. While adding this function, also use it in
perf_cpu_map__merge to avoid creating a new CPU map for some currently
missed patterns.

v2. Reorders the "Avoid segv" patch and makes other adjustments
    suggested by Arnaldo Carvalho de Melo <acme@kernel.org>.

Ian Rogers (6):
  perf stat: Avoid segv if core.user_cpus isn't set.
  perf evlist: Rename cpus to user_requested_cpus
  perf cpumap: Add is_subset function
  perf cpumap: More cpu map reuse by merge.
  perf cpumap: Add intersect function.
  perf evlist: Respect all_cpus when setting user_requested_cpus

 tools/lib/perf/cpumap.c                  | 73 ++++++++++++++++++++----
 tools/lib/perf/evlist.c                  | 28 ++++-----
 tools/lib/perf/include/internal/cpumap.h |  1 +
 tools/lib/perf/include/internal/evlist.h |  7 ++-
 tools/lib/perf/include/perf/cpumap.h     |  2 +
 tools/perf/arch/arm/util/cs-etm.c        |  8 +--
 tools/perf/arch/arm64/util/arm-spe.c     |  2 +-
 tools/perf/arch/x86/util/intel-bts.c     |  2 +-
 tools/perf/arch/x86/util/intel-pt.c      |  4 +-
 tools/perf/bench/evlist-open-close.c     |  2 +-
 tools/perf/builtin-ftrace.c              |  2 +-
 tools/perf/builtin-record.c              |  6 +-
 tools/perf/builtin-stat.c                | 11 ++--
 tools/perf/builtin-top.c                 |  2 +-
 tools/perf/util/auxtrace.c               |  2 +-
 tools/perf/util/bpf_ftrace.c             |  4 +-
 tools/perf/util/evlist.c                 | 17 +++---
 tools/perf/util/record.c                 |  6 +-
 tools/perf/util/sideband_evlist.c        |  3 +-
 tools/perf/util/stat-display.c           |  2 +-
 tools/perf/util/synthetic-events.c       |  2 +-
 tools/perf/util/top.c                    |  8 ++-
 22 files changed, 132 insertions(+), 62 deletions(-)

-- 
2.35.1.1021.g381101b075-goog

