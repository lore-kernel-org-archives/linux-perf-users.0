Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591014;
	b=R6LFjYL18bEzth7139mr7/e7J1MADbhVo8ThPz2frM6McNYPqwZO8OeGc5hbbXe/4wR0
	 mzIxKMKLJqJZHnrZDNcR3YvSuTc0WTYGF/zMQyUqQ2tI/XywFApRa+HToXeIr2HHlImOW
	 4ILGrsgU/Zn0IdilA3LuH11sNDjeWdB8YiWi6tcCulzs7GGo2rxIW2ci9/r8JuetPkJu0
	 zfVKPn9S35oXmpsnIVCI95zbN6AbMznZmTcvFBvV5KkL5HKYVn6YoAVUiMz4qXtrjmgRP
	 pkAX46Ct1zAOlcAMz2y7EDsKwu/vOQsdGxKymHifdAySenjIf9FgrKl8WoLRno7KxMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591014;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Pte760Dcws1QYw3wKQloZlKpbjXEcfgsAi8jBAM/B6E=;
	b=fYf1EnhU2Xxc4vSEVsk9TrAr5lE27uEPtHLQix/E2MWKqrxK0lu1am+x6xZc5Lpx5Ylv
	 /JXgqrEnEFCMWJoQh2XpDAy+a0SGVTHqPEtgP07lUwWDLqHkeDu+wF3t+gBfaMaVZGLED
	 00jCUW6Ms/43/lWu4e2coXKDjmGNXd6fHL3ux4Ka1LlRHqrJoX6pxKc+vbveMpjN5Xgvc
	 IOu56uJ5rzqCEAv2q5RKK/1WTsWsSBN9yN0NOZXvB+sjR1Nkjzi9k+D6BEN5fWDl3EC0C
	 Lk50kYhgAUapefEhuSEH8woBobthZONXlPCc2ksPcaV3R7bZxb1tQzqdFbqygO/5eEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QPlBk9sJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6586070F1A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QPlBk9sJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED83C1F000C4;
	Fri, 13 Nov 2026 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591014;
	bh=Pte760Dcws1QYw3wKQloZlKpbjXEcfgsAi8jBAM/B6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QPlBk9sJIu8VDS8RMbi0FgbSxu/WE8okU1imqRWGOPqSTq5oSxv35c9IfN8DtH0BX
	 wb6+0hjbCGQH8ygSInWTYwvAw+8KN7DSgM+hdut4ipb5lAaTQGt9QcRuueY9alNT4n
	 unP3E+0x0bJcUpprebpeRj5CLvYPYb8gN4zx5+s34aaBuLQjlZ87KdV+ukVchhhvcl
	 ocSHt2yxmsyexJmDysblAcoCswOCFSJP6ys2kP0kzSkg3Njdo6tn7CB+4dGyBRp+of
	 j/fHZ7psqMWwsSCH6q3ufZsmhIknzC8ngCWMXBBK1MLzDbjr1CQV5iUL2qvuksSTt6
	 mzJ/yzKpCkOGg==
Message-ID: <sashiko-outbox-213310@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/23] perf bench internals: Add maps benchmark
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-14-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:30:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a 'perf bench internals maps' subcommand to measure map insertion,
> sorting, and lookup operations directly:
>=20
> 1. Inserts non-overlapping maps in ascending address order (simulating
>    /proc/<pid>/maps synthesis) and queries each map by address.
> 2. Incrementally appends maps at interior addresses (simulating runtime
>    PERF_RECORD_MMAP2 / JIT events) and immediately queries each map by
>    address and by name.
>=20
> Example output:
>=20
>   $ perf bench internals maps
>   # Running 'internals/maps' benchmark:
>     Average ascending insert + lookup: 145.870 usec (+- 14.628 usec)
>     Average append + lookup: 17405.810 usec (+- 1773.195 usec)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D13

