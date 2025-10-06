Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656E23D283;
	Mon,  6 Oct 2025 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759780214; cv=none; b=cTpxnah/vPW70HtOOGPk6ljJMLGUDyD8iatJvqOgrkaYTqZAvdS3vZzBPs2OZ2COUeb/gwiNx4EuVvysnHyvYiOMZ4mR8DZyn1aQ6FMQgYs6B1dI8TbbpSzMnn/RRaY+GIye4KNlIhkmIXscZbtHLNyl6NxDXaij7Ztuu7rsQY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759780214; c=relaxed/simple;
	bh=1iSszkCi0lUsH8176NlUocZ21Z72m+lJn69XxPCJEoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZD3Brqo9/TUqUWtUwxBr50X5ziX/u4G+K1UPLzr9rUxad14qYk+7q6bt9FTM77ukmpmwvxs8PEXIQ13Kg8IitrYaOyTcx2qQUVfPEPb/tc4BnGUrSJKWacbWHq/A/NCtVlQUEde4Gl4Q95SH77VUqpamuy0hHDL2s9oimMGX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWMID7o4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWMID7o4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45027C4CEF5;
	Mon,  6 Oct 2025 19:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759780213;
	bh=1iSszkCi0lUsH8176NlUocZ21Z72m+lJn69XxPCJEoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OWMID7o46St1R1+e0u5oT4umgvC68KNxBuravp+B8wpfonMdKXT9qBusGxzqwlPOk
	 exl+2XlaU3lO+3s/J87tm9rI/ekPmtjbl9mXvQ6niADFoK22h4ERHExmRJaZZhXPkE
	 swG1I4XLzsvJANxJbMv/GQIKR1M/IRkOKaTjcX3SGGZbCm5TJZHo/1qRG0JcLj7ShR
	 EBmo2MbKxcXj1EOZfMZJQwxdPLkGjzjxgfuwAZ5BLdV+azPs3aMABvzRHujRQxTVc6
	 FA5BqB4f/5jYRRppMA8Xvq300ALFyeOP4LpgxD0N3L1drNd/5ILSfFSSZDU779YW5o
	 +GbqkomIyBBaA==
Date: Mon, 6 Oct 2025 16:50:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/9] perf build: Support building with Clang
Message-ID: <aOQdcvW6jURCV8pF@x1>
References: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com>

On Mon, Oct 06, 2025 at 05:21:22PM +0100, Leo Yan wrote:
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
> Testing:
> 
> Tested with linux-tools-container-builds [2], which based on Arnaldo's
> build test container but with several fixes for cross building with
> Clang:
> 
>   - All clang native builds on x86_64 have passed.
>   - The cross builds for arm64/mips/mips64/mipsel/riscv64 have passed.
> 
> Only a pity thing is I cannot build successfully with clang for
> ubuntu:20.04-x-powerpc64el (in below log, it only builds with GCC).
> The cross config does not work well on Ubuntu 20.04 due to failure
> "No gnu/libc-version.h found, please install glibc-dev[el]". I confirmed
> that powerpc64el cross build can make success on Ubuntu 24.04, the
> failure on Ubuntu 20.04 should not be caused by perf build.

Thaanks, applied, testing it.

- Arnaldo
