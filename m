From: yuzhoujian <ufo19890607@gmail.com>
Subject: [PATCH 4/4] Replace printf with fprintf for all the output functions
Date: Mon, 18 Sep 2017 13:55:22 +0800
Message-ID: <1505714122-39141-5-git-send-email-yuzhoujian@didichuxing.com>
References: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 tools/perf/builtin-script.c | 187 +++++++++++++++++++++++---------------------
 1 file changed, 99 insertions(+), 88 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 89bab68..0d206b2 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -498,7 +498,7 @@ static void fprint_sample_iregs(struct perf_sample *sample,
 
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
-		printf("%5s:0x%"PRIx64" ", perf_reg_name(r), val);
+		fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
 }
 
@@ -512,25 +512,25 @@ static void fprint_sample_start(struct perf_sample *sample,
 
 	if (PRINT_FIELD(COMM)) {
 		if (latency_format)
-			printf("%8.8s ", thread__comm_str(thread));
+			fprintf(fp, "%8.8s ", thread__comm_str(thread));
 		else if (PRINT_FIELD(IP) && symbol_conf.use_callchain)
-			printf("%s ", thread__comm_str(thread));
+			fprintf(fp, "%s ", thread__comm_str(thread));
 		else
-			printf("%16s ", thread__comm_str(thread));
+			fprintf(fp, "%16s ", thread__comm_str(thread));
 	}
 
 	if (PRINT_FIELD(PID) && PRINT_FIELD(TID))
-		printf("%5d/%-5d ", sample->pid, sample->tid);
+		fprintf(fp, "%5d/%-5d ", sample->pid, sample->tid);
 	else if (PRINT_FIELD(PID))
-		printf("%5d ", sample->pid);
+		fprintf(fp, "%5d ", sample->pid);
 	else if (PRINT_FIELD(TID))
-		printf("%5d ", sample->tid);
+		fprintf(fp, "%5d ", sample->tid);
 
 	if (PRINT_FIELD(CPU)) {
 		if (latency_format)
-			printf("%3d ", sample->cpu);
+			fprintf(fp, "%3d ", sample->cpu);
 		else
-			printf("[%03d] ", sample->cpu);
+			fprintf(fp, "[%03d] ", sample->cpu);
 	}
 
 	if (PRINT_FIELD(TIME)) {
@@ -539,11 +539,11 @@ static void fprint_sample_start(struct perf_sample *sample,
 		nsecs -= secs * NSEC_PER_SEC;
 
 		if (nanosecs)
-			printf("%5lu.%09llu: ", secs, nsecs);
+			fprintf(fp, "%5lu.%09llu: ", secs, nsecs);
 		else {
 			char sample_time[32];
 			timestamp__scnprintf_usec(sample->time, sample_time, sizeof(sample_time));
-			printf("%12s: ", sample_time);
+			fprintf(fp, "%12s: ", sample_time);
 		}
 	}
 }
@@ -580,21 +580,21 @@ static void fprint_sample_brstack(struct perf_sample *sample,
 			thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, to, &alt);
 		}
 
-		printf("0x%"PRIx64, from);
+		fprintf(fp, "0x%"PRIx64, from);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
+			fprintf(fp, "(");
 			map__fprintf_dsoname(alf.map, fp);
-			printf(")");
+			fprintf(fp, ")");
 		}
 
-		printf("/0x%"PRIx64, to);
+		fprintf(fp, "/0x%"PRIx64, to);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
+			fprintf(fp, "(");
 			map__fprintf_dsoname(alt.map, fp);
-			printf(")");
+			fprintf(fp, ")");
 		}
 
