Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7420359A9B;
	Sat,  1 Aug 2026 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583728; cv=none; b=ICk9nCfjoD1htbJslJmmeLYE3CC1A8eYzYme1u5NTGNBFvqkshBpo/n9UQeUZs0ADUvAVwM4vsWnuCYXyj0GNUFJzxAhxZarI522Gfu3HnLnfQiYiEs/06d02d8PyNG680cf5EE99SS1gIZpgdkO0QMe+DyCUl+kSDWIP+rf8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583728; c=relaxed/simple;
	bh=fcnZbbeqljOwmjnfwamAiamIxrC/pATHemwzBgub2TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dj82zoJnOPd5Jn4ijZrmBtlkl4GhquGMlSVeQdYkk+TeGhh1f8GmsbSHL3n7xptfbRXVxrye2hv4n0Ep+UGUCakVx6W37gv5zWd/wGM+Pi6eKX/W6KQ+UIb+6brUTltAtplxaWcAGqyHN89pF9gCmkkBBzkQgrfiC88liV3mgVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNDHhV1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNDHhV1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008441F00ADE;
	Sat,  1 Aug 2026 11:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785583727;
	bh=8NltONilZ9GycYIdkxMP4OoeJI6kGzsHNsdiT8Ul84U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MNDHhV1nD1XnRgFmarxfgWSy/KNHCUgDwqfve5p6hv8yCl4YL/fP7jYgzaaVxgcZT
	 xO53pg8GSoWVzN46pvycWvlsnDMTDnY7swqk+fVg82a+8orDWb3ge15lXu75Fg8i4s
	 nyMHk4m2pVuijZj1U/CJeCPrcFoJiEWad4wka9/HcFx7FvFN9XPMphJ4oq/o5V4G4M
	 NHPC5WTbcXnEazp4pwKPdwRuulnnzfGwyNyTEeq9DnkuGgnYsjnNpQEeZMKjlI2LLt
	 nu5BNB2ilGsKzIHpXeuxaUnGTmHDt/IR3sYBdhAYbwBG1D3ARjQlMbwu6ITqRvSPSl
	 ZK29vYmgK6YtA==
From: Will Deacon <will@kernel.org>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Geetha sowjanya <gakula@marvell.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	krzk+dt@kernel.org
Subject: Re: [PATCH v8 0/3] perf: marvell: Add CN20K DDR PMU support
Date: Sat,  1 Aug 2026 12:28:29 +0100
Message-ID: <178551108395.325729.8003584070138244623.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601073318.7098-1-gakula@marvell.com>
References: <20260601073318.7098-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 01 Jun 2026 13:03:15 +0530, Geetha sowjanya wrote:
> This series adds support for the DDR Performance Monitoring Unit (PMU)
> present in Marvell CN20K SoCs.
> 
> The DDR PMU is part of the DRAM Subsystem (DSS) and provides hardware
> counters to monitor DDR traffic and performance events. The block
> implements eight programmable counters and two fixed-function counters
> tracking DDR read and write activity, and is accessed via a dedicated
> MMIO region.
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/3] dt-bindings: perf: marvell: Add CN20K DDR PMU binding
      https://git.kernel.org/arm64/c/6e0aa591af99
[2/3] perf: marvell: Add CN20K DDR PMU support
      https://git.kernel.org/arm64/c/9b551a2446b2
[3/3] perf: marvell: Cancel CN10K DDR PMU hrtimer on device remove
      https://git.kernel.org/arm64/c/7dbcb0268d1e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
