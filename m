Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C24B23BF9F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140433; cv=none; b=fHwT1EULr2DWAGe4ybMcOz7LXP/ITaXIMUEZk7ISJVNPAmAmBvc4fjeLvOjfAkLww8yTN8L91ntzUi4leOxqAVWQdvapgldpiLal8fKyWj/Dqn94fb9dl5og63Va1N8PNawtMeHYYAXOGzulZLSCls+vxyt/TVStsvMd5zfOObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140433; c=relaxed/simple;
	bh=8LTgkvRKnG1+4yu4FNKfpop8N2AzYy09F8arlrd2814=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AxdppqpkcADW06CpksCSWF31t/GpUCHu8ti9xJIVVWwF9TvnjG8jh9ZfUnF9O3s77oo3tA6HBtJwZ/uWCIUXiOM9/jC0MNAZ2YpGGCLjWIbWLHQQwTfZEng8lh3O7+7N1n7cVOnRlrz70r/BEIUTnPPgSEXZhl7YmCxDlPy0wzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNSRRfmd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNSRRfmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A0FC2BCB0;
	Sat, 25 Apr 2026 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140433;
	bh=8LTgkvRKnG1+4yu4FNKfpop8N2AzYy09F8arlrd2814=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eNSRRfmdKcFb0JEdU+EIl8K81UIL4e3DlMUlxn3e4vyRZfUZ/RD/4P6UwaysUs/b7
	 QRQj/P2gM9blnDaPC+0kNfEsqjjjMV1QFfwcS0KeRxu2uNwwwHxjMqoxYeym3Uu3h9
	 Q1n69xN8Zc+S59A4/uWM6zYIPVNQYnXGAFEgurEAyqtU12/ZT2tgOSaUeddpvQEuRd
	 99lly+DpThioMddS7P4AR64a4M29v9BrgyN+zXhUbeDKlF3tegIR74uot142jNiKR1
	 1IrtkKwdBCcwEIWR//wrm+Nai61NoNxuH3vWQyevc17O/ZfNLVVYLkgLCPmCZvzkYh
	 SI6Qmbg9cBKKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 26/59] perf mem-phys-addr: Port mem-phys-addr to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-27-irogers@google.com>
References: <20260425174858.3922152-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:07:12 +0000
Message-Id: <20260425180712.F3A0FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] The script uses modern Python features that break compatibility =
with older Python 3 versions commonly used in enterprise distributions.
- [Medium] Unrestricted per-sample printing of unmapped physical addresses =
causes severe log spam and performance degradation.
- [Low] Incorrect handling of the `bisect_right` return value masks a logic=
al flaw via negative indexing.
--

commit 904dd2cfff43ebbf4c77eb8c22a3d0c319e26d8c
Author: Ian Rogers <irogers@google.com>

perf mem-phys-addr: Port mem-phys-addr to use python module

This commit adds a Python script that uses the perf python session API to
process a perf.data file. It demonstrates resolving physical address samples
to memory types by parsing /proc/iomem.

> diff --git a/tools/perf/python/mem-phys-addr.py b/tools/perf/python/mem-p=
hys-addr.py
> new file mode 100755
> index 000000000000..ba874d7a2011
> --- /dev/null
> +++ b/tools/perf/python/mem-phys-addr.py
> @@ -0,0 +1,117 @@
[ ... ]
> +# Physical memory layout from /proc/iomem. Key is the indent and then
> +# a list of ranges.
> +iomem: Dict[int, list[IomemEntry]] =3D collections.defaultdict(list)

Will this cause a TypeError on Python versions older than 3.9? Generic type
hints in standard collections like list require Python 3.9+. Older Python
versions commonly used in enterprise distributions might fail here.

> +# Child nodes from the iomem parent.
> +children: Dict[IomemEntry, set[IomemEntry]] =3D collections.defaultdict(=
set)

Similarly, will using set[] instead of Set[] from the typing module cause
exceptions on Python environments older than 3.9?

[ ... ]
> +def find_memory_type(phys_addr) -> Optional[IomemEntry]:
> +    """Search iomem for the range containing phys_addr with the maximum =
indent"""
> +    for i in range(max_indent, -1, -1):
> +        if i not in iomem:
> +            continue
> +        position =3D bisect.bisect_right(iomem[i], phys_addr,
> +                                       key=3Dlambda entry: entry.begin)

Does this break compatibility with Python versions older than 3.10? The key
parameter in bisect.bisect_right() was introduced in Python 3.10, so this
might result in a TypeError on older systems.

> +        if position is None:

Since bisect.bisect_right() always returns an integer, is this check for
None necessary?

> +            continue
> +        iomem_entry =3D iomem[i][position-1]

If phys_addr is smaller than the lowest address in the list, position will
be 0. This would result in accessing index -1, which fetches the last eleme=
nt
of the list via negative indexing wrap-around.

While the bounds check below will handle it safely, relying on this behavior
seems logically incorrect. Would it be better to check for position =3D=3D 0
instead of checking for None?

> +        if  iomem_entry.begin <=3D phys_addr <=3D iomem_entry.end:
> +            return iomem_entry
> +    print(f"Didn't find {phys_addr}")

Because process_event() evaluates thousands or millions of samples, won't
this print statement cause massive log spam and severely degrade performance
for unmapped physical addresses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D26
