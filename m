Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AEA25C83A
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505821; cv=none; b=fJkb+ibBPXrVJ87Eaau9IpQWo5CNBBM3aEOJAMrCW6JwCd6pbB4QO+VwznZ4+vuot7uKh2dOD+mnOxngYLMdHSa2KAbzWBOOtP+GcvzuBnXJkUkioIMCRWupLKcuV6McCAtVhripyiQLdrwOSL7voaJ1U5ux3my0w00/bNByMY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505821; c=relaxed/simple;
	bh=VxCykl7yeIAWJjVFGH1guO1tvXM4SvGkFfbkVMygBtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5/niWuWPoYPYXPezF64A+77xi6AT5yJStYK0bgw7dkmYRGwbnTvU4O3MNzQY9FcwtDBkwN22WbQM0cbEhtLNrLq8Ki3s+IA0fLepOG5hs3qNwUImfc1XwSVo2yh4KSs6/+ZVmugQ94vXumaRSskGDWPwA0uzaK9EB4AjtByV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zh8nBNHl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh8nBNHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7ED5C4CEF4;
	Mon, 14 Jul 2025 15:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752505820;
	bh=VxCykl7yeIAWJjVFGH1guO1tvXM4SvGkFfbkVMygBtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zh8nBNHlmLfyFWZsuMIA7Hkw3ddNEz0XUz3Pr9+g0MTzGDdm1q5T3EI5Okq3X0JRr
	 77yWCZl7SeJkREuWJqZxL8vUpynLCTOrqySWKuW0p7ErfpLdoTJP0nkg9yTXFQC0a0
	 /FPnk19mP2fyJgoDhhMMnpxd9nh4ZcYJgJu50u4yf0Y0Rbg4OhFNxN8ZfiwkGahw5F
	 HPqixW+4x15vkipgl04BU0+t2dlX+rF3GYUwc7/LIzvJG+mooOnBiyJG6pB4fXYivO
	 Mh4mzbPp20Zdh1ZV0tXnwnk2UFJo7ciB832i1fvF+G2WYY2WdEfueMz+/FhxP8GbMF
	 XygWhQQ4XStvw==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	allen.wang@hj-micro.com,
	peter.du@hj-micro.com,
	andy.xu@hj-micro.com
Subject: Re: [PATCH v2 0/2] perf/arm-ni: IRQ improvements
Date: Mon, 14 Jul 2025 16:10:10 +0100
Message-Id: <175250207277.1540736.2402817264708558809.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1752256072.git.robin.murphy@arm.com>
References: <cover.1752256072.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 11 Jul 2025 19:15:15 +0100, Robin Murphy wrote:
> v1: https://lore.kernel.org/all/cover.1747149165.git.robin.murphy@arm.com
> 
> Hi all,
> 
> Here's a quick tweak to address Will's concern last time (minus
> the affinity fix that's already queued).
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] perf/arm-ni: Consolidate CPU affinity handling
      https://git.kernel.org/will/c/6a5dc6c7534e
[2/2] perf/arm-ni: Support sharing IRQs within an NI instance
      https://git.kernel.org/will/c/89f0b9ccd314

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
