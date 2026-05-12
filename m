Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A863A6B83
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625069; cv=none; b=Zw2wElToZZeY8x4ptYanxSNa5SwxnVuzV61sN3c5E87q4XvopBMhG1TWJeM0EviiDe3moqL65wQ+MWwy8MgFwaZ3dnlpojTOOt3eGuXjRGG7ByqULi1V78GzxCboZb5a/B8rgrQM/6zyUHyCph2yw4SGUSbYC1cdYL84pvw7Jwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625069; c=relaxed/simple;
	bh=R2mYrtIH+cEYBpjYFkzjyzwumR9J0xCxaiuEDwAR8fs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qYLxnMKBUIZO0SsguDYTH3TUUy+sWFR8XR0m91RigddJZktT2Wc7V9YSjFh8h2mS54T4H7IIFEUwk4AOMZKRjmdXCw9LBxMQRJzoNJktDrS3SJUDcGWupeIr3yuKDIMl/LixD8iFgQd3JCIJUTzkVbgC4mgdQb7wEhDDJj2uU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clzE75x8; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clzE75x8"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132c3280e03so597518c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625067; x=1779229867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nXJ2mY5d1UHV89EWy3yfaT3HiWGgm3pXFJDp8n5u9FA=;
        b=clzE75x8y9p0kbOF6bLFGaFI2C+4PXYM4gGt67my6HQ0L4u3BHfa9MdqeIDrW0iki2
         yPpu70uIT5QyS7MihqTaiq7UsmdoUiLYzRPiNQlX+xh0uBCjAXxRqmLzXX+0KPO6thD0
         +861a1tC0GTsgDjWLsyKNAg+X2dgGSLbeGIR2zqWn82E/F6buX2oHcfsvrE35Z03MDaC
         zhcc/DNqIIX3ZT3/yRjDKCWBVIyTmSmaC1mRmH+4Im+PRJztbtp0FIGKzp+H9R/Xq+jg
         mXRdHkXMFCTkxgUG3qkRvqeNrcrz6TTNDlorZT14sa1G/aZCf2jaCl7jvp0ZsEpxIfW7
         TrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625067; x=1779229867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXJ2mY5d1UHV89EWy3yfaT3HiWGgm3pXFJDp8n5u9FA=;
        b=g0Nml/zqaxr4QCo/+y7PGn3uqQJzQdKj1b9UuCapXbfZOwoTCC6UdyA9mgdHyDdJoR
         EhnVitIZxku3vjgiss/ZrM2XDeCNGN66vKrQdXHpFxws1Ftij4Y7MuyIZoJCSIqNwxX+
         wC2ZIOO4csfphsdjtPp4TdvhcZVVZcZOgaE6A+isMMRNKO1AAcNmyA3jKtTfpMNsFngW
         uB6iBV5ikQOgt3ko9genpg2Fl1KI/ny7uEiloNjVNpTvx95yo+mo40DSeGTY5zrHRQO5
         rN7EAp7lACKPiIE7MCLNYQhv7ROUdgVyn2suBpoc1ot0wMOEE85F5oVikie7d3qYMWdB
         UVsw==
X-Forwarded-Encrypted: i=1; AFNElJ9f69mXUfe2p83tfyruxGH6dVppGPsVIdZDDM14QSZXe0rKTgiOrR/3Yt4YfTDek9ZnYQK7I4ZS+rLo6v0xd8+N@vger.kernel.org
X-Gm-Message-State: AOJu0YxyR6u5QMzVpKbLQaDmcDFFGvmUm3apPCGc9BawgjGTY+AxrGvb
	EverPRoebNHxLjD80mjwTsnLo2c5ZneJVI+wrFe+t6SME1FuUTqjVBoxEOnmPiiWk03q2DK4m2M
	mGYjWmwFx4g==
X-Received: from dlbeg7.prod.google.com ([2002:a05:7022:f87:b0:12d:b5ec:77bf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2385:b0:119:e56c:18ab
 with SMTP id a92af1059eb24-13436780a2dmr532101c88.19.1778625066368; Tue, 12
 May 2026 15:31:06 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:49 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-21-irogers@google.com>
Subject: [PATCH v13 20/32] perf s390-sample-raw: Don't pass evsel or its PMU
 with sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
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
2.54.0.563.g4f69b47b94-goog

