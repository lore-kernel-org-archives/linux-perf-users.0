Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9521C5796
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618278; cv=none; b=pXqJBH2E8yhlE7vMx5K2plJ4q6uTDQk+nQ9MgDmS0LXXU9Mx2uBaLOaAdJy4SZpb7hUuduLKHdXFJ+HnPRHVsuCidfiIWoy0ntiw2mNlAgDv+7vgPPs2eTNPtOYGs45pXHFsSARD7SUKlYDjYwSKlsva2BL8yX6iF6EsRiNINaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618278; c=relaxed/simple;
	bh=a/SJnAfZ++cIVzZ0MOXAnphnbstLnHOB9fZ5EurCpyc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=F1Qe2MvmOzfqxLuMWXEGu3z/4SFHmm6W7yIhqf00nYFVjAafYmxsQR1KOWYFaRmihSqn++otyaYkOb2+H2m2pFEkZVVf2h7dEe8nHZ5ZeqLX77A7VGHdWCYoIqsg5eYFYOUhN1oMeJ/j225fw8XY9BT1VUOYUww1ahN3zjWb9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+F84tAV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+F84tAV"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2bd9b1441aso4573287276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 10:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618276; x=1730223076; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XfPboL9tDGHiiStyDSuUXrmQVY6xilnSC3mqb44Upvg=;
        b=H+F84tAVydPdjGpz0hmykG5pNmhIC+25qU5uNC4FT+D/t/3hiChNHjvJ0nbYj/58ZA
         C+BeeKXpxB/QocLesRzZBmRw876UC88VM5viAssceJcMPjcFyvI4V7Tg4XkgtCBpa7MI
         KdvgwaTwiZ/KHfgsuLAMpNyQlnm7G9OQU/EG5gq1PsMLouaYRTFotRJwB7v2+M2wBByV
         wEq8cxlJFLmZ5w8D3b85kKtbdSCM4gpsLZZPC8LA7ik+WoVckfqbDUjTaKPwSBBm6vQy
         IrQV2V5ZGpmlB+iHdSjq3Uoe/UviRbiFEamZewpJkIp+br5WgVvoKUnKP4CADLhu1a/u
         tn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618276; x=1730223076;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfPboL9tDGHiiStyDSuUXrmQVY6xilnSC3mqb44Upvg=;
        b=abkUAsnqSy0LnkWj3XFRsyoG2c6Zh+47dFdOEtvvDdLnXrfgQzuZN2EKSXLlz6Hgnm
         u8ytwS6ewstDnwHNoDaZg+tZUTCZS4Yj/HMvNRA+J5Ru94OeOY6FbrnLOZsQzc0OK1ul
         KwOY9BnyhbykUw4KvAa1kzFcOLL88Fz4KicDygc+DcnGrotENyofi5jC8gsrLJY3YXi/
         4g6abPDJXhMPjalxCtZK20P78SiTxazbqvDSvo+gC2dqgqcrTu/q0cFRQeZSVHKCFRAa
         2gihNl7zOZYMd6inXcHXzqQq5garwkPd/hmFPrSI7FZJFMr25jlwXULknHJS7BCYSrHP
         KcOw==
X-Forwarded-Encrypted: i=1; AJvYcCXtD2gGKhnz3Pl2sx21GwpeFS5NOiOP9I/WWMKPr6snxPfPVXeg2ri8DDM66Wd+g+9kFL9gNuUe4AdnjK8PIe26@vger.kernel.org
X-Gm-Message-State: AOJu0YyMj4VDkspbPGtQBWHy/Gm4sqwx4HqMmruFHMHovZ+uH7loqWQ1
	gXS9wodcXLTDF7o2bR7lNpfBvMpspYvQ8cW+KT/PlenfMbShfF4t9emDAAbEXD45WMw8FXovgnd
	1RVmIuA==
X-Google-Smtp-Source: AGHT+IGCLZBFLtm70BOUOBJbP5T6K0jZmBV7v3k9f+Sgp12tlexCZccbgnAElZqFxYL3YtgPtnkCAjDHu9BF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a25:ced1:0:b0:e28:ec75:75ed with SMTP id
 3f1490d57ef6-e2bb1018b3emr28314276.0.1729618275780; Tue, 22 Oct 2024 10:31:15
 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:09 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 11/16] perf env: Move arch errno function to only use in env
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move arch_syscalls__strerrno_function out of builtin-trace.c to env.c
so that there isn't a util to builtin function call. This allows the
python.c stub to be removed. Also, remove declaration/prototype from
env.h and make static to reduce scope.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c                  | 1 -
 tools/perf/trace/beauty/arch_errno_names.sh | 3 ++-
 tools/perf/util/env.c                       | 2 ++
 tools/perf/util/env.h                       | 2 --
 tools/perf/util/python.c                    | 6 ------
 5 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0b30297b4ecb..dbcf74a9e047 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1108,7 +1108,6 @@ static bool syscall_arg__strtoul_btf_type(char *bf __maybe_unused, size_t size _
 	    .strtoul	= STUL_STRARRAY_FLAGS, \
 	    .parm	= &strarray__##array, }
 
-#include "trace/beauty/arch_errno_names.c"
 #include "trace/beauty/eventfd.c"
 #include "trace/beauty/futex_op.c"
 #include "trace/beauty/futex_val3.c"
diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index 30d3889b2957..b22890b8d272 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -57,7 +57,8 @@ create_arch_errno_table_func()
 	archlist="$1"
 	default="$2"
 
-	printf 'arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch)\n'
+	printf 'static arch_syscalls__strerrno_t *\n'
+	printf 'arch_syscalls__strerrno_function(const char *arch)\n'
 	printf '{\n'
 	for arch in $archlist; do
 		arch_str=$(arch_string "$arch")
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 1edbccfc3281..a903917a09a4 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -22,6 +22,8 @@ struct perf_env perf_env;
 #include "bpf-utils.h"
 #include <bpf/libbpf.h>
 
+#include "trace/beauty/arch_errno_names.c"
+
 void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node)
 {
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 51b36c36019b..6a61ceff10bc 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -56,8 +56,6 @@ struct pmu_caps {
 
 typedef const char *(arch_syscalls__strerrno_t)(int err);
 
-arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch);
-
 struct perf_env {
 	char			*hostname;
 	char			*os_release;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 77e02fcc51dd..35d84a96dbec 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/env.h"
 #include "util/kwork.h"
 #include "util/sample.h"
 #include "util/lock-contention.h"
@@ -1305,11 +1304,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch __maybe_unused)
-{
-	return NULL;
-}
-
 struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
 				       struct kwork_class *class __maybe_unused,
 				       struct kwork_work *key  __maybe_unused)
-- 
2.47.0.163.g1226f6d8fa-goog

