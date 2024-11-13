Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024445661;
	Wed, 13 Nov 2024 00:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457705; cv=none; b=dOmZOpksz7L4egZmmBJCalTz//ArLPqV7vmOeVTWPMH4eMmCPjVaA7BhMz1mlI/KuZBXKzPrKr3Wwc/bke8MkAHMIYKbn67M2f7oTAAJZQBPc0kg8wGDtnwMEp6BDLE3b3RTL63v67AYborXuWMRkdgu4sGMzrMvX0p43ZAzLtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457705; c=relaxed/simple;
	bh=3vwXpoLqH4tgEDR/6BEKnB6KYg193amWFuZtazpLuE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXEESjmp51L3wasapUi+dhv76NUq1pAUUoVrGp6dBxcSRRxT6+n7s5yg+OdWKsgVkmPniwFwPtePjMv9rlb3ASmbFp/RhecmlXQHDin+sGtmK+EjIokcDYTDqWNKME1oICdZxEEBhivY5JdRRwM8EZoo4EOv/UaMjURmrcAH0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzRlOe2B; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzRlOe2B"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2114214c63eso53698265ad.3;
        Tue, 12 Nov 2024 16:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731457703; x=1732062503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKsdbnvRUk9U6O1O9cwYT4JrIhseWm27eIb09OJkB1Y=;
        b=bzRlOe2BMD6kyyOAcS+dnlBsPmUfGAI7oFdt9qJWWXOeKCWKGXtFOjZrdIXCMK7r6J
         HUu/dvvBmi0TFGlRdZg5F0UeTOwJcBC7tvMrayTjaNrxazCxK/YgE+YQReS6eaJrTYBs
         9VKBqauqM0WQWQg0Pjk6ctFHx66DtxyUUx/S+yuUmwim/tsy3JvEO7m1MSwoUIH8G2xu
         USb243deZajorRbbedxnAsxWPQk3FTcPkdPPBGOBArhwTxGe/yyY0cajoh5mryB8nLYv
         31rlZhP1Dwlss9GB4YoyvFwTyy/2mdrn+rof9a4OdF33dGssSc4+JKz3bIkHVhhIiKar
         tDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457703; x=1732062503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKsdbnvRUk9U6O1O9cwYT4JrIhseWm27eIb09OJkB1Y=;
        b=JH3p1eJSQVnfbPScwq0z3sRB2l8aiegbe25aGDSu9KOQPRNr2tWT5pKvjr+qCnqJyB
         Er25KDgJUjijCaw9vVbV2mU7kIN0zuGVPZQ/9rXqOSciEQGUtn7/9dR8i8AlskTnX4kj
         /TllSX8wfJ6ru3hl/RyPD7o0mIToE2q9Xf/JEDwWkAljaPC4RYmt7rIaTSd/ZNX/SaPw
         Z8ptXLdlMlswguRC/aFMnPauNXuJHBrG3jl07Iej+AV0wvRBzBrMrYyHp9k4xVDH0/Bm
         1jBARsUPcxJ478WKhIu/NkqD2vYbtaoQJHzrB2UuRKYU44uTyTFS/HluhC0ebi2wnjGv
         UKLg==
X-Forwarded-Encrypted: i=1; AJvYcCXdM5XpaNlAq7dYXAf8S/Sf4hHFz9QfvHxyBmtYfoKE9VTbpmzmywxk8b6D38fY9MNjPl5itqKecOF0DDc=@vger.kernel.org, AJvYcCXrZfOfZfeni2NsyKcydf4RpINICaGbcClIXD31LLAaoL1hgb0XP4Qm0TsfJAZQBGvHJaYfLmAtLtqxMrfAjBtyRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc8tsjKYkvmBwZSzz4LJpaPKNeLw6SNu/M1Hyj+86UuIlbZh8A
	RYZaLq5QRy6EQJABLVUYdyedjxs25ELHfQXABxt922K9afOJXb0W
X-Google-Smtp-Source: AGHT+IHi16NKqwb2xu6avMOIeZm6r90zqsOQDvvkgiPYntKLaBAPO29Q1hJ/6CQnIJRI4rT6B3QcIg==
X-Received: by 2002:a17:903:1cb:b0:20c:bffe:e1e5 with SMTP id d9443c01a7336-21183521d84mr268992785ad.19.1731457703105;
        Tue, 12 Nov 2024 16:28:23 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e458bdsm100158425ad.133.2024.11.12.16.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:28:22 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v8 01/10] perf record --off-cpu: Add --off-cpu-thresh option
Date: Tue, 12 Nov 2024 16:28:09 -0800
Message-ID: <20241113002818.3578645-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241113002818.3578645-1-howardchu95@gmail.com>
References: <20241113002818.3578645-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specify the threshold for dumping offcpu samples with --off-cpu-thresh,
the unit is us (microsecond). Default value is 500000us (500ms, 0.5s).

Suggested-by: Ian Rogers <irogers@google.com>
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
 tools/perf/builtin-record.c | 26 ++++++++++++++++++++++++++
 tools/perf/util/off_cpu.h   |  1 +
 tools/perf/util/record.h    |  1 +
 3 files changed, 28 insertions(+)

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

