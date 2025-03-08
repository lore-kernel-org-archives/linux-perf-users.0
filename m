Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6161465AB
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Mar 2025 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741393951; cv=none; b=ih/Vt1NFjDSCPD+TzU6kM99NR3ao+JEpWzGPuvqofRbGiBXk74MqrqkHzMYUKhaZOB00rCiy7C03QfrUarYuBRthOCLDSVrtlN1oQvFYZ60cipJXqNhYD9ceg38cVKVNSqk8dW4oxP9fH6LPydRd7HEjy4VyHKKJTJ9Uv4b2xKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741393951; c=relaxed/simple;
	bh=HdOOD74kR58kQ17pG9CwaFF99KxFicuZ/9ks/nxTEFw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SnTbpJifjXX1OEHszOlvawjG2KqlDJOsx8b0KYetBHNO09+MghXzcBuZEFwKmxSH2Zf+dSfFejUpmhw7Hd8KxOyi2xuKyqbRBRklAbCvGDZBFQ9mVVN+ksxX+gjCeiF2cpLAfAtA6uPg2VALGaJS1Mheyq3EqGSYtOyrVhjfBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htNRXH+7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htNRXH+7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fd010df0f4so38838737b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Mar 2025 16:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741393949; x=1741998749; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vetkQsewyj1QbRQTjQ9n4OdNuLUxV5BdmsX+IHcqXRY=;
        b=htNRXH+7Jnc70m2GMM83BgA9CKfmaNXI9D+KwvN3smTkok5o6hFkX2WPcXke2VDb21
         LSiJd3YubVbxq++AlBAjt68hbOisfV6n6Jk0enT7B0ftL/7XnTQdtcK6nQq+P0IG/4Aq
         DS8m+teb5sPkoKTV8IKWotnvedDf5xMGp2WTPKjca6eWPQaiFA99bdmaCmwLOxNtoIj+
         WLM39vj1oIaqK46ANCy4Ams9eVo+U1YzwT+0pXDfAzCWxt+6qgz0wFJvwqnXYiLZIsUS
         uACx/12s0qtBBunzrcVYuPiltfBNz+xSQKnK0nsuS73KH8jeLgDg2vMACcA7vf8UzG3y
         rZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741393949; x=1741998749;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vetkQsewyj1QbRQTjQ9n4OdNuLUxV5BdmsX+IHcqXRY=;
        b=sFqTI8MdeAFuduKbP3RT5FHjfGHZT5KOaqFuHEvjLp43ZbiIoKVfHKaAuHanpWksOR
         ySL5dvFkeWm6lyIj6rig6judPwBPZWtxLO72zh73gvY/3VH97dPlKwUejABqyE2L6EuR
         JtBUTdpfpTU4oMnBXfo+vFjZd56S9g0MPwdNtYI/3szTYASIibk3Iogkna2P2S/UoUUK
         UMVxCMHxENDpVudK657jhs3waIsH7DPqb0IgJsF/Q0QXieVZu67G58GJgJ7yVJ9SGLL4
         OiN9l1Vg82Kii4utijjtrONggfG2NCm6VYmJXYXF1fG+56TjPJlksr8mNeDC8LXmdtK1
         5SOg==
X-Forwarded-Encrypted: i=1; AJvYcCXAIxwrWn8BAj9YofkDWZS69cbcum3i3HSZFXjzz3JkyMOkK/X5WVbxFaWvY94SCXFEh+UpJc29psSJx3Yz6fh3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+HMStoZsYdQVXYumfHVFpbAs4w5AU9cPcHdbPGOyOfBRu5Km
	Ie8HTBVnWySEQRRIz3eDlBdzYxvyNwLMyJM28QoqF77cdLB9j3tqwj2NfwD7/5hHXts17qXRIlA
	MR02SHQ==
X-Google-Smtp-Source: AGHT+IFN1j1UckDldnGO2oML3Lr7Es90qR+z0qbean5UPIvBHECq0bAZ2WTXIRqKYd/3JIgKQ6nWxFUa5jkt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:1541:e490:aa80:5766])
 (user=irogers job=sendgmr) by 2002:a05:6902:1368:b0:e63:3f3d:a5aa with SMTP
 id 3f1490d57ef6-e635c1ee91amr406694276.7.1741393948467; Fri, 07 Mar 2025
 16:32:28 -0800 (PST)
