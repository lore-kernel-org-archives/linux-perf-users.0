Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A33D88FA
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341637; cv=none; b=pAZoETwsGhanUoRu5rt9gxLzqPmUgPRuLo4ZOWGl9+lDO7qBeO7krLXBMMhOKYh0mJ7+U4z4qxpvjDsRsBDwLLX3og1erbjYRZIPCX4CVJr6Y1TMJnGQ2VhEwroLUpOMT5XcyZBv8N07gSlu598ErarqRR9xQZAuMDjeEA+eZ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341637; c=relaxed/simple;
	bh=iEKjCs+wx8b19/S8jW3k2Eyrpn2SOTwIwzkK/uK1uE8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=H18LMPy7tLeRNDQyMSGztwLll4IE0t0spoevnLPvUkczHChpwsvSyJ46S+uopRKtpQBxv+DC53fjIBZlkVBYPHvZ/5Aqgp9YKso2ovBrJTOPlRXb1VjMhKAElUrlWBMfofy/tKg4GvtQeyYFUNvAIEgW/Phxjbm4RSGsBJI6JtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEZX8B7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEZX8B7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079311F000C4;
	Sun, 18 Oct 2026 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792341634;
	bh=yFYmiiqcQyqZ+UXtjWNYRcny6/hoMKz2wdWizNKDUcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OEZX8B7w2n2wdVOI5hVdgTrUxYrnZ67KnTUCvi8z75b5zdtRzy2L2S6aV34TXfquI
	 YE9VIY8gFx16bV9ZZc7s2NISqu6peaUD5Rtu4BpRtl/lHomQcPGmiLTfRLyref4qAC
	 BKOGFsg92Q236ddEu551P0MB6xsrWvs0gcmjsLjUX7c45hCTw0++fyJcMgGFYZcXTT
	 ciIlxbDuji/2SKcrqmfHfAd+rVeElHXSRjLDdM5i97ithqgQINetvKBgfSJtYjhWYR
	 rG4ujmb5Qweq0XGPxmrm1/mzHzFulaLESVIo3EYwDBmH/bNmUgCUBjtVw0AcVYmxvj
	 zwIsuUxPrQphw==
Message-ID: <sashiko-outbox-176283@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/5] perf test: Fix a memory leak in PE file parsing
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018163741.850434-1-namhyung@kernel.org>
References: <20261018163741.850434-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 16:40:33 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The get_argv_exec_path() returns a dynamically allocated string so it
> should be freed.  Let's check the return value first so that it
> doesn't crash snprintf().
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-168781@kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018163741.8504=
34-1-namhyung@kernel.org?part=3D1

