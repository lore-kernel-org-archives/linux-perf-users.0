Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F5271278;
	Thu, 13 Feb 2025 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487628; cv=none; b=Ly7jLiR4j2vgpfKb/mMy3AU6WdokN2h02L4Su1f0j+o56OY9HiQ2dYZbcCgb4p1qSiUQmUVL6KKYBiIibR7YO56Dd6It6NnVsjn3M0mC51eEmxaa5AwQYopdiamJbO9pRGmahj5tgmwaes6axVdozVgc8el5CBkzmZTOlaKpgTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487628; c=relaxed/simple;
	bh=GPD6HDKgqeAnoPrMX7rRtPfeuzzlgM8kDH13INdoZR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDDKEiNExFum65h4MEaFmmGuuwK5mALUaLMhhwlUV3wi81VTh1mF4ZVnT6/dMNg4j9FGUe6jxc4FycQzbtcCqzptpzTj/BoO213WIKuzZG3t8SAAwi81BLdCnxnKZRc0idAKsN/Kx0KbK7AC6YR6Rlas5X5IB9VUe+NMGU6hrYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yle24aW3; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yle24aW3"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa7465baceso2933916a91.0;
        Thu, 13 Feb 2025 15:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739487626; x=1740092426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg1NcBAxZgPijirr2zNVBcLz8NdtPXgGW3roTpjnlrk=;
        b=Yle24aW3ZM5pvwlRDuVYl92yNa3Y9FjYeboRF2VQICowBLjCoNBQi+gn3QU8ITNqDA
         7fatfDSbcz9BOHQwotsF2KfqnZb6fBcLktHo7CR2ZU9qXvDydNCJxggML6pCNu+rGpt3
         ECGxx0bN/p3xY0RjUSJslB2gtKcdVvAZDiV/hW/F7z6FnFUMRK9piGyyBAFY5RMof3kf
         Waq7F03gODOV4h7Ekl3Wszat/k+o85lqPLzkgw+8/e6+QghKetR3yKtMVxwbhq7c3XOF
         cbffR34ttnMpViV5IS1gez/Bw7jYmIbDVM7YeZWT1Lzs6WNvZFCVqdqA+uokaZEtOgVM
         ywJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487626; x=1740092426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fg1NcBAxZgPijirr2zNVBcLz8NdtPXgGW3roTpjnlrk=;
        b=QRazVrPU7MpO+HQ0pCKvg6AdM8/Iy5wGdxvnDpNw7UpIlDJ0bl+LYWf5vbVIm9yS2a
         DLT/9a3XljVMwVvxtddF4iRXLHSGep6aGATtu8Xb8oSKQqfed74S4tXyBHuLvwCMiSze
         OekF0OMPHEZyvKfa5pJz4d55uELxWL/EnjC9pCJUJJixASXk2H+0K2hAwsRu/Ht2z1s1
         pOw4vBLAQV4TvOdy5MDUmbF42dgrp59Hyk7i4QHs0924pD8GbVR2ILuJJx6e+9aPTzzA
         By6067QWP5O+A7ytGumZ9YnAhxJFkNncaDBucbfpS52YV11jQx/Ohmo/ku8vm++7igfC
         QltQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBCZIzmeA52sPEQGtrLdJRR9+M/JCqedCUilcon8p5hVHh/Y+xAxxMAL+XpPvWVyO+jjW803nOJrpJpQYcuLC1Vg==@vger.kernel.org, AJvYcCWhXPh+Ohd2uZhrElxkjaRtBam5eIyIc91h9GP4pB7UekTQyFKHbtvQ7ji6BeDuCr5rnGIPuB90/dddRq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD04i/A7jx4lwcV06AcV/LnR1nNMND/aHnG94iOm+mBESIt67O
	9s/ceuLznx6CumPxuxKUNxWDSZgmTB99OIuGZJU4Eu/6FZAtMVJO
