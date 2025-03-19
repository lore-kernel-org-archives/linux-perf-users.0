Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5351F4E37;
	Wed, 19 Mar 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390664; cv=none; b=pg5fcJjXgcwj5WEPrFq/yuWIYgyzbcZt9rG6jpF+nVHkgnruWo4T2cMcki8LwbLi4+8ttunRisSjodHjsITNC2CsgJ349mu7oJ5Ykb8n2RcpN+ZBP9BWFmuhTntBeM2d2SeYBoYH4evHj3HCJTomMeUEyF09OnR817mSOcmkQMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390664; c=relaxed/simple;
	bh=x7BqLBdqa0Pofxy9h5kGhmOuImsx3iazNrFoBrSorSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JumOWhxx1PDL3kY/6wbe0EQJOnNZoB786BM5mzGxx1Jx9dT4eOjaSlCy3FXxxiEnaPO0GH56CGBxbUHpxan1dQXRSbY+ycgMgiXFzfY8ipEO538CmnN2rBqhaFXPOKhiZetrVtt07QXsmYMeFX+1F0Ier4ERIVf1f0cdHg5TbLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY0uhdBn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY0uhdBn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71F8C4CEE9;
	Wed, 19 Mar 2025 13:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742390663;
	bh=x7BqLBdqa0Pofxy9h5kGhmOuImsx3iazNrFoBrSorSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dY0uhdBn28SH0CjpOoq/FAsOG2uKdYmM1HX81wMJugzVl73UsBe9PEmGw+EsyY039
	 CGFfZbV2Sri5OVqUc8x6VGNTz+girkqdKFB8KuiIKqV7VfEBO6s/kq/vQHKHZa8d8+
	 yoOeQcejJVgrYDV/l1QUyyZ1leb7PXxORwlGJjrY+8wCtqaMm1JsJywG/pJxQPIj6l
	 E4xmnc7cV3HS9O9QMbTkwAV7CvfgLrpdq9EKy6LNZFQrOfGBtcN9KIkjlBYX4E8tcX
	 +p4zFuluOehct4IwB5f9EAVzj58JvyG5pxOvnIwmXIQpR8AU+K3h2F0WuXBCkyhXsp
	 lkTSPI+tUefEw==
Date: Wed, 19 Mar 2025 13:24:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	yury.khrustalev@arm.com, kristina.martsenko@arm.com,
	liaochang1@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] arm64: uaccess: Add additional userspace GCS
 accessors
Message-ID: <50a0920d-3e3d-4e96-b68a-a7a0d78c3695@sirena.org.uk>
References: <20250318204841.373116-1-jeremy.linton@arm.com>
 <20250318204841.373116-4-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Lrxbu3I30TVdgrcC"
Content-Disposition: inline
In-Reply-To: <20250318204841.373116-4-jeremy.linton@arm.com>
X-Cookie: Chairman of the Bored.


--Lrxbu3I30TVdgrcC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2025 at 03:48:37PM -0500, Jeremy Linton wrote:

> +static inline u64 load_user_gcs(unsigned long __user *addr, int *err)
> +{
> +	unsigned long ret;
> +	u64 load;
> +
> +	if (!access_ok((char __user *)addr, sizeof(load))) {
> +		*err = -EFAULT;
> +		return 0;
> +	}
> +
> +	gcsb_dsync();
> +	ret = copy_from_user(&load, addr, sizeof(load));
> +	if (ret != 0)
> +		*err = ret;
> +	return load;
> +}

A GCS load done by the hardware will verify that we are loading from GCS
memory (the accesses are marked as AccessType_GCS in the pseudocode
which is then validated in for example S1CheckPermissions()).  Sadly
there's no equivalent of GCSSTR so we'd need to do the permission check
ourselves to match this behaviour.

--Lrxbu3I30TVdgrcC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfaxX4ACgkQJNaLcl1U
h9B6kAf/aWTyBGHINz3SHkUd7B2qgPUiRdB16ns0/PHI44Me7B9WwzgUi4S60ku3
k9adlWzZXOVABsny7iREC/F24FgqxbT1hBSK/TXZPGJvubnkOahLXD7iXkANnMhh
lbnr++1qFc9tXTMuq3sFmGZA8u+RgavrZ1x7WdTkVQ/PkrY1tIOefK9+ut0RydD5
T7inRjdUC1ee6CorJqprrnC/G/VIi/lgg+DlpkDWW1teV49ASSim7nIhlZ4U+JVQ
Di39GgQj5uQyndh4r7fp1YuRBd5SyhjrWTce/XX06ctkUug6aZndsirvSKdQJQQL
0slQcyJA5dGCPUeUuvDRv2ghKhJ/1g==
=QTs9
-----END PGP SIGNATURE-----

--Lrxbu3I30TVdgrcC--
