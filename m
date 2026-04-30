Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D534C990;
	Thu, 30 Apr 2026 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519566; cv=none; b=LruwRb563OWGLNCQLuraTEwuvwUbLO/z+KY6vd2XrmrbeVSzNFvUtbwVh93rcRsm+Nq/zKOHmGzSrMHLuXNw3+CBV7MoQ54XQscjRX7bItndCZ2aBeVDrV4m2po1HtbE7uxtXbVfJ6ScLlU0Dn3Vbqf49H0YKvNoTfFDSXBoq9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519566; c=relaxed/simple;
	bh=mg07WEIAKsuSxne/3AsIHVpCoZ2+I3HzqZDVUkFi0EI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=heLYBDKpqENcgarLXj5+uAcXJVVLWcSkWrY6EcEZFg+Ch1TCwpftsv46UloqXkMItqwT94r8NfObKJ4mrL0fJUgFQ+S4cl5UMu6dcjSxUmfqouDBb9oiFW2/soBV3LZw+l02jArGZHGdmZALMjD3klA7RmfMJ+z/wtEDjYPuh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEtKXXx/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEtKXXx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB7EC2BCB9;
	Thu, 30 Apr 2026 03:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519565;
	bh=mg07WEIAKsuSxne/3AsIHVpCoZ2+I3HzqZDVUkFi0EI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dEtKXXx/jMjmFbAtXeqD7/QiR1wdAqG/KtNxyr+sYfrq55w3MraFUzAiv6YRAKSQE
	 8/y04V85AsmlvhfXuuEQOnr8vSHBqrNDGRQzyUZmi6eS6CjFKbZ9zUcIMAa6P02HJv
	 uJmjDRS5vTN4twzXaN2BvwIJUCca0XLP87peLxo78ipSppchY42CBJAjuLYlWYKV3n
	 CxLCnudyNDkMZZGHJB/Dwtx778/YMY3scP8Ycr7QGZKppi365e5pc8UM8cqFmRbbLZ
	 uzS+u19sKjIwjocwLX04nWrWqFtt5aenkYLt/yOL+7UQ4qB+wQPWwa/MxRUs3iiUem
	 e35K0GuOfLXIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDB53809A07;
	Thu, 30 Apr 2026 03:25:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/8] perf unwind: Refactor get_entries to allow dynamic
 libdw/libunwind selection
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751952104.2274119.14762312333480941665.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:21 +0000
References: <20260413024805.1316480-2-irogers@google.com>
In-Reply-To: <20260413024805.1316480-2-irogers@google.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-riscv@lists.infradead.org, acme@kernel.org, 9erthalion6@gmail.com,
 adrian.hunter@intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com,
 andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
 blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com,
 howardchu95@gmail.com, james.clark@linaro.org, john.g.garry@oracle.com,
 jolsa@kernel.org, leo.yan@linux.dev, libunwind-devel@nongnu.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org,
 palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
 shimin.guo@skydio.com, tglozar@redhat.com, tmricht@linux.ibm.com,
 will@kernel.org, yuzhuo@google.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Namhyung Kim <namhyung@kernel.org>:

On Sun, 12 Apr 2026 19:47:58 -0700 you wrote:
> Currently, both libdw and libunwind define 'unwind__get_entries'. This
> causes a duplicate symbol build failure when both are compiled into
> perf.
> 
> This commit refactors the DWARF unwind post-processing to be
> configurable at runtime via the .perfconfig file option
> 'unwind.style', or using the argument '--unwind-style' in the commands
> 'perf report', 'perf script' and 'perf inject', in a similar manner to
> the addr2line or the disassembler style.
> 
> [...]

Here is the summary with links:
  - [v4,1/8] perf unwind: Refactor get_entries to allow dynamic libdw/libunwind selection
    (no matching commit)
  - [v4,2/8] perf build loongarch: Remove reference to missing file
    https://git.kernel.org/riscv/c/841dbf4871c5
  - [v4,3/8] tools build: Deduplicate test-libunwind for different architectures
    (no matching commit)
  - [v4,4/8] perf build: Be more programmatic when setting up libunwind variables
    (no matching commit)
  - [v4,5/8] perf unwind-libunwind: Make libunwind register reading cross platform
    (no matching commit)
  - [v4,6/8] perf unwind-libunwind: Move flush/finish access out of local
    (no matching commit)
  - [v4,7/8] perf unwind-libunwind: Remove libunwind-local
    (no matching commit)
  - [v4,8/8] perf unwind-libunwind: Add RISC-V libunwind support
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


