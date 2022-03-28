Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECCDC4321E
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Mar 2022 23:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiC1X2t (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Mar 2022 19:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiC1X2r (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Mar 2022 19:28:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D742DD7C
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Mar 2022 16:27:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so12017480ybg.8
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Mar 2022 16:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fd8zO3I7cR3jn/Jx1EW0YLNB0c8F/thF/fGaitvvb58=;
        b=jhWfrBgC3Vidx16ZXPyaLDraZh3tQuBYXM724VRgco4ncvfxUi7yyZL7BAMENECuRr
         c8ZOwIgO5+uZy4p89VQXhbbCrSL8Cd0fRgY7Qgttlf7fm0fUgJe7cfxJoGx0+cGnFh7N
         KEB+IRtL1LlXsuam7rw7lu71qt2dGcSOIUCAjAPnee7ZkCJxJfye0EhEXY60jtniThLR
         W/hBrZyqmOKkZUOvGE6itlT47MOqBU1C+DuAI8pS9d/x1QpFDWyaip6AFrUXzzx+rM4Q
         qHMX7xcid4VCbEkpxBxj7NPPx8jYtHKTG09Hyjy3FN0YubprJa9gxwYNJH5xntFBiNm3
         06uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fd8zO3I7cR3jn/Jx1EW0YLNB0c8F/thF/fGaitvvb58=;
        b=uf4uAzuL3VF7wdKja3WnfKcw66MdpYQol4fmu7edwMYh12q0KAK1QJhpB/aMrRAduk
         kSz+S7OMo2giTOQn37BbA+cJ8uC7XSzimcR/hpD24zLVJoChSi6qEDn1n/OJCFr0A1q4
         HN4lLHIdu/Qrr/UWd3QvkCN5qslczRdrGYgxx57jRPnJo8QiWM9ODacVTy1c9UTwqrtP
         CJ2Aw6/gK7qEGe/G3VI1+CxVP44tZ9dynbzIMOjj25d3j3uk9TDYahUvKTqyvmeja8B+
         AgDZN6QIDTES6Fp1LG7eXmgQ3NY5s6WUbuteUdNk+C3An5o2b0Ewu981nd6gUUTVC00l
         AYzQ==
X-Gm-Message-State: AOAM5332554q53Y184ew15dPNhY1kFXRwMcoQbaKHhmpLx6VA62isgI1
        lZzdUsIwQOcMonkoor+gY4y+EoO3Vuk4
X-Google-Smtp-Source: ABdhPJx9mX24vBUXKujfAxpZd4EOEF4CDe3zBNIYlkFzjKX9KG29aQUbCRbBy+3NfgADLi4J9ufU7jNV4G8B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9d6a:527d:cf46:71e2])
 (user=irogers job=sendgmr) by 2002:a0d:eb4c:0:b0:2e5:bd5c:12cf with SMTP id
 u73-20020a0deb4c000000b002e5bd5c12cfmr28160203ywe.116.1648510019835; Mon, 28
 Mar 2022 16:26:59 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:26:45 -0700
In-Reply-To: <20220328232648.2127340-1-irogers@google.com>
Message-Id: <20220328232648.2127340-4-irogers@google.com>
Mime-Version: 1.0
References: <20220328232648.2127340-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 3/6] perf cpumap: Add is_subset function
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

Returns true if the second argument is a subset of the first.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c                  | 20 ++++++++++++++++++++
 tools/lib/perf/include/internal/cpumap.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index ee66760f1e63..23701024e0c0 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -319,6 +319,26 @@ struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
 	return map->nr > 0 ? map->map[map->nr - 1] : result;
 }
 
+/** Is 'b' a subset of 'a'. */
+bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b)
+{
+	if (a == b || !b)
+		return true;
+	if (!a || b->nr > a->nr)
+		return false;
+
+	for (int i = 0, j = 0; i < a->nr; i++) {
+		if (a->map[i].cpu > b->map[j].cpu)
+			return false;
+		if (a->map[i].cpu == b->map[j].cpu) {
+			j++;
+			if (j == b->nr)
+				return true;
+		}
+	}
+	return false;
+}
+
 /*
  * Merge two cpumaps
  *
diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 1973a18c096b..35dd29642296 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -25,5 +25,6 @@ struct perf_cpu_map {
 #endif
 
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu);
+bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b);
 
 #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
-- 
2.35.1.1021.g381101b075-goog

