Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793430355;
	b=aRshFHa5VXif28guWS+Asdxd98RrSNKSwV7B/4K/nIRUDUTw+XDjzk2Y03IKXQep+/AZ
	 p79qTKrL3ZReK628pIytrKKz94gfhywFxOC9F7WTOTSb1wTbXUJRA8uTGbU16WQ8kghZ9
	 Kg2yAQPz8ZQo/DWYaM/NbQb1UwpTrIo9/fsy3L4agrUJSERncEcn3zX0N9wQ28tyx10VG
	 e04730y4wvdW2E15qgt+gBQHvvS+iHRXIhNdf8nGwIX8enmRUJJ8Oi9AkDHnyNuhiy/lj
	 Sbat7nw+6TN1fLHGLbGbSlW4ffZy/dipFkzh1b58/2vLvzv19Jr7jMrzuIqDB+wZYBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793430355;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OagihIP284HBeckwq/KNJFNqJyjNcJi5p2KWfRoDcX0=;
	b=BeAgw12hkDX/HLYNe0HJrRwAndDUZIXmfGI7sldBOnwjMF8S40HG3lc9MyhnFfz4Lltn
	 y7f/f/YWTVfIQ0bEGE2/E+bPL3Y3aojWZXxZOTkF/wx4aIeo0vjSezQugTxejtfkq8Tsy
	 d7j4MzmjY++DvYgf8oG5TyCRnj1LSnYioQ+8bVvn+FsvOLPNbXa5T+yQYe8nSHojQhV3l
	 TTpmOGi/JUKq7nZXA1xqkI04JBpFVWQFe9fpbnil+tF8fo6bdE34LVk2bAaZ9KYEoaUHB
	 3uWCeTzjm3RRJkUOOFZReMi0Lj0/lMM6JAP43zLLQL5DMqLf2QTD+XUsptuzdJbjgVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZ11h81a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A9606A31A;
	Sat, 31 Oct 2026 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZ11h81a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140A91F000C1;
	Sat, 31 Oct 2026 07:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793430354;
	bh=OagihIP284HBeckwq/KNJFNqJyjNcJi5p2KWfRoDcX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WZ11h81aZifRZtvY5HaRDhUgnEuF2UpPb0Gvth8T7kFqY9lSiT+QfxKS6VcU6RVJm
	 bTztcVNJwUl4T07Sski2uEQY6A8rArHdKOtRGq4aDunA14ajQZqBj3/3qq4SmqQ+x0
	 0p2b6SIbPX/JR/73mJole2Qhk5br5b4W4lCz2xqC/hnb9KSeRgS/Yo/3QnPxUiLS4c
	 6ckB4c6qdMzKkxukw1rqXAt4M//4V2wUCBZI9lltw5orzyMObf+72ZY+aYdKYNDLQo
	 aBakxRe4t3vkvVBtkLaLfa1+pWN/BFBSmB2q7d75ZKBMMrJ+sxf9EdujpTlqUIzieW
	 2xC6qbkqPiekg==
Date: Sat, 31 Oct 2026 00:05:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	chjohnst@mail.com, neelx@suse.com, sean@ashe.io,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 04/10] perf ftrace: Add basic task
 call stack management
Message-ID: <auWTUJd4VJUI32S3@z2>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-5-atomlin@atomlin.com>
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
In-Reply-To: <20261026025735.546101-5-atomlin@atomlin.com>

