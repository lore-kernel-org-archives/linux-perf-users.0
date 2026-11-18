Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973711;
	b=JjO0U+PLgHm487DuPuWpmvOEBGt3KgqVPZahbl+v0fZfWwZdgIOqlW4HAljUhiupkD5s
	 kQpMG1lJYqq75QLuFTMsa2BdMRtqhmN7EC0AtoOWWW1HsZxcmtSHI+FwVDh0onxNr5FSk
	 8iTEhb6qr6UbfDEpmoGJoSsvxP81lRQtYsoPKHAbkSu0EdIgZf6kaRMDrupORpnWUzDWI
	 sxT2dKU4F0Vf4gCGj4rhAOqyjGMSuGwed2ZSAB34QZMHY8GhpJXwARCjKrMFpb7gHNfAM
	 y05ZLfcXm5COWJBwayASI96YeY8IyQp2mrCavUezrJNi/XGlis4mrK3BodZ7HIqm7KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973711;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h/xqPTeZCu8XdNEK/UasjACaolQcA//D8odSPcgzudY=;
	b=iSvZ/pNxSh1bGCa1mR5sktrSQJ52ckeKRmrKlKysPryloWSBqC2kli5NxdLLZ+rZvpy5
	 fCTB0ifj7zqG1ys2r0dv2XPErRxP03WuuQDIQGBSYOtQU9VgdnBco3Cel7OTZsMSv6jML
	 /hTNNKh+Rs7xKL1yKdGmhO4d2TbsJH8bXek+1mq7gNXSIqbXXYWDlhjh3M1m7d5iK5DHk
	 q/mb2ojnkR8PJm0fOUMbKozyaWQE7N1FpXXM9dcI58Ya7xkcfvu1Xtd1UGDHvq+DC1wKi
	 iyDbYlH3BYIS8pCVkJWT8j/5XpuQ7cSHajLVbBQdR+XkWglpJo6uaS7vmovU12u+c+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUHDe5MX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C31606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUHDe5MX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E481F000C6;
	Wed, 18 Nov 2026 03:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973711;
	bh=h/xqPTeZCu8XdNEK/UasjACaolQcA//D8odSPcgzudY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DUHDe5MXIKhMzY/GwDKoQVt6X68M6NukwlHtKSFxmBvyhbnUaPKbnUPVD1bciqJVa
	 32KngNHoUI1Ps3midd2fliiP1neBZucyuJBBZRvu6EiJlcwlapuD3C28uQXxU4MikR
	 mJtr5RRQ94VcQ+JJk9o4pmrW7wguLRvkF5LWtQL3UfeOzlYgvnG6kdKMv1+zWsEhB8
	 eMaXM952goPstFe4GVA15k6iEMBQ+F43gDP507GXpCSEt7bh1Miw7Hm0F8AoUhFvkk
	 /XPk69inF7DK5JN3GOwdwJp0zxyg9osDOl76/F1Ka/rhEAqWt7vcGxdFKRNdmkCvF6
	 gyjJrLTQVUGXA==
Message-ID: <sashiko-outbox-220047@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 02/24] perf/x86/intel: Validate LBR XSAVE state
 before updating LBR stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-3-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:48:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> intel_pmu_arch_lbr_read_xsave() did not verify whether LBR data was
> actually present in the XSAVE area. When the LBR state was in the INIT
> state, the hardware might not have written valid data to the XSAVE
> buffer, allowing stale or incomplete data to be cached.
>=20
> Add an explicit presence check for the LBR XSAVE state before updating
> the cached LBR stack. Also clear the cached LBR stack in
> intel_pmu_lbr_reset() to prevent stale entries from being reused across
> context switches and similar transitions.
>=20
> Fixes: c085fb877467 ("perf/x86/intel/lbr: Support XSAVES for arch LBR rea=
d")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D2

