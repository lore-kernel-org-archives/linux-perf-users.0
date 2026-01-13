Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1822D7B1;
	Tue, 13 Jan 2026 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340128; cv=none; b=sahKQZwahH5CEp0Qo9INffRaxp5FGRacMyRAqlKCvUWrckES+rkJ0wbCfDPA7y2IhtrvnKFVPD8OnyX9ZPy675zqjWdxrMPQ7Rjs96+bgyhpIvBu61ljsBcjU4bVlvUQBf8G9k55zJxEGbfNQ+CI46KSen+sPS87BL6rq/QQzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340128; c=relaxed/simple;
	bh=8LwYaeqHid1aR9gM0uCtnHJHfpKmhhUuE8umGzwjESQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQp9V96QQCnhos9A2rJ1ZzptUTpyO2ttlbbDOcTJSKkek2X1gZvM3c4Ni/THeMCs+sPHn0PV9BgpCGJ8T12TPLg/EMdJeQjZ8WZINXxPvllvos8QffWPRlbosobEEmeZFaKoNF+RxNQXt6NFvYHLaXJYSez2nbEr0++vpgORz4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkMYhQ+S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkMYhQ+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8BFC116C6;
	Tue, 13 Jan 2026 21:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768340128;
	bh=8LwYaeqHid1aR9gM0uCtnHJHfpKmhhUuE8umGzwjESQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkMYhQ+SHgyGxembtPtF4WRiEuxxrAPhSnWvaHnw4v07OH+oIYPYwRLANiNcUT21Y
	 E3c/FXLwDMogWxNrxauj13t11B9VFWSsYcki7Uq31ysrRkKJn6MTNvD596SBy1+31a
	 sNnj4E28NVMMtLCZxcZuiY2wJCLfqa+kJaHbHNqIb/9q0gz+p81EZjJKvc2/OXd27w
	 VB+YYdTpE47b8STaxsFdJ6tOVmMjBqmsqIDUfdQtImNxGdZFbEInyIH/QrpTYeOxQh
	 hpCibRORpLJhb4ARzm1tmPW5SbHkOniNw7i9yPsOKnka2ETWjl9LOFIeryZcxb96gM
	 fxiMDBZXXD7iw==
Date: Tue, 13 Jan 2026 18:35:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf inject: Add --convert-callchain option
Message-ID: <aWa6nZCN6xsbxyem@x1>
References: <20260110011715.1642869-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110011715.1642869-1-namhyung@kernel.org>

