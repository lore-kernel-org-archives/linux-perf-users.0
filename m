Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108B91B580F;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530438; cv=none; b=NmhTnRg5GNKKSBsU7MsGFX9vNP4k34clwysrERy1dUH1TgFWsy/YuBMtTlLIKhbVYif44Cp2WZAaoNwq2vhZj/+1yNQqQTjpPW7GRHTRtxEH3074H7D2HfD4GzvbenHC0TtSU0OOPymPQe40KI6AHzQz/iu6+sdkw1MO+eGFAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530438; c=relaxed/simple;
	bh=cm88tP/Dp1Y8OMyog3ReSR+5U6PYD1gdvoFDyAqqrGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PzNCt/VH0IzJxsYE7maVEiHnYbSimjVzGeCQfAmw3JfVfDIs9h3OAjY8DkVb/3pai+hkBWBkGWCpM4b9tglkeeHq1bLizNSdcEe3ZlHcH+S+1Y9svUPxykc+U+lwTDPybS8lmVmmxai7fsZffIlHAIK10DrMUp+yESkUdvv3b+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpwKZWD8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpwKZWD8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3617C4AF0B;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722530437;
	bh=cm88tP/Dp1Y8OMyog3ReSR+5U6PYD1gdvoFDyAqqrGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NpwKZWD8xlDHvM5Wr5EP1TritZv5c6YBqI41ANcluQfaNqMZgP2bF/3b0soGyJwnf
	 xgXdD4NP07UVbKqvmPeVJkirKzbRHllIyy/EGRUgXvzRAmBLXZppM0uu2OYn4STrhP
	 XhTLNOP/lqNP7ZYXaXvbXzLot9zB0HHTTSb7F19z+VZ1tACt1Hx/mO45hqhOEg9smh
	 MTh3hnls60Spof2JUZVbUeGKy34bgUPhFjNvYetOR7idjb7RgUeuUL6hBUePfyQB2A
	 0iaH/vFKbw8Nd9Ss3OvvkcFB7ckTeN++mKLwwMWmwd/SRi9aJNOJh2Zx0WIBSja5Kg
	 42CLMj3LnEqwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85C93E8877A;
	Thu,  1 Aug 2024 16:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] perf arch events: Fix duplicate RISC-V SBI firmware event
 name
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172253043753.13740.1828763400860823722.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 16:40:37 +0000
References: <20240719115018.27356-1-eric.lin@sifive.com>
In-Reply-To: <20240719115018.27356-1-eric.lin@sifive.com>
To: Eric Lin <eric.lin@sifive.com>
Cc: linux-riscv@lists.infradead.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, peterlin@andestech.com, dminus@andestech.com,
 locus84@andestech.com, jisheng.teoh@starfivetech.com, inochiama@outlook.com,
 n.shubin@yadro.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, samuel.holland@sifive.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 19 Jul 2024 19:50:18 +0800 you wrote:
> Currently, the RISC-V firmware JSON file has duplicate event name
> "FW_SFENCE_VMA_RECEIVED". According to the RISC-V SBI PMU extension[1],
> the event name should be "FW_SFENCE_VMA_ASID_SENT".
> 
> Before this patch:
> $ perf list
> 
> [...]

Here is the summary with links:
  - [v2] perf arch events: Fix duplicate RISC-V SBI firmware event name
    https://git.kernel.org/riscv/c/63ba5b0fb4f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


