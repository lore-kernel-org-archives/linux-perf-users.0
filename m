Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038C7211A3C;
	Wed, 28 May 2025 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748462942; cv=none; b=gSsHU4GDnGq+BbsC2agtz0D1rrOtdPlx5u8JoR2pHhuQOCQswUotbK9u8tsqTFoEhhnD71VMcS69vX2+ElVckiAij/VwY0h5WnH7aKkMyAp+y3HXyO7J69lxUaf+cSECAHbdgP4bZLqPrKNQin353dwzZLlgm3Ic0QODG1dBLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748462942; c=relaxed/simple;
	bh=pJ2dFQQdDmn/IChFcWmfT5WUYBKarwwig81+WsRQyQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm5x2qesJ4LRNpXShYGn28cZadoPtzaE/mCc6XR0zwiSxp0qckn/NlvSeeCJ1nByy9LSLBwi5EJsUCfhesSzb3ZvjqhCyw/KfgU2+7IIdJ15PiXXz9D+YZg3VLst1fOK1CfNFxj0FP9177MGbhmVccw7QYnA2E6sM2bTbVbXcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csMCLAkM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csMCLAkM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82225C4CEE3;
	Wed, 28 May 2025 20:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748462941;
	bh=pJ2dFQQdDmn/IChFcWmfT5WUYBKarwwig81+WsRQyQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=csMCLAkMuz5uJ2CafuZw0WAfnDW8V8NuvmwczmdNUPhID/F2RQevCk4mFc+vLVm9T
	 gvC1r2mSD8d1iEUQPSrli6KQPWKbOSGZ+B49xg3e2YSh0qosr1Zxi/dWmt0cyBJrOd
	 +y82R5uWzjhI9YT3uT/VKCE4r0Eoy0NrJtp0OJnij49tA26CISx1f6A9rh/tTvnQ2h
	 hZ3+jSsDhX7OJ1sV1DjFBfx11yfrYiC9Wsp3b21T/pZfWeCeIlz2eMBsi7DIi1xbu1
	 8us5nXcdQ7qPsm0QNNmXsk3tdLrZjbkp52/QeKX2P2OaluG7OE+a31inX63Qqv2inK
	 zuZQ0IA9R11NA==
Date: Wed, 28 May 2025 13:08:58 -0700
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
Message-ID: <aDdtWlUbDZtM9pvg@google.com>
References: <20250521165317.713463-1-irogers@google.com>
 <20250521165317.713463-2-irogers@google.com>
 <aC43Et06tyrBOrsT@google.com>
 <CAP-5=fUYUDq6hmd+e3_E7HCRPYuy-0KLE+gLuSCWAHh3A5wJLA@mail.gmail.com>
 <aDdR0pCNSmxCEyEZ@google.com>
 <CAP-5=fVv9+0UdYDNQ52T-QgKfUYBL-pgRwd_ac3jp7KW8sxrRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVv9+0UdYDNQ52T-QgKfUYBL-pgRwd_ac3jp7KW8sxrRw@mail.gmail.com>

On Wed, May 28, 2025 at 11:27:06AM -0700, Ian Rogers wrote:
> On Wed, May 28, 2025 at 11:11 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, May 21, 2025 at 02:15:24PM -0700, Ian Rogers wrote:
> > > On Wed, May 21, 2025 at 1:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Wed, May 21, 2025 at 09:53:15AM -0700, Ian Rogers wrote:
> > > > > By definition arch sample parsing and synthesis will inhibit certain
> > > > > kinds of cross-platform record then analysis (report, script,
> > > > > etc.). Remove arch_perf_parse_sample_weight and
> > > > > arch_perf_synthesize_sample_weight replacing with a common
> > > > > implementation. Combine perf_sample p_stage_cyc and retire_lat to
> > > > > capture the differing uses regardless of compiled for architecture.
> > > >
> > > > Can you please do this without renaming?  It can be a separate patch but
> > > > I think we can just leave it.
> > >
> > > It is not clear what the use of the union is. Presumably it is a
> > > tagged union but there is no tag as the union value to use is implied
> > > by either being built on x86_64 or powerpc. The change removes the
> > > notion of this code being built for x86_64 or powerpc and so the union
> > > value to use isn't clear (e.g. should arm use p_stage_cyc or
> > > retire_lat from the union), hence combining to show that it could be
> > > one or the other. The code could be:
> > > ```
> > > #ifdef __x86_64__
> > >        u16 p_stage_cyc;
> > > #elif defined(powerpc)
> > >        u16 retire_lat;
> > > #endif
> > > ```
> > > but this isn't cross-platform.
> >
> > Right, we probably don't want it.
> >
> >
> > > The change in hist.h of
> > > ```
> > > @@ -255,7 +255,7 @@ struct hist_entry {
> > >         u64                     code_page_size;
> > >         u64                     weight;
> > >         u64                     ins_lat;
> > > -       u64                     p_stage_cyc;
> > > +       u64                     p_stage_cyc_or_retire_lat;
> > > ```
> > > could be a follow up CL, but then we lose something of what the field
> > > is holding given the value is just a copy of that same named value in
> > > perf_sample. The code only inserts 34 lines and so the churn of doing
> > > that seemed worse than having the change in a single patch for
> > > clarity.
> >
> > Assuming other archs can add something later, we won't rename the field
> > again.  So I can live with the ugly union fields.  If we really want to
> > rename it, I prefer calling it just 'weight3' and let the archs handle
> > the display name only.
> 
> But that's my point (or in other words maybe you've missed my point) .
> Regardless of arch we should display p_stage_cyc if processing a
> perf.data file from a PowerPC as determined from the perf_env in the
> perf.data file, or retire_lat if processing a perf.data file from x86.

Agreed.


> The arch of the perf build is entirely irrelevant and calling the
> variable an opaque weight3 will require something that will need to be
> disambiguate it elsewhere in the code. The goal in variable names
> should be to be intention revealing, which I think
> p_stage_cyc_or_retire_lat is doing better than weight3, which is
> something of a regression from the existing but inaccurate
> p_stage_cyc.

Yeah, but I worried if it would end up with
'p_stage_cyc_or_retire_lat_or_something_else' later.

Thanks,
Namhyung

