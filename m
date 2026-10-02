Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF564B8296
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962773; cv=none; b=giSGtNY8CJz0yLuAzlfkCE4m13KOvyOSGiiwYU+UbvImC9oCJy5+nURIqN9aL9P6W6BfN1ZOFJwjuEkt6dxT8e4pIRKQhvixu/eTuhXRMfd+wsPjwUJj+e0I7RDXFkfemVxLv/kqa9cImZeEyLidh5RqlHpH33MuC9CGMMxq590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962773; c=relaxed/simple;
	bh=xvpaUz4B3bDmJ8mp3NbbbkWxfiCH0sSgdPy2CH2zBbg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aE9jQdozp7v1j4hKz6zxu85ugyVS6HWZi0v+a77wdVEjw48gofZS3Nv2dqK2kV1zcHdAEG12k76z0XPKW+k/d3Eph7mwYfEJyrJCjdRLRxR703igk6JTlAm10PmhcJJ1LUKPoAmWjhSN7NvXJhtWbrl4O1eQErSt89u7tplSpjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dFrjyW40; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFrjyW40"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3510a481ae9so792057eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 10:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790962759; x=1791567559; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FiRedINEl1Qq/ylBeM4HgVFBA243D1uRumj3a6WIf5g=;
        b=dFrjyW40pFon4RdW7ep7Gkq4cETVZ/PelsWTdpI9OWkppvZ3jmENiEOHtyAq07Kpt4
         cOwXmcJTtLPIPPxj7l9bMenjy1Kts9WTCMkmg/bdBIccWGZ+IUqQn9Yud4EIIM6jHGuQ
         Xx3LXZfF5UrTVBwCVRc78wTdiaWTEqszA89XdPiHUXHcZ54HW9mpx1dGFgT/5xytTcXS
         VgF0u9XjNN6UkgZpf+gY2VfFV7CqbewENzv1y+MU23puJ1++SA7HBlgyYI24b92gqemu
         fLL71lU1eGr7wOmojFS715PoegjDne1gdSbo5pWgFVP5o7H2YS1FWDipeEppde78DytX
         3iYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790962759; x=1791567559;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FiRedINEl1Qq/ylBeM4HgVFBA243D1uRumj3a6WIf5g=;
        b=XipGc/KSMW0poq3WUVasOsInDzUPU6yO6eNM6Z/B2nzPMXbfNQHRK4HF/0nownDADV
         RmTvYd77N68YGJ7POghbvE8dEltl2kWu5W1cPMQGKyW0lGa3ml0rTGsGJpAn39BwdqmW
         E+cyNufXDuefNp9ym6Hi788nRfnxprTtLWWELOnwVJSJTJOjz3AjQZSoy1PhxJL4EJNW
         N49GXts2d6aYfllxUEE2EsPjcFpXAh9tCg8nLPocVKmzso5CR3tpgjcP8qt0GhiZz/jn
         l+G8dy0yHKMowSxdTCWnQ+ofn0EzKkUfu+/BBMZZygTiQYcVRGpwsjtI6UOZ9vThcv/r
         vMZg==
X-Forwarded-Encrypted: i=1; AKwUvBzkb76pAf362ZZVFKPBzRVhCIWq3Y5d8mthJeyJnCh/FJf8CUhdECJiumSSURz7EFILSgyJwcj146IkZLu9w4x/@vger.kernel.org
X-Gm-Message-State: AFuF++mcgBoWWuyQ8XHqP5xhi1CbBM35/Fwz6ARF+XZ8AqYXLs6fyusq
	5B3u7uY8+BTRRjdlJHaJkMySQ3GNg3Qd6zLcwPmP+KNcJBaxK5dx7a0WeZdVNskHJIX+7kggTXY
	0Za3RpYb0JA==
