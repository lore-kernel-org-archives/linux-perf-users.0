Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CBA207A20;
	Wed, 28 May 2025 22:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748470577; cv=none; b=nHgQNoaTMsfSCSuEziPrSwXqx22l83igxihXbfsFtDt9KIDH0tKzCc4qnkl8R7K7vJBjARhxKbeIXHbVSe9BbcW2Teckhtb7/gfxSIOfhqg+yvaTPIKxHiHC7Am9JfoEWEFYLOFBZwDvT2mMRQSnDGGmDUoFgbhn9pT8OrhuCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748470577; c=relaxed/simple;
	bh=14aYNCNfI06xgQO0opu7LK+XD3fig3/AMaFXaT8jqi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brkiRKkc8cZrTqz79slToAL3/c66bMWUei9nadwXSR4JoZlebhPNASNDU/2/NYmjFgclkQYqGgnNCgfQxldASBC00JHeCGCxJOhM+Zqc7mPBwFYywpDiaE/JbjpkYIH+IIoZTLp2hiJspUTjb2QhFzwBYrFh3MiiGMON8rw7idU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhofPInb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhofPInb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697DBC4CEE3;
	Wed, 28 May 2025 22:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748470576;
	bh=14aYNCNfI06xgQO0opu7LK+XD3fig3/AMaFXaT8jqi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhofPInbXDWh1B5QlG2a3ED7JdgjQiTBNCjvubn+7PFjm+jbRxTtyDSe8LUnwGvGx
	 +OyWBcYO8Rl5IPfMbLtZrOpU0rsVaTBrtCAS4o0Zhr0j86YbG8jm6Ote67Ml/rWaXF
	 qeE+hfzW3Oe5o0svZdwCgmP30J3wEu+4bRsdgw2lIhScVmeY/g2vYHA5Ki6E2XJCUf
	 YCWQCk/WNac5oJ1tZpqNcD/zFbiIBU0TrPeizuLZDVl4lyhuUN0vrsabaxFyesIy+S
	 lX08Q4ga8WFvklLVhh1FIaGQGaNGOvoWiXcuzNmEeU5SGgRXoSye2vyT+msw8YpXRl
	 BidGtghk9kvIg==
Date: Wed, 28 May 2025 15:16:14 -0700
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
Message-ID: <aDeLLvBVQnQqJT4b@google.com>
References: <20250428213409.1417584-1-irogers@google.com>
 <20250428213409.1417584-6-irogers@google.com>
 <aDd06eK7fKFsFsVS@google.com>
 <CAP-5=fV-cLLpdyoqL8+Jrt3iYU7EbpZZDOyM1kBCc+54gA2Nzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV-cLLpdyoqL8+Jrt3iYU7EbpZZDOyM1kBCc+54gA2Nzg@mail.gmail.com>

On Wed, May 28, 2025 at 01:54:41PM -0700, Ian Rogers wrote:
> On Wed, May 28, 2025 at 1:41 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Apr 28, 2025 at 02:34:04PM -0700, Ian Rogers wrote:
> > > Previously only the sample IP's map DSO would be marked hit for the
> > > purposes of populating the build ID cache. Walk the call chain to mark
> > > all IPs and DSOs.
> >
> > I think this is correct, but I'm afraid it'd also increase the processing
> > time.  Do you happen to have any numbers?
> 
> It increases time spent processing the data file but to get a large
> data file I had to run for multiple seconds and I struggled to get the
> performance cost of this to be in the milliseconds (ie a tiny fraction
> of the record time). Ultimately I found the change imperceptible and
> couldn't think of a good command line to make it perceptible.

The worst case would be dwarf unwinding.  Maybe we can skip the
processing if it takes too long..

> 
> If the time is spent populating ~/.debug because more DSOs are marked
> then this is fixing a bug and isn't a problem with the patch.

Right, it's a good thing.

> 
> My personal opinion is that it is somewhat surprising `perf record` is
> post-processing the perf.data file at all, and -B and -N would be my
> expected defaults - just as --buildid-mmap implies --no-buildid (-B).

Otherwise nobody will run perf buildid-cache to add the info. :)


> I didn't want to modify existing behaviors in these changes, however,
> in this case I was just trying to make the existing behavior correct,
> similar to fixing the same bug in `perf inject`.

Thanks for your work,
Namhyung

