From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/24] perf script: Use fprintf like printing uniformly
Date: Mon, 23 Oct 2017 20:47:32 -0300
Message-ID: <20171023234736.5335-21-acme@kernel.org>
References: <20171023234736.5335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023234736.5335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, yuzhoujian <yuzhoujian@didichuxing.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We've been mixing print() with fprintf() style printing for a while, but
now we need to use fprintf() like syntax uniformly as a preparatory
patch for supporting printing to different files, one per event.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: yuzhoujian <yuzhoujian@didichuxing.com>
Link: http://lkml.kernel.org/n/tip-kv5z3v8ptfghbarv3a9usvin@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 491 +++++++++++++++++++++++---------------------
 1 file changed, 259 insertions(+), 232 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5a7dfc5691a1..3e83f4735b21 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -500,69 +500,76 @@ static int perf_session__check_output_opt(struct perf_session *session)
 	return 0;
 }
 
-static void print_sample_iregs(struct perf_sample *sample,
-			  struct perf_event_attr *attr)
+static int perf_sample__fprintf_iregs(struct perf_sample *sample,
+				      struct perf_event_attr *attr, FILE *fp)
 {
 	struct regs_dump *regs = &sample->intr_regs;
 	uint64_t mask = attr->sample_regs_intr;
 	unsigned i = 0, r;
+	int printed = 0;
 
 	if (!regs)
-		return;
+		return 0;
 
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
-		printf("%5s:0x%"PRIx64" ", perf_reg_name(r), val);
+		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
+
+	return printed;
 }
 
-static void print_sample_uregs(struct perf_sample *sample,
-			  struct perf_event_attr *attr)
+static int perf_sample__fprintf_uregs(struct perf_sample *sample,
+				      struct perf_event_attr *attr, FILE *fp)
 {
 	struct regs_dump *regs = &sample->user_regs;
 	uint64_t mask = attr->sample_regs_user;
 	unsigned i = 0, r;
+	int printed = 0;
 
 	if (!regs || !regs->regs)
-		return;
+		return 0;
 
-	printf(" ABI:%" PRIu64 " ", regs->abi);
+	printed += fprintf(fp, " ABI:%" PRIu64 " ", regs->abi);
 
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
-		printf("%5s:0x%"PRIx64" ", perf_reg_name(r), val);
+		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
+
+	return printed;
 }
 
-static void print_sample_start(struct perf_sample *sample,
-			       struct thread *thread,
-			       struct perf_evsel *evsel)
+static int perf_sample__fprintf_start(struct perf_sample *sample,
+				      struct thread *thread,
+				      struct perf_evsel *evsel, FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	unsigned long secs;
 	unsigned long long nsecs;
+	int printed = 0;
 
 	if (PRINT_FIELD(COMM)) {
 		if (latency_format)
-			printf("%8.8s ", thread__comm_str(thread));
+			printed += fprintf(fp, "%8.8s ", thread__comm_str(thread));
 		else if (PRINT_FIELD(IP) && symbol_conf.use_callchain)
-			printf("%s ", thread__comm_str(thread));
+			printed += fprintf(fp, "%s ", thread__comm_str(thread));
 		else
-			printf("%16s ", thread__comm_str(thread));
+			printed += fprintf(fp, "%16s ", thread__comm_str(thread));
 	}
 
 	if (PRINT_FIELD(PID) && PRINT_FIELD(TID))
-		printf("%5d/%-5d ", sample->pid, sample->tid);
+		printed += fprintf(fp, "%5d/%-5d ", sample->pid, sample->tid);
 	else if (PRINT_FIELD(PID))
-		printf("%5d ", sample->pid);
+		printed += fprintf(fp, "%5d ", sample->pid);
 	else if (PRINT_FIELD(TID))
-		printf("%5d ", sample->tid);
+		printed += fprintf(fp, "%5d ", sample->tid);
 
 	if (PRINT_FIELD(CPU)) {
 		if (latency_format)
-			printf("%3d ", sample->cpu);
+			printed += fprintf(fp, "%3d ", sample->cpu);
 		else
-			printf("[%03d] ", sample->cpu);
+			printed += fprintf(fp, "[%03d] ", sample->cpu);
 	}
 
 	if (PRINT_FIELD(TIME)) {
@@ -571,13 +578,15 @@ static void print_sample_start(struct perf_sample *sample,
 		nsecs -= secs * NSEC_PER_SEC;
 
 		if (nanosecs)
-			printf("%5lu.%09llu: ", secs, nsecs);
+			printed += fprintf(fp, "%5lu.%09llu: ", secs, nsecs);
 		else {
 			char sample_time[32];
 			timestamp__scnprintf_usec(sample->time, sample_time, sizeof(sample_time));
-			printf("%12s: ", sample_time);
+			printed += fprintf(fp, "%12s: ", sample_time);
 		}
 	}
+
+	return printed;
 }
 
 static inline char
@@ -589,16 +598,17 @@ mispred_str(struct branch_entry *br)
 	return br->flags.predicted ? 'P' : 'M';
 }
 
