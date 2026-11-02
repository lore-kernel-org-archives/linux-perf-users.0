Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656557;
	b=COMGGOe/unXK8fQRUFYnO8pF9zppucZ6Jm9ktd/8PYY69xls2ZsfXI1q44ZXkk1KwCJU
	 NKdLFlmHrBS0VSBGF0KNzGb9MuaRVWC977rXaRfozXggSWbyv/dxvp8Grvkb0LMe/7wy/
	 CwqhId1pklLGxzo0iV3r0SjvS4uZs+AeX6TqeUEmZM3+2bPrjK/W6K2xQP7vveUOM+pbS
	 aebOz+EZg7MRBE8waT6XCxuESrKMQGc1Tz3cEw+nAQsqiKCLbj5547hrum+yJo3X0UKYB
	 PtfRY5OcdUl16V46a2QmkCTgnEWijPJ3ObINpWatMiLwnE/2DkuY5kl4gTpRVUpC/Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656557;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=md1l9Gfz56MR9DjTzStAEF47BEh101GedVwl120dY1I=;
	b=wzuLnTHRRKvujgKVSULGZxnR06NnnUzi78aiTOFxzA3hZ4Z6zDGadNM7XUF7vwihud78
	 FOX1Xwl2jAg+Ea/E/HeJi+OZA+n7PiNMQzh6/xoOTy4Nau1NfjwTn0YD0SALLTh8yuiDr
	 T450eXCHHhNK4twfr1R2l4zzeZY3maF1Tzxz57oAk4jVQW4NZ2oQVWHSA4AYFUDNuelqu
	 iZyJ5lt7htPXR2Q7G6lBk0G9onVvS3tiyCBAueDCLxFsAddUAgVJ2vtNkbRfAc8O3ekVr
	 C1jUa7rR+TiVvsRm0wfkNHI5n0sTMB2CNABkmNTvtAi9xdJpu/oesqpzRyhimJD9ffA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIDceZfM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F3606A324
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIDceZfM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D521F00A16;
	Mon,  2 Nov 2026 21:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793656557;
	bh=md1l9Gfz56MR9DjTzStAEF47BEh101GedVwl120dY1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dIDceZfMwFnxN+lcOVrimrW8u3c/0VcH7V54JoKwBTXpLsynnu6qvTEAUFza18Fvv
	 nOrZ5GuQeWArU0KzWWZr0WSUoiMUFgJrM1EFzCL6CHOYhBjtuUAtQg5g8p9hDrTH1u
	 IPP1RJHZdKITkDUieebOA6QYGTGkLnlhiNzp4gNQvqoPWkbpOo5j3RtbbEL5nBb4n7
	 KK3H21die5rTwEyYqmUpx9la82uNF+XjhUFlAW7MTGReKKu2SaT4kl3DVuatOr0b1P
	 8z5EtT2LwCePjXgjKOZZzRSX/T8TXkc0JpoWaD1cbEI/NcDu/P93F33JK2/jCkgDuy
	 E9Sx43Nq0R/fw==
Message-ID: <sashiko-outbox-194242@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v13 05/10] perf ftrace: Support context
 switch tracking in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102214054.911298-6-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
 <20261102214054.911298-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 21:55:56 +0000
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
- [Medium] perf ftrace: stale min_raw_indent fails to prune frames after mi=
gration
--

commit deda012d1c25c88f1250fe9b40670db3ff14f5e6
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support context switch tracking in function graph tracer

