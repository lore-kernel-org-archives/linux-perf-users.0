Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50AAC43219
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Mar 2022 23:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiC1X2y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Mar 2022 19:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiC1X2s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Mar 2022 19:28:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5785658831
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Mar 2022 16:27:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h8-20020a25e208000000b00628c0565607so11993764ybe.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Mar 2022 16:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HI7lVdFOSrlQd5wT9t/SBLu67RK0OyhqHS+mLTojDoE=;
        b=OOfLyxjdfGI/Zzi87JL87OQfMszCNTUskyTB3iTykwAXRjAEpDXIS+voGrvIAZfDpR
         Epwup6CsDlPPO2kU6QMzOn0Epm3iM+kImr6kf8OxgLNzzbnruKyXgm/LeewSSA3k0yqp
         favmnY4DSQkIBaEiZz6q5NwUzkwJ78hb2Y4huCXqqEqyWjpOuVAB67CcxkD9vdR/hOfJ
         1u2AhCfGi1Mi+uCrQi8MiQH9uaS7hzSH+fiRw0fJ6TwTPMsnj4O6XGGzZLMpkd9BNXO9
         fGG+9nyuNkcRx+Dxg1AF6oDiL2h9rmOclzepyuG1ulyjca+zHJxSTl+seEh1kjNQXI3I
         S4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HI7lVdFOSrlQd5wT9t/SBLu67RK0OyhqHS+mLTojDoE=;
        b=7HaptRsgqnaZocSI43HMucvLYhiR6N0A2O6XQ9B2y9RsUPUrHs6E4a9SIMKXj2OS1S
         WiiHzVH4dGFPKBw5Yy4YizeaqKkd0Xqmcf1Cv2pzTSg4HRLImtBn5Hvyz/gaZY9Fw1sv
         /4Zp7jS/h8m91EpJjiy9tgtyYY3ZklcCHbct59JQAOqI2n1qUYE19TjLJe4r0Srnrkvn
         r4cw6JcejsFhkY2OULZVu0pyYjgShTgvbY79P8jNG25QgVw9xk+XnoKjwNPVy5CWLCkq
         67e+YBRAGtH9H//B8fAazNjtj8IPMMobu3GBoHRw1ewP4d4BhwT+8E6MabUJ7ZqTKT52
         uztg==
X-Gm-Message-State: AOAM532Wv56fPvZa0Lu1BQ5zKUbpHjyp2idhRD2yDAiyBgrWCqG5jKMx
        xmLumCZL+U0qGakq6331+2IBlYwcZYAZ
X-Google-Smtp-Source: ABdhPJxq3SawZ28lJ97d+m1B27jGZL3+ADhO9V4EPLQfdWt+wZImHtVrn+mTGk9KAcNNkDb7tpvSE9m8TcX9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9d6a:527d:cf46:71e2])
 (user=irogers job=sendgmr) by 2002:a05:6902:241:b0:633:d3e1:ff5e with SMTP id
 k1-20020a056902024100b00633d3e1ff5emr25241467ybs.625.1648510024506; Mon, 28
 Mar 2022 16:27:04 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:26:47 -0700
In-Reply-To: <20220328232648.2127340-1-irogers@google.com>
Message-Id: <20220328232648.2127340-6-irogers@google.com>
Mime-Version: 1.0
References: <20220328232648.2127340-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 5/6] perf cpumap: Add intersect function.
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

The merge function gives the union of two cpu maps. Add an intersect
function which will be used in the next change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c              | 38 ++++++++++++++++++++++++++++
 tools/lib/perf/include/perf/cpumap.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 384d5e076ee4..60cccd05f243 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -390,3 +390,41 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 	perf_cpu_map__put(orig);
 	return merged;
 }
+
+struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
+					     struct perf_cpu_map *other)
+{
+	struct perf_cpu *tmp_cpus;
+	int tmp_len;
+	int i, j, k;
+	struct perf_cpu_map *merged = NULL;
+
+	if (perf_cpu_map__is_subset(other, orig))
+		return orig;
+	if (perf_cpu_map__is_subset(orig, other)) {
+		perf_cpu_map__put(orig);
+		return perf_cpu_map__get(other);
+	}
+
+	tmp_len = max(orig->nr, other->nr);
+	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
+	if (!tmp_cpus)
+		return NULL;
+
+	i = j = k = 0;
+	while (i < orig->nr && j < other->nr) {
+		if (orig->map[i].cpu < other->map[j].cpu)
+			i++;
+		else if (orig->map[i].cpu > other->map[j].cpu)
+			j++;
+		else {
+			j++;
+			tmp_cpus[k++] = orig->map[i++];
+		}
+	}
+	if (k)
+		merged = cpu_map__trim_new(k, tmp_cpus);
+	free(tmp_cpus);
+	perf_cpu_map__put(orig);
+	return merged;
+}
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 4a2edbdb5e2b..a2a7216c0b78 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -19,6 +19,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 						     struct perf_cpu_map *other);
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
+							 struct perf_cpu_map *other);
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
-- 
2.35.1.1021.g381101b075-goog

