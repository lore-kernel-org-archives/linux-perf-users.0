Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E33491CF;
	Wed, 12 Nov 2025 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970209; cv=none; b=JA1LapBC9nqQZ/lEBLyRv7a/TEYWvscSntIetCKzTwaCZtIuOQU0wcuNL+r2S2Qh0PyaTXsgjlu2aR70uTw2ZFvddznHnBFfEEeC6/dRrZjM4YCOq3+O/ZQSPGQB4cCyVBP0+15sdfxGMdfU0PArSWy6vbhOkkGf7Dj24SrUL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970209; c=relaxed/simple;
	bh=TWtPDh2I8jbfGlYioVARtb6CeFqhrvyxVYAFz3NqyxU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BNt3kiVT3CMgqRdTSPACy7/U9ouRnRrZpD3EpSOIjP+GCUAbDkvrKcj+2N8QBOz4AHwz/Lis7cNoCAWQPxGFPMOm++hKF76dEfwC1I+EFgGc9ubOQfHTS+YdBADbaPU1I7bIfR5DUxIKj8WYTb8dj/5/j3131rOw3LoX2xRWSE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z20G81R+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z20G81R+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4999C16AAE;
	Wed, 12 Nov 2025 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762970207;
	bh=TWtPDh2I8jbfGlYioVARtb6CeFqhrvyxVYAFz3NqyxU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Z20G81R+3444I1Liewv2tXdkPShtay8lz/DamfET5Im9TL7hnYXB+rp7dxVI8v8MF
	 PIVLKRGpQar3CODb/5z8RUfvsTia6ewMIwIbI12nYijHOKxHCtAOSeVx3BJxJSKkIj
	 SY7RD6jPQF2X0AZMtCLHyCpB2TOPC+NsGYwgojG1jwVZCvjikiLKgTDat0w1W5JlJ9
	 31+Rsz3RKSGhiL+F+IMddPZ2XFtOcWggPl6LAXXRyZrVSgjguRG9t4bVefBi0fmxDy
	 oQpVxSwPAVpKiZnRx8w7emVSuc30g4ZVu4a05AQ26efR7TH9VNetxuUa6q/tEnvBkF
	 aaiv6fspAmEdw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
 Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>, 
 Collin Funk <collin.funk1@gmail.com>, 
 Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
 Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
 Weilin Wang <weilin.wang@intel.com>, Ian Rogers <irogers@google.com>
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
References: <20251111212206.631711-1-irogers@google.com>
Subject: Re: [PATCH v4 00/18]
Message-Id: <176297020576.2139491.4370438400941621838.b4-ty@kernel.org>
Date: Wed, 12 Nov 2025 09:56:45 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 11 Nov 2025 13:21:48 -0800, Ian Rogers wrote:
> Prior to this series stat-shadow would produce hard coded metrics if
> certain events appeared in the evlist. This series produces equivalent
> json metrics and cleans up the consequences in tests and display
> output. A before and after of the default display output on a
> tigerlake is:
> 
> Before:
> ```
> $ perf stat -a sleep 1
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