On Fri, Jan 09, 2026 at 05:17:14PM -0800, Namhyung Kim wrote:
> There are applications not built with frame pointers, so DWARF is needed
> to get the stack traces.  So `perf record --call-graph dwarf` saves the
> stack and register data for each sample to get the stacktrace offline.
> But sometimes those data may have sensitive information and we don't
> want to keep them in the file.
> 
> This perf inject --convert-callchain option parses the callchains and
> discard the stack and register after that.  This will save storage space
> and processing time for the new data file.  Of course, users should
> remove the original data file. :)
> 
> The down side is that it cannot handle inlined callchain entries as they
> all have the same IPs.  Maybe we can add an option to perf report to
> look up inlined functions using DWARF - IIUC it won't requires stack and
> register data.
> 
> This is an example.
> 
>   $ perf record --call-graph dwarf -- perf test -w noploop
> 
>   $ perf report --stdio --no-children --percent-limit=0 > output-prev
> 
>   $ perf inject -i perf.data --convert-callchain -o perf.data.out
> 
>   $ perf report --stdio --no-children --percent-limit=0 -i perf.data.out > output-next
> 
>   $ diff -u output-prev output-next
>   ...
>         0.23%  perf          ld-linux-x86-64.so.2  [.] _dl_relocate_object_no_relro
>                |
>   -            ---elf_dynamic_do_Rela (inlined)
>   -               _dl_relocate_object_no_relro
>   +            ---_dl_relocate_object_no_relro
>                   _dl_relocate_object
>                   dl_main
>                   _dl_sysdep_start
>   -               _dl_start_final (inlined)
>                   _dl_start
>                   _start
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2 changes)
>  * Use machine__kernel_ip() instead  (James)
>  * Check sample types for DWARF callchains (James)
>  * Fix build errors  (James)
>  * Add a new test  (Ian)
> 
>  tools/perf/Documentation/perf-inject.txt |   5 +
>  tools/perf/builtin-inject.c              | 151 +++++++++++++++++++++++
>  2 files changed, 156 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
> index c972032f4ca0d248..95dfdf39666efe89 100644
> --- a/tools/perf/Documentation/perf-inject.txt
> +++ b/tools/perf/Documentation/perf-inject.txt
> @@ -109,6 +109,11 @@ include::itrace.txt[]
>  	should be used, and also --buildid-all and --switch-events may be
>  	useful.
>  
> +--convert-callchain::
> +	Parse DWARF callchains and convert them to usual callchains.  This also
> +	discards stack and register data from the samples.  This will lose
> +	inlined callchain entries.
> +
>  :GMEXAMPLECMD: inject
>  :GMEXAMPLESUBCMD:
>  include::guestmount.txt[]
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 6080afec537d2178..02bd388d602fdd75 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -122,6 +122,7 @@ struct perf_inject {
>  	bool			in_place_update;
>  	bool			in_place_update_dry_run;
>  	bool			copy_kcore_dir;
> +	bool			convert_callchain;
>  	const char		*input_name;
>  	struct perf_data	output;
>  	u64			bytes_written;
> @@ -133,6 +134,7 @@ struct perf_inject {
>  	struct guest_session	guest_session;
>  	struct strlist		*known_build_ids;
>  	const struct evsel	*mmap_evsel;
> +	struct ip_callchain	*raw_callchain;
>  };
>  
>  struct event_entry {
> @@ -383,6 +385,89 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
>  	return perf_event__repipe_synth(tool, event);
>  }
>  
> +static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
> +						union perf_event *event,
> +						struct perf_sample *sample,
> +						struct evsel *evsel,
> +						struct machine *machine)
> +{
> +	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
> +	struct callchain_cursor *cursor = get_tls_callchain_cursor();
> +	union perf_event *event_copy = (void *)inject->event_copy;
> +	struct callchain_cursor_node *node;
> +	struct thread *thread;
> +	u64 sample_type = evsel->core.attr.sample_type;
> +	u32 sample_size = event->header.size;
> +	u64 i, k;
> +	int ret;
> +
> +	if (event_copy == NULL) {
> +		inject->event_copy = malloc(PERF_SAMPLE_MAX_SIZE);
> +		if (!inject->event_copy)
> +			return -ENOMEM;
> +
> +		event_copy = (void *)inject->event_copy;
> +	}
> +
> +	if (cursor == NULL)
> +		return perf_event__repipe_synth(tool, event);

So when you don't manage to convert you just repipe the whole event,
with all the stack that you're supposed to discard? Shouldn't we do this
adjustment anyway?

+	/* adjust sample size for stack and regs */
+	sample_size -= sample->user_stack.size;
+	sample_size -= (hweight64(evsel->core.attr.sample_regs_user) + 1) * sizeof(u64);
+	sample_size += (sample->callchain->nr + 1) * sizeof(u64);
+	event_copy->header.size = sample_size;

I.e. we either manage to convert the stack or we throw it away?

- Arnaldo

> +
> +	callchain_cursor_reset(cursor);
> +
> +	thread = machine__find_thread(machine, -1, sample->pid);
> +	if (thread == NULL)
> +		return perf_event__repipe_synth(tool, event);
> +
> +	/* this will parse DWARF using stack and register data */
> +	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
> +					/*parent=*/NULL, /*root_al=*/NULL,
> +					PERF_MAX_STACK_DEPTH);
> +	thread__put(thread);
> +	if (ret != 0)
> +		return perf_event__repipe_synth(tool, event);
> +
> +	/* copy kernel callchain and context entries */
> +	for (i = 0; i < sample->callchain->nr; i++) {
> +		inject->raw_callchain->ips[i] = sample->callchain->ips[i];
> +		if (sample->callchain->ips[i] == PERF_CONTEXT_USER) {
> +			i++;
> +			break;
> +		}
> +	}
> +	if (i == 0 || inject->raw_callchain->ips[i - 1] != PERF_CONTEXT_USER)
> +		inject->raw_callchain->ips[i++] = PERF_CONTEXT_USER;
> +
> +	node = cursor->first;
> +	for (k = 0; k < cursor->nr && i < PERF_MAX_STACK_DEPTH; k++) {
> +		if (machine__kernel_ip(machine, node->ip))
> +			/* kernel IPs were added already */;
> +		else if (node->ms.sym && node->ms.sym->inlined)
> +			/* we can't handle inlined callchains */;
> +		else
> +			inject->raw_callchain->ips[i++] = node->ip;
> +
> +		node = node->next;
> +	}
> +
> +	inject->raw_callchain->nr = i;
> +	sample->callchain = inject->raw_callchain;
> +
> +	memcpy(event_copy, event, sizeof(event->header));
> +
> +	/* adjust sample size for stack and regs */
> +	sample_size -= sample->user_stack.size;
> +	sample_size -= (hweight64(evsel->core.attr.sample_regs_user) + 1) * sizeof(u64);
> +	sample_size += (sample->callchain->nr + 1) * sizeof(u64);
> +	event_copy->header.size = sample_size;
> +
> +	/* remove sample_type {STACK,REGS}_USER for synthesize */
> +	sample_type &= ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER);
> +
> +	perf_event__synthesize_sample(event_copy, sample_type,
> +				      evsel->core.attr.read_format, sample);
> +	return perf_event__repipe_synth(tool, event_copy);
> +}
> +
>  static struct dso *findnew_dso(int pid, int tid, const char *filename,
>  			       const struct dso_id *id, struct machine *machine)
>  {
> @@ -2270,6 +2355,15 @@ static int __cmd_inject(struct perf_inject *inject)
>  		/* Allow space in the header for guest attributes */
>  		output_data_offset += gs->session->header.data_offset;
>  		output_data_offset = roundup(output_data_offset, 4096);
> +	} else if (inject->convert_callchain) {
> +		inject->tool.sample	= perf_event__convert_sample_callchain;
> +		inject->tool.fork	= perf_event__repipe_fork;
> +		inject->tool.comm	= perf_event__repipe_comm;
> +		inject->tool.exit	= perf_event__repipe_exit;
> +		inject->tool.mmap	= perf_event__repipe_mmap;
> +		inject->tool.mmap2	= perf_event__repipe_mmap2;
> +		inject->tool.ordered_events = true;
> +		inject->tool.ordering_requires_timestamps = true;
>  	}
>  
>  	if (!inject->itrace_synth_opts.set)
> @@ -2322,6 +2416,23 @@ static int __cmd_inject(struct perf_inject *inject)
>  				perf_header__set_feat(&session->header,
>  						      HEADER_BRANCH_STACK);
>  		}
> +
> +		/*
> +		 * The converted data file won't have stack and registers.
> +		 * Update the perf_event_attr to remove them before writing.
> +		 */
> +		if (inject->convert_callchain) {
> +			struct evsel *evsel;
> +
> +			evlist__for_each_entry(session->evlist, evsel) {
> +				evsel__reset_sample_bit(evsel, REGS_USER);
> +				evsel__reset_sample_bit(evsel, STACK_USER);
> +				evsel->core.attr.sample_regs_user = 0;
> +				evsel->core.attr.sample_stack_user = 0;
> +				evsel->core.attr.exclude_callchain_user = 0;
> +			}
> +		}
> +
>  		session->header.data_offset = output_data_offset;
>  		session->header.data_size = inject->bytes_written;
>  		perf_session__inject_header(session, session->evlist, fd, &inj_fc.fc,
> @@ -2346,6 +2457,18 @@ static int __cmd_inject(struct perf_inject *inject)
>  	return ret;
>  }
>  
> +static bool evsel__has_dwarf_callchain(struct evsel *evsel)
> +{
> +	struct perf_event_attr *attr = &evsel->core.attr;
> +	const u64 dwarf_callchain_flags =
> +		PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER | PERF_SAMPLE_CALLCHAIN;
> +
> +	if (!attr->exclude_callchain_user)
> +		return false;
> +
> +	return (attr->sample_type & dwarf_callchain_flags) == dwarf_callchain_flags;
> +}
> +
>  int cmd_inject(int argc, const char **argv)
>  {
>  	struct perf_inject inject = {
> @@ -2414,6 +2537,8 @@ int cmd_inject(int argc, const char **argv)
>  		OPT_STRING(0, "guestmount", &symbol_conf.guestmount, "directory",
>  			   "guest mount directory under which every guest os"
>  			   " instance has a subdir"),
> +		OPT_BOOLEAN(0, "convert-callchain", &inject.convert_callchain,
> +			    "Generate callchains using DWARF and drop register/stack data"),
>  		OPT_END()
>  	};
>  	const char * const inject_usage[] = {
> @@ -2429,6 +2554,9 @@ int cmd_inject(int argc, const char **argv)
>  
>  #ifndef HAVE_JITDUMP
>  	set_option_nobuild(options, 'j', "jit", "NO_LIBELF=1", true);
> +#endif
> +#ifndef HAVE_LIBDW_SUPPORT
> +	set_option_nobuild(options, 0, "convert-callchain", "NO_LIBDW=1", true);
>  #endif
>  	argc = parse_options(argc, argv, options, inject_usage, 0);
>  
> @@ -2588,6 +2716,28 @@ int cmd_inject(int argc, const char **argv)
>  		}
>  	}
>  
> +	if (inject.convert_callchain) {
> +		struct evsel *evsel;
> +
> +		if (inject.output.is_pipe || inject.session->data->is_pipe) {
> +			pr_err("--convert-callchain cannot work with pipe\n");
> +			goto out_delete;
> +		}
> +
> +		evlist__for_each_entry(inject.session->evlist, evsel) {
> +			if (!evsel__has_dwarf_callchain(evsel)) {
> +				pr_err("--convert-callchain requires DWARF call graph.\n");
> +				goto out_delete;
> +			}
> +		}
> +
> +		inject.raw_callchain = calloc(PERF_MAX_STACK_DEPTH, sizeof(u64));
> +		if (inject.raw_callchain == NULL) {
> +			pr_err("callchain allocation failed\n");
> +			goto out_delete;
> +		}
> +	}
> +
>  #ifdef HAVE_JITDUMP
>  	if (inject.jit_mode) {
>  		inject.tool.mmap2	   = perf_event__repipe_mmap2;
> @@ -2618,5 +2768,6 @@ int cmd_inject(int argc, const char **argv)
>  	free(inject.itrace_synth_opts.vm_tm_corr_args);
>  	free(inject.event_copy);
>  	free(inject.guest_session.ev.event_buf);
> +	free(inject.raw_callchain);
>  	return ret;
>  }
> -- 
> 2.52.0.457.g6b5491de43-goog
