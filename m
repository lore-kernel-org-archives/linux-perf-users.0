Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599708;
	b=Zx5N1tDFviWFYTFvIo1sMcij0fjj3QpyXeBxS3hXuPgkcv+6FEpwFUFQSO1NHi+lGSmZ
	 OWwo8oyq98M3yqHZ5lMmyMKxHcrfiFxCR0QLKOwLQpQdLE5scIrsLullHGZTgi8Oh+Dwe
	 PtnIGfv0kZMHarN44q+vOKyyRzFM5cQ19cbVdyOZXJEsfhhoiGIAaoURTG6e7d6IOkZ4y
	 sGYF3dArLmHPOJPJWLY7gogdKaAFrRuBcla6RJm8ww/YfzhDSPI2Iba1Ezo8E0wgBkYWh
	 kgVxMu0MfkfSBKIPJznmJ3TCraM3kbPpbuibrv8BFA7EOfuCt7hsAo0UkpmB97/cHlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599708;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=irHjbjg/My14Ik3ZYPR1qrZpSJ+xUGLqpvxG6SU3LaI=;
	b=oYOO0ISA39B5N3e11rVblrvr+mQ4kn4WTVY+qdT+sx093Qkv1DKXn5qxA1HODqd0alIN
	 FMuRUdAMVKtOGKHmziLShnmLTwECx0bDlGyGea8tDqbmDACozGViwpDPHMXWs5VYHcCkU
	 cEwbnB6XcVgCJX6rhnegTNRXsUSFLNC5RTmaMsclWGAHRMrTb/cn5LrvJhkbTvFoSPbzB
	 Nliwr3NK5Yzevi9tLJKvN1wBMOv60BoLdmdhHuqLgMdIqNLsEGqZyCvn8WlQ4Wo8wxqIH
	 Y8TMi/xGA1U9TZBUJ4c/iooxEeJLc4+kKRX2c5P89P9PFGW2VzLQtD4eWAW3S4H/3Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FCCtYJ6F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D279160A3801
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FCCtYJ6F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B3F1F000C4;
	Fri, 13 Nov 2026 19:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599708;
	bh=irHjbjg/My14Ik3ZYPR1qrZpSJ+xUGLqpvxG6SU3LaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FCCtYJ6FmJEFzmTV76w1TAkEFrGc6PTT/uOj20N04+uwlLwRHJJ7UYlrWYXqD08D/
	 F89AANESdEg9AyJHjZ8hMMs4GDOF0qZ4Thgo2foFssy1x2mdZaJ4mQaqvyNFSk4fa1
	 C5nOVPT8IszQrXJg5v/uEvYRXpLEaP0rymMEP4ciLj1yQ78aiNKXfADybxggC7GgxU
	 +KBFiA7LoG/7vmAzkN3LNa8OcwY3h3EhdJlDT9DvHo+vyADioGQH4c4xFq20ov7L5l
	 DO4s8TnTME0/csLvmXftY5sJHvrwcZcyVP8Pr1RcdSTL28rlJCZpqwgzqETMMpnX1K
	 irLQFz0cIkybQ==
Message-ID: <sashiko-outbox-213589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] Documentation: describe building tools with the
 kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112195427.3411746-8-sashal@kernel.org>
References: <20261112195427.3411746-1-sashal@kernel.org>
 <20261112195427.3411746-8-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:55:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Mention CONFIG_TOOLS_BUILD and "make tools_build" in the submit
> checklist, ask for libc-only selftests to be added to tools/Kconfig,
> and note that USERCFLAGS and USERLDFLAGS also apply to the tools.
>=20
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112195427.3411=
746-1-sashal@kernel.org?part=3D7

