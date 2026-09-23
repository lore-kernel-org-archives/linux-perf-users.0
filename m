Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648C34D3B0
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148551; cv=none; b=pDXm6VP3aW54EjJkAVBrJhd0BnsA8siE4VbyCi5O/Ly/uVKYK5iI5E54G15oV/ApjCcVMYgj+/av9HsQXnURVyqBA35upaaIRrXqW772lJq/l6ZQHoh0/1rvBxIBXexPl1S2yBeZa/bKAAUXoGOUvyjLElX2Rg/o1a/laG3JGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148551; c=relaxed/simple;
	bh=Y6RSGkVkvNIzP2q9L1DgpdY/Zr5Q5R/bRv2kac/DCv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JgyxHbsot41YIon+NaaeX0iduoynreei3rCK4DIfNxQMPV3703CWua47lPRqrwvanw1vaQjZldhw6v2Mi69onr/wtnL40tvoLblq2eM/qTWgC4Qx9d9UW+Tbgg6q4m/ULgSAHwvqVUgckzKhQv12auixR9ZrTOCYQmAR6m+QTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGpjQkNz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGpjQkNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2167E1F000FF;
	Wed, 23 Sep 2026 07:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148550;
	bh=Y6RSGkVkvNIzP2q9L1DgpdY/Zr5Q5R/bRv2kac/DCv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DGpjQkNzPLu1stqcgHSw/chiKPE17YxfK8MjIdn6E3GT7VbZ4WKM3LOGl51sXKykA
	 a2+ktYr7gLdh+3nOJHZAK2wQXI7OfQ88jI4rTw0Th7nSuzFrK12XcowAp6U/DH9O2E
	 NK13CGtSxTt4v0fLzmGf4ZbEWmkpQpWUgR4VNmnFDb2O9bK+7geiig0AIQkgJme5G1
	 kW0d4+K0s9umuiqfffwMr2dqaTaf1lYPgs+4TCPIh8sWXidWMnpA7B7LnbYq0L2kfe
	 0lSNcvvuV1pqwd3AciCvzje7D6JA3eMDX5H+SOCA/j5fHXqZxHYfUyfq3hJZTVDvhL
	 DJfSGEvAKnJGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 21/23] perf test trace_btf_general: Drop
 --max-events=1 and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <58ce3260eeba03521a8104db96dea1756a4c00e8.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <58ce3260eeba03521a8104db96dea1756a4c00e8.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:29:09 +0000
Message-Id: <20260923072910.2167E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace_btf_general.sh used `--max-events=3D1` with `perf trace` on
> commands such as `mv`, `echo`, and `sleep`. When background activity
> occurs or tests run in parallel, `perf trace` can capture an event
> from an unrelated process and exit prematurely before recording the
> target command's syscalls.
>=20
> Drop `--max-events=3D1` and let tracing run until the command completes,
> checking for the expected output with grep (matching trace_btf_enum.sh).
> Remove the (exclusive) tag so the test runs in parallel.
>=20
> Running perf trace in parallel is only safe now that the probe tests no
> longer name their probes "vfs_getname...": perf trace opens everything
> matching a hardcoded "probe:vfs_getname*" wildcard, which used to pin
> those probes and make their cleanup fail with -EBUSY.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D21

