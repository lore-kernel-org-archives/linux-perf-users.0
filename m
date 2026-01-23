Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97E52D193F
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769206951; cv=none; b=C/Eh/lIU6wNglbJtJbYqHquEc3mBwz6jSpbNRoKwqhRCbnzYXSHcfZhay7r67ehrXVXYhgCTmOpoa6oc4W2iY+WjdlUnh9GmhIwRJZstg+2OamLBmIu6XXbHiDjbgPO0k5AUUB6rTx38TrodomExRmaLpSy0lucIBxDS1YcDm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769206951; c=relaxed/simple;
	bh=wWcDCBThkRzjxvkI58nrHd4ls94KVV87sGI/wAQ5CMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=V37w0iM4sJfpO4JlrDadbMB86dbFpxNJKOXabp3EJiVucrnoPxxHaYuKjaf6M000/Il8NOC8harfzGAnxoEWTMUTiW9IjWVEUh04x9xrbh4uEqtZrdg0aLQCxB275GtQSAGgu/iUCleW+mK+/5FTVrd68WCjO0QGeCgP8NzbxII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iakSTq1q; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iakSTq1q"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12339e20a86so3242685c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 14:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769206949; x=1769811749; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cf7Y7FADq4PznKGJpGCjRHvBcF+nvW6t+j6b4wRmujU=;
        b=iakSTq1q0lVt8qbWV/1MbSXbUqZg2/4mfcEY44knmuhNyVYttgpMbbkuBXxV0B1GZH
         jIaKOqmz/5ZKM7RqLPprE1SoVzWN5oDmhPMMsTFw/rw7jp5NgqnHbUXCBsZblndg/5ju
         rVFHUAuzEwD9zVF8KncPAEv7jtqReXvAZcwtyvf+B3PoYo0hxYQlyLav7tl1dhupD30/
         m7Jk5PdLKcg+BqYuv3oqFj9o1yJPJd7bHwEKpoBu4haF8B1ZJtL1Og+hUI98JS1SrsIo
         JMpRLscgTcn+00j3Mf0O66DrrVC5H5Q45ZmoswibkkhKDRB8I0nyfki16Eu18HkJ+RaO
         LZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769206949; x=1769811749;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cf7Y7FADq4PznKGJpGCjRHvBcF+nvW6t+j6b4wRmujU=;
        b=dTF5vrOAk0D/Qf+owFFfINQCcRFlJYxtJEbG6bFceJ6UyPvcGDKuPnNj3x4uXuwKMx
         tgdRu8ETGJ5UB2lb5yKBC/FBIj8Gy9MBF+QSTsdgnXZN9+hDEeJyYb47Th5w3u5rbslF
         +l0uaO1tNIPbnC9RcRc2iLso8LTOeZ46qg4ZK60kAqwsh4NDAkCwKMtPYd6V03aOOrH4
         yEZRzic45EjVgNL+30DkOx2BSRkGqHFkBlpN1VQf6z/09mGI428/Kq0UlDiUgxkB2U7k
         s7pESBiU896enwpiKMZc3CN41jSLGHfruyx6S/yzFEu8IbofBK0LAMJOC85JDWIeA6xc
         FkfA==
X-Forwarded-Encrypted: i=1; AJvYcCVINQ+7Ot4oS0kx77NUxHaf61iUdc471E8st/H6LIxD/9pitRDGxOMMewl2RgArjoBGC45IthYXbubjsKkforX3@vger.kernel.org
X-Gm-Message-State: AOJu0YyGmI88cTM7wn0UsPaNjoqGTkW6wOpUN96IIznSrFj7jbBOAuCq
	TD6p5lMTAbFcLBu2/TKms4Kz6PbbZcPLvwnjYNh/jIhSc2Dj33euqIkhAA0p8OtSbbM7aXRWB9R
	/qJAhpuT41A==
X-Received: from dlbto2.prod.google.com ([2002:a05:7022:3b02:b0:121:a019:8a44])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:438a:b0:11b:9386:8271
 with SMTP id a92af1059eb24-1247dc14cbbmr2482480c88.46.1769206948958; Fri, 23
 Jan 2026 14:22:28 -0800 (PST)
