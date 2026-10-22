Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701793;
	b=208VlTkDbh1N9BgacrfdC857331sx2fMAKSy1O8BtYpm9+qAd1UmeZD0GczZpiCp+JU/
	 GVE5w2LX9c3uDzsrYImkfM0R5Lc7arhpW8vbrVD7pQ5SWtoqRq1TE9qe4nEauT4A7Qtrj
	 w66VNCXV+iG6jWhawSvOuQD7vS80PyQ+XUtdfkbYTftz6cBpYpLPfKuITv945bJeRuDoD
	 ZJt0BSZAC+E6FR7BL1MgPkPjrIYKgCEaowAaI0uVDXRxJSXSeMOGuwu+4qqZmfweJW9wM
	 oMRK3vM7wMIvwUuZ/Q+narC0dGnaLi2R6shGgVl6goC/3CCGiUMLt+zq/aHnLGfJ7NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701793;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+hPGvCjCe3LSxF9++YNn2hQxV0pEK7jS5ZwIJOzjIl4=;
	b=ehQsuk/YC/EpIQ60Jq8eNygOD8UFrbwDfjiFcTm6IiJHxEQvsD3vq2GXq9Ovm7m/jfNX
	 SDIe/3Qr5kwnYIkekt4CYzvWGeR7Bt2YlPwstP0DUYKmLTAAw5TfCuQfBVqKYrppcfhL3
	 LDnuUG6SuLQQ8NwqbiOMi+fXOWFNjLscxjrfj+jeoYSn/JNNWr0dqldUGMjARaJtMkrtJ
	 F7gFnkdyfR3YMJhQYBaJrfLsQtNF5KjqLknxyqhHKbxo6g8crEvY4mP2Sqg28l0lrZt4E
	 PS/eaLTG+PFYPNnpIVg8poPWQHk49+R6fhhfL/6MhhhzDMdSrFtxJjplLCQ4Wdw+Qag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alpjfQ+Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E4C606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alpjfQ+Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D886A1F01825;
	Thu, 22 Oct 2026 20:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701793;
	bh=+hPGvCjCe3LSxF9++YNn2hQxV0pEK7jS5ZwIJOzjIl4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=alpjfQ+Q93e4iBldmCGNqgKuZLOODYSDkKaJPJKGpRBWC6fqWTMTV/L7kKHnL0bpY
	 qNGEzikzxENtl5pfmaOmoWcxyTRYpq8Duz6ofQjtr+KKqalujk4TZn4MHNV68xKnQ6
	 R7dZcV12Vh8sqloou183BR0cteyB2ja5eNx1ZmewP1/GUioRRpjU2lJhIcmQ20gqcS
	 zQhWqEzWSs/WedrDGknoqL2chHiv+GEo0KklV5WM1uexPC8hGVc7VdejVAnIuwMylX
	 pV/1PF6buhJU/INv15ODfzSEhhklsw9omg+WXIgs4DZPH2A1xHmhIVsLARsuDCR+PP
	 w4I3fFDjvcinw==
Message-ID: <sashiko-outbox-182020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/11] perf lock contention: Extend BPF lock
 contention to RCU and SRCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022203003.1779152-12-irogers@google.com>
References: <20261020205859.1080743-1-irogers@google.com>
 <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:43:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend 'perf lock contention --use-bpf' to track RCU and SRCU
> grace-period and barrier waits:
>=20
> - Attach fentry/fexit programs to synchronize_rcu(),
>   synchronize_rcu_expedited(), synchronize_rcu_tasks(), rcu_barrier(),
>   synchronize_srcu(), synchronize_srcu_expedited(), and srcu_barrier()
>   when available in BTF.
> - Support filtering by lock type ('-Y rcu', '-Y rcu:W', '-Y srcu',
>   '-Y srcu:W') and by lock name ('-L rcu' or specific srcu_struct
>   symbol names).
>=20
> Example usage:
>=20
>   # perf lock con -a -b -Y rcu,srcu -F wait_total,avg_wait -- sleep 1
>      total wait     avg wait         type   caller
>=20
>        35.12 ms      8.78 ms        rcu:W   cleanup_net+0x284
>         7.84 ms      3.92 ms       srcu:W   __fsnotify_parent+0x114
>=20
>   # perf lock con -a -b -l -L rcu -F wait_total,avg_wait -- sleep 1
>      total wait     avg wait            address   symbol
>=20
>        35.12 ms      8.78 ms   ffffffff83754dc0   rcu (rcu)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022203003.1779=
152-1-irogers@google.com?part=3D11

