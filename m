Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC8403AE6
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341844; cv=none; b=ijc1BiIJPJ5Lnj5angZt3+xQT8moKLavp3+er531lYWQ6Y4dlit/JnHdfVKTWf3rpfauyszeE6Qt6gYlBYEfHg5npy4r2FtkSrB+dAq2oA1Qbhm/c3LGnojDgZ6RZMb5//cD+1TSwCddSqgxEqkFsBWcAtvkbakp/rdRgPUVSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341844; c=relaxed/simple;
	bh=SdlX0BV6jjULalGslkVbXHdfC4bqloMyr7G3rVoCZfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d9kBe2Mq9tW23jg7f+9BKAJDsMtqPLYwOZe+N+beRl5t9lkQNwSjs2dMtNw/iOkNts6moadyjci/gw5qoqsqa1OpaGm2TDRT6rfgfbF/D1v33ELjYhX4nol1sSK7HE2pFUwLJcQUimfSv/q36Yix02Jw6LAESEuTJeMjzNfK1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG9kOnp2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG9kOnp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A531F000E9;
	Wed,  2 Sep 2026 09:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788341839;
	bh=F6rCvI5hhF5G4IbuqDPTR6YPfWLRApT4XktgIslKqaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TG9kOnp2M01Sk4JIcBAGBbAvTrm2PFiN/o8i6PfTiL1TxzKJfeBFUcqDQIPB988dv
	 YVF8lQf8jcgOFY/ZdVn4I+HKPP//thkHylmNMjctpIrFPh5TVFQJyaeslvFKv9385D
	 aAbMOyVvW0CvF91Ns3N3HfmGIYMbX+0tim79PljOyKrmwsAKnuQBPuQjQdStMucYNg
	 +IoEwP4mTvpbezhfhIYkSxrNCBOB5SEkQ3JuW9LpukTJLOKjRFg49TkAPnNOl8UqFS
	 DmGMaCLKZnmRpww/ubHrywAhlZKUkmw0O5vEE7JYRAgg2Und54aXFc8eaaSoWhf+GW
	 cUJv2k9jDWXRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf bench futex: Define SYS_futex on 32-bit arches
 with 64-bit time_t
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nylon Chen" <nylon.chen@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260902093210.3571958-1-nylon.chen@sifive.com>
References: <20260902093210.3571958-1-nylon.chen@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 09:37:18 +0000
Message-Id: <20260902093719.B8A531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The kernel does not provide sys_futex() on 32-bit architectures that lack
> a 32-bit time representation, such as riscv32. Consequently glibc does not
> define SYS_futex there, only SYS_futex_time64, and perf bench's futex
> benchmarks fail to build:
>=20
>   bench/futex.h: In function 'futex_syscall':
>   bench/futex.h:77:18: error: 'SYS_futex' undeclared (first use in this f=
unction)
>=20
> Define SYS_futex as SYS_futex_time64 when only the latter is available.
> The guard and its comment are taken verbatim from
> tools/testing/selftests/futex/include/futextest.h, where they were added =
by
> commit 04850819c65c ("selftests/futex: Define SYS_futex on 32-bit
> architectures with 64-bit time_t"), keeping the two futex userspace heade=
rs
> in sync.
>=20
> [ ... ]
> which is unavailable on older distributions. This change deliberately
> avoids that dependency and adds only the one guard needed to fix
> compilation.
>=20
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902093210.3571=
958-1-nylon.chen@sifive.com?part=3D1

