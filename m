Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FB221D594
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531904; cv=none; b=gslP/kM+ifoDckV2pS2xgz0oaS4rz9LSiQ2473qRtOFHl3QHBXHw9T3SiWqde4Z/4yiqOx8pI99DtiAqfX3PhtgH3H7HzNt1H87LOtS3Lw27vRg3egnQeUdXJlC6nYMl3o9WVq8r+Nti3teUbBrmxL30PAxloJWsfvwuB898hho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531904; c=relaxed/simple;
	bh=e3BkgPAkqE+Kp/vXNmX/XI4nBMU0yuH5Qm5nv6a9TaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=usNi2JgIqb2yG+dnWIQqN9HO1XQImMZm+kvtKMpR/04rXQwcH70k6OYtOiCb/+ep2XHUKWw0QUhuPaZtR5udnKnAMdGdL2HNREPJC/q7mlZAne0pKvoilPhbPaXZwNay5u9pp1y0S2hFp7ZJSAj03iPEMTyZp+xGFlm8sMq39n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QDfidZrB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QDfidZrB"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff82dd6de0so8326382a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531901; x=1744136701; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+vBHbW/FwL1p41VAXGiycxaCCSO3f+EE4EkyfyOYnA=;
        b=QDfidZrBWXv1VOEG4x0IbipxLench/VLxBX6ppTNzpMhsu22cZVpgN4ozzQ3TUjm12
         649iRDIQuokEK5KHAb1NUb1JZalUj5mnj7zMGv0g2ZiAopdc3yS7lPv4+jPKZGzzdR8V
         uRDU4WWvaE3X/XzwpF0oc+9ivrv40cFi2pxX1JIp17216+nNmqxvtsBhwd950hgUbaSQ
         65rAnyKhHzPJl+eWFhuO5pofcxT2LXblDQOr/DvSC9gIvW7GXzX8QvAjd8mu5QxGnpCg
         uC4M065RZCrm/+WjebSnMfexmf5FwF4U3azQf/kNaMTfJLVRJ0+7H6XE3NMjjXyKZbQ6
         SLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531901; x=1744136701;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+vBHbW/FwL1p41VAXGiycxaCCSO3f+EE4EkyfyOYnA=;
        b=pRCiuKYUzO32NEIZQumiWCpSUBBYG2kgjnI8QTD9EJIsEbN7EdvhxG1lDi46fRlHeh
         Noca3cf+OVMjRHgqXag4sgfrFa5WTKppnDRMAONo/DfWcyJoIEJEn/XYVHMILetfE+AX
         LfVzncfGHE9paOiJMNwIh8kiX3SZqx2P1LvvzwhP2e7VqMPppYYl52ZyB6ICCFt9OFiN
         tIMwQQsJElTwdsqJ8DlA2PR62JPrTJE8huGTNoGogPxZ390KYG9MsaNqsPsi2t0IOhEn
         5QqQ9zHe+JHbMw1IeMZGsOhmwX2e7aSJeyZWh1K8Z3HT6sU3k1+hsr9IeFn0SVV5Dbjs
         6wKA==
X-Forwarded-Encrypted: i=1; AJvYcCVEoVxvDJE8k/ttE7Y59x1l+ESgTvewRSmGHu7s05kfvEuuJEJgkcr56J3cNhldhzr6xYTS8cEG+1utDSU9nLtr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07YLYhJx0nykaJjRVSdK7v4vbAltQgXZ61fbhHu3ULjcNwRSN
	5FpUuhNl51G1oxCupYyWKIMRBQct5WTpQIeis43EAmL+IJgWldwCZOhGaj0e47c0MCMCrrBh5C0
	xX6s20A==
