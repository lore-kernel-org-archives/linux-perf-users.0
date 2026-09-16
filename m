Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C493F3B47D2
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542142; cv=none; b=C8wdjbtcZQiHVcecsv+Ht/Mf+hvYHArQ5GOUpJlIm1GN1Dext1OonkhyJeXm4TfK502RgBCCnPNoKGUohF6zz+1CqFO3ShGkm2fSan1t6CLYY1zaJ0yTjzicf1SzOtqtu33lfhJySzOt0hMgue/CDYdpHySuFV+23+pMCOko8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542142; c=relaxed/simple;
	bh=E9zG0FrqEYWsXoVxv5LsfsAU8KgUnHHrF2yFFiM2di4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V4GWpSbcxuDOasDVKIPPY9hYoX1f2terQDHjsz0u4k3qz5YCwNVTQSmotaRTFOQAiGJ00E/YQdfxvavOEImDURoPkMew827a++OehX6knSCpkcTWcaJgsozmSWepNhamObHJksYiMQu3tTIfZK5teSRlqasEnDF1kb4FyyCnjFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghSb1Mql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghSb1Mql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5101F000FF;
	Wed, 16 Sep 2026 07:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789542141;
	bh=E9zG0FrqEYWsXoVxv5LsfsAU8KgUnHHrF2yFFiM2di4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ghSb1Mql5k1xYjU2fzPlv8ZXVRft4HZerbxr+4vHXx8YXOsXRwEGcMI0bihH9Kq7u
	 Lrr6Kob7Rr4pndN1vvngSPMFmNBCG83q+VMzM+TXPuUNzCzEjMoGg8bURHcC2TDj7s
	 La46IFyUqoJZzmVLnVUIuX+tLs1Yz2uPMZM27AaGTctVjqVRZmscm7ZvoThcE/BGDk
	 K+lqe7YPs3bWQtZ7fuwBfmTlzB69eobCZPjn6YIGp23xqKNqvOAkHEMXZQMwU13TgH
	 eemahXtVoQtSB6A+RU5rvC5x2R3w03xfa5y4pE3HHmngxkAK9Qmk5yf8rFNU8bD1Ml
	 vrxWrIoRx1iCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/9] perf evlist: Implement evlist__can_merge_hybrid
 using first_wildcard_match
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916065248.3153556-2-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916065248.3153556-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:02:20 +0000
Message-Id: <20260916070221.4C5101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add logic to dynamically identify mergeable events spawned from the
> same wildcard alias via first_wildcard_match. first_wildcard_match is
> populated when events are parsed, in `perf report` the events come
> from a file and so the first_wildcard_match is computed by matching
> event names.
>=20
> evlist__can_merge_hybrid only tests whether merging is possible and
> doesn't modify the evlist, so that it may be used as a predicate, for
> example, to decide whether to display a hint. The linking of all the
> matching events is done by evlist__merge_hybrid.
>=20
> is_pmu_core_len identifies core PMUs using the hybrid topology of the
> perf.data file. Should the file lack the topology, the PMUs of this
> machine are scanned but only when the file was recorded on the same
> architecture, as PMU names like "cpu_core" are architecture specific.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916065248.3153=
556-1-irogers@google.com?part=3D1

