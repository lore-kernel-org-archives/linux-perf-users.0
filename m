Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F5224D6
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263451; cv=none; b=Td93aUHNBaywHSIbkOjMd06ikHl7+z3fEzlP5R1pjLCE+Ms7Zkv+5fr5BHB92JIaXzN6pn/acJfake8Z+hvYodek4rvfHGdP9/rN9obkiXPmc/5+x4fSP8EGK6krwEhqSoC+immxhNcbFn8o1QuUtzGWAdMtOK2ucvS5e5IVGj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263451; c=relaxed/simple;
	bh=VHEQxZuQ9rLSqms6NB+Bfg4/d+txTryMdTzMhBV3QeU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HKIwbfdzGTVTGr3uB0vZd8/m1WxIieTa6Lf5uVSe2U++bswXYEgruYxqtodFu+7fanE8zuL1vveobJ0TsymdixQFEekWfOc9sgge7sDk0pSkNv/GBg7qPVOPW6kwquCLUt980exnXDuycaDKHFR90cjoyD4ZAZY1sTTxKyqBS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRcV48sl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRcV48sl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2BB1F000C4;
	Sat, 17 Oct 2026 18:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792263450;
	bh=VHEQxZuQ9rLSqms6NB+Bfg4/d+txTryMdTzMhBV3QeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jRcV48sldS90Jp/nVAJ7BItY0SmVtGzzgfKsOe3z/74NynqYXS3mJi+qRe2Yz6Qtd
	 VVO/OCvWT3CZ9zevzgNuLmKsjp+QA0cmXLNFvNV/CuIAWJRKrhb+UX6ECHsluVX1vT
	 j+RbCM3/61Xb9VrMiKic3e0SS9Dx0VinY8qm16G4Jtpw+C+jumNOz8Q5h3/dOPYOdT
	 pXzIUNGWIm4kKt0/ACxz4s5n+iZHCl4hMzpWoR2IFjg1aIh4VyjDnmrv7hXc3Zm4Qg
	 Ou2D1sgApvmw89GLWntKyev8pRaBdPUoDoTJAJSUqCXe5THLEnaUmgafCYwgyz7w5T
	 LpBUjuagGgg+w==
Message-ID: <sashiko-outbox-175767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 8/9] perf docs: Add perf-sysinfo man page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017185442.2137623-9-irogers@google.com>
References: <20261016213258.945737-1-irogers@google.com>
 <20261017185442.2137623-1-irogers@google.com>
 <20261017185442.2137623-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 18:57:29 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Document the 'perf sysinfo' subcommand and its options in
> Documentation/perf-sysinfo.txt and link it from Documentation/perf.txt.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017185442.2137=
623-1-irogers@google.com?part=3D8

