Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D72D373F;
	Fri,  7 Nov 2025 21:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762551778; cv=none; b=pKacYHHsSIfXJ6PmVCuk582Vk5WZOWlh/StsGOkdX/V3x49Nu+5a8S2Ulk6bxHH7QXfLLPYKY3dPpYsMkl2J//R5akBx8mwI96VguFL9U1PL9bQY+IclKnwR34xfZBFn4svezcq23PpGmwQTTT731gxIxqh8+n1gsKNICmIyupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762551778; c=relaxed/simple;
	bh=Qi5rdv1cLi6FjllauKJFwU0rxY8XG3HO6f4YGpav/uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGkVszD7CAAcgsArKsnvLmKbzu7UQAXxpdMAA7OxYYr6nRyd+Yt8k5lFmYHv1LubE2Z8urYSlp2EWe9MpPLVUYpxPBL5TdzW8nnbWlOW+zaS5EGkBT4emWwy3DNaY1DmEKcip0/RSeY933bi5x7hOD0Oz2/nCVu+zy01J3oFImc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+nxGHDl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+nxGHDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CCBC4CEF8;
	Fri,  7 Nov 2025 21:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762551778;
	bh=Qi5rdv1cLi6FjllauKJFwU0rxY8XG3HO6f4YGpav/uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+nxGHDlfr4dJPh3lcGHrgpQ7fOdacTxFtmf/GVSCPhYze1kt2jBA0aPbhyZA/vRm
	 VJvUnUPtd+Zis0nEy3uKdzoZJnH9zVkYNNigd0u2AE/5tOOP+mYqcCCmOA90wb6Yty
	 ub68X8kUrObZg2+Qtjxgr/gxqOuqkK6zwWW1US4GwNizf5fSxQxepR8lDw+JEfPWll
	 M2FNSQTRCWAUCBZyHZRV1ci+gYiXq3AcExcAAfXw2zOrb91Vi7rVd+3emTXkabqFbH
	 Uw7RwGAUo0tEgUABtPpxEa69Uzr+r60Xnxsn+BT/1vTu2MT0RZGekiQo5jgI/29A/Z
	 bnpaOW5KiyfDQ==
Date: Fri, 7 Nov 2025 13:42:56 -0800
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
Message-ID: <aQ5n4ML9lxY4VAxi@google.com>
References: <20251022220802.1335131-1-zide.chen@intel.com>
 <aPrktlANBHFtV52B@google.com>
 <576a7d2b-0a82-4738-8b86-507e4d841524@intel.com>
 <aP1ucJiJYBavTHV7@google.com>
 <e10d671a-eb89-4e06-a1eb-e2f12ee41d70@intel.com>
 <aQl3qfyTdAb68l1l@google.com>
 <652bf158-ba9e-4a97-b4c3-3a7f7e39fe85@intel.com>
 <aQzugcpRvOcPEEro@google.com>
 <5f84fe4f-90ef-42d6-8a3a-c1f515a7832a@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f84fe4f-90ef-42d6-8a3a-c1f515a7832a@intel.com>

