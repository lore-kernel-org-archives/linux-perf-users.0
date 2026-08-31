Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCDA41D22A
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182586; cv=none; b=k2alC9K1CaqXa0XWsHgqztqEIlMv1dcsF/p0PHOTwJEi+9FoyoGcG/2hMohiYeVb43zYLUgKwCQoCR7wO6nOJof0aRLAMU0d2wdAWIcZONFsQ5DzIGkI7bb4HDinnVoHWWbLXSdw/BeNqQyIgPxKHcovx4vGMz7+HCAlIhQF244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182586; c=relaxed/simple;
	bh=tkvvWOXFLaYqNrCzdjtp/zmgleQSVqJPA7mTG6rvSoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mzn4akLE6PtDKVH3P2lp6/609xCRgkqq4VthhXw+4w2Xipz+SS42f7ruZUoX1HLc2V4K4LHXu76Y5A8w1+8k8Z1Mw/OlXiboo6uxPtTO1q3wHmVAur7Y28CXTS6vcNpVJ8+f07ZDesGUpUOpREdZ7CpxppWibT+PKCOb/89e52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FakVBvkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FakVBvkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CD51F00A3D;
	Mon, 31 Aug 2026 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182584;
	bh=iP15vQOtFlq8JgIRhIv4w/eAmK2X4vXG1QzEJrb3J90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FakVBvkVX8XuIaRrPB4nUH2dMdZ6wnNVkXwcNo9CzXMVSnpvw7NDmWNrF2yzAFTu4
	 tBUWx/HIS8Cj9UblAw8vOtdO3ZXJ0GEkGZ2v3gWot/XF9vJE9RTSFAQ1k5uQ2lN1Rq
	 rxWPL/QUwAtf9UKD5YIIkrJpurbtGOTFpw3mXQJFGjpU3dWWbw2f9zTeWjg4iNMAnW
	 ZsEEmd/oDyWC1qNRsemrvawmdOPX8axRmdo/lykASs6Hul24dKGs1Vc43IcCwvNc5Q
	 JRCTL6xs/OadfUD6c47G3Q1Wsb6S9Gji6gtgjeHsY9k4QBGDofB5mLznxC32B4Nzep
	 +pK9Ut6bZ2/UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] perf jitdump: Fix funlockfile on unlocked stream
 in jit_open() error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831131110.4681-8-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
 <20260831131110.4681-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:23:04 +0000
Message-Id: <20260831132304.B2CD51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> If the malloc() for the initial read buffer fails, jit_open() jumps to
> the error label which calls funlockfile(jd->in).  However, flockfile()
> is called later in the function, so at this point the stream was never
> locked.  Calling funlockfile() on an unlocked stream is undefined
> behavior per POSIX.
>=20
> Split the error path into two labels: 'error' (after flockfile) calls
> funlockfile before cleanup, 'error_noflock' (before flockfile) skips
> the unlock.
>=20
> Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831131110.4681=
-1-acme@kernel.org?part=3D7

