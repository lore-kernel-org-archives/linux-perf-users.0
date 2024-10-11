Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE3F183CA5;
	Fri, 11 Oct 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664797; cv=none; b=C5LWiTwRZ9korIMO2dQZ1jrayw3h2pDjb+W/6uwz85aOvct6s9SVQ8eUbh7e2pa8eVO+MxR2noMxKtp7WNgTEcIwrdgPSp+LAJRlWdrqphLs8+5Jz0OCr1g7JhwqoceFj+I1au+ZjfTtguLWsmYObMFlvmWzp+23+fUuOgTiCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664797; c=relaxed/simple;
	bh=IakEbbZ8X+FcxiHtDssW9Xz6ZmjQL3Ku8ATidKob82o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrogZueeh1Wql6rCBh50IkzPVVHfTl1HE6JJHdAlpzdkw8lKjBvZS+AxN+Qa4xg9/Mi3zkHA7vkypwx/+7AcWPH/IHZiJv7vnaQqV3muzmi6O0H7r895qzJvDLDf0pyPBkwhZhLHLG4wwZqoPVMi16t7kwddxC64YNcMChPf3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1GVUIeM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1GVUIeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBC2C4CEC3;
	Fri, 11 Oct 2024 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728664796;
	bh=IakEbbZ8X+FcxiHtDssW9Xz6ZmjQL3Ku8ATidKob82o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1GVUIeM2kOWgMTMvT6f7dfXlCEVTZZ6iUmLI+eiq+DhBqsCbeIGENPBU85L+mbt9
	 IUCSzLyLjVuv/X4BftzJSYOcKNKI+6ClBj0PqaH7G18bHF2UrThVh1am3/z5nOGqGJ
	 7kbwKsBsgNdM2YeEPNPV+J4OHh/7LBhaDeQZ2Kv/9NvnJQc6YOF3qPMn2e0iTcO9EK
	 n2KYcgg1q+DOtpq9Xo44UI3kpnf4yOKTFg/+eawBHXrjbj057YYgMX09+eNncRBuFm
	 9QVn4BobY8kOcCC33BZ1tpfkGt5t+0i+81jwtbIaKlBozNAyR+YFJk+WWJhyG7l5Il
	 iBSsnsJmeAtNA==
Date: Fri, 11 Oct 2024 09:39:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ben Gainey <Ben.Gainey@arm.com>
Cc: "acme@kernel.org" <acme@kernel.org>,
	"irogers@google.com" <irogers@google.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH] perf evsel: Fix missing inherit + sample read check
Message-ID: <ZwlU2lpeekYntrGd@google.com>
References: <20241009062250.730192-1-namhyung@kernel.org>
 <7ced2109944c4aa773804a2d25854974b76d8fb6.camel@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ced2109944c4aa773804a2d25854974b76d8fb6.camel@arm.com>

On Fri, Oct 11, 2024 at 08:02:04AM +0000, Ben Gainey wrote:
> On Tue, 2024-10-08 at 23:22 -0700, Namhyung Kim wrote:
> > It should not clear the inherit bit simply because the kernel doesn't
> > support the sample read with it.  IOW the inherit bit should be kept
> > when the sample read is not requested for the event.
> 
> 
> Ah, sorry. Good spot.

Thanks for the review, can I translate it your Acked-by?

Thanks,
Namhyung
 
> > 
> > Fixes: 90035d3cd876cb71 ("tools/perf: Allow inherit +
> > PERF_SAMPLE_READ when opening events")
> > Cc: Ben Gainey <ben.gainey@arm.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/evsel.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index d8fd493af01458b7..507f526ccbbcfc36 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2112,7 +2112,8 @@ static int __evsel__prepare_open(struct evsel
> > *evsel, struct perf_cpu_map *cpus,
> >  
> >  static void evsel__disable_missing_features(struct evsel *evsel)
> >  {
> > - if (perf_missing_features.inherit_sample_read)
> > + if (perf_missing_features.inherit_sample_read && evsel-
> > >core.attr.inherit &&
> > +     (evsel->core.attr.sample_type & PERF_SAMPLE_READ))
> >   evsel->core.attr.inherit = 0;
> >   if (perf_missing_features.branch_counters)
> >   evsel->core.attr.branch_sample_type &=
> > ~PERF_SAMPLE_BRANCH_COUNTERS;
> 
