Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C42078F4A
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225495; cv=none; b=eQ/F7Y42QiVM7l/LikXrI7j360cuuXBx0M1Py2OpqxqFKvethE3pzhSZdIuFwARjq/c2ZGn0BBt0TquK3jOWdAG0BNUntTVEwc9KvY9nJAQXNqDa9AQtwO+lox7q/Y9NAzi3HAWg8vP3rnJKbo5QDjERppF8fxUXKjv/h2ZhVfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225495; c=relaxed/simple;
	bh=Y5yA/NuUNsLu3j1L11PtLLsp6wkFLImknV7Sgh1UQ4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i+Y/CWVOy/J0YTHh3kKDGQ6JAjuoef4PAm9rH4QBU957zINakFLJAiQQch/1lsD2y6w1nqNgS+KaQQR2yvM9pf7kHPFHWB3GoiyZygJpgMvIaF08q1C/6SM/DIGwBUcx/vBvAGQ3rK2IAuHKvHwetmSHWfK9j1DhsORiP4D89ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgUIIIT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgUIIIT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D6C1F000E9;
	Fri, 12 Jun 2026 00:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781225493;
	bh=XZfJ8zAtt27uh2n/UWG9ZeYyx+A/c58Rl5AORboA4Wg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HgUIIIT65KmFm6/6xxoz/Djng2kkNjBtl11bMXcdALpVrarYJfRotJ2g5EQ5F8P+7
	 MJ/HpaqF/0IJ+rxHYsYCbxkbKZrkeALsFTgvisAPVw0dFNIg8hUEHHwOFhPco4v/Xy
	 VAJJtrDIm/K+b6JU4gUI1Bhvmc43FR/cf5mb0fswfmlMdacZkLD7VFCWQNGUskgmVj
	 pN9dv3IUBVDKwVs7ngH+Ys5tkUK+GzJABjY3CZaniGuUYRXRMZ4PYg67ukjykSz2Ug
	 C2a16vIVLVT3IzT0AZHsA+pUoz9KrYAg6oVkCgnM3qgU6LJNtW5w7X4yK587+I3tuY
	 3JsK7kj0x7eMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/15] perf bpf: Bounds-check array offsets in
 bpil_offs_to_addr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612003444.50723-13-acme@kernel.org>
References: <20260612003444.50723-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 00:51:33 +0000
Message-Id: <20260612005133.85D6C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Information leak of heap address due to incomplete offset saniti=
zation.
--

commit a0507a1a42adbf8d7d5cf1288f8518eee273f578
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Bounds-check array offsets in bpil_offs_to_addr()

This commit adds a bounds check to bpil_offs_to_addr() for offsets coming f=
rom
untrusted perf.data files. When an offset exceeds data_len, the offset fiel=
ds
are zeroed out and the pointer conversion is skipped to prevent out-of-boun=
ds
pointer construction.

> diff --git a/tools/perf/util/bpf-utils.c b/tools/perf/util/bpf-utils.c
> --- a/tools/perf/util/bpf-utils.c
> +++ b/tools/perf/util/bpf-utils.c

[ ... ]

> @@ -264,12 +264,26 @@ void bpil_offs_to_addr(struct perf_bpil *info_linea=
r)
>  	for (i =3D PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
>  		const struct bpil_array_desc *desc =3D &bpil_array_desc[i];
>  		__u64 addr, offs;
> +		__u32 count, size;
> =20
>  		if ((info_linear->arrays & (1UL << i)) =3D=3D 0)
>  			continue;
> =20
>  		offs =3D bpf_prog_info_read_offset_u64(&info_linear->info,
>  						     desc->array_offset);
> +		count =3D bpf_prog_info_read_offset_u32(&info_linear->info,
> +						      desc->count_offset);
> +		size =3D bpf_prog_info_read_offset_u32(&info_linear->info,
> +						     desc->size_offset);
> +		/* offset and extent from perf.data are untrusted =E2=80=94 keep withi=
n data[] */
> +		if (offs >=3D info_linear->data_len ||
> +		    (u64)count * size > info_linear->data_len - offs) {
> +			bpf_prog_info_set_offset_u64(&info_linear->info,
> +						     desc->array_offset, 0);
> +			bpf_prog_info_set_offset_u32(&info_linear->info,
> +						     desc->count_offset, 0);
> +			continue;

[Severity: Medium]
Does skipping this conversion without clearing the corresponding array bit
in info_linear->arrays leak the heap address later?

When the bounds check fails, the offset is set to 0, but the active array
bit remains set in the info_linear->arrays bitmask.

Later, if the tool rewrites the data (such as during perf inject or archive=
),
write_bpf_prog_info() will call bpil_addr_to_offs(), which processes all
arrays that still have their bits set. It subtracts the heap base pointer
(info_linear->data) from the array address.

Since the address was explicitly forced to 0 here, the calculation becomes
0 - ptr_to_u64(info_linear->data). This results in the two's complement of
the heap address, which is then saved into the bpf_prog_info struct and
written back out to the perf.data file.

Would it be safer to also clear the active array bit via
info_linear->arrays &=3D ~(1UL << i) when zeroing out these offsets?

> +		}
>  		addr =3D offs + ptr_to_u64(info_linear->data);
>  		bpf_prog_info_set_offset_u64(&info_linear->info,
>  					     desc->array_offset, addr);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612003444.5072=
3-1-acme@kernel.org?part=3D12
