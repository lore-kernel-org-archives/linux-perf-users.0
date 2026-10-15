Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08C31E82B
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 01:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027491; cv=none; b=QbBFESLjPBSn3vzORQw1vQxhvsI3lk/03jUm/HK4Iz7M+OZcuo4tX35wEF83XPvg95yMmGJL7QPxxrDlA8pZ8psJ+4zLa91uPi3uip4AHeF/p2MIMsoGouzLuSDcTkctF4XMU9dginhEPyAuq1w2+pJsby+OFPRiUcKFKh0q3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027491; c=relaxed/simple;
	bh=fiMr2Xyg4raSy7wBl9rmCp6sv+zQKxEVnZ8rSyTxv64=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kRAqO6m9NQ7jDdWNrblcFB+plz/DXj+yz3IsZ73+SUYPeZcy9btKr0rfQ3YzvEIh6WYnbhcmd4WRhz+0VqqzeaWNQEa8Zm39qMa89hkfbqzyawY7SJEuTXA5P96qT8/qIvRC9T5hYaosrkX+QC63XYG5Qi8zp+7lKkvxztAve3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY0EkNBk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY0EkNBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFF21F000C4;
	Thu, 15 Oct 2026 01:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792027490;
	bh=Wy6jmBElFCcR+4miO1qQkqS6pslcqb9LZqUk40peoZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eY0EkNBkc7bmyhW0225BZmUdnI+pvxDCIFwf0aNeLUaVkVcrZAfn1rf0mRvHxNudp
	 x2O4ZqaJgvYb7DHj/j2x9svpOaNgmEcOs0rOj0Xay6AiaqL9G1UDSxpYLZt03VnNW1
	 WjAiHV6mhZkhPOG+4dPDX8o4blvxN9t0LuY869mzUqet+aDUK2w5NCKeaGA523tN4H
	 4+F7hHNyGwz8Bksj+mJUMwztBGUuukmfLEeBl1C2sGPLZ48ev0fOrGZaNHNyTgcUyW
	 JAYYfy2j2v3Dw90cqlaiSzl/QXeiv3eYl5+250yFr8vK6DjbCFcD7KAF09+WdXzkwE
	 65FJ/wgU9EPiQ==
Message-ID: <sashiko-outbox-172088@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v5 5/5] perf ftrace: Filter extraneous
 functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015011155.414667-6-atomlin@atomlin.com>
References: <20261015011155.414667-1-atomlin@atomlin.com>
 <20261015011155.414667-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 01:24:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf ftrace: inaccurate target_root_depth capture causes prematu=
re filter termination
- [Medium] perf ftrace: deep target subtrees suppressed as orphans on stack=
 overflow
- [Medium] perf ftrace: permanent stack desynchronization on dropped orphan=
 exit
--

commit bc1ceece5244de5f3fd5ae63daec2de2ddd1eee0
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Filter extraneous functions in function graph tracer
   =20
When tracing with the function graph tracer using a targeted filter
(-G or --graph-funcs), users occasionally observe unrelated functions in
the trace output:

[ ... ]

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index 71f00d393349e..90d0e3c9f8b5b 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c

[ ... ]

