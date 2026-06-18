Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6373745BE3
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jun 2026 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799861; cv=none; b=bv4AAl5qXGA5+ejiLpWKiZgbmUJz6oPbSj072q9UZqt0atqfg5VilbJF+omJ345d+sSn8tD+Ch47Sw1dqCHstibdGn1oatYm+x4r6a5VDq4gm9MYXyvAvmRbfQsE0BuhYtnd9JSrNpY+APmVBcEFRfNKXNBbDs8jQhrQcW6N4D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799861; c=relaxed/simple;
	bh=FO+0/TYzvhvoI++ACqMg6MxEQuO77ACKH3sR4cQaGvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lGQu9nKHgQYS4cqEFk9vYziy4vYazKnkrfpDkyszBcrMHkugzWjGSLYW47yQQIRhMPiz6IQpr7sS2fMurXqufPxYdbGLUsjYK+igQ60o41ga/ifJfr0op+Xw72LM8q83akLqP3lEazNxizoBN5Xu2hsMB1RUlFIYq+hXI9DKdpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8+4kBgd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8+4kBgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51761F000E9;
	Thu, 18 Jun 2026 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781799860;
	bh=gggsSEf0UJAzt/SDWvfXzo1VvsOHrZmp7pSjm4xmUtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O8+4kBgd+QHLjC3RaPxRwt0zGZsYMbZdugxfdTlZMsuFJ1qD2mIU+WMGDO2QVn7Ou
	 I1vUz36tcmUq/Qsz/G16WnsR8gFaIbJZWpv3cC4r5WBeblexMMBT23WeIH/jnute0o
	 GZqI4PHART5Mq8eVG6Vg56m6l0uyty08g3GEEOZnsrHREEXjNsL0b2BeLoKbElhAi2
	 EqCPiJfFN1At8AX9GOsl38r9yLPXHMyPtjORgmsJy479v2rFE+u+8lMuB4awQobrl0
	 3kYfVpe9GtKGuXteLlJZUYSS3Sqi1tSVSw9ZDaI1KWVN5n+xkijUNln24CqyhfuyNh
	 AVqchODdbrwTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf record: Don't store raw data on zstd
 compression failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Ilvokhin" <d@ilvokhin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <6fb9225500ede2bb607a287d6b8b5bea9065b780.1781797544.git.d@ilvokhin.com>
References: <cover.1781797544.git.d@ilvokhin.com>
 <6fb9225500ede2bb607a287d6b8b5bea9065b780.1781797544.git.d@ilvokhin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 16:24:19 +0000
Message-Id: <20260618162419.D51761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The `zstd_decompress_stream` function incorrectly updates the =
output buffer pointer, causing an out-of-bounds write and data corruption.
- [Critical] Buffer overflow via integer underflow in `zstd_compress_stream=
_to_records` bypasses the bounds check.
- [High] Unflushed compressed data is left in the ZSTD internal buffer and =
permanently lost at the end of a recording session.
- [High] The return value of `ZSTD_flushStream()` is entirely ignored, mask=
ing potential compression state errors.
- [High] A missing `perf_mmap__put` in the error path of `record__aio_push`=
 causes a reference count leak of `map->core`.
- [High] Skipped `perf_mmap__consume` on partial failure causes duplicate e=
vent records in the `perf.data` file.
- [High] An overly strict bounds check in `zstd_compress_stream_to_records`=
 causes `perf record` to abort when compressing large chunks of trace data.
--

commit 460b94129652aafbc57f9667aa7c4a4a81ffacbe
Author: Dmitry Ilvokhin <d@ilvokhin.com>

perf record: Don't store raw data on zstd compression failure

On a ZSTD_compressStream() error, zstd_compress_stream_to_records()
falls back to copying the uncompressed input into the output buffer and
returning its size. That cannot work:

- a COMPRESSED2 payload is always fed to zstd_decompress_stream(), so
  raw bytes placed there can never be read back.

- the record header is never finalized: process_header() is not called
  to write the real header.size and data_size, so they keep their
  initial values and do not match the bytes written.

- the copy is unbounded and can write past the output buffer.

Propagate the error instead.

