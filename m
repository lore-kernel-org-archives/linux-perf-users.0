Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF102505D6
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Apr 2025 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900081; cv=none; b=h6MF7MB27gvCPvHVZ9lcAW7icSkUQR+YkawNfUdME1gyayUKwfyBzwpVPCH8ak5xX6Ap79Bq705Cco2p2wGZBQZ1bHS0VBdg83L3OG1hS1IMDU3Noy4KAAIESYzHgChMyFI45x4W7IS7BXd06UjgVyQ6sJuhEye4RdgdT3wcccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900081; c=relaxed/simple;
	bh=4QZa76aQVeUrvv/haODwV1QVCs92C6wzHtacRLOV6Xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tt8LlUXWm411F5XT5jJ87EoQvYvwGglpyxEm+Aj6I8Z9OjyqgTE7w4bBbt6xY4m5kMQwaXYb0sD6gvQxrf5utadB3WQ56t75TV6IvIiap3dXzNWyr1EtSD+sa4BKuOWqVFnSvJ60d14lILcCBTf5Wt6lqnMdSHtlTbGY2qM8eto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7X34SRs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7X34SRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8DAC4CEEA;
	Thu, 17 Apr 2025 14:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744900081;
	bh=4QZa76aQVeUrvv/haODwV1QVCs92C6wzHtacRLOV6Xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7X34SRsqWuAsvh1MD93u+CtR0mEzYqn2mPygAB8lpfi8U4GogitbURImVBL362LR
	 xQCqZLUD8UwOTrXT7OnTXQcuBR2lpKaHU1XMwObKbXNIPGHFNPY4q/1yKIhJuRb45d
	 GafiOQcXYRyjKn0UUlF7FH9ocVtXBqEcGWrZPh3F8xGXNYeUZxFrAlHWq4HltGGoXy
	 +q8HkOYWu811vJUTgBBrMlXeJJK+sQ3Wq5Dr5hQ9ALqfRgZQnjS4fHdMtdTrE/Ib9t
	 GgXLiCGVhfqCTpbH3MD2hYEvLZTYB/1kkgvODjSXDCDkkTMf4s4E5AOft4V53lUceG
	 FVzH4eNX5/Ggg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH Resend] perf/arm-cmn: Remove CMN-600 DTC domain special case
Date: Thu, 17 Apr 2025 15:27:31 +0100
Message-Id: <174489529052.2689886.10372399448394123853.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <67985e39f53b56385d79a4f1264cf7f9cacedb58.1742308248.git.robin.murphy@arm.com>
References: <67985e39f53b56385d79a4f1264cf7f9cacedb58.1742308248.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 18 Mar 2025 14:32:10 +0000, Robin Murphy wrote:
> The special case for trying to infer the DTC domain for DTC-adjacent
> nodes on CMN-600 is fragile and buggy - currently resulting in subtly
> messed up DTC counter allocation - and the theoretical benefit it
> offers to a tiny minority of use-cases arguably doesn't outweigh the
> inconsistency it offers to others anyway. Just get rid of it.
> 
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Remove CMN-600 DTC domain special case
      https://git.kernel.org/will/c/674cd7740257

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
