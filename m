Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E020297A66
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035534; cv=none; b=nScci80Sj21Xn4Zcsgh25Am66JiSXIHlvbZ0RKCCLFf7QhqarmTX85SSB7nwQxsB9yRTYPO4L65pMZqMd/DknCmDufnLtDqW9StEDiDZh+bTNQ2QC2VDrAyX+XY6C6mVMN7gm8fgIIZLDCjZ0Mf2b/q9cqjnPqYqZxq6Gxk9f1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035534; c=relaxed/simple;
	bh=XGoBcx3D/H0ZCdhZHARD0zny+FxHLW+cIFx/wfu4xVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uG89GHGc4/U0y7PWzkdkdfCZiAS0dzYPEG47oPdxhnmW8vcADniU2VxNf0A3EYruq+8bBTeGQ5xbjrsWLpiERTABzG7qgvkwsju7xkpEyK0p7KDIhSgVBTZ9rSycyPuFZvHMbvmc1yw3XBlllmSUJmJpaMeHGjx/MQsKbFoHHJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exBlFRNm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exBlFRNm"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736c7df9b6cso205054b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035532; x=1746640332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w56r5yD+llVBppVE82Mu0qD/2xbGhukFK1UtBnrRVLE=;
        b=exBlFRNmvTQu2vAKzxicqIcre+Sor8g52hBAwPTvAPpoS6TJdAOHllPXSXXYpdYT68
         vAc+RDyJVIkfwnS/oyW3W3k+Rv07cI90ByfV1FUxB7sWZtz3K8a2gy83HSNZIA+AjtRm
         YTN3FoR9FW+ofhp036j9IqAdXeuXgE41/uIfAw+5FA7epK7hW3sI0oM3XQ+u2qcaPgb4
         da66ZSmvaf8/hIbYYgQjEBBml+tqnYysovLFvks7EyqrmrSN0IxRymdOZNY1N+RqWRFZ
         b5lLshowB51cUcpBRPPzUbo214tEBSj9g1vyZj/4SisbJ2G1F7EpYLsqaqibRfJbdsFW
         EUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035532; x=1746640332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w56r5yD+llVBppVE82Mu0qD/2xbGhukFK1UtBnrRVLE=;
        b=QoY3xr0C+ZvMNi6DVwyZL12/XepNpf5B5ufajX76pPQGlmXBlYcTwdmo2gZhit3ew4
         JxwiwuLaW2cOQukLJDvgtdpBuHnodNscOPWrwQT3Fcp6A5tRna7NbY2j8QtRuyAmFATQ
         uoWZToJ0AHY7f5iSgicT0SyGVOivR//1jQD02LXUORnW8JQ0nRpssr6uTpU5X6yrzPz6
         rW3e8+7zluw2QosxPFWbWqlTRiyBqzx6kfQNWVKxrmwlxNxOuQ0uvyaIqLqzKjOdKGYe
         BdqZ9FKZGT/CKowPmTN5SS3BBYfer39dQSVlPbHsuTZhEUz2Gk0+l/ltPKjqrwc8hpFY
         Ex8A==
X-Forwarded-Encrypted: i=1; AJvYcCVOKMr1OJpPsRqFr2hRUqlyC91IJzXIU75H25llWzGMU8Qm9egtiCuue3zrwGwvW1QpYH7mAN/x/s2j1q9ccr8l@vger.kernel.org
X-Gm-Message-State: AOJu0Yztyq78pAQcWTn8UDwa0TLHXzETAzGTwKVd0nb/TvJaaOGAjAWt
	1fs46VAA1J4UBQwW9wKqipQSHytsatwnc19y7ZG23HgpzViqNtejCipTmW1gzWRXqM0HoP/k9vp
	5Gu3fUA==
