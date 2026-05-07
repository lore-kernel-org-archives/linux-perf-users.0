Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647A3EC2F4
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173602; cv=none; b=bk5lal5TPNl6qH2jAHONuR7LouqlFLS4TyzMH6xO8M1RBahpyZNS9pmq69nPna6OY+4ZKT19qkMLj8dVvxk8yMJ1sLOjc6ce7zqAizv7+KQjvR6EWelUATo7eR69byyDRsgbnR68FtMXnitSGt5Qe9VPm9mKzOloID3ktar9gUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173602; c=relaxed/simple;
	bh=mcdWXHLT696Pdcv2pCYrxZgDlUv2AhV+X5HGQ7wEvyA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ZZ3i8tNPQHTkk7z1AMVTaqjNe9GG0sXd9Qz+4Fh+0cRkqrOlBmx3kbES6BQ6sU6fzmq8SiELwaHpzt5ZpzVdydoWhgGxbHPjAOO8X/MrR1wBzuOO5BStUnmPIO87/6t9WWK2bjOPm96fio1huf7sEMkVl8GN5A9sZ6Vb5hjoLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tV4kRAyR; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tV4kRAyR"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so1688441eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 May 2026 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778173598; x=1778778398; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NJTJITEGPdk/4GrzqRzWUaDaNlsNW/CyTKDJUYS/xvU=;
        b=tV4kRAyRg/SiT0ofUgM2PVqmKExv6fjW2Ttt155IupTyoQzqA6HNT7XHrdCoW9p62F
         eVNW+5mhNx/2fXGiLlF2LRNYLS+RUJlHmKj1F3MQhzCRvnenUyeVYqjpI6JxC/Cl6szg
         5+3jfebFQRKCg9otY22piBpdZ7L424P2Q+vT2N4z53pjdKy4rWdb5c6TKiAU1Pm4dP/I
         X5ovYRduXx/KOrQ1mZ0uKQadhNhQNiWKoXW9dU4bbkPV1y7boWKLbOr/tR0ZOzPOF7NF
         U4Pb2Jle1IPQ5YsnC0BPGjC9YzubAbEVBtJUNS6vFtEkZvEey5A23ScEeOwzi1JE4LUn
         pM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778173598; x=1778778398;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJTJITEGPdk/4GrzqRzWUaDaNlsNW/CyTKDJUYS/xvU=;
        b=gVrdTUZAdwLMj6nS56ol2lVPOAY73kIxRI+ZkRhSqfR9C5h2rw848okd+0S8XHWVMn
         hsfkDkbU87rS0I4bhNiG7UxUNH1pw3e6psKTbnaUmNJhFWnIrvVgE8m/wnDp/ztOMTbE
         X85bgu3tYCtf+J/9CnzeY4bTxN/gqzL16CrQ86/ILbWLafqBHJUJdM42fkJJtiZDKENz
         DvPnIYbFdo4YHmyI6Fp5/LoaZyn65nT2eO2Vb3bzq0TQ3HK+HxZmdQS6vS91wkoaO1pw
         5HjVAWMup61hhbQ6QGmaWEigvvIYa6QUgh19JvsmGAhL7WR9XPn31Xo5SrJ76+SX6cZy
         kmfA==
X-Forwarded-Encrypted: i=1; AFNElJ9Li4ygtEOTCGuxuLYv4e2aoalfvd3Fs9xbzgMJbRKrS7XuNfFi6QueHAQAZ+64CGA9oY/TJ2neZXLIid3VHUfu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56cQ8QGTehuuOntfRaXk7gTDRYLEucQyUZBJC+qVrH0PYAsGZ
	ykiUd2IqbgX5TURf7ifOzmLRTMJlt6njlxICAowcsyG9af4r9UEP1DStNk/cFkZuZlYlrNY0k76
	88DgNwGVFnw==
X-Received: from dlbrx21.prod.google.com ([2002:a05:7022:1715:b0:12f:1fa4:1a93])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2511:b0:130:6904:8c17
 with SMTP id a92af1059eb24-1319cc2a479mr4879365c88.18.1778173598210; Thu, 07
 May 2026 10:06:38 -0700 (PDT)
