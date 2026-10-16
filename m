Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC52199E89
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 04:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125405; cv=none; b=XtfNOiUFGJCcJ1+zysGjYj4KD6DnpbhfVKkQRwx+7e0Y2HdadIYbUIcDWJhtkvZyvGcMF64OD4asgejLqjYuAq+nQ2cGG3YFKhYHGOPRby6wbAN5zUu6EQcKh4TBj2xk3uMwWEo2QdxMqD+ydM7l6qHSnFakF5inerGtzc3luO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125405; c=relaxed/simple;
	bh=0rmMGEXLuTQQY7in3b5oJ3cShiU45q+n3R4p1GukUpM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gW0z3HB65A7spfASG2sejkooU+6HePHmQOmUXNiUb5Nql9bKHCM6lgJwAq1+3/saXyiTAvYimsJBQtvCHHHjQdB62Gx1M8XmPbZFEBR0sCVAi9D+ftoRZkjuGKOe200EO8U7tyiuNTVOFQCZuyABTvKxL9CA1aVpbZZ8T9xNmXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQY1LM/Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQY1LM/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79231F000C4;
	Fri, 16 Oct 2026 04:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792125404;
	bh=IaR+hAjySdi+vDQOA7C9WFoLmoson6mldgTseh/3kWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MQY1LM/YP6xagDmSTaB4pq3N37rOPv7kSUe+nCAzzysGT4AeKU0h4VZ6qj0vyhINf
	 wSRc19jnJ1sAy/tIjhd47jPTEHECNLMgLWG1vPF3U/9stJxZSQ+BbMflkOc7CIpt5o
	 bAUmO2nQye9FwhZc9pAxeTc2xGzUOMdIWYUbXvx8q1f7rtErtZeg240TCmX5aHCe+/
	 L8S2iWRqYJqQQgEoz3av37QK1zu20iQmg/eA2BSDzgY5ezgo7iNdjQheZOETpxjphO
	 38ifYlKhK0ldPEFYURH2fF9/d+ThOakJCBiDD8fE2wKfYRX57AZiDGS2TyMFaCrNDz
	 IzXyzkgRnl7FQ==
Message-ID: <sashiko-outbox-173792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v6 5/5] perf ftrace: Filter extraneous
 functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016040310.482876-6-atomlin@atomlin.com>
References: <20261016040310.482876-1-atomlin@atomlin.com>
 <20261016040310.482876-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 04:36:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf/ftrace: target filter state leak if target root is an overf=
lowed frame
- [Medium] perf/ftrace: name collision in orphan exit corrupts target track=
ing stack
- [Medium] perf/ftrace: orphan call filter bypassed when stack is overflowed
--

commit 507b405f29e53ab24cb9856a78d324efaeccdfc0
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Filter extraneous functions in function graph tracer

This commit filters extraneous functions (such as transient top-level
functions or detached orphan calls inside the target callgraph)
deterministically in user space when using the function graph tracer with
a targeted filter.

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index 6cdb87b445eaa..8a5d2bdf07207 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c

[ ... ]

> @@ -477,30 +541,57 @@ int ftrace_process_fgraph_line(struct perf_ftrace *=
ftrace, const char *line, FIL
>  	if (is_exit) {
>  		char exit_name[128];
> =20
>  		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
> =20
> -		/* Find matching frame on stack */
> +		/* Find matching frame on stack if exit is named */
>  		match_idx =3D -1;
> +		if (exit_name[0] !=3D '\0') {
> +			for (i =3D cs->depth - 1; i >=3D 0; i--) {
> +				if (!cs->stack[i].inlined && cs->stack[i].name &&
> +				    strcmp(cs->stack[i].name, exit_name) =3D=3D 0) {
>  					match_idx =3D i;
>  					break;
>  				}
>  			}
>  		}
> =20
> +		if (match_idx >=3D 0) {
> +			/* Named exit matches a tracked frame; clear stale orphan depth */
> +			cs->orphan_depth =3D 0;
> +		} else if (cs->orphan_depth > 0) {
> +			cs->orphan_depth--;
> +			return 0;
> +		}

[Severity: Medium]
Will this unconditional scan of the tracking stack cause name collisions if
a dropped orphan exit has the same name as an active frame?

The parser clears the orphan state and pops the stack if a name match is fo=
und,
blindly trusting that the named exit belongs to the tracked stack rather th=
an
the currently active orphan hierarchy.

If an unrelated orphan call shares the same name as a legitimate frame that
is currently active on the main target stack, it will prematurely match that
frame. The parser incorrectly assumes the tracked target function has exite=
d,
clears orphan_depth, and unspools the tracking stack up to that point.

Could this corrupt the target filter state and cause the actual target
function's eventual exit to be mishandled?

> +
> +		if (cs->overflow_depth > 0) {
> +			cs->overflow_depth--;
> +			if (!has_filter || cs->in_target) {
> +				if (!ftrace->use_inline) {
> +					print_line(ftrace, line, out);
> +				} else {
> +					extra_indent =3D cs->inlined_depth * 2;
> +					fprintf(out, "%.*s%*s%s\n",
> +						(int)(pipe_char - line + 1), line,
> +						leading_spaces + extra_indent, "", func_start);
> +				}
> +			}
> +			return 0;
> +		}

[Severity: Medium]
Does this early return skip the filter teardown logic located at the bottom
of the is_exit block?

If a target function is matched when the stack is already at FTRACE_MAX_STA=
CK,
in_target is set to true and target_root_depth is assigned FTRACE_MAX_STACK.
The parser enters the function, incrementing overflow_depth to 1 instead of
pushing a new tracking frame.

Upon the function's exit, the parser decrements overflow_depth and returns
early from the is_exit block. Because the cs->in_target =3D false teardown
logic is skipped, any subsequent unrelated sibling functions executing at t=
hat
stack depth will be leaked into the filtered trace output until the parent
frame exits and cs->depth drops below the maximum stack limit.

[ ... ]

> @@ -566,6 +824,22 @@ int ftrace_process_fgraph_line(struct perf_ftrace *f=
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
> +		if (has_retaddr && (caller_idx >=3D 0 ? caller_idx < cs->target_root_d=
epth
> +						    : cs->overflow_depth =3D=3D 0)) {
> +			if (has_open_brace && !has_semicolon)
> +				cs->orphan_depth =3D 1;
> +			for (i =3D 0; i < num_inlines; i++)
> +				free((void *)inlined_names[i]);
> +			return 0;
> +		}
> +	}

[Severity: Medium]
When the stack is overflowed (overflow_depth > 0), does this fallback
condition evaluate to false and bypass the orphan filter?

To suppress detached orphan calls originating outside the target hierarchy,
the parser verifies that each child entry descends from an active target st=
ack
frame by resolving its return address. If the caller is not found on the ac=
tive
tracking stack (caller_idx < 0), the code checks if cs->overflow_depth =3D=
=3D 0.

If the stack is actively overflowed (overflow_depth > 0), the condition
evaluates to false, causing the parser to not return early to suppress the
call. The logic blindly assumes that any unknown caller during an overflow
must be a legitimate overflowed child.

Could this disable the orphan suppression mechanism during deep call stacks,
allowing unrelated interrupt handlers or rb_wakeups() subtrees to leak into
the filtered target output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016040310.4828=
76-1-atomlin@atomlin.com?part=3D5
