Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902966;
	b=mZUcYXCQocmaCnHwO8/c60B6XYT02uwc5+e+hQpzr46YrOwH3byCHUp2NqMhUbqoNTae
	 ovaq9WzBH07quZ8JB7x5dNSzOArNaELXOQafKCUUptqIQKpha+ESV3bubzw7wrNif3z/I
	 JL1PtorIjjN3N21a4lWT9XKfrgSzXzNcitWm1CeNfTukSCTZmJyOXsY19fgJoZOz3od3f
	 j5e2Iv3adXyNd9vWpyO2tUzNi9RQikwkFKXWFcuvmJs1gnNhbihkPpti2f2agG3rqEUZg
	 lcpZW0gAB3Fzt7VkTPgNM5XEVI1YtQNJiEyQLqRj5EV1rc5DmZXv4W+rj2QpLQ9diJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902966;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=87BUSv4jLi0EAi2v0ImMCVT8LVLPI1omcIWBBpFwNWo=;
	b=rWKdA+i+hZGllQrmeKmwRcp2KgaLg7stFOR7BZ213j+IRdvi29QcwV/bvAZlYEpfBNq5
	 v6lloerIkIXsZPrP3o20ZRqxv8exCSqXFTqIpGHbbMyQYqAsIhx7xwbTT9YNQ0rqKpVCq
	 XAAYud1gBgt4bW6vj81a8uVB8Tr5wYxyRbJAa+HkoeGpPXLj/es8A1n4K39Hr7EN1eblI
	 2QzZeyBlWavot7VHc+HeMxuS6VHqftpibaArelca/mdiaN2JpitRB+TGpPArL54qvWN/J
	 jHqV+OW+R24FGRqNpEO4qC9x7tAvp1hJet5iLldBe6c/hDH0zjXdm4bvmUmPcY3plqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VMA+/qsH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78452606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMA+/qsH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5481F000C1;
	Thu,  5 Nov 2026 18:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793902966;
	bh=87BUSv4jLi0EAi2v0ImMCVT8LVLPI1omcIWBBpFwNWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VMA+/qsHfPxG67rkpqWotcNwxLm/5a3GfAOtEhvpVONSAYenDapCAedn2jikt1x+y
	 JvfHwrL/dWJJvEwK5/CBnGJswMlHrA8PQy4FT9ta3SMSgX3whdhujuOQX3NFHDTLKR
	 OhX2+gluiT1SB5odVRcA9PMVQuTKYaVDylWWQT2K56FCvfJuZpDCHy7Jsvj9BR/j06
	 JzmTRZORjWEp/cQXYXLaF9EWd/s+oeRdjC7wMOK0pwwMml1XjoQskSDCguHJq1tf7i
	 9eaE7SGKmLirVpWaePVevqvcENZpjf/IxJbQTxOXPAW20vJCBx2i3fNPrlbcp0CKXL
	 sgxOdqzlqmDZw==
Message-ID: <sashiko-outbox-199754@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/47] perf/x86: Move CPUHP_AP_PERF_X86_STARTING post
 stop_machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105163045.38862-15-frederic@kernel.org>
References: <20261105163045.38862-1-frederic@kernel.org>
 <20261105163045.38862-15-frederic@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:22:45 +0000
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
> Here only intel has a dying callback (intel_pmu_cpu_dying()) which does:
>=20
> * Deallocate the per CPU DS structure on the MSR_IA32_DS_AREA. This is
>   already racy against offlining CPUs because all possible CPUs's MSR
>   are written on a hardware event initialization, which still can happen
>   before the CPU actually goes off.
>=20
> * Deallocate PEBS buffer. This is already well synchronized against
>   hotplug up callback.
>=20
> Therefore the related teardwown callback can run concurrently with other
> CPUs.
>=20
> Move it to post stop_machine() accordingly.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105163045.3886=
2-1-frederic@kernel.org?part=3D14

