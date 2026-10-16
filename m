Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02066190462
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 04:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792124634; cv=none; b=T3zTTzBjOYZ4f8uLq0Th+oPu8vNL4oN+3nnCTWpvIC1mVms6kreH+gFJu6TiZ1HrKanw/3x6OEZqKvsSn8y6/0kUksnxtg4AHhbt/USUPhOWZ/M9dzNgubLr61+qQI7MjO0JBdxk7S/2opk7A/019qUtjaaIMYB4NEzMG+3zODo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792124634; c=relaxed/simple;
	bh=LaafSGs3ukuf2LBLEglVGUvI0NAl2TGEsz5p22ofGyM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aAXW7hFgor1d1bJPouBkWpMj9rk0iElHLcqnXngFz14yDPwgF6G2Xw+4oJiEccxGR5CxJuRCwdUGq8V6Hg77PArEAmdOcsUrRLnsCnxW9qy2whO2ayqBoqBHGhMOg6BjlUnW1FwT2uzRWwtgEZc8YUPpT6pp7/QF7jwOcvDKPW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCNwyttL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCNwyttL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517011F000C4;
	Fri, 16 Oct 2026 04:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792124632;
	bh=4SLxM9cR0YobOl0fwtd5Fx/epMtcV1xVbxYWXV7GkxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CCNwyttLVki9MRibXwheu4wIp5sQgZOy02/LKOdg02klmiN4UzvWuis+8xQiYYjDn
	 rB8vIK6aeTuI6yaOfUKG0rEZZHqV34fRqXVAflSYTEu8Cdqtk9qBsvAksT4KAIoUjh
	 mkUScZe6gOtRQa1Tqk1wPo+/sTZ23zDJJKcBLHFT3v8mPZRj8ijOiPk9G9srln9er5
	 MN3nPFj6o/qowW/7KyKieSwU7SSNP+lm1X9pTw+A3p6cbAJZ6kH4DNGD32kRjTSyCB
	 HD6K3xOOKvDKstw1gesP84BgPXPe8Em320xEyv3Kq9f5EWn0F0lMnttJyGj2LseHan
	 s3Ac0nQQie0sA==
Message-ID: <sashiko-outbox-173772@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v6 3/5] perf ftrace: Support display of
 inlined functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016040310.482876-4-atomlin@atomlin.com>
References: <20261016040310.482876-1-atomlin@atomlin.com>
 <20261016040310.482876-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 04:23:51 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] perf/ftrace: Stack tracking corrupts across context switches and t=
ask migrations
- [Medium] perf/ftrace: Stack overflow_depth is not reset when stale frames=
 are popped
- [Low] perf/ftrace: Missing <stdio.h> inclusion for FILE type in ftrace.h
--

commit ffcafe3751978ca1760ca39e8d576173ee6402ee
Author: Aaron Tomlin <atomlin@atomlin.com>

    perf ftrace: Support display of inlined functions in function graph tra=
cer

This commit introduces the --inline option to perf ftrace for the
function_graph tracer. It resolves return addresses to their inlined callch=
ain
and synthesizes the intermediate inlined frames directly into the streamed =
call
graph.

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c

[ ... ]

> +int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *l=
ine, FILE *out)
> +{

[ ... ]

> +	if (!ftrace->use_inline)
> +		return print_line(ftrace, line, out);
> +
> +	pipe_char =3D find_func_column(ftrace, line, &cpu);
> +	if (!pipe_char)
> +		return print_line(ftrace, line, out);
> +
> +	cs =3D get_cpu_state(cpu);

[Severity: High]
Does this code handle context switches appropriately?

When trace_pipe output is read, it contains context switch banners when tas=
ks
change on a CPU. These banners cannot be parsed by find_func_column(), which
will return NULL, skipping the line without clearing the stack state.

Because the state is tracked strictly per-CPU without task awareness, could
this cause the newly scheduled task to erroneously inherit the preempted
task's call stack? Furthermore, an unmatched closing brace from the newly
scheduled task could incorrectly match and pop the stranded frames belonging
to the preempted task:

[ ... ]

> +		/* Find matching frame on stack */
> +		match_idx =3D -1;
> +		for (i =3D cs->depth - 1; i >=3D 0; i--) {
> +			if (!cs->stack[i].inlined) {
> +				if (exit_name[0] =3D=3D '\0' ||
> +				    (cs->stack[i].name &&
> +				     strcmp(cs->stack[i].name, exit_name) =3D=3D 0)) {
> +					match_idx =3D i;
> +					break;
> +				}
> +			}
> +		}

[ ... ]

> +	/* Close stale callee frames and inactive inlined frames above caller */
> +	while (caller_idx >=3D 0 && cs->depth > caller_idx + 1 + common) {
> +		struct ftrace_stack_frame *top =3D &cs->stack[cs->depth - 1];

[Severity: Medium]
When the function call depth exceeds FTRACE_MAX_STACK, the logic starts
incrementing cs->overflow_depth. If trace events are dropped, this recovery
loop pops stale tracked frames above the caller.

However, since the caller was found in the tracked stack, does this mean all
overflow frames logically must have exited? By only decrementing cs->depth
and failing to reset cs->overflow_depth to 0, could subsequent valid exit
events mistakenly decrement overflow_depth instead of popping their actual
frame from the tracked stack?

> diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
> --- a/tools/perf/util/ftrace.h
> +++ b/tools/perf/util/ftrace.h

[ ... ]

> +struct machine;
> +
>  bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_le=
n, u64 *offset);
>  void ftrace_filter_retaddr(char *str);
> +int ftrace_resolve_inlines(struct machine *machine,
> +			   const char *sym_name, u64 offset,
> +			   const char **inlined_names, int max_inlines);
> +int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *l=
ine, FILE *out);

[Severity: Low]
Does this header file need to explicitly include <stdio.h> to provide the
declaration for the FILE type? Relying on implicit header inclusion can bre=
ak
compilation under musl libc.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016040310.4828=
76-1-atomlin@atomlin.com?part=3D3
