Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD20321D3E9;
	Tue, 29 Apr 2025 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939684; cv=none; b=PbWMzREUzfMMHqQM40dc7GOG1h6ZYEQta9NYaLqdOrgxWk54zqFKEn/19JSBOcsykV191bF5IwCQl3DsTwDKi+wTriAh4VktzH8qbajX4CnOn5vI53mUHQTKIh9cI6OgO+Q3BVqsZWz1V218DvJUOgaTswBQzBiNVp7eqN1NlmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939684; c=relaxed/simple;
	bh=GLuJPQJ8jw6F8oYf1L5LisnKK/54a8/jdguuwfZpUXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoFFM8JJEfdLe7eby69B8qvIP7k8YmRcShikCfySu5UTXWKaJEDr3d8Ltga51s+wD9bcAo+A4uLCFoUQEuJouj/yJqkA83Sp5cHOeO4fuJSfcf7mlx442yhMkjKfk8shjD9zTqhPW1pS+F/uoY3rZw+WJKK3eBtyjiZ8yOT+Xw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3Fi/XPJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3Fi/XPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4FEC4CEE3;
	Tue, 29 Apr 2025 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745939684;
	bh=GLuJPQJ8jw6F8oYf1L5LisnKK/54a8/jdguuwfZpUXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3Fi/XPJdT+9timjOV6EOiO+q1Ips7Bz+rFOmsDFzBrOdricBGOxYoPa/BUu9uRto
	 S8P2hfZ/idhZOJLRXvi3G4gI8ZOkdv7ZOSksoWB+8QHmDyeD36G9UkBXOpVmIH41+m
	 skd+Gx2y86WElqYp/F1E2jgQecEI9GRFtBBLtfpW0EndYDarHQpYeWzQdG77FHHRUA
	 vYJAhoaBkquc+DYJZOqtQDD+IibUktqb7rs8Y9kNMg9DfLyhbbhOrcAKD2/j7bUdtf
	 PmLrW7M012Gkc1gPPxUto/xqA+8xjII50Dr4TLIWKUTH6yHHzXgEA47PLAjIqNrm9K
	 7exreuKLos6gw==
Date: Tue, 29 Apr 2025 12:14:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Subject: Re: [PATCH v6 0/2] Prefer sysfs/JSON events also when no PMU is
 provided
Message-ID: <aBDsyY-iMT5CBg4i@x1>
References: <20250324164543.62574-1-irogers@google.com>
 <CAP-5=fWr8EUyro8ckxfMYWR3BhiXgzkjejTjmTb=8PR1p+wvWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWr8EUyro8ckxfMYWR3BhiXgzkjejTjmTb=8PR1p+wvWA@mail.gmail.com>

