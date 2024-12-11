Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2181F4E48;
	Wed, 11 Dec 2024 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955949; cv=none; b=ZmxfDSWLcK7QiJoBphET6ZNWvR8EvmtryL1WmGZN0UmaTadgcx2lG1GR2pG2NY+Yus52IVhnVlA2jIgm4plBefZKWRrAs3aXTryGSuWkHq1xxFdyG0fo4Xyio7Xj5a+oVTDPHvTnCpTYWfyaLNpV8nlKHzENC1bmrZEgWZNzlvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955949; c=relaxed/simple;
	bh=foSgLTZyTs4SVotNFY43ppSIAy4gTLpyUpH0qpfuhUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=au6AI8BMs2bXNcfzou651KJ8+IxB4959tWpR/EBp/WjQJhDzDhVohPiU1BnuvntyI2y6zwg1PlpP3XM2DUlQrntIyO6ax/9B+cR6xaixSEfzjETuQVtlhv+M/z9JgNpw3i7XH/nwcb8L+ewru1UGj4xKAsiUhAivEDq9CS36rU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BifEZXQ4; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BifEZXQ4"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso3856a12.3;
        Wed, 11 Dec 2024 14:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733955947; x=1734560747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4lb0Q0vjscdmvfAbqYffPP3ZGMItoDtlGIbQQlVEN4=;
        b=BifEZXQ4wSRshYTuixxfmF1vzXInI37SPiaJ3r4SDXJ6k7Tm9d5v+L3/U0HJFYQW7u
         hnRz2522SYYoPQLlKpgajHKjdx8mGVVS4TaK/S2lgUohpgVWFx8V1HkQP9GPFZ5q9po7
         f13+z4nq5sIwPt9SJrlsuMTGR5YGuCSGLrhibvlbAIt12FgRrxDeU/8COq7tBarB3yb8
         nMt97WGBaBJdcA0RWsJ8S7pgzyn2h+8PYw8UI9xO1ms2uTqFA4q303geAN0c6QJW2+lj
         gbaiK8jxUxD2HgT5f2cOzsPvkCPS4AdJJbaAbWO6lglEiyJCpbcSecMZrPgvKhweWo/U
         n9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955947; x=1734560747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4lb0Q0vjscdmvfAbqYffPP3ZGMItoDtlGIbQQlVEN4=;
        b=cCxr/CyPOJzIKD7jh+ghxLl+uigQbelS8Qe/R4Bw3J17EjPoijx5YvY1+usB9OpiBZ
         I+BTMK4coAFxG8R/3yVcKVyjjUSCwF1F/weqLw4kJBU51H+T4TALgdhZP0P/72G0RJBN
         1dLPu5IH0KRS1cjROySoIDKI/Ce1aKDQJDDGvucHfdPg47nUdMu5TjNDyoLnDhRpT2sU
         +iONAUStUH+Cmyf5FwD8oYSvdNjxHRQ8VdV25MgYfrETc2msRvFsCDESnTX+4bvIcSy6
         2ryJn7wlxmfpFRdAMi6QbvtO+rAXm9bs3UhPlK0sUoimX6wPIs3DqxR3Pq3AV8bQaL58
         +NFw==
X-Forwarded-Encrypted: i=1; AJvYcCUwoaUt14DbNrDmWwkoOBekR5UWRu/rOWeLXA7FJd14jQxkMj+GsSKLims+TfCLwYqQgddqI4h6kTWhQHE=@vger.kernel.org, AJvYcCV1FNtP4QR9GHIXjWus8LJBAJlHkYRP0ZTH00YCr4v5csdx5IXOeCabMrj/Pg8pzNrxlpVUxDp7Au7o0zPnOsav2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlYhBrvMIKn3ozirmp8KB/vZeQPy5sHeKDBrhbzNNk+wdIIemY
	ymsOV9pshH5aOwFfw4DhQ6xn/ewxBo9Gxk2REvGYljqVLxbQI5Ac
X-Gm-Gg: ASbGncs/C1yEsowJt+fSEw2jf0pPzCepaFEwbk5P5LksPTnKOPMg6UsDY/l8sgubjFn
	lIY5IOiqebVBMUjHnGLextONXXiELTOXSP80qYGiDJpfz/YrKYr4CWSFDDtBUBIDWe/u4LiT2U7
	wTQoy72E5DOQRU34G7MGJ1Z90j+iEx2IWZh2cONmK0p6HRiMVki8R2XhGaiTm+UfTyfGmiPuui4
	8SRZCWAPv1NqEDog/YSY+r/dZxArzLC3FjYwhGqJqmkxG5xyjib9xC9KIhe6liXsf0omIIEIzy1
	FV1pYMSuIg==