On Thu, Nov 06, 2025 at 05:23:09PM -0800, Chen, Zide wrote:
> 
> 
> On 11/6/2025 10:52 AM, Namhyung Kim wrote:
> > On Tue, Nov 04, 2025 at 11:10:44AM -0800, Chen, Zide wrote:
> >>
> >>
> >> On 11/3/2025 7:48 PM, Namhyung Kim wrote:
> >>> Hello,
> >>>
> >>> Sorry for the delay.
> >>>
> >>> On Mon, Oct 27, 2025 at 11:56:52AM -0700, Chen, Zide wrote:
> >>>>
> >>>>
> >>>> On 10/25/2025 5:42 PM, Namhyung Kim wrote:
> >>>>> On Fri, Oct 24, 2025 at 11:03:17AM -0700, Chen, Zide wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 10/23/2025 7:30 PM, Namhyung Kim wrote:
> >>>>>>> Hello,
> >>>>>>>
> >>>>>>> On Wed, Oct 22, 2025 at 03:08:02PM -0700, Zide Chen wrote:
> >>>>>>>> Commit c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
> >>>>>>>> unconditionally called the precise_ip fallback and moved it after the
> >>>>>>>> missing-feature checks so that it could handle EINVAL as well.
> >>>>>>>>
> >>>>>>>> However, this introduced an issue: after disabling missing features,
> >>>>>>>> the event could fail to open, which makes the subsequent precise_ip
> >>>>>>>> fallback useless since it will always fail.
> >>>>>>>>
> >>>>>>>> For example, run the following command on Intel SPR:
> >>>>>>>>
> >>>>>>>> $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
> >>>>>>>>
> >>>>>>>> Opening the event "cpu/mem-loads,ldlat=3/PS" returns EINVAL when
> >>>>>>>> precise_ip == 3. It then sets attr.inherit = false, which triggers a
> >>>>>>>
> >>>>>>> I'm curious about this part.  Why the kernel set 'inherit = false'?  IOW
> >>>>>>> how did the leader event (mem-loads-aux) succeed with inherit = true
> >>>>>>> then?
> >>>>>>
> >>>>>> Initially, the inherit = true for both the group leader
> >>>>>> (cpu/mem-loads-aux/S) and the event in question (cpu/mem-loads,ldlat=3/PS).
> >>>>>>
> >>>>>> When the second event fails with EINVAL, the current logic calls
> >>>>>> evsel__detect_missing_features() first. Since this is a PERF_SAMPLE_READ
> >>>>>> event, the inherit attribute falls back to false, according to the
> >>>>>> fallback order implemented in evsel__detect_missing_features().
> >>>>>
> >>>>> Right, that means the kernel doesn't support PERF_SAMPLE_READ with
> >>>>> inherit = true.  How did the first event succeed to open then?
> >>>>
> >>>> The perf tool sets PERF_SAMPLE_TID for Inherit + PERF_SAMPLE_READ
> >>>> events, as implemented in commit 90035d3cd876 ("tools/perf: Allow
> >>>> inherit + PERF_SAMPLE_READ when opening event").
> >>>>
> >>>> Meanwhile, commit 7e8b255650fc ("perf: Support PERF_SAMPLE_READ with
> >>>> inherit") rejects a perf event if has_inherit_and_sample_read(attr) is
> >>>> true and PERF_SAMPLE_TID is not set in attr->sample_type.
> >>>>
> >>>> Therefore, the first event succeeded, while the one opened in
> >>>> evsel__detect_missing_features() which doesn't have PERF_SAMPLE_TID failed.
> >>>
> >>> Why does the first succeed and the second fail?  Don't they have the
> >>> same SAMPLE_READ and SAMPLE_TID + inherit flags?
> >>
> >> Sorry, my previous reply wasn’t entirely accurate. The first event
> >> (cpu/mem-loads-aux/S) succeeds because it’s not a precise event
> >> (precise_ip == 0).
> > 
> > I'm not sure how it matters.  I've tested the same command line on SPR
> > and got this message.  It says it failed to open because of inherit and
> > SAMPE_READ.  It didn't have precise_ip too.
> > 
> >   $ perf record -e cpu/mem-loads-aux/S -vv true |& less
> >   ...
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             4 (cpu)
> >     size                             136
> >     config                           0x8203 (mem-loads-aux)
> >     { sample_period, sample_freq }   4000
> >     sample_type                      IP|TID|TIME|READ|ID|PERIOD
> >     read_format                      ID|LOST
> >     disabled                         1
> >     inherit                          1
> >     mmap                             1
> >     comm                             1
> >     freq                             1
> >     enable_on_exec                   1
> >     task                             1
> >     sample_id_all                    1
> >     mmap2                            1
> >     comm_exec                        1
> >     ksymbol                          1
> >     bpf_event                        1
> >   ------------------------------------------------------------
> >   sys_perf_event_open: pid 1161023  cpu 0  group_fd -1  flags 0x8
> >   sys_perf_event_open failed, error -22
> >   Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.
> >   ...
> > 
> > And it fell back to no-inherit and succeeded.  
> 
> On my SPR, with either kernel 6.18.0-rc4 or the older 6.17.0-rc6, my
> test results are different from yours — I didn’t see any EINVAL, and
> there was no fallback. :)

Yep, your kernel is recent and has the following commit.

7e8b255650fcfa1d0 ("perf: Support PERF_SAMPLE_READ with inherit")

My kernel is 6.6 and it rejects such a combination.  I'll test it on
newer kernels later.

> 
> It’s strange, but even so, since there’s no group leader in this case, I
> assume that when it falls back to non-inherit, it should pass the
> following check.
> 
>         if (task && group_leader &&
>             group_leader->attr.inherit != attr.inherit) {
>                 err = -EINVAL;
>                 goto err_task;
>         }
> 
> > I've also found that it
> > worked even with precise_ip = 3.
> > 
> >   $ perf record -e cpu/mem-loads-aux/PS -vv true |& less
> >   ...
> >   sys_perf_event_open: pid 1172834  cpu 0  group_fd -1  flags 0x8
> >   sys_perf_event_open failed, error -22
> >   Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             4 (cpu)
> >     size                             136
> >     config                           0x8203 (mem-loads-aux)
> >     { sample_period, sample_freq }   4000
> >     sample_type                      IP|TID|TIME|READ|ID|PERIOD
> >     read_format                      ID|LOST
> >     disabled                         1
> >     mmap                             1
> >     comm                             1
> >     freq                             1
> >     enable_on_exec                   1
> >     task                             1
> >     precise_ip                       3         <<<---- here
> >     sample_id_all                    1
> >     mmap2                            1
> >     comm_exec                        1
> >     ksymbol                          1
> >     bpf_event                        1
> >   ------------------------------------------------------------
> >   sys_perf_event_open: pid 1172834  cpu 0  group_fd -1  flags 0x8 = 4
> >   ...
> 
> Again, on my machine, I didn’t see EINVAL, and no fallback to
> non-inherit. In my test, glc_get_event_constraints() successfully forces
> this event (config == 0x8203) to fixed counter 0, so there’s no issue here.

That means your missing_features.inherit_sample_read should not be set.
It's strange you have that with the recent kernels.

Can you run these commands and show the output here?

  $ perf record -e task-clock:S  true
  $ perf evlist -v

Thanks,
Namhyung

> 
> > And it works fine on my machine.
> > 
> >   $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads/PS}' ls
> >   ...
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.033 MB perf.data (6 samples) ]
> 
> I don't know why it works for you, but in my tests, this event:
> 
> Opening: cpu/mem-loads/PS
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4 (cpu)
>   size                             248
>   config                           0x1cd
> (mem_trans_retired.load_latency_gt_1024)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|READ|ID|PERIOD
>   read_format                      ID|GROUP|LOST
>   inherit                          1
>   freq                             1
>   precise_ip                       3
>   sample_id_all                    1
>   { bp_addr, config1 }             0x3
> ------------------------------------------------------------
> 
> It gets emptyconstraint, then it can't schedule the event on any counter
> and x86_schedule_events() returns -EINVAL.
> 
> glc_get_event_constraints()
> {
>         struct event_constraint *c;
> 	
> 	// It gets the constraint INTEL_PLD_CONSTRAINT(0x1cd, 0xfe)
> 	// from intel_pebs_constraints(),
>         c = icl_get_event_constraints(cpuc, idx, event);
> 
> 	// When it tries to force :ppp event to fixed counter 0
>         if ((event->attr.precise_ip == 3) &&
>             !constraint_match(&fixed0_constraint, event->hw.config)) {
> 
> 		// It happens the constrain doesn't mask fixed counter 0
>                 if (c->idxmsk64 & BIT_ULL(0)) {
>                         return &counter0_constraint;
> 		
> 		// It gets here.
>                 return &emptyconstraint;
>         }
> 
>         return c;
> }
> 
> After that, it falls back to non-inherit, and it fails again because the
> inherit attribute differs from the group leader’s. This carries over to
> the precise_ip fallback path in the current code.
> 
> >>
> >> The second event fails with -EINVAL because, on some platforms, events
> >> with precise_ip = 3 must be scheduled on fixed counter 0, and it fails
> >> if it happens that this counter is unavailable.
> >>
> >> In the current code, the first fallback attempt (inherit = 0) also fails
> >> because the inherit attribute differs from that of the group leader
> >> (first event).
> > 
> > So I don't understand this.  Either the first event failed due to
> > inherit set or the second event should succeed with inherit.  Maybe
> > there's an unknown bug or something.
> > 
> > Thanks,
> > namhyung
> > 
> 
