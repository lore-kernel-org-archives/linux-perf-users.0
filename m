Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C43E3D92;
	Fri, 26 Jun 2026 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462076; cv=none; b=iiiY7P6C1T2c9vsTm77cxScIcwJOWoFyM/fdIcSReCtwSAiGMFkJPI1wr2YQRmH9GlRs/O6nMAosSFLPQYtCi+MNVd+ly+6uLuCy3fPhSbI7L6YOzq3V3kCPEMj/gyKdZPOheoauNXZowTYibAanqD+7qTuIGHTC9uNnq1R9vQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462076; c=relaxed/simple;
	bh=p30QomKiYtXGRZttFtNO0vfPTdt0owG9OJWyYu209xY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CO1vtlHLGZ1mWp2xt5UOumt5BRJyyTXGR3xYaew0KNVV1piOypmCnX3zi6IIjj2SvGyAGiXJ+srUlGdlv9Lvu2LShlxOBE0WdEnUYYwCNGAh3TNAx4V+IGpNG/ZTdKff/5Jg8pYNaZeOPONMnCUowin/i89ZwlkbqmpA22f5c1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZC15R2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZC15R2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE0C1F00A3D;
	Fri, 26 Jun 2026 08:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462074;
	bh=wplAzzEOm+Q0aPWW11dYgrqvd6iKQve3ErEDf2HUUMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EZC15R2pBfNIFs+6rNdwmk9jGSf+WvK+9KJt09+nK428GCipOT/5kpz/PdSAOO1X7
	 +3IhCzrKGed9ZgatfgLQfuHqxn09xGLHyOqbGUsEJrAPzdOx/g11diX3oZ1b7fiBeg
	 7pZhSn30yIO3XjwIdUAJGFIRcRozxroD6Oe7z1JO0za+TopjVP8RWYwKdNjlS6ISIQ
	 ovP7Hl1jhB2b7xBzCgHx8V2v7/0H0a5hbbI8M3AQs7ATgJsoWRZLex4hhvsYzfv/uz
	 gw/EOH7s4FxzBBa4RDMTF7I/hZ5AkETfNvj3WPJtj2JySlsDNeuOzv64uUofVexJAa
	 cSRnp7C94e8yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9ABD739389E8;
	Fri, 26 Jun 2026 08:21:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/7] perf unwind: Refactor get_entries to allow dynamic
 libdw/libunwind selection
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246206150.3816447.6305387305041749998.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:01 +0000
References: <20260513233151.572332-2-irogers@google.com>
In-Reply-To: <20260513233151.572332-2-irogers@google.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-riscv@lists.infradead.org, acme@kernel.org, adrian.hunter@intel.com,
 dapeng1.mi@linux.intel.com, james.clark@linaro.org, namhyung@kernel.org,
 florian.fainelli@broadcom.com, guanli.oerv@isrc.iscas.ac.cn,
 9erthalion6@gmail.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com,
 andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
 howardchu95@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
 leo.yan@linux.dev, libunwind-devel@nongnu.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mingo@redhat.com, palmer@dabbelt.com,
 peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com,
 tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Arnaldo Carvalho de Melo <acme@redhat.com>:

On Wed, 13 May 2026 16:31:45 -0700 you wrote:
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
  - [v5,1/7] perf unwind: Refactor get_entries to allow dynamic libdw/libunwind selection
    (no matching commit)
  - [v5,2/7] tools build: Deduplicate test-libunwind for different architectures
    https://git.kernel.org/riscv/c/6d13d53be9dd
  - [v5,3/7] perf build: Be more programmatic when setting up libunwind variables
    https://git.kernel.org/riscv/c/444508cd7c7b
  - [v5,4/7] perf unwind-libunwind: Make libunwind register reading cross platform
    (no matching commit)
  - [v5,5/7] perf unwind-libunwind: Move flush/finish access out of local
    https://git.kernel.org/riscv/c/2723e9f8b5cf
  - [v5,6/7] perf unwind-libunwind: Remove libunwind-local
    (no matching commit)
  - [v5,7/7] perf unwind-libunwind: Add RISC-V libunwind support
    https://git.kernel.org/riscv/c/834c557167a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


