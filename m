Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388171E2845;
	Mon, 10 Mar 2025 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642085; cv=none; b=lgeY0U6T9fKP/rPxogULZ+iCPg4xqH3rqlK2gUb4Z33nVR64f5lruBG+7B4l+sBC8UbnNrXBUcsmL+8rF5vMMwC+ZBwAFdFCzGnVh/Gac8lJHskhgp5yNUQRssHpo7Ndv1I+s25x3k7hgDBlRNpdnFeyTAuYAvTnD6d0sMKCazk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642085; c=relaxed/simple;
	bh=fimXjcsEmAf6FQYUCIrEKVZ2zpu/p5pUUtEOH6JJjn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7vFmEbmuygoEzGiFLWeobfeRskDj6/noGWX8lp9nGZGYlWRjcAeEGa8rFVw7fJ6laiKRJHGqxMn2dXQi75fmu57AP/rbXbB6CUq7vGkETrI1jfshWAGwqEBqQP+fHWJdnIlNnMNrM4Ve4L93so4JJ7O/NLN5P+h9Jj/Mu32XVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgsCgKBg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgsCgKBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0627AC4CEED;
	Mon, 10 Mar 2025 21:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741642084;
	bh=fimXjcsEmAf6FQYUCIrEKVZ2zpu/p5pUUtEOH6JJjn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgsCgKBg9Y5chyvUXsP5kQ78lxQyKMCQ19xtNX41mj5orgtQj+i59bUWKPMwfixuK
	 4isu6tvtf8AXXuv7UB8mpD1hwCeqsERQO4Ce9T77A5D2WDHoMbXVQVcjQdC0K8NLxC
	 HyPTkrYdtABeZ9HBZmfGL+qbXNrtRWYIEr6RLlgyHKyDW0reZblyLyhiU4CG9TTNV1
	 21UL0zptZnLHGsjFsiM84KyaXSuySddNj9lLHOBr6iPD0CCbz8nt7Vtfyv8Zf3Xh+c
	 8rsh1bQj9eyPwXqyE55mAcgyyLvAt8i+LnApfJ+veZzQvaoim3SAnOaBrJ8mx1MOI4
	 6W7/TewS0V3dA==
Date: Mon, 10 Mar 2025 18:28:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 11/11] perf python tracepoint: Switch to using
 parse_events
Message-ID: <Z89ZYVgL_bT3ampz@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-12-irogers@google.com>
 <Z89We45bGpeJvO9C@x1>
 <Z89WvaIVyF7klGp6@x1>
 <CAP-5=fXzva636zCZR2isdfrjT6mM3o42C+oGWNkGieqGVajfHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXzva636zCZR2isdfrjT6mM3o42C+oGWNkGieqGVajfHA@mail.gmail.com>

On Mon, Mar 10, 2025 at 02:17:59PM -0700, Ian Rogers wrote:
> On Mon, Mar 10, 2025 at 2:16 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Mar 10, 2025 at 06:15:42PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Fri, Feb 28, 2025 at 02:23:08PM -0800, Ian Rogers wrote:
> > > > Rather than manually configuring an evsel, switch to using
> > > > parse_events for greater commonality with the rest of the perf code.
> > > >
> > > > Reviewed-by: Howard Chu <howardchu95@gmail.com>
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > Now will all in place I'm trying to test it and I am getting some
> > > strange results:
> > >
> > > root@number:/home/acme/git/perf-tools-next# tools/perf/python/tracepoint.py
> > > <SNIP lots of seemingly ok lines>
> > > time 78318710956557 prev_comm=sudo prev_pid=3133818 prev_prio=120 prev_state=0x1 ==> next_comm=swapper/14 next_pid=0 next_prio=120
> > > time 78318720082300 prev_comm=swapper/16 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=kworker/u112:8 next_pid=1752774 next_prio=120
> > > time 78318706232435 prev_comm=kworker/u112:17 prev_pid=1551246 prev_prio=120 prev_state=0x80 ==> next_comm=swapper/21 next_pid=0 next_prio=120
> > > time 78318708202121 prev_comm=sudo prev_pid=3133818 prev_prio=120 prev_state=0x2 ==> next_comm=swapper/25 next_pid=0 next_prio=120
> > > time 78318748346989 prev_comm=swapper/26 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=gnome-terminal- next_pid=3551 next_prio=120
> > > Traceback (most recent call last):
> > >   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 47, in <module>
> > >     main()
> > >   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 42, in main
> > >     event.next_comm,
> > >     ^^^^^^^^^^^^^^^
> > > AttributeError: 'perf.sample_event' object has no attribute 'next_comm'
> > > root@number:/home/acme/git/perf-tools-next#
> > >
> > > But it shouldn't get there as there is this check:
> > >
> > >             if not isinstance(event, perf.sample_event):
> > >                 continue
> > >
> > >
> > > :-\
> > >
> > > Trying to debug that...
> >
> > And it doesn't seem related to your series, I checked and v6.13 has the
> > same problem, I nuked the build dir, etc.
> 
> Right. I'd seen the same issue.

time 79411977132102 prev_comm=sudo prev_pid=3133818 prev_prio=120 prev_state=0x2 ==> next_comm=swapper/12 next_pid=0 next_prio=120
{ type: sample }
time 79411977200343 prev_comm=kworker/u112:17 prev_pid=1551246 prev_prio=120 prev_state=0x80 ==> next_comm=swapper/16 next_pid=0 next_prio=120
{ type: sample }
time 79411964535268 prev_comm=kworker/u112:14 prev_pid=810939 prev_prio=120 prev_state=0x80 ==> next_comm=swapper/17 next_pid=0 next_prio=120
{ type: sample }
time 79411964746511 prev_comm=swapper/18 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=kworker/u112:12 next_pid=2109251 next_prio=120
{ type: sample }
Traceback (most recent call last):
  File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 48, in <module>
    main()
  File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 43, in main
    event.next_comm,
    ^^^^^^^^^^^^^^^
AttributeError: 'perf.sample_event' object has no attribute 'next_comm'
root@number:/home/acme/git/perf-tools-next#

And it says it is a sample... 


Well, ran out of time, will try later or early tomorrow, will also try
to review the syscalltbl series and Howard's off cpu profiling.

- Arnaldo