On Thu, Mar 27, 2025 at 12:13:45PM -0700, Ian Rogers wrote:
> On Mon, Mar 24, 2025 at 9:46 AM Ian Rogers <irogers@google.com> wrote:
> >
> > At the RISC-V summit the topic of avoiding event data being in the
> > RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
> > events being the priority when no PMU is provided so that legacy
> > events maybe supported via json. Originally Mark Rutland also
> > expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
> > M? processors, but James Clark more recently tested this and believes
> > the driver issues there may not have existed or have been resolved. In
> > any case, it is inconsistent that with a PMU event names avoid legacy
> > encodings, but when wildcarding PMUs (ie without a PMU with the event
> > name) the legacy encodings have priority.
> >
> > The patch doing this work was reverted in a v6.10 release candidate
> > as, even though the patch was posted for weeks and had been on
> > linux-next for weeks without issue, Linus was in the habit of using
> > explicit legacy events with unsupported precision options on his
> > Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
> > where ARM decided to call the events bus_cycles and cycles, the latter
> > being also a legacy event name. ARM haven't renamed the cycles event
> > to a more consistent cpu_cycles and avoided the problem. With these
> > changes the problematic event will now be skipped, a large warning
> > produced, and perf record will continue for the other PMU events. This
> > solution was proposed by Arnaldo.
> >
> > v6: Rebase of v5 (dropping already merged patches):
> >     https://lore.kernel.org/lkml/20250109222109.567031-1-irogers@google.com/
> >     that unusually had an RFC posted for it:
> >     https://lore.kernel.org/lkml/Z7Z5kv75BMML2A1q@google.com/
> >     Note, this patch conflicts/contradicts:
> >     https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@google.com/
> >     that I posted so that we could either consistently prioritize
> >     sysfs/json (these patches) or legacy events (the other
> >     patches). That lack of event printing and encoding inconsistency
> >     is most prominent in the encoding of events like "instructions"
> >     which on hybrid are reported as "cpu_core/instructions/" but
> >     "instructions" before these patches gets a legacy encoding while
> >     "cpu_core/instructions/" gets a sysfs/json encoding. These patches
> >     make "instructions" always get a sysfs/json encoding while the
> >     alternate patches make it always get a legacy encoding.
> 
> So another fun finding. Sysfs and json events are case insensitive:
> ```
> $ perf stat -e 'inst_retired.any,INST_RETIRED.ANY' true
> 
> Performance counter stats for 'true':
> 
>           129,134      cpu_atom/inst_retired.any:u/
>     <not counted>      cpu_core/inst_retired.any:u/
>                         (0.00%)
>           129,134      cpu_atom/INST_RETIRED.ANY:u/
>     <not counted>      cpu_core/INST_RETIRED.ANY:u/
>                         (0.00%)
> 
>       0.002193191 seconds time elapsed
> 
>       0.002354000 seconds user
>       0.000000000 seconds sys
> ```
> But legacy events match in lex code that is case sensitive. This means
> (on x86) the event 'instructions' is currently legacy, but the event
> 'INSTRUCTIONS' is a sysfs event. The event CYCLES is a parse error as
> there is no sysfs/json version. Given legacy events don't follow the
> case insensitivity norm this is more evidence we need to reduce their
> priority by merging these patches.

root@number:~# perf trace -e perf_event_open perf stat -C 1 -e INSTRUCTIONS,instructions,cycles sleep 1
     0.000 ( 0.025 ms): :620592/620592 perf_event_open(attr_uptr: { type: 4 (cpu), size: 136, config: 0xc0 (instructions), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1 }, pid: -1, cpu: 1, group_fd: -1, flags: FD_CLOEXEC) = 3
     0.030 ( 0.004 ms): :620592/620592 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x1 (PERF_COUNT_HW_INSTRUCTIONS), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1 }, pid: -1, cpu: 1, group_fd: -1, flags: FD_CLOEXEC) = 8
     0.035 ( 0.003 ms): :620592/620592 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1 }, pid: -1, cpu: 1, group_fd: -1, flags: FD_CLOEXEC) = 9

 Performance counter stats for 'CPU(s) 1':

         1,499,102      INSTRUCTIONS                                                          
         1,498,883      instructions                     #    0.81  insn per cycle            
         1,850,082      cycles                                                                

       1.001553577 seconds time elapsed

root@number:~#

So the behaviour if "instructions" is specified, since perf started, is
to have this:

     0.030 ( 0.004 ms): :620592/620592 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x1 (PERF_COUNT_HW_INSTRUCTIONS), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1 }, pid: -1, cpu: 1, group_fd: -1, flags: FD_CLOEXEC) = 8

And this is what we continue to obtain.

At some point we started supporting sysfs/JSON and then INSTRUCTIONS
started being accepted and we are getting:

     0.000 ( 0.025 ms): :620592/620592 perf_event_open(attr_uptr: { type: 4 (cpu), size: 136, config: 0xc0 (instructions), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1 }, pid: -1, cpu: 1, group_fd: -1, flags: FD_CLOEXEC) = 3

Which is what is expected, no change in behaviour over time.

- Arnaldo
