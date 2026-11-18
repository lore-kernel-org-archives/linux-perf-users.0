Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020431;
	b=FR4Osc6PjPtjkBinfdQC55lJES0ny+XIK7hoqQpwt6q+7lAZmjKkaH/euXxVplC71omJ
	 fsibg+h9zzA9xlRJvZIBCGB6hjtc09DHKZHShZ6JgQaFA1+WjmteeVJLgNVVb0OvRA0Y/
	 KdsgHw8GHpIfvocJrEA50aXLH6UvL0k+SotVFZ34PIBo2Jx+T1e91ZdeMV0ckRucDEZzY
	 vhDaXjl0Au0OAlkzw+TUUr3l3Z5ZtFpRZPkz5znxwGhlJshZOl9UFB496O/GPxZGjaGRz
	 QDA4jtHZEJEV8CwNke83rtq8vU6VC353GRYH2c0Kb01dFxW8DsyFq7/COJSAktoqNzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020431;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WRCVYCTlLa2AMtfuGoqEZTAWOmGP+Vt4iY9HOSFObQY=;
	b=XoPiJskGVwO7W+4W/rVS3l1nD5I7FiBpt2X6sol+nPu5tNo+SA3w6Yffk4gJtt2moEWR
	 Atxb8wpBhfKTg+DfsMH7GCRXskJP2r4Wpu2yw1PzcoC0drhVS0W++fPHdngbS+51n9s3x
	 g5kX6BgvLxA6QFaOQ8jctCg/l2vaPZ09U8fYZMadcSsd09Hm4sCesWbAe9U2Qk5EET7kR
	 KHPMr7Lh3S1niQM9MiLo0xDTMnFmnOO8DFyaKm/6FzqMLB7QpAyB0McNXSO+fa9t9W4nC
	 NowT8Bp7fFVtfTeqhK/CsfHAPJoc7sDuxSoolRnt5uD6wxp/GVQelRqnip4TuWdE+2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qo9y9f3F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE8606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qo9y9f3F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47C11F000C5;
	Wed, 18 Nov 2026 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020430;
	bh=WRCVYCTlLa2AMtfuGoqEZTAWOmGP+Vt4iY9HOSFObQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qo9y9f3FTaquiKaeSv/titsdf/DT1zHoNzrlDPM11dbExPG/Idk+hfDyUx7T7nW7c
	 W77rl8K7kMCRiwg/ZTYdu4kGNVgKjvReQNLGs+lRT6HC5cUiM/+xVPSFzq1uapmW7N
	 m2azQwL4cmEfcSDqu+n/XXWpGOayvbJuRpVM6zsC60e53pdx3hqgE2X1R2u7FMayBO
	 kaPm8tgj1ND+kwRWb60NcD57FMZQGY4cWlzJrnfqGRCnNXsReS/Kq3fy8bzmBWEWJx
	 QyzE2RbDtBkoPvvxGaJdiFA6EC2v4N4PA8+JfyxMgNFTHWFPhwFoK1zJDEwlNLcpPl
	 hZYmv2jp1CkUg==
Message-ID: <sashiko-outbox-221549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/34] perf cs-etm: Use the exception level to tell
 kernel from user
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-5-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-5-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:47:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> cs_etm__cpu_mode() decides whether an address is in the kernel by
> comparing it with the kernel start address. On arm64, modules are loaded
> below that, so module code is looked up in the thread's user maps which
> results in a decode failure.
>=20
> The exception level of the trace is known for ETMv4 and ETE, so use that
> instead and only fall back to the address when it's unknown. This
> enables the ability to decode trace from kernel modules.
>=20
> Fixes: c9a01a11dfe6 ("perf tools: Add support for decoding CoreSight trac=
e data")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D5

