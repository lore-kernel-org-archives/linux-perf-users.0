Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB336F908
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189236; cv=none; b=ezdIdzkSS9FjvwXcPvYeuHAJpT1Gj/JdUH4L0MXFJn6yuzdVqB1yrTHBEiU006IQeba8ucp9IWFiTY5eyfw8TgUWLok5LlBJ39Z6g9nXRF29vgL4xOPPy6y4oxHrEsYRD5qujCElKoJIis86uownPze3uvzVhm1YYZ3ID7y5IP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189236; c=relaxed/simple;
	bh=MbNte3ajWxCOGhSisLN/F3mv3hBikPMHZsTA8Ho4Pwg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eLWwXjRn8sp6dU1NxSbjvv5v1JqeGWhTkd5uzK3wS9z4tz6w4XnJKxFiDqzq6FhEHCPpEq+7gL0CkeQTxKuvLm4N3R43rg3CvTBWkHHY4HGW+4RXzPhkof1RAEzAsrFG8Do5mbs8nhnh0NulaxCdGVNfJXgdSW8NCKL2FKpNbJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTLk0uJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTLk0uJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AA61F000C4;
	Fri, 16 Oct 2026 22:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189235;
	bh=MbNte3ajWxCOGhSisLN/F3mv3hBikPMHZsTA8Ho4Pwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LTLk0uJWKAihAgs3rgTJxVxIUDngIU3zs4rQtVWD5QEiOS5YcqjgXeDRVTVguXz6R
	 MuNm1sLFH3r7MfKAhhqlkaY/4oxu0EJXXaOEeUpArqupwyMsc6AguTj0efTwsxUPjS
	 9n+6rA1V2RBbARJDb2a0SihOm968L/JueVz/4fg6iDyaH+KpliB8/j50Q2xMJU4y46
	 pK9uvSIGPlaWnyWkUNDWn89EM8qv4/O0NgXgIBf3UfGeCjG1r+CrE+sto1S1o3vkgd
	 xv9GeXxC/dxjoap0CDeUDrNgwNaU20kDA/VMVaSDbUHucUjv6gPLW/qiJpXcSduK7G
	 GIDRK557FQg1w==
Message-ID: <sashiko-outbox-175000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/17] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-2-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:20:34 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> _context_unsafe_alias() does not use its parameter 'p', which triggers
> -Wunused-parameter when building code that enables -Wextra (such as
> tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
> Explicitly cast 'p' to void to silence the warning, matching
> __assume_ctx_lock() and __assume_shared_ctx_lock().
>=20
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D1

