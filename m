Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCCD3BE62B
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087117; cv=none; b=tEbxy8Ajv5SIeA0JA/PlVIzALaKOTbdUmJbVwmHzWZbbkrLYB3tlS7X5SfPBwvjY8+4nQiR45nGOKBSy0daU834AoIboaPLgsyuXcSW+qfYNlOD6vwz1tMoa76PnqtodTs1vrDDmpq3mpyMSsRc7z1cS/6eRtdlfrxxoHfEzowo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087117; c=relaxed/simple;
	bh=W2iZtBwbMeUW5cxW0un0JB1gS83mXqwqrdUOZ1j1Rjc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WMiBawwd0aspXtba2zmacd5W9Jpjm1RX2hd8+ummkz2cbPVH9I3G91iORFQRbTWfgIfunL9g+CqZt48Xl6h7U80d55/SEnYCZyWtDmVsvV3rwTIOLEctwu2nqxc7LLmUe0GmSlsFw0K/ndnM2SoCaVSTho0R2EOH7SxohGLDXJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgi9X2+M; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgi9X2+M"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so2542992a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 00:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786087114; x=1786691914; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OtbJ0rSorxaytiiVxkbbUemcKwkjUmBSIKc/6USecP8=;
        b=lgi9X2+M9YAuHHMlDtt1FkC8geTtzJ4zYOOZDKRdMSfeKwXIPWlxwtMkpjpTR3KozV
         4E4HvUc51lWPq0LDOic58u7TkhKqbG0wFskCnvmMP0ZveJR1lax2POiOIXjLHoE4qpF2
         YTvrGq6DAFmeAsFrUWga0XnOupEL9vUklxm+2Pwaii33VywVNTLSlVfYeSHC1m7kelya
         q0066lZAZ7M+d3ipjJ/HwUBUmfQVwtHoZHgW+LhB7qZwuYfaTCoVSA8KG43czUQm+sJc
         qzqsuhsLtmPHDP2VpODPUdTENPklYm7Fg6RE6CNBjueJ92wHT4rXV1hQJ2XAIG6072/E
         QrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786087114; x=1786691914;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OtbJ0rSorxaytiiVxkbbUemcKwkjUmBSIKc/6USecP8=;
        b=OT+wunlaiUlnYiWOfiGjMzyFjVhC+EfNt7em8BFs0uD29FOtLaCZjrRr6x1I9zkByw
         7+ywiB9+w6ILfxREDSeZqMc5pQSA+5R0nmCSG8oYkR7A52khjxWI1XsFf+OWBmMF7jxB
         XQVn7J9/CGqwZLQq1Djjqgdt3zQhYeBZfaMNe4zNgutQr+2/B9aoqF/mpUA6L3v5r/dh
         8FmDkN87YuQ9U9t3Yi/Cy2CGYCllXIle1zMROBlgQ3F7HWdeRo7wvA7YGolgXbElhQnM
         qELuppP8R1CzI823jnGVRl9v68bOD2eeQkBiIowoTiOChgJPaY+IX7KO6rIjuRjPVJQA
         woFg==
X-Forwarded-Encrypted: i=1; AHgh+Ro1RoLKe1Kx+vDbNsa7nHUtbtoHYEeYwHn6T7aW1STPbfdicEs4rrv2efY4kjzDalqKkeJUpKcAuQ721LV57ldi@vger.kernel.org
X-Gm-Message-State: AOJu0YyuabAumCx2yamIy5jbJNAK1bKENKjVEJNVWSNcsGKuwkw6oLXO
	W7XLGvHJhiMJvGdZnmUAxbk4t9bQDvFThxC0zWrxoW9btsmAmJFYpz6TVP8TvUo6CN6Hzk32HpH
	FXMbxFRyoqg==