Date: Thu,  7 May 2026 10:06:22 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260507170622.611933-1-irogers@google.com>
Subject: [PATCH v1] perf record: Refactor ARM64 leaf caller setup out of arch
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Shimin Guo <shimin.guo@skydio.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Code in tools/perf/arch causes portability issues/opaqueness and LTO
issues due to the use of weak symbols. Move the adding of LR to the
sample_user_regs into arm64-frame-pointer-unwind-support.c conditional
on EM_HOST == EM_AARCH64 (false on all non-ARM64 builds). This also
better encapsulates the use of the sampled registers by
get_leaf_frame_caller_aarch64 and the set up by the new
add_leaf_frame_caller_opts_aarch64, exposing opportunities for
possibly sampling PC and SP to help the unwinder.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/Build                     |  1 -
 tools/perf/arch/arm64/util/machine.c                 | 12 ------------
 tools/perf/builtin-record.c                          | 11 +++++------
 tools/perf/util/arm64-frame-pointer-unwind-support.c |  6 ++++++
 tools/perf/util/arm64-frame-pointer-unwind-support.h |  2 ++
 5 files changed, 13 insertions(+), 19 deletions(-)
 delete mode 100644 tools/perf/arch/arm64/util/machine.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 4e06a08d281a..638aa6948ab5 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -5,7 +5,6 @@ perf-util-y += ../../arm/util/pmu.o
 perf-util-y += arm-spe.o
 perf-util-y += header.o
 perf-util-y += hisi-ptt.o
-perf-util-y += machine.o
 perf-util-y += mem-events.o
 perf-util-y += pmu.o
 perf-util-y += tsc.o
diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
deleted file mode 100644
index 80fb13c958d9..000000000000
--- a/tools/perf/arch/arm64/util/machine.c
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include "callchain.h" // prototype of arch__add_leaf_frame_record_opts
-#include "perf_regs.h"
-#include "record.h"
-
-#define SMPL_REG_MASK(b) (1ULL << (b))
-
-void arch__add_leaf_frame_record_opts(struct record_opts *opts)
-{
-	opts->sample_user_regs |= SMPL_REG_MASK(PERF_REG_ARM64_LR);
-}
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4a5eba498c02..272bba7f4b9e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -14,6 +14,7 @@
 #include "util/parse-events.h"
 #include "util/config.h"
 
+#include "util/arm64-frame-pointer-unwind-support.h"
 #include "util/callchain.h"
 #include "util/cgroup.h"
 #include "util/header.h"
@@ -3230,10 +3231,6 @@ static int record__parse_off_cpu_thresh(const struct option *opt,
 	return 0;
 }
 
-void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __maybe_unused)
-{
-}
-
 static int parse_control_option(const struct option *opt,
 				const char *str,
 				int unset __maybe_unused)
@@ -4319,8 +4316,10 @@ int cmd_record(int argc, const char **argv)
 
 	evlist__warn_user_requested_cpus(rec->evlist, rec->opts.target.cpu_list);
 
-	if (callchain_param.enabled && callchain_param.record_mode == CALLCHAIN_FP)
-		arch__add_leaf_frame_record_opts(&rec->opts);
+	if (callchain_param.enabled && callchain_param.record_mode == CALLCHAIN_FP) {
+		if (EM_HOST == EM_AARCH64)
+			add_leaf_frame_caller_opts_aarch64(&rec->opts);
+	}
 
 	err = -ENOMEM;
 	if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0) {
diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.c b/tools/perf/util/arm64-frame-pointer-unwind-support.c
index 858ce2b01812..3af8c7a466e0 100644
--- a/tools/perf/util/arm64-frame-pointer-unwind-support.c
+++ b/tools/perf/util/arm64-frame-pointer-unwind-support.c
@@ -2,6 +2,7 @@
 #include "arm64-frame-pointer-unwind-support.h"
 #include "callchain.h"
 #include "event.h"
+#include "record.h"
 #include "unwind.h"
 #include <string.h>
 
@@ -16,6 +17,11 @@ struct entries {
 
 #define SMPL_REG_MASK(b) (1ULL << (b))
 
+void add_leaf_frame_caller_opts_aarch64(struct record_opts *opts)
+{
+	opts->sample_user_regs |= SMPL_REG_MASK(PERF_REG_ARM64_LR);
+}
+
 static bool get_leaf_frame_caller_enabled(struct perf_sample *sample)
 {
 	struct regs_dump *regs;
diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.h b/tools/perf/util/arm64-frame-pointer-unwind-support.h
index 42d3a45490f5..ba35b295bfcd 100644
--- a/tools/perf/util/arm64-frame-pointer-unwind-support.h
+++ b/tools/perf/util/arm64-frame-pointer-unwind-support.h
@@ -5,8 +5,10 @@
 #include <linux/types.h>
 
 struct perf_sample;
+struct record_opts;
 struct thread;
 
+void add_leaf_frame_caller_opts_aarch64(struct record_opts *opts);
 u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread, int user_idx);
 
 #endif /* __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H */
-- 
2.54.0.545.g6539524ca2-goog

