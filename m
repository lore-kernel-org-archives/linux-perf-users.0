Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6EF3E51D6;
	Mon,  4 May 2026 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917271; cv=none; b=qhj0jNJK7x9DfrpMP3l3q2JkgHWxcsXB+AfAkVZgmlcz8btAKRkdZyoc8sCtWhV+0v2aoQX8//MHWSZDSC/k4wzcwvRFjkmzlhISnlBQ0hWCb/IuKPH41kjDMLROAgxK35HUD6Xiv4A9SOfDMm/bYxk7KkV1zEksDU3JPR0M9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917271; c=relaxed/simple;
	bh=leccLOhiq2QdlaHtZZKF8/D6p8Lo6PBNkeGX3IE8ZOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtgzDig7C4vNnzina5nvwr/GWXiWH3OYWYBl2lzlM61F1dJRDcElmVVOfm0jkXx98zyp94umMqCOijvNeV2BRfeKh2TWnwtLT486lfU8BgfVZnC1aV9uWOtZQ7O4iUpwMkjLXClWvCDAUpoxj6/s5U0eYU47FbFMui+Gg4PRshU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGERB53g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGERB53g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98502C2BCB8;
	Mon,  4 May 2026 17:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777917271;
	bh=leccLOhiq2QdlaHtZZKF8/D6p8Lo6PBNkeGX3IE8ZOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGERB53gey32knu4DwMMUoBi2esMPCP6qjlQ3fQo/MeJDP0bjCibiIqJlJkJcMuWF
	 j84zfJqEhE8SQDeYZeub8LpZJwvOS8jX+dVv3Ay9HHQk2M1abY745oq6y4ObxxojVP
	 6mQhAwCdkfyLcLUciL+46droy9ot7AXFemvpaQYGO16fKX3uq25mQa3ojHrO4TERaX
	 eLwnE4SXayKgHiS2LOwk+i48aO453XIiz9IQmnd+NO8IszLnnv4omFBvgbv2ggMwaJ
	 F1FzK4NuGSRu1v5+qdozQKmE6Ij5z/gZrwOGc7M7Pmp/vxid1CeTqrNW3Pps6aOogS
	 9yTjdGOJYubBQ==
Date: Mon, 4 May 2026 14:54:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
	sashiko@lists.linux.dev
Subject: Re: [PATCH v5 9/9] perf debuginfo: Fix libdw API contract violations
Message-ID: <afjdU9yZ5WYNgyc5@x1>
References: <20260504081227.2203848-10-irogers@google.com>
 <20260504105301.29676C2BCB8@smtp.kernel.org>
 <CAP-5=fUuqcGCgpZApHbqpP8hxs2Y+FYU2W=h1T0D4qgdhOfdBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUuqcGCgpZApHbqpP8hxs2Y+FYU2W=h1T0D4qgdhOfdBw@mail.gmail.com>

On Mon, May 04, 2026 at 08:26:34AM -0700, Ian Rogers wrote:
> On Mon, May 4, 2026 at 3:53 AM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Critical] This problem wasn't introduced by this patch, but the open() call in debuginfo__init_offline_dwarf() lacks the O_NONBLOCK flag, exposing a local Denial of Service (DoS) vulnerability.
> > --
> >
> > commit a6e339ae66465b909762a437f958cdaed424b666
> > Author: Ian Rogers <irogers@google.com>
> >
> > perf debuginfo: Fix libdw API contract violations
> >
> > This commit adds return value checks for dwfl_report_end and
> > dwfl_module_relocation_info to prevent potential segmentation faults. It also
> > fixes a file descriptor leak in the error path of
> > debuginfo__init_offline_dwarf() when offline initialization fails.
> >
> > > diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> > > index 0e35c13abd04..84a78b30ceac 100644
> > > --- a/tools/perf/util/debuginfo.c
> > > +++ b/tools/perf/util/debuginfo.c
> > > @@ -42,6 +42,7 @@ static int debuginfo__init_offline_dwarf(struct debuginfo *dbg,
> > >  {
> > >       GElf_Addr dummy;
> > >       int fd;
> > > +     bool fd_consumed = false;
> > >
> > >       fd = open(path, O_RDONLY);
> >
> > While this wasn't introduced by this patch, could this open() call cause a
> > regression by hanging on a FIFO?
> >
> > If the path originates from user-controlled sources, opening it without
> > O_NONBLOCK can cause the perf record session to hang indefinitely. Using
> > O_RDONLY | O_NONBLOCK would prevent this.
> 
> So this review is bad and based on this prompt:
> https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/perf.md#file-io-safety-on-untrusted-paths
> 
> I'm trying to get the bad prompt removed. The prompt was automatically
> generated from fixes commits when we added O_NONBLOCK to address build
> ID reading hangs, particularly for data mmaps during perf record
> synthesis. We now avoid those hangs by checking for a "regular" file
> with stat. Therefore, the advice regarding O_NONBLOCK and EINTR from
> the prompts is incorrect and does not reflect what the code base does.
> 
> Side note: this is the only Sashiko feedback on this series:
> https://sashiko.dev/#/patchset/20260504081227.2203848-1-irogers%40google.com

I'll process it soon,

- Arnaldo
