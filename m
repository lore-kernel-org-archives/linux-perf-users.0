Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9723C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbhL3HXP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbhL3HW3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CBCC061A72
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:22:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s84-20020a254557000000b0060ac37f4bb1so29562955yba.5
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EYvYMoHkX/cH/EEuV/LiHLhSTbFzgAzJd57ZEVR8Iu4=;
        b=NVVuPj96aldimSuJGWBAOg3INqZBKkVX1HMo9hlPXfRClq62GtJDqNPNzcIapVWz2B
         WAKxhM6ngSqrwev6kOnNIkzF9I3knUMFdzGJIvAdo+7YPkvx2KSBf5CWVcFS3aNPcSav
         /nwpL6te2utE0H5Wqs62uXgDrsQogRUnZgMy6TT7XQn2Iu1I9WA0NeEDiCWmvi+vSQy/
         nS2dkuvpfCfAyzxmFe470/Xf6GzoIjV2FbjvlZfsu8JtMPu12OqeDdbrvejPjqSXeL9g
         Pdqx3KpcQ/rtg8ZfkrqeTrsDfzaVzZJTiZSy6bXkni7sPP7PotJcAC0NhsnzMDkFWDtf
         3kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EYvYMoHkX/cH/EEuV/LiHLhSTbFzgAzJd57ZEVR8Iu4=;
        b=IIIARzu+DX+6t9kvdePUOO+IFWQY4Tgo0ILmlQ8MDqLXat/dGY1HdmEIWKb/Nnp0vT
         E+uxL7W3U4acbehEe8g6Z0QYEIR+IymKRw48ee2ZZGMwkH1NvJCGeSVqBZ33fzbnT854
         b6/8W76qXil42WzpR2nh0y3vAZKE7S3vz9lIdXRWwM22TexFCYC5PRsc63L7O8HLk5mA
         2jTYF9Mzx/A0YExVGROnyg3bcrEWmtX3W7JFzLysooNcZs0n8MJVg7kajfTzLQSH1Cme
         cLMOijMPGZ4APn1Qm0i7/mOSyuk5O6Eqt4UwTqEPikIyzNmNNP9X/rExCH5sQwcS9Tta
         fxJg==
X-Gm-Message-State: AOAM533Abq0WXIq6DKK9Q5xtaSGlI4Tr3aJ0kz7y3qN+ZlgTOywP3I+0
        wfcmxHypsFPc2GzYPGVd0OfwuTQoF+PR
X-Google-Smtp-Source: ABdhPJzprlVuniOvf96Uc4KFiSV+VfOhO1ZJPQT5NEAUi/ZPilJtwj9Sjp7ZAfOpIK+J19M3Y07RDFxxjwJD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:ab94:: with SMTP id
 v20mr28886251ybi.338.1640848946562; Wed, 29 Dec 2021 23:22:26 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:25 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-45-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 43/48] libperf: Sync evsel documentation
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

cpu was renamed cpu_map_idx, for clarity.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/Documentation/libperf.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index faef9ba3a540..32c5051c24eb 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -136,16 +136,16 @@ SYNOPSIS
   int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
                        struct perf_thread_map *threads);
   void perf_evsel__close(struct perf_evsel *evsel);
-  void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
+  void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   int perf_evsel__mmap(struct perf_evsel *evsel, int pages);
   void perf_evsel__munmap(struct perf_evsel *evsel);
-  void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread);
-  int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
+  void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu_map_idx, int thread);
+  int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
                        struct perf_counts_values *count);
   int perf_evsel__enable(struct perf_evsel *evsel);
-  int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu);
+  int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   int perf_evsel__disable(struct perf_evsel *evsel);
-  int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu);
+  int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
-- 
2.34.1.448.ga2b2bfdf31-goog

