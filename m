Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6453CB2C5
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935090; cv=none; b=KgwARRJn/wsvItNBcysQITE6xJ82PC9mp8Ao6JiWkFvibbCp+Fpup3gbzmCvRBttJ0KtWb+myUpQy8Lrv0ws/Vc0oEH4xJt5DB/3aBt/aFDwAwhqLTZNqx8S1/wsrh37sanP8THw2uP/8JtPbRB8uR5zUigWZPUclTlh4y6wBGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935090; c=relaxed/simple;
	bh=7eDRjxUlskf0jPR5n7ziyw0bbOj7tiw0HNf68rc8Zts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lAz1amwPdrrAzi+cuGh+PukmI53JOx5zY1g8B7DU3nc2W2McliJ7xlhTUQoJOWSpyo1sPRouuLXqG24AvGds4j3SiYsx1dgFF0qYuRs3dr56S9NTj9HC3ILUzlJoI/M+ddRyyMRXWu7Fhq7kwc7e0WuGxc7uzja5VhDmUd8QJCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOxygLcm; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOxygLcm"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d443c3b094so6357216eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935089; x=1776539889; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXPY7HFKarR0XebItbgb3ocvXnkeDU8nFx5tZNKGnO4=;
        b=rOxygLcmBiVC/ptf6HTmjuyjf894tV6zq6M8gZnPNtYum4kSlQWLKy98vk5IVYQ9I/
         efFFLa3KCzWop7BJH83XrVLbJ2BvYA4hVa0iaihWSB+ONpHgBK7EcSSSIbV2pZeYG92z
         uKY+ctO+TfSG5jPnDsWTIRtxJ+faMzorh33XkN/B3FfpwybBLZs2C4WlnizNfwL0WrZn
         kKjWRjx/I06OaeoLCrto+bp+Hy59XPpvhMTj+km2uPLpSVjZNeYKQt/KMSdoX9FPbnm2
         A5CLpBJVLBafNCIJRNiZVHMVsAK5eucaDuqX7k3D1UuaHkI6swcm86uESnW83S1DhS4V
         D7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935089; x=1776539889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXPY7HFKarR0XebItbgb3ocvXnkeDU8nFx5tZNKGnO4=;
        b=EoeUhAaDQGAxUtFn/04tW/6wVWnw8bAEJWYj+hcaY5VqnKAhVx7pKq6MG1m/ANM1Cx
         WUVWZWW35yEf5c2TKIDQClfc/g3x71rJqCArVa3BwwdHon/OXZvXu8A8UxNgVDRXD0HO
         2E9zTBHqGghmC1KcwvCI617S5xUcz8A2WtMLJuPkG0/6Q7B4Iey8WxvTi67tZ9gM6Fag
         pEGFewS4T06hANIXRZfsHqnJpwepNZ0X9TYdkTskx5eoTzE8vKMxowQC3Cu0Pob8h7ud
         D3i7YBygIu/7ZSwHT08G4ZtfAx9Hg9UKF05SZcwoc4pNdq2d10nEVaMZtPbYSIVqHK22
         rNNA==
X-Forwarded-Encrypted: i=1; AJvYcCUhs4ARgRBFdcNcItkU5zwzy53DQ2lldmxlo0iAK8Eb5ei+qKIpam9ljZJom/lr+Uf0GEDmUjI4Ed7HVh0/aBrN@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEHajSDdTfviCVqLNj26NiXap6bCRrEtBJNA4JIcEzyDk5yHX
	QlMxCuGcwBCUuin1qfohsCqis+4J+LGMZ3Jwurzmnuj+eL4fNFDdR69qB4dpwUP01bECMFw9S88
	8+jkbZG51lQ==
X-Received: from dlaf2.prod.google.com ([2002:a05:701b:2402:b0:128:cff2:6560])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4197:b0:11f:2c9e:87f8
 with SMTP id a92af1059eb24-12c34f147bbmr4127467c88.34.1775935088335; Sat, 11
 Apr 2026 12:18:08 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:17:04 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-24-irogers@google.com>
Subject: [PATCH v9 23/29] perf evsel: Don't pass evsel with sample
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

