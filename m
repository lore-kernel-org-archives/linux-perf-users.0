Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004535;
	b=RwuE1ybrVGXwzSK84InEQAkXdxw8F/Fjt7Fj4QPNA+VFZoFbh4KH1R0g/H7Jo7Rl1HJL
	 9CmfDBXwkKlruq4M5OpFar+Up3SHlF/hqVE73eH7uSFd2dTjEOIInm6JJxabkS9tV9POJ
	 15atq1ms677R1CT/WaHpJws/9VmdD1qkHvfVTJFNmNxKdaA/lNsAa02t0KGD+frjKkSkD
	 0pb64PmEMXVhulBwfOKsIAiFCcrVN4smtHpZPKcZnb3ZXQ8oX2X8cWhzpWkjQmOYEH0z4
	 DIjsqiYdBpO+75oTmaiq/6WOZbwPiuSE9P/6YOPwNdWVGS2Mz60eflfkaoe8rwSDDlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004535;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XL4veURXa1DZA4IPKDsKvjd9jDwsBQRzm7S1i2Ezn7E=;
	b=rlRSyMbUzSq8+/guyIP/sndv93x2YSxZS3QWlvi8zCzy/9fBtMs2ljb02PByAYQ/r+t6
	 En98Z88U10tcxfJBHE4KFF9gyZ/4juHX6/PDNWMLPBKYJ7xp3i5TEHtdbeeFNPs3YB4wp
	 /aNOWSoN6TbncafRjnpIB5BjsFfj1BXGM18ufngS8Klsmmb5/Nx7wIr6cTsoLx4bASLh0
	 RfT916ClygwUy14sf/QXNbffg6yOV76X3hn7MMAwPy06BTjESiZnnc/GyEHpPyAg2WTjE
	 8PB+SbTWiyKXwmY8xA1d1f+L6okTutGYGZUa5OHe2Mnz5xkETTgfnG5JA3C3L+vEnqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Unk1f+pJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB6C606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Unk1f+pJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D48C1F01825;
	Mon, 26 Oct 2026 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004535;
	bh=XL4veURXa1DZA4IPKDsKvjd9jDwsBQRzm7S1i2Ezn7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Unk1f+pJnSEKrsXU+FtJ7tPTQSnp24ZdFgwq8MpIBcv3BZ+DcTsa15lBZ+JTGJ2xg
	 B1A2CapO3IrAMwJo+Cu+go2Zg5Aaz+Ig+vErpCCcfo/aEgnvVi+O3yA97FoHZuPao5
	 Kiub9gOog9QvdYrb8c36k72KEFbzJ7cdvTa+hRcBpKSdcCmOidszgvIpPp3Kemk5s3
	 j39/2KBYKjeoEWVU9AhP9kjMSs70J2A9m7qN/Ca6VTv796D8UJazui+mrhql5sJlh+
	 v3gYOsbTMpfqJ08BKbhhpGRSbzqwHV7L+pHegIyG6YX/+Y4z02Xt2dyLxXgBU/B+nq
	 Zao83eMtrQNJQ==
Message-ID: <sashiko-outbox-184692@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] coresight: etm4x: Report whether the PMU counts
 the external outputs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a433810b85a9b768489d7b7b3ceb50324a2cd336.1792989860.git.aaupov@fb.com>
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <a433810b85a9b768489d7b7b3ceb50324a2cd336.1792989860.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:48:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Some CPUs count the trace unit's external outputs as the PMU common
> events TRCEXTOUT0-3 (0x4010-0x4013), which lets a configuration drive a
> PMU event from trace unit events. Other CPUs, Neoverse N1 for example,
> have no such events, and a feature relying on them would silently do
> nothing there.
>=20
> Detect at probe, on the trace unit's CPU, whether the PMU counts every
> external output: the trace unit has an external output for each of its
> events (caps.nr_event), and pmuv3_event_implemented() reports whether
> the PMU implements TRCEXTOUTn. Only check ETE: per its specification, an
> implemented TRCEXTOUTn event counts external output n, while whether that
> output is also an external input is IMPLEMENTATION DEFINED.
>=20
> Add a CS_CFG_MATCH_CAP_TRCEXTOUT capability match flag, set it on those
> trace units, and show it in the feature's configfs 'matches' attribute.
> With capabilities matched separately from the device class, a feature
> that requires it only loads on those trace units.
>=20
> Assisted-by: Devmate:Opus-5.5
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792989860.gi=
t.aaupov@fb.com?part=3D6

