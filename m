Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952946;
	b=s0kF8g7YmcwqngvNoyXHwubxyhtPO090lNLMc8V1eOzqCHb9AUJwWAlHDMnTIJjFBEW4
	 VNtBswGY5HDlTGNg6K48mpujqzDA0et3ZNICeaa/vGoUiS1mRehJmujjryFN3oxKELeOw
	 R99aA27NYL0hONrfLN6Fh3Z5pVXcGNIMQw6SdQLZl3KnLj19CdcnJ2JVUOaPonR3kkcz6
	 yrx/12tRSHzqIe1xVwRQG1sufs+4VtclpwD975O9pPbe4h8cDsUtLDVz/QsfHkodIRthv
	 /z4BLZgJCl8HNKAhBp50cGPIF+6z0cU98SHsSByxqXmLviWwA1iewoaOhNKfQrxqdZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952946;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=II15di91OMub+P+WrTZM1YdGSeHgKTqDbv56RBgHb1U=;
	b=gQM6A/k4Jnl7yj1yin3W6oYhh+5U/V80cp0FQbohmfBq4bW+f973CiTGFintlhN+NJnt
	 qw85eFwMfOz0d6IqYVpbAB8E4AvKo4/o4DFKWJjOaWrsL5th7u2e6hkdAoS4tsCKLmBHB
	 JSICXqjCXK72Ll3eFBcsnE5iEp6VoqABaxcRVb9Sc059SgVwLJQeE8L6mFSns+0I6crK3
	 PO9+x5O+rW+o2AWPo3FBdFA/EwvdQlcb7Q4JfPiNNUSa3549MTYdbwjl8cwoa4E2XxkD3
	 UCQ/tfnHLCKtfxxxqXNrlgNoocpKihmXgbC49aT/O1RpPStp5YgXr3RSOmwVqSShN8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkf+qYIG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD603606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkf+qYIG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3EB1F01825;
	Sun, 25 Oct 2026 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792952945;
	bh=II15di91OMub+P+WrTZM1YdGSeHgKTqDbv56RBgHb1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kkf+qYIGZNhb6DCa0jFtMQpUfhOV7WrGNemJPrYODppBI2f2QSipllc++hyJQ6jim
	 e6p9Q42TiX+gpdwa7A+Hs4mmtpuu2ohIRAZlBQcZ/TkJp01J6ecGfCyp/yN0R6IV4F
	 PbFCie+eQQvs+b8wXVnJF6WPxP6LE+sCz8owxJQQqidzYTckIdm4A7iuXOHRe43pl0
	 fbcTKojPkIwqDrvkJ2H9pymuPIXi5iDWABuKrNYJFCd+0bh5JpzB9VHTL94zz03o4N
	 kt03sZTOvo2XOxbNv2FFsgKV2RXA+rgOZ1Gnv6OD/A+pKET7WDydT5baEGLq9KWxhS
	 84um+YtCx6Z5A==
Message-ID: <sashiko-outbox-184338@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v11 05/10] perf ftrace: Support context
 switch tracking in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261025181125.514372-6-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
 <20261025181125.514372-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 18:29:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf ftrace: broken min_raw_indent tracking in ftrace_task_state=
__rekey()
- [Medium] perf ftrace: non-contiguous unknown-PID splice in ftrace_task_st=
ate__rekey()
--

commit 242f56625a11f73350f70f6bfa60c779b6624a22
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support context switch tracking in function graph tracer

