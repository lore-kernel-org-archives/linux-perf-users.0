Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C7334D915
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792292133; cv=none; b=sli6v4nk5ppsBXE8B5lDrZ5woUgm8Z5srkhpdidA0krIYJjykLGYTtZXGrE7KUmC1R825pFC3c+u5MOOoLeU5Z9Ro+LfRTfy4td+GoSJQGpXISvTFbbAbBw6Yf7ahLJpQDjnra429yQM/a9M/8AyY3Kqs9UT+CFLBto242La88g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792292133; c=relaxed/simple;
	bh=9kxy4B5fptD06SHTehdiWRkEWDXTONMy1pcXElsh44Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=d6kVM9ymA6HgrtX0+WK03ZSH/yzPLor5Vx7MZ8no9/Qcb/dkTr01wkhsFJnBA51xMQH7r9cvLY0WNAIr9ROydTpZ6C5T/VznpwmWT5/v9ZMgEihgvX15KoDznbr/sX9gEHz+b1DN+RzxsnIKhNQXXDe3uL/AVemgnKwfFlt3MKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8vKeLzb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8vKeLzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720C81F000C4;
	Sun, 18 Oct 2026 02:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792292131;
	bh=2PoRd5TcZd+g66nHHr+E83xUXSzlWFtcj7CatVVvkXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G8vKeLzb3u2CtEbuct0Mo+tpkgoWf2tjmayu/OT3iPenxo8DSrwzcy8plWseEiaK/
	 onQhYAc7S/Pp6ZxYYI1/3bZ+27X1ZkfookEm9RnzHEkwcf3NHx0jRBarhRjdB/OQLi
	 efeE/6DAQ+2miRarAaTA/3P11vz23lhVD5+nn/V4mB091YeIDqX38ecqrWHOFF7rYJ
	 UNIhk8+3gFggfayLTWjSwqkMAvpoXlOQ9OJ4MyVszh47kJFzlNYWUkd99fGRv+KPCt
	 V0aEl8DjYQGaHpP5RIuthUQBjwrtW2pOq9aozl/FhajkHOpGZVz+9jODX4GXyjQp2n
	 UEtpyeXoWOTNg==
Message-ID: <sashiko-outbox-175897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v8 6/6] perf ftrace: Filter extraneous
 functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018023753.584873-7-atomlin@atomlin.com>
References: <20261018023753.584873-1-atomlin@atomlin.com>
 <20261018023753.584873-7-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 02:55:31 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Medium] perf ftrace: funcgraph-retaddr not enabled for -G in cmd_ftrace()
- [Medium] perf ftrace: premature inline frame unwind in ftrace_process_fgr=
aph_line()
- [Medium] perf ftrace: inlines skew target_root_depth in ftrace_process_fg=
raph_line()
- [Medium] perf ftrace: non-target exit lines leaked in ftrace_process_fgra=
ph_line()
- [Medium] perf ftrace: ftrace_process_fgraph_line() treats ancestor caller=
s as orphans
- [Medium] perf tests ftrace: hardcoded vmlinux offset in test_graph_target=
_filter()
--

commit eca2ef148505a6e43726e07f9ad0e28ae131e40c
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Filter extraneous functions in function graph tracer

This commit adds userspace callgraph tracking and return-address provenance
filtering to perf ftrace so that top-level functions outside -G /
--graph-funcs targets and detached orphan subtrees inside target callgraphs
are suppressed. It also switches the per-task call stack to grow
dynamically and adds regression tests in tools/perf/tests/ftrace.c.

> diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
> index d83dee5a050dd..4c70951fd0c0c 100644
> --- a/tools/perf/tests/ftrace.c
> +++ b/tools/perf/tests/ftrace.c
> @@ -581,6 +581,939 @@ static int test_context_switch_handling(void)

[ ... ]

