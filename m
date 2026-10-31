Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793484114;
	b=5Px50Uxpl1dKtO5b35saxeh8bWiancPQK7Wxcb87Wf6OX/t9bjrSO/z1UWzjcXfDn3Jk
	 gdd9+MuCLfdHIcVecorjp8Hyh6MpLrR5ge4e0p/58kpE4awu4DkHz4tP5tJJcMq7wBlnS
	 R4vMOr+S0MIp+rsimfMW72BY+rpzLwMPNAeVudwLQxDKRVCfeqp/KH0kC0BdrYBxM7GQE
	 TRgaacjP+AC4VNoaLD7bQQzVhEhibkd+hSHUpSbOOB/gIdYVlcknDCaqKcDE2D/ETs3G2
	 FfuCe6hfKuJU0LsMeawPh9OI3wQBy46TQxBeLZpTo5TYzZ0rP5daXCl0uYl4IJ+mwsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484114;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Sbt7JqkJgu0zqPNckyfXZ49Vdj3nWIxMbu5RLnudvr4=;
	b=Ydlb/jTgCHUM/uzg/OZdN/zFWwxBKCase3hO5Tm3RdZdoSHiKDdZI4Yvq4cK7Ra9BjTa
	 mb1zbbzZ9ioGfXA2xaxQqT+25vD2sYOzHw2geZ0hlwZvP1pZ5KGsXnvROoS+s3gC8aDxw
	 kZa3UJFPGnqu3q2o2XYYC2a6Ftuc9HSIVq1mf+FSJxQ4kB49HmdFMq+p+MU26iaVHBAwr
	 F2n1Z5827yErAFSZSgMeHp8QFHXYeX45QqHB2Ld8qLqCp/ca544IN1NO435EXMJSGCXG+
	 r/wpO/nZjVDjwpUfErBAR25c7bHEeU2UItvXH/U/b+OWYsBj1P5DL7q0nFAu2di/DmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzPY9vVs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC6606A31A;
	Sat, 31 Oct 2026 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzPY9vVs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB431F000C1;
	Sat, 31 Oct 2026 22:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793484113;
	bh=Sbt7JqkJgu0zqPNckyfXZ49Vdj3nWIxMbu5RLnudvr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UzPY9vVs6Ex4oShBeJtRml3BpHhwtkXQCcYmgnvRsIDLA/gm7A6fVcDat2wu+7ceO
	 hyhCFUq/8EKrK4UHBaK8AIHIHQ9TtPP4snD9VFNnQROCdKfZstkHzSg3m32ADIVuYe
	 St8BRl6I81l4PMuxECoirxmJqetmxfA7+GgAqdSagS4cYIEeqGi4mCWK9li6Z6y95P
	 TDrEXEYmgo+XUt1+uAmIfJunUz1tnHY7Qn5buBN+a2PZwFaLZrYIFkTq7likwZT6hS
	 kBumFMhQ9fxC/5aMh27/YViBOqSmTTJ0AOh4zKR//siZTAKV9wEAHwU3W74Gsl2OhV
	 shZGRNU6zNTEA==
Date: Sat, 31 Oct 2026 15:01:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	chjohnst@mail.com, neelx@suse.com, sean@ashe.io,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 05/10] perf ftrace: Support context
 switch tracking in function graph tracer
Message-ID: <auZlT1eIOjpTnqHZ@z2>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-6-atomlin@atomlin.com>
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
In-Reply-To: <20261026025735.546101-6-atomlin@atomlin.com>

On Sun, Oct 25, 2026 at 10:57:30PM -0400, Aaron Tomlin wrote:
> When tracing multiple tasks across multiple CPUs, kernel context switches
> cause different threads of execution to interleave on the same CPU. Without
> context switch awareness, interleaved function calls corrupt the tracked
> call stack.
> 
> Add context switch detection and per-task state tracking:
> 
>     1.  Context switch banner parsing
> 
>         Implement parse_context_switch() to parse context switch banners
>         (e.g. " 0) <idle>-0 => migrati-19") in the trace stream, extracting
>         the CPU number and both outgoing and incoming task PIDs.
> 
>     2.  Task state rekeying and migration
> 
>         Implement ftrace_task_state__rekey() to reassign initial unknown
>         task states to real PIDs upon discovering outgoing task identity.

