Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770AEC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Mar 2022 06:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiC1G0p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Mar 2022 02:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238440AbiC1G0U (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Mar 2022 02:26:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A332C522C5
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Mar 2022 23:24:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e9ae7bd8deso60558167b3.9
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Mar 2022 23:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4TQ73I0e25XkGF6JYmSar5D4w+BV0D8V/TiHYSAl5KU=;
        b=rAbswlnujk8SJmxLde3al3arUpI/R7w91Rzm7Im3FFbuzIfrwxc+ukwRg2ubEFbel6
         u2xn9Xt+8UqLmVxVZDCy5Nby8rLxqJEd/CoGCk9U++oFpUs7RKCCFqA/YaPX4/GZKU5U
         w4zDDyta0qWgGM0toE5CfiZ51VV7n22L7WUbX6ZP1pmQMpV/LmnyXyL6MsHIdCuXlyuX
         z+SQAkei8tjNWFHynWVB1nY+gTAKs8lordMKynfqoAtLVgafdcegbc5TSy2occ4xSrIB
         kBaLqdF9P69Scb/0cyCCr6sUxseIuHLDaguZgdN1KxkbJ9A16IZ+UtqU0aR+e7aNrEl8
         vWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4TQ73I0e25XkGF6JYmSar5D4w+BV0D8V/TiHYSAl5KU=;
        b=gmLBVsJd9jLfpOYFKrmyFnrXpv+RNuD6PfnckR1o6whTRulK5xLaXdDasY0desD9Y2
         N1kgemj1hKLk6KJ+3N5VHAQ5jf7q4x5vJXTVo4gPrSkS92SCbwEaoNn4VS8vxvapQU9+
         LNeklIMkNa/gqZ0/XB8I/UJg+DnVpYAEbBcbsOlNUIpgmhxUUokE3Rd1zkodaf2FGabL
         qEmLY9pCDGkhlHEJPR18o+VG9e1v6x31Gf1Ujyp+GFtOD6KcLWXVfsNiDgo1Ui9V9DZI
         eJ1KevEkK5yfDZdkwQekdDmy+Htk9NPrdPPHnQg/48QomYrsbafT3k21Ma59lvxzBhtm
         iH0Q==
X-Gm-Message-State: AOAM5310RjBjOUECv+8oZpHC65o2COuvqUpCQQYnkD9pwAd7pr/QEecu
        QPOyMtsAuN0XbFL7bjK6VXU6wUeAQdge
X-Google-Smtp-Source: ABdhPJzzFACczXPpjcFkdPBG8L2RXqeBU42ZTsEkDl97YgxNOBZWCpXE1hi/ATJnf1wHmPGu6AqFFy8JjyPU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ef08:ed1b:261f:77fa])
 (user=irogers job=sendgmr) by 2002:a81:3a52:0:b0:2d7:549a:50fc with SMTP id
 h79-20020a813a52000000b002d7549a50fcmr24269495ywa.85.1648448669800; Sun, 27
 Mar 2022 23:24:29 -0700 (PDT)
Date:   Sun, 27 Mar 2022 23:24:13 -0700
In-Reply-To: <20220328062414.1893550-1-irogers@google.com>
Message-Id: <20220328062414.1893550-5-irogers@google.com>
Mime-Version: 1.0
References: <20220328062414.1893550-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH 4/5] perf stat: Avoid segv if core.user_cpus isn't set.
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

Passing null to perf_cpu_map__max doesn't make sense as there is no
valid max. Avoid this problem by null checking in
perf_stat_init_aggr_mode.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5bee529f7656..ecd5cf4fd872 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1472,7 +1472,10 @@ static int perf_stat_init_aggr_mode(void)
 	 * taking the highest cpu number to be the size of
 	 * the aggregation translate cpumap.
 	 */
-	nr = perf_cpu_map__max(evsel_list->core.user_cpus).cpu;
+	if (evsel_list->core.user_cpus)
+		nr = perf_cpu_map__max(evsel_list->core.user_cpus).cpu;
+	else
+		nr = 0;
 	stat_config.cpus_aggr_map = cpu_aggr_map__empty_new(nr + 1);
 	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
 }
-- 
2.35.1.1021.g381101b075-goog

