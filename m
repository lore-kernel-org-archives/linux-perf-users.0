Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AED1D63DC;
	Fri,  8 Nov 2024 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098508; cv=none; b=Ox9OjSIJNjCoI0K4TqSiU8W44U56VRuxU3ktkpJ5InFi4EOkZyzis+DVN0/csj8Hpk8dD91bFvKokXT5aW5WZzMrOYgWPFhJNF0au4lqEP3AFLZOrqjmOuTHEtugGCi6KJnqo11Aa5iQQXmIQ3TckScvEd1CylsG1q+O1PvJCnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098508; c=relaxed/simple;
	bh=7d2a59hjrXHo9LfQT3EC3YQbMy4Zy/NeVOWqAns9NwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zl0q1pPSS9lDwWqgMVzdAj8aufy24dHGaDUCjpFyFyoSr+FPmcu9hBI3wYkCxTpNiSaks+xKSq+VE9q1HJmA/g6aZfnEQ7LT7/fOTcZJoqlhqTW/MowHmBbKsCz4qyAmCXtOf3eXONUvf6NO/one87uECPzw/Y4/qit+sv7aWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOMTwfAN; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOMTwfAN"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e467c3996so2194662b3a.2;
        Fri, 08 Nov 2024 12:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098506; x=1731703306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e7d/fIuA3SMFMRnL/0dGJJps8hL64edz7Ln9wdsWNI=;
        b=HOMTwfANECdb/eW71/uv0UYn8Q0p4LWkkHl8NlYsSU67vMZwfgu6arG9gmalOUxiZu
         KWCvnIvgGIBP4Owp3soYlu1E7OfcUu3/ojo82CJ/GBOmZV3+MFD9mjNWltIj2xHNmKeu
         bDmopgB2k81/qQMFMGHWVeqcpHsPyeds3vkui2ZiAY++p5rW60Vzvfqo1Ey4py9h6Ir7
         ir8Vxl+HisUQxXavVrI2ZQuEyfhCOVKmZZMv6u4r0CghAe+HqHqrEDr60rCVqdr0jCMX
         U8TOqOVqrXwmMdY4U8M5Z4ZuI/AzbFGI7rCKCS0ouYY47n5V0sMl3mPmpssRFiWbCYpg
         TgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098506; x=1731703306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4e7d/fIuA3SMFMRnL/0dGJJps8hL64edz7Ln9wdsWNI=;
        b=Eqs+SXtTqxk4koO+zdiagNYbxcWQthZyAyN8Kh2FfOtRQDvS1QSqRK/qbYEX9vwxKG
         ZUUBzMWB1vXjZQ5OEcQRoEzht1uG+RoaZDZrv+EET+RemnRQDLj1gEZpfUyq3vcg2oTF
         jEKUf0oCGsYv3srvIY1PbhURgWrNNnjHOCQ2mDx6eiLhsKjhvFbzxWkQ0amBfx4egHbj
         V7TtQzQjfPPS/g9O0s9kp2h84QUs56fsZEFhGX3ShnavRZ84qrv6DYVOyXoog46uBdsu
         NfsISnCu359q8RbQXFFqjR8rBZ6rpdv2LqPHtzO1s5IMCoE79vPhl13Ap7uIvdyNXSnO
         uVXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuvp6fDoN9KZMu5nJqv3I4oAwJrzXbMzkvGAcqjRiTH8K9233MvCTPT/j8efqjZEBW92V8XsbWE+zn6XI7N9JVZw==@vger.kernel.org, AJvYcCXyQMCJ6FULTRD6Ln26tHsrkI5zMXgJ54AHOoMqtWRI2t72gwdTAsbE9YGOBiQWJXmkJ4aJZYuvQrKkYAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKf7OM327gtszKKHJsJqDGMYmfPmkeXUAWIXCJrB7O/PKWi+i
	xeHkcqjSoe5BvPz0+Bj5wkJxxRfAd/P6qa3/c9A9fuCCKvzmicT9
X-Google-Smtp-Source: AGHT+IHN8BF0wU+hRWkj4JYDZSLcmTu7Irz7OzFjiIsWGcQblSV2cxN3uBWLsBxqazzEGMiYoT3O2Q==
X-Received: by 2002:a05:6a20:9f04:b0:1d9:b78:2dd3 with SMTP id adf61e73a8af0-1dc22a42534mr5674962637.26.1731098505999;
        Fri, 08 Nov 2024 12:41:45 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffe3sm4221945b3a.2.2024.11.08.12.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:41:45 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	mark.rutland@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v7 01/10] perf record --off-cpu: Add --off-cpu-thresh option
Date: Fri,  8 Nov 2024 12:41:28 -0800
Message-ID: <20241108204137.2444151-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108204137.2444151-1-howardchu95@gmail.com>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
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
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-record.c | 26 ++++++++++++++++++++++++++
 tools/perf/util/off_cpu.h   |  1 +
 tools/perf/util/record.h    |  1 +
 3 files changed, 28 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f83252472921..ee04fdd7f2ca 100644
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
+	u64 off_cpu_thresh;
+
+	if (!str)
+		return -EINVAL;
+
+	off_cpu_thresh = strtoull(str, &endptr, 10);
+
+	/* threshold isn't string "0", yet strtoull() returns 0, parsing failed */
+	if (*endptr || (off_cpu_thresh == 0 && strcmp(str, "0")))
+		return -EINVAL;
+	else
+		opts->off_cpu_thresh = off_cpu_thresh;
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
+		.off_cpu_thresh      = OFFCPU_THRESH,
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
index a6566134e09e..3c11416e6627 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -79,6 +79,7 @@ struct record_opts {
 	int	      synth;
 	int	      threads_spec;
 	const char    *threads_user_spec;
+	u64	      off_cpu_thresh;
 };
 
 extern const char * const *record_usage;
-- 
2.43.0

