Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F741228D;
	Mon, 14 Sep 2026 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378440; cv=none; b=TJcqY3SbXrui1k549r+ZYnGiTgql4aUvDsPgyIKFky+7KwiZjYxLroyUBpxIJPJZF51y0uz5aBl2NVgHSmCpFVfRNilBy2f4TxgztBw2OKxAHU233xx4NGiG+xgQRzipWSj0uef2FmI5Vvl+ZXqdhE8K+hy7ohyVtJ56194xvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378440; c=relaxed/simple;
	bh=R5/tsL73QCRH2HIF7UXO7nG3vpGawDc+fpVOd9LdytQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dfk10DAzhwfzNAN9O5zQQegaJi+tf0Q383IyZyYfLuuDvZqY6qGskWs3cgVjgN+becEWK7leYPQMCImkzdrvbTP5lcDDEr2q10mnu4ZhpBpQNeHgam6DGLnXxmdarTKYvaqPtdiN2gTmLeHFiDAaZH6pxppd6QT7HthOwKXO6i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWiVqETX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWiVqETX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E477C1F000FF;
	Mon, 14 Sep 2026 09:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378439;
	bh=i4Ap0Zj2P4UerV/oppUYA5h33iUGoFnVLhsZM4Gj9xw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZWiVqETXO7s60ondKXt4agAnYI29fW0EGhbhmTUnMhHuC4jGWXfpkTS8vLnbsXSg7
	 vwk1cbd+P2VW6XsH7uMl1jK8UrRrHi8NNEjf/R05iNW3l2GwRlRMax35VHmXaCWsXQ
	 5PLpdQn6dk/9oe+FhnYwKNcUMWFXSUayaDkQl45uoKB4dG1eVZs7gYK6P3XIc5yljD
	 v9/YOQWfD+5KjuIKjlDNYQ9iTHaJI2elWjD9EGZbiOBnDm3sVsa0oxhYg28E369zYX
	 KHUjVDtiQ8M6zXH3wHpVqV71W6CMB6JM1vmtOQf1J96DuUwY4MYCGnESx8o9GVa68H
	 xDunk8i8DnDZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/7] riscv: stacktrace: introduce stack-bound
 tracking helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260914092648.51254-5-xueshuai@linux.alibaba.com>
References: <20260914092648.51254-1-xueshuai@linux.alibaba.com>
 <20260914092648.51254-5-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:33:58 +0000
Message-Id: <20260914093358.E477C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Wang Han <wanghan@linux.alibaba.com>
>=20
> A reliable unwinder needs to validate that every frame record it reads
> is fully contained in a known kernel stack, and it needs to refuse to
> walk back into a stack it has already left. Add the building blocks
> for that:
>=20
>   * struct stack_info / struct unwind_state in a new
>     asm/stacktrace/common.h, modelled on the arm64 reference
>     implementation.
>   * stackinfo_get_irq() / stackinfo_get_task() / stackinfo_get_overflow()
>     plus the corresponding on_*_stack() predicates in asm/stacktrace.h,
>     so callers can ask "is this object on stack X?" by stack kind
>     rather than open-coded address arithmetic.
>   * unwind_init_common(), unwind_find_stack() and
>     unwind_consume_stack() helpers that enforce the
>     forward-progress-only invariant required for reliability.
>=20
> No existing user is wired up to these helpers in this commit; the
> unwinder switch comes in a follow-up. The header changes leave
> on_thread_stack() with the same semantics as before, just expressed in
> terms of the new helpers.
>=20
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
> Signed-off-by: Wang Han <wanghan@linux.alibaba.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914092648.5125=
4-1-xueshuai@linux.alibaba.com?part=3D4

