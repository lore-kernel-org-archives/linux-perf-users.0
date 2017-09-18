From: yuzhoujian <ufo19890607@gmail.com>
Subject: [PATCH 2/4] Makes all those related functions receive the FILE pointer
Date: Mon, 18 Sep 2017 13:55:20 +0800
Message-ID: <1505714122-39141-3-git-send-email-yuzhoujian@didichuxing.com>
References: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 tools/perf/builtin-script.c | 247 ++++++++++++++++++++++++--------------------
 1 file changed, 136 insertions(+), 111 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 91b5225..f709f6f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -486,8 +486,8 @@ static int perf_session__check_output_opt(struct perf_session *session)
 	return 0;
 }
 
-static void print_sample_iregs(struct perf_sample *sample,
-			  struct perf_event_attr *attr)
+static void fprint_sample_iregs(struct perf_sample *sample,
+			  struct perf_event_attr *attr, FILE *fp)
 {
 	struct regs_dump *regs = &sample->intr_regs;
 	uint64_t mask = attr->sample_regs_intr;
@@ -502,9 +502,9 @@ static void print_sample_iregs(struct perf_sample *sample,
 	}
 }
 
-static void print_sample_start(struct perf_sample *sample,
+static void fprint_sample_start(struct perf_sample *sample,
 			       struct thread *thread,
-			       struct perf_evsel *evsel)
+			       struct perf_evsel *evsel, FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	unsigned long secs;
@@ -557,9 +557,10 @@ static void print_sample_start(struct perf_sample *sample,
 	return br->flags.predicted ? 'P' : 'M';
 }
 
-static void print_sample_brstack(struct perf_sample *sample,
+static void fprint_sample_brstack(struct perf_sample *sample,
 				 struct thread *thread,
-				 struct perf_event_attr *attr)
+				 struct perf_event_attr *attr,
+				 FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct addr_location alf, alt;
@@ -582,14 +583,14 @@ static void print_sample_brstack(struct perf_sample *sample,
 		printf("0x%"PRIx64, from);
 		if (PRINT_FIELD(DSO)) {
 			printf("(");
-			map__fprintf_dsoname(alf.map, stdout);
+			map__fprintf_dsoname(alf.map, fp);
 			printf(")");
 		}
 
 		printf("/0x%"PRIx64, to);
 		if (PRINT_FIELD(DSO)) {
 			printf("(");
-			map__fprintf_dsoname(alt.map, stdout);
+			map__fprintf_dsoname(alt.map, fp);
 			printf(")");
 		}
 
@@ -601,9 +602,10 @@ static void print_sample_brstack(struct perf_sample *sample,
 	}
 }
 
-static void print_sample_brstacksym(struct perf_sample *sample,
+static void fprint_sample_brstacksym(struct perf_sample *sample,
 				    struct thread *thread,
-				    struct perf_event_attr *attr)
+				    struct perf_event_attr *attr,
+				    FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct addr_location alf, alt;
@@ -627,17 +629,17 @@ static void print_sample_brstacksym(struct perf_sample *sample,
 		if (alt.map)
 			alt.sym = map__find_symbol(alt.map, alt.addr);
 
-		symbol__fprintf_symname_offs(alf.sym, &alf, stdout);
+		symbol__fprintf_symname_offs(alf.sym, &alf, fp);
 		if (PRINT_FIELD(DSO)) {
 			printf("(");
-			map__fprintf_dsoname(alf.map, stdout);
+			map__fprintf_dsoname(alf.map, fp);
 			printf(")");
 		}
 		putchar('/');
-		symbol__fprintf_symname_offs(alt.sym, &alt, stdout);
+		symbol__fprintf_symname_offs(alt.sym, &alt, fp);
 		if (PRINT_FIELD(DSO)) {
 			printf("(");
-			map__fprintf_dsoname(alt.map, stdout);
+			map__fprintf_dsoname(alt.map, fp);
 			printf(")");
 		}
 		printf("/%c/%c/%c/%d ",
@@ -648,9 +650,10 @@ static void print_sample_brstacksym(struct perf_sample *sample,
 	}
 }
 
-static void print_sample_brstackoff(struct perf_sample *sample,
+static void fprint_sample_brstackoff(struct perf_sample *sample,
 				    struct thread *thread,
-				    struct perf_event_attr *attr)
+				    struct perf_event_attr *attr,
+				    FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct addr_location alf, alt;
@@ -677,13 +680,13 @@ static void print_sample_brstackoff(struct perf_sample *sample,
 		printf("0x%"PRIx64, from);
 		if (PRINT_FIELD(DSO)) {
 			printf("(");
-			map__fprintf_dsoname(alf.map, stdout);
+			map__fprintf_dsoname(alf.map, fp);
 			printf(")");
 		}
 		printf("/0x%"PRIx64, to);
 		if (PRINT_FIELD(DSO)) {
 			printf("(");
-			map__fprintf_dsoname(alt.map, stdout);
+			map__fprintf_dsoname(alt.map, fp);
 			printf(")");
 		}
 		printf("/%c/%c/%c/%d ",
@@ -757,9 +760,9 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	return len;
 }
 
-static void print_jump(uint64_t ip, struct branch_entry *en,
+static void fprint_jump(uint64_t ip, struct branch_entry *en,
 		       struct perf_insn *x, u8 *inbuf, int len,
-		       int insn)
+		       int insn, FILE *fp)
 {
 	printf("\t%016" PRIx64 "\t%-30s\t#%s%s%s%s",
 	       ip,
@@ -776,9 +779,9 @@ static void print_jump(uint64_t ip, struct branch_entry *en,
 	putchar('\n');
 }
 
-static void print_ip_sym(struct thread *thread, u8 cpumode, int cpu,
+static void fprint_ip_sym(struct thread *thread, u8 cpumode, int cpu,
 			 uint64_t addr, struct symbol **lastsym,
-			 struct perf_event_attr *attr)
+			 struct perf_event_attr *attr, FILE *fp)
 {
 	struct addr_location al;
 	int off;
@@ -809,15 +812,16 @@ static void print_ip_sym(struct thread *thread, u8 cpumode, int cpu,
 		printf("%+d", off);
 	putchar(':');
 	if (PRINT_FIELD(SRCLINE))
-		map__fprintf_srcline(al.map, al.addr, "\t", stdout);
+		map__fprintf_srcline(al.map, al.addr, "\t", fp);
 	putchar('\n');
 	*lastsym = al.sym;
 }
 
-static void print_sample_brstackinsn(struct perf_sample *sample,
+static void fprint_sample_brstackinsn(struct perf_sample *sample,
 				     struct thread *thread,
 				     struct perf_event_attr *attr,
-				     struct machine *machine)
+				     struct machine *machine,
+				     FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	u64 start, end;
@@ -843,10 +847,10 @@ static void print_sample_brstackinsn(struct perf_sample *sample,
 			br->entries[nr-1].from,
 			machine, thread, &x.is64bit, &x.cpumode, false);
 	if (len > 0) {
-		print_ip_sym(thread, x.cpumode, x.cpu,
-			     br->entries[nr - 1].from, &lastsym, attr);
-		print_jump(br->entries[nr - 1].from, &br->entries[nr - 1],
-			    &x, buffer, len, 0);
+		fprint_ip_sym(thread, x.cpumode, x.cpu,
+			     br->entries[nr - 1].from, &lastsym, attr, fp);
+		fprint_jump(br->entries[nr - 1].from, &br->entries[nr - 1],
+			    &x, buffer, len, 0, fp);
 	}
 
 	/* Print all blocks */
@@ -872,9 +876,9 @@ static void print_sample_brstackinsn(struct perf_sample *sample,
 		for (off = 0;; off += ilen) {
 			uint64_t ip = start + off;
 
-			print_ip_sym(thread, x.cpumode, x.cpu, ip, &lastsym, attr);
+			fprint_ip_sym(thread, x.cpumode, x.cpu, ip, &lastsym, attr, fp);
 			if (ip == end) {
-				print_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn);
+				fprint_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, fp);
 				break;
 			} else {
 				printf("\t%016" PRIx64 "\t%s\n", ip,
@@ -901,7 +905,7 @@ static void print_sample_brstackinsn(struct perf_sample *sample,
 	start = br->entries[0].to;
 	end = sample->ip;
 	len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, true);
-	print_ip_sym(thread, x.cpumode, x.cpu, start, &lastsym, attr);
+	fprint_ip_sym(thread, x.cpumode, x.cpu, start, &lastsym, attr, fp);
 	if (len <= 0) {
 		/* Print at least last IP if basic block did not work */
 		len = grab_bb(buffer, sample->ip, sample->ip,
@@ -921,9 +925,9 @@ static void print_sample_brstackinsn(struct perf_sample *sample,
 	}
 }
 
-static void print_sample_addr(struct perf_sample *sample,
+static void fprint_sample_addr(struct perf_sample *sample,
 			  struct thread *thread,
-			  struct perf_event_attr *attr)
+			  struct perf_event_attr *attr, FILE *fp)
 {
 	struct addr_location al;
 
@@ -937,22 +941,23 @@ static void print_sample_addr(struct perf_sample *sample,
 	if (PRINT_FIELD(SYM)) {
 		printf(" ");
 		if (PRINT_FIELD(SYMOFFSET))
-			symbol__fprintf_symname_offs(al.sym, &al, stdout);
+			symbol__fprintf_symname_offs(al.sym, &al, fp);
 		else
-			symbol__fprintf_symname(al.sym, stdout);
+			symbol__fprintf_symname(al.sym, fp);
 	}
 
 	if (PRINT_FIELD(DSO)) {
 		printf(" (");
-		map__fprintf_dsoname(al.map, stdout);
+		map__fprintf_dsoname(al.map, fp);
 		printf(")");
 	}
 }
 
-static void print_sample_callindent(struct perf_sample *sample,
+static void fprint_sample_callindent(struct perf_sample *sample,
 				    struct perf_evsel *evsel,
 				    struct thread *thread,
-				    struct addr_location *al)
+				    struct addr_location *al,
+				    FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	size_t depth = thread_stack__depth(thread);
@@ -1005,10 +1010,11 @@ static void print_sample_callindent(struct perf_sample *sample,
 		printf("%*s", spacing - len, "");
 }
 
-static void print_insn(struct perf_sample *sample,
+static void fprint_insn(struct perf_sample *sample,
 		       struct perf_event_attr *attr,
 		       struct thread *thread,
-		       struct machine *machine)
+		       struct machine *machine,
+		       FILE *fp)
 {
 	if (PRINT_FIELD(INSNLEN))
 		printf(" ilen: %d", sample->insn_len);
@@ -1020,21 +1026,22 @@ static void print_insn(struct perf_sample *sample,
 			printf(" %02x", (unsigned char)sample->insn[i]);
 	}
 	if (PRINT_FIELD(BRSTACKINSN))
-		print_sample_brstackinsn(sample, thread, attr, machine);
+		fprint_sample_brstackinsn(sample, thread, attr, machine, fp);
 }
 
-static void print_sample_bts(struct perf_sample *sample,
+static void fprint_sample_bts(struct perf_sample *sample,
 			     struct perf_evsel *evsel,
 			     struct thread *thread,
 			     struct addr_location *al,
-			     struct machine *machine)
+			     struct machine *machine,
+			     FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->attr;
 	unsigned int type = output_type(attr->type);
 	bool print_srcline_last = false;
 
 	if (PRINT_FIELD(CALLINDENT))
-		print_sample_callindent(sample, evsel, thread, al);
+		fprint_sample_callindent(sample, evsel, thread, al, fp);
 
 	/* print branch_from information */
 	if (PRINT_FIELD(IP)) {
@@ -1055,7 +1062,7 @@ static void print_sample_bts(struct perf_sample *sample,
 		} else
 			putchar('\n');
 
-		sample__fprintf_sym(sample, al, 0, print_opts, cursor, stdout);
+		sample__fprintf_sym(sample, al, 0, print_opts, cursor, fp);
 	}
 
 	/* print branch_to information */
@@ -1063,13 +1070,13 @@ static void print_sample_bts(struct perf_sample *sample,
 	    ((evsel->attr.sample_type & PERF_SAMPLE_ADDR) &&
 	     !output[type].user_set)) {
 		printf(" => ");
-		print_sample_addr(sample, thread, attr);
+		fprint_sample_addr(sample, thread, attr, fp);
 	}
 
 	if (print_srcline_last)
-		map__fprintf_srcline(al->map, al->addr, "\n  ", stdout);
+		map__fprintf_srcline(al->map, al->addr, "\n  ", fp);
 
-	print_insn(sample, attr, thread, machine);
+	fprint_insn(sample, attr, thread, machine, fp);
 
 	printf("\n");
 }
@@ -1094,7 +1101,7 @@ static void print_sample_bts(struct perf_sample *sample,
 	{0, NULL}
 };
 
-static void print_sample_flags(u32 flags)
+static void fprint_sample_flags(u32 flags, FILE *fp)
 {
 	const char *chars = PERF_IP_FLAG_CHARS;
 	const int n = strlen(PERF_IP_FLAG_CHARS);
@@ -1130,15 +1137,17 @@ struct printer_data {
 	int line_no;
 	bool hit_nul;
 	bool is_printable;
+	FILE *fp;
 };
 
 static void
-print_sample_bpf_output_printer(enum binary_printer_ops op,
+fprint_sample_bpf_output_printer(enum binary_printer_ops op,
 				unsigned int val,
 				void *extra)
 {
 	unsigned char ch = (unsigned char)val;
 	struct printer_data *printer_data = extra;
+	FILE *fp = printer_data->fp;
 
 	switch (op) {
 	case BINARY_PRINT_DATA_BEGIN:
@@ -1191,31 +1200,31 @@ struct printer_data {
 	}
 }
 
-static void print_sample_bpf_output(struct perf_sample *sample)
+static void fprint_sample_bpf_output(struct perf_sample *sample, FILE *fp)
 {
 	unsigned int nr_bytes = sample->raw_size;
-	struct printer_data printer_data = {0, false, true};
+	struct printer_data printer_data = {0, false, true, fp};
 
 	print_binary(sample->raw_data, nr_bytes, 8,
-		     print_sample_bpf_output_printer, &printer_data);
+		     fprint_sample_bpf_output_printer, &printer_data);
 
 	if (printer_data.is_printable && printer_data.hit_nul)
 		printf("%17s \"%s\"\n", "BPF string:",
 		       (char *)(sample->raw_data));
 }
 
-static void print_sample_spacing(int len, int spacing)
+static void fprint_sample_spacing(int len, int spacing, FILE *fp)
 {
 	if (len > 0 && len < spacing)
 		printf("%*s", spacing - len, "");
 }
 
-static void print_sample_pt_spacing(int len)
+static void fprint_sample_pt_spacing(int len, FILE *fp)
 {
-	print_sample_spacing(len, 34);
+	fprint_sample_spacing(len, 34, fp);
 }
 
-static void print_sample_synth_ptwrite(struct perf_sample *sample)
+static void fprint_sample_synth_ptwrite(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_ptwrite *data = perf_sample__synth_ptr(sample);
 	int len;
@@ -1225,10 +1234,10 @@ static void print_sample_synth_ptwrite(struct perf_sample *sample)
 
 	len = printf(" IP: %u payload: %#" PRIx64 " ",
 		     data->ip, le64_to_cpu(data->payload));
-	print_sample_pt_spacing(len);
+	fprint_sample_pt_spacing(len, fp);
 }
 
-static void print_sample_synth_mwait(struct perf_sample *sample)
+static void fprint_sample_synth_mwait(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_mwait *data = perf_sample__synth_ptr(sample);
 	int len;
@@ -1238,10 +1247,10 @@ static void print_sample_synth_mwait(struct perf_sample *sample)
 
 	len = printf(" hints: %#x extensions: %#x ",
 		     data->hints, data->extensions);
-	print_sample_pt_spacing(len);
+	fprint_sample_pt_spacing(len, fp);
 }
 
-static void print_sample_synth_pwre(struct perf_sample *sample)
+static void fprint_sample_synth_pwre(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_pwre *data = perf_sample__synth_ptr(sample);
 	int len;
@@ -1251,10 +1260,10 @@ static void print_sample_synth_pwre(struct perf_sample *sample)
 
 	len = printf(" hw: %u cstate: %u sub-cstate: %u ",
 		     data->hw, data->cstate, data->subcstate);
-	print_sample_pt_spacing(len);
+	fprint_sample_pt_spacing(len, fp);
 }
 
-static void print_sample_synth_exstop(struct perf_sample *sample)
+static void fprint_sample_synth_exstop(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_exstop *data = perf_sample__synth_ptr(sample);
 	int len;
@@ -1263,10 +1272,10 @@ static void print_sample_synth_exstop(struct perf_sample *sample)
 		return;
 
 	len = printf(" IP: %u ", data->ip);
-	print_sample_pt_spacing(len);
+	fprint_sample_pt_spacing(len, fp);
 }
 
-static void print_sample_synth_pwrx(struct perf_sample *sample)
+static void fprint_sample_synth_pwrx(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_pwrx *data = perf_sample__synth_ptr(sample);
 	int len;
@@ -1277,10 +1286,10 @@ static void print_sample_synth_pwrx(struct perf_sample *sample)
 	len = printf(" deepest cstate: %u last cstate: %u wake reason: %#x ",
 		     data->deepest_cstate, data->last_cstate,
 		     data->wake_reason);
-	print_sample_pt_spacing(len);
+	fprint_sample_pt_spacing(len, fp);
 }
 
-static void print_sample_synth_cbr(struct perf_sample *sample)
+static void fprint_sample_synth_cbr(struct perf_sample *sample, FILE *fp)
 {
 	struct perf_synth_intel_cbr *data = perf_sample__synth_ptr(sample);
 	unsigned int percent, freq;
@@ -1295,30 +1304,30 @@ static void print_sample_synth_cbr(struct perf_sample *sample)
 		percent = (5 + (1000 * data->cbr) / data->max_nonturbo) / 10;
 		len += printf("(%3u%%) ", percent);
 	}
-	print_sample_pt_spacing(len);
+	fprint_sample_pt_spacing(len, fp);
 }
 
-static void print_sample_synth(struct perf_sample *sample,
-			       struct perf_evsel *evsel)
+static void fprint_sample_synth(struct perf_sample *sample,
+			       struct perf_evsel *evsel, FILE *fp)
 {
 	switch (evsel->attr.config) {
 	case PERF_SYNTH_INTEL_PTWRITE:
-		print_sample_synth_ptwrite(sample);
+		fprint_sample_synth_ptwrite(sample, fp);
 		break;
 	case PERF_SYNTH_INTEL_MWAIT:
-		print_sample_synth_mwait(sample);
+		fprint_sample_synth_mwait(sample, fp);
 		break;
 	case PERF_SYNTH_INTEL_PWRE:
-		print_sample_synth_pwre(sample);
+		fprint_sample_synth_pwre(sample, fp);
 		break;
 	case PERF_SYNTH_INTEL_EXSTOP:
-		print_sample_synth_exstop(sample);
+		fprint_sample_synth_exstop(sample, fp);
 		break;
 	case PERF_SYNTH_INTEL_PWRX:
-		print_sample_synth_pwrx(sample);
+		fprint_sample_synth_pwrx(sample, fp);
 		break;
 	case PERF_SYNTH_INTEL_CBR:
-		print_sample_synth_cbr(sample);
+		fprint_sample_synth_cbr(sample, fp);
 		break;
 	default:
 		break;
@@ -1354,7 +1363,7 @@ static int perf_evlist__max_name_len(struct perf_evlist *evlist)
 	return max;
 }
 
-static size_t data_src__printf(u64 data_src)
+static size_t data_src__fprintf(u64 data_src, FILE *fp)
 {
 	struct mem_info mi = { .data_src.val = data_src };
 	char decode[100];
@@ -1374,7 +1383,7 @@ static size_t data_src__printf(u64 data_src)
 static void process_event(struct perf_script *script,
 			  struct perf_sample *sample, struct perf_evsel *evsel,
 			  struct addr_location *al,
-			  struct machine *machine)
+			  struct machine *machine, FILE *fp)
 {
 	struct thread *thread = al->thread;
 	struct perf_event_attr *attr = &evsel->attr;
@@ -1383,7 +1392,7 @@ static void process_event(struct perf_script *script,
 	if (output[type].fields == 0)
 		return;
 
-	print_sample_start(sample, thread, evsel);
+	fprint_sample_start(sample, thread, evsel, fp);
 
 	if (PRINT_FIELD(PERIOD))
 		printf("%10" PRIu64 " ", sample->period);
@@ -1399,25 +1408,25 @@ static void process_event(struct perf_script *script,
 	}
 
 	if (print_flags)
-		print_sample_flags(sample->flags);
+		fprint_sample_flags(sample->flags, fp);
 
 	if (is_bts_event(attr)) {
-		print_sample_bts(sample, evsel, thread, al, machine);
+		fprint_sample_bts(sample, evsel, thread, al, machine, fp);
 		return;
 	}
 
 	if (PRINT_FIELD(TRACE))
-		event_format__print(evsel->tp_format, sample->cpu,
-				    sample->raw_data, sample->raw_size);
+		event_format__fprintf(evsel->tp_format, sample->cpu,
+				    sample->raw_data, sample->raw_size, fp);
 
 	if (attr->type == PERF_TYPE_SYNTH && PRINT_FIELD(SYNTH))
-		print_sample_synth(sample, evsel);
+		fprint_sample_synth(sample, evsel, fp);
 
 	if (PRINT_FIELD(ADDR))
-		print_sample_addr(sample, thread, attr);
+		fprint_sample_addr(sample, thread, attr, fp);
 
 	if (PRINT_FIELD(DATA_SRC))
-		data_src__printf(sample->data_src);
+		data_src__fprintf(sample->data_src, fp);
 
 	if (PRINT_FIELD(WEIGHT))
 		printf("%16" PRIu64, sample->weight);
@@ -1431,22 +1440,22 @@ static void process_event(struct perf_script *script,
 			cursor = &callchain_cursor;
 
 		putchar(cursor ? '\n' : ' ');
-		sample__fprintf_sym(sample, al, 0, output[type].print_ip_opts, cursor, stdout);
+		sample__fprintf_sym(sample, al, 0, output[type].print_ip_opts, cursor, fp);
 	}
 
 	if (PRINT_FIELD(IREGS))
-		print_sample_iregs(sample, attr);
+		fprint_sample_iregs(sample, attr, fp);
 
 	if (PRINT_FIELD(BRSTACK))
-		print_sample_brstack(sample, thread, attr);
+		fprint_sample_brstack(sample, thread, attr, fp);
 	else if (PRINT_FIELD(BRSTACKSYM))
-		print_sample_brstacksym(sample, thread, attr);
+		fprint_sample_brstacksym(sample, thread, attr, fp);
 	else if (PRINT_FIELD(BRSTACKOFF))
-		print_sample_brstackoff(sample, thread, attr);
+		fprint_sample_brstackoff(sample, thread, attr, fp);
 
 	if (perf_evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
-		print_sample_bpf_output(sample);
-	print_insn(sample, attr, thread, machine);
+		fprint_sample_bpf_output(sample, fp);
+	fprint_insn(sample, attr, thread, machine, fp);
 	printf("\n");
 }
 
@@ -1526,6 +1535,7 @@ static int process_sample_event(struct perf_tool *tool,
 {
 	struct perf_script *scr = container_of(tool, struct perf_script, tool);
 	struct addr_location al;
+	FILE *fp;
 
 	if (perf_time__skip_sample(&scr->ptime, sample->time))
 		return 0;
@@ -1555,8 +1565,10 @@ static int process_sample_event(struct perf_tool *tool,
 
 	if (scripting_ops)
 		scripting_ops->process_event(event, sample, evsel, &al);
-	else
-		process_event(scr, sample, evsel, &al, machine);
+	else {
+		fp = stdout;
+		process_event(scr, sample, evsel, &al, machine, fp);
+	}
 
 out_put:
 	addr_location__put(&al);
@@ -1605,6 +1617,7 @@ static int process_comm_event(struct perf_tool *tool,
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 	int ret = -1;
+	FILE *fp;
 
 	thread = machine__findnew_thread(machine, event->comm.pid, event->comm.tid);
 	if (thread == NULL) {
@@ -1621,8 +1634,9 @@ static int process_comm_event(struct perf_tool *tool,
 		sample->tid = event->comm.tid;
 		sample->pid = event->comm.pid;
 	}
-	print_sample_start(sample, thread, evsel);
-	perf_event__fprintf(event, stdout);
+	fp = stdout;
+	fprint_sample_start(sample, thread, evsel, fp);
+	perf_event__fprintf(event, fp);
 	ret = 0;
 out:
 	thread__put(thread);
@@ -1639,6 +1653,7 @@ static int process_namespaces_event(struct perf_tool *tool,
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
 	int ret = -1;
+	FILE *fp;
 
 	thread = machine__findnew_thread(machine, event->namespaces.pid,
 					 event->namespaces.tid);
@@ -1656,8 +1671,9 @@ static int process_namespaces_event(struct perf_tool *tool,
 		sample->tid = event->namespaces.tid;
 		sample->pid = event->namespaces.pid;
 	}
-	print_sample_start(sample, thread, evsel);
-	perf_event__fprintf(event, stdout);
+	fp = stdout;
+	fprint_sample_start(sample, thread, evsel, fp);
+	perf_event__fprintf(event, fp);
 	ret = 0;
 out:
 	thread__put(thread);
@@ -1673,6 +1689,7 @@ static int process_fork_event(struct perf_tool *tool,
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	FILE *fp;
 
 	if (perf_event__process_fork(tool, event, sample, machine) < 0)
 		return -1;
@@ -1689,8 +1706,9 @@ static int process_fork_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	print_sample_start(sample, thread, evsel);
-	perf_event__fprintf(event, stdout);
+	fp = stdout;
+	fprint_sample_start(sample, thread, evsel, fp);
+	perf_event__fprintf(event, fp);
 	thread__put(thread);
 
 	return 0;
@@ -1705,6 +1723,7 @@ static int process_exit_event(struct perf_tool *tool,
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	FILE *fp;
 
 	thread = machine__findnew_thread(machine, event->fork.pid, event->fork.tid);
 	if (thread == NULL) {
@@ -1718,8 +1737,9 @@ static int process_exit_event(struct perf_tool *tool,
 		sample->tid = event->fork.tid;
 		sample->pid = event->fork.pid;
 	}
-	print_sample_start(sample, thread, evsel);
-	perf_event__fprintf(event, stdout);
+	fp = stdout;
+	fprint_sample_start(sample, thread, evsel, fp);
+	perf_event__fprintf(event, fp);
 
 	if (perf_event__process_exit(tool, event, sample, machine) < 0)
 		err = -1;
@@ -1737,6 +1757,7 @@ static int process_mmap_event(struct perf_tool *tool,
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	FILE *fp;
 
 	if (perf_event__process_mmap(tool, event, sample, machine) < 0)
 		return -1;
@@ -1753,8 +1774,9 @@ static int process_mmap_event(struct perf_tool *tool,
 		sample->tid = event->mmap.tid;
 		sample->pid = event->mmap.pid;
 	}
-	print_sample_start(sample, thread, evsel);
-	perf_event__fprintf(event, stdout);
+	fp = stdout;
+	fprint_sample_start(sample, thread, evsel, fp);
+	perf_event__fprintf(event, fp);
 	thread__put(thread);
 	return 0;
 }
@@ -1768,6 +1790,7 @@ static int process_mmap2_event(struct perf_tool *tool,
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	FILE *fp;
 
 	if (perf_event__process_mmap2(tool, event, sample, machine) < 0)
 		return -1;
@@ -1784,8 +1807,9 @@ static int process_mmap2_event(struct perf_tool *tool,
 		sample->tid = event->mmap2.tid;
 		sample->pid = event->mmap2.pid;
 	}
-	print_sample_start(sample, thread, evsel);
-	perf_event__fprintf(event, stdout);
+	fp = stdout;
+	fprint_sample_start(sample, thread, evsel, fp);
+	perf_event__fprintf(event, fp);
 	thread__put(thread);
 	return 0;
 }
@@ -1799,7 +1823,7 @@ static int process_switch_event(struct perf_tool *tool,
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 	struct perf_session *session = script->session;
 	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
-
+	FILE *fp;
 	if (perf_event__process_switch(tool, event, sample, machine) < 0)
 		return -1;
 
@@ -1810,8 +1834,9 @@ static int process_switch_event(struct perf_tool *tool,
 		return -1;
 	}
 
-	print_sample_start(sample, thread, evsel);
-	perf_event__fprintf(event, stdout);
+	fp = stdout;
+	fprint_sample_start(sample, thread, evsel, fp);
+	perf_event__fprintf(event, fp);
 	thread__put(thread);
 	return 0;
 }
-- 
1.8.3.1
