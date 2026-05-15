Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480713D1ABD;
	Fri, 15 May 2026 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845886; cv=none; b=dhIrz5P5Uy8r3W3SVWkIUpdIHmW9Fxi9vhdxX7V9Pt/uMPbkXu6QHLOXAI/fz3R1q0edFXvY+xa2Bcl2CSxhW1cKdqPz9m1XlN3yg/tKOr08AgRUM1Ld0pp1XllKSOfFJJooudCIbuz1V8+IK0zxK2FGCf1F7hHSDurpoQFoLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845886; c=relaxed/simple;
	bh=n95M2QJ4RRSnUXpm5gDe3i8cdskGupJR10RF6SmWsnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekS5VOkHzQof5kKmQacJvSnYEbSyr6Wq971JscVurrT4xxZ8mWg9xhiT0SjhRTAaSnQ4LyhY3q8NeCw+G3DQh6Y5IsQ3d+N77jr01sWpqBbzfh9zqGec25c9AL+0lgAflHZaeQ4aiwkcEiF7Cvz1Nv0FA2Fe5q9qWMTAB3Vw6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aB2L+4nr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aB2L+4nr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69954C2BCB0;
	Fri, 15 May 2026 11:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778845885;
	bh=n95M2QJ4RRSnUXpm5gDe3i8cdskGupJR10RF6SmWsnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aB2L+4nrPjPEzq4r08tPHTLYm4vYBJh1Twie1ze3R+8eO+Z0+UtlHjP/x5gpHMS4a
	 7RotCVJ7MOqHyGzicj+4mgV90s2gAHjICortKCepoTFPHu/a0U7ck3TASCGsyoH8kl
	 M7n1dllw0K1pGT/gMLZT6E79R6DMZCQIY+EWxBB/meHQV96wioRhdGSKAGLDv/2YDH
	 fsOwVplkAO+kvLFesBiJxiy4UreAH7wovqqSx6MXA/k11XZFJKKVqVl7CpZsMj1181
	 AABP37gBVDgcJcZEImCLo7AvFGSra/W1gr2O1JwGKh6g1iS+/JhNB4Hkre7tSFgOBY
	 kBClv6GQaIiLw==
Date: Fri, 15 May 2026 08:51:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf pmu: Skip test on Arm64 when #slots is zero
Message-ID: <agcIuroGWo0UrkVX@x1>
References: <20260410-perf_fix_pmu_metrics_test-v2-1-61826ab3ca8b@arm.com>
 <CAP-5=fWEU5qqTHjisUyDJMQQB5yFibyogMwAerTs5VUF0OSPHA@mail.gmail.com>
 <20260513143705.GG34802@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513143705.GG34802@e132581.arm.com>

On Wed, May 13, 2026 at 03:37:05PM +0100, Leo Yan wrote:
> On Wed, May 13, 2026 at 06:10:00AM -0700, Ian Rogers wrote:
> 
> [...]
> 
> > We get this failure for these metrics on x86 when building perf with
> > JEVENTS_ARCH=all. Rather than expecting the parse failure perhaps we
> > should just always return true in tool_pmu__read_event:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/tool_pmu.c#n421
> 
> I considered returning true when slots == 0 so can mute parser error
> and allow the test to pass. However, if so platforms which do not
> support #slots would be able to use those metrics and generate
> meaningless statistics.
> 
> I would keep the parser errors so this is a reminding when users wrongly
> use unsupported metrics.
> 
> > I guess the problem there is that when these metrics are broken (no
> > slots value) you can't distinguish this case from other valid cases.
> 
> IMO, this is a test design issue: tests should validate metrics while
> remaining hardware-agnostic. Hardware-specific cases should either run
> only on supported platforms, or the tests should be refined to run
> transparently across different hardware.
> 
> > Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks for review!

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
