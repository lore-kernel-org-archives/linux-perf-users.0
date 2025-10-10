Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD022F16E;
	Fri, 10 Oct 2025 02:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063250; cv=none; b=h7cCT7j8A7EVm1YFTakNwAl4qs1Eisv7OWkQakKigXO/RiwA/pLOPIiR9jT9KHMo6JmbCMaK0Mb/08Vcn4E5qoAvXR1FHDy4yVzsrlItFHU4mDVa9Sf9pXySWtxEDhBt0wEM7pQ22d5xVozDCQyW2jsMmMzmjrN1ONrWYaLOBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063250; c=relaxed/simple;
	bh=ac4VtTda8SJRSe7ya6qERv9chI6J5rNgon5I14QHQy0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pv9QroEVjAtZ5ql6w5+LRTxyNN3VT4kKQZV3/U//4OH04RwH4ZDo/B7ONYyEzzBykzSODaHdkc91MKJytiHwFmeLZoaeFoz+MBmAKCa+dUkyAXCnyPP1NYf53GM6HynqAWhmX6giWamb3Yo8ucAU3PT7Ma16veGFeLH46YtlBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNX0xmHv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNX0xmHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF31C4CEE7;
	Fri, 10 Oct 2025 02:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760063250;
	bh=ac4VtTda8SJRSe7ya6qERv9chI6J5rNgon5I14QHQy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WNX0xmHvBiFXxv4mqNdaXwfKcAosh5PPPpszwfbWljExYKQ7ylm65jrdqKFPAfARV
	 WM9X/9nWqGrxDcDCPKBpkE3xWWjPAezq18hjJOOKfimQ8ePlsdOO/FKTz6Ye9EaiLn
	 uw+mnHVAnUogKtYbbi/WGlWSKdLR/MQD7JN/rzXsccDpd0w3U3gqwKLRvHr9+9Tv9j
	 rOJ6wTM6G9FYWM0+ZYTA8O7xWieWYWSr694a9UYw9MQ2Cj9qPUw9K544EZkaKfD8tW
	 RG3PiLSsUteZ/HPfrn0wkKake8vRSb6bMLAbdIfY9IH4923Lc2riE3YTEBUoNXNe3V
	 i/hRDi5gBaU9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E633A55FB5;
	Fri, 10 Oct 2025 02:27:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/9] perf build: Support building with Clang
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176006323800.354358.6110592426551858799.git-patchwork-notify@kernel.org>
Date: Fri, 10 Oct 2025 02:27:18 +0000
References: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com>
In-Reply-To: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, james.clark@linaro.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This series was applied to riscv/linux.git (fixes)
by Arnaldo Carvalho de Melo <acme@redhat.com>:

On Mon, 06 Oct 2025 17:21:22 +0100 you wrote:
> This series adds support for building perf with Clang, following the
> discussion in [1]. Because the Android NDK uses Clang by default,
> enabling Clang builds naturally covers Android as well.
> 
> The series is organized as follows:
> 
>   - Patches 1~2: Fix two bugs found with Clang.
>   - Patches 3~7: Correct CROSS_ARCH, Disable thread safety analysis for
>                  perl header, and dismiss Clang build warnings.
>   - Patches 8~9: Enable Clang in the Makefile and update the
>                  documentation.
> 
> [...]

Here is the summary with links:
  - [v3,1/9] tools build: Align warning options with perf
    https://git.kernel.org/riscv/c/53d067feb8c4
  - [v3,2/9] perf python: split Clang options when invoking Popen
    https://git.kernel.org/riscv/c/c6a43bc3e8f6
  - [v3,3/9] perf build: Correct CROSS_ARCH for clang
    https://git.kernel.org/riscv/c/ed33e5e43c1e
  - [v3,4/9] perf build: Disable thread safety analysis for perl header
    https://git.kernel.org/riscv/c/e7e86d7697c6
  - [v3,5/9] perf test coresight: Dismiss clang warning for memcpy thread
    https://git.kernel.org/riscv/c/50b7e7082a3d
  - [v3,6/9] perf test coresight: Dismiss clang warning for thread loop
    https://git.kernel.org/riscv/c/244a1ac76a67
  - [v3,7/9] perf test coresight: Dismiss clang warning for unroll loop thread
    https://git.kernel.org/riscv/c/9ec46fc93803
  - [v3,8/9] perf build: Support build with clang
    https://git.kernel.org/riscv/c/4772e66cb45e
  - [v3,9/9] perf docs: Document building with Clang
    https://git.kernel.org/riscv/c/0a75ba3e842c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


