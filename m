Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F64404BC4
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995193; cv=none; b=ThsSXSinnxNnPu8WrIcbWU3VEVM8ekkHj8GOKem8zcfVzLZNs1zS4TYcJXg6fVDvZStu+IxXqpFT0wTG9QMD6/T8vjkJlnH/WdQK6+toCN9iddL8WQfdANtB6Ic6A46YRQhu2YsUxLnvp7OgFR8Mgij8wCVaD8yWarIHrhskC+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995193; c=relaxed/simple;
	bh=+uMURrspfsBH7EQ9mXiCL6nyfQ0sj5YfwB1vct481+o=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TFr4Esvn56TD9DninILN6NKXJ0nh3dnWO3SSq0aYY7jAp6azx5aoOUVJ6ZYsB0cQ8FonDpAyPJ6LVvMjSfUcnsgTDKnLVmiHKsvpB0k5S9MsUZrkQDhmUVZx7SBe4LO3o/1OffahiNR7osN3J65nODUN5EqQtvYlbFpEn9IF7VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N41aj6a0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N41aj6a0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3B91F000C4;
	Wed, 14 Oct 2026 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791995192;
	bh=JyY8Ot4Rhg05YOqBPo5mSTy0a3OZDkl9/0cKwzpSj4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N41aj6a0tolJVB/WvDQQGFBR4wSSR5+VGFDq2C5+j1gHgq8/220X7f2YiNCOGqvd4
	 fJz5Aa1u5yxUFy1Mo03fvUfmBqKpccpnd4F8XM87I5/MBpgWpUwgI57R9+pvVPYLc9
	 Wpe03uLnw5eHSinbiqcMJuWOXu3D4aj25ambQW+o6HhsxCeupIMM/SU0zNOrfsUdjn
	 p134Liuil3fXdsiptywFxfQZvObEYGZgCCCmQP35Jhxr4tbNKDadShRC6WziMU1JFE
	 pXZ3jfN2sw2HViPcRJvxIsHhQQ/Xt2mBzuwkKTVijur20WlUplrSamKkCRANHT+yBe
	 F77QYy3YKIJwA==
Message-ID: <sashiko-outbox-171529@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v4 5/5] perf ftrace: Filter extraneous
 functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261014161457.373253-6-atomlin@atomlin.com>
References: <20261014161457.373253-1-atomlin@atomlin.com>
 <20261014161457.373253-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 16:26:31 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf/ftrace: filter state leak on leaf functions with inlines
- [Medium] perf: stack buffer overflow in make_blank_prefix()
--

commit 5c319821fcd67517723413eff78ea02ad9a706a1
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Filter extraneous functions in function graph tracer

This commit introduces a mechanism to track active callgraph state per CPU =
in
the perf ftrace function graph tracer. It suppresses unrelated top-level
functions and detached orphan calls from the trace output when using a
targeted filter.

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c

[ ... ]

> @@ -443,8 +479,9 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ft=
race, const char *line, FIL
>  	bool has_open_brace;
>  	bool has_semicolon;
>  	bool has_retaddr =3D false;
> +	bool has_filter =3D ftrace_has_graph_funcs(ftrace);
> =20
> -	if (!ftrace->use_inline)
> +	if (!has_filter && !ftrace->use_inline)
>  		return print_line(ftrace, line, out);
> =20
>  	pipe_char =3D find_func_column(ftrace, line, &cpu);

[Severity: Medium]
Shortly after this in ftrace_process_fgraph_line(), make_blank_prefix() is
called and provided with the 128-byte blank_prefix array from the stack:

    if (start_delim && start_delim < pipe_char) {
        for (c =3D buf + (start_delim - line) + 1; c < buf + (pipe_char - l=
ine); c++)
            *c =3D ' ';
    }

Can this loop in make_blank_prefix() write out of bounds?

The loop blindly writes space characters up to buf + (pipe_char - line). If
the trace line prefix before pipe_char exceeds 128 characters, it appears
this will write past the end of the blank_prefix stack buffer without
clamping to the size of the destination.

[ ... ]

> @@ -549,6 +691,21 @@ int ftrace_process_fgraph_line(struct perf_ftrace *f=
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
> +

[Severity: Medium]
Because cs->depth is inflated by the inline frames for a leaf target functi=
on,
the filter state check later on fails and leaves cs->in_target set to true.

When that happens, does this block cause subsequent sibling functions to
incorrectly return early, entirely skipping the logic that would normally
close the stale inline frames?

[ ... ]

> @@ -659,6 +816,13 @@ int ftrace_process_fgraph_line(struct perf_ftrace *f=
trace, const char *line, FIL
>  		}
>  	}
> =20
> +	if (has_filter && cs->in_target && cs->depth <=3D cs->target_root_depth=
 &&
> +	    has_semicolon && !has_open_brace) {
> +		cs->in_target =3D false;
> +		cs->target_root_depth =3D 0;
> +		cs->orphan_depth =3D 0;
> +	}
> +
>  	for (i =3D 0; i < num_inlines; i++)
>  		free((void *)inlined_names[i]);
>  	return 0;

[Severity: Medium]
Does this reset condition fail for leaf functions when ftrace->use_inline is
true?

If a targeted leaf function resolves to inline frames,
ftrace_process_fgraph_line() pushes the inline frames onto cs->stack and
increments cs->depth. Because cs->depth is inflated by num_inlines, the
check against cs->target_root_depth will be false, leaving in_target
permanently true for leaf calls with inlines.

Could this leak the filter state, causing subsequent sibling functions to be
incorrectly evaluated as being inside the target graph, leading to malformed
or missing trace lines?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014161457.3732=
53-1-atomlin@atomlin.com?part=3D5
