Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775186324;
	Fri, 17 Jan 2025 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136489; cv=none; b=kpggcnNu+qApUp5zCWlmhwvk1t0Dy9cysu+axEL1lkGMqoAFdIttD6g1HXGetgkOAChP/Vz0hXxcM1VmsthYsdZsJdojnhhf5oZGU1OZFehbdOKYunhX5xfV3phx49Xs1UZuvMIvzxm2e2S7l3LOMwNjDdME9NK7WTiJhs96Wls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136489; c=relaxed/simple;
	bh=IkLn0NUjJr3fRLkhhx+GSKLsB9SD/Hl6TVgxBLGOA2M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mEHwqcsSGTom+eAyKzORL3S/KvnaYEE/PRET8UcjT9jZZ8hfCU4OTQusvvhlFAJkdjoATZ6mLBYRK4xVMnqvS/a8OUa/L+ih0T4t41RlySFPrV6aHPAbb4A7q/iYt2QQ3nzF3xz7hoPo3vJWJQDAnYYhS+/AqscQFfCwsApRsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOc9ta3g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOc9ta3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5346C4CEDD;
	Fri, 17 Jan 2025 17:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737136489;
	bh=IkLn0NUjJr3fRLkhhx+GSKLsB9SD/Hl6TVgxBLGOA2M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eOc9ta3gkWAn3Ou50TPzvcaoJhumR/Y01YqIRNTO2bAnW7UeGUm6HfpQuFm1YAVwe
	 kmyQOkzNy1wsFqf48iDAbBRYQD3XK6B1rUg7mbsDezinfKYy/Iowp2W/LETxZIqto9
	 //a90tMic8n6QZYc/+i1h/eTmeJvEte/2IDNOSJfqVMX8KskdfNf3TcLm6ta4FsgLJ
	 xWXwrprfpfo5KV61zofv0te2fQgPKIO5R6Tf4gZss5aw5lzbFaGmKaGH5bOhkAyreQ
	 Y6Zvj4zS5WJRPgTxW6/TkUSaJVw/rWXl1SjC3brpXFzWuz6to+BLZ0B5HTRTokCdbE
	 4ISTMvjNukxZA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>
In-Reply-To: <20250114-perf_make_test-v1-1-decc1c517b11@rivosinc.com>
References: <20250114-perf_make_test-v1-1-decc1c517b11@rivosinc.com>
Subject: Re: [PATCH FOR-NEXT] perf tools: Expose quiet/verbose variables in
 Makefile.perf
Message-Id: <173713648876.2190713.3137931166483000893.b4-ty@kernel.org>
Date: Fri, 17 Jan 2025 09:54:48 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 14 Jan 2025 11:35:44 -0800, Charlie Jenkins wrote:

> The variables to make builds silent/verbose live inside
> tools/build/Makefile.build. Move those variables to the top-level
> Makefile.perf to be generally available.
> 
> Committer testing:
> 
> See the SYSCALL lines, now they are consistent with the other
> operations in other lines:
>   SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_32.h
>   SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_64.h
>   GEN     /tmp/build/perf-tools-next/common-cmds.h
>   GEN     /tmp/build/perf-tools-next/arch/arm64/include/generated/asm/sysreg-defs.h
>   PERF_VERSION = 6.13.rc2.g3d94bb6ed1d0
>   GEN     perf-archive
>   MKDIR   /tmp/build/perf-tools-next/jvmti/
>   MKDIR   /tmp/build/perf-tools-next/jvmti/
>   MKDIR   /tmp/build/perf-tools-next/jvmti/
>   MKDIR   /tmp/build/perf-tools-next/jvmti/
>   GEN     perf-iostat
>   CC      /tmp/build/perf-tools-next/jvmti/libjvmti.o
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

