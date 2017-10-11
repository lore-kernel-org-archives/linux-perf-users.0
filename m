From: ufo19890607 <ufo19890607@gmail.com>
Subject: [PATCH v3 3/4] Replace printf with fprintf for all print functions
Date: Thu, 12 Oct 2017 02:23:59 +0800
Message-ID: <1507746240-34638-4-git-send-email-ufo19890607@gmail.com>
References: <1507746240-34638-1-git-send-email-ufo19890607@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507746240-34638-1-git-send-email-ufo19890607@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

This patch will replace printf with fprintf for all print functions in the
builtin-script in order to support the per-event-dump option.

Changes since v2:
- none

Changes since v1:
- remove the fp_selection_helper function for setting the fp argument, and use
 a local variable to do the same thing.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 tools/perf/builtin-script.c | 178 ++++++++++++++++++++++----------------------
 1 file changed, 89 insertions(+), 89 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 4b51dd1..8c297f0 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -512,7 +512,7 @@ static void fprint_sample_iregs(struct perf_sample *sample,
 
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
-		printf("%5s:0x%"PRIx64" ", perf_reg_name(r), val);
+		fprintf(stdout, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
 }
 
@@ -526,11 +526,11 @@ static void fprint_sample_uregs(struct perf_sample *sample,
 	if (!regs || !regs->regs)
 		return;
 
-	printf(" ABI:%" PRIu64 " ", regs->abi);
+	fprintf(stdout, " ABI:%" PRIu64 " ", regs->abi);
 
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
-		printf("%5s:0x%"PRIx64" ", perf_reg_name(r), val);
+		fprintf(stdout, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
 }
 
@@ -544,25 +544,25 @@ static void fprint_sample_start(struct perf_sample *sample,
 
 	if (PRINT_FIELD(COMM)) {
 		if (latency_format)
-			printf("%8.8s ", thread__comm_str(thread));
+			fprintf(stdout, "%8.8s ", thread__comm_str(thread));
 		else if (PRINT_FIELD(IP) && symbol_conf.use_callchain)
-			printf("%s ", thread__comm_str(thread));
+			fprintf(stdout, "%s ", thread__comm_str(thread));
 		else
-			printf("%16s ", thread__comm_str(thread));
+			fprintf(stdout, "%16s ", thread__comm_str(thread));
 	}
 
 	if (PRINT_FIELD(PID) && PRINT_FIELD(TID))
-		printf("%5d/%-5d ", sample->pid, sample->tid);
+		fprintf(stdout, "%5d/%-5d ", sample->pid, sample->tid);
 	else if (PRINT_FIELD(PID))
-		printf("%5d ", sample->pid);
+		fprintf(stdout, "%5d ", sample->pid);
 	else if (PRINT_FIELD(TID))
-		printf("%5d ", sample->tid);
+		fprintf(stdout, "%5d ", sample->tid);
 
 	if (PRINT_FIELD(CPU)) {
 		if (latency_format)
-			printf("%3d ", sample->cpu);
+			fprintf(stdout, "%3d ", sample->cpu);
 		else
-			printf("[%03d] ", sample->cpu);
+			fprintf(stdout, "[%03d] ", sample->cpu);
 	}
 
 	if (PRINT_FIELD(TIME)) {
@@ -571,11 +571,11 @@ static void fprint_sample_start(struct perf_sample *sample,
 		nsecs -= secs * NSEC_PER_SEC;
 
 		if (nanosecs)
-			printf("%5lu.%09llu: ", secs, nsecs);
+			fprintf(stdout, "%5lu.%09llu: ", secs, nsecs);
 		else {
 			char sample_time[32];
 			timestamp__scnprintf_usec(sample->time, sample_time, sizeof(sample_time));
-			printf("%12s: ", sample_time);
+			fprintf(stdout, "%12s: ", sample_time);
 		}
 	}
 }
@@ -612,21 +612,21 @@ static void fprint_sample_brstack(struct perf_sample *sample,
 			thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, to, &alt);
 		}
 
-		printf(" 0x%"PRIx64, from);
+		fprintf(stdout, " 0x%"PRIx64, from);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
+			fprintf(stdout, "(");
 			map__fprintf_dsoname(alf.map, stdout);
-			printf(")");
+			fprintf(stdout, ")");
 		}
 
-		printf("/0x%"PRIx64, to);
+		fprintf(stdout, "/0x%"PRIx64, to);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
+			fprintf(stdout, "(");
 			map__fprintf_dsoname(alt.map, stdout);
-			printf(")");
+			fprintf(stdout, ")");
 		}
 
