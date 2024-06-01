Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F215C150999
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Jun 2024 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246822; cv=none; b=J6LQLxVqYIq73Ten12twafLm2Ej5HFKRAuJwRQ7HWzqr1s21xda6Nd8Q43Ho6VGtT1uHNtISj4NrXgMY5SPrv6tlu7vNxcl8yP9aKjU1o6A5oqpcGSUC8yEvIMwgjTBpDUkfnMgabcZ7cXbeR5sWlLdUcZ4RAUwidFzv3K0pkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246822; c=relaxed/simple;
	bh=aV5lsEweEVOhSTNbhC2B5NXvFA9D5mnNFeKyMZRK7vE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3ZQr27t6tqrIJ3JbQY2ZwmRdRbYMzhzxlQSgHwxk16szlkTumj0tATMbT+wl3CY+wopF4EeuuYbKj0NTIB9n46HN+xf/+KeLszORutBdrxVVwgDK7y2HVcv5xX38J/L/aMVJX33UZJCjNVWZtNHWHKA+MZ9XivYAQnge+cAL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8B1713D5;
	Sat,  1 Jun 2024 06:00:43 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.70.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 926073F792;
	Sat,  1 Jun 2024 06:00:17 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V3 07/10] perf tools: Replace strstarts() usage with str_has_prefix()
Date: Sat,  1 Jun 2024 18:29:43 +0530
Message-Id: <20240601125946.1741414-8-ChaitanyaS.Prakash@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
References: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>

To ensure consistency in string comparison functions between tools/ and
the kernel, calls to strstarts() are replaced with str_has_prefix().

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/perf/arch/arm/util/pmu.c              |  4 ++--
 tools/perf/arch/x86/annotate/instructions.c | 14 +++++++-------
 tools/perf/arch/x86/util/env.c              |  2 +-
 tools/perf/builtin-c2c.c                    |  4 ++--
 tools/perf/builtin-config.c                 |  2 +-
 tools/perf/builtin-daemon.c                 |  2 +-
 tools/perf/builtin-ftrace.c                 |  2 +-
 tools/perf/builtin-help.c                   |  6 +++---
 tools/perf/builtin-kmem.c                   |  2 +-
 tools/perf/builtin-kvm.c                    | 14 +++++++-------
 tools/perf/builtin-kwork.c                  | 10 +++++-----
 tools/perf/builtin-lock.c                   |  6 +++---
 tools/perf/builtin-mem.c                    |  4 ++--
 tools/perf/builtin-sched.c                  |  6 +++---
 tools/perf/builtin-script.c                 |  4 ++--
 tools/perf/builtin-stat.c                   |  4 ++--
 tools/perf/builtin-timechart.c              |  2 +-
 tools/perf/builtin-trace.c                  |  6 +++---
 tools/perf/perf.c                           | 12 ++++++------
 tools/perf/tests/symbols.c                  |  2 +-
 tools/perf/ui/browser.c                     |  2 +-
 tools/perf/ui/browsers/scripts.c            |  2 +-
 tools/perf/ui/stdio/hist.c                  |  2 +-
 tools/perf/util/amd-sample-raw.c            |  4 ++--
 tools/perf/util/annotate.c                  |  2 +-
 tools/perf/util/callchain.c                 |  2 +-
 tools/perf/util/config.c                    | 12 ++++++------
 tools/perf/util/map.c                       |  8 ++++----
 tools/perf/util/pmus.c                      |  2 +-
 tools/perf/util/sample-raw.c                |  2 +-
 tools/perf/util/symbol-elf.c                |  4 ++--
 31 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 8b7cb68ba1a8..ed280732c6c6 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -23,13 +23,13 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 		pmu->selectable = true;
 		pmu->perf_event_attr_init_default = cs_etm_get_default_config;
 #if defined(__aarch64__)
