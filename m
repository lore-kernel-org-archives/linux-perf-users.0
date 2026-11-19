Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114608;
	b=4sA2BEylNRVD2WkKYfpsBcaH9eS4S/rWTOBI/EJBg0srGiCnA7n8H32wOE1SlXSpFDv3
	 x9JX2hFYDH9303CYepqKyXW3YQl61pK/OXzTXq6MeMZ2jeRksWPH+nic7E8TXqFQmhhk7
	 bpLcSaROJ0DfOk6rKfXa5kCq47/Ic6yi8G31abjwfW7WIrPQceFj8nWgar+OvGS17YLjf
	 fiisXmv6vbicIU0pJZ1G2+ETlT2ATec7xhU1B5sawekbNdUV70AEKsYFF2kAettzgKXjt
	 8EoSIdiZB5PjhtsbW69txYposnHPVZN73/kQ8ta8r3/+GMU422prm34BQdK2ed7wAOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114608;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ryPNKuEaMX9GX+PD+Q0KOLNwYmuzX9l8CUGRRSAoiZU=;
	b=y6APulSkt0pjt/gX7vjEYz6t1RusvghPss+PWhQFCNhAF30nNCIP52VjEWIoMHV5xbPt
	 HG/iy5qWQrjklWeVVnd2axqNpRKtwH4juE4JpZsbizfznfdav/h7Kn83ZxPWJnsiQweo7
	 iyPDhxncFFYlvDx51LhZhRiUTTQj2VQDqh68kV/0tll4oHSoH7c8R2CzvMy9T1kt/N3Iw
	 qaYLhBpiB31ubJgOn3552bP7auXkUJJeqjodAC+GIgVuaFrOUwqlAIvNB9psgEJmhfWE4
	 EO7CecLANPP2yMSZbr4HlHKGjbup0FdbYMYwMQwekbGmMQ5LA3WPlA1A/8i4slg/dCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daVoZIqs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63991606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daVoZIqs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A8C1F000C5;
	Thu, 19 Nov 2026 18:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114608;
	bh=ryPNKuEaMX9GX+PD+Q0KOLNwYmuzX9l8CUGRRSAoiZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=daVoZIqs8XME3VyHcfiUUgBmJnCEJcTCsClzs1b2M9ngOFdLzgVHKBzFncIsgyzpu
	 Q9223o2hjUL5gvH1qNtLez9da6m8bpD9jmDxssZ/VRku5JkVcHtpktTJIVn0cpvpxv
	 EenM6lO/1GlZVqz98mXPIc5ebBgyXTMTqZ2s9+5o1k2oSbySV47MpQEFRVhxUOKbDy
	 KFp/MhpLvKBPJuUgIDsUEfmylG3YR7sMBanvLTSjqqRZpGea2RDSk9VbBNNbimlRdC
	 fi3dXLuR/4NMe9N5I7VY1qdD3z5lVGK96suy09h1nQFU/VXb5PVrYSG5M2Uv0xtO6C
	 FR7RMIDmVVPtQ==
Message-ID: <sashiko-outbox-223811@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 06/33] perf: arm_pmuv3: Generalize counter bitmasks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-7-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-7-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:56:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The OVSR bitmasks are valid for enable and interrupt registers as well as
> overflow registers. Generalize the names.
>=20
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D6

