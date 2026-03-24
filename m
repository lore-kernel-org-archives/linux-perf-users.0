Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD440825F
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Mar 2026 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364919; cv=none; b=RzQwQpf9x/DwNiXzZOWaF2YCK5oLAWY1Lntkho/lAfc17CZRAexYG376RurH2pRmhfbsNN2LSpaJyruvJTKSIal3QkyThv5BkPzkcu+wGxPFGWjTIxydzN2hV5w0bggJxNVo50fL+klnQYpxj8bvqToSOm/2F0qNUgpxkKntr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364919; c=relaxed/simple;
	bh=R5VUYltBEr94rWSSuVChVaVVO2Zl0GJU4okLo9Qlovo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pt9p1HuaDhYPSdhDdaDjXKUspV7ubro/r3sjrakBGkQpOQxwIq9dl0w1Yyl/IJuvQ6RFgmWJWjDpV7F7JLPFe/T5aAa2D2VD+o6wfKP5hfeeM2i6/mO84vZWwQYOyOz9F3KTSVrQpTwyT8zuIV3d8Bh9znQex7lQXoWTstz+0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2ok6bOm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2ok6bOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E61C2BCB5;
	Tue, 24 Mar 2026 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774364919;
	bh=R5VUYltBEr94rWSSuVChVaVVO2Zl0GJU4okLo9Qlovo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2ok6bOm+/aGYswNyfwaeNrpvKCxoX9hocW1DxwQZX4AuYvNBs+Yp/aLS8FG5fov+
	 mYeWkocsxA1uuLV4royRTMCt3GuXYsNOicgc5laHOzoHkC0C3bfnRmitu9Y6MXx/Ud
	 +ThtpUphDGysfH2iApq2048ytvxT/Oqt2xqZZW2jBJ3ybx4eZwEZtN8rFZ2WBLiILu
	 lS9y0w1o0XF0P72hUbKgF4g8uoaz+vQHplvbWtXwj/uybXsU7OwHTgwl9FvxkMi1VM
	 72F80z/loirGTkIDaP2laJCoKBDjQTulp1hSSH8AokwFSChgttjeqhcfvSRXwITMfY
	 vBCfjdvTQpWGQ==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	ilkka@os.amperecomputing.com,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH] perf/arm-cmn: Stop claiming entire iomem region
Date: Tue, 24 Mar 2026 15:08:14 +0000
Message-ID: <177435570088.1948965.8351460997755925127.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b6275655818f5af7e5fb07a9e18d1451b08b7e05.1771522073.git.robin.murphy@arm.com>
References: <b6275655818f5af7e5fb07a9e18d1451b08b7e05.1771522073.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Feb 2026 17:27:53 +0000, Robin Murphy wrote:
> So far, the PMU has been the only thing of interest in the vast mass
> of CMN registers, so we've gotten away with simply claiming the entire
> iomem region. However, now that we can support other features like MPAM
> controllers for the system caches, the PMU driver needs to stop being
> selfish and learn to share. Similarly to arm-ni, requesting just the
> DTC node(s) should suffice for staking our exclusive claim to the PMU
> features, as requesting hundreds of tiny regions for all the individual
> pmu_event_sel registers is definitely not worth the considerable bother.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Stop claiming entire iomem region
      https://git.kernel.org/will/c/5394396ff548

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
