Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1E23D3D1D;
	Fri,  5 Jun 2026 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694422; cv=none; b=qUFQP7MpUAhjM+ACDcBhCGGs4Xvs6KJGNiILskVQTdfozV52zeX80Vxy3nfeOhL+b5uTIt3ARmOVPDi/chkirwm0QP8hZaSYbvpAStDEctY4qCXHRUpqXmtXAbYs5ZnG4uglLqe417LOIhMKi2ZK4OUjfa+IJIdQa8r/LwxAtPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694422; c=relaxed/simple;
	bh=8EXjaaOHeXCMi7NlB9YH0TDZr4JLRlzxLAptFpFNV00=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ROAmrcIOUTrXbCatol4pUDYljsoCzFsDYyZrq297pliJc/kBtVqENftpj9wInHDrAnR/BXWjydVRX2AUgKl3nimx+9nm2tJ4d8aIlyfB8Q/qsnXGNGUIxQOHdvs9iGDp+SzpljdQ7wbwGPSVWMr8exRcAOR7EyxEcwWAcmK5UY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow8h1nt3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow8h1nt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECD41F00893;
	Fri,  5 Jun 2026 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780694421;
	bh=LJpoVFB+CuvYX0SXvlOWKASZl7v0I50VSEGhMK+Pmkg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ow8h1nt3qhRLcXmj5/tVS8pvYmQQSYHs0hPZbenVplmVZ3HBORnoEygSUNoNHMz+K
	 nT3eA62bFCLTC1u35tvVJQCwgTlhkGPB7aU+dc9rdvFh0MG8EotxBswJ/N3OxkNL+H
	 ptVsaomW6bzk0VypeeC/gZta/vqxMn7pEAgugp+xGTEWQJLusOab7Pz9pE6FwKnIRJ
	 b9/Fe8OWIPLJcWa0GUOqWPOXItpmerrHHAegcdjLLrbTHCnouyChrsQUn2Duw9MSgC
	 5Yf04yyVB2IBWGWmRz/0oLDnbfn9bQ1Uxu+GtcLfCWMOO11haDqIJPndGFJbn+piuB
	 ReSZeeXI4XsEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B653930BB9;
	Fri,  5 Jun 2026 21:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] bpftool build: Restrict feature tests during bootstrap
 compilation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178069442140.3922226.7204524293752393062.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 21:20:21 +0000
References: <20260531010750.525160-1-irogers@google.com>
In-Reply-To: <20260531010750.525160-1-irogers@google.com>
To: Ian Rogers <irogers@google.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, terrelln@fb.com, dsterba@suse.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
 james.clark@linaro.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 30 May 2026 18:07:50 -0700 you wrote:
> When the perf build executes 'make -C ../bpf/bpftool bootstrap', bpftool's
> Makefile unconditionally evaluated feature checks for llvm, libcap, libbfd,
> and disassembler libraries because the bootstrap target was not exempted.
> 
> Since the bootstrap bpftool strictly compiles minimal AST parsing and C
> code generation logic without linking LLVM or disassembler libraries, these
> feature check sub-makes are completely redundant.
> 
> [...]

Here is the summary with links:
  - [v1] bpftool build: Restrict feature tests during bootstrap compilation
    https://git.kernel.org/bpf/bpf-next/c/231fc9bc27fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


