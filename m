Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783716;
	b=vkpTaTkPBs7xOuU4awMFV2kRe/C5ARNHty5SxLK2PXnxzzD9PBjY3O3W7IZAuNDf5NkM
	 cyR+K43tNA2BqkJ1XxkhEqCkNuKiD+ZwStXQHWimTXyok7p/hwVyBOf5WK/ZJ6zq2SQtN
	 3aGFc+0sPC5GQ/RyWtm+dWouSoJjP8nSH+QDUu34suUI0WgKW45LarP7Hcj/qIjLsZq86
	 E19JTqmfsnE+yklHtWjQqu5L+N635VDSMQ/IkOhK++0KMZhjn9ape0yZ/n/6Q/0+IVxUo
	 Ha4031Xqs1sHCD+0et9Rp4Iw3aGqZnSMarptQiTc/57WxrXcikRUZpsaYWw8jwROPCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783716;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U2pl1BJNb9c18TxXqf8ewfYJk4DN7EGnl+qq+MTWxj8=;
	b=qx+HU9E/TppeQWwaNBt+vGrwKYi8c0fnzBLMoB8uXTdmRiVOLCF885YhitXFcJX61MWi
	 6PcQPbue8Dv77WGf3bOROL1EmyuBeBoIO6cISanfWjQV/i0xX1MadNoxH5kCXZYWN23Oz
	 FjijSGNl8y7zz5TrOJLhz+VW+mnOhuwHZLPiBmi0bOvxEEi1z0agAlEfkprzNw4+pza6Q
	 8AIEwR811hFHYFMVHv2uPRpzLvJ0e6EoBry8FEh3dssDMXu1YDALg90M9/ZEUWTtjdcnU
	 zFa1r6VRc8J4MQE2bcfqhRcjAO4h4bEE6Bx24OqP3+A+llIXTieMMYwucHvf/SnB5hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3nRQzRW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64087606A31D
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3nRQzRW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AAC1F031E0;
	Fri, 23 Oct 2026 19:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783716;
	bh=U2pl1BJNb9c18TxXqf8ewfYJk4DN7EGnl+qq+MTWxj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L3nRQzRWik+y5DPFwQC3O1bSPg0GLDH9houFOmEl9wu9Eq/jQlBy/m1/ZxfLWnRGu
	 nRLwUms9VzgiTMglQtazCbI8NIxOdTee9FkrshPzSGQkS79eCR5oZx7X0dMDvYYx04
	 vX5SeuMADoRiKb7rb3bKHKquXikBIRUN1DpSg2JoUA7SCE9orWkX/syKuVh17QF24X
	 kFDyxnpGyiKmVPwhM3QkSacYW3UciE2jCTKyEEOGofrn8xbaq7WDnKXN/kxJ1QB+SY
	 S0z0cQ4aZ60tTmBLtY45Y6mY6RJQVzwvS71CeKkDRikIYgZnTrVUC1/yWupQpm0eP0
	 FcexS6zIn5ySg==
Message-ID: <sashiko-outbox-183116@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/11] perf bpf-filter: Extend lock_held() to support
 RCU, Tasks Trace RCU, and SRCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023190558.3050796-11-irogers@google.com>
References: <20261022203003.1779152-1-irogers@google.com>
 <20261023190558.3050796-1-irogers@google.com>
 <20261023190558.3050796-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 19:28:35 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend the lock_held(<lock>) BPF sample filter to support RCU, Tasks
> Trace RCU, and SRCU locks:
>=20
> - 'rcu' (supports both read/shared and write/exclusive modes):
>   - Read/shared ('lock_held_read(rcu)', 'lock_held(rcu:R)',
>     'lock_held(rcu_read_lock)'): directly inspects
>     current->rcu_read_lock_nesting in perf_sample_filter via CO-RE (on
>     CONFIG_PREEMPT_RCU kernels), accounting for the baseline
>     rcu_read_lock() nesting acquired by the perf overflow handler itself
>     (bpf_overflow_handler() and do_perf_sw_event()) with zero extra
>     fentry/fexit tracing hooks.
>   - Write/exclusive ('lock_held_write(rcu)', 'lock_held(rcu:W)'):
>     attaches fentry/fexit hooks to synchronize_rcu(),
>     synchronize_rcu_expedited(), synchronize_rcu_tasks(), and
>     rcu_barrier() to track grace-period and barrier waits.
> [ ... ]
>=20
>   # perf record -a -g -e task-clock --filter 'lock_held(rcu:W)' -- sleep 1
>   # perf record -a -g -e cycles --filter 'lock_held(srcu)' -- sleep 1
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023190558.3050=
796-1-irogers@google.com?part=3D10

