Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F69924DCF6;
	Thu, 13 Aug 2026 02:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786587961; cv=none; b=i0H7om+hfDoZmh92tsoisKtA7y6kTHcHsChdk7hRhoq79RdYqCbSbowZH2O9W0TxYGZdp6L/Y1GYi/ZgbQL7aIfX8yO6qesi06BwrOM5hd4Ng59chhKsxt97HDC34W0suHZ8gtUuaD2pulM+BmvXkxYd2q3soDdZCW24IQiWrek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786587961; c=relaxed/simple;
	bh=eipdCnxkaqszQCxPkIf0sdIYQfIr81X5WPLi0NOiGnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEdmovIGzTgwi+PzBwaxSYSiBOgwKkkWm+eZ8V+ua4ESOWH78LO+rijeVQsbb5Q4vj4+UGZmecejPl0ImJAOsBitvyRYfgUG6s5fo9l2v2IymDItmTHghzJYC4vO3Z585Hh7F7LN0lcmn0YmFx8m2SvShV69cvLse15MyDFcjtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZVOdbtT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZVOdbtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506651F000E9;
	Thu, 13 Aug 2026 02:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786587960;
	bh=JmEpeEfbcgcIgHzXOgXv42FKwni45m9edtprSA9tkZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GZVOdbtTWPLqPwD1BcNskEe0EnZ1oTDQg7+IiSfsLsaBzIMRzXjMI3E8oHUYPS4zG
	 aE4PZKc3ndhCrDVBjbNWflxGAwau0BGhY43ui5QI4BUt7Vg+TloEEQFvZc69zoCVhP
	 kH6p6vYlO7CroJ2A+FNF68ded67Dsny7z1Ojbn3FMULjqBhPHkG14tA2/09xc04c4D
	 Hm9JUd/nilPbxxrYAPmA3L3btINXG0KntOboSkUJrU+JmWq/kvS48eaYutMBT+lJnp
	 VwnNFea5jjVCvdLqWhuhFAdE1/iupuxuQn7koCkZRD/ALHNQ3Mq6ulFgq3FCTTCEc1
	 JjKCLq1iLZ7pQ==
Date: Thu, 13 Aug 2026 11:25:54 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH 3/5] perf dso: Use stored fd error instead of stale errno
 in file_read() and file_size()
Message-ID: <an0rMidlKOX1LrgV@google.com>
References: <20260811175140.7235-1-acme@kernel.org>
 <20260811175140.7235-4-acme@kernel.org>
 <CAP-5=fX4AC7yPa_6xXoVmAswhUetnvth59mtPpHmX8Qp4bdf5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX4AC7yPa_6xXoVmAswhUetnvth59mtPpHmX8Qp4bdf5w@mail.gmail.com>

On Wed, Aug 12, 2026 at 04:12:52PM -0700, Ian Rogers wrote:
> On Tue, Aug 11, 2026 at 10:52 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > file_read() and file_size() use ret = -errno when
> > dso__data(dso)->fd is negative after try_to_open_dso() fails.  By this
> > point errno has been through mutex_lock(), nsinfo__mountns_enter(), and
> > multiple open() attempts inside try_to_open_dso() — it no longer
> > reflects the actual open failure.  If errno happens to be 0, ret = 0
> > looks like EOF rather than an error, and file_size() callers like
> > dso__data_size() would then report a zero-sized file instead of
> > failing.
> >
> > dso__data(dso)->fd is always negative on failure — -errno from
> > __open_dso() when no filename could be built (e.g. -EINVAL, -ENOENT),
> > or -1 when do_open() itself failed — and never 0, so use it directly
> > instead of reading the stale global errno.
> >
> > Fixes: 33bdedcea2d7 ("perf tools: Protect dso cache fd with a mutex")
> > Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Assisted-by: Claude:claude-opus-4.6
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/dso.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 124193453675ca18..32ae5c78cdb906e6 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -1029,7 +1029,8 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
> >
> >         if (dso__data(dso)->fd < 0) {
> >                 dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
> > -               ret = -errno;
> > +               /* fd is always negative here: -errno or -1, never 0 */
> > +               ret = dso__data(dso)->fd;
> 
> nit: we can "assert(ret < 0);" to verify the comment.

It's already checked in the above if statement.  I'm not sure the
comment or assert is necessary.

Thanks,
Namhyung

