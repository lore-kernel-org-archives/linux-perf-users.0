Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B0E15573D;
	Mon, 29 Jul 2024 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265659; cv=none; b=YIO4ETJ3HDGoL+NsQbeY/3cAyHwy78vPWLCYPt/pzZVAd0xC87XZg/gzNmITugdAaM9sLy0hm02tfby15HNb5l3wFU+xpDRi5h+kHqBkZ+hbm6SGVkz+21KEvw0woDcTHkOvHIVgz1lLa5a4KJhHTcgtVvXMm6rWf79n0C6qb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265659; c=relaxed/simple;
	bh=FHHChsesQGBUPjVTh2pJlQerrm07FKZEvYFh8m/v+ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnfBekGz8Lrq8Y2fS7H3U++hPQhTQPtcBqKnPf6kIBEYRojqNcNdTuTJqKrCmVit7xTo3qapBftzr4cnexW75H8c1Xh2h9blxJtqUxi1Z706UtSUIzPjEXlFpsuDvaSqnaL4yyTJbTwjkl7QZpvWDem0rVwLlMZE5Bre1DaXwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=QVWPrILY; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="QVWPrILY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=z4wToOxGTVLxBXyaC8U3DGnuV27Hlpn0H+I99oKbK0U=; b=QVWPrILYqMUWJxsf
	h6qZp3eLnWMfwcCvDtdYLNdU4lT50LBesRqQh1RD0xk862XgSrwcrY7QrOX+2P2LdRUUO7iOJGvy8
	Nf31oxsU2u1ZmphCdK+PO+JQFOeRivS3z5n/bJgPSJvqjos2WOZud8hTkneC0okPWG5M/43fXLU6C
	aXagcou1WC1Iek/xqfjqYgfRpiC638ORVzFu9cEr99jBd/SglIZKU+sH4pBsNFghZD3dvJXHiuAZ1
	IZ1OluA3naPoO+JfJpneIDI9fB0SY+agQQttyHEA4vUK4dwg3kvk51yX7Nv9yf9rmVt9JsDT3pjcg
	gSlGB7pievjp/G2PZA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sYRy3-00DoQa-2B;
	Mon, 29 Jul 2024 15:07:19 +0000
Date: Mon, 29 Jul 2024 15:07:19 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Ian Rogers <irogers@google.com>
Cc: kan.liang@linux.intel.com, acme@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test pmu: Remove unused test_pmus
Message-ID: <ZqewJ6oIprdRY8C5@gallifrey>
References: <20240727175919.1041468-1-linux@treblig.org>
 <CAP-5=fW+VbDaFV+YQCMMKYzrraMLLuVqb=BChL0o=-D5Y=4N_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW+VbDaFV+YQCMMKYzrraMLLuVqb=BChL0o=-D5Y=4N_w@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:01:45 up 82 days,  2:15,  1 user,  load average: 0.15, 0.05, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Ian Rogers (irogers@google.com) wrote:
> On Sat, Jul 27, 2024 at 10:59 AM <linux@treblig.org> wrote:
> >
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > Commit aa1551f299ba ("perf test pmu: Refactor format test and exposed
> > test APIs") added the 'test_pmus' list, but didn't use it.
> > (It seems to put them on the other_pmus list?)
> >
> > Remove it.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Strange that the compiler doesn't warn about unused stuff like this,
> we get unused variables within a function and unused static
> functions...

The problem is that LIST_HEAD initialises the list to point to itself;
so it *is* used - but only in it's own initialiser.
I did file:
   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=115027

> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,

> Possibly:
> Fixes: aa1551f299ba ("perf test pmu: Refactor format test and exposed
> test APIs")

Given it's got no actual effect other than a few bytes
saved, I'm not sure it's worth the Fixes.

Dave

> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/pmu.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> > index 40132655ccd1..0b2f04a55d7b 100644
> > --- a/tools/perf/tests/pmu.c
> > +++ b/tools/perf/tests/pmu.c
> > @@ -18,9 +18,6 @@
> >  #include <sys/stat.h>
> >  #include <sys/types.h>
> >
> > -/* Fake PMUs created in temp directory. */
> > -static LIST_HEAD(test_pmus);
> > -
> >  /* Cleanup test PMU directory. */
> >  static int test_pmu_put(const char *dir, struct perf_pmu *pmu)
> >  {
> > --
> > 2.45.2
> >
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
