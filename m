Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656394;
	b=vhXzLf9UGVKUcH1uC0y8+aGyQGMo1nqRjgjPVCTQEiz4KrxKVuMnYR6Jn43eTJ2Mx6aN
	 tEXdB5eDDuYVCWvhRuL4tAtgeaCQG4YXKAswVOdLTKz41qofxwIfcVA3uYtM+oG3YZ6lR
	 9G3KsjuiVrkK6kB50fHlwmPXAOaMe8bxLRjcqQ3DEosjJ2o8RqambntOu3c53m9z63GD2
	 2yDTPlYamk/zzMqv7qYepI7GKgrgDz8GkjQBxMavpmxEAeAsCU16Fm7uNLXEEtf5c4ktm
	 sdo7Wdr/ycDnqDTKDHmErS5b2x3mo5nTkpB2My46JU1tYkNyoLtVT1e3rhTUvsmia3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656394;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bW/Lz/uA7sVH1YgxP2NKgeZ8cQXY05YJttkDFnumWcw=;
	b=h1HImD8dzDTq4cbQWwb6CXYMGErOU+C8hq0GndLVfADnT0Qf9iq3rY2o535P3827PbM1
	 qUlE41tSO02rSgfH0SQf8R/ZltCotNwX9H6skY0HbTJAeeKX65kXnNRrDbVs9fxJ0gCoh
	 ZC21KweZnnW60KFWfl4feTkeuteOG5uGGMfaalR9Mu8cwmX6YvhL2yhVVPj9w8NK5tEna
	 VdaP5fNJUMI3mTlMj/UhFCWD7ScAMK4d1BoueYRgzzicOYkqP4I2tHLYwRLElo8hrd1Mr
	 hEr6TwzkEEutQwZ3KQ3orTR65fIahvxA1aKm5NnKa69INtqqW3tu4k/ynvMDhgJ3/8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQ0TvWti;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7534606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQ0TvWti
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EA31F00A16;
	Mon,  2 Nov 2026 21:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793656393;
	bh=bW/Lz/uA7sVH1YgxP2NKgeZ8cQXY05YJttkDFnumWcw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QQ0TvWti5ud97rK2+P61Tu0Nmzwx8wKEPUBCNcqbmMDVWDXNmNz2jJ8sBqCGgYGaY
	 PytQW3ur2V1W4cbnFxoZcr9pTqa3TE6NqoH7LI39fZ8jdgDxdmdNz2NIKtMrdNQb6i
	 R6jpgJgl1o399dHjkO1xrweT/59cqHqTnEYaHAf1/aBHzSG734F7XTebVO/5u5x6Uc
	 mnur0mIYX1t6MfuSYs3A0/sgE4sRRLgQC2ukwi+CWilFSn2mK7u+86gLhfUKLuzl5Z
	 Nz9Q6xhyhp/iunm6af282/yLXj+fNLdrU6ze5/apFMPqMSr6OECUG4aosLZz6whs1x
	 N3LE5jPoRG+MQ==
Message-ID: <sashiko-outbox-194240@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v13 07/10] perf symbol: Introduce
 vmlinux_path__find() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102214054.911298-8-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
 <20261102214054.911298-8-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 21:53:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The vmlinux_path array maintains standard paths used by perf to locate
> the kernel image (e.g. "vmlinux", "/boot/vmlinux",
> "/lib/modules/%s/build/vmlinux", "/usr/lib/debug/..."). While
> vmlinux_path__init() populates these candidates and dso__load_vmlinux_pat=
h()
> loads symbols into a DSO/map, callers (such as test suites or probing too=
ls)
> often need to verify the existence of an accessible vmlinux on disk before
> attempting machine setup or test execution.
>=20
> Introduce vmlinux_path__find() to search through the configured vmlinux_p=
ath
> entries (or symbol_conf.vmlinux_name if explicitly set) and return the
> path to the first readable vmlinux file, or NULL if none is accessible.
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102214054.9112=
98-1-atomlin@atomlin.com?part=3D7

