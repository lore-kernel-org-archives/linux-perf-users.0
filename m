Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700562;
	b=o2pm2hzJooKK9FE8IsHcp4x3Clg15ZeZNY+x/u0DEMIc0uRSV2/IMevgDiYKQJUh6a5t
	 Pv6jvAHOr65v3hx3ZdNX8nQSxtrjIKmk1OedlMhC5EYqmRKXxI82BqSast4sg6O62BeLS
	 4wY1Qh0G+IEfLMXffWItd+T6CBQDP8oRV2J248lrJr2rwIwCDVDMdBc7mBk8dKdr9WK2i
	 5YqEGrGVa/IZItsRDgKJDWesQbn9kYV52IyHQqCbJPxTQRqobCNpQE3nUIvhBG64TB38p
	 Gp+H28ScwkJ2dqVJ1t3eJjiMehIhHIJiFLw9XU1V2bRMkzCsxFteJ6Aeup0rakCYgEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700562;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=59YnveF3eIYPF8tcDZr0/5dqZQpHuLqsCZKxATVaJ8c=;
	b=ot9CPCI0ncyhQMkTedDZ83CxYJJadv/tUGKLVTumkiHO/sntnSEORVX0C0RlW30mWR5C
	 zrTci7s2QeI3nhbpQw7YEl2QRklRgFeTXCknB0OCDU1th0UBfSEWcCZl3DZlHGW0CJ05e
	 ok755bMPVjoaB90ju3ueJjMFEXMskz5fE02B42FAwlKvSNhpEv0MLud0YCyQYpBUEHlHc
	 Ixhk9Zs+j9XtaQb8EfStN8qv6eO8V9tF21cwxi0C8dsdWaQChgwzkILzJ6F3Sv9WOcPHt
	 ck+X1/Govdtd4NUMJ+wTHvKI8p0HLXtRond6GvQRiVzID4Ms0sRzk0/6I7mBhZCUfmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIqOVqg6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E368606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIqOVqg6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B056E1F01825;
	Thu, 22 Oct 2026 20:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700561;
	bh=59YnveF3eIYPF8tcDZr0/5dqZQpHuLqsCZKxATVaJ8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FIqOVqg6gAT4NeNayGUpC65b62I6xQoFKeMayiKeF2yR0I2Lq5nRarOY2tOibmy0q
	 KgZAbRxHHQ6FE3XbEwBQXW48n3ag8WzS/ULsWjF6cyyLnrITbn7DNoxqWNOSMvLODc
	 Ye4nCIjcBodCuLBEoaq0h7CqOrJmWOYNY+1mwhzirdYzLjgCKF6gXJyVP6SrgC8/Yg
	 e3WM1w70QkuJKe0HlSGddku30/lzFOChmIHisY7I6gcD9bxuqqAb8OzopRW0oEST6i
	 7jZov6FIjMhMKiO4fGnO7kreKe53qYLYQ+LSRtf8f3EEqISB5e5qHJMRrGAEndeDVO
	 0gt98kS/Z4gfg==
Message-ID: <sashiko-outbox-181990@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 16/19] perf intel-tpebs: Use DEFINE_MUTEX for
 tpebs_mtx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-17-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:22:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace tpebs_mtx_get() and its pthread_once() initialization helper
> tpebs_init() with DEFINE_MUTEX(tpebs_mtx) and static initializers for
> control_fd and ack_fd.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D16

