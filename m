Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129C2561B3;
	Mon,  2 Jun 2025 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748902336; cv=none; b=Y7WPplkR3HQdkxInL3qncO/y7KVtZCkwRFHD82vywcWz8wiEw8PT3PTKA6XtELLOVLltWm9UAcvjSHmm4gCxYeHkIcsNmary3umvI2jAT4OrqLtBrFHZhlxtWMRLn3IyrC5NtUDm1dTgnifx/gg1xgJik42Jpudm22s4iWnSdPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748902336; c=relaxed/simple;
	bh=soT7jJUaFNYS9Uh3l2z7LkH2EvguZZgThBpUjJD8exw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oJLr0lPyQV59LVRNlGrhaSDctdtjegv6wovVhNZD7RsQRfHltYgXEOfbJstdklMXwtJUZS8X8BW/8PHo0DRIpW5gjQFG3XRwVXk4wnaVN12TBr9yRZp7sXxGTBVvWwG3jn4hfgVrIx3vT0ykRTKtbVqcYplTGuR/BWfdw4cbYPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP3wV572; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP3wV572"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC39C4CEEB;
	Mon,  2 Jun 2025 22:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748902335;
	bh=soT7jJUaFNYS9Uh3l2z7LkH2EvguZZgThBpUjJD8exw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oP3wV572UGXiy4aMjgtspjktZ/tYOpVbUYxwQYelZoa3bz0HHRfXJ6flQ+CJcsBR/
	 5aFxl3I/p8MZ/kJ3gb5GxVpYKHgpyEMTQFb+jjMGy7vwoueg1IdlZIxJC6OnE6TJP/
	 HZ4Fdc8rRsIbeW5DufRikZllHeI3uVew9sMBrvOxtY2dn+MuZj9I3b/iDLFsSIUAXT
	 ci3DGspHBXIryaPPiEYDiFMW2g8cx3PKF0KGY3MXMSwbpGzYgf9819MKAdOYb/bJ+u
	 8FPl57tFxI+NzxaoNIfdTRhVrtoaolvnKCxLMaD8hFLPBaOZMRx2LcFFcyKNWWQGCh
	 iFETEHn2imxtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF32380AAD0;
	Mon,  2 Jun 2025 22:12:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] perf symbols: Ignore mapping symbols on riscv
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174890236756.925497.6881050930768049358.git-patchwork-notify@kernel.org>
Date: Mon, 02 Jun 2025 22:12:47 +0000
References: <20250409025202.201046-1-haibo1.xu@intel.com>
In-Reply-To: <20250409025202.201046-1-haibo1.xu@intel.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: linux-riscv@lists.infradead.org, xiaobo55x@gmail.com,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, stephen.s.brennan@oracle.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@dabbelt.com>:

On Wed,  9 Apr 2025 10:51:56 +0800 you wrote:
> RISCV ELF use mapping symbols with special names $x, $d to
> identify regions of RISCV code or code with different ISAs[1].
> These symbols don't identify functions, so will confuse the
> perf output.
> 
> The patch filters out these symbols at load time, similar to
> "4886f2ca perf symbols: Ignore mapping symbols on aarch64".
> 
> [...]

Here is the summary with links:
  - perf symbols: Ignore mapping symbols on riscv
    https://git.kernel.org/riscv/c/e4c39a45a0ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