X-Received: from dlbvv15.prod.google.com ([2002:a05:7022:5f0f:b0:14b:4891:4b9e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:304:b0:14a:51c8:e9f2
 with SMTP id a92af1059eb24-14f5c2ef7bfmr5648977c88.31.1790962758704; Fri, 02
 Oct 2026 10:39:18 -0700 (PDT)
Date: Fri,  2 Oct 2026 10:38:37 -0700
In-Reply-To: <20261002173848.3228217-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424061943.1321025-1-irogers@google.com> <20261002173848.3228217-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002173848.3228217-5-irogers@google.com>
Subject: [PATCH v2 4/8] perf: Refactor thread map and symbol APIs to take perf_sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Cc: ak@linux.intel.com, alexander.shishkin@linux.intel.com, 
	atrajeev@linux.ibm.com, dvyukov@google.com, fzczx123@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, kjain@linux.ibm.com, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, lihuafei1@huawei.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, m.liska@foxlink.cz, mark.rutland@arm.com, 
	martin.liska@hey.com, mpetlan@redhat.com, quic_zhonhan@quicinc.com, 
	scclevenger@os.amperecomputing.com, sesse@google.com, 
	stephen.s.brennan@oracle.com, thomas.falcon@intel.com, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"

Refactor thread__find_map and thread__find_symbol family of APIs to
take a struct perf_sample * instead of cpumode and addr. This prepares
for looking up symbols using build ID and offset, which is contained in
the sample payload instead of the address.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/powerpc/util/skip-callchain-idx.c    |  4 +-
 tools/perf/builtin-inject.c                   |  2 +-
 tools/perf/builtin-script.c                   | 40 +++++++++++----
 tools/perf/builtin-timechart.c                |  5 +-
 tools/perf/builtin-trace.c                    | 10 ++--
 tools/perf/tests/code-reading.c               |  4 +-
 tools/perf/tests/mmap-thread-lookup.c         |  9 +++-
 tools/perf/util/annotate-data.c               |  5 +-
 tools/perf/util/aslr.c                        | 16 ++++--
 tools/perf/util/build-id.c                    |  2 +-
 tools/perf/util/capstone.c                    |  4 +-
 tools/perf/util/cs-etm.c                      |  4 +-
 tools/perf/util/data-convert-json.c           |  4 +-
 tools/perf/util/debug.c                       |  4 +-
 tools/perf/util/dlfilter.c                    |  8 ++-
 tools/perf/util/event.c                       | 51 ++++++++++---------
 tools/perf/util/intel-pt.c                    | 14 +++--
 tools/perf/util/machine.c                     | 18 +++++--
 tools/perf/util/python.c                      | 18 +++++--
 tools/perf/util/thread.c                      | 11 ++--
 tools/perf/util/thread.h                      | 14 ++---
 tools/perf/util/unwind-libdw.c                |  7 ++-
 tools/perf/util/unwind-libunwind.c            |  8 ++-
 23 files changed, 179 insertions(+), 83 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 472714cfad38..cb29d9eafa89 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -225,7 +225,9 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 	addr_location__init(&al);
 	ip = chain->ips[1];
 
-	thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
+	thread__find_symbol(thread,
+			    &(struct perf_sample){.cpumode = PERF_RECORD_MISC_USER, .ip = ip},
+			    &al);
 
 	if (al.map)
 		dso = map__dso(al.map);
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 67f019acb6c0..42ed367d729f 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -1167,7 +1167,7 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 		goto repipe;
 	}
 
-	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
+	if (thread__find_map(thread, sample, &al)) {
 		mark_dso_hit(inject, tool, sample, machine, args.mmap_evsel, al.map,
 			     /*sample_in_dso=*/true);
 	}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b6691ebb1b4e..99e9e0c60f14 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1063,6 +1063,7 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
+	struct perf_sample br_sample = {};
 	u64 i, from, to;
 	int printed = 0;
 
@@ -1079,8 +1080,12 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 
 			addr_location__init(&alf);
 			addr_location__init(&alt);
-			thread__find_map_fb(thread, sample->cpumode, from, &alf);
-			thread__find_map_fb(thread, sample->cpumode, to, &alt);
+			br_sample.cpumode = sample->cpumode;
+			br_sample.ip = from;
+			thread__find_map_fb(thread, &br_sample, &alf);
+			br_sample.cpumode = sample->cpumode;
+			br_sample.ip = to;
+			thread__find_map_fb(thread, &br_sample, &alt);
 
 			printed += map__fprintf_dsoname_dsoff(alf.map, PRINT_FIELD(DSOFF), alf.addr, fp);
 			printed += fprintf(fp, "/0x%"PRIx64, to);
@@ -1102,6 +1107,7 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
+	struct perf_sample br_sample = {};
 	u64 i, from, to;
 	int printed = 0;
 
@@ -1116,8 +1122,12 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 		from = entries[i].from;
 		to   = entries[i].to;
 
-		thread__find_symbol_fb(thread, sample->cpumode, from, &alf);
-		thread__find_symbol_fb(thread, sample->cpumode, to, &alt);
+		br_sample.cpumode = sample->cpumode;
+		br_sample.ip = from;
+		thread__find_symbol_fb(thread, &br_sample, &alf);
+		br_sample.cpumode = sample->cpumode;
+		br_sample.ip = to;
+		thread__find_symbol_fb(thread, &br_sample, &alt);
 
 		printed += symbol__fprintf_symname_offs(alf.sym, &alf, fp);
 		if (PRINT_FIELD(DSO))
@@ -1140,6 +1150,7 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
+	struct perf_sample br_sample = {};
 	u64 i, from, to;
 	int printed = 0;
 
@@ -1154,11 +1165,15 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 		from = entries[i].from;
 		to   = entries[i].to;
 
-		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
+		br_sample.cpumode = sample->cpumode;
+		br_sample.ip = from;
+		if (thread__find_map_fb(thread, &br_sample, &alf) &&
 		    !dso__adjust_symbols(map__dso(alf.map)))
 			from = map__dso_map_ip(alf.map, from);
 
-		if (thread__find_map_fb(thread, sample->cpumode, to, &alt) &&
+		br_sample.cpumode = sample->cpumode;
+		br_sample.ip = to;
+		if (thread__find_map_fb(thread, &br_sample, &alt) &&
 		    !dso__adjust_symbols(map__dso(alt.map)))
 			to = map__dso_map_ip(alt.map, to);
 
@@ -1216,7 +1231,10 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
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
@@ -1291,7 +1309,7 @@ static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
 	int ret = 0;
 
 	addr_location__init(&al);
-	thread__find_map(thread, cpumode, addr, &al);
+	thread__find_map(thread, &(struct perf_sample){.cpumode = cpumode, .ip = addr}, &al);
 	if (!al.map)
 		goto out;
 	ret = map__fprintf_srccode(al.map, al.addr, stdout,
@@ -1346,7 +1364,9 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 		struct addr_location al;
 
 		addr_location__init(&al);
-		thread__find_map(thread, x->cpumode, ip, &al);
+		thread__find_map(thread,
+			 &(struct perf_sample){.cpumode = x->cpumode,
+					       .ip = ip}, &al);
 		printed += map__fprintf_srcline(al.map, al.addr, " srcline: ", fp);
 		printed += fprintf(fp, "\t");
 		addr_location__exit(&al);
@@ -1406,7 +1426,7 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 	int off, printed = 0, ret = 0;
 
 	addr_location__init(&al);
-	thread__find_map(thread, cpumode, addr, &al);
+	thread__find_map(thread, &(struct perf_sample){.cpumode = cpumode, .ip = addr}, &al);
 
 	if ((*lastsym) && al.addr >= (*lastsym)->start && al.addr < (*lastsym)->end)
 		goto out;
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 3d88c90c6573..745fd04e478a 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -512,6 +512,7 @@ static char *cat_backtrace(struct perf_sample *sample,
 	size_t p_len;
 	u8 cpumode = PERF_RECORD_MISC_USER;
 	struct ip_callchain *chain = sample->callchain;
+	struct perf_sample ip_sample = {};
 	FILE *f = open_memstream(&p, &p_len);
 	bool corrupted = false;
 
@@ -560,7 +561,9 @@ static char *cat_backtrace(struct perf_sample *sample,
 
 		addr_location__init(&tal);
 		tal.filtered = 0;
-		if (thread__find_symbol(al.thread, cpumode, ip, &tal))
+		ip_sample.cpumode = cpumode;
+		ip_sample.ip = ip;
+		if (thread__find_symbol(al.thread, &ip_sample, &tal))
 			fprintf(f, "..... %016" PRIx64 " %s\n", ip, tal.sym->name);
 		else
 			fprintf(f, "..... %016" PRIx64 "\n", ip);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d327603ae454..15b73580c5c2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3700,7 +3700,7 @@ static int trace__pgfault(struct trace *trace,
 	if (trace->summary_only)
 		goto out;
 
-	thread__find_symbol(thread, sample->cpumode, sample->ip, &al);
+	thread__find_symbol(thread, sample, &al);
 
 	trace__fprintf_entry_head(trace, thread, 0, true, sample->time,
 				  sample->cpu, trace->output);
@@ -3713,10 +3713,14 @@ static int trace__pgfault(struct trace *trace,
 
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
index c50b526f44fb..f339e2157dfc 100644
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
index 19a6ecd67f28..b53dcb11bbb0 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -848,8 +848,9 @@ bool get_global_var_info(struct data_loc_info *dloc, u64 addr,
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
index e365f807b021..acda28a6fd2d 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -155,7 +155,9 @@ static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
 		return 0; /* No thread. */
 
 	addr_location__init(&al);
-	if (!thread__find_map(aslr_thread, cpumode, addr, &al)) {
+	if (!thread__find_map(aslr_thread,
+			      &(struct perf_sample){.cpumode = cpumode, .ip = addr},
+			      &al)) {
 		/*
 		 * If lookup fails with specified cpumode, try fallback to the other space
 		 * to be robust against bad cpumode in samples.
@@ -169,7 +171,9 @@ static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
 		else if (cpumode == PERF_RECORD_MISC_GUEST_USER)
 			effective_cpumode = PERF_RECORD_MISC_GUEST_KERNEL;
 
-		if (!thread__find_map(aslr_thread, effective_cpumode, addr, &al)) {
+		if (!thread__find_map(aslr_thread,
+				      &(struct perf_sample){.cpumode = effective_cpumode,
+							    .ip = addr}, &al)) {
 			addr_location__exit(&al);
 			return 0; /* No mmap. */
 		}
@@ -286,7 +290,9 @@ static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
 	remap_key.pid = (cpumode == PERF_RECORD_MISC_KERNEL ||
 			 cpumode == PERF_RECORD_MISC_GUEST_KERNEL) ?
 			kernel_pid : thread__pid(aslr_thread);
-	if (thread__find_map(aslr_thread, cpumode, start, &al)) {
+	if (thread__find_map(aslr_thread,
+			     &(struct perf_sample){.cpumode = cpumode, .ip = start},
+			     &al)) {
 		struct dso *dso = map__dso(al.map);
 		const char *dso_name = dso ? dso__long_name(dso) : NULL;
 
@@ -343,7 +349,9 @@ static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
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
index 02233ef0eaff..6c0d33b1609d 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -69,7 +69,7 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 	}
 
 	addr_location__init(&al);
-	if (thread__find_map(thread, sample->cpumode, sample->ip, &al))
+	if (thread__find_map(thread, sample, &al))
 		dso__set_hit(map__dso(al.map));
 
 	addr_location__exit(&al);
diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 95881f15324a..fbad96e1e6a9 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -252,7 +252,9 @@ static size_t print_insn_x86(struct thread *thread, u8 cpumode, struct cs_insn *
 
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
index 2d1ab34f7b6b..31a11b802c1e 100644
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
index b7095519419e..2f31b3663ec1 100644
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
index c69ae57ce679..cd13a0c3cb52 100644
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
@@ -702,34 +702,34 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	thread__zput(al->thread);
 	al->thread = thread__get(thread);
 
-	al->addr = addr;
-	al->cpumode = cpumode;
+	al->addr = sample->ip;
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
 
@@ -754,33 +754,34 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
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
@@ -816,7 +817,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 		return -1;
 
 	dump_printf(" ... thread: %s:%d\n", thread__comm_str(thread), thread__tid(thread));
-	thread__find_map(thread, sample->cpumode, sample->ip, al);
+	thread__find_map(thread, sample, al);
 	dso = al->map ? map__dso(al->map) : NULL;
 	dump_printf(" ...... dso: %s\n",
 		dso
@@ -934,7 +935,9 @@ bool sample_addr_correlates_sym(struct perf_event_attr *attr)
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
index 8c21c9f52d57..243c252276ad 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -752,6 +752,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 {
 	struct intel_pt_queue *ptq = data;
 	struct machine *machine = ptq->pt->machine;
+	struct perf_sample sample = {};
 	struct thread *thread;
 	struct addr_location al;
 	unsigned char buf[INTEL_PT_INSN_BUF_SZ];
@@ -809,10 +810,13 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 		}
 	}
 
+	sample.cpumode = cpumode;
+
 	while (1) {
 		struct dso *dso;
 
-		if (!thread__find_map(thread, cpumode, *ip, &al) || !map__dso(al.map)) {
+		sample.ip = *ip;
+		if (!thread__find_map(thread, &sample, &al) || !map__dso(al.map)) {
 			if (al.map)
 				intel_pt_log("ERROR: thread has no dso for %#" PRIx64 "\n", *ip);
 			else
@@ -1007,7 +1011,9 @@ static int __intel_pt_pgd_ip(uint64_t ip, void *data)
 		return -EINVAL;
 
 	addr_location__init(&al);
-	if (!thread__find_map(thread, cpumode, ip, &al) || !map__dso(al.map))
+	if (!thread__find_map(thread,
+			      &(struct perf_sample){.cpumode = cpumode,
+						    .ip = ip}, &al) || !map__dso(al.map))
 		return -EINVAL;
 
 	offset = map__map_ip(al.map, ip);
@@ -3656,7 +3662,9 @@ static int intel_pt_find_map(struct thread *thread, u8 cpumode, u64 addr,
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
index 4bcb16da6481..1a13253d0c7f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2064,6 +2064,7 @@ static void ip__resolve_ams(struct thread *thread,
 			    struct addr_map_symbol *ams,
 			    u64 ip)
 {
+	static __thread struct perf_sample sample;
 	struct addr_location al;
 
 	addr_location__init(&al);
@@ -2074,7 +2075,8 @@ static void ip__resolve_ams(struct thread *thread,
 	 * Thus, we have to try consecutively until we find a match
 	 * or else, the symbol is unknown
 	 */
-	thread__find_cpumode_addr_location(thread, ip, /*symbols=*/true, &al);
+	sample.ip = ip;
+	thread__find_cpumode_addr_location(thread, &sample, /*symbols=*/true, &al);
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
@@ -2091,11 +2093,14 @@ static void ip__resolve_data(struct thread *thread,
 			     u8 m, struct addr_map_symbol *ams,
 			     u64 addr, u64 phys_addr, u64 daddr_page_size)
 {
+	static __thread struct perf_sample sample;
 	struct addr_location al;
 
 	addr_location__init(&al);
 
-	thread__find_symbol(thread, m, addr, &al);
+	sample.cpumode = m;
+	sample.ip = addr;
+	thread__find_symbol(thread, &sample, &al);
 
 	ams->addr = addr;
 	ams->al_addr = al.addr;
@@ -2218,6 +2223,7 @@ static int add_callchain_ip(struct thread *thread,
 			    u64 branch_from,
 			    bool symbols)
 {
+	static __thread struct perf_sample sample;
 	struct map_symbol ms = {};
 	struct addr_location al;
 	int nr_loop_iter = 0, err = 0;
@@ -2228,8 +2234,9 @@ static int add_callchain_ip(struct thread *thread,
 	al.filtered = 0;
 	al.sym = NULL;
 	al.srcline = NULL;
+	sample.ip = ip;
 	if (!cpumode) {
-		thread__find_cpumode_addr_location(thread, ip, symbols, &al);
+		thread__find_cpumode_addr_location(thread, &sample, symbols, &al);
 	} else {
 		if (ip >= PERF_CONTEXT_MAX) {
 			switch (ip) {
@@ -2256,10 +2263,11 @@ static int add_callchain_ip(struct thread *thread,
 			}
 			goto out;
 		}
+		sample.cpumode = *cpumode;
 		if (symbols)
-			thread__find_symbol(thread, *cpumode, ip, &al);
+			thread__find_symbol(thread, &sample, &al);
 		else
-			thread__find_map(thread, *cpumode, ip, &al);
+			thread__find_map(thread, &sample, &al);
 	}
 
 	if (al.sym != NULL) {
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cc9257e2cceb..a1f156fadc44 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -851,7 +851,10 @@ static PyObject *pyrf_sample_event__srccode(PyObject *self, PyObject *args)
 
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
@@ -1242,8 +1245,12 @@ static int pyrf_sample_event__resolve_addr_al(struct pyrf_event *pevent,
 	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.thread)
 		return -1;
 
-	thread__find_symbol_fb(pevent->al.thread, pevent->sample.cpumode,
-			       pevent->sample.addr, addr_al);
+	thread__find_symbol_fb(pevent->al.thread,
+			       &(struct perf_sample){
+				       .cpumode = pevent->sample.cpumode,
+				       .ip = pevent->sample.addr,
+			       },
+			       addr_al);
 	return 0;
 }
 
@@ -4363,6 +4370,7 @@ static PyObject *pyrf_call_path__to_callchain(const struct call_path *cp,
 					      struct thread *thread)
 {
 	struct pyrf_callchain *pchain;
+	struct perf_sample sample = {};
 	const struct call_path *pos;
 	u64 nr_frames = 0;
 
@@ -4395,7 +4403,9 @@ static PyObject *pyrf_call_path__to_callchain(const struct call_path *cp,
 						    : PERF_RECORD_MISC_USER;
 
 			addr_location__init(&al);
-			thread__find_map(thread, cpumode, pos->ip, &al);
+			sample.cpumode = cpumode;
+			sample.ip = pos->ip;
+			thread__find_map(thread, &sample, &al);
 			frame->map = map__get(al.map);
 			if (frame->map)
 				frame->sym = pos->sym;
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 91118c301913..ad3f1ae8a92e 100644
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
@@ -579,6 +580,7 @@ int thread__memcpy(struct thread *thread, struct machine *machine,
 		   void *buf, u64 ip, int len, bool *is64bit)
 {
 	u8 cpumode = PERF_RECORD_MISC_USER;
+	struct perf_sample sample = { .ip = ip };
 	struct addr_location al;
 	struct dso *dso;
 	long offset;
@@ -587,7 +589,8 @@ int thread__memcpy(struct thread *thread, struct machine *machine,
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
index d49901b1571e..855faa54c0cf 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -82,7 +82,9 @@ static int __report_module(struct addr_location *al, u64 ip,
 	 * Some callers will use al->sym, so we can't just use the
 	 * cheaper thread__find_map() here.
 	 */
-	thread__find_symbol(ui->thread, PERF_RECORD_MISC_USER, ip, al);
+	thread__find_symbol(ui->thread,
+			    &(struct perf_sample){.cpumode = PERF_RECORD_MISC_USER, .ip = ip},
+			    al);
 
 	if (al->map)
 		dso = map__dso(al->map);
@@ -208,13 +210,14 @@ static bool get_thread(Dwfl *dwfl __maybe_unused, pid_t tid, void *arg,
 static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
 			  Dwarf_Word *data, size_t len)
 {
+	struct perf_sample sample = { .cpumode = PERF_RECORD_MISC_USER, .ip = addr };
 	struct addr_location al;
 	union u64_swap u;
 	ssize_t size;
 	struct dso *dso;
 
 	addr_location__init(&al);
-	if (!thread__find_map(ui->thread, PERF_RECORD_MISC_USER, addr, &al)) {
+	if (!thread__find_map(ui->thread, &sample, &al)) {
 		pr_debug("unwind: no map for %lx\n", (unsigned long)addr);
 		goto out_fail;
 	}
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 6052383e862b..83f043f266da 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -370,7 +370,9 @@ static struct map *find_map(uint64_t ip, struct unwind_info *ui)
 	struct map *ret;
 
 	addr_location__init(&al);
-	thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
+	thread__find_map(ui->thread,
+			 &(struct perf_sample){.cpumode = PERF_RECORD_MISC_USER, .ip = ip},
+			 &al);
 	ret = map__get(al.map);
 	addr_location__exit(&al);
 	return ret;
@@ -626,7 +628,9 @@ static int entry(uint64_t ip, struct thread *thread, unwind_entry_cb_t cb, void
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
2.56.0.rc1.315.gc6ed9934b7-goog

