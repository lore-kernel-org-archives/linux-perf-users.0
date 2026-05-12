Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7784347C7
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544822; cv=none; b=JDc/gINCnogmJc0E62lSR/iuTdAAtTLnTJhgZvP2h9MwV+3gTswT8sRA1gmPyYWUzfN4hhVibCfmi5kA8YyIY3Grv8duS4oaBaLvrJuo9y1N12ayL3wEpeJBNQM6C/QHPPtV4gYyceKv6aMyZjU4lyeomM3D+m2vlN+xYhONSr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544822; c=relaxed/simple;
	bh=E/y1ZxzF3CtqKS6qnnbuEnS2SZMX04ado+eCOxzN2EA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X+G1802Kng0zPO3w373bMhMEByX00rXnS4c/eMRCuxMaCr9muGb2p0ey6CGf5WlOkXC1uE68PYex3pJeRtd9zqvCuw4mx6M1KgkEvWv1v+knJWQbOqM0m7k9uRkhFbBDm056Z5/5m2Jxq/CuxzYUWMHyhX1JzFf4AWu0wmtfrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9j1N65Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9j1N65Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7783FC2BCB0;
	Tue, 12 May 2026 00:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778544821;
	bh=E/y1ZxzF3CtqKS6qnnbuEnS2SZMX04ado+eCOxzN2EA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=b9j1N65QYqGfaHJiR4hIwB3Q4iXlvypsrnbBAHecdt97Z+vSYuZY998zWxOtRbWNM
	 DWeUeD48PumHk64B1r3/EgJu0J9PY6OQOASsnCttFcGO/w6KZyKd4FkwrNt52XplGP
	 YLpih/MVL7EftEHKZMtihNRDvie0b2L+Jy3/saaZmNlnBEN+/aOWGV0ivtlccvMQ2r
	 PlLKu/7iSOcwsKMTVimFpQykPabLT4yDl+m4VMUqTVEJfSpqV8k+BafvZ10jeeUNwL
	 /cwZ4YR8HCARfCkObBanshLpvTvUs+pQ22l2rH2JW2qzp7wWM4zqQNKXElyd4BEPHb
	 imfkO6U3ZCMGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/28] perf zstd: Fix compression error path in
 zstd_compress_stream_to_records()
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510033424.255812-4-acme@kernel.org>
References: <20260510033424.255812-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 00:13:40 +0000
Message-Id: <20260512001341.7783FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Out-of-bounds write occurs before the newly added buffer size guard
- [High] Unsigned integer underflow and memory leak when compression yields=
 0 bytes
- [High] Missing context reset on buffer-full error path causes state corru=
ption
- [High] Error propagation causes deterministic failure for incompressible =
data
- [High] Returning -1 on compression failure causes duplicated events
- [Medium] Ignored ZSTD_flushStream return value masks compression errors
--

commit 6e057a82790023201cbd71817c336d831f984f7f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf zstd: Fix compression error path in zstd_compress_stream_to_records()

This commit changes the error handling in zstd_compress_stream_to_records()
from falling back to uncompressed data to returning -1 and resetting the
compression stream. It also adds a bounds check to prevent dst_size underfl=
ows.

> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c
> @@ -55,6 +55,9 @@ ssize_t zstd_compress_stream_to_records(struct zstd_dat=
a *data, void *dst, size_
>  	while (input.pos < input.size) {
>  		record =3D dst;
>  		size =3D process_header(record, 0);

The process_header callback writes the event header to the record pointer
unconditionally. Since this happens before the newly added dst_size check,
can this cause an out-of-bounds write if the remaining dst_size is smaller
than the header size?

> +		/* Output buffer full =E2=80=94 cannot fit even the record header */
> +		if (size > dst_size)
> +			return -1;

The patch adds a context reset for ZSTD errors so the stream is usable
for flush retries. However, this early return for a full buffer exits
without resetting the context. Will the caller retry flushing with a
partially compressed internal state, producing corrupted output?

Replacing the uncompressed fallback with returning -1 propagates the error
to perf_mmap__push.

If a ring buffer wrap occurs and the second half returns -1, will
perf_mmap__push abort and skip perf_mmap__consume, leaving the
kernel buffer tail pointer unmodified and duplicating the first half on
the next read cycle?

Additionally, if a chunk is incompressible and its size exceeds the static
destination buffer size, will the out_child retry loop overflow again and
permanently block?

[ ... ]

> @@ -65,8 +68,16 @@ ssize_t zstd_compress_stream_to_records(struct zstd_da=
ta *data, void *dst, size_
>  		ret =3D ZSTD_compressStream(data->cstream, &output, &input);
>  		ZSTD_flushStream(data->cstream, &output);

This isn't a bug introduced by this patch, but the return value of
ZSTD_flushStream is not captured in ret. Does the subsequent
if (ZSTD_isError(ret)) check silently discard flush errors, leading to
truncated records?

>  		if (ZSTD_isError(ret)) {

[ ... ]

>  		}
>  		size =3D output.pos;
>  		size =3D process_header(record, size);

This isn't a bug introduced by this patch, but if ZSTD_compressStream and
ZSTD_flushStream produce 0 bytes, output.pos and size will be 0.

Since process_header(record, 0) acts as an initialization command and
returns the header size again, will this code subtract the header size
from dst_size a second time?

Could this cause dst_size to underflow, completely defeating bounds
checks on the next iteration and leaking uninitialized memory into the
output?

>  		compressed +=3D size;
>  		dst +=3D size;
>  		dst_size -=3D size;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510033424.2558=
12-1-acme@kernel.org?part=3D3
