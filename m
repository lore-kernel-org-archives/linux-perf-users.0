Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879097;
	b=DOLci3b6/t+/3FtO5NT6tDkyN6u4qMRLVWQ+VA7s1afX3jgZ7jFUp/pcgCkMDypueOeL
	 wJg2egB+DAyKY8nS94Lnot1HI8w1Z5QfGBRxMDBamkXh7TLWn9IJga+kOFZqxpqksETAM
	 YZ8e5Y+sBvVgpFzjNRrrCTFBDdisjUO/gteiMY9m2Ejafq9+I3eY6CfeP8lZ2DkrScdYc
	 BP9lBJH/mjbcB9B0A1aKc4ueR8kv4P8MASrRVvqNcbnOnsmUqOGOz5vm9EBGldPuoSVe7
	 QdHC9jpMi3pEfnawGM1TeduVB1rB/aPBIG+UhTejdjKkJcDC35SXl3/ky1+p5HwHskA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879097;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CfgY3BVOGMgEZYJJiCIVHq9OY1jwK59IL7RycWD3H9M=;
	b=rklJS+O1b5LZ4Pwrsx9+MFH/TOu/DJV4zRFwvo+poUIXVY9AOdBL53pvLKnypGGc/DOE
	 7UAY5IoCejyHpQWAaFCq6lVMEmIxX64diba+3Vz20I2PuIyqWwgtOyKn93JQmJEAcGgvn
	 JGOLBdyoqQ+tZgpHfMFq6YQQwz9jQR51R1dszR+PzEz21cjb91O76sDXnnMYbz2SelhEp
	 eTj8doKDAC4RxycpYME2ABt610Qvfmh/YBz5yeWNnC22HtHkeH9AdHH+jwBK5qPICmB1G
	 qQ+bUNGGXkAo/RHOIN1tErdwT/CakLqakVSNCkMlP6Tu7k//Tj8I+ZdXoZjT4ITIyAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfYHFCbl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C45606A31A
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Oct 2026 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfYHFCbl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB561F01825;
	Sat, 24 Oct 2026 21:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792879096;
	bh=CfgY3BVOGMgEZYJJiCIVHq9OY1jwK59IL7RycWD3H9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LfYHFCblKHTh21v6WHbihQc93NyyaQDN0wKlZDPJox+iIjUM9QJtRnwRSGKeSNKhs
	 FQAyjNvQdUI/JIE3CtKaiE1F0O1V52ZfjsLQzNfLzni3NHKXXe42DFHI+D5Aj/poJB
	 KfUKy/zWsUPMXoe/8HIEXHdAcSkBTFQlYBL8Ien4uR4cr3y8ztEKv/MCqbLWWYsbhg
	 cIElr2S0FTGIMX6hweRQlKZNstFUpL4eir9EM/pbLknx1d61i1pcPpC5o/AwZE/bcm
	 mSLlG+L/EpbGC4u7G7dVluJnAz/NfwT9ybMxuJ28uxzLvCFd+/al1xGY7Nr9vkLwPB
	 QbtPCL0f21vKw==
Message-ID: <sashiko-outbox-183906@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v10 05/10] perf ftrace: Support context
 switch tracking in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261024212549.450634-6-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
 <20261024212549.450634-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:58:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf ftrace: misordered stack merge in ftrace_task_state__rekey()
--

commit 280dc48b3ef7d657647928030bf50a4696853eb9
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support context switch tracking in function graph tracer

