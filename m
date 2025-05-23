Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE82DCBE1;
	Fri, 23 May 2025 01:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747965111; cv=none; b=qPCcsrzcplVIQr/7JncE7zD0waqFRtcu1pqFol2YlxdMQGiEws3uIA41c7uD/hn+M/MtZxG2x8/3kv/1AEcSOO8NMgOZhex1jNgoXqR1Px+EitIjjpetIptkUDyvx7P6vPIYSm6Exsk/SugN82a2y2bQ0uvPORUk7vDE7tBfZnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747965111; c=relaxed/simple;
	bh=8S+It+iOZUj7PzQhjL+wxzQATMEcIxRIc0xwYa5veuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC5+RwQ8dWuO5/iiPoKwFqKrD7yfhuBLAbdFGemXbTccj3cv2Io2Ozlwv5MfOJCIgkJcGmgG++NaoX2HCHpZHJHzFBcTweGJYj9LlSJjV0y82aBED+8vyYhlq8gUNS3q9vSiFAhQF6vgwEqrAl2jfTy58pHuW8+3ivkwiW/0gdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArdZegg3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArdZegg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483B8C4CEE4;
	Fri, 23 May 2025 01:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747965110;
	bh=8S+It+iOZUj7PzQhjL+wxzQATMEcIxRIc0xwYa5veuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArdZegg34/+WQEnnQxMgxsln8hSUNpzbj5nyEB+iCKxWGdHCkMuSSHg04ml3igFqL
	 ObKpUmJ5S52wOO7HseXTDWl9Y1ojP1c73ChJUdr6e3y7URM95DXMdTP72TGg43n9dr
	 jiMNdUgiIJx6wwoImp2OZLdC3/OWX5FkBwq2D70uUmj794WWnlcxuPSl6I9OIMyUxx
	 1GKy8cdL9ga0pvWtn71wlhZIXfhHvBxzr1uEv6sYHWMHJ6caZ0mvUkxc9tkwRKupia
	 PqhLd5SIBktte6jmD1om5cXR/fPhCn9zEyynkpaxWx0YcP/LvKB54sxSwCW1ZESsVu
	 k9nhRILl28faA==
Date: Thu, 22 May 2025 22:51:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests switch-tracking: Fix timestamp comparison
Message-ID: <aC_Us1xcKCmYFy_5@x1>
References: <20250331172759.115604-1-leo.yan@arm.com>
 <CAP-5=fVsgahBhOEOac52PmL0V+n1jqAxzf7n9PVWgWsxq9TvgQ@mail.gmail.com>
 <20250401091422.GA115840@e132581.arm.com>
 <CAP-5=fUGLy9xGmMO+6PXvfviB4U8Q8O7H3iTSSqEf72vin8gDA@mail.gmail.com>
 <20250402090516.GG115840@e132581.arm.com>
 <20250516153158.GH412060@e132581.arm.com>
 <aCvgbd5dZrF0YJg7@google.com>
 <aC_UKwuokMuf-kzD@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aC_UKwuokMuf-kzD@x1>

On Thu, May 22, 2025 at 10:49:31PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, May 19, 2025 at 06:52:45PM -0700, Namhyung Kim wrote:
> > Hi Leo,
> > 
> > On Fri, May 16, 2025 at 04:31:58PM +0100, Leo Yan wrote:
> > > Hi Ian, Namhyung,
> > > 
> > > [ - Mailing list ]
> > > 
> > > On Wed, Apr 02, 2025 at 10:05:16AM +0100, Leo Yan wrote:
> > > > On Tue, Apr 01, 2025 at 12:54:12PM -0700, Ian Rogers wrote:
> > > > > On Tue, Apr 1, 2025 at 2:14 AM Leo Yan <leo.yan@arm.com> wrote:
> > > > > >
> > > > > > On Mon, Mar 31, 2025 at 01:18:31PM -0700, Ian Rogers wrote:
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > I'm reminded of a Java check I wrote for this:
> > > > > >
> > > > > > Nice short article.
> > > > > >
> > > > > > > In clang -Wshorten-64-to-32 looks to cover this. I'll see if we can
> > > > > > > clean those warnings up a bit.
> > > > > >
> > > > > > I checked a bit and seems GCC has no this flag, but it makes sense for
> > > > > > me to enable the flag for Clang.
> > > > > >
> > > > > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > > > >
> > > > > > Thanks a lot, Ian.
> > > > > 
> > > > > I made a small variation to the change in:
> > > > > https://lore.kernel.org/lkml/20250401182347.3422199-10-irogers@google.com/
> > > > > to avoid a subtract and just directly compare the values.
> > > 
> > > Do you mind to pick up my this patch? :) Our internal CI reports the
> > > test case 109_Track_with_sched_switch failure daily, I am just wandering
> > > if we could apply the fix quickly.
> > 
> > Arnaldo is taking care of patches for v6.15.
> > 
> > Arnaldo, can you please take this?
> 
> >From what I understood it people agreed to pick Ian's patch, ok.

But that is part of a larger patch, so since Ian reviewed Leo's patch,
I'll end up picking the more contained one, no bandwidth to check all
the other parts now.

- Arnaldo
