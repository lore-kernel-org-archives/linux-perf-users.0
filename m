Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115612;
	b=wXZVtLGB6xQfGf7r0TGPxlZTMdZOPfD5tfBV5cAVeHGXMLGP3L6jZPRTb6dU42VhCo4r
	 ttI9SXUCw9IJS1B59IwBa6YNyEw5255gIJd5B+FWIoKHAwSBkd2ukfqb9LJRffaoK+J/Z
	 qvogxUCKtqNokYmDrzJ7dpDaPZqTlgON5nnobrUUY+B7g53y22Ahytj+jY2r99oXlU7oy
	 gA6WqC9kYoiYEjrraL05HgeV9dutxMjGdtpL/YRPch4jqdIphtjKoNQsAwBRwZJew3yJ4
	 NaPStM4d9jq71hl6V7bX6AKLbKz76REY4xyTMVHz6lAt/s3z+N6KrvBoGLzNbG7cSGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115612;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k1FUzxQx8fCh49gBJzvcbuvdIbchvRMD+OmoSNUezxU=;
	b=ZAVq1Ftrz53WU+p0BKCDjnxbTogbCAbuDsAw6eK2FTEp6W3l5Lr2yBnLk+ysn0xS6YyM
	 JsGazJUhJA4nbSEkzXFadRPem5tTWXQcxpG/BpgFxV5NvoM3DiXfAsjPYOgM2zqWfccdr
	 lNKCtzi9bbu8vN7esMCIY2/+fj1T8fP0fOcTzXXrcL+4idANavcI0OIHYL8Rws1wU5RIj
	 1D3+0gy3GhPMCtUXUdTkg5MHVEEHuKUnHFD8LtwKQgbUHDexCdwAfxlaSLUVTohpGFaxQ
	 0EwLk130By+61uKHc9alZwo/bzkv4aWyphGkGSy851EvPPWgfXR6zs6/hkDJWH71P+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTZVBTLe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FA1606A32C
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTZVBTLe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FECF1F000C5;
	Thu, 19 Nov 2026 19:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115612;
	bh=k1FUzxQx8fCh49gBJzvcbuvdIbchvRMD+OmoSNUezxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTZVBTLeS1kBe6SyvY2VAZu2BLFBO3rqcC93gZ4aQPShtic+ZOWcBVrgdpwk5cleX
	 qkJYSVDvBN18eIfsbEu5OyBAT2w2UQ5Zv7fa7FMzuO+2cTZzjQkubv3McNT9Yc24Dd
	 KbBE+D7BWMJ4dXzBgtcQXWNgUtLWln+GGemOme70CLr+W9y9qnKu1oCwyw//AlO7ZN
	 bdL/LywqDNkVRgV+MyLNdeHOTWwJqA1GWMomNGuwRpdM08APgk0YsPhDEODsV63zwZ
	 S7K8n86rOC/hIr+KfAsLJkG58LM57vxfaPJR+EByY6cm2XfwE3ZKyasPYTrxPKIQMc
	 4Av8Es3xvmCzg==
Message-ID: <sashiko-outbox-223845@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 12/33] KVM: arm64: Set up FGT for Partitioned PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-13-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-13-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:13:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In order to gain the best performance benefit from partitioning the
> PMU, utilize fine grain traps (FEAT_FGT and FEAT_FGT2) to avoid
> trapping common PMU register accesses by the guest to remove that
> overhead.
>=20
> Untrapped:
> - PMCR_EL0
> - PMUSERENR_EL0 (outside nested hypervisor context)
> - PMSELR_EL0
> - PMCCNTR_EL0
> - PMCNTEN_EL0
> - PMINTEN_EL1
> - PMEVCNTRn_EL0
>=20
> These are safe to untrap because writing MDCR_EL2.HPMN as this series
> [ ... ]
> disables EL0 PMU access, and trap PMUSERENR_EL0 reads via HDFGRTR_EL2
> when guest MDCR_EL2.TPM is set so MRS PMUSERENR_EL0 from VHE host EL0 is
> forwarded to L1.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D12

