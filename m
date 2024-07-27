Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92901187861
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271575; cv=none; b=Uj7Sd4lWVlNF7NN9VeG5v0jILx17LYWt0TQXcgr8owFnY26J5XyUhCBn/DmO5MFzQ/a3io+aKiU8LAwcivDm4QFMk/vkbgY70bK0T2LQFYc+gLCmhYqW/JteE0xq7PU238NnfLFk25hLr6Kj8QXG0vVF4kHnA0fH3naotIJvfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271575; c=relaxed/simple;
	bh=NpgF1/kK1yOkWx7OSvhib/FvJeG2/8hZAiow4pKggL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFEzM9CE5enhMvnqXeQv2/5CkJpdOR4IF7GllTFRlC/epzbFycR3mI+5crd8X2m61U/+CV+219Mx8H77No9mEfNqbYO8ovXjh29Lu394P7rf2nP7rVNuFl43Zx98ku0Vv1nw4LRtmyKUn9htcndq+NqrA2Aecmy6D46ZSDkefI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TMwZha5V; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TMwZha5V"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc6ee64512so21030335ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 09:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722271573; x=1722876373; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sq/wgKkNEoeBfHdwGP5Fnla8E6KMSluE3DaT/hx6/0=;
        b=TMwZha5Vj0sKoxExJ1Z/M1IWi7zVxSwT2M+iy1OacbKhTpillhnuKWWwgvUKozSrvM
         9A8xODtYCaadYioRhXt8gWNmvVDPi8dvIqHmVJbkxSvld8oZBXTsyKtYjDEgxV8PZJmd
         vLkOgH5R/a+xjjH/o5QVXZKEfgOLPbSoE95e+2UgpJmLUD39i6VdmKPw8UGsc9upjw5o
         VC4gPLGC8MNk+Tv2GA48RoY2kh2tfFDKrylifX/f5BBsTREzK7yGSwRisei/noVdTmTL
         qkwBgxLOhLcQ9uAUUJzK4uI5gYZM/1pLqT4PSCLquh17Hiq0iiTC9d3LZnzm35n0LJzS
         VZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271573; x=1722876373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sq/wgKkNEoeBfHdwGP5Fnla8E6KMSluE3DaT/hx6/0=;
        b=Wq/d9pPsYcidQYk8AVH1oJQ22WGfaJ3TZY5nGhkTU3Gp7DDHqoTEmNV5UzaiU597bm
         sY9O6JyLLayumC9hKkc+d6n5fs0tUj7Vus4DdlyAu3hxzVuT83TNefPp8gsKSgxmacu+
         U41Y7kWz5jMnVqBP9JPFElzHLpXsoonSYCFrskF73droq0fxBHhe20Mh99WatY9GuiXI
         8AnGf3G1rKTI7abukbHA6ohtPPzODYya0wPsPYA8dijywE5OREsQ0KeLM0u+jqTSAk5X
         qHhuaXAdGDAVef9rUhvbLAJ/OuxIvw2BTpJz+D0uzmNnxiAg7EMzXEFLJLNchxGlK9S8
         bc2Q==
X-Gm-Message-State: AOJu0YxrBtJxSVHiOySTGsLuGcLHTylIJXOYOxR4OFqylP485LqeNUj0
	M0DO7Wqa64EJcVYqS26u0uQnJTWA54DQHDbLbGIp9Is+10ZE2nLjehDc+E2y5nD7yoA+7ou4LLH
	v
X-Google-Smtp-Source: AGHT+IHIU4ZqwMOi+9pCWVyiNYiqbMYPUL7gmvjWFUUZYuciqgVS+40fRq++sBF6vHIYSXwLkZudiw==
X-Received: by 2002:a17:902:d491:b0:1fd:709a:2978 with SMTP id d9443c01a7336-1ff0485ba87mr59797395ad.38.1722271572808;
        Mon, 29 Jul 2024 09:46:12 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d401c6sm85480545ad.117.2024.07.29.09.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:46:12 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Jul 2024 22:29:34 -0700
Subject: [PATCH v2 4/8] libperf: Add support for overflow handling of
 sampling events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-overflow_check_libperf-v2-4-7d154dcf6bea@rivosinc.com>
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
In-Reply-To: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722271564; l=5292;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=8zwxFTYoYw8Wodjo527mV6UDvzQ+n1PNG6cEAoqFF1c=;
 b=kuo9VfbWPQ1nC8bXfn/ATV7gFoalcR9fMmHKAB0r+H6d1E/DkyARWRHZKCQpUjWnGHSDTpwTS
 qtCb21rRC7iBHI35lGaYorH25PUiulnNYyi3xrmSbD4e9VOHkUtdCLZ
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Extend the fields of the opts structure to set up overflow handling
for sampling events. Also, add processing to set signal handlers in
perf_evsel__open_opts.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/Documentation/libperf.txt |  6 ++-
 tools/lib/perf/Makefile                  |  1 +
 tools/lib/perf/evsel.c                   | 79 ++++++++++++++++++++++++++++++++
 tools/lib/perf/include/perf/evsel.h      |  6 ++-
 tools/lib/perf/tests/test-evlist.c       |  1 -
 5 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 83827b94617a..bb99534d5855 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -137,8 +137,12 @@ SYNOPSIS
           size_t sz;
 
           unsigned long open_flags;       /* perf_event_open flags */
