Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E24266B5A;
	Thu, 13 Feb 2025 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487622; cv=none; b=UJuI4C2XRv7KViydsk3QvokFw7EQ6VjsDOVT+Lsc9MgjAsk/CerTKG81YxyPquBXaVmzELmj6PJb+7FW9Q7tacdol6jJhJ/uPEuEZ7bcdkZSlI+dIds9r9gQ3hMa6b3Q0fLmIIpidY/k/dgt2k+84WKT+MNnrMxZ4e0sOEDhwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487622; c=relaxed/simple;
	bh=A8XyHQ5YgqWUiyI6TKjmZSVKVDEzl5SRC14UPMPAJJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHH2wxqxrBqmw1qKu6l97usFIB4KctiTb4ESCR5ma2WDUMBqf7P95uAyQzx1nAjhIOLFB78KVHZJJGXIFntMwJKjDesOLkmeQCtzjggldton8Xx9c9pT+GAgBrlbLxzUk2/zXuaoUkdUbut9TIEc77H6qoDwlFYIwUIjXbyUuu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXfMJ7xR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXfMJ7xR"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so2123083a91.2;
        Thu, 13 Feb 2025 15:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739487620; x=1740092420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu4dGM1SJKv24SUYwHSLe7ZuUX9YrvzrAdTqGotWDLE=;
        b=dXfMJ7xRQK/rMTeCefjdy6m+3lFQ7WLbRzV2Ni3tkrey0QHV7CrC5CRhwdGG7tyADX
         GvXwbA7UdjJG4VRyAhSVk5jNCYZQyebqJ17WUebaWjnTSUDiM19hh8I9rJAN8ztGrVJq
         G1uEUv9kjAdO0YiJ43jBuzwS4PWVgItSzQUzryVjYzXBEXFhFMxJZs7+LNwSxir1ubMa
         jKTZlOzNe1cMBpmEAcDoYxMCJIqNwMg9kVpqdI1XLW8ueeA6sK3USvBLsfrEc3brzkfx
         JKSfYH3emJ738OoBAPZbKiDGtFanHJqiDUHpUUAcC7V24mAQvgus7TLAjMK7l8NtEt89
         IHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487620; x=1740092420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eu4dGM1SJKv24SUYwHSLe7ZuUX9YrvzrAdTqGotWDLE=;
        b=WPP3fq8oznvNXR53tr/qEyG7jVQEYrzl4tNALAdHjfmI2YNiTMqp8LUmbUwM6806TW
         2njmOglSAeCfz543aYkF7Gc+zVbzZWcciRqpFMsIlpUbY/6ua32PU6XQH1s7EEttVDdY
         f+KdeS/BuffRP0y3zG69ki+jcpPDD2QpdVR2ZtI8Q54GPvdmC4F9uHu8N9acr8cCd4M+
         SulWcQGETVShHSFs7LGVXqt1wH4zqe0rFjX3/2FlA9/woCKxGhEpXBghqTMuF2YmTWxr
         B5h+I32cwVoKbAQschwrrvom1tSzNO8T+JhLwgwXnMPeFw6YpgL4lQzfxPpneAvfQz12
         lp+A==
X-Forwarded-Encrypted: i=1; AJvYcCUtoNXHF8dakJjSrsFXsH6Rd75pUZgJYVm6liP33+81GCVF1jgKt+Bx54ToX891OSFO00MGUvbPqWNb/5E=@vger.kernel.org, AJvYcCWjPqRBX8yWXFl2ls7o+JG4uVi9xTQYTenZlwwBeiuVvBxv+pNVEm1bMh4b+gquRx+3CbW/okxEXQFGHBrmfq9I7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzye4wfVxgKNKTpTd5Rp3t6AGJtD5AhTdpOQc6ou0tpg7zxkqoO
	/eO4lbWSna0rthYUkA76orq0KrXaRWxqiGC1MNIFDqc7k7zos04Q
X-Gm-Gg: ASbGncsPxTnz64FEH4E5aM0Idh2JM7jw9QicIOQWNsfw7zcDRjq8ad5Q2/KkmfwsnTP
	onwg2bDSZDiJ4z027xO6V0ylLu3sFMFVHcOlatEJAqF1pPINKCdXifoopwUKvWp2sCwL6vU4ZAk
	eWDTNsQVGS9B4nXqqeDwFfBfvjAST+SNgEsLchTaCQ5S32T8/OZZWRcuU+092uvodzhNYHVqsPd
	WpnxpVVchjR8Oz6OsC/VSofulZS24sdos9+Hjc8ZFeqjou3i2KAkG9Epv3hED/otlsCWI0BoeGB
	xCpRZF6T31cite4ClSlqd9dehM3nCe76joVd5SonJQkO2U4=
