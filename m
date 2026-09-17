Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5CE3C2785
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621160; cv=none; b=Xw9MpjEah19Bvxt8RxvdAw9z3NMQ2Fszmf00Z3b8tyFPZF+QcUs7CvJ1Xz4pfZA2N8CWmvJoURlRpxZLczGGD1suw3wKqtYgWemzYhp1Em4Ct637ETO3hPWF5wuCNjjdhNNqC3zeAbWrwTYqPfwtixu3qUZlq176iN0f1/2wv4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621160; c=relaxed/simple;
	bh=6RJrGwx0lrVDV03QEUtw3BuYxTuDE43uGUuwxus9RoM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IKPmhFhNQV9ySEQAL/4aL40CwxAt2+8cMYIALbyCPEhOqvfVCFz3ZLPxbJyIx9oYNMkFhCSlAslieg0im2gyPA7lj+Lmww5PrL+wzGE+6vZOWx/P5rRnD1kb8vqiIKbSiUtGRrQeVvDb0C3CZ6I0Y9BCVb9adIhFkEBhmboRoNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsGSv2TV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsGSv2TV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A05B1F000FF;
	Thu, 17 Sep 2026 04:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789621158;
	bh=Z0+JUyNoo+4QEPODnKIcAH5dAtdDvoyS7SwntaLMrmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lsGSv2TVA4RcDOCHtJTK/vLeGOS+b8/MOaEyKVqQM1yFpq4q6UIZ4fEoSYxa7BO0m
	 C883HZlgjUeZq6396kBzCHw2NdXFr8JPrhKamAQTtVdPp8TC/namB32Fwtrj99gClq
	 ohfVAQTjmVcciITmK9sSENrYMhtc+1ce8Xf1RuO40JuynuaVktYi0dnV0MSiqNpmA1
	 JEDrM+c+/5/5aF5GtsZKRFCYDGWgd4+fdnfjteLB5rtT7I1J1cUiPK2Xife0drPiAr
	 PDAn4PB2zJG9LWefetwH39+LyCsv/2Cd9nr/+DKHNhetgN2OO2p7JKVmSz6ngk2B12
	 s2DLkQCpnOwlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/11] perf unwind-libdw: missing <stdlib.h> in
 libdw_set_initial_registers()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917045326.63601-3-irogers@google.com>
References: <20260917045326.63601-1-irogers@google.com>
 <20260917045326.63601-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:59:18 +0000
Message-Id: <20260917045918.6A05B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko reported:
>=20
>   When building the perf tool against strict C standard libraries
>   (such as musl libc), compilation fails in
>   tools/perf/util/unwind-libdw.c due to implicit declarations of
>   memory allocation functions.
>=20
>   The libdw_set_initial_registers() function dynamically allocates an
>   array of DWARF registers using calloc() and subsequently releases it
>   with free().  However, the source file lacks an explicit #include
>   <stdlib.h>. On build environments where standard headers do not
>   implicitly chain-include <stdlib.h>, these functions remain
>   undeclared, resulting in fatal implicit function declaration errors
>   that break the build.
>=20
> Add the header files and use git clang-format to sort.
>=20
> Reported-by: sashiko-bot@kernel.org
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917045326.6360=
1-1-irogers@google.com?part=3D3

