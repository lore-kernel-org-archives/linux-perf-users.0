Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86233DB311
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189410; cv=none; b=nres4lvuSp96mHvN05pfoGiMs4mHQ1S/QxHKN7rkK5v7wAOvGhenYU1z3HyqONuuvtRL9WSaGop+6xXWPLWwUkT7gTBJhsZCFpTWcsoySDwJ+l2oaIsrz1fZ8EtymgYeIH5UV1KjT25Htrj87r0rdX6dSNPyFpeBS0v1wR8E8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189410; c=relaxed/simple;
	bh=wdOkfttU43Oqnm2XHPqynzRC5DsIQ8CrBal49MDqZqE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JjwHo+gB1iJibymrokB6Tj4ikMHTJO8jPOqMt3l7oyW+LR0fvTv4CfnV3hFBntvFsjos3jNyLfZ/d8KEaKjqQByG2CKUezWtHWhAsvxghegMiiGgvPdqSX+kPCJ9/pMI3V117aWL1KQdrDy/7qXUtA4DYOxRGr+8RTQpSPeznM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZGu/UWZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZGu/UWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEBE1F000C4;
	Fri, 16 Oct 2026 22:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189409;
	bh=wdOkfttU43Oqnm2XHPqynzRC5DsIQ8CrBal49MDqZqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OZGu/UWZQ61APiP5WQ0O5YsTAcDKHDeNE54hKnOAzc73eKWxM23qfZZpg52MT7ZKa
	 wxQ9OHSZVkwgLbwIyLSzImqEivllsQFFVt9TeX4kojbHoW2ktPXFUa/68jY+E6QEEp
	 w2vVttyJhmSmbBjxk713mH+8zJ6bH/312jCJGFRAEORRyRMmnZrsf+R7CwNxqiICMG
	 iGry5+8FtzKbGVBRc8oq59XJie9of7GGCphDTEfG7ufWZvt+UCyZQO3wFVh6XPOl5X
	 yeV5w/5TvmXzHzp7A5u4y9/RJfI9h9DrGAG6HmQRZTEDbe9PI8Bl9ChoP+K3Vz7eUm
	 Hu9/qO0h3boDg==
Message-ID: <sashiko-outbox-175013@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/17] perf mutex: Use kernel style
 compiler-context-analysis.h annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-5-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:23:28 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Enable -DWARN_CONTEXT_ANALYSIS alongside -Wthread-safety for Clang
> builds in tools/perf/Makefile.config, replace the custom lock safety
> macros in tools/perf with the kernel's compiler-context-analysis.h
> annotations (context_lock_struct, __guarded_by, __acquires,
> __acquires_shared, __releases, __releases_shared, __cond_acquires,
> __must_hold, __must_hold_shared, __must_not_hold, __returns_ctx_lock,
> __no_context_analysis, and __context_unsafe), and remove the redundant
> macro definitions from tools/perf/util/mutex.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D4

