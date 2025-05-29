Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750751DFE22;
	Thu, 29 May 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748552032; cv=none; b=SAAi4TZKwOJU9kGGAGiKy9qcPKP9ie0spVezsEms8MwTh4QdszsDyoRqhqYku6p/RNxuCwPRX8DRCmeQXn27stzgEO68wdg85byGCQkNVX+8OyxkBVk3rBM433nIYVt9jkz0AwMmR30Ob6YbxojNaDh+f44xUETwYXxGtZy7Pig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748552032; c=relaxed/simple;
	bh=+AmCCzWsoU/BUJLqFNvapuauRfVLlPOB453FP3teW7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6XQB2uO6TdKFCOLxlD2tboKBfceLaXbRap609U/qHd8InlTyDJCmpnaSESdgIZVqQ1VlLkGB09Z3l0/wN0DOOHIo7LAv95RtargJn95axOKJP88MbeFYAiFf1y45CAnIaUpROqM7PK2uiqg/UNhRL4l0btVgk9SuUOpPYCImas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCyjTDP6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCyjTDP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA983C4CEE7;
	Thu, 29 May 2025 20:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748552031;
	bh=+AmCCzWsoU/BUJLqFNvapuauRfVLlPOB453FP3teW7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCyjTDP6ccqpZjwy+i+PHzBmEvxpia7Qq0zyJaw4OWQWLiPMtanLR+SotemX2rnih
	 05EZ++Syvz9+pPhXJcXIoFr/WYnimfTPzM8wWjqhkMtHJ3qlE6Y6CG7rEuvIqpwwPF
	 Dgtk7xg7gheNVRgc5vWDDE8NnmqvySYcTEI6wRkV/Dg6qibbNXqovwQAWF2wdb0quE
	 ydqbEotcrwYNAH1z/wKZlUpWxy6S1+YwnWKuC1sjJiAP3Z4FsDZ2g+F0sBw27tB4BW
	 b5899HsdzGOnFoKPZN/b7KsgbwM/H6MfUR0BSXMcH3D+StZ/Ah5jTbu7hSQ9eL+7NG
	 2G6YBxkJPJhgQ==
Date: Thu, 29 May 2025 13:53:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	James Clark <james.clark@linaro.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Zixian Cai <fzczx123@gmail.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Martin Liska <martin.liska@hey.com>,
	Martin =?utf-8?B?TGnFoWth?= <m.liska@foxlink.cz>,
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/9] perf build-id: Mark DSO in sample callchains
Message-ID: <aDjJXUsfEjIBdQJ3@google.com>
References: <20250428213409.1417584-1-irogers@google.com>
 <20250428213409.1417584-6-irogers@google.com>
 <aDd06eK7fKFsFsVS@google.com>
 <CAP-5=fV-cLLpdyoqL8+Jrt3iYU7EbpZZDOyM1kBCc+54gA2Nzg@mail.gmail.com>
 <aDeLLvBVQnQqJT4b@google.com>
 <CAP-5=fWJMFYBtwPeH8DhzUG2jbjJ865sLojDtEc1+HDQZdpPoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWJMFYBtwPeH8DhzUG2jbjJ865sLojDtEc1+HDQZdpPoA@mail.gmail.com>

