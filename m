Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F33155322;
	Thu, 30 Jan 2025 05:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738214930; cv=none; b=G7vSaVUxSlQURWfZZeQ9UZJLETo6pPFJEveuYkVDE2sjx8JDH76Msjze3ESdybvti5KEcVElX6i5KXINrcnY05RD9jNewEfpGi1mP30gzLyFeUP2t0fYO1IJLwFgxq6Yjl2WGG4CI8E2KPsJkTWAWvsPsHfPOVEq9CrD9ImrcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738214930; c=relaxed/simple;
	bh=DiRdtYdsu9uMY3nUFypndpe6TMDpayqt6CcMg9blSag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqMtbDnqcadp8DjifJQDIuVBvJQzjoC+DOpWe5P9aAFdH2NLgktevN6bIXuO9dn8AYkXcdgfYmi8Q6suI2Y/V5EXXVJpOwBiNlGM8WA6vsrGTKJM4rBOz4wMk/pDDAKaprU1s9AkBRVo+zX0vfuutrSWSz52y4DBonENRBGZ/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYAzNYTQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYAzNYTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BB5C4CED2;
	Thu, 30 Jan 2025 05:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738214930;
	bh=DiRdtYdsu9uMY3nUFypndpe6TMDpayqt6CcMg9blSag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYAzNYTQOY17OyCI94WbM2/z6yeyK1mHdlJaCkdzzIindRjexgwghh5oHCxd8ClS8
	 ipdr+9+xxf3z3jb+rGv3xbam6vSmn0VJsMjivykEJJUNiuGGnNZ7vlAOTU2XWEwvC1
	 pLLWPiapNx8m6XIrqDTHbRpben2/ilMLFMrcCnWto4S3fEPeGcDoRKASVXiK08mtA2
	 7fAxow7HQhaHw1KChNkFmmBU5mDToLN8z/FWieAQI1tvw0DkJutK3wVX8bDDgzp4eU
	 LiQ9YAyQD9XCvj/CS/bvmKMwaR4Xy4UYiA9CLomf0wIwCg5Nh1OwPkzf4zrm74ZBRa
	 kUiU/Xh/7nucQ==
Date: Wed, 29 Jan 2025 21:28:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 2/7] perf report: Add parallelism sort key
Message-ID: <Z5sOEPVh4-WGmhc-@google.com>
References: <cover.1737971364.git.dvyukov@google.com>
 <3e52ed435e0ce98e1108b172fdcadc4749a25c98.1737971364.git.dvyukov@google.com>
 <Z5mxzGdXJ27O4x-Y@google.com>
 <CACT4Y+Z1hFt6ttPPdoDSxw-BDjBhnhxDAunHQ4do2o56Ne3BDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z1hFt6ttPPdoDSxw-BDjBhnhxDAunHQ4do2o56Ne3BDQ@mail.gmail.com>

