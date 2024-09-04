Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6775D1DA63A;
	Wed,  4 Sep 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464085; cv=none; b=MLe0OcpcIlW+zhkrskPV2VolWWsxw++vdKp7TQCEXe68maR1OpkvRLItcntDmHLJmkDu3BRua9x0NDzJMVFTIeEByGGGpmq4v81jmtDMopDA5ExCdCseRBKktcnWGjbUiPR9i3X8/sbqgJAAT5e1OpgGASaI2E+X7qUu0noE73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464085; c=relaxed/simple;
	bh=5rjogA+IPNpv3Q2rnXJqD03vvnleraaCLdUQNMypHv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQD8kY+PPg67USZ1HvVn6OX1VvwoMFzIXIPb8arRKGS0EkzwMH4B2N7OG7+mwDwFbFzOhnMkaJcaKa4DLuxrHpGQUrnfPasgvH2yLHWyOnW1n9AGUZ4VNspAuJqSraYLdvbycRqtxFAhd+t8mVo4l5APAo1T2dK4ikEWbczIeR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAAJR3cx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAAJR3cx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F62C4CEC3;
	Wed,  4 Sep 2024 15:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725464084;
	bh=5rjogA+IPNpv3Q2rnXJqD03vvnleraaCLdUQNMypHv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAAJR3cxNrSEnMGt2JIWtjueuIlAJFLOMYXjFJC+CRxXRodEFlqmi2xa1oG5zAa6I
	 fZRqEEaW2ofZlTn2gY7MC3IEXlCsbcQfjBCbYMpRQY7RTdxjFKgjofm39QJPKxxv/H
	 CmKgOhDdvxbTLlfP4RLqJA5yL1t6e2tEcI6emJuvTfTaUnMURw61BjOPpGfajI/bOK
	 Pk9KChYCmvtHJbRNuWhKhiTasoDnK3kPyK0E/52gEgTU/LDVEY07aCZUlnYrKXDsH1
	 zqRPhC1SwsYRnuBKALwVx1dsOC8tBdTOsKpKIJ5XmPersVoR6Ch0ayES1R4G1LbExN
	 wWAWJvIE2pQ5g==
Date: Wed, 4 Sep 2024 12:34:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf mem record not getting the mem_load_aux events by default
Message-ID: <Zth-DBdaSXodeFqn@x1>
References: <Zthu81fA3kLC2CS2@x1>
 <e848ad7b-bc9d-4eca-8918-0dd5a67c347e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e848ad7b-bc9d-4eca-8918-0dd5a67c347e@linux.intel.com>

On Wed, Sep 04, 2024 at 11:20:57AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-09-04 10:30 a.m., Arnaldo Carvalho de Melo wrote:
> > Hi Kan,
> > 
> > Recently I presented about 'perf mem record' and found that I had use
> > 'perf record' directly as 'perf mem record' on a Intel Hybrid system
> > wasn't selecting the required aux event:
> > 
> >   http://vger.kernel.org/~acme/prez/lsfmm-bpf-2024/#/19
> > 
> > The previous slides show the problem and the one above shows what worked
> > for me.
> > 
> > I saw this while trying to fix that:
> > 
> > Author: Kan Liang <kan.liang@linux.intel.com>
> > commit abbdd79b786e036e60f01b7907977943ebe7a74d
> > Date:   Tue Jan 23 10:50:32 2024 -0800
> > 
> >     perf mem: Clean up perf_mem_events__name()
> >     
> >     Introduce a generic perf_mem_events__name(). Remove the ARCH-specific
> >     one.
> >     
> >     The mem_load events may have a different format. Add ldlat and aux_event
> >     in the struct perf_mem_event to indicate the format and the extra aux
> >     event.
> >     
> >     Add perf_mem_events_intel_aux[] to support the extra mem_load_aux event.
> >     
> >     Rename perf_mem_events__name to perf_pmu__mem_events_name.
> > 
> > --------------------------´
> > 
> > So there are provisions for selecting the right events, but it doesn't
> > seem to be working when I tried, can you take a look at what I describe
> > on those slides and see what am I doing wrong?
> > 
> 
> If I understand the example in the slides correctly, the issue is that
> no mem events from big core are selected when running perf mem record,
> rather than wrong mem events are selected.
> 
> I don't see an obvious issue. That looks like a regression of the perf
> mem record. I will find a Alder Lake or Raptor Lake to take a deep look.

My expectation was for whatever is needed for having those events to be
put in place, like I did manually, and indeed, limiting it to cpu_core:

taskset -c 0 \
  perf record --weight --data \
              --event '{cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/P}:S' \
	      --event cpu_core/mem-stores/ find / > /dev/null

I.e. lots of boilerplate for using 'perf mem record', we should at least
have some sort of warning about the 'perf mem record' experience having
to be restricted to workloads running on PMUs where it can take place,
perhaps making 'perf mem record' to restrict the CPUs used for a session
to be the ones with the needed resources... and we have that already:

root@number:~# perf mem record sleep 1
Memory events are enabled on a subset of CPUs: 16-27
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.032 MB perf.data ]
root@number:~#

But...

root@number:~# perf evlist
cpu_atom/mem-loads,ldlat=30/P
cpu_atom/mem-stores/P
dummy:u
root@number:~# perf evlist -v
cpu_atom/mem-loads,ldlat=30/P: type: 10 (cpu_atom), size: 136, config: 0x5d0 (mem-loads), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1, { bp_addr, config1 }: 0x1f
cpu_atom/mem-stores/P: type: 10 (cpu_atom), size: 136, config: 0x6d0 (mem-stores), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|PERIOD|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1
dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|ADDR|IDENTIFIER|DATA_SRC|WEIGHT_STRUCT, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
root@number:~# 

It is not setting up the required

  --event '{cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/P}:S'

part, right?

To make this more useful perhaps we should, in addition to warning that
is running just on those CPUs, when we specify a workload (sleep 1) in
the above case, limit that workload to that set of CPUs so that we can
get those mem events on all of the workload runtime?

We would just add a new warning for that behaviour, etc.

- Arnaldo
