Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F33B2B2D7
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563555; cv=none; b=VuHqxyvU5Oenyz7RpM2Z0Z56YKxWxA4mxSXcnEV9BYZUVWL+ePzLcUNm32zPq1BVqj3Dyz5WUN+yc9HOSFOkKdbWfVkxKazh9qTs0YFNBrAx2FO87fO/MtTeT+mpyazkYQGPoukKr1b+2QIfXznKrcEsuylzxwoU5EdPGXfmvbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563555; c=relaxed/simple;
	bh=VyspgLK1sKiMpYAP6TKNzZY2uLh2iqmSmE9CxJHuavw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LkytBMAgxnTsune3j12XtsxcYELz+lu4sIDV2uC8Y2+joVJJfnmmHtTMON89/Y2890uhEv/Sey+JMcp1ymKh6VGwZJFlUJwirmDYSMW+lwBb8O4S3Kfr0WUpaJYTDxnzcmIbuW5JhKmYQmZ1c+c+g33G3w5nTE+js/8jtOnOpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dz5WrV+b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz5WrV+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79601F000E9;
	Mon, 24 Aug 2026 09:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787563553;
	bh=VyspgLK1sKiMpYAP6TKNzZY2uLh2iqmSmE9CxJHuavw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dz5WrV+b9pDrsciC4yWZOtqAajJtB6CpFa6/vOC3rFw985bcsoCTqHLmi2oFZo2yb
	 j+42U025MAiCSQCc/QBwLueS+vdtqrOVsyPoRv0jMqiF/X2LqckjdyqFRrRmTZC9bX
	 zSuBnUtTpAuvtibE7RnZEKyiQn0L8o8Qk3hjHhk28+n7Jww1XK/+AQTjItR+oOPYn1
	 zt3EJ3ypr4hMq2IfSSYzowO+rrLf6CyBUWAqIkllGh69klJCRFjl9nb6eOZwv9Ms8l
	 B59xcrF6avRzes8LN/+p/a3hQ4d7rBs/8nn60v6lc6Yt6As9sE0aRzxpvIA2wxmE5i
	 1q5VeM+RVs2ww==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 21/23] perf/x86/intel: Advertise
 PERF_PMU_CAP_SIMD_REGS capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-22-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-22-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 09:25:52 +0000
Message-Id: <20260824092552.E79601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Set PERF_PMU_CAP_SIMD_REGS once XSAVES-backed extended state beyond XMM
> is available for sampling, e.g. YMM, ZMM, OPMASK, eGPRs, or SSP.
>=20
> Keep backward compatibility unchanged. When only XMM sampling is
> available, continue to expose only PERF_PMU_CAP_EXTENDED_REGS. Expose
> PERF_PMU_CAP_SIMD_REGS only when additional SIMD/predicate register state
> is supported.
>=20
> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D21

