Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55DB1714CB;
	Fri, 22 Nov 2024 04:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250336; cv=none; b=BIzmhEUP3FmWxbgpwi4G0YbVmtahM0SJANJvbukgu8sT1y2+rFad41LtYJaYvSR0RWvNhiJfSpNbVGxhzhsQQCueqsbuis69Rrit8hwKxpoaA7UuphBhxoqN6UmCWEck/WX6ks3ER0i4WeIQph9CcZf/oiU8gqKseKi/3C1M+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250336; c=relaxed/simple;
	bh=fDlu79Z+JpLP6VkGzzSNhkvNzPqx/5aR8Zculu83bq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1efC9cbgm7HDAmpN1Noxyxj1brmxjdPTRfa45C8NOfmdfkw0lsdAJCkd5zTjfKnryFE5z2C5eiQ11O9aHgLd2qMJg/C6uTC3SX+SO/X7xVFq9JGtse8UKPXnFTRcn6dMTJS553jBlfTAPd/nmJ/Xv4uqz6JYmd3/CAO/JLPWIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=np1m7D8u; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="np1m7D8u"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21278f3d547so13655355ad.1;
        Thu, 21 Nov 2024 20:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732250334; x=1732855134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj7FgNlmIDqfkOn9oqIGg3b9ST9EW/2dbnHWahYJAtY=;
        b=np1m7D8uLNAhoVL1UL26Lvsmrg4k2ACouBp26hPt9Tp6YpOy2cm+RRdx+ZTlRYIL78
         PAjHr0qGhN6gm2EwGeR1TIL4FbHCpgBdUix6kyhArAdkYZB0rPL/ta2eMBmmKg2QHw2y
         HDK6TXpZICEEidhGQsEO+qRHY+XMLT7N1qzhUxwFPFLGagSrPQSKrRDXt9H7cEOuX9Jd
         2GVhUKhJ2BNBBXMXsIDXtP1ztTYvZTI4zGD3B1quRTRS4qVNUfAFl+qlO4+9Spt0imgt
         6Zgjvk+oEgujbUN/eYERtzwrv7p1CiEZeo4ui7lffakelJir5ukNiZaviBE2VkAAMU17
         bWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732250334; x=1732855134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj7FgNlmIDqfkOn9oqIGg3b9ST9EW/2dbnHWahYJAtY=;
        b=WXG7B7EArKRLUPzNZ/zTwOB8JqdOt2Mbdp4Ai76OxzkA99x7g8Q+JRq5fezTaTNvdl
         dnWxDjPPVr4/EX9kE1si0g9qIGJDXYRSDkb2L8Xl32uKL+NOENE1DiJVRsMrnfk1S7pp
         SXAat/PNcHHH1qbkt1Ao4qTlEXVTB3U57N+zJjZj9GdPkJ5joUpVKfMoiMVmwD/IzrMF
         CfK+5wjtOQ5l1TQnTA1DNPjccflF9FCfKLGLxuDA7oYh0gMhWSFN7YUcFWHsWHLp6CRQ
         DGFIpeSkeJsbFFy8L/0/5VsL7qSDdBvezTzJIZWvD7B963h2MWZh05/eZkP5ez3kB+Hs
         Gr4w==
X-Forwarded-Encrypted: i=1; AJvYcCWrdz4ndQrqRbgAu1X/LRXYiyo4UN3/E1gwAW/vU/v7FcIN2fuKNhaXwXF+UR3d6MpLpegXZAOUzyZUqouFx2wvug==@vger.kernel.org, AJvYcCXrv6do9zIzPHEcPWhI7lRn7t5I2EI4PU4vKjWa+GuiolCWqMqT7Vyeuan4cuqHqh4lNLJbhyaHpJ6+VEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwHniSR5H14Lblpbt/doxgLdxD8svEJG1hqak4d6YUBPjKvitb
	2ViL7p4gm+qEUKtwVASThxfxZKgU4u822olO5GWa38wF2Neut/Ux
X-Gm-Gg: ASbGncunolvncZjzUd6IDwUwecMhlivCrvSccehWfZSm1vsdLLDednklViUzBonzf46
	IY3hbTJFOjPFnWmP3dKUO9UpjRBoK/O9sDEHRw5mpuLmprse5ZWoue2h51JijdD+JLJkPHthBg1
	jEMFmDYirSvM08ayzaz8NwFGcraKGFPsTf+O9XFjEiVj3KOqBRZEe5hr+mDvQUNzCVellBy9llm
	ogwQ3TsBRlgO5KYllmXo2gKsZkewFCA2yEimRgV+l6QJT3ZrrHt2ItAlo1LKgxI+yFUBnsBtxbQ
	Jt4ANFG9Kqo=
X-Google-Smtp-Source: AGHT+IH112d+7FpaStLKCx/p1fGKn5j/gvILIRpBT64bbX+8DBOrRX4Y1gNS7/3Ko/HjnCu5z+Y8yQ==
X-Received: by 2002:a17:902:f548:b0:211:f6e4:d68f with SMTP id d9443c01a7336-2129f7302d2mr16990245ad.6.1732250333994;
        Thu, 21 Nov 2024 20:38:53 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1544bsm6638135ad.193.2024.11.21.20.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 20:38:53 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 06/10] perf evsel: Assemble offcpu samples
Date: Thu, 21 Nov 2024 20:38:36 -0800
Message-ID: <20241122043840.217453-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122043840.217453-1-howardchu95@gmail.com>
References: <20241122043840.217453-1-howardchu95@gmail.com>
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
index d7a68d450080..e0fd0a3eaa7f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1196,7 +1196,8 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 
 bool evsel__is_offcpu_event(struct evsel *evsel)
 {
-	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
+	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT) &&
+	       evsel->core.attr.sample_type & PERF_SAMPLE_RAW;
 }
 
 /*
@@ -2794,6 +2795,35 @@ static inline bool evsel__has_branch_counters(const struct evsel *evsel)
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
@@ -3145,6 +3175,9 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 	}
 
+	if (evsel__is_offcpu_event(evsel))
+		return __set_offcpu_sample(data);
+
 	return 0;
 }
 
-- 
2.43.0

