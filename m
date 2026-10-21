Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616546;
	b=lPgN89emQwqbGaeJKAEhVvfaP3sABk55zofbanuCAMt9SelR+QbKsCa/6LhSX5ReJAi6
	 3rUrUncq5qlZjhcBYYaBaUB3cbxiyQL0bkLW4OFqu7SjOAYfK/7ZRzLRDDZ39sh8sMT4H
	 p/K7LTbgy3Qb9yUfwVDfCig7cnF5Jll0GefAfws3sGjSfK7fbcVCXtojIGxzaOAe8CpMc
	 M79VkthMW/22ggqos8rdkvKCzquxkHXvVmYxXn2uTBJh3iqjQEi69Php7+Zw9B3sEsRXY
	 Fgq8TiBzy/ZZR5DR+UGjyVlyaFRjMDqy88wbbvavRYyfxHlWcyqQ0Vr5AZ+jfuUs3pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616546;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mwj6LHFfUlA8TeeG9iF7yKmGijO2Q6gkyoN6ioQwIpU=;
	b=okhoFZ4Qq0CR1fR59WXU8s5zvxZshY1F4yIAhdupog9/epY7NHtNI6msZY9OVNL+P1YW
	 PjzztwiacrVoITsrgRic9daeFNuT2CTWBe2DVRpAom3wzO40PUmgCyGtPLC8+QpovaT0S
	 NQi+xvMX2WUl023SqmN3b7/CBsXxAwN4XDcKyLilbJ5sS+Crq+xabecFS2k/WoXnxS/Fj
	 fW90kXhcmy5llEnpFqF1U2pBmM66aUy4tUimea1Us3T2QfeteZtsvhHZJyEGdwR5FHbfy
	 HnWllmLFE8PKYM0IiQj59NSbnXC31s12IiAromIwwy/yjwG5mU0StLZXYoBaEM+a0Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXwdH1Or;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BF606A31D
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXwdH1Or
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345941F000C5;
	Wed, 21 Oct 2026 21:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792616545;
	bh=Mwj6LHFfUlA8TeeG9iF7yKmGijO2Q6gkyoN6ioQwIpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eXwdH1OrllSh2erfLKDFhpop0qvVR1pz6YQv/cdZpToUbrPzXSQqJLa+07iDi+25R
	 FcQGHiqbqmNmedNbwCKIa9jzcieuJ31w/HFg33cIe9gRGdslWDjEk30motelunAM0T
	 J9jIjsGcBmjEgZa/y+hmUwU8YzgzV03FNz7ZFGZlMbBeYzsyFpftpFmPrIiyed5Ycw
	 j0O13uEDP6NB+NsQlf4Le+gHJx30xDmXsOl/JbBrbsPDD0zCKT6RV9KD9ebGVq2j3b
	 WrivKjYsNWrwa5Dhv77TbJAJ+l3a4xGLAER5H6ZDMh3uf1g8SkmLooWN6nNhaW+vTq
	 c32YGRhuPppAQ==
Message-ID: <sashiko-outbox-180681@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 1/2] kselftest: convert prefix.pl to Python
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021205506.26736-2-breno3011alves@gmail.com>
References: <20261018134322.26445-1-breno3011alves@gmail.com>
 <20261021205506.26736-1-breno3011alves@gmail.com>
 <20261021205506.26736-2-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 21:02:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Faithful re-implementation of tools/testing/selftests/kselftest/
> prefix.pl in Python 3 (stdlib only). Same unbuffered stdin-to-stdout
> processing, same "# " prefix behavior.
>=20
> Update runner.sh to invoke prefix.py instead of prefix.pl, update
> the install target to install prefix.py, and remove the old
> prefix.pl.
>=20
> Verified byte-for-byte identical to the Perl version.
>=20
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021205506.2673=
6-1-breno3011alves@gmail.com?part=3D1

