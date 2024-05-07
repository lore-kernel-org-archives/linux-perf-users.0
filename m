Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997D18733D;
	Tue,  7 May 2024 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113362; cv=none; b=GF7PTM16stezoLeQZ4xVe2L6WJsBLBds+s+DI2Z09Rr6a2boAtw6HcmysoalHPY8ADH5pvGEcLcUHWggTVZlRzWlVEnOzZ/sqMdsBdlrQycPmsDWD1n/5mIQVEpREb0Uvr8KOrvktmKcVM8fjqcq+xpBUNA9uzBOqqKL9CVxvb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113362; c=relaxed/simple;
	bh=1RbsmdPHrG35757L2/jwausSGTj7PtubNPTbxyDYUSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTXf/GdMGiNvhSURDVG+G6p5uByVftFikOA7vDr61dWCrGsPZjtcoKE4/IJsumfmM3NpBrp+Zr9+lpzwJSdT+HISdeN9A259GexVkh1OUlq4nOQ+RrP3ZltyOOyRIzYZSqEdXbuKecfFkBMGoDnYD7uqTZ098uokJ5c8Kg1sdOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjMZhEwY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjMZhEwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C02C2BBFC;
	Tue,  7 May 2024 20:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715113361;
	bh=1RbsmdPHrG35757L2/jwausSGTj7PtubNPTbxyDYUSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VjMZhEwYsM0dh7cIqoA9Gd6un66CuCELI6ap3ptY9bh2u752STcG5u/BVeiV0uEeG
	 AaVe8mGddngvOJftpk+RYfdWB1Gl8X09GNyV6fwbMaKZZegbmFwWDR6nNZRcUyhVcS
	 wXmwxC0kCWMlXPUEe9vhkqEK15SYrJ9+CS37TyK8Q70OsW8SVeQApGdnMLcqebyjy8
	 1zuoHPismpwunJt9Ag83f4l7kgJ3FFdzxVz6AcfGjlrbAUYiOWR7ylVzT8c000oXN+
	 3zT6HGeUTsY8/04XtdrHKu7HKq145e93OH4mSoC0oFk0y/DNDeLjwSFA3LtSKpURNo
	 tbFR0cinV5OoA==
Date: Tue, 7 May 2024 17:22:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Clark <james.clark@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Kajol Jain <kjain@linux.ibm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, Li Dong <lidong@vivo.com>,
	Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>,
	Andi Kleen <ak@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/8] perf ui browser: Don't save pointer to stack
 memory
Message-ID: <ZjqNjrJ2ElrT11iB@x1>
References: <20240507183545.1236093-1-irogers@google.com>
 <20240507183545.1236093-2-irogers@google.com>
 <ZjqNKPgWR7mBFaV4@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjqNKPgWR7mBFaV4@x1>

On Tue, May 07, 2024 at 05:20:59PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, May 07, 2024 at 11:35:38AM -0700, Ian Rogers wrote:
> > ui_browser__show is capturing the input title that is stack allocated
> > memory in hist_browser__run. Avoid a use after return by strdup-ing
> > the string.
> 
> But everything happens in that context, i.e. hist_brower__run() will
> call ui_browser__ methods and then exit.
> 
> We end up having browser->title pointing to returned stack memory
> (invalid) but there will be no references to it, no?
> 
> If we return to hist_browser__run() we then call ui_browser__show
> passing a new title, for "live" stack memory, rinse repeat. Or have you
> noticed an actual use-after-"free"?

And I'll take the patch, I'm just trying to figure it out if it fixed a
real bug or if it just makes the code more future proof, i.e. to avoid
us adding code that actually uses invalid stack memory.

- Arnaldo
 
> - Arnaldo
>  
> > Fixes: 05e8b0804ec4 ("perf ui browser: Stop using 'self'")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/ui/browser.c | 4 +++-
> >  tools/perf/ui/browser.h | 2 +-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> > index 603d11283cbd..c4cdf2ea69b7 100644
> > --- a/tools/perf/ui/browser.c
> > +++ b/tools/perf/ui/browser.c
> > @@ -287,7 +287,8 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
> >  	mutex_lock(&ui__lock);
> >  	__ui_browser__show_title(browser, title);
> >  
> > -	browser->title = title;
> > +	free(browser->title);
> > +	browser->title = strdup(title);
> >  	zfree(&browser->helpline);
> >  
> >  	va_start(ap, helpline);
> > @@ -304,6 +305,7 @@ void ui_browser__hide(struct ui_browser *browser)
> >  	mutex_lock(&ui__lock);
> >  	ui_helpline__pop();
> >  	zfree(&browser->helpline);
> > +	zfree(&browser->title);
> >  	mutex_unlock(&ui__lock);
> >  }
> >  
> > diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
> > index 510ce4554050..6e98d5f8f71c 100644
> > --- a/tools/perf/ui/browser.h
> > +++ b/tools/perf/ui/browser.h
> > @@ -21,7 +21,7 @@ struct ui_browser {
> >  	u8	      extra_title_lines;
> >  	int	      current_color;
> >  	void	      *priv;
> > -	const char    *title;
> > +	char	      *title;
> >  	char	      *helpline;
> >  	const char    *no_samples_msg;
> >  	void 	      (*refresh_dimensions)(struct ui_browser *browser);
> > -- 
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
