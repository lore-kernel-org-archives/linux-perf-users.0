Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC4827602E
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035470; cv=none; b=Gv0MfaYB/13NsBiCXRzjO0eZDzTQIR6YbzKa6yVfIk2TvECf7Xte2f6+iKUgCmCX4OsTfgLM7+a7iKURPdhQMGQdxkwUHs3jpvdKQ0fd+m+FE14um73lIK0npfCFZQXrn/dpD4s+9vibj3dyxsnXFoErNAMysM1nN9zZf94x53g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035470; c=relaxed/simple;
	bh=tzHoFVvqF7tZ5zDdvSBlUB5Nky5e43gxmTueOG1LlaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a3AIVIJtvEPVCtOzlqurf4L8Gf7jYPp1AXFuoXGmmiZKEQufQNioWHBne8rG1TX/+2BRdz4OEPVpy1vBDdPca7lyCLS9/9d5CbY36/AjZhO/lND1ts0oznzRTCvfANwHZDv70msYALUUnUk3k6ry0zJwmLXD0Zec3amY+8VIDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aNqzSpie; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aNqzSpie"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7394772635dso91078b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035466; x=1746640266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BKlr9pon+7w1T67KBxwboNOGjH8z6Rox+PAx2UWIQ/8=;
        b=aNqzSpieLwXkk4ieqANtDUDYZ4wegdhfFhsWUf1fBvpmOxKW5kWbNUekS5OxrO48WP
         X1rD1cAE4Mk1HGdxRLTuE3+nEuzs1zOjURLnMtj45sL3OLwZ+0hQG2vGCdgqdmjvERXG
         4hjUJ2MudkTMNgj161aG5RLpYrIYrxbNvyPBRptkuMP31Iku/oFVsUaUaoMoypyGMmZd
         yoDPH/MErojZZhc/jZjAPPpd/piF5pOfHYr3rY/d1Csf7syHrrmoeOcsa/vydq6bE2Ao
         i+GRrycy2X/B2cBPrommZjbekucZsasSd8osLrayXXwUMvTzhUy53da3I50Xmsayrppz
         ABeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035466; x=1746640266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKlr9pon+7w1T67KBxwboNOGjH8z6Rox+PAx2UWIQ/8=;
        b=wtyxj4MGHVKsrHrdVRkddxrPBi9nA6MNHIfPBqSAAiJvCmpOLPd3fK0Pc5RldpUo2l
         S7zOs9egIYLt2EGJzFEm+8SQJGR0pWRVk8Ti+JuQYD3LXGzqbyuRkuc5IXgkjGU9cQ+j
         5TWFRRgZLNCqrqLahF/oAQpNQDL/X3DDRcI2MNoxOmWrgCB/8sgImAbFIxcJAWet539C
         0sPku4x7U0+gUKx20Q6V2TscuPIPli8E1syXwOvq4GEXdro1qvqUQBWAqpEH8Sb/x40s
         ZdfIVY2tngE4xFLCIbJXOUSG9JUlyWuIHpJhOEh17iHY+GYmAOXZWo5QG5K3KdQyAAWa
         oBxg==
X-Forwarded-Encrypted: i=1; AJvYcCXBy0aLtuPSKSMMNFVJ4f+NttlSeuyqa+W0M3Mi5FZMC7iZ1X0fev/3bh8dEw+8m2lURDcY3npX0+a7or2WY8Tf@vger.kernel.org
X-Gm-Message-State: AOJu0YwOvV62Rl1zBvHs7arNCllH63J0TYkjFb8KBvrYcZoLF1rF0koS
	DHT/ojM2m1vqDjSnEM7V9CchFU61PZtTmHoNOoZ7YuRHPmcfwEAkhaG2JnkJiDfgF46sONPoHJx
	4aqte+g==
