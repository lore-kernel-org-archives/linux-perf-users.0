Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4EC4848AA
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585994; cv=none; b=ZfjACMld7i87NFAq1wboD2enZLG4A5xpYG3y/cVOdggbkAMwMlaif0C7vDKZc0zdRv8h70/AvxgMeBcFy9QtUmTW/TNYNj8Vh0XpU/OvpW0LA6TkkScXVtuy4LGxdVZcMCLivVlLBNy1Nxa/cFKkLcAD7QdkT01rKscnNVPr/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585994; c=relaxed/simple;
	bh=YcVcnqks4d6sSjOQMoZb8SJ3nSGF0i+KyoV1CcnV0NQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=am7+EFdgPTeegXwlyVhwZ0RFJ688tlVrkGvcE3PxzzF923bYY8n88lKk46KHVv55AwjETwQ37hMwjQ3Jbm3hqRZWVzY8JZoA5eqyTpf4zw504oNKOdzw/fDP5aAkmXzXxcOAllVF4QzfSxOj6ejXuoMj9TXdXsOtaR5jIV/ph4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ti6f+ZVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ti6f+ZVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D4F1F000FF;
	Mon, 28 Sep 2026 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585992;
	bh=hBf2zaqMpkynipICBBjNEIQ4PCzI69i43/H/fe8bOcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ti6f+ZVaC8KuCQzkgEZ1mxpSuX/d08ygNgTrBj93gpFuJgb9urSoBZ/7/x+t/1dPq
	 5T0fBtoV5XQCUo/l7xpzhcL316PsKzOkFMFEo5Z81wASl98CGH1OkYU/aAQzH+G0gO
	 SHCGvVNON3rJ1R6my06r40XfU/X+7KKrt8Dw+4V0NYGS2POn4uqPla42EaPL6vPSU/
	 DhPmZLHu0Q8J4qPID0oRV/UlxMZvTHMOQMSmUf2/vKzUzvViS8hn16qJ6r5YB/ediL
	 +URPLeBwynkTyZ7ANitUR4YVFg1aIJBBvIgoqASniAj9xJj7/h6oyABs27Y3TtfER8
	 T1izAGuHlBSqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf build: Improve fix for "argument list too long"
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmVub8OudCBNb25pbg==?= <benoit.monin@bootlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928-perf-orphan-args-v1-1-8cacf784621e@bootlin.com>
References: <20260928-perf-orphan-args-v1-1-8cacf784621e@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:59:51 +0000
Message-Id: <20260928085952.40D4F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The orphaned pmu-events JSON files are passed to the shell via
> `echo "$^"`, which puts the whole list into a single argument. With
> a long enough output directory path and enough files, exec'ing
> /bin/sh fails with:
>=20
>   make[5]: /bin/sh: Argument list too long
>   make[5]: *** [pmu-events/Build:228: prune_orphans] Error 127
>=20
> This only happens with out-of-tree builds, when setting O=3D to a
> relatively long path.
>=20
> To reproduce, build once with JEVENTS_ARCH=3Dall, then rebuild with
> a smaller JEVENTS_ARCH without cleaning first, so the leftover files
> become orphans. Using nds32 (which leaves ~1100 orphans), an output
> path of only ~70 characters is already enough to trigger it:
>=20
>   OUT=3D/any/long/path (at least 70 characters)
>   make -C tools/perf JEVENTS_ARCH=3Dall   O=3D$OUT -j$(nproc)
>   make -C tools/perf JEVENTS_ARCH=3Dnds32 O=3D$OUT -j$(nproc)
>=20
> Express the orphan file list as paths relative to $(OUT_DIR) by
> stripping the common prefix and restoring it with printf, the same
> approach used in scripts/Makefile.clean, so the shell arguments stay
> short.
>=20
> Fixes: b6712d91f8f5 ("perf build: Prevent "argument list too long" error")
> Suggested-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-perf-orpha=
n-args-v1-1-8cacf784621e@bootlin.com?part=3D1

