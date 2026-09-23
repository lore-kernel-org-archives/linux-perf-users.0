Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9153E31C
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177385; cv=none; b=m5KisPIoLXsoR5WtzkJ7ay07YCEOy0cKt0z2ktfnE+ZuJ9hjA6excTDX1iFoGAY+4Dr4lfXTfgC36xTsla+gKOJBNzT/13ohl090QtEmsxLPlEzGmzeKpo9+w8FA7jwbe6Bjt1HjacE4g6lFFLuyErw8XJSGMrufQWNvhUeRNFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177385; c=relaxed/simple;
	bh=+OIRgDVpW0ACOI1fZ4eAxxEwqA2z/0SNnHsauZToZLQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JPPrIC7NxsgwGBSRGVIEtlRaOpCUBy6eRRSwaIkNkYBJE/4vhCLTl8i+oGBSPB26wh8y2DpLrBzSwwS9M7CCV2F1/nCMVtP/ntU1PshhfrvIiQay3epo+RYyY3e8K2v958mRn4AgXDVbLhizC5xKJDS7WrRwVYD2PWBgDJntRXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/qhXSN6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/qhXSN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840A11F000FF;
	Wed, 23 Sep 2026 15:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177377;
	bh=+OIRgDVpW0ACOI1fZ4eAxxEwqA2z/0SNnHsauZToZLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/qhXSN6VIpxcl505JCjh08APx3gd93dPOK2rVoJ8gFz3hVArBPZdJMHDNyLPwuul
	 gzBDUAcbky4YV/uuU5EJTXBHYS54keO1pNCS4gFYQFhwGTcYcsdJUc0b4z1Ioqy9Xf
	 CZHlKTObz7ilG7l1+A5XDpy6shfgGnkf5wVJfvc4sZ8jUIjGp8d83S/yPslRl9+E0h
	 Am9OaWTrUKiNV6C+eCm3v2CZTbqDS2d5QI6AGZoj6g/odvoAYAcXy/BN9+G42rIZJ2
	 Yz/Zi+kUB2IF4e8sg5z0kcwbA+I8DG5Dz49tuOj9aEdzbk6sY1Dwx1Rn0L+FV8OUhf
	 BJ6aBWpJu8IBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/14] perf sample: Allow decoders to supply branch
 return addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-1-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-1-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:29:37 +0000
Message-Id: <20260923152937.840A11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The thread stack derives return addresses from IP + insn_len. For an
> interrupt or fault, the return address can instead be the sample IP even
> when instruction bytes at that address are available.
>=20
> Add ret_addr to perf_sample and prefer it in thread_stack__trace_end()
> and thread_stack__process() when supplied. Initialize it to zero so other
> samples retain the IP + insn_len calculation.
>=20
> Add a regression test for explicit exception return addresses and the
> ordinary call fallback when the return address is zero.
>=20
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-perf_cs_et=
m_fix_non_taken-v2-0-6ab8c07a5455@arm.com?part=3D1

