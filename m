Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E6F29A32D
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779834205; cv=none; b=feZpT6Nku45HWkWZqSzEAw6Mscc53e4bT69y5hpFkcssxnFvMnzrYF+jtySbFQKvsa/Up2gdkV49tT62LlEdCfeCwTUUoiJmWhT2bLB+Q1wq9y1vd1ssY2BVTpNV6dC2JZFJ2ATFLAmCfvPTacb14h1vp+vohhoQgw8ZLA+D6es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779834205; c=relaxed/simple;
	bh=yVeMKCjqU7T9ODXsHU8AmqTOn+nNSIfWCFlSRuVN5m8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pbjSL2ragKM0a9KqHLA1rtHUqF822R9EWuTZcxoxX28bgH07UKSSwT23JRZGJ1z2p8bl5N5odVJlqqr2kWdrALCr2G0tJR7zBZYCyaN4r2xPSC3Dn4L4nDywjrXZAbZJownKFgK6tfK9/HxiR5qj4f6Okhedph29GXgerPQww6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jP7zTbaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jP7zTbaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0861F000E9;
	Tue, 26 May 2026 22:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779834204;
	bh=UbQMtKYfTD/z1hFra2WJrCURH2LIlIKXHveMcMrGKPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jP7zTbaDNgUQXcyqEpCz9roJbvkuorIePVfVtHb3TDw3qKrJHkkPE5RRnKh/maB7Q
	 iBD2lHZchc4N9hBaAjlDiB6+KFwgjbRgu6XoZEIJohwEhlJepUfiLv/0hKI18Rh4q7
	 316rdrwvAWgmA5FoCjawoukMhaGCYPTuVgqBMwEmmfTHWnMQIdWylm/16ApckuvqsV
	 VyNyZ6agvpxwrqRwiTisLxPr+sa9bz2FDv8uplgA1lfc9cULagaou65s1UBT+diOU1
	 sYvVFRlCpq1hU3Fdj321a9iHUreDJAT/7etoc9aD9iGkUo0L1TOjQFOEpm/HSWfHxn
	 IlKZwk2TrJGlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/29] perf tools: Harden compressed event processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526211806.1193848-25-acme@kernel.org>
References: <20260526211806.1193848-25-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 22:23:23 +0000
Message-Id: <20260526222324.0F0861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Double-fetch of event header size from a memory-mapped file lead=
s to integer underflow and out-of-bounds read.
--

commit 6f8ff54f59a432aeacf15c3aba9115ca23082597
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Harden compressed event processing

This commit adds several hardening checks to the compressed event
decompression pipeline. It validates comp_mmap_len, checks for underflow
in decomp_last_rem, and ensures event header sizes are large enough to
contain the fixed struct fields.

> diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> --- a/tools/perf/util/tool.c
> +++ b/tools/perf/util/tool.c

[ ... ]

> @@ -47,14 +55,37 @@ static int perf_session__process_compressed_event(con=
st struct perf_tool *tool _
>  		decomp->size =3D decomp_last_rem;
>  	}
> =20
> +	/*
> +	 * Events are read directly from the mmap'd file; fields could
> +	 * theoretically change via a FUSE-backed file, but that applies
> +	 * to the entire event processing pipeline, not just here.
> +	 */
>  	if (event->header.type =3D=3D PERF_RECORD_COMPRESSED) {
> +		if (event->header.size < sizeof(struct perf_record_compressed))
> +			goto err_decomp;
>  		src =3D (void *)event + sizeof(struct perf_record_compressed);
>  		src_size =3D event->pack.header.size - sizeof(struct perf_record_compr=
essed);

[Severity: Medium]
Since event points to a memory-mapped file, can the size field be concurren=
tly
modified between the bounds check and the subtraction here?

If the size is changed to a smaller value after passing the check, could th=
is
double-fetch lead to an integer underflow, producing a massive src_size that
gets passed to zstd_decompress_stream() and causes an out-of-bounds read?

While the comment mentions FUSE modifications apply to the entire pipeline,
later commits reportedly fix this issue globally by snapshotting the size in
process_user_event(). It seems these newly introduced double-fetches in this
function miss that mitigation.

>  	} else if (event->header.type =3D=3D PERF_RECORD_COMPRESSED2) {
> +		/*
> +		 * prefetch_event() only guarantees that the 8-byte
> +		 * event header fits; validate that header.size covers
> +		 * the data_size field before accessing it, otherwise a
> +		 * crafted event reads data_size from adjacent memory.
> +		 */
> +		if (event->header.size < sizeof(struct perf_record_compressed2))
> +			goto err_decomp;
>  		src =3D (void *)event + sizeof(struct perf_record_compressed2);
>  		src_size =3D event->pack2.data_size;
> +		/*
> +		 * data_size is independent of header.size (which
> +		 * includes padding); verify it doesn't exceed the
> +		 * actual payload to prevent out-of-bounds reads in
> +		 * zstd_decompress_stream().
> +		 */
> +		if (src_size > event->header.size - sizeof(struct perf_record_compress=
ed2))

[Severity: Medium]
Does this also suffer from the same double-fetch problem?

If event->header.size is modified by a FUSE-backed file between the initial
check and this second evaluation, could the subtraction underflow and
erroneously bypass the out-of-bounds check for data_size?

> +			goto err_decomp;
>  	} else {
> -		return -1;
> +		goto err_decomp;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526211806.1193=
848-1-acme@kernel.org?part=3D24
