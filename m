Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0791F2C5C;
	Wed, 11 Dec 2024 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955943; cv=none; b=osLAPdHUW7vjDEYhMkLxV1ETaalTo8BMhGR4iDAIkGNn70uCJGJNHBICGfe4JL2NuZGeOb+5lkLzVIE5yuZnfbmh1NTRMxNfVL9WzCfDrpuVBHatgs4p8RuJuqkBRAPJ+FkV/C2RWeMmKYDT/8tHV+M5M2i15dj99dDaVF0eJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955943; c=relaxed/simple;
	bh=qS0cOrCuQAGNC6iJUTgJsbjM3SMEBq/GFor1cJW9EjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gz548pnETFORmeK3aK+psL2nMUPycypEFQbsFpl9Fz989Kd0ZpA5EYV7FBxDGOh7JcPVVsrEn6wENJHcEEZ5my/J9g0/6angoXnZS5yTW5imhpN2Mir9sqS9q3TriUPbNUsZfTwKTwPCAbFOc85RGutENWVknGoziILU7LC/q+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/BPts+R; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/BPts+R"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so17233a12.0;
        Wed, 11 Dec 2024 14:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733955941; x=1734560741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLwbvn6RlQVfrWwC3KGmGRTCbuyGiAEY+Px29G/ghSE=;
        b=A/BPts+RH/DrDLMEeCRLGmuccats6L/u3D6sUKb2RjYZg0qxpxgBfOlkgGVN9qBazY
         JFhOBnAB649y5ShonT37C3U1XoySm0NdI0PVKIjo6QXFwkfeMSgHXV8lRy2SSqfgRNTm
         K1U/WsDuEhTD3Lb6PXkhcfSgwoC2T4aeVdW9oIuNS/RodMaIHYmqmTm0no7+Fzd30bcn
         ghuLY6Mzm4pFijfdE1MhLa2wDcygBPFKeW5WGDjBeVWFWhj+yDIC8riyq1ipROn0psZE
         z/NqeGHs9T3zqHTIyYVeoCaU8ArEsCQNfh2JVMc1Tlvt7acQUm5929ZKVsQlehIAWJIX
         KplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955941; x=1734560741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLwbvn6RlQVfrWwC3KGmGRTCbuyGiAEY+Px29G/ghSE=;
        b=lyfWy6tmPGqzqvntcMx/dOYgqOfofT/xpHaWqtMH0Y9Rl9oGKrVPJL6j0CTNwRaNvy
         XN6uPZ3KsrkcT6QEwqGqM/REm5+/brhrCbNaF1ryefksnx53tG/NBbsMa/Akd72H9KF9
         LEOrfa7L6ig8radljDbCK2hEs9KFjWUB4Owpj74cyBpB9GxYtd64yXdnVT5Dh9tf88ei
         wjtwugrqUSb56CFvvKtK4HboMlYBwTjuBURnyGzMwnHcq8q5s3xBCbFRY7vtVKqyhROg
         6uRGDVpJwzLNPxeGGFnSW1yCEPZIwxqc/WjTr3oJK0kLe3jcflhQtaQMwdAJW6hxmTHm
         mKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIyunrd6ff8ydljFCApc/nNDLyCQ55ZdXrNOdZHp5ysS1AOoIiYul00rLbxg04xKgy68pJf5MofYeLk7s=@vger.kernel.org, AJvYcCXaSLr+6GsDvtZFxLduUfA33xMRkkqWbjDPAT2aE9FhOJdTZgdyzi0w5gDWvi/ZcHlCmxY8l1R+2Ks/B4UiDa+5dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ9SFfSSUznIXm5pzWt2412/Tp3c//wTpz1dpd6Ctfk/NjLG1Q
	9PoTQMnpnzuSNN+FLUcUKllGVeH2OHtPVFJlBF5S6yKM3ZLsyBV9
X-Gm-Gg: ASbGnctKGWirr3ch1gsBqwT0JzLN1O4l1cEhu5EY4BWVU7Dx/IiC+rG+7KRMOi3eUpl
	6RC9XCc8rSNjAta2TxluzL3vUU3tbBOl//5NvTTe+6Llnh+7AqPe20hM3Zmxm29NfkgRN0Qu+uy
	TowGJOPteH8xf7h3K8hIEn9NGibp3upDZWGIOJatwAsewocqh6RPiXpPgMJPw2SvslKmZf4vnja
	ogrVe02tlwzek/4GrFfAd1qjBcHavSmVt+Cxf4KOdCo/TnhzsJW/CoRdKq/k3y1nGk+UprXdxmo
	GhPPl/puhg==
X-Google-Smtp-Source: AGHT+IEnjKy0/8OV64jLBjzlLxfQzWsMGBkJXXzexL0UnyzqQw80mDCr0El+iSfR/iS1zkv5gt5yOw==
X-Received: by 2002:a17:90b:1a86:b0:2ee:d193:f3d5 with SMTP id 98e67ed59e1d1-2f13925b0d7mr2688220a91.7.1733955940876;
        Wed, 11 Dec 2024 14:25:40 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef6d1fd68asm11241561a91.36.2024.12.11.14.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:25:40 -0800 (PST)
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
Subject: [PATCH v11 05/10] perf evsel: Assemble offcpu samples
Date: Wed, 11 Dec 2024 14:25:23 -0800
Message-ID: <20241211222528.945590-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211222528.945590-1-howardchu95@gmail.com>
References: <20241211222528.945590-1-howardchu95@gmail.com>
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

