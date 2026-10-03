Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499BB1C5F13
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991209; cv=none; b=LW3cauuU8pME6L8BUjHoGI9c3fb9mhXN8MgyeHedFbU2hTmNpgJhyyj66JFj+ObSrKDKnLutPaI2UwWAt/E6FSD0k1J3tbK3og+xIhM6PVX9iHlQD0qaiDmtuUuTw3hi5lFmgFV0W15t5KdzjmpwAsodDyDqETgDb8Kez2pEt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991209; c=relaxed/simple;
	bh=oA2UUE2/f7O7SC891BEC9eI7CdJeMgvVHXQt15hBEPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aGanKcweINYUfdyhECkOgKFYdGCa2fjoER9gBPfcFy412yXJLDhWeN9ax5NchKfqS7ndDmuTbX8aAC43DOeOu2c/A0dRbBxjl6A05JpE9+J9P5llGQ7HUBoFA0IrPtOrpeByHWAIuvaBAmG7N2AnGhkjzKKtzfeniHByMWC5c3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJuoEYJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJuoEYJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A251F000FF;
	Sat,  3 Oct 2026 01:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991208;
	bh=oA2UUE2/f7O7SC891BEC9eI7CdJeMgvVHXQt15hBEPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GJuoEYJIoo2c9yAiX76W4BNwV3zmFMeUtUuoJOkbEJTJi8RXk3vWrBiIbSOTd1mxP
	 Hg4yksnvQdWXPN9GksiWV/IQRmjLDnCqW4KP6LGZcWCMFtxZM/+B3+2GiVGsU5t5Vp
	 bF/OYTpbsE5JkZNSofyY8pyxeWtyIzeLnU11AVE1TA+/OzmE1I7/hjyDKSc75lejlR
	 SVSzvAXvzORq7qXn1rRXlxjWBtmOaFXeRcT0ZBJoGLAk5qMlrlWLMHqFxTDwNHvVNX
	 0gKr3z7WQm7n+0ZidKWwvsOdp0Mzb/p6pAmLQh2qvpfqveZfcgNhR8ITmyvh1vlUVF
	 8dfASD3shUJXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/13] perf test: Add a test for the ilist script
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002182624.3259797-8-irogers@google.com>
References: <20261002182624.3259797-1-irogers@google.com>
 <20261002182624.3259797-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:27 +0000
Message-Id: <20261003013328.01A251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Test launching ilist through perf script and perf list --tui, and drive
> the textual app headless: check the tree of PMUs and metrics, search for
> and select the software task-clock event checking its counters are
> shown, check a failed search shows an error and select a metric. Failing
> to open counters, for example for want of permissions, is tolerated as
> an error dialog is shown.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002182624.3259=
797-1-irogers@google.com?part=3D7

