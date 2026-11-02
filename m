Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657493;
	b=31b3GrL/CSerD9p7Har3+NcN/kd5rQB21Ps04lHWrd/gS6VTpYMF0UcI2DKNFm+G9P8o
	 XEjFilBf4k4LCa8bnHN/cnbyREeNrzuShslHmdjhwu/dItBMxb/SPxdlIBp+Q/Q1QPg3K
	 nmosmpUJInyyaSXMvnm5OBOoMSpxMOaKhgn7MvI6k6/A5w2D1DWzUCOZI1l8YzD+BTsmp
	 I9m49BK9pL2JXlqW1jUYZhwfu/youXqYVbUs3/2MF5z8JWybzrE8pj8cT7HxDcQyTBspe
	 8tOoKUiQRi9UlnRw+plede7p50XAYlBA/d0RDVciNmGBG2i/E36KrZerFYkMeaQLP7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657493;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HO5OeKTZlz02ruJkvWUdGjDU3O1WxZRSdVfoYpcyGzQ=;
	b=hJXG1toOlKh1lcFa/p/z/k5UZC0mdLynu7c72o/SibE+d37CB16nx9oKwmszz9/Iul4b
	 N/ryxuULVdVTryru1mDLrQMgT/ds9Yl0YR04AISLj8LvknSBfVeS0xJuwAp3pdM61B+VO
	 vf8Ty2VItYrQsJaVkO/wBdJfl6sfWFXxhlM8ENMHQd5u+QZ8KjVBbQAoihhJb6wz/+ANq
	 GOjMmgpImjgWj605Y+FjjtWfSYu3rgQvpsb+9fpCkEd0b4vRR3XWgF3gJzuo5CRT8Fnas
	 do+4HMoD5mkbXK4mOzMqKdi9ak7SO4TQDvbmB1vrwmhiOQy50HZCpmz3avWxqtkO71Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLV++1jc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36209606A324
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLV++1jc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45A71F00A16;
	Mon,  2 Nov 2026 22:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793657492;
	bh=HO5OeKTZlz02ruJkvWUdGjDU3O1WxZRSdVfoYpcyGzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLV++1jcMZaFNS0FZtV6bv3UZTrhW0sO+mhVRPaAvB+WihDcygOysLhyFJagUEOao
	 Ro5SlySDDIvTBg6tVlyifLkHMkT9ZWIhVSXz+5QSNLmYy7vK8hGHjfTO98CCwOw2We
	 2wZCOX9Fg2spB9KgZMxILB1g4gT2FNAYLhoniwPyMPLj17i/D0E5fnxtERAndB1vxr
	 CzEGTpJBIbSj5zuHlx+ojQik53h/cr+y3Z/GH7ub28JVwl3/St4l8YZ9HEBjxQ4zdO
	 fzjPQmjs+ZYYM094nIMoAwVuoSPF9gNWEbIg3OjzgAtwHGJjpWObFoI/RT/DpSgfKO
	 zlfamTHwvHX9A==
Message-ID: <sashiko-outbox-194261@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v13 10/10] perf ftrace: Filter
 extraneous functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102214054.911298-11-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
 <20261102214054.911298-11-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 22:11:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf ftrace: unmatched IRQ return marker leaked in ftrace_proces=
s_fgraph_line()
- [Medium] perf ftrace: premature orphan_depth reset on nested exit in ftra=
ce_process_fgraph_line()
- [Medium] perf ftrace: ancestor frames discarded on unwind in ftrace_check=
_target_caller()
--

commit b4d5fc80488b4a74cd5c5107f8098d74571146bb
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Filter extraneous functions in function graph tracer

This commit adds per-task target callgraph state tracking and return-address
caller validation in userspace for perf ftrace to suppress unrelated top-le=
vel
functions and detached orphan calls when filtering with -G / --graph-funcs.

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index c2cf4a20553e2..a919307920321 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c

[ ... ]

> @@ -879,6 +1087,208 @@ static int print_line(struct perf_ftrace *ftrace, =
const char *line, FILE *out)

[ ... ]

