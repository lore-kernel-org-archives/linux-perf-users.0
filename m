Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A182EBDF4;
	Mon,  8 Sep 2025 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340098; cv=none; b=lUkzky5txPa3Q4NhmBiZSlhJy+uGoiD8jQTEsUkumt7916LxyYAhvlk28KaDoSmq6dn60unSJPjLQvCDwZO6Bo5qlcTHHV+PBsan3olK68d4VCfpuZnqymllGx4XQOVfb/1VHt9OnPTMxTg4CCX52edz9CPOt9SFDvnwPEDHmaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340098; c=relaxed/simple;
	bh=rX0FbXwgpvRNNI/2UkQ8kqjFikT1nbRId3r+WqD3Yz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWEaQtl2e4GymN4hlhkhJZace1OwedM1FV1YtESQP4Pe5B7f8izBrgigi8H3uqTQUnpvRWPVDT0zKcBvuKsjvJqEtO6kRt7x/Y4AOXa0TnSXsXQ24pX2vwt5bRLyx/pw4kr31HozNMa7Pb74PT7BoCG77dPMgIuROZHSM0gbU6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZnvjZ/6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZnvjZ/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B4FC4CEF1;
	Mon,  8 Sep 2025 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757340097;
	bh=rX0FbXwgpvRNNI/2UkQ8kqjFikT1nbRId3r+WqD3Yz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZnvjZ/6dgon0zsoULePF5c8f62g8NAPL6JWkKXEMW+rTzzOo/B6eTVtOChBRUZ2v
	 BzoEEfbqIejDwVxlD0jCkQOQqeBrBLUkVPLKEcsr6kgbVH7Dg8rk+aEHKGO0yatpoV
	 HJXVk6PigWEBgxmG2G+Kz1UoHsjXyn5T3SZLkxftWl27M44J4l2siBT2FizGpx0Gz6
	 wB9iuarryw5uO2bE+K7STq6QB/4cBmn1n9KYZlO2HqKu7ozPMDlmMgeBo4XQFlC7jg
	 eFYDIr23rW4dRi2bVFhjXKWwZGcXVlmW5jeoj+P2MP14r9Am2OrnnnngEyqaaCjM+C
	 r8K6wRtBA4OfA==
Date: Mon, 8 Sep 2025 15:01:32 +0100
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alexandru Elisei <Alexandru.Elisei@arm.com>,
	Anshuman Khandual <Anshuman.Khandual@arm.com>,
	Rob Herring <Rob.Herring@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	maz@kernel.org
Subject: Re: [PATCH 2/3] perf: arm_spe: Disable buffer before writing to
 PMBPTR_EL1 or PMBSR_EL1
Message-ID: <aL7hvEXjXpoyDCQf@willie-the-truck>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-2-52a2cd223d00@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-james-spe-vm-interface-v1-2-52a2cd223d00@linaro.org>

On Tue, Jul 01, 2025 at 04:31:58PM +0100, James Clark wrote:
> DEN0154 states that writes to PMBPTR_EL1 or PMBSR_EL1 must be done while
> the buffer is disabled (PMBLIMITR_EL1.E == 0). Re-arrange the interrupt
> handler to always disable the buffer for non-spurious interrupts before
> doing either.

Why is DEN0154 not part of the Arm ARM?

Trying to tighten the programmers model retrospectively in a separate
spec is a lovely idea but I'm not hugely interested in it. The driver is
written to the text in the Arm ARM and is going to stay that way. Any
future changes in the architecture need to be backwards compatible.

If we have to poke the thing differently in a VM, we might as well use
hypercalls/PV.

Will