-		printf("/%c/%c/%c/%d ",
+		fprintf(stdout, "/%c/%c/%c/%d ",
 			mispred_str( br->entries + i),
 			br->entries[i].flags.in_tx? 'X' : '-',
 			br->entries[i].flags.abort? 'A' : '-',
@@ -663,18 +663,18 @@ static void fprint_sample_brstacksym(struct perf_sample *sample,
 
 		symbol__fprintf_symname_offs(alf.sym, &alf, stdout);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
+			fprintf(stdout, "(");
 			map__fprintf_dsoname(alf.map, stdout);
-			printf(")");
+			fprintf(stdout, ")");
 		}
-		putchar('/');
+		fputc('/', stdout);
 		symbol__fprintf_symname_offs(alt.sym, &alt, stdout);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
+			fprintf(stdout, "(");
 			map__fprintf_dsoname(alt.map, stdout);
-			printf(")");
+			fprintf(stdout, ")");
 		}
-		printf("/%c/%c/%c/%d ",
+		fprintf(stdout, "/%c/%c/%c/%d ",
 			mispred_str( br->entries + i),
 			br->entries[i].flags.in_tx? 'X' : '-',
 			br->entries[i].flags.abort? 'A' : '-',
@@ -709,19 +709,19 @@ static void fprint_sample_brstackoff(struct perf_sample *sample,
 		if (alt.map && !alt.map->dso->adjust_symbols)
 			to = map__map_ip(alt.map, to);
 
-		printf(" 0x%"PRIx64, from);
+		fprintf(stdout, " 0x%"PRIx64, from);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
+			fprintf(stdout, "(");
 			map__fprintf_dsoname(alf.map, stdout);
-			printf(")");
+			fprintf(stdout, ")");
 		}
-		printf("/0x%"PRIx64, to);
+		fprintf(stdout, "/0x%"PRIx64, to);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
+			fprintf(stdout, "(");
 			map__fprintf_dsoname(alt.map, stdout);
-			printf(")");
+			fprintf(stdout, ")");
 		}
-		printf("/%c/%c/%c/%d ",
+		fprintf(stdout, "/%c/%c/%c/%d ",
 			mispred_str(br->entries + i),
 			br->entries[i].flags.in_tx ? 'X' : '-',
 			br->entries[i].flags.abort ? 'A' : '-',
@@ -796,7 +796,7 @@ static void fprint_jump(uint64_t ip, struct branch_entry *en,
 		       struct perf_insn *x, u8 *inbuf, int len,
 		       int insn, FILE *fp __maybe_unused)
 {
-	printf("\t%016" PRIx64 "\t%-30s\t#%s%s%s%s",
+	fprintf(stdout, "\t%016" PRIx64 "\t%-30s\t#%s%s%s%s",
 	       ip,
 	       dump_insn(x, ip, inbuf, len, NULL),
 	       en->flags.predicted ? " PRED" : "",
@@ -804,11 +804,11 @@ static void fprint_jump(uint64_t ip, struct branch_entry *en,
 	       en->flags.in_tx ? " INTX" : "",
 	       en->flags.abort ? " ABORT" : "");
 	if (en->flags.cycles) {
-		printf(" %d cycles", en->flags.cycles);
+		fprintf(stdout, " %d cycles", en->flags.cycles);
 		if (insn)
-			printf(" %.2f IPC", (float)insn / en->flags.cycles);
+			fprintf(stdout, " %.2f IPC", (float)insn / en->flags.cycles);
 	}
-	putchar('\n');
+	fputc('\n', stdout);
 }
 
 static void fprint_ip_sym(struct thread *thread, u8 cpumode, int cpu,
@@ -840,13 +840,13 @@ static void fprint_ip_sym(struct thread *thread, u8 cpumode, int cpu,
 		off = al.addr - al.sym->start;
 	else
 		off = al.addr - al.map->start - al.sym->start;
-	printf("\t%s", al.sym->name);
+	fprintf(stdout, "\t%s", al.sym->name);
 	if (off)
-		printf("%+d", off);
-	putchar(':');
+		fprintf(stdout, "%+d", off);
+	fputc(':', stdout);
 	if (PRINT_FIELD(SRCLINE))
 		map__fprintf_srcline(al.map, al.addr, "\t", stdout);
-	putchar('\n');
+	fputc('\n', stdout);
 	*lastsym = al.sym;
 }
 
@@ -873,7 +873,7 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 	x.thread = thread;
 	x.cpu = sample->cpu;
 
-	putchar('\n');
+	fputc('\n', stdout);
 
 	/* Handle first from jump, of which we don't know the entry. */
 	len = grab_bb(buffer, br->entries[nr-1].from,
@@ -889,7 +889,7 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 	/* Print all blocks */
 	for (i = nr - 2; i >= 0; i--) {
 		if (br->entries[i].from || br->entries[i].to)
-			pr_debug("%d: %" PRIx64 "-%" PRIx64 "\n", i,
+			fprintf(stdout, "%d: %" PRIx64 "-%" PRIx64 "\n", i,
 				 br->entries[i].from,
 				 br->entries[i].to);
 		start = br->entries[i + 1].to;
@@ -899,7 +899,7 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 		/* Patch up missing kernel transfers due to ring filters */
 		if (len == -ENXIO && i > 0) {
 			end = br->entries[--i].from;
-			pr_debug("\tpatching up to %" PRIx64 "-%" PRIx64 "\n", start, end);
+			fprintf(stdout, "\tpatching up to %" PRIx64 "-%" PRIx64 "\n", start, end);
 			len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, false);
 		}
 		if (len <= 0)
@@ -914,7 +914,7 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 				fprint_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, stdout);
 				break;
 			} else {
-				printf("\t%016" PRIx64 "\t%s\n", ip,
+				fprintf(stdout, "\t%016" PRIx64 "\t%s\n", ip,
 					dump_insn(&x, ip, buffer + off, len - off, &ilen));
 				if (ilen == 0)
 					break;
@@ -946,12 +946,12 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 		if (len <= 0)
 			return;
 
-		printf("\t%016" PRIx64 "\t%s\n", sample->ip,
+		fprintf(stdout, "\t%016" PRIx64 "\t%s\n", sample->ip,
 			dump_insn(&x, sample->ip, buffer, len, NULL));
 		return;
 	}
 	for (off = 0; off <= end - start; off += ilen) {
-		printf("\t%016" PRIx64 "\t%s\n", start + off,
+		fprintf(stdout, "\t%016" PRIx64 "\t%s\n", start + off,
 			dump_insn(&x, start + off, buffer + off, len - off, &ilen));
 		if (ilen == 0)
 			break;
@@ -965,7 +965,7 @@ static void fprint_sample_addr(struct perf_sample *sample,
 {
 	struct addr_location al;
 
-	printf("%16" PRIx64, sample->addr);
+	fprintf(stdout, "%16" PRIx64, sample->addr);
 
 	if (!sample_addr_correlates_sym(attr))
 		return;
@@ -973,7 +973,7 @@ static void fprint_sample_addr(struct perf_sample *sample,
 	thread__resolve(thread, &al, sample);
 
 	if (PRINT_FIELD(SYM)) {
-		printf(" ");
+		fprintf(stdout, " ");
 		if (PRINT_FIELD(SYMOFFSET))
 			symbol__fprintf_symname_offs(al.sym, &al, stdout);
 		else
@@ -981,9 +981,9 @@ static void fprint_sample_addr(struct perf_sample *sample,
 	}
 
 	if (PRINT_FIELD(DSO)) {
-		printf(" (");
+		fprintf(stdout, " (");
 		map__fprintf_dsoname(al.map, stdout);
-		printf(")");
+		fprintf(stdout, ")");
 	}
 }
 
@@ -1026,9 +1026,9 @@ static void fprint_sample_callindent(struct perf_sample *sample,
 	}
 
 	if (name)
-		len = printf("%*s%s", (int)depth * 4, "", name);
+		len = fprintf(stdout, "%*s%s", (int)depth * 4, "", name);
 	else if (ip)
-		len = printf("%*s%16" PRIx64, (int)depth * 4, "", ip);
+		len = fprintf(stdout, "%*s%16" PRIx64, (int)depth * 4, "", ip);
 
 	if (len < 0)
 		return;
@@ -1041,7 +1041,7 @@ static void fprint_sample_callindent(struct perf_sample *sample,
 		spacing = round_up(len + 4, 32);
 
 	if (len < spacing)
-		printf("%*s", spacing - len, "");
+		fprintf(stdout, "%*s", spacing - len, "");
 }
 
 static void fprint_insn(struct perf_sample *sample,
@@ -1051,13 +1051,13 @@ static void fprint_insn(struct perf_sample *sample,
 		       FILE *fp __maybe_unused)
 {
 	if (PRINT_FIELD(INSNLEN))
-		printf(" ilen: %d", sample->insn_len);
+		fprintf(stdout, " ilen: %d", sample->insn_len);
 	if (PRINT_FIELD(INSN)) {
 		int i;
 
-		printf(" insn:");
+		fprintf(stdout, " insn:");
 		for (i = 0; i < sample->insn_len; i++)
-			printf(" %02x", (unsigned char)sample->insn[i]);
+			fprintf(stdout, " %02x", (unsigned char)sample->insn[i]);
 	}
 	if (PRINT_FIELD(BRSTACKINSN))
 		fprint_sample_brstackinsn(sample, thread, attr, machine, stdout);
@@ -1088,13 +1088,13 @@ static void fprint_sample_bts(struct perf_sample *sample,
 			cursor = &callchain_cursor;
 
 		if (cursor == NULL) {
-			putchar(' ');
+			fputc(' ', stdout);
 			if (print_opts & EVSEL__PRINT_SRCLINE) {
 				print_srcline_last = true;
 				print_opts &= ~EVSEL__PRINT_SRCLINE;
 			}
 		} else
-			putchar('\n');
+			fputc('\n', stdout);
 
 		sample__fprintf_sym(sample, al, 0, print_opts, cursor, stdout);
 	}
@@ -1103,7 +1103,7 @@ static void fprint_sample_bts(struct perf_sample *sample,
 	if (PRINT_FIELD(ADDR) ||
 	    ((evsel->attr.sample_type & PERF_SAMPLE_ADDR) &&
 	     !output[type].user_set)) {
-		printf(" => ");
+		fprintf(stdout, " => ");
 		fprint_sample_addr(sample, thread, attr, stdout);
 	}
 
@@ -1112,7 +1112,7 @@ static void fprint_sample_bts(struct perf_sample *sample,
 
 	fprint_insn(sample, attr, thread, machine, stdout);
 
-	printf("\n");
+	fprintf(stdout, "\n");
 }
 
 static struct {
@@ -1162,9 +1162,9 @@ static void fprint_sample_flags(u32 flags, FILE *fp __maybe_unused)
 	str[pos] = 0;
 
 	if (name)
-		printf("  %-7s%4s ", name, in_tx ? "(x)" : "");
+		fprintf(stdout, "  %-7s%4s ", name, in_tx ? "(x)" : "");
 	else
-		printf("  %-11s ", str);
+		fprintf(stdout, "  %-11s ", str);
 }
 
 struct printer_data {
@@ -1184,30 +1184,30 @@ struct printer_data {
 
 	switch (op) {
 	case BINARY_PRINT_DATA_BEGIN:
-		printf("\n");
+		fprintf(stdout, "\n");
 		break;
 	case BINARY_PRINT_LINE_BEGIN:
-		printf("%17s", !printer_data->line_no ? "BPF output:" :
+		fprintf(stdout, "%17s", !printer_data->line_no ? "BPF output:" :
 						        "           ");
 		break;
 	case BINARY_PRINT_ADDR:
-		printf(" %04x:", val);
+		fprintf(stdout, " %04x:", val);
 		break;
 	case BINARY_PRINT_NUM_DATA:
-		printf(" %02x", val);
+		fprintf(stdout, " %02x", val);
 		break;
 	case BINARY_PRINT_NUM_PAD:
-		printf("   ");
+		fprintf(stdout, "   ");
 		break;
 	case BINARY_PRINT_SEP:
-		printf("  ");
+		fprintf(stdout, "  ");
 		break;
 	case BINARY_PRINT_CHAR_DATA:
 		if (printer_data->hit_nul && ch)
 			printer_data->is_printable = false;
 
 		if (!isprint(ch)) {
-			printf("%c", '.');
+			fprintf(stdout, "%c", '.');
 
 			if (!printer_data->is_printable)
 				break;
@@ -1217,14 +1217,14 @@ struct printer_data {
 			else
 				printer_data->is_printable = false;
 		} else {
-			printf("%c", ch);
+			fprintf(stdout, "%c", ch);
 		}
 		break;
 	case BINARY_PRINT_CHAR_PAD:
-		printf(" ");
+		fprintf(stdout, " ");
 		break;
 	case BINARY_PRINT_LINE_END:
-		printf("\n");
+		fprintf(stdout, "\n");
 		printer_data->line_no++;
 		break;
 	case BINARY_PRINT_DATA_END:
@@ -1242,14 +1242,14 @@ static void fprint_sample_bpf_output(struct perf_sample *sample, FILE *fp __mayb
 		     fprint_sample_bpf_output_printer, &printer_data);
 
 	if (printer_data.is_printable && printer_data.hit_nul)
-		printf("%17s \"%s\"\n", "BPF string:",
+		fprintf(stdout, "%17s \"%s\"\n", "BPF string:",
 		       (char *)(sample->raw_data));
 }
 
 static void fprint_sample_spacing(int len, int spacing, FILE *fp __maybe_unused)
 {
 	if (len > 0 && len < spacing)
-		printf("%*s", spacing - len, "");
+		fprintf(stdout, "%*s", spacing - len, "");
 }
 
 static void fprint_sample_pt_spacing(int len, FILE *fp __maybe_unused)
@@ -1265,7 +1265,7 @@ static void fprint_sample_synth_ptwrite(struct perf_sample *sample, FILE *fp __m
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = printf(" IP: %u payload: %#" PRIx64 " ",
+	len = fprintf(stdout, " IP: %u payload: %#" PRIx64 " ",
 		     data->ip, le64_to_cpu(data->payload));
 	fprint_sample_pt_spacing(len, stdout);
 }
@@ -1278,7 +1278,7 @@ static void fprint_sample_synth_mwait(struct perf_sample *sample, FILE *fp __may
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = printf(" hints: %#x extensions: %#x ",
+	len = fprintf(stdout, " hints: %#x extensions: %#x ",
 		     data->hints, data->extensions);
 	fprint_sample_pt_spacing(len, stdout);
 }
@@ -1291,7 +1291,7 @@ static void fprint_sample_synth_pwre(struct perf_sample *sample, FILE *fp __mayb
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = printf(" hw: %u cstate: %u sub-cstate: %u ",
+	len = fprintf(stdout, " hw: %u cstate: %u sub-cstate: %u ",
 		     data->hw, data->cstate, data->subcstate);
 	fprint_sample_pt_spacing(len, stdout);
 }
@@ -1304,7 +1304,7 @@ static void fprint_sample_synth_exstop(struct perf_sample *sample, FILE *fp __ma
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = printf(" IP: %u ", data->ip);
+	len = fprintf(stdout, " IP: %u ", data->ip);
 	fprint_sample_pt_spacing(len, stdout);
 }
 
@@ -1316,7 +1316,7 @@ static void fprint_sample_synth_pwrx(struct perf_sample *sample, FILE *fp __mayb
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = printf(" deepest cstate: %u last cstate: %u wake reason: %#x ",
+	len = fprintf(stdout, " deepest cstate: %u last cstate: %u wake reason: %#x ",
 		     data->deepest_cstate, data->last_cstate,
 		     data->wake_reason);
 	fprint_sample_pt_spacing(len, stdout);
@@ -1332,10 +1332,10 @@ static void fprint_sample_synth_cbr(struct perf_sample *sample, FILE *fp __maybe
 		return;
 
 	freq = (le32_to_cpu(data->freq) + 500) / 1000;
-	len = printf(" cbr: %2u freq: %4u MHz ", data->cbr, freq);
+	len = fprintf(stdout, " cbr: %2u freq: %4u MHz ", data->cbr, freq);
 	if (data->max_nonturbo) {
 		percent = (5 + (1000 * data->cbr) / data->max_nonturbo) / 10;
-		len += printf("(%3u%%) ", percent);
+		len += fprintf(stdout, "(%3u%%) ", percent);
 	}
 	fprint_sample_pt_spacing(len, stdout);
 }
@@ -1410,7 +1410,7 @@ static size_t data_src__fprintf(u64 data_src, FILE *fp __maybe_unused)
 	if (maxlen < len)
 		maxlen = len;
 
-	return printf("%-*s", maxlen, out);
+	return fprintf(stdout, "%-*s", maxlen, out);
 }
 
 static void process_event(struct perf_script *script,
@@ -1428,7 +1428,7 @@ static void process_event(struct perf_script *script,
 	fprint_sample_start(sample, thread, evsel, stdout);
 
 	if (PRINT_FIELD(PERIOD))
-		printf("%10" PRIu64 " ", sample->period);
+		fprintf(stdout, "%10" PRIu64 " ", sample->period);
 
 	if (PRINT_FIELD(EVNAME)) {
 		const char *evname = perf_evsel__name(evsel);
@@ -1436,7 +1436,7 @@ static void process_event(struct perf_script *script,
 		if (!script->name_width)
 			script->name_width = perf_evlist__max_name_len(script->session->evlist);
 
-		printf("%*s: ", script->name_width,
+		fprintf(stdout, "%*s: ", script->name_width,
 		       evname ? evname : "[unknown]");
 	}
 
@@ -1462,7 +1462,7 @@ static void process_event(struct perf_script *script,
 		data_src__fprintf(sample->data_src, stdout);
 
 	if (PRINT_FIELD(WEIGHT))
-		printf("%16" PRIu64, sample->weight);
+		fprintf(stdout, "%16" PRIu64, sample->weight);
 
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
@@ -1472,7 +1472,7 @@ static void process_event(struct perf_script *script,
 					      sample, NULL, NULL, scripting_max_stack) == 0)
 			cursor = &callchain_cursor;
 
-		putchar(cursor ? '\n' : ' ');
+		fputc(cursor ? '\n' : ' ', stdout);
 		sample__fprintf_sym(sample, al, 0, output[type].print_ip_opts, cursor, stdout);
 	}
 
@@ -1494,8 +1494,8 @@ static void process_event(struct perf_script *script,
 	fprint_insn(sample, attr, thread, machine, stdout);
 
 	if (PRINT_FIELD(PHYS_ADDR))
-		printf("%16" PRIx64, sample->phys_addr);
-	printf("\n");
+		fprintf(stdout, "%16" PRIx64, sample->phys_addr);
+	fprintf(stdout, "\n");
 }
 
 static struct scripting_ops	*scripting_ops;
-- 
1.8.3.1