X-Received: from dlcip6.prod.google.com ([2002:a05:7023:c086:b0:13e:5e3d:db8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7349:b0:3c6:3c5b:f2e1
 with SMTP id adf61e73a8af0-3cbadcfcacfmr7705992637.32.1786087112933; Fri, 07
 Aug 2026 00:18:32 -0700 (PDT)
Date: Fri,  7 Aug 2026 00:18:14 -0700
In-Reply-To: <20260807071818.718751-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807071818.718751-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807071818.718751-5-irogers@google.com>
Subject: [RFC PATCH v1 4/8] perf: Refactor thread map and symbol APIs to take perf_sample
From: Ian Rogers <irogers@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Eric Biggers <ebiggers@kernel.org>, Zecheng Li <zli94@ncsu.edu>, 
	Gabriel Marin <gmx@google.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	Derek Foreman <derek.foreman@collabora.com>, Tanushree Shah <tshah@linux.ibm.com>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Aaron Tomlin <atomlin@atomlin.com>, tanze <tanze@kylinos.cn>, 
	Rui Qi <qirui.001@bytedance.com>, Howard Chu <howardchu95@gmail.com>, 
	Chuck Lever <cel@kernel.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Alessio Podda <aleph.pi.gh@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Refactor thread__find_map and thread__find_symbol family of APIs to
take a struct perf_sample * instead of cpumode and addr. This prepares
for looking up symbols using build ID and offset, which is contained in
the sample payload instead of the address.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/powerpc/util/skip-callchain-idx.c    |  4 +-
 tools/perf/builtin-inject.c                   |  6 +-
 tools/perf/builtin-script.c                   | 33 +++++++----
 tools/perf/builtin-timechart.c                |  4 +-
 tools/perf/builtin-trace.c                    | 12 +++-
 tools/perf/tests/code-reading.c               |  4 +-
 tools/perf/tests/mmap-thread-lookup.c         |  9 ++-
 tools/perf/util/annotate-data.c               |  5 +-
 tools/perf/util/aslr.c                        | 16 +++--
 tools/perf/util/build-id.c                    |  5 +-
 tools/perf/util/capstone.c                    |  4 +-
 tools/perf/util/cs-etm.c                      |  4 +-
 tools/perf/util/data-convert-json.c           |  4 +-
 tools/perf/util/debug.c                       |  4 +-
 tools/perf/util/dlfilter.c                    |  8 ++-
 tools/perf/util/event.c                       | 59 +++++++++++--------
 tools/perf/util/intel-pt.c                    | 12 +++-
 tools/perf/util/machine.c                     | 18 ++++--
 tools/perf/util/python.c                      |  5 +-
 .../scripting-engines/trace-event-python.c    | 20 ++++---
 tools/perf/util/thread.c                      | 11 ++--
 tools/perf/util/thread.h                      | 14 ++---
 tools/perf/util/unwind-libdw.c                |  7 ++-
 tools/perf/util/unwind-libunwind.c            |  8 ++-
 24 files changed, 188 insertions(+), 88 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index e57f10798fa6..7a15efa0a699 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -223,7 +223,9 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 	addr_location__init(&al);
 	ip = chain->ips[1];
 
-	thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
+	thread__find_symbol(thread,
+			    &(struct perf_sample){.cpumode = PERF_RECORD_MISC_USER, .ip = ip},
+			    &al);
 
 	if (al.map)
 		dso = map__dso(al.map);
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 8559c0eab5f1..6aa9e3eea438 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -1167,7 +1167,11 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 		goto repipe;
 	}
 
-	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
+	if (thread__find_map(thread,
+			     &(struct perf_sample){.cpumode = sample->cpumode,
+						   .ip = sample->ip,
+						   .bid = sample->bid},
+			     &al)) {
 		mark_dso_hit(inject, tool, sample, machine, args.mmap_evsel, al.map,
 			     /*sample_in_dso=*/true);
 	}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f91d8b1fbd01..93cffafb1af7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1000,8 +1000,10 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 
 			addr_location__init(&alf);
 			addr_location__init(&alt);
-			thread__find_map_fb(thread, sample->cpumode, from, &alf);
-			thread__find_map_fb(thread, sample->cpumode, to, &alt);
+			thread__find_map_fb(thread,
+			    &(struct perf_sample){.cpumode = sample->cpumode, .ip = from}, &alf);
+			thread__find_map_fb(thread,
+			    &(struct perf_sample){.cpumode = sample->cpumode, .ip = to}, &alt);
 
 			printed += map__fprintf_dsoname_dsoff(alf.map, PRINT_FIELD(DSOFF), alf.addr, fp);
 			printed += fprintf(fp, "/0x%"PRIx64, to);
@@ -1037,8 +1039,10 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 		from = entries[i].from;
 		to   = entries[i].to;
 
-		thread__find_symbol_fb(thread, sample->cpumode, from, &alf);
-		thread__find_symbol_fb(thread, sample->cpumode, to, &alt);
+		thread__find_symbol_fb(thread,
+			       &(struct perf_sample){.cpumode = sample->cpumode, .ip = from}, &alf);
+		thread__find_symbol_fb(thread,
+			       &(struct perf_sample){.cpumode = sample->cpumode, .ip = to}, &alt);
 
 		printed += symbol__fprintf_symname_offs(alf.sym, &alf, fp);
 		if (PRINT_FIELD(DSO))
@@ -1075,11 +1079,15 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 		from = entries[i].from;
 		to   = entries[i].to;
 
-		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
+		if (thread__find_map_fb(thread,
+				&(struct perf_sample){.cpumode = sample->cpumode,
+						      .ip = from}, &alf) &&
 		    !dso__adjust_symbols(map__dso(alf.map)))
 			from = map__dso_map_ip(alf.map, from);
 
-		if (thread__find_map_fb(thread, sample->cpumode, to, &alt) &&
+		if (thread__find_map_fb(thread,
+				&(struct perf_sample){.cpumode = sample->cpumode,
+						      .ip = to}, &alt) &&
 		    !dso__adjust_symbols(map__dso(alt.map)))
 			to = map__dso_map_ip(alt.map, to);
 
@@ -1137,7 +1145,10 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	}
 
 	addr_location__init(&al);
-	if (!thread__find_map(thread, *cpumode, start, &al) || (dso = map__dso(al.map)) == NULL) {
+	if (!thread__find_map(thread,
+			      &(struct perf_sample){.cpumode = *cpumode,
+						    .ip = start}, &al) ||
+	    (dso = map__dso(al.map)) == NULL) {
 		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
 		goto out;
 	}
@@ -1212,7 +1223,7 @@ static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
 	int ret = 0;
 
 	addr_location__init(&al);
-	thread__find_map(thread, cpumode, addr, &al);
+	thread__find_map(thread, &(struct perf_sample){.cpumode = cpumode, .ip = addr}, &al);
 	if (!al.map)
 		goto out;
 	ret = map__fprintf_srccode(al.map, al.addr, stdout,
@@ -1267,7 +1278,9 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 		struct addr_location al;
 
 		addr_location__init(&al);
-		thread__find_map(thread, x->cpumode, ip, &al);
+		thread__find_map(thread,
+			 &(struct perf_sample){.cpumode = x->cpumode,
+					       .ip = ip}, &al);
 		printed += map__fprintf_srcline(al.map, al.addr, " srcline: ", fp);
 		printed += fprintf(fp, "\t");
 		addr_location__exit(&al);
@@ -1327,7 +1340,7 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 	int off, printed = 0, ret = 0;
 
 	addr_location__init(&al);
-	thread__find_map(thread, cpumode, addr, &al);
+	thread__find_map(thread, &(struct perf_sample){.cpumode = cpumode, .ip = addr}, &al);
 
 	if ((*lastsym) && al.addr >= (*lastsym)->start && al.addr < (*lastsym)->end)
 		goto out;
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 3f9153d5ecfb..77b79188afe6 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -564,7 +564,9 @@ static char *cat_backtrace(struct perf_sample *sample,
 
 		addr_location__init(&tal);
 		tal.filtered = 0;
-		if (thread__find_symbol(al.thread, cpumode, ip, &tal))
+		if (thread__find_symbol(al.thread,
+				&(struct perf_sample){.cpumode = cpumode,
+						      .ip = ip}, &tal))
 			fprintf(f, "..... %016" PRIx64 " %s\n", ip, tal.sym->name);
 		else
 			fprintf(f, "..... %016" PRIx64 "\n", ip);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c3c7f1f85c53..efe2ff239480 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3565,7 +3565,9 @@ static int trace__pgfault(struct trace *trace,
 	if (trace->summary_only)
 		goto out;
 
-	thread__find_symbol(thread, sample->cpumode, sample->ip, &al);
+	thread__find_symbol(thread,
+			    &(struct perf_sample){.cpumode = sample->cpumode,
+						  .ip = sample->ip}, &al);
 
 	trace__fprintf_entry_head(trace, thread, 0, true, sample->time,
 				  sample->cpu, trace->output);
@@ -3578,10 +3580,14 @@ static int trace__pgfault(struct trace *trace,
 
 	fprintf(trace->output, "] => ");
 
-	thread__find_symbol(thread, sample->cpumode, sample->addr, &al);
+	thread__find_symbol(thread,
+			    &(struct perf_sample){.cpumode = sample->cpumode,
+						  .ip = sample->addr}, &al);
 
 	if (!al.map) {
-		thread__find_symbol(thread, sample->cpumode, sample->addr, &al);
+		thread__find_symbol(thread,
+			    &(struct perf_sample){.cpumode = sample->cpumode,
+						  .ip = sample->addr}, &al);
 
 		if (al.map)
 			map_type = 'x';
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index f0e8ea8754ef..ca118d0262ad 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -394,7 +394,9 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
 
 	addr_location__init(&al);
-	if (!thread__find_map(thread, cpumode, addr, &al) || !map__dso(al.map)) {
+	if (!thread__find_map(thread,
+			      &(struct perf_sample){.cpumode = cpumode,
+						    .ip = addr}, &al) || !map__dso(al.map)) {
 		if (cpumode == PERF_RECORD_MISC_HYPERVISOR) {
 			pr_debug("Hypervisor address can not be resolved - skipping\n");
 			goto out;
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 0c5619c6e6e9..dca8bbfe780a 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -195,8 +195,10 @@ static int mmap_events(synth_cb synth)
 
 		pr_debug("looking for map %p\n", td->map);
 
-		thread__find_map(thread, PERF_RECORD_MISC_USER,
-				 (unsigned long) (td->map + 1), &al);
+		thread__find_map(thread, &(struct perf_sample){
+					.cpumode = PERF_RECORD_MISC_USER,
+					.ip = (unsigned long) (td->map + 1),
+				 }, &al);
 
 		thread__put(thread);
 
@@ -208,7 +210,10 @@ static int mmap_events(synth_cb synth)
 		}
 
 		pr_debug("map %p, addr %" PRIx64 "\n", al.map, map__start(al.map));
+
 		addr_location__exit(&al);
+		if (err)
+			break;
 	}
 
 	machine__delete(machine);
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 4e4c58764082..e3fc9c68ebe0 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -734,8 +734,9 @@ bool get_global_var_info(struct data_loc_info *dloc, u64 addr,
 	mem_addr = addr + map__reloc(dloc->ms->map);
 
 	addr_location__init(&al);
-	sym = thread__find_symbol_fb(dloc->thread, dloc->cpumode,
-				     mem_addr, &al);
+	sym = thread__find_symbol_fb(dloc->thread,
+				     &(struct perf_sample){.cpumode = dloc->cpumode,
+							   .ip = mem_addr}, &al);
 	if (sym) {
 		*var_name = sym->name;
 		/* Calculate type offset from the start of variable */
diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index 027695d96779..cb8e3ca437a1 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -154,7 +154,9 @@ static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
 		return 0; /* No thread. */
 
 	addr_location__init(&al);
-	if (!thread__find_map(aslr_thread, cpumode, addr, &al)) {
+	if (!thread__find_map(aslr_thread,
+			      &(struct perf_sample){.cpumode = cpumode, .ip = addr},
+			      &al)) {
 		/*
 		 * If lookup fails with specified cpumode, try fallback to the other space
 		 * to be robust against bad cpumode in samples.
@@ -168,7 +170,9 @@ static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
 		else if (cpumode == PERF_RECORD_MISC_GUEST_USER)
 			effective_cpumode = PERF_RECORD_MISC_GUEST_KERNEL;
 
-		if (!thread__find_map(aslr_thread, effective_cpumode, addr, &al)) {
+		if (!thread__find_map(aslr_thread,
+				      &(struct perf_sample){.cpumode = effective_cpumode,
+							    .ip = addr}, &al)) {
 			addr_location__exit(&al);
 			return 0; /* No mmap. */
 		}
@@ -285,7 +289,9 @@ static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
 	remap_key.pid = (cpumode == PERF_RECORD_MISC_KERNEL ||
 			 cpumode == PERF_RECORD_MISC_GUEST_KERNEL) ?
 			kernel_pid : thread__pid(aslr_thread);
-	if (thread__find_map(aslr_thread, cpumode, start, &al)) {
+	if (thread__find_map(aslr_thread,
+			     &(struct perf_sample){.cpumode = cpumode, .ip = start},
+			     &al)) {
 		struct dso *dso = map__dso(al.map);
 		const char *dso_name = dso ? dso__long_name(dso) : NULL;
 
@@ -342,7 +348,9 @@ static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
 		remap_addr = top->remapped_max;
 
 		addr_location__init(&prev_al);
-		if (thread__find_map(aslr_thread, cpumode, start - 1, &prev_al)) {
+		if (thread__find_map(aslr_thread,
+				     &(struct perf_sample){.cpumode = cpumode,
+							   .ip = start - 1}, &prev_al)) {
 			if (map__end(prev_al.map) == start)
 				is_contiguous = true;
 		}
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index eb95ab90f974..39e69f2299ab 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -69,7 +69,10 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 	}
 
 	addr_location__init(&al);
-	if (thread__find_map(thread, sample->cpumode, sample->ip, &al))
+	if (thread__find_map(thread,
+			     &(struct perf_sample){.cpumode = sample->cpumode,
+						   .ip = sample->ip,
+						   .bid = sample->bid}, &al))
 		dso__set_hit(map__dso(al.map));
 
 	addr_location__exit(&al);
diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 74213daf8786..dc31047149e3 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -241,7 +241,9 @@ static size_t print_insn_x86(struct thread *thread, u8 cpumode, struct cs_insn *
 
 		addr_location__init(&al);
 		if (op->type == X86_OP_IMM &&
-		    thread__find_symbol(thread, cpumode, op->imm, &al)) {
+		    thread__find_symbol(thread,
+					&(struct perf_sample){.cpumode = cpumode,
+							      .ip = op->imm}, &al)) {
 			printed += fprintf(fp, "%s ", insn[0].mnemonic);
 			printed += symbol__fprintf_symname_offs(al.sym, &al, fp);
 			if (print_opts & PRINT_INSN_IMM_HEX)
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 114b3cd2da49..a0bfd9aa6dbe 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1152,7 +1152,9 @@ static u32 __cs_etm__mem_access(struct cs_etm_queue *etmq,
 
 	cpumode = cs_etm__cpu_mode(etmq, address, el);
 
-	if (!thread__find_map(thread, cpumode, address, &al))
+	if (!thread__find_map(thread,
+			      &(struct perf_sample){.cpumode = cpumode,
+						    .ip = address}, &al))
 		goto out;
 
 	dso = map__dso(al.map);
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 40888b7c4467..8fa7bfdaadff 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -235,7 +235,9 @@ static int process_sample_event(const struct perf_tool *tool,
 				fputc(',', out);
 
 			addr_location__init(&tal);
-			ok = thread__find_symbol(al.thread, cpumode, ip, &tal);
+			ok = thread__find_symbol(al.thread,
+						 &(struct perf_sample){.cpumode = cpumode,
+								       .ip = ip}, &tal);
 			output_sample_callchain_entry(tool, ip, ok ? &tal : NULL);
 			addr_location__exit(&tal);
 		}
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 6b5ffe81f141..ea88c4942ccb 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -339,7 +339,9 @@ void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size)
 		bool printed = false;
 
 		addr_location__init(&al);
-		if (thread && thread__find_map(thread, PERF_RECORD_MISC_USER, addr, &al)) {
+		if (thread && thread__find_map(thread,
+				       &(struct perf_sample){.cpumode = PERF_RECORD_MISC_USER,
+							     .ip = addr}, &al)) {
 			al.sym = map__find_symbol(al.map, al.addr);
 			if (al.sym) {
 				fprintf(file, "    #%zd %p in %s ", i, stackdump[i], al.sym->name);
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index e11e144af62b..8a33bfe50939 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -177,7 +177,9 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
 		return -1;
 
 	addr_location__init(&al);
-	thread__find_symbol_fb(thread, d->sample->cpumode, address, &al);
+	thread__find_symbol_fb(thread,
+			       &(struct perf_sample){.cpumode = d->sample->cpumode,
+						     .ip = address}, &al);
 
 	al_to_d_al(&al, &d_al);
 
@@ -314,7 +316,9 @@ static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
 
 	addr_location__init(&a);
 
-	thread__find_map_fb(al->thread, d->sample->cpumode, ip, &a);
+	thread__find_map_fb(al->thread,
+			    &(struct perf_sample){.cpumode = d->sample->cpumode,
+						  .ip = ip}, &a);
 	ret = a.map ? code_read(ip, a.map, d->machine, buf, len) : -1;
 
 	addr_location__exit(&a);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c69ae57ce679..982fb9ed049f 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -691,7 +691,7 @@ int perf_event__process(const struct perf_tool *tool __maybe_unused,
 	return machine__process_event(machine, event, sample);
 }
 
-struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
+struct map *thread__find_map(struct thread *thread, struct perf_sample *sample,
 			     struct addr_location *al)
 {
 	struct maps *maps = thread__maps(thread);
@@ -702,34 +702,39 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	thread__zput(al->thread);
 	al->thread = thread__get(thread);
 
-	al->addr = addr;
-	al->cpumode = cpumode;
+	if (sample->ip) {
+		al->addr = sample->ip;
+	} else {
+		pr_debug("Sample missing IP data\n");
+		return NULL;
+	}
+	al->cpumode = sample->cpumode;
 	al->filtered = 0;
 
 	if (machine == NULL)
 		return NULL;
 
-	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
+	if (sample->cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
 		al->level = 'k';
 		maps = machine__kernel_maps(machine);
 		load_map = !symbol_conf.lazy_load_kernel_maps;
-	} else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
+	} else if (sample->cpumode == PERF_RECORD_MISC_USER && perf_host) {
 		al->level = '.';
-	} else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
+	} else if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
 		al->level = 'g';
 		maps = machine__kernel_maps(machine);
 		load_map = !symbol_conf.lazy_load_kernel_maps;
-	} else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
+	} else if (sample->cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
 		al->level = 'u';
 	} else {
 		al->level = 'H';
 
-		if ((cpumode == PERF_RECORD_MISC_GUEST_USER ||
-			cpumode == PERF_RECORD_MISC_GUEST_KERNEL) &&
+		if ((sample->cpumode == PERF_RECORD_MISC_GUEST_USER ||
+			sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL) &&
 			!perf_guest)
 			al->filtered |= (1 << HIST_FILTER__GUEST);
-		if ((cpumode == PERF_RECORD_MISC_USER ||
-			cpumode == PERF_RECORD_MISC_KERNEL) &&
+		if ((sample->cpumode == PERF_RECORD_MISC_USER ||
+			sample->cpumode == PERF_RECORD_MISC_KERNEL) &&
 			!perf_host)
 			al->filtered |= (1 << HIST_FILTER__HOST);
 
@@ -754,33 +759,34 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
  * because it applies only to the sample 'ip' and not necessary to 'addr' or
  * branch stack addresses. If possible, use a fallback to deal with those cases.
  */
-struct map *thread__find_map_fb(struct thread *thread, u8 cpumode, u64 addr,
+struct map *thread__find_map_fb(struct thread *thread, struct perf_sample *sample,
 				struct addr_location *al)
 {
-	struct map *map = thread__find_map(thread, cpumode, addr, al);
+	struct map *map = thread__find_map(thread, sample, al);
 	struct machine *machine = maps__machine(thread__maps(thread));
-	u8 addr_cpumode = machine__addr_cpumode(machine, cpumode, addr);
+	u8 addr_cpumode = machine__addr_cpumode(machine, sample->cpumode, sample->ip);
 
-	if (map || addr_cpumode == cpumode)
+	if (map || addr_cpumode == sample->cpumode)
 		return map;
 
-	return thread__find_map(thread, addr_cpumode, addr, al);
+	sample->cpumode = addr_cpumode;
+	return thread__find_map(thread, sample, al);
 }
 
-struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
-				   u64 addr, struct addr_location *al)
+struct symbol *thread__find_symbol(struct thread *thread, struct perf_sample *sample,
+				   struct addr_location *al)
 {
 	al->sym = NULL;
-	if (thread__find_map(thread, cpumode, addr, al))
+	if (thread__find_map(thread, sample, al))
 		al->sym = map__find_symbol(al->map, al->addr);
 	return al->sym;
 }
 
-struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
-				      u64 addr, struct addr_location *al)
+struct symbol *thread__find_symbol_fb(struct thread *thread, struct perf_sample *sample,
+				      struct addr_location *al)
 {
 	al->sym = NULL;
-	if (thread__find_map_fb(thread, cpumode, addr, al))
+	if (thread__find_map_fb(thread, sample, al))
 		al->sym = map__find_symbol(al->map, al->addr);
 	return al->sym;
 }
@@ -816,7 +822,10 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 		return -1;
 
 	dump_printf(" ... thread: %s:%d\n", thread__comm_str(thread), thread__tid(thread));
-	thread__find_map(thread, sample->cpumode, sample->ip, al);
+	thread__find_map(thread,
+			 &(struct perf_sample){.cpumode = sample->cpumode,
+					       .ip = sample->ip,
+					       .bid = sample->bid}, al);
 	dso = al->map ? map__dso(al->map) : NULL;
 	dump_printf(" ...... dso: %s\n",
 		dso
@@ -934,7 +943,9 @@ bool sample_addr_correlates_sym(struct perf_event_attr *attr)
 void thread__resolve(struct thread *thread, struct addr_location *al,
 		     struct perf_sample *sample)
 {
-	thread__find_map_fb(thread, sample->cpumode, sample->addr, al);
+	thread__find_map_fb(thread,
+			    &(struct perf_sample){.cpumode = sample->cpumode,
+						  .ip = sample->addr}, al);
 
 	al->cpu = sample->cpu;
 	al->sym = NULL;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 9d6628169fd9..228af524e9ce 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -812,7 +812,9 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 	while (1) {
 		struct dso *dso;
 
-		if (!thread__find_map(thread, cpumode, *ip, &al) || !map__dso(al.map)) {
+		if (!thread__find_map(thread,
+				      &(struct perf_sample){.cpumode = cpumode,
+							    .ip = *ip}, &al) || !map__dso(al.map)) {
 			if (al.map)
 				intel_pt_log("ERROR: thread has no dso for %#" PRIx64 "\n", *ip);
 			else
@@ -1007,7 +1009,9 @@ static int __intel_pt_pgd_ip(uint64_t ip, void *data)
 		return -EINVAL;
 
 	addr_location__init(&al);
-	if (!thread__find_map(thread, cpumode, ip, &al) || !map__dso(al.map))
+	if (!thread__find_map(thread,
+			      &(struct perf_sample){.cpumode = cpumode,
+						    .ip = ip}, &al) || !map__dso(al.map))
 		return -EINVAL;
 
 	offset = map__map_ip(al.map, ip);
@@ -3656,7 +3660,9 @@ static int intel_pt_find_map(struct thread *thread, u8 cpumode, u64 addr,
 			     struct addr_location *al)
 {
 	if (!al->map || addr < map__start(al->map) || addr >= map__end(al->map)) {
-		if (!thread__find_map(thread, cpumode, addr, al))
+		if (!thread__find_map(thread,
+				      &(struct perf_sample){.cpumode = cpumode,
+							    .ip = addr}, al))
 			return -1;
 	}
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 21d54ebc866b..aeace492b4e7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2072,7 +2072,9 @@ static void ip__resolve_ams(struct thread *thread,
 	 * Thus, we have to try consecutively until we find a match
 	 * or else, the symbol is unknown
 	 */
-	thread__find_cpumode_addr_location(thread, ip, /*symbols=*/true, &al);
+	thread__find_cpumode_addr_location(thread,
+					   &(struct perf_sample){.ip = ip},
+					   /*symbols=*/true, &al);
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
@@ -2093,7 +2095,7 @@ static void ip__resolve_data(struct thread *thread,
 
 	addr_location__init(&al);
 
-	thread__find_symbol(thread, m, addr, &al);
+	thread__find_symbol(thread, &(struct perf_sample){.cpumode = m, .ip = addr}, &al);
 
 	ams->addr = addr;
 	ams->al_addr = al.addr;
@@ -2227,7 +2229,9 @@ static int add_callchain_ip(struct thread *thread,
 	al.sym = NULL;
 	al.srcline = NULL;
 	if (!cpumode) {
-		thread__find_cpumode_addr_location(thread, ip, symbols, &al);
+		thread__find_cpumode_addr_location(thread,
+					   &(struct perf_sample){.ip = ip},
+					   symbols, &al);
 	} else {
 		if (ip >= PERF_CONTEXT_MAX) {
 			switch (ip) {
@@ -2255,9 +2259,13 @@ static int add_callchain_ip(struct thread *thread,
 			goto out;
 		}
 		if (symbols)
-			thread__find_symbol(thread, *cpumode, ip, &al);
+			thread__find_symbol(thread,
+				    &(struct perf_sample){.cpumode = *cpumode, .ip = ip},
+				    &al);
 		else
-			thread__find_map(thread, *cpumode, ip, &al);
+			thread__find_map(thread,
+				 &(struct perf_sample){.cpumode = *cpumode, .ip = ip},
+				 &al);
 	}
 
 	if (al.sym != NULL) {
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index d35190052d97..8857faf445cb 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -808,7 +808,10 @@ static PyObject *pyrf_sample_event__srccode(PyObject *self, PyObject *args)
 
 	if (addr != pevent->sample.ip) {
 		addr_location__init(&al);
-		thread__find_symbol_fb(pevent->al.thread, pevent->sample.cpumode, addr, &al);
+		thread__find_symbol_fb(pevent->al.thread,
+			       &(struct perf_sample){
+				       .cpumode = pevent->sample.cpumode,
+				       .ip = addr}, &al);
 	} else {
 		addr_location__init(&al);
 		al.thread = thread__get(pevent->al.thread);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 8f832ae316ca..8f7512c889a7 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -520,14 +520,16 @@ static PyObject *python_process_brstack(struct perf_sample *sample,
 		    PyLong_FromUnsignedLongLong(entries[i].flags.cycles));
 
 		addr_location__init(&al);
-		thread__find_map_fb(thread, sample->cpumode,
-				    entries[i].from, &al);
+		thread__find_map_fb(thread,
+				    &(struct perf_sample){.cpumode = sample->cpumode,
+							  .ip = entries[i].from}, &al);
 		dsoname = get_dsoname(al.map);
 		pydict_set_item_string_decref(pyelem, "from_dsoname",
 					      _PyUnicode_FromString(dsoname));
 
-		thread__find_map_fb(thread, sample->cpumode,
-				    entries[i].to, &al);
+		thread__find_map_fb(thread,
+				    &(struct perf_sample){.cpumode = sample->cpumode,
+							  .ip = entries[i].to}, &al);
 		dsoname = get_dsoname(al.map);
 		pydict_set_item_string_decref(pyelem, "to_dsoname",
 					      _PyUnicode_FromString(dsoname));
@@ -593,14 +595,16 @@ static PyObject *python_process_brstacksym(struct perf_sample *sample,
 		if (!pyelem)
 			Py_FatalError("couldn't create Python dictionary");
 
-		thread__find_symbol_fb(thread, sample->cpumode,
-				       entries[i].from, &al);
+		thread__find_symbol_fb(thread,
+				       &(struct perf_sample){.cpumode = sample->cpumode,
+							     .ip = entries[i].from}, &al);
 		get_symoff(al.sym, &al, true, bf, sizeof(bf));
 		pydict_set_item_string_decref(pyelem, "from",
 					      _PyUnicode_FromString(bf));
 
-		thread__find_symbol_fb(thread, sample->cpumode,
-				       entries[i].to, &al);
+		thread__find_symbol_fb(thread,
+				       &(struct perf_sample){.cpumode = sample->cpumode,
+							     .ip = entries[i].to}, &al);
 		get_symoff(al.sym, &al, true, bf, sizeof(bf));
 		pydict_set_item_string_decref(pyelem, "to",
 					      _PyUnicode_FromString(bf));
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index e483ffcb5d93..e79b2c0dd5d5 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -413,7 +413,7 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bo
 	return thread__clone_maps(thread, parent, do_maps_clone);
 }
 
-void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
+void thread__find_cpumode_addr_location(struct thread *thread, struct perf_sample *sample,
 					bool symbols, struct addr_location *al)
 {
 	size_t i;
@@ -425,10 +425,11 @@ void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 	};
 
 	for (i = 0; i < ARRAY_SIZE(cpumodes); i++) {
+		sample->cpumode = cpumodes[i];
 		if (symbols)
-			thread__find_symbol(thread, cpumodes[i], addr, al);
+			thread__find_symbol(thread, sample, al);
 		else
-			thread__find_map(thread, cpumodes[i], addr, al);
+			thread__find_map(thread, sample, al);
 
 		if (al->map)
 			break;
@@ -581,6 +582,7 @@ int thread__memcpy(struct thread *thread, struct machine *machine,
 		   void *buf, u64 ip, int len, bool *is64bit)
 {
 	u8 cpumode = PERF_RECORD_MISC_USER;
+	struct perf_sample sample = { .ip = ip };
 	struct addr_location al;
 	struct dso *dso;
 	long offset;
@@ -589,7 +591,8 @@ int thread__memcpy(struct thread *thread, struct machine *machine,
 		cpumode = PERF_RECORD_MISC_KERNEL;
 
 	addr_location__init(&al);
-	if (!thread__find_map(thread, cpumode, ip, &al)) {
+	sample.cpumode = cpumode;
+	if (!thread__find_map(thread, &sample, &al)) {
 		addr_location__exit(&al);
 		return -1;
 	}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index d82fce8173ae..f0c50eafeee5 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -124,17 +124,17 @@ size_t thread__fprintf(struct thread *thread, FILE *fp);
 
 struct thread *thread__main_thread(struct machine *machine, struct thread *thread);
 
-struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
+struct map *thread__find_map(struct thread *thread, struct perf_sample *sample,
 			     struct addr_location *al);
-struct map *thread__find_map_fb(struct thread *thread, u8 cpumode, u64 addr,
+struct map *thread__find_map_fb(struct thread *thread, struct perf_sample *sample,
 				struct addr_location *al);
 
-struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
-				   u64 addr, struct addr_location *al);
-struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
-				      u64 addr, struct addr_location *al);
+struct symbol *thread__find_symbol(struct thread *thread, struct perf_sample *sample,
+				   struct addr_location *al);
+struct symbol *thread__find_symbol_fb(struct thread *thread, struct perf_sample *sample,
+				      struct addr_location *al);
 
-void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
+void thread__find_cpumode_addr_location(struct thread *thread, struct perf_sample *sample,
 					bool symbols, struct addr_location *al);
 
 int thread__memcpy(struct thread *thread, struct machine *machine,
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 63a5c2253174..10779a0c793e 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -77,7 +77,9 @@ static int __report_module(struct addr_location *al, u64 ip,
 	 * Some callers will use al->sym, so we can't just use the
 	 * cheaper thread__find_map() here.
 	 */
-	thread__find_symbol(ui->thread, PERF_RECORD_MISC_USER, ip, al);
+	thread__find_symbol(ui->thread,
+			    &(struct perf_sample){.cpumode = PERF_RECORD_MISC_USER, .ip = ip},
+			    al);
 
 	if (al->map)
 		dso = map__dso(al->map);
@@ -203,12 +205,13 @@ static bool get_thread(Dwfl *dwfl __maybe_unused, pid_t tid, void *arg,
 static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
 			  Dwarf_Word *data)
 {
+	struct perf_sample sample = { .cpumode = PERF_RECORD_MISC_USER, .ip = addr };
 	struct addr_location al;
 	ssize_t size;
 	struct dso *dso;
 
 	addr_location__init(&al);
-	if (!thread__find_map(ui->thread, PERF_RECORD_MISC_USER, addr, &al)) {
+	if (!thread__find_map(ui->thread, &sample, &al)) {
 		pr_debug("unwind: no map for %lx\n", (unsigned long)addr);
 		goto out_fail;
 	}
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 73d191ce51a5..5d9f9002710a 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -351,7 +351,9 @@ static struct map *find_map(uint64_t ip, struct unwind_info *ui)
 	struct map *ret;
 
 	addr_location__init(&al);
-	thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
+	thread__find_map(ui->thread,
+			 &(struct perf_sample){.cpumode = PERF_RECORD_MISC_USER, .ip = ip},
+			 &al);
 	ret = map__get(al.map);
 	addr_location__exit(&al);
 	return ret;
@@ -596,7 +598,9 @@ static int entry(uint64_t ip, struct thread *thread, unwind_entry_cb_t cb, void
 	int ret;
 
 	addr_location__init(&al);
-	e.ms.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
+	e.ms.sym = thread__find_symbol(thread,
+				       &(struct perf_sample){.cpumode = PERF_RECORD_MISC_USER,
+							     .ip = ip}, &al);
 	e.ip     = ip;
 	e.ms.map = al.map;
 	e.ms.thread = thread__get(al.thread);
-- 
2.55.0.679.g6767b8d81c-goog

