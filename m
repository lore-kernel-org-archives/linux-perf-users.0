Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D783101B6
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779328171; cv=none; b=E6eD6AUe8BbCvnaLiKLAd9O3kC3Qp01YHfv2AStZLfz8UbfuVdBtdrpnKcaFCT2rdNfC4P1GjOs6mwTm+x/gviNxe0tEvxHhA/mNvDow/cmwgJOT2lMBQ7DRkaWwAWlJKOmN5iMUzlaTkapDhKJvwqHeeGshqFOFQzmGBdh6CpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779328171; c=relaxed/simple;
	bh=Lne8TopiaGTUHpK3jptOVN4rg84Na2YcL0i2vEQ1fG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H3FZr++/ssjE1/O8Q3EOgr2j0eHUk+j+Nv0m4oJxwhcLUlBfr98mSRbOFG8z7qCFYwS6NrqwZmlutnWVkfNQ/ABFWxlA9L9deWhBlcvNrIndm4MaFd7WxI57L/iOWrg/JXwUsIZfExz3OZ9Hxv8jOacJUJs2w86uYY2bx9TAPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmUCjzpg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmUCjzpg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514871F000E9;
	Thu, 21 May 2026 01:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779328162;
	bh=J2ycN9mmk2cRqyo+b/tHZZokRcYBcQ930Uww0rSR0PY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mmUCjzpgiYiGH6kolcCvNxQRz6VPXpJMGLwGGhtsllluN+vGRYxVvPEN5rWSAz5OL
	 V0so5hR5+OoklFDsOLM5CMYM6r2wf/WUX/r/Vsxz2pCPkgfjTKc95elr3sxTVa8PGr
	 IrpfmcrDyxC1MyB0Q+6JMCUg9WRznDlGp/6vzZe83vbhuBYP5YloacFa+cyAnotZH1
	 ua7LclGO6v3K22DBizcZLjfOXcbuattMFOC533Ruz7r+EHWpgceQN34/xMmaaVuAwW
	 TfdCQHnuv6afy1bPuWPmpSR1mzuQsPYTAoMoK8y0MNZZKtpA83F2ebuIf00AMXf97o
	 uEAYsnKtEL5qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/27] perf zstd: Fix compression error path in
 zstd_compress_stream_to_records()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260521011027.622268-4-acme@kernel.org>
References: <20260521011027.622268-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 01:49:21 +0000
Message-Id: <20260521014922.514871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] zstd_compress_stream_to_records produces unaligned event headers w=
hen splitting streams.
- [High] record__pushfn corrupts multi-record compressed output by forceful=
ly overwriting the first header, treating interleaved headers as payload.
- [High] zstd_decompress_stream corrupts the destination buffer and leaks m=
emory contents due to an unreset output.pos variable.
--

commit 560499759a9003b90691766e1e9ac645ad871d8e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf zstd: Fix compression error path in zstd_compress_stream_to_records()

The error fallback does memcpy(dst, src, src_size) intending to store
uncompressed data when compression fails, but this has three bugs.

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
> +		/*
> +		 * No progress: ZSTD couldn't emit any bytes into the
> +		 * remaining output buffer.  Calling process_header
> +		 * with size=3D0 would re-trigger header initialization,
> +		 * double-subtracting the header size from dst_size and
> +		 * underflowing the unsigned counter.
> +		 */
> +		if (size =3D=3D 0)
> +			goto reset;
>  		size =3D process_header(record, size);
>  		compressed +=3D size;
>  		dst +=3D size;

[Severity: High]
This is a pre-existing issue, but does advancing dst exactly by size (which
includes output.pos, the raw compressed payload size) cause subsequent loop
iterations to write new perf_event_header structures to unaligned memory
addresses?

Since output.pos is not guaranteed to be 8-byte aligned, will this cause
unaligned memory access crashes on architectures with strict alignment
requirements, and violate the perf.data specification?

>  		dst_size -=3D size;
>  	}
> =20
>  	return compressed;

[Severity: High]
This is a pre-existing issue, but does record__pushfn() corrupt multi-record
compressed output when calling this function?

Since zstd_compress_stream_to_records() splits large streams into multiple
independent events by interleaving raw perf_event_header structures, will
record__pushfn() forcibly overwrite the first header to span the entire
compressed byte count?

During decompression, will ZSTD_decompressStream() encounter these raw bina=
ry
headers inside the ZSTD stream and fail?

> +
> +reset:
> +	/* Reset so the context is usable if the caller retries */
> +	ret =3D ZSTD_initCStream(data->cstream, data->comp_level);
> +	if (ZSTD_isError(ret))
> +		pr_err("failed to reset compression context: %s\n",
> +			ZSTD_getErrorName(ret));
> +	return -1;
>  }
> =20
>  size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t =
src_size,

[Severity: High]
This is a pre-existing issue, but does zstd_decompress_stream() corrupt the
destination buffer and leak memory contents?

Inside the zstd_decompress_stream() loop, the code dynamically updates
output.dst =3D dst + output.pos, but does it fail to reset output.pos to 0?

Because ZSTD_decompressStream() always writes to output.dst + output.pos,
will the second iteration skip old_pos bytes of the destination buffer,
leaving them uninitialized, and write the next chunk of decompressed data
after the gap?

Note: This was fixed in commit 3c5751e39541b ("perf zstd: Fix multi-iterati=
on
decompression and error handling") later in the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521011027.6222=
68-1-acme@kernel.org?part=3D3
