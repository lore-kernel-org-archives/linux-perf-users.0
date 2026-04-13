Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CF3845CF
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053572; cv=none; b=TbimeUCxaJxyJrS8pKYXNWkVcd1j07KveRG5tA82IE2ct9y5sYcQsRhnLYIjYLEVvfuMAtek26eeive8z8WgigbwAZLbn/CMg7GCpsHTY3DjekNRd1Ty+PXBsnPJqMbjV2sMpWKkJIQvUhWYmJEwXenFPDJXcsRKhp8iYSedF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053572; c=relaxed/simple;
	bh=p3zEoq/bmQlpgAQt3/UAgTTaA4JyI4UO/QfGKpe/qI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kDDot9Ynn8WO/KK8q9cZ3mk8Bvwh0DPq9DdRB23tUI4t15q0V+RuMcjh7TVL0PRGnuSUyl90kbPHaQIYih0wqcBvloM81Vy7EhMo0omaGDXI3MseKgNF/6sUVxkda7K3qZqLRwIh36lT6Eu5vzZ2tvnTeLyT0ZOx7RoohuG27yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f8HZCABS; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8HZCABS"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12711ec96fbso12929227c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053565; x=1776658365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=f8HZCABSs21MtK2xErqxmFrCAI+ibOKwuAdVTrwRPGvozX32oVq/0uiv60bIeQVrHL
         0uiecEklIDb9hRRVXhM5DfrOTc+Ck6rY4G8/zEetaE78zVcql0xRyjoRlsa4VVBzoC1y
         1an7I+mBVUgbA/B540Pz0UcvZp8Hz14LSEWDr4OileIodhW/2I4Wn0dLpYeo18k6BbTe
         UZHA8K6iCmdKucnOcgPv/JKY6jwGYwJLLKrrOnU1Fhr46ZkosLDV+uvpKl672ZKi4gli
         nmjllAyXWqUMMd9OH4uismEHTb9fZJZRFywsXkUaU4noSmmP93qIhV8eR+ZkxGBuwq8L
         T1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053565; x=1776658365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=nQsUzEOJjOs6NHbZZZ5PO9YOFeJnz6utSSPI1TrUvppePOzvGlaNY4U/zZ12WE9lO+
         n6pAMM8uEMGSiM6QFxkbIEQwEpl50URoYpbM08ohBKwaECOZ/FBMXUTz7dBSSE2KJq+z
         jVafM5lc3w6wIz8DNkt5zOWnzBy3eNmjSi7ElFUK4GLMDP9oOuIqFjTry4EGOrmcecYX
         nntnk/BCa77d/WZrP9m/FDAi4QCE9brCg1ukxwiY3mZrGAU9SwkSgwzM2MRgG0KF7CpQ
         JNXFsTJowZHZeYLMvJGPc7R8IvA1nV3W7F1LaFAefMukvpYr0ch3pKj8+By2wq3B+sWr
         l3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWR6nU643mdlvYpIhdP1xR4Of5RxOzHwH1h8ZSJp442UJjNYLYfgCIuAePd6FKbI57oADNvjtwXZ6EaCo6fcO/h@vger.kernel.org
X-Gm-Message-State: AOJu0YwnuQ99WtuYEM7Le6vkEVUoS2WIqqZphcI1Dz5xB4Gbe8wLuCEV
	kPx/vdf4d3Ni/EMhP4z1AQYPVNs0vDAeUpnEBlTpeUr8kA08EXPkGae7X4TwHkw/Nsn2VKdWwYn
	n/IkTpyCv8Q==
X-Received: from dlag15.prod.google.com ([2002:a05:701b:250f:b0:12a:c3c1:4ace])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ba3:b0:128:cbc7:4c28
 with SMTP id a92af1059eb24-12c34f1c63dmr6746512c88.35.1776053565110; Sun, 12
 Apr 2026 21:12:45 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:31 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-22-irogers@google.com>
Subject: [PATCH v12 21/33] perf s390-sample-raw: Don't pass evsel or its PMU
 with sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and its PMU so it is unnecessary to pass
the evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/s390-sample-raw.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index c6ae0ae8d86a..52bbca5c56c8 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -222,8 +222,9 @@ static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 	return result;
 }
 
-static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
+static void s390_cpumcfdg_dump(struct perf_sample *sample)
 {
+	struct perf_pmu *pmu = sample->evsel->pmu;
 	size_t i, len = sample->raw_size, offset = 0;
 	unsigned char *buf = sample->raw_data;
 	const char *color = PERF_COLOR_BLUE;
@@ -284,8 +285,9 @@ static bool s390_pai_all_test(struct perf_sample *sample)
 	return true;
 }
 
-static void s390_pai_all_dump(struct evsel *evsel, struct perf_sample *sample)
+static void s390_pai_all_dump(struct perf_sample *sample)
 {
+	struct evsel *evsel = sample->evsel;
 	size_t len = sample->raw_size, offset = 0;
 	unsigned char *p = sample->raw_data;
 	const char *color = PERF_COLOR_BLUE;
@@ -332,31 +334,32 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
 			     struct perf_sample *sample)
 {
 	const char *pai_name;
-	struct evsel *evsel;
 
 	if (event->header.type != PERF_RECORD_SAMPLE)
 		return;
 
-	evsel = evlist__event2evsel(evlist, event);
-	if (!evsel)
-		return;
+	if (!sample->evsel) {
+		sample->evsel = evlist__event2evsel(evlist, event);
+		if (!sample->evsel)
+			return;
+	}
 
 	/* Check for raw data in sample */
 	if (!sample->raw_size || !sample->raw_data)
 		return;
 
 	/* Display raw data on screen */
-	if (evsel->core.attr.config == PERF_EVENT_CPUM_CF_DIAG) {
-		if (!evsel->pmu)
-			evsel->pmu = perf_pmus__find("cpum_cf");
+	if (sample->evsel->core.attr.config == PERF_EVENT_CPUM_CF_DIAG) {
+		if (!sample->evsel->pmu)
+			sample->evsel->pmu = perf_pmus__find("cpum_cf");
 		if (!s390_cpumcfdg_testctr(sample))
 			pr_err("Invalid counter set data encountered\n");
 		else
-			s390_cpumcfdg_dump(evsel->pmu, sample);
+			s390_cpumcfdg_dump(sample);
 		return;
 	}
 
-	switch (evsel->core.attr.config) {
+	switch (sample->evsel->core.attr.config) {
 	case PERF_EVENT_PAI_NNPA_ALL:
 		pai_name = "NNPA_ALL";
 		break;
@@ -370,8 +373,8 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
 	if (!s390_pai_all_test(sample)) {
 		pr_err("Invalid %s raw data encountered\n", pai_name);
 	} else {
-		if (!evsel->pmu)
-			evsel->pmu = perf_pmus__find_by_type(evsel->core.attr.type);
-		s390_pai_all_dump(evsel, sample);
+		if (!sample->evsel->pmu)
+			sample->evsel->pmu = perf_pmus__find_by_type(sample->evsel->core.attr.type);
+		s390_pai_all_dump(sample);
 	}
 }
-- 
2.53.0.1213.gd9a14994de-goog

