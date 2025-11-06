Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606D34CFC0;
	Thu,  6 Nov 2025 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455173; cv=none; b=LSJUtTDpe1hRIx1GYUQCzjZLasLBM8o/1Ync8X61V6eX1GYZUYVASJc5ydW12b+yRDTFe0LHey4qaRmr+/Aol29HaPABFqRMYNCwK2jrM2z2+wC+91aj8phL63oStQJnpVhxiwbiU2dyBVVCdehLuKBHNbfVyE0VoZaplrK55Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455173; c=relaxed/simple;
	bh=gdBHIuyO6YAVPPQfpte3nOsRwKm35zovfxtH21xO544=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEn7uXRRwtTMribYZa/BdX7FAh+1P2BlCkWW+/s1lF592+7dryRSJpUmU/4xpTtoR0aFBmAQeOqZWB5CS9HvRXihSxXpNR1V88tBkxxV0mC70ckDScb+AHVIvFvGZ4EOFVQlTRtqvwfkquWOVDdwvyqgkWWXIrfDWBWKSd+6krc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXbsOCC7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXbsOCC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47201C116B1;
	Thu,  6 Nov 2025 18:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762455172;
	bh=gdBHIuyO6YAVPPQfpte3nOsRwKm35zovfxtH21xO544=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXbsOCC7G4EBRbo+awbk8SLjpcL+Y/ewg/k/CaTr5Y07wTcEBiYH+9IfhGoB9mmIY
	 vdQXOkKQFeBg56mCS6m2Agxfm/kGeZT0DyLbbl3d2WI+sFDx/sCV/ihW/Gs36BvWWX
	 L8EaHQrkQNARFYSLcoSXnvifVPCf6VP8LfBAZNw0lT4yqLoBpiS8PTuqtdsojy2B0H
	 HEIWS4xTsDUhGETPhfhxr3mtXwVu1YG35VRFzxx2NRIckDr8JoxQLpuQ/l9BpF2ADZ
	 3l1PWXPl1jxI947wfgQCqyrmB4N8zlz0tvmkdd20LKV1AX+S+hq66FkydoT47DdO+A
	 e09GK0gIR0wNw==
Date: Thu, 6 Nov 2025 10:52:49 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	thomas.falcon@intel.com, dapeng1.mi@linux.intel.com,
	xudong.hao@intel.com
Subject: Re: [PATCH] perf tools: Refactor precise_ip fallback logic
Message-ID: <aQzugcpRvOcPEEro@google.com>
References: <20251022220802.1335131-1-zide.chen@intel.com>
 <aPrktlANBHFtV52B@google.com>
 <576a7d2b-0a82-4738-8b86-507e4d841524@intel.com>
 <aP1ucJiJYBavTHV7@google.com>
 <e10d671a-eb89-4e06-a1eb-e2f12ee41d70@intel.com>
 <aQl3qfyTdAb68l1l@google.com>
 <652bf158-ba9e-4a97-b4c3-3a7f7e39fe85@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <652bf158-ba9e-4a97-b4c3-3a7f7e39fe85@intel.com>

