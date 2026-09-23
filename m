Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BABF4766B3
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200793; cv=none; b=UFHFE2UyR0XBmZ5Y8yMYuIY3hm/awCEmchPyHCJnvt4AcBsr0zom6kqdJCp7z9a5fMmMuFUnnuZezTLZEff0ttbw9F2hB1HSYH8PldY6uDP/A7kM1+LkJBpw9bc56zz9iyRET/2I32oy7wgcq4bzt4AHme6/9S7FMxDSgyIpGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200793; c=relaxed/simple;
	bh=GrMDAZrehxTJHjxF5c4MOvpxS9RcChdclC76jxfWqzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hEIluc0CUI8l91iCymoEU8CtCG868qUU/S2IcjGRauQdGPxORbol1ysLaCxaGI7JEA2mKAz9Ayn2vgtc0EwDzN7Q0EixbE3IgGg6rMR0jzUhSJW1igH5ToBpiUAM4theTWjDW+w9sO06NjDXC4HdhZpGtE4ENAcpTe6P+HdSc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeCEocax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeCEocax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315201F000FF;
	Wed, 23 Sep 2026 21:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790200792;
	bh=AkNltAvRAimlek2ET9Ao4X3XhcyL/F7TAITM1g8mSTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oeCEocaxyj8isGjO6ZiCF36IQCQ8y3o2a/vnNWr9oXxSNHLAqcxmgwUOVmhTOrHFO
	 F3/WJBJC+KICFAFV2e/WuLQB2CtVq1agSbRHYAkm2BaJq0+K3aPFwgxxPN7oAqyx1D
	 AFJZPb+opM0Q+zPqFtJzTqZW0lQV65y7mjsVtMfn0of8K6Ij8XholxM2XlH2wWWZRB
	 ScZ8BAO7+0F3jSaCZJQxAMbaaLfTaqIjDQGcd7nzrQW3QtnNPWgW5K1wZOEO63+hz8
	 8sqJ0BNh6vmQp/UttA8tmNDKVCntyBZOM6rx3tk4x1dLRSMCA1qX9BQMJH9ZSzqHsS
	 6A4Igf5zV40jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf test: Fix record tests on hybrid machines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923215255.3329181-3-namhyung@kernel.org>
References: <20260923215255.3329181-1-namhyung@kernel.org>
 <20260923215255.3329181-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 21:59:51 +0000
Message-Id: <20260923215952.315201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently the leader sampling test looks for "cycles:" string to match
> the event and retrieve the value before the event name.  But it won't
> work on hybrid systems as the event name is different like below.
>=20
>   $ perf script | grep -m 10 brstack
>       perf 3322152 1873980.978431:     625379 cpu_atom/cycles/:      5582=
00cc40cf brstack_bench+0x31 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.978431:     625379 cpu_atom/cycles/:      5582=
00cc40cf brstack_bench+0x31 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.978598:     612177 cpu_atom/cycles/:      5582=
00cc4082 brstack_foo+0x17 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.978598:     612177 cpu_atom/cycles/:      5582=
00cc4082 brstack_foo+0x17 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.978762:     591859 cpu_atom/cycles/:      5582=
00cc403d brstack_bar+0x0 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.978762:     591859 cpu_atom/cycles/:      5582=
00cc403d brstack_bar+0x0 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.978948:     628505 cpu_atom/cycles/:      5582=
00cc403e brstack_bar+0x1 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.978948:     628505 cpu_atom/cycles/:      5582=
00cc403e brstack_bar+0x1 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.979146:     669816 cpu_atom/cycles/:      5582=
00cc40e5 brstack_bench+0x47 (/home/namhyung/project/linux/tools/perf/perf)
>       perf 3322152 1873980.979146:     669816 cpu_atom/cycles/:      5582=
00cc40e5 brstack_bench+0x47 (/home/namhyung/project/linux/tools/perf/perf)
> [ ... ]
>       628505      558200cc403e brstack_bar
>       669816      558200cc40e5 brstack_bench
>       669816      558200cc40e5 brstack_bench
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923215255.3329=
181-1-namhyung@kernel.org?part=3D3

