Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC7F486E4D
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639456; cv=none; b=D5o3l1rU7A7gt4nMcNieBLy3EAFczo6N4jC82XDDLyx2IKHRGjSeHqhW6gR+3SWwlKn35lanw1vzWsILkUfl3+Ht6Pl3jZBnQluxCV1kIHw6Thd9tdYZ1UsBA2eAHcclHHgyxCr8rl6cyIEaKRAGB8mPCGdaMgNsMMXP2esd5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639456; c=relaxed/simple;
	bh=7nKDucBzAgFqDbBgb1MO9u7dnpPtbzntsDjZr0ykRec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gR+fbOBk4UnkczBl0eebNmVW3MHl1hBdtZcgZdj2IoplidTiwhC45Rstq4yfuCkqWqg6oQ/D9MuUDsWDgaVgjqhNzdqrVO0NAD7n0HSY4LRkvpFgaSonFD/JdhD+gga6eibJE4+uqxLg1+n2N+Pkx5tDZTLiz9eoD2dm2zJOO9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz5kU3XR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz5kU3XR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923E01F00893;
	Thu, 17 Sep 2026 10:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789639441;
	bh=4f2Na45C6qNLb4x55e8WWE7XXVWIveuhS7IxJI3ZLCQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gz5kU3XR9ZgeRmkiJCS1UMXgP1PPq18Wp7P2QPpStkJRGgnImLdEICLfxoHiFtjJX
	 5DlWUQkckd9kAWPdd2kiO+aMq5x+1paOw3q1HzWaCQ8R2yZEzWsiB8KZYU4vyf8S7A
	 dcKHvPQZOMnWmYVXtOGZiKD150U3829Hr7vcLjWIJ2rJrEwELLFZ0xDEFrAc1irIZ8
	 skIg/KtxpAruzUkyjD8jHFd8uBVNLIlXsXEu564U+Fmks3ekrI3LG2MBgHB4LGn/Ve
	 NKdmKGpAtF3ld9zfUZoUwa9vhK09WPFSoAcEJ03a6vIv/fyBKaltbuq9rptdLerrXQ
	 miDn5J2gMnSkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf jevents: Limit the number of JSON reading workers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917095921.2802275-1-sandipan.das@amd.com>
References: <20260917095921.2802275-1-sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:04:01 +0000
Message-Id: <20260917100401.923E01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The ProcessPoolExecutor is created without max_workers, so
> concurrent.futures defaults to one worker per CPU and forks all of them
> when the first task is submitted. Each worker costs the parent a few
> file descriptors. For systems with high core-count processors like the
> AMD EPYC 9996, the pool can easily exhaust RLIMIT_NOFILE as seen below.
>=20
>   File ".../multiprocessing/popen_fork.py", line 65, in _launch
>     child_r, parent_w =3D os.pipe()
>   OSError: [Errno 24] Too many open files
>=20
> The error is reported, but jevents.py does not exit. The workers that
> did start stay blocked waiting for work and are never joined, so the
> build eventually hangs. Other targets keep building in the meantime,
> leaving the traceback several lines above the point where the build
> stalls.
>=20
> Limit the pool instead of sizing it against the descriptor limit, which
> would mean relying on how many descriptors concurrent.futures needs for
> each worker. At least for recent AMD EPYC processors, reading the JSON
> files does not need many workers to be fast and things typically stop
> scaling beyond 32 workers. Hence, a small upper bound keeps the speedup
> and stays well inside any usable limit.
>=20
> Fixes: eaab2eb09dc2 ("perf pmu-events: Parallelize JSON and metric pre-co=
mputation in jevents.py")
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917095921.2802=
275-1-sandipan.das@amd.com?part=3D1

