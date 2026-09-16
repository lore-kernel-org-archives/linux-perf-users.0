Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F837269C
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539445; cv=none; b=hsgtiIney6J3OFs5ENAPN9wIClGF2fwGh0KcmWFsjk9ITrbkF2Ut1U3VlVv2rmUFGq9eVcfH49sXVUN3WSKnlfkMFjoQW0bOb2rKvjnbT1Mm/VeveQVMS0+i4QIJdglRh0270OX0ltxCJIG41UKoBegr/TCsZjbWkJcV5cdDL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539445; c=relaxed/simple;
	bh=yH3FIimyKycC0IiJedUuOj6bhzbb0y+OzugD2Ng4HHA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sfRSb4rYUweO4xs+fmd085R5VkNX9Q8aSgOxwGlGXRg32NBDuRv9+4gn0oD6p4Ja9uCTrOoE7fhv85daWswxBzDgcWWgpgOKqSEz5vXp0udq9onsf3HlE7nnTqsIeRmZClVA+yi0OvcP/dTVyAG72bmbb1gL6iuayEm08WXTRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ufot0vMo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ufot0vMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419A91F000FF;
	Wed, 16 Sep 2026 06:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539444;
	bh=BRvYl+QiRxZoTDmCx9Z3mlu1oAhqqxKnrnwmgi4MukM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ufot0vMotuDUJG19Nuv3mLyDrfmhWnvfpM7NYDddjXB4+jWkIpmXMkfexu6gROAvW
	 j9I+6d92X2X520l4fH2p4fZhrSNT2EUqndyC7B9bAm9YmFqYg9xVCdPAlwzo463DAV
	 mEFlJIVflQ759ZHcUbz/jp3oYEtj3M0pVtjmLuWsz/oPVELPuuJsosA8shJdJP3Fro
	 kZYznkegkYGcrtA3iwAgquRdocMrxvdkMpCG5ia+kEDpWrxCHPYTSzX2NxDZhjIQro
	 YSJzQUKJq6AkI6P6jsJ+vp0jGrnn1djR+5TrrU7bKUL9Ca+QKQSVDinm4dCq4RIw+P
	 jgNG/grg74etA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] perf build: Only pass clang flags to CXX when CXX
 is clang
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916061218.3061216-6-irogers@google.com>
References: <20260916061218.3061216-1-irogers@google.com>
 <20260916061218.3061216-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:17:23 +0000
Message-Id: <20260916061724.419A91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Building with "make CC=3Dclang" appends clang's --target=3D and
> -fintegrated-as to CXX, but CXX is only set to clang++ by "make LLVM=3D1".
> With just CC=3Dclang, CXX is still g++ and every C++ feature test dies:
>=20
>   g++: error: unrecognized command-line option '--target=3D...'
>   g++: error: unrecognized command-line option '-fintegrated-as'
>=20
> The failures are silent, as feature tests are allowed to fail, so the
> build quietly loses libllvm and C++ demangling support:
>=20
>   $ make CC=3Dclang && grep LIBLLVM .config-detected
>   (nothing, whereas a gcc build reports CONFIG_LIBLLVM=3Dy)
>=20
> The block is entered when CC_NO_CLANG says CC is clang, which says
> nothing about CXX. Probe CXX the same way tools/scripts/Makefile.include
> probes CC, and only add the flags when CXX really is clang++.
>=20
> Mixing a clang-built C with a g++-built C++ is fine here, the C++ code
> is linked with -lstdc++ already.
>=20
> Fixes: 4772e66cb45e ("perf build: Support build with clang")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916061218.3061=
216-1-irogers@google.com?part=3D5