Yeah, it's unfortunate that the default ftrace output doesn't show PIDs. 


>         Track monotonic trace event sequence numbers on each frame so
>         merges can locate the exact splice boundary when tasks migrate
>         across CPUs and back before delayed banners are emitted. Prune
>         exited frames from pre-migration calls while preserving
>         intermediate active frames and splicing them directly into the
>         task call stack.
> 
>     3.  Verbose mode and single-PID binding
> 
>         In find_func_column(), parse the comm-pid column in verbose mode
>         to bind active task state on each line record.
> 
>         In get_cpu_state(), pre-bind single-PID workloads across all CPUs
>         when context-switch banners are absent.
> 
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/util/ftrace.c | 430 ++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/ftrace.h |  10 +
>  2 files changed, 436 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index 95db57e70d11..fc385d680911 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c
> @@ -13,11 +13,14 @@
>  #include <errno.h>
>  #include <sys/types.h>
>  #include "debug.h"
> +#include "evlist.h"
>  #include "util/ftrace.h"
>  #include "util/string2.h"
> +#include <perf/threadmap.h>
>  
>  static struct hlist_head ftrace_task_hash[FTRACE_PID_HASH_SIZE];
>  static struct ftrace_task_state *ftrace_cpu_tasks[FTRACE_MAX_CPUS];
> +static u64 ftrace_event_seq;
>  
>  /**
>   * ftrace_cpu_states__clear - Free allocated CPU and task stack states
> @@ -36,12 +39,14 @@ void ftrace_cpu_states__clear(void)
>  			for (j = 0; j < ts->depth; j++)
>  				free(ts->stack[j].name);
>  			free(ts->stack);
> +			free(ts->watermarks);
>  			hlist_del_init(&ts->node);
>  			free(ts);
>  		}
>  	}
>  
>  	memset(ftrace_cpu_tasks, 0, sizeof(ftrace_cpu_tasks));
> +	ftrace_event_seq = 0;
>  }
>  
>  /**
> @@ -98,6 +103,119 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
>  	return ts;
>  }
>  
> +/**
> + * ftrace_task_state__record_indent - Record an indentation watermark for a task
> + * @cs: Task state to update

Why is it called 'cs' instead of 'ts'?  Same goes to the later functions
too.


> + * @seq: Event sequence number of the observed trace record
> + * @raw_indent: Raw indentation (leading spaces) of the observed trace record
> + *
> + * Maintain a monotonic suffix-minima array of (seq, raw_indent) pairs. Any
> + * previously recorded watermarks with an indentation greater than or equal to
> + * @raw_indent are dominated by this newer, shallower (or equal) event for all
> + * earlier frames and are popped before appending the new watermark.
> + *
> + * Return: 0 on success, or -ENOMEM if memory allocation fails.
> + */
> +static int ftrace_task_state__record_indent(struct ftrace_task_state *cs,
> +					    u64 seq, int raw_indent)
> +{
> +	while (cs->nr_watermarks > 0 &&
> +	       cs->watermarks[cs->nr_watermarks - 1].raw_indent >= raw_indent)
> +		cs->nr_watermarks--;
> +
> +	if (cs->nr_watermarks >= cs->max_watermarks) {
> +		int new_max = cs->max_watermarks ? cs->max_watermarks * 2 : 16;
> +		struct ftrace_indent_watermark *new_wm;
> +
> +		new_wm = realloc(cs->watermarks, new_max * sizeof(*new_wm));
> +		if (!new_wm)
> +			return -ENOMEM;
> +		cs->watermarks = new_wm;
> +		cs->max_watermarks = new_max;
> +	}
> +
> +	cs->watermarks[cs->nr_watermarks].seq = seq;
> +	cs->watermarks[cs->nr_watermarks].raw_indent = raw_indent;
> +	cs->nr_watermarks++;
> +	return 0;
> +}
> +
> +/**
> + * ftrace_task_state__min_indent_after - Query minimum indentation after a sequence number
> + * @cs: Task state whose watermarks are queried
> + * @frame_seq: Sequence number of the frame to check against
> + *
> + * Because @cs->watermarks stores suffix minima in strictly increasing order of
> + * both sequence number and indentation, the first watermark with seq > @frame_seq
> + * holds the minimum raw indentation observed on @cs after @frame_seq.
> + *
> + * Return: The minimum raw indentation observed on @cs after @frame_seq, or -1
> + *         if no events were recorded on @cs after @frame_seq.
> + */
> +static int ftrace_task_state__min_indent_after(const struct ftrace_task_state *cs,
> +					       u64 frame_seq)
> +{
> +	int i;
> +
> +	for (i = 0; i < cs->nr_watermarks; i++) {
> +		if (cs->watermarks[i].seq > frame_seq)
> +			return cs->watermarks[i].raw_indent;
> +	}
> +
> +	return -1;
> +}
> +
> +/**
> + * ftrace_task_state__prune_stack - Prune frames that exited on another task state
> + * @cs: Task state whose call stack should be pruned
> + * @other: Other task state representing the same task on another CPU
> + *
> + * Remove any frames on @cs->stack that are known to have exited based on
> + * subsequent trace events recorded in @other->watermarks (i.e. events with
> + * seq > frame->seq and raw_indent <= frame->raw_indent). Synthesised inline
> + * frames are retained if and only if their enclosing real frame survives.
> + */
> +static void ftrace_task_state__prune_stack(struct ftrace_task_state *cs,
> +					   const struct ftrace_task_state *other)
> +{
> +	bool keep_inlines = false;
> +	bool seen_real = false;
> +	int i, dst = 0;
> +
> +	for (i = cs->depth - 1; i >= 0; i--) {
> +		struct ftrace_stack_frame *frame = &cs->stack[i];
> +		int min_indent = ftrace_task_state__min_indent_after(other, frame->seq);
> +		bool prune;
> +
> +		if (frame->inlined) {
> +			if (seen_real)
> +				prune = !keep_inlines;
> +			else
> +				prune = (min_indent >= 0);
> +		} else {
> +			prune = (min_indent >= 0 && frame->raw_indent >= min_indent);
> +			seen_real = true;
> +			keep_inlines = !prune;
> +		}
> +
> +		if (prune) {
> +			free(frame->name);
> +			frame->name = NULL;

You can use zfree(&frame->name);


> +			if (frame->inlined && cs->inlined_depth > 0)
> +				cs->inlined_depth--;
> +		}
> +	}
> +
> +	for (i = 0; i < cs->depth; i++) {
> +		if (cs->stack[i].name) {
> +			if (dst != i)
> +				cs->stack[dst] = cs->stack[i];
> +			dst++;
> +		}
> +	}
> +	cs->depth = dst;
> +}
> +
>  /**
>   * ftrace_task_state__grow_stack - Double the capacity of a task's call stack
>   * @cs: Task state whose stack should be resized
> @@ -124,6 +242,182 @@ static int ftrace_task_state__grow_stack(struct ftrace_task_state *cs)
>  	return 0;
>  }
>  
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
> +	int j, c;
> +	int to_copy;
> +
> +	if (ts->pid == new_pid)
> +		return ts;
> +
> +	hlist_del_init(&ts->node);
> +
> +	existing = find_task_state(new_pid);
> +	if (existing) {

I think it's better to handle the else case first as it's much shorter.
You can save an indentation level for the true case then.


> +		int orig_existing_depth;
> +		int total_needed;
> +
> +		for (c = 0; c < FTRACE_MAX_CPUS; c++) {
> +			if (ftrace_cpu_tasks[c] == ts)
> +				ftrace_cpu_tasks[c] = existing;
> +		}

I don't this is necessary.  IIUC the rekey function is supposed to be
called for a specific CPU and caller will update the CPU state.

> +
> +		/*
> +		 * Prune frames on existing and ts that exited during subsequent
> +		 * execution recorded on the other state.
> +		 */
> +		ftrace_task_state__prune_stack(existing, ts);
> +		ftrace_task_state__prune_stack(ts, existing);

