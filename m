Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085D1FC7FB;
	Wed, 18 Mar 2026 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773794261; cv=none; b=QZAhzCSB5PWvA23cye35mHofDJb+Of0PYhEdOlsFpBmg6wv1Hq+Fiib4Z2RfbcdwvjAgacml0XxcAYEWaiaS0WiJr6XdNm2Yzx7d5PfxrGxg6DyagJ77QCflrUGc1/+31ZDBfnacykQMohYX+FBDzBs6j+n40mfd/NTKYyVwZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773794261; c=relaxed/simple;
	bh=6eE0tl1IYoHM5BM6Gjv2NdoaSv2Px1aou1U8LJbJRg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhQFCqorhVhRM9MjLJMy/Q9oregYM+plS19XdlhXh1aRd3hySHe01MxZBGhnlzFt4CNpuUj/inDb1Z7/d+z2Ddf8Eip7fOFLEhm6be4hAujC+Jb16/apOvwZk3U4qGAp5T+0tXH6OACZmF74dLe2slkTwaaR7XnihU3LDu4mfR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElJqwrCk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElJqwrCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05576C4CEF7;
	Wed, 18 Mar 2026 00:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773794261;
	bh=6eE0tl1IYoHM5BM6Gjv2NdoaSv2Px1aou1U8LJbJRg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElJqwrCkgB8lPWBehLUqsGhbHeZ3EobiSEkOKexG78hg6TU3BJ6G2sSwGvFxsoOn2
	 e3llpp4r8v85cSTa6j474Crn8yUa2DbFBdOp0IgJ7KoTJzzYB8qfyk+pP6J096CegT
	 FX7ACoqLBDoBb7T4GPvr/gtZk5hgU84g//3mKF1kDZXyu9WWuFlY1SQorWDiG9HNQl
	 FGZeMQ6r6pBzegycaO2dt6XKAFGJ0wJULaQp+jVlXByymgrkNkWOVJyG9jLanwdYxu
	 0u7cIi57IuTmCbVvoaR/wvhpuXBaLRMqCLbjQxvtTGeW6kGpWi0M/HkzvU6QVVQg1n
	 3YpuIX7WQriUQ==
Date: Tue, 17 Mar 2026 21:37:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, Jan Polensky <japo@linux.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf stat issue with 7.0.0rc3
Message-ID: <abnz0pxixB7L7-7R@x1>
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>
 <abQq79_ajs8zFeEI@x1>
 <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com>
 <abmt6FhLfWrzWGwU@x1>
 <abmyA5q9nXjagJIL@x1>
 <abm1nR-2xjOUBroD@x1>
 <CAP-5=fU76bLLgorJJ0CVXwTanaZTbjtV=EWA2evy8UjGE8Sw4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU76bLLgorJJ0CVXwTanaZTbjtV=EWA2evy8UjGE8Sw4Q@mail.gmail.com>

On Tue, Mar 17, 2026 at 01:50:21PM -0700, Ian Rogers wrote:
> On Tue, Mar 17, 2026 at 1:12 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Tue, Mar 17, 2026 at 04:56:51PM -0300, Arnaldo Carvalho de Melo wrote:
> > > It is not trying PERF_COUNT_HW_STALLED_CYCLES_FRONTEND, is asking for
> > > PERF_COUNT_HW_STALLED_CYCLES_BACKEND instead...

> > If I instead ask just for stalled-cycles-frontend and
> > stalled-cycles-backend:

> > root@number:~# strace -e perf_event_open perf stat -e stalled-cycles-frontend,stalled-cycles-backend sleep 1

> I think you intend for this to be system wide '-a'.

> > perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0xa9, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 250619, -1, -1, PERF_FLAG_FD_CLOEXEC) = 3
> > perf_event_open({type=PERF_TYPE_HARDWARE, size=PERF_ATTR_SIZE_VER9, config=PERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 250619, -1, -1, PERF_FLAG_FD_CLOEXEC) = -1 ENOENT (No such file or directory)
> > --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=250619, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
> >
> >  Performance counter stats for 'sleep 1':
> >
> >            409,276      stalled-cycles-frontend
> >    <not supported>      stalled-cycles-backend
> >
> >        1.000428804 seconds time elapsed
> >
> >        0.000439000 seconds user
> >        0.000000000 seconds sys
> >
> >
> > --- SIGCHLD {si_signo=SIGCHLD, si_code=SI_USER, si_pid=250618, si_uid=0} ---
> > +++ exited with 0 +++
> > root@number:~#
> >
> > It used type=PERF_TYPE_RAW, config=0xa9 for  stalled-cycles-frontend but
> > type=PERF_TYPE_HARDWARE, config=PERF_COUNT_HW_STALLED_CYCLES_BACKEND.
> >
> > ⬢ [acme@toolbx perf-tools]$ git grep stalled-cycles-frontend tools
> > tools/bpf/bpftool/link.c:       [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = "stalled-cycles-frontend",
> > tools/perf/builtin-stat.c:     3,856,436,920 stalled-cycles-frontend   #   74.09% frontend cycles idle
> > tools/perf/pmu-events/arch/common/common/legacy-hardware.json:    "EventName": "stalled-cycles-frontend",
> > tools/perf/pmu-events/empty-pmu-events.c:/* offset=122795 */ "stalled-cycles-frontend\000legacy hardware\000Stalled cycles during issue [This event is an alias of idle-cycles-frontend]\000legacy-hardware-config=7\000\00000\000\000\000\000\000"
> > tools/perf/pmu-events/empty-pmu-events.c:/* offset=122945 */ "idle-cycles-frontend\000legacy hardware\000Stalled cycles during issue [This event is an alias of stalled-cycles-frontend]\000legacy-hardware-config=7\000\00000\000\000\000\000\000"
> > tools/perf/pmu-events/empty-pmu-events.c:{ 122795 }, /* stalled-cycles-frontend\000legacy hardware\000Stalled cycles during issue [This event is an alias of idle-cycles-frontend]\000legacy-hardware-config=7\000\00000\000\000\000\000\000 */
> > tools/perf/tests/shell/stat+std_output.sh:event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
> > tools/perf/util/evsel.c:        "stalled-cycles-frontend",
> > ⬢ [acme@toolbx perf-tools]$
> >
> > This machine is:
> >
> > ⬢ [acme@toolbx perf-tools]$ grep -m1 "model name" /proc/cpuinfo
> > model name      : AMD Ryzen 9 9950X3D 16-Core Processor
> 
> Lots of missing legacy events on AMD. The problem is worse with -dd and -ddd.
> 
> > ⬢ [acme@toolbx perf-tools]
> >
> > And doesn't have PERF_COUNT_HW_STALLED_CYCLES_BACKEND, but has
> > PERF_COUNT_HW_STALLED_CYCLES_FRONTEND, that gets configured using
> > PERF_TYPE_RAW and 0xa9 because:
> >
> > root@number:~# cat /sys/devices/cpu/events/stalled-cycles-frontend
> > event=0xa9
> > root@number:~#
> >
> > But I couldn't so far explain why in the default case it is asking for
> > PERF_COUNT_HW_STALLED_CYCLES_BACKEND, when it should be asking for
> > PERF_COUNT_HW_STALLED_CYCLES_FRONTEND or PERF_TYPE_RAW+config=0xa9...

So you mean that it goes on to try this:

  {
        "BriefDescription": "Max front or backend stalls per instruction",
        "MetricExpr": "max(stalled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions",
        "MetricGroup": "Default",
        "MetricName": "stalled_cycles_per_instruction",
        "DefaultShowEvents": "1"
    },

Yeah, it tries both:

perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0xa9, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, inherit=1, precise_ip=0 /* arbitrary skid */, ...}, 865157, -1, 14, PERF_FLAG_FD_CLOEXEC) = 15
perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0x76, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 865157, -1, -1, PERF_FLAG_FD_CLOEXEC) = 16
perf_event_open({type=PERF_TYPE_HARDWARE, size=PERF_ATTR_SIZE_VER9, config=PERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, inherit=1, precise_ip=0 /* arbitrary skid */, ...}, 865157, -1, 16, PERF_FLAG_FD_CLOEXEC) = -1 ENOENT (No such file or directory)

The RAW one is the equivalent to PERF_COUNT_HW_STALLED_CYCLES_FRONTEND,
I see now that I looked again at the 'strace perf stat sleep 1'

But in the output it also says:

     <not counted>      stalled-cycles-frontend          #      nan frontend_cycles_idle        (0.00%)

And if I try just this one:

root@number:~# strace -e perf_event_open perf stat -e stalled-cycles-frontend sleep 1
perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0xa9, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 865273, -1, -1, PERF_FLAG_FD_CLOEXEC) = 3
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=865273, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---

 Performance counter stats for 'sleep 1':

           422,404      stalled-cycles-frontend

       1.000432524 seconds time elapsed

       0.000438000 seconds user
       0.000000000 seconds sys


--- SIGCHLD {si_signo=SIGCHLD, si_code=SI_USER, si_pid=865272, si_uid=0} ---
+++ exited with 0 +++
root@number:~#

It works, so that line with stalled-cycles-frontend could have produced
the value, not '<not counted>', as this call succeeded:

perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0xa9, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, inherit=1, precise_ip=0 /* arbitrary skid */, ...}, 865157, -1, 14, PERF_FLAG_FD_CLOEXEC) = 15
perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0x76, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 865157, -1, -1, PERF_FLAG_FD_CLOEXEC) = 16

Maybe the explanation is that it tries the metric, that uses both
frontend and backend, it fails at backend and then it discards the
frontend?

 
> So the default events/metrics are now in json:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/common/common/metrics.json?h=perf-tools-next
> Relating to the stalls there are:
> ```
>     {
>         "BriefDescription": "Max front or backend stalls per instruction",
>         "MetricExpr": "max(stalled\\-cycles\\-frontend,
> stalled\\-cycles\\-backend) / instructions",
>         "MetricGroup": "Default",
>         "MetricName": "stalled_cycles_per_instruction",
>         "DefaultShowEvents": "1"
>     },

root@number:~# strace -e perf_event_open perf stat -M stalled_cycles_per_instruction sleep 1
perf_event_open({type=PERF_TYPE_HARDWARE, size=PERF_ATTR_SIZE_VER9, config=PERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 865362, -1, -1, PERF_FLAG_FD_CLOEXEC) = -1 ENOENT (No such file or directory)
Error:
No supported events found.
The stalled-cycles-backend event is not supported.
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_KILLED, si_pid=865362, si_uid=0, si_status=SIGTERM, si_utime=0, si_stime=0} ---
+++ exited with 1 +++
root@number:~#

>     {
>         "BriefDescription": "Frontend stalls per cycle",
>         "MetricExpr": "stalled\\-cycles\\-frontend / cpu\\-cycles",
>         "MetricGroup": "Default",
>         "MetricName": "frontend_cycles_idle",
>         "MetricThreshold": "frontend_cycles_idle > 0.1",
>         "DefaultShowEvents": "1"
>     },

root@number:~# strace -e perf_event_open perf stat -M frontend_cycles_idle sleep 1
perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0x76, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 865414, -1, -1, PERF_FLAG_FD_CLOEXEC) = 3
perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0xa9, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, inherit=1, precise_ip=0 /* arbitrary skid */, ...}, 865414, -1, 3, PERF_FLAG_FD_CLOEXEC) = 4
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=865414, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---

 Performance counter stats for 'sleep 1':

           881,022      cpu-cycles                       #     0.48 frontend_cycles_idle
           422,386      stalled-cycles-frontend

       1.000468505 seconds time elapsed

       0.000504000 seconds user
       0.000000000 seconds sys


--- SIGCHLD {si_signo=SIGCHLD, si_code=SI_USER, si_pid=865413, si_uid=0} ---
+++ exited with 0 +++
root@number:~#
>     {
>         "BriefDescription": "Backend stalls per cycle",
>         "MetricExpr": "stalled\\-cycles\\-backend / cpu\\-cycles",
>         "MetricGroup": "Default",
>         "MetricName": "backend_cycles_idle",
>         "MetricThreshold": "backend_cycles_idle > 0.2",
>         "DefaultShowEvents": "1"
>     },

root@number:~# strace -e perf_event_open perf stat -M backend_cycles_idle sleep 1
perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0x76, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 865442, -1, -1, PERF_FLAG_FD_CLOEXEC) = 3
perf_event_open({type=PERF_TYPE_HARDWARE, size=PERF_ATTR_SIZE_VER9, config=PERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, inherit=1, precise_ip=0 /* arbitrary skid */, ...}, 865442, -1, 3, PERF_FLAG_FD_CLOEXEC) = -1 ENOENT (No such file or directory)
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=865442, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---

 Performance counter stats for 'sleep 1':

     <not counted>      cpu-cycles                       #      nan backend_cycles_idle       
   <not supported>      stalled-cycles-backend                                                

       1.000739264 seconds time elapsed

       0.000675000 seconds user
       0.000000000 seconds sys


--- SIGCHLD {si_signo=SIGCHLD, si_code=SI_USER, si_pid=865441, si_uid=0} ---
+++ exited with 0 +++
root@number:~#

> ```
> The stalled_cycles_per_instruction and backed_cycles_idle should fail
> as the stalled-cycles-backend event is missing. frontend_cycles_idle
> should work, I wonder if the 0 counts relate to trouble scheduling
> groups of events. I'll need more verbose output to understand. Perhaps
> for stalled_cycles_per_instruction, we should modify the metric to
> tolerate missing events:
> 
> max(stalled\\-cycles\\-frontend if
> have_event(stalled\\-cycles\\-frontend) else 0,
> stalled\\-cycles\\-backend if have_event(stalled\\-cycles\\-backend)
> else 0) / instructions

That have_event() part also have to be implemented, right?

- Arnaldo