Date: Fri, 23 Jan 2026 14:22:07 -0800
In-Reply-To: <20260123222209.1181249-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260123222209.1181249-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260123222209.1181249-3-irogers@google.com>
Subject: [PATCH v1 2/4] perf thread: Add optional e_flags output argument to thread__e_machine
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Guo Ren <guoren@kernel.org>, 
	Tianyou Li <tianyou.li@intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Howard Chu <howardchu95@gmail.com>, Sergei Trofimovich <slyich@gmail.com>, 
	Shimin Guo <shimin.guo@skydio.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The e_flags are needed to accurately compute complete perf register
information for CSKY. Add the ability to read and have this value
associated with a thread. This change doesn't wire up the use of the
e_flags except in disasm where use already exists but just wasn't set
up yet.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c                   | 14 +++--
 tools/perf/builtin-trace.c                    | 12 ++--
 tools/perf/util/annotate.c                    |  5 +-
 tools/perf/util/disasm.c                      |  5 +-
 tools/perf/util/disasm.h                      |  2 +-
 tools/perf/util/dso.c                         | 43 +++++++++++---
 tools/perf/util/dso.h                         |  4 +-
 .../scripting-engines/trace-event-python.c    |  2 +-
 tools/perf/util/session.c                     |  4 +-
 tools/perf/util/thread.c                      | 59 +++++++++++++------
 tools/perf/util/thread.h                      | 16 ++++-
 tools/perf/util/unwind-libdw.c                |  4 +-
 12 files changed, 122 insertions(+), 48 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 372bede30230..8c0de27a9713 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2504,11 +2504,17 @@ static void process_event(struct perf_script *script,
 				    symbol_conf.bt_stop_list, fp);
 	}
 
-	if (PRINT_FIELD(IREGS))
-		perf_sample__fprintf_iregs(sample, attr, thread__e_machine(thread, machine), fp);
+	if (PRINT_FIELD(IREGS)) {
+		perf_sample__fprintf_iregs(sample, attr,
+					   thread__e_machine(thread, machine, /*e_flags=*/NULL),
+					   fp);
+	}
 
-	if (PRINT_FIELD(UREGS))
-		perf_sample__fprintf_uregs(sample, attr, thread__e_machine(thread, machine), fp);
+	if (PRINT_FIELD(UREGS)) {
+		perf_sample__fprintf_uregs(sample, attr,
+					   thread__e_machine(thread, machine, /*e_flags=*/NULL),
+					   fp);
+	}
 
 	if (PRINT_FIELD(BRSTACK))
 		perf_sample__fprintf_brstack(sample, thread, evsel, fp);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8df5ca44e4f9..311d9da9896a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2789,7 +2789,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	struct thread_trace *ttrace;
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
-	e_machine = thread__e_machine(thread, trace->host);
+	e_machine = thread__e_machine(thread, trace->host, /*e_flags=*/NULL);
 	sc = trace__syscall_info(trace, evsel, e_machine, id);
 	if (sc == NULL)
 		goto out_put;
@@ -2868,7 +2868,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
-	e_machine = thread__e_machine(thread, trace->host);
+	e_machine = thread__e_machine(thread, trace->host, /*e_flags=*/NULL);
 	sc = trace__syscall_info(trace, evsel, e_machine, id);
 	if (sc == NULL)
 		goto out_put;
@@ -2934,7 +2934,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	struct thread_trace *ttrace;
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
-	e_machine = thread__e_machine(thread, trace->host);
+	e_machine = thread__e_machine(thread, trace->host, /*e_flags=*/NULL);
 	sc = trace__syscall_info(trace, evsel, e_machine, id);
 	if (sc == NULL)
 		goto out_put;
