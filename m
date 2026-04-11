Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FF633D6F9
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890696; cv=none; b=mMoKC/7juga2CU69YhycCkue3d8srFD1goxqJtaatQLgotxbLHl5LZ8KP8JdJovWS+Ga0aVGwbPgaVp354Yv0rwPJvHMpVwhfmHsyLq8rlhK6pq4NwLIxPNNaEFoMEoPvbcu109ig+8AUzc8vD1F2bt4zmyqxg5AB3Q0HtRy0YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890696; c=relaxed/simple;
	bh=p3zEoq/bmQlpgAQt3/UAgTTaA4JyI4UO/QfGKpe/qI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=broo5UXaCqWZgsKmjBVjuxKGq7APxBgYj+LxvSeqfOx3IEyimmWhkQQQCioV66DfBdIfc/mSBP3cXqkhop1Rw+fhgzHaKEnlrlvSMJouKsn5/sR89iXsTovCc3O5j2bzoUz976CWx8sudR57FYeT8Csfd4VVUFA4AL0LwQfs794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9MYmh35; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9MYmh35"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so3164800eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890695; x=1776495495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=n9MYmh355y5zYAVpxGJuu6chQLz314Hpx9VhWdyPdH7tY/fai27bYCMSk/llFNTsgf
         orjKu+cdTHHZtLJMjScyPxVmh6iopMV5cASFcnVtXELdeDCt0WZ3Rvtob6uI4IU8of0Z
         FtAevPugNgIbSYCVUuupEhP7IoiywKhNjnm5DWeR6pX56w14VTpV6X8qtOjQH07gbamS
         DJ8gGxPpeHgz00e+CltyAa+7Xo2gcYx59zyTKQCghsoOmctxSFcHeiAn//3oanL6GXao
         V6Cv7VidkL0IFP88OBBVFrhYW/ygZ/31fR6hWHnG5jgyEcFGMa3rF8Yb8oZu8fsiFLNY
         nhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890695; x=1776495495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=lSMkTUoKgSc7WPyMSg0klnaBxtvxkaC7mtJkdW8WJMzR+7Kx8Y5tKTnRwZVI2UrOzh
         iDK3UAqiMcNiTsotrl6Z4Rw2YUBVQnZAkeeKO5yMJywc8fIAZNL2O+yn7n0a5yVOkFCP
         UQlfn5kL386X/xywzpfE9V5hblsc3JZ/NOldncQgrfl6h7WJkRDqvfzB5dVLglqlOVrd
         WWjjbXdEv7vSlW7pDwDV115RoFp4AOnoikCX43VToFLkWgD/51v1pOR13FFW6iH9zgxY
         aaF93qmbeXl6OJxc16G24V6lBXuIjK+b7hYjoS4dJfz2JJT7jP/0Uq63kZg1epvOgbF+
         /9pQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+N6y8R4UA+9PFZgad/izm8KXIM3+w+LNOme0yiDIKWyp8ZXtQ5XeZTfiQLOL4YzKWgbCdiOUr+CEe8PADzdVt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/bXASsFON8Ki0UnqCTTmzr1wiqf7DN8qD0ssiVqQFims5E5OY
	3pgLJz38mA74ffwDmz98L8Kx0tPzvLglE1GMF0GuNCbl+Kj1ohKyVz2FNbsyrvZpnuT2f2nR07d
	vrxuumaEu4Q==
X-Received: from dys21.prod.google.com ([2002:a05:693c:8015:b0:2be:4118:56f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e2cc:b0:2d3:4252:b127
 with SMTP id 5a478bee46e88-2d5898a5246mr4039812eec.26.1775890694495; Fri, 10
 Apr 2026 23:58:14 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:57:11 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-23-irogers@google.com>
Subject: [PATCH v8 22/29] perf s390-sample-raw: Don't pass evsel or its PMU
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

