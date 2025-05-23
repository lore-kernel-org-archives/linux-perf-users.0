Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30CE2DCC01;
	Fri, 23 May 2025 01:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747964975; cv=none; b=YDZIuq+sa0FpScSOVpf6Ye2gYr2tp4DBdSj6efWx2vwgs725Rp8P/bIHf2FEmI8tvwsMDc12KHohN0iw8c2iCoTr8rZBye8qXgyXiuu1fokPGErrDw2VnYtvKfgF96S8ZhM7J+AGeBcxDmIzHwThGkrRKUkR+KbNSOu9qw8t0ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747964975; c=relaxed/simple;
	bh=BWE/aCv+QCucuVvaehO2QfeeLX032ZzjTb4Yk6HF8IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apifV7O9Xe8ACBZJ/2u7grNVfoH9OJOpBfKS5KwS9VrPMTf+rBoBoY8vk7qxYIQYVieRUVVkSgz135ImACpXXUW9QLLIQCWVDFwq4ZLVBM/+GKoO2lkRymx6/QGtfn5qeZ23FPWPrxJwk0WEo9R862QktoiH3wMDHmf3/zVCg7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQniUM0z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQniUM0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07FBC4CEE4;
	Fri, 23 May 2025 01:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747964974;
	bh=BWE/aCv+QCucuVvaehO2QfeeLX032ZzjTb4Yk6HF8IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQniUM0zZHlayCTeNfgaSV1K2wPzLCkiKN+8XkiZ73ZfCcQdTSTCliaZPRPv97F4A
	 4Z5i3CR4BIT4auBnyOAiH5sb/MGRM3exmYRZxd/3v7U/qu0JXr9yz/odEk80McBTTr
	 GWsO6CcP89vp1Qmdfq3d6EILxHLkhGD3dKr56D8JpqDaikJckFtVbXmqJfKKCjDv7o
	 XllcKJtFMSnT8/vOYYsUcRHq6PkpoVmvnpicFNdBm06hxRUNzquYYfBoAXM5sRO2GF
	 ZTdMwHPAdtYpIUS5qbxl6xFfyExX6mn8uWjBcyU+SfLLiExy9CAdNcDtEX2LtTlvDX
	 sTGncYUuP8NWw==
Date: Thu, 22 May 2025 22:49:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests switch-tracking: Fix timestamp comparison
Message-ID: <aC_UKwuokMuf-kzD@x1>
References: <20250331172759.115604-1-leo.yan@arm.com>
 <CAP-5=fVsgahBhOEOac52PmL0V+n1jqAxzf7n9PVWgWsxq9TvgQ@mail.gmail.com>
 <20250401091422.GA115840@e132581.arm.com>
 <CAP-5=fUGLy9xGmMO+6PXvfviB4U8Q8O7H3iTSSqEf72vin8gDA@mail.gmail.com>
 <20250402090516.GG115840@e132581.arm.com>
 <20250516153158.GH412060@e132581.arm.com>
 <aCvgbd5dZrF0YJg7@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aCvgbd5dZrF0YJg7@google.com>

On Mon, May 19, 2025 at 06:52:45PM -0700, Namhyung Kim wrote:
> Hi Leo,
> 
> On Fri, May 16, 2025 at 04:31:58PM +0100, Leo Yan wrote:
> > Hi Ian, Namhyung,
> > 
> > [ - Mailing list ]
> > 
> > On Wed, Apr 02, 2025 at 10:05:16AM +0100, Leo Yan wrote:
> > > On Tue, Apr 01, 2025 at 12:54:12PM -0700, Ian Rogers wrote:
> > > > On Tue, Apr 1, 2025 at 2:14 AM Leo Yan <leo.yan@arm.com> wrote:
> > > > >
> > > > > On Mon, Mar 31, 2025 at 01:18:31PM -0700, Ian Rogers wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > I'm reminded of a Java check I wrote for this:
> > > > >
> > > > > Nice short article.
> > > > >
> > > > > > In clang -Wshorten-64-to-32 looks to cover this. I'll see if we can
> > > > > > clean those warnings up a bit.
> > > > >
> > > > > I checked a bit and seems GCC has no this flag, but it makes sense for
> > > > > me to enable the flag for Clang.
> > > > >
> > > > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > > >
> > > > > Thanks a lot, Ian.
> > > > 
> > > > I made a small variation to the change in:
> > > > https://lore.kernel.org/lkml/20250401182347.3422199-10-irogers@google.com/
> > > > to avoid a subtract and just directly compare the values.
> > 
> > Do you mind to pick up my this patch? :) Our internal CI reports the
> > test case 109_Track_with_sched_switch failure daily, I am just wandering
> > if we could apply the fix quickly.
> 
> Arnaldo is taking care of patches for v6.15.
> 
> Arnaldo, can you please take this?

From what I understood it people agreed to pick Ian's patch, ok.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> > 
> > Ian is working on a patch series for resolving the Clang warning which
> > also includes a fix [1], if Ian could extract the fix for the compar()
> > function in switch-tracking.c, this either would be fine for me.
> > 
> > Thanks a lot for your helping!
> > 
> > Leo
> > 
> > [1] https://lore.kernel.org/linux-perf-users/20250401182347.3422199-10-irogers@google.com/