> +static int ftrace_check_target_caller(struct perf_ftrace *ftrace,
> +				      struct ftrace_task_state *ts,
> +				      const char *func_start,
> +				      const char *entry_name,
> +				      bool is_graph_target,
> +				      int leading_spaces,
> +				      bool has_open_brace,
> +				      bool has_semicolon,
> +				      bool has_retaddr,
> +				      int caller_idx,
> +				      const char *blank_prefix,
> +				      FILE *out,
> +				      bool *is_target_root)
> +{
> +	if (!ftrace_has_graph_funcs(ftrace) || !ts->in_target ||
> +	    ts->depth <=3D ts->target_root_depth)
> +		return 0;
> +
> +	if (has_retaddr && caller_idx >=3D 0 && caller_idx < ts->target_root_de=
pth) {
> +		ftrace_unwind_to_depth(ts, caller_idx + 1, blank_prefix, out);
> +		if (is_graph_target) {
> +			ftrace_reset_to_target_root(ts, entry_name, ts->depth,
> +						    leading_spaces);
> +			*is_target_root =3D true;
> +			return 0;
> +		}
> +		reset_target_root_state(ts);
> +		if (has_open_brace && !has_semicolon &&
> +		    push_nontarget_frame(ts, func_start, leading_spaces) < 0)
> +			return -ENOMEM;
> +		return 1;
> +	}
> +
> +	if (leading_spaces <=3D ts->target_root_indent) {
> +		ftrace_unwind_to_depth(ts, 0, blank_prefix, out);
> +		if (is_graph_target) {
> +			ftrace_reset_to_target_root(ts, entry_name, 0,
> +						    leading_spaces);
> +			*is_target_root =3D true;
> +			return 0;
> +		}
> +		reset_target_root_state(ts);\n> +		if (has_open_brace && !has_semicolo=
n &&
> +		    push_nontarget_frame(ts, func_start, leading_spaces) < 0)
> +			return -ENOMEM;
> +		return 1;
> +	}

[Severity: Medium]
When recovering from a dropped target root exit in
ftrace_check_target_caller() because leading_spaces <=3D ts->target_root_in=
dent
(with caller_idx < 0, such as when funcgraph-retaddr is unavailable or the
call goes through an untraced wrapper), does calling
ftrace_unwind_to_depth(ts, 0, blank_prefix, out) discard active non-target
ancestor frames below ts->target_root_depth whose indentation is strictly l=
ess
than leading_spaces?

If an outer ancestor was pushed onto ts->stack before the target root enter=
ed,
unwinding all the way to 0 pops that ancestor frame as well. If that ancest=
or
subsequently calls another function or re-enters a target function, caller_=
idx
lookup will fail and suppress inline frame synthesis (--inline) when resolv=
ing
inlines in ftrace_process_fgraph_line():

	if (caller_idx < 0)
		num_inlines =3D 0;

Should this unwind to ts->target_root_depth first and then pop only non-tar=
get
ancestor frames with indent >=3D leading_spaces, matching the exit recovery=
 path
in ftrace_process_fgraph_line()?

> +
> +	if (has_retaddr) {
> +		if (caller_idx < 0) {
> +			if (ts->pending_irq_ent[0] !=3D '\0') {
> +				ts->pending_irq_ent[0] =3D '\0';
> +				ts->suppress_irq_ret =3D true;
> +			}
> +			if (has_open_brace && !has_semicolon) {
> +				ts->orphan_depth =3D 1;
> +				ts->orphan_base_indent =3D leading_spaces;
> +				ts->orphan_seq =3D ts->seq;
> +			}
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * ftrace_process_fgraph_line - Process and output a function graph trac=
e line
>   * @ftrace: Perf ftrace context
> @@ -910,16 +1320,54 @@ int ftrace_process_fgraph_line(struct perf_ftrace =
*ftrace, const char *line, FIL

[ ... ]

>  	if ((!has_filter || ftrace->graph_thresh) && !ftrace->use_inline)
>  		return print_line(ftrace, line, out);
> =20
> +	if (strstr(line, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>") !=3D NULL ||
> +	    strstr(line, "<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D") !=3D NULL) {
> +		bool is_irq_ent =3D (strstr(line, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>") !=
=3D NULL);
> +
> +		if (has_filter && parse_graph_cpu(ftrace, line, &cpu)) {
> +			ts =3D get_cpu_state(ftrace, cpu);
> +			if (ts && ts->in_target && ts->orphan_depth =3D=3D 0) {
> +				if (is_irq_ent) {
> +					if (ts->pending_irq_ent[0] !=3D '\0')
> +						print_line(ftrace, ts->pending_irq_ent, out);
> +					strlcpy(ts->pending_irq_ent, line,
> +						sizeof(ts->pending_irq_ent));
> +					ts->suppress_irq_ret =3D false;
> +				} else {
> +					if (ts->pending_irq_ent[0] !=3D '\0') {
> +						print_line(ftrace, ts->pending_irq_ent, out);
> +						ts->pending_irq_ent[0] =3D '\0';
> +					}
> +					if (ts->suppress_irq_ret)
> +						ts->suppress_irq_ret =3D false;
> +					else
> +						print_line(ftrace, line, out);
> +				}
> +			} else if (ts && !ts->in_target) {
> +				ts->pending_irq_ent[0] =3D '\0';
> +				ts->suppress_irq_ret =3D false;
> +			}
> +		} else if (!has_filter) {
> +			print_line(ftrace, line, out);
> +		}
> +		return 0;
> +	}

[ ... ]

> @@ -950,30 +1398,31 @@ int ftrace_process_fgraph_line(struct perf_ftrace =
*ftrace, const char *line, FIL
> =20
>  		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
> =20
> -		top_indent =3D -1;
> -		for (i =3D ts->depth - 1; i >=3D 0; i--) {
> -			if (!ts->stack[i].inlined) {
> -				top_indent =3D ts->stack[i].indent;
> -				break;
> +		if (ts->orphan_depth > 0) {
> +			if (has_filter && ts->in_target &&
> +			    (leading_spaces <=3D ts->target_root_indent ||
> +			     (ts->orphan_base_indent > 0 &&
> +			      leading_spaces < ts->orphan_base_indent))) {
> +				ts->orphan_depth =3D 0;
> +				ts->orphan_base_indent =3D 0;
> +				ts->orphan_seq =3D 0;
> +			} else {
> +				if (ts->orphan_base_indent > 0 &&
> +				    leading_spaces =3D=3D ts->orphan_base_indent)
> +					ts->orphan_depth =3D 0;
> +				else
> +					ts->orphan_depth--;
> +				if (ts->orphan_depth =3D=3D 0) {
> +					ts->orphan_base_indent =3D 0;
> +					ts->orphan_seq =3D 0;
> +				}
> +				return 0;
>  			}
>  		}

[Severity: Medium]
Can a dropped child entry inside an orphan subtree cause ts->orphan_depth to
reach 0 prematurely in ftrace_process_fgraph_line()?

When an orphan root frame enters at indentation I, ftrace_check_target_call=
er()
sets ts->orphan_depth =3D 1 and ts->orphan_base_indent =3D I. If a nested c=
hild
inside that orphan subtree at indentation > I has its entry event dropped by
the ring buffer, ts->orphan_depth remains 1.

When that nested child exits with leading_spaces > ts->orphan_base_indent, =
the
else branch decrements ts->orphan_depth from 1 to 0 and clears
ts->orphan_base_indent =3D 0, even though leading_spaces > ts->orphan_base_=
indent
indicates execution is still deeper than the outermost orphan frame. Could
subsequent calls or exits within the still-active outer orphan frame then l=
eak
into the output or pop active target frames?

[ ... ]

> @@ -1083,9 +1551,166 @@ int ftrace_process_fgraph_line(struct perf_ftrace=
 *ftrace, const char *line, FIL

[ ... ]

> +		if (ts->orphan_depth > 0) {
> +			if (has_open_brace && !has_semicolon) {
> +				ts->orphan_depth++;
> +				ts->orphan_seq =3D ts->seq;
> +			}
> +			return 0;
> +		}
> +	}
> +
> +	ts->suppress_irq_ret =3D false;

[Severity: Medium]
If an interrupt section contains more than one top-level orphan call between
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> and <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D (for ex=
ample, when an untraced interrupt entry
sequentially invokes irq_enter_rcu(), the interrupt handler, and
irq_exit_rcu()), will this unconditional reset of ts->suppress_irq_ret =3D =
false
in ftrace_process_fgraph_line() leak a dangling <=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D marker?

On the first orphan call after =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>, ftrace_chec=
k_target_caller() sees
ts->pending_irq_ent[0] !=3D '\0', clears ts->pending_irq_ent[0] =3D '\0', a=
nd sets
ts->suppress_irq_ret =3D true.

Once that first orphan call finishes (either immediately if it is a leaf ca=
ll,
or when its closing brace returns ts->orphan_depth to 0), the entry of the
second top-level orphan call reaches:

	ts->suppress_irq_ret =3D false;

before calling ftrace_check_target_caller(). Because ts->pending_irq_ent[0]=
 is
already '\0', ftrace_check_target_caller() suppresses the second orphan call
without setting ts->suppress_irq_ret back to true, causing the subsequent
<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D line to be printed without a matching openi=
ng marker.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102214054.9112=
98-1-atomlin@atomlin.com?part=3D10