On Wed, May 28, 2025 at 04:11:13PM -0700, Ian Rogers wrote:
> On Wed, May 28, 2025 at 3:16 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, May 28, 2025 at 01:54:41PM -0700, Ian Rogers wrote:
> > > On Wed, May 28, 2025 at 1:41 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Mon, Apr 28, 2025 at 02:34:04PM -0700, Ian Rogers wrote:
> > > > > Previously only the sample IP's map DSO would be marked hit for the
> > > > > purposes of populating the build ID cache. Walk the call chain to mark
> > > > > all IPs and DSOs.
> > > >
> > > > I think this is correct, but I'm afraid it'd also increase the processing
> > > > time.  Do you happen to have any numbers?
> > >
> > > It increases time spent processing the data file but to get a large
> > > data file I had to run for multiple seconds and I struggled to get the
> > > performance cost of this to be in the milliseconds (ie a tiny fraction
> > > of the record time). Ultimately I found the change imperceptible and
> > > couldn't think of a good command line to make it perceptible.
> >
> > The worst case would be dwarf unwinding.  Maybe we can skip the
> > processing if it takes too long..
> 
> This doesn't sound unreasonable but is somewhat beyond the scope of
> what I wanted to do here, which relates to migrating from inodes to
> buildids as identifiers for DSOs. It would be useful to get a bug
> report on this being too slow.
> 
> > >
> > > If the time is spent populating ~/.debug because more DSOs are marked
> > > then this is fixing a bug and isn't a problem with the patch.
> >
> > Right, it's a good thing.
> >
> > >
> > > My personal opinion is that it is somewhat surprising `perf record` is
> > > post-processing the perf.data file at all, and -B and -N would be my
> > > expected defaults - just as --buildid-mmap implies --no-buildid (-B).
> >
> > Otherwise nobody will run perf buildid-cache to add the info. :)
> 
> Right, but we know it is high overhead as we run a number of tests with -B:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/record_sideband.sh?h=perf-tools-next#n25
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/test_arm_spe.sh?h=perf-tools-next#n94
> 
> I agree that populating the buildid cache immediately after perf
> record minimizes a gap where DSOs may change prior to perf report. If
> the DSO changes midway through perf record it doesn't help as the
> buildid information is only computed at the end of perf record.
> 
> Isn't there an argument that because we have build IDs we don't care
> about the record to report race any more as debuginfod can find the
> prior version by means of the build ID? What I mean:
> 
> Current perf default way:
> 1) Run perf record with mmap2 inode rather the buildid data
> 1.1) To avoid any DSOs in the perf.data from not being available
> populate the buildid header in the perf.data and the buildid cache at
> the end of perf record
> 2) Replace some DSO that's got a sample in the perf.data with a different DSO
> 3) Run perf report
> 3.1) The DSO's buildid is known via the header and the buildid cache
> already contains the DSO
> 
> Current way with -N:
> 1) Run perf record with mmap2 inode rather the buildid data
> 1.1) To ensure DSOs have buildid data populate the buildid header in
> the perf.data  at the end of perf record
> 2) Replace some DSO that's got a sample in the perf.data with a different DSO
> 3) Run perf report
> 3.1) The DSO's buildid is known via the header, debuginfod can
> populate the buildid cache as needed
> 
> With --buildid-mmap:
> 1) Run perf record with mmap2 buildid data
> 1.1) No need to post process file to gather buildids
> 2) Replace some DSO that's got a sample in the perf.data with a different DSO
> 3) Run perf report
> 3.1) The DSO's buildid is known via the mmap2 events, debuginfod can
> populate the buildid cache as needed
> 
> With the current way and the current way with -N there is a race with
> the DSO changing midway through perf record. The buildid mmap closes
> the race.
> With -N and --buildid-mmap the buildid cache is populated based on use
> by a tool trying to read the DSO, rather than ahead of time at the end
> of perf record.
> 
> Is the risk of the race that much of an issue? I'm not sure, that's
> why I'd say default to using -B (if we didn't switch to buildid mmaps
> by default, but this series does that). You could opt into to covering
> the race by adding a flag so the data is processed at the end of perf
> record. You could use perf inject to add the build IDs.
> 
> As you say there's the cost at the end of perf record and I'm not sure
> it is worth it, which is why I'd expect the default to be to opt into
> having the cost. With --buildid-mmap I'm not seeing a race to cover
> but this series populates the buildid cache as I know you've argued
> that perf record should do this by default.

Yeah, I just wanted to keep the original behavior to save the used
binaries in the build-ID cache.  But we can use debuginfod if it's
available as you said.

I think it's a separate topic whether we prefer the build-ID cache or
debuginfod.  We should be able to change the default behavior with a
config option later.  So let's keep the caching for now.

Thanks,
Namhyung

