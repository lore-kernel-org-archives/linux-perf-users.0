Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89935387362
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633221; cv=none; b=fQTGTzYM2kn/PT6EpzsOgoYyXVcPHprnsAehANpraE+t04Gtf10CE8yOQYThPPc1oldpC7DQhMOTih9VJlL1GfBRjCl5rQCD7Xt2NUFIG7HYc3ltUvyXir95FB67GdqtimV3VxrKZFf/lIS2nG8y4hSHJmIMLHR1UCewfmLE2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633221; c=relaxed/simple;
	bh=dx5HgIGGhqnvfj2keHd/IWfkicfFg95KhLIVi2C5jhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YHT0PfkLOpHV7wL2U+pv58HtR2laIedWgsE/socXSOyIMBLkcc1Md+qx4LQLunfWiBjsMeSoz6x7eeTOXazh6iAgu5ajULxAPi6AWSUeh4JDk6XcyCkRBAEoFvPh/cc4Mg5YDwZPhEgrrPuwSNEliGc4DKa4G6y9Hn5dHqVOkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhxlndER; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhxlndER"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bda35eab74so582273eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 00:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775633219; x=1776238019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7VGO43VnRAVL9zGAQ9Zlx3k+gPhIb04E0ubKH9cAnA=;
        b=LhxlndERhrsG8aGFEASiSj4v3EFNj9LyBH0OAEbpv4HGQQW+cRXabbGoaX9A6k1HX8
         bTbM750FMQunrobyHT1YrF8DZi3pZVR+rggPIKAycxt1yvY3hqsY134lC+wfgvJV5j/k
         OqCk2dxzYUjT3a+shNJgFQRejoMMhWmHJLiIo8IwojZmP2qAEJcdYkqyDLuE6B+sPkkp
         jeWI8aqGAujZ2aHwDQpB3YrrTCoBYw3WRPew9k1YBP82J3iZS1fvyi6ZOU9T/61P555/
         /eQjhdQoDfQG+/YlusS3siGw+8BQVWBzkCWPUin/SL+xRONjMV6JGBsS1+vUxES4iR0Z
         qv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633219; x=1776238019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7VGO43VnRAVL9zGAQ9Zlx3k+gPhIb04E0ubKH9cAnA=;
        b=f21Nf60I3EcOyHsy7aSO2VE6cG8gPzCWs4jIq2pEv+PudDPyCHFUT2CXQEWDt09JRU
         WwnuG2cOwW5A8pE9KigvF4hp8vMbCOLaQIUytdOTlXag3NhehuqpHcxBwxsDZZSguNze
         VPi3UKO4QYinKwGETAsownhPmPUB4+IHptaLieRPCLhWFWGXjk2jSee3uSjLkg+Od7/b
         9PlYl/Jt3CGCQENGd4aDOQSFw+YnCTNvZCkbR/i4Oa4PdXfYMUwAUqsr+QDWnAXsSYT1
         tj7FZu9SqBQbYVptOPrQS7hTnMA1KKjptXYkkCqS6YTE9j3W9mGynrPmJaNP5o0dtIIX
         8LDg==
X-Forwarded-Encrypted: i=1; AJvYcCXGtP10kJB29Iz/8ajwJPp63jCxpB8VJA4AX2N2KDgCwXKTndz8UJtmAhDc3dW6PVk4PcHSRDpKzAXPwr9loCsG@vger.kernel.org
X-Gm-Message-State: AOJu0YzQYk9OwH7Dx/u9O7Zs3aWT4z/eMPya8a50ZWJnvnxjKgdvLhvQ
	jCAOnb+toonBvPxcIX9i43huFzmmNSoBhcXUR7Hnbh4FgtLlutnft5SvIEasjnNMATZ5+DkwJl6
	ZP5fC/sysHA==
X-Received: from dycpw10.prod.google.com ([2002:a05:7300:de4a:b0:2c5:d9bf:436c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:19a9:b0:2d2:d5a3:e97c
 with SMTP id 5a478bee46e88-2d2d5b36ff8mr794370eec.12.1775633218369; Wed, 08
 Apr 2026 00:26:58 -0700 (PDT)
Date: Wed,  8 Apr 2026 00:26:01 -0700
In-Reply-To: <20260408072601.210837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adPyeCq3rQrTurju@google.com> <20260408072601.210837-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408072601.210837-24-irogers@google.com>
Subject: [PATCH v7 23/23] perf evsel: Don't pass evsel with sample
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

Arrange for the sample to contain the evsel and so it is unnecessary
to pass the evsel as well. This is done for uniformity, although
parsing of the sample is arguably a special case. Add missing bound
check in perf_evsel__parse_id_sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 53 ++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b653e683d7a1..1e0bb4cb995d 100644
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

