Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6256C1F2C46;
	Wed, 11 Dec 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954436; cv=none; b=esBO4AERE1hvG+vm0OkDoqZwlkE+9f3MP5qiFee/cPmFo3eD/20lL220qBYQW8cWOFiD43ssTv0n2Ahws92WJrGjvIWGbwuWWMVllFd/JPGrvOfeYTgQBjVI26mS2wD6MyoBFvcBFUGzYFpcfxwPym17uu4krajZ32wv+Uitutg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954436; c=relaxed/simple;
	bh=qS0cOrCuQAGNC6iJUTgJsbjM3SMEBq/GFor1cJW9EjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHwyugOxHMpXw/osYuCA8ABrasKAVogTR/fx+dzVka0rLCs963aj6S/9dySC6/WyeN3y2RrUvpR2y/QOAFX7gUydXMQygI2WHAy00oZD1qvdhwKRWnwSj66IHAd5gtFjqSlip5Q5WTkZ8Xr6qwhC9GN90JfMKWRZkRDJbY/mbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnFtbLRs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnFtbLRs"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so6174330a91.3;
        Wed, 11 Dec 2024 14:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733954434; x=1734559234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLwbvn6RlQVfrWwC3KGmGRTCbuyGiAEY+Px29G/ghSE=;
        b=CnFtbLRs7mbkEH5A+beBsEU7/4DDBQlsaewBHeUPlm0hGcRthHOhWUx+56Mt1D89sS
         pkaDA94DDEYycEI8Boru20ni+VkuLoB/r3O/JINkn/fWWoQsJBKKkPpDAWWnzzWoBrFV
         IbRmR8lAbVE6mBPMa7fu4J9ciGgGPcIvVqSpwqeSXjHL9hEUxmtekIx0LaOCVeCkZY+0
         Hp1EVukLXyi48uxaMru9lJ5yF1uQJ2qFDK6pGlvgA0Sm5Ul7A7e/O8sP/spSDOo2RRcb
         HEFl/+cNOKd/YSJcY64hBPV5WBOVD75F9JC0KiKVAPmVjvap9WsI1Naa56QaFckCf1aY
         X/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954434; x=1734559234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLwbvn6RlQVfrWwC3KGmGRTCbuyGiAEY+Px29G/ghSE=;
        b=e1iV0ixULlNxZ3BEvPfBVsGCF4vcnyrItDpP7L6MFNP2xFpkLt7idXOUYnA8FKSbzq
         IMxNR9NFsyBD2Zfxh/UM+2VpklHXyhKn2fWIvdRvY+HfxN5DEXJd2sIarD/mUFvGuNmO
         gHft+UdMCdJdj1hjhhSG3icro4V5erVfVX+5D+RkwE61TFNVMn1uChKOmH+q9GOeWc0H
         ng5sIQoDey+/kDe+opMy3xnBcDaaRJnfLttBbNP7UGieeu+emJt4vI8wpA0xRDfWb0wB
         /Usf8ACiFzbRQFwnvLs2ltsgJ1GlV4FBjAKvI4lLwqxmdscR5ExMbUUKEQjFITBsTK6I
         fygw==
X-Forwarded-Encrypted: i=1; AJvYcCU2hRdeLRu6y54mBSz/5vxl3OBVvoK1n0XGKvXMHnZAlbOttpaGTAUB7iQ/Qjm5PmSPp0LzZwUBnUgZLS4=@vger.kernel.org, AJvYcCUByAKPGHh/l5QLEKW+NSgmDYPpB399UGt4j74yx3FEDAkxM1wfftaoTl9ZW6D+RJW1bHGa0vR+t7ySU8fQTMBQ2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxDRf0PVzaIAfWi3fvCV85SCSdL0PgVgqlOvIteeMcTXGzmSZK
	mVxQBMz6CtNE9ABOLsgToUKkG/VwI0mhaNh3oERyCPznxBsHsyp/
X-Gm-Gg: ASbGncurPMzopDCeEIeYZREVvQyw8IDfDMSF+N5fiWqgRUTR2nLhfvdP5gRY38D7GiI
	zJtmQLucqhBaeLaZ5uzDYZclpAKTCVWz2gkd6bG9eRbtK5h+vDBVj+ahtcGYE8uOBzfnILJX9W9
	cwAGid/6lENZXqzU+Dahri1EyGh3FtJ04pWFZSs12YpnfQRA6pgnNFuF+j4GvO9jg8AnAY1btSt
	ynel8o0et12wEePIugCa3V+twpotRlui5gn80Ct6PE64yxdk+fypVPVaZHFeMnvqMXF1PRZNuOJ
	QHHrk/bj+g==
X-Google-Smtp-Source: AGHT+IHXZXobPmFsFepTq3tKAJr3ZQSElAlJ+hjWoppGi6PixxorsUq17k9/JzkBk1d4aVr1kGj5nQ==
X-Received: by 2002:a17:90b:1e4f:b0:2ee:ab29:1482 with SMTP id 98e67ed59e1d1-2f127fb353bmr7928854a91.16.1733954432102;
        Wed, 11 Dec 2024 14:00:32 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700cccasm13912665a91.22.2024.12.11.14.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:00:31 -0800 (PST)
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
Subject: [PATCH v10 05/10] perf evsel: Assemble offcpu samples
Date: Wed, 11 Dec 2024 14:00:09 -0800
Message-ID: <20241211220014.931479-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211220014.931479-1-howardchu95@gmail.com>
References: <20241211220014.931479-1-howardchu95@gmail.com>
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

