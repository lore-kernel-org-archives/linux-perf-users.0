Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0523CA4A8
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935089; cv=none; b=ejWD5A09gwBP92+kQLWWdHeMB2+Fjqq2DGR/J0DpsEW+whacVcXd/lm4IXQaXGweAffaCB4MB5gugfenRlpJ5vWnp2PdV5XYTsR6nmIWpkUuw0oYyKG48RUeqXGd/JVFPPipkppLLmpy3EuSHrFckDPVq6IyudM0TAgJiZjfFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935089; c=relaxed/simple;
	bh=p3zEoq/bmQlpgAQt3/UAgTTaA4JyI4UO/QfGKpe/qI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m+Wbv6+qXzzf4XruXlZ+6u+ixxJAEi+aT2GvY+amd2HWWUIrVAxAt1fa/oK2rUDmm9IrD1hNSsC7FyL/06gv9v3dmFgRe++mtvE6tgL69XeCXhRhvgwV35Cfn01a3c5SmrYj+zkujqDa/7uoi3U+g3/2Zz5cTYA7Cym4P/pRjaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y8H/SAjY; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8H/SAjY"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso4001603eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935086; x=1776539886; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=Y8H/SAjYoy/e34q1/GVqW8L4qforEOXJ3+2p9neSgmoRjknKfGdYVqp4B8wRwi7Zb/
         KzuepEraAlO1KLY/9aR0gXDtLAdODrHFFDINUV2mQKsNogYOZFII7rJNQboUJ5TL9vme
         LNSC0hVB/1e45khKmcSDBE+WXkWsP+YYar6Kl+/6HULuNBWxV+17ixV9+3XWjCYebpOY
         LhBsxszXnqUxfmnloReUOXJ3wSchuZK7X6l382ZOOhzqAx6Q6t8+mhMFpNVPj/YicpCo
         dCx7ie74mZIMT8W6tit0Bdz9dIBKdsJ/vnqInfFvl8Z/mmwNRR0eUY6aaUbsEeDMlA70
         nK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935086; x=1776539886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=SJrrEmLDyOtofKq/cnR/pGSgWJMD1f3ko25q2LMHnnPMDLdXweJdy9p4q8Ksf7PxG9
         MnaHXJ5KU/kr0gwZxgkQ3iswQErznBFABrT92VmO3/j/ZgYw14oBXLwjIBRhMX5Q/hHz
         p6EAelMzLW2TIH4pQ3RXGzVmvZbTeSAKZcr4S7jerd7DfxN980HFw+o/DAmX3zATFzuT
         zkwmm4nqciB5wwOxa/zWjl2x81zWqGMZ/0Lust3FMGxVbs9CkX9l9YxvmHlzMSKrPt3c
         rwFLIhJ8tYRyb6PpETVY0gh0C0F9Jxeg/WrKl52Nm3pnNX6tGANCB1ti79UUtVpJjWsT
         DVkw==
X-Forwarded-Encrypted: i=1; AJvYcCW4lCkNyumGT4ilBczUESvp5lG/RBY1MascNmr7vUTJtUeKZqXnwYUl0sRyQ8A56bDGWKTu/QIWgEi2DWgYu6n6@vger.kernel.org
X-Gm-Message-State: AOJu0YxNBgefOj5ctDL3tyz8Ey0QXI0TmOyI/dKFt91wDM7vpiNaEgJa
	tYboCTgJYF09LsaFXoP/tFXDk8v3HJFsT5K5afQZY19jWkvdQSjqUk75IPvSjaCgHHJGW/EMRsG
	uollfPUpGiA==
X-Received: from dlbvg4.prod.google.com ([2002:a05:7022:7f04:b0:12c:15b9:3cdc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3d12:b0:119:e56c:18b1
 with SMTP id a92af1059eb24-12c34eeb720mr3968605c88.25.1775935085961; Sat, 11
 Apr 2026 12:18:05 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:17:03 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-23-irogers@google.com>
Subject: [PATCH v9 22/29] perf s390-sample-raw: Don't pass evsel or its PMU
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

