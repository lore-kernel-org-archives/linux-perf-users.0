Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591624;
	b=heEtEYYuIXvUX87HKl9LJnyM9xbDalxVeNzlOuA9f8/L2eH9RgzYLi/kxWPlHktDYntd
	 b4235Y9erLT0h5OZBuNn/GBw6j3GLp9G7V+l//0aTYdE1WhurJp1rVQi9IJp2yqY9xijz
	 5YO810309hyBpXOo1POwfmE11C67/45ITH9iXDa9W1nnftoN0qZUCKG2gFzLDeqdnaNjI
	 /3pPZaoli1gEYsLeYN93+tGePvzHohkusyoaLZ9BG+IUz2XKyXBkY2EmD/EDz7t17vzhJ
	 oO3azr/LcOfSM/i9Xxjs/MZBe6Qng8YNdY/csCeDuv7yXuyv598LvuBZsGQ6skK4tOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591624;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LBnOT+pYNjKtQCvUKDuEfxrT7ZoQnJHrgCpH8VkBawk=;
	b=NCtpAqjkS8jmVmETTqZATHJqpEp8gCUzTAk8xWH/Yl2W8+dApq11XuHdwf/VsoNVBD3g
	 uvSuSL/PwYtnnbAJUTtMiIL34QlFMxaQmvdtWW34hsQlzkj6bXC8og6k6qkjyVes3Ma+C
	 oPyiW77HzC4KkH3/jSsRYYRo9Eee00FOyKuVkbSfyWwdEFff747J1zprSIcxy608oBT8d
	 ujzuwefCeGWyOP4uUVDj7upI18Pcce87YgZJz2R3J6ZRjLprIVl5jsBqYilBeHUlURBhi
	 4RFvhKAxWmrMj+dR0GI6w8bdRln2X86CEZ2MvEDzX7nT/jI+KgTAVocMnnZI25DWb3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfElTf3W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A2606B478
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfElTf3W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462801F000C4;
	Fri, 13 Nov 2026 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591624;
	bh=LBnOT+pYNjKtQCvUKDuEfxrT7ZoQnJHrgCpH8VkBawk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bfElTf3WieD70t7cceVaQjkojFh9rLSDMTUdrhx+7li1u0IZZnLM/ccfppfuchr5D
	 SHGtxsMWMASQ7bSrVzIcmiBsztXeK0P3hqnMXv60BcwooqARe7E3SuX1itnlYMYBLR
	 9jxDI021fpYbt8B6ByzsKkJFR8hLW18bJomVWqMtFk/GmhfiSu+ikTQKwOqCnqo+Pm
	 UFCewMm3TLDTMHfD2N+iGE+galzur3aIil9jczWPpiAQ6BNPgAZA6O/kfbRLYQWmi7
	 1X4lNvRKRNObJOKoyl+JqFM0XA+Zo3O68jUGegGSjzw5gOLNheDhOMWyCcK79A4767
	 Dca50eLP/einw==
Message-ID: <sashiko-outbox-213338@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/23] perf symbol: Switch backing storage from
 rbtree to struct symbols array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-19-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:40:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Previously, DSO symbols were stored in an unprotected rb_root_cached
> with a 24-byte struct rb_node embedded inside every struct symbol. That
> design had three drawbacks:
> 1. Embedding struct rb_node (3 pointers, 24 bytes on 64-bit) accounted
>    for nearly 40% of struct symbol's fixed header size and scattered
>    symbol lookups across non-contiguous heap nodes.
> 2. Unlike struct dsos and struct maps, the symbol rbtree had no lock
>    protecting concurrent lookups, sorting, and insertions.
> 3. Deduplicating symbols, splitting kallsyms, and trimming excess symbol
>    container capacity under memory pressure benefit from operating on a
>    compact array under a lock.
>=20
> Replace struct rb_node in struct symbol with a locked, lazily-sorted
> pointer array in struct symbols, matching the design of struct dsos and
> struct maps:
> [ ... ]
>   After (libLLVM.so.21.1, -22.3% load, -8.1% memory):
>     Average DSO load + sort: 61.074 msec (+- 0.236 msec)
>     Average DSO memory usage: 8755 KB (+- 1 KB)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D18

