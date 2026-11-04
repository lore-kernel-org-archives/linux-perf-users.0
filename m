Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827170;
	b=JCwtw03tSSTVjpG0IFbN1couZOf8PpPHXmEEVE1AIjL4vlKIlUrv1eKMnuGSg3be2wzm
	 KEvgqvi0we+XqZRHpPsbDyAg5t80Kki+t3Q3shWc6IKHpq3xkEy+Q8vC3MQUDpjrSG9U8
	 bHs6FOVavql0fk57MCekaAUqiKFnwem32hxHzuVjdYqy6KeEklZFrgAd40u1IT3tl5azn
	 SdPOgzjxk/cl+P9elmQ8HlUD9+fhl1eB0URs8gyNEW7cadn+Zu7OFr25HkA0m1Q7TEkg1
	 G5NvotTIiqCs7tZT23Hn3N6nmy/SLK281kut+ROCAoGh9FPqe4T1ULtkUOMwOtV5dOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827170;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=laf8LOVg1+gNvmmBFR8ujDEZ8toScyzlnnQII6ALsW4=;
	b=rdM/CpGGqIkKHJvJiCqwryLbEkV0tBIdEczH5D184/p8iynl5/Z9GTf9vtK8jsTbMNkj
	 5s90DnQ5vyEvxOgz9Tj9XSVvcWXU8Pg1k9d6LF1fEG4KIEA30h84FTcSo0rr6S3yKfwHz
	 ViKbZyViQE+TlS+6h/4NAcP7Mm/Hsilr3rin41X8AjbEE+wnCNZRa61uQAn0Kr2A9rHur
	 Z3+MtbjpwBcg4nWiCyQACX+N4v9+KMohsD6fhahOnJVlZFrmHNEOBzwV5990uMPXHltHP
	 NzHZH8j/43XDMR4ZNAB+JERwzGGOyMmcd8Nv0Mdoi2ioyGdI+EYj9JAsXD/55QJt5Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYbcKJ51;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880DF6074FAF
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYbcKJ51
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405B01F0093A;
	Wed,  4 Nov 2026 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827170;
	bh=laf8LOVg1+gNvmmBFR8ujDEZ8toScyzlnnQII6ALsW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TYbcKJ51LK0C6aTq+2Ul9ykGg4heEpON3MIReQumrQQ2ZtyzZQsTd3B+vya++e8IR
	 T3kMkSj+TY39xBaLpaBpTUxiapxnNHCN0UrIAWgxJeKb7+xzPOq6khvHFrhV5Ez+iW
	 4ER9UdVrVM4Ztx6i/S2ZSlNF7nKkGl08R6JPffw69Ngwfhg9kMOfSN+4dlEjI131wd
	 8/2BYh1tzlyAp4IENJi7Fyts1TeK7lJiDpQmXwD+eVkZ54IRBv1D4+IZrG2RBulEPu
	 NiKxgXYuYnFWyff9gk55pEDm90nIzRI5MEtRPve+/BcZxdt2W72enCKmekZQFPUDBz
	 sC5j8jLqDI5Mg==
Message-ID: <sashiko-outbox-198094@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/19] perf dso: Use DEFINE_MUTEX for
 dso__data_open_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-12-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:19:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace _dso__data_open_lock and its pthread_once() initialization
> wrapper dso__data_open_lock() with DEFINE_MUTEX(dso__data_open_lock).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D11

