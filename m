Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866849652
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273361; cv=none; b=W1ByrvgvQHc1sqOCj9oSVVnHXacB99XqMFD3RNF0NwBRwNqIMVqEKLXUohnitz3/5cqmYameEV7PeG4HvvLUATHbMwUQ3Vft5KZ8GiuFs8GyzLkVme+jsm3KxzVJAuldwN0+g43a7/6v+7uYywzgFiYhaAUc3VW++FKrw9M+PzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273361; c=relaxed/simple;
	bh=6NiM1Nv7imSN6NGO0Qbw1eHxJQIVxr9LL1Tkk8/m+6M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=k3wJPwhbUAh5WiB+m0nB4ybn7Hg8sFrciHT+5/sHxlcYdkhyBDSq956/luA3lLC7QwOZ2z2DkU5FCS7sW0SRSyu4MuL6gTMnbebWwwZNIFve9LIcYZ2ehmSwDPLPXjQ3hshMecJ0hiIM2nOK8LH+ywL8+pk3mWhEjAKAGtx6NbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GavsVu4j; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GavsVu4j"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e54cb50c3baso182489276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 10:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736273357; x=1736878157; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Rj5RspISvp82xBYwd7/3r2uv97UQb04V4mK5h3NrO0=;
        b=GavsVu4jMMFBCHUdPByfPS2S446LUqKmfNuKDRxC21L1C++wQpqbv55tuDTqPdPn5D
         2oO8xEd3ilSHNS8x5DJll6Awm1USFsB6l3QDAvsmCaZBH2+qZl9ntfUXA8962GnO118P
         cAISRxy9Z+L050lV4iidopJJblzqf7WJUtuQwEQRucl0qbSNsj4yybX0SGp7sLHvFCQy
         z2n3Urzi7R7m2jeZN8NB6WLi7zQ+4wfRFhUbPfMaKDqgqSRttor7tBJ8FPsM3DeePEFm
         2brOh/dBy3zTbhsLvdGFR2zgESCaYFx0N6eSBNsP+tgyFDl1gvB0I/lnue+2Ob6i7b7B
         GNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736273357; x=1736878157;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Rj5RspISvp82xBYwd7/3r2uv97UQb04V4mK5h3NrO0=;
        b=BU1qUpc6T3bCtVPDetpdorxZZEwpKdQBm5F2m17XuOMlBMsO8YfHcnSC+L6NMWGWkb
         HkGEhInWckTchTd5n+m8NxlNDksv+buYUHcxK3RJ0mBNUJJncizf4JGzpzO1mr9BM0yM
         Nim8Gu4cl4qmus2/yn70V00KpQ7xJrFmzFdXyEuyiz5ozBkHUHSnjo1F3wtZMxYxXNla
         eyQHsGlaRf0SAtuWUF3Vce3FZ8Lwo3Vq3LOyNVZC6YpunWGw4Z8a4rA/sdLGS+7Q4WH6
         FL0IP/OdPQ8H2bvJCfUOGsct5ix6x1MAm3+X4OzjHk+nieJdZPo/Uk3arGxpi6edBtUA
         +THQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrzlC93CEzdH/4hUe+WWI0BEYipX50jdCtU/6JSKp5Xy8TWnqe3Bqmet30ErLXS/VmMnA9mtMp/Jynj/WU7QQA@vger.kernel.org
X-Gm-Message-State: AOJu0YxHuC2jXlI8gkzlV5ohWyvYOOzHATVPtEhHQmexMkukjYBHAqs2
	y/yx7w/TG0l1mNwk3FLMljd9bKzpkTGQ3Bu7VeWnz15Be//6bS44dyM1dhmYak4zM7tjCp1lM3k
	bULNcjg==
X-Google-Smtp-Source: AGHT+IEUTlQHgQ22Xtq7YLQQdmJRZ10UdmCV7tQ4aZj56dVKX0kWKQfKm7P9GtfRzBx/qViI3tPz15I9WnuN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ede7:40c7:c970:8d77])
 (user=irogers job=sendgmr) by 2002:a25:2943:0:b0:e38:8e02:1f01 with SMTP id
 3f1490d57ef6-e54ed8d5fddmr166276.1.1736273357373; Tue, 07 Jan 2025 10:09:17
 -0800 (PST)
Date: Tue,  7 Jan 2025 10:08:51 -0800
In-Reply-To: <20250107180854.770470-1-irogers@google.com>
Message-Id: <20250107180854.770470-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250107180854.770470-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 1/4] perf evsel: Add pmu_name helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Cc: Leo Yan <leo.yan@arm.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Add helper to get the name of the evsel's PMU. This handles the case
where there's no sysfs PMU via parse_events event_type helper.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
---
 tools/perf/util/evsel.c | 10 ++++++++++
 tools/perf/util/evsel.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 697428efa644..da1308462c4e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -237,6 +237,16 @@ int evsel__object_config(size_t object_size, int (*init)(struct evsel *evsel),
 	return 0;
 }
 
+const char *evsel__pmu_name(const struct evsel *evsel)
+{
+	struct perf_pmu *pmu = evsel__find_pmu(evsel);
+
+	if (pmu)
+		return pmu->name;
+
+	return event_type(evsel->core.attr.type);
+}
+
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
 
 int __evsel__sample_size(u64 sample_type)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 5e789fa80590..2dd108a14b89 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -236,6 +236,7 @@ int evsel__object_config(size_t object_size,
 			 void (*fini)(struct evsel *evsel));
 
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel);
+const char *evsel__pmu_name(const struct evsel *evsel);
 bool evsel__is_aux_event(const struct evsel *evsel);
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx);
-- 
2.47.1.613.gc27f4b7a9f-goog

