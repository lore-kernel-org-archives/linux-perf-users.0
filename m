Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116174;
	b=xw4xNh269VtQi3Vl0N58SsHbxuv+8kknWIoKDZlQQsfMcSwgS/e4tnEfgcCAs5Duh86U
	 sk2K8tb8Y3pEHgM7JzvDuFAPqlmB5z0+dtkC+PVRxdRBjlYUHLRZffRXLT/67Fh5jN2qG
	 pbaiLuagJZNGEb2GytPD8/wKC0dHZStCxLIHmVQm79ZSxjhFzhnFgQk6bazx35Fcav0Yu
	 k586esmbu5Nyho89JAfgxLj7pwQci0bPyebNnd4yN+nESxc84pGvhyjI6re2yvRPjqRvX
	 r+fEOEcJGzhNNyZOIesaRkwQrSPN5405E1DzY35/mzvjMLLukbfBW0kN/y6zKjB8JeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116174;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zQN7F4jXZl/wzXWr0THj7gopSsVCAhOCSg2tJlWUxdA=;
	b=PxLfvM0E40SlUc5s57b25ng4xTbPtyq2R3aVSz4vilDALZFSNZdwe0uyB9B5rdHvFUl+
	 KPKhPse7pyUibPXH9fjoh8rSPfU/61vPGWDhAbObrdZQxgZ07eAZXBGqCmF7VmPL2qIQF
	 dNRS2ChmJ10w5DuguPJekcOKAvGygSciTmDUpkG1/GqSLl7kkSu6G63Pz89Es6ioDRAUC
	 7nDn39w7dcQUrnOTn1SCQ/CwaClpxopDkc3VQNHLhso3BCFIAVoPa1K+x/3MQRpluoNqh
	 LI1ZERsfB/yuVhxjLwTbflwrrpnxuMnU4jCwfHJ4R2UMt6olbcU8ellHCukH4QFNo6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCT9JeGQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4796B606A326
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCT9JeGQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41B31F000C5;
	Thu, 19 Nov 2026 19:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116173;
	bh=zQN7F4jXZl/wzXWr0THj7gopSsVCAhOCSg2tJlWUxdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LCT9JeGQINzt8cyuox+J0kgecuLlUf5HiDJgu4bO5PuNu4qSWlW7KFabPrbcRuKup
	 zb3ZH7S08fR8BAMbuBDmDfpIP9SUgjKblOZXM+wjFKtfKM92GURU6oKE9FkUgMCRY8
	 Buo6iuIf1UEuyXva+x/WtCcjLCPBx5YSED91f87Sg3HMn/T9I0liKIDzbU171uVjFJ
	 J0XqY/VTAr52y2GdL5J5icfFpWzDGATs1NDhjl1VKJv7SpviFat5asPTzXq/QtbLUo
	 laooz/jEjQ+oZB37t/OJ3sTwBvuy/n+eokxhm+5B4U51MJTe02Sju1XGlJWzK+JYYI
	 TAp/FqNOaJlYw==
Message-ID: <sashiko-outbox-223869@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 24/33] perf: arm_pmuv3: Handle IRQs for Partitioned
 PMU guest counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-25-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-25-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:22:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Because ARM hardware does not directly inject PMU PPIs into guests,
> overflows on partitioned guest counters raise physical PMU interrupts
> that enter the host's armv8pmu_handle_irq() handler.
>=20
> Update armv8pmu_handle_irq() to read PMOVSCLR_EL0 without blindly
> clearing guest overflow bits:
> - Pass pmovsr to kvm_pmu_handle_guest_irq(), which clears guest-reserved
>   overflow bits in hardware and latches them into the running vCPU's
>   shadow PMOVSSET_EL0 register.
> - Mask out guest-reserved counter bits before clearing and processing
>   host perf overflows, returning IRQ_HANDLED early when only guest
>   counters overflowed or no host events are active.
>=20
> Also add kvm_pmu_host_start() and kvm_pmu_host_stop() so
> armv8pmu_start() and armv8pmu_stop() toggle MDCR_EL2.HPME rather than
> PMCR_EL0.E while a partitioned guest's PMU state is loaded on the CPU
> (leaving guest counters 0..HPMN-1 and PMCCNTR_EL0 under guest PMCR_EL0.E
> control), guarding local_daif_save() with !in_nmi() for GICv3 pseudo-NMI
> interrupt handlers.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D24

