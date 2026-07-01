Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912E38656D;
	Wed,  1 Jul 2026 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897561; cv=none; b=HrKfahw2vuHubmk2kLEc9D69AzTybrN3B9TzYLi7ykD2YgUzWygPGAFuKNh4QU7NRW4jvffcsRm4It8mDpb3UlkaX2bpEQjA2/DKF2JAsVYz0vF90skw/tZpnbnN1PpLrEk1Thgj8vxhvSfLtVGJa1APQyc3T6pQIE25kcyRq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897561; c=relaxed/simple;
	bh=O+WxQEJcPlXHvA5K00jtBGLyDoXDhWTLYNbRqUxjJFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oA8aBJ4fNxAIDlzXlr/nNTZaHxbvZobDuCXi7tths7bAtki4UthAZ2VVtRnHne29YBFgoGHwgX3g9U+oxP4aGV99GL/IzdFb6nIZ34+oTOuk056umMVeunKc1Nkk2cze8Va+hav1gOfUxiestpxk611psW4GbAaHUosezh0soYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlgN8Sw7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlgN8Sw7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD3E1F000E9;
	Wed,  1 Jul 2026 09:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782897560;
	bh=uuwWOO8gIcp9Zj4i7cd94cyG6/9P3iRk4Gw/v7AhFYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IlgN8Sw7RQR2YtkSmDQE4lpHykmigcb1sLi19M3MvTy4q6bdC1iRTIx+PHJb5j+oh
	 kKUtXSWBKO8mmTZvuUt3fHYX4128m05laoKRSFHY2eluYUMzaF+IaWmkNviYceTRL6
	 xDouxDmlGJsDqwRxGAhReeFad5cTCVHpz8snEXO7n/+kClMU7jGEP1vEbKrrWPcOyR
	 pzu/MSSMsXEnWKRY6u095F06/7RT3gcDLNqH2Jn5f/UGXUlsHTMtBu7r7fsJRcSyFP
	 WcSJGVeHTJfs0SdHxaQlAoaZD/xKf21FdvpDI54G3L/awEF/SbyIANGGxvzf744qp7
	 vFHiJR53ir+aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/22] RISC-V: perf: Add a mechanism to defined
 legacy event encoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: linux-perf-users@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260701-counter_delegation-v8-13-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-13-7909f863a645@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:19:19 +0000
Message-Id: <20260701091920.0CD3E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The fallback log message incorrectly reports 'No default PMU events=
 found' if a vendor only provides hardware events.
--

Note: The format of this review is altered to provide a free-form summary
rather than inline diff quotes due to recitation restrictions.

commit 8db6e371918071f188390a413ded48d85e22f4f9
Author: Atish Patra <atishp@rivosinc.com>
   =20
RISC-V: perf: Add a mechanism to defined legacy event encoding
   =20
This commit introduces a framework in the RISC-V PMU driver to support
vendor-specific legacy event encodings and counter mappings. Platform-speci=
fic
events will be added using this framework in later patches.

[Severity: Low]
In the newly added rvpmu_vendor_register_events() function, the fallback lo=
g=20
message evaluates if either the hardware event map or the cache event map i=
s=20
missing before printing "No default PMU events found".
   =20
If a vendor provides a valid hardware event map but leaves the cache event=
=20
map as NULL (e.g., if they do not support legacy cache PMU events), won't=20
this condition incorrectly trigger the fallback log? Does this code need to=
=20
use a logical AND instead, or should it evaluate and log hardware and cache=
=20
event presence separately to avoid misleading kernel logs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-counter_de=
legation-v8-0-7909f863a645@meta.com?part=3D13
