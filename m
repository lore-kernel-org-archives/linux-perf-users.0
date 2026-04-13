Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9637E2E7
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053573; cv=none; b=t9NFdEhdCedvNACIbO/5uOru8g9pbRE5td+bHUjq7ekfne/aiL7in6SRb/7gxp3zjJQPthTwpP/BoOClDuEZkqunH6CTN18JKEqp4kqJnUxV5MrbUDAFyrMZ+Ukmk8NKJpf8mEUMrU4Pys9dtm4AJWeVISWjO57iIavmjTwmdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053573; c=relaxed/simple;
	bh=X3d+bv/RmpzHuDPVyAZXrbt4fTvCbWhYts+FzU9xRfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=myJkNFcQP5H9GDFNFE+GqrWAH3nddJ5GLdwIKU2coTeFxfuu9vJJoJNiJP3qs4Nv6a3Mf+A62Wyc+2Z3z1+cbXaGNvY2U+fgLW1Dx32xpfCDfRDa+MNgj3jki5o3tG+8NKuC+xz3NpUjUs435vmtLlCVwcERjEX1tOVe5P3dtJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXsKwcme; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXsKwcme"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d93379001eso1541860eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053567; x=1776658367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fyJqf5DqEvyRM5sRLSS8mIeWVbUiTjGftiY+F4po8Hs=;
        b=VXsKwcme8XUHh78tw2vU8/AvVpk95hwbVkI6vXqutjlNoqlHMGGcFlxJi/FrM0y5l0
         0sy+ucHO57Tpj4XZ+SJpQLiw5SCNy6Y8RT4d63fOgAhbyqfMUqu6bYksqADYCyQV7lb3
         W4jx6cs+JrvBXmbRr62GlbrUiDOg5rARETn44gc+v87VvL5lXLiwhNP16zZLozflK/S8
         f4bW3aM52eK2uTD4ME+z/qBmE79h8IS1/6xKtM23M5s/Ihqac4I0syA8szwq5NTeqDVz
         QjHoSYAceEgONj8bAhQQUzuEegSk7zNT9Hi0pZUqgN841ZI1g3ujaSTmJlKlXuzBz8OQ
         bUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053567; x=1776658367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyJqf5DqEvyRM5sRLSS8mIeWVbUiTjGftiY+F4po8Hs=;
        b=HPAoYKSo5Nqh2Vq0WnvKNIeYlzIBporD6k7/XQSNTHA9USoSObFKHjUKxfZ14mBDJD
         XUJ6Z0jRlnrq4hEototiWP+AwUvVimeCokmjINIJR16OEoKvrkXY3pjF+yuz3mpgTQCq
         ro3gMmCQnapKKMaT/uqH2aE9ct349nhPrpjRqIHYtYp6gfeP7E2wnDpmb7l4tEvVOo4F
         8K5P9PjT3FbeFOGm6giostd9/MYIPz5M53PbON2RIT2jzqC6pHpB0oIUrIqYvj8IEeLi
         eFvneyamfHt4CZicL1wThrWf5OoNVBr79up/9cQLMAZi7nLpDPGK7rFsMc8h6+6I1XZr
         rT4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+d/H5+bn6jtgSDUkIuN7IGOfnEURgxf2EsVrao6BSpgSVkKdWOCOwCWtXxdtd2F9yuSyDRj2bAihflWfHXvHsU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9da4+HqfdxDvTTPZwRwUzOiaMOxwxnaMSZqixx0hRdTdZy3qa
	a6cEFnKHRmEeP/Hy6Vobuzx8SIKlEYCCD5Qdp4Dhll8noZIo+s0oo9XtYoThtIMvsqTuzYIwZpJ
	2brNH+c3kcg==
X-Received: from dycoz1.prod.google.com ([2002:a05:7301:fc81:b0:2d9:1564:c80c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3212:b0:2d9:94b4:a1c7
 with SMTP id 5a478bee46e88-2d994b4b427mr674902eec.15.1776053567147; Sun, 12
 Apr 2026 21:12:47 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:32 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-23-irogers@google.com>
Subject: [PATCH v12 22/33] perf evsel: Don't pass evsel with sample
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

