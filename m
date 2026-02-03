Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215FB36B079
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143245; cv=none; b=ffTh/D10Mv8V647BxWJIVnLMN+EMKhMDEp8qW3fOJD85Rcl9T/i+sJLNSBKRvaTX+O+CKtjairl4N2EhLaowtGnkIE47p7HHQDEoABj/1hwGUgOZXpTR5zi5RpBb7/i22RqvpbXi6vMv9E5CS5avozZlArs9RnZiDo4Fxiih2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143245; c=relaxed/simple;
	bh=sXKSOtLcPaTeWkO/mEs3KygOYQnKMmsW10C7VrPm5yA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JluVWjC9kyj2NOmIitbxPGS1T9Tlkv9XxmrhfJT8mXVNiXLYIZIhDzgT/Au06da+jbLjNmLe5EwzKdDaFNyDJ2ZEu2YLDi68p9FNR8GrFp7zfKwwKpwn/UxHESAjpSmSy3mZftqzKkY66lT4k6NOzTEC/bYbjApLP2d3Ul9Obkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ED/6hEJu; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ED/6hEJu"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b82974bd26so712523eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 10:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770143242; x=1770748042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIM5+Of9W90WeHpl1KAdtOvtvkuL79tdVDHtpDNPDbc=;
        b=ED/6hEJuEHnwAhQWVkfVKOBB++5rnKW28S3EC1D/2R8wG8ri177jK6sHT2JVP/lgEO
         Ca//cpXler1yWifU1ofZlqq5No7FoOT85oxGJC42e8wkssn0cwGquGup1+jeljld3prV
         3de+FoMdL1rqhRwSacJFwxhU2opZfbJBFdZAd6RhekmyH0NAHqnr4e/Vc6T/qlUxpec4
         1sjzkpfsKMjLi1LOL9hfT6itf67aYA13GA4sCsf6eRcWnzMhJBuGqhBhxqyA4Ke41cyl
         R8i8p6XNhbwx4NQ42F+7UpEEJs9VtKN808SoLbrnUcAts+PGa0zwycGi996JOIayekhw
         /iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770143242; x=1770748042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIM5+Of9W90WeHpl1KAdtOvtvkuL79tdVDHtpDNPDbc=;
        b=W/R65ZCJeqa4/lECGTclfouG3uwwguSIA9ldg1MsYr4oeAJhx6Q9cL6hIDGB6ubAYm
         30Fcypc6FGHChdCLzQtpivkh7XEknSStO8oR7FM+nrxT7sWIqIadcMKJv4wuIWcg0xH3
         0gKjKDwQea7fQz4lQ5zhjTeQQa0wd/8EI8ttDoBULdDgRhAteLh/OwVSt+QNtgeehVm1
         jtOEGnVqnYYrdzTFQIyfkRC3k3gMTDlqqGfYu2IwcYWguB68+Mpxr1JBadeY3TnFQ7gn
         tL2qfVK2zfo9hIYvrm1U5oCiz4d6U33h2zFjbOKlrvoUix6rI+9ubvLui7Z8VeP+roLD
         8nsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3U6Rq69S1Ar1qiHaShzLxmUA/7ijhJHozQL56T+cKKbgpf9Wo589ygwh8+T+4j+172YhacZBfz3ahtbeNXSOm@vger.kernel.org
X-Gm-Message-State: AOJu0YzG8uCrUUyRxhU/PKK1V+ZM+mH8NyVwMSoSpqkPguU5dz9En5OS
	5SYO8bh4WlBCASOFiz2v4ltgD5eNAClyAsrjORzNpyI6AeYfTgtux4Okdrn9VmPOg5eQoeovSNt
	2RoLOlV2o4Q==