X-Google-Smtp-Source: AGHT+IHBDO0PeVL+eplLtAI/D2saD6Cu4dY5ZVAjzRa4AOgzGhUqSaGB3wMEsiw5znX3wm1s5DqofXPBmxDq
X-Received: from pjbdb4.prod.google.com ([2002:a17:90a:d644:b0:2ef:8055:93d9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e85:b0:2ee:f80c:6889
 with SMTP id 98e67ed59e1d1-3053215d1b9mr21863883a91.33.1743531901110; Tue, 01
 Apr 2025 11:25:01 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:10 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-13-irogers@google.com>
Subject: [PATCH v1 12/48] perf trace: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/builtin-trace.c                    | 98 ++++++++++---------
 tools/perf/trace/beauty/arch_prctl.c          |  2 +-
 tools/perf/trace/beauty/eventfd.c             |  2 +-
 tools/perf/trace/beauty/fcntl.c               |  5 +-
 tools/perf/trace/beauty/flock.c               |  2 +-
 tools/perf/trace/beauty/fs_at_flags.c         |  4 +-
 tools/perf/trace/beauty/futex_op.c            |  2 +-
 tools/perf/trace/beauty/futex_val3.c          |  2 +-
 tools/perf/trace/beauty/ioctl.c               |  2 +-
 tools/perf/trace/beauty/kcmp.c                |  8 +-
 tools/perf/trace/beauty/mmap.c                |  2 +-
 tools/perf/trace/beauty/mode_t.c              |  2 +-
 tools/perf/trace/beauty/msg_flags.c           |  2 +-
 tools/perf/trace/beauty/open_flags.c          |  2 +-
 tools/perf/trace/beauty/perf_event_open.c     |  4 +-
 tools/perf/trace/beauty/pid.c                 |  2 +-
 tools/perf/trace/beauty/pkey_alloc.c          |  2 +-
 tools/perf/trace/beauty/prctl.c               | 10 +-
 tools/perf/trace/beauty/sched_policy.c        |  2 +-
 tools/perf/trace/beauty/seccomp.c             |  4 +-
 tools/perf/trace/beauty/signum.c              |  2 +-
 tools/perf/trace/beauty/socket.c              |  6 +-
 tools/perf/trace/beauty/socket_type.c         |  2 +-
 tools/perf/trace/beauty/statx.c               |  2 +-
 .../beauty/tracepoints/x86_irq_vectors.c      |  3 +-
 tools/perf/trace/beauty/tracepoints/x86_msr.c |  3 +-
 tools/perf/trace/beauty/waitid_options.c      |  2 +-
 27 files changed, 94 insertions(+), 85 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6ac51925ea42..b0ec3b9d0e9b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -553,7 +553,7 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
 
 size_t strarray__scnprintf_suffix(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_suffix, int val)
 {
-	int idx = val - sa->offset;
+	int idx = (int)(val - sa->offset);
 
 	if (idx < 0 || idx >= sa->nr_entries || sa->entries[idx] == NULL) {
 		size_t printed = scnprintf(bf, size, intfmt, val);
@@ -567,7 +567,7 @@ size_t strarray__scnprintf_suffix(struct strarray *sa, char *bf, size_t size, co
 
 size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_prefix, int val)
 {
-	int idx = val - sa->offset;
+	int idx = (int)(val - sa->offset);
 
 	if (idx < 0 || idx >= sa->nr_entries || sa->entries[idx] == NULL) {
 		size_t printed = scnprintf(bf, size, intfmt, val);
@@ -583,7 +583,8 @@ static size_t __syscall_arg__scnprintf_strarray(char *bf, size_t size,
 						const char *intfmt,
 					        struct syscall_arg *arg)
 {
-	return strarray__scnprintf(arg->parm, bf, size, intfmt, arg->show_string_prefix, arg->val);
+	return strarray__scnprintf(arg->parm, bf, size, intfmt, arg->show_string_prefix,
+				   (int)arg->val);
 }
 
 static size_t syscall_arg__scnprintf_strarray(char *bf, size_t size,
@@ -621,7 +622,7 @@ size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const
 
 	for (i = 0; i < sas->nr_entries; ++i) {
 		struct strarray *sa = sas->entries[i];
-		int idx = val - sa->offset;
+		int idx = (int)(val - sa->offset);
 
 		if (idx >= 0 && idx < sa->nr_entries) {
 			if (sa->entries[idx] == NULL)
@@ -658,7 +659,7 @@ bool strarray__strtoul_flags(struct strarray *sa, char *bf, size_t size, u64 *re
 	*ret = 0;
 
 	while (size != 0) {
-		int toklen = size;
+		size_t toklen = size;
 
 		sep = memchr(tok, '|', size);
 		if (sep != NULL) {
@@ -707,7 +708,8 @@ bool strarrays__strtoul(struct strarrays *sas, char *bf, size_t size, u64 *ret)
 size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
 					struct syscall_arg *arg)
 {
-	return strarrays__scnprintf(arg->parm, bf, size, "%d", arg->show_string_prefix, arg->val);
+	return strarrays__scnprintf(arg->parm, bf, size, "%d", arg->show_string_prefix,
+				    (int)arg->val);
 }
 
 #ifndef AT_FDCWD
@@ -717,7 +719,7 @@ size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
 static size_t syscall_arg__scnprintf_fd_at(char *bf, size_t size,
 					   struct syscall_arg *arg)
 {
-	int fd = arg->val;
+	int fd = (int)arg->val;
 	const char *prefix = "AT_FD";
 
 	if (fd == AT_FDCWD)
@@ -859,7 +861,7 @@ static size_t syscall_arg__scnprintf_access_mode(char *bf, size_t size,
 	bool show_prefix = arg->show_string_prefix;
 	const char *suffix = "_OK";
 	size_t printed = 0;
-	int mode = arg->val;
+	int mode = (int)arg->val;
 
 	if (mode == F_OK) /* 0 */
 		return scnprintf(bf, size, "F%s", show_prefix ? suffix : "");
@@ -901,7 +903,7 @@ static size_t syscall_arg__scnprintf_pipe_flags(char *bf, size_t size,
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "O_";
-	int printed = 0, flags = arg->val;
+	int printed = 0, flags = (int)arg->val;
 
 #define	P_FLAG(n) \
 	if (flags & O_##n) { \
@@ -933,7 +935,7 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "GRND_";
-	int printed = 0, flags = arg->val;
+	int printed = 0, flags = (int)arg->val;
 
 #define	P_FLAG(n) \
 	if (flags & GRND_##n) { \
@@ -979,7 +981,7 @@ static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_
 
 	for (int i = 0; i < btf_vlen(bt); ++i, ++be) {
 		const char *name = btf__name_by_offset(btf, be->name_off);
-		int max_len = max(size, strlen(name));
+		size_t max_len = max(size, strlen(name));
 
 		if (strncmp(name, bf, max_len) == 0) {
 			*val = be->val;
@@ -1717,7 +1719,7 @@ static int thread__read_fd_path(struct thread *thread, int fd)
 {
 	char linkname[PATH_MAX], pathname[PATH_MAX];
 	struct stat st;
-	int ret;
+	ssize_t ret;
 
 	if (thread__pid(thread) == thread__tid(thread)) {
 		scnprintf(linkname, sizeof(linkname),
@@ -1764,7 +1766,7 @@ static const char *thread__fd_path(struct thread *thread, int fd,
 
 size_t syscall_arg__scnprintf_fd(char *bf, size_t size, struct syscall_arg *arg)
 {
-	int fd = arg->val;
+	int fd = (int)arg->val;
 	size_t printed = scnprintf(bf, size, "%d", fd);
 	const char *path = thread__fd_path(arg->thread, fd, arg->trace);
 
@@ -1794,7 +1796,7 @@ size_t pid__scnprintf_fd(struct trace *trace, pid_t pid, int fd, char *bf, size_
 static size_t syscall_arg__scnprintf_close_fd(char *bf, size_t size,
 					      struct syscall_arg *arg)
 {
-	int fd = arg->val;
+	int fd = (int)arg->val;
 	size_t printed = syscall_arg__scnprintf_fd(bf, size, arg);
 	struct thread_trace *ttrace = thread__priv(arg->thread);
 
@@ -2067,11 +2069,11 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			    bool *use_btf)
 {
 	struct tep_format_field *last_field = NULL;
-	int len;
 
 	for (; field; field = field->next, ++arg) {
-		last_field = field;
+		size_t len;
 
+		last_field = field;
 		if (arg->scnprintf)
 			continue;
 
@@ -2171,7 +2173,7 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 	 */
 	if (IS_ERR(sc->tp_format)) {
 		sc->nonexistent = true;
-		err = PTR_ERR(sc->tp_format);
+		err = (int)PTR_ERR(sc->tp_format);
 		sc->tp_format = NULL;
 		return err;
 	}
@@ -2440,7 +2442,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 
 			if (trace->force_btf || default_scnprintf == NULL || default_scnprintf == SCA_PTR) {
 				btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
-								   size - printed, val, field->type);
+								   size - printed, (int)val,
+								   field->type);
 				if (btf_printed) {
 					printed += btf_printed;
 					continue;
@@ -2654,7 +2657,7 @@ static void thread__update_stats(struct thread *thread, struct thread_trace *ttr
 			}
 
 			stats->errnos = new_errnos;
-			stats->max_errno = err;
+			stats->max_errno = (int)err;
 		}
 
 		++stats->errnos[err - 1];
@@ -2686,7 +2689,7 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 	ttrace->entry_pending = false;
 	++trace->nr_events_printed;
 
-	return printed;
+	return (int)printed;
 }
 
 static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
@@ -2753,8 +2756,8 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	void *args;
 	int printed = 0;
 	struct thread *thread;
-	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
-	int augmented_args_size = 0, e_machine;
+	int id = (int)perf_evsel__sc_tp_uint(evsel, id, sample);
+	int err = -1, augmented_args_size = 0, e_machine;
 	void *augmented_args = NULL;
 	struct syscall *sc;
 	struct thread_trace *ttrace;
@@ -2830,11 +2833,11 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 {
 	struct thread_trace *ttrace;
 	struct thread *thread;
-	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
+	int id = (int)perf_evsel__sc_tp_uint(evsel, id, sample);
 	struct syscall *sc;
 	char msg[1024];
 	void *args, *augmented_args = NULL;
-	int augmented_args_size, e_machine;
+	int err = -1, augmented_args_size, e_machine;
 	size_t printed = 0;
 
 
@@ -2906,7 +2909,8 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	u64 duration = 0;
 	bool duration_calculated = false;
 	struct thread *thread;
-	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0, printed = 0;
+	int id = (int)perf_evsel__sc_tp_uint(evsel, id, sample);
+	int err = -1, callchain_ret = 0, printed = 0;
 	int alignment = trace->args_alignment, e_machine;
 	struct syscall *sc;
 	struct thread_trace *ttrace;
@@ -2928,7 +2932,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 		thread__update_stats(thread, ttrace, id, sample, ret, trace);
 
 	if (!trace->fd_path_disabled && sc->is_open && ret >= 0 && ttrace->filename.pending_open) {
-		trace__set_fd_pathname(thread, ret, ttrace->filename.name);
+		trace__set_fd_pathname(thread, (int)ret, ttrace->filename.name);
 		ttrace->filename.pending_open = false;
 		++trace->stats.vfs_getname;
 	}
@@ -2983,8 +2987,8 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	} else if (ret < 0) {
 errno_print: {
 		char bf[STRERR_BUFSIZE];
-		const char *emsg = str_error_r(-ret, bf, sizeof(bf)),
-			   *e = errno_to_name(evsel, -ret);
+		const char *emsg = str_error_r((int)-ret, bf, sizeof(bf));
+		const char *e = errno_to_name(evsel, (int)-ret);
 
 		fprintf(trace->output, "-1 %s (%s)", e, emsg);
 	}
@@ -3003,7 +3007,7 @@ errno_print: {
 	} else if (sc->fmt->hexret)
 		fprintf(trace->output, "%#lx", ret);
 	else if (sc->fmt->errpid) {
-		struct thread *child = machine__find_thread(trace->host, ret, ret);
+		struct thread *child = machine__find_thread(trace->host, (int)ret, (int)ret);
 
 		if (child != NULL) {
 			fprintf(trace->output, "%ld", ret);
@@ -3063,7 +3067,7 @@ static int trace__vfs_getname(struct trace *trace, struct evsel *evsel,
 		if (f == NULL)
 			goto out_put;
 
-		ttrace->filename.namelen = filename_len;
+		ttrace->filename.namelen = (unsigned int)filename_len;
 		ttrace->filename.name = f;
 	}
 
@@ -3191,7 +3195,8 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 			int offset = field->offset;
 
 			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
-				offset = format_field__intval(field, sample, evsel->needs_swap);
+				offset = (int)format_field__intval(field, sample,
+								   evsel->needs_swap);
 				syscall_arg.len = offset >> 16;
 				offset &= 0xffff;
 				if (tep_field_is_relative(field->flags))
@@ -3216,7 +3221,8 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		if (trace->show_arg_names)
 			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-		btf_printed = trace__btf_scnprintf(trace, &syscall_arg, bf + printed, size - printed, val, field->type);
+		btf_printed = trace__btf_scnprintf(trace, &syscall_arg, bf + printed,
+						   size - printed, (int)val, field->type);
 		if (btf_printed) {
 			printed += btf_printed;
 			continue;
@@ -3261,7 +3267,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 		trace__fprintf_comm_tid(trace, thread, trace->output);
 
 	if (evsel == trace->syscalls.events.bpf_output) {
-		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
+		int id = (int)perf_evsel__sc_tp_uint(evsel, id, sample);
 		int e_machine = thread ? thread__e_machine(thread, trace->host) : EM_HOST;
 		struct syscall *sc = trace__syscall_info(trace, evsel, e_machine, id);
 
@@ -4278,8 +4284,8 @@ static int trace__expand_filter(struct trace *trace, struct evsel *evsel)
 
 		if (isalpha(*right)) {
 			struct syscall_arg_fmt *fmt;
-			int left_size = tok - left,
-			    right_size = right_end - right;
+			int left_size = (int)(tok - left);
+			int right_size = (int)(right_end - right);
 			char arg[128], *type;
 
 			while (isspace(left[left_size - 1]))
@@ -4309,7 +4315,7 @@ static int trace__expand_filter(struct trace *trace, struct evsel *evsel)
 				if (fmt->strtoul(right, right_size, &syscall_arg, &val)) {
 					char *n, expansion[19];
 					int expansion_lenght = scnprintf(expansion, sizeof(expansion), "%#" PRIx64, val);
-					int expansion_offset = right - new_filter;
+					int expansion_offset = (int)(right - new_filter);
 
 					pr_debug("%s", expansion);
 
@@ -4718,7 +4724,7 @@ static int trace__replay(struct trace *trace)
 
 	session = perf_session__new(&data, &trace->tool);
 	if (IS_ERR(session))
-		return PTR_ERR(session);
+		return (int)PTR_ERR(session);
 
 	if (trace->opts.target.pid)
 		symbol_conf.pid_list_str = strdup(trace->opts.target.pid);
@@ -4816,7 +4822,7 @@ static struct syscall_entry *syscall__sort_stats(struct hashmap *syscall_stats)
 {
 	struct syscall_entry *entry;
 	struct hashmap_entry *pos;
-	unsigned bkt, i, nr;
+	size_t bkt, i, nr;
 
 	nr = syscall_stats->sz;
 	entry = malloc(nr * sizeof(*entry));
@@ -4830,7 +4836,7 @@ static struct syscall_entry *syscall__sort_stats(struct hashmap *syscall_stats)
 
 		entry[i].stats = ss;
 		entry[i].msecs = (u64)st->n * (avg_stats(st) / NSEC_PER_MSEC);
-		entry[i].syscall = pos->key;
+		entry[i].syscall = (int)pos->key;
 		i++;
 	}
 	assert(i == nr);
@@ -5011,7 +5017,6 @@ static int trace__set_filter_pids_from_option(const struct option *opt, const ch
 					      int unset __maybe_unused)
 {
 	int ret = -1;
-	size_t i;
 	struct trace *trace = opt->value;
 	/*
 	 * FIXME: introduce a intarray class, plain parse csv and create a
@@ -5022,16 +5027,16 @@ static int trace__set_filter_pids_from_option(const struct option *opt, const ch
 	if (list == NULL)
 		return -1;
 
-	i = trace->filter_pids.nr = intlist__nr_entries(list) + 1;
-	trace->filter_pids.entries = calloc(i, sizeof(pid_t));
+	trace->filter_pids.nr = intlist__nr_entries(list) + 1;
+	trace->filter_pids.entries = calloc(trace->filter_pids.nr, sizeof(pid_t));
 
 	if (trace->filter_pids.entries == NULL)
 		goto out;
 
 	trace->filter_pids.entries[0] = getpid();
 
-	for (i = 1; i < trace->filter_pids.nr; ++i)
-		trace->filter_pids.entries[i] = intlist__entry(list, i - 1)->i;
+	for (unsigned int i = 1; i < trace->filter_pids.nr; ++i)
+		trace->filter_pids.entries[i] = (pid_t)intlist__entry(list, i - 1)->i;
 
 	intlist__delete(list);
 	ret = 0;
@@ -5167,7 +5172,8 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 	struct trace *trace = (struct trace *)opt->value;
 	const char *s = str;
 	char *sep = NULL, *lists[2] = { NULL, NULL, };
-	int len = strlen(str) + 1, err = -1, list, idx;
+	size_t len = strlen(str) + 1;
+	int err = -1, list, idx;
 	char *strace_groups_dir = system_path(STRACE_GROUPS_DIR);
 	char group_name[PATH_MAX];
 	const struct syscall_fmt *fmt;
@@ -5623,7 +5629,7 @@ int cmd_trace(int argc, const char **argv)
 
 	if (callchain_param.enabled) {
 		if (!mmap_pages_user_set && geteuid() == 0)
-			trace.opts.mmap_pages = perf_event_mlock_kb_in_pages() * 4;
+			trace.opts.mmap_pages = (unsigned int)perf_event_mlock_kb_in_pages() * 4;
 
 		symbol_conf.use_callchain = true;
 	}
diff --git a/tools/perf/trace/beauty/arch_prctl.c b/tools/perf/trace/beauty/arch_prctl.c
index a211348d3204..c8193e04831d 100644
--- a/tools/perf/trace/beauty/arch_prctl.c
+++ b/tools/perf/trace/beauty/arch_prctl.c
@@ -29,7 +29,7 @@ static size_t x86_arch_prctl__scnprintf_code(int option, char *bf, size_t size,
 
 size_t syscall_arg__scnprintf_x86_arch_prctl_code(char *bf, size_t size, struct syscall_arg *arg)
 {
-	unsigned long code = arg->val;
+	int code = (int)arg->val;
 
 	return x86_arch_prctl__scnprintf_code(code, bf, size, arg->show_string_prefix);
 }
diff --git a/tools/perf/trace/beauty/eventfd.c b/tools/perf/trace/beauty/eventfd.c
index 4bab106213c6..38d9e6585375 100644
--- a/tools/perf/trace/beauty/eventfd.c
+++ b/tools/perf/trace/beauty/eventfd.c
@@ -15,7 +15,7 @@ static size_t syscall_arg__scnprintf_eventfd_flags(char *bf, size_t size, struct
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "EFD_";
-	int printed = 0, flags = arg->val;
+	int printed = 0, flags = (int)arg->val;
 
 	if (flags == 0)
 		return scnprintf(bf, size, "NONE");
diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index d075904dccce..6fbeeb1fcf82 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -25,7 +25,8 @@ static size_t fcntl__scnprintf_getlease(unsigned long val, char *bf, size_t size
 	static const char *fcntl_setlease[] = { "RDLCK", "WRLCK", "UNLCK", };
 	static DEFINE_STRARRAY(fcntl_setlease, "F_");
 
-	return strarray__scnprintf(&strarray__fcntl_setlease, bf, size, "%x", show_prefix, val);
+	return strarray__scnprintf(&strarray__fcntl_setlease, bf, size, "%x", show_prefix,
+				   (int)val);
 }
 
 static size_t syscall_arg__scnprintf_fcntl_getlease(char *bf, size_t size, struct syscall_arg *arg)
@@ -70,7 +71,7 @@ size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_ar
 size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
-	int cmd = syscall_arg__val(arg, 1);
+	size_t cmd = syscall_arg__val(arg, 1);
 
 	if (cmd == F_DUPFD)
 		return syscall_arg__scnprintf_fd(bf, size, arg);
diff --git a/tools/perf/trace/beauty/flock.c b/tools/perf/trace/beauty/flock.c
index a6514a6f07cf..ace7309ee1fc 100644
--- a/tools/perf/trace/beauty/flock.c
+++ b/tools/perf/trace/beauty/flock.c
@@ -24,7 +24,7 @@ size_t syscall_arg__scnprintf_flock(char *bf, size_t size, struct syscall_arg *a
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "LOCK_";
-	int printed = 0, op = arg->val;
+	int printed = 0, op = (int)arg->val;
 
 	if (op == 0)
 		return scnprintf(bf, size, "NONE");
diff --git a/tools/perf/trace/beauty/fs_at_flags.c b/tools/perf/trace/beauty/fs_at_flags.c
index c200669cb944..f9ab43300171 100644
--- a/tools/perf/trace/beauty/fs_at_flags.c
+++ b/tools/perf/trace/beauty/fs_at_flags.c
@@ -29,7 +29,7 @@ static size_t fs_at__scnprintf_flags(unsigned long flags, char *bf, size_t size,
 size_t syscall_arg__scnprintf_fs_at_flags(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
-	int flags = arg->val;
+	int flags = (int)arg->val;
 
 	return fs_at__scnprintf_flags(flags, bf, size, show_prefix);
 }
@@ -52,7 +52,7 @@ static size_t faccessat2__scnprintf_flags(unsigned long flags, char *bf, size_t
 size_t syscall_arg__scnprintf_faccessat2_flags(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
-	int flags = arg->val;
+	int flags = (int)arg->val;
 
 	return faccessat2__scnprintf_flags(flags, bf, size, show_prefix);
 }
diff --git a/tools/perf/trace/beauty/futex_op.c b/tools/perf/trace/beauty/futex_op.c
index 00365156782b..8c1741aab9be 100644
--- a/tools/perf/trace/beauty/futex_op.c
+++ b/tools/perf/trace/beauty/futex_op.c
@@ -29,7 +29,7 @@ static size_t syscall_arg__scnprintf_futex_op(char *bf, size_t size, struct sysc
 		SCF_UADDR2  = (1 << 4),
 		SCF_VAL3    = (1 << 5),
 	};
-	int op = arg->val;
+	int op = (int)arg->val;
 	int cmd = op & FUTEX_CMD_MASK;
 	size_t printed = 0;
 
diff --git a/tools/perf/trace/beauty/futex_val3.c b/tools/perf/trace/beauty/futex_val3.c
index 9114f7620571..6f02e8d5961d 100644
--- a/tools/perf/trace/beauty/futex_val3.c
+++ b/tools/perf/trace/beauty/futex_val3.c
@@ -8,7 +8,7 @@
 static size_t syscall_arg__scnprintf_futex_val3(char *bf, size_t size, struct syscall_arg *arg)
 {
 	const char *prefix = "FUTEX_BITSET_";
-	unsigned int bitset = arg->val;
+	unsigned int bitset = (unsigned int)arg->val;
 
 	if (bitset == FUTEX_BITSET_MATCH_ANY)
 		return scnprintf(bf, size, "%s%s", arg->show_string_prefix ? prefix : "", "MATCH_ANY");
diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index e19eb6ea361d..abb959be372d 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -175,7 +175,7 @@ static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size, boo
 size_t syscall_arg__scnprintf_ioctl_cmd(char *bf, size_t size, struct syscall_arg *arg)
 {
 	unsigned long cmd = arg->val;
-	int fd = syscall_arg__val(arg, 0);
+	int fd = (int)syscall_arg__val(arg, 0);
 	struct file *file = thread__files_entry(arg->thread, fd);
 
 	if (file != NULL) {
diff --git a/tools/perf/trace/beauty/kcmp.c b/tools/perf/trace/beauty/kcmp.c
index 9351f84390a1..bc81eaef4944 100644
--- a/tools/perf/trace/beauty/kcmp.c
+++ b/tools/perf/trace/beauty/kcmp.c
@@ -15,14 +15,14 @@
 
 size_t syscall_arg__scnprintf_kcmp_idx(char *bf, size_t size, struct syscall_arg *arg)
 {
-	unsigned long fd = arg->val;
-	int type = syscall_arg__val(arg, 2);
+	int fd = (int)arg->val;
+	int type = (int)syscall_arg__val(arg, 2);
 	pid_t pid;
 
 	if (type != KCMP_FILE)
 		return syscall_arg__scnprintf_long(bf, size, arg);
 
-	pid = syscall_arg__val(arg, arg->idx == 3 ? 0 : 1); /* idx1 -> pid1, idx2 -> pid2 */
+	pid = (pid_t)syscall_arg__val(arg, arg->idx == 3 ? 0 : 1); /* idx1 -> pid1, idx2 -> pid2 */
 	return pid__scnprintf_fd(arg->trace, pid, fd, bf, size);
 }
 
@@ -34,7 +34,7 @@ static size_t kcmp__scnprintf_type(int type, char *bf, size_t size, bool show_pr
 
 size_t syscall_arg__scnprintf_kcmp_type(char *bf, size_t size, struct syscall_arg *arg)
 {
-	unsigned long type = arg->val;
+	int type = (int)arg->val;
 
 	if (type != KCMP_FILE)
 		arg->mask |= (1 << 3) | (1 << 4); /* Ignore idx1 and idx2 */
diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index 3c5e97b93dd5..b3136b7b31ac 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -76,7 +76,7 @@ static size_t madvise__scnprintf_behavior(int behavior, char *bf, size_t size)
 static size_t syscall_arg__scnprintf_madvise_behavior(char *bf, size_t size,
 						      struct syscall_arg *arg)
 {
-	return madvise__scnprintf_behavior(arg->val, bf, size);
+	return madvise__scnprintf_behavior((int)arg->val, bf, size);
 }
 
 #define SCA_MADV_BHV syscall_arg__scnprintf_madvise_behavior
diff --git a/tools/perf/trace/beauty/mode_t.c b/tools/perf/trace/beauty/mode_t.c
index 29a8fadfb7f9..802f856c7bd1 100644
--- a/tools/perf/trace/beauty/mode_t.c
+++ b/tools/perf/trace/beauty/mode_t.c
@@ -24,7 +24,7 @@ static size_t syscall_arg__scnprintf_mode_t(char *bf, size_t size, struct syscal
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "S_";
-	int printed = 0, mode = arg->val;
+	int printed = 0, mode = (int)arg->val;
 
 #define	P_MODE(n) \
 	if ((mode & S_##n) == S_##n) { \
diff --git a/tools/perf/trace/beauty/msg_flags.c b/tools/perf/trace/beauty/msg_flags.c
index 2da581ff0c80..2fd0ddcd7f88 100644
--- a/tools/perf/trace/beauty/msg_flags.c
+++ b/tools/perf/trace/beauty/msg_flags.c
@@ -32,7 +32,7 @@ static size_t syscall_arg__scnprintf_msg_flags(char *bf, size_t size,
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "MSG_";
-	int printed = 0, flags = arg->val;
+	int printed = 0, flags = (int)arg->val;
 
 	if (flags == 0)
 		return scnprintf(bf, size, "NONE");
diff --git a/tools/perf/trace/beauty/open_flags.c b/tools/perf/trace/beauty/open_flags.c
index 78f6566ef110..17ceb0f1b36a 100644
--- a/tools/perf/trace/beauty/open_flags.c
+++ b/tools/perf/trace/beauty/open_flags.c
@@ -79,7 +79,7 @@ size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool sh
 
 size_t syscall_arg__scnprintf_open_flags(char *bf, size_t size, struct syscall_arg *arg)
 {
-	int flags = arg->val;
+	int flags = (int)arg->val;
 
 	if (!(flags & O_CREAT))
 		arg->mask |= 1 << (arg->idx + 1); /* Mask the mode parm */
diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace/beauty/perf_event_open.c
index 9f1ed989c775..d62c9d0261ad 100644
--- a/tools/perf/trace/beauty/perf_event_open.c
+++ b/tools/perf/trace/beauty/perf_event_open.c
@@ -20,7 +20,7 @@ static size_t syscall_arg__scnprintf_perf_flags(char *bf, size_t size,
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "PERF_";
-	int printed = 0, flags = arg->val;
+	int printed = 0, flags = (int)arg->val;
 
 	if (flags == 0)
 		return 0;
@@ -58,7 +58,7 @@ static int attr__fprintf(FILE *fp __maybe_unused, const char *name, const char *
 
 	args->first = false;
 	args->printed += printed;
-	return printed;
+	return (int)printed;
 }
 
 static size_t perf_event_attr___scnprintf(struct perf_event_attr *attr, char *bf, size_t size, bool show_zeros __maybe_unused)
diff --git a/tools/perf/trace/beauty/pid.c b/tools/perf/trace/beauty/pid.c
index 8f9c9950f8ba..609a582e0221 100644
--- a/tools/perf/trace/beauty/pid.c
+++ b/tools/perf/trace/beauty/pid.c
@@ -2,7 +2,7 @@
 
 size_t syscall_arg__scnprintf_pid(char *bf, size_t size, struct syscall_arg *arg)
 {
-	int pid = arg->val;
+	int pid = (int)arg->val;
 	struct trace *trace = arg->trace;
 	size_t printed = scnprintf(bf, size, "%d", pid);
 	struct thread *thread = machine__findnew_thread(trace->host, pid, pid);
diff --git a/tools/perf/trace/beauty/pkey_alloc.c b/tools/perf/trace/beauty/pkey_alloc.c
index f9596ed02cc4..c597a0f26a3d 100644
--- a/tools/perf/trace/beauty/pkey_alloc.c
+++ b/tools/perf/trace/beauty/pkey_alloc.c
@@ -48,7 +48,7 @@ static size_t pkey_alloc__scnprintf_access_rights(int access_rights, char *bf, s
 
 size_t syscall_arg__scnprintf_pkey_alloc_access_rights(char *bf, size_t size, struct syscall_arg *arg)
 {
-	unsigned long cmd = arg->val;
+	int cmd = (int)arg->val;
 
 	return pkey_alloc__scnprintf_access_rights(cmd, bf, size, arg->show_string_prefix);
 }
diff --git a/tools/perf/trace/beauty/prctl.c b/tools/perf/trace/beauty/prctl.c
index 7d1aa9fd03da..7768a72134a3 100644
--- a/tools/perf/trace/beauty/prctl.c
+++ b/tools/perf/trace/beauty/prctl.c
@@ -26,10 +26,10 @@ static size_t prctl__scnprintf_set_mm(int option, char *bf, size_t size, bool sh
 
 size_t syscall_arg__scnprintf_prctl_arg2(char *bf, size_t size, struct syscall_arg *arg)
 {
-	int option = syscall_arg__val(arg, 0);
+	int option = (int)syscall_arg__val(arg, 0);
 
 	if (option == PR_SET_MM)
-		return prctl__scnprintf_set_mm(arg->val, bf, size, arg->show_string_prefix);
+		return prctl__scnprintf_set_mm((int)arg->val, bf, size, arg->show_string_prefix);
 	/*
 	 * We still don't grab the contents of pointers on entry or exit,
 	 * so just print them as hex numbers
@@ -42,7 +42,7 @@ size_t syscall_arg__scnprintf_prctl_arg2(char *bf, size_t size, struct syscall_a
 
 size_t syscall_arg__scnprintf_prctl_arg3(char *bf, size_t size, struct syscall_arg *arg)
 {
-	int option = syscall_arg__val(arg, 0);
+	int option = (int)syscall_arg__val(arg, 0);
 
 	if (option == PR_SET_MM)
 		return syscall_arg__scnprintf_hex(bf, size, arg);
@@ -52,7 +52,7 @@ size_t syscall_arg__scnprintf_prctl_arg3(char *bf, size_t size, struct syscall_a
 
 size_t syscall_arg__scnprintf_prctl_option(char *bf, size_t size, struct syscall_arg *arg)
 {
-	unsigned long option = arg->val;
+	int option = (int)arg->val;
 	enum {
                 SPO_ARG2 = (1 << 1),
                 SPO_ARG3 = (1 << 2),
@@ -75,7 +75,7 @@ size_t syscall_arg__scnprintf_prctl_option(char *bf, size_t size, struct syscall
 		[PR_SET_PDEATHSIG]	 = all_but2,
 	};
 
-	if (option < ARRAY_SIZE(masks))
+	if (option < (int)ARRAY_SIZE(masks))
 		arg->mask |= masks[option];
 
 	return prctl__scnprintf_option(option, bf, size, arg->show_string_prefix);
diff --git a/tools/perf/trace/beauty/sched_policy.c b/tools/perf/trace/beauty/sched_policy.c
index 68aa59eeed8d..69dad444fa41 100644
--- a/tools/perf/trace/beauty/sched_policy.c
+++ b/tools/perf/trace/beauty/sched_policy.c
@@ -23,7 +23,7 @@ static size_t syscall_arg__scnprintf_sched_policy(char *bf, size_t size,
 		"NORMAL", "FIFO", "RR", "BATCH", "ISO", "IDLE", "DEADLINE",
 	};
 	size_t printed;
-	int policy = arg->val,
+	int policy = (int)arg->val,
 	    flags = policy & ~SCHED_POLICY_MASK;
 
 	policy &= SCHED_POLICY_MASK;
diff --git a/tools/perf/trace/beauty/seccomp.c b/tools/perf/trace/beauty/seccomp.c
index 637722e2796b..42c213a9eb88 100644
--- a/tools/perf/trace/beauty/seccomp.c
+++ b/tools/perf/trace/beauty/seccomp.c
@@ -10,7 +10,7 @@ static size_t syscall_arg__scnprintf_seccomp_op(char *bf, size_t size, struct sy
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "SECCOMP_SET_MODE_";
-	int op = arg->val;
+	int op = (int)arg->val;
 	size_t printed = 0;
 
 	switch (op) {
@@ -35,7 +35,7 @@ static size_t syscall_arg__scnprintf_seccomp_flags(char *bf, size_t size,
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "SECCOMP_FILTER_FLAG_";
-	int printed = 0, flags = arg->val;
+	int printed = 0, flags = (int)arg->val;
 
 #define	P_FLAG(n) \
 	if (flags & SECCOMP_FILTER_FLAG_##n) { \
diff --git a/tools/perf/trace/beauty/signum.c b/tools/perf/trace/beauty/signum.c
index 21220c56500a..a78bceeaa23e 100644
--- a/tools/perf/trace/beauty/signum.c
+++ b/tools/perf/trace/beauty/signum.c
@@ -5,7 +5,7 @@ static size_t syscall_arg__scnprintf_signum(char *bf, size_t size, struct syscal
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "SIG";
-	int sig = arg->val;
+	int sig = (int)arg->val;
 
 	switch (sig) {
 #define	P_SIGNUM(n) case SIG##n: return scnprintf(bf, size, "%s%s", show_prefix ? prefix : "", #n)
diff --git a/tools/perf/trace/beauty/socket.c b/tools/perf/trace/beauty/socket.c
index b0870c7b48e5..07a0bfa164d1 100644
--- a/tools/perf/trace/beauty/socket.c
+++ b/tools/perf/trace/beauty/socket.c
@@ -20,10 +20,10 @@ static size_t socket__scnprintf_ipproto(int protocol, char *bf, size_t size, boo
 
 size_t syscall_arg__scnprintf_socket_protocol(char *bf, size_t size, struct syscall_arg *arg)
 {
-	int domain = syscall_arg__val(arg, 0);
+	int domain = (int)syscall_arg__val(arg, 0);
 
 	if (domain == AF_INET || domain == AF_INET6)
-		return socket__scnprintf_ipproto(arg->val, bf, size, arg->show_string_prefix);
+		return socket__scnprintf_ipproto((int)arg->val, bf, size, arg->show_string_prefix);
 
 	return syscall_arg__scnprintf_int(bf, size, arg);
 }
@@ -43,5 +43,5 @@ static size_t socket__scnprintf_level(int level, char *bf, size_t size, bool sho
 
 size_t syscall_arg__scnprintf_socket_level(char *bf, size_t size, struct syscall_arg *arg)
 {
-	return socket__scnprintf_level(arg->val, bf, size, arg->show_string_prefix);
+	return socket__scnprintf_level((int)arg->val, bf, size, arg->show_string_prefix);
 }
diff --git a/tools/perf/trace/beauty/socket_type.c b/tools/perf/trace/beauty/socket_type.c
index bed8d5761ca8..2c7e3801ba34 100644
--- a/tools/perf/trace/beauty/socket_type.c
+++ b/tools/perf/trace/beauty/socket_type.c
@@ -23,7 +23,7 @@ static size_t syscall_arg__scnprintf_socket_type(char *bf, size_t size, struct s
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "SOCK_";
 	size_t printed;
-	int type = arg->val,
+	int type = (int)arg->val,
 	    flags = type & ~SOCK_TYPE_MASK;
 
 	type &= SOCK_TYPE_MASK;
diff --git a/tools/perf/trace/beauty/statx.c b/tools/perf/trace/beauty/statx.c
index 24843e614b93..de47bc0c03e5 100644
--- a/tools/perf/trace/beauty/statx.c
+++ b/tools/perf/trace/beauty/statx.c
@@ -19,7 +19,7 @@ static size_t statx__scnprintf_mask(unsigned long mask, char *bf, size_t size, b
 size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
-	int mask = arg->val;
+	int mask = (int)arg->val;
 
 	return statx__scnprintf_mask(mask, bf, size, show_prefix);
 }
diff --git a/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.c b/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.c
index 8eb9bc8534ac..6430d1084dc1 100644
--- a/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.c
+++ b/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.c
@@ -13,7 +13,8 @@ static DEFINE_STRARRAY(x86_irq_vectors, "_VECTOR");
 
 static size_t x86_irq_vectors__scnprintf(unsigned long vector, char *bf, size_t size, bool show_prefix)
 {
-	return strarray__scnprintf_suffix(&strarray__x86_irq_vectors, bf, size, "%#x", show_prefix, vector);
+	return strarray__scnprintf_suffix(&strarray__x86_irq_vectors, bf, size, "%#x", show_prefix,
+					  (int)vector);
 }
 
 size_t syscall_arg__scnprintf_x86_irq_vectors(char *bf, size_t size, struct syscall_arg *arg)
diff --git a/tools/perf/trace/beauty/tracepoints/x86_msr.c b/tools/perf/trace/beauty/tracepoints/x86_msr.c
index 6b8f129579d6..2be91be1af05 100644
--- a/tools/perf/trace/beauty/tracepoints/x86_msr.c
+++ b/tools/perf/trace/beauty/tracepoints/x86_msr.c
@@ -23,7 +23,8 @@ static DEFINE_STRARRAYS(x86_MSRs_tables);
 
 static size_t x86_MSR__scnprintf(unsigned long msr, char *bf, size_t size, bool show_prefix)
 {
-	return strarrays__scnprintf(&strarrays__x86_MSRs_tables, bf, size, "%#x", show_prefix, msr);
+	return strarrays__scnprintf(&strarrays__x86_MSRs_tables, bf, size, "%#x", show_prefix,
+				    (int)msr);
 }
 
 size_t syscall_arg__scnprintf_x86_MSR(char *bf, size_t size, struct syscall_arg *arg)
diff --git a/tools/perf/trace/beauty/waitid_options.c b/tools/perf/trace/beauty/waitid_options.c
index d4d10b33ba0e..2a920a0f41d0 100644
--- a/tools/perf/trace/beauty/waitid_options.c
+++ b/tools/perf/trace/beauty/waitid_options.c
@@ -7,7 +7,7 @@ static size_t syscall_arg__scnprintf_waitid_options(char *bf, size_t size,
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "W";
-	int printed = 0, options = arg->val;
+	int printed = 0, options = (int)arg->val;
 
 #define	P_OPTION(n) \
 	if (options & W##n) { \
-- 
2.49.0.504.g3bcea36a83-goog

