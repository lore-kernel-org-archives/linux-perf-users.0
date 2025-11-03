Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3333432BF25;
	Mon,  3 Nov 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181886; cv=none; b=XziZUDN6aUd/kheEDsnFCv+Rtjwv/ozQ2AylSBBrAFohaPwkuO/+KC/WFhCTQN5OciHFh3WEwWIbOYmguTlH6u65AiooVyFrhjUAG2FwUFMeX0BjHO/clJxLQg4yKo19GVVnF+Lfx3ME6eTkNFTuZCDEOpy6q55WBvub3v+c2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181886; c=relaxed/simple;
	bh=1y8nyhLMPDQthRdVRLcjZW6GOD7VlICRZa0k7+ilTrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1QWKboqTNKajXb0c9PaKd0cZZXgfrqOotmaT9xDADjZZCQyo0TGJGoOQVPb+Ykj9VORhx8812NIp4qtBJ56ap4OI4L6zTvXYjwKvrBgCk/RJUD/AlT+TwmZ3+YOrL7GxPfGz6L10V4SCpbdBHCe0lyfLwKMQQyGdx+JOwjRRNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCfnTOJL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCfnTOJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F8DC19423;
	Mon,  3 Nov 2025 14:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181885;
	bh=1y8nyhLMPDQthRdVRLcjZW6GOD7VlICRZa0k7+ilTrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCfnTOJLfLYbFN8gxf8ljTASem2Tu+fAvmEW/uOwwSoc0ga4ImCQV6ROb2zk+ESCY
	 zlH4WPE7jnsRp7F8ony9MkHgiBW+zIQgeQwsmJtm8k/Klst4IwFfm9MSLCN2EAgjb/
	 HjIme+3dr7vQodUv2pylktxuRhhCyLhxdwxjBD9hPUWPq3dFuqKzl0+peF7GDcy4To
	 YxL4PDi6L4leuWZG8ExJjNMIcvlDK5TLS1H8PrVPU1k0QTqHNNYhOIY8cvorgeZV1C
	 JBquY8zJLgCXoTHcRB2IJz4YzNw+L5kSjq2ZBqICnoq+4zPWqyGNBSHNwuRvFrrA8k
	 ExmZBWC7n421g==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_pmuv3: Add new Cortex and C1 CPU PMUs
Date: Mon,  3 Nov 2025 14:57:48 +0000
Message-Id: <176217971597.2906896.12399584424760011005.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251029213424.2951519-2-robh@kernel.org>
References: <20251029213424.2951519-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 29 Oct 2025 16:34:24 -0500, Rob Herring (Arm) wrote:
> Add CPU PMU compatible strings for Cortex-A320, Cortex-A520AE,
> Cortex-A720AE, and C1 Nano/Premium/Pro/Ultra.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_pmuv3: Add new Cortex and C1 CPU PMUs
      https://git.kernel.org/will/c/989b40b7578a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
