Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4269817A586
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765476; cv=none; b=CFar0zO/J5A/dGAaD2aNWFekBAuZ79O3cmOF45tyEBPoAbcpPLKNnYovwBSiwX4pBSBtPg3R/DDZY1sCGUisp4NbWGmRriXaESxGAyNqjU+PdnQjxroqJcvf3ks+5gryD16MMlsU+E2XoLO5sAPv2MhZmzuRLjfniAI+9d2usYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765476; c=relaxed/simple;
	bh=nqViFMVF3cIwx9QTsjl+g+Bd9rzv2I+EdktKc0VY3aE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lBpM1HFIJMFgL4/fKrjSFKPvWGVa94KIBYIIjAo0gfeQS1GPvVX97Q2hY0wAfpoW+r9hUzn67ZvCk6QtqwUjzPjgUyS8hTiQWkenV/m7AN1SM+luTZXiCpCDI3PstZCaus1AbbHPtZkVqicD4a9QA456SPOEqGfwaJhV/o9fbKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkYcCBjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkYcCBjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6701F0089B;
	Mon, 12 Oct 2026 00:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791765474;
	bh=d7OznAYWuE3z+kHyQN8BJmgemOFJ4aJg6wEPzRxJ4C4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gkYcCBjL7gQIILcKQtphHKVuCimA8c6UW5es4s3C30jlgO6Sr5WbuHfV6kAZbqySP
	 UdvTdrYy9EKBm8t6P+Cav6ZcQOAr9xcfq0NK6F+MTYj0EcDwxYBK4j0bk0VKw8gBUQ
	 URlRQePyDBOZzZqzxPz4gj25aKfbJA3C/Q7GeeTumw3DuO/Nwqf4naj11pfJEWTR2e
	 q71zzQjVazSH8Gg/0FaSS4AUOFdWMAfuDBzr7DejRdIBAKQ8Mq55L6D65//a2yAvXa
	 wVKksUenA5gJnCBaz7ZWtE2wmXCHR/Yen6k/nifnv754tZCbTCif4dnR5dBg5bLC6N
	 6R5qOVUaoirNQ==
Message-ID: <sashiko-outbox-167526@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v3 5/5] perf ftrace: Filter extraneous
 functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012003016.263063-6-atomlin@atomlin.com>
References: <20261012003016.263063-1-atomlin@atomlin.com>
 <20261012003016.263063-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 00:37:54 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf ftrace: Target filter state leaks for leaf functions at non=
-zero depth
--

commit 1481567e7a5dda207ce5b61e39c1b59803ca97c4
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Filter extraneous functions in function graph tracer

This commit enhances perf ftrace to filter out extraneous top-level functio=
ns
and detached orphan calls from the function graph output when using a target
filter.

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index 5cae01a28529f..96a41077dccbf 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c

[ ... ]

> @@ -509,6 +564,92 @@ int ftrace_process_fgraph_line(struct perf_ftrace *f=
trace, const char *line, FIL
>  	has_open_brace =3D (strchr(func_start, '{') !=3D NULL);
>  	has_semicolon =3D (strchr(func_start, ';') !=3D NULL);
> =20

[ ... ]

> +		print_line(ftrace, line, out);
> +		if (has_filter && cs->in_target && cs->depth =3D=3D 0 &&
> +		    has_semicolon && !has_open_brace) {
> +			cs->in_target =3D false;
> +			cs->orphan_depth =3D 0;
> +		}
> +		return 0;
> +	}

[Severity: Medium]
When a targeted function is a leaf call (no braces, only a semicolon) and
occurs at a call stack depth greater than 0, doesn't the hardcoded check for
cs->depth =3D=3D 0 prevent the filter state from resetting?

It appears that cs->in_target will remain true indefinitely if the target is
not at the root depth, causing subsequent non-targeted sibling functions and
their descendants within the same parent frame to bypass the filter and
incorrectly appear in the trace output.

[ ... ]

> @@ -645,6 +801,12 @@ int ftrace_process_fgraph_line(struct perf_ftrace *f=
trace, const char *line, FIL
>  		}
>  	}
> =20
> +	if (has_filter && cs->in_target && cs->depth =3D=3D 0 &&
> +	    has_semicolon && !has_open_brace) {
> +		cs->in_target =3D false;
> +		cs->orphan_depth =3D 0;
> +	}
> +
>  	for (i =3D 0; i < num_inlines; i++)
>  		free((void *)inlined_names[i]);
>  	return 0;

[Severity: Medium]
The identical logic exists here for the use_inline code path. Should these
checks verify cs->depth =3D=3D cs->target_root_depth instead of cs->depth =
=3D=3D 0
to properly reset the filter for leaf targets at non-zero depths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012003016.2630=
63-1-atomlin@atomlin.com?part=3D5
