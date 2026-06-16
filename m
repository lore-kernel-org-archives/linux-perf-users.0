Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4422C30C142
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572904; cv=none; b=Y1sfQecgpOMtNWz7jg34Py22nG3apgNUX0BNCxnyg8hEywX1/TEiqLZbWAU97x1BmLz3ER6nG6r1dCqKgrZ2AO1+uYovytO2nqA/0k7mSK+vNZdcBauvXAE4MYKYie/UvcShh7KcC6kCWZWrXz9V7GgsKyLZ1VfkYU8IR2PJeMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572904; c=relaxed/simple;
	bh=XPcs7f1SSOr1uBZlfczI3AMtWteGapCGX8VR5bYIAH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q9cH2/5ImL0TVBLEn4bDICQjLtVDAvpAJtOqiVkDbNGAWZTEvRKadbgrQsx2Vnef3PeCIbB+OdHzmoCa10n0pH+oRm33gZSnSWzB2LWXCYghiRNwARNGA5wQ+1Ne0KFbOv1xcWuT3vrfsGkdDeVRUg0qGIoOc7mApWIKmoRnqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpT0gJLr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpT0gJLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5591F000E9;
	Tue, 16 Jun 2026 01:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781572902;
	bh=lpa9+vJMVyUwpQ2PXxoqBwosWYIGtIDz3S2s5JE+zQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZpT0gJLrUtyL6N9GIt5/KejrWrONoKHtmLKBy9cDMTmBS8YgC58/lUT0Rrf/pq+mY
	 5P5lWg/oVlvPV6FM5AnHw6We7Kak/YHmycr+GXCo29dx7JjL7jh64zgzrt8/3CWv3f
	 v0WgXz9nt6T2MsQxRpqFGvP/V5jlf1/w9c2KGNoFrvta8MTgtCSbqRsA+lipC2FNDN
	 XdBm30sH60/2NdXaTEkHQ5b/82pM3L3g4zJNd00gg0ddLUbs+21uZ6MjVybdbBqrC5
	 pQ6hkNWtQBVDWuoiu3RI2VkLQdg9dUHDm4Aj66euhtXYEznpMkAsc7Mhh79/miiGR5
	 WLULZRGHmukKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] perf cs-etm: Validate num_cpu before metadata
 allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616010834.37618-4-acme@kernel.org>
References: <20260616010834.37618-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:21:42 +0000
Message-Id: <20260616012142.AD5591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Insufficient bounds checking during metadata parsing allows out-=
of-bounds reads, arbitrary index manipulation, and potential memory disclos=
ure inside the `num_cpu` loop.
--

commit 08062652d1b7507748a2450df846239247c38cd7
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Validate num_cpu before metadata allocation
   =20
cs_etm__process_auxtrace_info_full() reads num_cpu from untrusted
perf.data and uses it to allocate the metadata pointer array.
This patch adds bounds checking to prevent an integer overflow=20
when allocating the metadata pointer array.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 0927b0b9c06b1..d121c8f22028d 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -3431,6 +3431,18 @@ int cs_etm__process_auxtrace_info_full(union perf_=
event *event,
>  	/* First the global part */
>  	ptr =3D (u64 *) auxtrace_info->priv;
>  	num_cpu =3D ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
> +
> +	/*
> +	 * Bound num_cpu by the event size: the global header consumes
> +	 * CS_ETM_HEADER_SIZE bytes, and each CPU needs at least one u64
> +	 * metadata entry after that.
> +	 */
> +	priv_size =3D total_size - event_header_size - INFO_HEADER_SIZE -
> +		    CS_ETM_HEADER_SIZE;
> +	if (num_cpu <=3D 0 || priv_size <=3D 0 ||
> +	    num_cpu > priv_size / (int)sizeof(u64))
> +		return -EINVAL;

[Severity: Medium]
This is a pre-existing issue, but does this bounds check fully protect the
metadata parsing loop that follows?

While this check ensures there is at least one 8-byte element per CPU, insi=
de
the parsing loop, cs_etm__create_meta_blk() immediately accesses elements
beyond this guaranteed size:

nr_in_params =3D buff_in[i + CS_ETM_NR_TRC_PARAMS]

This could trigger an out-of-bounds read if priv_size is small.

Additionally, because nr_in_params is read without dynamic bounds checking,=
 it
can arbitrarily alter the read index i. On the next iteration, the code bli=
ndly
reads ptr[i], and on the error path, it could leak memory:

tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_info_full() {
    ...
    for (int j =3D 0; j < num_cpu; j++) {
        if (ptr[i] =3D=3D __perf_cs_etmv3_magic) {
            ...
        } else {
            ui__error("CS ETM Trace: Unrecognised magic number %#"PRIx64". =
...\n",
                      ptr[i]);
            err =3D -EINVAL;
            goto err_free_metadata;
        }
    ...
}

The strict bounds check (if (i * 8 !=3D priv_size)) only occurs after the
loop completes.

> +
>  	metadata =3D zalloc(sizeof(*metadata) * num_cpu);
>  	if (!metadata)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616010834.3761=
8-1-acme@kernel.org?part=3D3
