Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793489593;
	b=bY6KYnGmh0WPfQoCdRBm9+8UrCQZVXdyGVVwApo2VYThhvHR5/caKcwvPQ6JuC1/I9wS
	 taUm8vlNO0J2epSoTrGzbPivv7YRKvxUyNUi5dZ2NssnMj0XSe+tQm0TF5/6I6SBH3RaW
	 vRhzFBMgaO0kLsPrBWvCsIHYNN4BHIOb2gLOxBFYyGsgJ1s5HjJG3+3jSoHsW48kY7Dxk
	 3+EObipbAKNTIlsHrvaRAC5L9Eg9gHEhXWnuQC8L8y45VdFmtPLs4W4v+UVlR55CL4ZTV
	 nsM8fCXyhFzaGaBFSN8KUVI/hJYPQ9PfjclWzSTUL3WqCv3pfCK9A2KZvMpqxhr3QIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793489593;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7K2ziRCK1NU4A5lBQIz4uomFlwsvzdBFdBu8vHNoNxs=;
	b=KyTdjvdnH/iqjAgmqr9u5oQ+S14fmuDhdethkCZdC6RaTBIA/7jDXNOtFqRDMQmqSmwg
	 1Mut8XluEYmhErhm/fr8rNJQTO6i548tRnBaFlNG2fbydbsKipp9hbzZJFrUU6eVCbhXZ
	 jOcGMfNvJxZ8PLbbslSTfPASRNoVz/XzcVNSCY9qIlNGfxZ4NhrsP+GwRuhBntW/ypa1F
	 HT4ESWIKbMIRwVWnESlZI7XC5Gqp50TsSHDJXcOqvyBoFQX4rQbf4lccpsTeJ4AkYOKh+
	 h0f5j5DCJEnG5ZK0zjIEDrQ5dmvWlxGpHAyrP5P5P2PVY+tM6CVAObJnDGoj4qzikRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CV1xWQ58;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C0C606A31A;
	Sat, 31 Oct 2026 23:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CV1xWQ58
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0B81F000C1;
	Sat, 31 Oct 2026 23:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793489592;
	bh=7K2ziRCK1NU4A5lBQIz4uomFlwsvzdBFdBu8vHNoNxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CV1xWQ58S3zIxI7fVN9SmK6ed5b0TNVjyN8e4mlcAzqS/vuKy3jS6q1h+j0OIt2fp
	 SeSBOPRYwW+Pyso5UJMzuvufSqjzy1yahQY4FyLkxS2xrmoKm08wbn5HSc1LCok6nM
	 jWAFNhjFHJSUTxSkzLWrztKp3x5PkpImsE+tRJuO2ks38+o0GhQiWs9QEVRYWFFwf4
	 7FnjYpzxYL0g1CMUmqfNXtFJVDzgQ8MkbDDNLuXDwJl3c6ggZ/jwQ/fWK96PpRLfgD
	 iu/voPPztpMFrBDG4pGXSfaJouLg4/+SlhEGzDnuE3AyL2wLd2cdnPa1JMaEzyTSeM
	 Wap7GrMTyEQmg==
Date: Sat, 31 Oct 2026 16:33:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	chjohnst@mail.com, neelx@suse.com, sean@ashe.io,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 06/10] perf ftrace: Support display
 of inlined functions in function graph tracer
Message-ID: <auZ6tj_5-m1MNGDM@z2>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-7-atomlin@atomlin.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026025735.546101-7-atomlin@atomlin.com>

