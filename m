Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CA36EAAB
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Jan 2026 20:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889759; cv=none; b=Nno/x0cNGPNb0rtR5cZp1SfNMNiBNbjJX2XKrQvOOM2ELqnmc4NVlbGAZy0w/GVYhXji0+lhfpBTzJ8ePMr9E6pmiOT7QgkxnQqSW4QIO7pX0/OzkSbsG7lsiEl/lfK3fKm2hlIWOdvDU1iKzC2jFOQWCQxrSSfEO8XyXqIBUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889759; c=relaxed/simple;
	bh=7n7fpTuVsLpW5dTaoi783s2qeiHqMmMBKZjZu/WCqdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NCGhIcaHefuX/EwYI4vWnLWnYFhWWt0BOCrnnBprS2spNM+VlwJpYG1c0p3h7ZlfTLj09dFX9n18Ov4QlJnahMWqVngJNMYRzNeOUOIS8edmjVJKB4Sqe3NCxJD5ILu9DULAbQ1fRqZKJbVl84gK9Q+Zn5QY1eyqOz/k7gifbc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ehpd3Ood; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ehpd3Ood"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34c314af2d4so2409725a91.3
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Jan 2026 12:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769889757; x=1770494557; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CH19sZmi6OhmnuWmP/MMQ8cKU7/WOZcdh//pactV2Lg=;
        b=Ehpd3OodArfedbo+1eKeaZnTS8nAgsMUigigfs7+K2MAYHIdZahy42HZ4rz8X1W1bz
         gyu9hSpO0AM5lEA33Vm8KMaxx0khOFS3Z/qVD2bZU6cBBB/rW4YDejPZiooHvd69hYGQ
         COq4WQRRYT7r5qumAfhJ2j7VE4pF+tUyMdkksBM0IAAWql0jkuGhQkpH32c41zcmK1EK
         AU9wllHSGQe8QIfAMD8wIUkvOTEMearNEDGFBuY5bAVG2F9uhRJwAjd5YzLHqteRI7rF
         Cdi/LGiCLeZD/5qqId9aLPCRgQARKgtky8BZ9P1OrLP0NPz6OyaoCtRf4jto8CLDf4a/
         ZoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769889757; x=1770494557;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CH19sZmi6OhmnuWmP/MMQ8cKU7/WOZcdh//pactV2Lg=;
        b=nhCpsIOx1175js9JmLN4/Dt4sSRqKg14aI2lcG0yWKnzBtbfGyEkKhwoyCFYC5CJrt
         jWUJowDQO/ksa52+3vbjdwVCE6HwODliWrs16xVGrYUd7r4fDhfRnc6jzFXsgNfwUlfE
         1JoCprHq0g0zYGeiFeEpR6Ya8oow/Uhy0S/Lb7PqXlO9I02nmhd/72lmN7owFzUVuyUr
         v/N8Mspo3ErqHn/AMFUx17gGVLfM2eNUsczeEOvfdWeLJZS3fmRnnJalPlr+6jjFyZa5
         mMo/j1oA7L/SFRkcmlZZ/l7HrHYu4+z/ueb450MDKjA5DeEYiWlsvxesQHEM2t832w9k
         ickQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2zFRlw0Uej/7tQSI0Sxxl3Ct8/K1XYdYVGmcSPvR5FbsxOzJ9/+ZgU7uH+z/s8KjKouuIzqLtmDf0kQYIMGjm@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQj70aoBB7JhAqFHrv7TUSlaFrHEF1JXaRgxVA+OJnZbTo/M+
	YFlgMeApdkZSO/SgqpfuMNV4Pz5WwO79h3w5a0a+Ce4wSJ6r2btc2FD4vky2bbrav/PhL8rLM6g
	VX6zdDzH14w==
