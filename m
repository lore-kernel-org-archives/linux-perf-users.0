Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409123FF8A0
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034952; cv=none; b=TXl6adVwfgdtvdSwQIOAEClYQ066HGbyVUgG89Y1Tpv6bTievQoRyYp4Mv+HCqSd/d5yttpFLD53xrGVD43nZhTX5DKiFPpE1HkY+845CCF97MC7MJoGzxkdfxP+2yfFKFwaTUCwcwzNCIExYEtLwmb+WxK4wAdxn7SpOP5Dk4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034952; c=relaxed/simple;
	bh=SIqLYl/iCH/uxAayal1ERGCrYX6qYEeqvyziO+GrIeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NvZEgcnq7kR66DHUNCeOamnzJSWUW7rlNRUeGmDdbJPDwE8lGOKS2mq0MZGbRUxBcmvIbMpl1ynHkMoAkRP8cZdb1SaV6rpyUC5zbdZX3w+q5/CJfi2g8GHnkcwKgels0QN/IioBH8MQpTzqRLGuW9jtYH8VSam6EO2PqNHYSlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2kOKuV1; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2kOKuV1"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-128edc72e5bso14119756c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034950; x=1774639750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4NZS6AL7oOVCCREUUgvsfxKjx29LKhsPnmjEzP73Cs=;
        b=W2kOKuV1puRORfGsnACPionzl4/sSQO974udO4htgwWOWyGMf5vi47cY1KFDKIMMut
         uNui9enRn83+PeaFvl3RyvkG+3JYogCJLBdvuE44fMTgA6ItLm9oVIVXbY8c1ns/0KIo
         GfgcfUr7Ln60Nw47Hi50BX/cB8GxkVBp35eNczvHAXS0sV+jt6vbJO2X4X9D8UmIC+1f
         df8VrAf2oIToW16uHJGN4po+jQt4++cYfd0qpR4zjDiWJE2CJZavhn9VB1pKA78aItDH
         Bk5xd8XRV73qPZFonMLJ3ssJwx+KCR978N0QbVfS1eB2gQSiPsBfk8od4A8OVw1SyzGV
         BYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034950; x=1774639750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4NZS6AL7oOVCCREUUgvsfxKjx29LKhsPnmjEzP73Cs=;
        b=dj7ayS+KE7VCOjcCS9DZQNskRaoPC+79V3/SKCdzCNsFQiQqwB0AU9U9JXr/JvJaPS
         zYgzYOkmzAodc0LHutwdvXQb4ZHocODQXF0nW4b81K/Ts0heDExbkSRYLinTOKcObs7h
         00m4rI+zRg7v0f/JNK6FRtBG6MPyxWlU/ffFwT8ixdOkNMOEUVx/lrzHTioduCM1u9Dn
         yU6i+jtDkOojcDtFwSzgU0B82dyuvUZXjgH/YGFk30chpIkn/yEm2icAxSQos6ROLXEE
         xXSA/kf5Uig0WeUvbKXBEEB/vhwRTFLpWXOY/acrtout0NOluJIlAC1PH2GfZyF4ZWcr
         7qwA==
X-Forwarded-Encrypted: i=1; AJvYcCW9WOkhZpxvvhsBk/7k1Pg7LkM5hSiedXO5jP6xbzSiXyKawRairRekkHEABO/ES7ySPR2ddr9XlxUGUetwCxHb@vger.kernel.org
X-Gm-Message-State: AOJu0YyTNIBLIoK6NaXoMEUs0rcD7W2UFBAUvkoc0UEaszUCbSd/RyP0
	9CuGAUu0WsTIODOjpdRPKpNCDoA9ifRaeG8WHldwJSZE8yuZ7QmvEC5GcHCUxVN8Wm/5bFDw3ph
	kWuRiR5puVw==
X-Received: from dlbur7-n1.prod.google.com ([2002:a05:7022:ea47:10b0:12a:78f6:c8f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fd0c:b0:128:d2b3:5df
 with SMTP id a92af1059eb24-12a726d96ccmr1822379c88.23.1774034950100; Fri, 20
 Mar 2026 12:29:10 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:26 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-25-irogers@google.com>
Subject: [PATCH v4 24/25] perf s390-sample-raw: Don't pass evsel or its PMU
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
2.53.0.959.g497ff81fa9-goog

