Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335E45D915
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 06:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792044837; cv=none; b=N6Mwwp5Iq9dfkOD0sVHU65awlnj6doMLsQq5ysrk6TJszRKsSgnvPTCmBCxs40h0kM+VqxxNiTq1SI+C7EUfJZsfO2XpKwf7Oqpqk/NafmEhoA+FLfh58esDVSDOXUea+XQqCm1XwqSkzeg6UTO6vxwhPJ+wTOfQq8O/qb9B4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792044837; c=relaxed/simple;
	bh=lC3zAWZSoyM/BKw5bYn/wYMFLiCcPRE3yaOhmrSNF88=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CSC6cS57rLwx34RmCiNwY0EHNDfoLqMSgzg8ytNhIZHZ6+AtULztOwIJLsOcBsszscij19r6+nH9ue7/MlCTS8lm3i/0rBztTdKOI/kRvXNt37McST2KPfyxSoJ4sdxGpTsB6eUWtnP/7TW32/RayDCXEuEhE7YinG9BCDu5mnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKy/oRPG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKy/oRPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D8C1F000C4;
	Thu, 15 Oct 2026 06:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792044828;
	bh=lC3zAWZSoyM/BKw5bYn/wYMFLiCcPRE3yaOhmrSNF88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oKy/oRPGDQedJSh7IMms1GFrMc8NaLje6o0Ef7BEAQFWxqy+Dvzvq9jww97ti+sjo
	 Cu1fUUQ13PonwaEhsZx0afhdl/v/HhaJKnTOlR+4W7lEyeBm5RAk5mKMSqG+TSH0pl
	 6jLahET8XjAmBIaH3zFSzIZzH2fr/ZDh2c/Ut0bmCM6N9cwqjBbih93Tja9G4u+FVU
	 iEiosJuLYApcSXSdOmgVT4aEEFb798UEgNmsQmb6T96Mmnn3I+hAcHnKUCWB1uuC3C
	 WxmU438mVB5H8VFq1/XT8q7u6klY6OqcemQ3GKTtfMk3yNF5i2vc+Gm+iQLVUg4sCT
	 3uncesgWt6oHQ==
Message-ID: <sashiko-outbox-172333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf/amd/ibs: Fix kernel address leak via REGS_USER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Bangoria" <ravi.bangoria@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015060430.5877-3-ravi.bangoria@amd.com>
References: <20261015060430.5877-1-ravi.bangoria@amd.com>
 <20261015060430.5877-3-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 06:13:47 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> IBS hardware captures a sample and raises an NMI. Since the NMI can be
> delivered with a delay, a privilege change may occur between sample
> capture and NMI delivery. Because IBS only provides the sample RIP, the
> kernel records GPRs from the NMI pt_regs, which may reflect kernel mode
> if a privilege switch occurred in the interim. This can leak kernel
> addresses to unprivileged users through PERF_SAMPLE_REGS_USER.
>=20
> Fix this by discarding samples where the NMI arrives in kernel mode and
> the user has set exclude_kernel.
>=20
> Reported-by: Jayapal Ashwin Nair <janair@amd.com>
> Fixes: d29e744c7167 ("perf/x86: Relax privilege filter restriction on AMD=
 IBS")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015060430.5877=
-1-ravi.bangoria@amd.com?part=3D2

