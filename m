Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D9D3EB7FE
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621320; cv=none; b=Bp6Or/9jmcv6ZlpPLVZaC8ADkgpLmNHw7Q6PjPj1IU++ioL0yoLnnxLf54t5vCuWJPL9tAQq8iLGlBLaz8B+Rl2WTMRX2heB3dvFs1dc1yWZYABJYegoZMW4hJ4D0ktCHTl/e2t/DMsZJ7A9ekBZEiyvGXBqME8ryyx5hXjW2Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621320; c=relaxed/simple;
	bh=eB71rwwu41audEIJydv2oY9NR9SXmNrF0jtIFKgU+ew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MgADJ6/52n/sLnRSW69dyaRxenNPKDzXtoMRNWarG7Az7dQwUeqTWlud6a4yj7S6qrRQP3h2mem4DgflX/W+no6qshQqggacuYimQ/9MQ/Tutnti+wMDcIj8rpHgVuXqo4lwS9OwQ3bVpTccj7ycSKu3OENptYmq+i93pQSxO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmMvUwli; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmMvUwli"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B75D1F00893;
	Thu, 17 Sep 2026 05:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789621318;
	bh=2kc23ksQfXxhNIBrpRo1VkiN3LumK43WFzm1h/Vd09k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GmMvUwliPKEqvHlILmwhYxo1ohk+9yq0zClToTf6vBfXPbq3aj3IdHrkfdWWPEfAp
	 7Z4ofiLBpe2vmNniCy6qJ5kIG2Tc2x/z2f7fYGMBmDZhnWqO6EPpoZGnH8TxhPaGKG
	 5wB82z5t+LWIYDJMByEc15o8cQ3/B8V1nz2GSKkBUsX/bkboAxlyv0w6BT5PagYNPe
	 hi2cLY5gs9IBv5cAZjo5h3ltHaqFIljOcJ96R2/E7ZhmFJvc3AV9V4wxSfClOv9PO2
	 aHvcAT3dY+qlwLl6A0NEfHd+oroY5ybDMt6dX8p2cnugCdidW6onAkYwDjDQqC8X/G
	 XsEYYp69oGR/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/11] perf config: undeclared PATH_MAX due to
 missing <limits.h> inclusion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917045326.63601-10-irogers@google.com>
References: <20260917045326.63601-1-irogers@google.com>
 <20260917045326.63601-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:01:58 +0000
Message-Id: <20260917050158.9B75D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko reported:
>=20
>   When compiling the perf tool against a strict C library such as musl
>   libc, a build failure occurs in home_perfconfig() and
>   perf_config__set_variable() due to an undeclared PATH_MAX
>   identifier.
>=20
>   The PATH_MAX macro is defined in the standard POSIX <limits.h>
>   header.  Because tools/perf/util/config.c does not explicitly
>   include this header, build environments that lack implicit header
>   inclusion fail to resolve the identifier. This causes a compiler
>   error when evaluating the size of stack-allocated path arrays,
>   stopping the build.
>=20
> Add the header file.
>=20
> Reported-by: sashiko-bot@kernel.org
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917045326.6360=
1-1-irogers@google.com?part=3D10