X-Received: from pgvz8.prod.google.com ([2002:a65:6648:0:b0:bd9:a349:94a8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d19:b0:348:b7a1:431
 with SMTP id adf61e73a8af0-392dffe0bbemr7270573637.10.1769889757129; Sat, 31
 Jan 2026 12:02:37 -0800 (PST)
Date: Sat, 31 Jan 2026 12:02:22 -0800
In-Reply-To: <20260131200224.1296136-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131200224.1296136-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131200224.1296136-5-irogers@google.com>
Subject: [PATCH v2 4/6] perf session: Add e_flags to the e_machine helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, Yunseong Kim <ysk@kzalloc.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Blake Jones <blakejones@google.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Allow e_flags as well as e_machine to be computed using the e_machine
helper. This isn't currently used, the argument is always NULL, but it
will be used for a new header feature.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kvm.c    |  9 +++++----
 tools/perf/builtin-report.c |  4 ++--
 tools/perf/builtin-script.c |  6 ++++--
 tools/perf/util/evsel.c     |  6 +++---
 tools/perf/util/evsel.h     |  2 +-
 tools/perf/util/kvm-stat.c  | 12 ++++++++---
 tools/perf/util/session.c   | 40 +++++++++++++++++++++++++++----------
 tools/perf/util/session.h   |  2 +-
 8 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 93ba07c58290..0c5e6b3aac74 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -902,7 +902,7 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
 
 	if (kvm->duration && time_diff > kvm->duration) {
 		char decode[KVM_EVENT_NAME_LEN];
-		uint16_t e_machine = perf_session__e_machine(kvm->session);
+		uint16_t e_machine = perf_session__e_machine(kvm->session, /*e_flags=*/NULL);
 
 		kvm->events_ops->decode_key(kvm, &event->key, decode);
 		if (!skip_event(e_machine, decode)) {
@@ -1187,7 +1187,7 @@ static int cpu_isa_config(struct perf_kvm_stat *kvm)
 		return -EINVAL;
 	}
 
-	e_machine = perf_session__e_machine(kvm->session);
+	e_machine = perf_session__e_machine(kvm->session, /*e_flags=*/NULL);
 	err = cpu_isa_init(kvm, e_machine, cpuid);
 	if (err == -ENOTSUP)
 		pr_err("CPU %s is not supported.\n", cpuid);
@@ -1549,7 +1549,7 @@ static int kvm_live_open_events(struct perf_kvm_stat *kvm)
 static int read_events(struct perf_kvm_stat *kvm)
 {
 	int ret;
-
+	uint16_t e_machine;
 	struct perf_data file = {
 		.path  = kvm->file_name,
 		.mode  = PERF_DATA_MODE_READ,
@@ -1574,7 +1574,8 @@ static int read_events(struct perf_kvm_stat *kvm)
 		goto out_delete;
 	}
 
-	if (!register_kvm_events_ops(kvm, perf_session__e_machine(kvm->session))) {
+	e_machine = perf_session__e_machine(kvm->session, /*e_flags=*/NULL);
+	if (!register_kvm_events_ops(kvm, e_machine)) {
 		ret = -EINVAL;
 		goto out_delete;
 	}
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 810ffd66b11c..3b81f4b3dc49 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -448,7 +448,7 @@ static int report__setup_sample_type(struct report *rep)
 		}
 	}
 
-	callchain_param_setup(sample_type, perf_session__e_machine(session));
+	callchain_param_setup(sample_type, perf_session__e_machine(session, /*e_flags=*/NULL));
 
 	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
@@ -1296,7 +1296,7 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
 	 */
 	sample_type = evlist__combined_sample_type(*pevlist);
 	session = (*pevlist)->session;
-	callchain_param_setup(sample_type, perf_session__e_machine(session));
+	callchain_param_setup(sample_type, perf_session__e_machine(session, /*e_flags=*/NULL));
 	return 0;
 }
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c7d5a325b5cb..14c6f6c3c4f2 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2818,6 +2818,7 @@ static int process_attr(const struct perf_tool *tool, union perf_event *event,
 	struct perf_script *scr = container_of(tool, struct perf_script, tool);
 	struct evlist *evlist;
 	struct evsel *evsel, *pos;
+	uint16_t e_machine;
 	u64 sample_type;
 	int err;
 
@@ -2859,7 +2860,8 @@ static int process_attr(const struct perf_tool *tool, union perf_event *event,
 	 * on events sample_type.
 	 */
 	sample_type = evlist__combined_sample_type(evlist);
-	callchain_param_setup(sample_type, perf_session__e_machine(evsel__session(evsel)));
+	e_machine = perf_session__e_machine(evsel__session(evsel), /*e_flags=*/NULL);
+	callchain_param_setup(sample_type, e_machine);
 
 	/* Enable fields for callchain entries */
 	if (symbol_conf.use_callchain &&
@@ -3834,7 +3836,7 @@ static void script__setup_sample_type(struct perf_script *script)
 	struct perf_session *session = script->session;
 	u64 sample_type = evlist__combined_sample_type(session->evlist);
 
-	callchain_param_setup(sample_type, perf_session__e_machine(session));
+	callchain_param_setup(sample_type, perf_session__e_machine(session, /*e_flags=*/NULL));
 
 	if (script->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		pr_warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 848d0faf6698..aff44ffd3ff1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1008,11 +1008,11 @@ int evsel__group_desc(struct evsel *evsel, char *buf, size_t size)
 	return ret;
 }
 
-uint16_t evsel__e_machine(struct evsel *evsel)
+uint16_t evsel__e_machine(struct evsel *evsel, uint32_t *e_flags)
 {
 	struct perf_session *session = evsel__session(evsel);
 
-	return session ? perf_session__e_machine(session) : EM_HOST;
+	return perf_session__e_machine(session, e_flags);
 }
 
 static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
@@ -1050,7 +1050,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 
 	if (param->record_mode == CALLCHAIN_DWARF) {
 		if (!function) {
-			uint16_t e_machine = evsel__e_machine(evsel);
+			uint16_t e_machine = evsel__e_machine(evsel, /*e_flags=*/NULL);
 
 			evsel__set_sample_bit(evsel, REGS_USER);
 			evsel__set_sample_bit(evsel, STACK_USER);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index eefb5d569971..a3d754c029a0 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -546,7 +546,7 @@ static inline bool evsel__is_dummy_event(struct evsel *evsel)
 
 struct perf_session *evsel__session(struct evsel *evsel);
 struct perf_env *evsel__env(struct evsel *evsel);
-uint16_t evsel__e_machine(struct evsel *evsel);
+uint16_t evsel__e_machine(struct evsel *evsel, uint32_t *e_flags);
 
 int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
 
diff --git a/tools/perf/util/kvm-stat.c b/tools/perf/util/kvm-stat.c
index 858b5dbd39f6..27f16810498c 100644
--- a/tools/perf/util/kvm-stat.c
+++ b/tools/perf/util/kvm-stat.c
@@ -6,15 +6,19 @@
 
 bool kvm_exit_event(struct evsel *evsel)
 {
-	return evsel__name_is(evsel, kvm_exit_trace(evsel__e_machine(evsel)));
+	uint16_t e_machine = evsel__e_machine(evsel, /*e_flags=*/NULL);
+
+	return evsel__name_is(evsel, kvm_exit_trace(e_machine));
 }
 
 void exit_event_get_key(struct evsel *evsel,
 			struct perf_sample *sample,
 			struct event_key *key)
 {
+	uint16_t e_machine = evsel__e_machine(evsel, /*e_flags=*/NULL);
+
 	key->info = 0;
-	key->key  = evsel__intval(evsel, sample, kvm_exit_reason(evsel__e_machine(evsel)));
+	key->key  = evsel__intval(evsel, sample, kvm_exit_reason(e_machine));
 }
 
 
@@ -31,7 +35,9 @@ bool exit_event_begin(struct evsel *evsel,
 
 bool kvm_entry_event(struct evsel *evsel)
 {
-	return evsel__name_is(evsel, kvm_entry_trace(evsel__e_machine(evsel)));
+	uint16_t e_machine = evsel__e_machine(evsel, /*e_flags=*/NULL);
+
+	return evsel__name_is(evsel, kvm_entry_trace(e_machine));
 }
 
 bool exit_event_end(struct evsel *evsel,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d0053618f540..72e8bb67d740 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2964,27 +2964,47 @@ struct perf_env *perf_session__env(struct perf_session *session)
 	return &session->header.env;
 }
 
-static int perf_session__e_machine_cb(struct thread *thread,
-				      void *arg __maybe_unused)
+struct perf_session__e_machine_cb_args {
+	uint32_t e_flags;
+	uint16_t e_machine;
+	bool need_e_flags;
+};
+
+static int perf_session__e_machine_cb(struct thread *thread, void *_args)
 {
-	uint16_t *result = arg;
+	struct perf_session__e_machine_cb_args *args = _args;
 	struct machine *machine = maps__machine(thread__maps(thread));
 
-	*result = thread__e_machine(thread, machine, /*e_flags=*/NULL);
-	return *result != EM_NONE ? 1 : 0;
+	args->e_machine = thread__e_machine(thread, machine,
+					    args->need_e_flags ? &args->e_flags : NULL);
+	return args->e_machine != EM_NONE ? 1 : 0;
 }
 
 /*
  * Note, a machine may have mixed 32-bit and 64-bit processes and so mixed
  * e_machines. Use thread__e_machine when this matters.
  */
-uint16_t perf_session__e_machine(struct perf_session *session)
+uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags)
 {
-	uint16_t e_machine = EM_NONE;
+	struct perf_session__e_machine_cb_args args = {
+		.e_machine = EM_NONE,
+		.need_e_flags = e_flags != NULL,
+	};
+
+	if (!session) {
+		/* Default to assuming a host machine. */
+		if (e_flags)
+			*e_flags = EF_HOST;
+
+		return EM_HOST;
+	}
 
 	machines__for_each_thread(&session->machines,
-					 perf_session__e_machine_cb,
-					 &e_machine);
+				  perf_session__e_machine_cb,
+				  &args);
+
+	if (e_flags)
+		*e_flags = args.e_flags;
 
-	return e_machine == EM_NONE ? EM_HOST : e_machine;
+	return args.e_machine == EM_NONE ? EM_HOST : args.e_machine;
 }
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index eddc4c630b33..f05f0d4a6c23 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -211,6 +211,6 @@ int perf_event__process_finished_round(const struct perf_tool *tool,
 				       struct ordered_events *oe);
 
 struct perf_env *perf_session__env(struct perf_session *session);
-uint16_t perf_session__e_machine(struct perf_session *session);
+uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags);
 
 #endif /* __PERF_SESSION_H */
-- 
2.53.0.rc1.225.gd81095ad13-goog

