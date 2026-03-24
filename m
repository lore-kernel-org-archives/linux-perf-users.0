Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1A3B2FF1;
	Tue, 24 Mar 2026 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332464; cv=none; b=KFiRzMBUvOudOWCKo7L7KHxXcSU7rK8ziKKmgQSMAjLBgKYHnd4/NuUORI2u0hqepEYCUUf7sTY6ADbLH9/OIaBPQi3div6YtQ3TdQjHp+fA5k+bjbpDjfcOMpULl3JlfEQ1AxNXmYyAMIhtdBLoQmnfwMtlaLB2WStuGElzSwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332464; c=relaxed/simple;
	bh=qbtmamIzBSBJ7lpyvZvoyrHXaqJIdPVwSL2Ans8iygw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qqm+6AejLc0wYbzTXQtKWSCMh0PVFh03rWqH9CfYX+a82kRNDA0f5G3+kl6uBRS0VIzS4Nf/O0/Zq3GlMBfuLH521H7QDZ7PzGGGhoce+ht3UgVMc/nqlLNHyPD4Ggz7b9BxHBBjfI7crIacJYYLnRYraEiP13HUt1Ri/6/QK00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T25GCUMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T25GCUMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F80C2BCB2;
	Tue, 24 Mar 2026 06:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774332463;
	bh=qbtmamIzBSBJ7lpyvZvoyrHXaqJIdPVwSL2Ans8iygw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T25GCUMXCJbgJNXbwA+0n5tbTiAl//E0VrJFT0gZialhbokB2EymjYWj2mUVvpoe7
	 4X/cQehNhSFYLbgNYGso68/1gnjInlilS5gkzOuRhP6R3A2ZY5OwYE2S8nKgoJ3mKi
	 iaHaHXNV/rXqHya6c2TBvMpULR87MOI5IqKk7aj1W8mm9l6Uj3B3tb+zEbZpqFQjAr
	 mIZxnNXG1oFfR3uvT0+JZ7Mem7/qpcZdGy9+5M0ntGFakAS6wazJnm4EKpONIs2ywJ
	 Hm3HSib9PW2HT7scszTKUWJbqYweow2uJz50p71WaqwxkHAlQfjsTabaoEUPv/vvsh
	 nmMEt0uJDwm1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2EEB63808200;
	Tue, 24 Mar 2026 06:07:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch v3 0/4] Perf tools: perf-regs bug fix and optimization
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177433245177.469836.2784785880641063798.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 06:07:31 +0000
References: <20260203024356.444942-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260203024356.444942-1-dapeng1.mi@linux.intel.com>
To: Mi@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Dapeng <dapeng1.mi@linux.intel.com>
Cc: linux-riscv@lists.infradead.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
 john.g.garry@oracle.com, will@kernel.org, james.clark@linaro.org,
 mike.leach@linaro.org, guoren@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-kernel@vger.kernel.org, zide.chen@intel.com, thomas.falcon@intel.com,
 dapeng1.mi@intel.com, xudong.hao@intel.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Arnaldo Carvalho de Melo <acme@redhat.com>:

On Tue,  3 Feb 2026 10:43:52 +0800 you wrote:
> Changes:
>  v2 -> v3:
>   * Fix the abort issue for "-I" or "--user-regs" options. (Patch 1/4)
>   * Address Ian's comments.
> 
>  v1 -> v2:
>   * Fixing "PERF_REG_EXTENDED_MASK" redefinition building error by
>     changing the "asm/perf_regs.h" header path to relative UAPI path.
>     (Patch 1/3)
>   * Spliting xxx_reg_mask() and xxx_sdt_arg_parse_op() conversion into 2
>     patches.
> 
> [...]

Here is the summary with links:
  - [v3,1/4] perf regs: Fix abort for "-I" or "--user-regs" options
    https://git.kernel.org/riscv/c/c2e28ae2946f
  - [v3,2/4] perf arch: Update arch headers to use relative UAPI paths
    https://git.kernel.org/riscv/c/e716e69cf67b
  - [v3,3/4] perf regs: Remove __weak attributive arch__xxx_reg_mask() functions
    (no matching commit)
  - [v3,4/4] perf regs: Remove __weak attributive arch_sdt_arg_parse_op() function
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


