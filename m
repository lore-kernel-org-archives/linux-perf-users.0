From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Dropped Events
Date: Thu, 26 Oct 2017 17:18:38 -0300
Message-ID: <20171026201838.GN7045@kernel.org>
References: <20171026172107.kr3dcdbhfwwf4p2e@mikesart-cos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751533AbdJZUSr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Oct 2017 16:18:47 -0400
Content-Disposition: inline
In-Reply-To: <20171026172107.kr3dcdbhfwwf4p2e@mikesart-cos>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Sartain <mikesart@fastmail.com>
Cc: linux-perf-users@vger.kernel.org, Pierre-Loup Griffais <pgriffais@valvesoftware.com>

Em Thu, Oct 26, 2017 at 11:21:07AM -0600, Michael Sartain escreveu:
> We are doing some fairly simple ftrace captures using trace-cmd and we're
> missing chunks of events. We are starting the trace via something like ~ this:
> 
>     trace-cmd record -i -k -b 2000 -o $startTrace__traceFile \
>         -e "amdgpu:amdgpu_vm_flush" -e "amdgpu:amdgpu_cs_ioctl" \
>         -e "amdgpu:amdgpu_sched_run_job" -e "drm:drm_vblank_event" \
>         -e "*fence:*fence_signaled" -e "amdgpu:amdgpu_ttm_bo_move" \
>         -e "sched:sched_switch" &
> 
> And then the capture is done with a kill -9 $(pidof trace-cmd)

Can you try with the equivalent 'perf record' (or perf trace) call?

[root@jouet ~]# perf record -m 16384 -e i915:intel_gpu_freq_change,drm:drm_vblank_event,fence*:*fence_signaled,sched:sched_switch^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.792 MB perf.data (2895 samples) ]

[root@jouet ~]#

It'll report lost events, replace the i915 with the amdgpu events.

- Arnaldo
 
> We've tried not capturing sched_switch events (which were about 75% of the
> events), but we are still seeing missing events such as the drm_vblank events
> (81 - 85) in the example below [1]. "trace-cmd report --stat" reports 0 dropped
> events, no overruns, etc.
> 
> I'm going to try and set up a repro case and debug what's going on, but before
> doing that I thought I would ask here since I've seen two places online mention
> dropped events [2,3] and was wondering if there was more information on this.
> Ie, is this expected behavior? Is it logged anywhere? Any way to mitigate?
> 
> Thanks much.
>  -Mike
> 
> [1] trace-cmd report trace.dat | grep drm_vblank_event
> ....
>  <idle>-0 [001] 537337.235498: drm_vblank_event: crtc=0 seq=31330580
>  <idle>-0 [001] 537337.302508: drm_vblank_event: crtc=0 seq=31330586
>  <idle>-0 [001] 537337.313674: drm_vblank_event: crtc=0 seq=31330587
>  <idle>-0 [001] 537337.324862: drm_vblank_event: crtc=0 seq=31330588
>  <idle>-0 [001] 537337.336011: drm_vblank_event: crtc=0 seq=31330589
>  <idle>-0 [001] 537337.347189: drm_vblank_event: crtc=0 seq=31330590
>  <idle>-0 [001] 537337.358352: drm_vblank_event: crtc=0 seq=31330591
>  <idle>-0 [001] 537337.369535: drm_vblank_event: crtc=0 seq=31330592
>  <idle>-0 [001] 537337.380688: drm_vblank_event: crtc=0 seq=31330593
> 
> 
> [2] https://www.mail-archive.com/linux-perf-users@vger.kernel.org/msg02326.html
> 
> > Actually one thing that came to mind that I would like to clarification about.
> > I know that tracepoints are “lossy” and that if the “reader” of the pipe is not
> > consuming fast enough and the ring buffers get full then tracepoint information
> > gets dropped and pipe logs that it lost events. When I run “perf record”, is it
> > also recording every tracepoint or is it sampling (which I don’t exactly
> > understand but I think of it as it just periodically captures the tracepoint
> > info which basically means it’s losing them intentionally)?
> 
> [3] http://codearcana.com/posts/2016/01/03/dtrace-isnt-just-a-tool-its-a-philosophy.html
> 
> > Unfortunately, tracing all scheduler events is very high overhead in perf and
> > the lack of in-kernel aggregation means that events probably will be dropped if
> > load is high.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