X-Google-Smtp-Source: AGHT+IEvfCaQRBg4HaHRic54PooLid+vwMTTSRFafNXb/3ZzRoRt9dKqoM/six2KuYpANstVXaueapGaZsPj
X-Received: from pgng14.prod.google.com ([2002:a63:374e:0:b0:b1a:e979:b40f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1588:b0:1f5:8e94:2e81
 with SMTP id adf61e73a8af0-20ba6a20782mr153899637.9.1746035466023; Wed, 30
 Apr 2025 10:51:06 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:49:52 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-5-irogers@google.com>
Subject: [PATCH v2 04/47] perf bench: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/bench/breakpoint.c           |  8 +++++---
 tools/perf/bench/epoll-wait.c           |  3 ++-
 tools/perf/bench/evlist-open-close.c    |  8 ++++----
 tools/perf/bench/find-bit-bench.c       |  5 +++--
 tools/perf/bench/futex.h                |  4 ++--
 tools/perf/bench/inject-buildid.c       |  8 ++++----
 tools/perf/bench/mem-functions.c        |  2 +-
 tools/perf/bench/pmu-scan.c             | 12 ++++++------
 tools/perf/bench/sched-messaging.c      |  4 ++--
 tools/perf/bench/sched-pipe.c           | 15 +++++++++------
 tools/perf/bench/sched-seccomp-notify.c |  2 +-
 tools/perf/bench/synthesize.c           |  6 +++---
 tools/perf/builtin-bench.c              |  2 +-
 13 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/tools/perf/bench/breakpoint.c b/tools/perf/bench/breakpoint.c
index dfd18f5db97d..72802b334eeb 100644
--- a/tools/perf/bench/breakpoint.c
+++ b/tools/perf/bench/breakpoint.c
@@ -57,7 +57,7 @@ static int breakpoint_setup(void *addr)
 	attr.bp_addr = (unsigned long)addr;
 	attr.bp_type = HW_BREAKPOINT_RW;
 	attr.bp_len = HW_BREAKPOINT_LEN_1;
-	fd = syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0);
+	fd = (int)syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0);
 
 	if (fd < 0)
 		fd = -errno;
