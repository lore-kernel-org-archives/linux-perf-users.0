Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115690;
	b=2TlvpjzYrrmIpvG9O6Vnox1L/6k8vaccE1HoI2xLIv/i1ZZi4KTYD754GQerVVNpshfa
	 yGj8MGEiJkWVjvxkWXU932lWaRVykn8WYrp8rDkQlOdusKiEebirw7X8VlS8E++qAjTw6
	 Sh8n9aSB+Ix2DAlDRBH89FW/M2BNcNDZtejEJ9Bmgus0mDm5BhfWwbrF22MeGwl0/xHnp
	 sjlGohMx148nbNzCYgUs0T0kXvs3Hg0klXI0C+57n/X2MoMPglG4WgbrIJS+A0RGfHDLo
	 gUps3AD2EIbXqUqx3rHp/nh0vcHgZi7HHQ6sIrLv8bOXljJS1VXpTtDRacECRFfBDlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115690;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OSitPZZ+peUrUdAOv/gWaACZoMea9gJRNSlk6wPXdSs=;
	b=izzBAux5WYh3iO0YjbBZLqX2gx9j72I64fesfFf6gU2swcz0xa8vXFw4R8OiFKcKVr/t
	 oadCi29VUG082k8AFtL4sVZcCldJkpKTmtIDnGQBbmOWWED3qubCW/bGfvmhD8AOa6t3M
	 2qsHWuYbLKBTtrbZ0G55MJKhVacCtbNWoeNMEt5uLTu8FMH5ZZdr05uer8juUEFGrfnFh
	 NgkggAb8IYjfe0putaBoRt9mZ5wYUmAYtZoKakFIHdxc3zwWk+DCGg2YW9qfXA8iqV8Zj
	 KaJ6g6qZTc8wGkobB9j6G0vYhS3xpdY5n+Su2n1j1ahkE+eqleFtMtSIUMf1q21h3cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNd7IORt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FA606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNd7IORt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12C61F000C4;
	Thu, 19 Nov 2026 19:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115689;
	bh=OSitPZZ+peUrUdAOv/gWaACZoMea9gJRNSlk6wPXdSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LNd7IORtArSK4GIC4bhiUT7VwDcQRBP5OU4GuNSaEXNvunUqg9zoouOi7HLsQpQqx
	 Jyy5MLVVkPbycw1g1iKbM5y5keZWQQ5wAW/dIYknItPqGkauogwj/C+GH92Iu/P/z5
	 lb3bJZZlyW6YbuuG52oBXcINn0hbw9th2Axb+ivOHyL2qHwvNcjBvcMuDp4Qyx6bx8
	 DmzDupQAXy5AycgyuoLuLCrG8tj7UoKinQXMpfbL+UaE6I091K2tw/ZqoREpyXrB5L
	 aAMmsQaStg5mh74TqS1dNK6gDsOSwMF9ZCUhZyAzk7Di/ZGGlKCvG6LooOTWibapWU
	 UdrsJGGa7G8HQ==
Message-ID: <sashiko-outbox-223850@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 18/33] KVM: arm64: Enforce PMU event filter at
 vcpu_load()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-19-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-19-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:14:49 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The KVM PMU event filter uAPI requires disallowed events not to count.
> Because userspace can install or update the event filter independently
> of guest register writes, re-apply the filter on every vCPU load as well
> as on trapped PMEVTYPER<n>_EL0 and PMCCFILTR_EL0 writes, excluding all
> exception levels in hardware whenever the selected event is blocked.
>=20
> When running in a nested hypervisor context (is_hyp_ctxt(vcpu)), L1
> vEL2 executes at physical NS-EL1: remap guest ARMV8_PMU_INCLUDE_EL2 onto
> physical EL1 (clearing ARMV8_PMU_EXCLUDE_NS_EL1 so P =3D=3D NSK) and honor
> guest MDCR_EL2.HPMD for event counters 0..HPMN-1 and MDCR_EL2.HCCD for
> PMCCNTR_EL0.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D18