-	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
+	} else if (str_has_prefix(pmu->name, ARM_SPE_PMU_NAME)) {
 		pmu->selectable = true;
 		pmu->is_uncore = false;
 		pmu->perf_event_attr_init_default = arm_spe_pmu_default_config;
 		if (!strcmp(pmu->name, "arm_spe_0"))
 			pmu->mem_events = perf_mem_events_arm;
-	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
+	} else if (str_has_prefix(pmu->name, HISI_PTT_PMU_NAME)) {
 		pmu->selectable = true;
 #endif
 	}
diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 5cdf457f5cbe..05924ce76cc1 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -126,16 +126,16 @@ static bool amd__ins_is_fused(struct arch *arch, const char *ins1,
 		return false;
 
 	/* Family >= 15h supports cmp/test + branch fusion */
-	if (arch->family >= 0x15 && (strstarts(ins1, "test") ||
-	    (strstarts(ins1, "cmp") && !strstr(ins1, "xchg")))) {
+	if (arch->family >= 0x15 && (str_has_prefix(ins1, "test") ||
+	    (str_has_prefix(ins1, "cmp") && !strstr(ins1, "xchg")))) {
 		return true;
 	}
 
 	/* Family >= 19h supports some ALU + branch fusion */
-	if (arch->family >= 0x19 && (strstarts(ins1, "add") ||
-	    strstarts(ins1, "sub") || strstarts(ins1, "and") ||
-	    strstarts(ins1, "inc") || strstarts(ins1, "dec") ||
-	    strstarts(ins1, "or") || strstarts(ins1, "xor"))) {
+	if (arch->family >= 0x19 && (str_has_prefix(ins1, "add") ||
+	    str_has_prefix(ins1, "sub") || str_has_prefix(ins1, "and") ||
+	    str_has_prefix(ins1, "inc") || str_has_prefix(ins1, "dec") ||
+	    str_has_prefix(ins1, "or") || str_has_prefix(ins1, "xor"))) {
 		return true;
 	}
 
@@ -182,7 +182,7 @@ static int x86__cpuid_parse(struct arch *arch, char *cpuid)
 	if (ret == 3) {
 		arch->family = family;
 		arch->model = model;
-		arch->ins_is_fused = strstarts(cpuid, "AuthenticAMD") ?
+		arch->ins_is_fused = str_has_prefix(cpuid, "AuthenticAMD") ?
 					amd__ins_is_fused :
 					intel__ins_is_fused;
 		return 0;
diff --git a/tools/perf/arch/x86/util/env.c b/tools/perf/arch/x86/util/env.c
index 3e537ffb1353..394de17d2530 100644
--- a/tools/perf/arch/x86/util/env.c
+++ b/tools/perf/arch/x86/util/env.c
@@ -12,7 +12,7 @@ bool x86__is_amd_cpu(void)
 		goto ret;
 
 	perf_env__cpuid(&env);
-	is_amd = env.cpuid && strstarts(env.cpuid, "AuthenticAMD") ? 1 : -1;
+	is_amd = env.cpuid && str_has_prefix(env.cpuid, "AuthenticAMD") ? 1 : -1;
 	perf_env__exit(&env);
 ret:
 	return is_amd >= 1 ? true : false;
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c157bd31f2e5..4bce58ffeb58 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3348,9 +3348,9 @@ int cmd_c2c(int argc, const char **argv)
 	if (!argc)
 		usage_with_options(c2c_usage, c2c_options);
 
-	if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
+	if (strlen(argv[0]) > 2 && str_has_prefix("record", argv[0])) {
 		return perf_c2c__record(argc, argv);
-	} else if (strlen(argv[0]) > 2 && strstarts("report", argv[0])) {
+	} else if (strlen(argv[0]) > 2 && str_has_prefix("report", argv[0])) {
 		return perf_c2c__report(argc, argv);
 	} else {
 		usage_with_options(c2c_usage, c2c_options);
diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 2e8363778935..1a19d40fb492 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -79,7 +79,7 @@ static int show_spec_config(struct perf_config_set *set, const char *var)
 		return -1;
 
 	perf_config_items__for_each_entry(&set->sections, section) {
-		if (!strstarts(var, section->name))
+		if (!str_has_prefix(var, section->name))
 			continue;
 
 		perf_config_items__for_each_entry(&section->items, item) {
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index de76bbc50bfb..175ba1921cad 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -216,7 +216,7 @@ static int server_config(const char *var, const char *value, void *cb)
 {
 	struct daemon *daemon = cb;
 
-	if (strstarts(var, "session-")) {
+	if (str_has_prefix(var, "session-")) {
 		return session_config(daemon, var, value);
 	} else if (!strcmp(var, "daemon.base") && !daemon->base_user) {
 		if (daemon->base && strcmp(daemon->base, value)) {
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index eb30c8eca488..485696c2bff7 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -954,7 +954,7 @@ static int perf_ftrace_config(const char *var, const char *value, void *cb)
 {
 	struct perf_ftrace *ftrace = cb;
 
-	if (!strstarts(var, "ftrace."))
+	if (!str_has_prefix(var, "ftrace."))
 		return 0;
 
 	if (strcmp(var, "ftrace.tracer"))
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index b2a368ae295a..f5e3f1cb6eaa 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -98,7 +98,7 @@ static int check_emacsclient_version(void)
 	 */
 	finish_command(&ec_process);
 
-	if (!strstarts(buffer.buf, "emacsclient")) {
+	if (!str_has_prefix(buffer.buf, "emacsclient")) {
 		fprintf(stderr, "Failed to parse emacsclient version.\n");
 		goto out;
 	}
@@ -291,7 +291,7 @@ static int perf_help_config(const char *var, const char *value, void *cb)
 		add_man_viewer(value);
 		return 0;
 	}
-	if (strstarts(var, "man."))
+	if (str_has_prefix(var, "man."))
 		return add_man_viewer_info(var, value);
 
 	return 0;
@@ -321,7 +321,7 @@ static const char *cmd_to_page(const char *perf_cmd)
 
 	if (!perf_cmd)
 		return "perf";
-	else if (strstarts(perf_cmd, "perf"))
+	else if (str_has_prefix(perf_cmd, "perf"))
 		return perf_cmd;
 
 	return asprintf(&s, "perf-%s", perf_cmd) < 0 ? NULL : s;
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 6fd95be5032b..110e4900bc5f 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1991,7 +1991,7 @@ int cmd_kmem(int argc, const char **argv)
 			kmem_page = 1;
 	}
 
-	if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
+	if (strlen(argv[0]) > 2 && str_has_prefix("record", argv[0])) {
 		symbol__init(NULL);
 		return __cmd_record(argc, argv);
 	}
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 71165036e4ca..47a9cdf417b8 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2037,10 +2037,10 @@ static int kvm_cmd_stat(const char *file_name, int argc, const char **argv)
 		goto perf_stat;
 	}
 
-	if (strlen(argv[1]) > 2 && strstarts("record", argv[1]))
+	if (strlen(argv[1]) > 2 && str_has_prefix("record", argv[1]))
 		return kvm_events_record(&kvm, argc - 1, argv + 1);
 
-	if (strlen(argv[1]) > 2 && strstarts("report", argv[1]))
+	if (strlen(argv[1]) > 2 && str_has_prefix("report", argv[1]))
 		return kvm_events_report(&kvm, argc - 1 , argv + 1);
 
 #if defined(HAVE_TIMERFD_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
@@ -2170,18 +2170,18 @@ int cmd_kvm(int argc, const char **argv)
 		}
 	}
 
-	if (strlen(argv[0]) > 2 && strstarts("record", argv[0]))
+	if (strlen(argv[0]) > 2 && str_has_prefix("record", argv[0]))
 		return __cmd_record(file_name, argc, argv);
-	else if (strlen(argv[0]) > 2 && strstarts("report", argv[0]))
+	else if (strlen(argv[0]) > 2 && str_has_prefix("report", argv[0]))
 		return __cmd_report(file_name, argc, argv);
-	else if (strlen(argv[0]) > 2 && strstarts("diff", argv[0]))
+	else if (strlen(argv[0]) > 2 && str_has_prefix("diff", argv[0]))
 		return cmd_diff(argc, argv);
 	else if (!strcmp(argv[0], "top"))
 		return cmd_top(argc, argv);
-	else if (strlen(argv[0]) > 2 && strstarts("buildid-list", argv[0]))
+	else if (strlen(argv[0]) > 2 && str_has_prefix("buildid-list", argv[0]))
 		return __cmd_buildid_list(file_name, argc, argv);
 #if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
-	else if (strlen(argv[0]) > 2 && strstarts("stat", argv[0]))
+	else if (strlen(argv[0]) > 2 && str_has_prefix("stat", argv[0]))
 		return kvm_cmd_stat(file_name, argc, argv);
 #endif
 	else
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 56e3f3a5e03a..820172317d51 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2470,10 +2470,10 @@ int cmd_kwork(int argc, const char **argv)
 
 	sort_dimension__add(&kwork, "id", &kwork.cmp_id);
 
-	if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
+	if (strlen(argv[0]) > 2 && str_has_prefix("record", argv[0])) {
 		setup_event_list(&kwork, kwork_options, kwork_usage);
 		return perf_kwork__record(&kwork, argc, argv);
-	} else if (strlen(argv[0]) > 2 && strstarts("report", argv[0])) {
+	} else if (strlen(argv[0]) > 2 && str_has_prefix("report", argv[0])) {
 		kwork.sort_order = default_report_sort_order;
 		if (argc > 1) {
 			argc = parse_options(argc, argv, report_options, report_usage, 0);
@@ -2484,7 +2484,7 @@ int cmd_kwork(int argc, const char **argv)
 		setup_sorting(&kwork, report_options, report_usage);
 		setup_event_list(&kwork, kwork_options, kwork_usage);
 		return perf_kwork__report(&kwork);
-	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
+	} else if (strlen(argv[0]) > 2 && str_has_prefix("latency", argv[0])) {
 		kwork.sort_order = default_latency_sort_order;
 		if (argc > 1) {
 			argc = parse_options(argc, argv, latency_options, latency_usage, 0);
@@ -2495,7 +2495,7 @@ int cmd_kwork(int argc, const char **argv)
 		setup_sorting(&kwork, latency_options, latency_usage);
 		setup_event_list(&kwork, kwork_options, kwork_usage);
 		return perf_kwork__report(&kwork);
-	} else if (strlen(argv[0]) > 2 && strstarts("timehist", argv[0])) {
+	} else if (strlen(argv[0]) > 2 && str_has_prefix("timehist", argv[0])) {
 		if (argc > 1) {
 			argc = parse_options(argc, argv, timehist_options, timehist_usage, 0);
 			if (argc)
@@ -2504,7 +2504,7 @@ int cmd_kwork(int argc, const char **argv)
 		kwork.report = KWORK_REPORT_TIMEHIST;
 		setup_event_list(&kwork, kwork_options, kwork_usage);
 		return perf_kwork__timehist(&kwork);
-	} else if (strlen(argv[0]) > 2 && strstarts("top", argv[0])) {
+	} else if (strlen(argv[0]) > 2 && str_has_prefix("top", argv[0])) {
 		kwork.sort_order = default_top_sort_order;
 		if (argc > 1) {
 			argc = parse_options(argc, argv, top_options, top_usage, 0);
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 7007d26fe654..9e9b64875c6c 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2663,9 +2663,9 @@ int cmd_lock(int argc, const char **argv)
 	if (!argc)
 		usage_with_options(lock_usage, lock_options);
 
-	if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
+	if (strlen(argv[0]) > 2 && str_has_prefix("record", argv[0])) {
 		return __cmd_record(argc, argv);
-	} else if (strlen(argv[0]) > 2 && strstarts("report", argv[0])) {
+	} else if (strlen(argv[0]) > 2 && str_has_prefix("report", argv[0])) {
 		trace_handler = &report_lock_ops;
 		if (argc) {
 			argc = parse_options(argc, argv,
@@ -2687,7 +2687,7 @@ int cmd_lock(int argc, const char **argv)
 		/* recycling report_lock_ops */
 		trace_handler = &report_lock_ops;
 		rc = __cmd_report(true);
-	} else if (strlen(argv[0]) > 2 && strstarts("contention", argv[0])) {
+	} else if (strlen(argv[0]) > 2 && str_has_prefix("contention", argv[0])) {
 		trace_handler = &contention_lock_ops;
 		sort_key = "wait_total";
 		output_fields = "contended,wait_total,wait_max,avg_wait";
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 863fcd735dae..5abd25472734 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -510,9 +510,9 @@ int cmd_mem(int argc, const char **argv)
 			mem.input_name = "perf.data";
 	}
 
-	if (strlen(argv[0]) > 2 && strstarts("record", argv[0]))
+	if (strlen(argv[0]) > 2 && str_has_prefix("record", argv[0]))
 		return __cmd_record(argc, argv, &mem);
-	else if (strlen(argv[0]) > 2 && strstarts("report", argv[0]))
+	else if (strlen(argv[0]) > 2 && str_has_prefix("report", argv[0]))
 		return report_events(argc, argv, &mem);
 	else
 		usage_with_options(mem_usage, mem_options);
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 5977c49ae2c7..537aea6c0d55 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3642,9 +3642,9 @@ int cmd_sched(int argc, const char **argv)
 	 */
 	if (!strcmp(argv[0], "script")) {
 		return cmd_script(argc, argv);
-	} else if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
+	} else if (strlen(argv[0]) > 2 && str_has_prefix("record", argv[0])) {
 		return __cmd_record(argc, argv);
-	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
+	} else if (strlen(argv[0]) > 2 && str_has_prefix("latency", argv[0])) {
 		sched.tp_handler = &lat_ops;
 		if (argc > 1) {
 			argc = parse_options(argc, argv, latency_options, latency_usage, 0);
@@ -3662,7 +3662,7 @@ int cmd_sched(int argc, const char **argv)
 		sched.tp_handler = &map_ops;
 		setup_sorting(&sched, latency_options, latency_usage);
 		return perf_sched__map(&sched);
-	} else if (strlen(argv[0]) > 2 && strstarts("replay", argv[0])) {
+	} else if (strlen(argv[0]) > 2 && str_has_prefix("replay", argv[0])) {
 		sched.tp_handler = &replay_ops;
 		if (argc) {
 			argc = parse_options(argc, argv, replay_options, replay_usage, 0);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ef622d71195f..7f5a4a20deac 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -4099,13 +4099,13 @@ int cmd_script(int argc, const char **argv)
 	if (symbol__validate_sym_arguments())
 		return -1;
 
-	if (argc > 1 && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
+	if (argc > 1 && strlen(argv[0]) > 2 && str_has_prefix("record", argv[0])) {
 		rec_script_path = get_script_path(argv[1], RECORD_SUFFIX);
 		if (!rec_script_path)
 			return cmd_record(argc, argv);
 	}
 
-	if (argc > 1 && strlen(argv[0]) > 2 && strstarts("report", argv[0])) {
+	if (argc > 1 && strlen(argv[0]) > 2 && str_has_prefix("report", argv[0])) {
 		rep_script_path = get_script_path(argv[1], REPORT_SUFFIX);
 		if (!rep_script_path) {
 			fprintf(stderr,
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 35f79b48e8dc..822b93c498de 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2529,11 +2529,11 @@ int cmd_stat(int argc, const char **argv)
 	} else
 		stat_config.csv_sep = DEFAULT_SEPARATOR;
 
-	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
+	if (argc && strlen(argv[0]) > 2 && str_has_prefix("record", argv[0])) {
 		argc = __cmd_record(argc, argv);
 		if (argc < 0)
 			return -1;
-	} else if (argc && strlen(argv[0]) > 2 && strstarts("report", argv[0]))
+	} else if (argc && strlen(argv[0]) > 2 && str_has_prefix("report", argv[0]))
 		return __cmd_report(argc, argv);
 
 	interval = stat_config.interval;
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 19d4542ea18a..eed17971a2d6 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -2014,7 +2014,7 @@ int cmd_timechart(int argc, const char **argv)
 		goto out;
 	}
 
-	if (argc && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
+	if (argc && strlen(argv[0]) > 2 && str_has_prefix("record", argv[0])) {
 		argc = parse_options(argc, argv, timechart_record_options,
 				     timechart_record_usage,
 				     PARSE_OPT_STOP_AT_NON_OPTION);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 51eca671c797..f07951d665a7 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3135,7 +3135,7 @@ static bool evlist__add_vfs_getname(struct evlist *evlist)
 		return false;
 
 	evlist__for_each_entry_safe(evlist, evsel, tmp) {
-		if (!strstarts(evsel__name(evsel), "probe:vfs_getname"))
+		if (!str_has_prefix(evsel__name(evsel), "probe:vfs_getname"))
 			continue;
 
 		if (evsel__field(evsel, "pathname")) {
@@ -3601,7 +3601,7 @@ static int trace__set_filter_loop_pids(struct trace *trace)
 			break;
 
 		if (!strcmp(thread__comm_str(parent), "sshd") ||
-		    strstarts(thread__comm_str(parent), "gnome-terminal")) {
+		    str_has_prefix(thread__comm_str(parent), "gnome-terminal")) {
 			pids[nr++] = thread__tid(parent);
 			break;
 		}
@@ -5009,7 +5009,7 @@ int cmd_trace(int argc, const char **argv)
 				evsel->handler = trace__sys_enter;
 			}
 
-			if (strstarts(evsel__name(evsel), "syscalls:sys_exit_")) {
+			if (str_has_prefix(evsel__name(evsel), "syscalls:sys_exit_")) {
 				struct syscall_tp *sc;
 init_augmented_syscall_tp:
 				if (evsel__init_augmented_syscall_tp(evsel, evsel))
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index bd3f80b5bb46..11e148970c43 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -104,7 +104,7 @@ struct pager_config {
 static bool same_cmd_with_prefix(const char *var, struct pager_config *c,
 				  const char *header)
 {
-	return (strstarts(var, header) && !strcmp(var + strlen(header), c->cmd));
+	return (str_has_prefix(var, header) && !strcmp(var + strlen(header), c->cmd));
 }
 
 static int pager_command_config(const char *var, const char *value, void *data)
@@ -233,7 +233,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		/*
 		 * Check remaining flags.
 		 */
-		if (strstarts(cmd, CMD_EXEC_PATH)) {
+		if (str_has_prefix(cmd, CMD_EXEC_PATH)) {
 			cmd += strlen(CMD_EXEC_PATH);
 			if (*cmd == '=')
 				set_argv_exec_path(cmd + 1);
@@ -270,7 +270,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
-		} else if (strstarts(cmd, CMD_DEBUGFS_DIR)) {
+		} else if (str_has_prefix(cmd, CMD_DEBUGFS_DIR)) {
 			tracing_path_set(cmd + strlen(CMD_DEBUGFS_DIR));
 			fprintf(stderr, "dir: %s\n", tracing_path_mount());
 			if (envchanged)
@@ -497,7 +497,7 @@ int main(int argc, const char **argv)
 	 * that contains a dash in its name. To handle this scenario, we just
 	 * fall through and ignore the "xxxx" part of the command string.
 	 */
-	if (strstarts(cmd, "perf-")) {
+	if (str_has_prefix(cmd, "perf-")) {
 		cmd += 5;
 		argv[0] = cmd;
 		handle_internal_command(argc, argv);
@@ -508,7 +508,7 @@ int main(int argc, const char **argv)
 		cmd -= 5;
 		argv[0] = cmd;
 	}
-	if (strstarts(cmd, "trace")) {
+	if (str_has_prefix(cmd, "trace")) {
 #ifndef HAVE_LIBTRACEEVENT
 		fprintf(stderr,
 			"trace command not available: missing libtraceevent devel package at build time.\n");
@@ -530,7 +530,7 @@ int main(int argc, const char **argv)
 	commit_pager_choice();
 
 	if (argc > 0) {
-		if (strstarts(argv[0], "--"))
+		if (str_has_prefix(argv[0], "--"))
 			argv[0] += 2;
 	} else {
 		/* The user didn't specify a command; give them help */
diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index ee20a366f32f..67b5b84ccec4 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -145,7 +145,7 @@ static int subdivided_dso_cb(struct dso *dso, struct machine *machine __maybe_un
 {
 	struct dso *text_dso = d;
 
-	if (dso != text_dso && strstarts(dso__short_name(dso), dso__short_name(text_dso)))
+	if (dso != text_dso && str_has_prefix(dso__short_name(dso), dso__short_name(text_dso)))
 		if (test_dso(dso) != TEST_OK)
 			return -1;
 
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 19503e838738..aa5e2713b011 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -579,7 +579,7 @@ static int ui_browser__color_config(const char *var, const char *value,
 	int i;
 
 	/* same dir for all commands */
-	if (!strstarts(var, "colors.") != 0)
+	if ((!str_has_prefix(var, "colors.")) != 0)
 		return 0;
 
 	for (i = 0; ui_browser__colorsets[i].name != NULL; ++i) {
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index e437d7889de6..eef15f87f1dd 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -63,7 +63,7 @@ static int scripts_config(const char *var, const char *value, void *data)
 {
 	struct script_config *c = data;
 
-	if (!strstarts(var, "scripts."))
+	if (!str_has_prefix(var, "scripts."))
 		return -1;
 	if (c->index >= SCRIPT_MAX_NO)
 		return -1;
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index b849caace398..a3431a00103b 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -237,7 +237,7 @@ static size_t callchain__fprintf_graph(FILE *fp, struct rb_root *root,
 			 * displayed twice.
 			 */
 			if (!i++ && field_order == NULL &&
-			    sort_order && strstarts(sort_order, "sym"))
+			    sort_order && str_has_prefix(sort_order, "sym"))
 				continue;
 
 			if (!printed) {
diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index 9d0ce88e90e4..f99167bf6a78 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -320,9 +320,9 @@ bool evlist__has_amd_ibs(struct evlist *evlist)
 	while (nr_pmu_mappings--) {
 		ret = sscanf(pmu_mapping, "%u:%9s", &type, name);
 		if (ret == 2) {
-			if (strstarts(name, "ibs_op"))
+			if (str_has_prefix(name, "ibs_op"))
 				ibs_op_type = type;
-			else if (strstarts(name, "ibs_fetch"))
+			else if (str_has_prefix(name, "ibs_fetch"))
 				ibs_fetch_type = type;
 		}
 		pmu_mapping += strlen(pmu_mapping) + 1 /* '\0' */;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 1451caf25e77..b6983301f75f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1874,7 +1874,7 @@ static int annotation__config(const char *var, const char *value, void *data)
 {
 	struct annotation_options *opt = data;
 
-	if (!strstarts(var, "annotate."))
+	if (!str_has_prefix(var, "annotate."))
 		return 0;
 
 	if (!strcmp(var, "annotate.offset_level")) {
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 1730b852a947..fb6ca1d6996c 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -321,7 +321,7 @@ int perf_callchain_config(const char *var, const char *value)
 {
 	char *endptr;
 
-	if (!strstarts(var, "call-graph."))
+	if (!str_has_prefix(var, "call-graph."))
 		return 0;
 	var += sizeof("call-graph.") - 1;
 
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 7a650de0db83..0e9437a4ac25 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -473,22 +473,22 @@ static int perf_stat_config(const char *var, const char *value)
 int perf_default_config(const char *var, const char *value,
 			void *dummy __maybe_unused)
 {
-	if (strstarts(var, "core."))
+	if (str_has_prefix(var, "core."))
 		return perf_default_core_config(var, value);
 
-	if (strstarts(var, "hist."))
+	if (str_has_prefix(var, "hist."))
 		return perf_hist_config(var, value);
 
-	if (strstarts(var, "ui."))
+	if (str_has_prefix(var, "ui."))
 		return perf_ui_config(var, value);
 
-	if (strstarts(var, "call-graph."))
+	if (str_has_prefix(var, "call-graph."))
 		return perf_callchain_config(var, value);
 
-	if (strstarts(var, "buildid."))
+	if (str_has_prefix(var, "buildid."))
 		return perf_buildid_config(var, value);
 
-	if (strstarts(var, "stat."))
+	if (str_has_prefix(var, "stat."))
 		return perf_stat_config(var, value);
 
 	/* Add other config variables here. */
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index e1d14936a60d..d4e18e81c804 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -18,8 +18,8 @@
 
 static inline int is_android_lib(const char *filename)
 {
-	return strstarts(filename, "/data/app-lib/") ||
-	       strstarts(filename, "/system/lib/");
+	return str_has_prefix(filename, "/data/app-lib/") ||
+	       str_has_prefix(filename, "/system/lib/");
 }
 
 static inline bool replace_android_lib(const char *filename, char *newfilename)
@@ -39,7 +39,7 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 
 	app_abi_length = strlen(app_abi);
 
-	if (strstarts(filename, "/data/app-lib/")) {
+	if (str_has_prefix(filename, "/data/app-lib/")) {
 		char *apk_path;
 
 		if (!app_abi_length)
@@ -63,7 +63,7 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 		return true;
 	}
 
-	if (strstarts(filename, "/system/lib/")) {
+	if (str_has_prefix(filename, "/system/lib/")) {
 		char *ndk, *app;
 		const char *arch;
 		int ndk_length, app_length;
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b9b4c5eb5002..34dfb01d3b9a 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -47,7 +47,7 @@ int pmu_name_len_no_suffix(const char *str, unsigned long *num)
 	orig_len = len = strlen(str);
 
 	/* Non-uncore PMUs have their full length, for example, i915. */
-	if (!strstarts(str, "uncore_"))
+	if (!str_has_prefix(str, "uncore_"))
 		return len;
 
 	/*
diff --git a/tools/perf/util/sample-raw.c b/tools/perf/util/sample-raw.c
index f3f6bd9d290e..e5fcca8b755f 100644
--- a/tools/perf/util/sample-raw.c
+++ b/tools/perf/util/sample-raw.c
@@ -19,7 +19,7 @@ void evlist__init_trace_event_sample_raw(struct evlist *evlist)
 	if (arch_pf && !strcmp("s390", arch_pf))
 		evlist->trace_event_sample_raw = evlist__s390_sample_raw;
 	else if (arch_pf && !strcmp("x86", arch_pf) &&
-		 cpuid && strstarts(cpuid, "AuthenticAMD") &&
+		 cpuid && str_has_prefix(cpuid, "AuthenticAMD") &&
 		 evlist__has_amd_ibs(evlist)) {
 		evlist->trace_event_sample_raw = evlist__amd_sample_raw;
 	}
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index e398abfd13a0..2cd8226a07f1 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1368,8 +1368,8 @@ static u64 max_text_section(Elf *elf, GElf_Ehdr *ehdr)
 		/* .init and .exit sections are not placed with .text */
 		sec_name = elf_strptr(elf, ehdr->e_shstrndx, shdr.sh_name);
 		if (!sec_name ||
-		    strstarts(sec_name, ".init") ||
-		    strstarts(sec_name, ".exit"))
+		    str_has_prefix(sec_name, ".init") ||
+		    str_has_prefix(sec_name, ".exit"))
 			break;
 
 		/* Must be next to previous, assumes .text is first */
-- 
2.34.1