X-Google-Smtp-Source: AGHT+IEQR+TrSIMN1+lFgTdMrU158AQekRti9afO/P/19O8IjxAZYsGm0151dIU5v1t5dGtz6JkaFg==
X-Received: by 2002:a17:90b:3e89:b0:2ee:6e22:bfd0 with SMTP id 98e67ed59e1d1-2f127fdbf24mr6186031a91.21.1733955947399;
        Wed, 11 Dec 2024 14:25:47 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef6d1fd68asm11241561a91.36.2024.12.11.14.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:25:47 -0800 (PST)
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v11 09/10] perf record --off-cpu: Add --off-cpu-thresh option
Date: Wed, 11 Dec 2024 14:25:27 -0800
Message-ID: <20241211222528.945590-10-howardchu95@gmail.com>
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

Specify the threshold for dumping offcpu samples with --off-cpu-thresh,
the unit is milliseconds. The default value is 500ms.

Example:

  perf record --off-cpu --off-cpu-thresh 824

The example above collects off-cpu samples where the off-cpu time is
longer than 824ms

Suggested-by: Ian Rogers <irogers@google.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-2-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt |  9 ++++++++
 tools/perf/builtin-record.c              | 26 ++++++++++++++++++++++++
 tools/perf/util/off_cpu.h                |  1 +
 tools/perf/util/record.h                 |  1 +
 4 files changed, 37 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 242223240a08..f3ac4c739d5f 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -829,6 +829,15 @@ filtered through the mask provided by -C option.
 	only, as of now.  So the applications built without the frame
 	pointer might see bogus addresses.
 
+	off-cpu profiling consists two types of samples: direct samples, which
+	share the same behavior as regular samples, and the accumulated
+	samples, stored in BPF stack trace map, presented after all the regular
+	samples.
+
+--off-cpu-thresh::
+	Once a task's off-cpu time reaches this threshold (in milliseconds), it
+	generates a direct off-cpu sample. The default is 500ms.
+
 --setup-filter=<action>::
 	Prepare BPF filter to be used by regular users.  The action should be
 	either "pin" or "unpin".  The filter can be used after it's pinned.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0b637cea4850..4d0d9e36a421 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3147,6 +3147,28 @@ static int record__parse_mmap_pages(const struct option *opt,
 	return ret;
 }
 
+static int record__parse_off_cpu_thresh(const struct option *opt,
+					const char *str,
+					int unset __maybe_unused)
+{
+	struct record_opts *opts = opt->value;
+	char *endptr;
+	u64 off_cpu_thresh_ms; // converted to us for potential future improvements
+
+	if (!str)
+		return -EINVAL;
+
+	off_cpu_thresh_ms = strtoull(str, &endptr, 10);
+
+	/* the threshold isn't string "0", yet strtoull() returns 0, parsing failed */
+	if (*endptr || (off_cpu_thresh_ms == 0 && strcmp(str, "0")))
+		return -EINVAL;
+	else
+		opts->off_cpu_thresh_us = off_cpu_thresh_ms * 1000;
+
+	return 0;
+}
+
 void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __maybe_unused)
 {
 }
@@ -3340,6 +3362,7 @@ static struct record record = {
 		.ctl_fd              = -1,
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
+		.off_cpu_thresh_us   = OFFCPU_THRESH,
 	},
 };
 
@@ -3562,6 +3585,9 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
 	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
 		   "BPF filter action"),
+	OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "ms",
+		     "Dump off-cpu samples if off-cpu time exceeds this threshold (in milliseconds). (Default: 500ms)",
+		     record__parse_off_cpu_thresh),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index 2a4b7f9b2c4c..f07ab2e36317 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -16,6 +16,7 @@ struct record_opts;
 			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_RAW | \
 			      PERF_SAMPLE_CGROUP)
 
+#define OFFCPU_THRESH 500000ull
 
 #ifdef HAVE_BPF_SKEL
 int off_cpu_prepare(struct evlist *evlist, struct target *target,
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index a6566134e09e..2ca74add26c0 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -79,6 +79,7 @@ struct record_opts {
 	int	      synth;
 	int	      threads_spec;
 	const char    *threads_user_spec;
+	u64	      off_cpu_thresh_us;
 };
 
 extern const char * const *record_usage;
-- 
2.43.0

