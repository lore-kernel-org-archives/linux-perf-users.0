Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428778;
	b=3C7GXZa12ZgGdzqmPPWAG65hAgUX67Pz4jXm/5u0NTgLWTAzVWoC2lWpvTUnLnvyQK17
	 /M+CviWw2ZenNbcS5odokftEjC8VD0aA7E7ZkU7T1gHl2LX5TB9+dX1tf6mUGE92GC50L
	 HnUY+sYCrg8hXHL0McDkEKh9aY9hSVIm/ws/gGqPKFqAYGQ6jBycRQf/1kMw3AB1gfAav
	 fDLMeMe6WUp6uZ9Rv05zt6ywwAx3wflQCGu0vpL8Jh6UeLiP9Mb+cgZhh5PjNZSspX9he
	 gsyVYMCK4VW8ECwPoqNJFNJYt7M7gv1JqCkaWydLsR9vwf5iCEa4QgOyHj5UFygQ79Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428778;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vo4r2YvL0RTGg4C3rlkDmQZ8wchy2EYoHGsBoA0gWYg=;
	b=y+AH8M/Ezz8AXH8KPIfMZzfzkxEPHuFl+Ub5zMlo9kYciOrXvhmlouD/+C4DorQ98L1F
	 ru4gFX8Pvhvv/DnpAQRpQbpZAmn+fHSSoISoiYu09kWEudqbTnP3oLWJ6lMiKsUnh5umi
	 sHoTN8pS5/QVIfb3VGoBeZIbuCDNGsbM5czH5XRXqp5S0bI8xRdSm8Yi7oGDxaCr9YoOz
	 dyxHUpMcVdK+naekqyds+7VEnTYnFUHHvHHYkkJfygQIJpWz+bGGfS+bw/AFODWaq9gKz
	 aRNi1nYUKMalWR2EEkHcQsrNsgl0hoSWLV0gwHqyQhrtIWCjK7vbHOyO52DUa1GK6XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cI+MWvkJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE638606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cI+MWvkJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F521F00A05;
	Wed, 11 Nov 2026 20:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428778;
	bh=Vo4r2YvL0RTGg4C3rlkDmQZ8wchy2EYoHGsBoA0gWYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cI+MWvkJc0TqslVAmJ4aqBsWD75loqIKrn4engB4I3TiZhgiNjOzJeKTnYueNVRHN
	 ZnSBSdPSC+OPGGQv6SFmrivUfDgZTd4SSUGMDjNl2npmSbElG5JOAYm4y2hqz44YFx
	 FNU1PoyCuD6xEGCX/g8gK7ZvMD0c/8ORVDnwTxIThrr5jZCnQhPDUxGII1Bm0c+IuA
	 GLhm0fu0dbKW3GigZFVcVxJjIrvY1hpGIO+1PGZK9DBv/N1ajcb5/YX1NbJXfN4EY+
	 YUSf/77G1eb2P3LFB2JQR6r9a+YHqBGgRGPYMDeBQamURBnJowEzObYpvJLEfEa2vN
	 mCX6E1XJvRUMw==
Message-ID: <sashiko-outbox-209651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 14/20] perf thread: Expand context analysis
 annotations to threads and namespaces_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-15-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:26:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate shard and last_match in struct threads_table_entry with
> __guarded_by(&lock) and add __must_hold_shared()/__must_hold() to the
> last_match helpers in util/threads.c.
>=20
> In util/thread.h and util/thread.c, add __returns_ctx_lock() to
> thread__namespaces_lock() and thread__comm_lock(), annotate
> namespaces_list and comm_list with __guarded_by(), and add
> __must_hold_shared()/__must_hold() to the namespaces_list helpers.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D14