@@ -3285,7 +3285,9 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 
 	if (evsel == trace->syscalls.events.bpf_output) {
 		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
-		int e_machine = thread ? thread__e_machine(thread, trace->host) : EM_HOST;
+		int e_machine = thread
+			? thread__e_machine(thread, trace->host, /*e_flags=*/NULL)
+			: EM_HOST;
 		struct syscall *sc = trace__syscall_info(trace, evsel, e_machine, id);
 
 		if (sc) {
@@ -4916,7 +4918,7 @@ static size_t trace__fprintf_thread(FILE *fp, struct thread *thread, struct trac
 {
 	size_t printed = 0;
 	struct thread_trace *ttrace = thread__priv(thread);
-	int e_machine = thread__e_machine(thread, trace->host);
+	int e_machine = thread__e_machine(thread, trace->host, /*e_flags=*/NULL);
 	double ratio;
 
 	if (ttrace == NULL)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c16c6dfaa959..880b1bd300c2 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -984,6 +984,7 @@ int thread__get_arch(struct thread *thread, const struct arch **parch)
 {
 	const struct arch *arch;
 	struct machine *machine;
+	uint32_t e_flags;
 	uint16_t e_machine;
 
 	if (!thread) {
@@ -992,8 +993,8 @@ int thread__get_arch(struct thread *thread, const struct arch **parch)
 	}
 
 	machine = maps__machine(thread__maps(thread));
-	e_machine = thread__e_machine(thread, machine);
-	arch = arch__find(e_machine, machine->env ? machine->env->cpuid : NULL);
+	e_machine = thread__e_machine(thread, machine, &e_flags);
+	arch = arch__find(e_machine, e_flags, machine->env ? machine->env->cpuid : NULL);
 	if (arch == NULL) {
 		pr_err("%s: unsupported arch %d\n", __func__, e_machine);
 		return errno;
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 9b0ba1fc5aec..6b36287f30fe 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -134,7 +134,7 @@ static int arch__cmp(const void *a, const void *b)
 	return e_machine_and_eflags__cmp(&(*aa)->id, &(*ab)->id);
 }
 
-const struct arch *arch__find(uint16_t e_machine, const char *cpuid)
+const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *cpuid)
 {
 	static const struct arch *(*const arch_new_fn[])(const struct e_machine_and_e_flags *id,
 							 const char *cpuid) = {
@@ -157,8 +157,7 @@ const struct arch *arch__find(uint16_t e_machine, const char *cpuid)
 	static size_t num_archs;
 	struct e_machine_and_e_flags key = {
 		.e_machine = e_machine,
-		// TODO: e_flags should really come from the same source as e_machine.
-		.e_flags = EF_HOST,
+		.e_flags = e_flags,
 	};
 	const struct arch *result = NULL, **tmp;
 
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 6a1905f9d4fc..a6e478caf61a 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -108,7 +108,7 @@ struct annotate_args {
 	char			  *fileloc;
 };
 
-const struct arch *arch__find(uint16_t e_machine, const char *cpuid);
+const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *cpuid);
 bool arch__is_x86(const struct arch *arch);
 bool arch__is_powerpc(const struct arch *arch);
 
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 91c9f7cb9d8c..b791e1b6b2cf 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1220,14 +1220,20 @@ static enum dso_swap_type dso_swap_type__from_elf_data(unsigned char eidata)
 }
 
 /* Reads e_machine from fd, optionally caching data in dso. */
-uint16_t dso__read_e_machine(struct dso *optional_dso, int fd)
+uint16_t dso__read_e_machine(struct dso *optional_dso, int fd, uint32_t *e_flags)
 {
 	uint16_t e_machine = EM_NONE;
 	unsigned char e_ident[EI_NIDENT];
 	enum dso_swap_type swap_type;
+	bool need_e_flags;
 
-	_Static_assert(offsetof(Elf32_Ehdr, e_ident) == 0, "Unexpected offset");
-	_Static_assert(offsetof(Elf64_Ehdr, e_ident) == 0, "Unexpected offset");
+	if (e_flags)
+		*e_flags = 0;
+
+	{
+		_Static_assert(offsetof(Elf32_Ehdr, e_ident) == 0, "Unexpected offset");
+		_Static_assert(offsetof(Elf64_Ehdr, e_ident) == 0, "Unexpected offset");
+	}
 	if (pread(fd, &e_ident, sizeof(e_ident), 0) != sizeof(e_ident))
 		return EM_NONE; // Read failed.
 
@@ -1254,18 +1260,35 @@ uint16_t dso__read_e_machine(struct dso *optional_dso, int fd)
 	{
 		_Static_assert(offsetof(Elf32_Ehdr, e_machine) == 18, "Unexpected offset");
 		_Static_assert(offsetof(Elf64_Ehdr, e_machine) == 18, "Unexpected offset");
-		if (pread(fd, &e_machine, sizeof(e_machine), 18) != sizeof(e_machine))
-			return EM_NONE; // e_machine read failed.
 	}
+	if (pread(fd, &e_machine, sizeof(e_machine), 18) != sizeof(e_machine))
+		return EM_NONE; // e_machine read failed.
 
 	e_machine = DSO_SWAP_TYPE__SWAP(swap_type, uint16_t, e_machine);
 	if (e_machine >= EM_NUM)
 		return EM_NONE; // Bad ELF machine number.
 
+#ifdef NDEBUG
+	/* In production code the e_flags are only needed on CSKY. */
+	need_e_flags = e_flags && e_machine == EM_CSKY;
+#else
+	/* Debug code will always read the e_flags. */
+	need_e_flags = e_flags != NULL;
+#endif
+	if (need_e_flags) {
+		off_t offset = e_ident[EI_CLASS] == ELFCLASS32
+			? offsetof(Elf32_Ehdr, e_flags)
+			: offsetof(Elf64_Ehdr, e_flags);
+
+		if (pread(fd, e_flags, sizeof(*e_flags), offset) != sizeof(*e_flags)) {
+			*e_flags = 0;
+			return EM_NONE; // e_flags read failed.
+		}
+	}
 	return e_machine;
 }
 
-uint16_t dso__e_machine(struct dso *dso, struct machine *machine)
+uint16_t dso__e_machine(struct dso *dso, struct machine *machine, uint32_t *e_flags)
 {
 	uint16_t e_machine = EM_NONE;
 	int fd;
@@ -1285,6 +1308,8 @@ uint16_t dso__e_machine(struct dso *dso, struct machine *machine)
 	case DSO_BINARY_TYPE__BPF_IMAGE:
 	case DSO_BINARY_TYPE__OOL:
 	case DSO_BINARY_TYPE__JAVA_JIT:
+		if (e_flags)
+			*e_flags = EF_HOST;
 		return EM_HOST;
 	case DSO_BINARY_TYPE__DEBUGLINK:
 	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
@@ -1299,6 +1324,8 @@ uint16_t dso__e_machine(struct dso *dso, struct machine *machine)
 		break;
 	case DSO_BINARY_TYPE__NOT_FOUND:
 	default:
+		if (e_flags)
+			*e_flags = 0;
 		return EM_NONE;
 	}
 
@@ -1311,7 +1338,9 @@ uint16_t dso__e_machine(struct dso *dso, struct machine *machine)
 	try_to_open_dso(dso, machine);
 	fd = dso__data(dso)->fd;
 	if (fd >= 0)
-		e_machine = dso__read_e_machine(dso, fd);
+		e_machine = dso__read_e_machine(dso, fd, e_flags);
+	else if (e_flags)
+		*e_flags = 0;
 
 	mutex_unlock(dso__data_open_lock());
 	return e_machine;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index a95fee7d634b..ede691e9a249 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -866,8 +866,8 @@ int dso__data_file_size(struct dso *dso, struct machine *machine);
 off_t dso__data_size(struct dso *dso, struct machine *machine);
 ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 			      u64 offset, u8 *data, ssize_t size);
-uint16_t dso__read_e_machine(struct dso *optional_dso, int fd);
-uint16_t dso__e_machine(struct dso *dso, struct machine *machine);
+uint16_t dso__read_e_machine(struct dso *optional_dso, int fd, uint32_t *e_flags);
+uint16_t dso__e_machine(struct dso *dso, struct machine *machine, uint32_t *e_flags);
 ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
 			    struct machine *machine, u64 addr,
 			    u8 *data, ssize_t size);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index b90edc147796..50f0d16520cc 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -925,7 +925,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 
 	if (al->thread) {
 		machine = maps__machine(thread__maps(al->thread));
-		e_machine = thread__e_machine(al->thread, machine);
+		e_machine = thread__e_machine(al->thread, machine, /*e_flags=*/NULL);
 	}
 	if (set_regs_in_dict(dict, sample, evsel, e_machine))
 		Py_FatalError("Failed to setting regs in dict");
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c0231bc000e7..0e8a128d7c04 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1124,7 +1124,7 @@ static void dump_sample(struct machine *machine, struct evsel *evsel, union perf
 	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR)) {
 		struct thread *thread = machine__find_thread(machine, sample->pid, sample->pid);
 
-		e_machine = thread__e_machine(thread, machine);
+		e_machine = thread__e_machine(thread, machine, /*e_flags=*/NULL);
 	}
 
 	printf("(IP, 0x%x): %d/%d: %#" PRIx64 " period: %" PRIu64 " addr: %#" PRIx64 "\n",
@@ -2965,7 +2965,7 @@ static int perf_session__e_machine_cb(struct thread *thread,
 	uint16_t *result = arg;
 	struct machine *machine = maps__machine(thread__maps(thread));
 
-	*result = thread__e_machine(thread, machine);
+	*result = thread__e_machine(thread, machine, /*e_flags=*/NULL);
 	return *result != EM_NONE ? 1 : 0;
 }
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 3642858e6cbc..618f29afb160 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -449,7 +449,7 @@ void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 	}
 }
 