X-Gm-Gg: ASbGnct3UOXy/G1d6TggEvkCpHwvGPriK3Q5TQ3KmHBj9e4QsBF9kpiHJhFXZMl5ejk
	C/q49uNH7/I1twVbivE/Bj+mOi69JlbcQFlY9ZObmIE1RZHjfkbzVCSBsSVhHNUQ03Ly3SPtvAT
	x/jS84OMRBaSrMAyPUKem98JeMdNel1cyDjpbBBjbjq4b2ld8RliAlUkT/SEXlhwn9TcqSuSkMe
	bAi5tATMNk+qfCRMX3kHHSHcsnWGYmgOutCN1slt6e6RWo2+VvNDm+Ar6DiFBxLMmGqjj3q9EvG
	khdlqFgtHkJhhN39JxspopNRykW+FKwL+BT07hxKgfoxgt0=
X-Google-Smtp-Source: AGHT+IFsHQahU8g/tgoe9IgIJg9ph+LpQRNRdynO2o45MxVtooFtulDIsAz9hzwQxu8IoEaBaTh1hw==
X-Received: by 2002:a17:90b:4b8e:b0:2f8:49ad:4079 with SMTP id 98e67ed59e1d1-2fc0dfc650amr6273603a91.6.1739487626127;
        Thu, 13 Feb 2025 15:00:26 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349210sm17641735ad.11.2025.02.13.15.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:00:25 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v15 09/10] perf record --off-cpu: Add --off-cpu-thresh option
Date: Thu, 13 Feb 2025 15:00:08 -0800
Message-ID: <20250213230009.1450907-10-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213230009.1450907-1-howardchu95@gmail.com>
References: <20250213230009.1450907-1-howardchu95@gmail.com>
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
index 80686d590de2..3a87e635f52c 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -833,6 +833,15 @@ filtered through the mask provided by -C option.
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
index f3e5f856f4a4..4bdc7a0111ef 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3158,6 +3158,28 @@ static int record__parse_mmap_pages(const struct option *opt,
 	return ret;
 }
 
+static int record__parse_off_cpu_thresh(const struct option *opt,
+					const char *str,
+					int unset __maybe_unused)
+{
+	struct record_opts *opts = opt->value;
+	char *endptr;
+	u64 off_cpu_thresh_ms;
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
+		opts->off_cpu_thresh_ns = off_cpu_thresh_ms * NSEC_PER_MSEC;
+
+	return 0;
+}
+
 void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __maybe_unused)
 {
 }
@@ -3351,6 +3373,7 @@ static struct record record = {
 		.ctl_fd              = -1,
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
+		.off_cpu_thresh_ns   = OFFCPU_THRESH,
 	},
 };
 
@@ -3573,6 +3596,9 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
 	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
 		   "BPF filter action"),
+	OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "ms",
+		     "Dump off-cpu samples if off-cpu time exceeds this threshold (in milliseconds). (Default: 500ms)",
+		     record__parse_off_cpu_thresh),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index e55693bcbf08..00736fb2678c 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -14,6 +14,7 @@
 #include "util/strlist.h"
 #include <bpf/bpf.h>
 #include <internal/xyarray.h>
+#include <linux/time64.h>
 
 #include "bpf_skel/off_cpu.skel.h"
 
@@ -291,6 +292,8 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
+	skel->bss->offcpu_thresh_ns = opts->off_cpu_thresh_ns;
+
 	err = off_cpu_bpf__attach(skel);
 	if (err) {
 		pr_err("Failed to attach off-cpu BPF skeleton\n");
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index c15b69586723..8df35541141b 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -124,7 +124,7 @@ const volatile bool uses_cgroup_v1 = false;
 
 int perf_subsys_id = -1;
 
-__u64 offcpu_thresh_ns = 500000000ull;
+__u64 offcpu_thresh_ns;
 
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index 2a4b7f9b2c4c..64bf763ddf50 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -16,6 +16,7 @@ struct record_opts;
 			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_RAW | \
 			      PERF_SAMPLE_CGROUP)
 
+#define OFFCPU_THRESH 500000000ULL
 
 #ifdef HAVE_BPF_SKEL
 int off_cpu_prepare(struct evlist *evlist, struct target *target,
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index a6566134e09e..c82db4833b0a 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -79,6 +79,7 @@ struct record_opts {
 	int	      synth;
 	int	      threads_spec;
 	const char    *threads_user_spec;
+	u64	      off_cpu_thresh_ns;
 };
 
 extern const char * const *record_usage;
-- 
2.45.2

