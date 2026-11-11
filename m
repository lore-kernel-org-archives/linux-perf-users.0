Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368842;
	b=ByseSXTGfAfB+H9Do1prhguaC98goBDZTeC0HZcOWGhGFJajx7/ccj/pvf+gKSZVfgOS
	 C+NEcVB+U3zwl3kHwptahtltc/fFCUrXeMWzCtenwfeSDKGm7xHXgqEC9Sd4OeQcRKLGU
	 F2pCcWUXuHMCrtKldlPEzYqd/O3qS9Y+hG7kXcXQ/mJQ6d/Qv2/I90asJKeR1eIeDdNTd
	 qZTcJdUNfphOkGTNAVkBh1WCdx2aVK7Vfh/wLdcC4UiSy6355EIZUO08eMgaxidveu7ca
	 0OS7xmgOtdfDuZe6lpF5ckiukvKB70sg4a/uUjJV0qWT1uxSO/t8dp2/IrBext7BROA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368842;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VzPr8SWW+p7Xl3Ks2KX1NxrCJwgPmd8f/4FQGAD3tRQ=;
	b=Je8kSB6qY5Shfs5oeiww/ypaq35mRQowM/R/mFEPc/3fNLfp90utukh2evz6cAofCE/R
	 BGo53zGHgxn/nMvnT3FsvbDItFl3+C1lE7WhHe6TkE85Te/TYTXm2SBp5FhO/tUW+qD3b
	 jrUg1ifMl4JO6nT2TqriLCQp8+zoqqLOlpRH0I+jctdEyXk0jumiJXtQxZDV2ig0rBBc1
	 abVNsVnTQLylws/lWcAm0/XZXPpAm8ar6JXInn49x7FueoEes5GBVEuUK8ZP5ekfYvrdh
	 nQZxWWCjFO86pMMGERIlCe8b6+gW86JoB7kMNBZV1b6qA5JGNvApeeQJpv6fuXZ7jIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewZHDEIf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BB606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 03:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewZHDEIf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAC31F0089F;
	Wed, 11 Nov 2026 03:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368842;
	bh=VzPr8SWW+p7Xl3Ks2KX1NxrCJwgPmd8f/4FQGAD3tRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ewZHDEIfJo32NruSdPLh3jSTo203aTM+w+6uNuLhsgPrhY1skxy0kLr666zteovlL
	 23R8c+gTMgAkDRmjUUl0gwdqw486zGfNbq1BTMEcGf/Qew+TRlKv7WxzwYQOFcOfYg
	 EtesSZkJafQZKsCtvt6BeFA4gk/ueAjgRjWpLsNzMuRsWhJ3Xj65w7a3Ph8Pgq4Xpr
	 r8IVR1KN9W425X81jCHwKVB+Pd2R7z1FTGEofv7Vs3UI/gH+nZexqRRqeCn0dyrS/1
	 nbPqXmoXwB3tm1eV9Hknr++u5TUtshTxfJKrm7V+nkllHZj2hVuAODnGjtTBBSsn7U
	 L4hgJnZFntsoA==
Message-ID: <sashiko-outbox-208224@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] arm64: perf: Drop the example the userspace counter
 section points at
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111034432.2020955-1-takano32@gmail.com>
References: <20261111023550.1971639-1-takano32@gmail.com>
 <20261111034432.2020955-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:47:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Documentation/arch/arm64/perf.rst points at
> tools/perf/arch/arm64/tests/user-events.c, in the text and in the link
> target, but that file is not in the tree and no commit in the history
> leading to this base has added one.
>=20
> The section already describes how to use the libperf helpers and points at
> tools/lib/perf/tests/test-evsel.c as the example, so the sentence that
> sends the reader elsewhere is redundant.  Remove it and the link target
> rather than pointing at another test, and move the instruction for running
> the example into the How-to section, next to the reference it belongs to.
>=20
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111034432.2020=
955-1-takano32@gmail.com?part=3D1

