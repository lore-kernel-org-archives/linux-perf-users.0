Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020441;
	b=4C/L02xsTLB5kBfxJc02R74xe0zswZqZPldkgCQxV7EeF7oQOvbfafHIiLzvURHPykOe
	 RtyKthgziwhewTwzdx99Q6HtphPciWjTtSfOhgRM8QksIJsTCQUWqOmslL4ufME4c7LFK
	 7j4+EqgiT9ZDIlWy6NEOIcRLNkdDcAKtqlFYE1luQgY8LYCn5IV3U2aeDJ4HOEgR0TPkK
	 kFAjDgzrO4HXjyCjPLpgm9erQzqUTq6+0ZHm7zdmy4pd8HUyKZDJNGrJ1mObCixsxo4vB
	 /Uj5lJB2snnpaK+VgyTjhU02CTsd3//H4raPhHViGzEW3+lLdYvH5q6RruFdYDmNL0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020441;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1nB8UsizeZGlhTDJD0lhCpueEPglBAStMhK6hu8v5rc=;
	b=5bLqf2riupankIg8k3Ri/wIxZGEEV3k96793N5zF3+3KjgGiHzSpLMdk/8RHrkwnStnu
	 TdLM6cyTyBGecQ9TYXrLDjsTq0+8INS24veNvuoil5HORM0Q9mn/MZlAK7UIWuk0/jzop
	 7Y31AaeqCOCqe5WdmLJShKszkY1PrnYRYCPByYJnjBi5hHRInNTZjLoNiO3IC10o+LYpb
	 IH8r1FsxktrZztucfR05jaZWv3Uq5ydF96h/CelgDsaWbuI/gmbY6b7TF06iLcMaxVtRW
	 UoKW9FAP0H5QjOEvwrgPciXR4BtwzyovSW0oCfQGpeHQiAgT+vqDRc09JKPPtxZsxaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PM5eYt07;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF9606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PM5eYt07
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462921F000C9;
	Wed, 18 Nov 2026 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020441;
	bh=1nB8UsizeZGlhTDJD0lhCpueEPglBAStMhK6hu8v5rc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PM5eYt07cCEZu0r4RhAePLOHhqsUTEMIbNYmTq6e9jxRmZ8afQ+MzYYD8lwLiKaJF
	 tAOPdAEVmtxGvm4php8hStueJL6t1GTQXu/AJbPJge6ScDivvZAysNNSYTAQFP5zvk
	 Rqyuvyy9FPH84BPpFloj2hUafWzTdSHat9dR+p2WyCYsuh+3lg/RzEJAz0kORluW1f
	 tY9UhWtHLVajTrr57IinLwIZoyw5s+vMz/+dlMd2coIKHZvQoIhKD7JQJ9hFbCNa+e
	 081oCbqShywTJG73467yhgoKv+8n4/js3wwOJ9GxNNx9Jka+8Pr/uJYaECSC16r0QU
	 yrb39e7ArvQiw==
Message-ID: <sashiko-outbox-221550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/34] perf cs-etm: Share the thread ctxt between
 frontend and backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-24-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-24-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:47:20 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The decoder stops at every context packet and resumes only after the
> frontend has processed it, so now we only need to keep track of a single
> thread context.
>=20
> The thread gets updated when the frontend processes a context packet.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D24

