Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769622;
	b=30VdR5KcmgZwS9Ffs/JpaOzmLsJ64eC7CJ69ufJzX+SymMeY19Q0s7WghLVScxDsa6Sk
	 5FYgmhwQ3w4B8BOBEcDA8CSHehdIocX3NI1N0AyXuF/dtlZ5IQi5QQ5BreJfMkk3LLdkm
	 M71iA9M+KofJdUoJ4CXS6xDjk76cR2EEOG4zoMQh4r3qnr2GeoyOyRwNxteKr5eYOr0Ci
	 g76LwH4hdVthrUfC8n3r+unc3GHQ7e23n/zvGpSw8gH08y22snYONveAborvIQ3Lblu/V
	 WsWTzs/gVlR9jpiDU8+rUPBiWEENZb9Al2dwyqmCO3PXsYk4JwgZ/xp5PSk16pAfPGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769622;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ti6OcU5adnGENIngZ2g5rra4h+RNuFTfNhq5mDznP3w=;
	b=eD8E97TkILoXTHF64JLwRqBZcABfdFUDhhgliR4p+BT/ymNRDwi2SuVVMtCgHSbzezRV
	 vrp48aYwt5amZb7oCOPRtIE+CubAt2E3DkdEd3TbsK604tEumCpBXbidSNGTmVryMMtfh
	 sYnXbc99KgCR7sRQvEmOrzaZ0UTjJebXuYu84KO2gLCm9NrCcjaP8v1Thyl2CNE4Fcj+M
	 ANxqgMDBm7dKH1Za1s4PqQNC7M6N1mcDasG/qLJIYJew9sUUi5GzNFQL4ecznDAzUdu+B
	 0LvMRR752W30voMv5BUiyzGWu8FiYqVyOBwcjrU/PwfzS9z3zJR7ZIyxbnHWuI9vOcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Si4RSN5x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1B606A33D
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 05:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Si4RSN5x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E7D1F000C1;
	Wed,  4 Nov 2026 05:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793769622;
	bh=Ti6OcU5adnGENIngZ2g5rra4h+RNuFTfNhq5mDznP3w=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Si4RSN5xUdJzaowuul+KgTfn++8xsBZ1RvRoyL8vsqstr96cvdVrYBIj0joeqNuko
	 QboJ6qBG+6DcDC3ixukYruUqz4Q36csCZUFAT62lorihZvqFVuS4mlkFFgqCJNP1F0
	 xWnXDiNyMa7hts1VxdeMX6Y4kGXbX2VfD8kYAv2bpttFRhMCLrbqcr3rThI5lRquFu
	 7rVL8GhosTwAqRlEhGKsKxf7mGVqI26n0Gh94kS5HkXZtGUnczGfKM2UGsQLAcUogm
	 xgpUX0kF5rIvwii1l/rcCy1Uh9gBxgoFodpDRpu6boqVRmKiu8sgohTCtkbbC686Rp
	 TGnWUjfsBK7QQ==
Message-ID: <sashiko-outbox-196673@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 27/41] perf mem-events: Expose PMU init and name
 formatting helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-28-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-28-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 05:20:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Export perf_pmu__mem_events_init_pmu() and perf_pmu__mem_events_name()
> so callers can initialize and format per-PMU memory profiling events.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D27

