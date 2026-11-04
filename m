Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810157;
	b=mlcrGE89cEZFWtyEXxk/nIetbIiTzh8/MfxPTaeYoV5lMo7cE2aA2DUwnoZF+scmPMB5
	 Ua3UsZTwXUn5Z9yzxbEkTank0y7u5200urCU/g/iOYPiJ7n7NztJgEmEPj2iHG7+Dwk4o
	 52wYiXLeSGAVvzh2TtuXst7si9BzxvWZT9+8H4ianENdMLqHU2MzJr/m+PNQ+VsXjmQp3
	 U/5d86H45Az7q0d6zJTyH7WRjGxjgTTL04a7hnvafvKmeD6kgeKGwfwzzT9gS2kmKvAHJ
	 pcKE2Z66IgKEiT03P+YvQhydeKggQ6CGnHHHbu+3Jc9itRpVgsPjOEvOHVpq4nv1+zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810157;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HyrBj0kRtkZnPRnFpm9wjTUMd66YBHnzL1dnF6Ojw3A=;
	b=l8dyOuianyMRyopRb9AFm/uE29xhP92PDY0fYPCLAvHrrbwLhx0DSrn43BqL1Kidd/w8
	 00SpFXhpOKNGBJ2hQY1ORyuBtu6whCFTbZZRnFyhHYOQp2u1ZNY80wge/GDkVON9u7lcs
	 kFizFO2yyEK1h6TX48UlH1bqtm9/wcq+kMsk7skz2Z86hDG/DT1yERWPpZHag6OiMj9e5
	 cI7MghrLimfeb6f+X/lponfKNYL95UaM9qezPulJ6x8DpZv8OERkWe7Z+qzRVuQLseMaV
	 xa5Kbrt7zhQUw2SOxhalICj5ytA49zWmugSXCTIUvur8q9fduf0q7oO+JuK97aS/NzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PAvI/xay";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2741606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PAvI/xay
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DED11F000C1;
	Wed,  4 Nov 2026 16:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810156;
	bh=HyrBj0kRtkZnPRnFpm9wjTUMd66YBHnzL1dnF6Ojw3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PAvI/xayJvOM+z/E+oqXRtLkFiHJu2QUvkLT1JvbIOyN5iRqFrqKP6waLc8DIuZ9H
	 vi8IDXY1BPf1aHVJI3kHm6iics0gtbznrshdyftnW36Sq8kEpNOZV4iZeQdfMZhqry
	 7BUOd3ANg4jIVHjwBytDu0bdwo2tsK0gMl//NaPBD31ZPZr3YtCrwgj6lsugcLg5fC
	 Sn4jg3Za5v+xAXxpu1jxlEoSyqaMKslOpOVovU7K7oFUBG8O0U+yP51WTjrg0Boa1A
	 CppLfDCaga52G51AmbQeZUsRxiCZ1ytmH9vlgOvrqyErKr8/lie/xvoriiHhrvdavC
	 n2LpLtzGHr9JQ==
Message-ID: <sashiko-outbox-197626@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] perf jevents: Add support for NVIDIA Tegra410
 CPU Memory Latency PMU aliasing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104160716.2910873-5-bwicaksono@nvidia.com>
References: <20261104160716.2910873-1-bwicaksono@nvidia.com>
 <20261104160716.2910873-5-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:35:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add alias support for NVIDIA Tegra410 CPU Memory Latency PMU events.
>=20
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104160716.2910=
873-1-bwicaksono@nvidia.com?part=3D4

