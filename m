Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E117B50F
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 23:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791762359; cv=none; b=T7v6FFsjfOxi2ZwS/BvmjAVc1p5wkrEQZihrzvkEfK0bGfCazZNFSlUVp3bt6Hv63wk2gaO1g3n70HewWtKf0vOQw7pu4Lz0OY+Ej/FaIZSOJKV/XQqQNDlQ0ZiOpnNtZbMB6RrxOS2AzBjktrBt2mPu4987S4DKi0uOkIpWSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791762359; c=relaxed/simple;
	bh=bVDs3H15X2u0n1FIzOr1axHHb0NCe1p5zhNvNP3vrBs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qImkYyvj/n3EZtMX0l23YyPpgBDqvJ9sccg0eo9oDN+Xx7MunZbq7qJcEwltOp7ZHrVVmrs8XwnoFueDBNq7IE6XyS9cPGoXXnRUTR7eKV7Jv1jwC+s1NJJj0c1y3du8p4jLeldJmXR4NbfTjyT7TOHDP1ExDmdI3dPNFtujWxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9ZyNSIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9ZyNSIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6101F0089B;
	Sun, 11 Oct 2026 23:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791762358;
	bh=/M1J+ivfSayaA11C0OJd/Nk10+x6N/FNd/ZG7pQ6npI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C9ZyNSIwE4/Ce8x5cTZpQY+qIuHTbn7DeyPWG4XBaWAOOlp8Ol9DkJ7h5uQv2avPk
	 qvfzpzYYDlduexFIPMGZvwFw/UAIRVhjgcd/NkyvsiPKntqdRjYPLfyecBMqF/D2o1
	 6RslImRHbYYiTH0u7vvkj1WKSTKOoBq3evxGca390FKCO0Ui+RzmmraC3SocMuCKjx
	 vogvUyRvbU9Gyw6vXWe4Lo8/YzJC93v10/75ayWZpIpUmXAXDb6JqGJeQiZDdvczgA
	 1r9vkf0Ru+qzY2uNCnsoAAn8rlVIyT2pDU2r/tHtMdyL9DNsf2ZqI7PDhPRQNBuERQ
	 MW2YQ4ZjYu6xw==
Message-ID: <sashiko-outbox-167521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/6] kbuild: add "make tools_build" to build
 userspace tools from tools/
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261011233647.2454648-3-sashal@kernel.org>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 23:45:58 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The programs under tools/ have their own build systems and are not built
> by "make", so nothing builds them together with the kernel they belong
> to, and breakage in them is only noticed when someone happens to build
> them by hand, sometimes many stable releases later.
>=20
> Add a "Build userspace tools from tools/" menu (CONFIG_TOOLS_BUILD) with
> an entry for each tool, and a "tools_build" target that builds the
> selected ones for the target:
>=20
> - Each tool is built by its own build system, as it is built
>   standalone, into tools-build/ in the object tree. "make clean" removes
>   that directory without running the tools' own clean rules.
>=20
> - The compiler is the one CONFIG_CC_CAN_LINK was tested with: $(CC),
>   USERCFLAGS and KBUILD_USERABI, so cross builds, including LLVM=3D1
> [ ... ]
> The first entries are the tools that only need a C library: bootconfig,
> counter, dma, gpio, hv, iio, spi and usb.
>=20
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011233647.2454=
648-1-sashal@kernel.org?part=3D2