-static uint16_t read_proc_e_machine_for_pid(pid_t pid)
+static uint16_t read_proc_e_machine_for_pid(pid_t pid, uint32_t *e_flags)
 {
 	char path[6 /* "/proc/" */ + 11 /* max length of pid */ + 5 /* "/exe\0" */];
 	int fd;
@@ -458,30 +458,46 @@ static uint16_t read_proc_e_machine_for_pid(pid_t pid)
 	snprintf(path, sizeof(path), "/proc/%d/exe", pid);
 	fd = open(path, O_RDONLY);
 	if (fd >= 0) {
-		e_machine = dso__read_e_machine(/*optional_dso=*/NULL, fd);
+		e_machine = dso__read_e_machine(/*optional_dso=*/NULL, fd, e_flags);
 		close(fd);
 	}
 	return e_machine;
 }
 
-static int thread__e_machine_callback(struct map *map, void *machine)
+struct thread__e_machine_callback_args {
+	struct machine *machine;
+	uint32_t e_flags;
+	uint16_t e_machine;
+};
+
+static int thread__e_machine_callback(struct map *map, void *_args)
 {
+	struct thread__e_machine_callback_args *args = _args;
 	struct dso *dso = map__dso(map);
 
-	_Static_assert(0 == EM_NONE, "Unexpected EM_NONE");
 	if (!dso)
-		return EM_NONE;
+		return 0; // No dso, continue search.
 
-	return dso__e_machine(dso, machine);
+	args->e_machine = dso__e_machine(dso, args->machine, &args->e_flags);
+	return args->e_machine != EM_NONE ? 1 /* stop search */ : 0 /* continue search */;
 }
 
