Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12E3FFADF
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034954; cv=none; b=kNhcgzsYZ+EfOIoG6bIShTBBw1VTXEazIkSFwr6tVAERG/DMW/xkrjEiEVmZZpDmJik6arIHUHO7PleAftUnLO4BXTxR+ev8xz8K0d2otevg0k3RSI5pUW33F1jYHYzdoYejkJ5NyHZMGE0CqGMFeFAIzw0GgUQvoGA42j9uwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034954; c=relaxed/simple;
	bh=jCC+1zcvSlee1yIALlESeOVCtdEIr/366v1aS7dmfS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vf7vxM0YLWeGFVQ6WR0ktcy3KMl/X9Ksnt8GKPNTAYP0Emsz08S5TTr2CMLzvgmV5K84OLRpKGKlTROktHTkwTYiz1DrdxxazP5jXjeoIFxaX2/TCgnZTnm8Ib+FGUzP6PsMwJAqkMzZOGpBTo6PRPgof7BnKFDCfqx66NlwzH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VbMlQJDr; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbMlQJDr"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12776bebeb3so34387887c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034952; x=1774639752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpnOSR9aN4De7swl35pxQV3maON/uaBOmwAh/6kxbBE=;
        b=VbMlQJDrd8ubI7BMFeglpqDaCjL16semYOvqrcbOYovoEQJV8VlK1BAkuoFde3Gwfy
         ZhZ6P+wKAfo34rvHJkgzWPrXEtI0aPwYoqlgJ6pMqGfdaQS3XifwD7oIN+29aaDEug0t
         zVMr8q6b/g0VvK9l1E11ZvQVQG02EsskGHeKI8TCdUH/6XI2stmmi18WCuA8SBBITo2E
         cP9v4in7ZwKWABbCEnqiED8CHTeFqrCPz3QUz0bQ+AHFidAIVT2MBDxzPAquw0grpFlQ
         XKUm+owir1S+D31aHn2ERFSutrJSrDbA2H8XxPxBVLThl4tec1mgbMh61A+mQyTfBO1E
         v86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034952; x=1774639752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpnOSR9aN4De7swl35pxQV3maON/uaBOmwAh/6kxbBE=;
        b=Ppt0wm23eFnUS/7WnQnboJvaweRPGkQuPCfUgU2+yDTjKlju6K/Mwm9QR6v3X9pCUt
         gaW1IIi57uPWIcqr+B+9gUZ9qz7DnclH8zYsdHP10e5zu3JU0jU3snHLOV9U8cNLOxA+
         l4Ub2Oy4Wx8FsjYY2LBL9sdnuB9LRudFrnO6Kr0GNJtvdcBSbqxVGz++tjRwIiEucsoR
         ymqZU1i7Zyvu+aVowTWSzM6InAwmlq8kcFVCZh9zzyz3YfNCmKHC0QE2tJUJLBDXkD30
         ax5CQTg4feZjAAARp8L70uwZZAY5AeecIRWqxHysQ5ZLYjbQTbduN79vINQ63nlGq9Tx
         rSSg==
X-Forwarded-Encrypted: i=1; AJvYcCVDEtc8y9iLUl2KOhthZ79C2EdH9WJLi50zz+dlIbMVWZM/uzSy56gjWuIt5YBYxzTI2I1vNTK39CG9RYq96Wbd@vger.kernel.org
X-Gm-Message-State: AOJu0YysWM/FTc2xL8NuA2KzbHZlIYs8tOHWY4Km5XSxTZd1XwDGP2z4
	H04vs2uRMqU/FMKwbzF3yqtkdWbNzn3jiTvK58gv/3lqQgenLkVNzGcUmH7En2cWcRkx/nUEX16
	k4bgyhWfHXg==
X-Received: from dycqz5.prod.google.com ([2002:a05:7301:df45:b0:2c1:131e:b5c0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2389:b0:11a:e426:911a
 with SMTP id a92af1059eb24-12a7265d2aemr2005377c88.15.1774034952143; Fri, 20
 Mar 2026 12:29:12 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:27 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-26-irogers@google.com>
Subject: [PATCH v4 25/25] perf evsel: Don't pass evsel with sample
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
 tools/perf/util/evsel.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a4fe37f2a276..1085bcf3b54b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2997,24 +2997,29 @@ int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
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
@@ -3027,21 +3032,33 @@ static int perf_evsel__parse_id_sample(const struct evsel *evsel,
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
@@ -3239,14 +3256,14 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		data->deferred_cookie = event->callchain_deferred.cookie;
 
 		if (evsel->core.attr.sample_id_all)
-			perf_evsel__parse_id_sample(evsel, event, data);
+			perf_evsel__parse_id_sample(event, data);
 
 		return 0;
 	}
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
 		if (evsel->core.attr.sample_id_all)
-			perf_evsel__parse_id_sample(evsel, event, data);
+			perf_evsel__parse_id_sample(event, data);
 		return 0;
 	}
 
@@ -3608,12 +3625,13 @@ int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 
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
2.53.0.959.g497ff81fa9-goog

