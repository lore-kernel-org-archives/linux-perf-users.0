Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328AA3148BF
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850899; cv=none; b=RJ/bNvXBT7GOK7V9pCg0hQrmW0OSEIr/fw0A3DzCrkFq1GlrmlON/mY9ahw+n+vaXmvRAlEfBUu8njL8lph0BGXuycRWIylpA03kOUZxfwWkSCvXSCEi95CGtlUA728UnOpRd4QBeDGkWUnUsRfTvQ/97UQ2gSq0cPI4+EI4wGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850899; c=relaxed/simple;
	bh=dGf+dpZdMUWTcpJMP5apqji6A8jWVWduCOkui6L8ZOg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iEOe3sqqGUCRVkm2gMQDOCRceBGV/SeAJgSWXxNs7wsSoeJFHjJA2q0Diaf5IKDwmdlcjTzXJaOvrZpHgXTknq341Fqaa57pV/IFjWyBt5V6daOvCAY7lKWUekDafHPeEqiYzPzsnXrfvGp81dRQblT+qx1ptbgITtPIzcQ9P/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MN431kQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MN431kQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7261F000FF;
	Sat, 19 Sep 2026 20:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850897;
	bh=ugXm1wqFqtU7mg6lqyiR3kvxSaXkT1RvRrQ2+SzXlq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MN431kQmhmOHsAn1KV3weiLr0Sfvtb6OEFfYr/9kbG6z1HGawnxjx10OrImen0GSl
	 CgbGcqXqCDIcm997fOXcNgVzt55NfjE10wHG82I8amJse52VqzoeXWN5CngE7EvB5r
	 CFEWt2UXLKCknkSKTdfpPPIcArEiNcEWAFBFmasoaNFGWQuP4RYb4ae4mhxMZX/PLh
	 f4AagfGUUrnvqgzQL0e16xkon24glfAlD6fq2oXw9I+cmlR6cIIl5w6vqJZEnvX+hw
	 ILYSpOcK6TGdm2K6bBadlz2SuRFjSvNajk5gmSyLbN02SXnWGuQ8edbZEoukTbz18q
	 p+pFzOfzOXKhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] perf mem record: Request PERF_SAMPLE_CPU by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919204027.8504-7-acme@kernel.org>
References: <20260919204027.8504-1-acme@kernel.org>
 <20260919204027.8504-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 20:48:17 +0000
Message-Id: <20260919204817.8F7261F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The data type profiling per-sample stream keys cross-CPU contention on
> sample->cpu; without PERF_SAMPLE_CPU that field is the (u32)-1 "no CPU
> info" sentinel, so same-instance accesses from different cores are
> indistinguishable from same-CPU traffic.  'perf mem record' already
> passes -d (addr) and -W (weight) explicitly to the record parser, add
> --sample-cpu as well and document it in perf-mem(1).
>=20
> The rec_argv array only had room for nine arguments per PMU plus the
> user arguments, not counting the up to eight __cmd_record() adds itself,
> which a new argument would overflow on PMUs with separate load and store
> events; reserve space for the fixed arguments too.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919204027.8504=
-1-acme@kernel.org?part=3D6

