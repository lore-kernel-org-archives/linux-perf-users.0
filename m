Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232360;
	b=WfKhwQ5DyNcHHNCw4vWQyUK0JZcIbma/RAtQstYaVPMRO256yCmZd4XoovEkGe1YSCtQ
	 p79Inu8VUMuVBRZWdS4f3kW2qQ1n55cj5efoVtHT9llPYnfQVJVGpsdCXOsbMBl30tkb0
	 EgYXFUPGUAlTYXb1DexQCF2cLT3lGnet2q0PSNi/LiApI9hU3RSSB1cSyx/Vj+EzFYFai
	 Uxtj8lnev/6xZ02RPMgZuo8L+ovpPjgNdSgjFfIrfZG6KgS0U+BwbGtLEQ6HedZABY8bx
	 sLPiOEjHz8CV38/WfjWv7rOc9snOfyRsbSQiDUz1nhSXC3gxOP5vICCO5+/A9QPu6MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232360;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t5DsoclUMjS6n/PNs7+mBSDJ/nmL+nF9KRMG8y3E1uc=;
	b=rE26MCFwn7Xts1mR4p9Frqkp7oB9XtA6ICVkWEb2JzE88SEAUlrCFpswK6VMa0apj++F
	 r+2lnJJebPVl0Dayz2GIDQH2VBuku0Dcp31taLenONeu4GetO90EYU1c57CAlYYU5KUi0
	 9CHIaYULFV/hz5cq7/1zaMKm9K5s8N4nCYfNSLmf9fIIva2SghERYyTux9Fknt4kl0ulq
	 lQuBE4kwyvgVPZ0d3BSEWWybaC2BNlRfIbUASHEYru8knGpA+4JiQHRXVkmIZ5mcAMU95
	 17dJXpIVpNhTkNutFs8kDR/6OyqoMkrw3RSn0Wv0oKzCy0IqFdZwFzDUQwk2vUTWgOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YaKSrCoZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43BB606A321
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YaKSrCoZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FA41F0089F;
	Mon,  9 Nov 2026 13:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794232360;
	bh=t5DsoclUMjS6n/PNs7+mBSDJ/nmL+nF9KRMG8y3E1uc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YaKSrCoZjEpZx9SowIaXE9XYbjnBgbdj0eQdqWLW+dCurjroInDTQqa5EClDFIlfC
	 NFEH0dvRxzjLsBsUdL75ulDc7ExSrlm6HOl8i1YgES/7meAFljInfhOC5p7hMPjY0Y
	 yvb12HIx3S/YPY7Nj5EFd/yrbQXvV5seWsGiAKYvBc9uegvZjqqnYzX/f0He4cZAqB
	 VKQhVyg22OwzAa7saHpSGPyPCkqQURp9sUAt4L/KVeRphGk60AbAdevTfsHlfCT52w
	 7QfK51cIC7ZHpoVLLDwyEKLwML9uLiacRhIKtSyybwSuICD+n0reM0mV1pL6eKQNBI
	 6aISPlz8BeJAw==
Message-ID: <sashiko-outbox-205035@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] perf test probe_vfs_getname: Fix missing
 debuginfo detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109-james-perf-test-fixes-v4-3-355ee6b81917@linaro.org>
References: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
 <20261109-james-perf-test-fixes-v4-3-355ee6b81917@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 13:52:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> skip_if_no_debuginfo() looks for the errors that 'perf probe' prints when
> there is no debuginfo in the output of add_probe_vfs_getname(). But since
> commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
> line detected"), add_probe_vfs_getname() returns early without adding a
> probe if 'perf probe -L' doesn't find the line, which is also what
> happens when there is no debuginfo. The error from 'perf probe -L' is
> discarded, so the debuginfo errors are never found.
>=20
> This causes the debuginfo dependent subtests of the
> "perftool-testsuite_probe" test to fail instead of being skipped on
> kernels without debuginfo, because test_adding_kernel.sh calls
> skip_if_no_debuginfo() unconditionally. The other users only call it
> when add_probe_vfs_getname() returns 1, so they aren't affected.
>=20
> Fix it by doing a dry run of a probe that needs debuginfo instead. This
> [ ... ]
>   ...
>   189: perftool-testsuite_probe : FAILED!
>=20
> Fixes: 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable li=
ne detected")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-james-perf=
-test-fixes-v4-0-355ee6b81917@linaro.org?part=3D3

