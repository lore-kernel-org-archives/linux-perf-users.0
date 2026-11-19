Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116031;
	b=5RbTMk/yHc0RNfQpI+eupdWVTwZs5pdv7y+97nDAhAFy8L3SE7MAd+Raji2LAaPbF9fc
	 YGXew0kjRIBiRGCcIv6FzUQ/ANgAs7A5njRXQq1X/81d5BCNFU+QQJ4LYqs5Y54T27VK4
	 Re9AreFHUxEvF8hb92VbntKPsKOV0yAZslcNseH05VNuQE16XxCzjgMKOjbvFdiITyi8+
	 7JyXHf5X/EGf1To/Kg4vbcEZd+FF3x3vfHk6Yx5ZCxroRbJB4pIvEOrwuvt/i081MRyf8
	 OfaUZUiyg7KKcaMudXD7PVJh2GVmdq+8tyqCjyxIRmnMHNTQcxgj1ryiyhKjaylwBcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116031;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=foL5VVINGoDH8RgFZjqi2MTbR23q811vLACKLlS/tvY=;
	b=fmyhR6pF0RLso6JhiTyv8gkIWrwTpXPBAjLtFNA+BkU9DOwFLQ7q4Z0bV3aVUHoMR957
	 xCR3C1SxFnyprqsrwCE6pj3xqq8OVj8/WsKFKh44rkkRK/T8sP0rQevMBrmq7ojotcGU2
	 k5Qe2rdDG4XKzbuH4u1Pe+ib5RHTqsmYbMqGXEBlVmexu2873Wd8hB9lEkFDwyaJYIpJa
	 Wmfldm7amuq3MygFgdArkbZooZdfW/iiV3qULm/k+lGZ50KPepWDPkL+l+3l6OvOPpLPK
	 FH5z/9kTcTurdeGO9UBUJRuGHU0lENJaxYzsfq+hmM9RTwRcF9EThpl5zvfNXiS+b3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mny5l1X9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA3606A32C
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mny5l1X9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054E51F000C7;
	Thu, 19 Nov 2026 19:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116031;
	bh=foL5VVINGoDH8RgFZjqi2MTbR23q811vLACKLlS/tvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mny5l1X9tT9m5QVdrKRjcXTMmq15xbVhf0rYCTOeJ2VIommHHLCXELjPiPGR7OJiE
	 SL0KWv6az1ZAYiIZetPhimfb4J980VIAfrmIwCSb0Cc1VwiBKM+l4rcyHMNRN40QTE
	 sVcs969pFhDmK22/b8nIXaJfjEH/71d7PaK5OoxbqLZ+XpQtcyeIbA9kZ92hC8fUzN
	 LDSG03+q+L1xR/YNVs7yHWTeF3lO+kMxemj2cwMv7T5NOEXjFGh+paSXX2j7Zy/GC9
	 jXmJQdTxJw3sJfQAXUPlgV+y/ktkaMIzxoWHVz5ba+NMneYh7tlivApy6S+4DcTiZt
	 C2lsPYvih6TCw==
Message-ID: <sashiko-outbox-223863@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 30/33] KVM: arm64: Support zero event counters on
 Partitioned PMU without HPMN0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-31-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-31-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:20:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Programming MDCR_EL2.HPMN to 0 is CONSTRAINED UNPREDICTABLE on CPUs that
> do not implement FEAT_HPMN0, preventing userspace from configuring a
> cycle-counter-only Partitioned PMU guest (nr_pmu_counters =3D=3D 0) on th=
ose
> platforms if HPMN is set directly from nr_pmu_counters.
>=20
> Support nr_pmu_counters =3D=3D 0 without FEAT_HPMN0 whenever the PMU has =
at
> least two general-purpose counters by setting physical MDCR_EL2.HPMN =3D 1
> (via kvm_arm_pmu_part_hpmn()), reserving and quiescing physical counter 0
> alongside PMCCNTR_EL0 on vCPU load so host perf uses counters 1..N-1,
> keeping MDCR_EL2.TPMCR set so trapped PMCR_EL0 reads report N =3D=3D 0, a=
nd
> enabling fine-grained traps on PMEVCNTRn_EL0, PMCNTEN, PMINTEN, and
> PMSWINC_EL0 so counter 0 remains completely hidden from the guest while
> PMCCNTR_EL0 accesses stay untrapped on FEAT_FGT hosts.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D30

