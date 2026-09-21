Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1DC346A14
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968414; cv=none; b=lxXrjMu19Cwd1/E0R2pQkmzPo9fEfgtLoXoLKyKeHAdhnK9YxvE+qQEEu6CnXH48sXr+ogSjA/L1z1TsUoaWIEzGypIMhA7ehb7S3Y82RQ+z6hiot5mZ81F2A3mu1CtZiZAN0NU3Hl4e4VbGLHxGdYmHqdFUBcuuO36t/pNN0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968414; c=relaxed/simple;
	bh=9xNT5jRTBDBx3HCNjFjahfOfM4azIREm8Bs4EUkDQrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ovVP43xLm1pOm3aFPXbwu+7Mol/jsuMgfIdNfRyTIzHY3jSAYL4jy6yWoJFPOTFvGwgh8FueNW0AGh2REDVuYSs/VWawYAh+c/WmbgUDiJqK60Bm3LJF5FRyTxIwtXUrHf7+6j6z5opYdz6yKSXlMzrdbeHUXs9DlggfnD2X8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoITG/de; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoITG/de"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C011F000FF;
	Mon, 21 Sep 2026 05:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968413;
	bh=9xNT5jRTBDBx3HCNjFjahfOfM4azIREm8Bs4EUkDQrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LoITG/de4W9Go36UuR5Wqw5lKLIYGE9MyKN4K4X4telGqYHVH24jZaBOhGtKcBHVt
	 veBs2XnOKE1lgf+o+PucmJQCk8eeMBqvy6eyk5UmBPZGqVDADbuFmkTogus+t9cKuL
	 2g6a5n1ih0gFBo5aKrLsuXCBkFi/u88OUvCkpmg/1PfOjj5UMjlHtIXPesNUWKdf3n
	 x1rotRxP4UZZBckZ2nmQ34bt/sjepQrixye7+GorhEaL96LvV9Lej+klDeQcZBkRLx
	 lCciRmL+Lh8akBWAt+N09/UYL3LuqkEPBsvYok+lGfBZNPMpvzF3HuubOTj0m61yey
	 ADoqt4/luTaHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/49] perf python: Update syscall format string to
 optional positional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f64b7f59e863302bb81c14a3a13af2e116d38b8f.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <f64b7f59e863302bb81c14a3a13af2e116d38b8f.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:26:52 +0000
Message-Id: <20260921052653.36C011F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Update the PyArg_ParseTupleAndKeywords format string for
> pyrf__syscall_name() and pyrf__syscall_id() from "i|$i" to "i|i" (and
> "s|$i" to "s|i"), allowing elf_machine to be passed as an optional
> positional argument as well as a keyword argument.
>=20
> Update syscall_id() and syscall_name() in perf.pyi to match, and set the
> return type of syscall_name() to Optional[str] as unknown syscall numbers
> return None.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D1

