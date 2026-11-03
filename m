Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672008;
	b=WlMlG4Jp7r5NRA4ih1/Jrpi0DrikiYYB2bBmRa6Mi0W0smu/Yb8QJcCv2miRj+d3bKeO
	 pLdR5l0zTwrmH5tq5xxqUL1VEuUqf7WGHQLCO4Or+izVYHo6Csbg/voDDANBwvGXyk9eL
	 W6dTfJciWqxyzoza5fNHezU/fRV34UsJi5QUGww61xCVeFYaY6BE2z6i6I8ocoJ5PRFxr
	 QL3WlUenvG2aF/G9cWxGsKJnULUSznynrOUwX3QEEAPaII2DNtuAezRc1LFJQV3a0Jk0S
	 8otD6d78YS2EceCG9ihseYj4VKN5q7qvwoZc/4Qk6lDxy7du1pyERmpxJG9HElXh89w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672008;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6/MQHqvXudx9tgGVHveXhOKIr04v/NJ1SFycimhGNik=;
	b=OmJBGdNcR2HIknDoN+PPq3VfL4oowMtTggUCn4pQlZRPyi2APLTZUkbzDZZkjLszVBgg
	 HnZYZXAggEjDdP4FP6/oJep+vxuhiliIDxuLFDNFDE3lsrQQpC1GyH9xIsqpiu/d94YEO
	 elpqOyZKVzRWrRwmM94XTa27I4FDCsfEXfzXn5rwIrfmoGj/tW3Yrm1Kl9Edp5IZb0gA1
	 8LNz0kHSGeKuNN+TbIPXYIrWHtow58eKxpUcc0jm+W7UVRDc0yXA0jf5yEGbyangr7BkA
	 AWpyxlzfgfbrh9mSBBCcQvnv8aIG3c6hcP65d+ZLGrCqHOm/DMi/IIYeZPNFJolLs/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRCmzZ3m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1D2606A330
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRCmzZ3m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6311F00919;
	Tue,  3 Nov 2026 02:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793672007;
	bh=6/MQHqvXudx9tgGVHveXhOKIr04v/NJ1SFycimhGNik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BRCmzZ3mxF2YxgIl1qT+Uqop0LOfjN6wGAWpOiBWHaa5NlyQk32JwIM6EfCc+aoBa
	 BPxN/Uaruw19cSRex0ltL+rI5GrbKDULQ1nCsK2C4KYjt6UX5ULo2smjl3hwymALj+
	 yOpNWSgX0Tbb5OCksUX+59i56WePRSvFPvuxOyCiwvuJHGFcYlrO43CI3uAbaFX3sk
	 C3b/sAU4KtCHuFgAV8xWBNognKNhegWF4aba6ECbburbLhpE2oIUGPPdNpmOXaLJRN
	 l26xwpJ9UKQvmBlmJkU1+PFKgFIr+aG2xNeUc28m+nS7l72C66Se/td+CMcHKQB9FI
	 SHHQBytpsPtvw==
Message-ID: <sashiko-outbox-194455@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] Documentation: describe building tools with the
 kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102021253.2545235-8-sashal@kernel.org>
References: <20261102021253.2545235-1-sashal@kernel.org>
 <20261102021253.2545235-8-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 02:13:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Mention CONFIG_TOOLS_BUILD and "make tools_build" in the submit
> checklist, ask for libc-only selftests to be added to tools/Kconfig,
> and note that USERCFLAGS and USERLDFLAGS also apply to the tools.
>=20
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102021253.2545=
235-1-sashal@kernel.org?part=3D7

