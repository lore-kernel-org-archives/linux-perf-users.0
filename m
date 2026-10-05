Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4B31578E
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235629; cv=none; b=es92+f+sKd/bitMc4cnLMB1+IVXTsWdWay4PAtemN9okhCevVlZ+I5s0fw3VlrjuPlV/4DdoSBxnTlqwoSavJ0CxwHwEAwhLJMPjyvOzbZdHTI04sJJdweddHL2lmUES/jEOcgOYydFVigYMkw1yGUqGGxpLyCsqKIlyXmlE4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235629; c=relaxed/simple;
	bh=pNGn0EAU2+BRd4r/ayUpZ3hUul3WLizB0t0vtXsFInc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kaBiNxKNmceVjIYf9RC3cik6JBXzWr9BXTTpMDgtxaapmNS0evr06w2/xeXeDS0Kzl7teiy7s8YUp0OcKxWYP/ah0dGiZR/H5xaAC/uXj8O/NPBNNEcwMS6bOaBKoH+SPDxwk2XpgfhBkuhoSFRFLcQhLpnrjERg/haaUpvgstc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnVfcgH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnVfcgH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824CE1F000FF;
	Mon,  5 Oct 2026 21:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791235627;
	bh=eam9q9EVAVJC0xNMIY1y5SiZZd7XbvzABf13wk8YkWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RnVfcgH/L/qEbH7NslqAUoACPIS/l6j4xBN+Y56OG3vwKS6WI1FWIueaoYHL4RAk3
	 kBu87jfLqzlPysrAymGInZSUy6A/aDx/P87+koFLLkV8hL8G+uZiN2LH0PqQp3j1l0
	 iPbS6tzYRzDZ6pkuQRLqvdRJ58Q2VZUaxl1GQ0KyMNaVl2PFPFV/1rNrg6Ox5tpUlq
	 67ZVuGkpoizOHusNDDJqEqKp1hgUi8WC5mRv9y9+XNGA2pDE13RlOgT9ALNkp5sYjC
	 f/s0B4PA8XUTbghE1sFlJd05cOLFn1NKdTm6v1V+r+1TmiaS/uJ9OoFAAUKDKzLtxR
	 +6VlbjGBtJcmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf ftrace: Support display of inlined functions in
 function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005211518.26786-1-atomlin@atomlin.com>
References: <20261005211518.26786-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 21:27:07 +0000
Message-Id: <20261005212707.824CE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf: infinite spinloop on trace EOF in ftrace
- [Medium] perf: infinite parser state growth without funcgraph-tail
--

commit 8997c170e283406995c2dcd46938bbd3757d6735
Author: Aaron Tomlin <atomlin@atomlin.com>
perf ftrace: Support display of inlined functions in function graph tracer

This commit introduces the --inline option to perf ftrace for the function_=
graph
tracer. It resolves return addresses to their inlined callchains and synthe=
sizes
intermediate inlined frames directly into the streamed call graph.

> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> [ ... ]
> @@ -810,11 +829,24 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  			break;
> =20
>  		if (pollfd.revents & POLLIN) {
> -			int n =3D read(trace_fd, buf, sizeof(buf));
> +			int n =3D read(trace_fd, buf, TRACE_BUF_SIZE);
>  			if (n < 0)
>  				break;
> -			if (fwrite(buf, n, 1, stdout) !=3D 1)
> -				break;
> +			if (ftrace->use_inline || ftrace->filter_retaddr) {
> +				for (int i =3D 0; i < n; i++) {

[Severity: Medium]
When the trace_pipe reaches EOF, read() will return 0. The old code handled
this via fwrite() !=3D 1 which broke the poll loop.

With the new logic under --inline or --filter-retaddr, if n =3D=3D 0, the f=
or loop
is skipped and the outer loop doesn't break. Does this cause an infinite
spinloop on poll() when ftrace reaches EOF?

> +					if (buf[i] =3D=3D '\n') {
> +						if (ftrace_process_fgraph_line(ftrace, linebuf.buf, stdout) < 0)
> +							goto out_close_fd;
> +						strbuf_setlen(&linebuf, 0);
> +					} else {
> +						if (strbuf_addch(&linebuf, buf[i]) < 0)
> +							goto out_close_fd;
> +					}
> +				}
> +			} else {
> +				if (fwrite(buf, n, 1, stdout) !=3D 1)
> +					break;
> +			}
>  			/* flush output since stdout is in full buffering mode due to pager */
>  			fflush(stdout);
>  		}
> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> --- /dev/null
> +++ b/tools/perf/util/ftrace.c
> [ ... ]
> +int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *l=
ine, FILE *out)
> +{
> [ ... ]
> +	if (is_exit) {
> +		char exit_name[128];
> +
> +		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
> +
> [ ... ]
> +		/* Close all inlined frames above match_idx */
> +		while (cs->depth > 0 && (match_idx < 0 || cs->depth - 1 > match_idx)) {
> +			if (cs->stack[cs->depth - 1].inlined) {
> [ ... ]
> +				cs->inlined_depth--;
> [ ... ]
> +			} else {
> +				break;
> +			}
> +		}
> +
> +		/* Pop the matched real frame */
> +		if (cs->depth > 0 && !cs->stack[cs->depth - 1].inlined &&
> +		    cs->stack[cs->depth - 1].name &&
> +		    strcmp(cs->stack[cs->depth - 1].name, exit_name) =3D=3D 0) {
> +			free(cs->stack[cs->depth - 1].name);
> +			cs->depth--;
> +		}

[Severity: Medium]
If funcgraph-tail is disabled (the default setting), function exit events l=
ack
the trailing comment containing the function name. This means
extract_exit_func_name() will yield an empty string.

Because exit_name is empty, will strcmp() against the stack frame fail,
preventing the real frame from ever being popped?

> [ ... ]
> +	/* Open new inlined frames */
> +	for (i =3D common; i < num_inlines; i++) {
> +		int entry_indent =3D leading_spaces + cs->inlined_depth * 2;
> +
> +		if (!inlined_names[i]) {
> +			pr_err("Not enough memory\n");
> +			for (int j =3D 0; j < num_inlines; j++)
> +				free((void *)inlined_names[j]);
> +			return -ENOMEM;
> +		}
> +		fprintf(out, "%s%*s%s() { /* (inline) */\n", blank_prefix, entry_inden=
t, "", inlined_names[i]);
> +		if (cs->depth < FTRACE_MAX_STACK) {
> +			cs->stack[cs->depth].name =3D strdup(inlined_names[i]);
> +			if (!cs->stack[cs->depth].name) {
> +				pr_err("Not enough memory\n");
> +				for (int j =3D 0; j < num_inlines; j++)
> +					free((void *)inlined_names[j]);
> +				return -ENOMEM;
> +			}
> +			cs->stack[cs->depth].inlined =3D true;
> +			cs->stack[cs->depth].indent =3D entry_indent;
> +			cs->depth++;
> +		}
> +		cs->inlined_depth++;
> +	}

[Severity: Medium]
If real frames are never popped, FTRACE_MAX_STACK will eventually saturate.=
 Once
cs->depth reaches FTRACE_MAX_STACK, new frames are no longer pushed to the
stack, but cs->inlined_depth continues to unconditionally increment here.

Does this cause infinite indentation growth, since cs->inlined_depth will n=
ever
decrement on exit due to the stuck real frames blocking the popping loop ab=
ove?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005211518.2678=
6-1-atomlin@atomlin.com?part=3D1
