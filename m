Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFEE199931
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 04:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779595615; cv=none; b=X7zSLsG++afzCcRTwBb9lMj6PrfpqdzlscSlF/SxvXtr6LHNEdixlFjrLNxcrRcsKTiFkWRYfYK+ultKPkBoS3BXxioviG4l+xoxid5MNgVRKrmN56Dp82vfNe7kOqYGKPZnjCMQkPO2VcjQSoZjtAaESrGsbLkG/Bl94gRIxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779595615; c=relaxed/simple;
	bh=rCVtHVuy+/UQALCqQyMMN2uSscitEov9cO3yA/hf5bI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NZlNWLRUjUFmUf6OIarDAqfgjPAXF14BksJxEYvIGU2mxbnx53edxQLh2dJsc842jpmbvWyaSJetHoaBqHgSK7QkkN5cmz+owAYh3B6qoHONOkZPRPMfdqF0Hyvuo/PR+t5PNn0ngIvYbyzTA/VXCaPKDWW2Bx2JpsuryAIUU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzmtTyDA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzmtTyDA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4871F000E9;
	Sun, 24 May 2026 04:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779595613;
	bh=HuQWWqJfx0n+feUCVX4pxTn6CSBoty6LPP18jqhTDH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AzmtTyDApt4IGhPaneep0gdyyRst2IvfQpyDboWPMaFnuQMA9FXLczbtNqciQI2YP
	 BNyRdbDQbkMiqj28hcwNQewLb+dMe4LMyXcfzOaK+xt0VDHFOwPs0ooIiJuYEghyPW
	 ZTfNKxd8o5IuKg3zlnWB6DOTyz7lwGNBuC6g8d3OJIP/Yn75UtF9uvMPJGc8GMNO/C
	 z7x+Q1BmkiF8/wWSj7V7Ya2j1t0CFvTls1yBZ+rN+lLHD4DNENyaQz4m4L+c6bYLLQ
	 gsfkGuNrBemzl4RKFaj6J8IjakSAo3QCG6olPNWUgNtGpG4N4BBGo/ESDiedVrXxuk
	 NIovDf9APRF0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/29] perf zstd: Fix compression error path in
 zstd_compress_stream_to_records()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524032709.1080771-5-acme@kernel.org>
References: <20260524032709.1080771-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 04:06:53 +0000
Message-Id: <20260524040653.6A4871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch skips the final record__mmap_read_all() flush on error i=
n the main thread to avoid retrying a failed read, but misses the identical=
 retry path in parallel worker threads.

Pre-existing issues:
- [High] ZSTD compression silently corrupts the perf.data stream if the out=
put requires multiple records, because record__pushfn overwrites the multi-=
record headers and incorrectly wraps them into a single record.
- [High] The `zstd_compress_stream_to_records` loop advances the `dst` buff=
er by unaligned sizes, which can trigger unaligned memory access exceptions=
 on strict architectures.
--

commit 62a2343957107fded20fb827b93d6a1cadb0934a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf zstd: Fix compression error path in zstd_compress_stream_to_records()

This commit fixes bugs in the error fallback path of
zstd_compress_stream_to_records(). It returns -1 on error instead of doing
an unsafe memcpy, skips the final flush on mmap-read failure, and adds
boundary checks to ensure the compression context is properly reset.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c

[ ... ]

> @@ -2890,6 +2890,10 @@ static int __cmd_record(struct record *rec, int ar=
gc, const char **argv)
>  out_child:
>  	record__stop_threads(rec);
>  	record__mmap_read_all(rec, true);
> +	goto out_free_threads;
> +out_child_no_flush:
> +	/* mmap read already failed =E2=80=94 retrying would just fail again */
> +	record__stop_threads(rec);

[Severity: High]
The patch avoids retrying the failed read in the main thread by skipping
record__mmap_read_all() here, but what happens in parallel worker threads?

If a parallel worker thread running record__thread() encounters a read
error, it breaks its loop and unconditionally calls
record__mmap_read_all(thread->rec, true).=20

Does this circumvent the error handling logic and cause the worker thread
to immediately retry the failed read?

>  out_free_threads:
>  	record__free_thread_data(rec);
>  	evlist__finalize_ctlfd(rec->evlist);

> diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
> --- a/tools/perf/util/zstd.c
> +++ b/tools/perf/util/zstd.c

[ ... ]

> @@ -54,7 +55,13 @@ ssize_t zstd_compress_stream_to_records(struct zstd_da=
ta *data, void *dst, size_
> =20
>  	while (input.pos < input.size) {
>  		record =3D dst;
> +		/* process_header writes the event header into record */
> +		if (dst_size < sizeof(struct perf_event_header))
> +			goto reset;
>  		size =3D process_header(record, 0);

[Severity: High]
This is a pre-existing issue, but does this function corrupt the perf.data
stream if the output requires multiple records?

If the compressed output exceeds max_record_size, this loop splits it into
multiple chunks with a new perf_event_header for each. However,
record__pushfn() assumes a single event is returned and blindly overwrites
the first event's header.size and data_size with the total size of all
chunks.

Since header.size is a u16, will it overflow and truncate if the total size
exceeds 65535 bytes, while also swallowing subsequent headers into the
payload?

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
This is a pre-existing issue, but does advancing dst by an unaligned
size cause a crash on strict architectures?

Since output.pos is not guaranteed to be 8-byte or 4-byte aligned, dst
can become unaligned here.=20

On the next iteration, process_header() casts this unaligned address to
struct perf_record_compressed2 * and writes a 32-bit value to
event->header.type. Will this raise a SIGBUS exception on architectures
like SPARC?

>  	}
> =20
>  	return compressed;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524032709.1080=
771-1-acme@kernel.org?part=3D4
