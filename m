Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910537F334
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532224; cv=none; b=Q+/FYv6VRFL5Jc3HrAYhKG7elorw4p1R2LXmNDj3TYLiBbcXjhs69WyzWlAf4iM1wt4ajXhOL/oEhrz/iDFBWm6RMUG0JwZwJScsJP/cH8pMPRx9abA8xAMvVkVIMQFX+YVQZFxbNyns5Rh+Wa1Oy66XjIJWbnwYh5H2uVo4R2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532224; c=relaxed/simple;
	bh=GkP+ZIKkgTLIvf6YbdrFr7N7XLtam0IjadEqc2Lm8t0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AS0MilMnX2gCntLsCXnzJGyQtRckPHOBHQ00GqhXwWpRswcSsNQYyD115CPNu/TTOuMbJXI8H5mvnPhS9Pu7B/diP5chPiKeJd0wFTNNZhg+AoTaQSDbMNJOdd73Ubo7E12Q5M5TFKKapGD5cUX5hpURFuwtQCalJeBhEJNx0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+hCfaDE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+hCfaDE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E271F00A3D;
	Fri,  4 Sep 2026 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532222;
	bh=GkP+ZIKkgTLIvf6YbdrFr7N7XLtam0IjadEqc2Lm8t0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k+hCfaDE1gNfeUvjG5o+Ae7mfdzJSOEd5lfXkBM3M971DggX/7VZ6Z+M2rf70o12r
	 8nb5oZL9XzRxwnKSPx2L6Wgg4JnzUpREZyXy2adCRJ6D18yiYQj/o57O4sqbJI7XF4
	 InV+o2NI9JtEnoMuyFsj+344oYhJOOrkl8ZZ7Et/fRkRa1dXtIbqbz44aB2ehXeg4i
	 eEfBfj0vChz4qL1ZSoAFiokEuRlLq3oITDhpCHSqLT+YmgVqXUZ3odB4S5oE89y+2j
	 QQcsz8tIZs2OAjzN/sf0dmQBX0FDqS8qyLK5ghzcnbKg8HD9FG9n+HzYlrb9HtvymM
	 NHxyHxPD261uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/intel: Annotate x86_pmu::hybrid_pmu with
 __counted_by_ptr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260904141659.224248-2-blum@kernel.org>
References: <20260904141659.224248-2-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 14:30:22 +0000
Message-Id: <20260904143022.B3E271F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add __counted_by_ptr() to x86_pmu::hybrid_pmu to improve access bounds
> checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904141659.2242=
48-2-blum@kernel.org?part=3D1

