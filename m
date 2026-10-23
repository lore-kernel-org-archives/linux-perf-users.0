Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762496;
	b=s1yMdHJPa0iOU56pyYjhPDFV7fxgJ0dUaOds26MhrVYilfvLG/wtWIbfmZ27JmXi6nO/
	 dPmULlRLaPpP1XA/CJBZ417nxpQwcInLVG2jr2CRe6mrp24BN+v8sGInRYq4khhsPDcW0
	 ox2uQBaHyCieQ2JLVLn7rvkMXybQh2x+vMrNSulnBq377il4BhQrbA3ISvWFxAxb/y+Gi
	 e97ghVhWwfn4+gsKOooRljmtKLUlg6uyU5bFkrNdXG41UhaHRS0Ai76A+Z8AYztUczolq
	 39iLcFW+jUdvCRC4Hg3NxRlG+bzIXzx4f0k01uoR88D8DLgKKMFe8cvLiG00Lo0kbRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762496;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RUyJzUDweL/DC+WV/zpRyo/kKqATtq5/DECdNK4HzrU=;
	b=DORjWXdRMqBsEI0zyEBfwUh8NeldBqjYQ4uuGgQqTMO57UFUN8rPzaKTY+/1Fv4uisDa
	 KgtKEryGFtZ2691iAK93ners2GCjYaRoJVlT8DgK2+I++CFTG1nUtNhlXCuPlYm+e5s4u
	 FTMkscfm/zeXPnMTy0GZCb/+eAzvDaK/lasw5FoJ+sHCNwMlmULjZiq5C9XAeLnP4+WZu
	 BC/W9YhAnU2Wuh1FlBYmlnQLJFnqAjdg8RLogOG1JeIZDzME1vJ0anRUq6A61fKeU2ATB
	 0zuEgNfdflkZFKPwwidLmH6koDkVPujVqyBCgucSXzbO+01wQMqGRcnN2DEpreRaR8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaZ7LfEQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BF2606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaZ7LfEQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820DC1F01825;
	Fri, 23 Oct 2026 13:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792762495;
	bh=RUyJzUDweL/DC+WV/zpRyo/kKqATtq5/DECdNK4HzrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KaZ7LfEQ2Vv5E/rUv72VWXsdxqE5dxobOiC5IInclWM9qbmCK+bS0YilJUuSwDY/f
	 xvprqHn1qB5w+uvXiGXLdjOfBqLXepk+ebjvIoF+7p6+ppdeKON/tPQgsTWeJgr/Ev
	 PH4E092FYzYw1VpZ8Hafn9NoD/VKR5f4+8pDOZk7hjf/cH2vFWcYruJeYh+g3mKtmC
	 yLnMVwDPbtTSh9nKaYTteRPTe2pPqsZfo+zMjWiWufEtbAjr07idQ1vkzKbSPogugW
	 2Ak1z2bmzestKrUIbAXLUUVTRVq5BepZGmjuelUluWbPIJgDtuplXGMYTL8j3uwQsL
	 VpfELP19nCiCA==
Message-ID: <sashiko-outbox-182822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf treport: Initialize the subtitle in the
 constructor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023-perf_fix_pylint_warning-v1-1-b9da8dae2fe9@arm.com>
References: <20261023-perf_fix_pylint_warning-v1-0-b9da8dae2fe9@arm.com>
 <20261023-perf_fix_pylint_warning-v1-1-b9da8dae2fe9@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 13:34:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> For Arm64 cross build without Textual, assignments outside __init__()
> trigger pylint warning:
>=20
>   ************* Module treport
>   python/treport.py:625:8: W0201: Attribute 'sub_title' defined outside _=
_init__ (attribute-defined-outside-init)
>   python/treport.py:629:12: W0201: Attribute 'sub_title' defined outside =
__init__ (attribute-defined-outside-init)
>   python/treport.py:668:8: W0201: Attribute 'sub_title' defined outside _=
_init__ (attribute-defined-outside-init)
>   python/treport.py:675:8: W0201: Attribute 'sub_title' defined outside _=
_init__ (attribute-defined-outside-init)
>=20
>   ------------------------------------------------------------------
>   Your code has been rated at 9.91/10 (previous run: 9.91/10, +0.00)
>=20
> Move the initial subtitle assignment from on_mount() to
> ReportApp.__init__() so pylint can see the attribute initialization
> without resolving the Textual base class.
>=20
> Fixes: b379b70b7b7b ("perf treport: Show the profile while it loads")
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-perf_fix_p=
ylint_warning-v1-0-b9da8dae2fe9@arm.com?part=3D1

