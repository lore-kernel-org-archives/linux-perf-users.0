Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835185;
	b=zWyTwEyyt11Z99iXQWCDOWU8idvkCxe5MRXVsOc9kNMKd9OKr0oxTFD1wsj309vhycST
	 8/JaDfLDfHDgkoen6mqlNa59uwk+MoopGHnlVUHYC8MBEY8SEyc0B7eWLCbcXZT7DlgZE
	 hphDzKE25D+UFl7z57Al5RkdNMwMyTgUa904nFvxhngPJ7tOK8qQRxMuSSCe1vBiY/zhp
	 hOq33to3cPPlN5FAA0kZ+CvYy5g4UVjDuAzxZcVcV7mLodzQccrp8awIzQvG5spG6yb97
	 2scX5phG95KNqOr/PrysYATSgj4kFKUQEQqEOcYcTCDHawc6ZD96RSiC+/q99GUxkFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835185;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Rd+Ko8ysUBHLYE8LtSxkGjd7eOz7dvnBZoZuODvmf8g=;
	b=baEJ6lMJHuuDN/CnQopJgJPyLGNqHVcuwSaQQxjsK4Kl2qBQgyCIfQIEVcN2Bi4B4TOQ
	 bIFmHhJ6Wg+tOjsz8CKVrQYvJbxrsfk9LxSGyuE1SbjmlB2gHJpBWTirewKLjfwTiBeCX
	 KNeOfDpBuv2cdwj+LMOOSMZZ6i5QUMZSzYLli+p9K11Z95fsnx+wlZ2Gux9okbCJlB0UY
	 V4L4PtdJyScCcrJCg0i4rRL8wOodd4KX6M/LF3r2fL39bqx5Da8qfsP3av6Rgei+8rQjJ
	 iGJ1u08lveqzSktDfEwRcIsaoicJ9YlgCfBejod9TgZAuRYGJG/fjSFB0zM0aYwZGQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TN8TsoIT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13B606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TN8TsoIT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA0E1F000C4;
	Mon, 16 Nov 2026 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794835185;
	bh=Rd+Ko8ysUBHLYE8LtSxkGjd7eOz7dvnBZoZuODvmf8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TN8TsoITM4IhUcNtpAlWs7ty+H7MT2XUyyec6W24Jd8thYVis+gV+QiT4wHO/NUjZ
	 AL4RRshRm0O7eST6y7T8WAF5atM66rApa5CMB28x7Bv2V9joAZ3C9TAxgJWIa0fxBv
	 wjubqHqA3zxITt5Ntp94gPXgWaZqFPimws10ghd8KvRMLVg2XJmmnm3YKVrFSFADy5
	 ZcGn8/8Crj3qxARBDLDzCry3+TSejwqwKDFLCtsLNEG7n0MWuFlFLzuhybaT6xhxbz
	 k31faUwulrCtzvkC80RkdDFwhhgsU0VGnmGnKCCEciKOmgq8ntA6K1AsSLt5XOdvIP
	 tyRkL+pT/NQoQ==
Message-ID: <sashiko-outbox-217059@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: Don't read the original event's pmu_ctx in
 inherit_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Wade" <danjwade95@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116130736.32585-1-danjwade95@gmail.com>
References: <20261116130736.32585-1-danjwade95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 13:19:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> inherit_event() walks @parent_event up to the original, top-level event
> and takes the PMU from its pmu_ctx. perf_event_init_context() holds the
> mutex of the forking task's own context, but that original is attached to
> the context it was opened in, whose mutex and lock are both unheld, and t=
he
> fork is not in an RCU read-side section. The move_group path of
> perf_event_open() drops that pmu_ctx with put_pmu_ctx(), which can free it
> through call_rcu(), and reinstalls the pointer only two loops later:
>=20
>   G: perf_event_open(group_fd =3D P)      M, a child of G: fork()
>   --------------------------------      ----------------------------
>   put_pmu_ctx(P->pmu_ctx)
>     call_rcu(free_epc_rcu)
>   [ grace period -> kfree() ]           inherit_event(C)
>                                           parent_event =3D P
>                                           P->pmu_ctx->pmu  <-- freed
>   P->pmu_ctx =3D pmu_ctx
>=20
> The value is used as a struct pmu. No privilege is needed: a software
> leader, an inheriting hardware event on the caller's own task, and a fork.
>=20
> Take the PMU from the event inherit_event() is given, before the
> replacement; it is attached to @parent_ctx, whose mutex is held. The resu=
lt
> differs only when the group was moved after the context was cloned from i=
t.
>=20
> Fixes: 4b9ce6719606 ("perf: Make sure to use pmu_ctx->pmu for groups")
> Signed-off-by: Daniel Wade <danjwade95@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116130736.3258=
5-1-danjwade95@gmail.com?part=3D1