-static void print_sample_brstack(struct perf_sample *sample,
-				 struct thread *thread,
-				 struct perf_event_attr *attr)
+static int perf_sample__fprintf_brstack(struct perf_sample *sample,
+					struct thread *thread,
+					struct perf_event_attr *attr, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct addr_location alf, alt;
 	u64 i, from, to;
+	int printed = 0;
 
 	if (!(br && br->nr))
-		return;
+		return 0;
 
 	for (i = 0; i < br->nr; i++) {
 		from = br->entries[i].from;
@@ -611,38 +621,41 @@ static void print_sample_brstack(struct perf_sample *sample,
 			thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, to, &alt);
 		}
 
-		printf(" 0x%"PRIx64, from);
+		printed += fprintf(fp, " 0x%"PRIx64, from);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
-			map__fprintf_dsoname(alf.map, stdout);
-			printf(")");
+			printed += fprintf(fp, "(");
+			printed += map__fprintf_dsoname(alf.map, fp);
+			printed += fprintf(fp, ")");
 		}
 
-		printf("/0x%"PRIx64, to);
+		printed += fprintf(fp, "/0x%"PRIx64, to);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
-			map__fprintf_dsoname(alt.map, stdout);
-			printf(")");
+			printed += fprintf(fp, "(");
+			printed += map__fprintf_dsoname(alt.map, fp);
+			printed += fprintf(fp, ")");
 		}
 
-		printf("/%c/%c/%c/%d ",
+		printed += fprintf(fp, "/%c/%c/%c/%d ",
 			mispred_str( br->entries + i),
 			br->entries[i].flags.in_tx? 'X' : '-',
 			br->entries[i].flags.abort? 'A' : '-',
 			br->entries[i].flags.cycles);
 	}
+
+	return printed;
 }
 
-static void print_sample_brstacksym(struct perf_sample *sample,
-				    struct thread *thread,
-				    struct perf_event_attr *attr)
+static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
+					   struct thread *thread,
+					   struct perf_event_attr *attr, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct addr_location alf, alt;
 	u64 i, from, to;
+	int printed = 0;
 
 	if (!(br && br->nr))
-		return;
+		return 0;
 
 	for (i = 0; i < br->nr; i++) {
 
@@ -659,37 +672,40 @@ static void print_sample_brstacksym(struct perf_sample *sample,
 		if (alt.map)
 			alt.sym = map__find_symbol(alt.map, alt.addr);
 
-		symbol__fprintf_symname_offs(alf.sym, &alf, stdout);
+		printed += symbol__fprintf_symname_offs(alf.sym, &alf, fp);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
-			map__fprintf_dsoname(alf.map, stdout);
-			printf(")");
+			printed += fprintf(fp, "(");
+			printed += map__fprintf_dsoname(alf.map, fp);
+			printed += fprintf(fp, ")");
 		}
-		putchar('/');
-		symbol__fprintf_symname_offs(alt.sym, &alt, stdout);
+		printed += fprintf(fp, "%c", '/');
+		printed += symbol__fprintf_symname_offs(alt.sym, &alt, fp);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
-			map__fprintf_dsoname(alt.map, stdout);
-			printf(")");
+			printed += fprintf(fp, "(");
+			printed += map__fprintf_dsoname(alt.map, fp);
+			printed += fprintf(fp, ")");
 		}
-		printf("/%c/%c/%c/%d ",
+		printed += fprintf(fp, "/%c/%c/%c/%d ",
 			mispred_str( br->entries + i),
 			br->entries[i].flags.in_tx? 'X' : '-',
 			br->entries[i].flags.abort? 'A' : '-',
 			br->entries[i].flags.cycles);
 	}
+
+	return printed;
 }
 
-static void print_sample_brstackoff(struct perf_sample *sample,
-				    struct thread *thread,
-				    struct perf_event_attr *attr)
+static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
+					   struct thread *thread,
+					   struct perf_event_attr *attr, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct addr_location alf, alt;
 	u64 i, from, to;
+	int printed = 0;
 
 	if (!(br && br->nr))
-		return;
+		return 0;
 
 	for (i = 0; i < br->nr; i++) {
 
@@ -706,24 +722,26 @@ static void print_sample_brstackoff(struct perf_sample *sample,
 		if (alt.map && !alt.map->dso->adjust_symbols)
 			to = map__map_ip(alt.map, to);
 
-		printf(" 0x%"PRIx64, from);
+		printed += fprintf(fp, " 0x%"PRIx64, from);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
-			map__fprintf_dsoname(alf.map, stdout);
-			printf(")");
+			printed += fprintf(fp, "(");
+			printed += map__fprintf_dsoname(alf.map, fp);
+			printed += fprintf(fp, ")");
 		}
-		printf("/0x%"PRIx64, to);
+		printed += fprintf(fp, "/0x%"PRIx64, to);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
-			map__fprintf_dsoname(alt.map, stdout);
-			printf(")");
+			printed += fprintf(fp, "(");
+			printed += map__fprintf_dsoname(alt.map, fp);
+			printed += fprintf(fp, ")");
 		}