On Sun, Oct 25, 2026 at 10:57:31PM -0400, Aaron Tomlin wrote:
> The Linux kernel's function graph tracer operates at the machine
> instruction level via compiler instrumentation
> (-fpatchable-function-entry), recording entry and return events for
> physical function calls. Consequently, functions inlined by the compiler
> are invisible in the resulting call graph, as no discrete call or return
> instructions are emitted for them. While technically expected, this
> omission frequently obscures the logical execution flow when analysing
> kernel subsystems heavily reliant upon inlining.
> 
> Address this by introducing the --inline option to perf ftrace for the
> function_graph tracer.
> 
> When the kernel is configured with CONFIG_FUNCTION_GRAPH_RETADDR=y, the
> funcgraph-retaddr trace option records the caller's return address on
> each function entry, manifested in the trace stream as a comment
> (e.g. /* <-irq_work_queue_on+0x81/0xa0 */). By interrogating DWARF debug
> information from the kernel image (vmlinux) utilising libdw, perf ftrace
> resolves this return address to its inlined callchain and synthesises the
> intermediate inlined frames directly into the streamed call graph.
> 
> Key aspects of this implementation:
> 
>     1.  DWARF inline resolution
> 
>         Implement ftrace_resolve_inlines() using libdw to locate inlined
>         subroutines at the instruction address corresponding to the
>         caller's return address.
> 
>         Implement perf_ftrace__setup_inlines() and
>         perf_ftrace__cleanup_inlines() to initialise machine symbol
>         tracking, load vmlinux symbols, and verify kernel
>         CONFIG_FUNCTION_GRAPH_RETADDR support.
> 
>     2.  Inline frame synthesis
> 
>         In ftrace_process_fgraph_line(), when --inline is active:
>             - Interrogate return addresses using ftrace_parse_retaddr()
>               and resolve inlines via ftrace_resolve_inlines().
> 
>             - Identify common inlined ancestors on the tracked stack and
>               unwind inactive frames.
> 
>             - Open new inlined frames with /* (inline) */ and indent by
>               inlined_depth * 2.
> 
>             - On function exit, close matching inlined frames with
>               } /* func (inline) */.
> 
>     3.  Command-line options and documentation
> 
>         Add --inline and -k/--vmlinux options in
>         tools/perf/builtin-ftrace.c and document their usage in
>         tools/perf/Documentation/perf-ftrace.txt.
> 
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
[SNIP] 
> +/**
> + * ftrace_resolve_inlines - Resolve inlined functions for a return address
> + * @machine: Perf machine context
> + * @sym_name: Name of the caller function
> + * @offset: Instruction offset within the caller function
> + * @inlined_names: Array to store the resolved inline function names
> + * @max_inlines: Maximum number of inline frames to resolve
> + *
> + * Use DWARF debug information from the kernel image to resolve a caller's
> + * return address to its inlined callchain.
> + *
> + * Return: The number of inline functions successfully resolved.
> + */
> +int ftrace_resolve_inlines(struct machine *machine,
> +			   const char *sym_name, u64 offset,
> +			   const char **inlined_names, int max_inlines)

Why not remove 'const' from the inlined_names?

