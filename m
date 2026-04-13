Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4F26059D
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043403; cv=none; b=Q2S776HbsvcueM0gIWYTQXO1yH3Bq51ePz41Ql6PW9jIASgUudNh7kjd+lRY1ZPwFfD6OkjLUUNtnC9PYue3mxZLq0+mEzI26p87Q+E7v2SARiKHhK1uv8VMmVjumaieSiH/NNXeYUAgwdLDbAijGsCuLDHcfHeMDxKRN0YjzRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043403; c=relaxed/simple;
	bh=X3d+bv/RmpzHuDPVyAZXrbt4fTvCbWhYts+FzU9xRfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gqU2yvGmtYCzIbYwaj2WtA0oDiZ1SE+TGPSt6sHWjsonOKYDgjTFoIVPq7QHztjmfA9pnA1JjrOB55dtwHgN8Ag5TIZtNC09aaTrUw+vEqFgrTdoiGF5GAYkG7yBvUNuyY0L8tsTw52rosNGmJAejreaUEnKchqG7Q7TGZE5hpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KqaW+ypB; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KqaW+ypB"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d889997495so2295744eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043400; x=1776648200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fyJqf5DqEvyRM5sRLSS8mIeWVbUiTjGftiY+F4po8Hs=;
        b=KqaW+ypBr+o5n7pSfatbkxjwC/J+oO1OXydfRb7PVUPzuPFWXjdEQqd6Zp+PyjQIno
         uxf69B5Yd51u/6a5l+GQZT9ngyUZkPEolUM0Yi3eg27mr0KAF2/QOd19adXugz8Cy4gB
         ZbCjVFWu4ZqjjiKXlA6Utaq3vBQhNQhb28ASkWbmOsO+rWv2kGN+LK/7uEqjY0oW4jYG
         kNu5rF5O1KdmyJYuBxIYV7i8k04ydpfstxiEu86/PRuqiaunQZ2jtI6ulUwMfoze6mD8
         D1XxM0PoA00+qQEfv0UYyDwj+2X0J8j2UeTxQq+ppJbR0zqrHlcv62bEQjbXGmoHRXcW
         IL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043400; x=1776648200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyJqf5DqEvyRM5sRLSS8mIeWVbUiTjGftiY+F4po8Hs=;
        b=AXggIrqdBI5SpivJCcK0afJ78t37b1itXwKzmZdu8Hdqz6bK8Mz+VajOtXBAWo6jX7
         hHPktbrgDxhYrWUADaW9EZ8zlvYNvfvDbSjXud2AboRU/waxdJOhdfuBHplfq+ZUnG2n
         LOV5UCYIeJ24pDU6VfSQC2pP8dgh6H0dorZsfR/+2NYnRCqq91vpz0cPH9prfUVevlQG
         AHUzOZmbtK9JZtkVCq1pOXliqiPgor9tlDxOcqkKRLMFla7B54xRj4CfBLAgqm0JS8Sq
         VPpN4NVMV7kMeGO9xnCCVoAgscg18sTjfDPKiHW6fKL4d88MnDmeorth0Qdbe3W5LZpz
         NFUA==
X-Forwarded-Encrypted: i=1; AFNElJ/Fn3ep5fxE11jCS/imisu5Ott3p4OAYlPmCOgZbrwNs+KqKmWObgF8I3l+nqT8sBOVn9c+hKjVLzv2iibC2wZ3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xe9ab6zlfg+YMnRThGdveDfshutXp3Hf+9k95df1DSL2hDsz
	dVIlhN3D5CBN1Q1H3DSaKMrqnVWaX/ZOKYZnw4jMuknhyHdRhVT6lUeRupVWkwWq1N+H294SXXO
	1C3+e+/Egjg==
X-Received: from dyclx4.prod.google.com ([2002:a05:693c:2184:b0:2d1:f2ee:2849])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:df05:b0:2d2:d7b7:5c70
 with SMTP id 5a478bee46e88-2d5881b0358mr7559771eec.15.1776043399642; Sun, 12
 Apr 2026 18:23:19 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:16 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-23-irogers@google.com>
Subject: [PATCH v11 22/33] perf evsel: Don't pass evsel with sample
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

