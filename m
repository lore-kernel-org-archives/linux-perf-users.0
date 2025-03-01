Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848F1D416B
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Mar 2025 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740812739; cv=none; b=uWX3XBtTd3hpKvsUCMkzNOAAspNQmdiUxC/ZJnHMAcqWwCJbSSXHb+SmAC7WxeBDZg5sM4BMkuMEu47mCqnKDqBrN2UsXSgRIx2g9poezs5BOEKwN6axqV2ILmkF8Ayv1JdD3GOzg9LX0ML/IyzHINVuK8PMxLFzDX1gOEiJzEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740812739; c=relaxed/simple;
	bh=wT10qmxPNjhJO3TUiqD0b6InWJqdJHkHlWn0Rozw/jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEqUmUQyGpf8nBiuFfAp9bfLHRtgFYz3V7t7qm60GFqA+Z8FJe3c+uGvkt6i14HkaVXbWt/pqEgjZ+tt1GrGUSgF6CNNEHmAI+AfS7k7EVFA/U5cgtrLO+NLDr4AuflPUdE6GZ1de37nv5aWTjESDGnG+GD8TtEyr14lJocwiDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEgEBU17; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEgEBU17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E51EC4CEDD;
	Sat,  1 Mar 2025 07:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740812738;
	bh=wT10qmxPNjhJO3TUiqD0b6InWJqdJHkHlWn0Rozw/jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dEgEBU17hpmVAOOUI8kKAia6ph4Q9pDyAxnubjACWGjS0ogNVNHO91AbaVqCrSEhB
	 vHq3hSasyrO0zXBcU2VNGJG1lKoMQ8Aj09mUwCOvyAkp+ofJlaXpoTcnSMqXMH293o
	 tNTyIzv0vCZawxrFaH4waE25ZZ/o8VGwzn5qr1UI8feIkM+lLjaQK2QL6Ec1RHNnKc
	 mH3zxfNHcNcT7GYji3Gq09ZyPyWXZ6UxsjDVas1mrrqkhbnEwQco8hOEBH8j5Ao3kD
	 NkePOROWZKQUaxydCtYJEVE6JWL3IAoR/82hha7W37AHu0+A7ZBjPZ/YgS8npSTzUo
	 Z33Cafx5VVCyA==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: Re: [PATCH] perf/arm-cmn: Minor event type housekeeping
Date: Sat,  1 Mar 2025 07:05:25 +0000
Message-Id: <174080632166.3210087.735484296197071169.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <ef46a47fc4ab909093f14b2b4289a4835836ab6c.1738851844.git.robin.murphy@arm.com>
References: <ef46a47fc4ab909093f14b2b4289a4835836ab6c.1738851844.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 06 Feb 2025 14:24:04 +0000, Robin Murphy wrote:
> While handling RN-D nodes under the functionally-identical RN-I type
> works fine for perf tool users using the "rnid_" event aliases, and that
> is the documented and expected ABI, there's little reason not to be
> permissive and accept the actual RN-D type as an additional encoding for
> the same events as well. This may be convenient for other tooling
> generating event configs directly from its own topology data.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Minor event type housekeeping
      https://git.kernel.org/will/c/678a5d3d6db6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
