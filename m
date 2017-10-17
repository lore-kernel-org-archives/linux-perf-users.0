From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 2/4] Add fp argument to print functions
Date: Tue, 17 Oct 2017 11:01:38 -0300
Message-ID: <20171017140137.GD4204@kernel.org>
References: <1507746240-34638-1-git-send-email-ufo19890607@gmail.com>
 <1507746240-34638-3-git-send-email-ufo19890607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507746240-34638-3-git-send-email-ufo19890607@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ufo19890607 <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Oct 12, 2017 at 02:23:58AM +0800, ufo19890607 escreveu:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> This patch will add the fp argument to all the print functions so that they can use different
> file pointer to print on the screen or dump in the file.
> 
> Changes since v2:
> - none
> 
> Changes since v1:
> - add the __maybe_unused attribute for the fp argument in all the print functions,
>  because the fp is not used in this patch but needed in the later patches.
> - split the original patch(Makes all those related functions receive the FILE
>  pointer) to two simple patches, and this is the first part.

Please take a look at my perf/core branch, I've implemented it as I
suggested, no __maybe_unused was needed, as we go using it straight
away, just passing stdout for now.

More specifically:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=817d5c11c31c7459d4bd6c5ccbd6ada455c595b2

I'll look at the other patches soon,

- Arnaldo
 
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> ---
>  tools/perf/builtin-script.c | 190 +++++++++++++++++++++++---------------------
>  1 file changed, 100 insertions(+), 90 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 4ffa716..4b51dd1 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -500,8 +500,8 @@ static int perf_session__check_output_opt(struct perf_session *session)
>  	return 0;
>  }
>  
> -static void print_sample_iregs(struct perf_sample *sample,
> -			  struct perf_event_attr *attr)
> +static void fprint_sample_iregs(struct perf_sample *sample,
> +			  struct perf_event_attr *attr, FILE *fp __maybe_unused)
>  {
>  	struct regs_dump *regs = &sample->intr_regs;
>  	uint64_t mask = attr->sample_regs_intr;
> @@ -516,8 +516,8 @@ static void print_sample_iregs(struct perf_sample *sample,
>  	}
>  }
>  
> -static void print_sample_uregs(struct perf_sample *sample,
> -			  struct perf_event_attr *attr)
> +static void fprint_sample_uregs(struct perf_sample *sample,
> +			  struct perf_event_attr *attr, FILE *fp __maybe_unused)
>  {
>  	struct regs_dump *regs = &sample->user_regs;
>  	uint64_t mask = attr->sample_regs_user;
> @@ -534,9 +534,9 @@ static void print_sample_uregs(struct perf_sample *sample,
>  	}
>  }
>  
> -static void print_sample_start(struct perf_sample *sample,
> +static void fprint_sample_start(struct perf_sample *sample,
>  			       struct thread *thread,
> -			       struct perf_evsel *evsel)
> +			       struct perf_evsel *evsel, FILE *fp __maybe_unused)
>  {
>  	struct perf_event_attr *attr = &evsel->attr;
>  	unsigned long secs;
> @@ -589,9 +589,10 @@ static void print_sample_start(struct perf_sample *sample,
>  	return br->flags.predicted ? 'P' : 'M';
>  }
>  
> -static void print_sample_brstack(struct perf_sample *sample,
> +static void fprint_sample_brstack(struct perf_sample *sample,
>  				 struct thread *thread,
> -				 struct perf_event_attr *attr)
> +				 struct perf_event_attr *attr,
> +				 FILE *fp __maybe_unused)
>  {
>  	struct branch_stack *br = sample->branch_stack;
>  	struct addr_location alf, alt;
> @@ -633,9 +634,10 @@ static void print_sample_brstack(struct perf_sample *sample,
>  	}
>  }
>  
> -static void print_sample_brstacksym(struct perf_sample *sample,
> +static void fprint_sample_brstacksym(struct perf_sample *sample,
>  				    struct thread *thread,
> -				    struct perf_event_attr *attr)
> +				    struct perf_event_attr *attr,
> +				    FILE *fp __maybe_unused)
>  {
>  	struct branch_stack *br = sample->branch_stack;
>  	struct addr_location alf, alt;
> @@ -680,9 +682,10 @@ static void print_sample_brstacksym(struct perf_sample *sample,
>  	}
>  }
>  
> -static void print_sample_brstackoff(struct perf_sample *sample,
> +static void fprint_sample_brstackoff(struct perf_sample *sample,
>  				    struct thread *thread,
> -				    struct perf_event_attr *attr)
> +				    struct perf_event_attr *attr,
> +				    FILE *fp __maybe_unused)
>  {
>  	struct branch_stack *br = sample->branch_stack;
>  	struct addr_location alf, alt;
> @@ -789,9 +792,9 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
>  	return len;
>  }
>  
> -static void print_jump(uint64_t ip, struct branch_entry *en,
> +static void fprint_jump(uint64_t ip, struct branch_entry *en,
>  		       struct perf_insn *x, u8 *inbuf, int len,
> -		       int insn)
> +		       int insn, FILE *fp __maybe_unused)
>  {
>  	printf("\t%016" PRIx64 "\t%-30s\t#%s%s%s%s",
>  	       ip,
> @@ -808,9 +811,10 @@ static void print_jump(uint64_t ip, struct branch_entry *en,
>  	putchar('\n');
>  }
>  
> -static void print_ip_sym(struct thread *thread, u8 cpumode, int cpu,
> +static void fprint_ip_sym(struct thread *thread, u8 cpumode, int cpu,
>  			 uint64_t addr, struct symbol **lastsym,
> -			 struct perf_event_attr *attr)
> +			 struct perf_event_attr *attr,
> +			 FILE *fp __maybe_unused)
>  {
>  	struct addr_location al;
>  	int off;
> @@ -846,10 +850,11 @@ static void print_ip_sym(struct thread *thread, u8 cpumode, int cpu,
>  	*lastsym = al.sym;
>  }
>  
> -static void print_sample_brstackinsn(struct perf_sample *sample,
> +static void fprint_sample_brstackinsn(struct perf_sample *sample,
>  				     struct thread *thread,
>  				     struct perf_event_attr *attr,
> -				     struct machine *machine)
> +				     struct machine *machine,
> +				     FILE *fp __maybe_unused)
>  {
>  	struct branch_stack *br = sample->branch_stack;
>  	u64 start, end;
> @@ -875,10 +880,10 @@ static void print_sample_brstackinsn(struct perf_sample *sample,
>  			br->entries[nr-1].from,
>  			machine, thread, &x.is64bit, &x.cpumode, false);
>  	if (len > 0) {
> -		print_ip_sym(thread, x.cpumode, x.cpu,
> -			     br->entries[nr - 1].from, &lastsym, attr);
> -		print_jump(br->entries[nr - 1].from, &br->entries[nr - 1],
> -			    &x, buffer, len, 0);
> +		fprint_ip_sym(thread, x.cpumode, x.cpu,
> +			     br->entries[nr - 1].from, &lastsym, attr, stdout);
> +		fprint_jump(br->entries[nr - 1].from, &br->entries[nr - 1],
> +			    &x, buffer, len, 0, stdout);
>  	}
>  
>  	/* Print all blocks */
> @@ -904,9 +909,9 @@ static void print_sample_brstackinsn(struct perf_sample *sample,
>  		for (off = 0;; off += ilen) {
>  			uint64_t ip = start + off;
>  
> -			print_ip_sym(thread, x.cpumode, x.cpu, ip, &lastsym, attr);
> +			fprint_ip_sym(thread, x.cpumode, x.cpu, ip, &lastsym, attr, stdout);
>  			if (ip == end) {
> -				print_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn);
> +				fprint_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, stdout);
>  				break;
>  			} else {
>  				printf("\t%016" PRIx64 "\t%s\n", ip,
> @@ -933,7 +938,7 @@ static void print_sample_brstackinsn(struct perf_sample *sample,
>  	start = br->entries[0].to;
>  	end = sample->ip;
>  	len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, true);
> -	print_ip_sym(thread, x.cpumode, x.cpu, start, &lastsym, attr);
> +	fprint_ip_sym(thread, x.cpumode, x.cpu, start, &lastsym, attr, stdout);
>  	if (len <= 0) {
>  		/* Print at least last IP if basic block did not work */
>  		len = grab_bb(buffer, sample->ip, sample->ip,
> @@ -953,9 +958,10 @@ static void print_sample_brstackinsn(struct perf_sample *sample,
>  	}
>  }
>  
> -static void print_sample_addr(struct perf_sample *sample,
> +static void fprint_sample_addr(struct perf_sample *sample,
>  			  struct thread *thread,
> -			  struct perf_event_attr *attr)
> +			  struct perf_event_attr *attr,
> +			  FILE *fp __maybe_unused)
>  {
>  	struct addr_location al;
>  
> @@ -981,10 +987,11 @@ static void print_sample_addr(struct perf_sample *sample,
>  	}
>  }
>  
> -static void print_sample_callindent(struct perf_sample *sample,
> +static void fprint_sample_callindent(struct perf_sample *sample,
>  				    struct perf_evsel *evsel,
>  				    struct thread *thread,
> -				    struct addr_location *al)
> +				    struct addr_location *al,
> +				    FILE *fp __maybe_unused)
>  {
>  	struct perf_event_attr *attr = &evsel->attr;
>  	size_t depth = thread_stack__depth(thread);
> @@ -1037,10 +1044,11 @@ static void print_sample_callindent(struct perf_sample *sample,
>  		printf("%*s", spacing - len, "");
>  }
>  
> -static void print_insn(struct perf_sample *sample,
> +static void fprint_insn(struct perf_sample *sample,
>  		       struct perf_event_attr *attr,
>  		       struct thread *thread,
> -		       struct machine *machine)
> +		       struct machine *machine,
> +		       FILE *fp __maybe_unused)
>  {
>  	if (PRINT_FIELD(INSNLEN))
>  		printf(" ilen: %d", sample->insn_len);
> @@ -1052,21 +1060,22 @@ static void print_insn(struct perf_sample *sample,
>  			printf(" %02x", (unsigned char)sample->insn[i]);
>  	}
>  	if (PRINT_FIELD(BRSTACKINSN))
> -		print_sample_brstackinsn(sample, thread, attr, machine);
> +		fprint_sample_brstackinsn(sample, thread, attr, machine, stdout);
>  }
>  
> -static void print_sample_bts(struct perf_sample *sample,
> +static void fprint_sample_bts(struct perf_sample *sample,
>  			     struct perf_evsel *evsel,
>  			     struct thread *thread,
>  			     struct addr_location *al,
> -			     struct machine *machine)
> +			     struct machine *machine,
> +			     FILE *fp __maybe_unused)
>  {
>  	struct perf_event_attr *attr = &evsel->attr;
>  	unsigned int type = output_type(attr->type);
>  	bool print_srcline_last = false;
>  
>  	if (PRINT_FIELD(CALLINDENT))
> -		print_sample_callindent(sample, evsel, thread, al);
> +		fprint_sample_callindent(sample, evsel, thread, al, stdout);
>  
>  	/* print branch_from information */
>  	if (PRINT_FIELD(IP)) {
> @@ -1095,13 +1104,13 @@ static void print_sample_bts(struct perf_sample *sample,
>  	    ((evsel->attr.sample_type & PERF_SAMPLE_ADDR) &&
>  	     !output[type].user_set)) {
>  		printf(" => ");
> -		print_sample_addr(sample, thread, attr);
> +		fprint_sample_addr(sample, thread, attr, stdout);
>  	}
>  
>  	if (print_srcline_last)
>  		map__fprintf_srcline(al->map, al->addr, "\n  ", stdout);
>  
> -	print_insn(sample, attr, thread, machine);
> +	fprint_insn(sample, attr, thread, machine, stdout);
>  
>  	printf("\n");
>  }
> @@ -1126,7 +1135,7 @@ static void print_sample_bts(struct perf_sample *sample,
>  	{0, NULL}
>  };
>  
> -static void print_sample_flags(u32 flags)
> +static void fprint_sample_flags(u32 flags, FILE *fp __maybe_unused)
>  {
>  	const char *chars = PERF_IP_FLAG_CHARS;
>  	const int n = strlen(PERF_IP_FLAG_CHARS);
> @@ -1162,10 +1171,11 @@ struct printer_data {
>  	int line_no;
>  	bool hit_nul;
>  	bool is_printable;
> +	FILE *fp;
>  };
>  
>  static void
> -print_sample_bpf_output_printer(enum binary_printer_ops op,
> +fprint_sample_bpf_output_printer(enum binary_printer_ops op,
>  				unsigned int val,
>  				void *extra)
>  {
> @@ -1223,31 +1233,31 @@ struct printer_data {
>  	}
>  }
>  
> -static void print_sample_bpf_output(struct perf_sample *sample)
> +static void fprint_sample_bpf_output(struct perf_sample *sample, FILE *fp __maybe_unused)
>  {
>  	unsigned int nr_bytes = sample->raw_size;
> -	struct printer_data printer_data = {0, false, true};
> +	struct printer_data printer_data = {0, false, true, stdout};
>  
>  	print_binary(sample->raw_data, nr_bytes, 8,
> -		     print_sample_bpf_output_printer, &printer_data);
> +		     fprint_sample_bpf_output_printer, &printer_data);
>  
>  	if (printer_data.is_printable && printer_data.hit_nul)
>  		printf("%17s \"%s\"\n", "BPF string:",
>  		       (char *)(sample->raw_data));
>  }
>  
> -static void print_sample_spacing(int len, int spacing)
> +static void fprint_sample_spacing(int len, int spacing, FILE *fp __maybe_unused)
>  {
>  	if (len > 0 && len < spacing)
>  		printf("%*s", spacing - len, "");
>  }
>  
> -static void print_sample_pt_spacing(int len)
> +static void fprint_sample_pt_spacing(int len, FILE *fp __maybe_unused)
>  {
> -	print_sample_spacing(len, 34);
> +	fprint_sample_spacing(len, 34, stdout);
>  }
>  
> -static void print_sample_synth_ptwrite(struct perf_sample *sample)
> +static void fprint_sample_synth_ptwrite(struct perf_sample *sample, FILE *fp __maybe_unused)
>  {
>  	struct perf_synth_intel_ptwrite *data = perf_sample__synth_ptr(sample);
>  	int len;
> @@ -1257,10 +1267,10 @@ static void print_sample_synth_ptwrite(struct perf_sample *sample)
>  
>  	len = printf(" IP: %u payload: %#" PRIx64 " ",
>  		     data->ip, le64_to_cpu(data->payload));
> -	print_sample_pt_spacing(len);
> +	fprint_sample_pt_spacing(len, stdout);
>  }
>  
> -static void print_sample_synth_mwait(struct perf_sample *sample)
> +static void fprint_sample_synth_mwait(struct perf_sample *sample, FILE *fp __maybe_unused)
>  {
>  	struct perf_synth_intel_mwait *data = perf_sample__synth_ptr(sample);
>  	int len;
> @@ -1270,10 +1280,10 @@ static void print_sample_synth_mwait(struct perf_sample *sample)
>  
>  	len = printf(" hints: %#x extensions: %#x ",
>  		     data->hints, data->extensions);
> -	print_sample_pt_spacing(len);
> +	fprint_sample_pt_spacing(len, stdout);
>  }
>  
> -static void print_sample_synth_pwre(struct perf_sample *sample)
> +static void fprint_sample_synth_pwre(struct perf_sample *sample, FILE *fp __maybe_unused)
>  {
>  	struct perf_synth_intel_pwre *data = perf_sample__synth_ptr(sample);
>  	int len;
> @@ -1283,10 +1293,10 @@ static void print_sample_synth_pwre(struct perf_sample *sample)
>  
>  	len = printf(" hw: %u cstate: %u sub-cstate: %u ",
>  		     data->hw, data->cstate, data->subcstate);
> -	print_sample_pt_spacing(len);
> +	fprint_sample_pt_spacing(len, stdout);
>  }
>  
> -static void print_sample_synth_exstop(struct perf_sample *sample)
> +static void fprint_sample_synth_exstop(struct perf_sample *sample, FILE *fp __maybe_unused)
>  {
>  	struct perf_synth_intel_exstop *data = perf_sample__synth_ptr(sample);
>  	int len;
> @@ -1295,10 +1305,10 @@ static void print_sample_synth_exstop(struct perf_sample *sample)
>  		return;
>  
>  	len = printf(" IP: %u ", data->ip);
> -	print_sample_pt_spacing(len);
> +	fprint_sample_pt_spacing(len, stdout);
>  }
>  
> -static void print_sample_synth_pwrx(struct perf_sample *sample)
> +static void fprint_sample_synth_pwrx(struct perf_sample *sample, FILE *fp __maybe_unused)
>  {
>  	struct perf_synth_intel_pwrx *data = perf_sample__synth_ptr(sample);
>  	int len;
> @@ -1309,10 +1319,10 @@ static void print_sample_synth_pwrx(struct perf_sample *sample)
>  	len = printf(" deepest cstate: %u last cstate: %u wake reason: %#x ",
>  		     data->deepest_cstate, data->last_cstate,
>  		     data->wake_reason);
> -	print_sample_pt_spacing(len);
> +	fprint_sample_pt_spacing(len, stdout);
>  }
>  
> -static void print_sample_synth_cbr(struct perf_sample *sample)
> +static void fprint_sample_synth_cbr(struct perf_sample *sample, FILE *fp __maybe_unused)
>  {
>  	struct perf_synth_intel_cbr *data = perf_sample__synth_ptr(sample);
>  	unsigned int percent, freq;
> @@ -1327,30 +1337,30 @@ static void print_sample_synth_cbr(struct perf_sample *sample)
>  		percent = (5 + (1000 * data->cbr) / data->max_nonturbo) / 10;
>  		len += printf("(%3u%%) ", percent);
>  	}
> -	print_sample_pt_spacing(len);
> +	fprint_sample_pt_spacing(len, stdout);
>  }
>  
> -static void print_sample_synth(struct perf_sample *sample,
> -			       struct perf_evsel *evsel)
> +static void fprint_sample_synth(struct perf_sample *sample,
> +			       struct perf_evsel *evsel, FILE *fp __maybe_unused)
>  {
>  	switch (evsel->attr.config) {
>  	case PERF_SYNTH_INTEL_PTWRITE:
> -		print_sample_synth_ptwrite(sample);
> +		fprint_sample_synth_ptwrite(sample, stdout);
>  		break;
>  	case PERF_SYNTH_INTEL_MWAIT:
> -		print_sample_synth_mwait(sample);
> +		fprint_sample_synth_mwait(sample, stdout);
>  		break;
>  	case PERF_SYNTH_INTEL_PWRE:
> -		print_sample_synth_pwre(sample);
> +		fprint_sample_synth_pwre(sample, stdout);
>  		break;
>  	case PERF_SYNTH_INTEL_EXSTOP:
> -		print_sample_synth_exstop(sample);
> +		fprint_sample_synth_exstop(sample, stdout);
>  		break;
>  	case PERF_SYNTH_INTEL_PWRX:
> -		print_sample_synth_pwrx(sample);
> +		fprint_sample_synth_pwrx(sample, stdout);
>  		break;
>  	case PERF_SYNTH_INTEL_CBR:
> -		print_sample_synth_cbr(sample);
> +		fprint_sample_synth_cbr(sample, stdout);
>  		break;
>  	default:
>  		break;
> @@ -1386,7 +1396,7 @@ static int perf_evlist__max_name_len(struct perf_evlist *evlist)
>  	return max;
>  }
>  
> -static size_t data_src__printf(u64 data_src)
> +static size_t data_src__fprintf(u64 data_src, FILE *fp __maybe_unused)
>  {
>  	struct mem_info mi = { .data_src.val = data_src };
>  	char decode[100];
> @@ -1406,7 +1416,7 @@ static size_t data_src__printf(u64 data_src)
>  static void process_event(struct perf_script *script,
>  			  struct perf_sample *sample, struct perf_evsel *evsel,
>  			  struct addr_location *al,
> -			  struct machine *machine)
> +			  struct machine *machine, FILE *fp __maybe_unused)
>  {
>  	struct thread *thread = al->thread;
>  	struct perf_event_attr *attr = &evsel->attr;
> @@ -1415,7 +1425,7 @@ static void process_event(struct perf_script *script,
>  	if (output[type].fields == 0)
>  		return;
>  
> -	print_sample_start(sample, thread, evsel);
> +	fprint_sample_start(sample, thread, evsel, stdout);
>  
>  	if (PRINT_FIELD(PERIOD))
>  		printf("%10" PRIu64 " ", sample->period);
> @@ -1431,25 +1441,25 @@ static void process_event(struct perf_script *script,
>  	}
>  
>  	if (print_flags)
> -		print_sample_flags(sample->flags);
> +		fprint_sample_flags(sample->flags, stdout);
>  
>  	if (is_bts_event(attr)) {
> -		print_sample_bts(sample, evsel, thread, al, machine);
> +		fprint_sample_bts(sample, evsel, thread, al, machine, stdout);
>  		return;
>  	}
>  
>  	if (PRINT_FIELD(TRACE))
> -		event_format__print(evsel->tp_format, sample->cpu,
> -				    sample->raw_data, sample->raw_size);
> +		event_format__fprintf(evsel->tp_format, sample->cpu,
> +				    sample->raw_data, sample->raw_size, stdout);
>  
>  	if (attr->type == PERF_TYPE_SYNTH && PRINT_FIELD(SYNTH))
> -		print_sample_synth(sample, evsel);
> +		fprint_sample_synth(sample, evsel, stdout);
>  
>  	if (PRINT_FIELD(ADDR))
> -		print_sample_addr(sample, thread, attr);
> +		fprint_sample_addr(sample, thread, attr, stdout);
>  
>  	if (PRINT_FIELD(DATA_SRC))
> -		data_src__printf(sample->data_src);
> +		data_src__fprintf(sample->data_src, stdout);
>  
>  	if (PRINT_FIELD(WEIGHT))
>  		printf("%16" PRIu64, sample->weight);
> @@ -1467,21 +1477,21 @@ static void process_event(struct perf_script *script,
>  	}
>  
>  	if (PRINT_FIELD(IREGS))
> -		print_sample_iregs(sample, attr);
> +		fprint_sample_iregs(sample, attr, stdout);
>  
>  	if (PRINT_FIELD(UREGS))
> -		print_sample_uregs(sample, attr);
> +		fprint_sample_uregs(sample, attr, stdout);
>  
>  	if (PRINT_FIELD(BRSTACK))
> -		print_sample_brstack(sample, thread, attr);
> +		fprint_sample_brstack(sample, thread, attr, stdout);
>  	else if (PRINT_FIELD(BRSTACKSYM))
> -		print_sample_brstacksym(sample, thread, attr);
> +		fprint_sample_brstacksym(sample, thread, attr, stdout);
>  	else if (PRINT_FIELD(BRSTACKOFF))
> -		print_sample_brstackoff(sample, thread, attr);
> +		fprint_sample_brstackoff(sample, thread, attr, stdout);
>  
>  	if (perf_evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
> -		print_sample_bpf_output(sample);
> -	print_insn(sample, attr, thread, machine);
> +		fprint_sample_bpf_output(sample, stdout);
> +	fprint_insn(sample, attr, thread, machine, stdout);
>  
>  	if (PRINT_FIELD(PHYS_ADDR))
>  		printf("%16" PRIx64, sample->phys_addr);
> @@ -1594,7 +1604,7 @@ static int process_sample_event(struct perf_tool *tool,
>  	if (scripting_ops)
>  		scripting_ops->process_event(event, sample, evsel, &al);
>  	else
> -		process_event(scr, sample, evsel, &al, machine);
> +		process_event(scr, sample, evsel, &al, machine, stdout);
>  
>  out_put:
>  	addr_location__put(&al);
> @@ -1659,7 +1669,7 @@ static int process_comm_event(struct perf_tool *tool,
>  		sample->tid = event->comm.tid;
>  		sample->pid = event->comm.pid;
>  	}
> -	print_sample_start(sample, thread, evsel);
> +	fprint_sample_start(sample, thread, evsel, stdout);
>  	perf_event__fprintf(event, stdout);
>  	ret = 0;
>  out:
> @@ -1694,7 +1704,7 @@ static int process_namespaces_event(struct perf_tool *tool,
>  		sample->tid = event->namespaces.tid;
>  		sample->pid = event->namespaces.pid;
>  	}
> -	print_sample_start(sample, thread, evsel);
> +	fprint_sample_start(sample, thread, evsel, stdout);
>  	perf_event__fprintf(event, stdout);
>  	ret = 0;
>  out:
> @@ -1727,7 +1737,7 @@ static int process_fork_event(struct perf_tool *tool,
>  		sample->tid = event->fork.tid;
>  		sample->pid = event->fork.pid;
>  	}
> -	print_sample_start(sample, thread, evsel);
> +	fprint_sample_start(sample, thread, evsel, stdout);
>  	perf_event__fprintf(event, stdout);
>  	thread__put(thread);
>  
> @@ -1756,7 +1766,7 @@ static int process_exit_event(struct perf_tool *tool,
>  		sample->tid = event->fork.tid;
>  		sample->pid = event->fork.pid;
>  	}
> -	print_sample_start(sample, thread, evsel);
> +	fprint_sample_start(sample, thread, evsel, stdout);
>  	perf_event__fprintf(event, stdout);
>  
>  	if (perf_event__process_exit(tool, event, sample, machine) < 0)
> @@ -1791,7 +1801,7 @@ static int process_mmap_event(struct perf_tool *tool,
>  		sample->tid = event->mmap.tid;
>  		sample->pid = event->mmap.pid;
>  	}
> -	print_sample_start(sample, thread, evsel);
> +	fprint_sample_start(sample, thread, evsel, stdout);
>  	perf_event__fprintf(event, stdout);
>  	thread__put(thread);
>  	return 0;
> @@ -1822,7 +1832,7 @@ static int process_mmap2_event(struct perf_tool *tool,
>  		sample->tid = event->mmap2.tid;
>  		sample->pid = event->mmap2.pid;
>  	}
> -	print_sample_start(sample, thread, evsel);
> +	fprint_sample_start(sample, thread, evsel, stdout);
>  	perf_event__fprintf(event, stdout);
>  	thread__put(thread);
>  	return 0;
> @@ -1848,7 +1858,7 @@ static int process_switch_event(struct perf_tool *tool,
>  		return -1;
>  	}
>  
> -	print_sample_start(sample, thread, evsel);
> +	fprint_sample_start(sample, thread, evsel, stdout);
>  	perf_event__fprintf(event, stdout);
>  	thread__put(thread);
>  	return 0;
> -- 
> 1.8.3.1
