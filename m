Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA7330B30
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627804; cv=none; b=pSiAFDEjgZ2MB9CMaKsjhSqfBrk/X4ufdQf+khGecUxE55NjIZxELMjw553tfFDathfdyPxgpIqGBs/ewH7leG60j/L97VUe6vzleetVEu6JFCZmZ/Mgw0r0Omww3z1hjk13zzlPUKVL0/35GuHlPHIRNaJ6o87tyBSbWkGSHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627804; c=relaxed/simple;
	bh=59/fPmmIJ+wvu7jOaxWHkGNuTzrpNNBL4KSaqqptTOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NJt58lRfesCkS56wCO5sYRq/v3LLLtKCwlLpsN2vqiArSHD0F8G9B/6tf40tbPTMzSfKyeY1mTikCFRQHvTEgZ5GKfPNAImtWpuYIyK0CX/HHeCXZ8CKs2JxqeK+TGM2E1ashJr1Hi3rMhAwVOAslmjg9M5SoDmdVRIH2ZPlqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLUKMSM3; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLUKMSM3"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ae26a77b76so4881121eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627801; x=1769232601; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ovty9hx/OhrSFGFh9FSlYP45sCJ4K4eUavVfI0lVQ/E=;
        b=WLUKMSM3K7eOHIle8IKSxQTS3dhQdB02YrU4oVM+rQ9B+X9zW2uNEv0M50U/UfokIC
         tCNrt85cU2Wu6ZgUhXWnjrug2fUKuaE1hZ48Zl99DPHmoX+2aPxI61zfGEfD5Y7fitvi
         nDLQeg1FiJHZxLuklE5d4fYEP8387jZSSLQjRaO3DnhQYz8NLr5mdZp6Zx7inp9QcwXW
         Cb0WWBDZZFFClI+agwaRge7mql0/T+D6lzuMErSkXswgkugQeUx2LWlIksmxnS+uDuz5
         VmMB8LLJ12I7+XLTFUx+iGCXt7ImAVXoFiAH8U7/gCb0TBMvBEt2lgk2/eV/DMAdisyv
         e4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627801; x=1769232601;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ovty9hx/OhrSFGFh9FSlYP45sCJ4K4eUavVfI0lVQ/E=;
        b=PpID7HE6W9aUBl/KcCMGZ+k2qx54IkKdXe9RcW59z268igFy2mNjo3JNHM6AIjwXSZ
         gBHv9lQiQfGP9wbwGgkg8KrqAy6Q/wzQbTbm0yyeR1Lgq56vYyBKjHxgNGWkkeJpS3gE
         eriGlpwgriasZtHrq5luV7MHS0HtzDqqGz3SJZWssFepwMgOJ6vDb8NzD735L5FS9V3Q
         tg0ecLH07SXr5C0wHdqPfmskfUTNza3CNpcpyqhlmdZLW64AMQHWiskZmGFriA3RA0Fp
         MdpMAWJGAA8uUZsQV2XY85v03qfJ+rGC3jMUdu27BRjlzaD/T7ih4gZNZq3oWmHO6VB4
         8x9g==
X-Forwarded-Encrypted: i=1; AJvYcCUqE4wVE0l4S4PUOuJOZHbaXicaDUGS29Uu8G009JA0BCWu+41fdTy6x9i8XI7yPU+J6MfMmhnt1VHL15dd3Voz@vger.kernel.org
X-Gm-Message-State: AOJu0YwQFLXdeD/fGT9hJkTr1JBr+QOa9UZXoovniJwovPhZBj8FLLcx
	TMrYMUX3tRQzVy4yf1Py2wkq8HCdakODMAUWmYtQ+PHsEVgUG62AuQnje1jn6zWBXNH2lmW9Whj
	1CbDv+Qj8ow==
