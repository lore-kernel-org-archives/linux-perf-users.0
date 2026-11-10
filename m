Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275227;
	b=my6OLlu2P2dfsEHjCHaPTwOAhpPWuwybpLgRW3jBfjNBtxqFL2CAQHGfWApqVyCsg9QG
	 D+PdrOwAlWWIExSHTxdxY8WoBAhOgYhbRLfbRHSkDAVAHWudn0bNbO1JwrlOGiNdn1eGF
	 FzpiVvnLhsNvyU/DOAYwkNrexs11+Q4CoTWF/oPM3A/pq4pvpCcJQM7+Sa/qgVOgqFwys
	 QFjbZWlLJvb30ymAevTArXClDBqByMTEBdrAV03fJgtv19L9aCYC/uE4NtYDrABlmahBj
	 XA5NiehKC6T02kHTp+CvbvZYkFURz59vKLFOQZQ/sz+i8sWzXCaIYtgkdfy2U7A14yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275227;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IXihFVVWST77CcZZqxXA/oIi/9tlz1u0d3Gcwu5YQYM=;
	b=Zu6kl4ARdjIZxZqDMUZf1gVjgq99abuhDKZeL5TsxQZbNdaYGvbFp+6N4hooXBjwqxaZ
	 mJGe3G+4KertMgxP2kvOClm6kTiQmLqIHGSlDHojNoZFNiTuGNqvnejCs9BkbriZS6bX1
	 jReJ4fVRoz52e59Q/ExBlwyAPKaLkiPTd9Qr1SUPCLpSz0uAolj+AgzgrVXcps72w0335
	 9EHpbf90hHqiySwWahMyMNlDIRdTpY7SxtiY+aQpRbud/pHdPcwIpSsRlczR3vN4cMAMm
	 A4QlBU5elQGbxEYZI1lRAueMuqQmOzM8UcVn6M2vdfV6Ro9yvJ7gFa++BTATxRs0s9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ApPTLTAm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6474E60A2613
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ApPTLTAm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73231F008A6;
	Tue, 10 Nov 2026 01:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794275226;
	bh=IXihFVVWST77CcZZqxXA/oIi/9tlz1u0d3Gcwu5YQYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ApPTLTAmcTbWab72TGEdxpN/IB9lmdbOhKCkhLWTi5YGNFKYv6Ciwyl0iaIxkRRMc
	 TGvopNUXmg9Ygc8KNHXQ4mgE2f9eSliWbQDwRDTmjVUeI/GY3EbHughGwsE7/dFnz4
	 qudXzbzlLwRjXBGR4EdnirBTdD66Mtg1cPecQ9azlY9v+6zuZSFap1fQjAc4RWZ6BU
	 NvzazsQrZ8Iop24DMQlRkFheKxdBmWZ9OVrGIuQ9+0XbhFZbNTYZjoHF/7bVNHg/VJ
	 eDfvZIgEOwJse2d9crCJHssrGB2a3RlCEOydQFN5axKri+Bh5guZlYgisEWS1LXvGF
	 NyBLJiY5HLqxQ==
Message-ID: <sashiko-outbox-205987@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] riscv: stacktrace: introduce stack-bound
 tracking helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110013750.36800-8-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-1-xueshuai@linux.alibaba.com>
 <20261110013750.36800-8-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:47:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Wang Han <wanghan@linux.alibaba.com>
>=20
> A reliable unwinder needs to validate that every frame record it reads
> is fully contained in a known kernel stack, and it needs to refuse to
> walk back into a stack it has already left. Add the building blocks
> for that:
>=20
>   * struct stack_info / struct unwind_state in a new
>     asm/stacktrace/common.h, modelled on the arm64 reference
>     implementation.
>   * stackinfo_get_irq() / stackinfo_get_task() / stackinfo_get_overflow()
>     plus the corresponding on_*_stack() predicates in asm/stacktrace.h,
>     so callers can ask "is this object on stack X?" by stack kind
>     rather than open-coded address arithmetic.
>   * unwind_init_common(), unwind_find_stack() and
>     unwind_consume_stack() helpers that enforce the
>     forward-progress-only invariant required for reliability.
>=20
> No existing user is wired up to these helpers in this commit; the
> unwinder switch comes in a follow-up. The header changes leave
> on_thread_stack() with the same semantics as before, just expressed in
> terms of the new helpers.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Martin Kaiser <martin@kaiser.cx>
> Tested-by: Martin Kaiser <martin@kaiser.cx>
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110013750.3680=
0-1-xueshuai@linux.alibaba.com?part=3D7