I'm not sure about this.  In this context, it knows the 'ts' is uptodate
and the 'existing' contains the old state.  Does it need to prune the ts
using the existing?

IIUC this code assumes either ts or existing may have uptodate state
like in general cases but it would make the code unnecessarily longer.

> +
> +		orig_existing_depth = existing->depth;
> +		to_copy = ts->depth;
> +		total_needed = orig_existing_depth + to_copy;
> +
> +		while (total_needed > existing->max_stack) {
> +			if (ftrace_task_state__grow_stack(existing) < 0)
> +				break;
> +		}
> +		if (total_needed > existing->max_stack) {
> +			if (existing->max_stack > orig_existing_depth)
> +				to_copy = existing->max_stack - orig_existing_depth;
> +			else
> +				to_copy = 0;
> +		}
> +
> +		if (to_copy > 0) {
> +			int e_idx = 0, t_idx = 0, out_idx = 0;
> +
> +			if (orig_existing_depth > 0) {
> +				memmove(&existing->stack[to_copy],
> +					&existing->stack[0],
> +					orig_existing_depth * sizeof(existing->stack[0]));
> +			}
> +
> +			while (e_idx < orig_existing_depth && t_idx < to_copy) {
> +				if (existing->stack[to_copy + e_idx].seq <=
> +				    ts->stack[t_idx].seq) {
> +					existing->stack[out_idx++] =
> +						existing->stack[to_copy + e_idx++];
> +				} else {
> +					if (ts->stack[t_idx].inlined)
> +						existing->inlined_depth++;
> +					existing->stack[out_idx++] =
> +						ts->stack[t_idx++];
> +				}
> +			}
> +			while (t_idx < to_copy) {
> +				if (ts->stack[t_idx].inlined)
> +					existing->inlined_depth++;
> +				existing->stack[out_idx++] = ts->stack[t_idx++];
> +			}
> +			while (e_idx < orig_existing_depth) {
> +				existing->stack[out_idx++] =
> +					existing->stack[to_copy + e_idx++];
> +			}
> +		}
> +
> +		for (j = to_copy; j < ts->depth; j++)
> +			free(ts->stack[j].name);
> +
> +		existing->depth = orig_existing_depth + to_copy;
> +
> +		if (ts->seq > existing->seq)
> +			existing->seq = ts->seq;
> +
> +		if (ts->nr_watermarks > 0) {
> +			struct ftrace_indent_watermark *old_wm = existing->watermarks;
> +			int old_nr = existing->nr_watermarks;
> +			int e_wm = 0, t_wm = 0;
> +
> +			existing->watermarks = NULL;
> +			existing->max_watermarks = 0;
> +			existing->nr_watermarks = 0;
> +
> +			while (e_wm < old_nr && t_wm < ts->nr_watermarks) {
> +				if (old_wm[e_wm].seq <= ts->watermarks[t_wm].seq) {
> +					ftrace_task_state__record_indent(
> +						existing,
> +						old_wm[e_wm].seq,
> +						old_wm[e_wm].raw_indent);
> +					e_wm++;
> +				} else {
> +					ftrace_task_state__record_indent(
> +						existing,
> +						ts->watermarks[t_wm].seq,
> +						ts->watermarks[t_wm].raw_indent);
> +					t_wm++;
> +				}
> +			}
> +			while (e_wm < old_nr) {
> +				ftrace_task_state__record_indent(
> +					existing,
> +					old_wm[e_wm].seq,
> +					old_wm[e_wm].raw_indent);
> +				e_wm++;
> +			}
> +			while (t_wm < ts->nr_watermarks) {
> +				ftrace_task_state__record_indent(
> +					existing,
> +					ts->watermarks[t_wm].seq,
> +					ts->watermarks[t_wm].raw_indent);
> +				t_wm++;
> +			}
> +			free(old_wm);
> +		}

I'm curious if it really needs to have watermarks.  I guess it's enough
to have a watermark for each task (actually for each CPUs that are
running unidentified tasks) and only updates it on context switch.

Thanks,
Namhyung

> +
> +		free(ts->watermarks);
> +		free(ts->stack);
> +		free(ts);
> +		return existing;
> +	}
> +
> +	ts->pid = new_pid;
> +	key = hash_32((u32)new_pid, FTRACE_PID_HASH_BITS);
> +	hlist_add_head(&ts->node, &ftrace_task_hash[key]);
> +	return ts;
> +}
