Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BDE19D8BC
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786815051; cv=none; b=CKiK+NyLdLz6IwAzIHDsULWF8itxjPqcT6rqCrWQUSbQnL4jhtE/vz/D627nIhmduLzkCtS09Oyss1qq3Wsh7AccY+uUN07X+XePLoekDOFDRjxT/QAOVmGNjuFOVk76XyHX3amA5V510pxkLH3SOKYjowHuH/EIFoLd2kDxw04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786815051; c=relaxed/simple;
	bh=12S63OcLOsVJqbO7yFg1fL79veGVxgKEI1LOdB1AHWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mXtbMgrzxwa8yH9TpO93TNg/NnJ1tX3epZEv1gRExia18re9lDH1jmErxfrLyg+2ds1sOSoYuB37ggLYSBWbFc5K80daSrVyRKUkBYY1qeYEqwMR8I4MNTvinusrhplF6nW6qef+fyujVjXE6QSOsYmRcCzGVJQcnfLUVCfMmNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMi1e8k+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMi1e8k+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041A61F000E9;
	Sat, 15 Aug 2026 17:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786815050;
	bh=12S63OcLOsVJqbO7yFg1fL79veGVxgKEI1LOdB1AHWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMi1e8k+Jndsb7+L9uSUTrI31+wukEom5Qju2iT+/NRTvQducxvRTBbhiDyYsjGNu
	 BqSYrVq8EUvSR/WBjhXFgaMiMd9RSy2G31rkgqmpyhKEN6LFSK/oLmSPthtRgg0cg9
	 PDzvNdH6NDzCdx3cwXuoEACLAHTAgxEkIye/6SK6omAmNWRNj5+1pQZJZ8+wpRWfOK
	 zVXZoQ3KZmI72XTJNLv3jxRvj+5S6vlO6Zsw+nu89m11BGKMRJWZv81WOI2Q2SDal4
	 0ERd1Xq5W89Fs/3DqKUGN9biQaTBaXJ0G2PVNbsp/wL5sI1hIi8TFnptH+Kmr8R93P
	 f6zuwlJ1divJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/3] dt-bindings: perf: Add Broadcom Raspberry Pi
 AXI PMU definition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260815172712.50119-2-irogers@google.com>
References: <20260815082048.4043217-1-irogers@google.com>
 <20260815172712.50119-1-irogers@google.com>
 <20260815172712.50119-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 17:30:49 +0000
Message-Id: <20260815173050.041A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add Device Tree bindings for the Broadcom AXI PMU hardware blocks present
> in the Raspberry Pi SoC line (BCM2835, BCM2711, BCM2712).
>=20
> Depending on the SoC and security configuration, these PMUs support either
> direct MMIO access or routing via the Raspberry Pi firmware Mailbox IPC.
> The bindings support defining 1 or 2 backing MMIO regions natively map
> the system and VPU control surfaces.
>=20
> Assisted-by: Antigravity:gemini-3.6-flash
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815172712.5011=
9-1-irogers@google.com?part=3D1

