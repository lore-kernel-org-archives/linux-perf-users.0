Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591671;
	b=ZLFADB9WD1ER8k4V5OAL0mQIhfzZkIRtt/c1Y2Ly3lETGydGf37UGIW2Uxcmsz0HTE0B
	 AEjFoGyZlKcwp+xE70F6bWSCbeLLBGTvRWqmGbMFmY7dvJTS4FV3MJo9pJLtIfU2/mBR3
	 V8kilfOHQUGEdblsQIgF2FosqDhbZb5OsBK+hWjMWPDFRRw70TVydxTnjGHC92SzvG+W+
	 qKSj3cvRofYKLUoHPI5c0LF0txZPSxVGt9YVvMXEGKpmBRNOLpLiEfv5DfyFE7PFpsNde
	 0epiVdVLW5IFusXVvNLTYlb+f++ZZkEo5r6rzxblGDAYp3hzrUUggtQTauTMAwW0u3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591671;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DO6mUK8cNwRWQL2AjNwZijRna6N5p3MIiyke2BN5yZE=;
	b=RtjT65nJVOgB0UKjKQHVvg1I3ZHxTy4aSGfeG5YcJ8peGGh/2z01rSRvMkDuHtq67U2/
	 hGiRLbfsm2UDGMrx74nwSRMUEXmDbngFlDNRcP3MkeNukYoeSMFvwF771NF+24uXb0msn
	 lwAV2/e7W3KyutG7PNxdtgvTk6aa9k6IHgpvTxYjGi/FGn/P98v8fzsmWykHNn5y0HWa6
	 PrHq1iJGHgpq9o/t4lF8hZF/IA221f217oiJHT+AkVpYcnysMcvrvWmQQxshRLqLiMdtG
	 5yRwag6wNFMc32IRSpA9S39ZaDTq06woP/URNM2m4TU1w/qFU1brtEqmJg3hm/rtRzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEeEco+z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE2160703DC
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEeEco+z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECEE1F000C4;
	Fri, 13 Nov 2026 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591671;
	bh=DO6mUK8cNwRWQL2AjNwZijRna6N5p3MIiyke2BN5yZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TEeEco+zbzdSZAOCTUa11mnW7DSLFmEO6oySJ1TObi/uTIF/3N8clWmjY5okcL76X
	 ZAOEzn5uZ/yeXl49LxQZOzo3uuQf7qmSV/CuaQAguK62a7TQQ03xI6sQ0TBoO4i0Ao
	 bdepew7iwAPJL6+dDdpUv4at8eGHKjFp27P6MStzuQO2Emu3APKOUmcKffUwrRPVsY
	 7kyVFkhvVAbKAOV69cuG+r/tgIOiWog8+SJlPGt7vduY4qxGJytZBbNPwQlbv8toAt
	 ZE88A49bZAoOR/EYkk7Wg9nZjg91qADQSrEJVQqDpxVl80Z59+26nG8wazW7sIqCZ8
	 LG1xmGR3HuArg==
Message-ID: <sashiko-outbox-213339@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/23] perf tools: Remove perf_singlethreaded
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-4-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:41:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_singlethreaded bypassed pthread_rwlock operations in struct
> rw_semaphore by default unless callers manually toggled
> perf_set_multithreaded(). Because uncontended pthread_rwlock operations
> in userspace are cheap, keeping a global single-threaded bypass flag is
> unnecessary and prevents rw_semaphore trylock operations from detecting
> locks already held on the current call stack during OOM shrinking.
>=20
> Remove perf_singlethreaded, perf_set_singlethreaded(), and
> perf_set_multithreaded() so rw_semaphore always uses pthread_rwlock_t
> (or struct mutex when RWS_ERRORCHECK is enabled), and guard di_cache in
> util/annotate.c with a mutex instead of asserting perf_singlethreaded.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D3

