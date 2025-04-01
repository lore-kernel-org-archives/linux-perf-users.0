Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C77B225A31
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531958; cv=none; b=H9YKJUIdsn4BuKmFe4pIQ8p0o2526m1muRDK5KxV5C4qWhBDfqPkdSmhd4zosDI9DFky4AZwVx/KX8KmQWuOTP+FW6nxhENk8ifgqXynV9R3IJYSW1r9Hg+2S1f59ZuI63e/tD+f3gxRBQXiR9QzNkk5yA/zcVWZ9FJzORHDvjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531958; c=relaxed/simple;
	bh=Hjo4Ux9EshIB5nfwsYSB2kHln+oQVK3YSkK+wa42IQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RRfJtV87nBIGLFz1mVfwja4AyTBtKWZpgeKEFuOBLV4j9q5iJmLldF5a6iujAUnTizsvd7vAW3B0O566fVEZk4nrOOtMICi8YzT6z1Z3L7C0NUUWBSa3dMI+v0W6GXKtgYEiq/LCz98FKG2dSP1hmd+FlmPTVmorSV0EQxIf0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yKhRsUlS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yKhRsUlS"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-229668c8659so5266215ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531956; x=1744136756; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AINsNHfUQ84TZtdqHe8YbE6Ea6bkBfLpawU4T3dHFsc=;
        b=yKhRsUlSN6yUyspeokDcU19vuxCDr9Wi13QX1AxHkiX+f94r69hFIIeTitXE8t3ltW
         XqPizZu36hp1KtcPysp1O7+dkvbD0KTlqD2wApbAbLA6VZPHmAAVzjAOivTTVoalFPfl
         VoKfoAPO+NV5D99PifdJW0CCbvh7mXQEUwPe5fx3lahtLFB1ME0xxLkfqrVXDX68x4qI
         /I2udtO7GZnHRIk/7YJD8qwV8/EJufZbPz648k/kOi4gH5jfzxOwN+3XBlq2u+dr0TNK
         zJIHpYnAWqZrQ1CJYe9/JxZp3NWaBVmdSfAe4TTUPP7nZluj3PPH+aoyLRcGREHWqu5S
         hc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531956; x=1744136756;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AINsNHfUQ84TZtdqHe8YbE6Ea6bkBfLpawU4T3dHFsc=;
        b=m+X6doNZrLONRVDsBVX09Ktg2eSsusm4/ZXDkUjaGDfG7E7z58/vLfsXw1iV1473oC
         FcLyLXAlSN+fvBcXo7528+LCNRCBIZ37dkOSoPOqx/40XsoretShVjhrZBs/S2WxTCPk
         Y/vihbfo5U0A+qce/Di2/7A1IxtqkP8PVFHlhSqUa5nUh8RuZQ4IdqmC7nQo/+Jmg4tz
         rQ7QE/1MRuKx6JdNUoBqSB2qcwTcS6jPRn6kXfS6zt1aVVcl9ba0DDoUQAu++m7NrimL
         GrEmnFZ4EaKneoC1BRooElImqZSqp2CTH+lu8lDQCQrShA1DCqZK/Kncsx3m6Eye4wAp
         2hBA==
X-Forwarded-Encrypted: i=1; AJvYcCUdLJUHJP1bkoq6TvvbdDgEpKJ5O+ERX8damlES7PENt9Gaa7xYtTAbw8UW2BFZHuLJDYI2pArqaDv302ne+ONM@vger.kernel.org
X-Gm-Message-State: AOJu0YxJRYDAHZO0fUmM0tOujvo2UZoRg5rYvvV0Q/noMEd6tFpnSQKz
	odj6skut6qNLecMQdcNobOL2irNWNIUGmvEX7SDj6GugVoN7ZgEzEyedi2MjJuw4kslJWEhcEYd
	5P4bZkQ==
