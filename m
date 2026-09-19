Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B9B34CDD
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 01:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780034; cv=none; b=EXSb3ux5GAFmvepoOnNXYr11XwKNvVtyjb3xNrzu84Ar5ElBDYvjSp/HyzMnjsTrn4rNJ9Egt5WynMxW0s7bQy/0Eoq4utvn2K5x+397lHtueI68FPBNFIxubbheakbewTdMvW7EalztYoleuq8iYvtANVqL1cTLLH9iW3FerbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780034; c=relaxed/simple;
	bh=4lvst/pLCBs6pFpcRPiaOWPY9XDBEPtd2Uaeb+Z50UA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cm2QjreLmDOset5cASzajVmC7zRqlizkyX9IZ8Y6FXUIu9Lpzj+Xmj+F6xKkidVn4CLYwEwI4Tz7yfod45VA3Kgwjj7q9VWAo+xmkvSmnGgPxTKvweYfZFYv1WvKf234x9RV8c1x4kB7CCBGHMtcCnfQAzhVe2bBvoKuB1by6mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozgjsteI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozgjsteI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BEC1F000FF;
	Sat, 19 Sep 2026 01:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780028;
	bh=CYWccN/jqc1E7LbEukW0UCUNlvSTufqRMmMYuckpSlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ozgjsteIMNP0779i21fOHXuiZpLdQiERUI7vFyUfquDco/D0HuU/H0j9qAWF/M9Ei
	 t+qAYRgCjgbaelONcwTb1LSJR3FMsqTXMrkEGpUGYo658IQB7lcB0UPMbPY6BqnbTi
	 628gwP3uy6EPJw3IrzwkrXSp7LhyZbH5z/YPTN5Bw/n8OTZfAnuFrSuyy05yF0f+mZ
	 okBGvtlHd+ZR9Xm1LzkIiZkd78mWI/VKE43QTuPFDVIUhEISlFEhnL+ISXy0VkIfZD
	 4DX5lV3t8TP9j0c0BZQoOBR85kJrFacphUzwak3dWUVkvrTS0lVOR5ek5d7vJbgne9
	 hODdip85WCOSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 perf-tools-next 1/7] perf trace: Add upper bound
 checks for augmented BTF struct printing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919005530.728615-2-atomlin@atomlin.com>
References: <20260919005530.728615-1-atomlin@atomlin.com>
 <20260919005530.728615-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:07:08 +0000
Message-Id: <20260919010708.82BEC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf trace: btf_struct_scnprintf() fails to consume short payloa=
ds
--

commit ff5721b95fd4d48862773d326029922c1b94fdc7
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Add upper bound checks for augmented BTF struct printing

This commit adds upper bound checks for augmented_arg->size against the
remaining buffer size. It prevents buffer over-reads and integer
overflows when pretty-printing augmented struct payloads using BTF.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c

[ ... ]

> @@ -1133,12 +1133,13 @@ static size_t btf_struct_scnprintf(const struct b=
tf_type *type, struct btf *btf,
>  	LIBBPF_OPTS(btf_dump_opts, dump_opts);
>  	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
> =20
> -	if (arg =3D=3D NULL || arg->augmented.args =3D=3D NULL || arg->augmente=
d.size <=3D 0 ||
> +	if (arg =3D=3D NULL || arg->augmented.args =3D=3D NULL || arg->augmente=
d.size < (int)sizeof(*augmented_arg) ||
>  	    arg->fmt =3D=3D NULL || !arg->fmt->from_user)
>  		return 0;
> =20
>  	augmented_arg =3D arg->augmented.args;
> -	if (augmented_arg->size <=3D 0)
> +	if (augmented_arg->size <=3D 0 || augmented_arg->size > arg->augmented.=
size - (int)sizeof(*augmented_arg) ||
> +	    (size_t)augmented_arg->size < type->size)
>  		return 0;

[Severity: Medium]
Does this early return fail to consume the short payload?

By returning 0 here when the augmented payload is smaller than type->size, =
it
appears the parser abandons the payload without updating arg->augmented.arg=
s.

When the next syscall argument is formatted, will it read this stale struct
payload as its own augmented data, corrupting the parsing state for all
subsequent arguments?

Since short reads can occur legitimately during BPF tracing when capturing
large structs, should this gracefully advance past the short payload rather
than abandoning the update entirely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919005530.7286=
15-1-atomlin@atomlin.com?part=3D1
