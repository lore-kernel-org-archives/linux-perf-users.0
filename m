Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CF6C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 May 2022 04:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiECEVp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 May 2022 00:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiECEVl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 May 2022 00:21:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A49438D89
        for <linux-perf-users@vger.kernel.org>; Mon,  2 May 2022 21:18:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f8be9326fcso89743847b3.18
        for <linux-perf-users@vger.kernel.org>; Mon, 02 May 2022 21:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qM0CcLJJrKpW2Wkspbw9oc4+0PMtIaoOGCh2yb1+c8Y=;
        b=iT5xdA/rg8+MNsb785W3GH63t4eHf4o2ufE9t16Fodq6V8dmlCaFTXp1amgu76yDEd
         hdCCSc0RvrUoAMypdlByXDbeqohAw1BOVSCMyhQiHLq91rulRu5aw/8bkvnic86sCoru
         i5j6EZzVYStAni8Geao/E6QSYanLC7VaQwNXNwatg0idyTvuXkKNP6vbPHjghWo2iu4A
         lqhgzQQcqlP7yadi40ymLoJ4Lj9uIOynVAwTNYZda9t0LCRTWDtruwtfzL0ekTcrHJ5X
         fZhqw04Nf/CKLEkFaoF+ExsdgV2pd36WDimqIsL8lyepqPuLBqnFjdfhQqECSZQxjyFV
         THTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qM0CcLJJrKpW2Wkspbw9oc4+0PMtIaoOGCh2yb1+c8Y=;
        b=H5AK0651zJ2iH+GQcDlNuOBfOjGULrnKQo5j78kx+OA8bcGAuOSCu1tZFBZwBCas+n
         j1BZl10mEWcmrmrqOPPBHMwGZ+k76pqw4+fAbLAvonEoTyOF/Hrl9xat13M9D7yjk0gD
         QFmSmZwke/8wdnSwonD3TuuM9NxfU3k6m7WIHmeEaX2FptJAnYErQ9Eo2qQsbd0cig8V
         XvTrpfDTEw3JNulfUREBnAAmHaZ/WLvJGQW2TimKC4BByadL1Ap7cTRiyptbRsYXzX+J
         KTIHNMu70lim4IDC0bl+8AoPX7NH4gzefXyyCxWxDXZL4q+rqgT+OHyt26jcJN9+YQ5e
         pMTg==
X-Gm-Message-State: AOAM533Nro7z4+UtbtzbDpC95htbw+M9pmSWJrxOB9XTFp2rgmUa0+eF
        EYtOxeJuw2n5CGBg4rcG6qoMg6e0w/r8
X-Google-Smtp-Source: ABdhPJxiPnCbA7/Eppx8fhZ4RJy6qiG1Go1/53a0D2Iw71MIcgee3dcMxSVJ2GFtTvoQRpF4s/3zJG32pHul
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dd4b:52bb:771d:7bb4])
 (user=irogers job=sendgmr) by 2002:a81:6cc1:0:b0:2f8:bb31:143b with SMTP id
 h184-20020a816cc1000000b002f8bb31143bmr13489355ywc.64.1651551487238; Mon, 02
 May 2022 21:18:07 -0700 (PDT)
Date:   Mon,  2 May 2022 21:17:53 -0700
In-Reply-To: <20220503041757.2365696-1-irogers@google.com>
Message-Id: <20220503041757.2365696-3-irogers@google.com>
Mime-Version: 1.0
References: <20220503041757.2365696-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v5 2/6] perf evlist: Clear all_cpus before propagating
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

all_cpus is merged into during propagation. Initially all_cpus is set
from PMU sysfs. perf_evlist__set_maps will recompute it and change
evsel->cpus to user_requested_cpus if they are given. If all_cpus isn't
cleared then the union of the user_requested_cpus and PMU sysfs values
is set to all_cpus, whereas just user_requested_cpus is necessary. To
avoid this make all_cpus empty prior to propagation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index a09315538a30..974b4585f93e 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -59,6 +59,10 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
+	/* Recomputing all_cpus, so start with a blank slate. */
+	perf_cpu_map__put(evlist->all_cpus);
+	evlist->all_cpus = NULL;
+
 	perf_evlist__for_each_evsel(evlist, evsel)
 		__perf_evlist__propagate_maps(evlist, evsel);
 }
-- 
2.36.0.464.gb9c8b46e94-goog

