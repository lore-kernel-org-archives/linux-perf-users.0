Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79DF21D596;
	Sat, 23 May 2026 00:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496855; cv=none; b=V6CllExcmYLc+8JmTEpoNeVb/7Hop4TL6W786LY+q7HLx+AY64Fev50WUHLVgrGEdWPAmDR0fRT1YZHE4Yd6PFcU0VHN2xj9PFJkYRmIq/NT8jCy6U2kTssM5Dmmd4UrmtNE/BRDd7tprm0we2AfGpqVEK+q2owQsfo1oHdXums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496855; c=relaxed/simple;
	bh=y24+y40dHiVCNC2cididPPUvD4lAgnooyirchZc/vts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9P4bUuhDYnKU1+5eBjutHZAsVHPHcanJFjSJvcjhbGhRJQRZFJG9S8tlBauRDF5XlLsGN7wSJ2lOmZ0lV2KgYGBxYQeoIXOtlrSrE11EHC0nRos3aaCCX38+zA9BuykNRYakch5hqfE7JIYpfFRULqOov1bx0F5s9HdW6wRdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvcMb3y+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvcMb3y+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DC71F000E9;
	Sat, 23 May 2026 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779496853;
	bh=RH5r+SYIAsNZmAtFj4b5Snkpoy4oN4jN3vGlr695GhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZvcMb3y+Q5hocCEGRKH8BlWuU2V5GV5IbImaE0uxuKvi+spHniyLAeJiwivKj16xU
	 8ALXM31sw0xyeti6nX8k5asqo7Pk3B6vdYMm99pe7VeyhQ/UXC+hWeN2QojhMbKZXm
	 xed7x6njJ6/vxUCn72X/v+CtNkmn4H72Kz1w80c+YFZugjNr3e7dNLfeXNS89jaBs0
	 Mw6FM+Il4x1FcRSIZPw8aLQwOdKCAk/nLxafZ5SNg0BF/SBJZ6xgqmg49fDOHGHqXb
	 cpnnd73XGLvz/8QIpJ6wZTQlQrty005e/2RvUHxG7Wjy68s9/TGouptwvmRFo6BjWs
	 B/sRKkmEIOT+Q==
Date: Fri, 22 May 2026 21:40:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	nigro.fra@gmail.com, peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v4 1/2] perf tool_pmu: Make tool PMU events respect
 enable/disable
Message-ID: <ahD3ktHnB3ZkCvuF@x1>
References: <20260518223733.3034897-1-irogers@google.com>
 <20260519014106.3089452-1-irogers@google.com>
 <20260519014106.3089452-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519014106.3089452-2-irogers@google.com>

On Mon, May 18, 2026 at 06:41:05PM -0700, Ian Rogers wrote:
> Tool PMU events (duration_time, user_time, system_time) currently
> count from when the event is opened to when it is read. This causes
> issues with features like the delay option (-D) or control fd, where
> events are opened but should not start counting immediately.
> 
> Make these events behave more like regular counters by implementing
> proper enable and disable support. Add accumulated_time to struct
> evsel to track time while enabled, and implement enable/disable CPU
> callbacks to start/stop counting.
> 
> Also generalize userspace PMU mixed group handling. Userspace synthetic
> PMUs (type > PERF_PMU_TYPE_PE_END) do not have kernel implementations and
> cannot be grouped in the kernel (opened with group_fd = -1), and are
> skipped by kernel enable/disable calls. Iterate over group members in
> userspace and manually enable/disable any members if the leader or the
> member is a non-perf-event open PMU, and synchronize their disabled flags.
> 
> Fixes: b71f46a6a708 ("perf stat: Remove hard coded shadow metrics")
> Reported-by: Francesco Nigro <nigro.fra@gmail.com>
> Closes: https://lore.kernel.org/linux-perf-users/20260517093650.2540920-1-nigro.fra@gmail.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
> Assisted-by: Antigravity:gemini-3-flash

Thanks, applied both patches to perf-tools-next, for v7.2.

- Arnaldo
