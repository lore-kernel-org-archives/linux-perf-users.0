Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2462F8EBD
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778190764; cv=none; b=oasOFzPFnKxpQRRZjtiMS5XsG+5cbnc+GMuicXx/ZKk+wsv2JrDw/hai4yV/suuo8KmpIQ3R/jbQ9nKlVGQnznpcTiRnRbP/ATFcaQ7CCKRXjjXRbGGP4v/8n8Np1CVMBOqHkoqrOBaA5dCXH/VTe0XjCtgOrMAr+LVHlyH6s68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778190764; c=relaxed/simple;
	bh=ELYDMsMMTmAxkz2ozbMYJ9dbDO8NPkIn7ydPcfn6u2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YAtNM/llRJsxCT747pUEFhsUvPwgEL/h03Qn17IjRkkBqSZEKHwNpLbSxZTm2fz7JaskOTA+exxdT1IBVmfyeOZ7mse+pXy+Iw34uQzoHleAwT9XsdyHzUjmS0I4a/hojaKOhhoA3dDQH1vpDBEv7YCnyAQBzPjdCEnpFMcUg0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN8JuS6M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN8JuS6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B89C2BCB2;
	Thu,  7 May 2026 21:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778190763;
	bh=ELYDMsMMTmAxkz2ozbMYJ9dbDO8NPkIn7ydPcfn6u2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jN8JuS6M9/lByCN4mCfIy19smZgKoOnlH4ntqnyhp5eSOmZFzs1NcCElVTJWwxo9j
	 8uICGRYAdEnG3eni1BTW8e1NSlnGpAJdd/cmmATuUDm+yqP8NsI0FsGCXT4pbaR+wo
	 zImBEWFmMD+c+WirWIdjraHJIQtbIDvGCGWeHELSIu3ZUEgcsik3YJpf2mtJNDYo/y
	 EKDc/8YcSZBmdNVq4igcA10Q6XcMWA1JZG6rP9dfrKKxT8GXDmeO+/H8xnuWv7i2pp
	 baFwLewx4pgFVwVoKyCQXA9VN4XP4fQJT7WW4DxjYq4C2XT+ivz7qNDO5XWTkhYitZ
	 radF/sGYCtwpQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFT PATCH v2 5/7] perf-iostat: Extend iostat interface to
 support different iostat PMUs
Reply-To: sashiko@lists.linux.dev
To: "Yushan Wang" <wangyushan12@huawei.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260507063737.3542950-6-wangyushan12@huawei.com>
References: <20260507063737.3542950-6-wangyushan12@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 21:52:43 +0000
Message-Id: <20260507215243.C9B89C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Cryptic failure during argument parsing on unsupported platforms du=
e to removed error message.
--

commit a592ebf60ec05a2462f9e4e0f181c260df2632a7
Author: Shiju Jose <shiju.jose@huawei.com>

perf-iostat: Extend iostat interface to support different iostat PMUs

This commit extends the common iostat interface to provide support for
different PMUs. It allows each PMU to register itself and receive callbacks
for its specific functions through a unified framework.

> diff --git a/tools/perf/util/iostat.c b/tools/perf/util/iostat.c
> index a68ab100780d5..90607d1cf3fae 100644
> --- a/tools/perf/util/iostat.c
> +++ b/tools/perf/util/iostat.c

[ ... ]

> -__weak int iostat_parse(const struct option *opt __maybe_unused,
> -			 const char *str __maybe_unused,
> -			 int unset __maybe_unused)
> +__weak int iostat_parse(const struct option *opt, const char *str, int u=
nset)
>  {
> -	pr_err("iostat mode is not supported on current platform\n");
> -	return -1;
> +	if (!iostat_pmu)
> +		return -1;

Does removing this error message cause a cryptic failure during argument
parsing on unsupported platforms?

Previously, if iostat was unsupported, it explicitly printed that the mode
was not supported on the current platform. Now, returning -1 from an option
callback without an error message causes the parser to abort and print a
generic error, such as an unknown option.

> +
> +	return iostat_pmu->parse(opt, str, unset);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507063737.3542=
950-1-wangyushan12@huawei.com?part=3D5
