Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D044F15688C;
	Fri, 22 Nov 2024 04:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250328; cv=none; b=ETTV+D/qdLBzfq2DzLaxn/g6yzKREs7PVGlFTel1npV55tEYRYhB8i7IW2TDOkBvB6AWS3KyzOzyM8vdU/TJOPxt4XoA625rCMhkDSTbtgQTzsH+zSLotzs3XbykEPRysW+2T6Blv/T8ajQ6VsrrVnRvBy/x4IzvSiO2ID77G+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250328; c=relaxed/simple;
	bh=ZMUyrpoRvBaFb7l+97Ql8XtqR55copvH+5CmlUDTTfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jz4ZxT5RdJkXDElz6MBftk4ZvjMcTo1G9Vfs++SeVdpg+HRLQqR0OiNy63BHUa9T8Qg/zmgjulwrrkJomOwnsokXSYmpA/zhae7Up0RAqxT5F3ye2mtTe5r5VtOAwxSZgvbx4pcqdnU38lOTAjVPrh0MKAZS38kitu41jHWe8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBfiYSnA; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBfiYSnA"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1334942a12.3;
        Thu, 21 Nov 2024 20:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732250326; x=1732855126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tlVPJG6c2iOy9djXpDowD5/zOoImGMk2kTxgQTN4OM=;
        b=LBfiYSnALpuUcMoBGVKtC4fHVzIqqUUHO7uEWZe2kVcJHzyDvsQ6vwmEloKmIgl5tU
         mgg59j+x7vcnxuIF6VsSgQdE0p0PKDeFyIwoPgy3mQIjZ4f1bBdN5+euy0mwJtwMsKMp
         9Nsu088Hnbo+5WR7J/O4XreA6/Nda8Bp8iLW0l67SQr3G4wXPNcuk0aG0GEFqumDbsoG
         tHb8eMw4BDUrLKnVF8iosDvq07wl2C4jYNz6azAfoJFYUkLAcJkZOb4LBjM3G11tP8aY
         +EU1EpigZArYBI1LhfBGkdcgMmVIjmRJ1DOvqVZkH4cb/9f2/uc6YtRQtTDkesbjQ7o7
         skFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732250326; x=1732855126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tlVPJG6c2iOy9djXpDowD5/zOoImGMk2kTxgQTN4OM=;
        b=J640MO1vcj5yFAI/7uyFAxSu53gvknSjbsxjojXgECe8Fx2xsyHiTOgzJiwwYAicAq
         2+V+2zVIk7V6DxgoGH3wksvju6DOBY10a5KBkJ6DxdshOBjYD07A6Tqwx/zOJdCPOQvy
         dBWdIFbbpDcQ7LV+u1DL1UwxN1yjZz/YupCbeKpbuRHhKFmuuNPyXNRIrkWZgnOUghhC
         dQaRcWjgE6TwMKikrRg+IIclSIPiRXka9+0BO9TCJ9Phgsd2C+O1IISgZLNDDJMNtveX
         cwoiF/keZDvlfwbuRpTT1ujYpFYGIRiSRVOcCOP9kcgMe2cCeVUXPXiYXE4YkeEKvi2x
         de3g==
X-Forwarded-Encrypted: i=1; AJvYcCU9hgnV7ApCoADSO8DRWnrhbbKxt5oVAna8cjF9VSkonFj6DbpXq2ravnJKH+BhSJKXsJ5AzfdstleF5Iqf5lABmg==@vger.kernel.org, AJvYcCVVXqH9Nb5lZLQ39Jdf7rX7IOBCVMyeO3jUTcVMl3RqyZcXaaYu/yQcq7V4KpGa6ybhFanHWan2pqonxRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgnUt3yRM7jx35v6qdYvQUspJEQEkZscjIVBFYLghJ8U5bICz
	94cX0Kjp+TUrNNFBCigz+x5Jfj0OQUM7vUFxoxjoBMAO/1FuyiiV
X-Gm-Gg: ASbGncuDd7JsI0m38/G3FLa656cI6BCrL+crfNOaSPMFyv/hVxmSqnDL5yffqxXfTLJ
	RN/ZjrYdNoghP8HXSfuRtlSAxaL4UEuFmxNbCAGZbWFlighiIQft6pKV3YAdushx3ej2mlIxNZC
	qVw2hJZD+RdyPzy1HkqrkQN5EeEcYCAww8EjPdZqB0/E850CQ5vu3yPYE3klDwPG8IxXAZYypVa
	IDGrA9Y736PrVW8311IsnhHYrpi2DzWOkqrZhNf1fxBbiDy2NK4bLlUEOziEJArZp/LY+R/L35V
	wzeILp16WRE=
X-Google-Smtp-Source: AGHT+IHL30BoFijeNwRxWWqMPTNP/mMD4tXldqdnwcDf6ti7JORGZgB1xWpfHnScJkd7QZxJWYgy9w==
X-Received: by 2002:a05:6a20:9188:b0:1d9:25d4:e8b1 with SMTP id adf61e73a8af0-1e09e4edaf5mr2359047637.25.1732250325999;
        Thu, 21 Nov 2024 20:38:45 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1544bsm6638135ad.193.2024.11.21.20.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 20:38:45 -0800 (PST)
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v9 01/10] perf record --off-cpu: Add --off-cpu-thresh option
Date: Thu, 21 Nov 2024 20:38:31 -0800
Message-ID: <20241122043840.217453-2-howardchu95@gmail.com>
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

Specify the threshold for dumping offcpu samples with --off-cpu-thresh,
the unit is us (microsecond). Default value is 500,000us (500ms, 0.5s).

Example:

  perf record --off-cpu --off-cpu-thresh 400000

The example above collects off-cpu samples whose off-cpu time is longer
than 400,000us

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
index 242223240a08..05c8977983de 100644
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
+	Once a task's off-cpu time reaches this threshold, it generates a
+	direct off-cpu sample.
+
 --setup-filter=<action>::
 	Prepare BPF filter to be used by regular users.  The action should be
 	either "pin" or "unpin".  The filter can be used after it's pinned.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f83252472921..c069000efe5c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3149,6 +3149,28 @@ static int record__parse_mmap_pages(const struct option *opt,
 	return ret;
 }
 
+static int record__parse_off_cpu_thresh(const struct option *opt,
+					const char *str,
+					int unset __maybe_unused)
+{
+	struct record_opts *opts = opt->value;
+	char *endptr;
+	u64 off_cpu_thresh_us;
+
+	if (!str)
+		return -EINVAL;
+
+	off_cpu_thresh_us = strtoull(str, &endptr, 10);
+
+	/* threshold isn't string "0", yet strtoull() returns 0, parsing failed */
+	if (*endptr || (off_cpu_thresh_us == 0 && strcmp(str, "0")))
+		return -EINVAL;
+	else
+		opts->off_cpu_thresh_us = off_cpu_thresh_us;
+
+	return 0;
+}
+
 void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __maybe_unused)
 {
 }
@@ -3342,6 +3364,7 @@ static struct record record = {
 		.ctl_fd              = -1,
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
+		.off_cpu_thresh_us   = OFFCPU_THRESH,
 	},
 };
 
@@ -3564,6 +3587,9 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
 	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
 		   "BPF filter action"),
+	OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "us",
+		     "Dump off-cpu samples if off-cpu time reaches this threshold. The unit is microsecond (default: 500000)",
+		     record__parse_off_cpu_thresh),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index 2dd67c60f211..c6edc0f7c40d 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -16,6 +16,7 @@ struct record_opts;
 			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
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

