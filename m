Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C441DF273;
	Wed, 28 May 2025 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469760; cv=none; b=WTjZ7m0wyXf4P0mWyhBF2c3Qd+F+j7urMqVz5Ap4RQCUH4zi0kSNb+eCeK14Gjvnc/jGlakqfMrNY+qU9krabcFwqfLfesBpF+M5L3y5750x4V1ik/GYJdn0YWDE75EDm51lHZqq7iLtg1ls8tvtPuOhJq9r3wuCPv/z9eF1apw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469760; c=relaxed/simple;
	bh=M3ZiUOldkUKxloo6ZCnoF0coLkgVKoNw3VgiFV0T2wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS+9JqWkpkF/0+G0ZoKFtJFDEAJNYvS4yGwRZ83Lt9xMvpI2K4EJvZMYCA0XBhikYG/pduQcSb86/lMv38puDgCMqxgD2nc4gXmmuHz8L6qpSQ+rV2kgT5mlGimoXVyju+ZJWJdKbX77c+bwbDPcQf74Vpesd9Z5GRWpvbCJSRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC3UrlQk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC3UrlQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7486C4CEE3;
	Wed, 28 May 2025 22:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748469759;
	bh=M3ZiUOldkUKxloo6ZCnoF0coLkgVKoNw3VgiFV0T2wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EC3UrlQkCxngwpLvQWSgJ8/JJmui4KKv3E1YDZm/Wyue34vqAhPuAjDkSdbDviK9d
	 9v5OxPh+yJp901jDg3qGpDI9E6flHurZSIDSLi2gxqgkQUHfn3IXtIDo3ydrDV15zI
	 hGbPez7WxDgLv/TKxb/Meehq/c4UL0t1zdHW5wXwUTDp326aTTKIWirOXA8+16yv96
	 MO8+oBBqyEmnkpWG4PAyr9lO0+kMwremNWxFPMQeuTi3NWDJeMNtNrIgnOr9QrPIXk
	 +SVExYg3zJGFgEotYKtvRakalwRfKcJYOH1LM8Up7AyDzAWhiuSYRJlfDcvA3G+ZcO
	 ZkfWssAT3mQXQ==
Date: Wed, 28 May 2025 15:02:37 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>,
	Yujie Liu <yujie.liu@intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Matt Fleming <matt@readmodwrite.com>,
	Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>,
	Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] perf sample: Remove arch notion of sample parsing
Message-ID: <aDeH_QfWHPa9KT1S@google.com>
References: <20250521165317.713463-1-irogers@google.com>
 <20250521165317.713463-2-irogers@google.com>
 <aC43Et06tyrBOrsT@google.com>
 <CAP-5=fUYUDq6hmd+e3_E7HCRPYuy-0KLE+gLuSCWAHh3A5wJLA@mail.gmail.com>
 <aDdR0pCNSmxCEyEZ@google.com>
 <CAP-5=fVv9+0UdYDNQ52T-QgKfUYBL-pgRwd_ac3jp7KW8sxrRw@mail.gmail.com>
 <aDdtWlUbDZtM9pvg@google.com>
 <CAP-5=fXaaQv5eFTheW52CNc-5Zhmfow2aZ59vnJy74XL2oEcfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXaaQv5eFTheW52CNc-5Zhmfow2aZ59vnJy74XL2oEcfw@mail.gmail.com>

On Wed, May 28, 2025 at 01:38:03PM -0700, Ian Rogers wrote:
> On Wed, May 28, 2025 at 1:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, May 28, 2025 at 11:27:06AM -0700, Ian Rogers wrote:
> > > On Wed, May 28, 2025 at 11:11 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Wed, May 21, 2025 at 02:15:24PM -0700, Ian Rogers wrote:
> > > > > On Wed, May 21, 2025 at 1:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, May 21, 2025 at 09:53:15AM -0700, Ian Rogers wrote:
> > > > > > > By definition arch sample parsing and synthesis will inhibit certain
> > > > > > > kinds of cross-platform record then analysis (report, script,
> > > > > > > etc.). Remove arch_perf_parse_sample_weight and
> > > > > > > arch_perf_synthesize_sample_weight replacing with a common
> > > > > > > implementation. Combine perf_sample p_stage_cyc and retire_lat to
> > > > > > > capture the differing uses regardless of compiled for architecture.
> > > > > >
> > > > > > Can you please do this without renaming?  It can be a separate patch but
> > > > > > I think we can just leave it.
> > > > >
> > > > > It is not clear what the use of the union is. Presumably it is a
> > > > > tagged union but there is no tag as the union value to use is implied
> > > > > by either being built on x86_64 or powerpc. The change removes the
> > > > > notion of this code being built for x86_64 or powerpc and so the union
> > > > > value to use isn't clear (e.g. should arm use p_stage_cyc or
> > > > > retire_lat from the union), hence combining to show that it could be
> > > > > one or the other. The code could be:
> > > > > ```
> > > > > #ifdef __x86_64__
> > > > >        u16 p_stage_cyc;
> > > > > #elif defined(powerpc)
> > > > >        u16 retire_lat;
> > > > > #endif
> > > > > ```
> > > > > but this isn't cross-platform.
> > > >
> > > > Right, we probably don't want it.
> > > >
> > > >
> > > > > The change in hist.h of
> > > > > ```
> > > > > @@ -255,7 +255,7 @@ struct hist_entry {
> > > > >         u64                     code_page_size;
> > > > >         u64                     weight;
> > > > >         u64                     ins_lat;
> > > > > -       u64                     p_stage_cyc;
> > > > > +       u64                     p_stage_cyc_or_retire_lat;
> > > > > ```
> > > > > could be a follow up CL, but then we lose something of what the field
> > > > > is holding given the value is just a copy of that same named value in
> > > > > perf_sample. The code only inserts 34 lines and so the churn of doing
> > > > > that seemed worse than having the change in a single patch for
> > > > > clarity.
> > > >
> > > > Assuming other archs can add something later, we won't rename the field
> > > > again.  So I can live with the ugly union fields.  If we really want to
> > > > rename it, I prefer calling it just 'weight3' and let the archs handle
> > > > the display name only.
> > >
> > > But that's my point (or in other words maybe you've missed my point) .
> > > Regardless of arch we should display p_stage_cyc if processing a
> > > perf.data file from a PowerPC as determined from the perf_env in the
> > > perf.data file, or retire_lat if processing a perf.data file from x86.
> >
> > Agreed.
> >
> >
> > > The arch of the perf build is entirely irrelevant and calling the
> > > variable an opaque weight3 will require something that will need to be
> > > disambiguate it elsewhere in the code. The goal in variable names
> > > should be to be intention revealing, which I think
> > > p_stage_cyc_or_retire_lat is doing better than weight3, which is
> > > something of a regression from the existing but inaccurate
> > > p_stage_cyc.
> >
> > Yeah, but I worried if it would end up with
> > 'p_stage_cyc_or_retire_lat_or_something_else' later.
> 
> Perhaps it should be:
> ```
> union {
>   u16 raw;
>   u16 p_stage_cyc;
>   u16 retire_lat;
> } weight3;
> ```
> to try to best capture this. `xyz.weight3.raw` when the PowerPC or x86
> use isn't known, etc.

Looks better.  But based on the offline discussion, it'd be better to
just use 'u16 weight3'.


> In the histogram code the u16 is a u64.

Yep, because histogram entry aggregates sample weights.

Thanks,
Namhyung

