Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793942238;
	b=2V4LBlxNNVfdeSzDptD1CE9Xu87eX/8CE60L0n0W/49VyNlSbO7PoIPDr0fXbuLZHYLp
	 0Za+wb5Sd80S1fLpY87nO+gDswEx0rqYUyEkSs6sbaTKBKJR2CtjpruW4cizWX9q+BgQo
	 nWsZX/jGBNXHarHy+NLV+CRoolJTeV2jE2s2D57S3gXMx4E3faC+uEAH4sTODGx2psYX4
	 wQnDqQhbGcFjtG/x0+tTiDK7MTL+GA0OEe2jVE6DZoidMGV3eT5QLu/Rbiz45jPG8z7Rx
	 +oeGKRP5RcslN6nYdzq38u5LNn/fHsbl32f9K87hfWY6XFHzcdizhrAwp1B1CqwzCag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793942238;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SXkxFYE8YXpKnm0qfnAixZxelN0vwvcmSwrjAIX4JyU=;
	b=D3hlkr6IiYNSRbNcslaiiN6a31/qWzvWTaBOv2yQqmj9vLRl+KTSv9K8hVRrHoy3lnYK
	 0/DCe1qpP4y2nO+MH8RDsKuBUNEIMe2QlneOnezZtT7u5kE5I2/rSEhE55MfKucSdF+KA
	 +FQJtcsIuH12SIuaRkh0mnsDZ5fm5+tVsQCMYHuLhzYwnt32rN2gtjxXd5xOIBB6L/lPa
	 nu/ArlK2YHE3xXu8n+Ocyb0K0CRpHEsZSm00d7DkhwRY9bjyqgWZfepZTbO7NzMs60EZw
	 tWAr0svkxSCC4/w3iOhpGmhvQxdIWDlxmJdaCBtOLiN/YIXNi7pZzO8E2/SFqSjECKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hL859Q6D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A52606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hL859Q6D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C13A1F0089F;
	Fri,  6 Nov 2026 05:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793942237;
	bh=SXkxFYE8YXpKnm0qfnAixZxelN0vwvcmSwrjAIX4JyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hL859Q6DGUzrQqhe0d94fhz2JHsp1wACFM2bQxHqdbdvfxZzeC1MAc2l8O7y9Hy2t
	 K2h6N+cKh9JDp1GiNGDdllEzCweYwGRj8rBc0VMpf+Kivfn4+OOf8m+OjT7WX7ELAH
	 hB5VgwMCVkGZWjDz+C136i47IrWXD+87gq2enrAzAczoPtycE9rwuQes3bLl5zjTbV
	 qwUOAkjjKTAzVN8RSrQD3Stvd+JbVChUpWXEEN5R1kirVx9st8C92MUd4B9pFOjax+
	 33lfCdCjWf00mVuF74M+uNhV/1S7xINT5eML7uXtcmaZspSFUM0z3K6Cvz51lcsi9X
	 wTAosfsEg7e/Q==
Message-ID: <sashiko-outbox-200808@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 12/20] perf/x86/intel: Use a dedicated LBR stack for
 BPF snapshotting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-13-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-13-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:17:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> BPF LBR snapshotting currently reuses the default LBR stack
> (cpuc->__lbr_stack) when storing sampled data. This is unsafe when the
> BPF helper runs in PMI context via bpf_overflow_handler(): it can
> overwrite the cached LBR state for active PEBS LBR events, causing
> incorrect LBR data to be reported to userspace. When the PEBS and BPF
> stacks have different depths, this can also lead to out-of-bounds reads
> when the LBR stack is later exported.
>=20
> Use a dedicated LBR stack for BPF snapshotting so the BPF path no
> longer clobbers the shared LBR state used by other perf events.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 425507fa5f32 ("perf/x86/intel/lbr: Optimize v4 LBR unfreezing")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D12