This commit adds context switch detection and per-task call stack state
tracking to the userspace perf ftrace function graph processor. It parses
context switch banners, rekeys initial unknown per-CPU states upon
discovering task PIDs, and binds task states in verbose and single-PID
modes.

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index 95db57e70d11b..fea61a9e17b16 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c
[ ... ]
> @@ -124,6 +129,157 @@ static int ftrace_task_state__grow_stack(struct ftr=
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
> +		struct ftrace_task_state *older, *newer;
> +		int base_raw_indent;
> +
> +		for (c =3D 0; c < FTRACE_MAX_CPUS; c++) {
> +			if (ftrace_cpu_tasks[c] =3D=3D ts)
> +				ftrace_cpu_tasks[c] =3D existing;
> +		}
> +
> +		if (ts->seq < existing->seq) {
> +			older =3D ts;
> +			newer =3D existing;
> +		} else {
> +			older =3D existing;
> +			newer =3D ts;
> +		}
> +
> +		base_raw_indent =3D -1;
> +		if (newer->depth > 0)
> +			base_raw_indent =3D newer->stack[0].raw_indent;
> +		else if (newer->min_raw_indent >=3D 0)
> +			base_raw_indent =3D newer->min_raw_indent;
> +
> +		/*
> +		 * Prune frames on the older stack that have already exited
> +		 * (i.e. whose raw_indent >=3D base_raw_indent, along with any
> +		 * synthesized inlined frames).
> +		 */
> +		if (base_raw_indent >=3D 0) {
> +			while (older->depth > 0) {
> +				struct ftrace_stack_frame *top =3D
> +					&older->stack[older->depth - 1];
> +
> +				if (top->inlined) {
> +					free(top->name);
> +					if (older->inlined_depth > 0)
> +						older->inlined_depth--;
> +					older->depth--;
> +				} else if (top->raw_indent >=3D base_raw_indent) {
> +					free(top->name);
> +					older->depth--;
> +				} else {
> +					break;
> +				}
> +			}
> +		}
> +
> +		to_copy =3D ts->depth;
> +		if (to_copy > 0) {
> +			while (existing->depth + to_copy > existing->max_stack) {
> +				if (ftrace_task_state__grow_stack(existing) < 0)
> +					break;
> +			}
> +			if (existing->depth + to_copy > existing->max_stack)
> +				to_copy =3D existing->max_stack - existing->depth;
> +
> +			if (older =3D=3D ts) {
> +				memmove(&existing->stack[to_copy], &existing->stack[0],
> +					existing->depth * sizeof(existing->stack[0]));
> +				memcpy(&existing->stack[0], &ts->stack[0],
> +				       to_copy * sizeof(existing->stack[0]));
> +			} else {
> +				memcpy(&existing->stack[existing->depth], &ts->stack[0],
> +				       to_copy * sizeof(existing->stack[0]));
> +			}

[Severity: Medium]
Can ftrace_task_state__rekey() misorder the stack merge and prune active
frames when a task migrates to a CPU without an initial context-switch
banner and then migrates back before that CPU emits a banner?

In the kernel function_graph tracer (verif_pid()), each CPU initializes
last_pid =3D -1 and omits the context-switch banner for the first traced ta=
sk
on that CPU until a different traced task executes on it.

Suppose a task has a known state (existing) on CPU 0 with stack frames
[foo(raw_indent=3D2), bar(raw_indent=3D4)] and seq =3D 2, and then migrates=
 to
CPU 1 where no banner has been emitted yet, so events on CPU 1 are recorded
under ts =3D FTRACE_UNKNOWN_PID(1).

On CPU 1, the task exits bar(4) (setting ts->min_raw_indent =3D 4) and ente=
rs
qux(4) (giving ts->stack =3D [qux(4)] and ts->seq =3D 4), then migrates bac=
k to
CPU 0 before any other task is traced on CPU 1.

When the task then enters a child function baz(6) at leading_spaces =3D 6 on
CPU 0 in ftrace_process_fgraph_line(), baz(6) is pushed onto existing->stack
and existing->seq advances to 5 while foo(2) and the already-exited bar(4)
remain at the bottom of existing->stack. Even with the stale-frame unwinding
added in the follow-up commits ("perf ftrace: Support display of inlined
functions in function graph tracer" and "perf ftrace: Filter extraneous
functions in function graph tracer"), qux(4) resides on ts->stack rather
than existing->stack (so caller_idx is -1), meaning ftrace_process_fgraph_l=
ine()
only unwinds frames on existing->stack with raw_indent >=3D 6 and leaves
bar(4) in place.

When another task later runs on CPU 1 and emits the delayed context-switch
banner "1) P =3D> other", parse_context_switch() calls
ftrace_task_state__rekey(ts, P):

		if (ts->seq < existing->seq) {
			older =3D ts;
			newer =3D existing;
		} else {
			older =3D existing;
			newer =3D ts;
		}

		base_raw_indent =3D -1;
		if (newer->depth > 0)
			base_raw_indent =3D newer->stack[0].raw_indent;

Because ts->seq (4) < existing->seq (5), ftrace_task_state__rekey()
classifies ts as older and the entire existing state as newer, setting
base_raw_indent from existing->stack[0].raw_indent (foo at raw_indent =3D 2,
which actually predates ts).

Wouldn't the pruning loop on older (ts) then see that qux(4) has
raw_indent (4) >=3D base_raw_indent (2) and free the active qux(4) frame (a=
long
with any synthesized inlined frames on ts->stack), while leaving the exited
bar(4) frame on existing->stack?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024212549.4506=
34-1-atomlin@atomlin.com?part=3D5