+          int fcntl_flags;
+          unsigned int signal;
+          int owner_type;                 /* value for F_SETOWN_EX */
+          struct sigaction *sigact;
   };
-  #define perf_evsel_open_opts__last_field open_flags
+  #define perf_evsel_open_opts__last_field sigact
 
   #define LIBPERF_OPTS(TYPE, NAME, ...)
 
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 3a9b2140aa04..9dade2ad91bd 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -75,6 +75,7 @@ override CFLAGS += -Werror -Wall
 override CFLAGS += -fPIC
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
+override CFLAGS += -D_GNU_SOURCE
 
 all:
 
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 96ecf3e5c8b4..17d3d9a88c23 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -562,6 +562,79 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 		*pscaled = scaled;
 }
 
+static int perf_evsel__run_fcntl(struct perf_evsel *evsel,
+				 unsigned int cmd, unsigned long arg,
+				 int cpu_map_idx)
+{
+	int thread;
+
+	for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+		int err;
+		int *fd = FD(evsel, cpu_map_idx, thread);
+
+		if (!fd || *fd < 0)
+			return -1;
+
+		err = fcntl(*fd, cmd, arg);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int perf_evsel__set_signal_handler(struct perf_evsel *evsel,
+					  struct perf_evsel_open_opts *opts)
+{
+	unsigned int fcntl_flags;
+	unsigned int signal;
+	struct f_owner_ex owner;
+	struct sigaction *sigact;
+	int cpu_map_idx;
+	int err = 0;
+
+	fcntl_flags = OPTS_GET(opts, fcntl_flags, (O_RDWR | O_NONBLOCK | O_ASYNC));
+	signal = OPTS_GET(opts, signal, SIGIO);
+	owner.type = OPTS_GET(opts, owner_type, F_OWNER_PID);
+	sigact = OPTS_GET(opts, sigact, NULL);
+
+	if (fcntl_flags == 0 && signal == 0 && !owner.type == 0 && sigact == 0)
+		return err;
+
+	err = sigaction(signal, sigact, NULL);
+	if (err)
+		return err;
+
+	switch (owner.type) {
+	case F_OWNER_PID:
+		owner.pid = getpid();
+		break;
+	case F_OWNER_TID:
+		owner.pid = syscall(SYS_gettid);
+		break;
+	case F_OWNER_PGRP:
+	default:
+		return -1;
+	}
+
+	for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->fd); cpu_map_idx++) {
+		err = perf_evsel__run_fcntl(evsel, F_SETFL, fcntl_flags, cpu_map_idx);
+		if (err)
+			return err;
+
+		err = perf_evsel__run_fcntl(evsel, F_SETSIG, signal, cpu_map_idx);
+		if (err)
+			return err;
+
+		err = perf_evsel__run_fcntl(evsel, F_SETOWN_EX,
+					    (unsigned long)&owner, cpu_map_idx);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
 int perf_evsel__open_opts(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 			  struct perf_thread_map *threads,
 			  struct perf_evsel_open_opts *opts)
@@ -576,6 +649,12 @@ int perf_evsel__open_opts(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 	evsel->open_flags = OPTS_GET(opts, open_flags, 0);
 
 	err = perf_evsel__open(evsel, cpus, threads);
+	if (err)
+		return err;
+
+	err = perf_evsel__set_signal_handler(evsel, opts);
+	if (err)
+		return err;
 
 	return err;
 }
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 8eb3927f3cd0..344808f23371 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -31,9 +31,13 @@ struct perf_evsel_open_opts {
 	size_t sz;
 
 	unsigned long open_flags;	/* perf_event_open flags */
+	int fcntl_flags;
+	int signal;
+	int owner_type;			/* value for F_SETOWN_EX */
+	struct sigaction *sigact;
 };
 
-#define perf_evsel_open_opts__last_field open_flags
+#define perf_evsel_open_opts__last_field sigact
 
 #define LIBPERF_OPTS(TYPE, NAME, ...)			\
 	struct TYPE NAME = ({				\
diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index 10f70cb41ff1..3a833f0349d3 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)
 #include <inttypes.h>
 #include <sched.h>
 #include <stdio.h>

-- 
2.44.0

