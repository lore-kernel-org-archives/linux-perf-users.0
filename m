Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB5277C81
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832812; cv=none; b=uuijcaasfcXg7ybOtZPFSvFuE4iRoRg8sR/Q5kyBpnXpVnKblFRBC5IQo/Un9VBdjB6oLISVP39fKufUBC9mGd6n8LNFXQPAbS2kSMOsrrKLjeesWWRcVvoB/03/MEZi/fX7GSokMsuh6y579v7av6oXgsadz6KaWYz4+WbX0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832812; c=relaxed/simple;
	bh=LKAX4BCZug/06Y5htIL+hfqkVvftEWq3yxjiqy8JNfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VzJbbyrnYKyDcA3vb8zP1qETSgpzJRntf685UpzhogfHh+7vP8kd0A8L4B/lfUQd1nH4uRpeqkktK853f3m4jMtFKzvJR59Rc8bSrZeAJqHjsUTipfki3YK4yaKQmGpTjhW8aK5qpcAz2h4WG9fAtVj5eh3uP19Y3MVOgrIobVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXYcA0Ts; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXYcA0Ts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AF21F000E9;
	Tue, 26 May 2026 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832809;
	bh=8csMbNv9LbCPXjegoPBezAE2AvaiAzYUPQGYUYKU9us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cXYcA0Ts+1BFYdVd1Ci9x1Ht4L8IBc4LLjuIArKkyYZZeoAUfJ0RHr6KytHdyymDh
	 K7CgoYXDxvIo05Lu6z/7RdqNxYofFAgbji+pvQFkrl2JFywmubLVqAQ5QQcYYcQrEW
	 O81Uvic7fNFe7CkQufHEIKgwr0Ov71Q7PD+KjaZWNOMZkDEmjEw6lcBjneWFQ00BG9
	 nr7cvxFhWh0WvgoLgq8WjLOjzAXFmPDU6U0xvFrwXQK0RbVv8pnL9K7Y6WBheNQ36V
	 WAZzCNWCRgMo2tDCoZxJUPX9LTBcv4u+iTrzqoUmeh31lUW1JpG5vaBYGk+DnMzAje
	 wSMTjK3prGrHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/29] perf zstd: Fix compression error path in
 zstd_compress_stream_to_records()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526211806.1193848-5-acme@kernel.org>
References: <20260526211806.1193848-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 22:00:08 +0000
Message-Id: <20260526220008.C2AF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Mishandling of multi-record compressed streams leads to header=
 size overflow, stream corruption, and out-of-bounds stack reads.
- [High] AIO compressed records contain an uninitialized `data_size` field,=
 breaking decompression.
- [High] `ZSTD_flushStream()` is invoked on potentially errored contexts an=
d its return value is ignored, causing silent data loss.
- [High] `zstd_decompress_stream` manually advances the output buffer point=
ers without resetting `output.pos`, leading to double-increment and uniniti=
alized memory gaps.
--

commit e4a35c8e9f1ac44e063d21b4f97da413caa1b375
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf zstd: Fix compression error path in zstd_compress_stream_to_records()

This commit fixes multiple issues in the error paths of
zstd_compress_stream_to_records(). It properly resets the ZSTD
compression context on failures instead of incorrectly copying
uncompressed data, and ensures process_header() doesn't write past the
output buffer. It also fixes dst_size underflows and adds an
out_child_no_flush label to prevent retrying failed mmap reads.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index cc601796b2c8a..f1877bac815d7 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
[ ... ]
> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index 57027e0ac7b65..ecda9deb53b73 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c
[ ... ]
> @@ -54,7 +55,13 @@ ssize_t zstd_compress_stream_to_records(struct zstd_da=
ta *data, void *dst, size_
> =20
>  	while (input.pos < input.size) {
>  		record =3D dst;

[Severity: Critical]
This is a pre-existing issue, but does returning the aggregate size of
multiple compressed records from this loop cause problems for callers like
record__pushfn()?

If record__pushfn() assumes the output is a single record and assigns
the total aggregate size to event->header.size, a total compressed size
exceeding 65535 bytes could cause the 16-bit header.size to overflow and
truncate.

This truncation could cause an underflow in the subsequent padding
calculation (padding =3D event->header.size - compressed), resulting in a
massive size passed to record__write(&pad, padding) which would dump
out-of-bounds stack memory into the trace file.

> +		/* process_header writes the event header into record */
> +		if (dst_size < sizeof(struct perf_event_header))
> +			goto reset;
>  		size =3D process_header(record, 0);

[Severity: High]
This isn't a bug introduced by this patch, but does the process_header
callback leave the 8-byte data_size field uninitialized in AIO mode?

In AIO mode, record__aio_pushfn() calls zstd_compress() but does not
manually set event->data_size. When process_header() initializes
header.type and header.size, the data_size field appears to be left
uninitialized.

This causes perf_session__process_compressed_event() to fail
decompression when reading perf.data.

> +		/* Output buffer full =E2=80=94 cannot fit even the record header */
> +		if (size > dst_size)
> +			goto reset;
>  		compressed +=3D size;
>  		dst +=3D size;
>  		dst_size -=3D size;
[ ... ]
> @@ -65,10 +72,18 @@ ssize_t zstd_compress_stream_to_records(struct zstd_d=
ata *data, void *dst, size_
>  		if (ZSTD_isError(ret)) {

[Severity: High]
This is a pre-existing issue, but does calling ZSTD_flushStream() just
before this error check, without verifying if ZSTD_compressStream()
succeeded, violate the API contract?

Also, the return value of ZSTD_flushStream() is discarded. If the output
buffer fills up during flush, ZSTD returns > 0 to indicate more flushing
is required.

Because the loop only evaluates input.pos < input.size, if the input is
exhausted but the flush is incomplete, the loop will exit and leave the
remaining compressed data trapped in the internal context, dropping data.

>  			pr_err("failed to compress %ld bytes: %s\n",
>  				(long)src_size, ZSTD_getErrorName(ret));
> -			memcpy(dst, src, src_size);
> -			return src_size;
> +			goto reset;
>  		}
>  		size =3D output.pos;
[ ... ]
> @@ -76,6 +91,14 @@ ssize_t zstd_compress_stream_to_records(struct zstd_da=
ta *data, void *dst, size_
>  	}
> =20
>  	return compressed;
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
This isn't a bug introduced by this patch, but does
zstd_decompress_stream() fail to reset output.pos to 0 during each
iteration?

At the end of the decompression loop:

    output.dst  =3D dst + output.pos;
    output.size =3D dst_size - output.pos;

Without resetting output.pos =3D 0, the next iteration will write at
(dst + pos) + pos, skipping memory and leaving uninitialized gaps.

I see this was fixed later in the series in commit e38284f65bb96
("perf zstd: Fix multi-iteration decompression and error handling").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526211806.1193=
848-1-acme@kernel.org?part=3D4