On Sun, Oct 25, 2026 at 10:57:29PM -0400, Aaron Tomlin wrote:
> The function_graph tracer records kernel function entries and exits with
> nested indentation. To perform call graph analysis and subsequent inlined
> function reconstruction, userspace must track the active call stack on a
> per-task and per-CPU basis.
> 
> Introduce basic call stack management for the function graph tracer:
> 
>     1.  Data structures
> 
>         Define struct ftrace_stack_frame to track function names,
>         indentation, and inlined status.
> 
>         Define struct ftrace_task_state with a dynamically resisable call
>         stack array, tracked in a hash table keyed by PID alongside per-CPU
>         active task bindings (ftrace_cpu_tasks).
> 
>     2.  Trace stream processing
> 
>         Implement find_func_column() to isolate context columns (CPU,
>         timestamps, duration) from function graph trace lines across
>         standard and verbose layouts.
> 
>         Implement ftrace_process_fgraph_line() to parse function entries
>         ("{") and exits ("}"), pushing and popping frames on the tracked
>         stack and matching bare closing braces against preceding frames.
> 
>     3.  Integration in __cmd_ftrace()
> 
>         Stream complete trace lines through ftrace_process_fgraph_line()
>         in __cmd_ftrace() and clean up allocated CPU states on exit via
>         ftrace_cpu_states__clear().
> 
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
[SNIP]
> +/**
> + * ftrace_process_fgraph_line - Process and output a function graph trace line
> + * @ftrace: Perf ftrace context
> + * @line: The trace line to process
> + * @out: File stream to output to
> + *
> + * Parse function entries and exits, maintain the task's call stack, and
> + * output the trace line.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
> +{
> +	const char *pipe_char;
> +	const char *after_pipe;
> +	const char *func_start;
> +	struct ftrace_task_state *cs;
> +	int cpu = -1;
> +	int leading_spaces;
> +	int top_raw_indent;
> +	int match_idx;
> +	int i;
> +	bool is_exit;
> +	bool has_open_brace;
> +	bool has_semicolon;
> +
> +	pipe_char = find_func_column(ftrace, line, &cpu);
> +	if (!pipe_char)
> +		return print_line(ftrace, line, out);
> +
> +	cs = get_cpu_state(ftrace, cpu);
> +	if (!cs)
> +		return print_line(ftrace, line, out);
> +
> +	after_pipe = pipe_char + 1;
> +	func_start = skip_spaces(after_pipe);
> +	leading_spaces = func_start - after_pipe;
> +
> +	if (*func_start == '\0')
> +		return print_line(ftrace, line, out);
> +
> +	is_exit = (*func_start == '}');
> +
> +	if (is_exit) {
> +		char exit_name[128];
> +
> +		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
> +
> +		top_raw_indent = -1;
> +		for (i = cs->depth - 1; i >= 0; i--) {
> +			top_raw_indent = cs->stack[i].raw_indent;
> +			break;
> +		}

This loop doesn't look natural.  Why not just use an if statement?

> +
> +		if (cs->overflow_depth > 0 &&
> +		    (top_raw_indent < 0 || leading_spaces > top_raw_indent)) {
> +			cs->overflow_depth--;
> +			return print_line(ftrace, line, out);
> +		}
> +
> +		match_idx = -1;
> +		if (exit_name[0] != '\0') {
> +			for (i = cs->depth - 1; i >= 0; i--) {
> +				if (cs->stack[i].name &&
> +				    cs->stack[i].raw_indent == leading_spaces &&
> +				    strcmp(cs->stack[i].name, exit_name) == 0) {
> +					match_idx = i;
> +					break;
> +				}
> +			}
> +		}
> +
> +		if (match_idx < 0 && exit_name[0] == '\0') {
> +			for (i = cs->depth - 1; i >= 0; i--) {
> +				if (cs->stack[i].raw_indent == leading_spaces) {
> +					match_idx = i;
> +					break;
> +				}
> +			}
> +		}
> +
> +		if (match_idx >= 0) {
> +			cs->overflow_depth = 0;
> +			while (cs->depth > match_idx) {
> +				free(cs->stack[cs->depth - 1].name);
> +				cs->depth--;
> +			}
> +		} else if (cs->overflow_depth > 0) {
> +			cs->overflow_depth--;
> +		}
> +
> +		return print_line(ftrace, line, out);
> +	}
> +
> +	has_open_brace = (strchr(func_start, '{') != NULL);
> +	has_semicolon = (strchr(func_start, ';') != NULL);
> +
> +	top_raw_indent = -1;
> +	for (i = cs->depth - 1; i >= 0; i--) {
> +		top_raw_indent = cs->stack[i].raw_indent;
> +		break;
> +	}

Ditto.

> +
> +	if (cs->overflow_depth > 0 && top_raw_indent >= 0 &&
> +	    leading_spaces <= top_raw_indent)
> +		cs->overflow_depth = 0;
> +
> +	if (has_open_brace && !has_semicolon) {
> +		char entry_name[128];
> +
> +		extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
> +		if (cs->depth >= cs->max_stack &&
> +		    ftrace_task_state__grow_stack(cs) < 0) {
> +			cs->overflow_depth++;
> +		} else {
> +			cs->stack[cs->depth].name = strdup(entry_name);
> +			if (!cs->stack[cs->depth].name) {
> +				pr_err("Not enough memory\n");
> +				return -ENOMEM;
> +			}
> +			cs->stack[cs->depth].inlined = false;
> +			cs->stack[cs->depth].indent = leading_spaces;
> +			cs->stack[cs->depth].raw_indent = leading_spaces;
> +			cs->depth++;
> +		}
> +	}
> +
> +	return print_line(ftrace, line, out);
> +}
> diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
> index a3a679f74e9d..fa2974f46582 100644
> --- a/tools/perf/util/ftrace.h
> +++ b/tools/perf/util/ftrace.h
> @@ -1,6 +1,9 @@
>  #ifndef __PERF_FTRACE_H__
>  #define __PERF_FTRACE_H__
>  
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <sys/types.h>
>  #include <linux/list.h>
>  
>  #include "target.h"
> @@ -93,7 +96,34 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
>  
>  #endif  /* HAVE_BPF_SKEL */
>  
> +#define FTRACE_MAX_CPUS 4096
> +#define FTRACE_MAX_STACK 256
> +#define FTRACE_PID_HASH_BITS 10
> +#define FTRACE_PID_HASH_SIZE (1 << FTRACE_PID_HASH_BITS)
> +
> +#define FTRACE_IDLE_PID(cpu)       ((pid_t)(-1 - (cpu)))
> +#define FTRACE_UNKNOWN_PID(cpu)    ((pid_t)(-1 - FTRACE_MAX_CPUS - (cpu)))
> +
> +struct ftrace_stack_frame {
> +	char *name;
> +	bool inlined;
> +	int indent;
> +	int raw_indent;

Can you please add comments that explain why it has two indents?
Also inlined field may be added later.


> +};
> +
> +struct ftrace_task_state {
> +	struct hlist_node	node;
> +	pid_t			pid;
> +	struct ftrace_stack_frame *stack;
> +	int			max_stack;
> +	int			depth;
> +	int			inlined_depth;
> +	int			overflow_depth;

Ditto.  What are these depths?

Thanks,
Namhyung


> +};
> +
>  bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
>  void ftrace_filter_retaddr(char *str);
> +void ftrace_cpu_states__clear(void);
> +int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out);
>  
>  #endif  /* __PERF_FTRACE_H__ */
> -- 
> 2.55.0
> 
