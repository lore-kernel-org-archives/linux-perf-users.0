Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B6A38E126;
	Wed,  7 Oct 2026 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791415491; cv=none; b=ELAp2SkZIST8OBnOVvyIx2yY0nKIfOPpAJta5vE/XDFNuwmtL5PiOxVOdQjqbSp+C3yVAZxN2Km0D2UVCXOuHaYO6UgZNBnRDNxhL6eylH0V7LZ1d1Xu/n7WIRozvONuuUz1zUgsob2M0OyA3oxdzUam69iUqQA3iwCYndto1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791415491; c=relaxed/simple;
	bh=BmMvJ2rlz4kKLbhR/BSaoYnqq9DjjBjH6iA94RGwYjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MecjoUp7cbehKllIGAM/RzoEBBcXT+oBGsi1aO/ViwIT2RwXWA/8cplm23KqoAGcCV5FSPVw9rXjPrTRO3mjO+K/wCRnCoqirPiLogfxSymC+aDcpzbnoUsR5dF6eUwy4o5sksee7Fsv2QzpsGYL4I3Viq8eTSBSLvxVIyhAsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdIDp3Yq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdIDp3Yq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A821F000FF;
	Wed,  7 Oct 2026 23:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791415489;
	bh=ZGdYjXpDNWRI/i/RNZNFTXjtymnRcJfMdWCwA4vvxjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mdIDp3YqqrGVp4fhHyQE3WTCy3CLwWwzFbYAxxmTjNBf/8ibDYKdlmP7IY3kD7vcz
	 lbUZh0NHq6KUsTryhqNgwUnBE4A1RzxcX1u+4Xt6AHC8Dc+/JgvpHbAehEi/9dadKT
	 0H8elO7GtSOVylEFk6RBn2AIMii2fqtsmtji1d/1ccBJnRKQikqaj5Y8HQvqeWdADO
	 DrJ28DVkDXr6jGoqRRJoPUci3B4Dvh8kyjnneEhf0DW9GD3IehRj5BHT3YsVDI0v5+
	 +3m9OqPCqWv485Z43I2zQGXVDEpZWECkIKfvOxUqXmiLiG7jOzMSqilUlRH7icey+J
	 ArahEDJ3iIeCA==
Date: Wed, 7 Oct 2026 16:24:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v2 0/4] perf ftrace: Support inlined
 functions and display enhancements in function graph tracer
Message-ID: <asbUwDTKJ54HvNYi@google.com>
References: <20261006232756.65620-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006232756.65620-1-atomlin@atomlin.com>

Hello,

Interesting work!

On Tue, Oct 06, 2026 at 07:27:52PM -0400, Aaron Tomlin wrote:
> The Linux kernel's function graph tracer operates at the machine
> instruction level via compiler instrumentation
> (-fpatchable-function-entry), recording entry and return events for
> physical function calls. Consequently, functions inlined by the compiler
> are invisible in the resulting call-graph, as no discrete call or return
> instructions are emitted for them. While technically expected, this
> omission frequently obscures the logical execution flow when analysing
> kernel subsystems heavily reliant upon inlining (such as the scheduler,
> memory management, locking primitives, and RCU).
> 
> When the kernel is configured with CONFIG_FUNCTION_GRAPH_RETADDR=y, the
> funcgraph-retaddr trace option records the caller's return address on each
> function entry, manifested in the trace stream as a comment
> (e.g. /* <-wake_up_new_task+0x1d1/0x3e0 */). By interrogating DWARF debug
> information from the kernel image (vmlinux) utilising libdw, perf ftrace
> resolves this return address to its inlined callchain and synthesises the
> intermediate inlined frames directly into the streamed call-graph.
> 
> Synthesised inlined functions are rendered with an explicit /* (inline) */
> annotation at both entry and exit:
> 
>      # CPU  DURATION              FUNCTION CALLS
>      # |     |   |                 |   |   |   |
>       1)   0.856 us |  mutex_unlock(lock=0xffffffffbc28bfa0);
>       0)            |  wake_up_new_task(p=0xffff8b1f183bac80) {
>       0)            |    rb_irq_work_queue() { /* (inline) */
>       0)            |      rb_wakeups() { /* (inline) */
>       0)   1.374 us |        housekeeping_any_cpu(type=3);
>       0)            |        arch_irq_work_raise() {
>       0)            |          apic_wait_icr_idle() { /* (inline) */
>       0)            |            x2apic_send_IPI_self(vector=246) {
>       0)            |              instr_sysvec_irq_work() { /* (inline) */
>       0)            |                irq_enter_rcu() {
>       0)            |                  instr_sysvec_irq_work() { /* (inline) */
>       0)   0.673 us |                    irqtime_account_irq();
>       0)            |                  } /* instr_sysvec_irq_work (inline) */
>       0)   1.697 us |                }

