Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03513A5E64
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518868; cv=none; b=AGyUnN9cQnGhBGePIQAvCDHV6lN4AY2Gw06Ovr1Af/LSj+avqBTf1bBi5sqCQAoiYBK3MP2JInKFfyBC8xUdVNtib2hRgEK0yB2/74pDSVt/+8uYDzP0XuF0zD9N57FlTirF3zBax1tlOuv4fuXLFSAKENLXScPR33350oTTMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518868; c=relaxed/simple;
	bh=CyAjl7Vq3k6y/hBOTrJ5EHeophNtXm279Xcn6PTWWWA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aEC1cUFOYvZ+h68jMpnbrhaqoRFVgYPLA3Z+fjua61z02TgtQ2teWABZrTtmMDfoA5TOkotJ4cUDL8noxHZGmSU4zxPkwInECCDP5yyEzGWAt8A5fzREeOHUQlUPGOuQDCWYc/NQ3iVaCyjqCmyWDn8pdCmO2AvsAbHZCGlvmfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFiISGmN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFiISGmN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC691F000E9;
	Wed,  8 Jul 2026 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783518854;
	bh=jadtAgY9KyBpRufgvtP8kb1Cp+IeUqJmYlawEPv80Rg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VFiISGmNVBXVh4lZ3zh+3itje+oDzID+6mAgYshg3PO83ulx3xT5mT4tujOuYQ/Rk
	 A9xwcs10rwEqFi6Iizlx6xDqx+AWArhPAz1Fh31xzBKhiya8M3mEK2Ny+j2i2G2AYv
	 EqtTGFgUL1Hi0k8+3dvU8qeOpAiDOtsufTWaRdjiev6nONxqEz9YV2kSnCvW0P9gSS
	 yGxIKEvVFBSBUPlpR/5H21QIaVPpBQJCBw/XO/UctFwBfFfEkbBkXXk+fEZHGv3jHO
	 0gDbkQPGS/opTdL06kRqeDAOY7u4nx62ZlsGt/Z8zTlj33F6JY1HjJ+tjeFHGYuJsW
	 8SFeLusK6EHVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf record: Return the written size from
 process_comp_header()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Ilvokhin" <d@ilvokhin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <9a23dffc110b0e0ead7120fcbbef57b8e6c0b8a6.1783513665.git.d@ilvokhin.com>
References: <cover.1783513665.git.d@ilvokhin.com>
 <9a23dffc110b0e0ead7120fcbbef57b8e6c0b8a6.1783513665.git.d@ilvokhin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 13:54:13 +0000
Message-Id: <20260708135414.6DC691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] When a large buffer is split into multiple compressed records, `re=
cord__pushfn` overwrites the first record's header size with the total comp=
ressed size, corrupting the stream and causing integer truncation.
- [Medium] The `process_comp_header` function fails to initialize `event->d=
ata_size` and does not pad `PERF_RECORD_COMPRESSED2` records to an 8-byte b=
oundary, leading to an uninitialized heap memory disclosure.
--

--- Patch [1]: [PATCH v3 1/2] perf record: Return the written size from pro=
cess_comp_header() ---
commit a7fcd622c85922789abb8c299306610b9ac81440
Author: Dmitry Ilvokhin <d@ilvokhin.com>

perf record: Return the written size from process_comp_header()

This commit modifies process_comp_header() to take the remaining destination
space and return the bytes written or -1 if the header won't fit. The bounds
checking is now handled directly by the header processing function rather t=
han
the loop in zstd_compress_stream_to_records().

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c

[ ... ]

> @@ -1591,16 +1591,25 @@ static void record__adjust_affinity(struct record=
 *rec, struct mmap *map)
>  	}
>  }
> =20
> -static size_t process_comp_header(void *record, size_t increment)
> +/*
> + * Called once with data_size =3D=3D 0 to start a record, then once with
> + * data_size =3D=3D compressed payload size to finalize.
> + * Returns the bytes written, or -1 if it won't fit.
> + */
> +static ssize_t process_comp_header(void *record, size_t dst_size,
> +				   size_t data_size)
>  {
>  	struct perf_record_compressed2 *event =3D record;
>  	size_t size =3D sizeof(*event);
> =20
> -	if (increment) {
> -		event->header.size +=3D increment;
> -		return increment;
> +	if (data_size) {
> +		event->header.size +=3D data_size;
> +		return 0;
>  	}
> =20
> +	if (size > dst_size)
> +		return -1;
> +
>  	event->header.type =3D PERF_RECORD_COMPRESSED2;
>  	event->header.size =3D size;

[Severity: Medium]
This is a pre-existing issue, but does process_comp_header() leave
event->data_size uninitialized here?

If called from AIO mode via record__aio_pushfn(), the map->aio.data memory
could be allocated via malloc() and reused without zeroing.

Since event->data_size isn't set and the record isn't padded to an 8-byte
boundary, this could write uninitialized heap memory to the perf.data file
and break ZSTD decompression.

> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c

[ ... ]

> @@ -55,12 +57,9 @@ ssize_t zstd_compress_stream_to_records(struct zstd_da=
ta *data, void *dst, size_
> =20
>  	while (input.pos < input.size) {
>  		record =3D dst;
> -		/* process_header writes the event header into record */
> -		if (dst_size < sizeof(struct perf_event_header))
> -			goto reset;
> -		size =3D process_header(record, 0);
> +		size =3D process_header(record, dst_size, 0);
>  		/* Output buffer full =E2=80=94 cannot fit even the record header */
> -		if (size > dst_size)
> +		if (size < 0)

[Severity: High]
This is a pre-existing issue, but when zstd_compress_stream_to_records()
splits large outputs into multiple records, doesn't returning the total
compressed size cause issues in the caller?

Looking at record__pushfn() in tools/perf/builtin-record.c, the caller seems
to assume a single record was produced and overwrites the first record's
header size:

	event->data_size =3D compressed - sizeof(struct perf_record_compressed2);
	event->header.size =3D PERF_ALIGN(compressed, sizeof(u64));
	padding =3D event->header.size - compressed;

Since header.size is a u16, if a chunk produces more than 65535 bytes,
this would silently truncate the value.

This would cause the padding calculation to underflow into an enormous size=
_t
value, and record__write() would attempt to write exabytes of zero padding =
to
disk.

Even without truncation, overwriting the first header would cause the
decompressor to treat subsequent intermediate headers as ZSTD payload.

>  			goto reset;
>  		compressed +=3D size;
>  		dst +=3D size;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783513665.gi=
t.d@ilvokhin.com?part=3D1
