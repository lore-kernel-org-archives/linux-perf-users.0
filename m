Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940352;
	b=X/hhcBxPju6U0h+dUp0Mp85RI/niZdkWnChJLMsUlB7PrvVg2S8UCzn6yAail6Tek3Hn
	 4usP1+Z3gi3sA5Szyp6jeSdhytvgQop9Enz5gwms06mKiANcAGA4zcvz/NJzf/qFl5/7p
	 8DPbwedG44bee7CJJPXKuGmpHq3NLw36TLIiodFwJY6wwBv8PeTgrx30Ith+d9698YlmM
	 JkWFFYcwrARrrUIqkTR1/vkk3BmIuM1m7fLcu0SGbM9Eh6ZQCDWua1yLr1kSrtFjJrmAv
	 O65QLWs2jkbloh8Isjz4bjVXAF2hdqLwK/ecRY15yCflsjsRExD7HpJaTRkcdIZbqVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940352;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D0oWYoanJZguit2aHrNq0/HH2d1LVTVteDEZYfYkXiQ=;
	b=H76vgpOtFepG2yfPqnU1wAS0h9ZlcZRsjPgo553q07OBeceRk73VQgE9zYXE5Q9RxQrv
	 +o6rjQ8QxLkbwW50uwCiYuVOBEmHmwUE1W2neNa84tVN3KCfON/zQFT8yXG4EJVN0JhaV
	 Ow5yNarOABGtWiYO8Ax6jWJW9f61LtZ8+a5e6SlqpaQJBzamgLJYcUhi7WsiIf3kOcQXf
	 HPhNHm2E+KkemfMuTf4OrgQiwviGtVpyEd/ZSXPmA54sPsfT9/4oACr4nLIbiDQgJ/f+a
	 Laml1UyD8uWSFUoryC4/yLzuxlRgWa0q+K5JMJDMW4iyQRFLsO5U2Le+keDy33Fd65w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djFp2LOo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEDE606A32C
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djFp2LOo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C651C1F0089F;
	Fri,  6 Nov 2026 04:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793940352;
	bh=D0oWYoanJZguit2aHrNq0/HH2d1LVTVteDEZYfYkXiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=djFp2LOoceuUCbvQumqaWm1l7Zf1BGGVVvi/hsKDp8UJ7/hqtPFOmoyG4aLZeWqR4
	 L+dQ5KRLo8Hr1Pr3I55cCgZbZ/4dGhKgLjzAVsAKy3W6kFTh0o7Qx3GMcaqw2fimGe
	 uk99Y6APzPmCo8I4NIrWkguvpyGTtlevZc5xP87kg+cvnJQBtelGUCudwkZlf2l4Vp
	 YpTOMiibrcPHNeQaCPwhYXJBqrPIEH2ooJjYcWCLsfDw2i/BKzozJNfUY5q8w9TWNt
	 XhQytHX9Avt2U4KpiTAhbTQ3XYeWCeV48qAiFgOnFyF/K3/C5hWyNVWrPluYhMuQX8
	 1Zvxc9gI14Sig==
Message-ID: <sashiko-outbox-200757@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 07/20] perf/x86/intel: Add helper to enable PMU
 without LBR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-8-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-8-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:45:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Currently, __intel_pmu_enable_all() also re-enables LBR in addition to
> the PMU. Split out the PMU-only path into a new helper,
> ___intel_pmu_enable_all(), so the PMU can be enabled independently. This
> helper will be used by a subsequent patch.
>=20
> Also remove the unused added argument from __intel_pmu_enable_all().
>=20
> No functional change intended.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D7

