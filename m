Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504DF328255
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890653; cv=none; b=NKA8Vmu0RCLgjrbUyjZs8giCCgbh74Eb0MS5oMv+KxUfDAU5fNI0IDt0X/zx4Y1FKlafGDH7ieOwotrTxPYNeSu1mRJGyDc52yRbtDjxc8QkOqC8AKNIaGq5XdORnNCSPPpuhPxxd0RRC/vew6d55TNJmoPHWyMtkTFSZZs0hvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890653; c=relaxed/simple;
	bh=o+Xes5abuH+yASF/5nAM10kbXFW/dLHGpz6yw+ZAltA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=krauF32iXwArl5E8iIbiyx1R3K7ZcGLN6+8yJuFkybzTM7LOiM/5wzGak2mHk4FoJlSo4Aa3Lyi4VuuQvO1SMCBtBxwSotBNcObB+xkW9u4HvX26BFgfqxJ7pjJEz/IIHlvGxGJ/sTVAsNIkGtYI/pSC+MkIFqxYXMVaCrk1p68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ao6BTnfY; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ao6BTnfY"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c895e7de52so8578484eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890649; x=1776495449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oannBQ3qlAZji2iUnnBApQPMVduJ0gSlFJ8k8/hJ3qM=;
        b=ao6BTnfYOXNvZHGpdiVwM5rdC5exgUG/M9pbVpC5BRu7hNowcRNyk4xpXHc3gkF9kc
         LcvB+Q1/9+ZsMM+veck2x5UblWdUjvS5QJI8w40x6idw2Jed0cyILikL7Po5BrLyiLKb
         oOqKXj1nNyx/+AapS7wzAjAvAlw+/uGhZMChpy9r5TbtDYC6cyev3xRzp+PCLz8K0MMJ
         HC1K+nZOLtCGY4UH27Fw1TGq3IWtavVHrixYYIW6cUkqvxIpEZmfapyqwEZYsU4IYsDX
         CnBKpTg8X9RmY0Me5pKl+lg4Dps++qV1MvnWSRWmmHv3hNnuyPWpbJRcpwcxKd/8sQaj
         rtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890649; x=1776495449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oannBQ3qlAZji2iUnnBApQPMVduJ0gSlFJ8k8/hJ3qM=;
        b=XSt2gJeFPs+meB/6YQLdnOEPug6qJGQWgwOYrGGzkCDXvO7IxQt3ML9N4aM0Hx1k2H
         j9pkdtbbWGuUyL6P3f3yY9k2rxoSe6n5l4mjK3eZ0Sp8dT11DkByx3o+4+LQcuURBRwj
         pTPAmxZWC1T335B3pgsz1BmoN89j0ZzZocIsYkRusw3L3YJ1odqtOjILCJlwRy02t4va
         hJ2YXCXq58yeLwDmkhDrGD2i1RugMIIJazRoz0hNueVsJV+I5/xNTpSUIuJvIejjfjsX
         FvzBnIkVoOqf1QpTc9NcDyl8IeYELMtRzc1wDTQ9kxsZLyWfNPjgCSfbrEN41Vlpb6WW
         bsEw==
X-Forwarded-Encrypted: i=1; AJvYcCUPJqzUdkqB9OuNK/XoUDQsdSKT3mZ7gMD9/akwXg4smj3po8MDnOXqJQZpJunRH/Gs0pTgCXzYsoR4+DQmsmvB@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZR6E4Sh6UqVwEw6fdPLSeSmKRipOUDqIl8MpewY232jGoo6h
	Kb7m0+/qNtDiNPCltJvaRZsD9vnttUrsG8CNFOFxYim7j14veACAuEArxGZoudpO+4zKbgTA4b8
	z8zBAtd21xw==
