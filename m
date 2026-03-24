Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F39D3AE6E2;
	Tue, 24 Mar 2026 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332456; cv=none; b=nY6WLWy4EhPkmQREabwSReEygZ6vSn1RIo0lSwU5AllNAdiTaWNCH7SKSoUrBMkKeJ+U98eQROf9iyNxgYZoEA7PD9/RLo7dRcqFOgd1dX16KeysBdUboVl0r9rdDix28IZu+yazyI2fbPkb/nHZO88OLe0VfRaXXfek8JtZk1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332456; c=relaxed/simple;
	bh=GxPGKG/6w8349y5HsiaeOu43dZr4SR2srv5wsN2Tv+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TYTUcjGawvWMYo0tyLuwRxMhSeTr65sqT5IPdUOpsBl3hV+VsMKN8z811l0Q60E+VIDxTmUO6LfB62kkpU3WX/BrzJILZVkWNyTCDaJK3F9siS/XRJREiKTFQnjfHJAr/A7KZtQ9MyiZylO6Sx8q4Xd+n0uJgSh/tqcX3983AzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+DnWlXQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+DnWlXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98825C19424;
	Tue, 24 Mar 2026 06:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774332455;
	bh=GxPGKG/6w8349y5HsiaeOu43dZr4SR2srv5wsN2Tv+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c+DnWlXQvKGtO+8n/KZE5Zo2Ki19YvlnyKUQA9d/7tCrzTSDAD2PmimVz0/RTZ4LI
	 CM1cK/b7eKlrVfPSG2TYd+B7eG3XAD7gsbF2I+fLnS1HTy5k+TWfV7Iyc3J4H5ieM7
	 jZnZ9664OYwnqg5dZu3S724CJxFOzRlida7evmb+jmkd7oLQDdf+0rMT2sbCOhYTaM
	 UXR9GQmBdlrdJPqb0ISIZhg11RvHQbMoyoCVBgVE5wZwF4gMVcxxG/3LrodL24GEZk
	 8gKWh9pxg8JnPMo6nwNhOIfTH3GYAaHx/u1s4j/62u0/9WOjOjzAdO27WFhVla0/Pv
	 nTcigVyeQF74A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E73C03808200;
	Tue, 24 Mar 2026 06:07:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/5] perf kvm stat: Remove use of the arch directory
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177433244380.469836.9953865947941993562.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 06:07:23 +0000
References: <20260203182640.3911987-2-irogers@google.com>
In-Reply-To: <20260203182640.3911987-2-irogers@google.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-riscv@lists.infradead.org, acme@kernel.org, aditya.b1@linux.ibm.com,
 adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com,
 alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org,
 aou@eecs.berkeley.edu, ashelat@redhat.com, atrajeev@linux.ibm.com,
 blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com,
 dvyukov@google.com, howardchu95@gmail.com, james.clark@linaro.org,
 john.g.garry@oracle.com, jolsa@kernel.org, leo.yan@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org,
 palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
 shimin.guo@skydio.com, swapnil.sapkal@amd.com, thomas.falcon@intel.com,
 will@kernel.org, ysk@kzalloc.com, zhouquan@iscas.ac.cn

Hello:

This series was applied to riscv/linux.git (for-next)
by Arnaldo Carvalho de Melo <acme@redhat.com>:

On Tue,  3 Feb 2026 10:26:36 -0800 you wrote:
> `perf kvm stat` supports record and report options. By using the arch
> directory a report for a different machine type cannot be
> supported. Move the kvm-stat code out of the arch directory and into
> util/kvm-stat-arch following the pattern of perf-regs and
> dwarf-regs. Avoid duplicate symbols by renaming functions to have the
> architecture name within them. For global variables, wrap them in an
> architecture specific function. Selecting the architecture to use with
> `perf kvm stat` is selected by EM_HOST, ie no different than before
> the change. Later the ELF machine can be determined from the session
> or a header feature (ie EM_HOST at the time of the record).
> 
> [...]

Here is the summary with links:
  - [v3,1/5] perf kvm stat: Remove use of the arch directory
    https://git.kernel.org/riscv/c/ceea279f9376
  - [v3,2/5] perf kvm: Wire up e_machine
    https://git.kernel.org/riscv/c/43af54843677
  - [v3,3/5] perf session: Add e_flags to the e_machine helper
    https://git.kernel.org/riscv/c/07ad6f31b674
  - [v3,4/5] perf header: Add e_machine/e_flags to the header
    https://git.kernel.org/riscv/c/c4f4392264b4
  - [v3,5/5] perf thread: Don't require machine to compute the e_machine
    https://git.kernel.org/riscv/c/84cb36da8141

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


