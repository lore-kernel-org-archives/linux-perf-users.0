Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF137A498
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070366; cv=none; b=imUHq5XXjmUUxvPMknn/NnhpM3PWvepE+2BOm46CcitaOHTzTpJKc1FA8UTVI+r77xDSf8qo38ukSlQruwL/MxC1KxZcPM6Tmw3MehvU7t9EWh1Jy3HEkotkWlWMpwGfyO2/Ono9QyNVyGLoGSXuznYOIDb3dwdHYqeZoGWHkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070366; c=relaxed/simple;
	bh=CEsm0Nz/YepT2d3NjC77mtt/5pySzan8ma/j8t5WgnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=acUrpQWy5Ll8jgR1Fkz3zF/zmoMSNqopWhDrRRdQNiokuNMfgUUCLCu3cqqXrZvCk5M6hp++gy9aLcUKcMJW4JyV7UvyxuerAmRnjVhlfCVJiN7tsJKNSB8XoFMC+W76v5+Pyrl3CCZ4LRwH766dzgyogCyQ+hiEaWUBQZN6HvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqaGZ2M0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqaGZ2M0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29D61F000FF;
	Thu, 10 Sep 2026 19:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070364;
	bh=AoSAw8OX6lwAC/FQ+1ZzVIjGczyQM3eDHUdXxLqITqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LqaGZ2M0dD+bNRNOTwWSroX26eholeTuBnIFOvT+EEea3feCwMybR/sW85M8FOcVn
	 bdqso9LlT8i3SdgPREG/wDK8021c4GzVBeIFOgEEAJavdD15oLYBquH1EsBwXWwZkJ
	 YUuEvyrLAEha/B5j+z25ByaW7bSX6lB6cO5btFRVPavP24VIK1fxE5+/FYsKAqQuUr
	 0GzRPjVHa1v58Bivtsr9AmkHKKJjQRomdUP3i1yo1BjQoDXdxoRJsAlKOWwXXlTCof
	 vGfa8IfTlHdH4L+YBnT3vpCL6M7A9jeUMuhU4RBYbzy2fFy18VehrvlVer3llWleSp
	 3yTCaYS4Dcn9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/6] perf c2c: print memory region data with stdio
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910194324.98002-7-thomas.falcon@intel.com>
References: <20260910194324.98002-1-thomas.falcon@intel.com>
 <20260910194324.98002-7-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:59:24 +0000
Message-Id: <20260910195924.B29D61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unsafe end address calculation for zero-length memory ranges, causi=
ng integer underflow.
--

commit 353c7e26bf2f698e86dedab128c94a9970b19c51
Author: Thomas Falcon <thomas.falcon@intel.com>

perf c2c: print memory region data with stdio output

Print memory range data in perf-c2c subcommand. Only available in stdio
mode currently. If memory ranges are not supported or present, print
nothing.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index e37c1a3a4ca5e..9d0182a7d4d5a 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
[ ... ]
> +	for (int i =3D 0; i < nr_ranges; i++) {
> +		struct memory_range *r =3D &env->memory_ranges[i];
> +
> +		fprintf(out, "Range %d: [0x%016" PRIx64 "-0x%016" PRIx64 "] Node %d, l=
ocal region id %u, remote region id %u\n",
> +			i, r->base, r->base + r->length - 1, r->node,

[Severity: Low]
Does this code risk an integer underflow if a memory range has a length of =
0?

If r->length is 0, the end address calculation underflows, which can lead to
an incorrect address being printed (for example, wrapping around to
0xffffffffffffffff if the base address is 0).

Since the parsing function process_memory_ranges() can allow 0-length
ranges, should this calculation check for r->length =3D=3D 0 before
subtracting 1?

> +			r->local_region_id, r->remote_region_id);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910194324.9800=
2-1-thomas.falcon@intel.com?part=3D6
