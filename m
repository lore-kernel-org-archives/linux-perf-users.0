Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B33377007
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991214; cv=none; b=oTb0Tf+/I5CJp4Do5mRM94RYn9r56kUHfnLIiP0HVP0J2m/U9gLMAijmHB/frJFlsI81OyxB9fv7OgUAbgYmr+53g//KFw0/9Ozic71g3tjjg6MM2A72cF98y/IhbYyxoSrJqu/mQmci3zhpe0UVpDM+iVNAZdlUlyj7F9ZHCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991214; c=relaxed/simple;
	bh=hvREiGX1VhV3WixyO3svIqlfKWg68PeeKfegBmmTDH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tmPWnOEeoH8bhIJsZc8CdoXLTWMUJNOMVHRJsSgvD3r5SnQet3l0vVTRT8g9XOXGa/foeC649J/EA33pHqZOGYt6UBrqSzCQtcYtnxOqsNSAaYb3epsSQ1Yxwn/jVaZ463vbrYdKZVZR4YhpxZzGq2KXd4dO7VD2HbQgKrzeKlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJNxM08v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJNxM08v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0BD1F00899;
	Sat,  3 Oct 2026 01:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991212;
	bh=hvREiGX1VhV3WixyO3svIqlfKWg68PeeKfegBmmTDH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OJNxM08vnodmTjnKqe/9zaeQBKr1vu9WiQxMfwfmK8PEqRUaPlLTIt1ctdFAKwfMi
	 pNDr7BO3uGVGv0+N132Z0geUoKS4SaHzOnO6bvIuV9K9ZgB0+KCu0RxWsDwvXCfIwe
	 wfMGh7vDO82uYAsyqftFHZepoKHI1Xs9FT1HRo0YNvTD2BMEdQmE9j9K3Lv9JVSks2
	 y11rgFqTOCRw+xBavWL6nCLOu+71m/Vg/X1kTfbXpwDFW0QQclvTG9xqHi0XFHHOD4
	 NAy3qrkStWZqWpFor0/c1Ntvz4e2UHawpIbKhUQivJIHX7Pn/I6PkTAJ/0JBfwCR2j
	 VmJiErSc9cNmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/13] perf python: Lazily resolve sample callchains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002182624.3259797-5-irogers@google.com>
References: <20261002182624.3259797-1-irogers@google.com>
 <20261002182624.3259797-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:32 +0000
Message-Id: <20261003013332.AB0BD1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Previously, pyrf_event__new() eagerly resolved the sample's address
> location and callchain (including DWARF/FP unwinding and symbol lookup)
> for every sample with a callchain, even when the Python callback never
> accessed event.callchain (such as in ttimechart.py).
>=20
> Move callchain resolution to pyrf_sample_event__get_callchain() so that
> callchains are only unwound and resolved when event.callchain is
> accessed, reusing the sample's cached pevent->al via
> pyrf_sample_event__resolve_al().
>=20
> Because process_events() borrows the event and sample during the
> callback, callchains are never copied in the common case. Only when a
> callback retains a reference to the event beyond its return
> (Py_REFCNT(pyevent) > 1), the callchain was not already resolved during
> the callback, and the callchain is synthesized or LBR-merged (not backed
> by event_copy) does pyrf_event__copy() allocate a copy of
> sample->callchain.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002182624.3259=
797-1-irogers@google.com?part=3D4

