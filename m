Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848F481B1
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491497; cv=none; b=XAzuVnpyVyMd05LJs9Fedfz78fAtXBtcvZijomIXzmjKzEx4IfjjBgVoz2rs+e9/47ZfH1wQTPwdu6o81Ew9DvzEjF1HqgM0njsSHKtO2IVYIFpx88Wr0AI2fVNjETz27H/OmROV13qs/2/TwWFX3OuUcR5XYlCcN3CtmAXhcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491497; c=relaxed/simple;
	bh=q4D3LJ+P3oprZYugqGNaOP1vCHcAnm1kLKjSCmeyekI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pQe7Xur1Ea8UtCj2+YmTFWRevbadXwCEeStlz1agfT8F8+zFXEIw/TI2LaiSIOcJVu5HR73pYSavUD4GTinzSu59Gm4GnUuEqpvit8BC6stq1zpNjnv7IHa3GTVFx7mQxSfcoQ1SP6M+qZhFhsL15pWcPDcmt+WaWC2sEUho6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTWnxDsy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTWnxDsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6936F1F000E9;
	Fri, 26 Jun 2026 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782491495;
	bh=WnUrzsjEA1pFznuP8zXZW2QBPPI3TlV2WG8YqI8lzII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OTWnxDsy2nDuRZzDocUud4hoLwT1dNAGvOjse8k/MTpfgAoOmYj5a0YJuZeYXRciE
	 +xj5cJu0GxgGMHdwoR7N3U5AjrrFzgZTZT9WrA7pEUHNgiGP+QOrhal+lmNptJ3hmq
	 B8cMOIqYz6uES/YwTg0fubxk7FHuDKIFnO0o42jPBOh/tUTfILlbq/8WspI1OmFG2v
	 ZzqkpR0VnA8DcAcypTsAJmDFNYhRHQtUbGWtA6y+MpReoZdGKJSyvEWP3ZHIua5UXT
	 05/XXcrhS8Y09+1c5IVO4C6bx7faM5ing9VMHkjHmRW8HPXYiQbLrlavT4csBtOxGo
	 lcbo9fEVmxnYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf dso: Fix kallsyms DSO detection with fallback
 logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260626161052.1024439-2-tshah@linux.ibm.com>
References: <20260626161052.1024439-2-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 16:31:34 +0000
Message-Id: <20260626163135.6936F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free vulnerability due to lockless access of `dso->long_=
name` in `dso__is_kallsyms`.
--

commit 9c2571a16a38ac5caaaeb737772bc4cd229c357c
Author: Tanushree Shah <tshah@linux.ibm.com>

perf dso: Fix kallsyms DSO detection with fallback logic

This commit fixes an issue where kallsyms build-id symlinks fail to be
created during perf record/inject because the dso_binary_type is not
yet explicitly set. It falls back to matching the long_name against
known kallsyms strings when the binary type is not found. A strict
validation function is also added for guest kallsyms to prevent path
traversal attacks.

> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 2916b954a804b..884cca37753c4 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
[ ... ]
> @@ -924,8 +959,28 @@ static inline bool dso__is_kcore(const struct dso *d=
so)
>  static inline bool dso__is_kallsyms(const struct dso *dso)
>  {
>  	enum dso_binary_type bt =3D dso__binary_type(dso);
> +	const char *name;
> +
> +	if (bt =3D=3D DSO_BINARY_TYPE__KALLSYMS || bt =3D=3D DSO_BINARY_TYPE__G=
UEST_KALLSYMS)
> +		return true;
> +
> +	if (bt !=3D DSO_BINARY_TYPE__NOT_FOUND)
> +		return false;
> +
> +	if (!RC_CHK_ACCESS(dso)->kernel)
> +		return false;
> +
> +	name =3D RC_CHK_ACCESS(dso)->long_name;
> +	if (!name)
> +		return false;
> +
> +	if (!strcmp(name, DSO__NAME_KALLSYMS))
> +		return true;

[Severity: High]
This isn't a bug introduced by this patch, but lockless access to=20
dso->long_name is a systemic flaw that could lead to a use-after-free here.

If a concurrent thread modifies the DSO (e.g., the event processing thread =
in
perf top handling a ksymbol register event calls
machine__process_ksymbol_register() -> dso__set_long_name()), the old
long_name can be freed while the UI thread is executing dso__is_kallsyms()
and performing this strcmp().

Is it safe to expand the surface area of this pre-existing lockless string
dereference into a function that was previously safe?

> +
> +	if (!strcmp(name, DSO__NAME_GUEST_KALLSYMS))
> +		return true;
> =20
> -	return bt =3D=3D DSO_BINARY_TYPE__KALLSYMS || bt =3D=3D DSO_BINARY_TYPE=
__GUEST_KALLSYMS;
> +	return is_guest_kallsyms_pid_name(name);
>  }
> =20
>  bool dso__is_object_file(const struct dso *dso);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626161052.1024=
439-2-tshah@linux.ibm.com?part=3D1