Date: Fri,  7 Mar 2025 16:32:05 -0800
In-Reply-To: <20250308003209.234114-1-irogers@google.com>
Message-Id: <20250308003209.234114-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250308003209.234114-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v5 07/11] perf thread: Add support for reading the e_machine
 type for a thread
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

First try to read the e_machine from the dsos associated with the
thread's maps. If live use the executable from /proc/pid/exe and read
the e_machine from the ELF header. On failure use EM_HOST. Change
builtin-trace syscall functions to pass e_machine from the thread
rather than EM_HOST, so that in later patches when syscalltbl can use
the e_machine the system calls are specific to the architecture.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 43 ++++++++++----------
 tools/perf/util/thread.c   | 80 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/thread.h   | 14 ++++++-
 3 files changed, 115 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cfc8cb8cbef8..49199d753b7c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2729,16 +2729,16 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	int printed = 0;
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
-	int augmented_args_size = 0;
+	int augmented_args_size = 0, e_machine;
 	void *augmented_args = NULL;
-	/* TODO: get e_machine from thread. */
-	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
+	struct syscall *sc;
 	struct thread_trace *ttrace;
 
-	if (sc == NULL)
-		return -1;
-
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+	e_machine = thread__e_machine(thread, trace->host);
+	sc = trace__syscall_info(trace, evsel, e_machine, id);
+	if (sc == NULL)
+		goto out_put;
 	ttrace = thread__trace(thread, trace);
 	if (ttrace == NULL)
 		goto out_put;
@@ -2806,17 +2806,18 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 	struct thread_trace *ttrace;
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
-	/* TODO: get e_machine from thread. */
-	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
+	struct syscall *sc;
 	char msg[1024];
 	void *args, *augmented_args = NULL;
-	int augmented_args_size;
+	int augmented_args_size, e_machine;
 	size_t printed = 0;
 
-	if (sc == NULL)
-		return -1;
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+	e_machine = thread__e_machine(thread, trace->host);
+	sc = trace__syscall_info(trace, evsel, e_machine, id);
+	if (sc == NULL)
+		return -1;
 	ttrace = thread__trace(thread, trace);
 	/*
 	 * We need to get ttrace just to make sure it is there when syscall__scnprintf_args()
@@ -2881,15 +2882,15 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	bool duration_calculated = false;
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0, printed = 0;
-	int alignment = trace->args_alignment;
-	/* TODO: get e_machine from thread. */
-	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
+	int alignment = trace->args_alignment, e_machine;
+	struct syscall *sc;
 	struct thread_trace *ttrace;
 
-	if (sc == NULL)
-		return -1;
-
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+	e_machine = thread__e_machine(thread, trace->host);
+	sc = trace__syscall_info(trace, evsel, e_machine, id);
+	if (sc == NULL)
+		goto out_put;
 	ttrace = thread__trace(thread, trace);
 	if (ttrace == NULL)
 		goto out_put;
