Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701869;
	b=IxQ0SoUa6ROON+iqbNkWVvSH/Tn9qqWCwjm6035Uq6TJkuyQcG+xU5KoyT/N5ei/69Ag
	 4bvEYMFu8zvyRoEijeU7TLPyhmjqknQDq4ALjg9dBRSLpGaIzgL+MajpOS+NDZqr08aAI
	 btM89W8iHKhQHZu8rI+3j73E5Tz7j0MK7YRbqiOX3+DqirIrqzu+2v7DJmGJ4VugsihuF
	 Hp5sREEUdSSbfcO9aNnSTr0+o4YQq+hHSC1p1mEIS8iV43YgwMmX3AsGwZnFzAsfq2uEB
	 w/P74rKCmq9ZJi1enmW/w7Z+hY77/mckJ94xuvlzTlaawKv9wg/bixUs3NGb3+bfiNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701869;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eJNYhOERQ4ZI6pBemNFbnK3+hGimxjEr6t6iyYFT1Yc=;
	b=G3C9w4d0kliQhDcmCnA4wJN0dcNi6SPpU3eOG7fLKcif4pPljDc5csREp8EB9WzgSB42
	 dtKJ1WlJiwq0n3WhLwGdPqRImFxNwEmj1pG3quIO8LhbrGSirqBzzaa66X3LLWHTA9o8Q
	 6LtyVd32fee2OF1Wl9aUfanjmmTa8QpcsKuvrlCB1WUG6A+mT66DyhmgS3h0g9nt+lT78
	 yJedCC1Ob58NtTplFlaNCLg/GJDX6NzwTFQ6grs1dDuvXJCly3HcJVDS9K/uyJ4lim/xn
	 HrFIic6n233WLN+f6EJ/8iaDcXfV5JHQRCDz0wE2/ig2kdemXqPRuUQ/vTLy+3onfyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EV1RsrE1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A31606A32E
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EV1RsrE1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B703E1F01828;
	Thu, 22 Oct 2026 20:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701868;
	bh=eJNYhOERQ4ZI6pBemNFbnK3+hGimxjEr6t6iyYFT1Yc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EV1RsrE1//f/PjU0HOVJK49cQN1tOmF2I+lBsLk+/Yalj8BAFSEFzQIj7OkAddJGF
	 ID2zi3EABB7kRlFetmCcuoZ0kISVmD9Nu43qmaSrJ+I8rc6pyjSBc3MvLVlctEjDt+
	 68WQMszjvBo69oj/jWkpyVoiGmWg7R7VkBiMKxcj0vlsqLlB1VERJJEl5E3trFIEN9
	 V2xDLQipGhZ6tWnewytgH5fM0OFlH6gEd7Yk+SdXnGjkT+cG41d/fmMBB+pA2Lu6VE
	 xnO4yjhiBNKpwQ4hQptF4uQBA4aDRn/QgUfMye4TH8T4PTR5XD0lfpmkI46uXKNJdC
	 PJXP5aW9luFVA==
Message-ID: <sashiko-outbox-182021@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/11] perf bpf-filter: Extend lock_held() to support
 RCU, Tasks Trace RCU, and SRCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022203003.1779152-11-irogers@google.com>
References: <20261020205859.1080743-1-irogers@google.com>
 <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:44:28 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022203003.1779=
152-1-irogers@google.com?part=3D10

