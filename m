Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383292;
	b=MdnCRe90wg74+bBewZ9KoWwhnQBjO4SO9UuJR98dmJ4IwpuzwIYY07ZNZJThoNYArT18
	 zadh9OgkfGgifA1xOImLg19M1UosGdAe0Tu7JkCRkIy8/fcEFx2K13lBCgfeBBRIQxlR1
	 CFUc9g7EMq49U1OaupL1RrjeX7+8mUxXMNmp0yn9OVvQG6TnkPMkE0OWa7EiiA9Lnu44I
	 5LnDtQZQd1+Ox1QtMSLJgYVxNVe7KTsfkJ28S5zkyZg3DqD+lHs+jVIJ5dsc6qGJg0rQu
	 DLBwOeGnR6MLannrzrbl1n8Mr3YCbk03oJo0DJ4Y1VXPDUm3mCMIH1LiDtSK63+5+Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383292;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=852OIBA+RyFv5mI4IyySpyxG0q93j0oNJbtbsnThK+o=;
	b=fNoDQufpAs6wXnmgP3qGiT4tNJn4qBAedbOZIooHlsZndpYG64Z5ENaST7IwEoJhtqgA
	 ciAHH1BBpomntTVY9kCz2k4Eypi6ltUu1SP2TtmvdJBv5zj1LjiLeO6HJN+6JcspN7mFz
	 Hwlk4U7/Nra3a7/arZeLfgNbD7UpkRv2xBSwe4KGDEqCkXaqQ66AQgpSD5yC9uG09IQq6
	 PflqmMfUiebuPyU2dNLZIGuaJVwfsN+zdP6l0JFH6WBLLw4SBll4hIheLQdhX/CQbMYQR
	 NZ93ApWUtLTFjRzsWqz7d6BIjKARFSz4pIk1KZAABgbFM9kQq/8nzV1irEyb5slHXww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlOw1fAL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17E606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlOw1fAL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7161C1F000C1;
	Fri, 30 Oct 2026 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793383291;
	bh=852OIBA+RyFv5mI4IyySpyxG0q93j0oNJbtbsnThK+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YlOw1fALa4G3hPDtrPyT9F0BURVVC6ntTw3/ngyeZkYxoQyVqtgBFf0PAwTFQB86I
	 2NpERNTocc57Ygm84Ps2qAIQ2RDeZJqd09rjb1UtoJyPnL4VkAmKnBkEzxB1rRuAwW
	 Z8ik1L0hdiGvuqbaOv2FdFrgNea6PG3U0F+y+CEDyZaQLNxG0npsKGhEO4/H1k6mW5
	 IO8WIYiSDBiAUvng5b+JRFacgAuGI+R2WzWA0mTmmZQ8GXWdflOC14Dy4eB4TBZwmU
	 fs/GYq/NLzavivP6dlByHOUv7oLn0KMv3DQymnlbxyF4ZOcuboagbIOXLDwVmTt9cm
	 qGK/UFi+A6wxQ==
Message-ID: <sashiko-outbox-191387@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/9] perf jevents: Add support for NVIDIA Tegra410
 UCF PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030174816.1544471-2-bwicaksono@nvidia.com>
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
 <20261030174816.1544471-2-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 18:01:31 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030174816.1544=
471-1-bwicaksono@nvidia.com?part=3D1