-uint16_t thread__e_machine(struct thread *thread, struct machine *machine)
+uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint32_t *e_flags)
 {
 	pid_t tid, pid;
 	uint16_t e_machine = RC_CHK_ACCESS(thread)->e_machine;
+	uint32_t local_e_flags = 0;
+	struct thread__e_machine_callback_args args = {
+		.machine = machine,
+		.e_flags = 0,
+		.e_machine = EM_NONE,
+	};
 
-	if (e_machine != EM_NONE)
+	if (e_machine != EM_NONE) {
+		if (e_flags)
+			*e_flags = thread__e_flags(thread);
 		return e_machine;
+	}
 
 	tid = thread__tid(thread);
 	pid = thread__pid(thread);
@@ -489,18 +505,19 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine)
 		struct thread *parent = machine__findnew_thread(machine, pid, pid);
 
 		if (parent) {
-			e_machine = thread__e_machine(parent, machine);
+			e_machine = thread__e_machine(parent, machine, &local_e_flags);
 			thread__put(parent);
-			thread__set_e_machine(thread, e_machine);
-			return e_machine;
+			goto out;
 		}
 		/* Something went wrong, fallback. */
 	}
 	/* Reading on the PID thread. First try to find from the maps. */
-	e_machine = maps__for_each_map(thread__maps(thread),
-				       thread__e_machine_callback,
-				       machine);
-	if (e_machine == EM_NONE) {
+	maps__for_each_map(thread__maps(thread), thread__e_machine_callback, &args);
+
+	if (args.e_machine != EM_NONE) {
+		e_machine = args.e_machine;
+		local_e_flags = args.e_flags;
+	} else {
 		/* Maps failed, perhaps we're live with map events disabled. */
 		bool is_live = machine->machines == NULL;
 
@@ -514,12 +531,18 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine)
 		}
 		/* Read from /proc/pid/exe if live. */
 		if (is_live)
