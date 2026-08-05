Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D1B3D332C
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966688; cv=none; b=BVw0exHIST5ooiiaFIpOyJdNH3Q+gk4OZLyJcOnjjETPWDo/GA1B6jC5I6VGGi2A2dd6JN9betLeP+ZJIzKhPt/uWyRC1xaP7J75754a8prowUVn6uopixPJ15DBfjfksSZ17Pgxi7zEU9mowlaA09vmyXL0NJyMD01E7VgC2mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966688; c=relaxed/simple;
	bh=eXImi0LXk+h48Eb3SjHHj993K+y5LniqkfcPcL9PUOQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U9S3rMu+0eBtJw2UYIbblV7W579/daALDtUinHepisVyTywoMUVxTprHWDAm8vXLagqgZpt7AazV+ygYRYFLRAZhjKu3abqHOcOBtfJajlWtIj3t8N5czjza6n86YBzf+n8yLd0KOnv6u67/hLKESu6xXAUVNuE1FO8lJ2cQerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9u3Ue9i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9u3Ue9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3390E1F000E9;
	Wed,  5 Aug 2026 21:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785966687;
	bh=3Eku1zifPYNNnoVYThg+XZQnZch5GOZipmYy6ZIIbQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i9u3Ue9iiKtEE+qUtHNBBzJ9B15uRYQjLM1uEF6HYUK9yCgDil+MjaY9SppsGyzr8
	 COEWDnY8UX8JVKesymbBg1K34dhF89q84EKMLNljHgZgSgpppHjMF+KSrp6dhudj3g
	 +bn5V4ZLsPEbpZL6YsCCiy5EGqa0vij2xe3ePVwu03YAf1O//WRipkbpA8RPHhR2J3
	 zOyxfpk17+5C0tDcYrIVPoPD8NSA7B2jWuw6BZLlW6VJjGD0GUsFR3YysALuWl/5R8
	 JlSQOv70NY7ogaSRML9i9kFOWQYbbsiifNY2yJwPbSNt6nfHXE91U3hgXjl7byTlR2
	 BQ2QmlTu0Z/pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] perf jitdump: Validate sym string NUL-termination
 in code load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805212704.267779-12-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
 <20260805212704.267779-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:51:26 +0000
Message-Id: <20260805215127.3390E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing heap out-of-bounds read in `jit_repipe_code_move` due=
 to a hardcoded `+ 16` allocation size while using a dynamically sized head=
er length.
--

--- Patch [11]: [PATCH 11/12] perf jitdump: Validate sym string NUL-termina=
tion in code load ---
commit acba84089a50bc7dce59fc1ccce1335a41bbb013
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Validate sym string NUL-termination in code load

This commit adds a memchr() check to verify that the symbol name is
NUL-terminated within the region between the load header and the code blob.
This prevents an out-of-bounds read that could occur if code_size equals
total_size - sizeof(jr->load).

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 5a3ea2681fb37..5898a7d8eb962 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -487,6 +487,13 @@ static int jit_repipe_code_load(struct jit_buf_desc =
*jd, union jr_entry *jr)
> =20
>  	sym   =3D (void *)((unsigned long)jr + sizeof(jr->load));
>  	code  =3D (unsigned long)jr + jr->load.p.total_size - csize;
> +
> +	/* sym string lives between the load header and the code blob */
> +	if (!memchr(sym, '\0', code - (unsigned long)sym)) {
> +		pr_warning("jitdump: unterminated symbol name in code_load record\n");
> +		return -1;
> +	}
> +
>  	count =3D jr->load.code_index;
>  	idr_size =3D jd->machine->id_hdr_size;

[Severity: High]
This is a pre-existing issue, but I noticed a potential out-of-bounds read =
in
the related jit_repipe_code_move() function when calculating header sizes.

In tools/perf/util/jitdump.c:jit_repipe_code_move(), the event buffer is
allocated with a hardcoded +16 byte extra capacity:

	/*
	 * +16 to account for sample_id_all (hack)
	 */
	event =3D calloc(1, sizeof(*event) + 16);

However, when setting the header size, it adds the dynamic idr_size:

	event->mmap2.header.size =3D (sizeof(event->mmap2) -
			(sizeof(event->mmap2.filename) - size) + idr_size);

Could this result in an out-of-bounds read when perf_data__write() processes
this event?=20

If idr_size exceeds 16 bytes (which can happen depending on the sample_type)
and the dynamically sized filename string takes up the remaining slack spac=
e,
the calculated event->mmap2.header.size might exceed the allocated buffer s=
ize.
Could this leak uninitialized heap memory into the output stream?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805212704.2677=
79-1-acme@kernel.org?part=3D11
