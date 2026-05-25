Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ED9343890
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673946; cv=none; b=dK6ENJhOeQX8Mswsikk3QJ1WKblxUfB0oF7k2DxHDIIb3Pf31OOX96q93ZyIq2xt4xzEo11BSaHBeG98d1dFVzet2JYcaOTNLwK1DR7jGzug9c//0E5PClZB6f2YWHMHEI6f42REU5JboiaidKD2cG+c2DR77zrcX+fBUtlsABE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673946; c=relaxed/simple;
	bh=P/SCzxev01h0hjQCLcL00Lf7l0zCbM7JJTnE5mN9B7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h8psxawsQmlvA0gs41ioMg9iHz12rnj+CWtNPRxi6oOkhvlyc0AcImHJM7lhgUfROZto3WuuQXViONFokW2u5qVQu95ZXHC39Chmc3X5be7y9biK0y+XLdGv7FhPIlps/MDrKy8dM4PK54DtMhv4TYPQpD6DBVEM1ZUSw/NXBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsDLhZkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsDLhZkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8241F000E9;
	Mon, 25 May 2026 01:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779673944;
	bh=ff2aD5mHyET0bIJtTlrChjCVTHSg79rn0iBvfwkF6rA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TsDLhZkPcistUB5ojF3pRvDqORj2/b0+ZHzfPUghudjqB23KD0p+OXQJQbF9bYbPL
	 05sGbi5PiaAsvIY9UUjjnxC5tnRqeLzEHeIcNDQckKyejLF5P7vHDzO0OtJwQp+uKu
	 DnaPO2aB9hjd6g99KQL7wkDJ80gKYN1+V33zAkLUSX7Nl++dtI1mU25yGPtNEI9Qjb
	 /UAb2GrvLyIJaAVOhaDc4AE/pf6GH8v0lpq+si6S6GgdOIjrrP7wBF/to6ty57FGFn
	 4rvDE7VnCZeWAx+0kQo4iLo83yH9oh0nY50htsvGkRCUt/cy8QOSgVzRze5uAZ1LRE
	 zAiwdCA4FEhfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/29] perf zstd: Fix compression error path in
 zstd_compress_stream_to_records()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525010550.1100375-5-acme@kernel.org>
References: <20260525010550.1100375-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 01:52:23 +0000
Message-Id: <20260525015224.3C8241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `record__pushfn` overwrites the first compressed record's header w=
ith the total compressed size, corrupting multi-record streams and causing =
16-bit integer overflows.
--

commit e64058a4ff7a3dc25fc5fbbc6baeab2ab6b31aa4
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon May 25 01:05:24 2026 +0000

    perf zstd: Fix compression error path in zstd_compress_stream_to_record=
s()

This commit replaces the compression error fallback in
zstd_compress_stream_to_records() with an explicit error return after reset=
ting
the ZSTD context. It also adds a new label out_child_no_flush in __cmd_reco=
rd()
to skip the final flush on mmap read failures, and guards against missing
output buffer space before writing headers.

> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index 57027e0ac7b65..ecda9deb53b73 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c
[ ... ]
> @@ -65,10 +72,18 @@ ssize_t zstd_compress_stream_to_records(struct zstd_d=
ata *data, void *dst, size_
>  		if (ZSTD_isError(ret)) {
>  			pr_err("failed to compress %ld bytes: %s\n",
>  				(long)src_size, ZSTD_getErrorName(ret));
> -			memcpy(dst, src, src_size);
> -			return src_size;
> +			goto reset;
>  		}
>  		size =3D output.pos;
[ ... ]
>  		size =3D process_header(record, size);
>  		compressed +=3D size;
>  		dst +=3D size;
> @@ -76,6 +91,14 @@ ssize_t zstd_compress_stream_to_records(struct zstd_da=
ta *data, void *dst, size_
>  	}
> =20
>  	return compressed;

[Severity: High]
This is a pre-existing issue, but I have a question about how this returned
value is handled by the caller.

When zstd_compress_stream_to_records() emits multiple chunks and returns the
total combined size of all chunks, does the caller handle it correctly?

Looking at record__pushfn() in tools/perf/builtin-record.c, it unconditiona=
lly
assumes a single chunk is returned and overwrites the first chunk's header =
with
this total size:

    ssize_t compressed =3D zstd_compress(rec->session, map, map->data,
                                       mmap__mmap_len(map), bf, size);
    ...
    event->data_size =3D compressed - sizeof(struct perf_record_compressed2=
);
    event->header.size =3D PERF_ALIGN(compressed, sizeof(u64));

If the total combined size exceeds 65535 bytes, will this truncate header.s=
ize
(which is a u16) and corrupt the stream's event boundaries?

Also, by treating the concatenated chunks as a single payload, will the ZSTD
decompressor eventually read the embedded perf_event_header of the second c=
hunk
as if it were compressed ZSTD data, irreparably corrupting the profile and
causing decompression to fail?

> +
> +reset:
> +	/* Reset so the context is usable if the caller retries */
> +	ret =3D ZSTD_initCStream(data->cstream, data->comp_level);
> +	if (ZSTD_isError(ret))
> +		pr_err("failed to reset compression context: %s\n",
> +			ZSTD_getErrorName(ret));
> +	return -1;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525010550.1100=
375-1-acme@kernel.org?part=3D4
