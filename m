Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2D22FE06;
	Thu,  1 May 2025 02:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066510; cv=none; b=MxgdgmSPcm00JmBB8zYnS98aMWJlOzNCLj3IiXu7dh1yFGDs2o7MuJ2SwBaAM9cnMzcdQwlWVkW7nhyoc3135eSh8GnSr4CNxkdYHvQIo/Pg9G5D5xXkwENq0b6i5Q6V4g0XT+nRXoK/KLR7rd2itp7tHisEz+jqKo6BGlLE2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066510; c=relaxed/simple;
	bh=UBEORm636/9ymi4rsoYE3mXyHcRxH6DVHX1aMMbqXN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGai+CwubYV12V/XM1vGBMtBHqJheBMEqK2YLWt3/uSlrO2+7woeg9yQJwtqp3JrRT+lG1BLThKPxeuMzpt6+TICFqzmii8d2bB+N1zm9/ldgp3kIW2+FSoCJ1S2WijnZqpARPWKLAEVPkaNg6ch20qYhSZfgVQbR6PLU1FB88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si6bPtgi; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si6bPtgi"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736b0c68092so523721b3a.0;
        Wed, 30 Apr 2025 19:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746066508; x=1746671308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE7k5mUPZGsaEEvfnaUZGMWrp21zZwEJVPsVMxHJ10g=;
        b=Si6bPtgiQxwX4BlDMEM6dH6Ob0lV4zCpoAkCeJrtQAx8/8T4vMkWU+WCle5czWgxZk
         1XpWs3gwwUnuMCqFa0ze0vXVvP8VC2JXUIfFZE/63ig9t8RPXZJnY4kWyQALuHaKJkPF
         uVqB2+fh7ruRJmnsR4QkqaD0qPixUQKIj5PadU2S6GUCey34MhC5oF9x/oGax0RYQ+Gl
         /CQQmDtBXBKJqKwhcpvPq+PKDzJRrFa1juO3zyS+UIxInXoe55kpr2f17VMY5Xq6KU96
         yD7pBSNN76vjlpjawofaKXPyXCHDu/n7fGOm3gitRvXyiIk2PkCI2u5jz/QyC32GCIP0
         uBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746066508; x=1746671308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cE7k5mUPZGsaEEvfnaUZGMWrp21zZwEJVPsVMxHJ10g=;
        b=nrDMdruO+5B3A4UdxwuggpgY8vl5WoCoeK3cRGD1Ynaku0Y6qmC3efUEiO6eJopTW2
         7wnQDBPVzapKwXjEvx1Efs6Iykc47JyTQN3O6UNrmX5Ma6U6/rjf0w7RvAJiXjp8m/9B
         4TCzv3laGFFTZfiOQryNtXj8eLjrJxxUqfhmLvXmsKcXICUoXfdSZjjQvi7sIrUin0Yz
         lBR9vo8xWpZx4WzxBorWU6Ch11zmu3/al6r2W6vjG9ummVfDklKCgmqzaYyoqGEADnCM
         d9EzhZDw90nshO+hYme4IYvs0q854BwbbM/6i1XCp8j0SO7CJ/wNXjIholuMuyHsp2Tr
         46fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNrDbSU07G545YVc+Q+kTB8cp5Z0793cI6D9RTw7J15q2bUxAcXCCc9PGJaXg6N3Yr6qoCQjlNOShksgU=@vger.kernel.org, AJvYcCXYHgmb/ZDk9X57DvTb8TQWt9c0dFNBqKN2Vw2XiBKUuqnQoH+KXMiuzkyAqjSQA/b+G/hV69DYZquKOfC86oYqLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpS7sPsh3PHnx66Dzb4MF6nDvOUBYHoFC3ZEY+HFvzzdNk3vbn
	ovgqcPzPmtWX0EH8XzE/Ip6nt5mkrDZ8ZDg+uOLnz0bimpIxNfyw
X-Gm-Gg: ASbGncs/Glct5g1/qKv5DfXzcAedYnlnQAWAyhtklDjVPI+X7ODum4IiEEu/Hp4mSGi
	MiiD349CAK322voPW9e/k8+DaGSEAs/O0FmQCoMC52PIgoAwucfPCYalCEllyfeFvmMCh0KLaqx
	WshobvQqLF4GuQTy2zooKVbFaccIUcq7rqoiSqKn4cIrTm+kgsS5FBaka2AWyt/1AubElbuaMw4
	rvhuHNvIDKAfoHpLsvw3EfRqo11A7+XinORiYU7gCUO1LScF5t2E0f3A9cqAJvf3KyoltI5pTs+
	2XUZVKNt4rpgsneqPu49NjqhUOiZI2tljOOyShdp54X4gJvMAjBUlN/PvQQCpJ77iuYo+VKOX4n
	otaCazWZkm7UoqbCcH4WJ
X-Google-Smtp-Source: AGHT+IF7qt+/r8Rp0+kzvQvqTnA0A3Pxuei84gotGox2TjH+PinMYF7hSy+NC2a+KF+l2X1kTo/ksg==
X-Received: by 2002:a05:6a00:2185:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-74049184970mr1136510b3a.4.1746066507975;
        Wed, 30 Apr 2025 19:28:27 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a8fbe7sm2459599b3a.160.2025.04.30.19.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 19:28:27 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gautam@linux.ibm.com,
	Howard Chu <howardchu95@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v16 09/10] perf record --off-cpu: Add --off-cpu-thresh option
Date: Wed, 30 Apr 2025 19:28:07 -0700
Message-ID: <20250501022809.449767-10-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250501022809.449767-1-howardchu95@gmail.com>
References: <20250501022809.449767-1-howardchu95@gmail.com>
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

The example above collects direct off-cpu samples where the off-cpu time
is longer than 824ms

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
index c7fc1ba265e2..d84f7a0af05b 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -837,6 +837,15 @@ filtered through the mask provided by -C option.
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
index da28c52af464..d3ddf933d7a5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3162,6 +3162,28 @@ static int record__parse_mmap_pages(const struct option *opt,
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
@@ -3355,6 +3377,7 @@ static struct record record = {
 		.ctl_fd              = -1,
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
+		.off_cpu_thresh_ns   = OFFCPU_THRESH,
 	},
 };
 
@@ -3580,6 +3603,9 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
 	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
 		   "BPF filter action"),
+	OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "ms",
+		     "Dump off-cpu samples if off-cpu time exceeds this threshold (in milliseconds). (Default: 500ms)",
+		     record__parse_off_cpu_thresh),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index c7fde66bb8f9..c367fefe6ecb 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -14,6 +14,7 @@
 #include "util/strlist.h"
 #include <bpf/bpf.h>
 #include <internal/xyarray.h>
+#include <linux/time64.h>
 
 #include "bpf_skel/off_cpu.skel.h"
 
@@ -292,6 +293,8 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
+	skel->bss->offcpu_thresh_ns = opts->off_cpu_thresh_ns;
+
 	err = off_cpu_bpf__attach(skel);
 	if (err) {
 		pr_err("Failed to attach off-cpu BPF skeleton\n");
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 14cd8881f8bb..72763bb8d1de 100644
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

