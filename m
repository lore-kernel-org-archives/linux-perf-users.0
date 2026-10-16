Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20D83D301D
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137802; cv=none; b=HO8xpDB9XMtTZGlO8TwPwfesMjmuxCXikr8X18KqtDfVBFirWdq2Vh/o97cR4CG8K9QH9WUm4Ed2Hp5V1/P/HPs3WrgvC3+ISTZgv/i0jmgcjH5eNZ63kVkEyY22AFkIEhTS1Zd/0gM2LrMV83u6Z1C678ixzIdNzxr0AhUoquY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137802; c=relaxed/simple;
	bh=NdaLdc9ET2oirjqC8Feo2Pfv4g/U4c9VRUclw7vKuD4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lw73XQg9/9zAhQITDo3QAuqprtOn2xTzA1tnZXsp9WNs9kjn7N8fEKLkGqAPBfeFssUJ5VDj4rxav+Uemmu3R3WvBYlG1LKoLLgm5Ww9tWcrw303p8Xvgv9suxB2Ve7wMHgygv3llYcBZ235bv1gPv8Ebt0iq71FCAemsdw+G38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Comgzy53; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Comgzy53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559251F000C4;
	Fri, 16 Oct 2026 08:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792137801;
	bh=I1v8FLoxpx+DxI6vx2LNDPdksKuoaKNT03FopZfn+d8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Comgzy53c/WTls30WzgnLO3YAHz5J8LUQ6WoGM+jPV/Gsa8ltoUJKFUf/v5cMoHaD
	 h19iyacBZLWCuVrtyEFZqH/vZ1jBGNkS+cR7S/r6xOneEvmnjY8LNgKllMgw1LM2qL
	 uUOYGu2TKrcVfdqKqhoq0vdkD62dgxWV7LoKYpVko7WhyM+1IId4mSi/6Pe5zCbGX+
	 VYAiY/k9ugpZXRgiH6BsbjFbXjGa4oO1VdaJBLFX5sDUXcm8nPOmZPFGgFU4OkST8P
	 sAAMUTolglc/Z7IBltBy0zmulFn9Z3JQsouE5MKf7C+VqKAt0W1B2FYTYk0QMoJnn3
	 cKh3OSUGNw0cw==
Message-ID: <sashiko-outbox-173987@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] perf bench: Add atomic operations benchmark
Reply-To: sashiko-reviews@lists.linux.dev
To: "Changbin Du" <changbin.du@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016075552.1759260-1-changbin.du@gmail.com>
References: <20261016075552.1759260-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 08:03:20 +0000
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
> Both support a configurable thread count and runtime to measure
> atomic contention effects.
>=20
> Why this benchmark is needed:
> - Atomic read-modify-write operations are fundamental to lock-free
>   algorithms and data structures. Understanding their performance
>   characteristics under contention is critical for designing
> [ ... ]
> - Per-thread ops: fastest/slowest/avg operations per thread in the
>   last repeat (shows scheduling imbalance and lack of progress)
>=20
> Assisted-by: opencode:DeepSeek-V4-Pro
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016075552.1759=
260-1-changbin.du@gmail.com?part=3D1

