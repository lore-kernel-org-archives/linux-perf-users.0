Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4C520C494;
	Wed, 11 Dec 2024 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956386; cv=none; b=rmehXZcEJJUwGwPR/w3O64m19XYEa8DOgfrQ+eyjT4f3BN9waZhCTX8aJfwfEr2QC8JTetWy9r3plh/Xe7FK7tR95qShFiu5GEp59rjCv6RKTS2AzVUQU0BzB1YpiRNKQ0+MCw3PINe1swj8Ko6jiigVcf73/gB+egJVCFFpmII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956386; c=relaxed/simple;
	bh=BQx5g38MiMqbRkVexhZZjvYaNed5OXR/zfHMkJHDPQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AlNAQkC4P8jDGFPAX4LuYn0D9TqvAbqKBor/Rjs004vKbPKAIY4eKT2ZGzo/rY0WDOLArn3LIx5+ls9BQuXcl8Ug7LP8m9mVAIBFKHVk1Ukk22Gk8hvBJjFbC2OIDWVSmepO25402CKLpbpmgsA0q6g9zKA//MvgAzaqXGi23lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inlR6bAm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inlR6bAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CB6C4CED2;
	Wed, 11 Dec 2024 22:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956385;
	bh=BQx5g38MiMqbRkVexhZZjvYaNed5OXR/zfHMkJHDPQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=inlR6bAm7WQYJIQEmpSkRhblsgJZHnayLs4YjKOF+R1EchCBO/2+6ACaOBekxCOke
	 LAAZmH5uSnKupJdGy/u9N17XWtnr7hvZroeu7sbD83rh7qy3rEKoDQRdDGG0/Agfmq
	 6PMrzuEXRAjB5pSRZFc/oKSIL+1IbsLpMhwByfWt3h4KjoJDYJGBmgGDO64c2dsLqb
	 v4fPf7RVPXRcb+Oz0GH5sAh+uiT9oT6swGnR1DKOPLILa0m2uoDikkwbEiNc8LTSLB
	 LKWX4SR9SL1sW74acq+eCy0QZLomZN8OEDnHaYDDKbdXbCL/Ycug8vrlbaoXm06gY8
	 tRyC/PdTnFHwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE05380A965;
	Wed, 11 Dec 2024 22:33:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] perf, riscv: Wire up perf trace support for RISC-V
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395640149.1729195.11467040098314252452.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:33:21 +0000
References: <20241024190353.46737-1-bjorn@kernel.org>
In-Reply-To: <20241024190353.46737-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-riscv@lists.infradead.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bjorn@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, anup@brainfault.org, atishp@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Namhyung Kim <namhyung@kernel.org>:

On Thu, 24 Oct 2024 12:03:51 -0700 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> RISC-V does not currently support perf trace, since the system call
> table is not generated.
> 
> Perform the copy/paste exercise, wiring up RISC-V system call table
> generation.
> 
> [...]

Here is the summary with links:
  - perf, riscv: Wire up perf trace support for RISC-V
    https://git.kernel.org/riscv/c/8c0d1202bad3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


