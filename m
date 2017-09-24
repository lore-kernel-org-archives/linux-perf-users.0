From: yuzhoujian <ufo19890607@gmail.com>
Subject: [PATCH v2 4/4] Makes all print functions receive the fp argument, and opens a dump file in process_event.
Date: Sun, 24 Sep 2017 11:37:19 +0800
Message-ID: <1506224239-18550-5-git-send-email-yuzhoujian@didichuxing.com>
References: <1506224239-18550-1-git-send-email-yuzhoujian@didichuxing.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506224239-18550-1-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 tools/perf/builtin-script.c | 404 ++++++++++++++++++++++++--------------------
 1 file changed, 220 insertions(+), 184 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 271dfc4..6182859 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -57,6 +57,8 @@
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 static struct perf_stat_config	stat_config;
 static int			max_blocks;
+static FILE			*per_event_dump_file;
+static const char 		*file_name;
 
 unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
 
@@ -501,7 +503,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 }
 
 static void fprint_sample_iregs(struct perf_sample *sample,
-			  struct perf_event_attr *attr, FILE *fp __maybe_unused)
+			  struct perf_event_attr *attr, FILE *fp)
 {
 	struct regs_dump *regs = &sample->intr_regs;
 	uint64_t mask = attr->sample_regs_intr;
@@ -512,12 +514,12 @@ static void fprint_sample_iregs(struct perf_sample *sample,
 
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
-		fprintf(stdout, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
+		fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
 }
 
 static void fprint_sample_uregs(struct perf_sample *sample,
-			  struct perf_event_attr *attr, FILE *fp __maybe_unused)
+			  struct perf_event_attr *attr, FILE *fp)
 {
 	struct regs_dump *regs = &sample->user_regs;
 	uint64_t mask = attr->sample_regs_user;
@@ -526,17 +528,17 @@ static void fprint_sample_uregs(struct perf_sample *sample,
 	if (!regs || !regs->regs)
 		return;
 
-	fprintf(stdout, " ABI:%" PRIu64 " ", regs->abi);
+	fprintf(fp, " ABI:%" PRIu64 " ", regs->abi);
 
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
-		fprintf(stdout, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
+		fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
 }
 
 static void fprint_sample_start(struct perf_sample *sample,
 			       struct thread *thread,
-			       struct perf_evsel *evsel, FILE *fp __maybe_unused)
+			       struct perf_evsel *evsel, FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	unsigned long secs;
@@ -544,25 +546,25 @@ static void fprint_sample_start(struct perf_sample *sample,
 
 	if (PRINT_FIELD(COMM)) {
 		if (latency_format)
-			fprintf(stdout, "%8.8s ", thread__comm_str(thread));
+			fprintf(fp, "%8.8s ", thread__comm_str(thread));
 		else if (PRINT_FIELD(IP) && symbol_conf.use_callchain)
-			fprintf(stdout, "%s ", thread__comm_str(thread));
+			fprintf(fp, "%s ", thread__comm_str(thread));
 		else
-			fprintf(stdout, "%16s ", thread__comm_str(thread));
+			fprintf(fp, "%16s ", thread__comm_str(thread));
 	}
 
 	if (PRINT_FIELD(PID) && PRINT_FIELD(TID))
-		fprintf(stdout, "%5d/%-5d ", sample->pid, sample->tid);
+		fprintf(fp, "%5d/%-5d ", sample->pid, sample->tid);
 	else if (PRINT_FIELD(PID))
-		fprintf(stdout, "%5d ", sample->pid);
+		fprintf(fp, "%5d ", sample->pid);
 	else if (PRINT_FIELD(TID))
-		fprintf(stdout, "%5d ", sample->tid);
+		fprintf(fp, "%5d ", sample->tid);
 
 	if (PRINT_FIELD(CPU)) {
 		if (latency_format)
-			fprintf(stdout, "%3d ", sample->cpu);
+			fprintf(fp, "%3d ", sample->cpu);
 		else
-			fprintf(stdout, "[%03d] ", sample->cpu);
+			fprintf(fp, "[%03d] ", sample->cpu);
 	}
 
 	if (PRINT_FIELD(TIME)) {
@@ -571,11 +573,11 @@ static void fprint_sample_start(struct perf_sample *sample,
 		nsecs -= secs * NSEC_PER_SEC;
 
 		if (nanosecs)
-			fprintf(stdout, "%5lu.%09llu: ", secs, nsecs);
+			fprintf(fp, "%5lu.%09llu: ", secs, nsecs);
 		else {
 			char sample_time[32];
 			timestamp__scnprintf_usec(sample->time, sample_time, sizeof(sample_time));
-			fprintf(stdout, "%12s: ", sample_time);
+			fprintf(fp, "%12s: ", sample_time);
 		}
 	}
 }
@@ -592,7 +594,7 @@ static void fprint_sample_start(struct perf_sample *sample,
 static void fprint_sample_brstack(struct perf_sample *sample,
 				 struct thread *thread,
 				 struct perf_event_attr *attr,
-				 FILE *fp __maybe_unused)
+				 FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct addr_location alf, alt;
@@ -612,21 +614,21 @@ static void fprint_sample_brstack(struct perf_sample *sample,
 			thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, to, &alt);
 		}
 
-		fprintf(stdout, "0x%"PRIx64, from);
+		fprintf(fp, "0x%"PRIx64, from);
 		if (PRINT_FIELD(DSO)) {
-			fprintf(stdout, "(");
-			map__fprintf_dsoname(alf.map, stdout);
-			fprintf(stdout, ")");
+			fprintf(fp, "(");
+			map__fprintf_dsoname(alf.map, fp);
+			fprintf(fp, ")");
 		}
 
-		fprintf(stdout, "/0x%"PRIx64, to);
+		fprintf(fp, "/0x%"PRIx64, to);
 		if (PRINT_FIELD(DSO)) {
-			fprintf(stdout, "(");
-			map__fprintf_dsoname(alt.map, stdout);
-			fprintf(stdout, ")");
+			fprintf(fp, "(");
+			map__fprintf_dsoname(alt.map, fp);
+			fprintf(fp, ")");
 		}
 
-		fprintf(stdout, "/%c/%c/%c/%d ",
+		fprintf(fp, "/%c/%c/%c/%d ",
 			mispred_str( br->entries + i),
 			br->entries[i].flags.in_tx? 'X' : '-',
 			br->entries[i].flags.abort? 'A' : '-',
@@ -637,7 +639,7 @@ static void fprint_sample_brstack(struct perf_sample *sample,
 static void fprint_sample_brstacksym(struct perf_sample *sample,
 				    struct thread *thread,
 				    struct perf_event_attr *attr,
-				    FILE *fp __maybe_unused)
+				    FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct addr_location alf, alt;
@@ -661,20 +663,20 @@ static void fprint_sample_brstacksym(struct perf_sample *sample,
 		if (alt.map)
 			alt.sym = map__find_symbol(alt.map, alt.addr);
 
-		symbol__fprintf_symname_offs(alf.sym, &alf, stdout);
+		symbol__fprintf_symname_offs(alf.sym, &alf, fp);
 		if (PRINT_FIELD(DSO)) {
-			fprintf(stdout, "(");
-			map__fprintf_dsoname(alf.map, stdout);
-			fprintf(stdout, ")");
+			fprintf(fp, "(");
+			map__fprintf_dsoname(alf.map, fp);
+			fprintf(fp, ")");
 		}
-		fputc('/', stdout);
-		symbol__fprintf_symname_offs(alt.sym, &alt, stdout);
+		fputc('/', fp);
+		symbol__fprintf_symname_offs(alt.sym, &alt, fp);
 		if (PRINT_FIELD(DSO)) {
-			fprintf(stdout, "(");
-			map__fprintf_dsoname(alt.map, stdout);
-			fprintf(stdout, ")");
+			fprintf(fp, "(");
+			map__fprintf_dsoname(alt.map, fp);
+			fprintf(fp, ")");
 		}
-		fprintf(stdout, "/%c/%c/%c/%d ",
+		fprintf(fp, "/%c/%c/%c/%d ",
 			mispred_str( br->entries + i),
 			br->entries[i].flags.in_tx? 'X' : '-',
 			br->entries[i].flags.abort? 'A' : '-',
@@ -685,7 +687,7 @@ static void fprint_sample_brstacksym(struct perf_sample *sample,
 static void fprint_sample_brstackoff(struct perf_sample *sample,
 				    struct thread *thread,
 				    struct perf_event_attr *attr,
-				    FILE *fp __maybe_unused)
+				    FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct addr_location alf, alt;
@@ -709,19 +711,19 @@ static void fprint_sample_brstackoff(struct perf_sample *sample,
 		if (alt.map && !alt.map->dso->adjust_symbols)
 			to = map__map_ip(alt.map, to);
 
-		fprintf(stdout, "0x%"PRIx64, from);
+		fprintf(fp, "0x%"PRIx64, from);
 		if (PRINT_FIELD(DSO)) {
-			fprintf(stdout, "(");
-			map__fprintf_dsoname(alf.map, stdout);
-			fprintf(stdout, ")");
+			fprintf(fp, "(");
+			map__fprintf_dsoname(alf.map, fp);
+			fprintf(fp, ")");
 		}
-		fprintf(stdout, "/0x%"PRIx64, to);
+		fprintf(fp, "/0x%"PRIx64, to);
 		if (PRINT_FIELD(DSO)) {
-			fprintf(stdout, "(");
-			map__fprintf_dsoname(alt.map, stdout);
-			fprintf(stdout, ")");
+			fprintf(fp, "(");
+			map__fprintf_dsoname(alt.map, fp);
+			fprintf(fp, ")");
 		}
-		fprintf(stdout, "/%c/%c/%c/%d ",
+		fprintf(fp, "/%c/%c/%c/%d ",
 			mispred_str(br->entries + i),
 			br->entries[i].flags.in_tx ? 'X' : '-',
 			br->entries[i].flags.abort ? 'A' : '-',
@@ -794,9 +796,9 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 
 static void fprint_jump(uint64_t ip, struct branch_entry *en,
 		       struct perf_insn *x, u8 *inbuf, int len,
-		       int insn, FILE *fp __maybe_unused)
+		       int insn, FILE *fp)
 {
-	fprintf(stdout, "\t%016" PRIx64 "\t%-30s\t#%s%s%s%s",
+	fprintf(fp, "\t%016" PRIx64 "\t%-30s\t#%s%s%s%s",
 	       ip,
 	       dump_insn(x, ip, inbuf, len, NULL),
 	       en->flags.predicted ? " PRED" : "",
@@ -804,17 +806,17 @@ static void fprint_jump(uint64_t ip, struct branch_entry *en,
 	       en->flags.in_tx ? " INTX" : "",
 	       en->flags.abort ? " ABORT" : "");
 	if (en->flags.cycles) {
-		fprintf(stdout, " %d cycles", en->flags.cycles);
+		fprintf(fp, " %d cycles", en->flags.cycles);
 		if (insn)
-			fprintf(stdout, " %.2f IPC", (float)insn / en->flags.cycles);
+			fprintf(fp, " %.2f IPC", (float)insn / en->flags.cycles);
 	}
-	fputc('\n', stdout);
+	fputc('\n', fp);
 }
 
 static void fprint_ip_sym(struct thread *thread, u8 cpumode, int cpu,
 			 uint64_t addr, struct symbol **lastsym,
 			 struct perf_event_attr *attr,
-			 FILE *fp __maybe_unused)
+			 FILE *fp)
 {
 	struct addr_location al;
 	int off;
@@ -840,13 +842,13 @@ static void fprint_ip_sym(struct thread *thread, u8 cpumode, int cpu,
 		off = al.addr - al.sym->start;
 	else
 		off = al.addr - al.map->start - al.sym->start;
-	fprintf(stdout, "\t%s", al.sym->name);
+	fprintf(fp, "\t%s", al.sym->name);
 	if (off)
-		fprintf(stdout, "%+d", off);
-	fputc(':', stdout);
+		fprintf(fp, "%+d", off);
+	fputc(':', fp);
 	if (PRINT_FIELD(SRCLINE))
-		map__fprintf_srcline(al.map, al.addr, "\t", stdout);
-	fputc('\n', stdout);
+		map__fprintf_srcline(al.map, al.addr, "\t", fp);
+	fputc('\n', fp);
 	*lastsym = al.sym;
 }
 
@@ -854,7 +856,7 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 				     struct thread *thread,
 				     struct perf_event_attr *attr,
 				     struct machine *machine,
-				     FILE *fp __maybe_unused)
+				     FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	u64 start, end;
@@ -873,7 +875,7 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 	x.thread = thread;
 	x.cpu = sample->cpu;
 
-	fputc('\n', stdout);
+	fputc('\n', fp);
 
 	/* Handle first from jump, of which we don't know the entry. */
 	len = grab_bb(buffer, br->entries[nr-1].from,
@@ -881,15 +883,15 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 			machine, thread, &x.is64bit, &x.cpumode, false);
 	if (len > 0) {
 		fprint_ip_sym(thread, x.cpumode, x.cpu,
-			     br->entries[nr - 1].from, &lastsym, attr, stdout);
+			     br->entries[nr - 1].from, &lastsym, attr, fp);
 		fprint_jump(br->entries[nr - 1].from, &br->entries[nr - 1],
-			    &x, buffer, len, 0, stdout);
+			    &x, buffer, len, 0, fp);
 	}
 
 	/* Print all blocks */
 	for (i = nr - 2; i >= 0; i--) {
 		if (br->entries[i].from || br->entries[i].to)
-			fprintf(stdout, "%d: %" PRIx64 "-%" PRIx64 "\n", i,
+			fprintf(fp, "%d: %" PRIx64 "-%" PRIx64 "\n", i,
 				 br->entries[i].from,
 				 br->entries[i].to);
 		start = br->entries[i + 1].to;
@@ -899,7 +901,7 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 		/* Patch up missing kernel transfers due to ring filters */
 		if (len == -ENXIO && i > 0) {
 			end = br->entries[--i].from;
-			fprintf(stdout, "\tpatching up to %" PRIx64 "-%" PRIx64 "\n", start, end);
+			fprintf(fp, "\tpatching up to %" PRIx64 "-%" PRIx64 "\n", start, end);
 			len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, false);
 		}
 		if (len <= 0)
@@ -909,12 +911,12 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 		for (off = 0;; off += ilen) {
 			uint64_t ip = start + off;
 
-			fprint_ip_sym(thread, x.cpumode, x.cpu, ip, &lastsym, attr, stdout);
+			fprint_ip_sym(thread, x.cpumode, x.cpu, ip, &lastsym, attr, fp);
 			if (ip == end) {
-				fprint_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, stdout);
+				fprint_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, fp);
 				break;
 			} else {
-				fprintf(stdout, "\t%016" PRIx64 "\t%s\n", ip,
+				fprintf(fp, "\t%016" PRIx64 "\t%s\n", ip,
 					dump_insn(&x, ip, buffer + off, len - off, &ilen));
 				if (ilen == 0)
 					break;
@@ -938,7 +940,7 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 	start = br->entries[0].to;
 	end = sample->ip;
 	len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, true);
-	fprint_ip_sym(thread, x.cpumode, x.cpu, start, &lastsym, attr, stdout);
+	fprint_ip_sym(thread, x.cpumode, x.cpu, start, &lastsym, attr, fp);
 	if (len <= 0) {
 		/* Print at least last IP if basic block did not work */
 		len = grab_bb(buffer, sample->ip, sample->ip,
@@ -946,12 +948,12 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 		if (len <= 0)
 			return;
 
-		fprintf(stdout, "\t%016" PRIx64 "\t%s\n", sample->ip,
+		fprintf(fp, "\t%016" PRIx64 "\t%s\n", sample->ip,
 			dump_insn(&x, sample->ip, buffer, len, NULL));
 		return;
 	}
 	for (off = 0; off <= end - start; off += ilen) {
-		fprintf(stdout, "\t%016" PRIx64 "\t%s\n", start + off,
+		fprintf(fp, "\t%016" PRIx64 "\t%s\n", start + off,
 			dump_insn(&x, start + off, buffer + off, len - off, &ilen));
 		if (ilen == 0)
 			break;
@@ -961,11 +963,11 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 static void fprint_sample_addr(struct perf_sample *sample,
 			  struct thread *thread,
 			  struct perf_event_attr *attr,
-			  FILE *fp __maybe_unused)
+			  FILE *fp)
 {
 	struct addr_location al;
 
-	fprintf(stdout, "%16" PRIx64, sample->addr);
+	fprintf(fp, "%16" PRIx64, sample->addr);
 
 	if (!sample_addr_correlates_sym(attr))
 		return;
@@ -973,17 +975,17 @@ static void fprint_sample_addr(struct perf_sample *sample,
 	thread__resolve(thread, &al, sample);
 
 	if (PRINT_FIELD(SYM)) {
-		fprintf(stdout, " ");
+		fprintf(fp, " ");
 		if (PRINT_FIELD(SYMOFFSET))
-			symbol__fprintf_symname_offs(al.sym, &al, stdout);
+			symbol__fprintf_symname_offs(al.sym, &al, fp);
 		else
-			symbol__fprintf_symname(al.sym, stdout);
+			symbol__fprintf_symname(al.sym, fp);
 	}
 
 	if (PRINT_FIELD(DSO)) {
-		fprintf(stdout, " (");
-		map__fprintf_dsoname(al.map, stdout);
-		fprintf(stdout, ")");
+		fprintf(fp, " (");
+		map__fprintf_dsoname(al.map, fp);
+		fprintf(fp, ")");
 	}
 }
 
@@ -991,7 +993,7 @@ static void fprint_sample_callindent(struct perf_sample *sample,
 				    struct perf_evsel *evsel,
 				    struct thread *thread,
 				    struct addr_location *al,
-				    FILE *fp __maybe_unused)
+				    FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	size_t depth = thread_stack__depth(thread);
@@ -1026,9 +1028,9 @@ static void fprint_sample_callindent(struct perf_sample *sample,
 	}
 
 	if (name)
-		len = fprintf(stdout, "%*s%s", (int)depth * 4, "", name);
+		len = fprintf(fp, "%*s%s", (int)depth * 4, "", name);
 	else if (ip)
-		len = fprintf(stdout, "%*s%16" PRIx64, (int)depth * 4, "", ip);
+		len = fprintf(fp, "%*s%16" PRIx64, (int)depth * 4, "", ip);
 
 	if (len < 0)
 		return;
@@ -1041,26 +1043,26 @@ static void fprint_sample_callindent(struct perf_sample *sample,
 		spacing = round_up(len + 4, 32);
 
 	if (len < spacing)
-		fprintf(stdout, "%*s", spacing - len, "");
+		fprintf(fp, "%*s", spacing - len, "");
 }
 
 static void fprint_insn(struct perf_sample *sample,
 		       struct perf_event_attr *attr,
 		       struct thread *thread,
 		       struct machine *machine,
-		       FILE *fp __maybe_unused)
+		       FILE *fp)
 {
 	if (PRINT_FIELD(INSNLEN))
-		fprintf(stdout, " ilen: %d", sample->insn_len);
+		fprintf(fp, " ilen: %d", sample->insn_len);
 	if (PRINT_FIELD(INSN)) {
 		int i;
 
-		fprintf(stdout, " insn:");
+		fprintf(fp, " insn:");
 		for (i = 0; i < sample->insn_len; i++)
-			fprintf(stdout, " %02x", (unsigned char)sample->insn[i]);
+			fprintf(fp, " %02x", (unsigned char)sample->insn[i]);
 	}
 	if (PRINT_FIELD(BRSTACKINSN))
-		fprint_sample_brstackinsn(sample, thread, attr, machine, stdout);
+		fprint_sample_brstackinsn(sample, thread, attr, machine, fp);
 }
 
 static void fprint_sample_bts(struct perf_sample *sample,
@@ -1068,14 +1070,14 @@ static void fprint_sample_bts(struct perf_sample *sample,
 			     struct thread *thread,
 			     struct addr_location *al,
 			     struct machine *machine,
-			     FILE *fp __maybe_unused)
+			     FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	unsigned int type = output_type(attr->type);
 	bool print_srcline_last = false;
 
 	if (PRINT_FIELD(CALLINDENT))
-		fprint_sample_callindent(sample, evsel, thread, al, stdout);
+		fprint_sample_callindent(sample, evsel, thread, al, fp);
 
 	/* print branch_from information */
 	if (PRINT_FIELD(IP)) {
@@ -1088,31 +1090,31 @@ static void fprint_sample_bts(struct perf_sample *sample,
 			cursor = &callchain_cursor;
 
 		if (cursor == NULL) {
-			fputc(' ', stdout);
+			fputc(' ', fp);
 			if (print_opts & EVSEL__PRINT_SRCLINE) {
 				print_srcline_last = true;
 				print_opts &= ~EVSEL__PRINT_SRCLINE;
 			}
 		} else
-			fputc('\n', stdout);
+			fputc('\n', fp);
 
-		sample__fprintf_sym(sample, al, 0, print_opts, cursor, stdout);
+		sample__fprintf_sym(sample, al, 0, print_opts, cursor, fp);
 	}
 
 	/* print branch_to information */
 	if (PRINT_FIELD(ADDR) ||
 	    ((evsel->attr.sample_type & PERF_SAMPLE_ADDR) &&
 	     !output[type].user_set)) {
-		fprintf(stdout, " => ");
-		fprint_sample_addr(sample, thread, attr, stdout);
+		fprintf(fp, " => ");
+		fprint_sample_addr(sample, thread, attr, fp);
 	}
 
 	if (print_srcline_last)
-		map__fprintf_srcline(al->map, al->addr, "\n  ", stdout);
+		map__fprintf_srcline(al->map, al->addr, "\n  ", fp);
 
-	fprint_insn(sample, attr, thread, machine, stdout);
+	fprint_insn(sample, attr, thread, machine, fp);
 
-	fprintf(stdout, "\n");
+	fprintf(fp, "\n");
 }
 
 static struct {
@@ -1135,7 +1137,7 @@ static void fprint_sample_bts(struct perf_sample *sample,
 	{0, NULL}
 };
 
-static void fprint_sample_flags(u32 flags, FILE *fp __maybe_unused)
+static void fprint_sample_flags(u32 flags, FILE *fp)
 {
 	const char *chars = PERF_IP_FLAG_CHARS;
 	const int n = strlen(PERF_IP_FLAG_CHARS);
@@ -1162,9 +1164,9 @@ static void fprint_sample_flags(u32 flags, FILE *fp __maybe_unused)
 	str[pos] = 0;
 
 	if (name)
-		fprintf(stdout, "  %-7s%4s ", name, in_tx ? "(x)" : "");
+		fprintf(fp, "  %-7s%4s ", name, in_tx ? "(x)" : "");
 	else
-		fprintf(stdout, "  %-11s ", str);
+		fprintf(fp, "  %-11s ", str);
 }
 
 struct printer_data {
@@ -1181,33 +1183,34 @@ struct printer_data {
 {
 	unsigned char ch = (unsigned char)val;
 	struct printer_data *printer_data = extra;
+	FILE *fp = printer_data->fp;
 
 	switch (op) {
 	case BINARY_PRINT_DATA_BEGIN:
-		fprintf(stdout, "\n");
+		fprintf(fp, "\n");
 		break;
 	case BINARY_PRINT_LINE_BEGIN:
-		fprintf(stdout, "%17s", !printer_data->line_no ? "BPF output:" :
+		fprintf(fp, "%17s", !printer_data->line_no ? "BPF output:" :
 						        "           ");
 		break;
 	case BINARY_PRINT_ADDR:
-		fprintf(stdout, " %04x:", val);
+		fprintf(fp, " %04x:", val);
 		break;
 	case BINARY_PRINT_NUM_DATA:
-		fprintf(stdout, " %02x", val);
+		fprintf(fp, " %02x", val);
 		break;
 	case BINARY_PRINT_NUM_PAD:
-		fprintf(stdout, "   ");
+		fprintf(fp, "   ");
 		break;
 	case BINARY_PRINT_SEP:
-		fprintf(stdout, "  ");
+		fprintf(fp, "  ");
 		break;
 	case BINARY_PRINT_CHAR_DATA:
 		if (printer_data->hit_nul && ch)
 			printer_data->is_printable = false;
 
 		if (!isprint(ch)) {
-			fprintf(stdout, "%c", '.');
+			fprintf(fp, "%c", '.');
 
 			if (!printer_data->is_printable)
 				break;
@@ -1217,14 +1220,14 @@ struct printer_data {
 			else
 				printer_data->is_printable = false;
 		} else {
-			fprintf(stdout, "%c", ch);
+			fprintf(fp, "%c", ch);
 		}
 		break;
 	case BINARY_PRINT_CHAR_PAD:
-		fprintf(stdout, " ");
+		fprintf(fp, " ");
 		break;
 	case BINARY_PRINT_LINE_END:
-		fprintf(stdout, "\n");
+		fprintf(fp, "\n");
 		printer_data->line_no++;
 		break;
 	case BINARY_PRINT_DATA_END:
@@ -1233,31 +1236,31 @@ struct printer_data {
 	}
 }
 
-static void fprint_sample_bpf_output(struct perf_sample *sample, FILE *fp __maybe_unused)
+static void fprint_sample_bpf_output(struct perf_sample *sample, FILE *fp)
 {
 	unsigned int nr_bytes = sample->raw_size;
-	struct printer_data printer_data = {0, false, true, stdout};
+	struct printer_data printer_data = {0, false, true, fp};
 
 	print_binary(sample->raw_data, nr_bytes, 8,
 		     fprint_sample_bpf_output_printer, &printer_data);
 
 	if (printer_data.is_printable && printer_data.hit_nul)
-		fprintf(stdout, "%17s \"%s\"\n", "BPF string:",
+		fprintf(fp, "%17s \"%s\"\n", "BPF string:",
 		       (char *)(sample->raw_data));
 }
 
-static void fprint_sample_spacing(int len, int spacing, FILE *fp __maybe_unused)
+static void fprint_sample_spacing(int len, int spacing, FILE *fp)
 {
 	if (len > 0 && len < spacing)
-		fprintf(stdout, "%*s", spacing - len, "");
+		fprintf(fp, "%*s", spacing - len, "");
 }
 
-static void fprint_sample_pt_spacing(int len, FILE *fp __maybe_unused)
+static void fprint_sample_pt_spacing(int len, FILE *fp)
 {
-	fprint_sample_spacing(len, 34, stdout);
+	fprint_sample_spacing(len, 34, fp);
 }
 
-static void fprint_sample_synth_ptwrite(struct perf_sample *sample, FILE *fp __maybe_unused)
+static void fprint_sample_synth_ptwrite(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_ptwrite *data = perf_sample__synth_ptr(sample);
 	int len;
@@ -1265,12 +1268,12 @@ static void fprint_sample_synth_ptwrite(struct perf_sample *sample, FILE *fp __m
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = fprintf(stdout, " IP: %u payload: %#" PRIx64 " ",
+	len = fprintf(fp, " IP: %u payload: %#" PRIx64 " ",
 		     data->ip, le64_to_cpu(data->payload));
-	fprint_sample_pt_spacing(len, stdout);
+	fprint_sample_pt_spacing(len, fp);
 }
 
-static void fprint_sample_synth_mwait(struct perf_sample *sample, FILE *fp __maybe_unused)
+static void fprint_sample_synth_mwait(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_mwait *data = perf_sample__synth_ptr(sample);
 	int len;
@@ -1278,12 +1281,12 @@ static void fprint_sample_synth_mwait(struct perf_sample *sample, FILE *fp __may
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = fprintf(stdout, " hints: %#x extensions: %#x ",
+	len = fprintf(fp, " hints: %#x extensions: %#x ",
 		     data->hints, data->extensions);
-	fprint_sample_pt_spacing(len, stdout);
+	fprint_sample_pt_spacing(len, fp);
 }
 
-static void fprint_sample_synth_pwre(struct perf_sample *sample, FILE *fp __maybe_unused)
+static void fprint_sample_synth_pwre(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_pwre *data = perf_sample__synth_ptr(sample);
 	int len;
@@ -1291,12 +1294,12 @@ static void fprint_sample_synth_pwre(struct perf_sample *sample, FILE *fp __mayb
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = fprintf(stdout, " hw: %u cstate: %u sub-cstate: %u ",
+	len = fprintf(fp, " hw: %u cstate: %u sub-cstate: %u ",
 		     data->hw, data->cstate, data->subcstate);
-	fprint_sample_pt_spacing(len, stdout);
+	fprint_sample_pt_spacing(len, fp);
 }
 
-static void fprint_sample_synth_exstop(struct perf_sample *sample, FILE *fp __maybe_unused)
+static void fprint_sample_synth_exstop(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_exstop *data = perf_sample__synth_ptr(sample);
 	int len;
@@ -1304,11 +1307,11 @@ static void fprint_sample_synth_exstop(struct perf_sample *sample, FILE *fp __ma
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = fprintf(stdout, " IP: %u ", data->ip);
-	fprint_sample_pt_spacing(len, stdout);
+	len = fprintf(fp, " IP: %u ", data->ip);
+	fprint_sample_pt_spacing(len, fp);
 }
 
-static void fprint_sample_synth_pwrx(struct perf_sample *sample, FILE *fp __maybe_unused)
+static void fprint_sample_synth_pwrx(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_pwrx *data = perf_sample__synth_ptr(sample);
 	int len;
@@ -1316,13 +1319,13 @@ static void fprint_sample_synth_pwrx(struct perf_sample *sample, FILE *fp __mayb
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = fprintf(stdout, " deepest cstate: %u last cstate: %u wake reason: %#x ",
+	len = fprintf(fp, " deepest cstate: %u last cstate: %u wake reason: %#x ",
 		     data->deepest_cstate, data->last_cstate,
 		     data->wake_reason);
-	fprint_sample_pt_spacing(len, stdout);
+	fprint_sample_pt_spacing(len, fp);
 }
 
-static void fprint_sample_synth_cbr(struct perf_sample *sample, FILE *fp __maybe_unused)
+static void fprint_sample_synth_cbr(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_cbr *data = perf_sample__synth_ptr(sample);
 	unsigned int percent, freq;
@@ -1332,35 +1335,35 @@ static void fprint_sample_synth_cbr(struct perf_sample *sample, FILE *fp __maybe
 		return;
 
 	freq = (le32_to_cpu(data->freq) + 500) / 1000;
-	len = fprintf(stdout, " cbr: %2u freq: %4u MHz ", data->cbr, freq);
+	len = fprintf(fp, " cbr: %2u freq: %4u MHz ", data->cbr, freq);
 	if (data->max_nonturbo) {
 		percent = (5 + (1000 * data->cbr) / data->max_nonturbo) / 10;
-		len += fprintf(stdout, "(%3u%%) ", percent);
+		len += fprintf(fp, "(%3u%%) ", percent);
 	}
-	fprint_sample_pt_spacing(len, stdout);
+	fprint_sample_pt_spacing(len, fp);
 }
 
 static void fprint_sample_synth(struct perf_sample *sample,
-			       struct perf_evsel *evsel, FILE *fp __maybe_unused)
+			       struct perf_evsel *evsel, FILE *fp)
 {
 	switch (evsel->attr.config) {
 	case PERF_SYNTH_INTEL_PTWRITE:
-		fprint_sample_synth_ptwrite(sample, stdout);
+		fprint_sample_synth_ptwrite(sample, fp);
 		break;
 	case PERF_SYNTH_INTEL_MWAIT:
-		fprint_sample_synth_mwait(sample, stdout);
+		fprint_sample_synth_mwait(sample, fp);
 		break;
 	case PERF_SYNTH_INTEL_PWRE:
-		fprint_sample_synth_pwre(sample, stdout);
+		fprint_sample_synth_pwre(sample, fp);
 		break;
 	case PERF_SYNTH_INTEL_EXSTOP:
-		fprint_sample_synth_exstop(sample, stdout);
+		fprint_sample_synth_exstop(sample, fp);
 		break;
 	case PERF_SYNTH_INTEL_PWRX:
-		fprint_sample_synth_pwrx(sample, stdout);
+		fprint_sample_synth_pwrx(sample, fp);
 		break;
 	case PERF_SYNTH_INTEL_CBR:
-		fprint_sample_synth_cbr(sample, stdout);
+		fprint_sample_synth_cbr(sample, fp);
 		break;
 	default:
 		break;
@@ -1396,7 +1399,7 @@ static int perf_evlist__max_name_len(struct perf_evlist *evlist)
 	return max;
 }
 
-static size_t data_src__fprintf(u64 data_src, FILE *fp __maybe_unused)
+static size_t data_src__fprintf(u64 data_src, FILE *fp)
 {
 	struct mem_info mi = { .data_src.val = data_src };
 	char decode[100];
@@ -1410,59 +1413,69 @@ static size_t data_src__fprintf(u64 data_src, FILE *fp __maybe_unused)
 	if (maxlen < len)
 		maxlen = len;
 
-	return fprintf(stdout, "%-*s", maxlen, out);
+	return fprintf(fp, "%-*s", maxlen, out);
 }
 
 static void process_event(struct perf_script *script,
 			  struct perf_sample *sample, struct perf_evsel *evsel,
 			  struct addr_location *al,
-			  struct machine *machine, FILE *fp __maybe_unused)
+			  struct machine *machine, FILE *fp)
 {
 	struct thread *thread = al->thread;
 	struct perf_event_attr *attr = &evsel->attr;
 	unsigned int type = output_type(attr->type);
+	const char *evname;
+	char *filename;
 
 	if (output[type].fields == 0)
 		return;
 
-	fprint_sample_start(sample, thread, evsel, stdout);
+	/* the dump file name is <ORIGINAL PERF DATA FILE NAME>-script-dump-<EVENT NAME>.txt */
+	evname = perf_evsel__name(evsel);
+	if (script->tool.per_event_dump) {
+		if (asprintf(&filename, "%s%s%s%s", "perf.data", "-script-dump", evname, ".txt") < 0)
+			filename = NULL;
+		fp = fopen(filename, "a+");
+		if (!fp)
+			return;
+		free(filename);
+	}
+	fprint_sample_start(sample, thread, evsel, fp);
 
 	if (PRINT_FIELD(PERIOD))
-		fprintf(stdout, "%10" PRIu64 " ", sample->period);
+		fprintf(fp, "%10" PRIu64 " ", sample->period);
 
 	if (PRINT_FIELD(EVNAME)) {
-		const char *evname = perf_evsel__name(evsel);
-
 		if (!script->name_width)
 			script->name_width = perf_evlist__max_name_len(script->session->evlist);
 
-		fprintf(stdout, "%*s: ", script->name_width,
+		fprintf(fp, "%*s: ", script->name_width,
 		       evname ? evname : "[unknown]");
 	}
 
 	if (print_flags)
-		fprint_sample_flags(sample->flags, stdout);
+		fprint_sample_flags(sample->flags, fp);
 
 	if (is_bts_event(attr)) {
-		fprint_sample_bts(sample, evsel, thread, al, machine, stdout);
+		fprint_sample_bts(sample, evsel, thread, al, machine, fp);
 		return;
 	}
 
 	if (PRINT_FIELD(TRACE))
 		event_format__fprintf(evsel->tp_format, sample->cpu,
-				    sample->raw_data, sample->raw_size, stdout);
+				    sample->raw_data, sample->raw_size, fp);
 
 	if (attr->type == PERF_TYPE_SYNTH && PRINT_FIELD(SYNTH))
-		fprint_sample_synth(sample, evsel, stdout);
+		fprint_sample_synth(sample, evsel, fp);
 
 	if (PRINT_FIELD(ADDR))
-		fprint_sample_addr(sample, thread, attr, stdout);
+		fprint_sample_addr(sample, thread, attr, fp);
 
 	if (PRINT_FIELD(DATA_SRC))
-		data_src__fprintf(sample->data_src, stdout);
+		data_src__fprintf(sample->data_src, fp);
 
 	if (PRINT_FIELD(WEIGHT))
-		fprintf(stdout, "%16" PRIu64, sample->weight);
+		fprintf(fp, "%16" PRIu64, sample->weight);
 
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
@@ -1472,30 +1485,32 @@ static void process_event(struct perf_script *script,
 					      sample, NULL, NULL, scripting_max_stack) == 0)
 			cursor = &callchain_cursor;
 
-		fputc(cursor ? '\n' : ' ', stdout);
-		sample__fprintf_sym(sample, al, 0, output[type].print_ip_opts, cursor, stdout);
+		fputc(cursor ? '\n' : ' ', fp);
+		sample__fprintf_sym(sample, al, 0, output[type].print_ip_opts, cursor, fp);
 	}
 
 	if (PRINT_FIELD(IREGS))
-		fprint_sample_iregs(sample, attr, stdout);
+		fprint_sample_iregs(sample, attr, fp);
 
 	if (PRINT_FIELD(UREGS))
-		fprint_sample_uregs(sample, attr, stdout);
+		fprint_sample_uregs(sample, attr, fp);
 
 	if (PRINT_FIELD(BRSTACK))
-		fprint_sample_brstack(sample, thread, attr, stdout);
+		fprint_sample_brstack(sample, thread, attr, fp);
 	else if (PRINT_FIELD(BRSTACKSYM))
-		fprint_sample_brstacksym(sample, thread, attr, stdout);
+		fprint_sample_brstacksym(sample, thread, attr, fp);
 	else if (PRINT_FIELD(BRSTACKOFF))
-		fprint_sample_brstackoff(sample, thread, attr, stdout);
+		fprint_sample_brstackoff(sample, thread, attr, fp);
 
 	if (perf_evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
-		fprint_sample_bpf_output(sample, stdout);
-	fprint_insn(sample, attr, thread, machine, stdout);
+		fprint_sample_bpf_output(sample, fp);
+	fprint_insn(sample, attr, thread, machine, fp);
 
 	if (PRINT_FIELD(PHYS_ADDR))
-		fprintf(stdout, "%16" PRIx64, sample->phys_addr);
-	fprintf(stdout, "\n");
+		fprintf(fp, "%16" PRIx64, sample->phys_addr);
+	fprintf(fp, "\n");
+	if (script->tool.per_event_dump)
+		fclose(fp);
 }
 
 static struct scripting_ops	*scripting_ops;
@@ -1574,6 +1589,7 @@ static int process_sample_event(struct perf_tool *tool,
 {
 	struct perf_script *scr = container_of(tool, struct perf_script, tool);
 	struct addr_location al;
+	FILE *fp;
 
 	if (perf_time__skip_sample(&scr->ptime, sample->time))
 		return 0;
@@ -1601,10 +1617,11 @@ static int process_sample_event(struct perf_tool *tool,
 	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
 		goto out_put;
 
+	fp = tool->per_event_dump ? per_event_dump_file : stdout;
 	if (scripting_ops)
 		scripting_ops->process_event(event, sample, evsel, &al);
 	else
-		process_event(scr, sample, evsel, &al, machine, stdout);
+		process_event(scr, sample, evsel, &al, machine, fp);
 
 out_put:
 	addr_location__put(&al);
@@ -1653,6 +1670,7 @@ static int process_comm_event(struct perf_tool *tool,
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 	int ret = -1;
+	FILE *fp;
 
 	thread = machine__findnew_thread(machine, event->comm.pid, event->comm.tid);
 	if (thread == NULL) {
@@ -1669,8 +1687,9 @@ static int process_comm_event(struct perf_tool *tool,
 		sample->tid = event->comm.tid;
 		sample->pid = event->comm.pid;
 	}
-	fprint_sample_start(sample, thread, evsel, stdout);
-	perf_event__fprintf(event, stdout);
+	fp = tool->per_event_dump ? per_event_dump_file : stdout;
+	fprint_sample_start(sample, thread, evsel, fp);
+	perf_event__fprintf(event, fp);
 	ret = 0;
 out:
 	thread__put(thread);
@@ -1687,6 +1706,7 @@ static int process_namespaces_event(struct perf_tool *tool,
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 	int ret = -1;
+	FILE *fp;
 
 	thread = machine__findnew_thread(machine, event->namespaces.pid,
 					 event->namespaces.tid);
@@ -1704,8 +1724,9 @@ static int process_namespaces_event(struct perf_tool *tool,
 		sample->tid = event->namespaces.tid;
 		sample->pid = event->namespaces.pid;
 	}
-	fprint_sample_start(sample, thread, evsel, stdout);
-	perf_event__fprintf(event, stdout);
+	fp = tool->per_event_dump ? per_event_dump_file : stdout;
+	fprint_sample_start(sample, thread, evsel, fp);
+	perf_event__fprintf(event, fp);
 	ret = 0;
 out:
 	thread__put(thread);
@@ -1721,6 +1742,7 @@ static int process_fork_event(struct perf_tool *tool,
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	FILE *fp;
 
 	if (perf_event__process_fork(tool, event, sample, machine) < 0)
 		return -1;
@@ -1737,8 +1759,9 @@ static int process_fork_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	fprint_sample_start(sample, thread, evsel, stdout);
-	perf_event__fprintf(event, stdout);
+	fp = tool->per_event_dump ? per_event_dump_file : stdout;
+	fprint_sample_start(sample, thread, evsel, fp);
+	perf_event__fprintf(event, fp);
 	thread__put(thread);
 
 	return 0;
@@ -1753,6 +1776,7 @@ static int process_exit_event(struct perf_tool *tool,
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	FILE *fp;
 
 	thread = machine__findnew_thread(machine, event->fork.pid, event->fork.tid);
 	if (thread == NULL) {
@@ -1766,8 +1790,9 @@ static int process_exit_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	fprint_sample_start(sample, thread, evsel, stdout);
-	perf_event__fprintf(event, stdout);
+	fp = tool->per_event_dump ? per_event_dump_file : stdout;
+	fprint_sample_start(sample, thread, evsel, fp);
+	perf_event__fprintf(event, fp);
 
 	if (perf_event__process_exit(tool, event, sample, machine) < 0)
 		err = -1;
@@ -1785,6 +1810,7 @@ static int process_mmap_event(struct perf_tool *tool,
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	FILE *fp;
 
 	if (perf_event__process_mmap(tool, event, sample, machine) < 0)
 		return -1;
@@ -1801,8 +1827,9 @@ static int process_mmap_event(struct perf_tool *tool,
 		sample->tid = event->mmap.tid;
 		sample->pid = event->mmap.pid;
 	}
-	fprint_sample_start(sample, thread, evsel, stdout);
-	perf_event__fprintf(event, stdout);
+	fp = tool->per_event_dump ? per_event_dump_file : stdout;
+	fprint_sample_start(sample, thread, evsel, fp);
+	perf_event__fprintf(event, fp);
 	thread__put(thread);
 	return 0;
 }
@@ -1816,6 +1843,7 @@ static int process_mmap2_event(struct perf_tool *tool,
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	FILE *fp;
 
 	if (perf_event__process_mmap2(tool, event, sample, machine) < 0)
 		return -1;
@@ -1832,8 +1860,9 @@ static int process_mmap2_event(struct perf_tool *tool,
 		sample->tid = event->mmap2.tid;
 		sample->pid = event->mmap2.pid;
 	}
-	fprint_sample_start(sample, thread, evsel, stdout);
-	perf_event__fprintf(event, stdout);
+	fp = tool->per_event_dump ? per_event_dump_file : stdout;
+	fprint_sample_start(sample, thread, evsel, fp);
+	perf_event__fprintf(event, fp);
 	thread__put(thread);
 	return 0;
 }
@@ -1847,6 +1876,7 @@ static int process_switch_event(struct perf_tool *tool,
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	FILE *fp;
 
 	if (perf_event__process_switch(tool, event, sample, machine) < 0)
 		return -1;
@@ -1858,8 +1888,9 @@ static int process_switch_event(struct perf_tool *tool,
 		return -1;
 	}
 
-	fprint_sample_start(sample, thread, evsel, stdout);
-	perf_event__fprintf(event, stdout);
+	fp = tool->per_event_dump ? per_event_dump_file : stdout;
+	fprint_sample_start(sample, thread, evsel, fp);
+	perf_event__fprintf(event, fp);
 	thread__put(thread);
 	return 0;
 }
@@ -2852,6 +2883,11 @@ int cmd_script(int argc, const char **argv)
 	file.path = input_name;
 	file.force = symbol_conf.force;
 
+	if (file.path)
+		file_name = file.path;
+	else
+		file_name = "perf.data";
+
 	if (argc > 1 && !strncmp(argv[0], "rec", strlen("rec"))) {
 		rec_script_path = get_script_path(argv[1], RECORD_SUFFIX);
 		if (!rec_script_path)
-- 
1.8.3.1
