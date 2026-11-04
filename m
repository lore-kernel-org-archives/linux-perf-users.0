Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810976;
	b=MRw9asT1QweI4QWVSNgQ/oDxo6s5LO6AMaJSipi+lFZe3k4QuohVBNztlkiNhEqmSHJ5
	 sWQeuu5bfy62xvHufGF4CYKpHRPuBNXheN6fvhIjhY7WEaXE7oiGJSy8KoBlUcfoT8n70
	 uW5hJxuf4fPjgqmpZLic2uFkUReld7uaqG8moGCrM5R+vSLxahL/fLP0QzgZNvf7g3O1Y
	 3t+RvXPxlD4Wz6k+GUqXFRVe1o072//hXypZZikbzGNTqSgOhfKatw+3MlboFQ/Q/6i7I
	 P2CMae4LEC3+UW90vsg/ptS6J9Nx7sFU4AKLpSnR+GO1Jz84jGXc8t5GUjIu4YXEjLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810976;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y0NHsGT/zCMwzb440GgBZDC8HwaRuBOHz9SHXIwTJkY=;
	b=eVFA3QXNZ/YJPlb7swN/gwWzeeBSY5aK2G9KqXO3CTzdh3+Y7X8F6zF3NrI9kbhHkQOj
	 hBTNBMkRMOC5T28cTCj2wFYwGZSx/kkjPqHd31+91S3LRkdKnijjby9pWtOKxKG+P7dsB
	 j4P+DH2MfYXT8nLKWbwLCkQrD6EKxgcE+nGPcy7uQ3TKbMx27ELoBwEwUhZ/M/VgYOAeB
	 VRv21SBPEPta/4y2lCLx5NIA0olWHvaqSvIc6E/KNNC+yqbJNuqy/FA0uteHCpA/t48Ns
	 t7ZOu12D0TaIgkDXtlPgDHJpsWmoDnvGoyKNwgc09YLEtfxCARNJZ5V/YMvEk2dIc1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GroVQlA7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768B6082BE8
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GroVQlA7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08081F00919;
	Wed,  4 Nov 2026 16:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810975;
	bh=y0NHsGT/zCMwzb440GgBZDC8HwaRuBOHz9SHXIwTJkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GroVQlA76LgOGQzVenz/5QXdXHryasfLNCHuFkME5MmixHeqwl2BMHvLmaXLaLBQC
	 IEkOpA2eyrC/unTYmxvds0fL3NbB+InH1z/0f27mqi8LOY8hEgHoFJ5Lw39Mr/owR9
	 J5qJZ1c6wseXDHZGZaP1tVs7uPTBrQ95OPwTEaMaaS32BNzB/h3SSqmKERqy0qJR24
	 bOtBwZuHKf8MTcNKkpWbcPWEb5SRCFNWvcJK5skdz67BDoBiuNjijxuoLpFzS+EBKh
	 qfH7/3Xv/ioKFuFu5GdKyuSMMbuLR1L+ET+1JgyD724Xi0QbsVIQGV+EqsXkclHSik
	 Bb9ZbBQvVPO+A==
Message-ID: <sashiko-outbox-197686@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] perf pmus: Treat both numbers of NVIDIA PCIe PMU
 names as suffix
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104160716.2910873-8-bwicaksono@nvidia.com>
References: <20261104160716.2910873-1-bwicaksono@nvidia.com>
 <20261104160716.2910873-8-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:49:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The NVIDIA PCIe and PCIe target PMUs are named <name>_<socket>_rc_<rc>,
> like nvidia_pcie_pmu_1_rc_3. pmu_name_len_no_suffix() only strips the
> last number, so perf treats the PMUs of each socket as a different PMU.
> An event or metric on all PCIe PMUs then gives one result per socket,
> each labelled with the first RC of its socket.
>=20
> Make pmu_name_len_no_suffix() strip both numbers of these names, so the
> instances on all sockets are merged as one PMU, nvidia_pcie_pmu or
> nvidia_pcie_tgt_pmu. Also accept that name on the command line, as perf
> list shows it, and sort these PMUs by socket and then by RC.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104160716.2910=
873-1-bwicaksono@nvidia.com?part=3D7