-		printf("/%c/%c/%c/%d ",
+		printed += fprintf(fp, "/%c/%c/%c/%d ",
 			mispred_str(br->entries + i),
 			br->entries[i].flags.in_tx ? 'X' : '-',
 			br->entries[i].flags.abort ? 'A' : '-',
 			br->entries[i].flags.cycles);
 	}
+
+	return printed;
 }
 #define MAXBB 16384UL
 
@@ -789,31 +807,30 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	return len;
 }
 
-static void print_jump(uint64_t ip, struct branch_entry *en,
-		       struct perf_insn *x, u8 *inbuf, int len,
-		       int insn)
+static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
+			    struct perf_insn *x, u8 *inbuf, int len,
+			    int insn, FILE *fp)
 {
-	printf("\t%016" PRIx64 "\t%-30s\t#%s%s%s%s",
-	       ip,
-	       dump_insn(x, ip, inbuf, len, NULL),
-	       en->flags.predicted ? " PRED" : "",
-	       en->flags.mispred ? " MISPRED" : "",
-	       en->flags.in_tx ? " INTX" : "",
-	       en->flags.abort ? " ABORT" : "");
+	int printed = fprintf(fp, "\t%016" PRIx64 "\t%-30s\t#%s%s%s%s", ip,
+			      dump_insn(x, ip, inbuf, len, NULL),
+			      en->flags.predicted ? " PRED" : "",
+			      en->flags.mispred ? " MISPRED" : "",
+			      en->flags.in_tx ? " INTX" : "",
+			      en->flags.abort ? " ABORT" : "");
 	if (en->flags.cycles) {
-		printf(" %d cycles", en->flags.cycles);
+		printed += fprintf(fp, " %d cycles", en->flags.cycles);
 		if (insn)
-			printf(" %.2f IPC", (float)insn / en->flags.cycles);
+			printed += fprintf(fp, " %.2f IPC", (float)insn / en->flags.cycles);
 	}
-	putchar('\n');
+	return printed + fprintf(fp, "\n");
 }
 
