Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794974968;
	b=bTWSUcXT2ZK18oLiK2tR7qN63YVcjzhGXFKei5YkG3LQpJ10TSMwUvTLj7uWzaB79wcH
	 7sYtimrAuv1zlSy6tO7ijXA0KJ4MHOrB74ziOfF6YtGp85c/BXi5S61gF18a2pVs/P/Du
	 RPWIZrdHdz5RBIYkm/4A/mQgeBC77m+DGxAjuabu5z05jGlLR9TMlIZtEAuBrzd9qgZuA
	 RxDsXF85vyvwjD4cDPlQKDgGv8Nh3TL/mwLnkJparRQRCy21rPeePlkTSorh3OKqTvT4w
	 5wb9eAePkJHO35B7L0dTbHU1Ls6foS3lbRY458TsgWd4bFjHgr+CAC75P1gHhjfDhAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794974968;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VQgTVFzB/3rmeNN7Lyjee5DPPoczd01qZN0k9ut7ecc=;
	b=sf8S94xnJVAuqS0itGrPEDWJUi7yoIIP+qECTRyJYUVdXZukxYKGtyAtTw331pypoBAC
	 vhyQ7YLpo8UXafgWYdT0GHRCeZp2XAq/MrHV/Wz9h7u6WqXcxP6BumSshFCxaFc1xzNZm
	 3E3ztYp78MQpk/+bRaJ3JC6EDqSqHCdrrGfNflJMCm8jKZqB7C9eJpdSI07mJ9zAyKRZX
	 phCD/ta43GjH421cCTMX5FmHJ2RbxDpO1A8Q/ouNRy/OZruXoLUnA60idFiug1HXLuMfv
	 ludo2Ef9Z14iiDgebDVWLKfnWHet+8ynwXsSSEaQnMidenhiBWBSDo1tPsBcu6+nACw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cs9BDIvq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C3606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 04:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cs9BDIvq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62461F000C4;
	Wed, 18 Nov 2026 04:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794974968;
	bh=VQgTVFzB/3rmeNN7Lyjee5DPPoczd01qZN0k9ut7ecc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cs9BDIvqvlW82JEw7D/NTbbPg3BFMDoo0RY9fgAeDQyFl59IsvAbC1oXBOrxReA6l
	 XpyXNl7O36D3C7/GHiPS+Ew2C0m5oA+glTR2o9plUwRdc2gc09VisZKVYOSuFPhhOI
	 haWx2T8iKH1tLequY5BlIR6m3DVTLtUVF7t1+amoEpHeuSkPV1lzGIO7w3OoZKiTBq
	 AiDKIvA91Qw3MBlcFUC01KyOFESCQG7juyw9xyw9lSMC0rLCHTjFrBeQJA0HwUMuHA
	 rfDwshi6XisJTY7feVtuogaSyn/E2UCAxAKVQzSSwRQCJcuUBynNWafkjLTCPNn7W6
	 DDo20U+sYeiOQ==
Message-ID: <sashiko-outbox-220069@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 17/24] perf/x86/intel: Refresh LBR stack for non-PEBS
 LBR events when needed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-18-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-18-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 04:09:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> PEBS and non-PEBS events share the same LBR stack in cpuc->__lbr_stack.
> In the PMI handler, the non-PEBS path refreshes the LBR state before the
> PEBS buffer is drained.
>=20
> When PEBS and non-PEBS LBR events overflow in the same PMI, draining the
> PEBS buffer can overwrite the shared LBR stack with the PEBS snapshot.
> This leaves stale LBR data from the PEBS record in place, so userspace
> can see the wrong branch stack instead of the live LBR state at PMI
> entry.
>=20
> Track whether the LBR stack still contains the live state from PMI entry
> with a cpuc->lbr_stack_live flag. The flag starts out clear on each pass
> of the PMI handler and is set once the live LBR state has been read.
> Draining PEBS records with LBR data clears it again, so a non-PEBS LBR
> event re-reads the stack only when it is needed. Since the LBR state is
> frozen for the duration of PMI handling, it only needs to be read once
> for multiple non-PEBS LBR events in the same PMI.
>=20
> Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D17

