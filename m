Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815AF3B71D2
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539476; cv=none; b=unxWLGcO1+WGFAHtZuUKRcpbDRYPlVDmZiOY/bOs46g0RCw2BNdXVgOc1gZPpGOHqZ8oTwzKXidk/Bd7KgmPDI++WOG1n4ZEjX3AKaDj7/uHYgeQAohpphIdGIQ44QXhrfiWNemrAd2lBn/U5j7FNtbdOUQUPnaTuZAi//3th48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539476; c=relaxed/simple;
	bh=CcJSYoYaoiGxfFiRbQv6IlLUjTdgpJZBiLjG8v0g6XE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DgQEHhqQy5NFxzzfOy5r8BAmPWQ2iie45G/KT2UAP9hlU2U5vQIlDoKSItMnL/NxOev6PP0NkVoYV77GViDW95yYPgqkjEAd8ScIo5dl4RtYucV88AiCqkAv7EE2DbiNIFZIHJclBQColqTXY7ZQt5FU0AbrnPnXRZTpBWaPRks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFPp4aOK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFPp4aOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7EF1F000FF;
	Wed, 16 Sep 2026 06:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539475;
	bh=P9WS5X0TJ67SY7d+ad5e2d9ZEGrM/3WZ2lZdfxcGy58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eFPp4aOK1V4CWVbU1+dbx8M/HGhaQlt2Vg9NIi6RnAbyzUROGhyNVnARZkfGl8QSI
	 UvI9Z9vUKKHykvMRYxrzlA/8kwFMEOCYQdFbjlU43sutZMwRhR003yB4vwPL3uz0et
	 bTKF1sE5xDqKQxMz/GsQECMdUpFblyQwihQS9EQ0/MPiffBUxHGG4wkfYql5mRs1LD
	 ElswsJ4xAS4selohF//ofVw+zUaLaGXlApBFpT3KKX8DMWgQIavwhTtjEMWfGConAi
	 hKMjh0qrK8sPe1+H2r9wySgDeG3kA500UjUz65VOb8vTFVFG9NJzECr0KSsuHOOAK/
	 F10Bu9jHv4DXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] perf build: Remove leftovers of removed build
 options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916061218.3061216-9-irogers@google.com>
References: <20260916061218.3061216-1-irogers@google.com>
 <20260916061218.3061216-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:17:54 +0000
Message-Id: <20260916061754.EE7EF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> NO_LIBDW_DWARF_UNWIND, NO_SYSCALL_TABLE and the embedded clang/LLVM
> support were all removed, but each removal left the matching entry in
> the build test suite behind:
>=20
>   run +=3D make_no_libdw_dwarf_unwind
>   run +=3D make_no_syscall_tbl
>   run +=3D make_with_clangllvm
>=20
> None of these have a make_* variable defining what to build, so $($@)
> expands to nothing and each one silently repeats the plain "make_pure"
> build. The suite therefore spends six builds, as every test is also run
> with O=3D, appearing to cover options that no longer exist.
>=20
> Remove them, along with the NO_LIBDW_DWARF_UNWIND comment that is still
> in Makefile.perf.
>=20
> Fixes: 2e9191573a69 ("perf build: Remove NO_LIBDW_DWARF_UNWIND option")
> Fixes: 3cc550f5bbcf ("perf tools: Remove dependency on libaudit")
> Fixes: 56b11a2126bf ("perf bpf: Remove support for embedding clang for co=
mpiling BPF events (-e foo.c)")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916061218.3061=
216-1-irogers@google.com?part=3D8