X-Received: from dyaw27-n1.prod.google.com ([2002:a05:693c:415b:10b0:2b0:5041:8a8b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:7bc2:b0:2b7:18eb:a0b9
 with SMTP id 5a478bee46e88-2b8329b3935mr163770eec.43.1770143242111; Tue, 03
 Feb 2026 10:27:22 -0800 (PST)
Date: Tue,  3 Feb 2026 10:26:39 -0800
In-Reply-To: <20260203182640.3911987-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYIOMWb2sijXzSDm@x1> <20260203182640.3911987-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203182640.3911987-5-irogers@google.com>
Subject: [PATCH v3 4/5] perf header: Add e_machine/e_flags to the header
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

Add 64-bits of feature data to record the ELF machine and flags. This
allows readers to initialize based on the data. For example, `perf kvm
stat` wants to initialize based on the kind of data to be read, but at
initialization time there are no threads to base this data upon and
using the host means cross platform support won't work. The values in
the perf_env also act as a cache for these within the session.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.h     |  3 +++
 tools/perf/util/header.c  | 33 +++++++++++++++++++++++++++++++++
 tools/perf/util/header.h  |  1 +
 tools/perf/util/session.c | 33 +++++++++++++++++++++++++++------
 4 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 76ba1a36e9ff..a4501cbca375 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -74,6 +74,9 @@ struct perf_env {
 	char			*os_release;
 	char			*version;
 	char			*arch;
+	/* e_machine expanded from 16 to 32-bits for alignment. */
+	u32			e_machine;
+	u32			e_flags;
 	int			nr_cpus_online;
 	int			nr_cpus_avail;
 	char			*cpu_desc;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 31c3bab1b10a..9142a8ba4019 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -379,6 +379,21 @@ static int write_arch(struct feat_fd *ff,
 	return do_write_string(ff, uts.machine);
 }
 
+static int write_e_machine(struct feat_fd *ff,
+			   struct evlist *evlist __maybe_unused)
+{
+	/* e_machine expanded from 16 to 32-bits for alignment. */
+	uint32_t e_flags;
+	uint32_t e_machine = perf_session__e_machine(evlist->session, &e_flags);
+	int ret;
+
+	ret = do_write(ff, &e_machine, sizeof(e_machine));
+	if (ret)
+		return ret;
+
+	return do_write(ff, &e_flags, sizeof(e_flags));
+}
+
 static int write_version(struct feat_fd *ff,
 			 struct evlist *evlist __maybe_unused)
 {
@@ -1785,6 +1800,12 @@ static void print_arch(struct feat_fd *ff, FILE *fp)
 	fprintf(fp, "# arch : %s\n", ff->ph->env.arch);
 }
 
+static void print_e_machine(struct feat_fd *ff, FILE *fp)
+{
+	fprintf(fp, "# e_machine : %u\n", ff->ph->env.e_machine);
+	fprintf(fp, "#   e_flags : %u\n", ff->ph->env.e_flags);
+}
+
 static void print_cpudesc(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# cpudesc : %s\n", ff->ph->env.cpu_desc);
@@ -2612,6 +2633,17 @@ FEAT_PROCESS_STR_FUN(arch, arch);
 FEAT_PROCESS_STR_FUN(cpudesc, cpu_desc);
 FEAT_PROCESS_STR_FUN(cpuid, cpuid);
 
+static int process_e_machine(struct feat_fd *ff, void *data __maybe_unused)
+{
+	int ret;
+
+	ret = do_read_u32(ff, &ff->ph->env.e_machine);
+	if (ret)
+		return ret;
+
+	return do_read_u32(ff, &ff->ph->env.e_flags);
+}
+
 #ifdef HAVE_LIBTRACEEVENT
 static int process_tracing_data(struct feat_fd *ff, void *data)
 {
@@ -3730,6 +3762,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
 	FEAT_OPR(PMU_CAPS,	pmu_caps,	false),
 	FEAT_OPR(CPU_DOMAIN_INFO,	cpu_domain_info,	true),
+	FEAT_OPR(E_MACHINE,	e_machine,	false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 36cc74e2d14d..cc40ac796f52 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -54,6 +54,7 @@ enum {
 	HEADER_HYBRID_TOPOLOGY,
 	HEADER_PMU_CAPS,
 	HEADER_CPU_DOMAIN_INFO,
+	HEADER_E_MACHINE,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 72e8bb67d740..53f51c3f9603 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2967,7 +2967,6 @@ struct perf_env *perf_session__env(struct perf_session *session)
 struct perf_session__e_machine_cb_args {
 	uint32_t e_flags;
 	uint16_t e_machine;
-	bool need_e_flags;
 };
 
 static int perf_session__e_machine_cb(struct thread *thread, void *_args)
@@ -2975,8 +2974,7 @@ static int perf_session__e_machine_cb(struct thread *thread, void *_args)
 	struct perf_session__e_machine_cb_args *args = _args;
 	struct machine *machine = maps__machine(thread__maps(thread));
 
-	args->e_machine = thread__e_machine(thread, machine,
-					    args->need_e_flags ? &args->e_flags : NULL);
+	args->e_machine = thread__e_machine(thread, machine, &args->e_flags);
 	return args->e_machine != EM_NONE ? 1 : 0;
 }
 
@@ -2988,8 +2986,8 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
 {
 	struct perf_session__e_machine_cb_args args = {
 		.e_machine = EM_NONE,
-		.need_e_flags = e_flags != NULL,
 	};
+	struct perf_env *env;
 
 	if (!session) {
 		/* Default to assuming a host machine. */
@@ -2999,12 +2997,35 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
 		return EM_HOST;
 	}
 
+	env = perf_session__env(session);
+	if (env && env->e_machine != EM_NONE) {
+		if (e_flags)
+			*e_flags = env->e_flags;
+
+		return env->e_machine;
+	}
+
 	machines__for_each_thread(&session->machines,
 				  perf_session__e_machine_cb,
 				  &args);
 
+	if (args.e_machine != EM_NONE) {
+		if (env) {
+			env->e_machine = args.e_machine;
+			env->e_flags = args.e_flags;
+		}
+		if (e_flags)
+			*e_flags = args.e_flags;
+
+		return args.e_machine;
+	}
+
+	/*
+	 * Couldn't determine from the perf_env or current set of
+	 * threads. Default to the host.
+	 */
 	if (e_flags)
-		*e_flags = args.e_flags;
+		*e_flags = EF_HOST;
 
-	return args.e_machine == EM_NONE ? EM_HOST : args.e_machine;
+	return EM_HOST;
 }
-- 
2.53.0.rc2.204.g2597b5adb4-goog

