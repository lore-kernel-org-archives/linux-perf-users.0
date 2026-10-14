Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB434EDCC3
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995261; cv=none; b=pg+Qx0exfoGlhtSFK9XS6CCvhOl+rd+LC9q6gJufOVsx6kbmztqH3/KlzXmpwoup2BBlV/FdSkG1YBNxZEuo8pMhTEYJPQfar+l36aMDefRLMwPxjzq3iuc+fao9qS7LD0Z0WMBdKWhkpf+ipvvMpjLYLdxq13w40596XgnQFoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995261; c=relaxed/simple;
	bh=L1zBF/wczZQRBQZAihcHAWvpg2v2K2etWVwJvGFF8Xc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qh/wZkXM81tMiEQPzTyBWxCFeB3JeUNbD3zFE8r2phaBr7Zuk3W+2+Ya41xV3GEbSoMxvBg8UnbJggGSUrIs6oO+iOCzIW8EtxG5HOVwTwtZ88kW3Q3MyQOjIIMJAj7+T3RSenziRRyz2GRyVeMdfr0mIzuTQWJ4h9VDTyh68VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYoJ0w+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYoJ0w+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CB61F000C4;
	Wed, 14 Oct 2026 16:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791995259;
	bh=lT/Sk0W3vxBcCNbnquWN4H1IN89muizBriz6C4cCJ3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jYoJ0w+DBUQujxSHol05L9E0ZyMVtAcFW5C0xpWAbHdnGHhv1BMI5tacR/3zfAJ58
	 5owSDVe3UFIL/5zxz6Jv8PQLSj2cpsHaMGaD4pGDfg92iv9PQdEBJ6Phs2RURs3v4m
	 VcdJNXo3lhP3RKM/xqeSmH2vjJ0/8hl1J0lzwQ3S7F/mbiVSorriHcSrO2ucMWJ+lw
	 v8UyjX4bKtPpfr6ypSbvBNg1hsqXX8KoZtwr0SgLzYMnz+xKs9Y76Ad25puyEo34Fa
	 9JjYkVeGPSSN4l71WSoyW155kvNA66tZGZ0H1yPqtf86jNAt9qeD6TpjTZsVakswaD
	 y+pYgY04HVfxQ==
Message-ID: <sashiko-outbox-171531@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v4 3/5] perf ftrace: Support display of
 inlined functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261014161457.373253-4-atomlin@atomlin.com>
References: <20261014161457.373253-1-atomlin@atomlin.com>
 <20261014161457.373253-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 16:27:39 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf: buffer overflow in make_blank_prefix() due to unclamped lo=
op bounds
- [Medium] perf ftrace: parser stack desynchronization on FTRACE_MAX_STACK =
saturation
- [Low] perf/ftrace: stale real frames prevent inactive inlines from being =
popped
--

commit 74f9ce28f357fc14d2ef1925d4b8504c439b4901
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support display of inlined functions in function graph tracer

This commit introduces the --inline option to perf ftrace for the
function_graph tracer. It leverages DWARF debug information from the
kernel image to resolve return addresses to their inlined callchains and
synthesizes intermediate frames directly into the streamed call graph.

diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
[ ... ]
> +static void make_blank_prefix(const struct perf_ftrace *ftrace, const ch=
ar *line,
> +			      const char *pipe_char, char *buf, size_t size)
> +{
> +	size_t len =3D pipe_char - line + 1;
> +	const char *start_delim =3D NULL;
> +	char *c;
> +
> +	if (len >=3D size)
> +		len =3D size - 1;
> +
> +	memcpy(buf, line, len);
> +	buf[len] =3D '\0';
> +
> +	if (*pipe_char =3D=3D '|') {
[ ... ]
> +		if (start_delim && start_delim < pipe_char) {
> +			for (c =3D buf + (start_delim - line) + 1; c < buf + (pipe_char - lin=
e); c++)
> +				*c =3D ' ';

[Severity: Medium]
Does this code overflow the buf array?

The buf array is populated from a fixed 128-byte array (blank_prefix) in the
caller. The earlier memcpy is safely clamped to size - 1, but this loop bou=
nd
uses the unclamped distance pipe_char - line.

If a trace line has an exceptionally long prefix (such as from a long comm
string or malformed input), could pipe_char - line exceed the buffer size a=
nd
cause out-of-bounds writes on the stack?

> +		}
> +	}
> +}
[ ... ]
> +int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *l=
ine, FILE *out)
> +{
[ ... ]
> +	if (is_exit) {
> +		char exit_name[128];
> +
> +		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
> +
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

[Severity: Medium]
Can this cause parser stack desynchronization on deep call stacks?

If a trace contains more than FTRACE_MAX_STACK (256) nested frames, the
push logic correctly drops them to prevent overflowing the stack tracking.
However, when these untracked frames exit, their trace lines often contain
bare closing braces, which results in exit_name[0] =3D=3D '\0'.

Will this unconditionally match the topmost valid non-inlined frame on the
stack and pop it prematurely, permanently desynchronizing the stack state
and breaking inline resolution for subsequent callers?

[ ... ]
> +	/* Close inlined frames that are no longer active */
> +	while (active_inlines > common && cs->depth > 0) {
> +		if (cs->stack[cs->depth - 1].inlined) {
> +			struct ftrace_stack_frame *top =3D &cs->stack[cs->depth - 1];
> +			int exit_indent =3D top->indent;
> +
> +			if (cs->inlined_depth > 0)
> +				cs->inlined_depth--;
> +			fprintf(out, "%s%*s} /* %s (inline) */\n",
> +				blank_prefix, exit_indent, "", top->name);
> +			free(top->name);
> +			cs->depth--;
> +			active_inlines--;
> +		} else {
> +			break;
> +		}
> +	}

[Severity: Low]
Can stale real frames prevent inactive inlined frames from being popped?

If a function exit event is dropped (for example, due to a ring buffer
overwrite), the corresponding real frame remains on the stack. When the next
entry event is processed and we attempt to close inactive inlined frames ab=
ove
the caller, the loop breaks immediately upon encountering this stale real f=
rame.

Does this leave the inactive inlines stuck on the stack, corrupting the
nesting and indentation of subsequent call graph output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014161457.3732=
53-1-atomlin@atomlin.com?part=3D3
