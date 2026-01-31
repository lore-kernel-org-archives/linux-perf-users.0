Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768636EAAB
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Jan 2026 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889761; cv=none; b=ACggOHi5c+UgsCTFvYRQ6D7GYNCGmTFdpd6b5YZb5pDCG7H+ptANRgX7Qeh2YNQnVVnZfuMjaMvn8TYmUdzDh0C8ruh94EelEkAudyIPl/Q2mP23qTUHozNswUGGtAm13a3uNl0Xq2/ERl2nvqDsStGfil1UNuakR0mvBpPLcFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889761; c=relaxed/simple;
	bh=OzSHZgVSQiPsRKExjnMPTpTbG3IhOOTKw3fuldg3o4k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LYj9ZKAaHDf+IlocZBTDfiRK0l0P+ryuIA/5REByWvwWdm2lVgGW6FafutL5oc6lDz2sYmb5p6mO4XVxVGXKk/70eoMx3vKKHpUMZZDfLbZd7IXKqqMVxSzPU2rwmA2+WU2YvYyOeKwB1s8TuchmYrvAqknQh0TYHqP4YNRuR98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSfIHd2H; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSfIHd2H"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b799f7a603so17524344eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Jan 2026 12:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769889759; x=1770494559; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbIIGfMQy8kU/29JW+xHk5T5mRSTZKfA14hCK/ZK1Tw=;
        b=KSfIHd2HBrbZCM+FKwPAInhYPbUEazvXCZHwsFC3+q80lQN22WeqQa+ufNMm0h+wq9
         by5LsKtLPUxbXv/Ay+ZOTeMoU9QSaTe54B3yZ9It1htNQCR5OY1NljAO2jhHtS57mkVs
         1EM++xo86V8bh6dAOokEKIPdP3KGExGwGmKxYf5HnhL0qG6RsjS1SPrGbZKmNmuaSLS/
         To1m2gQc7jClwvOuZ0DgpYcFCxYl0YLu3oYKRA6YJVb7Iqsgc+u9FzmA2EQJy+pn+ae+
         Wjw1bFGZYOjIyEuEEfQG2qF+fPf1KxEZt2tHwY7YylEJ/+LoqVOLzrpp/H5YMCjbm/Mt
         IAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769889759; x=1770494559;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbIIGfMQy8kU/29JW+xHk5T5mRSTZKfA14hCK/ZK1Tw=;
        b=gHIwSO4EiD8hp61sumiLgMmmLGf98FqZ8rwuUwxB2bDGKx17pExOG5Jug8w5XiGbCG
         ds7i9KRKZ24OoHL7M1Jq42MwotNZpwBvXJ0p07VEO7A3HnoHL5s1CltSlqTHejpsCwBa
         7/NzSR2zGo3Mqs6Xp66wZRjCJFijkH0gWmDiH21vlxDJ49TeRFqNxHTZ09ldWDP0Uq6v
         8vnPHcuWFF9XS95Hmi3vmH/2I4h0R4r3UeBIdTvMK5WhEGfqjVwiizGA63vju0q2aHm+
         vuaUrlJTJGuspLO5osFlRG48OM961q3I2RTwqSb/yQ09CuHxHu95sSe8OEp6STA64Ka4
         19EA==
X-Forwarded-Encrypted: i=1; AJvYcCVdpJmEwXZXWq4rI5EViuPRrPVDntNRFOn+KLfLdSKgtU7VsJJ1JKwdz81T92XqvylVLp948BJgproTM4fkF2Mq@vger.kernel.org
X-Gm-Message-State: AOJu0YywFW0bjVQ9IuQXnBpC5vpL0aZwWeZ7jhJM9BDn+jS+DN5JddgE
	xICQW3fvqpEVDuI8HSiHqe5O7uaZPBU5l9lsVH6YXhk8yFPM75FETmVFsDQ9mjvuWoHzCRneU3a
	jZWx44bByIw==
X-Received: from dycoz4.prod.google.com ([2002:a05:7301:fc84:b0:2b6:bdce:fb0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:434f:b0:2b7:1746:c947
 with SMTP id 5a478bee46e88-2b7c86268ebmr3367037eec.6.1769889759132; Sat, 31
 Jan 2026 12:02:39 -0800 (PST)
Date: Sat, 31 Jan 2026 12:02:23 -0800
In-Reply-To: <20260131200224.1296136-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131200224.1296136-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131200224.1296136-6-irogers@google.com>
Subject: [PATCH v2 5/6] perf header: Add e_machine/e_flags to the header
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
index eefd1cd73b6a..196bbe0c8407 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -378,6 +378,21 @@ static int write_arch(struct feat_fd *ff,
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
@@ -1784,6 +1799,12 @@ static void print_arch(struct feat_fd *ff, FILE *fp)
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
@@ -2611,6 +2632,17 @@ FEAT_PROCESS_STR_FUN(arch, arch);
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
@@ -3729,6 +3761,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
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
2.53.0.rc1.225.gd81095ad13-goog

