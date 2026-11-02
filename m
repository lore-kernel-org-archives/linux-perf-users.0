Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622571;
	b=F8Rf90Krp3CQ11vsBMun4TaJgWsX1N1sstTTbyY6STavqWXZUWVA36mrfGEOQVDKx4bh
	 4B6nMyorQ0cSMtjYrcRsKv4+T3EwQR0nN/iCCDEAqBHMPVlWdF8zFOcCxQy/3qfD/b/x3
	 XGFnK3/6zuMeXvEjqvxPdJJtCcVOWO0af5NIeHp/kqYPyuk9Vr2RG3sOjDNmE8Iku+vLW
	 VeCPMR3OlNkN7VSKmbONEHPcjhXcliytgzRmYue+VwaY0/4qhHeT0MkV1DPbM8kbLzciL
	 mOTWn2vxma3qwDYr5UHIHyNMUJzqAaJU2WivrRLy190Jr0Ro9oIT53aMIiaoLJFr1HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=huFJ3KazMZIfQIbOTTer+Le/VM0ppXoD/yhODOb+HGU=;
	b=MbySH5fT/Nvk0Z+ZeBvoxfnnwNEayTcy7UgpPk9oz8smls505o+dwwlSeGKyBb9Zvdq/
	 WzqxLhmrR5CuB9LaSsAGD4J+g2ijqXM5ubV7lZ9AKYO2PzIOM8zjWPszXEhyrX66APiya
	 JkfUEvWllo+NLwnpsyD0E0Knf5U/XK5A/1YKwkoWArle9dfgEyxQEMfZsq/bBC/lN2Dmo
	 CY+VrG0UtcHu1BBUKd9zPBf+wpfmGWl8CileH1jvVlsd8ThoHqdQZHeExvUnTLVzwrAaW
	 SfBYyAlaZ1HRaEzPY8n2BvUBDaLx+EUhcBtLABh9Q2DIHKNzM0oyzytJ270VYra5utA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgILHDMO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF02606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgILHDMO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775FE1F00A16;
	Mon,  2 Nov 2026 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622570;
	bh=huFJ3KazMZIfQIbOTTer+Le/VM0ppXoD/yhODOb+HGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XgILHDMOZFf7fOOEqh9Rna7fWDcOtheSExiS6fEWvOg9nkKYBExF94lrHCeorDUnn
	 jF0jo5F9awWu8bUViA5g9BYTs+Yv1fFx1ReAbspD44T278YYrRv7hwAF6kCSYiSmM6
	 1QJEnwTViW6EoUceOHG0uaokuMUMM7Iy+kHKFDrZSUoQTbaySmn05/8YNVG5IT8ZTq
	 V6cWjheMCR3bTTYFZiBN5YTPK0+bcBwdoBWqIFXVg1pNM6f5/83VXSwOQHerZTKOF7
	 /N5DuHKYumdtgpSzTgZIWuyupwOkGgRqIhTDYGX6JvV8SJo+lixKMfjnpdyfPAz79j
	 QOyUp4iI73R1g==
Message-ID: <sashiko-outbox-193408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/18] perf cs-etm: Don't drop previous target for
 kernel samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-6-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-6-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:29:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The branch target of the previous sample is used as the start of the
> range to disassemble, but if that sample's DSO is "[unknown]" then we'll
> drop it even though it's useful information. This happens when recording
> userspace only. Save the address earlier for "Trace On" samples, before
> we get to the early exit condition for unknown DSOs.
>=20
> In a later commit to change the default timestamp interval, trace will
> be collected that triggers this issue, so fix it now.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D6

