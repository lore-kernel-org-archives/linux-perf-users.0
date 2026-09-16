Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D5259C80
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539708; cv=none; b=S8rKCFvoUnxS/hRl10RcKrElZlK4fqSiIijheM4fJP9pFhn3/CRZ4wpCSli4FMAZE4aktTxgYW7Lp2UrpFk9j7JJbjZYdY4yZvyIAUX3A+mWMXDTpi/gxfnPRrpUDwi2EzHdhXDcuRF1Bu99dAa+1VIr5YlwRsBT1O5TjgHKC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539708; c=relaxed/simple;
	bh=KMCoHx1Kkq6pi10wF0av7UBFXez8OmkIZyzwgnPrVNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RGI2QPPfbm54eYjzpcUSZBRDmx0Xik8+06MChejjKWajzkDifYBe96oE/6Z0AxfE54S3av2sGo3K2lvybF++IUJ0iMMdTs7Ku7xHmVgSe3H8b9oWnCxVjxMgUKWOjFF2q3AJNg5PlPn/frNJ1qGKCmmjECXUnfQIhHV5UkaMsxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI3X3oi1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI3X3oi1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC4F1F000FF;
	Wed, 16 Sep 2026 06:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539707;
	bh=DcId8UfC4HkNVPaNTDQWix34lL9toFqzWlf/D2JE5mY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mI3X3oi1t2P3Fgrs/pp56FDHrnsDZa6xEjZiVn5Qxb3RJw6+TIwWCJ/mtU7fgWw+p
	 BZXqkX17CwA4vey0ZEoM2M/mpeVf7x3ok68RDhBDUL+jJ7I2AmWoG31GXOx5q6zdsK
	 vjqDE1+oYwJRpz6ukg0nEdwMvUNWoYUZixbsz41FETZ7XYigLXt1HKujMYnEuhrZXe
	 TovrGnsENipKj9/7Ifed4qxbiL6yFlin9zCvalPVPXs6fLNE4ph2FoXM7vfnHbxa++
	 CEO1OrqI3sUQ7wiTkXEwN0ShuD79Do7JO0OyWpmavJMrR/fv3mbZTpMvsiFwT7BsxF
	 MgJb6DMnmUK9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] perf symbol: Fix the build when demangling with
 libbfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916061218.3061216-3-irogers@google.com>
References: <20260916061218.3061216-1-irogers@google.com>
 <20260916061218.3061216-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:21:46 +0000
Message-Id: <20260916062147.4CC4F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> cxx_demangle_sym() calls bfd_demangle() with the DMGL_PARAMS and
> DMGL_ANSI flags, but nothing declares them. The
> "#define PACKAGE 'perf'", "#include <bfd.h>" and the DMGL_ definitions
> were left behind in symbol-elf.c when the demangling code moved to
> symbol.c, and libiberty's demangle.h that defines the flags isn't
> installed by every binutils package. The cplus_demangle() variant is
> missing a declaration for the same reason.
>=20
> The code is only built when the C++ ABI's __cxa_demangle() is
> unavailable, so most builds never compile it:
>=20
>   $ make BUILD_NONDISTRO=3D1 NO_DEMANGLE=3D1
>   util/symbol.c:2714: error: 'DMGL_PARAMS' undeclared
>   util/symbol.c:2714: error: 'DMGL_ANSI' undeclared
>   util/symbol.c:2716: error: implicit declaration of 'bfd_demangle'
>=20
> Move the libbfd demangling into libbfd.c, which already includes bfd.h,
> and declare in symbol.c the libiberty interfaces the cplus_demangle()
> variant needs.
>=20
> Fixes: 4d9b5146f0d9 ("perf symbol: Move demangling code out of symbol-elf=
.c")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916061218.3061=
216-1-irogers@google.com?part=3D2

