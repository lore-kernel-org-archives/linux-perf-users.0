Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6CB377AB0
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205109; cv=none; b=Z21fPo33v7E/fnb6X9Ffg8iquZSYP50In+dOuExZRODNjplYhrHQ3jE1Zo7NSYzT/BiWgWpb+sF+5uhfk4i/D4p9HCuM/xR37THApAMTU8BcNNamcWheEt7M0Ipvjbbed8to8P2FqIYAI2YlL2mby83Ry68el70CQL5WhXwGy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205109; c=relaxed/simple;
	bh=YS+RsWA7tMQ/rYdFwaZQp1w50e00VItnC8AAGbOqHVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lq7kBHNTpgWICXossCqNJxsSBkEHhPm8mPLyCN4yGank9YCngqmSq+qple7BiiIHisTQpC3GZbgjijpWlbthq/kwavU6yrqD8PlVh4qmWb98nDY1adHlUcQnuKpSsf5qCvD3cIxK70d8SodnYOSAlY+8Mwx6+8GiVyV6H4Gm40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6D0BJlU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6D0BJlU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B572F1F000E9;
	Mon, 31 Aug 2026 19:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788205107;
	bh=YS+RsWA7tMQ/rYdFwaZQp1w50e00VItnC8AAGbOqHVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C6D0BJlUiYfr0pHmGT+udI0wvSAK2IfQGdx18A/xDwSoy46RW1SNRe9ML6hjIVhY9
	 jlRRQK5eUq4WSXa2IzLlIyr1AFE+b+l4K74A/wjtDVtCNtdSgtDT6wwKnXMv+xr1Mj
	 IIuATaOx/XEaqJnENQO44/mBQFcnTJFQpNVxwmbtevJpi0XPO+ZvPmREb4duLVs0Yp
	 VUJGWIp4jyhsmdUFNOGckWyIpK8dsmhaOLH45La02YD3DkCGIGEd1RCpxkiEVE6Bum
	 rzP9qFr6xjpVqzcWRuHOOx6I0ll4MoKJIj0u5jRAptC3aKVFFIgmyWczAdKL3zBGme
	 vIgRg+rGHWOhQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 08/19] ptwrite uprobes / x86: Add a user fault notifier
 chain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-9-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-9-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:38:27 +0000
Message-Id: <20260831193827.B572F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The ptwrite uprobes need to catch faults in the user probes, otherwise a
> bad probe could crash the program. For classic probes that is handled in
> the kernel, but with these new kinds of probes the crash happens in ring 3
> code.
>=20
> The existing die chain cannot be used for this because it only handles
> kernel level faults. Add a new user fault notifier chain that is supported
> for #GP, #PF, #SS. It is only called before a signal would be delivered, =
so
> it doesn't slow down any hot paths. The fault handler can then handle the
> fault and prevent the signal.
>=20
> Add register code and the hooks for the chain.
>=20
> Some of the existing fault hardware workarounds could be converted to this
> in the future (not done yet)
>=20
> Assisted-by: omp:gpt-5.6-luna
> Signed-off-by: Andi Kleen <ak@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D8

