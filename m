Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07023815D5
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302563; cv=none; b=Nnk71IvLquC6O4Gl66yRnfxMnikPa/OH3V+zG8vFlpsfzVPsHGztisdZ1mff2b2xye/DMgmpJRtnmfEXZBZHqEC8HyhGzzQjk7rKBWfdCDRgv1Wp1rED3E0/1pMwiEC9H+buhWelHAjP3TuYJopXq4iwUKmmrD2GzN4qj8VzMXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302563; c=relaxed/simple;
	bh=JmHQi/41549MphMawPW3NFIBmrmX5nq5DXWqLoBEzMM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a++xv/NIHhESORg0DqRGgejIOhT8w8eZN4ZLRSjdTo16Tnwn8fM7Batc7g31FfXpRX66pNcCOF7HixDNjDDbDlJE1biyWwewzQrcUKo3JNvXycDgwkgHEGHnBFc9fEuudn7RWnFJN8wPCbXh95X3A612zdCKYPX3C9ntz1IjB9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPjI4Dcv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPjI4Dcv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4886D1F000E9;
	Fri, 12 Jun 2026 22:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781302562;
	bh=R/M0Yzbe1E44DFkJsr/sbDjyaolQpvdtYxfIA9t9cXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oPjI4DcvUZcu0cl+I4YN9fCW5JcvrTVFACDl54DCGB6tbsC3QQqfZmTtqwJ3QPzoF
	 MU8fbuByEwGpqNlRHQSWjWRRgZZJjr0pLHTclFX8FVKAYZOn4cFtThLMTj8EDDiENh
	 kAsDYdYBNxoClRjjfXRdsuFNbdB5r6EMoQ/XV0gQ6YvwJAHeb0kWMwtGcqdln4nbhy
	 Q4/FqhRS8XRNLpwLr42y7mlXBJDTcEXp6ki0At7zam1aYFfUhx+ONrqgw4XwTPYpg2
	 IdrclmsC6ABNIEiX49IpUZFDLlRzcgW2d47M8MCki3hiLU0/mkNc5bf8v6URcrAwgd
	 pKps80YcMofAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf trace: Fix noise and signed formatting of
 __probe_ip in bare dynamic probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612220843.1320348-1-atomlin@atomlin.com>
References: <20260612220843.1320348-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 22:16:01 +0000
Message-Id: <20260612221602.4886D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch hardcodes the `__probe_ip` argument name in the output=
 format, ignoring the `trace->show_arg_names` configuration.
--

commit 52fd2385bfe746191bd8b95bc76fff9e349f4450
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Fix noise and signed formatting of __probe_ip in bare dynamic p=
robes

This commit hides the implicit __probe_ip field in bare dynamic probes
by default, and formats it as a hexadecimal kernel address when verbose mode
is enabled.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 48615ddccd93a..ca0b2680d531b 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c

[ ... ]

> @@ -3234,6 +3234,23 @@ static size_t trace__fprintf_tp_fields(struct trac=
e *trace, struct evsel *evsel,
>  		if (val =3D=3D 0 && !trace->show_zeros && !arg->show_zero && arg->strt=
oul !=3D STUL_BTF_TYPE)
>  			continue;
> =20
> +		/*
> +		 * __probe_ip is implicitly added to bare dynamic probes.
> +		 * Suppress it by default to avoid cluttering the output.
> +		 * If verbose mode is enabled, ensure it is formatted as a
> +		 * hexadecimal memory address rather than a signed integer.
> +		 */
> +		if (!strcmp(field->name, "__probe_ip")) {
> +			if (!verbose)
> +				continue;
> +
> +			printed +=3D scnprintf(bf + printed, size - printed,
> +					     "%s%s: %#016llx", printed ?
> +					     ", " : "", field->name,
> +					     (unsigned long long)val);

[Severity: Medium]
Does this hardcoded format string bypass the trace->show_arg_names
configuration?

In trace__fprintf_tp_fields(), other arguments dynamically check if their
names should be printed:

        if (trace->show_arg_names)
                printed +=3D scnprintf(bf + printed, size - printed, "%s: "=
, field->name);

By explicitly formatting "%s%s: %#016llx" using field->name, it looks like
__probe_ip will always print its argument name here, even if perf trace
is executed with --no-arg-names alongside --verbose.

> +			continue;
> +		}
> +
>  		printed +=3D scnprintf(bf + printed, size - printed, "%s", printed ? "=
, " : "");
> =20
>  		if (trace->show_arg_names)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612220843.1320=
348-1-atomlin@atomlin.com?part=3D1
