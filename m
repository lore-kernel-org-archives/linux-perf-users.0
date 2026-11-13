Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600322;
	b=LECKsAs+fk8ZDY3+YLRLZgpazMKVG8IULC/FPGn1GjaaCpJZVwJ8Mi5O+6PyCLwIrLsY
	 oJU4BTW9TQvNqvsa5nZamlorI4MAOOyp1j19U982yO1YmxiL+SH7JVHJgeIwy6MGEp+F4
	 TrpTdTGhN5wYNaXqWZ8F3WU4Qp31pdL7FUfYzSwN9LgQOVr7U9MN7kXkGUUjRr7Snw+l4
	 9qmS8+tNwfa+aisZkKOs4yuMlnlNDx61HLEgJUSPRaaopVTbI1ANJFIMOgr3qTREMYPnb
	 +thoaeYs2aIXpjLWGcoFfQLPAY+L0HpHdq2DbKd0NYiNt8K+b9g2N9+dnwWUvJ0QB/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600322;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DamFSyvc71ygRrYyWA5zXjbnXHxljf9qL61y//7XoRQ=;
	b=DYC8U0BNrkmfs1hxXiXAYEht4s6dTDrEY4zwbYcZGXx2/VKCuYTWEvWaWz1TgBoI7AyV
	 kgPqsdzfWSk+91dzQ6u4NH7VzbYWCjU7MZYHa42PXu7+WcHf15CvXaH0cN06HsBUMOIqr
	 SWAl871zQMK0tZukC5eOl2YiSzHXLCN0MPqJFsBMFqLW7o5tzP7iKKAYDub0yA0vD87c/
	 7PjDvxg9BD5jWRc9oQPVtzOqJN1p7/J+A61yV8iFpxIIj4+nT30Xd1pZbdBejeuRI8lgw
	 rw3EJiJfPdghYn4GFpAH/KEY5wZ3EZ7jL4iL3PTG81fJvBzbgdghz0nblP0Z65Gdj7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHLIldHt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0A606A32E
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHLIldHt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D994E1F000C4;
	Fri, 13 Nov 2026 20:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600322;
	bh=DamFSyvc71ygRrYyWA5zXjbnXHxljf9qL61y//7XoRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jHLIldHt5srAVn/t2fDm51yeY1Lk6+K1UttHK5T3XYNNeKtBnPEHRhMbkyqFtxlID
	 eQan/li2nj4uEll50s3WNkUWj0MzLLaA914+1ynls8/jOKvp8eiJX7JDVwikwEN8Kf
	 NN/IyBASaG5mgsjAEZdVfkKWWzXMmrdFW0VZI0QDftsaJGUWYa/eUJQ6/1d/+kdQOP
	 QRYoxLgZBpI50DJ6x/Z2EtA2rS7tJg1fP4DTRMqGRjtkbnXqU623amTgvBN/AW/uRO
	 OYMB110F4oEberGzZrbT+ey4iyhk+t1Rpbd7qJ++SRILQA6AZUPzB0G6+qRY9Xbb5m
	 wv8gawgRsATjA==
Message-ID: <sashiko-outbox-213610@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/30] perf env: Make lazy perf_env initialization
 thread-safe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-6-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:05:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Guard lazy initialization of kernel_is_64_bit, nr_cpus_avail, e_machine,
> cpuid, nr_pmu_mappings, pmu_mappings, and numa_map in struct perf_env
> with env->lock, and use DO_ONCE() to initialize the cached host utsname
> structure. This prevents data races when multiple threads concurrently
> query a shared struct perf_env.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D5

