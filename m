Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589180;
	b=bOt+lIg/HOrWS1CT8wXJG9Jmor8N7Qtp6e5pJqY4tplRHzUgHGhIH38tVl2n/dC+q9Uf
	 eP31dOnfpmbICDla/DXZBT3gG5sRbYuqFXfd+FAEE+vQOfCXSWTCldWCSu+wjDB3xJHWs
	 m32ncVlNdF+cQyLNu9yAcugEPK/zJxcc4/xQUSdaVb6ZEymy/x4T2BzXzzE31ujU18ORX
	 nVzQDc26qegbMXI9VOaPAAo/3g6lgLLuTLYoVo5yl5fxvZYJqHg5p1WWOzYQEXJMMISsu
	 DYkA2F0ZHFMa2iOCIA/drXdaHfd6a8LzouDTDckn9O2mvNA9foouPLcNDeYFZVN5cLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589180;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jLcegW2imKgBBE/Pjl3innfn1A0TaUiMa3HNUBLvC98=;
	b=fn86YwjQRVVBmtzdmiBRevJ8Ns+OS3qmWhChjk0ESc9zD+/ePusTDjz6g7IYDXLgg03/
	 qh5UmgQ34p8JN4174tmncvcz7BHDIooy6Dr8zMU5LCnonvD7hpuS+AcVyjFR6WRx+vshj
	 nAea0ScJrJ3t6s1ZBv+dVOgAWakFEW5vwhHrwakSWQCyCc1DRAFgjSoA7aDPdRMFp85GA
	 X0qDj+ULz0w7GueXxSX5OPFZJyjfljcQGrZqspPRRyPF+AN/17OGtVrp2LwXQIxcFUfYF
	 YlVVhQ+NueO75HXTwlrbNf/ma321KyS6HG2og8372WNHGNbOGjGPtksrMAIqzQNnF6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCIwfly5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4120606A337
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCIwfly5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0C11F000C5;
	Fri, 13 Nov 2026 16:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589180;
	bh=jLcegW2imKgBBE/Pjl3innfn1A0TaUiMa3HNUBLvC98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TCIwfly5mHusO+CZ9d3WuKIYwMJ5s+gMImG0v8UEMRLIoBp2bNGlr6eZpzgf+nTor
	 4pnM1Bpml5LAnRVD1yht9mUibVV4ar3LpiiDDHa+IpBuq2v94hPmzj5f3+ILK0DdpF
	 NKfwWCtM2mF8Eg4Phl0PB1rANniSlS8HO+9D58RbIXtxUV7wgp+jaJdB/xy50SVR5N
	 0HoE7tNzOjqWlLF7R0h/AOafjkh9gN5j83pltqGZXnqO0ttTyll7v/0GKjzwCbaIjx
	 Hfni+fTrOetctwFAjZ1otrL4ERnOcVUPzOfbNriRZwq7vVJ63jBi9BN/puIzD3UjJm
	 cKdC3wEtZobGA==
Message-ID: <sashiko-outbox-213260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 14/21] perf thread: Expand context analysis
 annotations to threads and namespaces_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-15-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:59:39 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D14