X-Received: from dyckx2.prod.google.com ([2002:a05:7300:c7c2:b0:2d3:51a9:d76c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3723:b0:2d4:afb3:7b00
 with SMTP id 5a478bee46e88-2d58a2a1bfbmr4137366eec.28.1775890648987; Fri, 10
 Apr 2026 23:57:28 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:56:52 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-4-irogers@google.com>
Subject: [PATCH v8 03/29] perf kvm: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

As the sample now contains the evsel, read the evsel from the sample
rather than passing them as a pair.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kvm.c                      | 19 +++--
 .../perf/util/kvm-stat-arch/kvm-stat-arm64.c  | 17 +++--
 .../util/kvm-stat-arch/kvm-stat-loongarch.c   | 17 ++---
 .../util/kvm-stat-arch/kvm-stat-powerpc.c     | 17 ++---
 .../perf/util/kvm-stat-arch/kvm-stat-riscv.c  | 18 +++--
 tools/perf/util/kvm-stat-arch/kvm-stat-s390.c | 20 +++---
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  | 70 ++++++++-----------
 tools/perf/util/kvm-stat.c                    | 19 +++--
 tools/perf/util/kvm-stat.h                    | 18 ++---
 9 files changed, 89 insertions(+), 126 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 5e8e6fde097a..d9b9792894a8 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -806,7 +806,6 @@ static bool update_kvm_event(struct perf_kvm_stat *kvm,
 }
 
 static bool is_child_event(struct perf_kvm_stat *kvm,
-			   struct evsel *evsel,
 			   struct perf_sample *sample,
 			   struct event_key *key)
 {
@@ -818,8 +817,8 @@ static bool is_child_event(struct perf_kvm_stat *kvm,
 		return false;
 
 	for (; child_ops->name; child_ops++) {
-		if (evsel__name_is(evsel, child_ops->name)) {
-			child_ops->get_key(evsel, sample, key);
+		if (evsel__name_is(sample->evsel, child_ops->name)) {
+			child_ops->get_key(sample, key);
 			return true;
 		}
 	}
@@ -917,11 +916,10 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
 
 static
 struct vcpu_event_record *per_vcpu_record(struct thread *thread,
-					  struct evsel *evsel,
 					  struct perf_sample *sample)
 {
 	/* Only kvm_entry records vcpu id. */
-	if (!thread__priv(thread) && kvm_entry_event(evsel)) {
+	if (!thread__priv(thread) && kvm_entry_event(sample->evsel)) {
 		struct vcpu_event_record *vcpu_record;
 		struct machine *machine = maps__machine(thread__maps(thread));
 		uint16_t e_machine = thread__e_machine(thread, machine, /*e_flags=*/NULL);
@@ -932,7 +930,7 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,
 			return NULL;
 		}
 
-		vcpu_record->vcpu_id = evsel__intval(evsel, sample, vcpu_id_str(e_machine));
+		vcpu_record->vcpu_id = evsel__intval(sample->evsel, sample, vcpu_id_str(e_machine));
 		thread__set_priv(thread, vcpu_record);
 	}
 
@@ -943,12 +941,11 @@ static bool handle_kvm_event(struct perf_kvm_stat *kvm,
 			     struct thread *thread,
 			     struct perf_sample *sample)
 {
-	struct evsel *evsel = sample->evsel;
 	struct vcpu_event_record *vcpu_record;
 	struct event_key key = { .key = INVALID_KEY,
 				 .exit_reasons = kvm->exit_reasons };
 
-	vcpu_record = per_vcpu_record(thread, evsel, sample);
+	vcpu_record = per_vcpu_record(thread, sample);
 	if (!vcpu_record)
 		return true;
 
@@ -957,13 +954,13 @@ static bool handle_kvm_event(struct perf_kvm_stat *kvm,
 	    (kvm->trace_vcpu != vcpu_record->vcpu_id))
 		return true;
 
-	if (kvm->events_ops->is_begin_event(evsel, sample, &key))
+	if (kvm->events_ops->is_begin_event(sample, &key))
 		return handle_begin_event(kvm, vcpu_record, &key, sample);
 
-	if (is_child_event(kvm, evsel, sample, &key))
+	if (is_child_event(kvm, sample, &key))
 		return handle_child_event(kvm, vcpu_record, &key, sample);
 
-	if (kvm->events_ops->is_end_event(evsel, sample, &key))
+	if (kvm->events_ops->is_end_event(sample, &key))
 		return handle_end_event(kvm, vcpu_record, &key, sample);
 
 	return true;
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c b/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
index c640dcd8af7c..1e76906f719c 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c
@@ -17,10 +17,11 @@ static const char * const __kvm_events_tp[] = {
 	NULL,
 };
 
-static void event_get_key(struct evsel *evsel,
-			  struct perf_sample *sample,
+static void event_get_key(struct perf_sample *sample,
 			  struct event_key *key)
 {
+	struct evsel *evsel = sample->evsel;
+
 	key->info = 0;
 	key->key = evsel__intval(evsel, sample, kvm_exit_reason(EM_AARCH64));
 	key->exit_reasons = arm64_exit_reasons;
@@ -36,19 +37,17 @@ static void event_get_key(struct evsel *evsel,
 	}
 }
 
-static bool event_begin(struct evsel *evsel,
-			struct perf_sample *sample __maybe_unused,
+static bool event_begin(struct perf_sample *sample,
 			struct event_key *key __maybe_unused)
 {
-	return evsel__name_is(evsel, kvm_entry_trace(EM_AARCH64));
+	return evsel__name_is(sample->evsel, kvm_entry_trace(EM_AARCH64));
 }
 
-static bool event_end(struct evsel *evsel,
-		      struct perf_sample *sample,
+static bool event_end(struct perf_sample *sample,
 		      struct event_key *key)
 {
-	if (evsel__name_is(evsel, kvm_exit_trace(EM_AARCH64))) {
-		event_get_key(evsel, sample, key);
+	if (evsel__name_is(sample->evsel, kvm_exit_trace(EM_AARCH64))) {
+		event_get_key(sample, key);
 		return true;
 	}
 	return false;
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c b/tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c
index b802e516b138..9d6265290f6d 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c
@@ -53,14 +53,12 @@ static const char * const __kvm_events_tp[] = {
 	NULL,
 };
 
-static bool event_begin(struct evsel *evsel,
-			struct perf_sample *sample, struct event_key *key)
+static bool event_begin(struct perf_sample *sample, struct event_key *key)
 {
-	return exit_event_begin(evsel, sample, key);
+	return exit_event_begin(sample, key);
 }
 
-static bool event_end(struct evsel *evsel,
-		      struct perf_sample *sample __maybe_unused,
+static bool event_end(struct perf_sample *sample,
 		      struct event_key *key __maybe_unused)
 {
 	/*
@@ -71,17 +69,16 @@ static bool event_end(struct evsel *evsel,
 	 *   kvm:kvm_enter   means returning to vmm and then to guest
 	 *   kvm:kvm_reenter means returning to guest immediately
 	 */
-	return evsel__name_is(evsel, kvm_entry_trace(EM_LOONGARCH)) ||
-	       evsel__name_is(evsel, kvm_reenter_trace);
+	return evsel__name_is(sample->evsel, kvm_entry_trace(EM_LOONGARCH)) ||
+	       evsel__name_is(sample->evsel, kvm_reenter_trace);
 }
 
-static void event_gspr_get_key(struct evsel *evsel,
-			       struct perf_sample *sample, struct event_key *key)
+static void event_gspr_get_key(struct perf_sample *sample, struct event_key *key)
 {
 	unsigned int insn;
 
 	key->key = LOONGARCH_EXCEPTION_OTHERS;
-	insn = evsel__intval(evsel, sample, "inst_word");
+	insn = evsel__intval(sample->evsel, sample, "inst_word");
 
 	switch (insn >> 24) {
 	case 0:
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c b/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
index 42182d70beb6..5158d7e88ee6 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
@@ -28,12 +28,11 @@ static const char * const ppc_book3s_hv_kvm_tp[] = {
 /* 1 extra placeholder for NULL */
 static const char *__kvm_events_tp[NR_TPS + 1];
 
-static void hcall_event_get_key(struct evsel *evsel,
-				struct perf_sample *sample,
+static void hcall_event_get_key(struct perf_sample *sample,
 				struct event_key *key)
 {
 	key->info = 0;
-	key->key = evsel__intval(evsel, sample, "req");
+	key->key = evsel__intval(sample->evsel, sample, "req");
 }
 
 static const char *get_hcall_exit_reason(u64 exit_code)
@@ -51,18 +50,16 @@ static const char *get_hcall_exit_reason(u64 exit_code)
 	return "UNKNOWN";
 }
 
-static bool hcall_event_end(struct evsel *evsel,
-			    struct perf_sample *sample __maybe_unused,
+static bool hcall_event_end(struct perf_sample *sample,
 			    struct event_key *key __maybe_unused)
 {
-	return evsel__name_is(evsel, __kvm_events_tp[3]);
+	return evsel__name_is(sample->evsel, __kvm_events_tp[3]);
 }
 
-static bool hcall_event_begin(struct evsel *evsel,
-			      struct perf_sample *sample, struct event_key *key)
+static bool hcall_event_begin(struct perf_sample *sample, struct event_key *key)
 {
-	if (evsel__name_is(evsel, __kvm_events_tp[2])) {
-		hcall_event_get_key(evsel, sample, key);
+	if (evsel__name_is(sample->evsel, __kvm_events_tp[2])) {
+		hcall_event_get_key(sample, key);
 		return true;
 	}
 
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c b/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
index 8d4d5d6ce720..e8db8b4f8e2e 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c
@@ -20,30 +20,28 @@ static const char * const __kvm_events_tp[] = {
 	NULL,
 };
 
-static void event_get_key(struct evsel *evsel,
-			  struct perf_sample *sample,
+static void event_get_key(struct perf_sample *sample,
 			  struct event_key *key)
 {
 	int xlen = 64; // TODO: 32-bit support.
 
 	key->info = 0;
-	key->key = evsel__intval(evsel, sample, kvm_exit_reason(EM_RISCV)) & ~CAUSE_IRQ_FLAG(xlen);
+	key->key = evsel__intval(sample->evsel, sample,
+				 kvm_exit_reason(EM_RISCV)) & ~CAUSE_IRQ_FLAG(xlen);
 	key->exit_reasons = riscv_exit_reasons;
 }
 
-static bool event_begin(struct evsel *evsel,
-			struct perf_sample *sample __maybe_unused,
+static bool event_begin(struct perf_sample *sample,
 			struct event_key *key __maybe_unused)
 {
-	return evsel__name_is(evsel, kvm_entry_trace(EM_RISCV));
+	return evsel__name_is(sample->evsel, kvm_entry_trace(EM_RISCV));
 }
 
-static bool event_end(struct evsel *evsel,
-		      struct perf_sample *sample,
+static bool event_end(struct perf_sample *sample,
 		      struct event_key *key)
 {
-	if (evsel__name_is(evsel, kvm_exit_trace(EM_RISCV))) {
-		event_get_key(evsel, sample, key);
+	if (evsel__name_is(sample->evsel, kvm_exit_trace(EM_RISCV))) {
+		event_get_key(sample, key);
 		return true;
 	}
 	return false;
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-s390.c b/tools/perf/util/kvm-stat-arch/kvm-stat-s390.c
index 7e29169f5bb0..158372ba0205 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-s390.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-s390.c
@@ -18,38 +18,34 @@ define_exit_reasons_table(sie_sigp_order_codes, sigp_order_codes);
 define_exit_reasons_table(sie_diagnose_codes, diagnose_codes);
 define_exit_reasons_table(sie_icpt_prog_codes, icpt_prog_codes);
 
-static void event_icpt_insn_get_key(struct evsel *evsel,
-				    struct perf_sample *sample,
+static void event_icpt_insn_get_key(struct perf_sample *sample,
 				    struct event_key *key)
 {
 	u64 insn;
 
-	insn = evsel__intval(evsel, sample, "instruction");
+	insn = evsel__intval(sample->evsel, sample, "instruction");
 	key->key = icpt_insn_decoder(insn);
 	key->exit_reasons = sie_icpt_insn_codes;
 }
 
-static void event_sigp_get_key(struct evsel *evsel,
-			       struct perf_sample *sample,
+static void event_sigp_get_key(struct perf_sample *sample,
 			       struct event_key *key)
 {
-	key->key = evsel__intval(evsel, sample, "order_code");
+	key->key = evsel__intval(sample->evsel, sample, "order_code");
 	key->exit_reasons = sie_sigp_order_codes;
 }
 
-static void event_diag_get_key(struct evsel *evsel,
-			       struct perf_sample *sample,
+static void event_diag_get_key(struct perf_sample *sample,
 			       struct event_key *key)
 {
-	key->key = evsel__intval(evsel, sample, "code");
+	key->key = evsel__intval(sample->evsel, sample, "code");
 	key->exit_reasons = sie_diagnose_codes;
 }
 
-static void event_icpt_prog_get_key(struct evsel *evsel,
-				    struct perf_sample *sample,
+static void event_icpt_prog_get_key(struct perf_sample *sample,
 				    struct event_key *key)
 {
-	key->key = evsel__intval(evsel, sample, "code");
+	key->key = evsel__intval(sample->evsel, sample, "code");
 	key->exit_reasons = sie_icpt_prog_codes;
 }
 
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
index 0f626db3a439..0ce543d82850 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
@@ -24,45 +24,43 @@ static const struct kvm_events_ops exit_events = {
  * the time of MMIO write: kvm_mmio(KVM_TRACE_MMIO_WRITE...) -> kvm_entry
  * the time of MMIO read: kvm_exit -> kvm_mmio(KVM_TRACE_MMIO_READ...).
  */
-static void mmio_event_get_key(struct evsel *evsel, struct perf_sample *sample,
+static void mmio_event_get_key(struct perf_sample *sample,
 			       struct event_key *key)
 {
-	key->key  = evsel__intval(evsel, sample, "gpa");
-	key->info = evsel__intval(evsel, sample, "type");
+	key->key  = evsel__intval(sample->evsel, sample, "gpa");
+	key->info = evsel__intval(sample->evsel, sample, "type");
 }
 
 #define KVM_TRACE_MMIO_READ_UNSATISFIED 0
 #define KVM_TRACE_MMIO_READ 1
 #define KVM_TRACE_MMIO_WRITE 2
 
-static bool mmio_event_begin(struct evsel *evsel,
-			     struct perf_sample *sample, struct event_key *key)
+static bool mmio_event_begin(struct perf_sample *sample, struct event_key *key)
 {
 	/* MMIO read begin event in kernel. */
-	if (kvm_exit_event(evsel))
+	if (kvm_exit_event(sample->evsel))
 		return true;
 
 	/* MMIO write begin event in kernel. */
-	if (evsel__name_is(evsel, "kvm:kvm_mmio") &&
-	    evsel__intval(evsel, sample, "type") == KVM_TRACE_MMIO_WRITE) {
-		mmio_event_get_key(evsel, sample, key);
+	if (evsel__name_is(sample->evsel, "kvm:kvm_mmio") &&
+	    evsel__intval(sample->evsel, sample, "type") == KVM_TRACE_MMIO_WRITE) {
+		mmio_event_get_key(sample, key);
 		return true;
 	}
 
 	return false;
 }
 
-static bool mmio_event_end(struct evsel *evsel, struct perf_sample *sample,
-			   struct event_key *key)
+static bool mmio_event_end(struct perf_sample *sample, struct event_key *key)
 {
 	/* MMIO write end event in kernel. */
-	if (kvm_entry_event(evsel))
+	if (kvm_entry_event(sample->evsel))
 		return true;
 
 	/* MMIO read end event in kernel.*/
-	if (evsel__name_is(evsel, "kvm:kvm_mmio") &&
-	    evsel__intval(evsel, sample, "type") == KVM_TRACE_MMIO_READ) {
-		mmio_event_get_key(evsel, sample, key);
+	if (evsel__name_is(sample->evsel, "kvm:kvm_mmio") &&
+	    evsel__intval(sample->evsel, sample, "type") == KVM_TRACE_MMIO_READ) {
+		mmio_event_get_key(sample, key);
 		return true;
 	}
 
@@ -86,31 +84,27 @@ static const struct kvm_events_ops mmio_events = {
 };
 
  /* The time of emulation pio access is from kvm_pio to kvm_entry. */
-static void ioport_event_get_key(struct evsel *evsel,
-				 struct perf_sample *sample,
+static void ioport_event_get_key(struct perf_sample *sample,
 				 struct event_key *key)
 {
-	key->key  = evsel__intval(evsel, sample, "port");
-	key->info = evsel__intval(evsel, sample, "rw");
+	key->key  = evsel__intval(sample->evsel, sample, "port");
+	key->info = evsel__intval(sample->evsel, sample, "rw");
 }
 
-static bool ioport_event_begin(struct evsel *evsel,
-			       struct perf_sample *sample,
+static bool ioport_event_begin(struct perf_sample *sample,
 			       struct event_key *key)
 {
-	if (evsel__name_is(evsel, "kvm:kvm_pio")) {
-		ioport_event_get_key(evsel, sample, key);
+	if (evsel__name_is(sample->evsel, "kvm:kvm_pio")) {
+		ioport_event_get_key(sample, key);
 		return true;
 	}
 
 	return false;
 }
 
-static bool ioport_event_end(struct evsel *evsel,
-			     struct perf_sample *sample __maybe_unused,
-			     struct event_key *key __maybe_unused)
+static bool ioport_event_end(struct perf_sample *sample, struct event_key *key __maybe_unused)
 {
-	return kvm_entry_event(evsel);
+	return kvm_entry_event(sample->evsel);
 }
 
 static void ioport_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
@@ -130,31 +124,25 @@ static const struct kvm_events_ops ioport_events = {
 };
 
  /* The time of emulation msr is from kvm_msr to kvm_entry. */
-static void msr_event_get_key(struct evsel *evsel,
-				 struct perf_sample *sample,
-				 struct event_key *key)
+static void msr_event_get_key(struct perf_sample *sample, struct event_key *key)
 {
-	key->key  = evsel__intval(evsel, sample, "ecx");
-	key->info = evsel__intval(evsel, sample, "write");
+	key->key  = evsel__intval(sample->evsel, sample, "ecx");
+	key->info = evsel__intval(sample->evsel, sample, "write");
 }
 
-static bool msr_event_begin(struct evsel *evsel,
-			       struct perf_sample *sample,
-			       struct event_key *key)
+static bool msr_event_begin(struct perf_sample *sample, struct event_key *key)
 {
-	if (evsel__name_is(evsel, "kvm:kvm_msr")) {
-		msr_event_get_key(evsel, sample, key);
+	if (evsel__name_is(sample->evsel, "kvm:kvm_msr")) {
+		msr_event_get_key(sample, key);
 		return true;
 	}
 
 	return false;
 }
 
-static bool msr_event_end(struct evsel *evsel,
-			     struct perf_sample *sample __maybe_unused,
-			     struct event_key *key __maybe_unused)
+static bool msr_event_end(struct perf_sample *sample, struct event_key *key __maybe_unused)
 {
-	return kvm_entry_event(evsel);
+	return kvm_entry_event(sample->evsel);
 }
 
 static void msr_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
diff --git a/tools/perf/util/kvm-stat.c b/tools/perf/util/kvm-stat.c
index 27f16810498c..f17a6132958d 100644
--- a/tools/perf/util/kvm-stat.c
+++ b/tools/perf/util/kvm-stat.c
@@ -11,22 +11,20 @@ bool kvm_exit_event(struct evsel *evsel)
 	return evsel__name_is(evsel, kvm_exit_trace(e_machine));
 }
 
-void exit_event_get_key(struct evsel *evsel,
-			struct perf_sample *sample,
+void exit_event_get_key(struct perf_sample *sample,
 			struct event_key *key)
 {
-	uint16_t e_machine = evsel__e_machine(evsel, /*e_flags=*/NULL);
+	uint16_t e_machine = evsel__e_machine(sample->evsel, /*e_flags=*/NULL);
 
 	key->info = 0;
-	key->key  = evsel__intval(evsel, sample, kvm_exit_reason(e_machine));
+	key->key  = evsel__intval(sample->evsel, sample, kvm_exit_reason(e_machine));
 }
 
 
-bool exit_event_begin(struct evsel *evsel,
-		      struct perf_sample *sample, struct event_key *key)
+bool exit_event_begin(struct perf_sample *sample, struct event_key *key)
 {
-	if (kvm_exit_event(evsel)) {
-		exit_event_get_key(evsel, sample, key);
+	if (kvm_exit_event(sample->evsel)) {
+		exit_event_get_key(sample, key);
 		return true;
 	}
 
@@ -40,11 +38,10 @@ bool kvm_entry_event(struct evsel *evsel)
 	return evsel__name_is(evsel, kvm_entry_trace(e_machine));
 }
 
-bool exit_event_end(struct evsel *evsel,
-		    struct perf_sample *sample __maybe_unused,
+bool exit_event_end(struct perf_sample *sample,
 		    struct event_key *key __maybe_unused)
 {
-	return kvm_entry_event(evsel);
+	return kvm_entry_event(sample->evsel);
 }
 
 static const char *get_exit_reason(struct perf_kvm_stat *kvm,
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 4a998aaece5d..cdbd921a555f 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -53,18 +53,15 @@ struct kvm_event {
 };
 
 struct child_event_ops {
-	void (*get_key)(struct evsel *evsel,
-			struct perf_sample *sample,
+	void (*get_key)(struct perf_sample *sample,
 			struct event_key *key);
 	const char *name;
 };
 
 struct kvm_events_ops {
-	bool (*is_begin_event)(struct evsel *evsel,
-			       struct perf_sample *sample,
+	bool (*is_begin_event)(struct perf_sample *sample,
 			       struct event_key *key);
-	bool (*is_end_event)(struct evsel *evsel,
-			     struct perf_sample *sample, struct event_key *key);
+	bool (*is_end_event)(struct perf_sample *sample, struct event_key *key);
 	const struct child_event_ops *child_ops;
 	void (*decode_key)(struct perf_kvm_stat *kvm, struct event_key *key,
 			   char *decode);
@@ -116,14 +113,11 @@ struct kvm_reg_events_ops {
 
 #ifdef HAVE_LIBTRACEEVENT
 
-void exit_event_get_key(struct evsel *evsel,
-			struct perf_sample *sample,
+void exit_event_get_key(struct perf_sample *sample,
 			struct event_key *key);
-bool exit_event_begin(struct evsel *evsel,
-		      struct perf_sample *sample,
+bool exit_event_begin(struct perf_sample *sample,
 		      struct event_key *key);
-bool exit_event_end(struct evsel *evsel,
-		    struct perf_sample *sample,
+bool exit_event_end(struct perf_sample *sample,
 		    struct event_key *key);
 void exit_event_decode_key(struct perf_kvm_stat *kvm,
 			   struct event_key *key,
-- 
2.53.0.1213.gd9a14994de-goog

