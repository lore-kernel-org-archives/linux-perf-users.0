Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4352E18DB20;
	Sat, 12 Apr 2025 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744490554; cv=none; b=kdC13lWLgX+RO8/upJldUT7C1205GhsZGIPIUaQOU+U/8TtCk0PJ1AeJc5qRhHUn/5JmSag3aU7aQ73huB2hbFq1RKFk1F/LWJUwLDXHqNTks9SdQQUa4WKNAfl4HRiSkW2PFRvuttEQHHVRI45lAzD0GBxvKcXVSygUoMZ5FXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744490554; c=relaxed/simple;
	bh=67nwnmAQRibIdssEsdv9dREv+MhzN5xv/2g8tq8XfiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg46jlYQjmYxX6TTRz9oi3B3tnUFlX8LO/QWmLN3zhQM7eby+knGgx6540ZhoFNu+FHsCMue25SVvanQ7VefjRtM5Rd8U6rE9Zc9Cwr3U6oYvSd6SNyYM/x3Hcyv6fMDmPJ8U39OnJGyV9x1ttaxwOllp5b1uvHIeum8YiEANxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9cM1Ak5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9cM1Ak5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC90C4CEE3;
	Sat, 12 Apr 2025 20:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744490553;
	bh=67nwnmAQRibIdssEsdv9dREv+MhzN5xv/2g8tq8XfiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9cM1Ak5DFmc1MALV8VTCx2DznegMuxrQRlrZ7p1gt+laVV3ehKGKitZ1/Knm2l3L
	 feqj+CXyUJQQcLjI8xtcKNJXLrrWvQBGHLeB/wlyNwmYumfwE1Cujt1YHKhEsJxWe9
	 QUu4vlgu/L8izyBcF6IAYVyJCAdls/jU7/R83CWjQWTfbHCNR3yMdi3qP4m+Q/1nTi
	 74gBspeJVkZeyn5N1Fm5hPumHYtdUPK7Ma1x3od0F0XkX9WuQZs9Hu74G0fGIF0w54
	 TtXIItXj4MpTyIpngSc+rOSQDI3L/JqvKjD9xKyr/Q/+7HbB68ra0wNA7aPrTDE3+5
	 Q6ldfHXaja1dw==
Date: Sat, 12 Apr 2025 22:42:27 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Mark Barnett <mark.barnett@arm.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	ben.gainey@arm.com, deepak.surti@arm.com, ak@linux.intel.com,
	will@kernel.org, james.clark@arm.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/5] A mechanism for efficient support for
 per-function metrics
Message-ID: <Z_rQMwKQDu6K66_r@gmail.com>
References: <20250408171530.140858-1-mark.barnett@arm.com>
 <Z_ZcRiHTGljxEEdN@gmail.com>
 <2fa741d8-13c7-49c0-a6c5-540a7c2cf3a7@arm.com>
 <CAP-5=fUukVQMRHUQ9Mpx38H-7VNLt4mDj-jaYgn8Tf4zjecD-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUukVQMRHUQ9Mpx38H-7VNLt4mDj-jaYgn8Tf4zjecD-A@mail.gmail.com>


* Ian Rogers <irogers@google.com> wrote:

> I don't think work should be gated on cleaning up perf report, top, 
> etc. which still needs clean up for things like hybrid events. As the 
> histograms should use the sample's period then I believe things 
> should just work in much the same way as leader sampling can work. 
> It'd be worth checking.

Yeah, so I think burst-profiling is basically still a single-event 
profiling mode - with a tooling-side filter that skips the long-periods 
and includes the burst-periods, and transforms all the statistics and 
counts to make sense in the usual perf context.

Ie. I don't think it should be overly intrusive, and it could be a nice 
performance & profiling quality feature we'd consider using by default 
eventually.

Thanks,

	Ingo
