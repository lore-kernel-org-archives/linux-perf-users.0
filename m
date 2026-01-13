Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080DB632;
	Tue, 13 Jan 2026 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339171; cv=none; b=ZcyzSjhLJBi+Qvf7FN7e3H9tF1rpF7i0gpi6wEUSlKanwTYNHE7JxcOVsS7OIEGVg81KeAFoldf9RhCVvv2pfTDMh6I7gDXqsBgbCvB7lOYsbhraPn3OjwD5g9XVepLw+8qXhIw0FjzK6ZEzgZOushpqtdqEw/d3jBeBUmULmkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339171; c=relaxed/simple;
	bh=5NuiKNjxUc1TurQR9JDdmZmzqiloKM8PFOpm9bsSv50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSulqYN/yyFSEaHxKnl38FDpw18LFftU1rs+ROp39WhyJLmHeV9j762SEG1/Mg2eytpe1gsd1qesEtrAMp4oNJW/F/M0yiNaAgK5CIlr9a0BQvOFfkKGyyHSCetPZlDf9mnfiJjYC9nFs4s9T0a5bDPE/O3+ChGMo0JiQ20CROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHL2qC9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHL2qC9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290FDC116C6;
	Tue, 13 Jan 2026 21:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768339170;
	bh=5NuiKNjxUc1TurQR9JDdmZmzqiloKM8PFOpm9bsSv50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHL2qC9gp8/Pb5pqDYDIhdvAPKmSdTsWdnMdlteGaac+9UDSPe83T6kasjIVEnSZp
	 2NuL7aYn5+aH13RtgDfoIP4f57UEvxDLi5sGIOLtzZVADA9/8q8hBlrl1p64jDsqjp
	 NqOF8rUAyaVz/ujOtcYq9lSSdWeAjZ+04mAUGgQ41VsWKCAt3ZEGPqxKVxzqtraGeN
	 5L7MlfUD0A2Ge4qp01Vt1VmKu9vf6ALzzv/bCuOOu+yydq39dqRhOIiD42zP9e2ckq
	 JIFpTUxGktHYY/hLWvtxlG/7hkeC4n7+a77HrQVaridJNBMkG/DdIocDU7siQS2Xit
	 FrTFza2ABrv6w==
Date: Tue, 13 Jan 2026 18:19:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Subject: Re: [PATCH 2/4] perf vendor events amd: Add Zen 6 uncore events
Message-ID: <aWa237L98No7Ec2B@x1>
References: <cover.1767858676.git.sandipan.das@amd.com>
 <b00e27727d8aea8cf49c5e6e08b29357d04bc2b8.1767858676.git.sandipan.das@amd.com>
 <aWaqmlLZ9NGpY6Ys@x1>
 <CAP-5=fX6=wj+xZa4dK=5mjAoDJX7KreK1dMAT-o3aH9BkWZyVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX6=wj+xZa4dK=5mjAoDJX7KreK1dMAT-o3aH9BkWZyVg@mail.gmail.com>

On Tue, Jan 13, 2026 at 12:41:42PM -0800, Ian Rogers wrote:
> On Tue, Jan 13, 2026 at 12:27 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Jan 08, 2026 at 01:22:15PM +0530, Sandipan Das wrote:
> > > Add uncore events taken from Section 1.6 "L3 Cache Performance Monitor
> > > Counters" and Section 2.2 "UMC Performance Monitor Events" of the
> > > Performance Monitor Counters for AMD Family 1Ah Model 50h-57h Processors
> > > document available at the link below.
> > >
> > > This constitutes events which capture L3 cache and UMC command activity.
> >
> >   LD      /tmp/build/perf-tools-next/perf-util-in.o
> >   AR      /tmp/build/perf-tools-next/libperf-util.a
> >   CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
> > /tmp/build/perf-tools-next/pmu-events/pmu-events.c:30902:37: error: ‘pmu_events__amdzen6’ defined but not used [-Werror=unused-const-variable=]
> > 30902 | static const struct pmu_table_entry pmu_events__amdzen6[] = {
> >       |                                     ^~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[3]: *** [pmu-events/Build:89: /tmp/build/perf-tools-next/pmu-events/pmu-events.o] Error 1
> > make[2]: *** [Makefile.perf:772: /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o] Error 2
> > make[1]: *** [Makefile.perf:288: sub-make] Error 2
> > make: *** [Makefile:119: install-bin] Error 2
> > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> > ⬢ [acme@toolbx perf-tools-next]$
> >
> > When building at this patch (2/4) it breaks, lemme see if at the end it
> > works, but even then this can't stand this way, as we break bisection...
> >
> > Then, on 3/4 we get:
> >
> >   CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
> > /tmp/build/perf-tools-next/pmu-events/pmu-events.c:30992:37: error: ‘pmu_metrics__amdzen6’ defined but not used [-Werror=unused-const-variable=]
> > 30992 | static const struct pmu_table_entry pmu_metrics__amdzen6[] = {
> >       |                                     ^~~~~~~~~~~~~~~~~~~~
> > /tmp/build/perf-tools-next/pmu-events/pmu-events.c:30908:37: error: ‘pmu_events__amdzen6’ defined but not used [-Werror=unused-const-variable=]
> > 30908 | static const struct pmu_table_entry pmu_events__amdzen6[] = {
> >       |                                     ^~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[3]: *** [pmu-events/Build:89: /tmp/build/perf-tools-next/pmu-events/pmu-events.o] Error 1
> > make[2]: *** [Makefile.perf:772: /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o] Error 2
> > make[1]: *** [Makefile.perf:288: sub-make] Error 2
> > make: *** [Makefile:119: install-bin] Error 2
> > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> > ⬢ [acme@toolbx perf-tools-next]$
> >
> > Finally, on 4/4 everything builds.
> >
> > Can you please take a look to check how we can keep all bisection happy?
> 
> So patch 4 adds the mapfile.csv change and that's the thing that
> creates the references to the zen6 tables that is failing when
> building with the earlier patches. If patch 4 is made patch 1 then the
> series builds at each step (1,2,3,4) for me.

Trying that now... Did the trick, thanks! Applied.

- Arnaldo
