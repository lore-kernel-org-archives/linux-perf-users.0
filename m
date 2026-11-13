Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601136;
	b=O0k2S5EJvdMOOTrWA3kbClcLebZOq9Gp9Cx9GGPZCLD5jXSBLrPO2P45QKleBOLcz7Jl
	 JDM5owl+d59VyDcyK485HO95HGRJs2Wc3SJwnok3U5ocJm0U6ZC9swjIzkE6kr2FMMtm8
	 7QyoIVZyQh2bc4xVPMHc1dgDTxaRq5b4Tj8FggcTu84NsMhglNkcskZZ2bVdJyNsFZx44
	 MSVr5RDEL6EgRCjGBGpcqta/PNJdK/1Fvq2ehtx4AQn8uvVA9506r6Dh5xO645K9P7ybq
	 SA/IpO4mydWv4ywko1sIwcr/ARLjo+UZG3SUrauYarkY7oTszSaYqk8ePSKZ3A6F9sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601136;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u76idVuihWoM+CR6wbi28HEvualfPFIGL0+JjzgEAWs=;
	b=3iSoTYdmJwbSbngoj4dBAu/qiLw+TdCUwJ7j+YnVuyfwYbYEfVJiSv8UnDE59WiZJayN
	 ymqpiF6G9jNN/OsXd7oEwqOWqdef9OUJt+k79LCAoelwjd5v7+kLEQ8PQN8K1X9qL0xbU
	 NFiyUMPGML/8t0hFYCsmbZL15EuBkbN3Q/9V2VJtX3qSOWm5cWSH1wOuXiPq4fbG3RaTA
	 M2qEdNkYLAJvPy1e7uXmmLJ7otT9UKHClcFEzVSC2kQ0FhMaiDN08gyFkavIgIB/lIAyJ
	 r10B6Ud5pQclSCBImC3c85qiK0JOpDHs8v9ZDc5rGLYHDsSZT0GVC9QUo5hA1y6Cwbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNEVlSBO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1639606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNEVlSBO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CDC1F000C4;
	Fri, 13 Nov 2026 20:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601136;
	bh=u76idVuihWoM+CR6wbi28HEvualfPFIGL0+JjzgEAWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KNEVlSBO/YCGg+UCA2q0298nFBHaMv7NgPN4Uogd9jiHsXyTK3oUQyMLf/n0TKQsF
	 xPmUwS5IWn0uGdFG8G+O6PgPFF5UoDRVpcr1zIIJqTvUI1A0Z+3ZcbdYGcI/djUW7a
	 sij3aP6jC7iRMcPUzWk+r8R4vSqo/K9l2d9tHZj0Ia5tyKVGZsCcrBn6Hnsir2uW1A
	 AQhMN34PLx9GIbPiqyCEzyKd6z6ZbveUTh5JZDqpqcIdK9DUnRBl7dYc/jS6n6h22P
	 p7vqD2bkj9RwOd5j3sMitdFdJv3B91Q5Cz6BPdtjt1x+Ch7TdBWWEbQ/460UMXsgJO
	 3gb+KZwGM1o7Q==
Message-ID: <sashiko-outbox-213632@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/11] perf tests: Silence the libbfd probe in
 build-test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113200850.2803460-8-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
 <20261113200850.2803460-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:18:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> build-test evaluates the libbfd probe at parse time and the compiler's
> stderr isn't captured by $(shell ...), so without binutils-devel it
> prints "bfd.h: No such file or directory" once per tests/make
> invocation, five times per run.
>=20
> Redirect the compiler's stderr; the empty result still skips the
> nondistro tests as intended.
>=20
> Fixes: 523471c5163659c6 ("perf build: Skip nondistro build test if libbfd=
 is old")
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113200850.2803=
460-1-acme@kernel.org?part=3D7

