Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884492;
	b=rrs8OVBLvkZpGWEyhRuXpBgcD6FzOHI/v9drWe/IVv54OrycAKLqvbXvI6i/z7zw7ksH
	 /AOFQI2woqlg09W9OvMHVg7WU+O2OqxtO/g0Uk6LGohHoAfBHvdW8LSfEqW8gtZ9izPD4
	 q+0mvLNLMCRXvI+Tm0Seb2LL2DfVjeTA0gxAXgQh/vCe/PgJWBx2YBt4Z5Nucc2G7RCc5
	 Cv5xvaVicbgQs9DmpCuvTXdPTd1OkMDnGNEzGwCtMFO5jQKn1p34rS4n78rTt8yj3b6R4
	 r5werucjJ8Z7PUAucfmvr6P7JtfAs97xzCLDylxBQOlo4gzdXococnXkYEs6o7CvN0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884492;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VzqgZNPoq/O2+CPLl0kouyVsD375ZRm1iFTGVv1gzBY=;
	b=JbHHmgW8pw4ti2x4/rB9xmiUEtYEVvKrLGHNCJVcKfS2NTHrWLfe46SpUG8Gm0iCROkx
	 UVbpa7gFZca5Us+kASfiub2WOcBhQmCVeg2av4rpPF5+dWWuWdTOoVRuS+uN03hj2QTdD
	 9x8YI3ytNr248AhPtzcw3XxezPH6meu7aXn3KQqf6ZiRxibR7pcOnuoXaGyBdnIxGLmS5
	 QPI1Ewi0j6UamBdx68dn16YL3/jTrssliOVovUxbteCpvJpgwAscTYnq5Vh48Kl/XOHsV
	 dgM8r39VBd4FjqLo0N1TfJTJeYOiWp9ll3rxOw/OmToDbvtmZpcez3EZddiefdWm3Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HSzGxlua;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBBD606A329
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HSzGxlua
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC081F000C4;
	Tue, 17 Nov 2026 03:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884491;
	bh=VzqgZNPoq/O2+CPLl0kouyVsD375ZRm1iFTGVv1gzBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HSzGxluarvcfmwiA56BBNRN01t1hpOZTpfFO9ZAS739gy0wNOddoiNgWANjehBzpu
	 V/JDpKeAhKkReMtCQvaWW0PDVmRLNYw6qWw6kjUrrQbUWpV1U5oXLI06icvvbq0+u3
	 scNT75W6xUDErFxTrmhq5gqrh9qlVEqebuLjIvULMkGZTU3lZ4YvvSsNbX34Eq/lqd
	 cZ3Wwd/RaIBuuntlymUE6li+XYUeHHySfVMtbncJO9mxs/TaGcnCocZR1yHUs1QiHs
	 u3NDVZ5i7bdr6W+G2qGpbL2cOOhEcnlndJunCTq7TlQdXLVxLJwe177gwYY0e4Omv3
	 fYkeN2ZLR26TQ==
Message-ID: <sashiko-outbox-218108@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/12] perf annotate: Print the stats after the
 annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117025305.3958882-8-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
 <20261117025305.3958882-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 03:01:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The instruction stats are printed before the loop that accounts them,
> so 'perf annotate --code-with-type --insn-stat' always shows zeros.
> The data type counters are updated in --code-with-type mode too, but
> only --data-type mode accounts their total, so they are incomplete
> there.
>=20
> Print both after the annotation loops, the data type part only with
> --data-type.
>=20
> Fixes: 58824fa0087e1cb7 ("perf annotate: Add --insn-stat option for debug=
ging")
> Fixes: 61a9741e9f78c64c ("perf annotate: Add --type-stat option for debug=
ging")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117025305.3958=
882-1-acme@kernel.org?part=3D7

