Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818860;
	b=eypgBU5j8ZJuV7+yHj+9cOITi0/26VMcvz1IiWxegUfDOAwLih+Yr7YJCvOJON7mIPuQ
	 VEjhn+kFigPYNfjeB82ShZZqLINNH51eWU3WDggMDgpo8r16y44nCX2e1sGOpkNRszGNr
	 ibu7Ao2JwejudPa9GZz7vj25Sje2d1admFd/u26NSA3eEC+Lwf5YgbTBsk7zozBZwgk+z
	 PSfUAwPJqW78k04X932nHTw5Zk/M0PECXRbEYCRQSUMbeHk5rdscDc8ry91jNBTutlWwy
	 uAt+bEKHakxIlNGbGQq41Cx03hO/gGiQ8Bk1UTzB1KBg3NWnOpvr1y/CaLplYpdEfkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818860;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hbfRAH47qojiT6dKxq3x2l/yz14osDCgG7xxcNFqpgI=;
	b=s/HAAVYHRbSUCMKSmq/BF+3dWYQuRB7uD8wM8ZWmgZJX/nyWMQ+rcuX7+bWavPRKhCzo
	 +ST0f+snhQHDMcSgRZ02WCeP/B15ecnUQkFsO2KMx/2akdOh+eBENhDkYYPY1waGFJEVD
	 0+T3mV+Pmf//JtWIfgf5PyO+AkaOlF6Mw2jQ7gIZLoKyNpU7l3xfeKuFRh+UdGVuYZZtE
	 nKVvesdH5epjcAEI4SkJMStQz76/MiswLEs2N0CdAH4dks4cKY5OHydn1yIV8XcODVjkE
	 4EQQ1Aa/h17Zx1qr1le3NnSK6oVmw4dZBgne+/E+gnUv/dbzWqzzvUr0mesoJrF1bpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbWLlJFD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDC8606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbWLlJFD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFFD1F00919;
	Wed,  4 Nov 2026 19:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818859;
	bh=hbfRAH47qojiT6dKxq3x2l/yz14osDCgG7xxcNFqpgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cbWLlJFDhXMU+V6j7E/LuwI0hx8orq6pJSv8lhRdpmqPN6mQFEoZaa1BXJ9LFCYtF
	 T98szGsyzoBiBuRwYff7uTd8hIz3Aj8kg9HypjzwxaA9XHMaCeEl2xAR2Yu7aUS6Ir
	 +ECRgjSmCOjAf9/XOG4TXKm4OHV6f9z6hfwDgbfSgpZnqsUOTmd9RahEFo8F1tSTAt
	 3Zwxbz7ui4TVvxK9qBnm6u/sTRG46kdJT8LwQ2R/L4rNFDqXxD2/L7UavtQXlVfuaF
	 UewoSRvjg55uVteGmIafibU/odd4JR+E9Z5gGIsWGv6nxWkW4BXUKUGkytn6nryJ3/
	 NAE4bi6W7wswQ==
Message-ID: <sashiko-outbox-197903@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/13] alpha/perf: attach ProfileMe status as
 PERF_SAMPLE_RAW data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-alpha-profileme-v6-7-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
 <20261104-alpha-profileme-v6-7-63362e9290a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:00:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A ProfileMe sample's PC alone does not say what happened to the profiled
> instruction. I_STAT and PCTR_CTL do: whether it trapped and why, was
> mispredicted, stalled, or was killed on a wrong path, and what PCTR1
> counted during the window.
>=20
> With PERF_SAMPLE_RAW, attach PMPC, I_STAT and PCTR_CTL to each ProfileMe
> sample in a versioned struct alpha_profileme_sample. PMPC is included
> because a PALmode PMPC is not the sample's IP. Killed instructions can be
> told apart by PM_KILLED_BM and VAL. The 64-bit fields are packed after
> the 32-bit version, since the payload follows the 32-bit raw size in the
> sample record: they are then 8-byte aligned in the record, which needs
> no padding.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-alpha-prof=
ileme-v6-0-63362e9290a3@gmail.com?part=3D7

