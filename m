Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976F32F75F;
	Wed, 15 Oct 2025 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543632; cv=none; b=LbZumEnaYlY7MgWtcHltXAh/fVBNveGYShTNzJr4LTcrvPY/yL4snnd4GBD2QWXkf4Sz7+kgTeHNG9/ImZ22/JbEdgR0gdhPFmUXFzAyyaWXiq8gC/Z7rkk/GAUd5LnZMSWF0Jiu/i8qfqNuQOfW1hW6ya9rDLqj+Oh6Y8Khycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543632; c=relaxed/simple;
	bh=3/4Yb5GvdpeqmkRv6UDmkOqW6uguTyQgWjtCOYs8m5k=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XgUqvZnOJ9RqbHMb/iueTlqFjjaiiu0mM+cq7U+T4xfg0coO10nEOUTFUWHyAPNzq8LK0k9MEmUpbIlOw5R1+BvDipmvag1aJnhl7CBu/5Zu37QuQ/gXeLyc6Np5x1v6S7fmcBwO+liw4Dfb1V7Y8umqFhk+H5neozAWz8YhWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOTmNL2H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOTmNL2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96190C4CEF8;
	Wed, 15 Oct 2025 15:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760543631;
	bh=3/4Yb5GvdpeqmkRv6UDmkOqW6uguTyQgWjtCOYs8m5k=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=qOTmNL2HnUcf5bQyOe9OnFPONkI/Lt4QPdPo3bWrJv88QY2SGnRWalqpkR5lVcfAb
	 ooQxNXPAlZxykICk/V1SCke+hNwpQw+sv1h58xWjJUY0/TuRokpHdTk4Xy36KfgNzb
	 ukuueGfQwpRGULBjcPxbefLIac/Y9Vc9gWl8e9fwIP9A/SWkAli/8icSNtvOE6TAGe
	 yudQfehapx0tivK9WtO4/wnQmDSlnZ3ite23jab4B5zGLKJD/7hQ6qOpcLb1HwDgLg
	 Utgt9fv+oG9YE4Hy/DS14dx0Ye8ouY1+MwHT6/oY3hZ34dmCJmlw19sb0NHz5Bfs3n
	 X8exgBwP3Mc0w==
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
 Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
 Vince Weaver <vincent.weaver@maine.edu>, Ian Rogers <irogers@google.com>
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
References: <20251005182430.2791371-1-irogers@google.com>
Subject: Re: [PATCH v7 00/27] Legacy hardware/cache events as json
Message-Id: <176054362630.22559.13423487878652916137.b4-ty@kernel.org>
Date: Thu, 16 Oct 2025 00:53:46 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Sun, 05 Oct 2025 11:24:03 -0700, Ian Rogers wrote:

> Mirroring similar work for software events in commit 6e9fa4131abb
> ("perf parse-events: Remove non-json software events"). These changes
> migrate the legacy hardware and cache events to json.  With no hard
> coded legacy hardware or cache events the wild card, case
> insensitivity, etc. is consistent for events. This does, however, mean
> events like cycles will wild card against all PMUs. A change doing the
> same was originally posted and merged from:
> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
> his dislike for the cycles behavior on ARM with perf record. Earlier
> patches in this series make perf record event opening failures
> non-fatal and hide the cycles event's failure to open on ARM in perf
> record, so it is expected the behavior will now be transparent in perf
> record on ARM. perf stat with a cycles event will wildcard open the
> event on all PMUs, however, with default events the cycles event will
> only be opened on core PMUs.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

