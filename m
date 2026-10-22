Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701394;
	b=kQ9cPEFxHX80sCC0Gml38iM5hxYxKJDZrxkWmMr44WAWZmeDMe8xntwKByQ10/ofkvp2
	 kMu1gxgXJp/gJ3pGZ6POVW4hjzUOYUNOr/TA9cUIwGs0o1HrgEHloBowfm63vH75FT3kL
	 mj5OvRdQCWwyljRY54iAaTdJACBnOn5SPKKjDOjMonDIyLd3XWAFArtyqGbXNR5Ft2ksV
	 OD5ReSuf49IxQSVXLd6wtLefHtGH0MUoRKjSsjXKcEJ/llN3vSP3edyWYsTGYeOHTUKf4
	 k3MF0M3PE2eGN+0PcfUtyhmPHFossuPBtwqAP3PgbDPR+VBPzLmCJfMwzx0HYpcR3fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701394;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e6SXhMNeFN5vz3KWNw58GSq/CkW+qVFJiRc1Zy6+oGU=;
	b=qMq011o8Gc4Gk8qlIuXNqPIP4vFVFJyNkTFpyLQo81QD9YZcCXdLvyzzL6Xn0u/i0HJV
	 twvmT/LrE0qwqodKMmpRmn94FIXjVfXND4NHkNnhjijnFbVoSyir6rCIxH4uSEJoc+PvM
	 yEboxPZYP4EVU5W0eoTcdrMKispbpgK0PUtOsU/IO5bV3BYcz3OLPg9BgTbfjpnxi8NBi
	 bVPltt0Y2kK//aGmXtj4V4IoNtB3sB+TM4RiHJbIjVGFuxW/qqi+zAhippcOYBTHjqoDL
	 v/pv4H8aIeZWta7ETjFvN/5CgoT2lA1lptLtCuvDQJdTS1b3iFc9P/N1JV/oP6w/plQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7q8hheK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D23606A334
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7q8hheK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6C71F031E2;
	Thu, 22 Oct 2026 20:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701393;
	bh=e6SXhMNeFN5vz3KWNw58GSq/CkW+qVFJiRc1Zy6+oGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R7q8hheK6eehd2Wx9H9e2srLefc5vSyZEBVZul8Mv96k8YdvY8op8FZ5cRJrmL1E2
	 v7oRDu4IHW6CJpTXq0or7UgxKzx1ziihE/fxSAubNq7f+LuIoseNP9cWHPsS+RZZRC
	 KHoNaQqc1vP8xPBPbBYCckBJSbDy/3KxLMYF1DSolLPYAlTWMcmcY3ByzZH95DpDc7
	 /h6Hnrung9nQ+pM+09SXmVFzOZDW3RMKjwObGsLVFo8nRvv6DQDGw3Uh1n10hLqoyR
	 4Z59cBtBaub51UrxhxZOeNH1jQp2OmgQFy9xoxgvRmkr+H0B+hY5/B9EpFgMW4SADY
	 eY6t6WQag0a9Q==
Message-ID: <sashiko-outbox-182014@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/11] perf lock contention: Share common BPF and
 lock type definitions in lock_data.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022203003.1779152-4-irogers@google.com>
References: <20261020205859.1080743-1-irogers@google.com>
 <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:36:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Move lock_type_table, LCB_F_* flags, and the common BPF lock helpers
> (get_lock_owner, get_current_mmap_lock, get_current_siglock,
> get_lock_addr, check_lock_type, do_collect_zone_lock,
> do_collect_lock_syms, do_slab_cache_iter) and shared CO-RE structs into
> tools/perf/util/bpf_skel/lock_data.h and tools/perf/util/lock-contention.=
[ch]
> so they can be reused by BPF sample filtering.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022203003.1779=
152-1-irogers@google.com?part=3D3

