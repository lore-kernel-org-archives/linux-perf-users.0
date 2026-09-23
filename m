Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0112F3C07
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187798; cv=none; b=BcSDqtTYdYwysm+e2rOJEUmPlDp//Uv4CAGfcKWrh3eJa5QeAPPFQmZbhy5qoVNIhrj10cJ5+W9Fd/VRFG4JfAcB57prLuRQ4ExKAf/UhD2Cm/6gtN7BFyR292L5f3RWg69o8t0Lc8s4+6AB0TOpUx0aLIQS52lFf/wsRKnZQmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187798; c=relaxed/simple;
	bh=XP+3l9UDRb0uFDKTupFsq2CkQET2Y+m1KZkek/hGWj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g8Bxi/YzLJLXKmssgIrRmuptAdysgbDxMRD57zBAuf8p460NIuTtaA/OaG5lNNp7aXOMvKB444bWyx2G6HQvTkSZpuduVpwAjMceMl8c3hvCuAJ+AYy7ie2S+B7vBCQcQ5z6YSuTNmD7lvWrCPZcriwJ8rr06OWeqfaM/VXy0ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av0anMPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av0anMPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C27F1F000FF;
	Wed, 23 Sep 2026 18:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187796;
	bh=XP+3l9UDRb0uFDKTupFsq2CkQET2Y+m1KZkek/hGWj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Av0anMPQXRS7U2gPE23eQfM0ANgKVXdjWpAtCtlRKfJ4rG6MqCeD6wWYQ9rWly02p
	 YScTxTEnD2fW6VBjtgXcnkfysCzaffs5yj5r+Co0VeTPaGcegDemzbAC2/Smr7eFy0
	 0rEl1fywdwWkgyGRCxNrS15zaGogu4Z/23ZTQJTldemP8E83iwf3TmW9wYo/QdxbYo
	 EuGG3aEJ5djp832RIFeeJPoXscl/EsP/2lsPfqj4DmiZ+VFO6VyIU49BoPxPSPJ9lx
	 kZWpoPG8+6iZBkyRZim8gjSvsHNZofJ22tZ/QSTBxIjO/1CTzPnCBEBj0TsDbe12hU
	 gU9sHml261smA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/49] perf python: Update syscall helpers and expose
 arch_strerrno
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-2-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:23:15 +0000
Message-Id: <20260923182316.5C27F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Update the PyArg_ParseTupleAndKeywords format string for
> pyrf__syscall_name() and pyrf__syscall_id() from "i|$i" to "i|i" (and
> "s|$i" to "s|i"), allowing elf_machine to be passed as an optional
> positional argument as well as a keyword argument. Update syscall_id()
> and syscall_name() in perf.pyi to match, and set the return type of
> syscall_name() to Optional[str] as unknown syscall numbers return None.
>=20
> Also expose perf_env__arch_strerrno() as perf.arch_strerrno(err,
> elf_machine=3DNone) so standalone Python scripts can resolve
> architecture-specific errno names directly from the auto-generated
> trace beauty tables instead of maintaining duplicate errno dictionaries
> in Python. Tighten the macro pattern in arch_errno_names.sh to
> E[A-Z0-9]+ so compiler -D flags containing underscores (such as LLVM's
> -DEXPERIMENTAL_KEY_INSTRUCTIONS=3D1) do not shadow EPERM (1), and add
> EM_SPARC32PLUS alongside EM_SPARC and EM_SPARCV9.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D1

