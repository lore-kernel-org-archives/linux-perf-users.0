Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C71845C1C;
	Wed, 28 Aug 2024 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880194; cv=none; b=tuU1Y71gW1XGq/Ar8bX3SXTjZFI5qbW2MBL5Cf/eqWSxP5w/QCEB8VMhzBczxiOJ63HMXpglvUb3MZXwtOoPiuq424292oWhjE6nGupxsp4NC4Njk9RwczZ5OwreEhiiZHEY5uBIzZB/N5f4m2Q00objMezEF/WQr1ellbN7wwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880194; c=relaxed/simple;
	bh=4Uh2dt5mIcP/LqUTE9Z/MwR79r2opkE/XAZV52ER0UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0d44qsiErfmfxIMH78xAQ9Klo9ZQukEcVfFet5mEet5HFP8gOjMK0YaF2pJ2hjkFchQdTkxmlWbRH3I+efIlmO/oF/bdT9tQJe5IgnA8sCJrOW1DelhyY3iHuMHayw1P1g5LiqnYIg08dFrfZIYZN8xN11GYQ7Y+dBzz3se26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kE0q9W5S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kE0q9W5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC69C4CEC0;
	Wed, 28 Aug 2024 21:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724880194;
	bh=4Uh2dt5mIcP/LqUTE9Z/MwR79r2opkE/XAZV52ER0UE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kE0q9W5SoHJ5kLXIf+HV7stKQB9wh4iDCzUUDtpRrgwe/1xjtHkZo7bt3GENs+DUX
	 vJeBkxS7nsvK/V10S3wi+7d+x0vpMpKFLRqCWbjIfEf2lIG4oJ2gjg8rm7TIj4TPp1
	 99ItcB+D+GqEo9YFnLBAhW0T5IJ/5rXKDjbpbNX5Fm+r0xZQ7auu6XAsQ+QNPRh3R0
	 WCQL1ufqlyfzmi0oE2sfqm39sX8wVhPN2eacNtlyeofgwSZQ6WzxTT0SH5VpNIoNKH
	 YZeN2AE7psv9vbr/DMMtKMcj3yHchukydsOMMxkZN9SvGPSZLdGQUqyP/EwPhuwzPV
	 gK2XWqQtnxXwg==
Date: Wed, 28 Aug 2024 18:23:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Matt Fleming <matt@readmodwrite.com>
Subject: Re: [PATCH 1/4] perf report: Fix segfault when 'sym' sort key is not
 used
Message-ID: <Zs-VP5uWCeIdooB_@x1>
References: <20240826221045.1202305-1-namhyung@kernel.org>
 <20240826221045.1202305-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826221045.1202305-2-namhyung@kernel.org>

On Mon, Aug 26, 2024 at 03:10:42PM -0700, Namhyung Kim wrote:
> The fields in the hist_entry are filled on-demand which means they only
> have meaningful values when relevant sort keys are used.  So if neither
> of 'dso' nor 'sym' sort keys are used, the map/symbols in the hist entry
> can be garbage.  So it shouldn't access it unconditionally.
> 
> I got a segfault, when I wanted to see cgroup profiles.

Thanks, applied the series to perf-tools-next,

- Arnaldo
