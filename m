Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611C3E5A32
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922800; cv=none; b=MkjMoJvMuoWHRBNxO09A4nb4ssu5qZTqQJpm+i6Ki0GTJIig3QWm1Raz8V41OES3bXALevmMVxXIfV89VNji2/a45k1s/xGWRCwpex4h0wS55kJZwoDu9yTgguYB5zbmZuuD7DtV8FinFSxDhT8gtLWjJG9RxZk9fOASVdN1cPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922800; c=relaxed/simple;
	bh=fGz0uhS0F9kG7OPeeVU9UcA/0YoPfjR87w5Rfj5QBrk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tc/Jzql7cXLhZQ0Uog5NakOv/4D7tpB008tBaWEjoZrWsF4i/kYKRR2fTYJMvo8fExLLaTvwkZVKY/D0t+3vNwUop81OxM1BeSQEpipefD8PKb9VkLOq9PSvyCce46oYsqfNjW3PuRU+PlyV5YQwYsfzohHBJlql/xEQ/w3gLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ompxwe7+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ompxwe7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432781F000FF;
	Tue, 13 Oct 2026 20:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922798;
	bh=fGz0uhS0F9kG7OPeeVU9UcA/0YoPfjR87w5Rfj5QBrk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ompxwe7+4v30+vY65up7ofd0cPY1ZURORCDY0N4dLj3OpYTTezxoOXOgzh2gGG0Ye
	 htAoujDJz1BX2S09dBXNMK+BSR/yQ+IWMuwr/yuA28zxdcg33ux+pqQd0Mtj0nn4lw
	 yEh2PiOzBDGrIzr+oM/Po6l24LtCXgpNskf1WiBFmp//hhDJIK80ZdtIOziPWJlblK
	 1kuLSfgOCH21N4avwxuvdOEPtoMmyfE2q/U18V8VrZY0JmhCZiGzo1GwrtKNBCRgO2
	 Obznw3IHcEpl969X6s72KlA+X9R6f3/7xjJ7VzDiFpbY6vryMkcl/m/H+P1Ca/YJX2
	 Bof2+hcYu0q5w==
Message-ID: <sashiko-outbox-170444@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/19] perf test attr: Introduce mask_bits(),
 generalizing hide_core_pmu_type()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-10-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:19:57 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> What hide_core_pmu_type() does is take a set of bits out of each of the
> '|'-separated alternatives in a value, wildcards included, keeping the
> rest of the expression: extract that as mask_bits() and implement
> hide_core_pmu_type() in terms of it, a prep for using the same thing to
> ignore, when comparing expectations, the sample id bit perf ends up
> asking for and the read_format group bit that a PMU count can remove.
>=20
> No change in behaviour.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D9