> +	vmlinux =3D vmlinux_path__find();
> +
> +	/* 6. Test targeted leaf call with synthesized DWARF inlines closing an=
d resetting filter */
> +	if (vmlinux) {
> +		symbol_conf.vmlinux_name =3D vmlinux;
> +		symbol_conf.ignore_vmlinux_buildid =3D true;
> +		if (perf_ftrace__setup_inlines(&ftrace) =3D=3D 0 && ftrace.machine) {
> +			out =3D open_memstream(&out_buf, &out_len);
> +			if (!out) {
> +				perf_ftrace__cleanup_inlines(&ftrace);
> +				ret =3D TEST_FAIL;
> +				goto out_free_filter;
> +			}
> +
> +			ftrace_process_fgraph_line(&ftrace,
> +				" 0)               |  wake_up_new_task() {", out);
> +			/* Targeted leaf with caller having inline activate_task */
> +			ftrace_process_fgraph_line(&ftrace,
> +				" 0)   1.500 us    |    enqueue_task(); /* <-wake_up_new_task+0x1d1/=
0x3e0 */",
> +				out);
> +			/* Sibling call after targeted leaf */
> +			ftrace_process_fgraph_line(&ftrace,
> +				" 0)   1.000 us    |    check_preempt_curr(); /* <-wake_up_new_task+=
0x0/0x3e0 */",
> +				out);
> +			ftrace_process_fgraph_line(&ftrace,
> +				" 0)   2.500 us    |  } /* wake_up_new_task */", out);
> +
> +			fclose(out);
> +			ftrace_cpu_states__clear();
> +			perf_ftrace__cleanup_inlines(&ftrace);
> +
> +			if (!strstr(out_buf, "enqueue_task();")) {
> +				pr_debug("FAILED: targeted leaf enqueue_task missing\n");
> +				ret =3D TEST_FAIL;
> +				goto out_free_filter;
> +			}
> +			if (!strstr(out_buf, "} /* activate_task (inline) */")) {
> +				pr_debug("FAILED: inline activate_task not closed after leaf target\=
n");
> +				ret =3D TEST_FAIL;
> +				goto out_free_filter;
> +			}

[Severity: Medium]
In test_graph_target_filter(), when vmlinux_path__find() finds a host
vmlinux image, perf_ftrace__setup_inlines() loads that binary regardless of
architecture, compiler, Kconfig, or whether DWARF debug info is present.

The test then passes the hardcoded return address offset
wake_up_new_task+0x1d1/0x3e0 to ftrace_process_fgraph_line() and returns
TEST_FAIL if out_buf does not contain "} /* activate_task (inline) */".

Won't this cause perf test to fail on any system with a readable vmlinux
where wake_up_new_task+0x1d1 does not resolve via DWARF to an inlined
activate_task() frame?

[ ... ]

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index 66c19116ee64e..26fc5b83b7b41 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c

[ ... ]

> @@ -586,28 +675,49 @@ int ftrace_process_fgraph_line(struct perf_ftrace *=
ftrace, const char *line, FIL
> =20
>  		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
> =20
> -		/* Find matching frame on stack */
> +		if (cs->orphan_depth > 0) {
> +			/*
> +			 * If an orphan exit was dropped by the kernel ring buffer,
> +			 * and the target root function itself exits with its named
> +			 * closing brace, the orphan has definitively ended. Clear
> +			 * stale orphan_depth and proceed with matching the target root.
> +			 * Otherwise, all exits (bare or callee names) belong to the orphan.
> +			 */
> +			if (has_filter && cs->in_target && exit_name[0] !=3D '\0' &&
> +			    cs->target_root_depth < cs->depth &&
> +			    cs->stack[cs->target_root_depth].name &&
> +			    strcmp(cs->stack[cs->target_root_depth].name, exit_name) =3D=3D 0=
) {
> +				cs->orphan_depth =3D 0;
> +			} else {
> +				cs->orphan_depth--;
> +				return 0;
> +			}
> +		}

[Severity: Medium]
In ftrace_process_fgraph_line(), this dropped-orphan exit recovery check
compares exit_name against cs->stack[cs->target_root_depth].name.

However, when a target root function enters at depth > 0 with
ftrace->use_inline enabled and its caller has inlined frames,
ftrace_process_fgraph_line() sets cs->target_root_depth before pushing the
synthesized inlined frames onto cs->stack:

	if (is_target_root)
		cs->target_root_depth =3D cs->depth;

	/* Open new inlined frames */
	for (i =3D common; i < num_inlines; i++) {
		...
		cs->stack[cs->depth].name =3D strdup(inlined_names[i]);
		...
		cs->stack[cs->depth].inlined =3D true;
		cs->stack[cs->depth].indent =3D entry_indent;
		cs->depth++;
		cs->inlined_depth++;
	}

The non-inlined target root frame is then pushed above those synthesized
frames, leaving cs->stack[cs->target_root_depth].name holding the outermost
inlined caller frame's name rather than the target root function's name.

If an orphan call's exit event is dropped in this state and the target root
subsequently exits with its named closing brace, won't this strcmp() fail to
match exit_name, causing the target root's exit to be swallowed as part of
the orphan?

[ ... ]

> @@ -639,9 +750,36 @@ int ftrace_process_fgraph_line(struct perf_ftrace *f=
trace, const char *line, FIL
>  			extra_indent =3D 0;
>  		}
> =20
> -		fprintf(out, "%.*s%*s%s\n",
> -			(int)(pipe_char - line + 1), line,
> -			leading_spaces + extra_indent, "", func_start);
> +		if (!has_filter || cs->in_target) {
> +			if (!ftrace->use_inline) {
> +				print_line(ftrace, line, out);
> +			} else {
> +				fprintf(out, "%.*s%*s%s\n",
> +					(int)(pipe_char - line + 1), line,
> +					leading_spaces + extra_indent, "", func_start);
> +			}
> +		}

[Severity: Medium]
Suppose an outer non-target function enters at depth 0 (stored in
cs->stack[0] with its entry line suppressed) and calls a target function at
depth 1 (cs->target_root_depth =3D 1, cs->in_target =3D true).

If the target function's exit event is dropped by the ring buffer and the
outer function exits with "} /* outer_func */", match_idx is 0 (which is
less than cs->target_root_depth) and cs->depth is unwound to 0. Similarly,
if an unmatched named exit arrives while cs->in_target is true, match_idx
is -1.

Because ftrace_process_fgraph_line() prints the exit line whenever
cs->in_target is true before checking whether cs->depth <=3D
cs->target_root_depth, won't this leak the closing brace line for the
suppressed ancestor (or unmatched function) into the output?

> +
> +		if (has_filter && cs->in_target) {
> +			while (cs->depth > cs->target_root_depth &&
> +			       cs->stack[cs->depth - 1].inlined) {
> +				struct ftrace_stack_frame *top =3D &cs->stack[cs->depth - 1];
> +				int exit_indent =3D top->indent;
> +
> +				if (cs->inlined_depth > 0)
> +					cs->inlined_depth--;
> +				fprintf(out, "%s%*s} /* %s (inline) */\n",
> +					blank_prefix, exit_indent, "", top->name);
> +				free(top->name);
> +				cs->depth--;
> +			}
> +
> +			if (cs->depth <=3D cs->target_root_depth) {
> +				cs->in_target =3D false;
> +				cs->target_root_depth =3D 0;
> +				cs->orphan_depth =3D 0;
> +			}
> +		}
>  		return 0;
>  	}

[Severity: Medium]
When both -G (has_filter) and --inline (ftrace->use_inline) are active and a
non-leaf child function is called from within a synthesized inlined scope
inside the target callgraph, the stack holds the caller's .inlined =3D true
frame(s) followed by the child callee's .inlined =3D false frame.

When that child callee exits, its real frame is popped above, leaving the
caller's still-active .inlined frame(s) at cs->stack[cs->depth - 1] with
cs->depth > cs->target_root_depth.

Doesn't this while loop run unconditionally on every exit event inside the
target callgraph, prematurely popping and printing "} /* ... (inline) */"
for the caller's active inlined frames whenever a child function returns
(and then re-opening them on the next sibling call)?

[ ... ]

> +	if (!ftrace->use_inline) {
> +		if (is_target_root) {
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
> +				if (caller_idx >=3D 0) {
> +					while (cs->depth > caller_idx + 1) {
> +						free(cs->stack[cs->depth - 1].name);
> +						cs->depth--;
> +					}
> +				}
> +			}
> +			cs->target_root_depth =3D cs->depth;
> +		}
> +
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
> +			}
> +		}

[Severity: Medium]
In the !ftrace->use_inline path (as well as the dropped-orphan recovery
above), ftrace_process_fgraph_line() relies on ftrace_parse_retaddr()
finding return address comments in the trace stream to suppress detached
orphan calls and synchronize target_root_depth.

However, in tools/perf/builtin-ftrace.c, set_tracing_funcgraph_retaddr()
only enables funcgraph-retaddr when ftrace->graph_retaddr or
ftrace->use_inline is set:

static int set_tracing_funcgraph_retaddr(struct perf_ftrace *ftrace)
{
	if (ftrace->graph_retaddr || ftrace->use_inline) {
		if (write_tracing_option_file("funcgraph-retaddr", "1") < 0) {

and cmd_ftrace() only sets ftrace.filter_retaddr =3D true when
ftrace.use_inline && !ftrace.graph_retaddr:

		if (!ftrace.filter_retaddr_set) {
			if (ftrace.use_inline && !ftrace.graph_retaddr)
				ftrace.filter_retaddr =3D true;
			else
				ftrace.filter_retaddr =3D false;
		}

When a user runs perf ftrace -G <func> without --inline or --graph-opts
retaddr, funcgraph-retaddr is disabled in tracefs, so ftrace_parse_retaddr()
always returns false. Should builtin-ftrace.c also enable funcgraph-retaddr
(and filter_retaddr when !ftrace.graph_retaddr) when ftrace.graph_funcs is
non-empty?

[ ... ]

> @@ -675,6 +950,21 @@ int ftrace_process_fgraph_line(struct perf_ftrace *f=
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
What happens if a target function enters at a nested depth
(cs->target_root_depth > 0, beneath a suppressed outer ancestor on
cs->stack), and the target root's exit event is dropped by the ring buffer?

When the outer ancestor subsequently makes another function call,
caller_idx resolves to that ancestor's frame on cs->stack (0 <=3D caller_id=
x <
cs->target_root_depth), proving the target root has already returned.

Because both this check in the ftrace->use_inline path and the corresponding
check in the !ftrace->use_inline path test caller_idx <
cs->target_root_depth instead of caller_idx < 0, they treat the ancestor's
subsequent call as a detached orphan and return early without unwinding the
stale target frames or resetting cs->in_target.

Should 0 <=3D caller_idx < cs->target_root_depth unwind the completed target
frames down to caller_idx + 1 and reset cs->in_target before evaluating the
new entry?

[ ... ]

> @@ -708,13 +995,17 @@ int ftrace_process_fgraph_line(struct perf_ftrace *=
ftrace, const char *line, FIL
> =20
>  			if (cs->inlined_depth > 0)
>  				cs->inlined_depth--;
> -			fprintf(out, "%s%*s} /* %s (inline) */\n",
> -				blank_prefix, exit_indent, "", top->name);
> +			if (!has_filter || (cs->in_target && !is_target_root))
> +				fprintf(out, "%s%*s} /* %s (inline) */\n",
> +					blank_prefix, exit_indent, "", top->name);
>  		}
>  		free(top->name);
>  		cs->depth--;
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018023753.5848=
73-1-atomlin@atomlin.com?part=3D6
