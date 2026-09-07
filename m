Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DAC3F1046
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 03:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753582; cv=none; b=PwvF1UdH/YhI8ldlujcEMfs/NZtPCBqQssYeQj3SipzPK5D6/ZhTW5jsnHZs4kVnfNFFSRxBMX39Kz5XnOMN8aSbHJpTNVlARu7u8Iv2AcsY39nbQnJuFKoreccBwfZwEdxzyPWG1z2stEsqLUsg+W2IWZXNokWXfqkl7BGsZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753582; c=relaxed/simple;
	bh=DDc04Ja12XM4YUsz/766geOYp6mGm3hUpcVhOEr5UJE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ol/2S14+RuhPShyT7qAZzv/ik5CHMX39/GYnhJWcAw1gIe4iKYtBa8h0+F0O7rgiJjmi927Xe6iWTd7PKDlksiHL3aQPheoDM5W2aj+K0ZHNV2Hu7MxQuylGH3TrtFlYrwCMi0zPQMpcIbGFtufbwmvN8BwuresOrPxWt4vIivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J21wVmc+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J21wVmc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B506F1F00A3A;
	Mon,  7 Sep 2026 03:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788753580;
	bh=xB/sMevgAC6zPGXIvTM5BzC28xpTWukpN1JXwQPN/Wc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J21wVmc+ByRY07CGR1DOmDtukqQUqQPJTYSm2DPsQhyhLfCJ/ErnA4gBEjJNjloHm
	 i11Knj9Jtf0185U1Xfy13BGeE7GtZrQXofpmpCtM041mQE48QtWsox96Pz22kMtVkt
	 gB+JzHzjAcDvwbD0B4QchUpWxx0qRiRpNRmmIXEiGP388kLCazGv7a7e7+wfIuiXVr
	 11cUmnY4/TPkUmnW9s4U6/E8EOCsdqCTYxkHSYgLJm7HdYS+S1kbx3oX01ATosgaBm
	 w2WCLu/vZA1AWtESPqRZqTI9juYV7Etk0qHFScmPiqOcqvrIa1w4RXi7sxuUpzgAiZ
	 uKHGHyVgTCOJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf annotate: fall back to original binary if
 build-id cache entry is not a valid ELF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260907034554.714-2-atrajeev@linux.ibm.com>
References: <20260907034554.714-1-atrajeev@linux.ibm.com>
 <20260907034554.714-2-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 03:59:40 +0000
Message-Id: <20260907035940.B506F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Spurious warning emitted for missing build-id cache files and va=
lid kallsyms cache entries.
--

commit 4a56442e475b7351d0cee0b5ef94464e2d112fe2
Author: Athira Rajeev <atrajeev@linux.ibm.com>

perf annotate: fall back to original binary if build-id cache entry is not =
a valid ELF

This commit adds a check to verify that a build-id cache file is actually a
valid ELF before passing it to objdump. If the file is not a valid ELF, it
emits a warning and falls back to the original binary path.

> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 6cfdbabbb8c7d..e263a2a8715dd 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1201,6 +1201,12 @@ static int dso__disassemble_filename(struct dso *d=
so, char *filename, size_t fil
>  	if (len < 0)
>  		goto fallback;
> =20
> +	if (!is_valid_elf(filename)) {
> +		pr_warning("build-id cache file is not a valid ELF, falling back to or=
iginal binary: %s\n",
> +			filename);
> +		goto fallback;
> +	}
> +

[Severity: Medium]
Will this emit spurious warnings for missing build-id cache files or valid=
=20
kallsyms cache entries?

When perf annotate looks up a build-id and finds a kallsyms entry (which is=
 a=20
plain text copy of /proc/kallsyms, not an ELF) or a dangling symlink (missi=
ng=20
file), the newly added is_valid_elf() check evaluates to false.

Because this check is placed before the original access() and=20
strstr(..., DSO__NAME_KALLSYMS) checks, it preempts the expected silent=20
fallback paths and prints a warning.

>  	linkname[len] =3D '\0';
>  	if (strstr(linkname, DSO__NAME_KALLSYMS) ||
>  		access(filename, R_OK)) {
> fallback:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907034554.714-=
1-atrajeev@linux.ibm.com?part=3D2
