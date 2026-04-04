Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5A349B0B
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 03:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274278; cv=none; b=A8eRkLqVydp5WnGzqjeEz3czgHSujCMbcI/o7rI0NypblDM1TabVtO4CMy4DvoHGU0hmTGOZrY2k2h3qSdTNUhevJFNTpMJosje7cgv6APKvw4F8hzTbkWZaisjrJSehI/NTpDS0orIRTejmowYbgwG0bbSQcbfl89uxJ+5c6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274278; c=relaxed/simple;
	bh=dx5HgIGGhqnvfj2keHd/IWfkicfFg95KhLIVi2C5jhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k7KchoM4zFDzoe5T/PWlLO91vEjakNYtq1QBw2INtismi5pWLBurlwD2SVsRyJg26UvUm6LN9jW+/USDY8tOLHJmmJIO6/PPJoOvQfLeaB8fzRRbPbdTMx87UmOBpe93htZZklm/jMcvFFx9f64k9e7v2m7vD7U1PvjfgQ7Bmgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NVGLQFwB; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVGLQFwB"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-128ba70cc99so2579252c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 20:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775274276; x=1775879076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7VGO43VnRAVL9zGAQ9Zlx3k+gPhIb04E0ubKH9cAnA=;
        b=NVGLQFwBIhyRu6VYbVAbm5tJ2FACVSpaODeAqnkHkftZnHv/hNbstWyuJNU90/44SJ
         179FJECwlWIzc0RLeccaLJqkg/jjQahgncm3OS8BtNfZ29QO6kY+dY7HnhUB5ooNvTz2
         5OA98tXAG2dcqck1KPuL3NbAIOyM5Cm9pnzs0CGx/zFTAWrIBUU+to1dOL6+G/SLjrpm
         oRMqWZ/7mDX4ScMQDF4QtTMtV0IbUTVjGeuXz6pdr3WQ9e9kpa61976up9FXLX0wS1+b
         4keDvu+OA3084Aw5w1HTdrghI51XQMfFgwC6KV5oenbsfiXa6a5KhFdUSVnUSsvUVZHt
         85vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775274276; x=1775879076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7VGO43VnRAVL9zGAQ9Zlx3k+gPhIb04E0ubKH9cAnA=;
        b=ED293lE8gOiHBFJyHRLrSFYyJMmp8mZeKSnJDPMy04nr5MicV+ZX8Aoqee6bYhbOrW
         vm2pouVgvAdRNVnL5vesEINJZT6gjQmqxdVrdFyOBhZU3ZeoATobubXjKe6hP7ovnzks
         v+++2rj9szY7IZqioQEz6dOvvZRw5EeATRbK5Q9KfbF7FkeiWQXCCHTL5Z5TEIM/k3DK
         U6GNGQrXKhpOYeuNhN9jVojPupunQuiUDIDY0TLc2S6aTY7GwMrn2eW7KUomDDajgDYF
         RlHsYwLTbxIegXa/c9L2eckC+cwo81bQH/hJEES0uhX5m48AnEpyMl+YbM/f8cXkzJbX
         Tvrw==
X-Forwarded-Encrypted: i=1; AJvYcCXje6k/mF9s4PgVsG3/ru+qgsUHRqSzjYbLJwv3aYOujXAMMx3ItHj0RC7faGyA8hodOjLleEOLgUUibAnxK0QC@vger.kernel.org
X-Gm-Message-State: AOJu0YzRECTKFAcTG157RnxRRoiO8bgwe1aFCPL40zInwtPlig/FllJn
	QBBYstcxB6p9DTkPggYsMXdgZ6vNhkGEHboBpgTqRpRmlHOBt6U6VuYodAr/m2syxTZxBFutDv+
	cxShlcoasKg==
X-Received: from dlbur5.prod.google.com ([2002:a05:7022:ea45:b0:12a:c5dd:73f9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:43a8:b0:11b:9b98:aa4b
 with SMTP id a92af1059eb24-12bfb6ec461mr2615000c88.6.1775274275815; Fri, 03
 Apr 2026 20:44:35 -0700 (PDT)
Date: Fri,  3 Apr 2026 20:43:25 -0700
In-Reply-To: <20260404034325.3172592-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403204017.2919994-1-irogers@google.com> <20260404034325.3172592-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404034325.3172592-26-irogers@google.com>
Subject: [PATCH v6 25/25] perf evsel: Don't pass evsel with sample
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

