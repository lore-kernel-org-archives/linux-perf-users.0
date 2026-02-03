Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93428359704
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143234; cv=none; b=jNoVinGoiRYgrC1jw3CtMQK7kcdD5j/ORavORVXZQmK7x/Nt4TxabUI8yGWzBYkFgVRDlUuBwOPbgOzvJ4sWiNPfrdcWzRMlstuuvUCCO37SLrh6j5YebBxQvNLXIGWxUauUstAmq6kzGVrkN/LTzy6FR1CNaVXkhsKMXCYOXsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143234; c=relaxed/simple;
	bh=kHpcTJCZV+aUWok+Qq4YcCfFJIaLag+5P6lM1gxsnP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t5JU0JIxTB5STpQe13uE4PHVAweYJjpIbPOfFXaBGPtf8DnwRGhi+gzGlhjHVQst8WLZVF7tECVBONNunZ3EUBseVISUcCQjFOS6GPZM62WWCrpPmlS/xWwsgweAKMQtgltTp1NZoQOy+C+1xyYTDgRcnngdEl1ZrLqjI83v85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ifr/xalP; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ifr/xalP"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b7eddde359so3667422eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 10:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770143232; x=1770748032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=os2xaUwPSOKN1Qn0Q1X9vU6deQDG0YlYowBgBpJaS3I=;
        b=Ifr/xalPjegwYa0JjjSUjN+i+FPPMFu2agbs/WouLFjBBHQIIzRgCX27zqUEGbwyG8
         WDWRCLTetkkagc34Y5NeRDFDmwhbAcYMtzkl74wGPf1ehUi2oqcoh1qn0024q6t9k0b1
         S/39AZLR5YqZKFwkfHSYoDduNtgbEJ+/DtLYNk+dnXimiEfdS8CBtbgwuY77B5WUPdw7
         qx2hnnoRVtzhYxp3f0iXDuIHTpOaWmOHUQQRf9hJxqzcT0MAq0gAJdIIuCdgp7xnGgtS
         9msAiEnpHBSqoBsXACNiRbSyyFfbaiVd1d3pfYHwXBlNqehFkw+HuKTJdc2G2j6Oe2Er
         wD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770143232; x=1770748032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=os2xaUwPSOKN1Qn0Q1X9vU6deQDG0YlYowBgBpJaS3I=;
        b=b90sbCKxSUYDrUqaedZFDAqtS5FbRJZ4kQTkgUgn7eZIphyphoe6MM4dJH54LLXwB6
         pEyvBfE6V2j9TUc2APG+yeMLsvFrD/Wv/OWGrN+rGpGt+KNxZa8zM4/iMHVOWfqjJrX9
         09lm6878vycmkIRN1oFEqjnUHUnjZFFphlOoTMexmeJh7Kb0rikURnlS7ayA842dWZdu
         RxePqQZZl6YrrWSQ1z3UYZnXIdkRgjsA51VpIsnxlbj5UAMpI3VEETYwQ0nm44eQx+DB
         N8atYVZnacfZzNSeDUZW3sFhsqi/k7uYzriK7wm4wRGdp4Ja9NGj1sZBXUVChkWftnqu
         T+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7XSm5yb5LYjv58CmhsEpeNk5GDcFdbj0taeWjcWKe3O6kxG7wZaIUtm5Y5Bk4L9QLAjQsR7wLlIdjbdZyskpX@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNGEAq19drC3kSjh97DWwua6ns1GteWCSkeRgkSHAml7icEIA
	PRXugi86JblmuoA1w+W9BUlpmpdpH+5DYbw+cAZhDvJm80myYBh7Q1zPrI9q75W/sOXi/hjVrYH
	N/1f7DxHnEQ==
