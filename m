Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8FB3ED3B2
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561644; cv=none; b=KgJM6iGPV3uITBnMkkLf0Q6Z1CVnUikEI7IFttJVObCa0onKmXp37IZw1Sz3jMTLv6MHZhstxk5QEAtNgEYBKOdoyQSQEFJGCx9Wo7Y8kXf2tm+dlgaGqr+PpgSJ6Uzhf6Aa8/hUToGWOXkr14leM4JeU2u1YCSR7jg47mRgITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561644; c=relaxed/simple;
	bh=P0xJjMa4V1b986AiOZaQ3EEeE1C3KtoAjgL4LV6xUcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WY0eP/sgZBqCHi7IP2lYImdGdqeqhHVggevAO1C/tDwRJ7yfu1fDZVqmv2rH0hRNQxu63Y0p2YKxt18G0n3OJrZid7JMOGKgjyQjCfqltwL6EjOPXZ4n+Gq/J0ORiLNVTh9xrltp06TJ7pjNdX63vrcskR6T4/4rBQPBj2D2FwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyZshEdp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyZshEdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D811F000E9;
	Mon, 24 Aug 2026 08:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561642;
	bh=P0xJjMa4V1b986AiOZaQ3EEeE1C3KtoAjgL4LV6xUcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nyZshEdponjrXC2455zWDN6VgB82/cOGn68mkDL8KTELx8qFbPwwNR+PyT2cAKsre
	 LLU4fT0fQ6MYIZIGz9V7pklZwefBFSSsSGmwL9KkRrvitVCts9fkq7as+ZoXpwgvkN
	 ptxxtdUdbdTLlONBwq9/l1Em9dMvutRnOurZ/JclPXbdal99injawU4D/+YM/YcXm8
	 pkOFY5d3t8VsPHjLtpEaZeQhI1N5OJCfe19l0WzHHpyXht5Vgy6rCm2aE4gUn36gi5
	 uTZxZ6GMRCyJsUWF6YNGnkD7FBfhLonZHmr9ZOu3TwCYxtZ1wn0NKrJunKZnhs4v68
	 BQqB/TEoG2w8w==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 16/23] perf/x86: Support OPMASK sampling
 using sample_simd_pred_reg_* fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-17-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-17-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:54:02 +0000
Message-Id: <20260824085402.76D811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Support sampling of OPMASK registers via the sample_simd_pred_reg_*
> fields.
>=20
> Each OPMASK register consists of 1 u64 word. Current x86 hardware
> supports 8 OPMASK registers. The perf_simd_reg_value() function is
> responsible for outputting OPMASK value to userspace.
>=20
> Additionally, sample_simd_pred_reg_qwords should be set to 1 to indicate
> OPMASK sampling.
>=20
> OPMASK sampling will be enabled in a subsequent patch that sets
> PERF_PMU_CAP_SIMD_REGS.
>=20
> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D16