> @@ -476,12 +514,23 @@ int ftrace_process_fgraph_line(struct perf_ftrace *=
ftrace, const char *line, FIL
>  	if (is_exit) {
>  		char exit_name[128];
> =20
> +		if (cs->orphan_depth > 0) {
> +			cs->orphan_depth--;
> +			return 0;
> +		}

[Severity: Medium]
If an orphan call executes and increments cs->orphan_depth, but its
corresponding exit event is dropped by the kernel ring buffer,
cs->orphan_depth will remain > 0.

Will the next valid exit event (belonging to the target callgraph) hit this
block and be blindly consumed without popping its frame from cs->stack?

Could this lead to permanent desynchronization of the tracked call stack?

[ ... ]

> @@ -539,6 +601,98 @@ int ftrace_process_fgraph_line(struct perf_ftrace *f=
trace, const char *line, FIL
>  	has_open_brace =3D (strchr(func_start, '{') !=3D NULL);
>  	has_semicolon =3D (strchr(func_start, ';') !=3D NULL);
> =20
> +	if (cs->orphan_depth > 0) {
> +		if (has_open_brace && !has_semicolon)
> +			cs->orphan_depth++;
> +		return 0;
> +	}
> +
> +	if (has_filter) {
> +		if (cs->depth =3D=3D 0 || !cs->in_target) {
> +			char entry_name[128];
> +
> +			extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
> +			if (ftrace_is_graph_func(ftrace, entry_name)) {
> +				cs->in_target =3D true;
> +				cs->target_root_depth =3D cs->depth;

[Severity: Medium]
Since cs->target_root_depth is captured here as the current cs->depth, what
happens if the --inline option is used?

Can subsequent inline resolution logic pop stale inline frames from previous
sibling calls, decrementing cs->depth before the target root itself is push=
ed?

If so, could the target root end up being pushed at a depth lower than the
captured target_root_depth, causing the target filter to prematurely
terminate when a child of the target root exits (since
cs->depth <=3D cs->target_root_depth would evaluate to true)?

> +				cs->orphan_depth =3D 0;
> +				is_target_root =3D true;
> +			} else if (cs->depth =3D=3D 0) {
> +				cs->in_target =3D false;
> +				cs->orphan_depth =3D 0;
> +			}
> +		}

[ ... ]

> +	if (!ftrace->use_inline) {
> +		if (has_filter && cs->in_target && cs->depth > cs->target_root_depth) {
> +			if (ftrace_parse_retaddr(func_start, caller_sym,
> +						 sizeof(caller_sym), &caller_offset)) {
> +				caller_idx =3D -1;
> +				for (i =3D cs->depth - 1; i >=3D 0; i--) {
> +					if (!cs->stack[i].inlined && cs->stack[i].name &&
> +					    strcmp(cs->stack[i].name, caller_sym) =3D=3D 0) {
> +						caller_idx =3D i;
> +						break;
> +					}
> +				}
> +				if (caller_idx < cs->target_root_depth) {
> +					if (has_open_brace && !has_semicolon)
> +						cs->orphan_depth =3D 1;
> +					return 0;
> +				}

[Severity: Medium]
If the call stack depth exceeds FTRACE_MAX_STACK, cs->overflow_depth is
incremented instead of pushing new frames to cs->stack.

When a subsequent legitimate child call is processed, its caller won't be
found in the stack, leaving caller_idx as -1.

Will this cause caller_idx < cs->target_root_depth to evaluate to true,
incorrectly flagging the valid child as an orphan and suppressing it and
all its subtrees?

[ ... ]

> @@ -565,6 +719,21 @@ int ftrace_process_fgraph_line(struct perf_ftrace *f=
trace, const char *line, FIL
>  		}
>  	}
> =20
> +	/*
> +	 * When inside a target graph filter, child functions must descend
> +	 * from an active frame on the target stack. Suppress detached
> +	 * calls originating outside the target hierarchy.
> +	 */
> +	if (has_filter && cs->in_target && cs->depth > cs->target_root_depth) {
> +		if (has_retaddr && caller_idx < cs->target_root_depth) {
> +			if (has_open_brace && !has_semicolon)
> +				cs->orphan_depth =3D 1;
> +			for (i =3D 0; i < num_inlines; i++)
> +				free((void *)inlined_names[i]);
> +			return 0;
> +		}
> +	}

[Severity: Medium]
Similar to the non-inline case, if the stack has overflowed FTRACE_MAX_STAC=
K,
caller_idx will be -1 because the parent frame was never pushed to the stac=
k.

Does this mean caller_idx < cs->target_root_depth will incorrectly evaluate
to true, wrongly classifying deep legitimate subtrees as orphans and droppi=
ng
them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015011155.4146=
67-1-atomlin@atomlin.com?part=3D5
