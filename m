Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3473D6CA6
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 05:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564519; cv=none; b=WKuvrHA638+9KP6faYAprj48JM1Ffxmd8+WpMOw04OwUfn8CkCcniKoCbS09926yerG57BKAGf3HnSZE14gd+tdlfxZx5YIjafwNTecEBVU03MB3et+BJXiXYRQTcetOiVCAzTJsCMbSAoZ74ceo5USGNyxYEwu2Lzn+HXVK9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564519; c=relaxed/simple;
	bh=AhkIDHkSUw/Ww9+e8WRxd2D5oAlbbwkSgqtw2fo2L2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GbNv8roNDHrYH9yVQ4W/GsWvuoxQ1ksc0pGn3X7Kl7UWez7JR0bHkOHxWkBwI93U4w40EJDUtoW6WCyio6CvijZgTXBKEy8UstrlHC0209pxr8OMZ3KeqObMAMmp2lSGwNePCRSN5ePwujrcAXDk1PsG+m9ud4osXT6KlUM3iiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRsVQn5R; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRsVQn5R"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f5943ca81aso6184520eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 22:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564504; x=1779169304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vkhmEf7l/p3H+evY3e6sZCpcHnKb11tYhtK4qTF0OHU=;
        b=SRsVQn5RDGNPO48McY01WPh7gvZkj+6/jbzdGg49UOGMrKNC1lH5HRj94JK5ZSQskD
         dJWBMps1XY8qED+lH3wG16vDx/iSWpwNaJUJhB4x7MM//R/IHXjRzviu6f1qzJiKCsPq
         IeTUOkLHNXlym+WCgRIlcgF0cjAM2ttztClREOkkviIFwB4+zy73pUpbxB8tMiojwoMb
         wwT1bkcZGyIHXu1FawBN0VPNSCxGDhZVNDMpfEEHMpS/x5T4uasieWfeCh22Y6QDKF+f
         J0HWQLOAz3hot87YwkTpi7zxfgwPgE7qygI87lV7OHl+wx5OZdIrAqEcUlnFWSm3K8eN
         fyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564504; x=1779169304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vkhmEf7l/p3H+evY3e6sZCpcHnKb11tYhtK4qTF0OHU=;
        b=jMy0UrRupg7LhrxQlxHzer1+P7ISvXFeWscBapIJo2OOrzs2ZwdOI1D5Qa8iqPdhRc
         5l2ZGgc6Fa3Z89vFPdsQCn8CtuJSQSTmi0aI7/BqWhpMwEW0vAkJF+27nFnRtBufOOH/
         NSlfhl7V52AE31j49T4qyH+xKf5crqUTWm1+zr6o8yWcr1WLEnwSHCmZkl80tzy/9sA/
         jNpSJytlDnEoThx0UQls0yqYZdvlD0EhPyOBhUAz6JQkpJOJaXzKYhoenRcmHZ2RrqM5
         HEYSLvLW73ssCorcG5V4yG2xCicU/aLv3wWsYklCwQJeJcs3Oz4E0zH/FBrnSmP3KSsi
         cBDw==
X-Forwarded-Encrypted: i=1; AFNElJ9SeGNtnqv/5HTrjM6sbHbq3xfILrNaBEt9h32sbY7UL9hB4IK+oRdqxA6NOQb4vuoaLTG2XVZ2Bq6JPRDaYEU2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk1BdxFNCyt97cRtRMTMbVXgefTnZ6M5g7C5Nu4tio9Dk0jogv
	hv8m2fflis+JmCcyjMZt6ns+PhQg+aWg0FsBMtsgPhbJwd7RLjvJ4H1MplVrMQP7wwuu3Tpgarn
	uxWasgZEdhg==
X-Received: from dlbbt1.prod.google.com ([2002:a05:7022:981:b0:12d:c585:f600])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec07:b0:130:9b78:b17b
 with SMTP id a92af1059eb24-132a83ed506mr6504466c88.38.1778564503592; Mon, 11
 May 2026 22:41:43 -0700 (PDT)
Date: Mon, 11 May 2026 22:41:40 -0700
In-Reply-To: <20260507170622.611933-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507170622.611933-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512054140.3427725-1-irogers@google.com>
Subject: [PATCH v2] perf record: Refactor ARM64 leaf caller setup out of arch
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, james.clark@linaro.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	dapeng1.mi@linux.intel.com, john.g.garry@oracle.com, jolsa@kernel.org, 
	leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mike.leach@arm.com, mingo@redhat.com, 
	peterz@infradead.org, shimin.guo@skydio.com, will@kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Code in tools/perf/arch causes portability issues/opaqueness and LTO
issues due to the use of weak symbols. Move the adding of LR to the
sample_user_regs into arm64-frame-pointer-unwind-support.c conditional
on EM_HOST == EM_AARCH64 (false on all non-ARM64 builds). This also
better encapsulates the use of the sampled registers by
get_leaf_frame_caller_aarch64 and the set up by the new
add_leaf_frame_caller_opts_aarch64, exposing opportunities for
possibly sampling PC and SP to help the unwinder.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/Build                     |  1 -
 tools/perf/arch/arm64/util/machine.c                 | 12 ------------
 tools/perf/builtin-record.c                          | 11 +++++------
 tools/perf/util/arm64-frame-pointer-unwind-support.c |  6 ++++++
 tools/perf/util/arm64-frame-pointer-unwind-support.h |  2 ++
 tools/perf/util/callchain.h                          |  2 --
 6 files changed, 13 insertions(+), 21 deletions(-)
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
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 06d463ccc7a0..b7702d65ad60 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -277,8 +277,6 @@ static inline int arch_skip_callchain_idx(struct thread *thread __maybe_unused,
 }
 #endif
 
-void arch__add_leaf_frame_record_opts(struct record_opts *opts);
-
 char *callchain_list__sym_name(struct callchain_list *cl,
 			       char *bf, size_t bfsize, bool show_dso);
 char *callchain_node__scnprintf_value(struct callchain_node *node,
-- 
2.54.0.563.g4f69b47b94-goog