On Wed, Jan 29, 2025 at 08:18:34AM +0100, Dmitry Vyukov wrote:
> On Wed, 29 Jan 2025 at 05:42, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Jan 27, 2025 at 10:58:49AM +0100, Dmitry Vyukov wrote:
> > > Show parallelism level in profiles if requested by user.
> > >
> > > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: linux-perf-users@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  tools/perf/builtin-report.c | 11 +++++++++++
> > >  tools/perf/util/hist.c      |  2 ++
> > >  tools/perf/util/hist.h      |  3 +++
> > >  tools/perf/util/session.c   | 12 ++++++++++++
> > >  tools/perf/util/session.h   |  1 +
> > >  tools/perf/util/sort.c      | 23 +++++++++++++++++++++++
> > >  tools/perf/util/sort.h      |  1 +
> > >  7 files changed, 53 insertions(+)
> > >
> > > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > > index 0d9bd090eda71..14d49f0625881 100644
> > > --- a/tools/perf/builtin-report.c
> > > +++ b/tools/perf/builtin-report.c
> > > @@ -1720,6 +1720,17 @@ int cmd_report(int argc, const char **argv)
> > >               symbol_conf.annotate_data_sample = true;
> > >       }
> > >
> > > +     if (report.disable_order || !perf_session__has_switch_events(session)) {
> > > +             if ((sort_order && strstr(sort_order, "parallelism")) ||
> > > +                             (field_order && strstr(field_order, "parallelism"))) {
> > > +                     if (report.disable_order)
> > > +                             ui__error("Use of parallelism is incompatible with --disable-order.\n");
> > > +                     else
> > > +                             ui__error("Use of parallelism requires --switch-events during record.\n");
> > > +                     return -1;
> > > +             }
> > > +     }
> > > +
> > >       if (sort_order && strstr(sort_order, "ipc")) {
> > >               parse_options_usage(report_usage, options, "s", 1);
> > >               goto error;
> > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > index 0f30f843c566d..cafd693568189 100644
> > > --- a/tools/perf/util/hist.c
> > > +++ b/tools/perf/util/hist.c
> > > @@ -207,6 +207,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
> > >
> > >       hists__new_col_len(hists, HISTC_CGROUP, 6);
> > >       hists__new_col_len(hists, HISTC_CGROUP_ID, 20);
> > > +     hists__new_col_len(hists, HISTC_PARALLELISM, 11);
> > >       hists__new_col_len(hists, HISTC_CPU, 3);
> > >       hists__new_col_len(hists, HISTC_SOCKET, 6);
> > >       hists__new_col_len(hists, HISTC_MEM_LOCKED, 6);
> > > @@ -741,6 +742,7 @@ __hists__add_entry(struct hists *hists,
> > >               .ip      = al->addr,
> > >               .level   = al->level,
> > >               .code_page_size = sample->code_page_size,
> > > +             .parallelism    = al->parallelism,
> > >               .stat = {
> > >                       .nr_events = 1,
> > >                       .period = sample->period,
> > > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > > index 46c8373e31465..a6e662d77dc24 100644
> > > --- a/tools/perf/util/hist.h
> > > +++ b/tools/perf/util/hist.h
> > > @@ -42,6 +42,7 @@ enum hist_column {
> > >       HISTC_CGROUP_ID,
> > >       HISTC_CGROUP,
> > >       HISTC_PARENT,
> > > +     HISTC_PARALLELISM,
> > >       HISTC_CPU,
> > >       HISTC_SOCKET,
> > >       HISTC_SRCLINE,
> > > @@ -228,6 +229,7 @@ struct hist_entry {
> > >       u64                     transaction;
> > >       s32                     socket;
> > >       s32                     cpu;
> > > +     int                     parallelism;
> >
> > Can you make it u16 and move to around cpumode to remove paddings?
> 
> It generally should be the same size as cpu/socket/etc. And these are
> 32-bits throughout the codebase (the previous fields). Are there any
> checks that MAX_NR_CPUS<64K?

I don't think there's such a check.  But practically it used be 4K and
you can add the check. :)

Anyway hist_entry is getting bigger and we may need to shrink it later.
I don't stringly insist on u16 though.  It's up to you.

Thanks,
Namhyung

> >
> >
> > >       u64                     code_page_size;
> > >       u64                     weight;
> > >       u64                     ins_lat;
> > > @@ -580,6 +582,7 @@ bool perf_hpp__is_thread_entry(struct perf_hpp_fmt *fmt);
> > >  bool perf_hpp__is_comm_entry(struct perf_hpp_fmt *fmt);
> > >  bool perf_hpp__is_dso_entry(struct perf_hpp_fmt *fmt);
> > >  bool perf_hpp__is_sym_entry(struct perf_hpp_fmt *fmt);
> > > +bool perf_hpp__is_parallelism_entry(struct perf_hpp_fmt *fmt);
> > >
> > >  struct perf_hpp_fmt *perf_hpp_fmt__dup(struct perf_hpp_fmt *fmt);
