Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE3228CB8
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769586073; cv=none; b=FvmT6lENbEccw79jtPKSVi5Pq+tTR2x5ODYcRliW9RtN82INxwnrsUujwteTcfWssFLorgLoTSSPMHXbBTfj1xH/kb62E6aI13WTcXxtaYWIhRLUEhmIDhrHVT9RYYEWiDpgMoWfZOxWpG3XVXV70vw07x0LElxsBeuteXNwKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769586073; c=relaxed/simple;
	bh=ZYZ3ts2lEXpoAv2DKF+vERbCqS03n0zKhJZN6rN/scE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=O9ntgbX6eHuOSOQGLNXTEI/bY9DL2zivYKCrE5zBaT0Ye5IvlN6gTa3w1ZgOxTqmGs2hZ30FWpUSNVxCXf0hl/z+p853sJcrkI72NF0h7jtVycjfVEw6FWBTG/dhUPKycVBWCRT7xBtiqLOnSqW/snnEPC5eLQIBubfSRf72ikU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZLRHC7Fb; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLRHC7Fb"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1233b91de6bso11198965c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 23:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769586069; x=1770190869; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X1yac3VhavJ/iSNuoTf4tOpLzxqJ/EDuq8aVrMeVv+k=;
        b=ZLRHC7FbS6ECRGCNG+1od8orlgrt5ldvyDF7EhAnODdqs0kJq1a83k/YNPckE9LfIV
         08Nmh6MVycWAG9wSLcj/aRY8v6ZiMgKMq4AyZxqnYUExqae4vl3n8IYfqf+sl5VhAnZE
         cJUfdy/EKcX08cYQzOjsZDvV9jABh7Q9R52wZjnqKVwUrXq7d9QDp/wnSSNK8agg/ga1
         71PlCfHbbrca+7lvhLXSEtLr7BkExO2gjmdtSvq9YDx3wAi/U9WIIksn/eb83cIjqBHF
         7Qb81PTMgMh1Z8joc8opdMRm4tcu+yeg7Oef7mVdF7mXJ1gYLPFQLYSSTNNpp8TVSqp1
         ehYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769586069; x=1770190869;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1yac3VhavJ/iSNuoTf4tOpLzxqJ/EDuq8aVrMeVv+k=;
        b=F7IzIK0s23MrUE6YPAzkOcXFro9IxirBKVvN44kJF9Fn+BRlO2VMukZu10goxrpLrG
         GYKCt9xVWGpaLUZsAZ4RbhRmDanySS/OpsTWDuALcOsEGPy/ZQfphEz+TCppKslEfRLu
         x2eLcJ1wS0uBMPsKttX2XUNB1ABlV6zMT1pvFd+YMJCDvhIuBECukGxj17G1UH67LBaW
         zwfaKRXXdZepzInZygAZj7ORtD+NmEbCOArGXwYAxKhAQ+XGVfwvDwv+1gixjbPWQiQS
         1koB+tkoEojqQTQHZFrcA2f2hDO3qUZpsXd1u1C5KkVHWdC7rN0ijwOP2FMy47IZE7Oz
         flYA==
X-Forwarded-Encrypted: i=1; AJvYcCXwD4zu5uPavcQYlcj46Cn9Rv31jMXRNWm30qAFyZRD2VuMswRyjd4CCK0K1mz8C6R7PGhK5ooozrICUM5XyPHy@vger.kernel.org
X-Gm-Message-State: AOJu0YzGl6KtWmutT8tGaTe2ZgFIr7ENLrrH+ND+VqA4UNhokU/zhWS+
	AQIBP7Jxw8w11E8r3/p86v50jvYa/lEgWqW7hibxpwB2AQmsHhRwBb6FGYuCO/SiWYUz0ICz0gU
	hME5I9pwo/Q==
X-Received: from dlnn5.prod.google.com ([2002:a05:7022:6185:b0:11f:30f6:ea10])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fa3:b0:123:35cb:96e3
 with SMTP id a92af1059eb24-124a00e4d53mr2943505c88.46.1769586069175; Tue, 27
 Jan 2026 23:41:09 -0800 (PST)
Date: Tue, 27 Jan 2026 23:41:05 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260128074106.788156-1-irogers@google.com>
Subject: [PATCH v1] perf kvm stat: Remove use of the arch directory
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, Yunseong Kim <ysk@kzalloc.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Quan Zhou <zhouquan@iscas.ac.cn>, Andrew Jones <ajones@ventanamicro.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

`perf kvm stat` supports record and report options. By using the arch
directory a report for a different machine type cannot be
supported. Move the kvm-stat code out of the arch directory and into
util/kvm-stat-arch following the pattern of perf-regs and
dwarf-regs. Avoid duplicate symbols by renaming functions to have the
architecture name within them. For global variables, wrap them in an
architecture specific function. Selecting the architecture to use with
`perf kvm stat` is selected by EM_HOST, ie no different than before
the change. When the ELF machine can be determined from a header
feature (ie EM_HOST at the time of the record) then this can change.

The build and #define HAVE_KVM_STAT_SUPPORT is now redundant so remove
across Makefiles and in the build.

Opportunistically constify architectural structs and arrays.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config                    |   4 -
 tools/perf/arch/arm64/Makefile                |   1 -
 tools/perf/arch/arm64/util/Build              |   1 -
 tools/perf/arch/loongarch/Makefile            |   1 -
 tools/perf/arch/loongarch/util/Build          |   1 -
 tools/perf/arch/powerpc/Makefile              |   1 -
 tools/perf/arch/powerpc/util/Build            |   1 -
 tools/perf/arch/riscv/Makefile                |   1 -
 tools/perf/arch/riscv/util/Build              |   2 -
 tools/perf/arch/s390/Makefile                 |   1 -
 tools/perf/arch/s390/util/Build               |   1 -
 tools/perf/arch/x86/Makefile                  |   1 -
 tools/perf/arch/x86/util/Build                |   1 -
 tools/perf/builtin-kvm.c                      |  37 ++--
 tools/perf/util/Build                         |   3 +-
 .../kvm-stat-arch}/arm64_exception_types.h    |   0
 .../kvm-stat-arch}/book3s_hcalls.h            |   0
 .../kvm-stat-arch}/book3s_hv_exits.h          |   0
 .../kvm-stat-arch/kvm-stat-arm64.c}           |  43 ++--
 .../kvm-stat-arch/kvm-stat-loongarch.c}       |  48 ++--
 .../kvm-stat-arch/kvm-stat-powerpc.c}         |  61 ++---
 .../kvm-stat-arch/kvm-stat-riscv.c}           |  42 ++--
 .../kvm-stat-arch/kvm-stat-s390.c}            |  38 ++--
 .../kvm-stat-arch/kvm-stat-x86.c}             |  44 ++--
 .../kvm-stat-arch}/riscv_trap_types.h         |   2 +-
 tools/perf/util/kvm-stat.c                    | 209 +++++++++++++++++-
 tools/perf/util/kvm-stat.h                    |  68 ++++--
 27 files changed, 434 insertions(+), 178 deletions(-)
 rename tools/perf/{arch/arm64/util => util/kvm-stat-arch}/arm64_exception_types.h (100%)
 rename tools/perf/{arch/powerpc/util => util/kvm-stat-arch}/book3s_hcalls.h (100%)
 rename tools/perf/{arch/powerpc/util => util/kvm-stat-arch}/book3s_hv_exits.h (100%)
 rename tools/perf/{arch/arm64/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-arm64.c} (63%)
 rename tools/perf/{arch/loongarch/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-loongarch.c} (78%)
 rename tools/perf/{arch/powerpc/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-powerpc.c} (78%)
 rename tools/perf/{arch/riscv/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-riscv.c} (58%)
 rename tools/perf/{arch/s390/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-s390.c} (77%)
 rename tools/perf/{arch/x86/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-x86.c} (88%)
 rename tools/perf/{arch/riscv/util => util/kvm-stat-arch}/riscv_trap_types.h (96%)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 63ca9b2be663..c7e493245f34 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1033,10 +1033,6 @@ ifndef NO_LIBNUMA
   endif
 endif
 