X-Received: from dybpi1.prod.google.com ([2002:a05:7301:4201:b0:2b6:bfef:23fa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a883:b0:2ae:5424:e5a4
 with SMTP id 5a478bee46e88-2b6b4eade90mr4086553eec.37.1768627800651; Fri, 16
 Jan 2026 21:30:00 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:48 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-23-irogers@google.com>
Subject: [PATCH v1 22/23] perf unwind-libdw: Don't discard loaded ELF/Dwarf
 after every unwind
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"

The unwind-libdw dwfl has ELF binaries associated with mmap
addresses. Experimenting with using the per dso dwfl it is required to
alter the address to be 0 based variant. Unfortunately libdwfl doesn't
allow a single unwind and then an update to the return address to be 0
based as there are assertions that registers aren't updated once an
unwind has started, etc.

As removing the dwfl didn't prove possible, an alternative is to just
not discard the dwfl when the unwind ends. The dwfl is valid for a
process unless a dso is loaded at the same address as a previous
one. So keep the dwfl with the maps, invalidate it if a map is removed
(in case a new map replaces it) and recycle the dwfl in the unwinding
code. A wrinkly in the implementation of this is that the attached
thread argument is remembered by the dwfl and so it needs to be a
pointer to memory that also persists with the dwfl (struct
dwfl_ui_thread_info in the code).

Recording 10 seconds of system wide data with --call-graph=dwarf and
then processing with perf report shows a total runtime improvement
from 41.583s to 2.279s (an 18x speedup).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c         | 36 +++++++++++++-
 tools/perf/util/maps.h         |  4 ++
 tools/perf/util/unwind-libdw.c | 90 +++++++++++++++++++++++++---------
 tools/perf/util/unwind-libdw.h |  9 +++-
 4 files changed, 112 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index c321d4f4d846..8ccc46d515b6 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -10,6 +10,7 @@
 #include "thread.h"
 #include "ui/ui.h"
 #include "unwind.h"
+#include "unwind-libdw.h"
 #include <internal/rc_check.h>
 
 /*
@@ -39,6 +40,9 @@ DECLARE_RC_STRUCT(maps) {
 #ifdef HAVE_LIBUNWIND_SUPPORT
 	void		*addr_space;
 	const struct unwind_libunwind_ops *unwind_libunwind_ops;
+#endif
+#ifdef HAVE_LIBDW_SUPPORT
+	void		*libdw_addr_space_dwfl;
 #endif
 	refcount_t	 refcnt;
 	/**
@@ -203,6 +207,17 @@ void maps__set_unwind_libunwind_ops(struct maps *maps, const struct unwind_libun
 	RC_CHK_ACCESS(maps)->unwind_libunwind_ops = ops;
 }
 #endif
+#ifdef HAVE_LIBDW_SUPPORT
+void *maps__libdw_addr_space_dwfl(const struct maps *maps)
+{
+	return RC_CHK_ACCESS(maps)->libdw_addr_space_dwfl;
+}
+
+void maps__set_libdw_addr_space_dwfl(struct maps *maps, void *dwfl)
+{
+	RC_CHK_ACCESS(maps)->libdw_addr_space_dwfl = dwfl;
+}
+#endif
 
 static struct rw_semaphore *maps__lock(struct maps *maps)
 {
@@ -218,6 +233,9 @@ static void maps__init(struct maps *maps, struct machine *machine)
 #ifdef HAVE_LIBUNWIND_SUPPORT
 	RC_CHK_ACCESS(maps)->addr_space = NULL;
 	RC_CHK_ACCESS(maps)->unwind_libunwind_ops = NULL;
+#endif
+#ifdef HAVE_LIBDW_SUPPORT
+	RC_CHK_ACCESS(maps)->libdw_addr_space_dwfl = NULL;
 #endif
 	refcount_set(maps__refcnt(maps), 1);
 	RC_CHK_ACCESS(maps)->nr_maps = 0;
@@ -240,6 +258,9 @@ static void maps__exit(struct maps *maps)
 	zfree(&maps_by_address);
 	zfree(&maps_by_name);
 	unwind__finish_access(maps);
+#ifdef HAVE_LIBDW_SUPPORT
+	libdw__invalidate_dwfl(maps, maps__libdw_addr_space_dwfl(maps));
+#endif
 }
 
 struct maps *maps__new(struct machine *machine)
@@ -549,6 +570,9 @@ void maps__remove(struct maps *maps, struct map *map)
 	__maps__remove(maps, map);
 	check_invariants(maps);
 	up_write(maps__lock(maps));
+#ifdef HAVE_LIBDW_SUPPORT
+	libdw__invalidate_dwfl(maps, maps__libdw_addr_space_dwfl(maps));
+#endif
 }
 
 bool maps__empty(struct maps *maps)
@@ -604,18 +628,26 @@ int maps__for_each_map(struct maps *maps, int (*cb)(struct map *map, void *data)
 void maps__remove_maps(struct maps *maps, bool (*cb)(struct map *map, void *data), void *data)
 {
 	struct map **maps_by_address;
+	bool removed = false;
 
 	down_write(maps__lock(maps));
 
 	maps_by_address = maps__maps_by_address(maps);
 	for (unsigned int i = 0; i < maps__nr_maps(maps);) {
-		if (cb(maps_by_address[i], data))
+		if (cb(maps_by_address[i], data)) {
 			__maps__remove(maps, maps_by_address[i]);
-		else
+			removed = true;
+		} else {
 			i++;
+		}
 	}
 	check_invariants(maps);
 	up_write(maps__lock(maps));
+	if (removed) {
+#ifdef HAVE_LIBDW_SUPPORT
+		libdw__invalidate_dwfl(maps, maps__libdw_addr_space_dwfl(maps));
+#endif
+	}
 }
 
 struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index d9aa62ed968a..20c52084ba9e 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -52,6 +52,10 @@ void maps__set_addr_space(struct maps *maps, void *addr_space);
 const struct unwind_libunwind_ops *maps__unwind_libunwind_ops(const struct maps *maps);
 void maps__set_unwind_libunwind_ops(struct maps *maps, const struct unwind_libunwind_ops *ops);
 #endif
+#ifdef HAVE_LIBDW_SUPPORT
+void *maps__libdw_addr_space_dwfl(const struct maps *maps);
+void maps__set_libdw_addr_space_dwfl(struct maps *maps, void *dwfl);
+#endif
 
 size_t maps__fprintf(struct maps *maps, FILE *fp);
 
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index e0321043af88..c1646ef5f971 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -20,6 +20,17 @@
 #include "callchain.h"
 #include "util/env.h"
 
+/*
+ * The dwfl thread argument passed to functions like memory_read. Memory has to
+ * be allocated to persist of multiple uses of the dwfl.
+ */
+struct dwfl_ui_thread_info {
+	/* Back link to the dwfl. */
+	Dwfl *dwfl;
+	/* The current unwind info, only 1 is supported. */
+	struct unwind_info *ui;
+};
+
 static char *debuginfo_path;
 
 static int __find_debuginfo(Dwfl_Module *mod __maybe_unused, void **userdata,
@@ -35,6 +46,19 @@ static int __find_debuginfo(Dwfl_Module *mod __maybe_unused, void **userdata,
 	return -1;
 }
 
+void libdw__invalidate_dwfl(struct maps *maps, void *arg)
+{
+	struct dwfl_ui_thread_info *dwfl_ui_ti = arg;
+
+	if (!dwfl_ui_ti)
+		return;
+
+	assert(dwfl_ui_ti->ui == NULL);
+	maps__set_libdw_addr_space_dwfl(maps, NULL);
+	dwfl_end(dwfl_ui_ti->dwfl);
+	free(dwfl_ui_ti);
+}
+
 static const Dwfl_Callbacks offline_callbacks = {
 	.find_debuginfo		= __find_debuginfo,
 	.debuginfo_path		= &debuginfo_path,
@@ -187,7 +211,8 @@ static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
 static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *result,
 			void *arg)
 {
-	struct unwind_info *ui = arg;
+	struct dwfl_ui_thread_info *dwfl_ui_ti = arg;
+	struct unwind_info *ui = dwfl_ui_ti->ui;
 	uint16_t e_machine = thread__e_machine(ui->thread, ui->machine);
 	struct stack_dump *stack = &ui->sample->user_stack;
 	u64 start, end;
@@ -228,7 +253,8 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
 
 static bool libdw_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
-	struct unwind_info *ui = arg;
+	struct dwfl_ui_thread_info *dwfl_ui_ti = arg;
+	struct unwind_info *ui = dwfl_ui_ti->ui;
 	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
 	Dwarf_Word *dwarf_regs;
 	int max_dwarf_reg = 0;
@@ -320,33 +346,50 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 			int max_stack,
 			bool best_effort)
 {
-	struct machine *machine = maps__machine(thread__maps(thread));
+	struct maps *maps = thread__maps(thread);
+	struct machine *machine = maps__machine(maps);
 	uint16_t e_machine = thread__e_machine(thread, machine);
-	struct unwind_info *ui, ui_buf = {
-		.sample		= data,
-		.thread		= thread,
-		.machine	= machine,
-		.cb		= cb,
-		.arg		= arg,
-		.max_stack	= max_stack,
-		.e_machine	= e_machine,
-		.best_effort    = best_effort
-	};
+	struct dwfl_ui_thread_info *dwfl_ui_ti;
+	static struct unwind_info *ui;
+	Dwfl *dwfl;
 	Dwarf_Word ip;
 	int err = -EINVAL, i;
 
 	if (!data->user_regs || !data->user_regs->regs)
 		return -EINVAL;
 
-	ui = zalloc(sizeof(ui_buf) + sizeof(ui_buf.entries[0]) * max_stack);
+	ui = zalloc(sizeof(*ui) + sizeof(ui->entries[0]) * max_stack);
 	if (!ui)
 		return -ENOMEM;
 
-	*ui = ui_buf;
+	*ui = (struct unwind_info){
+		.sample		= data,
+		.thread		= thread,
+		.machine	= machine,
+		.cb		= cb,
+		.arg		= arg,
+		.max_stack	= max_stack,
+		.e_machine	= e_machine,
+		.best_effort    = best_effort
+	};
 
-	ui->dwfl = dwfl_begin(&offline_callbacks);
-	if (!ui->dwfl)
-		goto out;
+	dwfl_ui_ti = maps__libdw_addr_space_dwfl(maps);
+	if (dwfl_ui_ti) {
+		dwfl = dwfl_ui_ti->dwfl;
+	} else {
+		dwfl_ui_ti = zalloc(sizeof(*dwfl_ui_ti));
+		dwfl = dwfl_begin(&offline_callbacks);
+		if (!dwfl)
+			goto out;
+
+		dwfl_ui_ti->dwfl = dwfl;
+		maps__set_libdw_addr_space_dwfl(maps, dwfl_ui_ti);
+	}
+	assert(dwfl_ui_ti->ui == NULL);
+	assert(dwfl_ui_ti->dwfl == dwfl);
+	assert(dwfl_ui_ti == maps__libdw_addr_space_dwfl(maps));
+	dwfl_ui_ti->ui = ui;
+	ui->dwfl = dwfl;
 
 	err = perf_reg_value(&ip, data->user_regs, perf_arch_reg_ip(e_machine));
 	if (err)
@@ -356,11 +399,12 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	if (err)
 		goto out;
 
-	err = !dwfl_attach_state(ui->dwfl, /*elf=*/NULL, thread__tid(thread), &callbacks, ui);
-	if (err)
-		goto out;
+	dwfl_attach_state(dwfl, /*elf=*/NULL, thread__tid(thread), &callbacks,
+			  /* Dwfl thread function argument*/dwfl_ui_ti);
+	// Ignore thread already attached error.
 
-	err = dwfl_getthread_frames(ui->dwfl, thread__tid(thread), frame_callback, ui);
+	err = dwfl_getthread_frames(dwfl, thread__tid(thread), frame_callback,
+				    /* Dwfl frame function argument*/ui);
 
 	if (err && ui->max_stack != max_stack)
 		err = 0;
@@ -384,7 +428,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	for (i = 0; i < ui->idx; i++)
 		map_symbol__exit(&ui->entries[i].ms);
 
-	dwfl_end(ui->dwfl);
+	dwfl_ui_ti->ui = NULL;
 	free(ui);
 	return 0;
 }
diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-libdw.h
index 9c5b5fcaaae8..3dec0ab8bd50 100644
--- a/tools/perf/util/unwind-libdw.h
+++ b/tools/perf/util/unwind-libdw.h
@@ -2,15 +2,17 @@
 #ifndef __PERF_UNWIND_LIBDW_H
 #define __PERF_UNWIND_LIBDW_H
 
-#include <elfutils/libdwfl.h>
+#include <stdint.h>
 #include "unwind.h"
 
 struct machine;
 struct perf_sample;
 struct thread;
 
+#ifdef HAVE_LIBDW_SUPPORT
+
 struct unwind_info {
-	Dwfl			*dwfl;
+	void			*dwfl;
 	struct perf_sample      *sample;
 	struct machine          *machine;
 	struct thread           *thread;
@@ -23,4 +25,7 @@ struct unwind_info {
 	struct unwind_entry	entries[];
 };
 
+void libdw__invalidate_dwfl(struct maps *maps, void *dwfl);
+#endif
+
 #endif /* __PERF_UNWIND_LIBDW_H */
-- 
2.52.0.457.g6b5491de43-goog