X-Google-Smtp-Source: AGHT+IHXdSNd3g++jqN+fHHZIowU3mAWz41Q2ckrahN9Qab8zKJXOz5RlfbWGg1n8s9o1EELvcDlzidMfBca
X-Received: from plse12.prod.google.com ([2002:a17:902:b78c:b0:21f:b748:a1c8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1106:b0:215:b75f:a1cb
 with SMTP id d9443c01a7336-2292f9448a5mr207715785ad.9.1743531955685; Tue, 01
 Apr 2025 11:25:55 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:37 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-40-irogers@google.com>
Subject: [PATCH v1 39/48] perf timechart: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/builtin-timechart.c | 60 ++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 068d297aaf44..6d8d695f3099 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -118,7 +118,7 @@ struct per_pidcomm {
 	int		Y;
 	int		display;
 
-	long		state;
+	int		state;
 	u64		state_since;
 
 	char		*comm;
@@ -385,7 +385,7 @@ static struct power_event *p_state_end(struct timechart *tchart, int cpu,
 	if (!pwr)
 		return NULL;
 
-	pwr->state = cpus_pstate_state[cpu];
+	pwr->state = (int)cpus_pstate_state[cpu];
 	pwr->start_time = cpus_pstate_start_times[cpu];
 	pwr->end_time = timestamp;
 	pwr->cpu = cpu;
@@ -601,8 +601,8 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 			struct perf_sample *sample,
 			const char *backtrace __maybe_unused)
 {
-	u32 state  = evsel__intval(evsel, sample, "state");
-	u32 cpu_id = evsel__intval(evsel, sample, "cpu_id");
+	u32 state  = (u32)evsel__intval(evsel, sample, "state");
+	u32 cpu_id = (u32)evsel__intval(evsel, sample, "cpu_id");
 
 	if (state == (u32)PWR_EVENT_EXIT)
 		c_state_end(tchart, cpu_id, sample->time);
@@ -617,8 +617,8 @@ process_sample_cpu_frequency(struct timechart *tchart,
 			     struct perf_sample *sample,
 			     const char *backtrace __maybe_unused)
 {
-	u32 state  = evsel__intval(evsel, sample, "state");
-	u32 cpu_id = evsel__intval(evsel, sample, "cpu_id");
+	u32 state  = (u32)evsel__intval(evsel, sample, "state");
+	u32 cpu_id = (u32)evsel__intval(evsel, sample, "cpu_id");
 
 	p_state_change(tchart, cpu_id, sample->time, state);
 	return 0;
@@ -631,8 +631,8 @@ process_sample_sched_wakeup(struct timechart *tchart,
 			    const char *backtrace)
 {
 	u8 flags  = evsel__intval(evsel, sample, "common_flags");
-	int waker = evsel__intval(evsel, sample, "common_pid");
-	int wakee = evsel__intval(evsel, sample, "pid");
+	int waker = (int)evsel__intval(evsel, sample, "common_pid");
+	int wakee = (int)evsel__intval(evsel, sample, "pid");
 
 	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, backtrace);
 	return 0;
@@ -644,8 +644,8 @@ process_sample_sched_switch(struct timechart *tchart,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
-	int prev_pid   = evsel__intval(evsel, sample, "prev_pid");
-	int next_pid   = evsel__intval(evsel, sample, "next_pid");
+	int prev_pid   = (int)evsel__intval(evsel, sample, "prev_pid");
+	int next_pid   = (int)evsel__intval(evsel, sample, "next_pid");
 	u64 prev_state = evsel__intval(evsel, sample, "prev_state");
 
 	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
@@ -660,8 +660,8 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
 			   struct perf_sample *sample,
 			   const char *backtrace __maybe_unused)
 {
-	u64 cpu_id = evsel__intval(evsel, sample, "cpu_id");
-	u64 value  = evsel__intval(evsel, sample, "value");
+	int cpu_id = (int)evsel__intval(evsel, sample, "cpu_id");
+	int value  = (int)evsel__intval(evsel, sample, "value");
 
 	c_state_start(cpu_id, sample->time, value);
 	return 0;
@@ -683,7 +683,7 @@ process_sample_power_frequency(struct timechart *tchart,
 			       struct perf_sample *sample,
 			       const char *backtrace __maybe_unused)
 {
-	u64 cpu_id = evsel__intval(evsel, sample, "cpu_id");
+	int cpu_id = (int)evsel__intval(evsel, sample, "cpu_id");
 	u64 value  = evsel__intval(evsel, sample, "value");
 
 	p_state_change(tchart, cpu_id, sample->time, value);
@@ -697,10 +697,9 @@ process_sample_power_frequency(struct timechart *tchart,
  */
 static void end_sample_processing(struct timechart *tchart)
 {
-	u64 cpu;
 	struct power_event *pwr;
 
-	for (cpu = 0; cpu <= tchart->numcpus; cpu++) {
+	for (unsigned int cpu = 0; cpu <= tchart->numcpus; cpu++) {
 		/* C state */
 #if 0
 		pwr = zalloc(sizeof(*pwr));
@@ -723,7 +722,7 @@ static void end_sample_processing(struct timechart *tchart)
 			return;
 
 		if (!pwr->state)
-			pwr->state = tchart->min_freq;
+			pwr->state = (int)tchart->min_freq;
 	}
 }
 
@@ -812,7 +811,7 @@ static int pid_end_io_sample(struct timechart *tchart, int pid, int type,
 	}
 
 	if (ret < 0) {
-		sample->err = ret;
+		sample->err = (int)ret;
 	} else if (type == IOTYPE_READ || type == IOTYPE_WRITE ||
 		   type == IOTYPE_TX || type == IOTYPE_RX) {
 
@@ -852,7 +851,8 @@ process_enter_read(struct timechart *tchart,
 		   struct evsel *evsel,
 		   struct perf_sample *sample)
 {
-	long fd = evsel__intval(evsel, sample, "fd");
+	int fd = (int)evsel__intval(evsel, sample, "fd");
+
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_READ,
 				   sample->time, fd);
 }
@@ -872,7 +872,8 @@ process_enter_write(struct timechart *tchart,
 		    struct evsel *evsel,
 		    struct perf_sample *sample)
 {
-	long fd = evsel__intval(evsel, sample, "fd");
+	int fd = (int)evsel__intval(evsel, sample, "fd");
+
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_WRITE,
 				   sample->time, fd);
 }
@@ -892,7 +893,8 @@ process_enter_sync(struct timechart *tchart,
 		   struct evsel *evsel,
 		   struct perf_sample *sample)
 {
-	long fd = evsel__intval(evsel, sample, "fd");
+	int fd = (int)evsel__intval(evsel, sample, "fd");
+
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_SYNC,
 				   sample->time, fd);
 }
@@ -912,7 +914,8 @@ process_enter_tx(struct timechart *tchart,
 		 struct evsel *evsel,
 		 struct perf_sample *sample)
 {
-	long fd = evsel__intval(evsel, sample, "fd");
+	int fd = (int)evsel__intval(evsel, sample, "fd");
+
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_TX,
 				   sample->time, fd);
 }
@@ -932,7 +935,8 @@ process_enter_rx(struct timechart *tchart,
 		 struct evsel *evsel,
 		 struct perf_sample *sample)
 {
-	long fd = evsel__intval(evsel, sample, "fd");
+	int fd = (int)evsel__intval(evsel, sample, "fd");
+
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_RX,
 				   sample->time, fd);
 }
@@ -952,7 +956,8 @@ process_enter_poll(struct timechart *tchart,
 		   struct evsel *evsel,
 		   struct perf_sample *sample)
 {
-	long fd = evsel__intval(evsel, sample, "fd");
+	int fd = (int)evsel__intval(evsel, sample, "fd");
+
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_POLL,
 				   sample->time, fd);
 }
@@ -1034,7 +1039,7 @@ static void draw_c_p_states(struct timechart *tchart)
 	while (pwr) {
 		if (pwr->type == PSTATE) {
 			if (!pwr->state)
-				pwr->state = tchart->min_freq;
+				pwr->state = (int)tchart->min_freq;
 			svg_pstate(pwr->cpu, pwr->start_time, pwr->end_time, pwr->state);
 		}
 		pwr = pwr->next;
@@ -1310,7 +1315,7 @@ static void draw_process_bars(struct timechart *tchart)
 
 static void add_process_filter(const char *string)
 {
-	int pid = strtoull(string, NULL, 10);
+	int pid = (int)strtoull(string, NULL, 10);
 	struct process_filter *filt = malloc(sizeof(*filt));
 
 	if (!filt)
@@ -1458,7 +1463,6 @@ static int determine_display_io_tasks(struct timechart *timechart, u64 threshold
 
 static void write_svg_file(struct timechart *tchart, const char *filename)
 {
-	u64 i;
 	int count;
 	int thresh = tchart->io_events ? BYTES_THRESH : TIME_THRESH;
 
@@ -1494,7 +1498,7 @@ static void write_svg_file(struct timechart *tchart, const char *filename)
 
 		svg_legenda();
 
-		for (i = 0; i < tchart->numcpus; i++)
+		for (unsigned int i = 0; i < tchart->numcpus; i++)
 			svg_cpu_box(i, tchart->max_freq, tchart->turbo_frequency);
 
 		draw_cpu_usage(tchart);
@@ -1616,7 +1620,7 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 
 	session = perf_session__new(&data, &tchart->tool);
 	if (IS_ERR(session))
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 
 	symbol__init(&session->header.env);
 
-- 
2.49.0.504.g3bcea36a83-goog