X-Google-Smtp-Source: AGHT+IGW+BaY+KT0cT3H87owpFFd6R5pLw+7uhEWVUtlZCUAPKjS/GVgvV5ChblqDu6QVqaVg9eNig==
X-Received: by 2002:a17:90b:1847:b0:2ee:a583:e616 with SMTP id 98e67ed59e1d1-2fc0e1c6256mr7122076a91.9.1739487620128;
        Thu, 13 Feb 2025 15:00:20 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349210sm17641735ad.11.2025.02.13.15.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:00:19 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v15 05/10] perf evsel: Assemble offcpu samples
Date: Thu, 13 Feb 2025 15:00:04 -0800
Message-ID: <20250213230009.1450907-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213230009.1450907-1-howardchu95@gmail.com>
References: <20250213230009.1450907-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the data in bpf-output samples, to assemble offcpu samples. In
evsel__is_offcpu_event(), Check if sample_type is PERF_SAMPLE_RAW to
support off-cpu sample data created by an older version of perf.

Testing compatibility on offcpu samples collected by perf before this patch series:

See below, the sample_type still uses PERF_SAMPLE_CALLCHAIN

$ perf script --header -i ./perf.data.ptn | grep "event : name = offcpu-time"
 # event : name = offcpu-time, , id = { 237917, 237918, 237919, 237920 }, type = 1 (software), size = 136, config = 0xa (PERF_COUNT_SW_BPF_OUTPUT), { sample_period, sample_freq } = 1, sample_type = IP|TID|TIME|CALLCHAIN|CPU|PERIOD|IDENTIFIER, read_format = ID|LOST, disabled = 1, freq = 1, sample_id_all = 1

The output is correct.

$ perf script -i ./perf.data.ptn | grep offcpu-time
gmain    2173 [000] 18446744069.414584:  100102015 offcpu-time:
NetworkManager     901 [000] 18446744069.414584:    5603579 offcpu-time:
Web Content 1183550 [000] 18446744069.414584:      46278 offcpu-time:
gnome-control-c 2200559 [000] 18446744069.414584: 11998247014 offcpu-time:

And after this patch series:

$ perf script --header -i ./perf.data.off-cpu-v9 | grep "event : name = offcpu-time"
 # event : name = offcpu-time, , id = { 237959, 237960, 237961, 237962 }, type = 1 (software), size = 136, config = 0xa (PERF_COUNT_SW_BPF_OUTPUT), { sample_period, sample_freq } = 1, sample_type = IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER, read_format = ID|LOST, disabled = 1, freq = 1, sample_id_all = 1

perf $ ./perf script -i ./perf.data.off-cpu-v9 | grep offcpu-time
     gnome-shell    1875 [001] 4789616.361225:  100097057 offcpu-time:
     gnome-shell    1875 [001] 4789616.461419:  100107463 offcpu-time:
         firefox 2206821 [002] 4789616.475690:  255257245 offcpu-time:

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-7-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f45d4b44d70d..fcd49f407f52 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1263,7 +1263,8 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 
 bool evsel__is_offcpu_event(struct evsel *evsel)
 {
-	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
+	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT) &&
+	       evsel->core.attr.sample_type & PERF_SAMPLE_RAW;
 }
 
 /*
@@ -2933,6 +2934,35 @@ static inline bool evsel__has_branch_counters(const struct evsel *evsel)
 	return false;
 }
 
+static int __set_offcpu_sample(struct perf_sample *data)
+{
+	u64 *array = data->raw_data;
+	u32 max_size = data->raw_size, *p32;
+	const void *endp = (void *)array + max_size;
+
+	if (array == NULL)
+		return -EFAULT;
+
+	OVERFLOW_CHECK_u64(array);
+	p32 = (void *)array++;
+	data->pid = p32[0];
+	data->tid = p32[1];
+
+	OVERFLOW_CHECK_u64(array);
+	data->period = *array++;
+
+	OVERFLOW_CHECK_u64(array);
+	data->callchain = (struct ip_callchain *)array++;
+	OVERFLOW_CHECK(array, data->callchain->nr * sizeof(u64), max_size);
+	data->ip = data->callchain->ips[1];
+	array += data->callchain->nr;
+
+	OVERFLOW_CHECK_u64(array);
+	data->cgroup = *array;
+
+	return 0;
+}
+
 int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			struct perf_sample *data)
 {
@@ -3287,6 +3317,9 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 	}
 
+	if (evsel__is_offcpu_event(evsel))
+		return __set_offcpu_sample(data);
+
 	return 0;
 }
 
-- 
2.45.2