This commit adds context switch banner parsing and per-task call stack state
tracking to the function graph tracer in perf ftrace, including task state
rekeying and stack splicing across CPU migrations.

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index 95db57e70d11b..055b5eb6b8327 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c
[ ... ]
> @@ -124,6 +129,208 @@ static int ftrace_task_state__grow_stack(struct ftr=
ace_task_state *cs)
>  	return 0;
>  }
> =20
> +/**
> + * ftrace_task_state__rekey - Reassign a task state to a new PID
> + * @ts: The task state to re-key
> + * @new_pid: The new process ID to associate with the state
> + *
> + * Rehash @ts under @new_pid. If a task state for @new_pid already exist=
s,
> + * merge or replace it and update active CPU references accordingly.
> + *
> + * Return: A pointer to the active task state associated with @new_pid.
> + */
> +static struct ftrace_task_state *ftrace_task_state__rekey(struct ftrace_=
task_state *ts,
> +							  pid_t new_pid)
> +{
> +	struct ftrace_task_state *existing;
> +	u32 key;
> +	int j, c;
> +	int to_copy;
> +
> +	if (ts->pid =3D=3D new_pid)
> +		return ts;
> +
> +	hlist_del_init(&ts->node);
> +
> +	existing =3D find_task_state(new_pid);
> +	if (existing) {
> +		int split_idx =3D existing->depth;
> +		int old_split_idx, post_count;
> +		int base_raw_indent, post_raw_indent;
> +
> +		for (c =3D 0; c < FTRACE_MAX_CPUS; c++) {
> +			if (ftrace_cpu_tasks[c] =3D=3D ts)
> +				ftrace_cpu_tasks[c] =3D existing;
> +		}
> +
> +		/*
> +		 * Find the split point in existing where frames postdate ts.
> +		 * Frames 0 .. split_idx - 1 were pushed prior to ts.
> +		 * Frames split_idx .. existing->depth - 1 were pushed after ts.
> +		 */
> +		for (j =3D 0; j < existing->depth; j++) {
> +			if (existing->stack[j].seq > ts->seq) {
> +				split_idx =3D j;
> +				break;
> +			}
> +		}
> +		old_split_idx =3D split_idx;
> +		post_count =3D existing->depth - old_split_idx;
> +
> +		/*
> +		 * Prune pre-ts frames on existing that exited before or during ts
> +		 * (i.e. whose raw_indent >=3D base_raw_indent, along with any
> +		 * synthesized inlined frames).
> +		 */
> +		base_raw_indent =3D -1;
> +		if (ts->depth > 0)
> +			base_raw_indent =3D ts->stack[0].raw_indent;
> +		if (ts->min_raw_indent >=3D 0 &&
> +		    (base_raw_indent < 0 || ts->min_raw_indent < base_raw_indent))
> +			base_raw_indent =3D ts->min_raw_indent;
> +
> +		if (base_raw_indent >=3D 0) {
> +			while (split_idx > 0) {
> +				struct ftrace_stack_frame *top =3D
> +					&existing->stack[split_idx - 1];
> +
> +				if (top->inlined) {
> +					free(top->name);
> +					top->name =3D NULL;
> +					if (existing->inlined_depth > 0)
> +						existing->inlined_depth--;
> +					split_idx--;
> +					existing->depth--;
> +				} else if (top->raw_indent >=3D base_raw_indent) {
> +					free(top->name);
> +					top->name =3D NULL;
> +					split_idx--;
> +					existing->depth--;
> +				} else {
> +					break;
> +				}
> +			}
> +		}

[Severity: Medium]
Can this split_idx search and pre-ts pruning loop in
ftrace_task_state__rekey() drop active intermediate frames from
existing->stack when an initial unknown-PID state accumulates events both
before and after events on existing?

In the kernel's function_graph tracer, verif_pid() only emits a per-CPU
context switch banner when the traced PID on that CPU changes from its
previous traced PID. Consider when task P starts on CPU 0 (tracked under
ts =3D FTRACE_UNKNOWN_PID(0)), migrates to CPU 1, and then migrates back to
CPU 0 before any other task produces a trace event on CPU 0:

1. On CPU 0, task P pushes outer frames f1 (raw_indent =3D 2, seq =3D 1) and
   f2 (raw_indent =3D 4, seq =3D 2) onto ts (FTRACE_UNKNOWN_PID(0)).

2. Task P migrates to CPU 1, where a banner "other =3D> P" binds CPU 1 to
   existing (PID P), and pushes intermediate frames f3 (raw_indent =3D 6,
   seq =3D 3) and f4 (raw_indent =3D 8, seq =3D 4) onto existing->stack.

3. Task P migrates back to CPU 0. Since no other task emitted a trace
   record on CPU 0 in the meantime, no banner is emitted on CPU 0 and
   CPU 0 remains bound to ts. Task P executes another traced event on
   CPU 0 at seq =3D 5 (for example, a leaf call or inner frame f5 at
   raw_indent =3D 10), updating ts->seq to 5.

4. Later, another task runs on CPU 0 and emits "0) P =3D> next", triggering
   ftrace_process_fgraph_line() -> parse_context_switch() ->
   ftrace_task_state__rekey(ts, P).

Because ts->seq is now 5 while existing->stack frames f3 and f4 have
seq =3D 3 and 4, the loop checking existing->stack[j].seq > ts->seq finds no
match and leaves split_idx =3D existing->depth. That classifies f3 and f4 as
pre-ts frames, and the pruning loop then compares them against
base_raw_indent =3D ts->stack[0].raw_indent (2 from f1), freeing and droppi=
ng
the active intermediate frames f3 and f4.

> +
> +		/*
> +		 * If newer frames or exits exist on existing, prune any frames
> +		 * on ts that exited before them.
> +		 */
> +		post_raw_indent =3D -1;
> +		if (existing->seq > ts->seq) {
> +			if (post_count > 0)
> +				post_raw_indent =3D existing->stack[old_split_idx].raw_indent;
> +			if (existing->min_raw_indent >=3D 0 &&
> +			    (post_raw_indent < 0 || existing->min_raw_indent < post_raw_inden=
t))
> +				post_raw_indent =3D existing->min_raw_indent;
> +		}
[ ... ]
> @@ -402,6 +725,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ft=
race, const char *line, FIL
>  	if (is_exit) {
>  		char exit_name[128];
> =20
> +		if (cs->min_raw_indent < 0 || leading_spaces < cs->min_raw_indent)
> +			cs->min_raw_indent =3D leading_spaces;
> +
>  		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
> =20
>  		top_raw_indent =3D -1;
> @@ -479,7 +805,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ft=
race, const char *line, FIL
>  			cs->stack[cs->depth].inlined =3D false;
>  			cs->stack[cs->depth].indent =3D leading_spaces;
>  			cs->stack[cs->depth].raw_indent =3D leading_spaces;
> +			cs->stack[cs->depth].seq =3D cs->seq;
>  			cs->depth++;
> +			cs->min_raw_indent =3D -1;
>  		}
>  	}

[Severity: Medium]
Does tracking min_raw_indent as a single unsequenced value that is reset to
-1 on function entry cause ftrace_task_state__rekey() to miscompute
post_raw_indent and base_raw_indent across CPU migrations?

There appear to be two ways this can corrupt the tracked call stack when
ftrace_process_fgraph_line() -> parse_context_switch() ->
ftrace_task_state__rekey() merges ts into existing:

1. In ftrace_task_state__rekey(), existing->min_raw_indent is folded into
   post_raw_indent whenever existing->seq > ts->seq, without checking
   whether that minimum exit indentation was actually recorded after
   ts->seq:

   - Suppose task P on CPU 0 (existing) exits a function at
     leading_spaces =3D 2 (seq =3D 1), setting existing->min_raw_indent =3D=
 2.
   - Task P migrates to CPU 1 (ts =3D FTRACE_UNKNOWN_PID(1)) and enters
     functions at indentations 2, 4, and 6 (seq =3D 2..4, so ts->seq =3D 4).
   - Task P migrates back to CPU 0 (existing) at seq =3D 5 and executes a
     leaf call at indent 8 or exits only the deepest frame at indent 6.
     Now existing->seq is 5 (> ts->seq), while existing->min_raw_indent is
     still 2 from seq =3D 1.
   - When CPU 1 later emits its context switch banner and calls
     ftrace_task_state__rekey(ts, P), existing->seq > ts->seq is true and
     post_raw_indent becomes existing->min_raw_indent (2), causing the
     post-ts pruning loop to pop and free the still-active frames on ts at
     indentations 2 and 4.

2. In ftrace_process_fgraph_line(), pushing a new frame onto cs->stack
   unconditionally sets cs->min_raw_indent =3D -1. If a task on ts (or
   existing after ts) first exits a pre-migration frame at a shallow
   indentation (such as leading_spaces =3D 2, setting cs->min_raw_indent =
=3D 2)
   and then enters a new function at a deeper indentation (such as
   leading_spaces =3D 4), resetting cs->min_raw_indent =3D -1 erases the
   shallow exit watermark. When ftrace_task_state__rekey() subsequently
   computes base_raw_indent or post_raw_indent, it only sees indentation 4
   and fails to prune the already-exited frame at indentation 2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025181125.5143=
72-1-atomlin@atomlin.com?part=3D5