> +{
> +	struct map *map = NULL;
> +	struct symbol *sym;
> +	struct dso *dso;
> +	struct inline_node *node;
> +	struct inline_list *ilist;
> +	u64 ip, addr;
> +	int count = 0;
> +	int j;
> +
> +	if (!machine || !offset)
> +		return 0;
> +
> +	sym = machine__find_kernel_symbol_by_name(machine, sym_name, &map);
> +	if (!sym || !map)
> +		return 0;
> +
> +	dso = map__dso(map);
> +	if (!dso) {
> +		map__put(map);
> +		return 0;
> +	}
> +
> +	ip = sym->start + offset - 1;
> +	addr = map__rip_2objdump(map, ip);
> +
> +	node = inlines__tree_find(dso__inlined_nodes(dso), addr);
> +	if (!node) {
> +		node = dso__parse_addr_inlines(dso, addr, sym);
> +		if (node)
> +			inlines__tree_insert(dso__inlined_nodes(dso), node);
> +	}
> +
> +	if (!node) {
> +		map__put(map);
> +		return 0;
> +	}
> +
> +	list_for_each_entry_reverse(ilist, &node->val, list) {
> +		if (ilist->symbol && symbol__inlined(ilist->symbol)) {
> +			if (count < max_inlines) {

You can reduce the indentation by inverting the condition.


> +				char *name = strdup(ilist->symbol->name);

Why not just save the pointer?  You may not use some of them, also it
copies the string again when it's added to the stack.  It'd make the
error handling a bit easier.

> +
> +				if (!name) {
> +					for (j = 0; j < count; j++)
> +						free((void *)inlined_names[j]);
> +					map__put(map);
> +					return -ENOMEM;
> +				}
> +				inlined_names[count++] = name;
> +			}
> +		}
> +	}
> +
> +	map__put(map);
> +	return count;
> +}
[SNIP]
>   * @line: The trace line to process
>   * @out: File stream to output to
>   *
> - * Parse function entries and exits, maintain the task's call stack, and
> - * output the trace line.
> + * Process a trace line from the function_graph tracer. If --inline is set,
> + * this function parses the return address comment, resolves it to its
> + * inlined callchain, and synthesises intermediate frames into the streamed
> + * call graph.
>   *
>   * Return: 0 on success, or a negative error code on failure.
>   */
>  int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
>  {
> +	char caller_sym[128];
> +	char blank_prefix[128];
> +	const char *inlined_names[FTRACE_MAX_INLINES];
>  	const char *pipe_char;
>  	const char *after_pipe;
>  	const char *func_start;
> -	struct ftrace_task_state *cs;
> +	struct ftrace_cpu_state *cs;
> +	u64 caller_offset = 0;
> +	int num_inlines = 0;
>  	int cpu = -1;
>  	int leading_spaces;
> -	int top_raw_indent;
> +	int extra_indent;
> +	int caller_idx;
> +	int active_inlines;
> +	int common;
>  	int match_idx;
> -	int i;
> +	int top_raw_indent;
> +	int i, j;
>  	bool is_exit;
>  	bool has_open_brace;
>  	bool has_semicolon;
> +	bool has_retaddr = false;
> +
> +	if (!ftrace->use_inline)
> +		return print_line(ftrace, line, out);
>  
>  	pipe_char = find_func_column(ftrace, line, &cpu);
>  	if (!pipe_char) {
> @@ -799,6 +989,7 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
>  		return print_line(ftrace, line, out);
>  
>  	cs->seq = ++ftrace_event_seq;
> +	make_blank_prefix(ftrace, line, pipe_char, blank_prefix, sizeof(blank_prefix));
>  
>  	after_pipe = pipe_char + 1;
>  	func_start = skip_spaces(after_pipe);
> @@ -818,20 +1009,32 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
>  
>  		top_raw_indent = -1;
>  		for (i = cs->depth - 1; i >= 0; i--) {
> -			top_raw_indent = cs->stack[i].raw_indent;
> -			break;
> +			if (!cs->stack[i].inlined) {
> +				top_raw_indent = cs->stack[i].raw_indent;
> +				break;
> +			}
>  		}
>  
> +		/*
> +		 * If currently overflowed beyond FTRACE_MAX_STACK, any exit whose
> +		 * indentation is deeper than the top tracked frame belongs to the
> +		 * overflow region.
> +		 */
>  		if (cs->overflow_depth > 0 &&
>  		    (top_raw_indent < 0 || leading_spaces > top_raw_indent)) {
>  			cs->overflow_depth--;
> -			return print_line(ftrace, line, out);
> +			extra_indent = cs->inlined_depth * 2;
> +			fprintf(out, "%.*s%*s%s\n",
> +				(int)(pipe_char - line + 1), line,
> +				leading_spaces + extra_indent, "", func_start);
> +			return 0;
>  		}
>  
> +		/* Find matching frame on stack */
>  		match_idx = -1;
>  		if (exit_name[0] != '\0') {
>  			for (i = cs->depth - 1; i >= 0; i--) {
> -				if (cs->stack[i].name &&
> +				if (!cs->stack[i].inlined && cs->stack[i].name &&
>  				    cs->stack[i].raw_indent == leading_spaces &&
>  				    strcmp(cs->stack[i].name, exit_name) == 0) {
>  					match_idx = i;
> @@ -840,9 +1043,14 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
>  			}
>  		}
>  
> +		/*
> +		 * If bare brace ('}'), match the topmost non-inlined frame
> +		 * with matching indentation.
> +		 */
>  		if (match_idx < 0 && exit_name[0] == '\0') {
>  			for (i = cs->depth - 1; i >= 0; i--) {
> -				if (cs->stack[i].raw_indent == leading_spaces) {
> +				if (!cs->stack[i].inlined &&
> +				    cs->stack[i].raw_indent == leading_spaces) {
>  					match_idx = i;
>  					break;
>  				}
> @@ -851,17 +1059,51 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
>  
>  		if (match_idx >= 0) {
>  			cs->overflow_depth = 0;
> -			while (cs->depth > match_idx) {
> +		} else if (cs->overflow_depth > 0) {
> +			cs->overflow_depth--;
> +			extra_indent = cs->inlined_depth * 2;
> +			fprintf(out, "%.*s%*s%s\n",
> +				(int)(pipe_char - line + 1), line,
> +				leading_spaces + extra_indent, "", func_start);
> +			return 0;
> +		}
> +
> +		if (match_idx >= 0) {
> +			/* Close all inlined and orphaned frames above match_idx */
> +			while (cs->depth > 0 && cs->depth - 1 > match_idx) {
> +				struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
> +
> +				if (top->inlined) {
> +					int exit_indent = top->indent;
> +
> +					if (cs->inlined_depth > 0)
> +						cs->inlined_depth--;
> +					fprintf(out, "%s%*s} /* %s (inline) */\n",
> +						blank_prefix, exit_indent, "", top->name);
> +				}
> +				free(top->name);
> +				cs->depth--;
> +			}
> +
> +			/* Pop the matched real frame */
> +			if (cs->depth > 0 && match_idx == cs->depth - 1 &&
> +			    !cs->stack[cs->depth - 1].inlined) {
>  				free(cs->stack[cs->depth - 1].name);
>  				cs->depth--;
>  			}
> -		} else if (cs->overflow_depth > 0) {
> -			cs->overflow_depth--;
> +
> +			extra_indent = cs->inlined_depth * 2;
> +		} else {
> +			extra_indent = 0;
>  		}
>  
> -		return print_line(ftrace, line, out);
> +		fprintf(out, "%.*s%*s%s\n",
> +			(int)(pipe_char - line + 1), line,
> +			leading_spaces + extra_indent, "", func_start);
> +		return 0;
>  	}
>  
> +	/* It's an entry or a leaf call */
>  	has_open_brace = (strchr(func_start, '{') != NULL);
>  	has_semicolon = (strchr(func_start, ';') != NULL);
>  
> @@ -870,40 +1112,277 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
>  
>  	top_raw_indent = -1;
>  	for (i = cs->depth - 1; i >= 0; i--) {
> -		top_raw_indent = cs->stack[i].raw_indent;
> -		break;
> +		if (!cs->stack[i].inlined) {
> +			top_raw_indent = cs->stack[i].raw_indent;
> +			break;
> +		}
>  	}
>  
>  	if (cs->overflow_depth > 0 && top_raw_indent >= 0 &&
>  	    leading_spaces <= top_raw_indent)
>  		cs->overflow_depth = 0;
>  
> -	if (has_open_brace && !has_semicolon) {
> -		char entry_name[128];
> +	if (ftrace_parse_retaddr(func_start, caller_sym, sizeof(caller_sym), &caller_offset)) {
> +		has_retaddr = true;
> +		num_inlines = ftrace_resolve_inlines(ftrace->machine, caller_sym,
> +						      caller_offset, inlined_names,
> +						      FTRACE_MAX_INLINES);
> +		if (num_inlines < 0)
> +			return num_inlines;
> +	}
> +
> +	/* Determine which inlined frames are currently open above the caller */
> +	caller_idx = -1;
> +	if (has_retaddr && cs->overflow_depth == 0) {
> +		for (i = cs->depth - 1; i >= 0; i--) {
> +			if (!cs->stack[i].inlined && cs->stack[i].name &&
> +			    cs->stack[i].raw_indent < leading_spaces &&
> +			    strcmp(cs->stack[i].name, caller_sym) == 0) {
> +				caller_idx = i;
> +				break;
> +			}
> +		}
> +	}
> +
> +	/* If caller is not on the tracked stack, do not synthesise inlines */
> +	if (has_retaddr && caller_idx < 0) {
> +		for (i = 0; i < num_inlines; i++)
> +			free((void *)inlined_names[i]);
> +		num_inlines = 0;
> +	}
> +
> +	active_inlines = 0;
> +	if (caller_idx >= 0) {
> +		for (i = caller_idx + 1; i < cs->depth; i++) {
> +			if (cs->stack[i].inlined)
> +				active_inlines++;
> +			else
> +				break;
> +		}
> +	}
> +
> +	/* Find common prefix of inlined functions */
> +	common = 0;
> +	if (caller_idx >= 0) {
> +		while (common < active_inlines && common < num_inlines &&
> +		       cs->stack[caller_idx + 1 + common].name &&
> +		       !strcmp(cs->stack[caller_idx + 1 + common].name,
> +			       inlined_names[common])) {
> +			common++;
> +		}
> +	}
> +
> +	/* Close stale callee frames and inactive inlined frames above caller */
> +	if (caller_idx >= 0)
> +		cs->overflow_depth = 0;
> +
> +	while (caller_idx >= 0 && cs->depth > caller_idx + 1 + common) {
> +		struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
> +
> +		if (top->inlined) {
> +			int exit_indent = top->indent;
> +
> +			if (cs->inlined_depth > 0)
> +				cs->inlined_depth--;
> +			fprintf(out, "%s%*s} /* %s (inline) */\n",
> +				blank_prefix, exit_indent, "", top->name);
> +		}
> +		free(top->name);
> +		cs->depth--;
> +	}
> +
> +	if (caller_idx < 0 && cs->overflow_depth == 0) {
> +		/*
> +		 * If caller is not on the tracked stack, unwind any frames whose
> +		 * raw indentation is greater than or equal to the new entry's
> +		 * indentation (their exit events were dropped), and close any
> +		 * trailing inlined frames that were left open from prior calls.
> +		 */
> +		while (cs->depth > 0) {
> +			struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
> +
> +			if (top->inlined) {
> +				int exit_indent = top->indent;
> +
> +				if (cs->inlined_depth > 0)
> +					cs->inlined_depth--;
> +				fprintf(out, "%s%*s} /* %s (inline) */\n",
> +					blank_prefix, exit_indent, "", top->name);
> +				free(top->name);
> +				cs->depth--;
> +			} else if (top->raw_indent >= leading_spaces) {
> +				free(top->name);
> +				cs->depth--;
> +			} else {
> +				break;
> +			}
> +		}
> +	}
>  
> -		while (cs->depth > 0 &&
> -		       cs->stack[cs->depth - 1].raw_indent >= leading_spaces) {
> -			free(cs->stack[cs->depth - 1].name);
> -			cs->depth--;
> +	/* Open new inlined frames */
> +	for (i = common; i < num_inlines; i++) {
> +		int entry_indent = leading_spaces + cs->inlined_depth * 2;
> +
> +		if (!inlined_names[i]) {
> +			pr_err("Not enough memory\n");
> +			for (j = 0; j < num_inlines; j++)
> +				free((void *)inlined_names[j]);
> +			return -ENOMEM;
> +		}
> +		if (cs->depth >= cs->max_stack &&
> +		    ftrace_task_state__grow_stack(cs) < 0)
> +			break;
> +
> +		fprintf(out, "%s%*s%s() { /* (inline) */\n",
> +			blank_prefix, entry_indent, "", inlined_names[i]);
> +		cs->stack[cs->depth].name = strdup(inlined_names[i]);
> +		if (!cs->stack[cs->depth].name) {
> +			pr_err("Not enough memory\n");
> +			for (j = 0; j < num_inlines; j++)
> +				free((void *)inlined_names[j]);
> +			return -ENOMEM;
> +		}
> +		cs->stack[cs->depth].inlined = true;
> +		cs->stack[cs->depth].indent = entry_indent;
> +		cs->stack[cs->depth].raw_indent = -1;

I'm curious if it's possible to get rid of the indent and raw_indent.
I think you can get the indent from the depth easily.  The raw indent
would be from any non-inlined parent if needed.  Also having inlined
depth in the cs/ts seems unnecessary.  What do you think?


> +		cs->stack[cs->depth].seq = cs->seq;
> +		cs->depth++;
> +		cs->inlined_depth++;
> +	}
> +
> +	/* Print current line with updated indentation */
> +	extra_indent = cs->inlined_depth * 2;
> +
> +	if (!ftrace->graph_retaddr) {
> +		char *filtered = strdup(func_start);
> +
> +		if (filtered) {
> +			ftrace_filter_retaddr(filtered);
> +			fprintf(out, "%.*s%*s%s\n",
> +				(int)(pipe_char - line + 1), line,
> +				leading_spaces + extra_indent, "", filtered);
> +			free(filtered);
> +		} else {
> +			pr_err("Not enough memory\n");
> +			for (i = 0; i < num_inlines; i++)
> +				free((void *)inlined_names[i]);
> +			return -ENOMEM;
>  		}
> +	} else {
> +		fprintf(out, "%.*s%*s%s\n",
> +			(int)(pipe_char - line + 1), line,
> +			leading_spaces + extra_indent, "", func_start);
> +	}
> +
> +	/* If non-leaf entry, push onto stack */
> +	if (has_open_brace && !has_semicolon) {
> +		char entry_name[128];
>  
>  		extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
>  		if (cs->depth >= cs->max_stack &&
>  		    ftrace_task_state__grow_stack(cs) < 0) {
> -			cs->overflow_depth++;
> -		} else {
> -			cs->stack[cs->depth].name = strdup(entry_name);
> -			if (!cs->stack[cs->depth].name) {
> -				pr_err("Not enough memory\n");
> -				return -ENOMEM;
> -			}
> -			cs->stack[cs->depth].inlined = false;
> -			cs->stack[cs->depth].indent = leading_spaces;
> -			cs->stack[cs->depth].raw_indent = leading_spaces;
> -			cs->stack[cs->depth].seq = cs->seq;
> -			cs->depth++;
> +			for (i = 0; i < num_inlines; i++)
> +				free((void *)inlined_names[i]);
> +			return -ENOMEM;
> +		}
> +
> +		cs->stack[cs->depth].name = strdup(entry_name);
> +		if (!cs->stack[cs->depth].name) {
> +			pr_err("Not enough memory\n");
> +			for (i = 0; i < num_inlines; i++)
> +				free((void *)inlined_names[i]);
> +			return -ENOMEM;
> +		}
> +		cs->stack[cs->depth].inlined = false;
> +		cs->stack[cs->depth].indent = leading_spaces + extra_indent;
> +		cs->stack[cs->depth].raw_indent = leading_spaces;
> +		cs->stack[cs->depth].seq = cs->seq;
> +		cs->depth++;
> +	}
> +
> +	for (i = 0; i < num_inlines; i++)
> +		free((void *)inlined_names[i]);
> +	return 0;
> +}
[SNIP]
> diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
> index 45f5090d0115..7b9e0919ae8d 100644
> --- a/tools/perf/util/ftrace.h
> +++ b/tools/perf/util/ftrace.h
> @@ -42,6 +42,8 @@ struct perf_ftrace {
>  	int			graph_verbose;
>  	int			graph_thresh;
>  	int			graph_tail;
> +	bool			use_inline;
> +	struct machine		*machine;
>  };
>  
>  struct filter_entry {
> @@ -96,44 +98,18 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
>  
>  #endif  /* HAVE_BPF_SKEL */
>  
> -#define FTRACE_MAX_CPUS 4096
> -#define FTRACE_MAX_STACK 256
> -#define FTRACE_PID_HASH_BITS 10
> -#define FTRACE_PID_HASH_SIZE (1 << FTRACE_PID_HASH_BITS)
> +struct machine;
>  
> -#define FTRACE_IDLE_PID(cpu)       ((pid_t)(-1 - (cpu)))
> -#define FTRACE_UNKNOWN_PID(cpu)    ((pid_t)(-1 - FTRACE_MAX_CPUS - (cpu)))
> -
> -struct ftrace_stack_frame {
> -	char *name;
> -	bool inlined;
> -	int indent;
> -	int raw_indent;
> -	u64 seq;
> -};
> -
> -struct ftrace_indent_watermark {
> -	u64 seq;
> -	int raw_indent;
> -};
> -
> -struct ftrace_task_state {
> -	struct hlist_node	node;
> -	pid_t			pid;
> -	struct ftrace_stack_frame *stack;
> -	int			max_stack;
> -	int			depth;
> -	int			inlined_depth;
> -	int			overflow_depth;
> -	u64			seq;
> -	struct ftrace_indent_watermark *watermarks;
> -	int			max_watermarks;
> -	int			nr_watermarks;
> -};
> +#define FTRACE_MAX_INLINES 32

Isn't 32 too big?  I guess 8 would be enough..

Thanks,
Namhyung

>  
>  bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
>  void ftrace_filter_retaddr(char *str);
> -void ftrace_cpu_states__clear(void);
> +int ftrace_resolve_inlines(struct machine *machine,
> +			   const char *sym_name, u64 offset,
> +			   const char **inlined_names, int max_inlines);
>  int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out);
> +void ftrace_cpu_states__clear(void);
> +int perf_ftrace__setup_inlines(struct perf_ftrace *ftrace);
> +void perf_ftrace__cleanup_inlines(struct perf_ftrace *ftrace);
>  
>  #endif  /* __PERF_FTRACE_H__ */
> -- 
> 2.55.0
> 