X-Google-Smtp-Source: AGHT+IEG2H18HfSkFwhCm6JIClX1smQ32JR4nn0f4Vp6aXlfgZgbVPE4bsUM8G5SQKBKoX3/sC9tOtKBt+/7
X-Received: from pgwb26.prod.google.com ([2002:a65:669a:0:b0:b0b:2e92:bd7c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d526:b0:1f5:8a1d:3904
 with SMTP id adf61e73a8af0-20aa26d41b1mr5336515637.7.1746035532110; Wed, 30
 Apr 2025 10:52:12 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:25 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-38-irogers@google.com>
Subject: [PATCH v2 37/47] perf sched: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 56 +++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 26ece6e9bfd1..8ddb0bab5748 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -595,7 +595,7 @@ static int self_open_counters(struct perf_sched *sched, unsigned long cur_task)
 static u64 get_cpu_usage_nsec_self(int fd)
 {
 	u64 runtime;
-	int ret;
+	ssize_t ret;
 
 	ret = read(fd, &runtime, sizeof(runtime));
 	BUG_ON(ret != sizeof(runtime));
@@ -823,7 +823,7 @@ replay_wakeup_event(struct perf_sched *sched,
 		    struct machine *machine __maybe_unused)
 {
 	const char *comm = evsel__strval(evsel, sample, "comm");
-	const u32 pid	 = evsel__intval(evsel, sample, "pid");
+	const u32 pid	 = (u32)evsel__intval(evsel, sample, "pid");
 	struct task_desc *waker, *wakee;
 
 	if (verbose > 0) {
@@ -846,8 +846,8 @@ static int replay_switch_event(struct perf_sched *sched,
 {
 	const char *prev_comm  = evsel__strval(evsel, sample, "prev_comm"),
 		   *next_comm  = evsel__strval(evsel, sample, "next_comm");
-	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
-		  next_pid = evsel__intval(evsel, sample, "next_pid");
+	const u32 prev_pid = (u32)evsel__intval(evsel, sample, "prev_pid"),
+		  next_pid = (u32)evsel__intval(evsel, sample, "next_pid");
 	struct task_desc *prev, __maybe_unused *next;
 	u64 timestamp0, timestamp = sample->time;
 	int cpu = sample->cpu;
@@ -1116,8 +1116,8 @@ static int latency_switch_event(struct perf_sched *sched,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
-	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
-		  next_pid = evsel__intval(evsel, sample, "next_pid");
+	const u32 prev_pid = (u32)evsel__intval(evsel, sample, "prev_pid"),
+		  next_pid = (u32)evsel__intval(evsel, sample, "next_pid");
 	const char prev_state = evsel__taskstate(evsel, sample, "prev_state");
 	struct work_atoms *out_events, *in_events;
 	struct thread *sched_out, *sched_in;
@@ -1186,7 +1186,7 @@ static int latency_runtime_event(struct perf_sched *sched,
 				 struct perf_sample *sample,
 				 struct machine *machine)
 {
-	const u32 pid	   = evsel__intval(evsel, sample, "pid");
+	const u32 pid	   = (u32)evsel__intval(evsel, sample, "pid");
 	const u64 runtime  = evsel__intval(evsel, sample, "runtime");
 	struct thread *thread = machine__findnew_thread(machine, -1, pid);
 	struct work_atoms *atoms = thread_atoms_search(&sched->atom_root, thread, &sched->cmp_pid);
@@ -1221,7 +1221,7 @@ static int latency_wakeup_event(struct perf_sched *sched,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
-	const u32 pid	  = evsel__intval(evsel, sample, "pid");
+	const u32 pid = (u32)evsel__intval(evsel, sample, "pid");
 	struct work_atoms *atoms;
 	struct work_atom *atom;
 	struct thread *wakee;
@@ -1282,7 +1282,7 @@ static int latency_migrate_task_event(struct perf_sched *sched,
 				      struct perf_sample *sample,
 				      struct machine *machine)
 {
-	const u32 pid = evsel__intval(evsel, sample, "pid");
+	const u32 pid = (u32)evsel__intval(evsel, sample, "pid");
 	u64 timestamp = sample->time;
 	struct work_atoms *atoms;
 	struct work_atom *atom;
@@ -1618,8 +1618,8 @@ static void print_sched_map(struct perf_sched *sched, struct perf_cpu this_cpu,
 static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			    struct perf_sample *sample, struct machine *machine)
 {
-	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
-	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid");
+	const u32 next_pid = (u32)evsel__intval(evsel, sample, "next_pid");
+	const u32 prev_pid = (u32)evsel__intval(evsel, sample, "prev_pid");
 	struct thread *sched_in, *sched_out;
 	struct thread_runtime *tr;
 	int new_shortname;
@@ -1641,7 +1641,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 		sched->max_cpu = this_cpu;
 
 	if (sched->map.comp) {
-		cpus_nr = bitmap_weight(sched->map.comp_cpus_mask, MAX_CPUS);
+		cpus_nr = (int)bitmap_weight(sched->map.comp_cpus_mask, MAX_CPUS);
 		if (!__test_and_set_bit(this_cpu.cpu, sched->map.comp_cpus_mask)) {
 			sched->map.comp_cpus[cpus_nr++] = this_cpu;
 			new_cpu = true;
@@ -1784,8 +1784,8 @@ static int process_sched_switch_event(const struct perf_tool *tool,
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
 	int this_cpu = sample->cpu, err = 0;
-	u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
-	    next_pid = evsel__intval(evsel, sample, "next_pid");
+	u32 prev_pid = (u32)evsel__intval(evsel, sample, "prev_pid");
+	u32 next_pid = (u32)evsel__intval(evsel, sample, "next_pid");
 
 	if (sched->curr_pid[this_cpu] != (u32)-1) {
 		/*
@@ -1919,7 +1919,7 @@ static int perf_sched__read_events(struct perf_sched *sched)
 	session = perf_session__new(&data, &sched->tool);
 	if (IS_ERR(session)) {
 		pr_debug("Error creating perf session");
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 	}
 
 	symbol__init(&session->header.env);
@@ -1990,7 +1990,7 @@ static void evsel__save_time(struct evsel *evsel, u64 timestamp, u32 cpu)
 		return;
 
 	if ((cpu >= r->ncpu) || (r->last_time == NULL)) {
-		int i, n = __roundup_pow_of_two(cpu+1);
+		u32 n = (u32)__roundup_pow_of_two(cpu+1);
 		void *p = r->last_time;
 
 		p = realloc(r->last_time, n * sizeof(u64));
@@ -1998,7 +1998,7 @@ static void evsel__save_time(struct evsel *evsel, u64 timestamp, u32 cpu)
 			return;
 
 		r->last_time = p;
-		for (i = r->ncpu; i < n; ++i)
+		for (u32 i = r->ncpu; i < n; ++i)
 			r->last_time[i] = (u64) 0;
 
 		r->ncpu = n;
@@ -2146,7 +2146,7 @@ static void timehist_print_sample(struct perf_sched *sched,
 {
 	struct thread_runtime *tr = thread__priv(thread);
 	const char *next_comm = evsel__strval(evsel, sample, "next_comm");
-	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
+	const u32 next_pid = (u32)evsel__intval(evsel, sample, "next_pid");
 	u32 max_cpus = sched->max_cpu.cpu + 1;
 	char tstr[64];
 	char nstr[30];
@@ -2415,7 +2415,7 @@ static struct thread *get_idle_thread(int cpu)
 	 * structs if needed
 	 */
 	if ((cpu >= idle_max_cpu) || (idle_threads == NULL)) {
-		int i, j = __roundup_pow_of_two(cpu+1);
+		int j = (int)__roundup_pow_of_two(cpu+1);
 		void *p;
 
 		p = realloc(idle_threads, j * sizeof(struct thread *));
@@ -2423,7 +2423,7 @@ static struct thread *get_idle_thread(int cpu)
 			return NULL;
 
 		idle_threads = (struct thread **) p;
-		for (i = idle_max_cpu; i < j; ++i)
+		for (int i = idle_max_cpu; i < j; ++i)
 			idle_threads[i] = NULL;
 
 		idle_max_cpu = j;
@@ -2530,7 +2530,7 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 		if (tr && tr->prio != -1)
 			prio = tr->prio;
 		else if (evsel__name_is(evsel, "sched:sched_switch"))
-			prio = evsel__intval(evsel, sample, "prev_prio");
+			prio = (int)evsel__intval(evsel, sample, "prev_prio");
 
 		if (prio != -1 && !test_bit(prio, sched->prio_bitmap)) {
 			rc = true;
@@ -2602,7 +2602,7 @@ static int timehist_sched_wakeup_event(const struct perf_tool *tool,
 	struct thread *thread;
 	struct thread_runtime *tr = NULL;
 	/* want pid of awakened task not pid in sample */
-	const u32 pid = evsel__intval(evsel, sample, "pid");
+	const u32 pid = (u32)evsel__intval(evsel, sample, "pid");
 
 	thread = machine__findnew_thread(machine, 0, pid);
 	if (thread == NULL)
@@ -2638,8 +2638,8 @@ static void timehist_print_migration_event(struct perf_sched *sched,
 		return;
 
 	max_cpus = sched->max_cpu.cpu + 1;
-	ocpu = evsel__intval(evsel, sample, "orig_cpu");
-	dcpu = evsel__intval(evsel, sample, "dest_cpu");
+	ocpu = (u32)evsel__intval(evsel, sample, "orig_cpu");
+	dcpu = (u32)evsel__intval(evsel, sample, "dest_cpu");
 
 	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
 	if (thread == NULL)
@@ -2686,7 +2686,7 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
 	struct thread *thread;
 	struct thread_runtime *tr = NULL;
 	/* want pid of migrated task not pid in sample */
-	const u32 pid = evsel__intval(evsel, sample, "pid");
+	const u32 pid = (u32)evsel__intval(evsel, sample, "pid");
 
 	thread = machine__findnew_thread(machine, 0, pid);
 	if (thread == NULL)
@@ -2714,8 +2714,8 @@ static void timehist_update_task_prio(struct evsel *evsel,
 {
 	struct thread *thread;
 	struct thread_runtime *tr = NULL;
-	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
-	const u32 next_prio = evsel__intval(evsel, sample, "next_prio");
+	const u32 next_pid = (u32)evsel__intval(evsel, sample, "next_pid");
+	const u32 next_prio = (u32)evsel__intval(evsel, sample, "next_prio");
 
 	if (next_pid == 0)
 		thread = get_idle_thread(sample->cpu);
@@ -3258,7 +3258,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
 
 	session = perf_session__new(&data, &sched->tool);
 	if (IS_ERR(session))
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 
 	if (cpu_list) {
 		err = perf_session__cpu_bitmap(session, cpu_list, cpu_bitmap);
-- 
2.49.0.906.g1f30a19c02-goog