-		printf("/%c/%c/%c/%d ",
+		fprintf(fp, "/%c/%c/%c/%d ",
 			mispred_str( br->entries + i),
 			br->entries[i].flags.in_tx? 'X' : '-',
 			br->entries[i].flags.abort? 'A' : '-',
@@ -631,18 +631,18 @@ static void fprint_sample_brstacksym(struct perf_sample *sample,
 
 		symbol__fprintf_symname_offs(alf.sym, &alf, fp);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
+			fprintf(fp, "(");
 			map__fprintf_dsoname(alf.map, fp);
-			printf(")");
+			fprintf(fp, ")");
 		}
-		putchar('/');
+		fputc('/', fp);
 		symbol__fprintf_symname_offs(alt.sym, &alt, fp);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
+			fprintf(fp, "(");
 			map__fprintf_dsoname(alt.map, fp);
-			printf(")");
+			fprintf(fp, ")");
 		}
-		printf("/%c/%c/%c/%d ",
+		fprintf(fp, "/%c/%c/%c/%d ",
 			mispred_str( br->entries + i),
 			br->entries[i].flags.in_tx? 'X' : '-',
 			br->entries[i].flags.abort? 'A' : '-',
@@ -677,19 +677,19 @@ static void fprint_sample_brstackoff(struct perf_sample *sample,
 		if (alt.map && !alt.map->dso->adjust_symbols)
 			to = map__map_ip(alt.map, to);
 
-		printf("0x%"PRIx64, from);
+		fprintf(fp, "0x%"PRIx64, from);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
+			fprintf(fp, "(");
 			map__fprintf_dsoname(alf.map, fp);
-			printf(")");
+			fprintf(fp, ")");
 		}
-		printf("/0x%"PRIx64, to);
+		fprintf(fp, "/0x%"PRIx64, to);
 		if (PRINT_FIELD(DSO)) {
-			printf("(");
+			fprintf(fp, "(");
 			map__fprintf_dsoname(alt.map, fp);
-			printf(")");
+			fprintf(fp, ")");
 		}
-		printf("/%c/%c/%c/%d ",
+		fprintf(fp, "/%c/%c/%c/%d ",
 			mispred_str(br->entries + i),
 			br->entries[i].flags.in_tx ? 'X' : '-',
 			br->entries[i].flags.abort ? 'A' : '-',
@@ -764,7 +764,7 @@ static void fprint_jump(uint64_t ip, struct branch_entry *en,
 		       struct perf_insn *x, u8 *inbuf, int len,
 		       int insn, FILE *fp)
 {
-	printf("\t%016" PRIx64 "\t%-30s\t#%s%s%s%s",
+	fprintf(fp, "\t%016" PRIx64 "\t%-30s\t#%s%s%s%s",
 	       ip,
 	       dump_insn(x, ip, inbuf, len, NULL),
 	       en->flags.predicted ? " PRED" : "",
@@ -772,11 +772,11 @@ static void fprint_jump(uint64_t ip, struct branch_entry *en,
 	       en->flags.in_tx ? " INTX" : "",
 	       en->flags.abort ? " ABORT" : "");
 	if (en->flags.cycles) {
-		printf(" %d cycles", en->flags.cycles);
+		fprintf(fp, " %d cycles", en->flags.cycles);
 		if (insn)
-			printf(" %.2f IPC", (float)insn / en->flags.cycles);
+			fprintf(fp, " %.2f IPC", (float)insn / en->flags.cycles);
 	}
-	putchar('\n');
+	fputc('\n', fp);
 }
 
 static void fprint_ip_sym(struct thread *thread, u8 cpumode, int cpu,
@@ -807,13 +807,13 @@ static void fprint_ip_sym(struct thread *thread, u8 cpumode, int cpu,
 		off = al.addr - al.sym->start;
 	else
 		off = al.addr - al.map->start - al.sym->start;
-	printf("\t%s", al.sym->name);
+	fprintf(fp, "\t%s", al.sym->name);
 	if (off)
-		printf("%+d", off);
-	putchar(':');
+		fprintf(fp, "%+d", off);
+	fputc(':', fp);
 	if (PRINT_FIELD(SRCLINE))
 		map__fprintf_srcline(al.map, al.addr, "\t", fp);
-	putchar('\n');
+	fputc('\n', fp);
 	*lastsym = al.sym;
 }
 
@@ -840,7 +840,7 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 	x.thread = thread;
 	x.cpu = sample->cpu;
 
-	putchar('\n');
+	fputc('\n', fp);
 
 	/* Handle first from jump, of which we don't know the entry. */
 	len = grab_bb(buffer, br->entries[nr-1].from,
@@ -856,7 +856,7 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 	/* Print all blocks */
 	for (i = nr - 2; i >= 0; i--) {
 		if (br->entries[i].from || br->entries[i].to)
-			pr_debug("%d: %" PRIx64 "-%" PRIx64 "\n", i,
+			fprintf(fp, "%d: %" PRIx64 "-%" PRIx64 "\n", i,
 				 br->entries[i].from,
 				 br->entries[i].to);
 		start = br->entries[i + 1].to;
@@ -866,7 +866,7 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 		/* Patch up missing kernel transfers due to ring filters */
 		if (len == -ENXIO && i > 0) {
 			end = br->entries[--i].from;
-			pr_debug("\tpatching up to %" PRIx64 "-%" PRIx64 "\n", start, end);
+			fprintf(fp, "\tpatching up to %" PRIx64 "-%" PRIx64 "\n", start, end);
 			len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, false);
 		}
 		if (len <= 0)
@@ -881,7 +881,7 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 				fprint_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, fp);
 				break;
 			} else {
-				printf("\t%016" PRIx64 "\t%s\n", ip,
+				fprintf(fp, "\t%016" PRIx64 "\t%s\n", ip,
 					dump_insn(&x, ip, buffer + off, len - off, &ilen));
 				if (ilen == 0)
 					break;
@@ -913,12 +913,12 @@ static void fprint_sample_brstackinsn(struct perf_sample *sample,
 		if (len <= 0)
 			return;
 
-		printf("\t%016" PRIx64 "\t%s\n", sample->ip,
+		fprintf(fp, "\t%016" PRIx64 "\t%s\n", sample->ip,
 			dump_insn(&x, sample->ip, buffer, len, NULL));
 		return;
 	}
 	for (off = 0; off <= end - start; off += ilen) {
-		printf("\t%016" PRIx64 "\t%s\n", start + off,
+		fprintf(fp, "\t%016" PRIx64 "\t%s\n", start + off,
 			dump_insn(&x, start + off, buffer + off, len - off, &ilen));
 		if (ilen == 0)
 			break;
@@ -931,7 +931,7 @@ static void fprint_sample_addr(struct perf_sample *sample,
 {
 	struct addr_location al;
 
-	printf("%16" PRIx64, sample->addr);
+	fprintf(fp, "%16" PRIx64, sample->addr);
 
 	if (!sample_addr_correlates_sym(attr))
 		return;
@@ -939,7 +939,7 @@ static void fprint_sample_addr(struct perf_sample *sample,
 	thread__resolve(thread, &al, sample);
 
 	if (PRINT_FIELD(SYM)) {
-		printf(" ");
+		fprintf(fp, " ");
 		if (PRINT_FIELD(SYMOFFSET))
 			symbol__fprintf_symname_offs(al.sym, &al, fp);
 		else
@@ -947,9 +947,9 @@ static void fprint_sample_addr(struct perf_sample *sample,
 	}
 
 	if (PRINT_FIELD(DSO)) {
-		printf(" (");
+		fprintf(fp, " (");
 		map__fprintf_dsoname(al.map, fp);
-		printf(")");
+		fprintf(fp, ")");
 	}
 }
 
@@ -992,9 +992,9 @@ static void fprint_sample_callindent(struct perf_sample *sample,
 	}
 
 	if (name)
-		len = printf("%*s%s", (int)depth * 4, "", name);
+		len = fprintf(fp, "%*s%s", (int)depth * 4, "", name);
 	else if (ip)
-		len = printf("%*s%16" PRIx64, (int)depth * 4, "", ip);
+		len = fprintf(fp, "%*s%16" PRIx64, (int)depth * 4, "", ip);
 
 	if (len < 0)
 		return;
@@ -1007,7 +1007,7 @@ static void fprint_sample_callindent(struct perf_sample *sample,
 		spacing = round_up(len + 4, 32);
 
 	if (len < spacing)
-		printf("%*s", spacing - len, "");
+		fprintf(fp, "%*s", spacing - len, "");
 }
 
 static void fprint_insn(struct perf_sample *sample,
@@ -1017,13 +1017,13 @@ static void fprint_insn(struct perf_sample *sample,
 		       FILE *fp)
 {
 	if (PRINT_FIELD(INSNLEN))
-		printf(" ilen: %d", sample->insn_len);
+		fprintf(fp, " ilen: %d", sample->insn_len);
 	if (PRINT_FIELD(INSN)) {
 		int i;
 
-		printf(" insn:");
+		fprintf(fp, " insn:");
 		for (i = 0; i < sample->insn_len; i++)
-			printf(" %02x", (unsigned char)sample->insn[i]);
+			fprintf(fp, " %02x", (unsigned char)sample->insn[i]);
 	}
 	if (PRINT_FIELD(BRSTACKINSN))
 		fprint_sample_brstackinsn(sample, thread, attr, machine, fp);
@@ -1054,13 +1054,13 @@ static void fprint_sample_bts(struct perf_sample *sample,
 			cursor = &callchain_cursor;
 
 		if (cursor == NULL) {
-			putchar(' ');
+			fputc(' ', fp);
 			if (print_opts & EVSEL__PRINT_SRCLINE) {
 				print_srcline_last = true;
 				print_opts &= ~EVSEL__PRINT_SRCLINE;
 			}
 		} else
-			putchar('\n');
+			fputc('\n', fp);
 
 		sample__fprintf_sym(sample, al, 0, print_opts, cursor, fp);
 	}
@@ -1069,7 +1069,7 @@ static void fprint_sample_bts(struct perf_sample *sample,
 	if (PRINT_FIELD(ADDR) ||
 	    ((evsel->attr.sample_type & PERF_SAMPLE_ADDR) &&
 	     !output[type].user_set)) {
-		printf(" => ");
+		fprintf(fp, " => ");
 		fprint_sample_addr(sample, thread, attr, fp);
 	}
 
@@ -1078,7 +1078,7 @@ static void fprint_sample_bts(struct perf_sample *sample,
 
 	fprint_insn(sample, attr, thread, machine, fp);
 
-	printf("\n");
+	fprintf(fp, "\n");
 }
 
 static struct {
@@ -1128,9 +1128,9 @@ static void fprint_sample_flags(u32 flags, FILE *fp)
 	str[pos] = 0;
 
 	if (name)
-		printf("  %-7s%4s ", name, in_tx ? "(x)" : "");
+		fprintf(fp, "  %-7s%4s ", name, in_tx ? "(x)" : "");
 	else
-		printf("  %-11s ", str);
+		fprintf(fp, "  %-11s ", str);
 }
 
 struct printer_data {
@@ -1151,30 +1151,30 @@ struct printer_data {
 
 	switch (op) {
 	case BINARY_PRINT_DATA_BEGIN:
-		printf("\n");
+		fprintf(fp, "\n");
 		break;
 	case BINARY_PRINT_LINE_BEGIN:
-		printf("%17s", !printer_data->line_no ? "BPF output:" :
+		fprintf(fp, "%17s", !printer_data->line_no ? "BPF output:" :
 						        "           ");
 		break;
 	case BINARY_PRINT_ADDR:
-		printf(" %04x:", val);
+		fprintf(fp, " %04x:", val);
 		break;
 	case BINARY_PRINT_NUM_DATA:
-		printf(" %02x", val);
+		fprintf(fp, " %02x", val);
 		break;
 	case BINARY_PRINT_NUM_PAD:
-		printf("   ");
+		fprintf(fp, "   ");
 		break;
 	case BINARY_PRINT_SEP:
-		printf("  ");
+		fprintf(fp, "  ");
 		break;
 	case BINARY_PRINT_CHAR_DATA:
 		if (printer_data->hit_nul && ch)
 			printer_data->is_printable = false;
 
 		if (!isprint(ch)) {
-			printf("%c", '.');
+			fprintf(fp, "%c", '.');
 
 			if (!printer_data->is_printable)
 				break;
@@ -1184,14 +1184,14 @@ struct printer_data {
 			else
 				printer_data->is_printable = false;
 		} else {
-			printf("%c", ch);
+			fprintf(fp, "%c", ch);
 		}
 		break;
 	case BINARY_PRINT_CHAR_PAD:
-		printf(" ");
+		fprintf(fp, " ");
 		break;
 	case BINARY_PRINT_LINE_END:
-		printf("\n");
+		fprintf(fp, "\n");
 		printer_data->line_no++;
 		break;
 	case BINARY_PRINT_DATA_END:
@@ -1209,14 +1209,14 @@ static void fprint_sample_bpf_output(struct perf_sample *sample, FILE *fp)
 		     fprint_sample_bpf_output_printer, &printer_data);
 
 	if (printer_data.is_printable && printer_data.hit_nul)
-		printf("%17s \"%s\"\n", "BPF string:",
+		fprintf(fp, "%17s \"%s\"\n", "BPF string:",
 		       (char *)(sample->raw_data));
 }
 
 static void fprint_sample_spacing(int len, int spacing, FILE *fp)
 {
 	if (len > 0 && len < spacing)
-		printf("%*s", spacing - len, "");
+		fprintf(fp, "%*s", spacing - len, "");
 }
 
 static void fprint_sample_pt_spacing(int len, FILE *fp)
@@ -1232,7 +1232,7 @@ static void fprint_sample_synth_ptwrite(struct perf_sample *sample, FILE *fp)
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = printf(" IP: %u payload: %#" PRIx64 " ",
+	len = fprintf(fp, " IP: %u payload: %#" PRIx64 " ",
 		     data->ip, le64_to_cpu(data->payload));
 	fprint_sample_pt_spacing(len, fp);
 }
@@ -1245,7 +1245,7 @@ static void fprint_sample_synth_mwait(struct perf_sample *sample, FILE *fp)
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = printf(" hints: %#x extensions: %#x ",
+	len = fprintf(fp, " hints: %#x extensions: %#x ",
 		     data->hints, data->extensions);
 	fprint_sample_pt_spacing(len, fp);
 }
@@ -1258,7 +1258,7 @@ static void fprint_sample_synth_pwre(struct perf_sample *sample, FILE *fp)
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = printf(" hw: %u cstate: %u sub-cstate: %u ",
+	len = fprintf(fp, " hw: %u cstate: %u sub-cstate: %u ",
 		     data->hw, data->cstate, data->subcstate);
 	fprint_sample_pt_spacing(len, fp);
 }
@@ -1271,7 +1271,7 @@ static void fprint_sample_synth_exstop(struct perf_sample *sample, FILE *fp)
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = printf(" IP: %u ", data->ip);
+	len = fprintf(fp, " IP: %u ", data->ip);
 	fprint_sample_pt_spacing(len, fp);
 }
 
@@ -1283,7 +1283,7 @@ static void fprint_sample_synth_pwrx(struct perf_sample *sample, FILE *fp)
 	if (perf_sample__bad_synth_size(sample, *data))
 		return;
 
-	len = printf(" deepest cstate: %u last cstate: %u wake reason: %#x ",
+	len = fprintf(fp, " deepest cstate: %u last cstate: %u wake reason: %#x ",
 		     data->deepest_cstate, data->last_cstate,
 		     data->wake_reason);
 	fprint_sample_pt_spacing(len, fp);
@@ -1299,10 +1299,10 @@ static void fprint_sample_synth_cbr(struct perf_sample *sample, FILE *fp)
 		return;
 
 	freq = (le32_to_cpu(data->freq) + 500) / 1000;
-	len = printf(" cbr: %2u freq: %4u MHz ", data->cbr, freq);
+	len = fprintf(fp, " cbr: %2u freq: %4u MHz ", data->cbr, freq);
 	if (data->max_nonturbo) {
 		percent = (5 + (1000 * data->cbr) / data->max_nonturbo) / 10;
-		len += printf("(%3u%%) ", percent);
+		len += fprintf(fp, "(%3u%%) ", percent);
 	}
 	fprint_sample_pt_spacing(len, fp);
 }
@@ -1377,7 +1377,7 @@ static size_t data_src__fprintf(u64 data_src, FILE *fp)
 	if (maxlen < len)
 		maxlen = len;
 
-	return printf("%-*s", maxlen, out);
+	return fprintf(fp, "%-*s", maxlen, out);
 }
 
 static void process_event(struct perf_script *script,
@@ -1389,21 +1389,30 @@ static void process_event(struct perf_script *script,
 	struct perf_event_attr *attr = &evsel->attr;
 	unsigned int type = output_type(attr->type);
 
+	const char *evname;
+	char *file_name;
 	if (output[type].fields == 0)
 		return;
 
+	evname = perf_evsel__name(evsel);
+	if (script->tool.per_event_dump == true) {
+		if (asprintf(&file_name, "%s%s", evname, ".stack") < 0)
+			file_name = NULL;
+		fp = fopen(file_name, "a+");
+		if (!fp)
+			return;
+		free(file_name);
+	}
 	fprint_sample_start(sample, thread, evsel, fp);
 
 	if (PRINT_FIELD(PERIOD))
-		printf("%10" PRIu64 " ", sample->period);
+		fprintf(fp, "%10" PRIu64 " ", sample->period);
 
 	if (PRINT_FIELD(EVNAME)) {
-		const char *evname = perf_evsel__name(evsel);
-
 		if (!script->name_width)
 			script->name_width = perf_evlist__max_name_len(script->session->evlist);
 
-		printf("%*s: ", script->name_width,
+		fprintf(fp, "%*s: ", script->name_width,
 		       evname ? evname : "[unknown]");
 	}
 
@@ -1429,7 +1438,7 @@ static void process_event(struct perf_script *script,
 		data_src__fprintf(sample->data_src, fp);
 
 	if (PRINT_FIELD(WEIGHT))
-		printf("%16" PRIu64, sample->weight);
+		fprintf(fp, "%16" PRIu64, sample->weight);
 
 	if (PRINT_FIELD(IP)) {
 		struct callchain_cursor *cursor = NULL;
@@ -1439,7 +1448,7 @@ static void process_event(struct perf_script *script,
 					      sample, NULL, NULL, scripting_max_stack) == 0)
 			cursor = &callchain_cursor;
 
-		putchar(cursor ? '\n' : ' ');
+		fputc(cursor ? '\n' : ' ', fp);
 		sample__fprintf_sym(sample, al, 0, output[type].print_ip_opts, cursor, fp);
 	}
 
@@ -1456,7 +1465,9 @@ static void process_event(struct perf_script *script,
 	if (perf_evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
 		fprint_sample_bpf_output(sample, fp);
 	fprint_insn(sample, attr, thread, machine, fp);
-	printf("\n");
+	fprintf(fp, "\n");
+	if (script->tool.per_event_dump == true)
+		fclose(fp);
 }
 
 static struct scripting_ops	*scripting_ops;
-- 
1.8.3.1
