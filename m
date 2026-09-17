Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD493CF685
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621138; cv=none; b=YAlm1Q5YgmfuUeuQPu58dlz+fAOBPT4QCidSiA3y+ZTDnCezGPn6uYkkLAT+Le4dwOf2Dd1qf9LTbxKLiA50IAeD47b2I2T7AJNETp2dA4OZfEjuZb4hHeOva9KO8apAG/k8YpwCF08xZ2GloKMCCwgKOrKGlKnbD82lqH/+eAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621138; c=relaxed/simple;
	bh=NmNotBnIJefMEB4UXrMtuMy7MjH1sb4iFGyeCD3Ndxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IR+0O1lzNrT7lpdx+t6j5AM/Cx5r5bfP3aF91hC0eaWduaQU9i/E2hk5uwgCWWC7jYaMy70zt1HmwL8wyGMuTYbyljcKtG8uIjiPzq38hZwMhJcg/t+y3k+r8GRaR5OjDliShUgnXn3vnEKDxMVFMc6boudL5xDnMK3FCCEYvkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tw7BwQkJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tw7BwQkJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E790C1F000FF;
	Thu, 17 Sep 2026 04:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789621137;
	bh=CTJIGO+Owgm8QNQYcQ/ljSb5Vdh4W/+d3ACwrki4BI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tw7BwQkJpBcESLRKREgrczkNTBoGsQjx1Mq3BO+7s0mvFs4+jqghglYo9xK1l5fZV
	 OUxio+eTXyBKImrBDLoP9Et5gNecPMtK35Aj3wdPEkVc6vLpSvu80LF7AIKGqGFw/X
	 YOz8XzkWKDcBuXuf7kRvpWK0gfVgcrPEz2zVmxEjEsh32VTSrF4bM2GVyzarnzUnmz
	 au4hf7olqzviNbvTlXU7Ti5wqXZE21YEmzNP5+9v7zscX1P6wH2rnXtPKGR/RZc9+s
	 dv99onM2m5eevKg0gixo21gdglFrmebWAnwwr1dpF9H97Uc5WOdSJtkgC4qGTM3uEW
	 gSja9fBWdLM0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/11] perf test: missing stdio.h and signal.h
 inclusions in cmd_test()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917045326.63601-6-irogers@google.com>
References: <20260917045326.63601-1-irogers@google.com>
 <20260917045326.63601-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:58:56 +0000
Message-Id: <20260917045856.E790C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko reported:
>=20
>   When compiling the perf tool against musl libc, the build fails in
>   tools/perf/tests/builtin-test.c due to missing explicit inclusions
>   of <stdio.h> and <signal.h>.
>=20
>   The file relies on standard I/O functions like fdopen() and
>   fprintf(), as well as signal handling constructs like signal(),
>   SIGINT, and SIGTERM within __cmd_test() and related helpers. While
>   glibc may implicitly pull in these definitions through other
>   standard headers such as <stdlib.h> or <unistd.h>, musl libc
>   strictly enforces POSIX namespace separation and avoids implicit
>   header inclusion. Because the required headers are absent, the
>   compiler cannot resolve these standard library types and macros,
>   resulting in a direct compilation failure on musl-based systems.
>=20
> Add the header files and use git clang-format to sort.
>=20
> Reported-by: sashiko-bot@kernel.org
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917045326.6360=
1-1-irogers@google.com?part=3D6