Fixes: f24c1d7523e6 ("perf tools: Introduce Zstd streaming based compressio=
n API")

> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> index a0f6572ad2017..2de777d49ee0b 100644
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c
[ ... ]
> @@ -71,8 +69,7 @@ ssize_t zstd_compress_stream_to_records(struct zstd_dat=
a *data, void *dst, size_
>  		if (ZSTD_isError(ret)) {
>  			pr_err("failed to compress %ld bytes: %s\n",
>  				(long)src_size, ZSTD_getErrorName(ret));
> -			memcpy(dst, src, src_size);
> -			return src_size;
> +			return -1;
>  		}
>  		size =3D output.pos;
>  		size =3D process_header(record, size);

[Severity: High]
This isn't a bug introduced by this patch, but does the loop ignore the
return value of ZSTD_flushStream()?

Looking at zstd_compress_stream_to_records():

		ret =3D ZSTD_compressStream(data->cstream, &output, &input);
		ZSTD_flushStream(data->cstream, &output);
		if (ZSTD_isError(ret)) {

The return value of ZSTD_flushStream() is never checked. The subsequent
ZSTD_isError(ret) only evaluates the error code of ZSTD_compressStream().
If the flush operation encounters a failure, the error code is discarded,
potentially resulting in silently corrupted data streams or emitting an
incomplete compressed payload without propagating an error to the user.


[Severity: High]
This is a pre-existing issue, but does zstd_compress_stream_to_records()
leave unflushed compressed data in the ZSTD internal buffer?

In tools/perf/util/zstd.c:zstd_compress_stream_to_records():

	while (input.pos < input.size) {
        ...

The loop exits strictly when input.pos =3D=3D input.size. Since
ZSTD_flushStream() can leave unflushed data in the internal compression
stream if the output buffer fills up, and perf record never calls
ZSTD_endStream() to force a final flush at the end of the session, any
remaining compressed data trapped in the stream buffer is silently and
permanently lost, resulting in truncated or corrupted trace files.


[Severity: Critical]
This is a pre-existing issue, but does zstd_decompress_stream() incorrectly
advance the output buffer pointer, causing an out-of-bounds write?

In tools/perf/util/zstd.c:zstd_decompress_stream():

	while (input.pos < input.size) {
		ret =3D ZSTD_decompressStream(data->dstream, &output, &input);
        ...
		output.dst  =3D dst + output.pos;
		output.size =3D dst_size - output.pos;
	}

The output.dst pointer is advanced by output.pos
(output.dst =3D dst + output.pos). However, output.pos is the accumulated
number of bytes written, which ZSTD_decompressStream() internally adds to
output.dst. This evaluates to an effective write address of
dst + 2 * output.pos.

Consequently, the decompression loop skips over output.pos bytes on every
iteration, leaving uninitialized gaps in the decompressed output and quickly
writing past the dst_size bounds, causing severe memory corruption.


[Severity: Critical]
This is a pre-existing issue, but does zstd_compress_stream_to_records()
have a buffer overflow via integer underflow that bypasses bounds checking?

In tools/perf/util/zstd.c:zstd_compress_stream_to_records():

		if (hdr_size &&
		    dst_size < hdr_size + max_record_size + sizeof(u64)) {
			pr_err("failed to compress: output buffer too small\n");
			return -1;
		}
		record =3D dst;
		size =3D process_header(record, 0);

When perf_mmap__push() splits the ring buffer, the second chunk can be
passed to zstd_compress() with a very small dst_size (e.g., 8 bytes). Since
hdr_size is initially 0, the boundary check is bypassed on the first
iteration.

process_header() unconditionally writes a 24-byte header into the <24 byte
remaining buffer, corrupting memory. Then dst_size -=3D 24 underflows to a
huge value (SIZE_MAX), causing ZSTD_compressStream() to write up to 64KB
(max_record_size) entirely out of bounds.


[Severity: High]
This is a pre-existing issue, but does the error path in record__aio_push()
cause a reference count leak of map->core?

In tools/perf/builtin-record.c:record__aio_push():

	if (ret !=3D 0) /* ret > 0 - no data, ret < 0 - error */
		return ret;

When zstd_compress() fails on the second mmap chunk, record__aio_pushfn()
propagates the error (< 0). perf_mmap__push() then aborts and returns the
error code.

The code checks if (ret !=3D 0) and returns immediately, skipping the
perf_mmap__put(&map->core) cleanup that balances the perf_mmap__get()
acquired during the successful first chunk. This unhandled error path causes
an LSAN-reportable memory leak and violates perf tool reference counting
invariants.


[Severity: High]
This is a pre-existing issue, but does skipping perf_mmap__consume() on
partial failure cause duplicate event records in the perf.data file?

In tools/perf/util/mmap.c:perf_mmap__push():

	if (push(md, to, buf, size) < 0) {
		rc =3D -1;
		goto out;
	}

If the second chunk of a split ring buffer fails during zstd_compress(),
perf_mmap__push() aborts via goto out, skipping the
perf_mmap__consume(&md->core) call.

Because perf_mmap__consume() is skipped, the ring buffer's consumer tail
pointer is never advanced, even though the first chunk was successfully
compressed and written. The caller record__mmap_read_evlist() receives the
error, aborts, and triggers a retry via record__mmap_read_all(rec, true),
which reads and writes the exact same first chunk again, resulting in
duplicated events and corrupted profiling data.


[Severity: High]
This is a pre-existing issue, but does an overly strict bounds check in
zstd_compress_stream_to_records() cause perf record to improperly abort?

In tools/perf/util/zstd.c:zstd_compress_stream_to_records():

		if (hdr_size &&
		    dst_size < hdr_size + max_record_size + sizeof(u64)) {
			pr_err("failed to compress: output buffer too small\n");
			return -1;
		}

The loop requires dst_size to be larger than approximately 64KB
(hdr_size + max_record_size + sizeof(u64)) to proceed to the next iteration.

If the remaining buffer space falls below this threshold near the end of a
compression loop, it unconditionally returns -1 and prints "output buffer
too small", even if only a few bytes of input remain to be compressed. This
logic effectively turns a normal buffer sizing condition into a fatal error,
instantly aborting the entire perf record session.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781797544.gi=
t.d@ilvokhin.com?part=3D3