This commit adds context switch detection and per-task call stack state
tracking to the perf ftrace function graph tracer. It parses context switch
banners and verbose mode task columns to re-key, prune, and merge per-task
call stacks across CPU migrations.

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index 21d40c6eb288d..5c7d1c71c6350 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c
[ ... ]
> @@ -161,6 +177,205 @@ static struct ftrace_task_state *get_task_state(pid=
_t pid)
>  	return ts;
>  }
> =20
> +/**
> + * ftrace_task_state__record_indent - Record an indentation watermark fo=
r a task
> + * @ts: Task state to update
> + * @raw_indent: Raw indentation (leading spaces) of the observed trace r=
ecord
> + *
> + * Record the shallowest indentation observed on @ts along with its event
> + * sequence number so that earlier frames that have already exited can be
> + * pruned when merging task states across CPUs.
> + */
> +static void ftrace_task_state__record_indent(struct ftrace_task_state *t=
s,
> +					     int raw_indent)
> +{
> +	if (ts->min_raw_indent < 0 || raw_indent <=3D ts->min_raw_indent) {
> +		ts->min_raw_indent =3D raw_indent;
> +		ts->min_indent_seq =3D ts->seq;
> +	}
> +}
> +
> +/**
> + * ftrace_task_state__prune_stack - Prune frames that exited on another =
task state
> + * @ts: Task state whose call stack should be pruned
> + * @other: Other task state representing the same task on another CPU
> + *
> + * Remove any frames on @ts->stack that are known to have exited based on
> + * subsequent trace events recorded on @other (i.e. @other->min_indent_s=
eq >
> + * frame->seq and @other->min_raw_indent <=3D frame->indent). Synthesised
> + * inline frames are retained if and only if their enclosing real frame
> + * survives.
> + */
> +static void ftrace_task_state__prune_stack(struct ftrace_task_state *ts,
> +					   const struct ftrace_task_state *other)
> +{
> +	bool keep_inlines =3D false;
> +	bool seen_real =3D false;
> +	int i, dst =3D 0;
> +
> +	for (i =3D ts->depth - 1; i >=3D 0; i--) {
> +		struct ftrace_stack_frame *frame =3D &ts->stack[i];
> +		int min_indent =3D (other->min_indent_seq > frame->seq) ?
> +				 other->min_raw_indent : -1;
> +		bool prune;
> +
> +		if (frame->inlined) {
> +			if (seen_real)
> +				prune =3D !keep_inlines;
> +			else
> +				prune =3D (min_indent >=3D 0);
> +		} else {
> +			prune =3D (min_indent >=3D 0 && frame->indent >=3D min_indent);
> +			seen_real =3D true;
> +			keep_inlines =3D !prune;
> +		}
> +
> +		if (prune)
> +			zfree(&frame->name);
> +	}
[ ... ]
> +static struct ftrace_task_state *ftrace_task_state__rekey(struct ftrace_=
task_state *ts,
> +							  pid_t new_pid)
> +{
[ ... ]
> +	if (to_copy > 0) {
> +		int e_idx =3D 0, t_idx =3D 0, out_idx =3D 0;
> +
> +		if (orig_existing_depth > 0) {
> +			memmove(&existing->stack[to_copy],
> +				&existing->stack[0],
> +				orig_existing_depth * sizeof(existing->stack[0]));
> +		}
> +
> +		while (e_idx < orig_existing_depth && t_idx < to_copy) {
> +			if (existing->stack[to_copy + e_idx].seq <=3D
> +			    ts->stack[t_idx].seq) {
> +				existing->stack[out_idx++] =3D
> +					existing->stack[to_copy + e_idx++];
> +			} else {
> +				existing->stack[out_idx++] =3D
> +					ts->stack[t_idx++];
> +			}
> +		}

[Severity: Medium]
Can a shallow indentation recorded early in a task state's lifetime prevent
ftrace_task_state__prune_stack() from pruning deeper frames that exit after=
 a
round-trip CPU migration?

In ftrace_task_state__record_indent(), ts->min_raw_indent and
ts->min_indent_seq are only updated when raw_indent <=3D ts->min_raw_indent:

	if (ts->min_raw_indent < 0 || raw_indent <=3D ts->min_raw_indent) {
		ts->min_raw_indent =3D raw_indent;
		ts->min_indent_seq =3D ts->seq;
	}

Suppose a task executes on CPU 0 at indent 2 (seq 1), pinning CPU 0's
min_raw_indent =3D 2 and min_indent_seq =3D 1. The task then migrates to CP=
U 1
before a context-switch banner is emitted on CPU 1, enters deeper functions
on CPU 1 at indent 4 (seq 2) and indent 6 (seq 3), and migrates back to
CPU 0 while the outer indent-2 frame is still active.

When those deeper frames subsequently exit or new frames are entered at
indent 4 or 6 on CPU 0 (seqs 4..6), raw_indent <=3D ts->min_raw_indent
(4 <=3D 2 or 6 <=3D 2) is false, so CPU 0's min_indent_seq remains stuck at=
 1.

When the delayed context-switch banner on CPU 1 is later parsed and
ftrace_task_state__rekey() calls ftrace_task_state__prune_stack(),
other->min_indent_seq > frame->seq evaluates to false (1 > 2 and 1 > 3),
causing min_indent to be -1. As a result, the exited deeper frames (along
with any attached inline frames) are not pruned, and the merge loop in
ftrace_task_state__rekey() splices them into existing->stack purely by
sequence number ahead of newer frames at shallower or equal indentations.

Should ftrace_task_state__rekey() also unwind earlier frames whose
indentation is greater than or equal to a later frame's indentation during
the merge, or track indentation watermarks relative to the migration point?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102214054.9112=
98-1-atomlin@atomlin.com?part=3D5
