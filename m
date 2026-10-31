Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793430697;
	b=2IsXd/Hq8aL6jsRsamD0EWIBCjHUF2rtAxgRkYvGiaNohgUGGb44K3teW5qm8eooiN9/
	 HHstcCJeLjMq9zqc6ed5iNj6NUvcxoItaO5QDn446zoh57lyhE1qyo/WAsk1ce5tAhMyL
	 L9jhIlQoxTM4HmnQRodV8gzL8hWJZeZGXoU/tjAHFSZHrkKdAgGSkI0z7s4NZXI+S2QD3
	 Kr2BDZvueC/e9PLCSh1+bcy5cwXRbP42I0segJHa7LjvTnHi9eRZfwG5n7jCYQaDaUnGS
	 8qPTZweEl89ug2eDhmy2n4Z7XV4IDhXsFqyUrKtSy1aR3UqXwIzpqt0uU1Q7PSZ8hAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793430697;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MNSb9ssm6PkfnnU35o6Gc/PwNjgcFxJc+CzizpyKcEQ=;
	b=YVQ+1yseQj+nxOuyqJROsojYqKb++RziZka3kPy0/zTy1V3I0TjxCy8umyYmAS4rqa8X
	 1JZT4XDmd1z53dcp0FncGFe6FV4DEgYm/8ewvdvmk3WSaz/1bURKcNWhaeDJTxVgAYHnp
	 uGgbxHKGR1tSiOJGyyfiHE29k1hbv4rd4fXbGkkKrNWfMwlvh7C1zV4xh8T9AV618GKgW
	 CIb9ZYW1/+7/fKfyxh32l9oM9oN7M7dY+v8k+LHiX/HrABrsAokVvsFWJhRYNtfcAHASN
	 G4WompaEp60TD4JF/WrdhruBqgiALVyajSeEcQZDW7BEt1yZ6UX8q+fMD+Mr76STZKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OnUOa03a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21933606A31A;
	Sat, 31 Oct 2026 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OnUOa03a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD171F000C1;
	Sat, 31 Oct 2026 07:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793430696;
	bh=MNSb9ssm6PkfnnU35o6Gc/PwNjgcFxJc+CzizpyKcEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OnUOa03ac+I4pGZtYSk0Ww/0heqPOhUpcQHB7Eh9S6biQEFC84XnJ9sDfHtUEY6eu
	 9KHcv/KbuZN94dtpbsx9jLs4fzSfJw4t2k6FAyB2GSA8douPVv8ssMbVXo6TXYWPeT
	 /alrKBASakWLw/3IRvsheP9P2hqCEU3l5nyncA7JoPMcQIZigx7M9QycfSX2HulFUn
	 VEbja9jROF3enhxJcwmSVzChQkDvscD4a1Hp8uEI2mXHMGKVI/AS1+ayEvclBPrmVh
	 FsboFPm832Jr4ElHeu2rK0M9HtFJw+4jC+HTz7aJ/M4FAbsRPA9dHzdmK9r1SUmQSI
	 xR8dY5bkZ9/Zw==
Date: Sat, 31 Oct 2026 00:11:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	chjohnst@mail.com, neelx@suse.com, sean@ashe.io,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 06/10] perf ftrace: Support display
 of inlined functions in function graph tracer
Message-ID: <auWUpl0toDFpwSYS@z2>
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
> @@ -664,11 +834,16 @@ static void extract_exit_func_name(const char *str, char *buf, size_t size)
>   * @cpu: Pointer to store the CPU number
>   *
>   * Locate the context columns that precede the function call column of a
> - * function_graph trace record.
> + * function_graph trace record. Depending on the funcgraph-* options set
> + * up by perf, a record looks like:
> + *
> + *   [ abstime |]  CPU)  [ comm-pid |]  [ duration |]  func
> + *
> + * The abstime and comm-pid columns are only present with --graph-opts
> + * verbose.
>   *
>   * Return: A pointer to the last character of the context columns (the final
> - * '|' delimiter, or the CPU ')' when no delimiter follows it). Returns NULL
> - * if @line is not a trace record.
> + * '|' delimiter). Returns NULL if @line is not a trace record.
>   */

It'd be nice if you could move the comments to the original commit that
introduced the function.


>  static const char *find_func_column(const struct perf_ftrace *ftrace,
>  				    const char *line, int *cpu)
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

Hmm.. probably better to define the structs in the .c file in the first
place?

Thanks,
Namhyung


> +#define FTRACE_MAX_INLINES 32
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
