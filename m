Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD63225785
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531956; cv=none; b=MrQyOK4VSKObV0q+yLM+QUtekcoNpt4q0u/lIMr+D9tIKd5N6LbK3U0Yp3oteRFloIpXLmvbmpubOoQzyxbh4p11blx98ZC+q77vw1ZE7bNbyaIOrISy4YSgZgJa18X7Dp+qOIjJFVpoA7aq1sCnWc07F5oDK66+GLlLgzeAgls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531956; c=relaxed/simple;
	bh=ssJnoXCMCIxg/r0KvR46wCsctcfmKPYwSEmK6Obx5Iw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tSrD87uLHpCsUnVHM6FwYcsIZ5HjKhr0VleWP6jHJeNhwNv7luDH1DQ/+PFvWTLDKhgMdyiBdj4qbhCTfh0RR5GOaRzALsBJbMuL6dzQKMGhFlg/mAFArdpnwGrFtdYFLIMLgR3vh8YUikHx8SFLa89qPliaBbr0pex5W232flI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJdUXJJA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJdUXJJA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2265a09dbfcso9901165ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531954; x=1744136754; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbTNVfPfGOZtV31+YgAoq7VcrpMcIRlshuKG92aboaA=;
        b=wJdUXJJA3LyeMiut7LqkxXdiDpExPzfr0yU0cM6QtPQjajAFtuiGCCLAu5T8r/tRv8
         enas/WZDRup5mH7aCg4qEgpaCBfyfskFA+MAGEorl/0N1O9j5pTHEPBzkNtuEFoL+xYZ
         kGbvE8zIiMGkf91ikK1TQdZ519g6uBHYLheohCdG+LMjF5YetLOjQaTG+0jBxjyRSAbZ
         VWxUf+Tn3ouTuSgIDQqI7nALBu/YbeF438S1ziiNAJ0gatbiq4mnhRhXrMz9cHaASURd
         i0Vxi94ZlIqASigjNap26U8m+VyII/IrhT2ORmDO7zcTMQHAYcJz9rgabNajoRSj10Oo
         M9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531954; x=1744136754;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbTNVfPfGOZtV31+YgAoq7VcrpMcIRlshuKG92aboaA=;
        b=aVUbrWpM0KfDRixrdyrrpglwJoIkqh45wP+Bkz848DD1F2PSXcUJGhGLPlyRU/+oaf
         7m0H68sIIhiA4sN9aoRyp4eubv+QTTFIzOWmmMO6PHtIjxofuddAjxXWFs5A6n0S6Iz3
         xb2irWSltEFefvpcpP+eyGzRMdeCd8IlG8gtVCACSm9TZ1asTLOmNUcqeeX5e+maOJGG
         UDzJUf9mggCvD00zeCRfTXQgb0mlOj/Yfysb0hgnybjxXjrWmx2fJ6ldTJOjSMOWSUju
         U1jDvLUgoJN7P6P9P+khliQxKOwvpOipC/8/W/zgcNwQxgipmn8VIU806JSqDEHmtV43
         aCCg==
X-Forwarded-Encrypted: i=1; AJvYcCXltBa2dnqjvuQQTAkd8IKojZzXVT16n+2tByir1LmI3ukY35LNBXfVTDtps+9KSaiAJuGQKeEFtu/X4t8MrY6t@vger.kernel.org
X-Gm-Message-State: AOJu0YyfIJ29Qtpw8sNCVCRKaCNUw2ahIxz0eZG7wzkMMo2G42WCbU+N
	93xW8RBxyegIZGlhTyVeBxVy13CRUspUiIAi+r2UBEX+34KNKCKdaCEanLepoklUF9hf5SiYrWm
	Oo5RhGw==
X-Google-Smtp-Source: AGHT+IGm8WFbj7OaIz/NHPNtyB0BO2iv3wTzzs/z112p+SUHgK9W3OD0HDZkH9Rbgrm4+EmSVllWh4/lTaJ6
X-Received: from plkk12.prod.google.com ([2002:a17:902:c40c:b0:215:48e7:5dc8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8b:b0:224:179a:3b8f
 with SMTP id d9443c01a7336-2292f979cb9mr211562555ad.23.1743531953315; Tue, 01
 Apr 2025 11:25:53 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:36 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-39-irogers@google.com>
Subject: [PATCH v1 38/48] perf sched: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
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
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
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
2.49.0.504.g3bcea36a83-goog

