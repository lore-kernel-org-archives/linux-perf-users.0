Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB58E346A14
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792302507; cv=none; b=V/NXGF+bhi3YiJ7fqftq7z77wXo39p4jEGziT/KgDptuzYDSvElxgxvTD9h1n33eAq8GgcTVUAao7XkKXDFIeliVg0RztZ30kst1Cb8O5y39ZAcYcEjKS//li+kHVQYqKlsVQjMiL1bfRfhoPEafUXwABA8dzaO6ypv/KTR+Gkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792302507; c=relaxed/simple;
	bh=dZZMq0yRJVzA+9cCt1iSHp454/O4vHXHH1lmm96/Dc8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cGRCP3yhd+uOxxJ6o6eBfGMLBATbJpru/HY2fQo4PyHhLrMa26As5X6f90x4SUm0TSugrpXciNCSHIaSm4tKAYTWCsqcYHg7ztojwlzF/Y1ZWtuKVp99N8iHBrUJAWIuyoxEn45MojNhjv1ZQHasgYRVkaxUeW/nO4ggAVV7Ysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3pzSwEL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3pzSwEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C3F1F000C4;
	Sun, 18 Oct 2026 05:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792302506;
	bh=mmbjwOvdzl7UXiuGWe/767GomK7XKujNyqOIwRx5JN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B3pzSwEL3MyYxEDvlvMXgloh0xsJcYvh7yiZQiw8OqWGIKL2Y28QofMORgZklK/qR
	 RvNEzUNPaoLjNheknaD9jjslNdjn85U7JF8xJvZnA37a5SVoK3nWwnitXNt4lTchwx
	 s5m2opQ1ITs0opUptr2Kxr/ScnurVjYh0c5Vd7av+dJKO2m2BeWeMYBoUFqyISxtVF
	 kU/kCcJ4PGNXOzFaCY0vezkdOu1Tj+A1se12MMBeNzxIwiiNtVDjI+Ld85XMY+012y
	 R7tY5uv5Qa7EaBvcUc0E9/OexCBfRaWrOEo9ErhfQdPCF9k+j6M9mOXc7hZ9Zkc3Ne
	 GyET3npkACZQA==
Message-ID: <sashiko-outbox-175955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] perf lock contention: Extend BPF lock contention
 to RCU and SRCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018053710.2572636-6-irogers@google.com>
References: <20261017171437.2066343-1-irogers@google.com>
 <20261018053710.2572636-1-irogers@google.com>
 <20261018053710.2572636-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 05:48:25 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018053710.2572=
636-1-irogers@google.com?part=3D5

