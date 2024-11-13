Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C60B481C4
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460816; cv=none; b=aeqlu367VEIJstm0zUFhqp2tl0C3I59m6Dl8eIdUNK+/E3eUiOfJPzMa4fDyszBV8qQEGNxVT67vnE8pR8baszlKVwmJW1cuA6q/4xHEpzyh/FBZ52p++RY7lktwgXOxcvVZk+wgqnVs7Ns+mi2nfcI5cre66GHLzK0LxXWjKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460816; c=relaxed/simple;
	bh=yBrrjk33hB9mv0HQWhIV3uiwMnwAIcTRHi/FGKwtzpE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=Q0ZpZohvhAxf4NbrjzfKUSjg77h5OPQ79tZa5p5HQd8Skn59KwGnhtgwGLU/pWMRMGMVyXpkOYDMxrSVHiQ3F1LyMzeLV8AguVbFznJHZNeSvDaGljnt7a0bBByxPCH+n5YGPMImRnW7jsEgLDb8llhX8zSuqKzU2MZoMkGEE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oQpkkbEF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQpkkbEF"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a5e83a3so126138697b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 17:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731460813; x=1732065613; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bftrBhNaPc7oeTC7/+do3eHkq6mgh+Qn+l/FW9m2q5c=;
        b=oQpkkbEFaHXtnrJdrLAPsmY3zh/fOu7he+/bFxkfMBRigJEYmOMjKkqepdKSQ1Wiit
         mcae4cOFlpcnnLFED2MXnwBsZoGlePVrHh6JM/zA4E2TcCwQxouZPYZ9h3Ec9zmGFCkC
         aAL2L0Ejui/oOiewlHEzgr7ZJWHZX9qC+gWWyE2zs3EukA062CLGS+CHO6SO529rFV5x
         Er4ki+eAlk0GG2ox6Cr2t4Ib7edIhYBdSChFKCdcIIh0S+6NLs9APDk65NgSyS6oQ/Pp
         hcJ4sVCARCPhe3QqmyrnHYjhskhrhHnJuodrJh9ipkF3nZ4QOYpytUXXyeGN+7+TNXYT
         Atxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731460813; x=1732065613;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bftrBhNaPc7oeTC7/+do3eHkq6mgh+Qn+l/FW9m2q5c=;
        b=omOHarT9AiKsuW3D4Fg3A+bK2JzEKsJSz7nqaMq4GESSHamFDaCYyk8ZqGePZL+k7s
         oacpbmT/4qe8Ph4/qUHJZS9CmgnxJMGtFqjsEbAMrqUxmxmt2EsU8iolmAqxrs926beF
         A1rAetVq7pf0dbiham1BP8ReXX33fj2gBdIj1bckPjJyS2ftG8KqCRenB4xn+X9P7ipD
         UuVNg8OXN3HjDM11/DwRVUP4R7CaD8f9MyORXKFu675k3WaQ+Orgzyed7+RZPakhMGb5
         voGMHd96q4odOSjUiCzxetcEokwxoM+X64pfXU0qbr9RxkEA6OB8Qzb5ucziKRfEYAA+
         R7tQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7awItjwOmqjqI3+XhSf7bwbdGk99WZuAbEIfN5m8TbFguFUzknyezzQRNHx6IiLkwWqGZu2Xytvsy5hyStGGx@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQDpkQ+ZIHPiHgM3IQyDxZvFBDeSGjWJmMgQpTlTaFBdsoqpZ
	55E1yxovLfhWJky/hC/fdaajg3ZDfw2apij9J1r2B+On7VlNzjYxBRUVGOypkU71JxPiNgWARrO
	qgpsL3A==
X-Google-Smtp-Source: AGHT+IH2gh4uwLxmzu9ZWUORhDP3WW5r82WHCOHoNi+rnFccs+oEG+FT/lT50rt3Vi6W7fgphWstpsrxvymh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ba3:1d9a:12e0:c4af])
 (user=irogers job=sendgmr) by 2002:a81:d442:0:b0:6e7:e3e4:9d83 with SMTP id
 00721157ae682-6eca4c04b2emr225617b3.8.1731460813222; Tue, 12 Nov 2024
 17:20:13 -0800 (PST)
Date: Tue, 12 Nov 2024 17:19:54 -0800
In-Reply-To: <20241113011956.402096-1-irogers@google.com>
Message-Id: <20241113011956.402096-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241113011956.402096-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v2 2/4] perf stat: Fix find_stat for mixed legacy/non-legacy events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Legacy events typically don't have a PMU when added leading to
mismatched legacy/non-legacy cases in find_stat. Use evsel__find_pmu
to make sure the evsel PMU is looked up. Update the evsel__find_pmu
code to look for the PMU using the extended config type or, for legacy
hardware/hw_cache events on non-hybrid systems, just use the core PMU.

Before:
```
$ perf stat -e cycles,cpu/instructions/ -a sleep 1
 Performance counter stats for 'system wide':

       215,309,764      cycles
        44,326,491      cpu/instructions/

       1.002555314 seconds time elapsed
```
After:
```
$ perf stat -e cycles,cpu/instructions/ -a sleep 1

 Performance counter stats for 'system wide':

       990,676,332      cycles
     1,235,762,487      cpu/instructions/                #    1.25  insn per cycle

       1.002667198 seconds time elapsed
```

Fixes: 3612ca8e2935 ("perf stat: Fix the hard-coded metrics
calculation on the hybrid")
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
---
 tools/perf/util/pmus.c        | 20 +++++++++++++++++---
 tools/perf/util/stat-shadow.c |  3 ++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 451c6e00ad70..7e5f428a1fd2 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -710,11 +710,25 @@ char *perf_pmus__default_pmu_name(void)
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel->pmu;
+	bool legacy_core_type;
 
-	if (!pmu) {
-		pmu = perf_pmus__find_by_type(evsel->core.attr.type);
-		((struct evsel *)evsel)->pmu = pmu;
+	if (pmu)
+		return pmu;
+
+	pmu = perf_pmus__find_by_type(evsel->core.attr.type);
+	legacy_core_type =
+		evsel->core.attr.type == PERF_TYPE_HARDWARE ||
+		evsel->core.attr.type == PERF_TYPE_HW_CACHE;
+	if (!pmu && legacy_core_type) {
+		if (perf_pmus__supports_extended_type()) {
+			u32 type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+
+			pmu = perf_pmus__find_by_type(type);
+		} else {
+			pmu = perf_pmus__find_core_pmu();
+		}
 	}
+	((struct evsel *)evsel)->pmu = pmu;
 	return pmu;
 }
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 47718610d5d8..109c4a012ce8 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -151,6 +151,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 {
 	struct evsel *cur;
 	int evsel_ctx = evsel_context(evsel);
+	struct perf_pmu *evsel_pmu = evsel__find_pmu(evsel);
 
 	evlist__for_each_entry(evsel->evlist, cur) {
 		struct perf_stat_aggr *aggr;
@@ -177,7 +178,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 		 * Except the SW CLOCK events,
 		 * ignore if not the PMU we're looking for.
 		 */
-		if ((type != STAT_NSECS) && (evsel->pmu != cur->pmu))
+		if ((type != STAT_NSECS) && (evsel_pmu != evsel__find_pmu(cur)))
 			continue;
 
 		aggr = &cur->stats->aggr[aggr_idx];
-- 
2.47.0.277.g8800431eea-goog

