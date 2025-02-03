Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46834211299;
	Mon,  3 Feb 2025 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610127; cv=none; b=GUz0dn0m9LNhCCdvC5wN0ZLR6JDRXP1Hg0DooZmppgqwn7SgSm+kaJr+o7+I0nHHAhsol3T2VkvvPx45G+lFgfAydzlG5E2Hk3Or8S+BOGrc3xuGA95W+1sVtsmThjnjk4qLIQnTkXxvHXx4rZCTcJImRAiHLvPlOz0465QLxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610127; c=relaxed/simple;
	bh=KSPtOuW3Y7uccCGPaz4N71aPVV/qLhJF4x/HtTZprdU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tGbj8xO2CTNtAFiuTqIHVqoMzbvUGcQZqpW9gJltTVI9BqXIg8jNrwONUQszFTkYI0B1jnmLxNOMc52lztLkxpj52Aw81LfxJb3g9sHBe3vfzfdfy32twG7PI+a18jS2XLCyWDMiQq4iK2dyagrQmDY26M3y2z/UXlmHEvDAp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbsokPPO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbsokPPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202F2C4CED2;
	Mon,  3 Feb 2025 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738610127;
	bh=KSPtOuW3Y7uccCGPaz4N71aPVV/qLhJF4x/HtTZprdU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gbsokPPOVbAr+hxpRjIjdqcnKS1OFLw8GFFoluTtrExBNLY5rOPJUKQYmgP/AeWE/
	 UFHoJ2hP4/KozSthIcub+Hg0FdVir3qx/B9fqaNV2LwTjw3mt1EnxlIVMJjizpaUfq
	 2vvdT98DmNVkppjCml1GIvQK47rCZm95Fve8BN5c1d6FMoOQ7g6TpZkhelj7Tpqdra
	 3xWna/9xhy4H9t2pH3QTgoYWCwOr2sNp5ffKSsRpJrgZA2DZlnLqDlt/x0lqq3GWKQ
	 Qyx9L0vSC/zdLO9fCL+26suauKkZGBikBkdRtR9l1IABnxIfgTKGLpmKlDbw0duHzp
	 nyGju3Agg2VOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CC7380AA67;
	Mon,  3 Feb 2025 19:15:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] tools: perf: tests: Fix code reading for riscv
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173861015401.3409359.1963171242133274809.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 19:15:54 +0000
References: <20241219-perf_fix_riscv_obj_reading-v3-1-a7d644dcfa50@rivosinc.com>
In-Reply-To: <20241219-perf_fix_riscv_obj_reading-v3-1-a7d644dcfa50@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Arnaldo Carvalho de Melo <acme@redhat.com>:

On Thu, 19 Dec 2024 13:44:25 -0800 you wrote:
> After binutils commit e43d876 which was first included in binutils 2.41,
> riscv no longer supports dumping in the middle of instructions. Increase
> the objdump window by 2-bytes to ensure that any instruction that sits
> on the boundary of the specified stop-address is not cut in half.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [v3] tools: perf: tests: Fix code reading for riscv
    https://git.kernel.org/riscv/c/0f9ad973b095

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


