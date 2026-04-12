Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348B344D8E
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959779; cv=none; b=T7DKuL81ajgxXitQ+CwYF1N8yYcybURk1Va6igTXYCWTwwPlbKz5/oi/c1dj9m27/Kdu1x/qUqw9ujZjf8GgkcIKWqaSIZSKNep5DgXOFWnghbwuAPaaEqU0kB/LOWBclFsZk63kG3+eRpGax3fNB9LnVLs2ommMYPANE9qEsto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959779; c=relaxed/simple;
	bh=X3d+bv/RmpzHuDPVyAZXrbt4fTvCbWhYts+FzU9xRfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TfL7+6Jx8seHDjnbPq7DxbF6RZZmitw7v2WQulOYUbbLovNZ41B95FROhzvOW1SZ5c0bV0/dyJwTz/SwFnd9farhJfXqegVUiWp9wWl07fvcETodzcR7mUo0R3CeZvj7ajb9NQMyFM/R92Xt5Hrrm4ISYP8toiuSZUPW/vsimzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P/8dIfQs; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/8dIfQs"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-127876be621so2474222c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959777; x=1776564577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fyJqf5DqEvyRM5sRLSS8mIeWVbUiTjGftiY+F4po8Hs=;
        b=P/8dIfQs6Ri3L9y4scTbqHz8YQINdhNXRF3wfCdS9t5VG8H0QCHAqNU2ffXXlYa7GL
         TxuyCUgffPuSzYOyx71fqpxQTt3cS5rs6IUrF5ZF32wx5IX4vE+4Dce2QlBedjwvMwTn
         BurwAVjIhI7Fnh3s2Sp6uEwmAk3iWqDN8YRiCvKymmZ6k3Diwj9fkkKLrbqt0XpFB/4B
         lKx6IhDgeHDbfjl7Uvg5Bwf7XRKWRsW5ODSD46qaGYuPDBKTF8ueNEmh48HSPjT7yqSi
         O/EsbGQpjYbxJvxlpV6eCtEpjL2v9kAM+iVh98Fhw7sSHx7eK9OskzOOD3tyVzRWAUg6
         dFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959777; x=1776564577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyJqf5DqEvyRM5sRLSS8mIeWVbUiTjGftiY+F4po8Hs=;
        b=AYyVuwTNGtUjy1ZrQHcJXiCUHDh+o22A+wvsWBjMPSJzBjJFl7iveBgQlxQWAKz96k
         f+TFwgfF/OBq6/scHBUpHHV4Q+lASCAEdb1OcNjJvlrwkwcr/e6bVGlWTKE6Jaxnz9oO
         em3LsUM6LooH6ALY4x3M9soAr36XpVQR7/Eglw9MPFWQsYmoMOnAl68eLk0Jzv2xNIlP
         fR0C1UciTSyzHgAV6Lw+uit19azec6ajhNIe3azJh9aJFfPYTODHxn4Zt9j4/ZxBMhfs
         xZqh7sElOyRUnB89GAujXaBIc70ND3twYoAMPmT9SczWx9fwuIxGusL1agfYwj1GgGmD
         d1CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJh//w0ohw0puvuLPJrzSoM2PJ9XXsnQbYaYSD+4Sd/c6XpKb2UjcXtyhN4UpFxtUgx2Ku3LJP4Dxzk1np2f5I@vger.kernel.org
X-Gm-Message-State: AOJu0YxFjTGXNfZNwEixw3JVNnDODDOnS4LebnzJfRpE2bSrhKrKSCha
	F4aq4E2z6Gz0b9jm4xbM4Y49Dkf7SIz+OXY/+WvxCGpZvvF9mKg3HOEdBWGAbI6XxFqepzZI3jG
	0xrcDcUgw6Q==
X-Received: from dlbsn14.prod.google.com ([2002:a05:7022:b90e:b0:128:d185:c6ff])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6885:b0:12b:ebf6:a3bc
 with SMTP id a92af1059eb24-12c351a0d3amr3942515c88.3.1775959776709; Sat, 11
 Apr 2026 19:09:36 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:26 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-24-irogers@google.com>
Subject: [PATCH v10 23/29] perf evsel: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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
parsing of the sample is arguably a special case. Add bound checks in
perf_evsel__parse_id_sample by switching to using an index and
checking it doesn't become negative.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 61 +++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ee30e15af054..bb48568b8101 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3003,52 +3003,62 @@ int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
 	return ret;
 }
 
-static int perf_evsel__parse_id_sample(const struct evsel *evsel,
-				       const union perf_event *event,
+static int perf_evsel__parse_id_sample(const union perf_event *event,
 				       struct perf_sample *sample)
 {
+	const struct evsel *evsel = sample->evsel;
 	u64 type = evsel->core.attr.sample_type;
 	const __u64 *array = event->sample.array;
 	bool swapped = evsel->needs_swap;
 	union u64_swap u;
-
-	array += ((event->header.size -
-		   sizeof(event->header)) / sizeof(u64)) - 1;
+	int i = ((event->header.size - sizeof(event->header)) / sizeof(u64)) - 1;
 
 	if (type & PERF_SAMPLE_IDENTIFIER) {
-		sample->id = *array;
-		array--;
+		if (i < 0)
+			return -EFAULT;
+
+		sample->id = array[i--];
 	}
 
 	if (type & PERF_SAMPLE_CPU) {
-		u.val64 = *array;
+		if (i < 0)
+			return -EFAULT;
+
+		u.val64 = array[i--];
 		if (swapped) {
 			/* undo swap of u64, then swap on individual u32s */
 			u.val64 = bswap_64(u.val64);
 			u.val32[0] = bswap_32(u.val32[0]);
 		}
-
 		sample->cpu = u.val32[0];
-		array--;
 	}
 
 	if (type & PERF_SAMPLE_STREAM_ID) {
-		sample->stream_id = *array;
-		array--;
+		if (i < 0)
+			return -EFAULT;
+
+		sample->stream_id = array[i--];
 	}
 
 	if (type & PERF_SAMPLE_ID) {
-		sample->id = *array;
-		array--;
+		if (i < 0)
+			return -EFAULT;
+
+		sample->id = array[i--];
 	}
 
 	if (type & PERF_SAMPLE_TIME) {
-		sample->time = *array;
-		array--;
+		if (i < 0)
+			return -EFAULT;
+
+		sample->time = array[i--];
 	}
 
 	if (type & PERF_SAMPLE_TID) {
-		u.val64 = *array;
+		if (i < 0)
+			return -EFAULT;
+
+		u.val64 = array[i--];
 		if (swapped) {
 			/* undo swap of u64, then swap on individual u32s */
 			u.val64 = bswap_64(u.val64);
@@ -3058,7 +3068,6 @@ static int perf_evsel__parse_id_sample(const struct evsel *evsel,
 
 		sample->pid = u.val32[0];
 		sample->tid = u.val32[1];
-		array--;
 	}
 
 	return 0;
@@ -3244,15 +3253,18 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
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
 
@@ -3614,12 +3626,13 @@ int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 
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

