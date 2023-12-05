Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCDB67E92
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6OEGV3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A59C433C7;
	Tue,  5 Dec 2023 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701789407;
	bh=jq5y4F+MD6cK5ddPvr4GODQOw/RI3b2M4ZVyhad3PW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6OEGV3+J/iTPI2llA0C7IC9l8W4GQ6k/Kd+RXoO8DjudrmJAURNFrRxRz87lMm/Z
	 ihMI6C29CdhLvdUpxpAKIl0Jsngnf1+4HU9rAY1eOkq1GvBJuP4xfb6W1IypVFIjFI
	 m0EkHVKY1GbYMslqfBiphJX1MikIBfQOjyx6AWf2VpNFcC5iC8A3WKio2b/pQcz+M5
	 8v/Q/Jl/BpEAehldpJuYJCEdjY8nwtyxuOe37nOvxJsuZHlkYVrmggGHa4aCz8qSo5
	 Sje9jnMscOfMfse/Gq+oZwEJpbCN7rh/8MuyOIp8iQzOZPU79fuLbYewDbkMcNsqT8
	 RtWq4JHp8Ab/A==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] drivers: perf: arm_pmu: Drop 'pmu_lock' element from 'struct pmu_hw_events'
Date: Tue,  5 Dec 2023 15:16:27 +0000
Message-Id: <170178008886.1061392.10642726925666459219.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231115092805.737822-1-anshuman.khandual@arm.com>
References: <20231115092805.737822-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 15 Nov 2023 14:58:03 +0530, Anshuman Khandual wrote:
> This series drops 'pmu_lock' usage from all arm platforms which had already
> been dropped from arm64 platforms earlier via the following commit.
> 
> commit 2a0e2a02e4b7 ("arm64: perf: Remove PMU locking").
> 
> Afterwards, drop unused 'pmu_lock' element from 'struct pmu_hw_events'. The
> series applies on 6.7-rc1 and has been tested on arm64. Although just build
> tested for arm platform.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] arm: perf: Remove PMU locking
      https://git.kernel.org/will/c/5cd7da19cb97
[2/2] drivers: perf: arm_pmu: Drop 'pmu_lock' element from 'struct pmu_hw_events'
      https://git.kernel.org/will/c/118eb89b1e7f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