@@ -111,7 +111,8 @@ static void *breakpoint_thread(void *arg)
 // then starts nparallel threads which create and join bench_repeat batches of nthreads threads.
 int bench_breakpoint_thread(int argc, const char **argv)
 {
-	unsigned int i, result_usec;
+	unsigned int i;
+	long result_usec;
 	int repeat = bench_repeat;
 	struct breakpoint *breakpoints;
 	pthread_t *parallel;
@@ -197,7 +198,8 @@ static const char * const enable_usage[] = {
 // and then disables and enables the breakpoint bench_repeat times.
 int bench_breakpoint_enable(int argc, const char **argv)
 {
-	unsigned int i, nthreads, result_usec, done = 0;
+	unsigned int i, nthreads, done = 0;
+	long result_usec;
 	char watched;
 	int fd;
 	pthread_t *threads;
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 20fe4f72b4af..5ea3e0b2daf2 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -182,7 +182,8 @@ static void shuffle(void *array, size_t n, size_t size)
 
 static void *workerfn(void *arg)
 {
-	int fd, ret, r;
+	int fd, ret;
+	ssize_t r;
 	struct worker *w = (struct worker *) arg;
 	unsigned long ops = w->ops;
 	struct epoll_event ev;
diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index 79cedcf94a39..6b75e2dc2fbf 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -173,16 +173,16 @@ static char *bench__repeat_event_string(const char *evstr, int n)
 {
 	char sbuf[STRERR_BUFSIZE];
 	struct strbuf buf;
-	int i, str_size = strlen(evstr),
-	    final_size = str_size * n + n,
-	    err = strbuf_init(&buf, final_size);
+	size_t str_size = strlen(evstr);
+	size_t final_size = str_size * n + n;
+	int err = strbuf_init(&buf, final_size);
 
 	if (err) {
 		pr_err("strbuf_init: %s\n", str_error_r(err, sbuf, sizeof(sbuf)));
 		goto out_error;
 	}
 
-	for (i = 0; i < n; i++) {
+	for (int i = 0; i < n; i++) {
 		err = strbuf_add(&buf, evstr, str_size);
 		if (err) {
 			pr_err("strbuf_add: %s\n", str_error_r(err, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
index 7e25b0e413f6..59b00e89f71b 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -31,7 +31,7 @@ static const char *const bench_usage[] = {
 static unsigned int accumulator;
 static unsigned int use_of_val;
 
-static noinline void workload(int val)
+static noinline void workload(unsigned long val)
 {
 	use_of_val += val;
 	accumulator++;
@@ -59,8 +59,9 @@ static int do_for_each_set_bit(unsigned int num_bits)
 	u64 runtime_us;
 	struct stats fb_time_stats, tb_time_stats;
 	double time_average, time_stddev;
-	unsigned int bit, i, j;
+	unsigned int i, j;
 	unsigned int set_bits, skip;
+	unsigned long bit;
 
 	init_stats(&fb_time_stats);
 	init_stats(&tb_time_stats);
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index ebdc2b032afc..6d9076e091eb 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -49,14 +49,14 @@ static inline int
 futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct timespec *timeout,
 	      volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3);
+	return (int)syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3);
 }
 
 static inline int
 futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t val, int nr_requeue,
 			 volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2, val3);
+	return (int)syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2, val3);
 }
 
 /**
diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index f55c07e4be94..b78de817e721 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -175,7 +175,7 @@ static ssize_t synthesize_mmap(struct bench_data *data, struct bench_dso *dso, u
 	union perf_event event;
 	size_t len = offsetof(struct perf_record_mmap2, filename);
 	u64 *id_hdr_ptr = (void *)&event;
-	int ts_idx;
+	size_t ts_idx;
 
 	len += roundup(strlen(dso->name) + 1, 8) + bench_id_hdr_size;
 
@@ -250,14 +250,14 @@ static void *data_reader(void *arg)
 	struct bench_data *data = arg;
 	char buf[8192];
 	int flag;
-	int n;
 
 	flag = fcntl(data->output_pipe[0], F_GETFL);
 	fcntl(data->output_pipe[0], F_SETFL, flag | O_NONBLOCK);
 
 	/* read out data from child */
 	while (true) {
-		n = read(data->output_pipe[0], buf, sizeof(buf));
+		ssize_t n = read(data->output_pipe[0], buf, sizeof(buf));
+
 		if (n > 0)
 			continue;
 		if (n == 0)
@@ -451,7 +451,7 @@ static void do_inject_loop(struct bench_data *data, bool build_id_all)
 static int do_inject_loops(struct bench_data *data)
 {
 
-	srand(time(NULL));
+	srand((int)time(NULL));
 	symbol__init(NULL);
 
 	bench_sample_type  = PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP;
diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 19d45c377ac1..672b76eb8f99 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -82,7 +82,7 @@ static int init_cycles(void)
 
 static u64 get_cycles(void)
 {
-	int ret;
+	ssize_t ret;
 	u64 clk;
 
 	ret = read(cycles_fd, &clk, sizeof(u64));
diff --git a/tools/perf/bench/pmu-scan.c b/tools/perf/bench/pmu-scan.c
index 9e4d36486f62..4a885d4bd279 100644
--- a/tools/perf/bench/pmu-scan.c
+++ b/tools/perf/bench/pmu-scan.c
@@ -19,8 +19,8 @@ static unsigned int iterations = 100;
 
 struct pmu_scan_result {
 	char *name;
-	int nr_aliases;
-	int nr_formats;
+	size_t nr_aliases;
+	size_t nr_formats;
 	int nr_caps;
 	bool is_core;
 };
@@ -63,7 +63,7 @@ static int save_result(void)
 		list_for_each(list, &pmu->format)
 			r->nr_formats++;
 
-		pr_debug("pmu[%d] name=%s, nr_caps=%d, nr_aliases=%d, nr_formats=%d\n",
+		pr_debug("pmu[%d] name=%s, nr_caps=%d, nr_aliases=%zu, nr_formats=%zu\n",
 			nr_pmus, r->name, r->nr_caps, r->nr_aliases, r->nr_formats);
 		nr_pmus++;
 	}
@@ -77,7 +77,7 @@ static int check_result(bool core_only)
 	struct pmu_scan_result *r;
 	struct perf_pmu *pmu;
 	struct list_head *list;
-	int nr;
+	size_t nr;
 
 	for (int i = 0; i < nr_pmus; i++) {
 		r = &results[i];
@@ -98,7 +98,7 @@ static int check_result(bool core_only)
 
 		nr = perf_pmu__num_events(pmu);
 		if (nr != r->nr_aliases) {
-			pr_err("Unmatched number of event aliases in %s: expect %d vs got %d\n",
+			pr_err("Unmatched number of event aliases in %s: expect %zu vs got %zu\n",
 				pmu->name, r->nr_aliases, nr);
 			return -1;
 		}
@@ -107,7 +107,7 @@ static int check_result(bool core_only)
 		list_for_each(list, &pmu->format)
 			nr++;
 		if (nr != r->nr_formats) {
-			pr_err("Unmatched number of event formats in %s: expect %d vs got %d\n",
+			pr_err("Unmatched number of event formats in %s: expect %zu vs got %zu\n",
 				pmu->name, r->nr_formats, nr);
 			return -1;
 		}
diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 93dcd9dba3d0..a2eb47944f44 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -102,7 +102,7 @@ static void *sender(struct sender_context *ctx)
 	/* Now pump to every receiver. */
 	for (i = 0; i < nr_loops; i++) {
 		for (j = 0; j < ctx->num_fds; j++) {
-			int ret, done = 0;
+			ssize_t ret, done = 0;
 
 again:
 			ret = write(ctx->out_fds[j], data + done,
@@ -133,7 +133,7 @@ static void *receiver(struct receiver_context* ctx)
 	/* Receive them all */
 	for (i = 0; i < ctx->num_packets; i++) {
 		char data[DATASIZE];
-		int ret, done = 0;
+		ssize_t ret, done = 0;
 
 again:
 		ret = read(ctx->in_fds[0], data + done, DATASIZE - done);
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 70139036d68f..b847213fd616 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -102,7 +102,8 @@ static const char * const bench_sched_pipe_usage[] = {
 static int enter_cgroup(int nr)
 {
 	char buf[32];
-	int fd, len, ret;
+	int fd;
+	ssize_t ret, len;
 	int saved_errno;
 	struct cgroup *cgrp;
 	pid_t pid;
@@ -118,7 +119,7 @@ static int enter_cgroup(int nr)
 	cgrp = cgrps[nr];
 
 	if (threaded)
-		pid = syscall(__NR_gettid);
+		pid = (pid_t)syscall(__NR_gettid);
 	else
 		pid = getpid();
 
@@ -172,23 +173,25 @@ static void exit_cgroup(int nr)
 
 static inline int read_pipe(struct thread_data *td)
 {
-	int ret, m;
+	ssize_t ret;
+	int m;
 retry:
 	if (nonblocking) {
 		ret = epoll_wait(td->epoll_fd, &td->epoll_ev, 1, -1);
 		if (ret < 0)
-			return ret;
+			return (int)ret;
 	}
 	ret = read(td->pipe_read, &m, sizeof(int));
 	if (nonblocking && ret < 0 && errno == EWOULDBLOCK)
 		goto retry;
-	return ret;
+	return (int)ret;
 }
 
 static void *worker_thread(void *__tdata)
 {
 	struct thread_data *td = __tdata;
-	int i, ret, m = 0;
+	int i, m = 0;
+	ssize_t ret;
 
 	ret = enter_cgroup(td->nr);
 	if (ret < 0) {
diff --git a/tools/perf/bench/sched-seccomp-notify.c b/tools/perf/bench/sched-seccomp-notify.c
index 269c1f4a6852..4f0c68b366e3 100644
--- a/tools/perf/bench/sched-seccomp-notify.c
+++ b/tools/perf/bench/sched-seccomp-notify.c
@@ -43,7 +43,7 @@ static const char * const bench_seccomp_usage[] = {
 
 static int seccomp(unsigned int op, unsigned int flags, void *args)
 {
-	return syscall(__NR_seccomp, op, flags, args);
+	return (int)syscall(__NR_seccomp, op, flags, args);
 }
 
 static int user_notif_syscall(int nr, unsigned int flags)
diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index 9b333276cbdb..484ba825fcf4 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -120,7 +120,7 @@ static int run_single_threaded(void)
 	session = perf_session__new(NULL, NULL);
 	if (IS_ERR(session)) {
 		pr_err("Session creation failed.\n");
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 	}
 	threads = thread_map__new_by_pid(getpid());
 	if (!threads) {
@@ -163,7 +163,7 @@ static int do_run_multi_threaded(struct target *target,
 	for (i = 0; i < multi_iterations; i++) {
 		session = perf_session__new(NULL, NULL);
 		if (IS_ERR(session))
-			return PTR_ERR(session);
+			return (int)PTR_ERR(session);
 
 		atomic_set(&event_count, 0);
 		gettimeofday(&start, NULL);
@@ -210,7 +210,7 @@ static int run_multi_threaded(void)
 	int err;
 
 	if (max_threads == UINT_MAX)
-		max_threads = sysconf(_SC_NPROCESSORS_ONLN);
+		max_threads = (int)sysconf(_SC_NPROCESSORS_ONLN);
 
 	puts(
 "Computing performance of multi threaded perf event synthesis by\n"
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 2c1a9f3d847a..2f6a34908273 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -212,7 +212,7 @@ static int bench_str2int(const char *str)
 static int run_bench(const char *coll_name, const char *bench_name, bench_fn_t fn,
 		     int argc, const char **argv)
 {
-	int size;
+	size_t size;
 	char *name;
 	int ret;
 
-- 
2.49.0.906.g1f30a19c02-goog

