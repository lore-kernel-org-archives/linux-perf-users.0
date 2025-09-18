Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61BC221294;
	Thu, 18 Sep 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208808; cv=none; b=TyCaSFBs5sDQrCQRMUHss8+0iE0dUXRFxwtsPB0krMDt85Tb6Jm663bnTvLPFlPozyIuKAmIlhcnn8R1D/0L086Mq3BGcFTEVsG9hS3lx+1aIGsPdJwlksn3Tt6Eg8ZkduSUOMCLVNI62v+1H0MDKN9JLCapLQ2Skql7XZu5LdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208808; c=relaxed/simple;
	bh=WtFvBNz1kJ7pD7bo4mQcWpsZ1ssTGarDzTz4XC7qwVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PLjeoxuI6Zow7GzUKdy45xCPq3Vo2fKEzWY07Pmd/GRQKzH6BqMc0gK9STEmYF4RrSq3yA5Cb21mI5AOcVWRO0EmefLoIbHaaC+58jM+uSHj9ylJmLI8OUmZBqlTd0dxGgIRID59EFnqvcSoZ0B2ol19Cpo1iX32ZONc1zqnF1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n49SMoE5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n49SMoE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA81C4CEE7;
	Thu, 18 Sep 2025 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758208808;
	bh=WtFvBNz1kJ7pD7bo4mQcWpsZ1ssTGarDzTz4XC7qwVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n49SMoE5Zt1WozM4r5I7FeD2ewGouOsP2e2IevUVtRyRC0LAPna1MaCaTClXqFwTj
	 7wEJGLQk4Q9BT8ewfa8KTYJvri6JYRmfKnZlhJegGrrzWTORDKTzAsAKwJA4oJYfUj
	 YZY7HQi4xeNpO34JScJdzKRisVDd5jyZTnaxFHbWgtRikFi81Y0onbNtZf8Xpsu4S7
	 4x/IAMmM31spNaQbp0aNwomP8/86h/rm4k8ivzFLkXtPU7pG26flLaaKqVpZ7ftEq8
	 Z+zye+fFsehsVlS5Zyv78mYcNT1sEBb2S6fSLi+HScdyx+7Eyuv3lJypyQ4C9rWVLm
	 WE0TtZ3w/aG3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CA139D0C28;
	Thu, 18 Sep 2025 15:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drivers/perf: riscv: Remove redundant ternary operators
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175820880826.2459453.293698691705893286.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 15:20:08 +0000
References: <20250828122510.30843-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250828122510.30843-1-liaoyuanhong@vivo.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: linux-riscv@lists.infradead.org, atish.patra@linux.dev,
 anup@brainfault.org, will@kernel.org, mark.rutland@arm.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Paul Walmsley <pjw@kernel.org>:

On Thu, 28 Aug 2025 20:25:09 +0800 you wrote:
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - drivers/perf: riscv: Remove redundant ternary operators
    https://git.kernel.org/riscv/c/01dc937ac18d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