@@ -3236,8 +3237,8 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 
 	if (evsel == trace->syscalls.events.bpf_output) {
 		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
-		/* TODO: get e_machine from thread. */
-		struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
+		int e_machine = thread ? thread__e_machine(thread, trace->host) : EM_HOST;
+		struct syscall *sc = trace__syscall_info(trace, evsel, e_machine, id);
 
 		if (sc) {
 			fprintf(trace->output, "%s(", sc->name);
@@ -4881,6 +4882,7 @@ static size_t trace__fprintf_thread(FILE *fp, struct thread *thread, struct trac
 {
 	size_t printed = 0;
 	struct thread_trace *ttrace = thread__priv(thread);
+	int e_machine = thread__e_machine(thread, trace->host);
 	double ratio;
 
 	if (ttrace == NULL)
@@ -4900,8 +4902,7 @@ static size_t trace__fprintf_thread(FILE *fp, struct thread *thread, struct trac
 	else if (fputc('\n', fp) != EOF)
 		++printed;
 
-	/* TODO: get e_machine from thread. */
-	printed += thread__dump_stats(ttrace, trace, EM_HOST, fp);
+	printed += thread__dump_stats(ttrace, trace, e_machine, fp);
 
 	return printed;
 }
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 0ffdd52d86d7..89585f53c1d5 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <elf.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -16,6 +18,7 @@
 #include "symbol.h"
 #include "unwind.h"
 #include "callchain.h"
+#include "dwarf-regs.h"
 
 #include <api/fs/fs.h>
 
@@ -51,6 +54,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		thread__set_ppid(thread, -1);
 		thread__set_cpu(thread, -1);
 		thread__set_guest_cpu(thread, -1);
+		thread__set_e_machine(thread, EM_NONE);
 		thread__set_lbr_stitch_enable(thread, false);
 		INIT_LIST_HEAD(thread__namespaces_list(thread));
 		INIT_LIST_HEAD(thread__comm_list(thread));
@@ -423,6 +427,82 @@ void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 	}
 }
 
+static uint16_t read_proc_e_machine_for_pid(pid_t pid)
+{
+	char path[6 /* "/proc/" */ + 11 /* max length of pid */ + 5 /* "/exe\0" */];
+	int fd;
+	uint16_t e_machine = EM_NONE;
+
+	snprintf(path, sizeof(path), "/proc/%d/exe", pid);
+	fd = open(path, O_RDONLY);
+	if (fd >= 0) {
+		_Static_assert(offsetof(Elf32_Ehdr, e_machine) == 18, "Unexpected offset");
+		_Static_assert(offsetof(Elf64_Ehdr, e_machine) == 18, "Unexpected offset");
+		if (pread(fd, &e_machine, sizeof(e_machine), 18) != sizeof(e_machine))
+			e_machine = EM_NONE;
+		close(fd);
+	}
+	return e_machine;
+}
+
+static int thread__e_machine_callback(struct map *map, void *machine)
+{
+	struct dso *dso = map__dso(map);
+
+	_Static_assert(0 == EM_NONE, "Unexpected EM_NONE");
+	if (!dso)
+		return EM_NONE;
+
+	return dso__e_machine(dso, machine);
+}
+
+uint16_t thread__e_machine(struct thread *thread, struct machine *machine)
+{
+	pid_t tid, pid;
+	uint16_t e_machine = RC_CHK_ACCESS(thread)->e_machine;
+
+	if (e_machine != EM_NONE)
+		return e_machine;
+
+	tid = thread__tid(thread);
+	pid = thread__pid(thread);
+	if (pid != tid) {
+		struct thread *parent = machine__findnew_thread(machine, pid, pid);
+
+		if (parent) {
+			e_machine = thread__e_machine(parent, machine);
+			thread__set_e_machine(thread, e_machine);
+			return e_machine;
+		}
+		/* Something went wrong, fallback. */
+	}
+	/* Reading on the PID thread. First try to find from the maps. */
+	e_machine = maps__for_each_map(thread__maps(thread),
+				       thread__e_machine_callback,
+				       machine);
+	if (e_machine == EM_NONE) {
+		/* Maps failed, perhaps we're live with map events disabled. */
+		bool is_live = machine->machines == NULL;
+
+		if (!is_live) {
+			/* Check if the session has a data file. */
+			struct perf_session *session = container_of(machine->machines,
+								    struct perf_session,
+								    machines);
+
+			is_live = !!session->data;
+		}
+		/* Read from /proc/pid/exe if live. */
+		if (is_live)
+			e_machine = read_proc_e_machine_for_pid(pid);
+	}
+	if (e_machine != EM_NONE)
+		thread__set_e_machine(thread, e_machine);
+	else
+		e_machine = EM_HOST;
+	return e_machine;
+}
+
 struct thread *thread__main_thread(struct machine *machine, struct thread *thread)
 {
 	if (thread__pid(thread) == thread__tid(thread))
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 6cbf6eb2812e..cd574a896418 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -60,7 +60,11 @@ DECLARE_RC_STRUCT(thread) {
 	struct srccode_state	srccode_state;
 	bool			filter;
 	int			filter_entry_depth;
-
+	/**
+	 * @e_machine: The ELF EM_* associated with the thread. EM_NONE if not
+	 * computed.
+	 */
+	uint16_t		e_machine;
 	/* LBR call stack stitch */
 	bool			lbr_stitch_enable;
 	struct lbr_stitch	*lbr_stitch;
@@ -302,6 +306,14 @@ static inline void thread__set_filter_entry_depth(struct thread *thread, int dep
 	RC_CHK_ACCESS(thread)->filter_entry_depth = depth;
 }
 
+uint16_t thread__e_machine(struct thread *thread, struct machine *machine);
+
+static inline void thread__set_e_machine(struct thread *thread, uint16_t e_machine)
+{
+	RC_CHK_ACCESS(thread)->e_machine = e_machine;
+}
+
+
 static inline bool thread__lbr_stitch_enable(const struct thread *thread)
 {
 	return RC_CHK_ACCESS(thread)->lbr_stitch_enable;
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

