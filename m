Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777741;
	b=x8VZoqof9E1Tyaa0vwlg6chf9u5HgB/Rmqd5j6zCc9ZA7v9EPJqIAhzMKHLL/qI/HbgR
	 yuP7OFQ/k6HBy/8gkg9WFY75rEXTtSiDv5oP8+/XbSCCzRwRnvmdIS8BEDrO+K0rXDdRV
	 c/fFokuMkwpxVzJaTkDp73xxI5+Q3LlUbZjHXx1/N6KxZPoNoYR0LPQzOt3WcY5joylmZ
	 rtzvJ4ZuJc/VbCO/+ZkXuVYHpMdOB/OXXyS2mri49G7G37eN7/nm4VgQ8t7uM5NJAPsv8
	 ER/+zZA8shCBRA4mn2cQjxbXws+B8xSX4w3IIIbj4m6Qjh2sH+aJ7YZJK67fbhZ5Egg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777741;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=626tgi66kdQ74LDjwP+3KRmCPjqcDRZiyS0c4wH+xZo=;
	b=Vmz0lOdtI7FodMOp6j+EK6i+5SS5G+JwhORV7gMBtOavBGDZ4zDWaWDFL99OFH90we17
	 vsPcpXyM2zHCi2toXLA7LlD0ix6YT+yPNQ7ZfOOrjORjBMLAAk+Qu5JwFNDvY5Ob7kcEg
	 Dl7evW4a4tdvC1gbjHuH+PnOGb2Eoba/yYnYyah2+pIgRzoCvYjeOUsVqkGdXi+3i3T5F
	 aJER6sIrNlqgXG8MkD/HdEodCJqi/LmPz9RAbSMpBuaHpeZ8Chd3YAhhpVZ+70QF1rAJV
	 qRkKlWaivq7Bhw5lVhBH51X5YWlnE4Qo0cRIteGI8gJaizvqyi5xzA0437V66eA2G2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ft0cH+sk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7916606A31B;
	Wed,  4 Nov 2026 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ft0cH+sk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4741F000C1;
	Wed,  4 Nov 2026 07:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793777740;
	bh=626tgi66kdQ74LDjwP+3KRmCPjqcDRZiyS0c4wH+xZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ft0cH+skR6Jai/YWZUujt1P54xcE1puevc9ipPrWElFsmW5Yo5uCQ7/pjxbVglbHL
	 icwWlOQvPfwwLemZ4gAeyJqVZ9wsxK1wi4OT/OPbJdZ7aBZJ6yEg9daydHYXD6qlj9
	 JkekAveuP/lZs1EMzICXWA6wKbUrDtGnwHJm82pN0cSRKJh83RdQZOZvK77KovPnl9
	 9TBtth5CWuUJrOCknXc6kJTt4p2MuWkLKP0yzfKi7fmHzIaYkvfe/CTmdQbpjy0NXR
	 ZeQxfAA3ZMN0cJ3FrHka+3qbZn7GHaw266l7ndA7lERRDNivnueOi5FtPlDxR9EpKO
	 7+KtdpLFDQMMw==
Date: Tue, 3 Nov 2026 23:35:37 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	chjohnst@mail.com, neelx@suse.com, sean@ashe.io,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 04/10] perf ftrace: Add basic task
 call stack management
Message-ID: <aurgSbFGfN0VC2L6@z2>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-5-atomlin@atomlin.com>
 <auWTUJd4VJUI32S3@z2>
 <5s4fy255agvlgqdg4b4f5ekvhgmpjndydvsaadeq56cubrtgot@mrflkcricted>
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
In-Reply-To: <5s4fy255agvlgqdg4b4f5ekvhgmpjndydvsaadeq56cubrtgot@mrflkcricted>

Hello,

