Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225138;
	b=4fu0CBubRN/8pUbDWG+SX0azh3eI0+WISFK4Fik55biqMREBkStUjc8dDv5Ab5juG9RZ
	 Jqo9o8QTay2lXh0Kr2nM8mUuW6aR0zzyNazoIycW1uN+ozwcMu65E5vmOt0n39ipOtsHu
	 zSGLyEjbhDJLHKYOMGAOgjQGdWKew16HRW8iZAPiV9F/HU/x44XNk3zcdKN/Bsrimf+rh
	 1f3CVDF5+5u3eJlorzIN7kY++5ULbzGKNI1PPt+q/MRT1yo02CidSrWe+QzGZXPYoZR7D
	 efX4NEWT0+dp4RVrjIdNzLFvC4nDnyis+3LTgxoBXAhhV7KkAH2DdL+oa8/iatrQkoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225138;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I065W3vhE5w9hFq62qh1zHzscyhgRPXJCqMIY91zOww=;
	b=AR06EE0mUBUN1vECPGPRq4d9l2IAw5eo4CiGY8RmdqT0ecadbarxNsaDZPOP6dQx6hTE
	 29b+w543UAvlV0lme0SV5v0wQ/rV3ZO/m+UtXlnNeJIHjBa+hPQh1XCgqf8qjfv3CRMkg
	 vbziTzV6UQPurkkYzqRPVP2Oq2cDJFDDWv0ssjRHRo7S1Ip6q3HgB9B+wuq7GbF782DPV
	 /GFTMEgOSxwYu6+WkcKCIxJW8qvo24vsifEt5pT4/NkPp7DQ70NF7O97b2D/yIpaGL3rY
	 bR7euZMSrNznnztOyVoH7CyKGG0uS+Nx25UBI+Fj9e0Y8yJ1k9EzE/qiy7Ddvndy8WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDL9uRJB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46355606A321
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDL9uRJB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86CF1F0089F;
	Mon,  9 Nov 2026 11:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794225137;
	bh=I065W3vhE5w9hFq62qh1zHzscyhgRPXJCqMIY91zOww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VDL9uRJBRf1oXy+TUQTOJleafZ/lE78IKAaw3WZxoZBA9oWWvxlIhZzJ8rRxSPNIl
	 /4hy6JzEPJ9AMtIyKn9o6nFQWA9MMyaz3aCJj3SA1dCodH22B2M4ZR78LEFZ9N+78c
	 QMRTzuY/hi3g8vqSOQ2Cj50z5Hb2avMl6+yEJnHVEW2qvUXStkA/O2taZ8tdoFM7Fm
	 7gnqqJ6MsgG+v+PdCv1NAP44sJ1rGV/3XRVNWki4borZ6Q9C36eTdP+VqDn89NYcsJ
	 o9ecc2Az1lEqFlTyPW4YxjeForfKu1G48qj4xQHH8rWU/JeeoiSVe1ohfZ9txjKqyD
	 h7d7EsuQtJ7+A==
Message-ID: <sashiko-outbox-204907@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/riscv: Guard PMU counter indices and user
 access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109113909.38153-1-zhaogongyi@bytedance.com>
References: <20261103093709.81605-1-zhaogongyi@bytedance.com>
 <20261109113909.38153-1-zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 11:52:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A disabled event may be mmaped before hw.idx is assigned; a userpage
> update with that invalid index can make pmu_sbi_csr_index() access
> pmu_ctr_list[] out of bounds.
>=20
> Validate indices before publishing or using a CSR, and reject
> out-of-range SBI results before accessing counter state. Keep mmap
> authorization independent of assignment for disabled events.
>=20
> Reject a zero SBI counter count before allocating counter state. A
> zero-length pmu_ctr_list[] would be dereferenced when a non-sampling
> event selects its initial counter width.
>=20
> Fixes: cc4c07c89aad ("drivers: perf: Implement perf event mmap support in=
 the SBI backend")
> Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109113909.3815=
3-1-zhaogongyi@bytedance.com?part=3D1

