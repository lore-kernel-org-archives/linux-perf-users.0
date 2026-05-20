Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B83FC5CF
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303987; cv=none; b=EpczcH4d2HyHn1PtA35qXqLvXuLGzChcm944GAVHQyj6rcreXvTYwTXjjdHi78TBpYcDAGwUeynuAsHJYrCY1g1tM2pPgpTs+lPK4BHpP2Bjh6tTpAzCf8hqryWmfpJm6H8Y244R6W4iKVPDs55mzYRle4ET+7OJwjz9nIfooy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303987; c=relaxed/simple;
	bh=axjBlqsLnQJgPofCOYpERZZsQKwNiC91FlHgqidnc0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JwZTQqRnF+LXi9/jtjD3gFUqYvd/a6PNWu2EDsOgKaB3y5JSWM2sVbYUHK1nMB4db/z0ONYNbW1oS65x+BYuli0LLtecUIQ6qMVUz5IHxur8NK+HQNrkfjxKXqG5oUPS5n9G7jwPBaq8LqIgdHjbJ4yz/THxu1LV/F0dgO+hYKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udALZCwU; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udALZCwU"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2eebb099efbso21417878eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303985; x=1779908785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7/1EoKTIaBaGZGvD3bTdI20mnHfTvwemKpb5Vj+d8s=;
        b=udALZCwU2Td07bVp9titNjxD3/NYnLmAhMRtPJVzLDVAMB0WZSJvATadaCNjLa5Fm8
         kz8ABnRTnANhWzR+160C7PWczXlMos3jZ7QwcXp3v8qMF+Fit4rFSZvFmllWCjRb+0+8
         k59O2I0W9BzpysouwYWlcq6yuW8/r7bPGYtxReFfEzzSjEGGMLPeXVB9YywLDk8rEOAT
         BAWIL+ml55+Z5G1sVUgDHzXLYebjH5XKrrwoLs5K+lDm9lsPftktz5RjchuN3PBLHxvr
         qtMZe+iZFJ1FjGd3wuly6i6xy8yarDcjyJNww/ICBYYk7jSq/TFHHpMCp4g+UMTuwW0w
         kUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303985; x=1779908785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7/1EoKTIaBaGZGvD3bTdI20mnHfTvwemKpb5Vj+d8s=;
        b=OdI5AhrbXJga2luljkLmY2EB3t0mfMV8WHa2xYqA0ghDy0iRP0DOccW5ow9W4FVdq+
         mslFGV/03PYUGDgvglncGL7r0GpMCnhnNmf/S9uk7CX6Apc7Wk9lgr+yr7wSzMic0KZR
         kM8DoCwQFneDVWS0lhNp5qAa1o9awS1hkCP4kD8y2uYs6p/jm8ocTu2vUXykJ/D3XYWN
         bR5O5ePQ5vaE2/5ucqW0wKifrUXnwNtll+QsHhjVfmGox9HQFdUNNhV/RoIOypO3RY4K
         v/7TDp3X15JHotLLSFUHJVMDQcWXNEdSTni1d1ELqS26MYwcIiwPMgn7XCkIv0Sgh3R9
         IdcA==
X-Forwarded-Encrypted: i=1; AFNElJ+7vZPgWUlX4f+F3MX9BbFloAS2ynbevp5jJ9SFv7WzXJDrzLPbpCsLwwzHbIrX2KdQnyybwaSbjyYhKcxgeiks@vger.kernel.org
X-Gm-Message-State: AOJu0YywgQSbHY4brwlCM7cvL4Moz4duEEo+lKISjyakdyUIDgKYOFJV
	NXHn74I3wafh1ftjOWS+sM+r21TV8cqtxMVQ+3bz4L6acwq0X4DUKvYFu0d2bREV5ksDTuLCSwu
	DU5yQK46UmQ==
X-Received: from dycqv12.prod.google.com ([2002:a05:7300:df4c:b0:2f9:af7:503f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:22a8:b0:2dd:6937:79c8
 with SMTP id 5a478bee46e88-3039818a6bcmr12875822eec.5.1779303984485; Wed, 20
 May 2026 12:06:24 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:26 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-21-irogers@google.com>
Subject: [PATCH v14 20/32] perf s390-sample-raw: Don't pass evsel or its PMU
 with sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

As struct perf_sample now directly contains its own resolved evsel pointer,
passing the evsel separately is redundant and clutters the interface.

Remove the redundant evsel parameter from s390-sample-raw-specific handlers and
structures, ensuring the tool always directly accesses the evsel bound to the
sample. This simplifies the API signatures and eliminates the risk of passing
an inconsistent evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.54.0.746.g67dd491aae-goog

