Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052139;
	b=WUsZkmhr9mM6pzZmkcp6EwVpLvlolYRoAheXOn70wJja2ZyVUbddjOjvTfnSurxKk5aA
	 CT/xWZDDJQ87BPLA1LMPNbMmIAh4KQ3a+PiZlkGgAQ6+QSeyM9XWEi0Fmp2/ocShSyBUI
	 5VqnLVJS9D1+OQdU9zzzzH2rNRYX9EC1VJGialxDiMdP6DbUGm0zSDXK701sjEjyiwrmI
	 NxHZFaRWWW18hazUe3XU2Oa7Eqt3EAqXHxPufJFIeROfTAkq8003PosJfpCT0LceYRtsf
	 M9ZlYetgXmvlvyS1hY+w0JDGv+Zv54saOh5GGUsvSAEGy1VFDRj8dg6fA5myjd0mc3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052139;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0563xb89/qKAnIA3bg9Uwme6IHhXJ/OSom+UTsku1Eo=;
	b=sZ+nZhldoxjMsH2q6AZjOCaMH9VPplSDxGU6bcSsN+VsNBeFYV2oE8k4NWOu7viXh7GZ
	 /2QtcYoWJZtBbxa9blvnp1v6lVc5ofB6N3uoGR07FXWBLZ7zNxVOmEN0in3ATMNTRE+tg
	 /TR3as5u2tfWgwvKUogsVBFBai4nO8M7pz6UkuTVp0ijrW4pZ81mGpGGnJIMXQ1A/mOqu
	 WO+Ogw5uzOEPOQE1Q+Nswpe/L/U/sLfyeYIzWh+w/jqgCq+6WMqmuZtaSPt9gBMqlcd9n
	 EZKWyCTIdW479PQ7UZTIn4REu1CjNoTKVoeKH5jXQcEFQO9LFnXVc5NC9QqiJ15EJ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEn+r3zA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933AF606A31B
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEn+r3zA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04761F01825;
	Mon, 26 Oct 2026 22:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793052139;
	bh=0563xb89/qKAnIA3bg9Uwme6IHhXJ/OSom+UTsku1Eo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dEn+r3zAIEBw0maFC4033GI37agUyX8C4Cwggb8V46dWbAFUm3UPEhDPz8e3hqM2Y
	 5a4yvzBmR2KCl8z5d+eJjm4YgiNoG9vddFynAQ0FvqOZRL8EOKRLCG7Hj9O64nntk8
	 ZarnaPEtBrsX2fcV/v8+J0ngB1uJBANI+ror9iU0cHdz2TcbZnadzBZ2nuY5+6edis
	 NdfECeiW7FXez8mZZXH8wKEzebwV3e3cTp6nq1nEbJqo/Sx6ixMTo3lfhF/wu5AXQQ
	 Va+BlLxhi8Y58rKzYy+Kagt/vQQzDhNMM/Jl24qrqFK4ltAhYb8k0zl6EAUxALO5BM
	 Pm54LtxfsUsnQ==
Message-ID: <sashiko-outbox-185777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 10/10] uaccess: Move the NULL mm warning out of line
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Houghton" <jthoughton@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026215226.3713941-11-jthoughton@google.com>
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-11-jthoughton@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 22:02:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> uaccess_without_mm() is inlined into every user copy, including every
> copy_{to,from}_user() call site on architectures that define
> INLINE_COPY_USER, such as arm64. Each inlined WARN_ON_ONCE() adds its
> own __bug_table entry.
>=20
> Keep the NULL current->mm check inline, but move the warning into a
> single out-of-line, __cold function, uaccess_warn_without_mm().
>=20
> The trade-off is that only the first offending access in the system
> warns, rather than the first one from each call site. The stack trace
> still identifies the caller, and the access is refused either way.
>=20
> Compared to the base of this series, with defconfig + KVM:
>=20
>                      inline WARN_ON_ONCE()    out-of-line warning
>   x86_64 total       +5,884 B (+0.014%)       +9,714 B (+0.023%)
>   arm64  total      +40,948 B (+0.10%)       +24,609 B (+0.06%)
>=20
> On arm64, this removes the ~16 KB of __bug_table growth, while text
> size is unchanged, as a call is the same size as the inline brk. On
> x86_64, the call is larger than the inline ud2 and causes more .cold
> splitting, so this is a slight regression.
>=20
> Signed-off-by: James Houghton <jthoughton@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026215226.3713=
941-1-jthoughton@google.com?part=3D10

