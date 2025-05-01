Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8B231856;
	Thu,  1 May 2025 02:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066503; cv=none; b=cZQHk45zntApOyj/XZMqAeT7mfiDT5yAV93/0IQ81EQV+l1XUUr2H/TB10v/kI3sq+STarCxvEVJwuJ4iA74p2ymAsfcsMftWD3ZOCvB8hTXuqWj3Z7Zoapzc8ZCjPz+mNNo6nFjTTVMa/4MpPTViKbTirGGgIrhQxuJwMcXL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066503; c=relaxed/simple;
	bh=DOtmYZ08nWeqolCBw1DBGPoZGcMaiKoo2RsbESyGlPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QA5cwb/pFvQpMH40rXFAiE7VhB0fD40pyNbCjHxMGJUMf8eCJ6OMn8Og2ofu0uNAxbRqnjTHrE/NBFglVdUZT/TGfLEths7N4PkhxDA1TP6KzkuPONRuAvkAmfEFe5kfK41fxjO04ICL66JqIONWDlHJ1j8pAZe0r5vM+2lDQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K38yyngw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K38yyngw"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso804069b3a.0;
        Wed, 30 Apr 2025 19:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746066501; x=1746671301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOLcMhRBa8687KTEG0Rm1QPK2LiDeZ9ivT+5m0+6uLw=;
        b=K38yyngwzTak/tfcWkWH26gvZ4vONWgE/6F+Y8zD+3n9KNDzcVozgHhydkqe6qN8yJ
         TAbV7XxUbEwaYGOsb7xgCO6jzZKgFrZ4iz9u+3TviehVSWrqwwM1g4EOVpAq7Kbgycgm
         0+cPFKgXSd8xZpXA1fojkTfZ5slOSdPM15CaHxPdWgmZMFm49Xs1PH9n4An/7lPfxtLN
         m6c71QFRdJNGeceGr7lqNbbVRz+SLSYUNnpQyDlyWTvnnB+sybEzpPBdOavtrX3w9tnK
         QZwZaJ4sWrsuUq22Fj3o7kXzO6zOdOf82k6UrgkWf3AKowr7zu5cmei8hJZpBiZnwakI
         WuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746066501; x=1746671301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOLcMhRBa8687KTEG0Rm1QPK2LiDeZ9ivT+5m0+6uLw=;
        b=JSAVZMbpsOqkV+0Iai1shir7y2ZLj2SqTot5VAKuyQFdMBTKQbqqL6k3qhcLI2+grQ
         zlD5RJHdzrltcy6e0AD2EDMVdkMB74QxtEXOAr2LY6cQ1pYeWs/qG4ANRD9+Al0VroY1
         jYdbDY/IIGcnE+KTPRsT3dSVZp7jZ13k51rBZgOXnBwllElALLFrKsIiw9lRSfGOsfQn
         lM6+c/gGXpfniTBgyZ7gJgWJrnK0ZR5M0q0fX0R3QBEp5HYJMgqY8aIxLKBnT/VVRt6w
         gl96mWDzgd503sqdIJvaGJOiO6DZUdVOU2BSeg1PsNsefEMMrTu35rRs3kcJe/TLP8ME
         avMA==
X-Forwarded-Encrypted: i=1; AJvYcCVrtmjzXuBvnVd2cy5+XibiyPZieC97HFHAavK4CVzBW0NmRUYeprMQewYRsIw6rnO/TcTeyEU+x8nYcqg=@vger.kernel.org, AJvYcCXRoKl/Ckg3eysGNu7/xxe/NvvZN0O/sI1nL0zjq+f9I6kaIhrcJgBqNGp92vxZJthy+juGAYKRO7jkAvIMN3dllA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzst7YhFTgNTMr5Y3Co4DMJozGNXDBd6+54M+lt5A70p62FEmn8
	7kAx1RI2ri1N3r6pC7cseHex8+xxXfKtVAbAwLiFMHRselrojsHsLUeI8m7Ogq4=
X-Gm-Gg: ASbGncvhQwQOUr+Est0jXunllwWMdSjKgCMttxLbxPrjat64HDGu2XzIwyTsRZI9z+a
	uTNUPnyg5DlpM3EOoScaoVseDouJRFNegj+2n2BjCrj2Ks0zuSM8z9PcWCWc1m8YaNrkE6EFshh
	mw8CCVYgjoIaDSci6QC1EEWdG53dC+KoFtNGKzkg5nPsAZ0O7zuIprl0WlW3lXwqNKuUnNw47pw
	ZcKAOuh96c4NXeUFlqkrJks3QQ4XnsLZ7C8ph8YTq2vHxy3Bck3KZzI5qTqEjxnYtrmA0JHXK5Y
	xKtYl3CcvIKCnQwyux4CLi7U2viwdyanIondbM+Q3WHPrUL9IxMvjFoNWSMpjopBqBbsLRA5uWC
	qPpo48+teuQ==
X-Google-Smtp-Source: AGHT+IGwoFq1spxsTGSX9ojzlcdbQ7wa+yn2JHsmbQO8RCRg+bgIYAPQPuy0Fo2mPoZTnruJNEN6gA==
X-Received: by 2002:a05:6a00:3a09:b0:736:3e50:bfec with SMTP id d2e1a72fcca58-7404777ecd5mr2154034b3a.8.1746066501236;
        Wed, 30 Apr 2025 19:28:21 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a8fbe7sm2459599b3a.160.2025.04.30.19.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 19:28:20 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gautam@linux.ibm.com,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v16 05/10] perf evsel: Assemble offcpu samples
Date: Wed, 30 Apr 2025 19:28:03 -0700
Message-ID: <20250501022809.449767-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250501022809.449767-1-howardchu95@gmail.com>
References: <20250501022809.449767-1-howardchu95@gmail.com>
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

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
index ea6b1ff16e6d..22a1c5b26fb0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1277,7 +1277,8 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 
 bool evsel__is_offcpu_event(struct evsel *evsel)
 {
-	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
+	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT) &&
+	       evsel->core.attr.sample_type & PERF_SAMPLE_RAW;
 }
 
 /*
@@ -2923,6 +2924,35 @@ static inline bool evsel__has_branch_counters(const struct evsel *evsel)
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
@@ -3277,6 +3307,9 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 	}
 
+	if (evsel__is_offcpu_event(evsel))
+		return __set_offcpu_sample(data);
+
 	return 0;
 }
 
-- 
2.45.2

