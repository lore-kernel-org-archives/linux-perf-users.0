Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942929;
	b=iOEPsQlCykrrmMplzFLmYHrT+aq9L+peQW/iBFVRRjjNI0bk8Y7SI+ZLfMTILVGz/cN9
	 bVhmrDt4xYxSW42jEQTv6az6TgYUGtAexlarQFzOEqqNyy+nHzLVyDCe0CtCunIMkPlPy
	 3pe0DsqXZ5TLKalWSeo48sAiJwlQ/5HVIZjIE9vz1kEnNmOIqiv8CAeW58V8ofAn4pdJ1
	 RbAr6zA3ti4uc9+GArYj4GFlNeknfPH6yCD5twSP6j9p7vftwAWTzAtfdQQlfd6SoAA5a
	 lpd7bteRRvAF9Py4B2TyiMNkIaSO5XSePLfkctIGMCyIW+EeTkNDEkwJ18IS2yjcElg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942929;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uyMFzgDFo/LVRZJjr+175jhlhALTM8HwRXLc/CsqpWM=;
	b=gIhc/5G6emQyowjPQsMDhLrgDq66ID7ogTvh5+GTd20vfLiXpXEGu0kB61fPM5JaXSJG
	 yPSjT9PcqPruaxZOMLGD8R8U3oD3WLLk+4nIcj0xBo77mjmHTrH679wkg/hU+gOxngPQy
	 j3bCU9AKOX6ekaOiCZAqgNWBJ5SwFnI7thHYSLqT4jNdN5bRoeAv60sD/2QY3OPJHeM3L
	 Kjmh6qGHm6jmnzZR8gn4G0SNqKlw87vgk+F4DHiffoVA4WkmMOBJF/CP3orY0PjPrdyI6
	 a/DsNF3iCLJzGPMjfaSLJwAkwWScVjT12Hr9dJHTin99BshRK8aCQI3/22tYb885Yww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4nF71v7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3F606A32C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4nF71v7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155491F000C4;
	Tue, 17 Nov 2026 19:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942929;
	bh=uyMFzgDFo/LVRZJjr+175jhlhALTM8HwRXLc/CsqpWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K4nF71v7LbWxY8QClkb5b21ZAEp3HNGFjCt83hn15TncFqEw7fp/SqHWqtXjBPhvl
	 D/xSKiDHz36fi1up7R8Ad87cRMqo79s3GjX5xsk8fvQr6Ha7AgtJHs17eXObuFJgdR
	 sD5+25N1tQsnl6axjG+w5pZcD5MPLjR2UoH43xuOHfWHI7MMqPERC6T6OcinZlMywD
	 nOgqCMFTzVGOkFo9FFysqL8+vqjPp0cMiPMGU+nVoTOXgZfg8vo9jSZJp/yOtJGgau
	 mtX56A7Hcci1hF6OgkrV7Lk9Gar4rvKv4CtAJ5/dMB0/5BeCvF3ADi9LxLZCtSCM7g
	 a6PfxLofV2W8g==
Message-ID: <sashiko-outbox-219454@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/9] perf session: Add dso__session() and
 session-scoped allocation wrappers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117185305.108003-9-irogers@google.com>
References: <20261117185305.108003-1-irogers@google.com>
 <20261117185305.108003-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:15:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add explicit session-scoped memory allocation wrappers:
> - perf_session__malloc(session, size)
> - perf_session__zalloc(session, size)
> - perf_session__calloc(session, nmemb, size)
> - perf_session__realloc(session, ptr, size)
> - perf_session__strdup(session, s)
>=20
> When an allocation fails and returns NULL, if a non-NULL struct
> perf_session is provided, the wrapper invokes perf_session__shrink() to
> evict unreferenced symbols, DSOs, and cached debuginfo across the
> session's machines and then retries the allocation once. This avoids
> the thrashing overhead of periodic heuristic shrinking while allowing
> perf to recover from memory exhaustion.
>=20
> Also plumb a back-pointer from struct dsos to its owning struct machine
> so machine__session(machine) and dso__session(dso) can resolve the
> active perf_session.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117185305.1080=
03-1-irogers@google.com?part=3D8