Arrange for the sample to contain the evsel and so it is unnecessary
to pass the evsel as well. This is done for uniformity, although
parsing of the sample is arguably a special case. Add missing bound
check in perf_evsel__parse_id_sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 53 ++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ee30e15af054..3c10b840778e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3003,24 +3003,39 @@ int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
 	return ret;
 }
 
-static int perf_evsel__parse_id_sample(const struct evsel *evsel,
-				       const union perf_event *event,
+static int perf_evsel__parse_id_sample(const union perf_event *event,
 				       struct perf_sample *sample)
 {
+	const struct evsel *evsel = sample->evsel;
 	u64 type = evsel->core.attr.sample_type;
-	const __u64 *array = event->sample.array;
+	const __u64 *array, *array_begin = event->sample.array;
 	bool swapped = evsel->needs_swap;
 	union u64_swap u;
 
-	array += ((event->header.size -
-		   sizeof(event->header)) / sizeof(u64)) - 1;
+	if ((type & (PERF_SAMPLE_IDENTIFIER |
+		     PERF_SAMPLE_CPU |
+		     PERF_SAMPLE_STREAM_ID |
+		     PERF_SAMPLE_ID |
+		     PERF_SAMPLE_TIME |
+		     PERF_SAMPLE_TID)) == 0)
+		return 0;
+
+	if (event->header.size < sizeof(event->header) + sizeof(u64))
+		return -EFAULT;
 
+	array = array_begin + ((event->header.size - sizeof(event->header)) / sizeof(u64)) - 1;
 	if (type & PERF_SAMPLE_IDENTIFIER) {
+		if (array < array_begin)
+			return -EFAULT;
+
 		sample->id = *array;
 		array--;
 	}
 
 	if (type & PERF_SAMPLE_CPU) {
+		if (array < array_begin)
+			return -EFAULT;
+
 		u.val64 = *array;
 		if (swapped) {
 			/* undo swap of u64, then swap on individual u32s */
@@ -3033,21 +3048,33 @@ static int perf_evsel__parse_id_sample(const struct evsel *evsel,
 	}
 
 	if (type & PERF_SAMPLE_STREAM_ID) {
+		if (array < array_begin)
+			return -EFAULT;
+
 		sample->stream_id = *array;
 		array--;
 	}
 
 	if (type & PERF_SAMPLE_ID) {
+		if (array < array_begin)
+			return -EFAULT;
+
 		sample->id = *array;
 		array--;
 	}
 
 	if (type & PERF_SAMPLE_TIME) {
+		if (array < array_begin)
+			return -EFAULT;
+
 		sample->time = *array;
 		array--;
 	}
 
 	if (type & PERF_SAMPLE_TID) {
+		if (array < array_begin)
+			return -EFAULT;
+
 		u.val64 = *array;
 		if (swapped) {
 			/* undo swap of u64, then swap on individual u32s */
@@ -3244,15 +3271,18 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 		data->deferred_cookie = event->callchain_deferred.cookie;
 
-		if (evsel->core.attr.sample_id_all)
-			perf_evsel__parse_id_sample(evsel, event, data);
-
+		if (evsel->core.attr.sample_id_all) {
+			if (perf_evsel__parse_id_sample(event, data))
+				goto out_efault;
+		}
 		return 0;
 	}
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
-		if (evsel->core.attr.sample_id_all)
-			perf_evsel__parse_id_sample(evsel, event, data);
+		if (evsel->core.attr.sample_id_all) {
+			if (perf_evsel__parse_id_sample(event, data))
+				goto out_efault;
+		}
 		return 0;
 	}
 
@@ -3614,12 +3644,13 @@ int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
 		struct perf_sample data = {
+			.evsel = evsel,
 			.time = -1ULL,
 		};
 
 		if (!evsel->core.attr.sample_id_all)
 			return -1;
-		if (perf_evsel__parse_id_sample(evsel, event, &data))
+		if (perf_evsel__parse_id_sample(event, &data))
 			return -1;
 
 		*timestamp = data.time;
-- 
2.53.0.1213.gd9a14994de-goog

