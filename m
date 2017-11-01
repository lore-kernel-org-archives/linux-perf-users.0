From: Michael Sartain <mikesart@fastmail.com>
Subject: Re: Dropped Events
Date: Tue, 31 Oct 2017 22:06:42 -0600
Message-ID: <20171101040641.yyh7kttexizyl5kr@mikesart-cos>
References: <20171026172107.kr3dcdbhfwwf4p2e@mikesart-cos>
 <20171026201838.GN7045@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46301 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750758AbdKAEGp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Nov 2017 00:06:45 -0400
Content-Disposition: inline
In-Reply-To: <20171026201838.GN7045@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Pierre-Loup Griffais <pgriffais@valvesoftware.com>

On Thu, Oct 26, 2017 at 05:18:38PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 26, 2017 at 11:21:07AM -0600, Michael Sartain escreveu:
> > We are doing some fairly simple ftrace captures using trace-cmd and we're
> > missing chunks of events. We are starting the trace via something like ~ this:
> > 
> >     trace-cmd record -i -k -b 2000 -o $startTrace__traceFile \
> >         -e "amdgpu:amdgpu_vm_flush" -e "amdgpu:amdgpu_cs_ioctl" \
> >         -e "amdgpu:amdgpu_sched_run_job" -e "drm:drm_vblank_event" \
> >         -e "*fence:*fence_signaled" -e "amdgpu:amdgpu_ttm_bo_move" \
> >         -e "sched:sched_switch" &
> > 
> > And then the capture is done with a kill -9 $(pidof trace-cmd)
> 
> Can you try with the equivalent 'perf record' (or perf trace) call?
> 
> [root@jouet ~]# perf record -m 16384 -e i915:intel_gpu_freq_change,drm:drm_vblank_event,fence*:*fence_signaled,sched:sched_switch^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 2.792 MB perf.data (2895 samples) ]
> 
> [root@jouet ~]#
> 
> It'll report lost events, replace the i915 with the amdgpu events.

Hi Arnaldo.

Sorry for the delay, got busy doing some other work and took a while to
narrow down a repro case that didn't involve running games and VR
compositors, etc.

I did the following on my Dell XPS i7-6560U laptop with Debian Test 4.13.4-2.

1. Ran: glxgears -fullscreen
2: Ran: sudo perf record -m 16384 -e sched:sched_switch -e sched:sched_process_fork -e sched:sched_process_exec
     -e sched:sched_process_exit -e drm:drm_vblank_event -e drm:drm_vblank_event_queued -e *fence:*fence_signaled
     -e i915:i915_flip_request -e i915:i915_flip_complete -e i915:intel_gpu_freq_change -e i915:i915_gem_request_add
     -e i915:intel_engine_notify -e i915:i915_gem_request_wait_begin -e i915:i915_gem_request_wait_end

  << ... waited ~30 seconds ... >>
^C
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 10.466 MB perf.data (85200 samples) ]

Everything worked as expected in this case. The below is a repro for ~ what
we're seeing with the loaded system.

1. Ran: glxgears -fullscreen
2: Ran: sudo perf record -m 16384 -e sched:sched_switch -e sched:sched_process_fork -e sched:sched_process_exec
     -e sched:sched_process_exit -e drm:drm_vblank_event -e drm:drm_vblank_event_queued -e *fence:*fence_signaled
     -e i915:i915_flip_request -e i915:i915_flip_complete -e i915:intel_gpu_freq_change -e i915:i915_gem_request_add
     -e i915:intel_engine_notify -e i915:i915_gem_request_wait_begin -e i915:i915_gem_request_wait_end
3. Ran: dd oflag=direct if=/home/mikesart/test.tmp of=/home/mikesart/test2.tmp bs=4k count=2000000 && sync
     where test.tmp is a ~7.7G file

  << ... waited ~30 seconds ... >>
^C
[ perf record: Woken up 4 times to write data ]
[ perf record: Captured and wrote 165.687 MB perf.data (1359800 samples) ]

For this case we wound up with a 165MB perf.data file. This is the same
behavior we're seeing with trace-cmd. No reported missing events or anything,
and a huge trace.dat file with missing chunks of events.

Thanks.
 -Mike
