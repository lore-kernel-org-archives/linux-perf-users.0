Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706038;
	b=S4MR2STLasGnndugYd/6r5K+OpXE6DBsPLwPvsKxzqW2B0L2iSA8qYcU/gF56yp1ss5d
	 OkzBdCLS95EdjoKygVBhxB2Ne0Q/yHo1R8fYgL613l5UUezqhDlsBSNEv7fL4loPwsSBK
	 9SZQYibRT5ypfhSW2Lvbzj2GgzbuS13auIVHPPufoCoH2nItb9izj/svL+zmtmh1ISzSn
	 JmgnuZjLRHsIG0GtHdcncCCiwkInKlE7MJNDyXEXGP+NmSV1GwtpBig1Csq5CYszgHH7X
	 9QHQp3Oo0r6pWy/Jlp/Jzd4/qYL5UMp+32IqJ1/hE4Pk3nnlFYtu0i7es75v/2Iv9Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706038;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bGTfheeLbNCe6iN1y+HOcjRelbzWu8NR2QHXqBh3AZ0=;
	b=UEUsk6HHERbRf3mlA1oEV7IlQCdOm9JCAulFxeopubJNDFfpt5+5PXp4+cSzvqscPDUW
	 8lN3H1upNqtn2H/ZizudxIfSG7epVVjpSgFzXInamEg/ThibtwTxAgypKe0k4+oKaLZ7b
	 isHGNXmN3nXhBZ4wI+lM/0zGtbXy5X3KS8D0cy350lin5F755riDHN2nhymK0dQBEEVpB
	 iH0GpcBtyKweqGHiOJIg2/L03GVm3YWoctmkcTzwJuGXWCPjHBsgaBjO8B6TOaWY37ZRu
	 q/+NQ05pKOZ8RUUZzqybcyuSRhM7Ft9oxnXVD5aF371uR0II+0+rvtQeAUTP199UrKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmghtLWC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA0606A31A;
	Thu, 22 Oct 2026 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmghtLWC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163261F01825;
	Thu, 22 Oct 2026 21:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792706036;
	bh=bGTfheeLbNCe6iN1y+HOcjRelbzWu8NR2QHXqBh3AZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gmghtLWC0R5Vab/VZmP3rQ4rXYHfHLPZP+NgSq51I1ACAZOy+FAuNXE4or0o9orka
	 bgEq8T6WlVVjUHatF/R8jzzTighLNve1KhwecE7jnGzsL46RMXW+NtyYX9Vz++rs7q
	 vqz6If5OPUE6MxQ3ZK1e/3jr/TMUpUAvPhRNOZnRCXPCJYRr7bnD/F5VjlekWRoB27
	 YmhTiM1YFEyYP4T8SucyUypEOT5uke7CBA4vpIcnAh1l0EyS8ZsUqiYlfMTxpksFqE
	 BGXbCl25QE7UKfNDZObAICW1L18i9pNyazLdCaw/vRk+hGFvlliITzzTrpKAU+Ro4s
	 Ba+H10cV1Lbqg==
Date: Thu, 22 Oct 2026 14:53:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v9 4/6] perf ftrace: Support display of
 inlined functions in function graph tracer
Message-ID: <atqF8rgKGnaH7EhQ@google.com>
References: <20261021023337.809936-1-atomlin@atomlin.com>
 <20261021023337.809936-5-atomlin@atomlin.com>
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
In-Reply-To: <20261021023337.809936-5-atomlin@atomlin.com>

On Tue, Oct 20, 2026 at 10:33:35PM -0400, Aaron Tomlin wrote:
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
>     1.  Inlined frame presentation
> 
>         Synthesised inlined functions are rendered with an explicit
>         /* (inline) */ annotation at both entry and exit:
> 
>             # tracer: function_graph
>             #
>             # CPU               FUNCTION CALLS
>             # |                 |   |   |   |
>              6) activate_task() {
>              6)   enqueue_task() {
>              6)     enqueue_task_fair() {
>              6)       update_curr_eevdf() { /* (inline) */
>              6)         update_curr() {
>              6)           update_se() {
>              6)             cgroup_account_cputime() { /* (inline) */
>              6)               cpuacct_charge();
>              6)             } /* cgroup_account_cputime (inline) */
>              6)           }
>              6)           dl_server_update() {
>              6)             update_curr_dl_se();
>              6)         }
>              6)       } /* update_curr_eevdf (inline) */
>              6)       enqueue_hierarchy() { /* (inline) */
>              6)         update_curr() {
>              6)           update_se();
>              6)         }
>              6)         enqueue_entity() {
>              6)           account_entity_enqueue() { /* (inline) */
>              6)             account_llc_enqueue();
>              6)           } /* account_entity_enqueue (inline) */
>              6)         }
>              6)       } /* enqueue_hierarchy (inline) */
>              6)       place_entity() {
>              6)         avg_vruntime();
>              6)       }
>              6)       __enqueue_entity();
>              6)       dl_server_start();
>              6)       hrtick_update() { /* (inline) */
>              6)         hrtick_active() { /* (inline) */
>              6)           hrtimer_active();
>              6)         } /* hrtick_active (inline) */
>              6)       } /* hrtick_update (inline) */
>              6)       hrtick_start_fair();
>              6)     psi_enqueue() { /* (inline) */
>              6)       psi_task_change() {
>              6)         psi_flags_change();
>              6)         psi_group_change() {
>              6)           record_times();
>              6)         }
>              6)       }
>              6)     } /* psi_enqueue (inline) */
>              6)   }
>              6) }
> 
>         This affords immediate visual clarity to the reader upon
>         entering an inlined scope, without necessitating a search for
>         the closing delimiter.
> 
>     2.  Call graph reconstruction and per-task stack tracking
> 
>         Maintains a per-task synthetic call stack tracking real and
>         inlined frames across context switches, synthesising entry and
>         exit delimiters to accurately reconstruct the execution
>         hierarchy. Tasks are tracked in a hash table keyed by PID, with
>         per-CPU active bindings updated upon context-switch banners or
>         verbose line records. Inlined frames are structured strictly
>         root-to-leaf and validated against the active stack to prevent
>         un-traced callers from attaching orphan inlines. Bare closing
>         braces without trailing function names (the default when
>         funcgraph-tail is disabled) are correctly matched against
>         preceding frames on the stack. Context column alignment,
>         including task comm-pid delimiters in verbose mode, is preserved
>         when generating prefixes for synthesised inline frames.
>         Furthermore, stack depth saturation guards ensure that inlined
>         frame depth tracking remains clamped, indentation cannot drift
>         even under deep call trees exceeding FTRACE_MAX_STACK, and
>         overflow depth is automatically recovered upon caller detection.
> 
>     3.  Option handling and diagnostics
> 
>         Adds -k or --vmlinux to designate an explicit debug image, and
>         provides clear diagnostic guidance should --inline be invoked on
>         a kernel lacking CONFIG_FUNCTION_GRAPH_RETADDR. Automatically
>         enables return address comment filtering unless explicitly
>         requested.
> 
>     4.  Automated verification
> 
>         Expands the unit test suite in tools/perf/tests/ftrace.c to
>         validate DWARF inline symbol resolution, comment filtering
>         toggles, bare closing braces handling, task context-switch
>         isolation and migration, and stack saturation/overflow recovery.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/Documentation/perf-ftrace.txt |   17 +-
>  tools/perf/builtin-ftrace.c              |   76 +-
>  tools/perf/tests/ftrace.c                |  914 ++++++++++++++++++-
>  tools/perf/util/ftrace.c                 | 1059 +++++++++++++++++++++-
>  tools/perf/util/ftrace.h                 |   14 +
>  5 files changed, 2059 insertions(+), 21 deletions(-)

I think it's too big and you can split into pieces like:

 1. add the basic task stack management code
 2. support context switch
 3. support inline functions
 4. add test code

Thanks,
Namhyung

