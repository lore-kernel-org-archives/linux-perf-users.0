Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869448122E;
	Thu,  4 Jun 2026 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582439; cv=none; b=mk57eve/YrONQJH7ajEQuJDwHCdlt8GZCSoUU4oadCDf4RXmbEM2KLKhrnWpRzRIpZBZ7m6/QERSVsR+idLveUUbGFIyV142aOlGxGezJmRJUC1rIu+9DaY098E6PbXJpSLRAx6/8TEWB94Yeb9RYtWTqBHwTzfaBcRtcICpa6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582439; c=relaxed/simple;
	bh=9SNt5UkCWaS+RaMplNCgE7bZjU8OHtggEaTfCN5D7w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwobT+JSxZ25E7YuMm8n8UHPQQYZMoG3Vfx8dYTbQzhCZx8yveyxDG5gBcIuszfBxy4XrDrNvJIGmABADKD35BLqZSaX2QW+1J0u9d8n5a9uGmt8nyhlNQ6KO7zCwn4sB2gx0n9aKQZSY8yh4324zyRhJOmM1YC0+/Dql8Y25A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouMpxFKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouMpxFKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5531F00893;
	Thu,  4 Jun 2026 14:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780582435;
	bh=H8rc8zwK9puL2XKBHl+yIc6AZF882i4Ze9wOrzu0+O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ouMpxFKSoNiSuvqpqM/zN2qcHVStRQkt4E1TbKON0re6emHamGz4A0OSDVFmpkJ/X
	 c92zfRg8cU1ArsYLQNgfjN7EsY2R1++wbS4WoeIGEBHiggEhsggcPxPiUIb3qAl0qa
	 q5+EIybabZAb6Irge+zKyi5IR+BTtCmFwVRADCdKIYK2uRSIn343fVBLB65T9dgvNW
	 e9jXs/fsg5nPInDaIZzx94Ldwc5M0lwRUYES/x3QTXEvIzjnzX1g5FWfXwW7mGn0FQ
	 Ty5w0z+WqDQfK3dj09nDKQWYXiJymKfn46Tzdw1BrgiWhwIWQPBymxLfLErnqBsqBd
	 vNw55LIfiEofw==
Date: Thu, 4 Jun 2026 11:13:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf annotate: Fix crashes on empty annotate windows
Message-ID: <aiGIIBdqhFes5wJr@x1>
References: <20260420-james-perf-annotate-assert-v1-1-ddf04d640569@linaro.org>
 <aegvUXJTQT9qRoDs@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aegvUXJTQT9qRoDs@google.com>

On Tue, Apr 21, 2026 at 07:15:45PM -0700, Namhyung Kim wrote:
> On Mon, Apr 20, 2026 at 12:52:17PM +0100, James Clark wrote:
> > Annotate can open with an empty window if the disassembly tool fails.
> > After the linked change, the TUI started assuming there was a current
> > annotation line and could assert or segfault in the seek, refresh, and
> > source-toggle paths.
> > 
> > Handle empty annotate windows explicitly: set the asm entry count before
> > resetting the browser, return early when refreshing an empty list, and
> > ignore source line toggle when there is no current annotation line.
> > 
> > Fixes the following when opening an annotation:
> > 
> >   perf: ui/browser.c:125: ui_browser__list_head_seek: Assertion `pos != NULL' failed.
> >   Aborted
> > 
> > Fixes: e201757f7a0a ("perf annotate: Fix source code annotate with objdump")
> > Assisted-by: GitHub Copilot:GPT-5.4
> > Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
