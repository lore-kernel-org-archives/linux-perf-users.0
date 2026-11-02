Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793615338;
	b=GhuDGshc5s8ZiXk4/Hia32F5/17C4qIwJEa4oqqyJecbTgdFsChZxWhzS9qt18E+h494
	 L2IGIUgtlmNaliwwnA30NGsT781tc0mMdcCj2+ErJp2iciRrFwXY1VCFfm+SoXi3bamau
	 2OkE/X7xUa4hzLC/IWW0F725FxON53KcyIN5iaDZduoP6lfxLwNfBUKXxCB/EE7ZEUGIQ
	 nFaloFcD6nKopOGaW8wkBQm8ThX3t96D9sjFlTR/cTO2lFvGcOJZ+0+zEpFV6twD9qRO2
	 htIKg2l3HJEmrcZTIl/hlS73Dy1cb7/wNo47rdd0YL/8Lq9glb+Gsw7tlfJwN7gCT8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615338;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mc4LK3SmKYUcRLN/O0YaUqDlYcm6ag42XKllgsF0wPA=;
	b=Ffn5OQ2j8xmZPMgQ7xV6bJjbgQSXFmtvcGpoiqkvDGqdbVFiJXl6vmaN0fM8Qjl0jYv5
	 XE60i9GiJt9YVHR6GaDOaV8XQgXcSKBg5S67+t4ChoDpdWe0itFDyiTrEbiRyzwhNovy6
	 PP1jY8hQITnTIEDqCUaZPNa2oI4DVGC0iRIOsTh18GYZ/Ei0+jEW4J6WwNfF1I0xVA6ET
	 zGn3Exy3CyKX6DS3B8xSjT1kC8VJ8dB319QCx1vzIo1MZj6ahsX1Kfu+z5KWAs3dAdWCL
	 RwHH7BHEcMZC7d5okG5qEpAQqrL1dH0Rdjm8PP04K5mG9rdJkpaHtILKKQnywNGeDaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fbz311yK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F0606A324
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fbz311yK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF171F000C1;
	Mon,  2 Nov 2026 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793615337;
	bh=mc4LK3SmKYUcRLN/O0YaUqDlYcm6ag42XKllgsF0wPA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Fbz311yKLLhlquCV4J3lsj6YkTD6trGXHcMTgGv+hrpl515AI8lpArlQSngCRt0vO
	 dG22XiuZCAVaURzThy46tkgcZ7coXtFFvts8fkimCN9KDX7N3HYxdAgQHXrlonVM9P
	 /pX37SIRXpuanL+l/FiQRh4admKhx52flmW9nSXcv7dJYQpifjq/yRg0b6gGj9hS6a
	 e1ks5TyITfKCgUs7E+3KWcheXKQP9LMy0SXzB3Xj4cLVt8SPdATvhoYT2ppbanMVsA
	 +rKpfpz/2aC9NR8LVk6pH+d4ybv9wZXl/AzyWeKqTqi4Ij3EHHm72sYyrYlexnyEdk
	 Yc/tGKTUOi8Rg==
Message-ID: <sashiko-outbox-193259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd/uncore: Avoid context migration from
 non-owners
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <273135a6d33a40f442fb18e140a90689fae7cd32.1793614726.git.sandipan.das@amd.com>
References: <273135a6d33a40f442fb18e140a90689fae7cd32.1793614726.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 10:28:57 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Each uncore context is owned by a single CPU that hosts all events for
> the corresponding uncore domain and is advertised through the sysfs
> cpumask attribute. When a CPU goes offline, the context is migrated to
> an online sibling if the departing CPU is the owner.
>=20
> Before commit d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore
> management"), uncore_down_prepare() checked whether the CPU going
> offline owned the context. The check was lost when the function was
> replaced by amd_uncore_ctx_move(). Hence, when a CPU that is not the
> owner goes offline, ownership is always handed over to the first online
> sibling in the uncore domain irrespective of whether another sibling
> already owns it. This goes unnoticed as long as the owner is the
> lowest-numbered online CPU in the domain, since the first online
> sibling is then the owner itself. Once ownership has moved, that no
> longer holds.
> [ ... ]
>=20
> Restore the ownership check that was lost during the refactor.
>=20
> Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/273135a6d33a40f442f=
b18e140a90689fae7cd32.1793614726.git.sandipan.das@amd.com?part=3D1

