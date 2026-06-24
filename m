Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34D330BB8D
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278909; cv=none; b=YngfgZkHQMR536BBwfDpzI88/vlF/OvH2znPj2wOO5cMr/5gwnemlUh9HPzilexd3Wkl/q2EO4qu1qOapsocap4JKRabF37yv/WXz0AHKjcov1RzUdfdlrnx30DO73nn2yRT8cCEj2iR3XxfSdyxPSFQZ+p+Vq3YOib+EXjKXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278909; c=relaxed/simple;
	bh=kzetOxB/0lOEM20VvJomkfLmmqlfhq8H5i8i8FmvvyY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=irvmH+VWwJR9eGQ4a7FNItVtcJ1AclQw4ZAdCcUMjvdQGzVXncfkivY2pMy6Hp8eQ/IKnYalMrmnnCdXMu4ui5Jpz23hQ1Z/XuicvGpW3VaaYBedwe+CcO9mSxKCZVnZzQsY+tN/8z+GhxqsqifRIZrQxmSaSZKxFTENEEuawE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHXpQpGs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHXpQpGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E8F1F000E9;
	Wed, 24 Jun 2026 05:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782278908;
	bh=6tV3kveKxf655kzkRkcWNn5UDR2p5fYpQEQnNu5cKCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LHXpQpGsQMtKWaIuLwzoBqeQ7EMawm8bNUDrsWIhC7aRs97uMeg9dQQwscELlyOs3
	 612Qx2wOh6tRk+AGs/3HWrKgxhC7WwI04ItdIgMQet0eH0RSM07yz+fcoyJyMFqo/u
	 m1Cbm/BPYHk6LYpT5vB9ZzKQ5Is9NFeroaAXJQDNffDyR1KJYUuC8b/ZQ+7dW0bvWg
	 ZujzdpFXEy+7OrbEcNgtmeJBmbV7PoZliBBWZ4+b1+Af8dU0HGAIKEF6E7T/AbE6pF
	 DEWm/LvOaMX5oN1aF6TTLWu79PzSiBFTiqLgUe70sLUxYBQFAe9vciG7Y9Sb0C1f47
	 kUPjhcAF+Vlxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/16] perf test: Fix skiplist leak in cmd_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260624051535.3584977-9-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260624051535.3584977-1-irogers@google.com>
 <20260624051535.3584977-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 05:28:27 +0000
Message-Id: <20260624052828.30E8F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unsafe error handling: `errno` may be clobbered by cleanup funct=
ions before being evaluated.
--

commit c1a33a510193529b900f698c55a9892c973edeb2
Author: Ian Rogers <irogers@google.com>

perf test: Fix skiplist leak in cmd_test

This commit fixes a memory leak in cmd_test() by ensuring the skiplist is
properly freed on the exit paths.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 7e75f590f225e..cf5625cf4f110 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c

[ ... ]

> @@ -1781,9 +1781,12 @@ int cmd_test(int argc, const char **argv)
>  	rlimit__bump_memlock();
> =20
>  	suites =3D build_suites();
> -	if (!suites)
> +	if (!suites) {
> +		intlist__delete(skiplist);
>  		return errno ? -errno : -ENOMEM;

[Severity: Medium]
Could the call to intlist__delete() clobber errno before it is evaluated in
the return statement?=20

intlist__delete() cascades to rblist__delete(), which ultimately issues
free() calls. On some libc implementations or under memory sanitizers, free=
()
and related cleanup functions do not guarantee that errno is preserved. This
could result in returning an incorrect error code from build_suites().

> +	}
>  	ret =3D __cmd_test(suites, argc, argv, skiplist);
>  	free(suites);
> +	intlist__delete(skiplist);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624051535.3584=
977-1-irogers@google.com?part=3D7
