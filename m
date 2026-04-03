Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A913DDDD5
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248882; cv=none; b=p83S61RhX48OSq2hAIChwtvqPmKe9eLPxp+ndX+iPxAdmycZLdHm1q4GG5oYBjYVeVGTn4aou4cchnPdltoIAHpRXxmHnXRHrdHOPx9KvISvQh4EjWkMPoeL25UTARCl3hqKgpUBEdAx1TPTCoKt/FgQnKcpAJ5eX6tBQcD/Kyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248882; c=relaxed/simple;
	bh=p3zEoq/bmQlpgAQt3/UAgTTaA4JyI4UO/QfGKpe/qI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FEi15no7+X4/boR2R7TEjQf7rWrjtwHxb0al5RlHzj0g4Pw/ls/mISF7vEEoUHRL9P3SeCKqzFDK3zYDiQC/hGy9t6RYmevzdRyOcYgsE9nyBdiNBFnEoT1snTe/QhcZD9M2Y4dcSv3Yeay8HEqoe3uOUr1Rkrcbrq0QFfaCjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NA0/q/7A; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NA0/q/7A"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c68a134df8so2139851eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248880; x=1775853680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=NA0/q/7A2IxETvY0hKSHtUkbv0BUlN0IQzqUU7SQ001kqb8bsjESMsRdftxOAqRyhi
         DU0G9FyhTRv0OZc47a//YzYAmzZ6uIFwdxmwOMsPkDKbUQl5Y99B3/lF0QHIT9LDJ91e
         1rSLcs1PfBs+5NC/GNsqGw6RElmrP5fGiELk3rJxldgBFQS/AfcZ/nAKhtNKV5oo614b
         A7tNzNpp7NEhopapZubnfdFb/8Lft/Vt2gTcRTcssYSlank9H1HGgG3B0nL3h+hRiH2+
         s2XKFk+2btVYpGf9Vlg0FGB94czj+3vW5acEz6NVd0dVR8CObV14YWoHFzAwSOFGSPnC
         uRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248880; x=1775853680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=fYqvnjaCRJINmYxbZqOIB3Br8xkKJ5LzFg4CB70QSQQDk0JNn29cliMiriMXVKkzoo
         BfRGLFXT7rluTfgKpiLPvxD7W4O7xOrU8pJWRylBgmxHCa3r8YYSURp55hoiJjyQqtd7
         L5f3Cg4Bp7scSWahSnPEohvtpvqOov31dOk72G0ug7MOmXwZRBg7CI5EdV4ttvDq9XI/
         aPKr2q2YznHsP7Se/nhlACaUtJxkGxEnkTvYh6Psy/L889391vXk2eRPDZ9dTKjwbcth
         yEglETFk7lv4AdBxJFO4XERE2T4kKah+/Q92iGAv/YIBfE+Q4P1FJpO1i7CvRE8Jxw9i
         zJnA==
X-Forwarded-Encrypted: i=1; AJvYcCXOkTKvy+LLYZMM5o+YTUMI+cOFPh2KJ460GCjM1EYdm16g7A5LkfKJ8zv0FPPVnsbyxKpbPlL+dL8VCmpNhcQV@vger.kernel.org
X-Gm-Message-State: AOJu0YxNdkIry6okH5WxEw3SnvEWR/8afzkMrT6s1Ze9Og9zB/WZdpRY
	cKechJ6YKmeVg20F4V9R9zePL6YWPN+xb+S3uHkwGbrYYNxNNr/ApCq7A5fhmhjhRKA2Rtpuw82
	ZO6rrn+8lCw==
X-Received: from dybmd47.prod.google.com ([2002:a05:7301:182f:b0:2cc:9943:d1b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a14b:b0:2c1:6676:5ed6
 with SMTP id 5a478bee46e88-2cbfbf7a279mr2007764eec.25.1775248879950; Fri, 03
 Apr 2026 13:41:19 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:16 -0700
In-Reply-To: <20260403204017.2919994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
 <20260403204017.2919994-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403204017.2919994-25-irogers@google.com>
Subject: [PATCH v5 24/25] perf s390-sample-raw: Don't pass evsel or its PMU
 with sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
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