X-Received: from dycmq7.prod.google.com ([2002:a05:7301:787:b0:2b6:c3b1:69d4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:ea2:b0:2b7:ff39:30eb
 with SMTP id 5a478bee46e88-2b832722b9fmr162822eec.0.1770143231506; Tue, 03
 Feb 2026 10:27:11 -0800 (PST)
Date: Tue,  3 Feb 2026 10:26:37 -0800
In-Reply-To: <20260203182640.3911987-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYIOMWb2sijXzSDm@x1> <20260203182640.3911987-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203182640.3911987-3-irogers@google.com>
Subject: [PATCH v3 2/5] perf kvm: Wire up e_machine
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: aditya.b1@linux.ibm.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, ashelat@redhat.com, 
	atrajeev@linux.ibm.com, blakejones@google.com, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, dvyukov@google.com, howardchu95@gmail.com, 
	irogers@google.com, james.clark@linaro.org, john.g.garry@oracle.com, 
	jolsa@kernel.org, leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	shimin.guo@skydio.com, swapnil.sapkal@amd.com, thomas.falcon@intel.com, 
	will@kernel.org, ysk@kzalloc.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Pass the e_machine to the kvm functions so that they aren't just wired
to EM_HOST. In the case of a session move some setup until the session
is created. As the session isn't fully running the default EM_HOST is
returned as no e_machine can be found in a running machine. This is,
however, some marginal progress to cross platform support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kvm.c                      | 45 ++++++++------
 tools/perf/util/evsel.c                       |  2 +-
 tools/perf/util/evsel.h                       |  1 +
 .../perf/util/kvm-stat-arch/kvm-stat-arm64.c  |  6 +-
 .../util/kvm-stat-arch/kvm-stat-loongarch.c   |  3 +-
 .../perf/util/kvm-stat-arch/kvm-stat-riscv.c  |  6 +-
 tools/perf/util/kvm-stat.c                    | 62 +++++++++----------
 tools/perf/util/kvm-stat.h                    | 23 +++----
 8 files changed, 80 insertions(+), 68 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index bd9bda32157f..93ba07c58290 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "perf.h"
 
+#include <dwarf-regs.h>
 #include "util/build-id.h"
 #include "util/evsel.h"
 #include "util/evlist.h"
@@ -615,11 +616,11 @@ static const char *get_filename_for_perf_kvm(void)
 
 #if defined(HAVE_LIBTRACEEVENT)
 
-static bool register_kvm_events_ops(struct perf_kvm_stat *kvm)
+static bool register_kvm_events_ops(struct perf_kvm_stat *kvm, uint16_t e_machine)
 {
 	const struct kvm_reg_events_ops *events_ops;
 
-	for (events_ops = kvm_reg_events_ops(); events_ops->name; events_ops++) {
+	for (events_ops = kvm_reg_events_ops(e_machine); events_ops->name; events_ops++) {
 		if (!strcmp(events_ops->name, kvm->report_event)) {
 			kvm->events_ops = events_ops->ops;
 			return true;
@@ -841,11 +842,11 @@ static bool handle_child_event(struct perf_kvm_stat *kvm,
 	return true;
 }
 
-static bool skip_event(const char *event)
+static bool skip_event(uint16_t e_machine, const char *event)
 {
 	const char * const *skip_events;
 
-	for (skip_events = kvm_skip_events(); *skip_events; skip_events++)
+	for (skip_events = kvm_skip_events(e_machine); *skip_events; skip_events++)
 		if (!strcmp(event, *skip_events))
 			return true;
 
@@ -901,9 +902,10 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
 
 	if (kvm->duration && time_diff > kvm->duration) {
 		char decode[KVM_EVENT_NAME_LEN];
+		uint16_t e_machine = perf_session__e_machine(kvm->session);
 
 		kvm->events_ops->decode_key(kvm, &event->key, decode);
-		if (!skip_event(decode)) {
+		if (!skip_event(e_machine, decode)) {
 			pr_info("%" PRIu64 " VM %d, vcpu %d: %s event took %" PRIu64 "usec\n",
 				 sample->time, sample->pid, vcpu_record->vcpu_id,
 				 decode, time_diff / NSEC_PER_USEC);
@@ -921,6 +923,8 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,
 	/* Only kvm_entry records vcpu id. */
 	if (!thread__priv(thread) && kvm_entry_event(evsel)) {
 		struct vcpu_event_record *vcpu_record;
+		struct machine *machine = maps__machine(thread__maps(thread));
+		uint16_t e_machine = thread__e_machine(thread, machine, /*e_flags=*/NULL);
 
 		vcpu_record = zalloc(sizeof(*vcpu_record));
 		if (!vcpu_record) {
@@ -928,7 +932,7 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,
 			return NULL;
 		}
 
-		vcpu_record->vcpu_id = evsel__intval(evsel, sample, vcpu_id_str());
+		vcpu_record->vcpu_id = evsel__intval(evsel, sample, vcpu_id_str(e_machine));
 		thread__set_priv(thread, vcpu_record);
 	}
 
@@ -1163,6 +1167,7 @@ static int cpu_isa_config(struct perf_kvm_stat *kvm)
 {
 	char buf[128], *cpuid;
 	int err;
+	uint16_t e_machine;
 
 	if (kvm->live) {
 		struct perf_cpu cpu = {-1};
@@ -1182,7 +1187,8 @@ static int cpu_isa_config(struct perf_kvm_stat *kvm)
 		return -EINVAL;
 	}
 
-	err = cpu_isa_init(kvm, cpuid);
+	e_machine = perf_session__e_machine(kvm->session);
+	err = cpu_isa_init(kvm, e_machine, cpuid);
 	if (err == -ENOTSUP)
 		pr_err("CPU %s is not supported.\n", cpuid);
 
@@ -1413,7 +1419,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 
 	if (!verify_vcpu(kvm->trace_vcpu) ||
 	    !is_valid_key(kvm) ||
-	    !register_kvm_events_ops(kvm)) {
+		!register_kvm_events_ops(kvm, EM_HOST)) {
 		goto out;
 	}
 
@@ -1568,6 +1574,11 @@ static int read_events(struct perf_kvm_stat *kvm)
 		goto out_delete;
 	}
 
+	if (!register_kvm_events_ops(kvm, perf_session__e_machine(kvm->session))) {
+		ret = -EINVAL;
+		goto out_delete;
+	}
+
 	/*
 	 * Do not use 'isa' recorded in kvm_exit tracepoint since it is not
 	 * traced in the old kernel.
@@ -1610,9 +1621,6 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	if (!is_valid_key(kvm))
 		goto exit;
 
-	if (!register_kvm_events_ops(kvm))
-		goto exit;
-
 	if (kvm->use_stdio) {
 		use_browser = 0;
 		setup_pager();
@@ -1653,15 +1661,16 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 	};
 	const char * const *events_tp;
 	int ret;
+	uint16_t e_machine = EM_HOST;
 
 	events_tp_size = 0;
-	ret = setup_kvm_events_tp(kvm);
+	ret = setup_kvm_events_tp(kvm, e_machine);
 	if (ret < 0) {
 		pr_err("Unable to setup the kvm tracepoints\n");
 		return ret;
 	}
 
-	for (events_tp = kvm_events_tp(); *events_tp; events_tp++)
+	for (events_tp = kvm_events_tp(e_machine); *events_tp; events_tp++)
 		events_tp_size++;
 
 	rec_argc = ARRAY_SIZE(record_args) + argc + 2 +
@@ -1676,7 +1685,7 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 
 	for (j = 0; j < events_tp_size; j++) {
 		rec_argv[i++] = STRDUP_FAIL_EXIT("-e");
-		rec_argv[i++] = STRDUP_FAIL_EXIT(kvm_events_tp()[j]);
+		rec_argv[i++] = STRDUP_FAIL_EXIT(kvm_events_tp(e_machine)[j]);
 	}
 
 	rec_argv[i++] = STRDUP_FAIL_EXIT("-o");
@@ -1770,7 +1779,7 @@ static struct evlist *kvm_live_event_list(void)
 	if (evlist == NULL)
 		return NULL;
 
-	for (events_tp = kvm_events_tp(); *events_tp; events_tp++) {
+	for (events_tp = kvm_events_tp(EM_HOST); *events_tp; events_tp++) {
 
 		tp = strdup(*events_tp);
 		if (tp == NULL)
@@ -1895,7 +1904,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	/*
 	 * generate the event list
 	 */
-	err = setup_kvm_events_tp(kvm);
+	err = setup_kvm_events_tp(kvm, EM_HOST);
 	if (err < 0) {
 		pr_err("Unable to setup the kvm tracepoints\n");
 		return err;
@@ -2005,7 +2014,7 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 
 	BUG_ON(i + 2 != rec_argc);
 
-	ret = kvm_add_default_arch_event(&i, rec_argv);
+	ret = kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
 	if (ret)
 		goto EXIT;
 
@@ -2092,7 +2101,7 @@ static int __cmd_top(int argc, const char **argv)
 
 	BUG_ON(i != argc);
 
-	ret = kvm_add_default_arch_event(&i, rec_argv);
+	ret = kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
 	if (ret)
 		goto EXIT;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5ac1a05601b1..848d0faf6698 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1008,7 +1008,7 @@ int evsel__group_desc(struct evsel *evsel, char *buf, size_t size)
 	return ret;
 }
 
-static uint16_t evsel__e_machine(struct evsel *evsel)
+uint16_t evsel__e_machine(struct evsel *evsel)
 {
 	struct perf_session *session = evsel__session(evsel);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 95c4bd0f0f2e..eefb5d569971 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -546,6 +546,7 @@ static inline bool evsel__is_dummy_event(struct evsel *evsel)
 
 struct perf_session *evsel__session(struct evsel *evsel);
 struct perf_env *evsel__env(struct evsel *evsel);
+uint16_t evsel__e_machine(struct evsel *evsel);
 
 int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
 
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c b/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
index 8003ff415b1a..c640dcd8af7c 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
@@ -22,7 +22,7 @@ static void event_get_key(struct evsel *evsel,
 			  struct event_key *key)
 {
 	key->info = 0;
-	key->key = evsel__intval(evsel, sample, kvm_exit_reason());
+	key->key = evsel__intval(evsel, sample, kvm_exit_reason(EM_AARCH64));
 	key->exit_reasons = arm64_exit_reasons;
 
 	/*
@@ -40,14 +40,14 @@ static bool event_begin(struct evsel *evsel,
 			struct perf_sample *sample __maybe_unused,
 			struct event_key *key __maybe_unused)
 {
-	return evsel__name_is(evsel, kvm_entry_trace());
+	return evsel__name_is(evsel, kvm_entry_trace(EM_AARCH64));
 }
 
 static bool event_end(struct evsel *evsel,
 		      struct perf_sample *sample,
 		      struct event_key *key)
 {
-	if (evsel__name_is(evsel, kvm_exit_trace())) {
+	if (evsel__name_is(evsel, kvm_exit_trace(EM_AARCH64))) {
 		event_get_key(evsel, sample, key);
 		return true;
 	}
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c b/tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c
index a15ce072ac34..b802e516b138 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <memory.h>
+#include <dwarf-regs.h>
 #include "../kvm-stat.h"
 #include "../parse-events.h"
 #include "../debug.h"
@@ -70,7 +71,7 @@ static bool event_end(struct evsel *evsel,
 	 *   kvm:kvm_enter   means returning to vmm and then to guest
 	 *   kvm:kvm_reenter means returning to guest immediately
 	 */
-	return evsel__name_is(evsel, kvm_entry_trace()) ||
+	return evsel__name_is(evsel, kvm_entry_trace(EM_LOONGARCH)) ||
 	       evsel__name_is(evsel, kvm_reenter_trace);
 }
 
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c b/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
index b2c5d3220795..8d4d5d6ce720 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
@@ -27,7 +27,7 @@ static void event_get_key(struct evsel *evsel,
 	int xlen = 64; // TODO: 32-bit support.
 
 	key->info = 0;
-	key->key = evsel__intval(evsel, sample, kvm_exit_reason()) & ~CAUSE_IRQ_FLAG(xlen);
+	key->key = evsel__intval(evsel, sample, kvm_exit_reason(EM_RISCV)) & ~CAUSE_IRQ_FLAG(xlen);
 	key->exit_reasons = riscv_exit_reasons;
 }
 
@@ -35,14 +35,14 @@ static bool event_begin(struct evsel *evsel,
 			struct perf_sample *sample __maybe_unused,
 			struct event_key *key __maybe_unused)
 {
-	return evsel__name_is(evsel, kvm_entry_trace());
+	return evsel__name_is(evsel, kvm_entry_trace(EM_RISCV));
 }
 
 static bool event_end(struct evsel *evsel,
 		      struct perf_sample *sample,
 		      struct event_key *key)
 {
-	if (evsel__name_is(evsel, kvm_exit_trace())) {
+	if (evsel__name_is(evsel, kvm_exit_trace(EM_RISCV))) {
 		event_get_key(evsel, sample, key);
 		return true;
 	}
diff --git a/tools/perf/util/kvm-stat.c b/tools/perf/util/kvm-stat.c
index b1affd97917b..858b5dbd39f6 100644
--- a/tools/perf/util/kvm-stat.c
+++ b/tools/perf/util/kvm-stat.c
@@ -6,7 +6,7 @@
 
 bool kvm_exit_event(struct evsel *evsel)
 {
-	return evsel__name_is(evsel, kvm_exit_trace());
+	return evsel__name_is(evsel, kvm_exit_trace(evsel__e_machine(evsel)));
 }
 
 void exit_event_get_key(struct evsel *evsel,
@@ -14,7 +14,7 @@ void exit_event_get_key(struct evsel *evsel,
 			struct event_key *key)
 {
 	key->info = 0;
-	key->key  = evsel__intval(evsel, sample, kvm_exit_reason());
+	key->key  = evsel__intval(evsel, sample, kvm_exit_reason(evsel__e_machine(evsel)));
 }
 
 
@@ -31,7 +31,7 @@ bool exit_event_begin(struct evsel *evsel,
 
 bool kvm_entry_event(struct evsel *evsel)
 {
-	return evsel__name_is(evsel, kvm_entry_trace());
+	return evsel__name_is(evsel, kvm_entry_trace(evsel__e_machine(evsel)));
 }
 
 bool exit_event_end(struct evsel *evsel,
@@ -66,9 +66,9 @@ void exit_event_decode_key(struct perf_kvm_stat *kvm,
 	scnprintf(decode, KVM_EVENT_NAME_LEN, "%s", exit_reason);
 }
 
-int setup_kvm_events_tp(struct perf_kvm_stat *kvm)
+int setup_kvm_events_tp(struct perf_kvm_stat *kvm, uint16_t e_machine)
 {
-	switch (EM_HOST) {
+	switch (e_machine) {
 	case EM_PPC:
 	case EM_PPC64:
 		return __setup_kvm_events_tp_powerpc(kvm);
@@ -77,9 +77,9 @@ int setup_kvm_events_tp(struct perf_kvm_stat *kvm)
 	}
 }
 
-int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
+int cpu_isa_init(struct perf_kvm_stat *kvm, uint16_t e_machine, const char *cpuid)
 {
-	switch (EM_HOST) {
+	switch (e_machine) {
 	case EM_AARCH64:
 		return __cpu_isa_init_arm64(kvm);
 	case EM_LOONGARCH:
@@ -95,14 +95,14 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
 	case EM_386:
 		return __cpu_isa_init_x86(kvm, cpuid);
 	default:
-		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		pr_err("Unsupported kvm-stat host %d\n", e_machine);
 		return -1;
 	}
 }
 
-const char *vcpu_id_str(void)
+const char *vcpu_id_str(uint16_t e_machine)
 {
-	switch (EM_HOST) {
+	switch (e_machine) {
 	case EM_AARCH64:
 	case EM_RISCV:
 	case EM_S390:
@@ -114,14 +114,14 @@ const char *vcpu_id_str(void)
 	case EM_386:
 		return "vcpu_id";
 	default:
-		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		pr_err("Unsupported kvm-stat host %d\n", e_machine);
 		return NULL;
 	}
 }
 
-const char *kvm_exit_reason(void)
+const char *kvm_exit_reason(uint16_t e_machine)
 {
-	switch (EM_HOST) {
+	switch (e_machine) {
 	case EM_AARCH64:
 		return "ret";
 	case EM_LOONGARCH:
@@ -137,14 +137,14 @@ const char *kvm_exit_reason(void)
 	case EM_386:
 		return "exit_reason";
 	default:
-		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		pr_err("Unsupported kvm-stat host %d\n", e_machine);
 		return NULL;
 	}
 }
 
-const char *kvm_entry_trace(void)
+const char *kvm_entry_trace(uint16_t e_machine)
 {
-	switch (EM_HOST) {
+	switch (e_machine) {
 	case EM_AARCH64:
 	case EM_RISCV:
 	case EM_X86_64:
@@ -158,14 +158,14 @@ const char *kvm_entry_trace(void)
 	case EM_S390:
 		return "kvm:kvm_s390_sie_enter";
 	default:
-		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		pr_err("Unsupported kvm-stat host %d\n", e_machine);
 		return NULL;
 	}
 }
 
-const char *kvm_exit_trace(void)
+const char *kvm_exit_trace(uint16_t e_machine)
 {
-	switch (EM_HOST) {
+	switch (e_machine) {
 	case EM_AARCH64:
 	case EM_LOONGARCH:
 	case EM_RISCV:
@@ -178,14 +178,14 @@ const char *kvm_exit_trace(void)
 	case EM_S390:
 		return "kvm:kvm_s390_sie_exit";
 	default:
-		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		pr_err("Unsupported kvm-stat host %d\n", e_machine);
 		return NULL;
 	}
 }
 
-const char * const *kvm_events_tp(void)
+const char * const *kvm_events_tp(uint16_t e_machine)
 {
-	switch (EM_HOST) {
+	switch (e_machine) {
 	case EM_AARCH64:
 		return __kvm_events_tp_arm64();
 	case EM_LOONGARCH:
@@ -201,14 +201,14 @@ const char * const *kvm_events_tp(void)
 	case EM_386:
 		return __kvm_events_tp_x86();
 	default:
-		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		pr_err("Unsupported kvm-stat host %d\n", e_machine);
 		return NULL;
 	}
 }
 
-const struct kvm_reg_events_ops *kvm_reg_events_ops(void)
+const struct kvm_reg_events_ops *kvm_reg_events_ops(uint16_t e_machine)
 {
-	switch (EM_HOST) {
+	switch (e_machine) {
 	case EM_AARCH64:
 		return __kvm_reg_events_ops_arm64();
 	case EM_LOONGARCH:
@@ -224,14 +224,14 @@ const struct kvm_reg_events_ops *kvm_reg_events_ops(void)
 	case EM_386:
 		return __kvm_reg_events_ops_x86();
 	default:
-		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		pr_err("Unsupported kvm-stat host %d\n", e_machine);
 		return NULL;
 	}
 }
 
-const char * const *kvm_skip_events(void)
+const char * const *kvm_skip_events(uint16_t e_machine)
 {
-	switch (EM_HOST) {
+	switch (e_machine) {
 	case EM_AARCH64:
 		return __kvm_skip_events_arm64();
 	case EM_LOONGARCH:
@@ -247,14 +247,14 @@ const char * const *kvm_skip_events(void)
 	case EM_386:
 		return __kvm_skip_events_x86();
 	default:
-		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
+		pr_err("Unsupported kvm-stat host %d\n", e_machine);
 		return NULL;
 	}
 }
 
-int kvm_add_default_arch_event(int *argc, const char **argv)
+int kvm_add_default_arch_event(uint16_t e_machine, int *argc, const char **argv)
 {
-	switch (EM_HOST) {
+	switch (e_machine) {
 	case EM_PPC:
 	case EM_PPC64:
 		return __kvm_add_default_arch_event_powerpc(argc, argv);
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 759079b4294c..4a998aaece5d 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -140,10 +140,10 @@ bool kvm_entry_event(struct evsel *evsel);
 /*
  * arch specific callbacks and data structures
  */
-int setup_kvm_events_tp(struct perf_kvm_stat *kvm);
+int setup_kvm_events_tp(struct perf_kvm_stat *kvm, uint16_t e_machine);
 int __setup_kvm_events_tp_powerpc(struct perf_kvm_stat *kvm);
 
-int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid);
+int cpu_isa_init(struct perf_kvm_stat *kvm, uint16_t e_machine, const char *cpuid);
 int __cpu_isa_init_arm64(struct perf_kvm_stat *kvm);
 int __cpu_isa_init_loongarch(struct perf_kvm_stat *kvm);
 int __cpu_isa_init_powerpc(struct perf_kvm_stat *kvm);
@@ -151,12 +151,12 @@ int __cpu_isa_init_riscv(struct perf_kvm_stat *kvm);
 int __cpu_isa_init_s390(struct perf_kvm_stat *kvm, const char *cpuid);
 int __cpu_isa_init_x86(struct perf_kvm_stat *kvm, const char *cpuid);
 
-const char *vcpu_id_str(void);
-const char *kvm_exit_reason(void);
-const char *kvm_entry_trace(void);
-const char *kvm_exit_trace(void);
+const char *vcpu_id_str(uint16_t e_machine);
+const char *kvm_exit_reason(uint16_t e_machine);
+const char *kvm_entry_trace(uint16_t e_machine);
+const char *kvm_exit_trace(uint16_t e_machine);
 
-const char * const *kvm_events_tp(void);
+const char * const *kvm_events_tp(uint16_t e_machine);
 const char * const *__kvm_events_tp_arm64(void);
 const char * const *__kvm_events_tp_loongarch(void);
 const char * const *__kvm_events_tp_powerpc(void);
@@ -164,7 +164,7 @@ const char * const *__kvm_events_tp_riscv(void);
 const char * const *__kvm_events_tp_s390(void);
 const char * const *__kvm_events_tp_x86(void);
 
-const struct kvm_reg_events_ops *kvm_reg_events_ops(void);
+const struct kvm_reg_events_ops *kvm_reg_events_ops(uint16_t e_machine);
 const struct kvm_reg_events_ops *__kvm_reg_events_ops_arm64(void);
 const struct kvm_reg_events_ops *__kvm_reg_events_ops_loongarch(void);
 const struct kvm_reg_events_ops *__kvm_reg_events_ops_powerpc(void);
@@ -172,7 +172,7 @@ const struct kvm_reg_events_ops *__kvm_reg_events_ops_riscv(void);
 const struct kvm_reg_events_ops *__kvm_reg_events_ops_s390(void);
 const struct kvm_reg_events_ops *__kvm_reg_events_ops_x86(void);
 
-const char * const *kvm_skip_events(void);
+const char * const *kvm_skip_events(uint16_t e_machine);
 const char * const *__kvm_skip_events_arm64(void);
 const char * const *__kvm_skip_events_loongarch(void);
 const char * const *__kvm_skip_events_powerpc(void);
@@ -180,13 +180,14 @@ const char * const *__kvm_skip_events_riscv(void);
 const char * const *__kvm_skip_events_s390(void);
 const char * const *__kvm_skip_events_x86(void);
 
-int kvm_add_default_arch_event(int *argc, const char **argv);
+int kvm_add_default_arch_event(uint16_t e_machine, int *argc, const char **argv);
 int __kvm_add_default_arch_event_powerpc(int *argc, const char **argv);
 int __kvm_add_default_arch_event_x86(int *argc, const char **argv);
 
 #else /* !HAVE_LIBTRACEEVENT */
 
-static inline int kvm_add_default_arch_event(int *argc __maybe_unused,
+static inline int kvm_add_default_arch_event(uint16_t e_machine __maybe_unused,
+					     int *argc __maybe_unused,
 					     const char **argv __maybe_unused)
 {
 	return 0;
-- 
2.53.0.rc2.204.g2597b5adb4-goog

