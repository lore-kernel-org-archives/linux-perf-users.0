Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BAD29D264;
	Wed,  5 Aug 2026 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891659; cv=none; b=iO2YYityGxKhvmzLHs9VVylEDw+vP70XM17yeTbl1plZWtENHuCBfxybRRqTegYuBKtQOy9YtRiPI6rYlgXusUmrvu1aRatablF8092YRcQQRkDD9HZPc688qqERrGUmBBkiS6qlKFwSSjKwZk/4pMm238dXSPtc0oFtgb/m7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891659; c=relaxed/simple;
	bh=HwR9nVlD+ktFrbwizV6BSjgnNtJiBICHuVrBCSIDaMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pL/xwwCHaIyxf7uxR/Mhta2eakqNOisPnoq3+WUow+nsXbic17NDb+kaWdt8QcaLW1c5TaJD04p/FMpEm0ERZegvCQG/D4MdUBrxCaVrvzpKuYWoMLq8xjdlfYgHDPvb/5qBJIVNvZR2tOraphZZt/l3kSQ/+Pvo3qYi3n1tXHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdiRkgYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdiRkgYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DB11F00A3E;
	Wed,  5 Aug 2026 01:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785891656;
	bh=o3KX9skCpKY11w+0FlGhhpohym5ngk1RFk12GUsJf1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZdiRkgYOxwCPkyMP9MXyafK1991EZ2jyJgUEjzC2UWj9+QArYQs43RDm9QZJNPw0m
	 oy0b1mpk81lRd6mP9Kd9YkyGgkV1nRaJrd01I4S90yQpJEKYyP8gRTOLOUS81omaFE
	 xeWYq13BjLzViMjeSeU45Ni79OpHKVfICNf85FDTslgPXrV98IaZvWvqEhmd1q2KTN
	 fG38PHUUcJr3FF2zkt88SvL1ShkgvHtc2+0xQ/wCSJAxsL46ftyEAP0X4WbI5NP3lJ
	 bBHYQLmu27YWWGOIGiaZkH3m31IkjoAIV1qCeQzcqpRZlOvtdE3wFNxW6emnA80SNb
	 c/VoDu4hfMiBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09C53926663;
	Wed,  5 Aug 2026 01:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 00/22] Add Counter delegation ISA extension support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178589161639.3856351.5268442875805678038.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 01:00:16 +0000
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
In-Reply-To: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: linux-riscv@lists.infradead.org, jolsa@kernel.org, pjw@kernel.org,
 mark.rutland@arm.com, robh@kernel.org, anup@brainfault.org,
 namhyung@kernel.org, acme@kernel.org, krzk+dt@kernel.org, irogers@google.com,
 will@kernel.org, james.clark@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org,
 conor@kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Paul Walmsley <pjw@kernel.org>:

On Wed, 01 Jul 2026 01:46:48 -0700 you wrote:
> This series adds the counter delegation extension support. It is based on
> very early PoC work done by Kevin Xue and mostly rewritten after that.
> The counter delegation ISA extension(Smcdeleg/Ssccfg) actually depends
> on multiple ISA extensions.
> 
> 1. S[m|s]csrind : The indirect CSR extension[1] which defines additional
>    5 ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation of
>    RISC-V CSR address space.
> 2. Smstateen: The stateen bit[60] controls the access to the registers
>    indirectly via the above indirect registers.
> 3. Smcdeleg/Ssccfg: The counter delegation extensions[2]
> 
> [...]

Here is the summary with links:
  - [v8,01/22] RISC-V: perf: fix resource cleanup on driver probe failure
    https://git.kernel.org/riscv/c/bf08074d8a20
  - [v8,02/22] RISC-V: Add Sxcsrind ISA extension CSR definitions
    https://git.kernel.org/riscv/c/7c31031b2974
  - [v8,03/22] RISC-V: Add Sxcsrind ISA extension definition and parsing
    https://git.kernel.org/riscv/c/7fe9435ef9e7
  - [v8,04/22] dt-bindings: riscv: add Sxcsrind ISA extension description
    https://git.kernel.org/riscv/c/010e2b79bd08
  - [v8,05/22] RISC-V: Define indirect CSR access helpers
    https://git.kernel.org/riscv/c/6f1ece4a6691
  - [v8,06/22] RISC-V: Add Smcntrpmf extension parsing
    https://git.kernel.org/riscv/c/935bfae38e57
  - [v8,07/22] dt-bindings: riscv: add Smcntrpmf ISA extension description
    https://git.kernel.org/riscv/c/837eaefa4d63
  - [v8,08/22] RISC-V: Add Sscfg extension CSR definition
    https://git.kernel.org/riscv/c/db40f62b80ec
  - [v8,09/22] RISC-V: Add Ssccfg/Smcdeleg ISA extension definition and parsing
    https://git.kernel.org/riscv/c/2ea70441fe0f
  - [v8,10/22] dt-bindings: riscv: add Counter delegation ISA extensions description
    https://git.kernel.org/riscv/c/b8d69e7159cc
  - [v8,11/22] RISC-V: perf: Restructure the SBI PMU code
    (no matching commit)
  - [v8,12/22] RISC-V: perf: Modify the counter discovery mechanism
    (no matching commit)
  - [v8,13/22] RISC-V: perf: Add a mechanism to defined legacy event encoding
    (no matching commit)
  - [v8,14/22] RISC-V: perf: Implement supervisor counter delegation support
    (no matching commit)
  - [v8,15/22] RISC-V: perf: Skip PMU SBI extension when not implemented
    (no matching commit)
  - [v8,16/22] RISC-V: perf: Use config2/vendor table for event to counter mapping
    (no matching commit)
  - [v8,17/22] RISC-V: perf: Add legacy event encodings via sysfs
    (no matching commit)
  - [v8,18/22] RISC-V: perf: Add Qemu virt machine events
    (no matching commit)
  - [v8,19/22] tools/perf: Support event code for arch standard events
    (no matching commit)
  - [v8,20/22] tools/perf: Add RISC-V CounterIDMask event field
    (no matching commit)
  - [v8,21/22] TEST(do-not-upstream): fake qemu-virt PMU events for cdeleg counter-mask testing
    (no matching commit)
  - [v8,22/22] TEST(do-not-upstream): fake qemu vendor JSON + mapfile entry for CounterIDMask path
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


