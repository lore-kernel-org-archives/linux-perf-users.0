Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404F3314D2;
	Mon, 23 Feb 2026 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873953; cv=none; b=cCXldfa34xwM80Cp+A7onFuUIK5t08JhJwxFCUBUtx3m2TkbUsKRBFWFGiZUo5HFSKDELf4Du599AR0xnMvSqndwiUS7ASa9LAVcc69p2ajflo0nwautixPiSQGqGqHT/Lhp6WYUBQBUmoy+Pn8tXTtku4jqpJlZcPkNsUw3DKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873953; c=relaxed/simple;
	bh=LsDZz1xBbsKr0HvG8NaFTXkFAP/ESgqO9rC52rJZe+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmS7i+KjB6b/mRj4ZiPzKOw08bmljIeedHUXN3PZ3hUjAuJuEIEJ/YFU3gs49zvx/Pinc40eRtKuEtzAWl5huho/BpEGUNgJLgPNhLqGMX6dv7J6/M5sn1XQbZQC9WXf2dQ9A5uVK6sHy6bd+rRW2A5T3DbSITjK+wjrymOqB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5yfjozp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5yfjozp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F46C116D0;
	Mon, 23 Feb 2026 19:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771873952;
	bh=LsDZz1xBbsKr0HvG8NaFTXkFAP/ESgqO9rC52rJZe+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5yfjozpNNgLw367B5byAKP3PwekK+zDn5ZGMIWcy8Fh8nUDA0JE1FQNfiUje1rYL
	 DpYYjCl4q0Kwms19E6TRltUgPF4uFWs+Q9IXl+OrqflbSbeglt8cUGASQiNHG7gzzL
	 juKlnpfNku3lJGFi2JAWViRTHUImFsvr000t0p8eS2nO1U/fwT7DLFdNOIJZuq0hDg
	 d7pqNb5rcuh+AEBnkbcft0mcsl8vS1TIt90Tr0Hw4BIc0lE/zGArVMbSz8ZdlhVq7K
	 5Fk6eDcfR3KWApVATtyZGsacmEIbE5/XqKKHqHdIcYTlxi7imWhj/3e4MhTyEDexX1
	 3VQfTByv2fJuw==
Date: Mon, 23 Feb 2026 11:12:27 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf bench: Fix initialization of union
Message-ID: <aZymm3rGRtztu29p@google.com>
References: <20260219004417.188434-1-namhyung@kernel.org>
 <a91a44a4-a918-4edd-9fe2-2274d5213dcf@linaro.org>
 <ea82e2ab-ddb5-419b-aa70-49b28f18383a@linaro.org>
 <20260219150256.GC136967@e132581.arm.com>
 <aZdd2clm2RQGLnT4@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZdd2clm2RQGLnT4@google.com>

On Thu, Feb 19, 2026 at 11:00:41AM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Feb 19, 2026 at 03:02:56PM +0000, Leo Yan wrote:
> > On Thu, Feb 19, 2026 at 10:38:57AM +0000, James Clark wrote:
> > > 
> > > 
> > > On 19/02/2026 10:36 am, James Clark wrote:
> > > > 
> > > > 
> > > > On 19/02/2026 12:44 am, Namhyung Kim wrote:
> > > > > Recent compilers don't initialize all members (or the largest member) in
> > > > > an union.  Instead it seems to set the first member only.  So some perf
> > > > > bench output shows invalid numbers like below on my system with GCC 15.
> > > > 
> > > > I couldn't find V1 of this so I wasn't sure if it was discussed already,
> > > > but wasn't the plan to fix this with a compiler option:
> > > > 
> > > > https://lore.kernel.org/linux-perf-users/20250319110454.3230687-1-leo.yan@arm.com/
> > > > 
> > > > and
> > > > 
> > > > https://lore.kernel.org/linux-perf-users/20250320105235.3498106-1-leo.yan@arm.com/
> > > 
> > > Oh I see V1 was only the second patch, that's why I couldn't find it.
> > 
> > Thanks for bringing up this, James.  The latest patch would be:
> > 
> > https://lore.kernel.org/lkml/20250402173056.829400-1-leo.yan@arm.com/
> > 
> > This patch intends to apply the option across tools, but no response
> > from the maintainers.  Seems to me, it may be good enought to apply the
> > option to perf first.
> 
> Thanks for the reminder, yeah it looks better.

Leo, can you please resend that patch to linux-kbuild list and CC the
maintainers?  It seems you did it to Clang folks only..

Thanks,
Namhyung

