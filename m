Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812639D6FF
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663827; cv=none; b=hNi6fUr6zjgQcZHd2T8L3M5PN77LGKj66ILjN3kmIcuDFdNnd1mc6T6iNWHwGFKIA0UmviDoN/Qyu3zVhSEln5a1J+9XPsPxCWv2ph11lW6NNGj0fgAYMuHlGVAK0FrPhtqcrzAZFRidogL9dlIj9/XnYJr/pH4hzjyuRsWYr5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663827; c=relaxed/simple;
	bh=N5rk7EFcsfrf0f5ie+mo09vRDnC+cBp1PYoAo+VFYu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QtJ2oyXBbngQaIqOdUADxo1yKsP29GJiVcTzFAq8dq0LBdlWewBOK8Hktweqr+a9RuunjOh38QasBztowAcUCCVYJbLkhb+eyO1YrjhzdpY88crll4JZs+DVkklzkBE7tuR8P3soDP4TY7MdxSRg2J8tEmsaWOsd9eNnvL1RPmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzgnohdb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzgnohdb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F8A1F000FF;
	Thu, 17 Sep 2026 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663826;
	bh=G50EOJFmL+QeikQ1E77+xvZXFtpBUs41PzLeRymeoTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dzgnohdbCjLPaRzqDZspKapSoUXF+AfDtPJ/dbIe9aeUYArFEXw6I+qFgik1tyW7n
	 UTJJ57MzNwZuSRdmbz19cOgT5VQMTLkFXdDE19wcx1yRCiw6S1+kfGYMNvHjzweqxG
	 G5VkwBI07jX/FJbnuwoWQYLPtRiD6i11qjtEOiTS/NL55Rql0CT/OQVJGlXeryS8mL
	 LgXdMc3Foa1zRlTKTvHzf8eork+Wq2gLGGlSB3cZY6EdvW4LRCXhoXQn9CcEbNNwdL
	 VzIaGQyTz/pUofuOp+2jUAz/S5qs4u8AraHULHLesjI1cShgfwmvykX1bWoTC9/LsJ
	 8KnPCrnANhldA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/14] perf trace: Filter events in BPF and avoid
 tracepoint vetoes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <749b01086b20a21ca6cf86989d5a117d60d94924.1789662556.git.irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <749b01086b20a21ca6cf86989d5a117d60d94924.1789662556.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:50:25 +0000
Message-Id: <20260917165026.30F8A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The BPF augmented_raw_syscalls sys_enter and sys_exit programs returned
> 0 for syscalls that were not of interest. Returning 0 from a tracepoint
> BPF program vetoes the event for the whole system, so an unrelated
> concurrent perf trace, perf record or ftrace session listening to
> raw_syscalls would silently lose events. This is a cross-session side
> effect and shows up as flaky failures when perf tests run in parallel.
>=20
> Furthermore, syscall_unaugmented previously returned 1 without writing
> anything to the __augmented_syscalls__ ring buffer. This forced
> userspace perf trace to listen to both raw_syscalls:sys_enter and
> __augmented_syscalls__ in its evlist, requiring userspace event
> deduplication.
>=20
> Address these issues:
> 1. In augmented_raw_syscalls.bpf.c, never return 0 from tracepoint
> [ ... ]
>    disabled, ensure the non-augmented tracepoint path cleanly configures
>    sys_enter and sys_exit without duplicate entries.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789662556.gi=
t.irogers@google.com?part=3D5