-ifdef HAVE_KVM_STAT_SUPPORT
-    CFLAGS += -DHAVE_KVM_STAT_SUPPORT
-endif
-
 ifeq (${IS_64_BIT}, 1)
   ifndef NO_PERF_READ_VDSO32
     $(call feature_check,compile-32)
diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index 087e099fb453..44cc3f023318 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
 PERF_HAVE_JITDUMP := 1
-HAVE_KVM_STAT_SUPPORT := 1
diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 0177af19cc00..d25edd9e1883 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,4 +1,3 @@
-perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-util-y += ../../arm/util/auxtrace.o
 perf-util-y += ../../arm/util/cs-etm.o
diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
index 087e099fb453..44cc3f023318 100644
--- a/tools/perf/arch/loongarch/Makefile
+++ b/tools/perf/arch/loongarch/Makefile
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
 PERF_HAVE_JITDUMP := 1
-HAVE_KVM_STAT_SUPPORT := 1
diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
index 0aa31986ecb5..1cb06a5f8935 100644
--- a/tools/perf/arch/loongarch/util/Build
+++ b/tools/perf/arch/loongarch/util/Build
@@ -3,4 +3,3 @@ perf-util-y += perf_regs.o
 
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
-perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index a295a80ea078..44cc3f023318 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 5fd28ec713a4..e091b6785674 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -1,5 +1,4 @@
 perf-util-y += header.o
-perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-util-y += perf_regs.o
 perf-util-y += mem-events.o
 perf-util-y += pmu.o
diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
index 087e099fb453..44cc3f023318 100644
--- a/tools/perf/arch/riscv/Makefile
+++ b/tools/perf/arch/riscv/Makefile
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
 PERF_HAVE_JITDUMP := 1
-HAVE_KVM_STAT_SUPPORT := 1
diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
index 628b9ebd418b..c01231bcf9c3 100644
--- a/tools/perf/arch/riscv/util/Build
+++ b/tools/perf/arch/riscv/util/Build
@@ -1,4 +1,2 @@
 perf-util-y += perf_regs.o
 perf-util-y += header.o
-
-perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 0033698a65ce..8b59ce8efb89 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
index 5391d26fedd4..87229f2c4397 100644
--- a/tools/perf/arch/s390/util/Build
+++ b/tools/perf/arch/s390/util/Build
@@ -1,5 +1,4 @@
 perf-util-y += header.o
-perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-util-y += perf_regs.o
 
 perf-util-y += machine.o
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index a295a80ea078..44cc3f023318 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 76127eefde8b..0c4cf1dd07bf 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -1,7 +1,6 @@
 perf-util-y += header.o
 perf-util-y += tsc.o
 perf-util-y += pmu.o
-perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-util-y += perf_regs.o
 perf-util-y += topdown.o
 perf-util-y += machine.o
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index c61369d54dd9..bd9bda32157f 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -52,7 +52,7 @@
 #include <math.h>
 #include <perf/mmap.h>
 
