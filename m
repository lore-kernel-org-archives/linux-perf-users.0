Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03B215CD7E
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Jan 2026 23:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767741191; cv=none; b=TI8dup3mXkw93saSlPXDC3jvXVcxDdRZscHMwoXF8Fs/WG8r4MO748PXbxWTSVuQjD9Wxl+nIXzhqg7j5ZMpHc3Ssc/k6r0WyVtX4AKziqREgnC6yJ1j/Rx0/dHtnTW7VLrKvW0fcuGuuB4J7/wFKOFLHxZwIhUf2JgQsP9iv9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767741191; c=relaxed/simple;
	bh=HyAPnTEGY1lFrvxzTIN72RXJrOV35G6AS3aI5GAo/60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eswqMKmPIKWOG7JVpiwJuLWmLIwbuyQL/Kt1Hzd8iCwTcG3JcPEe37p5YJmaWxLke753sNPLiJUDsTsHJLdN3Nk3TqVfYptNrFfyBR9WlCMJ5j9JApPLXIrz+Vf6HvoATN0XTBbKTGuS+ZEs7FX/rm6zcFaZojhE9OmAz1o44Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAtRDS6e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAtRDS6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B94C116C6;
	Tue,  6 Jan 2026 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767741190;
	bh=HyAPnTEGY1lFrvxzTIN72RXJrOV35G6AS3aI5GAo/60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WAtRDS6ejQ6Gse9FCW6w26JcHDfzluf/B767GLKSjdnPfasYmdVuKgxZgrNaJkzUa
	 g5h5605L2T7BLcLwsrZCGVYqW9zygce9EsebLUMsZwo1wjPms4JAZtQe4uV730j7Ma
	 fi68ZH45sA7DqXWIv8dfUeHn5D3W6q9kiGak7Pi6Ke3+pWEfPSuMwOFapBk6bWbYVd
	 nfBV78fvBy/2mVFRz/JCJC++32/jp6S6Lw+V4+dzOzktrCGtqYw+UhaF64W3EoK06f
	 Zmt9badtZZsN9otvEX2WIV68mQhu9v+YSxOtgz2GIGUABk4WME36OiEHqTtVZS/u47
	 g6muMMJwlFSbQ==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/3] perf/arm_dsu: Support newer DSUs
Date: Tue,  6 Jan 2026 23:13:02 +0000
Message-ID: <176773486069.2610441.14881091386712987325.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765802897.git.robin.murphy@arm.com>
References: <cover.1765802897.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 15 Dec 2025 13:04:57 +0000, Robin Murphy wrote:
> DSU-110 and 120 have been out for a while, and although they continue
> to share the same basic system register interface, they have subtle
> functional changes that require a little attention to support properly.
> And while DSUs still aren't widely exposed in current systems, at least
> some folks do apparently care.
> 
> Sanity-checked on DSU-120 in FPGA, and original DSU on Rockchip RK3566
> with TF-A hacked to set ACTLR_EL3.CLUSTERPMUEN.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/3] perf/arm_dsu: Support DSU-110
      https://git.kernel.org/will/c/0113affc9101
[2/3] perf/arm_dsu: Support DSU-120
      https://git.kernel.org/will/c/85c0dbd8b6e2
[3/3] perf/arm_dsu: Allow standard cycles events
      https://git.kernel.org/will/c/79448fa1f495

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
