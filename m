Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD735A385
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804758; cv=none; b=YPOQJwoXsYWQQFfojgYEifELTz+nKNkk5CDGL+kTv8sL5h0QcDp8mIEGh8X209bNcLx3I3xAKzje3tDR5o/+qhVrtB8/AD68EQoYua26+k+pX1MjpJgXZBRzhkVEHVMwOCccV572q4XqZka1mIT1sqMqSWdTMEbBa6WR7X851B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804758; c=relaxed/simple;
	bh=4+568BpZFsNACr+GNVgJwgQyrW8Xj9C0ilafwINLsvg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i87u4hFcqdnG2TRRrhHifYkxIJ/oO/CpL7zp0YrrPjkxffUfwAxU6CjxASlNNDZGk7WUHqy3cfRlgUMaqsfsP8drBcFzg0E/aQ6alGQR5LIriNvjQZp7ItdclGTSKuZE3NAvqZ0ZkUYLBAQBC7nVM6bFJbj159Wkk5FmgV9mb+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmjQtCKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmjQtCKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450281F000E9;
	Tue, 30 Jun 2026 07:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782804757;
	bh=K/KFWpBL7DUI5A/FwALHJRHgrLy4oqU8v/fGFAVSoOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PmjQtCKG5c2J5cfVr0vVs3v8ym/6z9zhRMWD2cfLAgvIBlI+MN+tJc5qKWwEyZbbx
	 qusgjRuPeFnNeXykLcz0IXy5z5uwl0XfvTosijmryOMWDfdBfnU1qVu3J+9SLFjJWc
	 AovnriFE6Ce5XX1LHt5y5IuSxPeVIKZDK8dnMcSasPtPVDmEhNKxHY6eLJ5Kmpaj7c
	 ht3b1snkxtsRRPQ6dC0vFDydQsrJaL2qWQOjLhcbzZMXYHP2GrysBPFQAPDHWxca3Y
	 AJCnYPtfdLquSIE0G/AP5uC2FzpvztbpQZvNIVelNfxa/dz0LL31Yx4emk1YxGv+Xd
	 XaRy1Su+NX0Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf record: Fix multiple
 PERF_RECORD_COMPRESSED2 records per push
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Ilvokhin" <d@ilvokhin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <079503c01a3e28d3775947f3449cadacfa1f4117.1782743187.git.d@ilvokhin.com>
References: <cover.1782743187.git.d@ilvokhin.com>
 <079503c01a3e28d3775947f3449cadacfa1f4117.1782743187.git.d@ilvokhin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 07:32:36 +0000
Message-Id: <20260630073237.450281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit `#include <string.h>` for `memset` in `builtin-rec=
ord.c`.
--

commit cb8ac7d313a36a42601f85ffc5fb9a9061002bc0
Author: Dmitry Ilvokhin <d@ilvokhin.com>

perf record: Fix multiple PERF_RECORD_COMPRESSED2 records per push

This commit frames compressed records individually when produced rather
than rewriting a single header for an entire blob. This prevents truncation
of the header.size field when a compressed blob exceeds 64KB.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4a5eba498c025..2562c3177eae1 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c

[ ... ]

> @@ -1590,18 +1577,29 @@ static void record__adjust_affinity(struct record=
 *rec, struct mmap *map)
>  	}
>  }
> =20
> -static size_t process_comp_header(void *record, size_t increment)
> +/*
> + * Called once with data_size =3D=3D 0 to start a record, then once with
> + * data_size =3D=3D compressed payload size to finalize and 8-byte-pad it
> + * (unaligned records trip ASan in the reader).
> + */
> +static size_t process_comp_header(void *record, size_t data_size)
>  {
>  	struct perf_record_compressed2 *event =3D record;
>  	size_t size =3D sizeof(*event);
> =20
> -	if (increment) {
> -		event->header.size +=3D increment;
> -		return increment;
> +	if (data_size) {
> +		size_t padding;
> +
> +		event->data_size =3D data_size;
> +		event->header.size =3D PERF_ALIGN(size + data_size, sizeof(u64));
> +		padding =3D event->header.size - size - data_size;
> +		memset(record + size + data_size, 0, padding);

[Severity: Low]
Does this file need an explicit include for <string.h>?

Relying on implicit header inclusion for POSIX libc functions like memset c=
an
cause build failures on systems using musl libc, where implicit header grap=
hs
differ from glibc.

> +		return data_size + padding;
>  	}
> =20
>  	event->header.type =3D PERF_RECORD_COMPRESSED2;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782743187.gi=
t.d@ilvokhin.com?part=3D1
