Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702361DF735;
	Thu, 12 Dec 2024 23:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046052; cv=none; b=f2yGGtv+/vSr2kA+2KKFU8jmg/eb8BUV5Jz6Z6VukD6bd9ndo7Jo6aKElaSJaaWW/MpObh0puWBqdmmCEeN6Q/4te1dJO4BQisNThsEAsd3OEvWgjmw6G/UD30arWRn5eTxTvC1/xQ+zF9u4LV3rHIv3zn9I9UcD9H05e8J3VkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046052; c=relaxed/simple;
	bh=qS0cOrCuQAGNC6iJUTgJsbjM3SMEBq/GFor1cJW9EjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugIlNt1LoH8OnD3xaE6iNu3yk5/lM+j8+YE4O6BSFdpRF/TTdP7kQQxmzMbdpI8NnXIye/8u9Cj0wb+m2IZ/a6hxzJcLpzWEStk5W0jl55wAmF4Dp/m3zXIlp8vRkLVYcN4Aitr5ZpAaYeCovY3sgfQNxgNyo5E02otx+UVuCOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imOaAyqG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imOaAyqG"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21669fd5c7cso10663595ad.3;
        Thu, 12 Dec 2024 15:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046050; x=1734650850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLwbvn6RlQVfrWwC3KGmGRTCbuyGiAEY+Px29G/ghSE=;
        b=imOaAyqG2T0qaazUVEJMBR1siI2452bE5Owk+NV7E2gFoItWtYSzrZQoMrNX+qniMG
         JVmJIwhHLHl9qiRMbNMAx+2YwhFcshGs0HkRvye5nW1gShqtE7QCm10UHJ40CRe7o8k2
         Jy0CbLHwakIgDwqV81a/Xyqcg30cZtWN7o6rXc0uZiotXuzRL3wMwD6WJFsm/j92DNX7
         QOG08KJ+Dw2GxgX9JTUlsMRaInrgL1JnN4yqGdxqFwHlZ6V+EYfpA+gEzu0+ehdaCxUf
         zDyw8ss1SBrQJn1tFjm6uvTJxIhq0QOXxrEB+YBR1mj0s49hc3CI1g5UiwLFnpWM9dgp
         drsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046050; x=1734650850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLwbvn6RlQVfrWwC3KGmGRTCbuyGiAEY+Px29G/ghSE=;
        b=Ff7UtVlD69iVnlQV+WJIBoTtoNR7cmmRGrQLzqKzRNqWKQtVM356LhQwn/Hpc2Gix0
         mB7ss0mHO210o545HEjIH0QAEChZB0xqEWn9f1tWWH9KDt/vHHcK8JMJ5qSvCqpwGNAU
         7Q5KdWmTuISR7sOiU7PIzwc3KT3vWoEGAlehgvlsGxc+ojPVf/mqjIRIv3o4AWWNfs3E
         SlNwvc9CUlbTLLK3EMHe2fPizB4P22S+txNsUfMz5wvRMdnardddAFZUS2Eta+t/uISS
         ROhphaD+oQ0aJoqYkfQ6Sn0N37zTIDqlfzJHgVurh5tB9yXuQaIx4GI3wF8A8oYPrPqn
         wWHg==
X-Forwarded-Encrypted: i=1; AJvYcCVk+qhj33a0gYvM2QdzDfaRUaPs5vpsEKTNCQpp7Fnr/Xsxp+jHMjqgJutqIm9mWnj/znBqNGygdNQ/R+Q=@vger.kernel.org, AJvYcCXgEQZV0eYEVEeNBwvOcfHweNfkmrDcG5ua0LxQAvAEBUqT/Sm+qI0GFgN9oXSre/hcaTJ49X26jLOzmqDb25ba3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrlQUv09dW1ebQcGDJ3opkNa1Q805vYfgM1pWtJUIJKcTKYvpS
	wMcnozpAafRmBaVyEBRQrjghJXSt931CMKFsfEnfNwS0JDHzc1qJ
X-Gm-Gg: ASbGnct6Kvywl/mAZo1FB52g1WtmGk256TrHI6GSoFoX6sTUdtwCSxChCJ0wwcuqC4U
	dN0kM5QvEjWXc51UxPGcaudpP3dw4BW2QCF7QPC/41dpeUHsalBG92dhRiFIyxN0F0u/MhiU5GH
	zDXWOqBIsGivo2g+2PtPIiafxHo93b0MzZsWOXg8bpEjqlRsK5Yg6QsLAFjh0QCvkbz1qkJnAiP
	K6Fj3zwdr1XbgwKIOiTpvJ/RQjpy8LL3h0cqzNwrVRMppMSxLxXGXn6WBGFoTpcvjeVocIA8qmk
	dam1Y8wA/ygV
X-Google-Smtp-Source: AGHT+IFnkLsqFR+lZnVLsgI1YwL9bb/cgTuwgWM9b6icsut5B67VKs5LyOJQcPcSTp4dPKoO4RNNgg==
X-Received: by 2002:a17:903:41cb:b0:216:393b:23e0 with SMTP id d9443c01a7336-21892a5a683mr7939435ad.36.1734046049224;
        Thu, 12 Dec 2024 15:27:29 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4e202e9asm7324674a12.72.2024.12.12.15.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 15:27:28 -0800 (PST)
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
Subject: [PATCH v13 05/10] perf evsel: Assemble offcpu samples
Date: Thu, 12 Dec 2024 15:27:12 -0800
Message-ID: <20241212232717.232507-6-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212232717.232507-1-howardchu95@gmail.com>
References: <20241212232717.232507-1-howardchu95@gmail.com>
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

