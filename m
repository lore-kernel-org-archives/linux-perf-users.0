Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831134;
	b=0Y39JNb89lZdrzZPrDBnAToCwuoyQIDXTrQZtdIaGr+TEmjUuDbKTA7D6xVUEVL1FtGU
	 1OpJw3XmJ9xzrujrhzL0qggJGEZnP6/tMP2wGM5QFajvmJPhjVLh7PTSNicqHqYk4C2Xw
	 4gTx7uN2rq0tm/1aRFP++qu+oUAqTBMQX978Ac0d8j62UtsfEs5Bu93A/UR1sXbJAOt/J
	 RZE5R2psM9qVAHYbWC40wwVa8bF0h+xfXfIL1QwWtySs4P2pZVlDIe6mVgVCAkwSOZhH+
	 KxrcY9HCnQniFHDX+4hoo33Mj+cspHvbCV5OBYU2N76Rv7Q/SDb+tlWnDpC57tAAh2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831134;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u5U1Hx7OrRdS/ClSeZ3CvlATNB/smujSv3WnODh3vbM=;
	b=q3yp0EqRlPsptQu1OdGp63WqUohOU6z09Ps7KwGPSzZRZqnJ/O3SKC1MdIzGE995vFkl
	 vhQYT4Q13v7oLzbPxdA0I23NOlzF92GqRKE/bVoLi2cJC5d5d0HArveNE/a2XD0QJFyPv
	 iw9gJaqoRahP+OWSvNpQ//83oV/6Q8NaYDa0622RtNiGS1W6qxDRI41AHg/aKLWCEJBTY
	 u+EszzgxdhGG6HjJ8ommNIgz4XO3fVaz4LNVSGbyvHkC463RcrO1E/3CpdbfUbVFTDJhf
	 3Wa45LY8i7AHIUGnyp5lESebLKItOTE6DH2FAtTJXxfPWyZzrpve2SIhLWjDMoKvwwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlIeX9cw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F521606A323
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlIeX9cw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF85A1F000C4;
	Mon, 16 Nov 2026 12:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794831134;
	bh=u5U1Hx7OrRdS/ClSeZ3CvlATNB/smujSv3WnODh3vbM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IlIeX9cwyZwhqBmpEKhWHj5xnc6P/gfKIieXJNoM+sSriicEhlIZNBMMiqD+tS2jh
	 umXnu/pzlKSCGTX8+TRR6Re5A7EhO+m4LcUd846F/3OdLiWatv9D+F72vRrZ2Jjxpp
	 6sAhVFBsy3UHcxXjLbkfXDeUFUHQlZJ36mJ2jUK+T2H9hmvNLAYl9gp4c65FN0voLr
	 aBizV9KGD+M4e3BD4nSCZelw8DQwAq0ZSVAFIiEXBU+bK72cnhuJmFB2JPNnw5l/a6
	 lzHSClWBYA1HnqYJ/U0dTd/wSCTI1LZoU44pTovSTK5MrdQ0oCmT01sSgQFnf+FDrH
	 RFleN+e5o017Q==
Message-ID: <sashiko-outbox-216991@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] x86/events/amd/iommu: Use a per-IOMMU cpumask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vasant Hegde" <vasant.hegde@amd.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261116115350.13740-1-vasant.hegde@amd.com>
References: <20261116115350.13740-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 12:12:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> IOMMU performance counters are accessed via MMIO. The AMD IOMMU PMUs
> share one global cpumask, fixed to CPU0, so every IOMMU's events are
> read through the same CPU. That prevents collecting per-NUMA-node
> numbers (for example perf stat --per-socket). The mask is also never
> updated, so counting stops if that CPU goes offline.
>=20
> Give each IOMMU PMU its own cpumask. The CPU is chosen from the online
> CPUs of the NUMA node of the IOMMU's PCI device, via
> amd_iommu_idx_to_dev(). If the node is unknown or has no online CPU,
> any online CPU is used. If no online CPU exists at all, that PMU is
> not registered.
>=20
> A CPU hotplug callback moves the reader when that CPU goes offline,
> preferring another online CPU on the same node. If the reader had to
> leave the node, it moves back when a CPU on that node comes online.
> Events are pinned to the current reader so they share one context and
> migrate together.
>=20
> Assisted-by: Cursor
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116115350.1374=
0-1-vasant.hegde@amd.com?part=3D1