-static void print_ip_sym(struct thread *thread, u8 cpumode, int cpu,
-			 uint64_t addr, struct symbol **lastsym,
-			 struct perf_event_attr *attr)
+static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
+			   u8 cpumode, int cpu, struct symbol **lastsym,
+			   struct perf_event_attr *attr, FILE *fp)
 {
 	struct addr_location al;
-	int off;
+	int off, printed = 0;
 
 	memset(&al, 0, sizeof(al));
 
@@ -822,7 +839,7 @@ static void print_ip_sym(struct thread *thread, u8 cpumode, int cpu,
 		thread__find_addr_map(thread, cpumode, MAP__VARIABLE,
 				      addr, &al);
 	if ((*lastsym) && al.addr >= (*lastsym)->start && al.addr < (*lastsym)->end)
-		return;
+		return 0;
 
 	al.cpu = cpu;
 	al.sym = NULL;
@@ -830,37 +847,39 @@ static void print_ip_sym(struct thread *thread, u8 cpumode, int cpu,
 		al.sym = map__find_symbol(al.map, al.addr);
 
 	if (!al.sym)
-		return;
+		return 0;
 
 	if (al.addr < al.sym->end)
 		off = al.addr - al.sym->start;
 	else
 		off = al.addr - al.map->start - al.sym->start;
-	printf("\t%s", al.sym->name);
+	printed += fprintf(fp, "\t%s", al.sym->name);
 	if (off)
-		printf("%+d", off);
-	putchar(':');
+		printed += fprintf(fp, "%+d", off);
+	printed += fprintf(fp, ":");
 	if (PRINT_FIELD(SRCLINE))
-		map__fprintf_srcline(al.map, al.addr, "\t", stdout);
-	putchar('\n');
+		printed += map__fprintf_srcline(al.map, al.addr, "\t", fp);
+	printed += fprintf(fp, "\n");
 	*lastsym = al.sym;
+
+	return printed;
 }
 
-static void print_sample_brstackinsn(struct perf_sample *sample,
-				     struct thread *thread,
-				     struct perf_event_attr *attr,
-				     struct machine *machine)
+static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
+					    struct thread *thread,
+					    struct perf_event_attr *attr,
+					    struct machine *machine, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	u64 start, end;
-	int i, insn, len, nr, ilen;
+	int i, insn, len, nr, ilen, printed = 0;
 	struct perf_insn x;
 	u8 buffer[MAXBB];
 	unsigned off;
 	struct symbol *lastsym = NULL;
 
 	if (!(br && br->nr))
-		return;
+		return 0;
 	nr = br->nr;
 	if (max_blocks && nr > max_blocks + 1)
 		nr = max_blocks + 1;
@@ -868,17 +887,17 @@ static void print_sample_brstackinsn(struct perf_sample *sample,
 	x.thread = thread;
 	x.cpu = sample->cpu;
 
-	putchar('\n');
+	printed += fprintf(fp, "%c", '\n');
 
 	/* Handle first from jump, of which we don't know the entry. */
 	len = grab_bb(buffer, br->entries[nr-1].from,
 			br->entries[nr-1].from,
 			machine, thread, &x.is64bit, &x.cpumode, false);
 	if (len > 0) {
-		print_ip_sym(thread, x.cpumode, x.cpu,
-			     br->entries[nr - 1].from, &lastsym, attr);
-		print_jump(br->entries[nr - 1].from, &br->entries[nr - 1],
-			    &x, buffer, len, 0);
+		printed += ip__fprintf_sym(br->entries[nr - 1].from, thread,
+					   x.cpumode, x.cpu, &lastsym, attr, fp);
+		printed += ip__fprintf_jump(br->entries[nr - 1].from, &br->entries[nr - 1],
+					    &x, buffer, len, 0, fp);
 	}
 
 	/* Print all blocks */
@@ -904,13 +923,13 @@ static void print_sample_brstackinsn(struct perf_sample *sample,
 		for (off = 0;; off += ilen) {
 			uint64_t ip = start + off;
 
-			print_ip_sym(thread, x.cpumode, x.cpu, ip, &lastsym, attr);
+			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 			if (ip == end) {
-				print_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn);
+				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, fp);
 				break;
 			} else {
-				printf("\t%016" PRIx64 "\t%s\n", ip,
-					dump_insn(&x, ip, buffer + off, len - off, &ilen));
+				printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", ip,
+						   dump_insn(&x, ip, buffer + off, len - off, &ilen));
 				if (ilen == 0)
 					break;
 				insn++;
@@ -923,9 +942,9 @@ static void print_sample_brstackinsn(struct perf_sample *sample,
 	 * has not been executed yet.
 	 */
 	if (br->entries[0].from == sample->ip)
-		return;
+		goto out;
 	if (br->entries[0].flags.abort)
-		return;
+		goto out;
 
 	/*
 	 * Print final block upto sample
@@ -933,58 +952,61 @@ static void print_sample_brstackinsn(struct perf_sample *sample,
 	start = br->entries[0].to;
 	end = sample->ip;
 	len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, true);
-	print_ip_sym(thread, x.cpumode, x.cpu, start, &lastsym, attr);
+	printed += ip__fprintf_sym(start, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 	if (len <= 0) {
 		/* Print at least last IP if basic block did not work */
 		len = grab_bb(buffer, sample->ip, sample->ip,
 			      machine, thread, &x.is64bit, &x.cpumode, false);
 		if (len <= 0)
-			return;
+			goto out;
 
-		printf("\t%016" PRIx64 "\t%s\n", sample->ip,
+		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", sample->ip,
 			dump_insn(&x, sample->ip, buffer, len, NULL));
-		return;
+		goto out;
 	}
 	for (off = 0; off <= end - start; off += ilen) {
-		printf("\t%016" PRIx64 "\t%s\n", start + off,
-			dump_insn(&x, start + off, buffer + off, len - off, &ilen));
+		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", start + off,
+				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
 		if (ilen == 0)
 			break;
 	}
+out:
+	return printed;
 }
 
-static void print_sample_addr(struct perf_sample *sample,
-			  struct thread *thread,
-			  struct perf_event_attr *attr)
+static int perf_sample__fprintf_addr(struct perf_sample *sample,
+				     struct thread *thread,
+				     struct perf_event_attr *attr, FILE *fp)
 {
 	struct addr_location al;
-
-	printf("%16" PRIx64, sample->addr);
+	int printed = fprintf(fp, "%16" PRIx64, sample->addr);
 
 	if (!sample_addr_correlates_sym(attr))
-		return;
+		goto out;
 
 	thread__resolve(thread, &al, sample);
 
 	if (PRINT_FIELD(SYM)) {
-		printf(" ");
+		printed += fprintf(fp, " ");
 		if (PRINT_FIELD(SYMOFFSET))
-			symbol__fprintf_symname_offs(al.sym, &al, stdout);
+			printed += symbol__fprintf_symname_offs(al.sym, &al, fp);
 		else
-			symbol__fprintf_symname(al.sym, stdout);
+			printed += symbol__fprintf_symname(al.sym, fp);
 	}
 
 	if (PRINT_FIELD(DSO)) {
-		printf(" (");
-		map__fprintf_dsoname(al.map, stdout);
-		printf(")");
+		printed += fprintf(fp, " (");
+		printed += map__fprintf_dsoname(al.map, fp);
+		printed += fprintf(fp, ")");
 	}
+out:
+	return printed;
 }
 
-static void print_sample_callindent(struct perf_sample *sample,
-				    struct perf_evsel *evsel,
-				    struct thread *thread,
-				    struct addr_location *al)
+static int perf_sample__fprintf_callindent(struct perf_sample *sample,
+					   struct perf_evsel *evsel,
+					   struct thread *thread,
+					   struct addr_location *al, FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	size_t depth = thread_stack__depth(thread);
@@ -1019,12 +1041,12 @@ static void print_sample_callindent(struct perf_sample *sample,
 	}
 
 	if (name)
-		len = printf("%*s%s", (int)depth * 4, "", name);
+		len = fprintf(fp, "%*s%s", (int)depth * 4, "", name);
 	else if (ip)
-		len = printf("%*s%16" PRIx64, (int)depth * 4, "", ip);
+		len = fprintf(fp, "%*s%16" PRIx64, (int)depth * 4, "", ip);
 
 	if (len < 0)
-		return;
+		return len;
 
 	/*
 	 * Try to keep the output length from changing frequently so that the
@@ -1034,39 +1056,46 @@ static void print_sample_callindent(struct perf_sample *sample,
 		spacing = round_up(len + 4, 32);
 
 	if (len < spacing)
-		printf("%*s", spacing - len, "");
+		len += fprintf(fp, "%*s", spacing - len, "");
+
+	return len;
 }
 
-static void print_insn(struct perf_sample *sample,
-		       struct perf_event_attr *attr,
-		       struct thread *thread,
-		       struct machine *machine)
+static int perf_sample__fprintf_insn(struct perf_sample *sample,
+				     struct perf_event_attr *attr,
+				     struct thread *thread,
+				     struct machine *machine, FILE *fp)
 {
+	int printed = 0;
+
 	if (PRINT_FIELD(INSNLEN))
-		printf(" ilen: %d", sample->insn_len);
+		printed += fprintf(fp, " ilen: %d", sample->insn_len);
 	if (PRINT_FIELD(INSN)) {
 		int i;
 
-		printf(" insn:");
+		printed += fprintf(fp, " insn:");
 		for (i = 0; i < sample->insn_len; i++)
-			printf(" %02x", (unsigned char)sample->insn[i]);
+			printed += fprintf(fp, " %02x", (unsigned char)sample->insn[i]);
 	}
 	if (PRINT_FIELD(BRSTACKINSN))
-		print_sample_brstackinsn(sample, thread, attr, machine);
+		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
+
+	return printed;
 }
 
-static void print_sample_bts(struct perf_sample *sample,
-			     struct perf_evsel *evsel,
-			     struct thread *thread,
-			     struct addr_location *al,
-			     struct machine *machine)
+static int perf_sample__fprintf_bts(struct perf_sample *sample,
+				    struct perf_evsel *evsel,
+				    struct thread *thread,
+				    struct addr_location *al,
+				    struct machine *machine, FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	unsigned int type = output_type(attr->type);
 	bool print_srcline_last = false;
+	int printed = 0;
 
 	if (PRINT_FIELD(CALLINDENT))
-		print_sample_callindent(sample, evsel, thread, al);
+		printed += perf_sample__fprintf_callindent(sample, evsel, thread, al, fp);
 
 	/* print branch_from information */
 	if (PRINT_FIELD(IP)) {
@@ -1079,31 +1108,30 @@ static void print_sample_bts(struct perf_sample *sample,
 			cursor = &callchain_cursor;
 
 		if (cursor == NULL) {
-			putchar(' ');
+			printed += fprintf(fp, " ");
 			if (print_opts & EVSEL__PRINT_SRCLINE) {
 				print_srcline_last = true;
 				print_opts &= ~EVSEL__PRINT_SRCLINE;
 			}
 		} else
-			putchar('\n');
+			printed += fprintf(fp, "\n");
 
-		sample__fprintf_sym(sample, al, 0, print_opts, cursor, stdout);
+		printed += sample__fprintf_sym(sample, al, 0, print_opts, cursor, fp);
 	}
 
 	/* print branch_to information */
 	if (PRINT_FIELD(ADDR) ||
 	    ((evsel->attr.sample_type & PERF_SAMPLE_ADDR) &&
 	     !output[type].user_set)) {
-		printf(" => ");
-		print_sample_addr(sample, thread, attr);
+		printed += fprintf(fp, " => ");
+		printed += perf_sample__fprintf_addr(sample, thread, attr, fp);
 	}
 
 	if (print_srcline_last)
-		map__fprintf_srcline(al->map, al->addr, "\n  ", stdout);
-
-	print_insn(sample, attr, thread, machine);
+		printed += map__fprintf_srcline(al->map, al->addr, "\n  ", fp);
 
-	printf("\n");
+	printed += perf_sample__fprintf_insn(sample, attr, thread, machine, fp);
+	return printed + fprintf(fp, "\n");
 }
 
 static struct {
@@ -1126,7 +1154,7 @@ static struct {
 	{0, NULL}
 };
 
-static void print_sample_flags(u32 flags)
+static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 {
 	const char *chars = PERF_IP_FLAG_CHARS;
 	const int n = strlen(PERF_IP_FLAG_CHARS);
@@ -1153,9 +1181,9 @@ static void print_sample_flags(u32 flags)
 	str[pos] = 0;
 
 	if (name)
-		printf("  %-7s%4s ", name, in_tx ? "(x)" : "");
-	else
-		printf("  %-11s ", str);
+		return fprintf(fp, "  %-7s%4s ", name, in_tx ? "(x)" : "");
+
+	return fprintf(fp, "  %-11s ", str);
 }
 
 struct printer_data {
@@ -1225,138 +1253,136 @@ static int sample__fprintf_bpf_output(enum binary_printer_ops op,
 	return printed;
 }
 
-static void print_sample_bpf_output(struct perf_sample *sample)
+static int perf_sample__fprintf_bpf_output(struct perf_sample *sample, FILE *fp)
 {
 	unsigned int nr_bytes = sample->raw_size;
 	struct printer_data printer_data = {0, false, true};
-
-	print_binary(sample->raw_data, nr_bytes, 8,
-		     sample__fprintf_bpf_output, &printer_data);
+	int printed = binary__fprintf(sample->raw_data, nr_bytes, 8,
+				      sample__fprintf_bpf_output, &printer_data, fp);
 
 	if (printer_data.is_printable && printer_data.hit_nul)
-		printf("%17s \"%s\"\n", "BPF string:",
-		       (char *)(sample->raw_data));
+		printed += fprintf(fp, "%17s \"%s\"\n", "BPF string:", (char *)(sample->raw_data));
+
+	return printed;
 }
 
-static void print_sample_spacing(int len, int spacing)
+static int perf_sample__fprintf_spacing(int len, int spacing, FILE *fp)
 {
 	if (len > 0 && len < spacing)
-		printf("%*s", spacing - len, "");
+		return fprintf(fp, "%*s", spacing - len, "");
+
+	return 0;
 }
 
-static void print_sample_pt_spacing(int len)
+static int perf_sample__fprintf_pt_spacing(int len, FILE *fp)
 {
-	print_sample_spacing(len, 34);
+	return perf_sample__fprintf_spacing(len, 34, fp);
 }
 
-static void print_sample_synth_ptwrite(struct perf_sample *sample)
+static int perf_sample__fprintf_synth_ptwrite(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_ptwrite *data = perf_sample__synth_ptr(sample);
 	int len;
 
 	if (perf_sample__bad_synth_size(sample, *data))
-		return;
+		return 0;
 
-	len = printf(" IP: %u payload: %#" PRIx64 " ",
+	len = fprintf(fp, " IP: %u payload: %#" PRIx64 " ",
 		     data->ip, le64_to_cpu(data->payload));
-	print_sample_pt_spacing(len);
+	return len + perf_sample__fprintf_pt_spacing(len, fp);
 }
 
-static void print_sample_synth_mwait(struct perf_sample *sample)
+static int perf_sample__fprintf_synth_mwait(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_mwait *data = perf_sample__synth_ptr(sample);
 	int len;
 
 	if (perf_sample__bad_synth_size(sample, *data))
-		return;
+		return 0;
 
-	len = printf(" hints: %#x extensions: %#x ",
-		     data->hints, data->extensions);
-	print_sample_pt_spacing(len);
+	len = fprintf(fp, " hints: %#x extensions: %#x ",
+		      data->hints, data->extensions);
+	return len + perf_sample__fprintf_pt_spacing(len, fp);
 }
 
-static void print_sample_synth_pwre(struct perf_sample *sample)
+static int perf_sample__fprintf_synth_pwre(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_pwre *data = perf_sample__synth_ptr(sample);
 	int len;
 
 	if (perf_sample__bad_synth_size(sample, *data))
-		return;
+		return 0;
 
-	len = printf(" hw: %u cstate: %u sub-cstate: %u ",
-		     data->hw, data->cstate, data->subcstate);
-	print_sample_pt_spacing(len);
+	len = fprintf(fp, " hw: %u cstate: %u sub-cstate: %u ",
+		      data->hw, data->cstate, data->subcstate);
+	return len + perf_sample__fprintf_pt_spacing(len, fp);
 }
 
-static void print_sample_synth_exstop(struct perf_sample *sample)
+static int perf_sample__fprintf_synth_exstop(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_exstop *data = perf_sample__synth_ptr(sample);
 	int len;
 
 	if (perf_sample__bad_synth_size(sample, *data))
-		return;
+		return 0;
 
-	len = printf(" IP: %u ", data->ip);
-	print_sample_pt_spacing(len);
+	len = fprintf(fp, " IP: %u ", data->ip);
+	return len + perf_sample__fprintf_pt_spacing(len, fp);
 }
 
-static void print_sample_synth_pwrx(struct perf_sample *sample)
+static int perf_sample__fprintf_synth_pwrx(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_pwrx *data = perf_sample__synth_ptr(sample);
 	int len;
 
 	if (perf_sample__bad_synth_size(sample, *data))
-		return;
+		return 0;
 
-	len = printf(" deepest cstate: %u last cstate: %u wake reason: %#x ",
+	len = fprintf(fp, " deepest cstate: %u last cstate: %u wake reason: %#x ",
 		     data->deepest_cstate, data->last_cstate,
 		     data->wake_reason);
-	print_sample_pt_spacing(len);
+	return len + perf_sample__fprintf_pt_spacing(len, fp);
 }
 
-static void print_sample_synth_cbr(struct perf_sample *sample)
+static int perf_sample__fprintf_synth_cbr(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_cbr *data = perf_sample__synth_ptr(sample);
 	unsigned int percent, freq;
 	int len;
 
 	if (perf_sample__bad_synth_size(sample, *data))
-		return;
+		return 0;
 
 	freq = (le32_to_cpu(data->freq) + 500) / 1000;
-	len = printf(" cbr: %2u freq: %4u MHz ", data->cbr, freq);
+	len = fprintf(fp, " cbr: %2u freq: %4u MHz ", data->cbr, freq);
 	if (data->max_nonturbo) {
 		percent = (5 + (1000 * data->cbr) / data->max_nonturbo) / 10;
-		len += printf("(%3u%%) ", percent);
+		len += fprintf(fp, "(%3u%%) ", percent);
 	}
-	print_sample_pt_spacing(len);
+	return len + perf_sample__fprintf_pt_spacing(len, fp);
 }
 
-static void print_sample_synth(struct perf_sample *sample,
-			       struct perf_evsel *evsel)
+static int perf_sample__fprintf_synth(struct perf_sample *sample,
+				      struct perf_evsel *evsel, FILE *fp)
 {
 	switch (evsel->attr.config) {
 	case PERF_SYNTH_INTEL_PTWRITE:
-		print_sample_synth_ptwrite(sample);
-		break;
+		return perf_sample__fprintf_synth_ptwrite(sample, fp);
 	case PERF_SYNTH_INTEL_MWAIT:
-		print_sample_synth_mwait(sample);
-		break;
+		return perf_sample__fprintf_synth_mwait(sample, fp);
 	case PERF_SYNTH_INTEL_PWRE:
-		print_sample_synth_pwre(sample);
-		break;
+		return perf_sample__fprintf_synth_pwre(sample, fp);
 	case PERF_SYNTH_INTEL_EXSTOP:
-		print_sample_synth_exstop(sample);
-		break;
+		return perf_sample__fprintf_synth_exstop(sample, fp);
 	case PERF_SYNTH_INTEL_PWRX:
-		print_sample_synth_pwrx(sample);
-		break;
+		return perf_sample__fprintf_synth_pwrx(sample, fp);
 	case PERF_SYNTH_INTEL_CBR:
-		print_sample_synth_cbr(sample);
-		break;
+		return perf_sample__fprintf_synth_cbr(sample, fp);
 	default:
 		break;
 	}
+
+	return 0;
 }
 
 struct perf_script {
@@ -1388,7 +1414,7 @@ static int perf_evlist__max_name_len(struct perf_evlist *evlist)
 	return max;
 }
 
-static size_t data_src__printf(u64 data_src)
+static int data_src__fprintf(u64 data_src, FILE *fp)
 {
 	struct mem_info mi = { .data_src.val = data_src };
 	char decode[100];
@@ -1402,7 +1428,7 @@ static size_t data_src__printf(u64 data_src)
 	if (maxlen < len)
 		maxlen = len;
 
-	return printf("%-*s", maxlen, out);
+	return fprintf(fp, "%-*s", maxlen, out);
 }
 
 static void process_event(struct perf_script *script,
@@ -1413,11 +1439,12 @@ static void process_event(struct perf_script *script,
 	struct thread *thread = al->thread;
 	struct perf_event_attr *attr = &evsel->attr;
 	unsigned int type = output_type(attr->type);
+	FILE *fp = stdout;
 
 	if (output[type].fields == 0)
 		return;
 
-	print_sample_start(sample, thread, evsel);
+	perf_sample__fprintf_start(sample, thread, evsel, fp);
 
 	if (PRINT_FIELD(PERIOD))
 		printf("%10" PRIu64 " ", sample->period);
@@ -1433,10 +1460,10 @@ static void process_event(struct perf_script *script,
 	}
 
 	if (print_flags)
-		print_sample_flags(sample->flags);
+		perf_sample__fprintf_flags(sample->flags, fp);
 
 	if (is_bts_event(attr)) {
-		print_sample_bts(sample, evsel, thread, al, machine);
+		perf_sample__fprintf_bts(sample, evsel, thread, al, machine, fp);
 		return;
 	}
 
@@ -1445,16 +1472,16 @@ static void process_event(struct perf_script *script,
 				    sample->raw_data, sample->raw_size);
 
 	if (attr->type == PERF_TYPE_SYNTH && PRINT_FIELD(SYNTH))
-		print_sample_synth(sample, evsel);
+		perf_sample__fprintf_synth(sample, evsel, fp);
 
 	if (PRINT_FIELD(ADDR))
-		print_sample_addr(sample, thread, attr);
+		perf_sample__fprintf_addr(sample, thread, attr, fp);
 
 	if (PRINT_FIELD(DATA_SRC))
-		data_src__printf(sample->data_src);
+		data_src__fprintf(sample->data_src, fp);
 
 	if (PRINT_FIELD(WEIGHT))
-		printf("%16" PRIu64, sample->weight);
+		fprintf(fp, "%16" PRIu64, sample->weight);
 
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
@@ -1464,26 +1491,26 @@ static void process_event(struct perf_script *script,
 					      sample, NULL, NULL, scripting_max_stack) == 0)
 			cursor = &callchain_cursor;
 
-		putchar(cursor ? '\n' : ' ');
-		sample__fprintf_sym(sample, al, 0, output[type].print_ip_opts, cursor, stdout);
+		fputc(cursor ? '\n' : ' ', fp);
+		sample__fprintf_sym(sample, al, 0, output[type].print_ip_opts, cursor, fp);
 	}
 
 	if (PRINT_FIELD(IREGS))
-		print_sample_iregs(sample, attr);
+		perf_sample__fprintf_iregs(sample, attr, fp);
 
 	if (PRINT_FIELD(UREGS))
-		print_sample_uregs(sample, attr);
+		perf_sample__fprintf_uregs(sample, attr, fp);
 
 	if (PRINT_FIELD(BRSTACK))
-		print_sample_brstack(sample, thread, attr);
+		perf_sample__fprintf_brstack(sample, thread, attr, fp);
 	else if (PRINT_FIELD(BRSTACKSYM))
-		print_sample_brstacksym(sample, thread, attr);
+		perf_sample__fprintf_brstacksym(sample, thread, attr, fp);
 	else if (PRINT_FIELD(BRSTACKOFF))
-		print_sample_brstackoff(sample, thread, attr);
+		perf_sample__fprintf_brstackoff(sample, thread, attr, fp);
 
 	if (perf_evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
-		print_sample_bpf_output(sample);
-	print_insn(sample, attr, thread, machine);
+		perf_sample__fprintf_bpf_output(sample, fp);
+	perf_sample__fprintf_insn(sample, attr, thread, machine, fp);
 
 	if (PRINT_FIELD(PHYS_ADDR))
 		printf("%16" PRIx64, sample->phys_addr);
@@ -1661,7 +1688,7 @@ static int process_comm_event(struct perf_tool *tool,
 		sample->tid = event->comm.tid;
 		sample->pid = event->comm.pid;
 	}
-	print_sample_start(sample, thread, evsel);
+	perf_sample__fprintf_start(sample, thread, evsel, stdout);
 	perf_event__fprintf(event, stdout);
 	ret = 0;
 out:
@@ -1696,7 +1723,7 @@ static int process_namespaces_event(struct perf_tool *tool,
 		sample->tid = event->namespaces.tid;
 		sample->pid = event->namespaces.pid;
 	}
-	print_sample_start(sample, thread, evsel);
+	perf_sample__fprintf_start(sample, thread, evsel, stdout);
 	perf_event__fprintf(event, stdout);
 	ret = 0;
 out:
@@ -1729,7 +1756,7 @@ static int process_fork_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	print_sample_start(sample, thread, evsel);
+	perf_sample__fprintf_start(sample, thread, evsel, stdout);
 	perf_event__fprintf(event, stdout);
 	thread__put(thread);
 
@@ -1758,7 +1785,7 @@ static int process_exit_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	print_sample_start(sample, thread, evsel);
+	perf_sample__fprintf_start(sample, thread, evsel, stdout);
 	perf_event__fprintf(event, stdout);
 
 	if (perf_event__process_exit(tool, event, sample, machine) < 0)
@@ -1793,7 +1820,7 @@ static int process_mmap_event(struct perf_tool *tool,
 		sample->tid = event->mmap.tid;
 		sample->pid = event->mmap.pid;
 	}
-	print_sample_start(sample, thread, evsel);
+	perf_sample__fprintf_start(sample, thread, evsel, stdout);
 	perf_event__fprintf(event, stdout);
 	thread__put(thread);
 	return 0;
@@ -1824,7 +1851,7 @@ static int process_mmap2_event(struct perf_tool *tool,
 		sample->tid = event->mmap2.tid;
 		sample->pid = event->mmap2.pid;
 	}
-	print_sample_start(sample, thread, evsel);
+	perf_sample__fprintf_start(sample, thread, evsel, stdout);
 	perf_event__fprintf(event, stdout);
 	thread__put(thread);
 	return 0;
@@ -1850,7 +1877,7 @@ static int process_switch_event(struct perf_tool *tool,
 		return -1;
 	}
 
-	print_sample_start(sample, thread, evsel);
+	perf_sample__fprintf_start(sample, thread, evsel, stdout);
 	perf_event__fprintf(event, stdout);
 	thread__put(thread);
 	return 0;
-- 
2.13.6
