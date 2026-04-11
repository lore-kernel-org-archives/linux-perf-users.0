Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03007331A4B
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890699; cv=none; b=gu8YC/ZB+PuA+rsz38Or3kuaeSoIj8O1HDB4YJvGeYvVnWog87L6PepyFGSMRYDNd/WQeFVBYTZ5HHDghdX3hA849BTxFAraNoemDLqFViVeIkjiyF0czAoBh/S/50l1e8Cfc5r3IeHXD93r/WGrYzJIlargD4OuNk+eRiRnOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890699; c=relaxed/simple;
	bh=7eDRjxUlskf0jPR5n7ziyw0bbOj7tiw0HNf68rc8Zts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qZwmBcLUUQx4x6mFJo9D0mIAxP2DWyKMMUShB7L+X3OA+5cV8B0CA1eUXyYGCbsl9Co2V88dP4QPUlbInfOGrf1dFWmqOV3uch7QRXZhkrcaNPTWpcl9D6SYdnp55Y6lSyiSiIZ6QIx6RfR09Qf5jgrrs4kQ7UYIFpQrezgt2eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGi5yg5x; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGi5yg5x"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1279caef718so14385507c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890697; x=1776495497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXPY7HFKarR0XebItbgb3ocvXnkeDU8nFx5tZNKGnO4=;
        b=wGi5yg5xUXMIdBkiPLJC7uxy0fb9BQafhNeyPsZkT/oYPI8ehpimwimigo/iNaZVVi
         Surn/Rr9FP34lwOl6DXXRKvTCyq5EbwBvYYCz2bKVasKUh2cs9TFvNqfY1WOL7mqjHb6
         pP7JE4Puqzil9PQ8HZQJKxgwJ5mXi77l/Z1KQIPSKJ/ugWdJQz1w3CfuQ2SUkcQ+uXo5
         UAvCF1Y/o3pGXRitMykP4xWA9RZfWRhNB2R0w6ob70jMbBqCryA9JfLUo5DqJID6Eky4
         094pHIzz9W9myMoXNJE5y8KGwUD52qpsscWIE2LRhoDJD4xjQvK6hK6iHJ4sJgAV7w6I
         qSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890697; x=1776495497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXPY7HFKarR0XebItbgb3ocvXnkeDU8nFx5tZNKGnO4=;
        b=Lc5n6T8MN90b5CqhQyUbIKOqVdd8DzSG27vvCZwL/uZVNeHSvjK5sJD00TRNkapKLH
         FbmIB6KnMj7an8f6XR7cNwNMBvQhDm63WlVbmgrtg9YUZN53tGTDBjiqVmXbyMy7JOle
         ZaNIbuTjjVcq5NfVPuYwcMnhO+WUJFuWaQqwIPLSSEXA7yQ5+zrZJgVc6b9UOZac1DuU
         t44MAQezeIeK7V+Rp8qRucWHXiWJ+pblknUPyBbidXNfWZzFAf6RubQ0s9xeOuil4+nU
         1rZjc2y22bWO2NPj6WFpg6OvF3QvcxzWldMujoumrPbQ2K3yXvlM0dIbH4cBs7ciShji
         HN6g==
X-Forwarded-Encrypted: i=1; AJvYcCUiSS9+ZlvpJe6hedBz+fofsb0yJGgolkkhR+AonBRVHHD65jLuOLUGyYVVPlD/d03TXc9eNkBdm9Aue4kjCzYI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe9q3RDEgpsjMfGqUL+hOCtTgw5zcRy8hjggUyIxfYMz5rmhgO
	l19WiyKedkwAyrZTnueQfeORNGbzOTZhpuZ+3iIyV3ULR/SbkauM6M8LmYB4FrYBytFMezcHE5R
	LnLxhUSjYVw==
X-Received: from dlaf2.prod.google.com ([2002:a05:701b:2402:b0:128:cff2:6560])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6982:b0:11b:ade6:45a7
 with SMTP id a92af1059eb24-12c34e68d78mr3475036c88.1.1775890696740; Fri, 10
 Apr 2026 23:58:16 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:57:12 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-24-irogers@google.com>
Subject: [PATCH v8 23/29] perf evsel: Don't pass evsel with sample
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

