Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CFE3ACEFE;
	Tue, 24 Mar 2026 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332468; cv=none; b=mLYYGW2+nKWgKkjCZaAK8EwybZ11ZSYt6VUL3UQfOKcAUjijm0Nj9/XCBoizDFJzoD6j3ilOy4YjmGR/HdfV7szKtCYzL3pALULOXMlLVcGScrlW+Pt53nXo8/+J6ErmttZ4KL6BUxEBZUlDBQzSr1MVqpiTecnuLxaiU5Nph+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332468; c=relaxed/simple;
	bh=6+dvKOT4g/k0Y///kbeYb81X6mcfuooOow0a3vXI29s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jA0BHAfdeoltnWOISDq2ounFNf045nee0G6TzCPaBoB0M8RkDPaUraS+SqnoRt2EqvLxhTqv0nVOUKNT/OSen19BmqOlw95O21zQKSDEJ8Y7iQtz3H1UIfGmlpDXZJ6er5CFoxBwDYFbGiNBgeeeyc82KVNFEZgciL3oPvayZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/ypJECe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/ypJECe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1BAC2BCB2;
	Tue, 24 Mar 2026 06:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774332467;
	bh=6+dvKOT4g/k0Y///kbeYb81X6mcfuooOow0a3vXI29s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C/ypJECeek5S8XTR2ocF92FlRbSJ2HwfE0y5yOQ06i3e4bmUASX+VJ1yLNKS85vWf
	 ZiH+KDcEdZ7N49IKaVpGPfNsPZ4lUwTiFmeSgtwn4KYdqcjSV2/FGzf3o7OKapXsyE
	 lbNUQu4TTSRMfh9MZ4ed/OBBomg8FbyS3cJBnROn6HtDNHw3VIaQ18MUwwdNONfpIk
	 npFVs//XXQS//chpaamPdTs5CyJwVgKU/C/noyccoChE1RdVmh/EaHc/h/NGilrEdX
	 eyzwi3E7gr2Bk6PUDqK547mfVSKlBgk/iaOEL78kRAbw7CjrA38kAnBOoTRuhAIf1A
	 7lR2HrP6b5QMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CA83808200;
	Tue, 24 Mar 2026 06:07:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] perf regs: Refactor use of arch__sample_reg_masks to
 perf_reg_name
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177433245578.469836.9909443703543629128.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 06:07:35 +0000
References: <20260121021735.3625244-1-irogers@google.com>
In-Reply-To: <20260121021735.3625244-1-irogers@google.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-riscv@lists.infradead.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
 adrian.hunter@intel.com, james.clark@linaro.org, john.g.garry@oracle.com,
 will@kernel.org, leo.yan@linux.dev, guoren@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 shimin.guo@skydio.com, atrajeev@linux.ibm.com, stephen.s.brennan@oracle.com,
 howardchu95@gmail.com, thomas.falcon@intel.com, ak@linux.intel.com,
 linux@treblig.org, dvyukov@google.com, krzysztof.m.lopatowski@gmail.com,
 ctshao@google.com, aditya.b1@linux.ibm.com, haibo1.xu@intel.com,
 slyich@gmail.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, dapeng1.mi@linux.intel.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Arnaldo Carvalho de Melo <acme@redhat.com>:

On Tue, 20 Jan 2026 18:17:35 -0800 you wrote:
> arch__sample_reg_masks isn't supported on ARM(32), csky, loongarch,
> MIPS, RISC-V and s390. The table returned by the function just has the
> name of a register paired with the corresponding sample_regs_user mask
> value. For a given perf register we can compute the name with
> perf_reg_name and the mask is just 1 left-shifted by the perf register
> number. Change __parse_regs to use this method for finding registers
> rather than arch__sample_reg_masks, thereby adding __parse_regs
> support for ARM(32), csky, loongarch, MIPS, RISC-V and s390. As
> arch__sample_reg_masks is then unused, remove the now unneeded
> declarations.
> 
> [...]

Here is the summary with links:
  - [v2] perf regs: Refactor use of arch__sample_reg_masks to perf_reg_name
    https://git.kernel.org/riscv/c/3d06db9bad1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