Let me read this output..

It seems housekeeping_any_cpu() is called from the inlined chain:

  wake_up_new_task()
    -> rb_irq_work_queue()
      -> rb_wakeups()
        -> housekeeping_any_cpu()

But I think the actual call chain would seem like:

  wake_up_new_task()
    -> rb_wakeups()
      -> rb_irq_work_queue()
        -> housekeeping_any_cpu()

And I don't know how wake_up_new_task() called rb_wakeups() directly.

Also how do you know if arch_irq_work_raise() is called within the same
inlined call-chain?  It seems rb_irq_work_queue() indeed calls the
function after housekeeping_any_cpu():

  rb_irq_work_queue()
    -> irq_work_queue_on()
      -> __irq_work_queue_local()
        -> irq_work_raise()

I guess you compare the callchain with the previous one and merge the
call if they match.  Then it would support partial match and close some
parents correctly like when other function is called from rb_wakeups(),
for example.

> 
> This series decomposes the feature into a modular, bisectable progression
> of four patches:
> 
>     1.  Stack frame optimisation in __cmd_ftrace()
> 
>         Replaces the 4096-byte stack array in __cmd_ftrace() with dynamic
>         heap allocation alongside struct strbuf streaming, reducing the
>         stack frame footprint by over 96% (down to ~160 bytes) while
>         ensuring complete line-delimited records and robust EOF handling.
> 
>     2.  Return address comment filtering
> 
>         Introduces ftrace_parse_retaddr() and ftrace_filter_retaddr() with
>         --filter-retaddr and --graph-opts filter-retaddr to strip caller
>         comments from trace output, accompanied by an initial unit test
>         suite in tools/perf/tests/ftrace.c.

I'm curious why do we need options as we already have 'retaddr' graph-option
to enable it.  I think it should work the same as 'retaddr' is not
given, no?  Otherwise, we could add 'noretaddr' instead.

Also I think it's only useful with the --inline option.  If so, we could
handle that automatically when it's given (and 'retaddr' is not given).

Thanks,
Namhyung

> 
>     3.  Inlined function call-graph reconstruction
> 
>         Introduces --inline and -k or --vmlinux, dynamically synthesising
>         inlined frames marked with /* (inline) */. Correctly matches bare
>         closing braces ('}') when funcgraph-tail is disabled, clamps stack
>         depth to prevent indentation drift, and expands the automated test
>         suite to verify inline resolution, comment filtering, and stack
>         saturation recovery.
> 
>     4.  Execution duration suppression
> 
>         Introduces --graph-opts noduration (and duration=[0|1]) to toggle
>         the kernel's funcgraph-duration tracing option, omitting the
>         duration column when the user is focused purely on call-graph
>         topology and inlined hierarchy.
> 
> Changes since v1:
> 
>  - Modularised the implementation into a 4-patch bisectable series rather
>    than a monolithic commit
> 
>  - Resolved potential infinite loop on poll() upon trace_pipe EOF
> 
>  - Fixed stuck call stack frames when funcgraph-tail is disabled by
>    supporting bare closing delimiters matching LIFO stack frames
> 
>  - Prevented unbounded indentation growth on deep call trees by clamping
>    inline expansion and synchronising cs->inlined_depth to frames
>    successfully pushed onto cs->stack
> 
>  - Added dedicated unit tests covering bare closing braces and stack
>    saturation recovery
> 
>  - Refined option documentation in perf-ftrace.txt
> 
>  - Link to v1: https://lore.kernel.org/lkml/20261005211518.26786-1-atomlin@atomlin.com/
> 
> Aaron Tomlin (4):
>   perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
>   perf ftrace: Support filtering return address comments
>   perf ftrace: Support display of inlined functions in function graph
>     tracer
>   perf ftrace: Support omitting execution duration in function graph
>     tracer
> 
>  tools/perf/Documentation/perf-ftrace.txt |  21 +
>  tools/perf/builtin-ftrace.c              | 126 +++++-
>  tools/perf/tests/Build                   |   1 +
>  tools/perf/tests/builtin-test.c          |   1 +
>  tools/perf/tests/ftrace.c                | 240 ++++++++++
>  tools/perf/tests/tests.h                 |   1 +
>  tools/perf/util/Build                    |   1 +
>  tools/perf/util/ftrace.c                 | 537 +++++++++++++++++++++++
>  tools/perf/util/ftrace.h                 |  17 +
>  9 files changed, 933 insertions(+), 12 deletions(-)
>  create mode 100644 tools/perf/tests/ftrace.c
>  create mode 100644 tools/perf/util/ftrace.c
> 
> -- 
> 2.55.0
> 
