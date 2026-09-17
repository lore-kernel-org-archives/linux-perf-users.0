Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013F037F8A7
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611114; cv=none; b=ng1GsuDHsx5Iv6s1ZqBxgCGGYQHdhFyvapS5lbrdcPUbMa54pcJC8XLutOYpcaFqe5DCE0PewcRS2e/LHbMtBm1rvg921XCnhrvr2pROZec94N2iKek8qrnFDTtA69crKGzIIgNKzvQurqJZ9X8y7COTMFYhvpbXY9V+Tm/EYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611114; c=relaxed/simple;
	bh=Ca0ROPUBKZCYTECrfbu4HBcBVPZ2+cccaoMNMRnKjfc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rVi3wwYFobMhRqy1KzkGV5X3EK7s373Zo8NO11Ceuar8mAZZAF0t1+Wjj06lZolORA1v7dyYr7/GtuLlglIHAX32tfW5D4gCcdh/r7L5Wae1JyAgWpHu7U3hXj8AaPRd/kJxng+e6NBZdymO0DIwPpl9dsAMmjk4umml4AFX7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1h/xpwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1h/xpwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B021F000FF;
	Thu, 17 Sep 2026 02:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611112;
	bh=Ca0ROPUBKZCYTECrfbu4HBcBVPZ2+cccaoMNMRnKjfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M1h/xpwt1feDAAhgrcqzGqnQw1KUkHaIiI6JNEyTdvNA39pBvuDrom2/NlkzPuS8H
	 reeVLuMm4R1/IYKQjyMuIbsjy3LCR3mAouMXtUDinBvkxVSV7M3Pp2+CnZ0XB3XrVG
	 oonjotJmEDfnw/twOjHl09sBDHzWRLwRcGLG+pfR6JqbZvVFs4/fH1Q1YXSmMYzb8g
	 JODM7hpmQqWbsmQM5qw8R5It4uyHcAd14rmSXUtBtTaQGadCRk1P9EFYKbrIlBHhzN
	 Oiv0UG+tcq+NVe+PblcyxmCEN7pGHo37LmJUD6DFc6ukWOLNFLwK0N+gdzS9jUh9nD
	 UkBnnR5xt5X6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] perf/x86/intel: Add precise OMR event support for
 DMR/NVL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917015234.981153-11-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
 <20260917015234.981153-11-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 02:11:51 +0000
Message-Id: <20260917021152.49B021F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The latest perfmon event database introduces below precise OMR event
> support for DMR/NVL:
> - MEM_LOAD_L2_MISS_RETIRED.* (event 0xd6)
> - MEM_STORE_L2_MISS_RETIRED.* (event 0x4f)
>=20
> These events use the same OMR MSRs as the existing OMR events, but
> they are not listed in intel_pnc_extra_regs[]. As a result, perf
> cannot assign the required OMR extra registers when scheduling them.
>=20
> Add the new precise OMR events to intel_pnc_extra_regs[] so they can
> be scheduled with the correct OMR MSRs. MEM_LOAD_L2_MISS_RETIRED.*
> remains limited to GP counters 0-3, while
> MEM_STORE_L2_MISS_RETIRED.* is available on all GP counters.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917015234.9811=
53-1-dapeng1.mi@linux.intel.com?part=3D10