> 
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index e8105083e67c..445c8ccc22d2 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -134,9 +134,24 @@ OPTIONS for 'perf ftrace trace'
>  	  - depth=<n>    - Set max depth for function graph tracer to follow.
>  	  - tail         - Print function name at the end.
>  
> +--inline::
> +	Show inlined functions in function_graph tracer. This requires
> +	kernel support for the funcgraph-retaddr option and a vmlinux with
> +	debug symbols. Inlined functions are displayed in the call graph
> +	hierarchy, and their inlined status is indicated with `/* (inline) */`
> +	on entry and exit, e.g. `func() { /* (inline) */` and `} /* func (inline) */`.
> +	By default, raw return address comments (`/* <-caller+offset */`)
> +	are hidden in the output; specify `--graph-opts retaddr` to show them.
> +
>  --filter-retaddr::
>  	Filter out function return address comments (`/* <-caller+offset */`)
> -	from function_graph output.
> +	from function_graph output. This is enabled by default when `--inline`
> +	is used; use `--no-filter-retaddr` to disable it.
> +
> +-k::
> +--vmlinux=::
> +	Path to the vmlinux file containing debug symbols for resolving
> +	inlined functions.
>  
>  
>  OPTIONS for 'perf ftrace latency'
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index c715cbebaabe..ed483bb20ed5 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -575,9 +575,14 @@ static int set_tracing_funcgraph_retval(struct perf_ftrace *ftrace)
>  
>  static int set_tracing_funcgraph_retaddr(struct perf_ftrace *ftrace)
>  {
> -	if (ftrace->graph_retaddr) {
> -		if (write_tracing_option_file("funcgraph-retaddr", "1") < 0)
> +	if (ftrace->graph_retaddr || ftrace->use_inline) {
> +		if (write_tracing_option_file("funcgraph-retaddr", "1") < 0) {
> +			if (ftrace->use_inline) {
> +				pr_err("failed to set funcgraph-retaddr option in tracing\n");
> +				pr_err("Hint: ensure kernel is compiled with CONFIG_FUNCTION_GRAPH_RETADDR=y\n");
> +			}
>  			return -1;
> +		}
>  	}
>  
>  	return 0;
> @@ -744,6 +749,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  	int trace_fd;
>  	char *buf = NULL;
>  	struct strbuf linebuf = STRBUF_INIT;
> +	int ret = 0;
>  	struct pollfd pollfd = {
>  		.events = POLLIN,
>  	};
> @@ -770,6 +776,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  		goto out_reset;
>  	}
>  
> +	if (perf_ftrace__setup_inlines(ftrace) < 0)
> +		goto out_reset;
> +
>  	setup_pager();
>  
>  	buf = malloc(TRACE_BUF_SIZE);
> @@ -837,14 +846,20 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  				break;
>  			for (int i = 0; i < n; i++) {
>  				if (buf[i] == '\n') {
> -					if (ftrace->filter_retaddr)
> -						ftrace_filter_retaddr(linebuf.buf);
> -					if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
> +					if (ftrace_process_fgraph_line(ftrace,
> +								       linebuf.buf,
> +								       stdout) < 0) {
> +						ret = -1;
> +						goto out_close_fd;
> +					}
> +					if (ferror(stdout))
>  						break;
>  					strbuf_setlen(&linebuf, 0);
>  				} else {
> -					if (strbuf_addch(&linebuf, buf[i]) < 0)
> +					if (strbuf_addch(&linebuf, buf[i]) < 0) {
> +						ret = -1;
>  						goto out_close_fd;
> +					}
>  				}
>  			}
>  			/* flush output since stdout is in full buffering mode due to pager */
> @@ -876,22 +891,30 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  			break;
>  		for (int i = 0; i < n; i++) {
>  			if (buf[i] == '\n') {
> -				if (ftrace->filter_retaddr)
> -					ftrace_filter_retaddr(linebuf.buf);
> -				if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
> +				if (ftrace_process_fgraph_line(ftrace,
> +							       linebuf.buf,
> +							       stdout) < 0) {
> +					ret = -1;
> +					goto out_close_fd;
> +				}
> +				if (ferror(stdout))
>  					break;
>  				strbuf_setlen(&linebuf, 0);
>  			} else {
> -				if (strbuf_addch(&linebuf, buf[i]) < 0)
> +				if (strbuf_addch(&linebuf, buf[i]) < 0) {
> +					ret = -1;
>  					goto out_close_fd;
> +				}
>  			}
>  		}
>  	}
>  
>  	if (!ferror(stdout) && linebuf.len > 0) {
> -		if (ftrace->filter_retaddr)
> -			ftrace_filter_retaddr(linebuf.buf);
> -		fprintf(stdout, "%s\n", linebuf.buf);
> +		if (ftrace_process_fgraph_line(ftrace, linebuf.buf,
> +					       stdout) < 0) {
> +			ret = -1;
> +			goto out_close_fd;
> +		}
>  		strbuf_setlen(&linebuf, 0);
>  	}
>  
> @@ -901,9 +924,10 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  	free(buf);
>  	strbuf_release(&linebuf);
>  out_reset:
> +	perf_ftrace__cleanup_inlines(ftrace);
>  	exit_tracing_instance();
>  out:
> -	return (done && !workload_exec_errno) ? 0 : -1;
> +	return (ret == 0 && done && !workload_exec_errno) ? 0 : -1;
>  }
>  
>  static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
> @@ -1856,8 +1880,13 @@ int cmd_ftrace(int argc, const char **argv)
>  		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
>  	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
>  		    "Trace children processes"),
> -	OPT_BOOLEAN_SET(0, "filter-retaddr", &ftrace.filter_retaddr, &ftrace.filter_retaddr_set,
> -			"Filter out funcgraph return address comments"),
> +	OPT_BOOLEAN(0, "inline", &ftrace.use_inline,
> +		    "Show inlined functions in function_graph tracer"),
> +	OPT_BOOLEAN_SET(0, "filter-retaddr", &ftrace.filter_retaddr,
> +			&ftrace.filter_retaddr_set,
> +			"Filter out funcgraph return address comments (default with --inline)"),
> +	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name, "file",
> +		   "vmlinux pathname"),
>  	OPT_INTEGER('D', "delay", &ftrace.target.initial_delay,
>  		    "Number of milliseconds to wait before starting tracing after program start"),
>  	OPT_PARENT(common_options),
> @@ -1973,6 +2002,21 @@ int cmd_ftrace(int argc, const char **argv)
>  
>  	switch (subcmd) {
>  	case PERF_FTRACE_TRACE:
> +		select_tracer(&ftrace);
> +
> +		if (ftrace.use_inline) {
> +			if (strcmp(ftrace.tracer, "function_graph") != 0) {
> +				pr_err("Error: --inline option is only supported with function_graph tracer\n");
> +				ret = -EINVAL;
> +				goto out_delete_filters;
> +			}
> +		}
> +		if (!ftrace.filter_retaddr_set) {
> +			if (ftrace.use_inline && !ftrace.graph_retaddr)
> +				ftrace.filter_retaddr = true;
> +			else
> +				ftrace.filter_retaddr = false;
> +		}
>  		cmd_func = __cmd_ftrace;
>  		break;
>  	case PERF_FTRACE_LATENCY:
> diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
> index 42604811a2fb..44ed5d7dcf98 100644
> --- a/tools/perf/tests/ftrace.c
> +++ b/tools/perf/tests/ftrace.c
> @@ -7,7 +7,13 @@
>  #include <unistd.h>
>  #include "tests.h"
>  #include "debug.h"
> +#include "dso.h"
> +#include "machine.h"
> +#include "map.h"
> +#include "symbol.h"
>  #include "util/ftrace.h"
> +#include "evlist.h"
> +#include "thread_map.h"
>  
>  static int test_parse_retaddr(void)
>  {
> @@ -63,6 +69,896 @@ static int test_filter_retaddr(void)
>  	return TEST_OK;
>  }
>  
> +#define TEST_CHECK(text, cond)					\
> +do {								\
> +	if (!(cond)) {						\
> +		pr_debug("FAILED %s:%d %s\n", __FILE__, __LINE__, text); \
> +		ret = TEST_FAIL;				\
> +		goto out_cleanup;				\
> +	}							\
> +} while (0)
> +
> +static int test_inline_processing(void)
> +{
> +	static const char line_entry[] = " 0)               |  wake_up_new_task() {";
> +	static const char line_enqueue[] =
> +		" 0)               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */";
> +	static const char line_exit_enqueue[] = " 0) + 10.000 us   |    } /* enqueue_task */";
> +	static const char line_exit_task[] = " 0) + 20.000 us   |  } /* wake_up_new_task */";
> +	static const char line_bare_enqueue[] = " 0) + 10.000 us   |    }";
> +	static const char line_bare_task[] = " 0) + 20.000 us   |  }";
> +	static const char line_unmatched[] = " 0) +  5.000 us   |    } /* unrelated_func */";
> +	static const char line_verbose_entry[] =
> +		" 1234.567890 |   0)   bash-1234    |  ....   |               |  wake_up_new_task() {";
> +	static const char line_verbose_enqueue[] =
> +		" 1234.567890 |   0)   bash-1234    |  ....   |               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */";
> +	static const char line_verbose_exit_enqueue[] =
> +		" 1234.567890 |   0)   bash-1234    |  ....   |   1.234 us    |    } /* enqueue_task */";
> +	static const char line_verbose_exit_task[] =
> +		" 1234.567890 |   0)   bash-1234    |  ....   |   2.567 us    |  } /* wake_up_new_task */";
> +	static const char line_verbose_inline_entry[] =
> +		" 1234.567890 |   0)   bash-1234    |  ....   |               |    activate_task() { /* (inline) */";
> +	static const char line_verbose_inline_exit[] =
> +		" 1234.567890 |   0)   bash-1234    |  ....   |               |    } /* activate_task (inline) */";
> +	struct perf_ftrace ftrace;
> +	char *out_buf = NULL;
> +	size_t out_len = 0;
> +	FILE *out;
> +	const char *unmatched_pos;
> +	const char *inline_exit_pos;
> +	const char *vmlinux;
> +	const char *saved_vmlinux = symbol_conf.vmlinux_name;
> +	bool saved_ignore_buildid = symbol_conf.ignore_vmlinux_buildid;
> +	int ret = TEST_OK;
> +
> +	memset(&ftrace, 0, sizeof(ftrace));
> +	ftrace.use_inline = true;
> +	ftrace.filter_retaddr = 1; /* Default when --graph-opts retaddr is not specified */
> +	ftrace.tracer = "function_graph";
> +
> +	vmlinux = vmlinux_path__find();
> +
> +	/* If vmlinux is present, test resolving symbols */
> +	if (vmlinux) {
> +		const char *inlined_names[FTRACE_MAX_INLINES];
> +		int num_inlines;
> +		int j;
> +
> +		symbol_conf.vmlinux_name = vmlinux;
> +		symbol_conf.ignore_vmlinux_buildid = true;
> +		ret = perf_ftrace__setup_inlines(&ftrace);
> +		if (ret < 0 || !ftrace.machine) {
> +			ret = TEST_SKIP;
> +			goto out_cleanup;
> +		}
> +
> +		num_inlines = ftrace_resolve_inlines(ftrace.machine,
> +						     "wake_up_new_task", 0x1d1,
> +						     inlined_names,
> +						     FTRACE_MAX_INLINES);
> +		if (num_inlines <= 0 || strcmp(inlined_names[0], "activate_task") != 0) {
> +			pr_debug("vmlinux does not inline activate_task at wake_up_new_task+0x1d1; skipping inline test\n");
> +			for (j = 0; j < num_inlines; j++)
> +				free((void *)inlined_names[j]);
> +			ret = TEST_SKIP;
> +			goto out_cleanup;
> +		}
> +		for (j = 0; j < num_inlines; j++)
> +			free((void *)inlined_names[j]);
> +
> +		if (ftrace_resolve_inlines(ftrace.machine, "wake_up_new_task", 0,
> +					   inlined_names, FTRACE_MAX_INLINES) != 0) {
> +			pr_debug("ftrace_resolve_inlines with offset 0 should return 0\n");
> +			ret = TEST_FAIL;
> +			goto out_cleanup;
> +		}
> +
> +		out = open_memstream(&out_buf, &out_len);
> +		if (!out) {
> +			ret = TEST_FAIL;
> +			goto out_cleanup;
> +		}
> +
> +		/* Feed simulated function graph trace lines */
> +		ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +		ftrace_process_fgraph_line(&ftrace, line_exit_enqueue, out);
> +		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
> +
> +		fclose(out);
> +		ftrace_cpu_states__clear();
> +
> +		pr_debug("Processed output:\n%s\n", out_buf);
> +
> +		/* Verify activate_task entry with inline hint */
> +		TEST_CHECK("contains activate_task entry with inline hint",
> +			   strstr(out_buf, "activate_task() { /* (inline) */") != NULL);
> +
> +		/* Verify activate_task exit with inline hint */
> +		TEST_CHECK("contains activate_task exit with inline hint",
> +			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
> +
> +		/* Verify return address comment was filtered out by default */
> +		TEST_CHECK("retaddr comment filtered out",
> +			   strstr(out_buf, "/* <-wake_up_new_task") == NULL);
> +
> +		free(out_buf);
> +		out_buf = NULL;
> +
> +		/* Now test with filter_retaddr = 0 (user specified --graph-opts retaddr) */
> +		ftrace.filter_retaddr = 0;
> +		out = open_memstream(&out_buf, &out_len);
> +		if (!out) {
> +			ret = TEST_FAIL;
> +			goto out_cleanup;
> +		}
> +
> +		ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +		ftrace_process_fgraph_line(&ftrace, line_exit_enqueue, out);
> +		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
> +
> +		fclose(out);
> +		ftrace_cpu_states__clear();
> +
> +		/* Verify return address comment IS preserved when filter_retaddr = 0 */
> +		TEST_CHECK("retaddr comment preserved when requested",
> +			   strstr(out_buf, "/* <-wake_up_new_task") != NULL);
> +
> +		free(out_buf);
> +		out_buf = NULL;
> +
> +		/* Test with bare closing braces (funcgraph-tail disabled by default) */
> +		ftrace.filter_retaddr = 1;
> +		out = open_memstream(&out_buf, &out_len);
> +		if (!out) {
> +			ret = TEST_FAIL;
> +			goto out_cleanup;
> +		}
> +
> +		ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +		ftrace_process_fgraph_line(&ftrace, line_bare_enqueue, out);
> +		ftrace_process_fgraph_line(&ftrace, line_bare_task, out);
> +
> +		fclose(out);
> +
> +		TEST_CHECK("bare braces inline entry",
> +			   strstr(out_buf, "activate_task() { /* (inline) */") != NULL);
> +		TEST_CHECK("bare braces inline exit",
> +			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
> +
> +		free(out_buf);
> +		out_buf = NULL;
> +
> +		/* Test bare closing brace matches outer frame when inner callee exit was dropped */
> +		out = open_memstream(&out_buf, &out_len);
> +		if (!out) {
> +			ret = TEST_FAIL;
> +			goto out_cleanup;
> +		}
> +
> +		ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +		/* line_bare_enqueue is dropped! */
> +		ftrace_process_fgraph_line(&ftrace, line_bare_task, out);
> +
> +		fclose(out);
> +
> +		TEST_CHECK("dropped callee exit: inlined frame closed",
> +			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
> +		TEST_CHECK("dropped callee exit: outer bare brace emitted",
> +			   strstr(out_buf, "  }") != NULL);
> +
> +		free(out_buf);
> +		out_buf = NULL;
> +
> +		/* Test that unmatched exit events do not pop active inlined frames */
> +		out = open_memstream(&out_buf, &out_len);
> +		if (!out) {
> +			ret = TEST_FAIL;
> +			goto out_cleanup;
> +		}
> +
> +		ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +		ftrace_process_fgraph_line(&ftrace, line_exit_enqueue, out);
> +		/* Unmatched exit event while activate_task is still active */
> +		ftrace_process_fgraph_line(&ftrace, line_unmatched, out);
> +		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
> +
> +		fclose(out);
> +
> +		unmatched_pos = strstr(out_buf, "} /* unrelated_func */");
> +		inline_exit_pos = strstr(out_buf, "} /* activate_task (inline) */");
> +
> +		TEST_CHECK("unmatched exit present", unmatched_pos != NULL);
> +		TEST_CHECK("inline exit present", inline_exit_pos != NULL);
> +		TEST_CHECK("inline exit not prematurely popped before unmatched exit",
> +			   inline_exit_pos > unmatched_pos);
> +
> +		free(out_buf);
> +		out_buf = NULL;
> +
> +		/* Test recovery when an intermediate real function exit event is dropped */
> +		out = open_memstream(&out_buf, &out_len);
> +		if (!out) {
> +			ret = TEST_FAIL;
> +			goto out_cleanup;
> +		}
> +
> +		ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +		/* line_exit_enqueue is dropped; outer wake_up_new_task exits directly */
> +		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
> +
> +		fclose(out);
> +
> +		TEST_CHECK("inline exit synthesized despite dropped callee exit",
> +			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
> +
> +		free(out_buf);
> +		out_buf = NULL;
> +
> +		/* Test recovery when intermediate callee exit is dropped before sibling call */
> +		out = open_memstream(&out_buf, &out_len);
> +		if (!out) {
> +			ret = TEST_FAIL;
> +			goto out_cleanup;
> +		}
> +
> +		ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +		/* line_exit_enqueue dropped; caller makes sibling call without inlines */
> +		ftrace_process_fgraph_line(&ftrace,
> +			" 0)               |    check_preempt_curr(); /* <-wake_up_new_task+0x0/0x3e0 */",
> +			out);
> +		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
> +
> +		fclose(out);
> +
> +		TEST_CHECK("inline exit synthesized when callee exit dropped before sibling call",
> +			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
> +
> +		free(out_buf);
> +		out_buf = NULL;
> +
> +		/* Test that callers not on active stack do not synthesise inlines */
> +		out = open_memstream(&out_buf, &out_len);
> +		if (!out) {
> +			ret = TEST_FAIL;
> +			goto out_cleanup;
> +		}
> +
> +		ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +		/* housekeeping_any_cpu called by untraced ring_buffer_unlock_commit */
> +		ftrace_process_fgraph_line(&ftrace,
> +			" 0)               |    housekeeping_any_cpu(); /* <-ring_buffer_unlock_commit+0x1a0/0x1f0 */",
> +			out);
> +		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
> +
> +		fclose(out);
> +
> +		TEST_CHECK("untraced caller inlines not synthesised",
> +			   strstr(out_buf, "rb_wakeups") == NULL &&
> +			   strstr(out_buf, "rb_irq_work_queue") == NULL);
> +
> +		free(out_buf);
> +		out_buf = NULL;
> +
> +		/* Test trailing inlined frame closed on untraced entry (caller_idx < 0) */
> +		out = open_memstream(&out_buf, &out_len);
> +		if (!out) {
> +			ret = TEST_FAIL;
> +			goto out_cleanup;
> +		}
> +
> +		ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +		/* line_enqueue has inlined activate_task() open; next entry has caller_idx < 0 */
> +		ftrace_process_fgraph_line(&ftrace,
> +					   " 0)               |    irq_handler() {",
> +					   out);
> +		ftrace_process_fgraph_line(&ftrace,
> +					   " 0)               |    } /* irq_handler */",
> +					   out);
> +		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
> +
> +		fclose(out);
> +
> +		TEST_CHECK("trailing inline frame closed before untraced call",
> +			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
> +		TEST_CHECK("untraced call not indented inside trailing inline frame",
> +			   strstr(out_buf, "    irq_handler() {") != NULL);
> +
> +		free(out_buf);
> +		out_buf = NULL;
> +
> +		/* Test dropped exits unwound when new function starts at shallower indent */
> +		out = open_memstream(&out_buf, &out_len);
> +		if (!out) {
> +			ret = TEST_FAIL;
> +			goto out_cleanup;
> +		}
> +
> +		ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +		/* Exits dropped! New root entry arrives at indent 2 */
> +		ftrace_process_fgraph_line(&ftrace,
> +					   " 0)               |  schedule() {",
> +					   out);
> +		ftrace_process_fgraph_line(&ftrace,
> +					   " 0)               |  } /* schedule */",
> +					   out);
> +
> +		fclose(out);
> +
> +		TEST_CHECK("stale inlines closed when new root arrives",
> +			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
> +		TEST_CHECK("new root entry printed without stale indentation",
> +			   strstr(out_buf, "  schedule() {") != NULL);
> +
> +		free(out_buf);
> +		out_buf = NULL;
> +
> +		/* Test verbose mode prefix formatting for synthesised inlines */
> +		ftrace.graph_verbose = true;
> +		out = open_memstream(&out_buf, &out_len);
> +		if (!out) {
> +			ret = TEST_FAIL;
> +			goto out_cleanup;
> +		}
> +
> +		ftrace_process_fgraph_line(&ftrace, line_verbose_entry, out);
> +		ftrace_process_fgraph_line(&ftrace, line_verbose_enqueue, out);
> +		ftrace_process_fgraph_line(&ftrace, line_verbose_exit_enqueue, out);
> +		ftrace_process_fgraph_line(&ftrace, line_verbose_exit_task, out);
> +
> +		fclose(out);
> +		ftrace_cpu_states__clear();
> +
> +		TEST_CHECK("verbose inline entry preserves comm-pid",
> +			   strstr(out_buf, line_verbose_inline_entry) != NULL);
> +		TEST_CHECK("verbose inline exit preserves comm-pid",
> +			   strstr(out_buf, line_verbose_inline_exit) != NULL);
> +
> +		free(out_buf);
> +		out_buf = NULL;
> +		ftrace.graph_verbose = false;
> +	}
> +
> +out_cleanup:
> +	free(out_buf);
> +	perf_ftrace__cleanup_inlines(&ftrace);
> +	symbol_conf.vmlinux_name = saved_vmlinux;
> +	symbol_conf.ignore_vmlinux_buildid = saved_ignore_buildid;
> +	return ret;
> +}
> +#undef TEST_CHECK
> +
> +static void feed_fgraph_entry(struct perf_ftrace *ftrace, int cpu, int depth,
> +			      const char *name, const char *retaddr, FILE *out)
> +{
> +	char line[1024];
> +	int indent = 2 + 2 * depth;
> +
> +	if (retaddr) {
> +		snprintf(line, sizeof(line), " %d)               |%*s%s() { /* <-%s */",
> +			 cpu, indent, "", name, retaddr);
> +	} else {
> +		snprintf(line, sizeof(line), " %d)               |%*s%s() {",
> +			 cpu, indent, "", name);
> +	}
> +	ftrace_process_fgraph_line(ftrace, line, out);
> +}
> +
> +static void feed_fgraph_exit(struct perf_ftrace *ftrace, int cpu, int depth,
> +			     const char *name, FILE *out)
> +{
> +	char line[1024];
> +	int indent = 2 + 2 * depth;
> +
> +	if (name) {
> +		snprintf(line, sizeof(line), " %d)   1.000 us    |%*s} /* %s */",
> +			 cpu, indent, "", name);
> +	} else {
> +		snprintf(line, sizeof(line), " %d)   1.000 us    |%*s}",
> +			 cpu, indent, "");
> +	}
> +	ftrace_process_fgraph_line(ftrace, line, out);
> +}
> +
> +static int test_stack_saturation(void)
> +{
> +	struct perf_ftrace ftrace;
> +	char *out_buf = NULL;
> +	size_t out_len = 0;
> +	FILE *out;
> +	const char *vmlinux;
> +	int i;
> +
> +	memset(&ftrace, 0, sizeof(ftrace));
> +	ftrace.use_inline = true;
> +	ftrace_cpu_states__clear();
> +
> +	out = open_memstream(&out_buf, &out_len);
> +	if (!out)
> +		return TEST_FAIL;
> +
> +	/* Push root frame at depth 0 */
> +	feed_fgraph_entry(&ftrace, 0, 0, "root_func", NULL, out);
> +
> +	/* Push 255 more frames to fill FTRACE_MAX_STACK (256) */
> +	for (i = 1; i < 256; i++)
> +		feed_fgraph_entry(&ftrace, 0, i, "sub_func", NULL, out);
> +
> +	/* Push 44 overflow frames beyond FTRACE_MAX_STACK */
> +	for (i = 0; i < 44; i++)
> +		feed_fgraph_entry(&ftrace, 0, 256 + i, "overflow_func", NULL, out);
> +
> +	/* Pop the 44 overflow frames with bare closing braces */
> +	for (i = 43; i >= 0; i--)
> +		feed_fgraph_exit(&ftrace, 0, 256 + i, NULL, out);
> +
> +	/* Pop 255 tracked sub_func frames */
> +	for (i = 255; i >= 1; i--)
> +		feed_fgraph_exit(&ftrace, 0, i, NULL, out);
> +
> +	/* Pop root frame - must cleanly match root_func on stack, not popped prematurely */
> +	feed_fgraph_exit(&ftrace, 0, 0, "root_func", out);
> +
> +	/* Feed one more function entry - it must have base indentation (no indentation drift) */
> +	feed_fgraph_entry(&ftrace, 0, 0, "base_func", NULL, out);
> +
> +	fclose(out);
> +	ftrace_cpu_states__clear();
> +
> +	/* Verify base_func starts at standard 2 spaces indentation without drift */
> +	if (!strstr(out_buf, "|  base_func() {")) {
> +		pr_debug("FAILED %s:%d no indentation drift after stack saturation\n",
> +			 __FILE__, __LINE__);
> +		free(out_buf);
> +		return TEST_FAIL;
> +	}
> +
> +	free(out_buf);
> +	out_buf = NULL;
> +
> +	/* Test overflow recovery when events are dropped */
> +	out = open_memstream(&out_buf, &out_len);
> +	if (!out)
> +		return TEST_FAIL;
> +
> +	feed_fgraph_entry(&ftrace, 0, 0, "root_func", NULL, out);
> +	for (i = 1; i < 256; i++)
> +		feed_fgraph_entry(&ftrace, 0, i, "sub_func", NULL, out);
> +	for (i = 0; i < 44; i++)
> +		feed_fgraph_entry(&ftrace, 0, 256 + i, "overflow_func", NULL, out);
> +
> +	/* Dropped events: root_func directly calls recovery_func */
> +	feed_fgraph_entry(&ftrace, 0, 1, "recovery_func", "root_func+0x20", out);
> +	feed_fgraph_exit(&ftrace, 0, 1, NULL, out);
> +	feed_fgraph_exit(&ftrace, 0, 0, "root_func", out);
> +
> +	fclose(out);
> +	ftrace_cpu_states__clear();
> +
> +	if (!strstr(out_buf, "recovery_func() {")) {
> +		pr_debug("FAILED %s:%d recovery_func missing after overflow recovery\n",
> +			 __FILE__, __LINE__);
> +		free(out_buf);
> +		return TEST_FAIL;
> +	}
> +	if (!strstr(out_buf, "} /* root_func */")) {
> +		pr_debug("FAILED %s:%d root_func exit missing after overflow recovery\n",
> +			 __FILE__, __LINE__);
> +		free(out_buf);
> +		return TEST_FAIL;
> +	}
> +
> +	free(out_buf);
> +	out_buf = NULL;
> +
> +	/* Test that bare braces during overflow do not prematurely pop tracked frames */
> +	out = open_memstream(&out_buf, &out_len);
> +	if (!out)
> +		return TEST_FAIL;
> +
> +	feed_fgraph_entry(&ftrace, 0, 0, "root_func", NULL, out);
> +	for (i = 1; i < 256; i++)
> +		feed_fgraph_entry(&ftrace, 0, i, "sub_func", NULL, out);
> +	for (i = 0; i < 10; i++)
> +		feed_fgraph_entry(&ftrace, 0, 256 + i, "overflow_func", NULL, out);
> +
> +	/* Pop 10 overflow frames with bare braces */
> +	for (i = 9; i >= 0; i--)
> +		feed_fgraph_exit(&ftrace, 0, 256 + i, NULL, out);
> +
> +	/* Pop 255 sub_func frames with bare braces */
> +	for (i = 255; i >= 1; i--)
> +		feed_fgraph_exit(&ftrace, 0, i, NULL, out);
> +
> +	/* Root frame must still be on the stack to match caller */
> +	feed_fgraph_entry(&ftrace, 0, 1, "child_func", "root_func+0x10", out);
> +	feed_fgraph_exit(&ftrace, 0, 1, NULL, out);
> +	feed_fgraph_exit(&ftrace, 0, 0, "root_func", out);
> +
> +	fclose(out);
> +	ftrace_cpu_states__clear();
> +
> +	if (!strstr(out_buf, "child_func() {")) {
> +		pr_debug("FAILED %s:%d child_func missing after bare braces in overflow\n",
> +			 __FILE__, __LINE__);
> +		free(out_buf);
> +		return TEST_FAIL;
> +	}
> +	if (!strstr(out_buf, "} /* root_func */")) {
> +		pr_debug("FAILED %s:%d root_func exit missing after bare braces in overflow\n",
> +			 __FILE__, __LINE__);
> +		free(out_buf);
> +		return TEST_FAIL;
> +	}
> +
> +	free(out_buf);
> +	out_buf = NULL;
> +
> +	/* Test recursive caller lookup skips stale inner invocation */
> +	out = open_memstream(&out_buf, &out_len);
> +	if (!out)
> +		return TEST_FAIL;
> +
> +	/* Outer recursive invocation at indent 2 */
> +	ftrace_process_fgraph_line(&ftrace, " 0)               |  rec_func() {", out);
> +	/* Inner recursive invocation at indent 4 */
> +	ftrace_process_fgraph_line(&ftrace,
> +				   " 0)               |    rec_func() { /* <-rec_func+0x10 */",
> +				   out);
> +	/* Inner invocation exit is dropped by ring buffer */
> +	/* Outer invocation calls sibling_func at indent 4 */
> +	ftrace_process_fgraph_line(&ftrace,
> +				   " 0)   1.000 us    |    sibling_func(); /* <-rec_func+0x20 */",
> +				   out);
> +	ftrace_process_fgraph_line(&ftrace, " 0)   2.000 us    |  } /* rec_func */", out);
> +
> +	fclose(out);
> +	ftrace_cpu_states__clear();
> +
> +	if (!strstr(out_buf, "sibling_func();")) {
> +		pr_debug("FAILED %s:%d sibling_func missing under recursive caller\n",
> +			 __FILE__, __LINE__);
> +		free(out_buf);
> +		return TEST_FAIL;
> +	}
> +	if (!strstr(out_buf, "} /* rec_func */")) {
> +		pr_debug("FAILED %s:%d rec_func exit missing after dropped inner exit\n",
> +			 __FILE__, __LINE__);
> +		free(out_buf);
> +		return TEST_FAIL;
> +	}
> +	free(out_buf);
> +	out_buf = NULL;
> +
> +	/* Test top inlined frame when cs->overflow_depth > 0 does not misclassify exit */
> +	vmlinux = vmlinux_path__find();
> +	if (vmlinux) {
> +		const char *saved_vmlinux = symbol_conf.vmlinux_name;
> +		bool saved_ignore_buildid = symbol_conf.ignore_vmlinux_buildid;
> +		const char *inlined_names[FTRACE_MAX_INLINES];
> +		int num_inlines;
> +		int j;
> +
> +		symbol_conf.vmlinux_name = vmlinux;
> +		symbol_conf.ignore_vmlinux_buildid = true;
> +		if (perf_ftrace__setup_inlines(&ftrace) == 0 && ftrace.machine) {
> +			num_inlines = ftrace_resolve_inlines(ftrace.machine,
> +							     "wake_up_new_task", 0x1d1,
> +							     inlined_names,
> +							     FTRACE_MAX_INLINES);
> +			if (num_inlines > 0 && !strcmp(inlined_names[0], "activate_task")) {
> +				out = open_memstream(&out_buf, &out_len);
> +				if (!out) {
> +					for (j = 0; j < num_inlines; j++)
> +						free((void *)inlined_names[j]);
> +					perf_ftrace__cleanup_inlines(&ftrace);
> +					symbol_conf.vmlinux_name = saved_vmlinux;
> +					symbol_conf.ignore_vmlinux_buildid = saved_ignore_buildid;
> +					return TEST_FAIL;
> +				}
> +
> +				/* Fill stack up to 254 with tracked frames */
> +				feed_fgraph_entry(&ftrace, 0, 0, "root_func", NULL, out);
> +				for (i = 1; i < 254; i++)
> +					feed_fgraph_entry(&ftrace, 0, i, "sub_func", NULL, out);
> +
> +				/* Frame 254 is wake_up_new_task */
> +				feed_fgraph_entry(&ftrace, 0, 254, "wake_up_new_task", NULL, out);
> +
> +				/*
> +				 * Frame 255: enqueue_task resolves inline activate_task.
> +				 * Inlined frame activate_task is pushed at stack[255]
> +				 * (cs->depth = 256). Real frame enqueue_task overflows
> +				 * into cs->overflow_depth = 1.
> +				 */
> +				feed_fgraph_entry(&ftrace, 0, 255, "enqueue_task",
> +						  "wake_up_new_task+0x1d1/0x3e0", out);
> +
> +				/*
> +				 * Nested child call inside overflow: does NOT pop the
> +				 * inlined frame!
> +				 */
> +				feed_fgraph_entry(&ftrace, 0, 256, "child_overflow",
> +						  "enqueue_task+0x10", out);
> +
> +				/* Exit child_overflow (overflow_depth decrements to 1) */
> +				feed_fgraph_exit(&ftrace, 0, 256, NULL, out);
> +
> +				/* Exit enqueue_task (overflow_depth decrements to 0) */
> +				feed_fgraph_exit(&ftrace, 0, 255, NULL, out);
> +
> +				/* Exit wake_up_new_task: synthesises inline exit */
> +				feed_fgraph_exit(&ftrace, 0, 254, NULL, out);
> +
> +				/* Pop remaining sub_func frames and root_func */
> +				for (i = 253; i >= 1; i--)
> +					feed_fgraph_exit(&ftrace, 0, i, NULL, out);
> +				feed_fgraph_exit(&ftrace, 0, 0, "root_func", out);
> +
> +				/* Feed base frame to check for indentation drift */
> +				feed_fgraph_entry(&ftrace, 0, 0, "drift_check", NULL, out);
> +
> +				fclose(out);
> +				ftrace_cpu_states__clear();
> +
> +				if (!strstr(out_buf, "activate_task() { /* (inline) */") ||
> +				    !strstr(out_buf, "} /* activate_task (inline) */") ||
> +				    !strstr(out_buf, "|  drift_check() {")) {
> +					pr_debug("FAILED %s:%d top inlined frame saturation failed\n",
> +						 __FILE__, __LINE__);
> +					free(out_buf);
> +					for (j = 0; j < num_inlines; j++)
> +						free((void *)inlined_names[j]);
> +					perf_ftrace__cleanup_inlines(&ftrace);
> +					symbol_conf.vmlinux_name = saved_vmlinux;
> +					symbol_conf.ignore_vmlinux_buildid = saved_ignore_buildid;
> +					return TEST_FAIL;
> +				}
> +
> +				free(out_buf);
> +				out_buf = NULL;
> +			}
> +			for (j = 0; j < num_inlines; j++)
> +				free((void *)inlined_names[j]);
> +			perf_ftrace__cleanup_inlines(&ftrace);
> +		}
> +		symbol_conf.vmlinux_name = saved_vmlinux;
> +		symbol_conf.ignore_vmlinux_buildid = saved_ignore_buildid;
> +	}
> +
> +	free(out_buf);
> +	return TEST_OK;
> +}
> +
> +static int test_column_layouts(void)
> +{
> +	static const struct {
> +		const char *desc;
> +				bool verbose;
> +		const char *in;
> +		const char *expected;
> +	} cases[] = {
> +		{
> +			"default layout", false,
> +			" 7)               |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
> +			" 7)               |  wake_up_new_task() {\n",
> +		},
> +		{
> +			"verbose layout", true,
> +			" 1234.567890 |   7)   bash-1234    |  ....   |               |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
> +			" 1234.567890 |   7)   bash-1234    |  ....   |               |  wake_up_new_task() {\n",
> +		},
> +	};
> +	struct perf_ftrace ftrace;
> +	char *out_buf = NULL;
> +	size_t out_len = 0;
> +	FILE *out;
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cases); i++) {
> +		memset(&ftrace, 0, sizeof(ftrace));
> +		ftrace.use_inline = true;
> +		ftrace.filter_retaddr = true;
> +				ftrace.graph_verbose = cases[i].verbose;
> +
> +		out = open_memstream(&out_buf, &out_len);
> +		if (!out)
> +			return TEST_FAIL;
> +
> +		ftrace_process_fgraph_line(&ftrace, cases[i].in, out);
> +		fclose(out);
> +		ftrace_cpu_states__clear();
> +
> +		if (strcmp(out_buf, cases[i].expected)) {
> +			pr_debug("%s: expected '%s', got '%s'\n",
> +				 cases[i].desc, cases[i].expected, out_buf);
> +			free(out_buf);
> +			return TEST_FAIL;
> +		}
> +		free(out_buf);
> +		out_buf = NULL;
> +	}
> +
> +	return TEST_OK;
> +}
> +
> +static int test_context_switch_handling(void)
> +{
> +	struct perf_ftrace ftrace;
> +	struct perf_thread_map *threads;
> +	char *out_buf = NULL;
> +	size_t out_len = 0;
> +	FILE *out;
> +	int i;
> +
> +	memset(&ftrace, 0, sizeof(ftrace));
> +	ftrace.use_inline = true;
> +	ftrace_cpu_states__clear();
> +
> +	out = open_memstream(&out_buf, &out_len);
> +	if (!out)
> +		return TEST_FAIL;
> +
> +	/*
> +	 * Initial Task 1 (PID 100) starts running on CPU 0 before any banner
> +	 * has been emitted on that CPU (default kernel ftrace behaviour).
> +	 */
> +	ftrace_process_fgraph_line(&ftrace, " 0)               |  func1() {", out);
> +
> +	/* First context switch on CPU 0: Task 1 switches to <idle>-0 */
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +	ftrace_process_fgraph_line(&ftrace, " 0)    task1-100   =>    <idle>-0 ", out);
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +
> +	/* Idle task executes on CPU 0 - should NOT inherit func1's stack */
> +	ftrace_process_fgraph_line(&ftrace, " 0)               |  default_idle() {", out);
> +	ftrace_process_fgraph_line(&ftrace, " 0)               |  } /* default_idle */", out);
> +
> +	/* Context switch to Task 2 (PID 200) on CPU 0 */
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +	ftrace_process_fgraph_line(&ftrace, " 0)    <idle>-0    =>    task2-200 ", out);
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +
> +	/* Task 2 executes func2 - should NOT inherit func1's indentation */
> +	ftrace_process_fgraph_line(&ftrace, " 0)               |  func2() {", out);
> +	ftrace_process_fgraph_line(&ftrace, " 0)               |  } /* func2 */", out);
> +
> +	/* Task 1 migrates and resumes on CPU 1 */
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +	ftrace_process_fgraph_line(&ftrace, " 1)    <idle>-0    =>    task1-100 ", out);
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +
> +	/* Task 1 exits func1 on CPU 1 - should cleanly match func1 from its preserved stack */
> +	ftrace_process_fgraph_line(&ftrace, " 1)               |  } /* func1 */", out);
> +
> +	/*
> +	 * Test delayed context switch banner migration where a task state
> +	 * allocated on CPU 3 is rekeyed from CPU 2.
> +	 */
> +	ftrace_process_fgraph_line(&ftrace, " 2)               |  func3() {", out);
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +	ftrace_process_fgraph_line(&ftrace, " 3)    <idle>-0    =>    task3-300 ", out);
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +	ftrace_process_fgraph_line(&ftrace, " 2)    task3-300   =>    <idle>-0 ", out);
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +	ftrace_process_fgraph_line(&ftrace, " 3)               |    func4() {", out);
> +	ftrace_process_fgraph_line(&ftrace, " 3)               |    } /* func4 */", out);
> +	ftrace_process_fgraph_line(&ftrace, " 3)               |  } /* func3 */", out);
> +
> +	/*
> +	 * Test delayed context switch banner migration where CPU 3 enters func6()
> +	 * BEFORE CPU 2 emits its delayed context switch banner. ts from CPU 2
> +	 * must be merged underneath existing on CPU 3.
> +	 */
> +	ftrace_process_fgraph_line(&ftrace, " 2)               |  func5() {", out);
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +	ftrace_process_fgraph_line(&ftrace, " 3)    <idle>-0    =>    task4-400 ", out);
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +	ftrace_process_fgraph_line(&ftrace, " 3)               |    func6() {", out);
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +	ftrace_process_fgraph_line(&ftrace, " 2)    task4-400   =>    <idle>-0 ", out);
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +	ftrace_process_fgraph_line(&ftrace, " 3)               |    } /* func6 */", out);
> +	ftrace_process_fgraph_line(&ftrace, " 3)               |  } /* func5 */", out);
> +
> +	/*
> +	 * Test single-task profiling across CPU migration where context switch
> +	 * banners are suppressed by the kernel (verif_pid prev_pid == -1).
> +	 */
> +	ftrace.evlist = evlist__new();
> +	if (ftrace.evlist) {
> +		threads = thread_map__new_by_tid(500);
> +		perf_evlist__set_maps(evlist__core(ftrace.evlist), NULL, threads);
> +		perf_thread_map__put(threads);
> +	}
> +
> +	ftrace_cpu_states__clear();
> +	ftrace_process_fgraph_line(&ftrace, " 0)               |  func_a() {", out);
> +	ftrace_process_fgraph_line(&ftrace, " 1)               |    func_b() {", out);
> +	ftrace_process_fgraph_line(&ftrace, " 1)               |    } /* func_b */", out);
> +	ftrace_process_fgraph_line(&ftrace, " 0)               |  } /* func_a */", out);
> +
> +	evlist__put(ftrace.evlist);
> +	ftrace.evlist = NULL;
> +
> +	fclose(out);
> +	ftrace_cpu_states__clear();
> +
> +	/* Verify default_idle in Idle task started at base indentation */
> +	TEST_ASSERT_VAL("idle task does not inherit initial task call stack",
> +			strstr(out_buf, "|  default_idle() {") != NULL);
> +
> +	/* Verify func2 in Task 2 started at base indentation "|  func2() {" */
> +	TEST_ASSERT_VAL("task2 does not inherit task1 call stack",
> +			strstr(out_buf, "|  func2() {") != NULL);
> +
> +	/* Verify task1 exit on CPU 1 matches cleanly */
> +	TEST_ASSERT_VAL("task1 preserved stack across migration",
> +			strstr(out_buf, "1)               |  } /* func1 */") != NULL);
> +
> +	/* Verify task3 preserved stack across delayed context switch banner */
> +	TEST_ASSERT_VAL("task3 preserved stack across delayed banner",
> +			strstr(out_buf, "3)               |  } /* func3 */") != NULL);
> +
> +	/* Verify task4 merged outer stack when entered before delayed banner */
> +	TEST_ASSERT_VAL("task4 merged outer stack when entered before delayed banner",
> +			strstr(out_buf, "3)               |  } /* func5 */") != NULL);
> +
> +	/* Verify single-task stack tracked across CPUs without banners */
> +	TEST_ASSERT_VAL("single-task stack tracked across CPUs without banners",
> +			strstr(out_buf, "0)               |  } /* func_a */") != NULL);
> +
> +	/*
> +	 * Test migration where merged stack depth exceeds FTRACE_MAX_STACK
> +	 * does not cause indentation drift or corruption.
> +	 * CPU 2 starts without a context switch banner, accumulating under
> +	 * FTRACE_UNKNOWN_PID(2).
> +	 */
> +	free(out_buf);
> +	out_buf = NULL;
> +	out = open_memstream(&out_buf, &out_len);
> +	if (!out)
> +		return TEST_FAIL;
> +
> +	for (i = 0; i < 200; i++)
> +		feed_fgraph_entry(&ftrace, 2, i, "deep_func", NULL, out);
> +
> +	/* Migrate to CPU 3, enter more frames */
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +	ftrace_process_fgraph_line(&ftrace, " 3)    <idle>-0    =>    task5-500 ", out);
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +	for (i = 0; i < 100; i++)
> +		feed_fgraph_entry(&ftrace, 3, 200 + i, "more_func", NULL, out);
> +
> +	/* Delayed context switch banner from CPU 2 rekeys and merges stacks (> 256) */
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +	ftrace_process_fgraph_line(&ftrace, " 2)    task5-500   =>    <idle>-0 ", out);
> +	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
> +
> +	/* Unwind all frames on CPU 3 (44 in overflow_depth + 256 on stack = 300) */
> +	for (i = 299; i >= 0; i--)
> +		feed_fgraph_exit(&ftrace, 3, i, NULL, out);
> +	feed_fgraph_entry(&ftrace, 3, 0, "after_merge", NULL, out);
> +
> +	fclose(out);
> +	ftrace_cpu_states__clear();
> +
> +	TEST_ASSERT_VAL("no indentation drift after saturated stack rekey",
> +			strstr(out_buf, "|  after_merge() {") != NULL);
> +
> +	free(out_buf);
> +	return TEST_OK;
> +}
> +
>  static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
>  	int ret;
> @@ -75,7 +971,23 @@ static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __ma
>  	if (ret != TEST_OK)
>  		return ret;
>  
> +	ret = test_stack_saturation();
> +	if (ret != TEST_OK)
> +		return ret;
> +
> +	ret = test_context_switch_handling();
> +	if (ret != TEST_OK)
> +		return ret;
> +
> +	ret = test_column_layouts();
> +	if (ret != TEST_OK)
> +		return ret;
> +
> +	ret = test_inline_processing();
> +	if (ret != TEST_OK)
> +		return ret;
> +
>  	return TEST_OK;
>  }
>  
> -DEFINE_SUITE("Ftrace return address processing", ftrace);
> +DEFINE_SUITE("Ftrace inline processing", ftrace);
> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index 452231c01568..c3da2d1f44f4 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c
> @@ -1,12 +1,346 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/compiler.h>
> -#include <linux/kernel.h>
> -#include <linux/string.h>
> +/*
> + * ftrace.c - Ftrace utilities and inlined function processing
> + *
> + * Copyright (C) 2026 Aaron Tomlin <atomlin@atomlin.com>
> + */
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <errno.h>
>  #include <string.h>
>  #include <ctype.h>
> +#include <stdbool.h>
> +#include <linux/kernel.h>
> +#include <linux/zalloc.h>
> +#include <linux/hash.h>
> +#include <linux/list.h>
> +#include <linux/string.h>
> +#include "debug.h"
> +#include "dso.h"
> +#include "evlist.h"
> +#include "machine.h"
> +#include "map.h"
> +#include "srcline.h"
> +#include "symbol.h"
>  #include "util/ftrace.h"
> +#include <perf/threadmap.h>
> +
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
> +};
> +
> +struct ftrace_task_state {
> +	struct hlist_node	node;
> +	pid_t			pid;
> +	struct ftrace_stack_frame stack[FTRACE_MAX_STACK];
> +	int			depth;
> +	int			inlined_depth;
> +	int			overflow_depth;
> +};
> +
> +#define ftrace_cpu_state ftrace_task_state
> +
> +static struct hlist_head ftrace_task_hash[FTRACE_PID_HASH_SIZE];
> +static struct ftrace_task_state *ftrace_cpu_tasks[FTRACE_MAX_CPUS];
> +
> +/**
> + * ftrace_cpu_states__clear - Free allocated CPU and task stack states
> + *
> + * Free all memory associated with the per-task stack tracking states
> + * used for inlined function resolution, including the strings
> + * allocated for stack frames.
> + */
> +void ftrace_cpu_states__clear(void)
> +{
> +	struct ftrace_task_state *ts;
> +	struct hlist_node *tmp;
> +	int i, j;
> +
> +	for (i = 0; i < FTRACE_PID_HASH_SIZE; i++) {
> +		hlist_for_each_entry_safe(ts, tmp, &ftrace_task_hash[i], node) {
> +			for (j = 0; j < ts->depth; j++)
> +				free(ts->stack[j].name);
> +			hlist_del_init(&ts->node);
> +			free(ts);
> +		}
> +	}
> +
> +	memset(ftrace_cpu_tasks, 0, sizeof(ftrace_cpu_tasks));
> +}
> +
> +/**
> + * find_task_state - Look up call stack state for a task by PID
> + * @pid: Process ID of the task
> + *
> + * Return: A pointer to the task's stack state, or NULL if not found.
> + */
> +static struct ftrace_task_state *find_task_state(pid_t pid)
> +{
> +	struct ftrace_task_state *ts;
> +	struct hlist_head *head;
> +	u32 key = hash_32((u32)pid, FTRACE_PID_HASH_BITS);
> +
> +	head = &ftrace_task_hash[key];
> +	hlist_for_each_entry(ts, head, node) {
> +		if (ts->pid == pid)
> +			return ts;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * get_task_state - Get or allocate stack state for a given task PID
> + * @pid: Process ID of the task
> + *
> + * Return: A pointer to the task's stack state, or NULL on allocation failure.
> + */
> +static struct ftrace_task_state *get_task_state(pid_t pid)
> +{
> +	struct ftrace_task_state *ts = find_task_state(pid);
> +	struct hlist_head *head;
> +	u32 key;
> +
> +	if (ts)
> +		return ts;
> +
> +	ts = zalloc(sizeof(*ts));
> +	if (!ts)
> +		return NULL;
> +
> +	ts->pid = pid;
> +	key = hash_32((u32)pid, FTRACE_PID_HASH_BITS);
> +	head = &ftrace_task_hash[key];
> +	hlist_add_head(&ts->node, head);
> +	return ts;
> +}
> +
> +/**
> + * ftrace_task_state__rekey - Reassign a task state to a new PID
> + * @ts: The task state to re-key
> + * @new_pid: The new process ID to associate with the state
> + *
> + * Rehash @ts under @new_pid. If a task state for @new_pid already exists,
> + * merge or replace it and update active CPU references accordingly.
> + *
> + * Return: A pointer to the active task state associated with @new_pid.
> + */
> +static struct ftrace_task_state *ftrace_task_state__rekey(struct ftrace_task_state *ts,
> +							  pid_t new_pid)
> +{
> +	struct ftrace_task_state *existing;
> +	u32 key;
> +	int keep_existing;
> +	int j, c;
> +
> +	if (ts->pid == new_pid)
> +		return ts;
> +
> +	hlist_del_init(&ts->node);
> +
> +	existing = find_task_state(new_pid);
> +	if (existing) {
> +		if (existing->depth == 0) {
> +			for (c = 0; c < FTRACE_MAX_CPUS; c++) {
> +				if (ftrace_cpu_tasks[c] == existing)
> +					ftrace_cpu_tasks[c] = ts;
> +			}
> +			hlist_del_init(&existing->node);
> +			free(existing);
> +		} else {
> +			for (c = 0; c < FTRACE_MAX_CPUS; c++) {
> +				if (ftrace_cpu_tasks[c] == ts)
> +					ftrace_cpu_tasks[c] = existing;
> +			}
> +
> +			if (ts->depth >= FTRACE_MAX_STACK) {
> +				for (j = 0; j < existing->depth; j++) {
> +					if (!existing->stack[j].inlined)
> +						existing->overflow_depth++;
> +					free(existing->stack[j].name);
> +				}
> +				existing->inlined_depth = 0;
> +				for (j = 0; j < FTRACE_MAX_STACK; j++) {
> +					if (ts->stack[j].inlined)
> +						existing->inlined_depth++;
> +				}
> +				memcpy(&existing->stack[0], &ts->stack[0],
> +				       FTRACE_MAX_STACK * sizeof(existing->stack[0]));
> +				existing->depth = FTRACE_MAX_STACK;
> +				existing->overflow_depth += ts->overflow_depth;
> +			} else if (existing->depth + ts->depth > FTRACE_MAX_STACK) {
> +				keep_existing = FTRACE_MAX_STACK - ts->depth;
> +
> +				for (j = keep_existing; j < existing->depth; j++) {
> +					if (!existing->stack[j].inlined)
> +						existing->overflow_depth++;
> +					else
> +						existing->inlined_depth--;
> +					free(existing->stack[j].name);
> +				}
> +				memmove(&existing->stack[ts->depth], &existing->stack[0],
> +					keep_existing * sizeof(existing->stack[0]));
> +				memcpy(&existing->stack[0], &ts->stack[0],
> +				       ts->depth * sizeof(existing->stack[0]));
> +				existing->depth = FTRACE_MAX_STACK;
> +				existing->inlined_depth += ts->inlined_depth;
> +				existing->overflow_depth += ts->overflow_depth;
> +			} else {
> +				memmove(&existing->stack[ts->depth], &existing->stack[0],
> +					existing->depth * sizeof(existing->stack[0]));
> +				memcpy(&existing->stack[0], &ts->stack[0],
> +				       ts->depth * sizeof(existing->stack[0]));
> +				existing->depth += ts->depth;
> +				existing->inlined_depth += ts->inlined_depth;
> +				existing->overflow_depth += ts->overflow_depth;
> +			}
> +
> +			free(ts);
> +			return existing;
> +		}
> +	}
> +
> +	ts->pid = new_pid;
> +	key = hash_32((u32)new_pid, FTRACE_PID_HASH_BITS);
> +	hlist_add_head(&ts->node, &ftrace_task_hash[key]);
> +	return ts;
> +}
> +
> +static pid_t ftrace__get_single_pid(struct perf_ftrace *ftrace)
> +{
> +	struct perf_thread_map *threads;
> +	pid_t pid;
> +
> +	if (!ftrace || !ftrace->evlist || ftrace->inherit)
> +		return -1;
> +
> +	threads = evlist__core(ftrace->evlist)->threads;
> +	if (!threads || perf_thread_map__nr(threads) != 1)
> +		return -1;
> +
> +	pid = perf_thread_map__pid(threads, 0);
> +	return (pid > 0) ? pid : -1;
> +}
> +
> +/**
> + * get_cpu_state - Get or allocate active task stack state for a given CPU
> + * @ftrace: Perf ftrace context
> + * @cpu: The CPU number
> + *
> + * Return: A pointer to the CPU's active task stack state, or NULL on error or
> + * out-of-bounds CPU index.
> + */
> +static struct ftrace_task_state *get_cpu_state(struct perf_ftrace *ftrace, int cpu)
> +{
> +	pid_t single_pid;
> +
> +	if (cpu < 0 || cpu >= FTRACE_MAX_CPUS)
> +		return NULL;
> +
> +	if (!ftrace_cpu_tasks[cpu]) {
> +		single_pid = ftrace__get_single_pid(ftrace);
> +		if (single_pid > 0)
> +			ftrace_cpu_tasks[cpu] = get_task_state(single_pid);
> +		else
> +			ftrace_cpu_tasks[cpu] = get_task_state(FTRACE_UNKNOWN_PID(cpu));
> +	}
> +
> +	return ftrace_cpu_tasks[cpu];
> +}
> +
> +/**
> + * parse_context_switch - Parse context switch banner and update CPU's task
> + * @line: The trace line containing the banner
> + *
> + * Check if @line is a context switch banner (e.g. " 0) <idle>-0 => migrati-19").
> + * If so, extract the CPU number and both the outgoing and incoming task PIDs,
> + * re-key any initial unknown task state on this CPU to the outgoing PID, and
> + * update the active task mapping for that CPU to the incoming PID.
> + *
> + * Return: true if @line was a context switch banner, false otherwise.
> + */
> +static bool parse_context_switch(const char *line)
> +{
> +	const char *arrow = strstr(line, " => ");
> +	const char *p;
> +	const char *next;
> +	const char *hyphen;
> +	const char *h;
> +	char *endptr;
> +	char *end_pid;
> +	long cpu_val;
> +	long prev_pid;
> +	long next_pid;
> +	pid_t real_prev;
> +	pid_t real_next;
> +
> +	if (!arrow)
> +		return false;
> +
> +	/* Find CPU number before ')' */
> +	p = skip_spaces(line);
> +	cpu_val = strtol(p, &endptr, 10);
> +	if (endptr == p || *endptr != ')')
> +		return false;
> +
> +	if (cpu_val < 0 || cpu_val >= FTRACE_MAX_CPUS)
> +		return false;
> +
> +	/*
> +	 * Parse outgoing task PID before " => " (" CPU) comm-pid => ...").
> +	 * Scan backwards from arrow to find the hyphen before the numeric PID.
> +	 */
> +	h = arrow - 1;
> +	while (h > endptr && *h == ' ')
> +		h--;
> +	while (h > endptr && *h != '-')
> +		h--;
> +	if (h <= endptr || *h != '-')
> +		return false;
> +
> +	prev_pid = strtol(h + 1, &end_pid, 10);
> +	if (end_pid == h + 1)
> +		return false;
> +
> +	/* Parse target task PID after " => " (" => comm-pid") */
> +	next = skip_spaces(arrow + 4);
> +	hyphen = strrchr(next, '-');
> +	if (!hyphen)
> +		return false;
> +
> +	next_pid = strtol(hyphen + 1, &end_pid, 10);
> +	if (end_pid == hyphen + 1)
> +		return false;
> +
> +	real_prev = (prev_pid == 0) ? FTRACE_IDLE_PID(cpu_val) : (pid_t)prev_pid;
> +	real_next = (next_pid == 0) ? FTRACE_IDLE_PID(cpu_val) : (pid_t)next_pid;
> +
> +	/*
> +	 * If no context switch was seen previously on this CPU, its initial
> +	 * pre-banner trace records were accumulated under an unknown synthetic
> +	 * PID. Re-key that state to real_prev so the initial task's stack and
> +	 * inlined frames are preserved when it schedules back in.
> +	 */
> +	if (ftrace_cpu_tasks[cpu_val] &&
> +	    ftrace_cpu_tasks[cpu_val]->pid == FTRACE_UNKNOWN_PID(cpu_val)) {
> +		ftrace_cpu_tasks[cpu_val] =
> +			ftrace_task_state__rekey(ftrace_cpu_tasks[cpu_val], real_prev);
> +	}
> +
> +	ftrace_cpu_tasks[cpu_val] = get_task_state(real_next);
> +	return true;
> +}
>  
>  /**
>   * ftrace_parse_retaddr - Parse return address comment from trace line
> @@ -91,3 +425,722 @@ void ftrace_filter_retaddr(char *str)
>  
>  	memmove(start, end, strlen(end) + 1);
>  }
> +
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
> +				char *name = strdup(ilist->symbol->name);
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
> +
> +/**
> + * extract_entry_func_name - Extract the function name from an entry record
> + * @str: The trace line's function column string
> + * @buf: Buffer to store the extracted name
> + * @size: Size of the @buf
> + *
> + * Parse the function name out of an entry trace record by stripping away
> + * parentheses or braces.
> + */
> +static void extract_entry_func_name(const char *str, char *buf, size_t size)
> +{
> +	size_t i = 0;
> +
> +	while (*str && *str != '(' && *str != '{' && !isspace(*str) && i < size - 1)
> +		buf[i++] = *str++;
> +	buf[i] = '\0';
> +}
> +
> +/**
> + * extract_exit_func_name - Extract the function name from an exit record
> + * @str: The trace line's function column string
> + * @buf: Buffer to store the extracted name
> + * @size: Size of the @buf
> + *
> + * Parse the original function name out of the trailing comment in an
> + * exit trace record.
> + */
> +static void extract_exit_func_name(const char *str, char *buf, size_t size)
> +{
> +	const char *p = strchr(str, '}');
> +	size_t i = 0;
> +
> +	buf[0] = '\0';
> +	if (!p)
> +		return;
> +
> +	p = strstr(p, "/*");
> +	if (!p)
> +		return;
> +
> +	p = skip_spaces(p + 2);
> +	while (*p && !isspace(*p) && *p != '*' && *p != '/' && i < size - 1)
> +		buf[i++] = *p++;
> +	buf[i] = '\0';
> +}
> +
> +/**
> + * make_blank_prefix - Create a blank prefix mirroring a trace record's context
> + * @ftrace: Perf ftrace context
> + * @line: The original trace record
> + * @pipe_char: Pointer to the final delimiter character of the context columns
> + * @buf: Buffer to store the blank prefix
> + * @size: Size of the @buf
> + *
> + * Generate a prefix matching the context columns of @line (e.g. CPU, duration)
> + * but with the duration field replaced by spaces.
> + */
> +static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line,
> +			      const char *pipe_char, char *buf, size_t size)
> +{
> +	size_t len = pipe_char - line + 1;
> +	const char *start_delim = NULL;
> +	char *c;
> +
> +	if (!size)
> +		return;
> +
> +	if (len >= size)
> +		len = size - 1;
> +
> +	memcpy(buf, line, len);
> +	buf[len] = '\0';
> +
> +	if (*pipe_char == '|') {
> +		if (ftrace->graph_verbose) {
> +			/* In verbose mode, duration starts after the comm-pid '|' */
> +			for (const char *p = pipe_char - 1; p >= line; p--) {
> +				if (*p == '|') {
> +					start_delim = p;
> +					break;
> +				}
> +			}
> +		} else {
> +			/* In default mode, duration starts after CPU ')' */
> +			start_delim = strchr(line, ')');
> +		}
> +
> +		if (start_delim && start_delim < pipe_char && start_delim < line + len) {
> +			char *end = buf + (pipe_char - line);
> +
> +			if (end > buf + len)
> +				end = buf + len;
> +			for (c = buf + (start_delim - line) + 1; c < end; c++)
> +				*c = ' ';
> +		}
> +	}
> +}
> +
> +/**
> + * find_func_column - Locate the function call column in a trace record
> + * @ftrace: Perf ftrace context
> + * @line: The trace record to parse
> + * @cpu: Pointer to store the CPU number
> + *
> + * Locate the context columns that precede the function call column of a
> + * function_graph trace record. Depending on the funcgraph-* options set
> + * up by perf, a record looks like:
> + *
> + *   [ abstime |]  CPU)  [ comm-pid |]  [ duration |]  func
> + *
> + * The abstime and comm-pid columns are only present with --graph-opts
> + * verbose.
> + *
> + * Return: A pointer to the last character of the context columns (the final
> + * '|' delimiter). Returns NULL if @line is not a trace record.
> + */
> +static const char *find_func_column(const struct perf_ftrace *ftrace,
> +				    const char *line, int *cpu)
> +{
> +	const char *p = line;
> +	char *endptr;
> +	long val;
> +
> +	if (ftrace->graph_verbose) {
> +		p = strchr(p, '|');
> +		if (!p)
> +			return NULL;
> +		p++;
> +	}
> +
> +	p = skip_spaces(p);
> +	val = strtol(p, &endptr, 10);
> +	if (endptr == p || *endptr != ')')
> +		return NULL;
> +	p = endptr;
> +
> +	if (ftrace->graph_verbose) {
> +		const char *proc_start = p;
> +
> +		p = strchr(p, '|');
> +		if (!p)
> +			return NULL;
> +
> +		if (val >= 0 && val < FTRACE_MAX_CPUS) {
> +			const char *h = p - 1;
> +
> +			while (h >= proc_start && *h != '-')
> +				h--;
> +			if (h >= proc_start && *h == '-') {
> +				long pid_val = strtol(h + 1, NULL, 10);
> +				pid_t task_pid = (pid_val == 0) ?
> +						 FTRACE_IDLE_PID(val) :
> +						 (pid_t)pid_val;
> +
> +				ftrace_cpu_tasks[(int)val] = get_task_state(task_pid);
> +			}
> +		}
> +
> +		/*
> +		 * In verbose mode, latency-format is also enabled by
> +		 * set_tracing_funcgraph_verbose(), emitting a "<lat-fmt> |"
> +		 * column after the comm-pid column.
> +		 */
> +		p = strchr(p + 1, '|');
> +		if (!p)
> +			return NULL;
> +	}
> +
> +	p = strchr(p + 1, '|');
> +	if (!p)
> +		return NULL;
> +
> +	*cpu = (int)val;
> +	return p;
> +}
> +
> +/**
> + * print_line - Output a trace line verbatim, filtering return addresses if needed
> + * @ftrace: Perf ftrace context
> + * @line: The trace line to output
> + * @out: File stream to output to
> + *
> + * Output @line to @out. If ftrace->filter_retaddr is set, return address
> + * comments are filtered out first.
> + *
> + * Return: 0 on success, or a negative error code (e.g. -ENOMEM) on failure.
> + */
> +static int print_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
> +{
> +	char *filtered;
> +
> +	if (!ftrace->filter_retaddr) {
> +		fprintf(out, "%s\n", line);
> +		return 0;
> +	}
> +
> +	filtered = strdup(line);
> +	if (!filtered) {
> +		pr_err("Not enough memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	ftrace_filter_retaddr(filtered);
> +	fprintf(out, "%s\n", filtered);
> +	free(filtered);
> +	return 0;
> +}
> +
> +/**
> + * ftrace_process_fgraph_line - Process and output a function graph trace line
> + * @ftrace: Perf ftrace context
> + * @line: The trace line to process
> + * @out: File stream to output to
> + *
> + * Process a trace line from the function_graph tracer. If --inline is set,
> + * this function parses the return address comment, resolves it to its
> + * inlined callchain, and synthesises intermediate frames into the streamed
> + * call graph.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
> +{
> +	char caller_sym[128];
> +	char blank_prefix[128];
> +	const char *inlined_names[FTRACE_MAX_INLINES];
> +	const char *pipe_char;
> +	const char *after_pipe;
> +	const char *func_start;
> +	struct ftrace_cpu_state *cs;
> +	u64 caller_offset = 0;
> +	int num_inlines = 0;
> +	int cpu = -1;
> +	int leading_spaces;
> +	int extra_indent;
> +	int caller_idx;
> +	int active_inlines;
> +	int common;
> +	int match_idx;
> +	int top_raw_indent;
> +	int i, j;
> +	bool is_exit;
> +	bool has_open_brace;
> +	bool has_semicolon;
> +	bool has_retaddr = false;
> +
> +	if (!ftrace->use_inline)
> +		return print_line(ftrace, line, out);
> +
> +	pipe_char = find_func_column(ftrace, line, &cpu);
> +	if (!pipe_char) {
> +		parse_context_switch(line);
> +		return print_line(ftrace, line, out);
> +	}
> +
> +	cs = get_cpu_state(ftrace, cpu);
> +	if (!cs)
> +		return print_line(ftrace, line, out);
> +
> +	make_blank_prefix(ftrace, line, pipe_char, blank_prefix, sizeof(blank_prefix));
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
> +			if (!cs->stack[i].inlined) {
> +				top_raw_indent = cs->stack[i].raw_indent;
> +				break;
> +			}
> +		}
> +
> +		/*
> +		 * If currently overflowed beyond FTRACE_MAX_STACK, any exit whose
> +		 * indentation is deeper than the top tracked frame belongs to the
> +		 * overflow region.
> +		 */
> +		if (cs->overflow_depth > 0 &&
> +		    (top_raw_indent < 0 || leading_spaces > top_raw_indent)) {
> +			cs->overflow_depth--;
> +			extra_indent = cs->inlined_depth * 2;
> +			fprintf(out, "%.*s%*s%s\n",
> +				(int)(pipe_char - line + 1), line,
> +				leading_spaces + extra_indent, "", func_start);
> +			return 0;
> +		}
> +
> +		/* Find matching frame on stack */
> +		match_idx = -1;
> +		if (exit_name[0] != '\0') {
> +			for (i = cs->depth - 1; i >= 0; i--) {
> +				if (!cs->stack[i].inlined && cs->stack[i].name &&
> +				    strcmp(cs->stack[i].name, exit_name) == 0) {
> +					match_idx = i;
> +					break;
> +				}
> +			}
> +		}
> +
> +		/*
> +		 * If bare brace ('}'), match the topmost non-inlined frame
> +		 * with matching indentation.
> +		 */
> +		if (match_idx < 0 && exit_name[0] == '\0') {
> +			for (i = cs->depth - 1; i >= 0; i--) {
> +				if (!cs->stack[i].inlined &&
> +				    cs->stack[i].raw_indent == leading_spaces) {
> +					match_idx = i;
> +					break;
> +				}
> +			}
> +		}
> +
> +		if (match_idx >= 0) {
> +			cs->overflow_depth = 0;
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
> +				free(cs->stack[cs->depth - 1].name);
> +				cs->depth--;
> +			}
> +
> +			extra_indent = cs->inlined_depth * 2;
> +		} else {
> +			extra_indent = 0;
> +		}
> +
> +		fprintf(out, "%.*s%*s%s\n",
> +			(int)(pipe_char - line + 1), line,
> +			leading_spaces + extra_indent, "", func_start);
> +		return 0;
> +	}
> +
> +	/* It's an entry or a leaf call */
> +	has_open_brace = (strchr(func_start, '{') != NULL);
> +	has_semicolon = (strchr(func_start, ';') != NULL);
> +
> +	top_raw_indent = -1;
> +	for (i = cs->depth - 1; i >= 0; i--) {
> +		if (!cs->stack[i].inlined) {
> +			top_raw_indent = cs->stack[i].raw_indent;
> +			break;
> +		}
> +	}
> +
> +	if (cs->overflow_depth > 0 && top_raw_indent >= 0 &&
> +	    leading_spaces <= top_raw_indent)
> +		cs->overflow_depth = 0;
> +
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
> +
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
> +		if (cs->depth >= FTRACE_MAX_STACK)
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
> +		cs->depth++;
> +		cs->inlined_depth++;
> +	}
> +
> +	/* Print current line with updated indentation */
> +	extra_indent = cs->inlined_depth * 2;
> +
> +	if (ftrace->filter_retaddr) {
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
> +		}
> +	} else {
> +		fprintf(out, "%.*s%*s%s\n",
> +			(int)(pipe_char - line + 1), line,
> +			leading_spaces + extra_indent, "", func_start);
> +	}
> +
> +	/* If non-leaf entry, push onto stack */
> +	if (has_open_brace && !has_semicolon) {
> +		char entry_name[128];
> +
> +		extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
> +		if (cs->depth < FTRACE_MAX_STACK) {
> +			cs->stack[cs->depth].name = strdup(entry_name);
> +			if (!cs->stack[cs->depth].name) {
> +				pr_err("Not enough memory\n");
> +				for (i = 0; i < num_inlines; i++)
> +					free((void *)inlined_names[i]);
> +				return -ENOMEM;
> +			}
> +			cs->stack[cs->depth].inlined = false;
> +			cs->stack[cs->depth].indent = leading_spaces + extra_indent;
> +			cs->stack[cs->depth].raw_indent = leading_spaces;
> +			cs->depth++;
> +		} else {
> +			cs->overflow_depth++;
> +		}
> +	}
> +
> +	for (i = 0; i < num_inlines; i++)
> +		free((void *)inlined_names[i]);
> +	return 0;
> +}
> +
> +/**
> + * perf_ftrace__setup_inlines - Initialise symbol resolution for inlines
> + * @ftrace: Perf ftrace context
> + *
> + * Initialise symbol tracking and load the kernel image (vmlinux) for
> + * DWARF debug information parsing.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int perf_ftrace__setup_inlines(struct perf_ftrace *ftrace)
> +{
> +	struct map *kmap;
> +	struct ftrace_task_state *ts;
> +	pid_t single_pid;
> +	int c;
> +
> +	if (!ftrace->use_inline)
> +		return 0;
> +
> +	single_pid = ftrace__get_single_pid(ftrace);
> +	if (single_pid > 0) {
> +		ts = get_task_state(single_pid);
> +		if (ts) {
> +			for (c = 0; c < FTRACE_MAX_CPUS; c++)
> +				ftrace_cpu_tasks[c] = ts;
> +		}
> +	}
> +
> +	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
> +	symbol_conf.inline_name = true;
> +	if (symbol_conf.vmlinux_name)
> +		symbol_conf.ignore_vmlinux_buildid = true;
> +
> +	if (symbol__init(NULL) < 0) {
> +		pr_warning("Failed to initialize symbols for inlined functions\n");
> +		return -1;
> +	}
> +
> +	ftrace->machine = machine__new_host(NULL);
> +	if (!ftrace->machine) {
> +		pr_warning("Failed to create host machine for symbols\n");
> +		return -1;
> +	}
> +
> +	if (symbol_conf.vmlinux_name) {
> +		kmap = machine__kernel_map(ftrace->machine);
> +		if (!kmap ||
> +		    dso__load_vmlinux(map__dso(kmap), kmap,
> +				      symbol_conf.vmlinux_name, false) <= 0) {
> +			pr_warning("Failed to load kernel image '%s'\n", symbol_conf.vmlinux_name);
> +			goto out_delete_machine;
> +		}
> +	} else {
> +		if (machine__load_vmlinux_path(ftrace->machine) <= 0) {
> +			pr_warning("Failed to load vmlinux from search path\n");
> +			goto out_delete_machine;
> +		}
> +	}
> +
> +	return 0;
> +
> +out_delete_machine:
> +	machine__delete(ftrace->machine);
> +	ftrace->machine = NULL;
> +	return -1;
> +}
> +
> +/**
> + * perf_ftrace__cleanup_inlines - Clean up resources used for inline resolution
> + * @ftrace: Perf ftrace context
> + *
> + * Free the machine context and the CPU stack tracking states.
> + */
> +void perf_ftrace__cleanup_inlines(struct perf_ftrace *ftrace)
> +{
> +	if (ftrace->machine) {
> +		machine__delete(ftrace->machine);
> +		ftrace->machine = NULL;
> +	}
> +	ftrace_cpu_states__clear();
> +}
> diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
> index 50216d3fef64..4d8a56ce878c 100644
> --- a/tools/perf/util/ftrace.h
> +++ b/tools/perf/util/ftrace.h
> @@ -1,6 +1,7 @@
>  #ifndef __PERF_FTRACE_H__
>  #define __PERF_FTRACE_H__
>  
> +#include <stdio.h>
>  #include <linux/list.h>
>  
>  #include "target.h"
> @@ -41,6 +42,8 @@ struct perf_ftrace {
>  	int			graph_tail;
>  	bool			filter_retaddr;
>  	bool			filter_retaddr_set;
> +	bool			use_inline;
> +	struct machine		*machine;
>  };
>  
>  struct filter_entry {
> @@ -95,7 +98,18 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
>  
>  #endif  /* HAVE_BPF_SKEL */
>  
> +struct machine;
> +
> +#define FTRACE_MAX_INLINES 32
> +
>  bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
>  void ftrace_filter_retaddr(char *str);
> +int ftrace_resolve_inlines(struct machine *machine,
> +			   const char *sym_name, u64 offset,
> +			   const char **inlined_names, int max_inlines);
> +int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out);
> +void ftrace_cpu_states__clear(void);
> +int perf_ftrace__setup_inlines(struct perf_ftrace *ftrace);
> +void perf_ftrace__cleanup_inlines(struct perf_ftrace *ftrace);
>  
>  #endif  /* __PERF_FTRACE_H__ */
> -- 
> 2.55.0
> 
