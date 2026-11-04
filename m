Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809612;
	b=UMDmtpNK64RlOqQ/JGMJJ5SsdIoevUNKjg8FNFcyDeVA1wYnRByRQGg/x3zw9Lfan19A
	 3uRrAvVCwmpkaOPbYXMFyASWCJnD2Xh1yOhS3AJCrOcxyStMbNHgXElSaTNjzv7R08xbg
	 aUWUOC6RA4pIpg1LUqeefnQpQh22JlojV6hTCMqK1Sz6evklMyWTSS2v0dxwTTwXq1ti3
	 DYzU9SKl97vEXppNPiVFMSiy11Ru2XJqH0cFpZFj4yD5ahxedDzpSOHvmeyhxIAJVdEz5
	 28DaLIpub/LHamlULJCIGJTjRQlU+HdR78iAOD71LN8FdRMDrzfGhwWFKbdKbHJ2YUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809612;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mJq1ZQ7jYW4PPcj7vIEBQZj5ZkGUM6UhIgKtjpP+pJc=;
	b=XQB0pEG8a8nIp8djBcn+5NdWwidQUnNC7e4FEsX/5Tdt5EkIb5/jYnLDKLkFhOvfV25U
	 BQarNA40oieh1mNQKmMw5owMo4R07HyNN4p8soNNeBW8LWphCC5VMOqUQU4UJUoXU4vFT
	 jKpomVhvdWDRR2g4FrYVhhAWU05GSxwCLvw4ZyzOH+5WBc0yt4EEgtxDGE2NpSYSooWdO
	 pFCEwE2PZPGCww0b5nedEHaIholoj9n2j0iof4ZBimZ9RVJzUEw2X5vQf/jdDPACUMvS4
	 efXmlgOn3/f+ybfjdegL1hQAt1YCggw8GbqPaE9AE7HcIXjbyeELSFNEpajpj++JmrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAJ4bXFF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27604606A333
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAJ4bXFF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911B61F00A02;
	Wed,  4 Nov 2026 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809611;
	bh=mJq1ZQ7jYW4PPcj7vIEBQZj5ZkGUM6UhIgKtjpP+pJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gAJ4bXFF3Gx0pvxZSU7OZgUhU4MBHCHbXgor9RNsiwkZFhF+45Na0dyG7BMBIXj5W
	 mh9v9vPul59uNcQCgyb0yppLweruq2wlqsNNWgRXJZntYXJafkq6DV4wcAXYakM4v9
	 0dQxbLhQQgFnKLvrWOS4xmInSDiQ9learFilj+Fgly7t4ojMH5GalL9CgLg1dXTS/L
	 4iRUw7JKugXRKZQC9Kwx+0ZHvBLxnqYJGm99HEuIqc6FTkLdeWvAb22l9lF0X028gn
	 4OVOEYSPpd91HDFtBPq6gzYG8ZUezgvgH4z1vkce8s7ag0ItHopMs+c77FuCkFh5NI
	 CR2JSALbIPxbA==
Message-ID: <sashiko-outbox-197605@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] perf jevents: Add support for NVIDIA Tegra410
 UCF PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104160716.2910873-2-bwicaksono@nvidia.com>
References: <20261104160716.2910873-1-bwicaksono@nvidia.com>
 <20261104160716.2910873-2-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:26:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add alias support for NVIDIA Tegra410 UCF PMU events and metrics.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104160716.2910=
873-1-bwicaksono@nvidia.com?part=3D1