-#if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+#if defined(HAVE_LIBTRACEEVENT)
 #define GET_EVENT_KEY(func, field)					\
 static u64 get_event_ ##func(struct kvm_event *event, int vcpu)		\
 {									\
@@ -597,7 +597,7 @@ static void kvm_display(struct perf_kvm_stat *kvm)
 
 #endif /* HAVE_SLANG_SUPPORT */
 
-#endif // defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+#endif // defined(HAVE_LIBTRACEEVENT)
 
 static const char *get_filename_for_perf_kvm(void)
 {
@@ -613,13 +613,13 @@ static const char *get_filename_for_perf_kvm(void)
 	return filename;
 }
 
-#if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+#if defined(HAVE_LIBTRACEEVENT)
 
 static bool register_kvm_events_ops(struct perf_kvm_stat *kvm)
 {
-	struct kvm_reg_events_ops *events_ops = kvm_reg_events_ops;
+	const struct kvm_reg_events_ops *events_ops;
 
-	for (events_ops = kvm_reg_events_ops; events_ops->name; events_ops++) {
+	for (events_ops = kvm_reg_events_ops(); events_ops->name; events_ops++) {
 		if (!strcmp(events_ops->name, kvm->report_event)) {
 			kvm->events_ops = events_ops->ops;
 			return true;
@@ -809,7 +809,7 @@ static bool is_child_event(struct perf_kvm_stat *kvm,
 			   struct perf_sample *sample,
 			   struct event_key *key)
 {
-	struct child_event_ops *child_ops;
+	const struct child_event_ops *child_ops;
 
 	child_ops = kvm->events_ops->child_ops;
 
@@ -845,7 +845,7 @@ static bool skip_event(const char *event)
 {
 	const char * const *skip_events;
 
-	for (skip_events = kvm_skip_events; *skip_events; skip_events++)
+	for (skip_events = kvm_skip_events(); *skip_events; skip_events++)
 		if (!strcmp(event, *skip_events))
 			return true;
 
@@ -928,7 +928,7 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,
 			return NULL;
 		}
 
-		vcpu_record->vcpu_id = evsel__intval(evsel, sample, vcpu_id_str);
+		vcpu_record->vcpu_id = evsel__intval(evsel, sample, vcpu_id_str());
 		thread__set_priv(thread, vcpu_record);
 	}
 
@@ -1636,11 +1636,6 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	return ret;
 }
 
-int __weak setup_kvm_events_tp(struct perf_kvm_stat *kvm __maybe_unused)
-{
-	return 0;
-}
-
 static int
 kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 {
@@ -1666,7 +1661,7 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 		return ret;
 	}
 
-	for (events_tp = kvm_events_tp; *events_tp; events_tp++)
+	for (events_tp = kvm_events_tp(); *events_tp; events_tp++)
 		events_tp_size++;
 
 	rec_argc = ARRAY_SIZE(record_args) + argc + 2 +
@@ -1681,7 +1676,7 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 
 	for (j = 0; j < events_tp_size; j++) {
 		rec_argv[i++] = STRDUP_FAIL_EXIT("-e");
-		rec_argv[i++] = STRDUP_FAIL_EXIT(kvm_events_tp[j]);
+		rec_argv[i++] = STRDUP_FAIL_EXIT(kvm_events_tp()[j]);
 	}
 
 	rec_argv[i++] = STRDUP_FAIL_EXIT("-o");
@@ -1775,7 +1770,7 @@ static struct evlist *kvm_live_event_list(void)
 	if (evlist == NULL)
 		return NULL;
 
-	for (events_tp = kvm_events_tp; *events_tp; events_tp++) {
+	for (events_tp = kvm_events_tp(); *events_tp; events_tp++) {
 
 		tp = strdup(*events_tp);
 		if (tp == NULL)
@@ -1985,13 +1980,7 @@ static int kvm_cmd_stat(const char *file_name, int argc, const char **argv)
 perf_stat:
 	return cmd_stat(argc, argv);
 }
-#endif /* HAVE_KVM_STAT_SUPPORT */
-
-int __weak kvm_add_default_arch_event(int *argc __maybe_unused,
-					const char **argv __maybe_unused)
-{
-	return 0;
-}
+#endif /* HAVE_LIBTRACEEVENT */
 
 static int __cmd_record(const char *file_name, int argc, const char **argv)
 {
@@ -2179,7 +2168,7 @@ int cmd_kvm(int argc, const char **argv)
 		return __cmd_top(argc, argv);
 	else if (strlen(argv[0]) > 2 && strstarts("buildid-list", argv[0]))
 		return __cmd_buildid_list(file_name, argc, argv);
-#if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+#if defined(HAVE_LIBTRACEEVENT)
 	else if (strlen(argv[0]) > 2 && strstarts("stat", argv[0]))
 		return kvm_cmd_stat(file_name, argc, argv);
 #endif
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b9925c6902ca..2852ba0f3d4d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -128,7 +128,8 @@ perf-util-y += spark.o
 perf-util-y += topdown.o
 perf-util-y += iostat.o
 perf-util-y += stream.o
-perf-util-y += kvm-stat.o
+perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
+perf-util-y += kvm-stat-arch/
 perf-util-y += lock-contention.o
 perf-util-y += auxtrace.o
 perf-util-y += intel-pt-decoder/
diff --git a/tools/perf/arch/arm64/util/arm64_exception_types.h b/tools/perf/util/kvm-stat-arch/arm64_exception_types.h
similarity index 100%
rename from tools/perf/arch/arm64/util/arm64_exception_types.h
rename to tools/perf/util/kvm-stat-arch/arm64_exception_types.h
diff --git a/tools/perf/arch/powerpc/util/book3s_hcalls.h b/tools/perf/util/kvm-stat-arch/book3s_hcalls.h
similarity index 100%
rename from tools/perf/arch/powerpc/util/book3s_hcalls.h
rename to tools/perf/util/kvm-stat-arch/book3s_hcalls.h
diff --git a/tools/perf/arch/powerpc/util/book3s_hv_exits.h b/tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
similarity index 100%
rename from tools/perf/arch/powerpc/util/book3s_hv_exits.h
rename to tools/perf/util/kvm-stat-arch/book3s_hv_exits.h
diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
similarity index 63%
rename from tools/perf/arch/arm64/util/kvm-stat.c
rename to tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
index 6611aa21cba9..8003ff415b1a 100644
--- a/tools/perf/arch/arm64/util/kvm-stat.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
@@ -1,21 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <memory.h>
-#include "../../../util/evsel.h"
-#include "../../../util/kvm-stat.h"
+#include "../debug.h"
+#include "../evsel.h"
+#include "../kvm-stat.h"
 #include "arm64_exception_types.h"
-#include "debug.h"
 
 define_exit_reasons_table(arm64_exit_reasons, kvm_arm_exception_type);
 define_exit_reasons_table(arm64_trap_exit_reasons, kvm_arm_exception_class);
 
-const char *kvm_trap_exit_reason = "esr_ec";
-const char *vcpu_id_str = "id";
-const char *kvm_exit_reason = "ret";
-const char *kvm_entry_trace = "kvm:kvm_entry";
-const char *kvm_exit_trace = "kvm:kvm_exit";
+static const char *kvm_trap_exit_reason = "esr_ec";
 
-const char *kvm_events_tp[] = {
+static const char * const __kvm_events_tp[] = {
 	"kvm:kvm_entry",
 	"kvm:kvm_exit",
 	NULL,
@@ -26,7 +22,7 @@ static void event_get_key(struct evsel *evsel,
 			  struct event_key *key)
 {
 	key->info = 0;
-	key->key = evsel__intval(evsel, sample, kvm_exit_reason);
+	key->key = evsel__intval(evsel, sample, kvm_exit_reason());
 	key->exit_reasons = arm64_exit_reasons;
 
 	/*
@@ -44,28 +40,28 @@ static bool event_begin(struct evsel *evsel,
 			struct perf_sample *sample __maybe_unused,
 			struct event_key *key __maybe_unused)
 {
-	return evsel__name_is(evsel, kvm_entry_trace);
+	return evsel__name_is(evsel, kvm_entry_trace());
 }
 
 static bool event_end(struct evsel *evsel,
 		      struct perf_sample *sample,
 		      struct event_key *key)
 {
-	if (evsel__name_is(evsel, kvm_exit_trace)) {
+	if (evsel__name_is(evsel, kvm_exit_trace())) {
 		event_get_key(evsel, sample, key);
 		return true;
 	}
 	return false;
 }
 
-static struct kvm_events_ops exit_events = {
+static const struct kvm_events_ops exit_events = {
 	.is_begin_event = event_begin,
 	.is_end_event	= event_end,
 	.decode_key	= exit_event_decode_key,
 	.name		= "VM-EXIT"
 };
 
-struct kvm_reg_events_ops kvm_reg_events_ops[] = {
+static const struct kvm_reg_events_ops __kvm_reg_events_ops[] = {
 	{
 		.name	= "vmexit",
 		.ops	= &exit_events,
@@ -73,12 +69,27 @@ struct kvm_reg_events_ops kvm_reg_events_ops[] = {
 	{ NULL, NULL },
 };
 
-const char * const kvm_skip_events[] = {
+static const char * const __kvm_skip_events[] = {
 	NULL,
 };
 
-int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
+int __cpu_isa_init_arm64(struct perf_kvm_stat *kvm)
 {
 	kvm->exit_reasons_isa = "arm64";
 	return 0;
 }
+
+const char * const *__kvm_events_tp_arm64(void)
+{
+	return __kvm_events_tp;
+}
+
+const struct kvm_reg_events_ops *__kvm_reg_events_ops_arm64(void)
+{
+	return __kvm_reg_events_ops;
+}
+
+const char * const *__kvm_skip_events_arm64(void)
+{
+	return __kvm_skip_events;
+}
diff --git a/tools/perf/arch/loongarch/util/kvm-stat.c b/tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c
similarity index 78%
rename from tools/perf/arch/loongarch/util/kvm-stat.c
rename to tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c
index a7859a3a9a51..a15ce072ac34 100644
--- a/tools/perf/arch/loongarch/util/kvm-stat.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <memory.h>
-#include "util/kvm-stat.h"
-#include "util/parse-events.h"
-#include "util/debug.h"
-#include "util/evsel.h"
-#include "util/evlist.h"
-#include "util/pmus.h"
+#include "../kvm-stat.h"
+#include "../parse-events.h"
+#include "../debug.h"
+#include "../evsel.h"
+#include "../evlist.h"
+#include "../pmus.h"
 
 #define LOONGARCH_EXCEPTION_INT		0
 #define LOONGARCH_EXCEPTION_PIL		1
@@ -43,12 +43,8 @@
 
 define_exit_reasons_table(loongarch_exit_reasons, loongarch_exception_type);
 
-const char *vcpu_id_str = "vcpu_id";
-const char *kvm_exit_reason = "reason";
-const char *kvm_entry_trace = "kvm:kvm_enter";
-const char *kvm_reenter_trace = "kvm:kvm_reenter";
-const char *kvm_exit_trace = "kvm:kvm_exit";
-const char *kvm_events_tp[] = {
+static const char *kvm_reenter_trace = "kvm:kvm_reenter";
+static const char * const __kvm_events_tp[] = {
 	"kvm:kvm_enter",
 	"kvm:kvm_reenter",
 	"kvm:kvm_exit",
@@ -74,7 +70,8 @@ static bool event_end(struct evsel *evsel,
 	 *   kvm:kvm_enter   means returning to vmm and then to guest
 	 *   kvm:kvm_reenter means returning to guest immediately
 	 */
-	return evsel__name_is(evsel, kvm_entry_trace) || evsel__name_is(evsel, kvm_reenter_trace);
+	return evsel__name_is(evsel, kvm_entry_trace()) ||
+	       evsel__name_is(evsel, kvm_reenter_trace);
 }
 
 static void event_gspr_get_key(struct evsel *evsel,
@@ -109,12 +106,12 @@ static void event_gspr_get_key(struct evsel *evsel,
 	}
 }
 
-static struct child_event_ops child_events[] = {
+static const struct child_event_ops child_events[] = {
 	{ .name = "kvm:kvm_exit_gspr", .get_key = event_gspr_get_key },
 	{ NULL, NULL },
 };
 
-static struct kvm_events_ops exit_events = {
+static const struct kvm_events_ops exit_events = {
 	.is_begin_event = event_begin,
 	.is_end_event = event_end,
 	.child_ops = child_events,
@@ -122,18 +119,33 @@ static struct kvm_events_ops exit_events = {
 	.name = "VM-EXIT"
 };
 
-struct kvm_reg_events_ops kvm_reg_events_ops[] = {
+static const struct kvm_reg_events_ops __kvm_reg_events_ops[] = {
 	{ .name	= "vmexit", .ops = &exit_events, },
 	{ NULL, NULL },
 };
 
-const char * const kvm_skip_events[] = {
+static const char * const __kvm_skip_events[] = {
 	NULL,
 };
 
-int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
+int __cpu_isa_init_loongarch(struct perf_kvm_stat *kvm)
 {
 	kvm->exit_reasons_isa = "loongarch64";
 	kvm->exit_reasons = loongarch_exit_reasons;
 	return 0;
 }
+
+const char * const *__kvm_events_tp_loongarch(void)
+{
+	return __kvm_events_tp;
+}
+
+const struct kvm_reg_events_ops *__kvm_reg_events_ops_loongarch(void)
+{
+	return __kvm_reg_events_ops;
+}
+
+const char * const *__kvm_skip_events_loongarch(void)
+{
+	return __kvm_skip_events;
+}
diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
similarity index 78%
rename from tools/perf/arch/powerpc/util/kvm-stat.c
rename to tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
index c8357b571ccf..42182d70beb6 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
-#include "util/kvm-stat.h"
-#include "util/parse-events.h"
-#include "util/debug.h"
-#include "util/evsel.h"
-#include "util/evlist.h"
-#include "util/pmus.h"
+#include "../kvm-stat.h"
+#include "../parse-events.h"
+#include "../debug.h"
+#include "../evsel.h"
+#include "../evlist.h"
+#include "../pmus.h"
 
 #include "book3s_hv_exits.h"
 #include "book3s_hcalls.h"
@@ -13,15 +13,11 @@
 
 #define NR_TPS 4
 
-const char *vcpu_id_str = "vcpu_id";
-const char *kvm_entry_trace = "kvm_hv:kvm_guest_enter";
-const char *kvm_exit_trace = "kvm_hv:kvm_guest_exit";
-
 define_exit_reasons_table(hv_exit_reasons, kvm_trace_symbol_exit);
 define_exit_reasons_table(hcall_reasons, kvm_trace_symbol_hcall);
 
 /* Tracepoints specific to ppc_book3s_hv */
-const char *ppc_book3s_hv_kvm_tp[] = {
+static const char * const ppc_book3s_hv_kvm_tp[] = {
 	"kvm_hv:kvm_guest_enter",
 	"kvm_hv:kvm_guest_exit",
 	"kvm_hv:kvm_hcall_enter",
@@ -30,8 +26,7 @@ const char *ppc_book3s_hv_kvm_tp[] = {
 };
 
 /* 1 extra placeholder for NULL */
-const char *kvm_events_tp[NR_TPS + 1];
-const char *kvm_exit_reason;
+static const char *__kvm_events_tp[NR_TPS + 1];
 
 static void hcall_event_get_key(struct evsel *evsel,
 				struct perf_sample *sample,
@@ -60,13 +55,13 @@ static bool hcall_event_end(struct evsel *evsel,
 			    struct perf_sample *sample __maybe_unused,
 			    struct event_key *key __maybe_unused)
 {
-	return (evsel__name_is(evsel, kvm_events_tp[3]));
+	return evsel__name_is(evsel, __kvm_events_tp[3]);
 }
 
 static bool hcall_event_begin(struct evsel *evsel,
 			      struct perf_sample *sample, struct event_key *key)
 {
-	if (evsel__name_is(evsel, kvm_events_tp[2])) {
+	if (evsel__name_is(evsel, __kvm_events_tp[2])) {
 		hcall_event_get_key(evsel, sample, key);
 		return true;
 	}
@@ -82,27 +77,27 @@ static void hcall_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
 	scnprintf(decode, KVM_EVENT_NAME_LEN, "%s", hcall_reason);
 }
 
-static struct kvm_events_ops hcall_events = {
+static const struct kvm_events_ops hcall_events = {
 	.is_begin_event = hcall_event_begin,
 	.is_end_event = hcall_event_end,
 	.decode_key = hcall_event_decode_key,
 	.name = "HCALL-EVENT",
 };
 
-static struct kvm_events_ops exit_events = {
+static const struct kvm_events_ops exit_events = {
 	.is_begin_event = exit_event_begin,
 	.is_end_event = exit_event_end,
 	.decode_key = exit_event_decode_key,
 	.name = "VM-EXIT"
 };
 
-struct kvm_reg_events_ops kvm_reg_events_ops[] = {
+static const struct kvm_reg_events_ops __kvm_reg_events_ops[] = {
 	{ .name = "vmexit", .ops = &exit_events },
 	{ .name = "hcall", .ops = &hcall_events },
 	{ NULL, NULL },
 };
 
-const char * const kvm_skip_events[] = {
+static const char * const __kvm_skip_events[] = {
 	NULL,
 };
 
@@ -123,7 +118,7 @@ static int is_tracepoint_available(const char *str, struct evlist *evlist)
 static int ppc__setup_book3s_hv(struct perf_kvm_stat *kvm,
 				struct evlist *evlist)
 {
-	const char **events_ptr;
+	const char * const *events_ptr;
 	int i, nr_tp = 0, err = -1;
 
 	/* Check for book3s_hv tracepoints */
@@ -135,10 +130,9 @@ static int ppc__setup_book3s_hv(struct perf_kvm_stat *kvm,
 	}
 
 	for (i = 0; i < nr_tp; i++)
-		kvm_events_tp[i] = ppc_book3s_hv_kvm_tp[i];
+		__kvm_events_tp[i] = ppc_book3s_hv_kvm_tp[i];
 
-	kvm_events_tp[i] = NULL;
-	kvm_exit_reason = "trap";
+	__kvm_events_tp[i] = NULL;
 	kvm->exit_reasons = hv_exit_reasons;
 	kvm->exit_reasons_isa = "HV";
 
@@ -157,12 +151,12 @@ static int ppc__setup_kvm_tp(struct perf_kvm_stat *kvm)
 	return ppc__setup_book3s_hv(kvm, evlist);
 }
 
-int setup_kvm_events_tp(struct perf_kvm_stat *kvm)
+int __setup_kvm_events_tp_powerpc(struct perf_kvm_stat *kvm)
 {
 	return ppc__setup_kvm_tp(kvm);
 }
 
-int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
+int __cpu_isa_init_powerpc(struct perf_kvm_stat *kvm)
 {
 	int ret;
 
@@ -184,7 +178,7 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
  *
  * Function to parse the arguments and return appropriate values.
  */
-int kvm_add_default_arch_event(int *argc, const char **argv)
+int __kvm_add_default_arch_event_powerpc(int *argc, const char **argv)
 {
 	const char **tmp;
 	bool event = false;
@@ -217,3 +211,18 @@ int kvm_add_default_arch_event(int *argc, const char **argv)
 	free(tmp);
 	return 0;
 }
+
+const char * const *__kvm_events_tp_powerpc(void)
+{
+	return __kvm_events_tp;
+}
+
+const struct kvm_reg_events_ops *__kvm_reg_events_ops_powerpc(void)
+{
+	return __kvm_reg_events_ops;
+}
+
+const char * const *__kvm_skip_events_powerpc(void)
+{
+	return __kvm_skip_events;
+}
diff --git a/tools/perf/arch/riscv/util/kvm-stat.c b/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
similarity index 58%
rename from tools/perf/arch/riscv/util/kvm-stat.c
rename to tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
index 3ea7acb5e159..b2c5d3220795 100644
--- a/tools/perf/arch/riscv/util/kvm-stat.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
@@ -7,19 +7,14 @@
  */
 #include <errno.h>
 #include <memory.h>
-#include "../../../util/evsel.h"
-#include "../../../util/kvm-stat.h"
+#include "../evsel.h"
+#include "../kvm-stat.h"
 #include "riscv_trap_types.h"
 #include "debug.h"
 
 define_exit_reasons_table(riscv_exit_reasons, kvm_riscv_trap_class);
 
-const char *vcpu_id_str = "id";
-const char *kvm_exit_reason = "scause";
-const char *kvm_entry_trace = "kvm:kvm_entry";
-const char *kvm_exit_trace = "kvm:kvm_exit";
-
-const char *kvm_events_tp[] = {
+static const char * const __kvm_events_tp[] = {
 	"kvm:kvm_entry",
 	"kvm:kvm_exit",
 	NULL,
@@ -29,8 +24,10 @@ static void event_get_key(struct evsel *evsel,
 			  struct perf_sample *sample,
 			  struct event_key *key)
 {
+	int xlen = 64; // TODO: 32-bit support.
+
 	key->info = 0;
-	key->key = evsel__intval(evsel, sample, kvm_exit_reason) & ~CAUSE_IRQ_FLAG;
+	key->key = evsel__intval(evsel, sample, kvm_exit_reason()) & ~CAUSE_IRQ_FLAG(xlen);
 	key->exit_reasons = riscv_exit_reasons;
 }
 
@@ -38,28 +35,28 @@ static bool event_begin(struct evsel *evsel,
 			struct perf_sample *sample __maybe_unused,
 			struct event_key *key __maybe_unused)
 {
-	return evsel__name_is(evsel, kvm_entry_trace);
+	return evsel__name_is(evsel, kvm_entry_trace());
 }
 
 static bool event_end(struct evsel *evsel,
 		      struct perf_sample *sample,
 		      struct event_key *key)
 {
-	if (evsel__name_is(evsel, kvm_exit_trace)) {
+	if (evsel__name_is(evsel, kvm_exit_trace())) {
 		event_get_key(evsel, sample, key);
 		return true;
 	}
 	return false;
 }
 
-static struct kvm_events_ops exit_events = {
+static const struct kvm_events_ops exit_events = {
 	.is_begin_event = event_begin,
 	.is_end_event	= event_end,
 	.decode_key	= exit_event_decode_key,
 	.name		= "VM-EXIT"
 };
 
-struct kvm_reg_events_ops kvm_reg_events_ops[] = {
+static const struct kvm_reg_events_ops __kvm_reg_events_ops[] = {
 	{
 		.name	= "vmexit",
 		.ops	= &exit_events,
@@ -67,12 +64,27 @@ struct kvm_reg_events_ops kvm_reg_events_ops[] = {
 	{ NULL, NULL },
 };
 
-const char * const kvm_skip_events[] = {
+static const char * const __kvm_skip_events[] = {
 	NULL,
 };
 
-int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
+int __cpu_isa_init_riscv(struct perf_kvm_stat *kvm)
 {
 	kvm->exit_reasons_isa = "riscv64";
 	return 0;
 }
+
+const char * const *__kvm_events_tp_riscv(void)
+{
+	return __kvm_events_tp;
+}
+
+const struct kvm_reg_events_ops *__kvm_reg_events_ops_riscv(void)
+{
+	return __kvm_reg_events_ops;
+}
+
+const char * const *__kvm_skip_events_riscv(void)
+{
+	return __kvm_skip_events;
+}
diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/util/kvm-stat-arch/kvm-stat-s390.c
similarity index 77%
rename from tools/perf/arch/s390/util/kvm-stat.c
rename to tools/perf/util/kvm-stat-arch/kvm-stat-s390.c
index 0aed92df51ba..2073bfd82b67 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-s390.c
@@ -8,9 +8,9 @@
 
 #include <errno.h>
 #include <string.h>
-#include "../../util/kvm-stat.h"
-#include "../../util/evsel.h"
-#include <asm/sie.h>
+#include "../kvm-stat.h"
+#include "../evsel.h"
+#include "../../../arch/s390/include/uapi/asm/sie.h"
 
 define_exit_reasons_table(sie_exit_reasons, sie_intercept_code);
 define_exit_reasons_table(sie_icpt_insn_codes, icpt_insn_codes);
@@ -18,11 +18,6 @@ define_exit_reasons_table(sie_sigp_order_codes, sigp_order_codes);
 define_exit_reasons_table(sie_diagnose_codes, diagnose_codes);
 define_exit_reasons_table(sie_icpt_prog_codes, icpt_prog_codes);
 
-const char *vcpu_id_str = "id";
-const char *kvm_exit_reason = "icptcode";
-const char *kvm_entry_trace = "kvm:kvm_s390_sie_enter";
-const char *kvm_exit_trace = "kvm:kvm_s390_sie_exit";
-
 static void event_icpt_insn_get_key(struct evsel *evsel,
 				    struct perf_sample *sample,
 				    struct event_key *key)
@@ -58,7 +53,7 @@ static void event_icpt_prog_get_key(struct evsel *evsel,
 	key->exit_reasons = sie_icpt_prog_codes;
 }
 
-static struct child_event_ops child_events[] = {
+static const struct child_event_ops child_events[] = {
 	{ .name = "kvm:kvm_s390_intercept_instruction",
 	  .get_key = event_icpt_insn_get_key },
 	{ .name = "kvm:kvm_s390_handle_sigp",
@@ -70,7 +65,7 @@ static struct child_event_ops child_events[] = {
 	{ NULL, NULL },
 };
 
-static struct kvm_events_ops exit_events = {
+static const struct kvm_events_ops exit_events = {
 	.is_begin_event = exit_event_begin,
 	.is_end_event = exit_event_end,
 	.child_ops = child_events,
@@ -78,7 +73,7 @@ static struct kvm_events_ops exit_events = {
 	.name = "VM-EXIT"
 };
 
-const char *kvm_events_tp[] = {
+static const char * const __kvm_events_tp[] = {
 	"kvm:kvm_s390_sie_enter",
 	"kvm:kvm_s390_sie_exit",
 	"kvm:kvm_s390_intercept_instruction",
@@ -88,17 +83,17 @@ const char *kvm_events_tp[] = {
 	NULL,
 };
 
-struct kvm_reg_events_ops kvm_reg_events_ops[] = {
+static const struct kvm_reg_events_ops __kvm_reg_events_ops[] = {
 	{ .name = "vmexit", .ops = &exit_events },
 	{ NULL, NULL },
 };
 
-const char * const kvm_skip_events[] = {
+static const char * const __kvm_skip_events[] = {
 	"Wait state",
 	NULL,
 };
 
-int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
+int __cpu_isa_init_s390(struct perf_kvm_stat *kvm, const char *cpuid)
 {
 	if (strstr(cpuid, "IBM")) {
 		kvm->exit_reasons = sie_exit_reasons;
@@ -108,3 +103,18 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
 
 	return 0;
 }
+
+const char * const *__kvm_events_tp_s390(void)
+{
+	return __kvm_events_tp;
+}
+
+const struct kvm_reg_events_ops *__kvm_reg_events_ops_s390(void)
+{
+	return __kvm_reg_events_ops;
+}
+
+const char * const *__kvm_skip_events_s390(void)
+{
+	return __kvm_skip_events;
+}
diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
similarity index 88%
rename from tools/perf/arch/x86/util/kvm-stat.c
rename to tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
index bff36f9345ea..1cf541385a4b 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <string.h>
-#include "../../../util/kvm-stat.h"
-#include "../../../util/evsel.h"
-#include "../../../util/env.h"
+#include "../kvm-stat.h"
+#include "../evsel.h"
+#include "../env.h"
 #include <asm/svm.h>
 #include <asm/vmx.h>
 #include <asm/kvm.h>
@@ -12,18 +12,13 @@
 define_exit_reasons_table(vmx_exit_reasons, VMX_EXIT_REASONS);
 define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);
 
-static struct kvm_events_ops exit_events = {
+static const struct kvm_events_ops exit_events = {
 	.is_begin_event = exit_event_begin,
 	.is_end_event = exit_event_end,
 	.decode_key = exit_event_decode_key,
 	.name = "VM-EXIT"
 };
 
-const char *vcpu_id_str = "vcpu_id";
-const char *kvm_exit_reason = "exit_reason";
-const char *kvm_entry_trace = "kvm:kvm_entry";
-const char *kvm_exit_trace = "kvm:kvm_exit";
-
 /*
  * For the mmio events, we treat:
  * the time of MMIO write: kvm_mmio(KVM_TRACE_MMIO_WRITE...) -> kvm_entry
@@ -83,7 +78,7 @@ static void mmio_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
 		  key->info == KVM_TRACE_MMIO_WRITE ? "W" : "R");
 }
 
-static struct kvm_events_ops mmio_events = {
+static const struct kvm_events_ops mmio_events = {
 	.is_begin_event = mmio_event_begin,
 	.is_end_event = mmio_event_end,
 	.decode_key = mmio_event_decode_key,
@@ -127,7 +122,7 @@ static void ioport_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
 		  key->info ? "POUT" : "PIN");
 }
 
-static struct kvm_events_ops ioport_events = {
+static const struct kvm_events_ops ioport_events = {
 	.is_begin_event = ioport_event_begin,
 	.is_end_event = ioport_event_end,
 	.decode_key = ioport_event_decode_key,
@@ -171,14 +166,14 @@ static void msr_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
 		  key->info ? "W" : "R");
 }
 
-static struct kvm_events_ops msr_events = {
+static const struct kvm_events_ops msr_events = {
 	.is_begin_event = msr_event_begin,
 	.is_end_event = msr_event_end,
 	.decode_key = msr_event_decode_key,
 	.name = "MSR Access"
 };
 
-const char *kvm_events_tp[] = {
+static const char * const __kvm_events_tp[] = {
 	"kvm:kvm_entry",
 	"kvm:kvm_exit",
 	"kvm:kvm_mmio",
@@ -187,7 +182,7 @@ const char *kvm_events_tp[] = {
 	NULL,
 };
 
-struct kvm_reg_events_ops kvm_reg_events_ops[] = {
+static const struct kvm_reg_events_ops __kvm_reg_events_ops[] = {
 	{ .name = "vmexit", .ops = &exit_events },
 	{ .name = "mmio", .ops = &mmio_events },
 	{ .name = "ioport", .ops = &ioport_events },
@@ -195,12 +190,12 @@ struct kvm_reg_events_ops kvm_reg_events_ops[] = {
 	{ NULL, NULL },
 };
 
-const char * const kvm_skip_events[] = {
+static const char * const __kvm_skip_events[] = {
 	"HLT",
 	NULL,
 };
 
-int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
+int __cpu_isa_init_x86(struct perf_kvm_stat *kvm, const char *cpuid)
 {
 	if (strstr(cpuid, "Intel")) {
 		kvm->exit_reasons = vmx_exit_reasons;
@@ -226,7 +221,7 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
  * So, to avoid this issue explicitly use "cycles" instead of "cycles:P" event
  * by default to sample guest on Intel platforms.
  */
-int kvm_add_default_arch_event(int *argc, const char **argv)
+int __kvm_add_default_arch_event_x86(int *argc, const char **argv)
 {
 	const char **tmp;
 	bool event = false;
@@ -262,3 +257,18 @@ int kvm_add_default_arch_event(int *argc, const char **argv)
 	free(tmp);
 	return ret;
 }
+
+const char * const *__kvm_events_tp_x86(void)
+{
+	return __kvm_events_tp;
+}
+
+const struct kvm_reg_events_ops *__kvm_reg_events_ops_x86(void)
+{
+	return __kvm_reg_events_ops;
+}
+
+const char * const *__kvm_skip_events_x86(void)
+{
+	return __kvm_skip_events;
+}
diff --git a/tools/perf/arch/riscv/util/riscv_trap_types.h b/tools/perf/util/kvm-stat-arch/riscv_trap_types.h
similarity index 96%
rename from tools/perf/arch/riscv/util/riscv_trap_types.h
rename to tools/perf/util/kvm-stat-arch/riscv_trap_types.h
index 6cc71eb01fca..aa5d24fab4ee 100644
--- a/tools/perf/arch/riscv/util/riscv_trap_types.h
+++ b/tools/perf/util/kvm-stat-arch/riscv_trap_types.h
@@ -3,7 +3,7 @@
 #define ARCH_PERF_RISCV_TRAP_TYPES_H
 
 /* Exception cause high bit - is an interrupt if set */
-#define CAUSE_IRQ_FLAG		(_AC(1, UL) << (__riscv_xlen - 1))
+#define CAUSE_IRQ_FLAG(xlen)		(_AC(1, UL) << (xlen - 1))
 
 /* Interrupt causes (minus the high bit) */
 #define IRQ_S_SOFT 1
diff --git a/tools/perf/util/kvm-stat.c b/tools/perf/util/kvm-stat.c
index 38ace736db5c..b1affd97917b 100644
--- a/tools/perf/util/kvm-stat.c
+++ b/tools/perf/util/kvm-stat.c
@@ -2,12 +2,11 @@
 #include "debug.h"
 #include "evsel.h"
 #include "kvm-stat.h"
-
-#if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+#include <dwarf-regs.h>
 
 bool kvm_exit_event(struct evsel *evsel)
 {
-	return evsel__name_is(evsel, kvm_exit_trace);
+	return evsel__name_is(evsel, kvm_exit_trace());
 }
 
 void exit_event_get_key(struct evsel *evsel,
@@ -15,7 +14,7 @@ void exit_event_get_key(struct evsel *evsel,
 			struct event_key *key)
 {
 	key->info = 0;
-	key->key  = evsel__intval(evsel, sample, kvm_exit_reason);
+	key->key  = evsel__intval(evsel, sample, kvm_exit_reason());
 }
 
 
@@ -32,7 +31,7 @@ bool exit_event_begin(struct evsel *evsel,
 
 bool kvm_entry_event(struct evsel *evsel)
 {
-	return evsel__name_is(evsel, kvm_entry_trace);
+	return evsel__name_is(evsel, kvm_entry_trace());
 }
 
 bool exit_event_end(struct evsel *evsel,
@@ -67,4 +66,202 @@ void exit_event_decode_key(struct perf_kvm_stat *kvm,
 	scnprintf(decode, KVM_EVENT_NAME_LEN, "%s", exit_reason);
 }
 
-#endif
+int setup_kvm_events_tp(struct perf_kvm_stat *kvm)
+{
+	switch (EM_HOST) {
+	case EM_PPC:
+	case EM_PPC64:
+		return __setup_kvm_events_tp_powerpc(kvm);
+	default:
+		return 0;
+	}
+}
+
+int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
+{
+	switch (EM_HOST) {
+	case EM_AARCH64:
+		return __cpu_isa_init_arm64(kvm);
+	case EM_LOONGARCH:
+		return __cpu_isa_init_loongarch(kvm);
+	case EM_PPC:
+	case EM_PPC64:
+		return __cpu_isa_init_powerpc(kvm);
+	case EM_RISCV:
+		return __cpu_isa_init_riscv(kvm);
+	case EM_S390:
+		return __cpu_isa_init_s390(kvm, cpuid);
+	case EM_X86_64:
+	case EM_386:
+		return __cpu_isa_init_x86(kvm, cpuid);
+	default:
+		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		return -1;
+	}
+}
+
+const char *vcpu_id_str(void)
+{
+	switch (EM_HOST) {
+	case EM_AARCH64:
+	case EM_RISCV:
+	case EM_S390:
+		return "id";
+	case EM_LOONGARCH:
+	case EM_PPC:
+	case EM_PPC64:
+	case EM_X86_64:
+	case EM_386:
+		return "vcpu_id";
+	default:
+		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		return NULL;
+	}
+}
+
+const char *kvm_exit_reason(void)
+{
+	switch (EM_HOST) {
+	case EM_AARCH64:
+		return "ret";
+	case EM_LOONGARCH:
+		return "reason";
+	case EM_PPC:
+	case EM_PPC64:
+		return "trap";
+	case EM_RISCV:
+		return "scause";
+	case EM_S390:
+		return "icptcode";
+	case EM_X86_64:
+	case EM_386:
+		return "exit_reason";
+	default:
+		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		return NULL;
+	}
+}
+
+const char *kvm_entry_trace(void)
+{
+	switch (EM_HOST) {
+	case EM_AARCH64:
+	case EM_RISCV:
+	case EM_X86_64:
+	case EM_386:
+		return "kvm:kvm_entry";
+	case EM_LOONGARCH:
+		return "kvm:kvm_enter";
+	case EM_PPC:
+	case EM_PPC64:
+		return "kvm_hv:kvm_guest_enter";
+	case EM_S390:
+		return "kvm:kvm_s390_sie_enter";
+	default:
+		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		return NULL;
+	}
+}
+
+const char *kvm_exit_trace(void)
+{
+	switch (EM_HOST) {
+	case EM_AARCH64:
+	case EM_LOONGARCH:
+	case EM_RISCV:
+	case EM_X86_64:
+	case EM_386:
+		return "kvm:kvm_exit";
+	case EM_PPC:
+	case EM_PPC64:
+		return "kvm_hv:kvm_guest_exit";
+	case EM_S390:
+		return "kvm:kvm_s390_sie_exit";
+	default:
+		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		return NULL;
+	}
+}
+
+const char * const *kvm_events_tp(void)
+{
+	switch (EM_HOST) {
+	case EM_AARCH64:
+		return __kvm_events_tp_arm64();
+	case EM_LOONGARCH:
+		return __kvm_events_tp_loongarch();
+	case EM_PPC:
+	case EM_PPC64:
+		return __kvm_events_tp_powerpc();
+	case EM_RISCV:
+		return __kvm_events_tp_riscv();
+	case EM_S390:
+		return __kvm_events_tp_s390();
+	case EM_X86_64:
+	case EM_386:
+		return __kvm_events_tp_x86();
+	default:
+		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		return NULL;
+	}
+}
+
+const struct kvm_reg_events_ops *kvm_reg_events_ops(void)
+{
+	switch (EM_HOST) {
+	case EM_AARCH64:
+		return __kvm_reg_events_ops_arm64();
+	case EM_LOONGARCH:
+		return __kvm_reg_events_ops_loongarch();
+	case EM_PPC:
+	case EM_PPC64:
+		return __kvm_reg_events_ops_powerpc();
+	case EM_RISCV:
+		return __kvm_reg_events_ops_riscv();
+	case EM_S390:
+		return __kvm_reg_events_ops_s390();
+	case EM_X86_64:
+	case EM_386:
+		return __kvm_reg_events_ops_x86();
+	default:
+		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		return NULL;
+	}
+}
+
+const char * const *kvm_skip_events(void)
+{
+	switch (EM_HOST) {
+	case EM_AARCH64:
+		return __kvm_skip_events_arm64();
+	case EM_LOONGARCH:
+		return __kvm_skip_events_loongarch();
+	case EM_PPC:
+	case EM_PPC64:
+		return __kvm_skip_events_powerpc();
+	case EM_RISCV:
+		return __kvm_skip_events_riscv();
+	case EM_S390:
+		return __kvm_skip_events_s390();
+	case EM_X86_64:
+	case EM_386:
+		return __kvm_skip_events_x86();
+	default:
+		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		return NULL;
+	}
+}
+
+int kvm_add_default_arch_event(int *argc, const char **argv)
+{
+	switch (EM_HOST) {
+	case EM_PPC:
+	case EM_PPC64:
+		return __kvm_add_default_arch_event_powerpc(argc, argv);
+	case EM_X86_64:
+	case EM_386:
+		return __kvm_add_default_arch_event_x86(argc, argv);
+	default:
+		return 0;
+	}
+}
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index a356b839c2ee..a54cd4496df9 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -2,8 +2,6 @@
 #ifndef __PERF_KVM_STAT_H
 #define __PERF_KVM_STAT_H
 
-#ifdef HAVE_KVM_STAT_SUPPORT
-
 #include "tool.h"
 #include "sort.h"
 #include "stat.h"
@@ -67,7 +65,7 @@ struct kvm_events_ops {
 			       struct event_key *key);
 	bool (*is_end_event)(struct evsel *evsel,
 			     struct perf_sample *sample, struct event_key *key);
-	struct child_event_ops *child_ops;
+	const struct child_event_ops *child_ops;
 	void (*decode_key)(struct perf_kvm_stat *kvm, struct event_key *key,
 			   char *decode);
 	const char *name;
@@ -95,7 +93,7 @@ struct perf_kvm_stat {
 	struct exit_reasons_table *exit_reasons;
 	const char *exit_reasons_isa;
 
-	struct kvm_events_ops *events_ops;
+	const struct kvm_events_ops *events_ops;
 
 	u64 total_time;
 	u64 total_count;
@@ -113,11 +111,9 @@ struct perf_kvm_stat {
 
 struct kvm_reg_events_ops {
 	const char *name;
-	struct kvm_events_ops *ops;
+	const struct kvm_events_ops *ops;
 };
 
-#if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
-
 void exit_event_get_key(struct evsel *evsel,
 			struct perf_sample *sample,
 			struct event_key *key);
@@ -130,11 +126,9 @@ bool exit_event_end(struct evsel *evsel,
 void exit_event_decode_key(struct perf_kvm_stat *kvm,
 			   struct event_key *key,
 			   char *decode);
-#endif
 
 bool kvm_exit_event(struct evsel *evsel);
 bool kvm_entry_event(struct evsel *evsel);
-int setup_kvm_events_tp(struct perf_kvm_stat *kvm);
 
 #define define_exit_reasons_table(name, symbols)	\
 	static struct exit_reasons_table name[] = {	\
@@ -144,15 +138,49 @@ int setup_kvm_events_tp(struct perf_kvm_stat *kvm);
 /*
  * arch specific callbacks and data structures
  */
-int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid);
+int setup_kvm_events_tp(struct perf_kvm_stat *kvm);
+int __setup_kvm_events_tp_powerpc(struct perf_kvm_stat *kvm);
 
-extern const char *kvm_events_tp[];
-extern struct kvm_reg_events_ops kvm_reg_events_ops[];
-extern const char * const kvm_skip_events[];
-extern const char *vcpu_id_str;
-extern const char *kvm_exit_reason;
-extern const char *kvm_entry_trace;
-extern const char *kvm_exit_trace;
+int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid);
+int __cpu_isa_init_arm64(struct perf_kvm_stat *kvm);
+int __cpu_isa_init_loongarch(struct perf_kvm_stat *kvm);
+int __cpu_isa_init_powerpc(struct perf_kvm_stat *kvm);
+int __cpu_isa_init_riscv(struct perf_kvm_stat *kvm);
+int __cpu_isa_init_s390(struct perf_kvm_stat *kvm, const char *cpuid);
+int __cpu_isa_init_x86(struct perf_kvm_stat *kvm, const char *cpuid);
+
+const char *vcpu_id_str(void);
+const char *kvm_exit_reason(void);
+const char *kvm_entry_trace(void);
+const char *kvm_exit_trace(void);
+
+const char * const *kvm_events_tp(void);
+const char * const *__kvm_events_tp_arm64(void);
+const char * const *__kvm_events_tp_loongarch(void);
+const char * const *__kvm_events_tp_powerpc(void);
+const char * const *__kvm_events_tp_riscv(void);
+const char * const *__kvm_events_tp_s390(void);
+const char * const *__kvm_events_tp_x86(void);
+
+const struct kvm_reg_events_ops *kvm_reg_events_ops(void);
+const struct kvm_reg_events_ops *__kvm_reg_events_ops_arm64(void);
+const struct kvm_reg_events_ops *__kvm_reg_events_ops_loongarch(void);
+const struct kvm_reg_events_ops *__kvm_reg_events_ops_powerpc(void);
+const struct kvm_reg_events_ops *__kvm_reg_events_ops_riscv(void);
+const struct kvm_reg_events_ops *__kvm_reg_events_ops_s390(void);
+const struct kvm_reg_events_ops *__kvm_reg_events_ops_x86(void);
+
+const char * const *kvm_skip_events(void);
+const char * const *__kvm_skip_events_arm64(void);
+const char * const *__kvm_skip_events_loongarch(void);
+const char * const *__kvm_skip_events_powerpc(void);
+const char * const *__kvm_skip_events_riscv(void);
+const char * const *__kvm_skip_events_s390(void);
+const char * const *__kvm_skip_events_x86(void);
+
+int kvm_add_default_arch_event(int *argc, const char **argv);
+int __kvm_add_default_arch_event_powerpc(int *argc, const char **argv);
+int __kvm_add_default_arch_event_x86(int *argc, const char **argv);
 
 static inline struct kvm_info *kvm_info__get(struct kvm_info *ki)
 {
@@ -186,11 +214,6 @@ static inline struct kvm_info *kvm_info__new(void)
 	return ki;
 }
 
-#else /* HAVE_KVM_STAT_SUPPORT */
-// We use this unconditionally in hists__findnew_entry() and hist_entry__delete()
-#define kvm_info__zput(ki) do { } while (0)
-#endif /* HAVE_KVM_STAT_SUPPORT */
-
 #define STRDUP_FAIL_EXIT(s)		\
 	({	char *_p;		\
 		_p = strdup(s);		\
@@ -201,5 +224,4 @@ static inline struct kvm_info *kvm_info__new(void)
 		_p;			\
 	})
 
-extern int kvm_add_default_arch_event(int *argc, const char **argv);
 #endif /* __PERF_KVM_STAT_H */
-- 
2.52.0.457.g6b5491de43-goog

