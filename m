Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185953;
	b=PhVV8Qw89c9AtrFdWc/G3i4Y8sINVK/YWOpWH8xP7SablAHwUAnmjzL7IvjYA0JEemXb
	 JFiUxQ4riCvXnsUf933G9ffvhEsOMW6UK/i7AuzmBJu835Ree6jrFgi1YWgGHPrjjp7qD
	 ABc8QNwK6egNaFGjR1i0ztg84FVNpK+2T4vPkwM3D6XUrVO3JsmoXCAmaMrolHKhKpJj5
	 kG2m4xwDXygcIb7g0NWsh9qxSqyvpNVfYKadmyV2eaZVfokqgDBwBNHjFifSd67VUk0nT
	 fkN4d/kahkvKnPit5yExBYg0OWxSvPGYrQZfKUVWT8lgiECpE9dZv4zRUp7iF3T1x/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185953;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mt6oSNoD4bDJa4eOaqExM9bLhPNmjtelGh3usPza1Vs=;
	b=SjaoNZQMI4Dd5ucbCVzdSceZK92Vzrqx4IXcder856/0n0wzytuNNpCPBAE3L2lFFkS0
	 6hPBtUEEAj+GTZnfNVly17fe2GYxMPOS8FqVKjNPmmXGIPi+7E5S6EKneZnbJxrOptqwF
	 98Xs5KCfgLs376v0FcXjKDkRgsg6mGLM2uCJnmuJaFFYS3q/iuuTjgnVyF/mi2u04mzoU
	 uE9DQ/qRalNOQGySfPRbiBF+15oQrDvXQR7D3n50Kb+p/0xVKBVuGlg4jOulLz0TreSWe
	 kyPwtSAm383jj7kefOhqpaI5IAQBEthaXwsuk2/FC61el5MFziyW0Rwm1RxB/VPjDyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAHUnxv5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A4606A31C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 00:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAHUnxv5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE421F0089F;
	Mon,  9 Nov 2026 00:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794185953;
	bh=Mt6oSNoD4bDJa4eOaqExM9bLhPNmjtelGh3usPza1Vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LAHUnxv5uYOwZQJITnPPBPS2fBW2+TOdmKq10QIJjf8HHzGDL5r4+pzhhkXd6Nmrh
	 XcBRn7Gxlx8KXxstW2Ti1BnE9AT0oM0FaSxMDX+OEyb/E/0X/v6pGCEgJXwXHg3XgK
	 dJyszu912tfKN4y61/H2bjCpn2sz8sXpPCbM199jmmgRMw18OiTNk2OtKOH4V2eQjH
	 gMLjpk0R+qVobfh8EoADhiGlwNB6pl1J96BXMC/geXkXSs3T2d/KDIUct7pKm6s0I4
	 tHfTNfq2ppNRd/DOF7qyv51MDsUOP2HmuipYMpSSOat6XC532+4f9umbTxlejltqx5
	 BKUyzqxijS31Q==
Message-ID: <sashiko-outbox-204268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 4/5] perf c2c: Show all memory regions in the region
 column
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109004402.1403713-5-dapeng1.mi@linux.intel.com>
References: <20261109004402.1403713-1-dapeng1.mi@linux.intel.com>
 <20261109004402.1403713-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:59:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The c2c memory-region column currently records only the last memory
> region seen for an address. However, a single address can map to
> multiple memory regions over the sampling window, so reporting only the
> final one loses useful information.
>=20
> Update the memory-region tracking to accumulate all sampled regions for
> the address and display them together in the region column.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109004402.1403=
713-1-dapeng1.mi@linux.intel.com?part=3D4

