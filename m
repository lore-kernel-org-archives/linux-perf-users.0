Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18812C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Mar 2022 23:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiC1X3E (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Mar 2022 19:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiC1X2t (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Mar 2022 19:28:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0DA2DA89
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Mar 2022 16:27:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e8216c4c46so85508747b3.23
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Mar 2022 16:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=62T0/TU1Sa4Wqe+eN5txv4UBeKWrByFVFuAcfl2TJUY=;
        b=WuFWAPyS7pgyWDgjtlzsKpFPsxxPd9tgW0nM0IULEGbEsaEs5zE0BwR/iV0yiRyiUr
         C9LzDD7OQikFacW2EZ3HgTOERW8ioeMdDmGtbxjGjdAvIgFqPAGlWSKO/Fo07kxOusQj
         xXQTuUoN7COi2/I3yvyXPwYeetZ2hVDiAs6t36XmpeIj0N0pXu41bgEpHgFvTMqjwxGS
         YkJ0glvboVcb8xY9ZZdbAAgSHoReMnojd0N4VWMYdi2aBcDvyxepEb8RTHF4ZzMUgt9m
         qUiIro8106ztVL4WbMUEwnsQ0Z0mF/k9xEPBZD0X3XV3XPniYpCSNqCpBNG82OklWGGW
         su1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=62T0/TU1Sa4Wqe+eN5txv4UBeKWrByFVFuAcfl2TJUY=;
        b=7T2wDXPTH6vhte0eDg778cjY1OZtEIGGQZ6l7KR3cFTmkmfR3Rg6cWapEE38ZAh0g1
         XAWKqVOzUlaagL18iwQ3/B/TgYDEy07DJG6wSWije64phcmlKeCS6bXWlR4Tq+GHDuac
         QS46Ta39DJL/KJPQceFg+4u6B2a3B9wBcNfB1TlhqYcgo1OFPoA8MayArswdUaqi74En
         izExTwPEgrPdoIUviHlu3G4azqL0/TM6+fer7yOwy5lDki3tTcccarzol8q5/k5bgMZ2
         uVxtDnAd+YRVrcat+o/YtUbpM+AZ/uMnMXWNKhLc1ujc3a0Aogp/vWap/OfC6H9B0k1c
         ON/Q==
X-Gm-Message-State: AOAM532ITjP/sPVetx5ovlmCJOVGWLhRMlNRVWC16BmE2VGR9QEwzkgL
        lUJNBA8gSaVEd8QECgn8PMSuxr0sRx8P
X-Google-Smtp-Source: ABdhPJyGiiWxc4ARHStwB+ZXo/aW9HRYLxvc/de+ZQtJa8gJqpvKLIH6JBfkA9BFTOaLI3PuawSjmI+3PmmF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9d6a:527d:cf46:71e2])
 (user=irogers job=sendgmr) by 2002:a25:ba04:0:b0:623:ed7a:701d with SMTP id
 t4-20020a25ba04000000b00623ed7a701dmr25269976ybg.209.1648510026853; Mon, 28
 Mar 2022 16:27:06 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:26:48 -0700
In-Reply-To: <20220328232648.2127340-1-irogers@google.com>
Message-Id: <20220328232648.2127340-7-irogers@google.com>
Mime-Version: 1.0
References: <20220328232648.2127340-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 6/6] perf evlist: Respect all_cpus when setting user_requested_cpus
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

If all_cpus is calculated it represents the merge/union of all
evsel cpu maps. By default user_requested_cpus is computed to be
the online CPUs. For uncore events, it is often the case currently
that all_cpus is a subset of user_requested_cpus. Metrics printed
without aggregation and with metric-only, in print_no_aggr_metric,
iterate over user_requested_cpus assuming every CPU has a metric to
print. For each CPU the prefix is printed, but then if the
evsel's cpus doesn't contain anything you get an empty line like
the following on a 2 socket 36 core SkylakeX:

```
$ perf stat -A -M DRAM_BW_Use -a --metric-only -I 1000
     1.000453137 CPU0                       0.00
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137 CPU18                      0.00
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     1.000453137
     2.003717143 CPU0                       0.00
...
```

While it is possible to be lazier in printing the prefix and
trailing newline, having user_requested_cpus not be a subset of
all_cpus is preferential so that wasted work isn't done elsewhere
user_requested_cpus is used. The change modifies user_requested_cpus
to be the intersection of user specified CPUs, or default all online
CPUs, with the CPUs computed through the merge of all evsel cpu maps.

New behavior:
```
$ perf stat -A -M DRAM_BW_Use -a --metric-only -I 1000
     1.001086325 CPU0                       0.00
     1.001086325 CPU18                      0.00
     2.003671291 CPU0                       0.00
     2.003671291 CPU18                      0.00
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index cb2cf4463c08..1a3308ec35f1 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1036,6 +1036,8 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	if (!cpus)
 		goto out_delete_threads;
 
+	if (evlist->core.all_cpus)
+		cpus = perf_cpu_map__intersect(cpus, evlist->core.all_cpus);
 	evlist->core.has_user_cpus = !!target->cpu_list && !target->hybrid;
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
-- 
2.35.1.1021.g381101b075-goog

