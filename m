Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004340;
	b=45Z2qvVlJadlpQG0dtquZfsxV5lQhjcAru9d0nYL2NSmW78d1RcxhhDe99Qp3l8QmEXn
	 pbWq34dx+eaoPSCOsHGdodpwLzVkuLdu/ZkZD21Fdsm0l5eCReWkX3v60DKrX+PUYCid0
	 UHH0Tf+1O40ZpX5Kp4SuzcxO5rPbBVtGull6bSReLGkps7Dw32f93ObgvyPF2N41AuWiu
	 XnB5r5FI4bZ8DDNg9vm7ZvPnh8HDMKTAPWoeAjoAT2oNdF+MAesUaU9JQPyD3Wen3ACH4
	 047+WBa+nVy6HzoyHoYUFiHlfCjzzZdUJFIvf/tGb69Xx51Lr/FySku7+p8Mk6SCArQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004340;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=65ObRe4mdyCiCGlDp/Xa/bqCkSZyO9/sXwNa2q+1R2E=;
	b=Fpf48vggOA9fFCo2/+3kedW7SFkeBwOhcHqbBuZkoA0FdxXUkh3OX3NU7KZcEf76dXPz
	 sofIow6ZksBVnOgIr7BdRtqMYoh39EZ4m9Cf5UYq1mhk/f59jVw4AbxwG8pPN9lg6GDJb
	 oj96IYZ3HQUiHzyZTYoObi4RRhRU2euyWp5xrwSQZxXZi2NNksALvgAmtQ09YdWsMmhrp
	 BcaG2mJGSeFR1Reys/LnYQZlOf4ZwGMAD0oqvpfwvYPt3OEH+aVv9nNkz7+fauqWfjVzu
	 zHtdJhsJQ9F7q14URwW0rvix8iPNNVqo3dY9nGUAU8B0emG21olL24RNSKQkPFVzeYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtcYXsRo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF679606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtcYXsRo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5141F01825;
	Mon, 26 Oct 2026 08:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004339;
	bh=65ObRe4mdyCiCGlDp/Xa/bqCkSZyO9/sXwNa2q+1R2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZtcYXsRoK/SZ9aWhVCcvzjZHf3Gyb4i1+wc2CGjk0zgsYYNUBBqvdzSVNw7UPGD09
	 ksmLY0sGA6tGHWgiBrJmQFMQywjCoE3K3trAc52udUiDrKfyVrBLmTsYJ/gpCoGHtW
	 cdABGeIMSveUvJknKqtji7ucoYkiCJZJ+t4FLeOdwFmRTc39QhSpiXoTAWcz+OVUJC
	 +5OhZQb76xXaijccik4o6MI7rzhJxJS15NvhTXlH1ZpZRIWC0M++U+w4mSz65Gt28A
	 tRDJ05ykYGZ91SGow6haRkABk/iuGdkMl65GIFchs6AKDcHv/20A2sLFUfkFpVIBOG
	 pNQj/OJ6DqXZw==
Message-ID: <sashiko-outbox-184686@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] perf: arm_pmuv3: Add pmuv3_event_implemented()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <23ffe461b8d7b04f78118154dfc9ea1d2a14978a.1792989860.git.aaupov@fb.com>
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <23ffe461b8d7b04f78118154dfc9ea1d2a14978a.1792989860.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:45:38 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Drivers outside the PMU driver may need to know whether the local CPU's
> PMU implements a common event before relying on it, for example a trace
> unit driver checking that the PMU counts its external outputs as
> TRCEXTOUTn.
>=20
> Add pmuv3_event_implemented() to the arm64 asm/arm_pmuv3.h, next to
> read_pmceid0() and read_pmceid1(). It reads PMCEID0/1 on the calling CPU:
> events 0x0000-0x003f are reported in bits [31:0], and the common events
> from ARMV8_PMUV3_EXT_COMMON_EVENT_BASE in bits [63:32] from PMUv3p1. Move
> ARMV8_PMUV3_EXT_COMMON_EVENT_BASE next to the event numbers in
> linux/perf/arm_pmuv3.h so it is available without CONFIG_ARM_PMU.
>=20
> Suggested-by: James Clark <james.clark@linaro.org>
> Assisted-by: Devmate:Opus-5.5
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792989860.gi=
t.aaupov@fb.com?part=3D5

