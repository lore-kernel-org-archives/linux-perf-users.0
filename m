Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797E822D7A1
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577620; cv=none; b=VK4+EpzXDuQqBzMAIJ3uDxaiy2Et9+yB2Na6tjgPWBuWln4cJV8M/WGlj/2G6ULJ4BD3jOLFob4mNmBbbp8MWxHtahEpsbwx3JFL18t4fculwHnI/Dd/qr8dWysblCi9cJrgZz6tXTX3zredg/9+e1xPWEikcpsIzYEAYF1Xocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577620; c=relaxed/simple;
	bh=32+hZs8JzCbBiGlUxL7ayLjGwW9A8kN70umIiU4w1xU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KIQUbECNeHdyaxfgnndEKZGLYl98Z8TePXKl0Fv1Irv0Wogwk7lWfq5YmlxqDJf5Fj8QpxSmfPR/9NhW4Tm61vz6KSBKnmo12I/cC356wane33lJNTCazTcilO2sUSSb5SJS0DoVShvxwxaertHhclw+68QUSV8xjDIGREMoNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0tj+hlv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0tj+hlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7528B1F000E9;
	Tue, 16 Jun 2026 02:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781577619;
	bh=cAXFCyoMZKaC1E5VeFGHr7Zht7RnwggxjBqZJ5upAnM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k0tj+hlv5KMj6A87/db8MfTqnBDip9xHYfTL+ZqubspLyJuPFWY1YWyyZLk9LV6kg
	 QS2GX6Hdm7bBg6hNAwpDC1Wst0K2nVV/THSzXBgrdRy5H8CMbHbORUd9MpJkzLeTZK
	 CpM+nW5jJ2+s8n7IuDCScl7/zmL0GwmAdm/lBJdaZ/8yU+7VaaFFBMhUb3XHPdErRY
	 4q8IAhr1XSYkGFGkFLvi9a90FkV2YWUHfhxw7a5W3nOQxwtCdNvwjqY5GZt9av9lXH
	 uoq6GQ8jIdbKdiZxAoINJt55WPtMWPI1M+fAGTPu/lb9RUsEdl02SBdO9rHLgai6L9
	 FUtVaI6t18u0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] perf cs-etm: Validate num_cpu before metadata
 allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616022715.5739-4-acme@kernel.org>
References: <20260616022715.5739-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 02:40:18 +0000
Message-Id: <20260616024018.7528B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Insufficient bounds checking in the per-CPU metadata parsing loop =
allows arbitrary out-of-bounds reads based on untrusted event data.
- [Medium] Memory allocated for `etm->queues` array elements (`etmq`) is le=
aked when initialization fails on the error path.
--

commit 3997f8cbed57aaf438aeb6594523932b36c0d9d5
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Validate num_cpu before metadata allocation

This commit computes priv_size early to bound num_cpu against the private
data area size. This prevents a 32-bit multiplication overflow and
subsequent out-of-bounds writes when allocating the metadata array.

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
> +

[Severity: High]
This is a pre-existing issue, but does the new validation fully prevent
out-of-bounds reads during metadata parsing?

While the check ensures a minimum of one 8-byte entry per CPU, it doesn't
protect the inner parsing loop. When cs_etm__create_meta_blk() is called,
it reads nr_in_params directly from the untrusted perf.data file payload:

tools/perf/util/cs-etm.c:cs_etm__create_meta_blk()
    ...
    nr_in_params =3D buff_in[i + CS_ETM_NR_TRC_PARAMS];
    ...
    for (k =3D 0; k < nr_in_params; k++)
        metadata[k] =3D buff_in[i + k];
    ...

Could a maliciously crafted perf.data file provide an arbitrarily large
nr_in_params, causing an out-of-bounds read before the index i is finally
validated against priv_size at the end of the function?

>  	metadata =3D zalloc(sizeof(*metadata) * num_cpu);
>  	if (!metadata)
>  		return -ENOMEM;

[Severity: Medium]
This is a pre-existing issue, but does the error handling in this function
leak memory?

During initialization, cs_etm__setup_queue() allocates a struct
cs_etm_queue and assigns it to the .priv pointer. If initialization fails
later, the code branches here:

tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_info_full()
    ...
err_free_queues:
    auxtrace_queues__free(&etm->queues);

Since auxtrace_queues__free() is a generic helper that doesn't clean up
subsystem-specific .priv contexts, will these dynamically allocated
queue structures be leaked when the error path is taken?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616022715.5739=
-1-acme@kernel.org?part=3D3