-			e_machine = read_proc_e_machine_for_pid(pid);
+			e_machine = read_proc_e_machine_for_pid(pid, &local_e_flags);
 	}
-	if (e_machine != EM_NONE)
+out:
+	if (e_machine != EM_NONE) {
 		thread__set_e_machine(thread, e_machine);
-	else
+		thread__set_e_flags(thread, local_e_flags);
+	} else {
 		e_machine = EM_HOST;
+		local_e_flags = EF_HOST;
+	}
+	if (e_flags)
+		*e_flags = local_e_flags;
 	return e_machine;
 }
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 310eaea344bb..f5792d3e8a16 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -60,6 +60,10 @@ DECLARE_RC_STRUCT(thread) {
 	struct srccode_state	srccode_state;
 	bool			filter;
 	int			filter_entry_depth;
+	/**
+	 * @e_flags: The ELF EF_* associated with the thread. Valid if e_machine != EM_NONE.
+	 */
+	uint16_t		e_flags;
 	/**
 	 * @e_machine: The ELF EM_* associated with the thread. EM_NONE if not
 	 * computed.
@@ -307,13 +311,23 @@ static inline void thread__set_filter_entry_depth(struct thread *thread, int dep
 	RC_CHK_ACCESS(thread)->filter_entry_depth = depth;
 }
 
-uint16_t thread__e_machine(struct thread *thread, struct machine *machine);
+uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint32_t *e_flags);
 
 static inline void thread__set_e_machine(struct thread *thread, uint16_t e_machine)
 {
 	RC_CHK_ACCESS(thread)->e_machine = e_machine;
 }
 
+static inline uint32_t thread__e_flags(const struct thread *thread)
+{
+	return RC_CHK_ACCESS(thread)->e_flags;
+}
+
+static inline void thread__set_e_flags(struct thread *thread, uint32_t e_flags)
+{
+	RC_CHK_ACCESS(thread)->e_flags = e_flags;
+}
+
 
 static inline bool thread__lbr_stitch_enable(const struct thread *thread)
 {
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 9cb0960ef905..3fdcfa06bf22 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -213,7 +213,7 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
 {
 	struct dwfl_ui_thread_info *dwfl_ui_ti = arg;
 	struct unwind_info *ui = dwfl_ui_ti->ui;
-	uint16_t e_machine = thread__e_machine(ui->thread, ui->machine);
+	uint16_t e_machine = thread__e_machine(ui->thread, ui->machine, /*e_flags=*/NULL);
 	struct stack_dump *stack = &ui->sample->user_stack;
 	u64 start, end;
 	int offset;
@@ -348,7 +348,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 {
 	struct maps *maps = thread__maps(thread);
 	struct machine *machine = maps__machine(maps);
-	uint16_t e_machine = thread__e_machine(thread, machine);
+	uint16_t e_machine = thread__e_machine(thread, machine, /*e_flags=*/NULL);
 	struct dwfl_ui_thread_info *dwfl_ui_ti;
 	static struct unwind_info *ui;
 	Dwfl *dwfl;
-- 
2.52.0.457.g6b5491de43-goog

