Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD8F3446A3
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959782; cv=none; b=SLmdmyG8U9+yhgg2+c74CCym52DrKydxS39J438rFEdtcJYyUgokg/4BJ/76YXYj+IK1gYIf3ofgtC//OgOo0DeBB/ml+nasn0kU54VByPeCXoNekxo9h5zylutmSZumjWFOy4ni158yAmpLYTXtEm3hNYcVQKUhnRj6Y23aybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959782; c=relaxed/simple;
	bh=p3zEoq/bmQlpgAQt3/UAgTTaA4JyI4UO/QfGKpe/qI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MAfT5w/PJUpIcV1oG52OUVdKw3OEh1shBHzgpj01/K7R1PfjqbaqjWlyMhp2d+/dffj5OAe37ZHX7lxXUBOMixVGRucVxkVSyWV3cjHJHmIea8uUqM+ZOa968TLxKy/PfbVcxYCO/UIVp52Pipf7yM7as8f/PXbUS/qDaSHrvLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBBleRPz; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBBleRPz"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12bf9974587so3350961c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959780; x=1776564580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=QBBleRPzQWLE9zbC4dPN1uf5D0BxSRpQNgsNDkWrDF4wigWVbVtislr6hBr3W0Ck/2
         yZuZk/mXwOR3xgFdtmT5fflTrV0qE0/TB1NR8dDJY5RstdZaJTgTcPvMapXyvR9cCH1U
         9S2milffoUqS1C0fKHLnZLkDhdb71kyEvTAZPqPuN7snEKkYIneL1IU6GGIrSluMO5fI
         5ic+N0+Oa0jwK09HtUNxFXLZGWGtQ7058i0SYIAYzaVKZ0/5ZKVtCMa1EUB7DofWljoL
         DCKh2m/rzrh1qBSB9ZhFzOHpwYW6nRCw+U7fHUxpbf5VL5ds4a0W6jeBsz+ARC5bA/mA
         gCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959780; x=1776564580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=jL4haIJyw6SUB/rb31d/+RlvIonsQc/3F/8Pt5kyByassMdd9ZcL6PB3ZMkMKoiY3Y
         eyLsYyjPHxM6yQq6iVhRX+nuiqr7JRPxHuiPFrBAMZxAU/Ko9S59+8g7jRqrviqj33rK
         n0ygDHNniv8OnGlpzploR3uuhu6ifAA+86J5xCHvJ0dhRahif1SmNpYS++uAV3fgSEXM
         07cwP7jr5UO5t/hFmHHrmNzY0e9LkYtduwiGE+Wp2ubgzCkdnqNfJjY9oZ+sszk0E+XQ
         Z98azDmz44IGe/gQvG9q/PB8ldbv8OAjsMl2HpeG81+yntQmuDoTFx4efS9/G/4y3wAH
         T67w==
X-Forwarded-Encrypted: i=1; AJvYcCWmkfrJaPt5O65iwSkWKrZjHRI8YdXagOSsCN/v+2823dl9X/EpPz48MZFfwNgvZUZFJQ4YvJxQdKYoOVVm8vKU@vger.kernel.org
X-Gm-Message-State: AOJu0YwWwrhlURMCv1eUBNk98IIM3ji2nPNaPnVH9SITsp8LcaOE2Fyt
	ltZKLIsMcdRcJkdArY5KXlKDOnprFr243IW6OLMXuhgxmZCRGvxVliTVUqK8js+Mh/4+BiQaNdg
	JZlZulIKHvg==
X-Received: from dlaf12.prod.google.com ([2002:a05:701b:240c:b0:128:d7bc:9755])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2042:10b0:119:e56b:958a
 with SMTP id a92af1059eb24-12c34ea93ffmr3639034c88.15.1775959774492; Sat, 11
 Apr 2026 19:09:34 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:25 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-23-irogers@google.com>
Subject: [PATCH v10 22/29] perf s390-sample-raw: Don't pass evsel or its PMU
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