On Tue, Nov 04, 2025 at 11:10:44AM -0800, Chen, Zide wrote:
> 
> 
> On 11/3/2025 7:48 PM, Namhyung Kim wrote:
> > Hello,
> > 
> > Sorry for the delay.
> > 
> > On Mon, Oct 27, 2025 at 11:56:52AM -0700, Chen, Zide wrote:
> >>
> >>
> >> On 10/25/2025 5:42 PM, Namhyung Kim wrote:
> >>> On Fri, Oct 24, 2025 at 11:03:17AM -0700, Chen, Zide wrote:
> >>>>
> >>>>
> >>>> On 10/23/2025 7:30 PM, Namhyung Kim wrote:
> >>>>> Hello,
> >>>>>
> >>>>> On Wed, Oct 22, 2025 at 03:08:02PM -0700, Zide Chen wrote:
> >>>>>> Commit c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
> >>>>>> unconditionally called the precise_ip fallback and moved it after the
> >>>>>> missing-feature checks so that it could handle EINVAL as well.
> >>>>>>
> >>>>>> However, this introduced an issue: after disabling missing features,
> >>>>>> the event could fail to open, which makes the subsequent precise_ip
> >>>>>> fallback useless since it will always fail.
> >>>>>>
> >>>>>> For example, run the following command on Intel SPR:
> >>>>>>
> >>>>>> $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
> >>>>>>
> >>>>>> Opening the event "cpu/mem-loads,ldlat=3/PS" returns EINVAL when
> >>>>>> precise_ip == 3. It then sets attr.inherit = false, which triggers a
> >>>>>
> >>>>> I'm curious about this part.  Why the kernel set 'inherit = false'?  IOW
> >>>>> how did the leader event (mem-loads-aux) succeed with inherit = true
> >>>>> then?
> >>>>
> >>>> Initially, the inherit = true for both the group leader
> >>>> (cpu/mem-loads-aux/S) and the event in question (cpu/mem-loads,ldlat=3/PS).
> >>>>
> >>>> When the second event fails with EINVAL, the current logic calls
> >>>> evsel__detect_missing_features() first. Since this is a PERF_SAMPLE_READ
> >>>> event, the inherit attribute falls back to false, according to the
> >>>> fallback order implemented in evsel__detect_missing_features().
> >>>
> >>> Right, that means the kernel doesn't support PERF_SAMPLE_READ with
> >>> inherit = true.  How did the first event succeed to open then?
> >>
> >> The perf tool sets PERF_SAMPLE_TID for Inherit + PERF_SAMPLE_READ
> >> events, as implemented in commit 90035d3cd876 ("tools/perf: Allow
> >> inherit + PERF_SAMPLE_READ when opening event").
> >>
> >> Meanwhile, commit 7e8b255650fc ("perf: Support PERF_SAMPLE_READ with
> >> inherit") rejects a perf event if has_inherit_and_sample_read(attr) is
> >> true and PERF_SAMPLE_TID is not set in attr->sample_type.
> >>
> >> Therefore, the first event succeeded, while the one opened in
> >> evsel__detect_missing_features() which doesn't have PERF_SAMPLE_TID failed.
> > 
> > Why does the first succeed and the second fail?  Don't they have the
> > same SAMPLE_READ and SAMPLE_TID + inherit flags?
> 
> Sorry, my previous reply wasn’t entirely accurate. The first event
> (cpu/mem-loads-aux/S) succeeds because it’s not a precise event
> (precise_ip == 0).

I'm not sure how it matters.  I've tested the same command line on SPR
and got this message.  It says it failed to open because of inherit and
SAMPE_READ.  It didn't have precise_ip too.

  $ perf record -e cpu/mem-loads-aux/S -vv true |& less
  ...
  ------------------------------------------------------------
  perf_event_attr:
    type                             4 (cpu)
    size                             136
    config                           0x8203 (mem-loads-aux)
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|READ|ID|PERIOD
    read_format                      ID|LOST
    disabled                         1
    inherit                          1
    mmap                             1
    comm                             1
    freq                             1
    enable_on_exec                   1
    task                             1
    sample_id_all                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
  ------------------------------------------------------------
  sys_perf_event_open: pid 1161023  cpu 0  group_fd -1  flags 0x8
  sys_perf_event_open failed, error -22
  Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.
  ...

And it fell back to no-inherit and succeeded.  I've also found that it
worked even with precise_ip = 3.

  $ perf record -e cpu/mem-loads-aux/PS -vv true |& less
  ...
  sys_perf_event_open: pid 1172834  cpu 0  group_fd -1  flags 0x8
  sys_perf_event_open failed, error -22
  Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.
  ------------------------------------------------------------
  perf_event_attr:
    type                             4 (cpu)
    size                             136
    config                           0x8203 (mem-loads-aux)
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|READ|ID|PERIOD
    read_format                      ID|LOST
    disabled                         1
    mmap                             1
    comm                             1
    freq                             1
    enable_on_exec                   1
    task                             1
    precise_ip                       3         <<<---- here
    sample_id_all                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
  ------------------------------------------------------------
  sys_perf_event_open: pid 1172834  cpu 0  group_fd -1  flags 0x8 = 4
  ...

And it works fine on my machine.

  $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads/PS}' ls
  ...
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.033 MB perf.data (6 samples) ]

> 
> The second event fails with -EINVAL because, on some platforms, events
> with precise_ip = 3 must be scheduled on fixed counter 0, and it fails
> if it happens that this counter is unavailable.
> 
> In the current code, the first fallback attempt (inherit = 0) also fails
> because the inherit attribute differs from that of the group leader
> (first event).

So I don't understand this.  Either the first event failed due to
inherit set or the second event should succeed with inherit.  Maybe
there's an unknown bug or something.

Thanks,
namhyung

