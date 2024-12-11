Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3E1F4E33;
	Wed, 11 Dec 2024 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954442; cv=none; b=bLUUZTm6Vcxa1LQvLLQcK1SrfvQi37I8dBlTHHQ66AkZBvQrMO7RKGp9KE1m1x5KAHEvxW13OsWLKt69hE5WWQIhABTimT7xB3vMlobfuBMh3pjqL/uyekQDYfqz28euLfTIZCMJThr5P4nRaau8f7+34U9y/UwNmKR7dNGZqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954442; c=relaxed/simple;
	bh=foSgLTZyTs4SVotNFY43ppSIAy4gTLpyUpH0qpfuhUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fokQb04dSZ6HM1I1JG6T3h6+SW4oexgeRfq4qsw5QIEGSbkqksxTz4qYYC9M/wFRcVew2gnNUW/wl6ZIV5URCFmTx6YBXjbXGt7iDGC1XVBL9obaOIZQ0YUT/ZPJcXiG9pPA0TucxUsjNHdJL6QczdxdoYEoFHN3Wov3hLBmrYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGDSEVbi; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGDSEVbi"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef748105deso4217950a91.1;
        Wed, 11 Dec 2024 14:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733954440; x=1734559240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4lb0Q0vjscdmvfAbqYffPP3ZGMItoDtlGIbQQlVEN4=;
        b=HGDSEVbiyyotLbz+Vc25aX9yZlo1vN0NiXYPRpzfXllsZVgB2+UWCVt1nuYF9wPfNl
         vMOTbbJi40R8OEXteosrcoUhTkBh52AlnzvoaA4FFFEzYQqUU9Mg9OmAED0BZAJ7i6RD
         VJuCFabsyTD/tCU5pegRIJjlf9StFnCBMZPIjzj2muKTAWP8OMESjJ5HRngoXA0D4LRd
         4kPXC0Tyw2V9FmW7GNIlJKgtrdoiybGo3nsFjzgIiRWsiejiR0uQL93zXQWNynpXRQM+
         BjKEbFv6Ca9zf0Z+VmvENUtFfm++ct/jLLQFgLRSB9+H73hou8OvDXTHxC8Gys8IC2an
         OfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954440; x=1734559240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4lb0Q0vjscdmvfAbqYffPP3ZGMItoDtlGIbQQlVEN4=;
        b=JzScrypK/drIPdvX7y2MTsPP63w6+x69RK0Lm7e4TmT9KwYMv+Kr01L/Vpy06k2pcf
         +EDQaKWhGmRg9vQjZl5TFOzD8WJiSBSUVoIa46HXOobwFgqV8/nPWYw0rvxuRQ9rrXnA
         EEyI1SrhoWKVEbpdSnKyBAYC/vxIWpBJD5usjyC6W1f8DYoAuqqDqMF6onAZlDqSduU2
         uuBHwlJLbrQW7mnWUSaX97qQJJOIalmHDH0C1+tHUNupoLkhEB1JCQKI85fFa0N2+YF1
         LTf8S9DY2pOgt2GUoHZ1Re/DqxdaslkuWaIyhKJlTMKuHxkWHoZR18VeDnEWHvSbAqKO
         hYuA==
X-Forwarded-Encrypted: i=1; AJvYcCVTHnxSSiD8mhqcKZbp6aO9wt3wV/sMocoVyBirWAS+PYCFvfWwJ3FzEU/eXA13MWpQfqPHyIwTYbuRA7yrloVkGQ==@vger.kernel.org, AJvYcCWjY+q6a5zpX/aDW8n0vS4nVveDSMl3neFLqSuoaibSlVwhb73gHdXahFOnegFyUkUYJ3X8WL8ffDOm144=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9A+P+yM5UFS/449MR4NcVpHg85bhZ0huemUVMeVcnkrVmxA+
	77lKhagyNdJqetlrdKuIg64xCGnwvv1W7ecV2HImoTiGKuDPdM8A
X-Gm-Gg: ASbGncvCoFQyTM9+3yBH3iQ0bBcqMUpAu3W/RqeJrSLcvkA6CL6IIfxqRfEDp7DDTA9
	I5ghlI4OcjDmuKbY9mkTjGmlYYGrXR9CWSBPU9wWJU5C/C5wn1JZYmFOJLr6zxKJksldKneNu5o
	UzePELDvmKFnTvti2uhrYusHfDaKnXcy1wFzJvBksmb9wn/4jVBDYrWLrLCS7NGCRgpeceD2upU
	4e1nid/Fdrf5K0EWlxNYUyWsrjAJ8Y6AxK4pRb9VxytUTUGWkVeS2Pa9EuIyqgTbNZVFJmm6UEg
	HxBRocygjQ==
X-Google-Smtp-Source: AGHT+IFtUs6o96Ickeac4oqzX+YjBtxAhxZqPF3v+ltsT/W+Uvq3y4hhAvnDY8edquGxWcpVqE7ksw==
X-Received: by 2002:a17:90b:4ac4:b0:2ee:e18b:c1fa with SMTP id 98e67ed59e1d1-2f13930ba5cmr2039691a91.28.1733954438773;
        Wed, 11 Dec 2024 14:00:38 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700cccasm13912665a91.22.2024.12.11.14.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:00:38 -0800 (PST)
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
Subject: [PATCH v10 09/10] perf record --off-cpu: Add --off-cpu-thresh option
Date: Wed, 11 Dec 2024 14:00:13 -0800
Message-ID: <20241211220014.931479-10-howardchu95@gmail.com>
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

