Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A633E3932ED
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561058; cv=none; b=mKcB9FBKl0dtVlxC78FI95PZM7XbrzgI9V9jc12MaLDcjEIjR3ujPJdPLBAqm4b1XhVW4sCS4m4uthdqmK8zDmL6GwbWFPLBixWPS/pbJbg9y/2ZdkYsoyz6GmsM7Kbq/1sRE7ZHlQxmUXcrgDzN4Td7m6AJYBxaq4VHKlSGtAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561058; c=relaxed/simple;
	bh=eKG2P9JaCLvgx1tcXe64mm5pJTnNxGuRlo/NfAvtNbk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oNpmfUtrTcWIgCKz9XP1DH+2xLtdKDbWYvjVENxYBJwLJltQvmPp2P1GNLAp3Q2CYasW4l0Bta0pZDa2WIE8z4/1VWjMJuTPhPl9tmLcX2NjvGQB/cu152/kxOGB5mbVbjuacsN1wauiMC/PcnqRjmn4msp6RAmqkJtwRTvnbYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUMqYAom; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUMqYAom"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AC31F00A3A;
	Mon, 24 Aug 2026 08:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561056;
	bh=eKG2P9JaCLvgx1tcXe64mm5pJTnNxGuRlo/NfAvtNbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HUMqYAomwwboatKOpVOcB5VM9qy5gLB5HY0WcMzERwRf1fegv335XtrFd+u2xBhJ2
	 ydlOFoBulu6yKC9MeABLrMxXQ8sN81/agICDp4XITn6/IHdl9OwlUvDQOa223q0VU/
	 cFpnek6TRox4EMuhIGvFpqs9PVzj7dmoqbL9JXJVb9qhh/pDI0BnbkRIOfR1crk/3C
	 o6zZWDxgdq3SwajHf6N1AFoTDpQknzRP68kQGYWJxRGA6AGdn6n3CqJdZ5eNDhVQgg
	 WerPq3pliC5of5OvMktjJx8ofGaPqz9AFGqF5tn4kc/xXSt4GA6L9BLR3c0BGRSCVG
	 KO2XMkQrJNfZw==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 01/23] perf/x86: Move hybrid PMU
 initialization before x86_pmu_starting_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-2-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:44:15 +0000
Message-Id: <20260824084415.D3AC31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The current approach initializes hybrid PMU structures immediately before
> registering them. This is risky as it can lead to key fields, such as
> 'capabilities', being inadvertently overwritten.
>=20
> Although no issues have arisen so far, this method is not ideal. It makes
> the PMU structure fields susceptible to being overwritten, especially with
> future changes that might initialize fields like 'capabilities' within
> init_hybrid_pmu() called by x86_pmu_starting_cpu().
>=20
> To mitigate this potential problem, move the default hybrid structure
> initialization before calling x86_pmu_starting_cpu().
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D1

