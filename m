Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D44E27F010;
	Mon, 26 Jan 2026 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460793; cv=none; b=Ei+OKcAkzygnkwOpuNmqv07Ua2/6scammXITgr05duOLpFNqpbm/vSxcZp2MBwpwqTfVfCxeUsnLial0kQ8IE3Mkdhi75zyYUum3S3NmerIpOoA6wahpC4Q3TKXQFBDJmNtfz125TAyzgUVWB1GwRZIb1igHEWuB34shxogU12w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460793; c=relaxed/simple;
	bh=JQR+rydd6TVtpjqwvvPc7pyZWC9fW0lYqxzqur8LTSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBsp+1xKtDAIwSS0nLj0gZRLKy0vqYYHgLIhqMhRjRIqajqfEqBnYqWCIHMutwLB01s5xSY4Jf4xUPfB1e/yHiEWYrjum3XhoupcuAOschDCTPsotMoJ5JbdCqn6V3rvr+qx8phTxv+Y/NhTVtxdjZQJWVWGLuKkHQgdvnfaOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0xCs0tz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0xCs0tz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10569C116C6;
	Mon, 26 Jan 2026 20:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769460792;
	bh=JQR+rydd6TVtpjqwvvPc7pyZWC9fW0lYqxzqur8LTSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0xCs0tzj+CsL08a0ImnkfVqeKJreOOpP2t6t1qVmgRD4c26+ENWYiT7FcBaMTzNj
	 6SCUivpi1/X11Ocxt4Y8kbUf2RedMZng5aAM4KHjVZu88NuYO3lJ4ZN+FVX6jFYFMu
	 hIz5d3i8nFFw6hL9VEgGlXdq8OZm8YdCtKMLSfY6kudg5kinRS5+pEdPBsCUoW0Z/U
	 HKlD/O9UZYo1L/3ag4uu4AUctGnXWFv9GHluSleXt+EiVqPPk7j6Rqtod/as3D9iok
	 ezh/1bnv2h5lCfRHyPH+h9jd9M4x/qaqmj7gPe4OybmO9Z3TwM0FVKJUbJGdDSJ2LV
	 rU02nlx8murqg==
Date: Mon, 26 Jan 2026 17:53:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Shimin Guo <shimin.guo@skydio.com>, Andi Kleen <ak@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/3] perf more ELF machine usage
Message-ID: <aXfUNewGdbqqQL18@x1>
References: <20260124001611.1332019-1-irogers@google.com>
 <aXfUFBfCQ4m_DFrx@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXfUFBfCQ4m_DFrx@x1>

On Mon, Jan 26, 2026 at 05:52:39PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jan 23, 2026 at 04:16:08PM -0800, Ian Rogers wrote:
> > Switch 3 more cases where the perf_env arch was being used to
> > determine the architecture type and switch to using the ELF
> > machine. This includes the addition of minimal instruction parsing in
> > perf script for architectures other than x86, or x86 when
> > cross-platform.
> > 
> > Note: this series will conflict with the e_flags series:
> > https://lore.kernel.org/lkml/20260123222209.1181249-1-irogers@google.com/
> > that adds an additional out argument to thread__e_machine. In all the
> > cases here that argument should be NULL. So:
> >   thread__e_machine(thread, machine)
> > becomes:
> >   thread__e_machine(thread, machine, /*e_flags=*/NULL)
> 
> This one isn't applying.

⬢ [acme@toolbx perf-tools-next]$        git am ./20260123_irogers_perf_more_elf_machine_usage.mbx
Applying: perf script: Fix script_fetch_insn for more than just x86
Applying: perf callchain: Switch callchain_param_setup from an arch to an e_machine
error: patch failed: tools/perf/util/callchain.c:31
error: tools/perf/util/callchain.c: patch does not apply
Patch failed at 0002 perf callchain: Switch callchain_param_setup from an arch to an e_machine
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
⬢ [acme@toolbx perf-tools-next]$

- Arnaldo
