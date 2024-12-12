Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD161891A9;
	Thu, 12 Dec 2024 02:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970305; cv=none; b=KV50S8p0mnqPCA72FscBtgK4xaDzHecx7SRGMdNKYJkV0CTnsYjQ+JXD+BRGll3PsMlVSVIZfmiLRuckMnpRkkk//h8M8iKGvi0Ld2O8dMUeGvcGI1XbUvRcWoKoNHVPD8rx5tSecZai88N5pL+PkyJIqxW5+M9UcYQF7Q+8mg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970305; c=relaxed/simple;
	bh=sXShppuk91lG1gcVC4ZBQW0g/2laIvfgKYRovt48150=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5VL1WW1brgpjTIyDXG/HMbLNap7hs+/bJEUX+J4RG/i7U1szfGeR4sc8XjJhhBNaitbp9lRygiZS8ckp7qYwtGMbR33jwFg6HjqB63hl0+k7eZgoJG71nZkafg6uWACoOrtlwVpRgvqXUpHsUqVCdDpJjnVCA62YJRM7tjiJMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TErHzxyb; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TErHzxyb"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2efa856e4a4so60816a91.0;
        Wed, 11 Dec 2024 18:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733970303; x=1734575103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fS22MoLd8wNO6s8nIhAnqT6Lq7LzbIV7Mpi5Zi+JLU=;
        b=TErHzxybE090b517b+4IBiTytsG8gNtXgsXssGNsqdufGZbnd1ctAOCrL9sAZXBLn6
         gyQD+o/e31n532KcubV1pKcjbL0O+VJYEAWD25H/l1UqtF1jgiVBtDy2XMFNvj4ZVv7V
         +tlXf+Z33QxFuE71UKur3tchgkEFFzCC9+vMy01AZp1ZFEa/U7zk/yp42f9i86kgIKDl
         OKRAh8sb97ie6Yr7kyncDheAldTKShl3+ageNp+US6b0h6cwMaziFs/rpLfU0Mdq32wP
         MrhQ4odpoG2j272uRSYgKzhknsXDmgTsYdrgu4cBKHwOPrXptW+luwU8pLoTmnWKpWfj
         rLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970303; x=1734575103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fS22MoLd8wNO6s8nIhAnqT6Lq7LzbIV7Mpi5Zi+JLU=;
        b=FNV6aJqGxiKQC6wcEmmZHFBH2oKXnMyQ7eORCDUisFftL9gyeRO0qnSsPwgCvRnr63
         /Rk7oxTjBZ8NFgEBuT1w2To2oNF8tp0QDocxrYvcyA+gyyic0d3msQzzXLz2eKucX3ja
         u0zmpKE6tzSELqEn+KQoPXNNswjm0AgtHNNMjMY1ByBgK9Kvbd9bp5ShkZHZS1GIXFlA
         PANT1gj1RveGzPfjYaNKfYQM35+1h/GUBpyD6Y4HGZhbZytcIBEoEf8kDhkv4P8vUYrD
         wJxRfO7FLenv6A1PwE0IdRmSKI3eCU25z2g+3VkAd0IEaAuttNxefIHIkVNun/yBhXWJ
         UFWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU39KghEbbgamC7BOrxJHLVAILHa0SXWsL68VpvnE/LD9WNogZXU3bqA8LH4TLASSbyV1YIESM/oC3LtJuZ73kauw==@vger.kernel.org, AJvYcCWJ7ReIdjomUVZW5qfpOFp0T80FX+xZEduSHDeT0NDwHhFEASV1XjQfg7rFl2ts9qs5I9gGBlsOxUGYTlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziGdZLjEMoP+DxFxmb7cVOyjjjwu98PKvq8hfrcnyakj++Tpoa
	lvKV+vLWHUqos3DBMTWbkpe0eG5FRXThqa3ZunlIagXjNKsM9/Dj
X-Gm-Gg: ASbGncvfQJDUcWJQ8yehjNpPTvxCS7f/8jf4C1+nZcd2Hc+6Ah0TDaE3QZFUCz74EAO
	PGbjw2QPLrhQQf2l4jtxDWMpBcVao1/e7hDEtg33szu79wOHUP4WSc84rzyr/8NXKHMXLn3e34J
	+vjK8VJ96Y/T685MvM3HDSKy6OF1czUofJBxxgLZSY2l5d/1pW2oWpmPc3ljvvNKEe0dRdQrRmx
	P8sU0M4ep8GkTB8lpZcweSDgTbFnQqzWiC5Cvw+3Tb8n4HXrrByxrBlPDGdU+xMWkZUZ42YrFAu
	6n1giHycHLMy
X-Google-Smtp-Source: AGHT+IH+b3LrfT0YaB0UdI0f2DjsgF73u7+XWHbZuV7kdoN+tIRR7OalvRPIZy6LPzqFdxOA05z9RQ==
X-Received: by 2002:a17:90b:4b88:b0:2ee:9d57:243 with SMTP id 98e67ed59e1d1-2f1392574fdmr3312387a91.1.1733970303161;
        Wed, 11 Dec 2024 18:25:03 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm112583a91.12.2024.12.11.18.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:25:02 -0800 (PST)
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
Subject: [PATCH v12 09/10] perf record --off-cpu: Add --off-cpu-thresh option
Date: Wed, 11 Dec 2024 18:24:19 -0800
Message-ID: <20241212022420.1035999-10-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212022420.1035999-1-howardchu95@gmail.com>
References: <20241212022420.1035999-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specify the threshold for dumping offcpu samples with --off-cpu-thresh,
the unit is milliseconds. Default value is 500ms.

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
 tools/perf/util/bpf_off_cpu.c            |  3 +++
 tools/perf/util/off_cpu.h                |  1 +
 tools/perf/util/record.h                 |  1 +
 5 files changed, 40 insertions(+)

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
index 0b637cea4850..62183a6857f2 100644
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
+		opts->off_cpu_thresh_us = off_cpu_thresh_ms * USEC_PER_MSEC;
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
 
diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 2e7e4ae43ffc..c3ac19393c0f 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -14,6 +14,7 @@
 #include "util/strlist.h"
 #include <bpf/bpf.h>
 #include <internal/xyarray.h>
+#include <linux/time64.h>
 
 #include "bpf_skel/off_cpu.skel.h"
 
@@ -286,6 +287,8 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
+	skel->bss->offcpu_thresh_ns = opts->off_cpu_thresh_us * NSEC_PER_USEC;
+
 	err = off_cpu_bpf__attach(skel);
 	if (err) {
 		pr_err("Failed to attach off-cpu BPF skeleton\n");
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

