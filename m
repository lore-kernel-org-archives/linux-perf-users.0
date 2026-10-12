Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022B17A586
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 00:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765507; cv=none; b=eEGXMnEVi9x2m5KUWnrHptfSWafiWM68So1mrqjfUwYGyRw5gjH5rAulcpIeCTncx6lICf2ow3tO1kNoC8Jakbrb+EI2uQ+BustlJ6eRRPqUOajWnSR5DpmlMKNdQocL9G3aRizzJOuDO19rBMn/hZdVPJLyZzlAqsnX0RUyx68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765507; c=relaxed/simple;
	bh=sVzCb7fveuFGKH+MpeULQXzeKKC6k9UzmafBx+wovzM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DHOBjsIAsdxNpfiKMFhvQ4QxWr4RrPKZdZ8MVi8DwXOputLPqv9VYw2xVOaPPGFYnVUVO25PCAy4Xn1SAS+j+lEnepfrptcuHRo8XVwNS9M8yb0KRKi3uHuMA1IRDsZtpJIm/05DviBlAKDanwjnomO5t/nqW/9CsPzY/GVuxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaMC5pAo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaMC5pAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D16D1F0089B;
	Mon, 12 Oct 2026 00:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791765505;
	bh=LWrFYB5tp2e32G1i0yDHer37DKCcqX/1ordekB6QMMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZaMC5pAoNd8yEbDRfPhncG1rnO+rcDx/Z0Ygfy9WRQxjbBQ+91glKrhcgDZ2at4Rr
	 Oxt6WR93QYdSPrnDI6+2xkq85J2TaCQZo+mowi3sqS3dApktwn9Kwirn6dlwpmENdF
	 TpnWfJWEtMf9XCez8MApqgVxleOrH/6FOqm+TvNxFtLD3HlNiNzUnXfEX8Z3JT14PO
	 88uSOY/XvOFdGB8g518ME6J2TK6PLaAX+urhf3tMJAk+bzK5DzQqNkDIAM3jwos5//
	 sQtKeHJUudpjSiAUpWqPo4S6U8qD0d+LHPhsSj3/hWBIP+b/lkzLB5XlcgnQPBEX8F
	 MQTuRG6RMYcBg==
Message-ID: <sashiko-outbox-167527@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v3 2/5] perf ftrace: Support filtering
 return address comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012003016.263063-3-atomlin@atomlin.com>
References: <20261012003016.263063-1-atomlin@atomlin.com>
 <20261012003016.263063-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 00:38:24 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] perf: build failure in cmd_ftrace() due to extra OPT_CALLBACK argum=
ent
- [Low] perf: ftrace_parse_retaddr() is dead code and never used for filter=
ing
- [Low] perf: missing document title underline breaks asciidoc generation
--

commit 5dab431981f96da9cbf4caa8e862a4c0e461a1ff
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support filtering return address comments

This commit introduces support for filtering out return address comments fr=
om
function graph trace output via a standalone --filter-retaddr flag. It adds
parsing and filtering logic, updates the command-line interface, and includ=
es
a dedicated unit test suite.

> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Docume=
ntation/perf-ftrace.txt
> index 3f3808e513fe8..3dbb7e8e783e9 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -1,5 +1,4 @@
>  perf-ftrace(1)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[Severity: Low]
Does removing the document title underline break the asciidoc generation?

Asciidoctor strictly requires the document title to be underlined with equal
signs of at least the same length as the text. Removing it renders the
document malformed.

[ ... ]

> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index d6604be593a34..f3221089a4793 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
[ ... ]
> @@ -1827,11 +1833,14 @@ int cmd_ftrace(int argc, const char **argv)
>  		     "Set nograph filter on given functions", parse_filter_func),
>  	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
>  		     "Graph tracer options, available options: args,retval,retval-hex,=
retaddr,nosleep-time,noirqs,verbose,thresh=3D<n>,depth=3D<n>",
> +		     "Graph tracer options, available options: args,retval,retval-hex,=
retaddr,nosleep-time,noirqs,noduration,verbose,thresh=3D<n>,depth=3D<n>,tai=
l",
>  		     parse_graph_tracer_opts),

[Severity: Low]
Does this extra string literal cause a build failure?

The OPT_CALLBACK macro for graph-opts was modified by adding a new help
string literal without removing the old one. Because they are separated by a
comma, the C preprocessor treats them as two distinct arguments, causing the
macro to be invoked with 7 arguments instead of 6.

[ ... ]

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> new file mode 100644
> index 0000000000000..344d36293f5ca
> --- /dev/null
> +++ b/tools/perf/util/ftrace.c
[ ... ]
> +bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_le=
n, u64 *offset)
> +{

[Severity: Low]
Is ftrace_parse_retaddr() ever used outside of the test suite?

The commit message claims this function is implemented to robustly match
return address comments before stripping them. However, looking at the
implementation of ftrace_filter_retaddr() below:

[ ... ]

> +void ftrace_filter_retaddr(char *str)
> +{
> +	char *start =3D strstr(str, "/* <-");
> +	char *end;
> +
> +	if (!start)
> +		return;
> +
> +	end =3D strstr(start, "*/");

It appears ftrace_filter_retaddr() performs string replacement using strstr
and memmove directly, bypassing ftrace_parse_retaddr() entirely. This leaves
the parsing function unused in the actual execution path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012003016.2630=
63-1-atomlin@atomlin.com?part=3D2
