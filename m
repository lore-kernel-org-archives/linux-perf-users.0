Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A383C24DD17
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043400; cv=none; b=Lfjj0BLAV9/9d3cS3TbeyH4YlbQOZPdfjh5uGfHcoyDkdYQsQi4tDu50Gz0EcJDxqLfn1Or/lYgX1DI7/t3Rf8QpvMeOIXa0/8NaOB0ecra4tZv+2RAAvoQ+4koiiJQzF1hs2ZtsOc4rUWbUg6IVbL7SkBxXB2tJfAcg8aQoUmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043400; c=relaxed/simple;
	bh=p3zEoq/bmQlpgAQt3/UAgTTaA4JyI4UO/QfGKpe/qI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G7LRivBp6pm6v9kM2UEw1uJlW8KHDmJUplj20/AwS79EgX8xs7TfETrmgIsVEQly0foKNUVxGvCKOhrsZTbZ9H03ys4aMZUNB8W7Aa0ZsxIOeRhJYnOsSAXfQf/C29tFy7pgHKuXFXF3hM7udqQj82T5egLlavBgCS1IBSwhdGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vBepE8bQ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBepE8bQ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2cc75e79b97so14009005eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043398; x=1776648198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=vBepE8bQhfwC7goW+EbUo6hG8YrCCma/Bt1L0fkcsFTUkd3onVvuE3FggwEG1M3zEw
         C+oZZXF5qux2HyzC+y+5RNF4UIqjxWsp2VajA7Sj6ZU4q9D5vnzXc7hHtu66u8uNvxKZ
         eMOGtU4j4zMo741NXyhMjXIF8nKYdDWqxKgfk44QXpRyKvB9FNByrrMH/9MYYGO2Hv4T
         bDEm/Ulru3KEMTZzLoc7+ZBCvR7Y1a6Wk/9zGXCAEJ/9TNSbK2IurDKt0579vm1UPxet
         FrVNvsLM4TGPw4RyS1TP8p83iZRuArBHwunU+vimJZ4yni+/a8ETKijfW7zCIDf8Njfi
         wp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043398; x=1776648198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=sMtz1f6hLjV2ybT07APQyRrWCEhxhKFgWJeHreVR3++Nkoe9akALCJn1jFA8is8cyn
         81PoiaOglkMZkyU+3x1mMPKyBnZ1TCCG7Ay5qRz0VwAxLsEO0KOwD39/CIfmfYZaf/pq
         c3dfLBPkkv7iQPUUd+Qe+r7bCQU4xx65ZbREHzCtKybh//JG+tXSOw+psv9/fjVA3q1p
         hW1VYPyQ01Kf4y1eeeClEM1WqYKESfKoZnl2UoEuuA9Oe7fc1YpYq98AIgAQ1IK9snq1
         IGIy738RHLw+yyWY/5yyG7g1i/yafPqoV34ZSLb1WRfQ9tRj1ZInbGFGJ36ryUUEmv5l
         MmxA==
X-Forwarded-Encrypted: i=1; AFNElJ+K5KhKcx6wO69BtqGmr37wF1C2SvzR26Zw0zbKvIAwHV4XV37bPnXSoK+rf75eIVrL0UcDawV5vE0PcJAoy8MY@vger.kernel.org
X-Gm-Message-State: AOJu0YxNaDVjXbBc/c0XJPtpVdM5ALAormPlb9NS9g/Q6VxLY+mN0e8o
	AhB9zJZfoyG4rvZEtWsgR+rGs7kkaN3AF7W28+23UIgyXf/4l1nlXvEVf5FgZQyDEW8UMJBXn8O
	VXF6kRevRcg==
X-Received: from dyji40.prod.google.com ([2002:a05:7300:7a28:b0:2d8:dd18:baee])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8c85:b0:2c5:50fe:c782
 with SMTP id 5a478bee46e88-2d5871bc6b9mr6192275eec.3.1776043397595; Sun, 12
 Apr 2026 18:23:17 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:15 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-22-irogers@google.com>
Subject: [PATCH v11 21/33] perf s390-sample-raw: Don't pass evsel or its PMU
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

