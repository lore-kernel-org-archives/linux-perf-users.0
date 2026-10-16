Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B3582B8B
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172614; cv=none; b=c5d4Bheyr2FqP4FTI+46poDgmPlZCLJFIlXzSr5d0QDeMFBbKyAPd4mgtSJ8jFYPydJ24K3F1rzN0M/lD37S0GKIAYUS0N/00si9JMmbwKNturE45cduibJnHkCG/GBYDSNwjIl08l5qIAM77BP/DkOEAz1ZCYtbtopg3SLe4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172614; c=relaxed/simple;
	bh=NdaTgPoKEqUAZEot1qjXvtSSvcgT6SVmNPLWRZp/S6s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lESemu+Vuv83PPEn69im5Yame02FptfhUIbKcmP2rwgWgRlWpvN4eKpLjni9/kjbcuVLQEIrNpjQ31gaj6uWYgGBk8C4ZFBCX2sLhomizQePZ42SjZhq4gqMKKdot7NQJ1UYvs0ntLmDD2yvYKCdImxwtSOPoPzgRHN2NDXqyos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMPLj1AX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMPLj1AX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519FB1F000C4;
	Fri, 16 Oct 2026 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172612;
	bh=NdaTgPoKEqUAZEot1qjXvtSSvcgT6SVmNPLWRZp/S6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VMPLj1AXV1fpDUL9D0xQJiWSHWvYEHKjZnUv/Z779hS9oWZ/4FIhWqdw9peBAs0RQ
	 2C9c0JkZoGlUXkYsPyVUQnQGuW8BTE4NUmlmjagl5/CGdtTBhAYJNrRA4npQoFNbO7
	 ssKzPF6mLNOxqEPgx6cg5LN4OtLSR7kvin186aFGDsxawnqW4KtvvX634Y+QwQt5DU
	 DR1iMCMQF9DP4aSQAihL/kt3LWVTpKfdQMIkOywdy63vUZj4fr0BFlFU92+r6inwuE
	 CzLetlqfYTc4P0vWDkJ2zvPjL+XSgHWPVnKeC1MX676YeA1qfg0c6YxSgiyJ46K6ZS
	 SyQeR74+MJkLA==
Message-ID: <sashiko-outbox-174741@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/17] perf dso: Expand context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-12-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:43:31 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Annotate struct dsos fields with __guarded_by(&lock), annotate dso__data_=
open and
> fd_limit in util/dso.c with __guarded_by(&dso__data_open_lock), and
> tighten __dsos__findnew_id() and __dsos__addnew_id() from shared to
> exclusive lock requirements.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D11

