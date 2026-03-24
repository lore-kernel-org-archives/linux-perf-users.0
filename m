Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EEA3AD534;
	Tue, 24 Mar 2026 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332455; cv=none; b=XgGkjt5NLRhc32q11XaUJSySNDou3OqvxoTgxMsXe43Nndhx7jruMyMK0UdNwiTBQFFBlTJjhtuUG7fWbAMgeOXfJS/+LLCb7nuwL6qaT0LRblybunA7z7pjRUhhCVT2q5TwwYhqoxEyZVdC73Wgv02K3OlGTMmf1hMdlz6ke+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332455; c=relaxed/simple;
	bh=wFb340HUOaVrCXWQpjgqhiuSeNlgOOpYnArU4IDmxzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rQ4JHiQ+pnvvHj3T0KHjPkY1ZKCMp72NKGZAoRctupubMTehSxhnhCly4ee3I+lqNqyoNy1bVsx5W5JefUpnBtVosxgDpfeEdQAC9xhGmUZoVf3A4HC1Hm9cYOrl93fLix6rO6tVbr8tXs5FnsbY9R+juBHTQTXw2Kyyhc0py4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBlAG3kL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBlAG3kL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9ADC19424;
	Tue, 24 Mar 2026 06:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774332454;
	bh=wFb340HUOaVrCXWQpjgqhiuSeNlgOOpYnArU4IDmxzQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TBlAG3kLq1QC9v/NKcvGed5e0LjMvlG9h0iMOSj/3glJcGD0yAAUYeXqJdBQlyd0n
	 mxF3JXMSNmPhKUSGpblKH0uhIQnL36LIgEy4RiYqtxA6VpPMdmI3RCvMcAE/ryfipI
	 aOiDQoDLBkG/+2wfKqahNxof/eeA24qDIxLyeSjLvnTXWPIFTu55qFEg9sbEnSkyD6
	 IE90UwaA0J5PEjHSEZVGG/rhPNCy/KGELPK7CQJrWsJnxwHafSwdmIDBCXAlFNjQW+
	 /GZzQ7+h0MixrEKdi9ZxoOAdi8r3VsYs6bqBzBzxTMMRdItSGJ2Czpb+6ey4cxdcUu
	 qS1/OaI3tMXnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA04E3808200;
	Tue, 24 Mar 2026 06:07:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 00/12] perf annotate arch clean up
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177433244254.469836.16725604300266891770.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 06:07:22 +0000
References: <20260122213516.671089-1-irogers@google.com>
In-Reply-To: <20260122213516.671089-1-irogers@google.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-riscv@lists.infradead.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
 john.g.garry@oracle.com, will@kernel.org, leo.yan@linux.dev,
 guoren@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, zecheng@google.com,
 tianyou.li@intel.com, thomas.falcon@intel.com, Julia.Lawall@inria.fr,
 suchitkarunakaran@gmail.com, atrajeev@linux.ibm.com, aditya.b1@linux.ibm.com,
 howardchu95@gmail.com, krzysztof.m.lopatowski@gmail.com, linux@treblig.org,
 shimin.guo@skydio.com, slyich@gmail.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Arnaldo Carvalho de Melo <acme@redhat.com>:

On Thu, 22 Jan 2026 13:35:04 -0800 you wrote:
> 3 initial memory leak fix patches for perf annotate.
> 
> Move the disasm.c #included arch files into a new util/annotate-arch
> directory. Make the code compile standalone. Try to better encapsulate
> architecture specific code within the files and with a
> arch__new_<arch> function that allows additional data to be associated
> with the struct arch using the standard container_of trick.
> 
> [...]

Here is the summary with links:
  - [v3,01/12] perf header: Fix memory leaks in process_cpu_domain_info
    https://git.kernel.org/riscv/c/d84f24c89886
  - [v3,02/12] perf annotate: Fix args leak of map_symbol
    https://git.kernel.org/riscv/c/00419892bac2
  - [v3,03/12] perf maps: Fix reference count leak in maps__find_ams
    https://git.kernel.org/riscv/c/6fdd2676db55
  - [v3,04/12] perf disasm: Constify use of struct arch
    https://git.kernel.org/riscv/c/57d26593a92f
  - [v3,05/12] perf disasm: Constify use of struct ins_op
    https://git.kernel.org/riscv/c/1e3b91d6c53e
  - [v3,06/12] perf disasm: Constify use of struct ins
    https://git.kernel.org/riscv/c/2a1ca20d0b58
  - [v3,07/12] perf disasm: Rework the string arch__is to use the ELF machine
    https://git.kernel.org/riscv/c/927308527310
  - [v3,08/12] perf disasm: Don't include C files from the arch directory
    https://git.kernel.org/riscv/c/07b972ff09f4
  - [v3,09/12] perf disasm: Refactor ins__is_call/jump to avoid exposing arch ins_ops
    https://git.kernel.org/riscv/c/5301cc698821
  - [v3,10/12] perf map_symbol: Switch from holding maps to holding thread
    https://git.kernel.org/riscv/c/c4e3a00356ff
  - [v3,11/12] perf disasm: Refactor arch__find and initialization of arch structs
    (no matching commit)
  - [v3,12/12] perf disasm: Minor layout tweaks for struct arch
    https://git.kernel.org/riscv/c/dc329efc162a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


