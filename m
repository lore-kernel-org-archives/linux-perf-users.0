Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38D513FEE
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Oct 2026 04:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791433124; cv=none; b=r9uXEklnSVVcbFSC6GCrxYSvajrjh6dxjAlF9TvfuKqkorNaMJixcEZthkmRIsTfWCPz72ntXGXZiR/H/do9Dxd5k4UORV3j3OYWqD13fMlVqwSQ2DDeVnFF90mes63IBfBC3XfdGORhbpZRyk+75bDB3jzaL+3M/xLtoxFH+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791433124; c=relaxed/simple;
	bh=SRAFMZcM09kN/AjUk+lJL7sNZPt1p9nf0aeda2tIPZo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=a4QwzwKKYBjvPj2FtUf9PoZPB2qYKnVNfjBxfwzQXQToQ61anIndYSiB6XWHyVSfTvP+8evrM0C0ZY3YPvMJT8KhWvg6XC40JX+0gedaX/SznROdkIOt9ikW4qIqU9JCAhAMOC8+JduplHgt+DEBHp/0HGTglytc8ErP7cnnIQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBSdldXv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBSdldXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA341F000FF;
	Thu,  8 Oct 2026 04:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791433123;
	bh=9o0zIyJ6McAYH7IjbQCXXaubg7+bKvN7n41+teW+4eQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FBSdldXvpGzN/q3xmJxQVRb7wRxBSZDcUYwhfFRFfBylNiZdkvdHVBz6eBZq2HfCQ
	 MYx0ZloWFwufcuHpYOAuz9m7lIyL2sXMvKL0KQBQ6x5zH0UmsN0yADntO98kgcPlku
	 AUtlZsS/Z/l1dg65TUIJfOm0j/Vj70cYkz/kvaFQjdbviao0Xw3gfH88q1PoLgLHnU
	 wZyk4QxNN1pOgr/WTtqs9cKwth6dlZrL23q+4CZpR7qjrIhQIj7RSnCGYOptYN7Xdz
	 y72WzaJHBiyjPZOLBShQ24e46QRrkTaa1NotxPF6van82C1z38iAP6vmnPLVJ7eOZ8
	 XzObJCW0o6zAQ==
Message-ID: <sashiko-outbox-163608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf bench: Add atomic operations benchmark
Reply-To: sashiko-reviews@lists.linux.dev
To: "Changbin Du" <changbin.du@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261008041123.1970315-1-changbin.du@gmail.com>
References: <20261008041123.1970315-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 04:18:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a new 'atomic' collection to perf bench for benchmarking
> atomic read-modify-write operations with multi-threaded
> contention testing. It provides two subcommands:
>=20
>   - atomic cas: contended compare-and-swap operations
>     (__atomic_compare_exchange_n)
>   - atomic inc: contended fetch-add operations (__atomic_fetch_add)
>=20
> Both support configurable thread count and iteration count to
> measure atomic contention effects.
>=20
> Why this benchmark is needed:
> - Atomic read-modify-write operations are fundamental to lock-free
>   algorithms and data structures. Understanding their performance
>   characteristics under contention is critical for designing
> [ ... ]
> - Per-thread times: fastest/slowest/avg thread completion time
> - Per-thread throughput: per-thread ops/sec (shows scheduling imbalance)
>=20
> Assisted-by: opencode:DeepSeek-V4-Pro
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008041123.1970=
315-1-changbin.du@gmail.com?part=3D1

