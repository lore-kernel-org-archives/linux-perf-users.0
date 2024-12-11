Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DBE1FECB9;
	Wed, 11 Dec 2024 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956353; cv=none; b=EzwiGTWUnukVW3TxGD7VxnrdD1Dt35sba8srfMtjVs361dHDCt8/rDbXPrpNvok+gFVEw/mmKjAx8oPm+ZYD/sR8eqOgRf84eoJpgm2H0WCKWdnBW1aoOO9iOZbCeH2GqQHTzR3xiRLSNQFf4JxpAJRcnwmcqVLFglM2EZ4Me+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956353; c=relaxed/simple;
	bh=RRuLfKZeC8+vc2RY1vIgr2/93ygrFKjc9DELDSjP76w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cYo6NBxvCIo3Yh0secZku1T0mrUuE4XBsdmCzl/ywudVgGzqnfBzklmLguNQCRtxyBy9J6mFqXM8Pz/bJmax2Da5SL8UZ9e1h/GHKf3DO9Lf7mkHLIxbc9DQm2JVVdbu+33BbT/xQKwHlpE/6wy4rb7Nw1uShKULa6EMY73AIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdV8cioA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdV8cioA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D537C4CED2;
	Wed, 11 Dec 2024 22:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956353;
	bh=RRuLfKZeC8+vc2RY1vIgr2/93ygrFKjc9DELDSjP76w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cdV8cioAnhLMhQZutiHWY+WBHtcIFtIO7iItL4IlV2Bzx7Yz/2CAAoAyrasboVtnp
	 xh4aWdm0kZuPQSolZrnbAUGw58tQb9l0Y6cZv6qcNqH8mEbq27Z0Hj5HfIMVysNzfG
	 bt2GP1vrfXVtkoYpM3nXRqlvBz9JAVp3o9t7nLPrNR/hywSHGgtYtz49Ec8FaDxkXM
	 Sga9jYw2unkD8pN1JCnG8Za6O16kvgH+Xjjav4mmvgMOyS48Nr/1w81nw8RgHTtPDy
	 oqPIBVAWpJujhC6gFG/yhxP5XJsGd/+zZ39jvKK7QfWZLenlfexA1w3IMUz2AUcXE8
	 4fEPvRXqWfT2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D41380A965;
	Wed, 11 Dec 2024 22:32:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/8] Refactor cpuid and metric table lookup code
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395636900.1729195.10506266683827384224.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:49 +0000
References: <20241107162035.52206-1-irogers@google.com>
In-Reply-To: <20241107162035.52206-1-irogers@google.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-riscv@lists.infradead.org, john.g.garry@oracle.com, will@kernel.org,
 james.clark@linaro.org, mike.leach@linaro.org, leo.yan@linux.dev,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, chenhuacai@kernel.org,
 maobibo@loongson.cn, atrajeev@linux.vnet.ibm.com, ben717@andestech.com,
 alexghiti@rivosinc.com, sandipan.das@amd.com, bgray@linux.ibm.com,
 xu.yang_2@nxp.com, ravi.bangoria@amd.com, clement.legoffic@foss.st.com,
 yangyicong@hisilicon.com, mhiramat@kernel.org, dima@secretsauce.net,
 linux@treblig.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Arnaldo Carvalho de Melo <acme@redhat.com>:

On Thu,  7 Nov 2024 08:20:27 -0800 you wrote:
> Xu Yang <xu.yang_2@nxp.com> reported issues with the system metric
> lookup:
> https://lore.kernel.org/linux-perf-users/20241106085441.3945502-1-xu.yang_2@nxp.com/
> These patches remove a lot of the logic relating CPUIDs to PMUs so
> that the PMU isn't part of the question when finding a metric table.
> For time reasons, it doesn't go as far as allowing system metrics
> without a metric table as a metric table is needed for metrics to
> refer to other metrics, and the refactoring of that resolution is a
> hassle.
> 
> [...]

Here is the summary with links:
  - [v2,1/8] perf jevents: fix breakage when do perf stat on system metric
    https://git.kernel.org/riscv/c/4a159e6049f3
  - [v2,2/8] perf header: Move is_cpu_online to numa bench
    https://git.kernel.org/riscv/c/c6fafe36bab3
  - [v2,3/8] perf header: Refactor get_cpuid to take a CPU for ARM
    https://git.kernel.org/riscv/c/cec0d6572a44
  - [v2,4/8] perf arm64 header: Use cpu argument in get_cpuid
    https://git.kernel.org/riscv/c/538737da9625
  - [v2,5/8] perf header: Avoid transitive PMU includes
    https://git.kernel.org/riscv/c/7463ee17a740
  - [v2,6/8] perf header: Pass a perf_cpu rather than a PMU to get_cpuid_str
    https://git.kernel.org/riscv/c/494c403ff159
  - [v2,7/8] perf jevents: Add map_for_cpu
    https://git.kernel.org/riscv/c/0434410fa45c
  - [v2,8/8] perf pmu: Move pmu_metrics_table__find and remove ARM override
    https://git.kernel.org/riscv/c/8f997865ee9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


