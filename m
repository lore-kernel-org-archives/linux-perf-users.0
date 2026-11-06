Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941552;
	b=p1ZgXVvnhoiVHOV/Gqf4VBu2WoQq4zngsdiKxbRCtwj5c7LJEwcOTdgFVtVkL13e/+tv
	 mVUtL8rU/+zDmoq0w0ewAkgtIgAoFKAi4pVkK1yia1oVeMs3Z4/dSAE4PDBOVKDNx0l1c
	 Md7ivy9n9Qiu4/SUY5MhtsvH+vyfIEN9D28ICKlz1KubTON1FgVxO8HGEtTdefDfQQEUl
	 BuVFsrKskABukkGLrNR7RQk43uV8AQCriPkzmQtGE7i8jjOVVsAwKo60zFaBl19qppmau
	 Yf5A71PzddB1mvNh4UseEuC0Z4Dx6KCZzLwRq7bMHBEVUjxioYq5n9p+Lwljja6vdCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941552;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HU8VkCZyDdYD4TJeUv6jYIvKNk3dZgl9bcQu/L2U+uQ=;
	b=1X4jhSs2UR8d4iZTxjijpJ0TJCWl7i9x73cyB+uXn1GSaRM6hXNriHWDAg0HziyLRl2i
	 qB6S6UTFC6b1xTveK1eBdwLB0I2fEZtF6tJ2mTlKWlVwePlgOWNpSSAjeTqWgCT0CzhxX
	 ZvjkMJ9QfhM8aYXT6Y3ldC6kLRU/rablKkvTasGYcYZQKlDzTwypfsv7RDK2u+5Q1f9wF
	 xTYUXm9VG4GLjJf+hJ6GHAEC4nBALv1/Izf3/aa/SqEmTxU3W5ZtaW1dtDaqnVkePwmqA
	 fCnbgAae8bC4UYgf3EULFMKwcVbEk9RfQUCQpAQ1PcmVT9JwVh7syyXrFN26suWEqeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGKHYyWb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A34606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGKHYyWb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EA51F0089F;
	Fri,  6 Nov 2026 05:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941552;
	bh=HU8VkCZyDdYD4TJeUv6jYIvKNk3dZgl9bcQu/L2U+uQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QGKHYyWbVrbzR/W3RAaJY/5phMwmQEKyAWs22vEOPK74xqczg2oANl+qFIW0R4Yf+
	 PNOd6vi8cfqw1uo3i0XVmdf35QA5wcJaJvnVNHjDyJUUuu6M4eB3jyYTwL9tv8e3u9
	 zzGnSRdvtQChjbkPA6TQ7ucRaPYoge4xYZwate9fZdZVskp82eHJgvJoEPjWQxOExF
	 drOw8BcvdJzF+Y/fmCxRlm5HuJymRSbyVKPDTi5qQCQVDzZFfSiZ7f2VcqO3SaNmrV
	 PazzUa5pDI3CzTQOPUqOzUJIQo/wptQjfjP/ykVLuKxyo15wKNlOBvUR+a8nIW9fvY
	 ZDxPobxEyIMug==
Message-ID: <sashiko-outbox-200791@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 02/20] perf/x86/intel: Validate LBR XSAVE state
 before updating LBR stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106043257.842864-3-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:05:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> intel_pmu_arch_lbr_read_xsave() doesn't check if the LBR data is present
> in the xsave area. If LBR data is in the INIT state, the LBR data may not
> be really written into the xsave area.
>=20
> Add an explicit LBR XSAVE state presence check before updating the cached
> LBR stack. Also clear the cached LBR stack when intel_pmu_lbr_reset() is
> called, in addition to resetting the hardware LBR register file, to preve=
nt
> stale LBR data from being reused after a context switch or similar
> transition.
>=20
> Fixes: c085fb877467 ("perf/x86/intel/lbr: Support XSAVES for arch LBR rea=
d")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D2

