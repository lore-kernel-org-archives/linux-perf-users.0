Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951461;
	b=YGOTR4yJovR8nMn+q4aLAeuvWUV/hl8Xtw72d5JDBhXQQM/dANd31YtQFHFxD55aKSrh
	 d5jL/b7OBKrAro1ItoG9rhy3Db8o/5ZoZGAJ+FpJuQytBwVHYC33u/cu450lZDq9M2Lss
	 2pWd482vBoPeTouElco+hkE321L63wVkFTJLpJsZ2FYfG+JJxYiaTIDwkKo6fdVIoVBgR
	 38bhw7ft+EE48m8sBu7iEjaZAPDOrk8rRP21aFb4FMqFSLt+RTicQJG30WNmd0SJRJlEo
	 cp/ggM27wRIerwVhhlRAHHUrCfphP+CZB0snKmBFz05r3eoipmJxcAsClgghRCxdG3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951461;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=34YpYBTQIjMAACOdn6KvOmfQr/pOnAR/1Z7wVqeDz2M=;
	b=MtHE5TAZxP8h9TDwJsVr3CpxIvxG8uG2lGNUv33Lj9QSKCre6tHgj5mmT+9zKv4onk7B
	 VpY7wkqBn1Lcc4bZt0FZla/Woj63dHyq0iOD0fZPMDjiV9Vsa+ZR4CKtpoIs5WJmgArNY
	 rYnZrlAH+gLdr7qQwMXLbYaW56bhXILFXQ+x08LrNXgw6K9LxwaFKkveLSaNQLixbAEbK
	 wje0H67o0N0vN9MmdNXyIyqem7HMojQmtUxhzj4Z7GYRfHuSg8UpfLCY4VsehoXXVnlNF
	 c3WHlU0gm1nNapLiJyDF7hhMYXtV3mfGbEtVmvOEFMZMfeLzS2vG4MfzK+v2OW9ueqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q14+9C2O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC2606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q14+9C2O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E8D1F0089F;
	Fri,  6 Nov 2026 07:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793951461;
	bh=34YpYBTQIjMAACOdn6KvOmfQr/pOnAR/1Z7wVqeDz2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q14+9C2OQuwPda6DxNr8bDD1JbO3OM3IFfFkcL5iQENxFLFnPZjdgcbCzjqr6yr54
	 Wr8dKtmDaUfklISQN3Y6HvkW6CVz5AWwmr4OfUZV7HLQRMKUEcRjFzNt9qWUXpwgqu
	 Ol7mHn0Anfs1Z++Su2nGMjrPlnTpeADnfExlrBdxIkgC9YN6t3SoiaLOFUUxq45HsU
	 uQBoxCsIjHgHDO1AR/G1LSbYkRD6gxM9LtWXAtbGeoOFMRVzGruoluIgxuLrhCMzuu
	 2bBo7BVjmej7yyfypfNHPDGu0nTsfAtFtTyfUM3E2eqwyZ7k0DSLeeHHT+0uQxVooz
	 i8a4WzdgXIOnQ==
Message-ID: <sashiko-outbox-201007@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf c2c: Show all memory regions in the region
 column
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106073018.903126-2-dapeng1.mi@linux.intel.com>
References: <20261106073018.903126-1-dapeng1.mi@linux.intel.com>
 <20261106073018.903126-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:51:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] perf c2c: memory leak of c2c_he->regionstr in c2c_he_free()
- [Low] perf c2c: calc_width() populates regionstr and width on child
  entries
--

commit bee454704ac015d02d879348350c49da07d10fb5
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf c2c: Show all memory regions in the region column

This commit updates perf c2c to record a bitmap of all sampled memory
regions per histogram entry and format them into a heap-allocated string
displayed in the memory region column.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index f51fa23f3bf18..9c638fbfc2eaa 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c

[ ... ]

> @@ -2264,6 +2239,52 @@ static int set_nodestr(struct c2c_hist_entry *c2c_=
he)
>  	return c2c_he->nodestr ? 0 : -ENOMEM;
>  }
> =20
> +#define PERF_MEM_REGION_MASK	\
> +	GENMASK(PERF_MEM_REGION_MEM7, PERF_MEM_REGION_MEM0)
> +#define PERF_MEM_REGION_NUM	\
> +	(PERF_MEM_REGION_MEM7 - PERF_MEM_REGION_MEM0 + 1)
> +
> +static int set_mem_region_str(struct c2c_hist_entry *c2c_he)
> +{
> +	char buf[32];
> +	int len =3D 0;
> +
> +	if (c2c_he->regionstr)
> +		return 0;
> +
> +	if (!c2c_he->regionset) {
> +		len =3D scnprintf(buf, sizeof(buf), "N/A");
> +		goto out;
> +	}
> +
> +	if (c2c_he->regionset & BIT(PERF_MEM_REGION_MMIO)) {
> +		len =3D scnprintf(buf, sizeof(buf), "MMIO");
> +		if (c2c_he->regionset & PERF_MEM_REGION_MASK)
> +			len +=3D scnprintf(buf + len, sizeof(buf) - len, ",");
> +	}
> +
> +	if (c2c_he->regionset & PERF_MEM_REGION_MASK) {
> +		unsigned long regionset =3D
> +			c2c_he->regionset >> PERF_MEM_REGION_MEM0;
> +		int num =3D hweight_long(regionset);
> +
> +		len +=3D scnprintf(buf + len, sizeof(buf) - len, "Mem-");
> +		if (num > 1)
> +			len +=3D scnprintf(buf + len, sizeof(buf) - len, "{");
> +		len +=3D bitmap_scnprintf(&regionset, PERF_MEM_REGION_NUM,
> +					buf + len, sizeof(buf) - len);
> +		if (num > 1)
> +			len +=3D scnprintf(buf + len, sizeof(buf) - len, "}");
> +	}
> +
> +out:
> +	if (len > dim_dcacheline_mem_region.width)
> +		dim_dcacheline_mem_region.width =3D len;\
> +	c2c_he->regionstr =3D strdup(buf);

[Severity: Low]
Does c2c_he_free() leak c2c_he->regionstr?  c2c_he_free() frees
c2c_he->nodestr and the other heap fields with zfree(), but does not free
c2c_he->regionstr.

> +
> +	return c2c_he->regionstr ? 0 : -ENOMEM;
> +}
> +
>  static void calc_width(struct c2c_hist_entry *c2c_he)
>  {
>  	struct c2c_hists *c2c_hists;
> @@ -2271,6 +2292,7 @@ static void calc_width(struct c2c_hist_entry *c2c_h=
e)
>  	c2c_hists =3D container_of(c2c_he->he.hists, struct c2c_hists, hists);
>  	hists__calc_col_len(&c2c_hists->hists, &c2c_he->he);
>  	set_nodestr(c2c_he);
> +	set_mem_region_str(c2c_he);
>  }

[Severity: Low]
Should set_mem_region_str() only run for top-level cacheline entries (or
when c2c_he->hists is non-NULL)?

calc_width() is also called from filter_cb() for per-cacheline child
entries, which do not display the dcacheline_mem_region column.  Running
set_mem_region_str() on child entries allocates an unused regionstr for
every child entry (including filtered ones) and can inflate
dim_dcacheline_mem_region.width when a child's non-contiguous subset of
regions (such as "Mem-{0,2,4}") formats wider than the parent cacheline's
contiguous range (such as "Mem-{0-4}").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106073018.9031=
26-1-dapeng1.mi@linux.intel.com?part=3D2
