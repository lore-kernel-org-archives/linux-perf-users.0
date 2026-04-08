Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA76387362
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633219; cv=none; b=eBkxXYjSHcyJ9UzHbNQOo8+QhKrlsAF+LWTlpOdmw7n8AsqajVHQR6auY99SkzPE3ImfMz3PNKA/OBVveUAj652sKvJOfWvFn1oOfzvM50JoTEfkvl0WuXAaWYaMeQOsS+eewY3BPUP9TF7eqaDsmRma33gkLZAgx71IkP0zYMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633219; c=relaxed/simple;
	bh=p3zEoq/bmQlpgAQt3/UAgTTaA4JyI4UO/QfGKpe/qI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fkd4YjYTGkgP9bkSMe4uut5VJmHJ18+UH+42hlU2rI5lUu/PelHBOmDmLnfg7Zh/QOPSZqLBk22GGlVTffslb8aUtuyqx3M8D/1xVHQwyngzPf97OJglmcK9CcqwHLbBxTfM/4e3xFTgi+4arUexldEJXO0iueQdd8p3o+hEHz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2qVeV3v; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2qVeV3v"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso8560359eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 00:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775633216; x=1776238016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=l2qVeV3vv7SN0GYOHSQb0ZMZzC2n16wNdpv6e6tUS1Q99BwNIW9VgsIs18x3WeKfsP
         3q1CT+dhNAjwemFARFOteh54ooQExzz5jslz0Asj1FiWH9X+2jTg7SIU74hvSDPzrdDo
         VBdwZ6WCC1MpdQFWNzPvr9I8isMp/rn+tjW3ApS/TRTZEIlM51KfdlwmVjbnlE9bHBqt
         gs2TWr6WOnVneSw05PR8tvs9aMFc77azhcF/6nQX7kVDt77pZgmDJfHCFgN9Lu1IkFXr
         dF+KhZdpsQYfBBufATf+l1ZqSwo22tulEjpxyFSRcPArJiEc1tqLUoUOHrYNe/sLwpSM
         lt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633216; x=1776238016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=ScRsx+FczHT2fUwSNEfWodJSAMo/908+FrLu4wwerqWvOdUc9bkY7NCv2ow1PQGt+7
         NYj13ES34VSCZUo1CDhz9tEhlufogJYCgt2808BphGPhyDhtPNsnVxAZUschAiYtrowT
         IpvqA9qA3O6gVjabfn/ts5R9dy/MpF5WGt4+kgK7DnAiq8AfS2Q/a5weOsySA7C4yKmh
         WGA3BkmeFIaCfGxJGoad7MRDfpTlzyKthZZ6+2oEaa2+Rg3Dk39G+e+iTGogYxrz45CY
         gkDWnJCDKHnkIjz/4F4eYxp1YeXhK1/2rrqlcaPBT15If3NzmotDbW9ctvQvhaitcLhd
         kmmw==
X-Forwarded-Encrypted: i=1; AJvYcCX27vZoC2H7cTK0QrUJLfULDTN13++VDg1kF9/TbWyE0MS9rn5k3ju5wh54lGhqVWnZrdfbcBiM7cEk5LyiuMC5@vger.kernel.org
X-Gm-Message-State: AOJu0YyMt3k47L2Me3Cp0oPGVtIg1M63/L+h3C4UhHbrO9D1J671l/Lk
	pXzHbAYJc8aC+nbzas5BmSwWZ0PNE6PllCxa7a9XNTM+giPVv7+LBFwjUZnDJwGyAQaig9/DIMZ
	rSxuBkVeufw==
X-Received: from dybmi2.prod.google.com ([2002:a05:7301:f82:b0:2cb:90d4:7906])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1288:b0:2b7:fdb6:ccf6
 with SMTP id 5a478bee46e88-2cbf9fe7b2dmr10513589eec.14.1775633216201; Wed, 08
 Apr 2026 00:26:56 -0700 (PDT)
Date: Wed,  8 Apr 2026 00:26:00 -0700
In-Reply-To: <20260408072601.210837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adPyeCq3rQrTurju@google.com> <20260408072601.210837-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408072601.210837-23-irogers@google.com>
Subject: [PATCH v7 22/23] perf s390-sample-raw: Don't pass evsel or its PMU
 with sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, 
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

