Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E778168497;
	Thu, 12 Dec 2024 02:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970298; cv=none; b=Y3Sy9OR0EF3Xjw06MYqeOW+kFCAJJg+1f4mmQMrkaK/xZMKJVTLk3vqvNB2MBVWfumudmPkbj11Xw5aC0JdQyZztDhtaujnAhM2XQ3yDry7QK6primUGmIBv2OtZA+LNcgnMPMBciM99ppKRHFQvbZg1UjKTNIEafXpYHvZ4JXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970298; c=relaxed/simple;
	bh=qS0cOrCuQAGNC6iJUTgJsbjM3SMEBq/GFor1cJW9EjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gl0nCtpvdMIDxhe6gizvgTBW6bOFoJi5IGQGpAZhfAUBZVJNAHwWZ8SQG7daJOQTFcoVmd2Mq0VdnNJ2DoCouOzpG+D2lQQ0vzsqqBexXmHxuE4TJJTuWwmPsbWXDwdCAnP7D4cXRFkfhMWQylwTmcEjzDTvogK8NfiwA0WUz6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2IEzD3S; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2IEzD3S"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so74663a91.2;
        Wed, 11 Dec 2024 18:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733970296; x=1734575096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLwbvn6RlQVfrWwC3KGmGRTCbuyGiAEY+Px29G/ghSE=;
        b=d2IEzD3Sp4lCFkN9ZQRq2d7q/jJYgsWUcjHSLDEa+xDcbb3xxGGc2oCaosT1VKQM2z
         I8P2YWK3n2wAz1AR1C3aC5OScHpG2u+tEsXHGSE6cQqLBInKKROm+wzEdhowZiY5lB3b
         hOReDtH9eLg5ZZ3rjfqcioXuKBm9Jj9a3d91/tVwQWJXdmjbSdUbw9xZuINcBxdLSKW8
         Rpj6iXILkI15v7I5eNiOhGV8Sqn5CLJKq8PVVkXpSBfJLg8h8iHzeTeQl45RShg9F5q+
         lWlQqAo8MGZ4ZBsVH5X/hOnlK3hCBLT6MqZoOBLty27/wVJdUUxqMBMR2R9G9HwnYfpo
         jdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970296; x=1734575096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLwbvn6RlQVfrWwC3KGmGRTCbuyGiAEY+Px29G/ghSE=;
        b=kqoLm5OaF/5mC47pnDTQNLCBsOU8Ql2pfLZc75P5AMUSSTPoHa9cqOQzf9ZUVqwBk4
         5ABz0rvDJeqdvvsObHzgtvvZYkrffOOYTt9ufDZFR+rqvg0patds/vvNelo3nMB6019d
         Cq1KfXN9akObkLNI9uzwSkmc6jt+flrET2SbQ7D9efA74ZNvGyDAofQNNchhHhfdtKuf
         psRfVif7mQ9g0g6BEk5UKK2IhNnuHL4OGukku1DVCbb/AqiPOR7iRptGSMwseCo9Mk+x
         USuAAPgvVMdfCoCyZEE0Hv0mVNeEhoH2lCXR1nKvxPSiuefPPM1aXqh9dpGXGmnYkKV+
         FhVw==
X-Forwarded-Encrypted: i=1; AJvYcCU3qVx8gUjHvBBY34xlWzo1TvljFV+L3hp+91Rlq3O+BsSVrCMtzoQ8TDxA2lOQ8DAqzclew7XV7zhuMxKgjcTYjQ==@vger.kernel.org, AJvYcCVjEwREbALiAVytnHSL8bAwV0JzavkpAsAUND63IxXh07/kIWpcf7VcoRzZcgvgKEGW8vTmewviktRfwKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybMvVQpF/+LjGRJ2/dXHt4qK8roCVSgaNFp8dOchcR6rpUGSO1
	0OWwKGmdfbgYenwm5Agt+xVeUZkic/4EzzuvZhFIZDtn5r+UQp85
X-Gm-Gg: ASbGncuiSRivmw56g9GUZvwJZzbKV9xYE2FBY6MGjD4J3+486IPBoSRshr6Fn7+eqBU
	3Lff2RKNsyMXwINxQYCbU34iGWbPQjncV8J/DKLDS/e1PHPbuDPbj2dgPRJSz2iKrpZZeR9c7yq
	AYYci//KujIbdzHjW1y9j5gWh4ZJf2pJT/8OAKnQcnpSq9tWHDA36jSpoQKaiZc4zcAhp7xEshb
	QXuijTLhZTAU+pzg5/efNPF6M6a/+qwjvszVtaiNZF4rSSyGN0uXsqsL7zlbDylJSjyoTlt6psE
	TDLpexVgSBwz
X-Google-Smtp-Source: AGHT+IFEYpJwuYNcHuEdAd5hBIXCKiR0yxS3z/KkRBIcZdCQS+7EkGEfb17R8LRX3lzU93ieeFkKbQ==
X-Received: by 2002:a17:90b:3d0b:b0:2ea:4a6b:79d1 with SMTP id 98e67ed59e1d1-2f139293f4bmr3314874a91.11.1733970296450;
        Wed, 11 Dec 2024 18:24:56 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm112583a91.12.2024.12.11.18.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:24:56 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v12 05/10] perf evsel: Assemble offcpu samples
Date: Wed, 11 Dec 2024 18:24:15 -0800
Message-ID: <20241212022420.1035999-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212022420.1035999-1-howardchu95@gmail.com>
References: <20241212022420.1035999-1-howardchu95@gmail.com>
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
index d0f2d9e8ce6c..e3e352e91c89 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1244,7 +1244,8 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 
 bool evsel__is_offcpu_event(struct evsel *evsel)
 {
-	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
+	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT) &&
+	       evsel->core.attr.sample_type & PERF_SAMPLE_RAW;
 }
 
 /*
@@ -2846,6 +2847,35 @@ static inline bool evsel__has_branch_counters(const struct evsel *evsel)
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
@@ -3197,6 +3227,9 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 	}
 
+	if (evsel__is_offcpu_event(evsel))
+		return __set_offcpu_sample(data);
+
 	return 0;
 }
 
-- 
2.43.0