On Sat, Oct 31, 2026 at 06:27:42PM -0400, Aaron Tomlin wrote:
> On Sat, Oct 31, 2026 at 12:05:52AM -0700, Namhyung Kim wrote:
> > On Sun, Oct 25, 2026 at 10:57:29PM -0400, Aaron Tomlin wrote:
> > > The function_graph tracer records kernel function entries and exits with
> > > nested indentation. To perform call graph analysis and subsequent inlined
> > > function reconstruction, userspace must track the active call stack on a
> > > per-task and per-CPU basis.
> > > 
> > > Introduce basic call stack management for the function graph tracer:
> > > 
> > >     1.  Data structures
> > > 
> > >         Define struct ftrace_stack_frame to track function names,
> > >         indentation, and inlined status.
> > > 
> > >         Define struct ftrace_task_state with a dynamically resisable call
> > >         stack array, tracked in a hash table keyed by PID alongside per-CPU
> > >         active task bindings (ftrace_cpu_tasks).
> > > 
> > >     2.  Trace stream processing
> > > 
> > >         Implement find_func_column() to isolate context columns (CPU,
> > >         timestamps, duration) from function graph trace lines across
> > >         standard and verbose layouts.
> > > 
> > >         Implement ftrace_process_fgraph_line() to parse function entries
> > >         ("{") and exits ("}"), pushing and popping frames on the tracked
> > >         stack and matching bare closing braces against preceding frames.
> > > 
> > >     3.  Integration in __cmd_ftrace()
> > > 
> > >         Stream complete trace lines through ftrace_process_fgraph_line()
> > >         in __cmd_ftrace() and clean up allocated CPU states on exit via
> > >         ftrace_cpu_states__clear().
> > > 
> > > Tested-by: Ian Rogers <irogers@google.com>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > > ---
> > [SNIP]
> > > +/**
> > > + * ftrace_process_fgraph_line - Process and output a function graph trace line
> > > + * @ftrace: Perf ftrace context
> > > + * @line: The trace line to process
> > > + * @out: File stream to output to
> > > + *
> > > + * Parse function entries and exits, maintain the task's call stack, and
> > > + * output the trace line.
> > > + *
> > > + * Return: 0 on success, or a negative error code on failure.
> > > + */
> > > +int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
> > > +{
> > > +	const char *pipe_char;
> > > +	const char *after_pipe;
> > > +	const char *func_start;
> > > +	struct ftrace_task_state *cs;
> > > +	int cpu = -1;
> > > +	int leading_spaces;
> > > +	int top_raw_indent;
> > > +	int match_idx;
> > > +	int i;
> > > +	bool is_exit;
> > > +	bool has_open_brace;
> > > +	bool has_semicolon;
> > > +
> > > +	pipe_char = find_func_column(ftrace, line, &cpu);
> > > +	if (!pipe_char)
> > > +		return print_line(ftrace, line, out);
> > > +
> > > +	cs = get_cpu_state(ftrace, cpu);
> > > +	if (!cs)
> > > +		return print_line(ftrace, line, out);
> > > +
> > > +	after_pipe = pipe_char + 1;
> > > +	func_start = skip_spaces(after_pipe);
> > > +	leading_spaces = func_start - after_pipe;
> > > +
> > > +	if (*func_start == '\0')
> > > +		return print_line(ftrace, line, out);
> > > +
> > > +	is_exit = (*func_start == '}');
> > > +
> > > +	if (is_exit) {
> > > +		char exit_name[128];
> > > +
> > > +		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
> > > +
> > > +		top_raw_indent = -1;
> > > +		for (i = cs->depth - 1; i >= 0; i--) {
> > > +			top_raw_indent = cs->stack[i].raw_indent;
> > > +			break;
> > > +		}
> > 
> > This loop doesn't look natural.  Why not just use an if statement?
> 
> Hi Namhyung,
> 
> Thank you. I completely agree.
> 
> A loop that unconditionally breaks on the first iteration is
> unnecessary here. I will replace it with a simple conditional check in
> the next revision:
> 
>     top_raw_indent = -1;
>     if (cs->depth > 0)
>         top_raw_indent = cs->stack[cs->depth - 1].raw_indent;
> 
> All subsequent similar instances will be addressed accordingly as well.
> 
> > > +struct ftrace_stack_frame {
> > > +	char *name;
> > > +	bool inlined;
> > > +	int indent;
> > > +	int raw_indent;
> > 
> > Can you please add comments that explain why it has two indents?
> > Also inlined field may be added later.
> 
> Certainly. The two indent fields serve distinct purposes once inlined
> frames are injected into the output.
> 
>     - raw_indent: Records the original leading whitespace count after "|"
>       as emitted by the kernel's function_graph tracer. Because the kernel
>       only traces real stack frames, raw_indent is used to match entry and
>       exit frames against the raw trace stream.
> 
>     - indent: Records the adjusted visual indentation (in spaces) used when
>       rendering the frame to output, accounting for any extra indentation
>       added by preceding synthetic inlined frames so that the closing "}"
>       aligns with its opening "{".
> 
> Agreed, these fields are not used yet. I will move inlined and
> inlined_depth into the subsequent patch that introduces inlined function
> display, and add explanatory comments to both structures.
> 
> > > +};
> > > +
> > > +struct ftrace_task_state {
> > > +	struct hlist_node	node;
> > > +	pid_t			pid;
> > > +	struct ftrace_stack_frame *stack;
> > > +	int			max_stack;
> > > +	int			depth;
> > > +	int			inlined_depth;
> > > +	int			overflow_depth;
> > 
> > Ditto.  What are these depths?
> 
>     - max_stack: Current allocated capacity (in frames) of the dynamically
>       resized 'stack' array.
> 
>     - depth: Current number of active frames stored on stack.
> 
>     - inlined_depth: Number of active synthetic inlined frames currently on
>       stack, used to compute the extra visual indentation offset for
>       child frames. This will also be moved to the later patch.
> 
>     - overflow_depth: Number of nested call frames entered while stack is
>       saturated (at the maximum depth cap or on allocation failure), used
>       so their matching exit braces can be consumed without prematurely
>       popping valid parent frames.
> 
> I will document all of these fields with comments in the next revision.
> 
> Please see an example. When synthetic inlined frames are injected, the
> visual display column (indent) shifts right relative to the kernel stream
> (raw_indent):
> 
>     1.  What kernel function_graph emits:
> 
>            |  foo() {                 <-- raw_indent = 2
>            |    bar() {               <-- raw_indent = 4
>            |    } /* bar */           <-- raw_indent = 4
>            |  } /* foo */             <-- raw_indent = 2
> 
>     2.  Rendered output and stack state:
> 
>         When perf injects inlined function inline_helper() onto cs->stack,
>         inlined_depth becomes 1. Every subsequent child frame shifts right
>         by (inlined_depth * 2) spaces so bar() nests visually inside
>         inline_helper(), while still retaining raw_indent = 4 to match the
>         kernel's closing "}" event:
> 
>            Rendered Output            cs->stack[idx] and ftrace_task_state
>            ---------------            ---------------------------
>            |  foo() {                 [0] foo:
>            :                              raw_indent=2, indent=2, inlined=false
>            :                              (depth=1, inlined_depth=0)
>            :
>            |    inline_helper() {     [1] inline_helper:
>            :                              raw_indent=4, indent=4, inlined=true
>            :                              (depth=2, inlined_depth=1)
>            :
>            |      bar() {             [2] bar:
>            :                              raw_indent=4, indent=6, inlined=false
>            :                              (depth=3, inlined_depth=1)
>            :                              ^
>            :                              '-- indent = raw_indent (4) +
>            :                                           inlined_depth * 2 (2) = 6
>            :
>            |      } /* bar */         <-- kernel function_graph emits "}"
>            :                              at raw_indent=4. Matched against [2]
>            :                              via raw_indent=4, but printed at
>            :                              [2].indent (6 spaces)
>            :
>            |    } /* inline_helper */ <-- Popped automatically; printed at
>            :                              [1].indent (4 spaces)
>            :
>            |  } /* foo */             <-- kernel function_graph emits "}"
>                                           at raw_indent=2. Matched against [0]
>                                           via raw_indent=2, printed at
>                                           [0].indent (2 spaces)
> 

Thanks for the example,  the comment also look good.

Namhyung

