Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F871E048F;
	Thu, 12 Dec 2024 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046057; cv=none; b=Ku6Tp2suIZfeOxufNiNe4z7p/8qPPisTfMeVjgjJTgBGIYhIEBfIusNO7hSVKjPCPtApZEjVnGSs3AglLohDEaOxzusp14LzmtmRytaT1N1Axn/mj7l/l1rbD+0oU95fKAXmSRIpqBtJ6P1FvGVT7D6fLWQdEyc2ODmtSUVn6AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046057; c=relaxed/simple;
	bh=UnK7vv2vPf8cKT/ib5cXoNr4e2IONsMyFqLWNx8SqKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d06OGrt5Wreaq2Ak5raWR2ZSMdlVf54B+Iab5JdiBL/ip3+Rtz+i1EWo4M6Lign/WXlAos8sNuPkPCC7rUYcIeMvUs84BhjK6nzV1rSvKvoRuW/MGXPxLG4/xKI0y2Gb0keciIvk+SSnqlQunnVH/uxRrNGdqjZx7j+TXUF8bmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfWCSO3v; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfWCSO3v"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7242f559a9fso1400603b3a.1;
        Thu, 12 Dec 2024 15:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046055; x=1734650855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGaXt7PekQ+SHh7VzC54OXmzl48njRQIufsJiYn7I/M=;
        b=bfWCSO3vKXORK6PPGGwdeuEyKWw64SZ9PvIo88T0ur2Fe7bc6ERlgQ7ps2v8a67DRE
         FQsoNZFxEqp6+1ToZ8oaI63G8jenXHD9OZ3GnmzadfhSuJnPYbDUwOr3E7vxgMYG9ZZt
         Sq1OMBMnwDjw7esFhd9MqGdG0iEHLoyirNBxGpI1uUVGcYg+93KoQF/tzZWxA06RnIk7
         Z8fd+LKJx4xkTiLJmervXqso+2B2D7mhiZ1yfNJttKNILYlaZHcGMT72u6ARuJx8MfEy
         mhqzMwqIY9EBqczuChkCFK4JO1UhV7HMNNoC0cMWfwqGq56njXETbXgO2Dyy+D25nfuU
         txEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046055; x=1734650855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGaXt7PekQ+SHh7VzC54OXmzl48njRQIufsJiYn7I/M=;
        b=TyVwofOmJA6oVrLibYsbtFjn9MwuEt/suxuOF5DDU81PCgUhuXQhGQUmbAdlQS5CH+
         Pp6BIgRGym2ZYgpt8HG6J8jZ6oNpF2pqaU0AJedl7S/gVGOAAzM0/G7eZ3Zosb0vD81i
         g7kjrfaXRX02RVnk3nsQbQ6exAvvGZwqbHXQb0u8zzzkBC7ryFokGFhuTOxr/Zn7Etfl
         v3x1WOoz4yj0aHFM2LReMy2whsWBtq+an/K+IhidpDsanHD00g1nazodQAErozRlkhAw
         vxdaNkYr9zvrPOzBee57x4Xou/cLxC4f8X+N8bYUhzVMA9dgvP4142zH/nUlXT4GFDAZ
         vLhg==
X-Forwarded-Encrypted: i=1; AJvYcCWDtK5gBgRykizcLz9DpR2B+eS6o2y6OMxmQTD300b2PeQ1c8l6uQJ8iEkDZ0Wlv+/N5UBRMzwNHmUlbKM=@vger.kernel.org, AJvYcCWhSKf2QmY9fTANlBql1hL1amFfn9wIB5spDJiyXLPqOMWBsMrrIHTlHNIs/9v0KDVmWREww2Aq6T+Mlpj99cCqKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7nUvAMP0pmPi961G4VS46Z/QI9MuZLHJIr0mUgSMvsEnu2+qB
	r+CS8TGZY3ZZr5z0vOgqBOcvIchoaJniA8seGEDsK8UUvJbsb7ip
X-Gm-Gg: ASbGnctuXtBRXoghwa+keaqguIeUDDztGxRQFXcovZbvHO4wm5rp7zxsLl+296J/nHX
	p+5cBRY4Z+HBPrDk1ZoZRvbo6dDWgIOO+a4AANA64vyKob07/7hPuuXaW+OnsHMpWbkxqW2REW5
	/b+5VBt2No14Ry1C8SU16eCgc2tY5lRHKcFcMmgeldSwofsVRl3k0wlPLdINGH4CQxjBYq8JgnE
	RuhhxPFJHtUKjLA16Fj90qo+u6u+nunrzdC5yVWSrHyZgj7xv4a26BT/h1matXcRGJTajFU41r1
	c7PC2V+WlPBb
X-Google-Smtp-Source: AGHT+IGWaft0g4FVBRb7KQ+4N997Pu9PRqaGKIQj4AInRjWHpTshfD/EKxU9BFFSFOsONdZvw1cxDw==
X-Received: by 2002:a05:6a00:b88:b0:725:d1d5:6d86 with SMTP id d2e1a72fcca58-7290c25b1abmr563186b3a.19.1734046055405;
        Thu, 12 Dec 2024 15:27:35 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4e202e9asm7324674a12.72.2024.12.12.15.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 15:27:35 -0800 (PST)
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
Subject: [PATCH v13 09/10] perf record --off-cpu: Add --off-cpu-thresh option
Date: Thu, 12 Dec 2024 15:27:16 -0800
Message-ID: <20241212232717.232507-10-howardchu95@gmail.com>
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
 tools/perf/util/bpf_skel/off_cpu.bpf.c   |  2 +-
 tools/perf/util/off_cpu.h                |  1 +
 tools/perf/util/record.h                 |  1 +
 6 files changed, 41 insertions(+), 1 deletion(-)

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
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 77fdc9e81db3..aae63d999abb 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -123,7 +123,7 @@ const volatile bool uses_cgroup_v1 = false;
 
 int perf_subsys_id = -1;
 
-__u64 offcpu_thresh_ns = 500000000ull;
+__u64 offcpu_thresh_ns;
 
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
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

