Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F493259C80
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539492; cv=none; b=cIROCA4YeAZQJppZoVg7ymzHoTC5qvjKudsQjyUiwty1zzlE1RRsXm/fY+ePjT0CbTXHHFDF+MFPshcHZUxJIFco3f9XJxYymqej4UZrDQPaw2bBr6tGiXvZ19vm9udOZkWtZi55TlXp96e81H9GV2gQOu6V/YnS1MDtLKCVeIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539492; c=relaxed/simple;
	bh=THpdSxCkxABdCg1H7PdmqxYCE9W+FxShVL0KCncYzjU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ofMVDbqiUnpDhG8X9Sna5l4fGKEFLfegO3qqV4ONJWY3O/u6xSno3PhdlToDf+N8be2dlYt1gyEpBM1DLYz8G7plGfFlI5ZEILcr91LNrEjYCXjfQ9yvz09CqTOautc8p7/vHMHLmNvxRu1RSFiDrMfsIFYAnGvqDMGjHrNF8sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBXDDBVz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBXDDBVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C080C1F000FF;
	Wed, 16 Sep 2026 06:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539490;
	bh=YqGzQ3Pt1RerikLnwdVpa87c7CFxQPSfMSYys6jL7vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JBXDDBVzbnAKQYde/rPvvDbDyPSRgC7mps27GdcQDdRqSSCV003ly18l8a3+QizI2
	 uSa/UJZwmam9WYXVvgEaTZ0cQ7M8XeAtP3qB9yA6RYuKrG6M2mBXMEzzu6KUdiuIfr
	 FqNoJAwicGbuS4Iyzp1XfvEm8QJUw6amqRnE1i5E+x99ijeG9AYioN5z00dycgoc80
	 KhS1gzDJZC4lOZ5nLiUqED3f/k5hd3yN0+h8J2STUHM6Z9Ewz8ImjfoEUuhSVmxTsq
	 brFQSe18p0bCXigqrg84/zclLy2lwz4YGiW7aHTKxJ4ZwpryVky8v/lV+Yd2r6ghQk
	 B4Y3MB2PEpK0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] perf libbfd: Fix the clang -Wthread-safety build
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916061218.3061216-2-irogers@google.com>
References: <20260916061218.3061216-1-irogers@google.com>
 <20260916061218.3061216-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:18:10 +0000
Message-Id: <20260916061810.C080C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf_bfd_lock() and perf_bfd_unlock() are the callbacks given to
> bfd_thread_init(), so by design they acquire and release the lock on
> libbfd's behalf and the lock state differs between entry and exit.
> clang's thread safety analysis, which perf builds with as an error,
> flags both:
>=20
>   util/libbfd.c:56:1: error: mutex 'bfd_mutex' is still held at the end o=
f function [-Werror,-Wthread-safety-analysis]
>   util/libbfd.c:60:2: error: releasing mutex 'bfd_mutex' that was not hel=
d [-Werror,-Wthread-safety-analysis]
>=20
> Mark both functions NO_THREAD_SAFETY_ANALYSIS so that libbfd.c compiles
> with "make CC=3Dclang BUILD_NONDISTRO=3D1".
>=20
> Fixes: b72b8132d8fd ("perf libbfd: Ensure libbfd is initialized prior to =
use")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916061218.3061=
216-1-irogers@google.com?part=3D1

