Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA05383C95
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330008; cv=none; b=ol0nIwUdKuky8ZL/IJbz9LkxTU1d5ezWlHL1NGWcciEZZaGu30mh5WIiGDOOFzFoehKxeZA2xPJpE4oY5B5lnosAPCEX9nggou9M2vLKelM2QkUH9fptqkRaUFSQXCKfAvf+q0foavTNO7ouE/13Tw3q4WszkSI4Mfwzf9llfLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330008; c=relaxed/simple;
	bh=R3ju5yu96XEOMNIKYP8uijW0QayJJAQTT5TzUwIHrJE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=O70ifCGOassTBj16x5O6xtapZuzMY3vpoPxOFOLqEkLfUkNSwgucdJiHxVAUrz/vgW6YrxnowF5sxP64jVVR0XbEGfP53bsIAxIOZQpc3MFWlwrm5H08AwXspXTVw7gYSonPkStYl5xh9bgViAdzafvGvWnygXUE4wq7V5WjMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxueqb+z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxueqb+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FD01F0089B;
	Tue,  6 Oct 2026 23:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330006;
	bh=ScBlXllQfuMj8UPmV5zRgTlyH9rDJXrsvUzAprB/mgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hxueqb+zwBQOIyyKsYFcZaWzExv5x+794p2kICE5ebI4izQ5AW3IBQAobjA0aUaEb
	 gXsd7U6Cjqvv/5CVKZpK3QDtB59H1gQT3fwVp3JBcLPEX3RGLFVcpV85XfFtPqGXyi
	 HRaIhGWmwpAifcn0quKhvWUZv59cBt1ZuW6A5B3TSD6iooJV3HvX9qdQqt0Os07c7j
	 4225cquLL7JNLLWD3Q31iJlcJzCt7CPCgcUaUjpLRVPenOsT3Sn2sC+stGd2ICebNo
	 JjDNfqrdC3nvSpMIMT6OemD7KNs3QCmJhSVVO+AlrhLEBTc5ccQCu3UC8P1L9tbgUo
	 Q9vszyJpVxeog==
Message-ID: <sashiko-outbox-162515@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v2 3/4] perf ftrace: Support display of
 inlined functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006232756.65620-4-atomlin@atomlin.com>
References: <20261006232756.65620-1-atomlin@atomlin.com>
 <20261006232756.65620-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 23:40:06 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] perf: fgraph inline tracking fails to close frames if num_inline=
s =3D=3D 0
- [Medium] perf: fgraph stack unwinding fails permanently on dropped trace =
events
- [Low] perf: unmatched exit events erroneously pop active inlined frames
- [Low] perf: memory leak of trace buffers on open failure
- [Low] perf tests: memory leak on inline processing test failure
--

commit d46c8024964e46cbda045d2aa35a4276291e5d25
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support display of inlined functions in function graph tracer

This commit introduces the --inline option to perf ftrace for the
function_graph tracer. It resolves the return address to its inlined
callchain using DWARF debug information and synthesizes intermediate
inlined frames directly into the streamed call graph.

> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
[ ... ]
> @@ -769,6 +774,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  		goto out_reset;
>  	}
> =20
> +	if (perf_ftrace__setup_inlines(ftrace) < 0)
> +		goto out_reset;
> +
>  	setup_pager();
> =20
>  	buf =3D malloc(TRACE_BUF_SIZE);
> @@ -827,9 +835,10 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
[ ... ]
>  	trace_file =3D get_tracing_instance_file("trace_pipe");
>  	if (!trace_file) {
>  		pr_err("failed to open trace_pipe\n");
>  		goto out_reset;
>  	}
> =20
>  	trace_fd =3D open(trace_file, O_RDONLY);
> =20
>  	put_tracing_file(trace_file);
> =20
>  	if (trace_fd < 0) {
>  		pr_err("failed to open trace_pipe\n");
>  		goto out_reset;
>  	}

[Severity: Low]
Does this error path leak the trace buffers?

In __cmd_ftrace(), buf is allocated and linebuf is initialized just before
opening the trace pipe. If get_tracing_instance_file() or open() fails, the
code jumps directly to out_reset, which bypasses the out_close_fd block
where free(buf) and strbuf_release(&linebuf) are called.

> --- a/tools/perf/tests/ftrace.c
> +++ b/tools/perf/tests/ftrace.c
[ ... ]
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
> +		TEST_ASSERT_VAL("contains activate_task entry with inline hint",
> +				strstr(out_buf, "activate_task() { /* (inline) */") !=3D NULL);

[Severity: Low]
Can a failure here leak memory and machine resources during tests?

If TEST_ASSERT_VAL fails, it immediately returns TEST_FAIL. Since
test_inline_processing() allocates ftrace.machine and out_buf, returning
early bypasses free(out_buf) and perf_ftrace__cleanup_inlines(&ftrace).

> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c
[ ... ]
> +	/* Determine which inlined frames are currently open above the caller */
> +	caller_idx =3D -1;
> +	if (num_inlines > 0) {
> +		for (i =3D cs->depth - 1; i >=3D 0; i--) {
> +			if (!cs->stack[i].inlined && cs->stack[i].name &&
> +			    strcmp(cs->stack[i].name, caller_sym) =3D=3D 0) {
> +				caller_idx =3D i;
> +				break;
> +			}
> +		}
> +	}

[Severity: Medium]
Does guarding this loop with if (num_inlines > 0) prevent finding the
caller when a non-inlined function executes?

If a non-inlined function runs, ftrace_resolve_inlines() returns
num_inlines =3D=3D 0. Because of this check, the stack search is skipped and
caller_idx remains -1.=20

As a result, active_inlines evaluates to 0, which bypasses the loop meant
to close stale inlined frames. This causes the new non-inlined function to
be incorrectly pushed to the stack with the extra indentation of the=20
unclosed inlined function, disrupting the call graph hierarchy.

[ ... ]
> +		/* Close all inlined frames above match_idx */
> +		while (cs->depth > 0 && (match_idx < 0 || cs->depth - 1 > match_idx)) {

[Severity: Low]
Can spurious exit events erroneously pop active inlined frames?

If a trace output contains an unmatched or spurious exit event, the stack=20
search finds no matching real frame, leaving match_idx as -1. The condition
(match_idx < 0 || cs->depth - 1 > match_idx) will evaluate to true, which
indiscriminately pops and closes currently active inlined frames from the
top of the stack until it hits a real frame.

> +			if (cs->stack[cs->depth - 1].inlined) {
> +				struct ftrace_stack_frame *top =3D &cs->stack[cs->depth - 1];
> +				int exit_indent =3D top->indent;
> +
> +				if (cs->inlined_depth > 0)
> +					cs->inlined_depth--;
> +				fprintf(out, "%s%*s} /* %s (inline) */\n",
> +					blank_prefix, exit_indent, "", top->name);
> +				free(top->name);
> +				cs->depth--;
> +			} else {
> +				break;
> +			}
> +		}

[Severity: Medium]
Does this loop permanently trap frames if it encounters a dropped trace eve=
nt?

If an exit event for a non-inlined function is dropped (e.g., from a ring
buffer overrun), an orphaned non-inlined frame remains on the stack. When
this unwinding loop hits that orphaned frame (!cs->stack[...].inlined),
it calls break instead of popping it.=20

Because cs->depth doesn't decrease past the orphaned frame, the subsequent
check for the correctly matched real frame fails, leaving both the matched
frame and orphaned frames permanently stuck on the stack until depth is
exhausted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006232756.6562=
0-1-atomlin@atomlin.com?part=3D3
