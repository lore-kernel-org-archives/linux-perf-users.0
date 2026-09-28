Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9F71C2AA
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600463; cv=none; b=C0fTlGYnUF6wJQ4kCtzKby1QI/67fQuZqErSlcFd3Vk2t3rvXdfTUn2jr4Sfn/z6zspvrW+FT8MjmWnYPwxEi5LSuoTd0R5gEEnn3PRbeFoU6YzWENh+dDMazvqoZAd5v2TbsAVT4bgrnCPPG20pjgkPeuVWCpjOVJ3I/N2DSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600463; c=relaxed/simple;
	bh=xL3otiNLfN4iuZ+X8QRR+EIM1MNxHnt5Os08r8uAT0g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ShjRN0hP88KW+/b6vTrm5Z13Ab7pXe+6OTYyraYCZrQuw2smKnRVS09nDYkYSP3vLowq9k3kI9TmZiYSWPkCI/In1nCBlccyCH7MD9R0uwaN3Bx6tNpid1F5KI22K8bIOzQBPzbgr7oXQr8ls8Dfy/27Aj7HHuD1gz2fjF2WuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y55ehYbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y55ehYbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397191F000FF;
	Mon, 28 Sep 2026 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790600462;
	bh=Ao/4Tq15JL7hHHbZ2ZHYLb4f4Cqx7sBGyQkZgSJIbGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y55ehYbzMyWKG8afa3d/AHBGysZ59yv8/UpAFBLpQ3E+ozCi9u9rGN//yEDgofFMC
	 HxdAg+Y4BxbDDegdgMfH7QcASECdp7/RCO7sIv1l10jDKKIAvTW/VmQtPLPAXfaHKx
	 k8uEIV5e8rGN9J90Y9uf0PC5CgqkIcVeY806xW9+7cRu6x4sfxN9iMzn4PefFBuTrr
	 hEoUtIXSDIrnucuhAj7vnIfNmcMht9f5BXmRsY/PKFjRgzPgvJkuGuflpHVTnUDJHy
	 w+C9kTPso8TbqemgRUsIdxn5L3aq4CO8VthhaHBhbolxatVwz/l+LuyVrgnajlKiN0
	 pgvM3aG9yOp1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf python: Fix arm-cs-trace-disasm type error
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928-james-perf-mypy-cs-disasm-v1-1-1bda909475ce@linaro.org>
References: <20260928-james-perf-mypy-cs-disasm-v1-1-1bda909475ce@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 13:01:01 +0000
Message-Id: <20260928130102.397191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The perf sample dso_bid getter returns a string or None, matching its
> Optional[str] annotation. Attempting to decode it as bytes causes mypy
> to report union-attr errors, even though this was behind a conditional
> that checked for bytes type.
>=20
> Use the string directly, retaining the fallback for an unknown build ID.
>=20
> This fixes the following build error:
>=20
>   python/arm-cs-trace-disasm.py:266: error: Item "None" of "str | None" h=
as no attribute "decode"  [union-attr]
>=20
> Fixes: 279b402e5143 ("perf python: Port arm-cs-trace-disasm to perf modul=
e")
> Assisted-by: Codex:GPT-6-Astra
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-james-perf=
-mypy-cs-disasm-v1-1-1bda909475ce@linaro.org?part=3D1

