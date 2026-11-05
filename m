Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904179;
	b=pI4Fn9FQYZ+E7iD/O++3NWdZptUkb9aP56/PWk0LUscp2kUpplgxIyy5D7xH00CO3KM/
	 dY3GWDfDmxnBeR0r1M5X2G4WuPTUMk26LHM12lNsjCqR1D/5KSBvVhJB2C98tb726fpmh
	 mMVVHGfl5c7oHvXPp7Hdt3GXW8EtaHuzItFBxMT/lCPuzlc9xjnNABmRAugDXXHritxL7
	 IumT6xKJmDgq2u6KVfCyUKESZe1H3JsT53bJ/ElBthlw7BcgyZ7qbC9ldXyE3yz+dVBc0
	 01iD5J5y6Yf5gy+ZJViOIg6n1kFMrHnDAr34nIYalba0/32/eHAuHC/501AO0iAIPOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904179;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VsZlGBDeqkbPyVFKgFXWPn+ZnfPjXh1925IHxdPNdd0=;
	b=IUViPXHBJnqJ4zhCz6UMr2SR1vgJwZb8Sf7ZqAF05RFLhiiA8ocw6+W9MLS87fqw1gDV
	 clKNTYZI1TmA9YBpwWN2Pz+i4ADcfwZ1GV5fWD2t3yfO8rFMSoLsgOtuQataR0MTfJYx3
	 dIdejylIAW7m2wXASIBcMl5WG6WsKguyjwxmm5lu7ypZ7eiNcT/sMNSvqcv5QuyyS4Ja3
	 /up8+ccLdLySf9MiaHNUkSobe2WMGvoEamkbOFOvwxsuQX5hE2Drx3Fgc2YTblKnqJ0iu
	 2GiKGeQiChfNtP9ylOGGjAPtLdRROUghovKmnTWlkXzA1ovyXzisssZTtSYYoBxyi3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eusje8Jl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E24606A32C
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eusje8Jl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79F91F000C1;
	Thu,  5 Nov 2026 18:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904178;
	bh=VsZlGBDeqkbPyVFKgFXWPn+ZnfPjXh1925IHxdPNdd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eusje8JlmBQzkqWxivPke44zn4uuiwcvsQocjUotN+Q8E2BtKtbcYvmH1nY1xc6Li
	 6MYYgPuciJDktVi4ivPshkeKrOOoVC08z2GPC1lHumc77lZNCbrZeq1hpOR9D1t1Kf
	 ROjvJyzq+nSsX50yWL71G1H122RyPBSAzTXohZJ8v1F2kZg76Ps+jOMAmpeVO7mqzu
	 Yldz/XFXzVHF9ki5nlblTohKCgkonHkpmR4sh1SBLcPpDysZ7aut8q5Xamh1Ekh5EG
	 eeRwCbOetQNqCHHXBI6+Avie3BFKXv91pCdjW6xJstViqrP5JK3/cU/baaTPlJWaHz
	 zphURx6TZB6tA==
Message-ID: <sashiko-outbox-199790@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/47] perf: RISC-V: Move CPUHP_AP_PERF_RISCV_STARTING
 post stop_machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105163045.38862-21-frederic@kernel.org>
References: <20261105163045.38862-1-frederic@kernel.org>
 <20261105163045.38862-21-frederic@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:42:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Between CPUHP_TEARDOWN_CPU and CPUHP_AP_OFFLINE, stop_machine executes
> all the teardown callbacks while stopping all CPUs in the system. This
> doesn't mix-up well with running RT or isolated tasks.
>=20
> In order to transition smoothly from global stop_machine to finer
> grained synchronization between teardown callbacks and the other CPUs,
> a new stop machine post function has been introduced to be executed
> after the main one with IRQs still disabled while other CPUs can exit
> stop_machine().
>=20
> The teardown callback here:
>=20
> * Disables the per-cpu IRQ
> * Disables user-mode access to the CPU counter
> * Disables the shared memory snapshot of the CPU PMU.
>=20
> All these operations are local to the CPU and should be able to execute
> concurrently with other CPUs.
>=20
> Move this teardown callback to post stop_machine() accordingly.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105163045.3886=
2-1-frederic@kernel.org?part=3D20

