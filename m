Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6A6229B18
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773800751; cv=pass; b=e2AKwl7Nmrbrbsr+EG5pW5f87XiXo4mfqH2v0fqkie70o51DuF7K6vpxbrREuQhalr9Pu3cNtwx8J/4er5I6AuVA7Z69RLpGoevbVBdFwkyTO2nj6BfJoT8yvvTeaz+z/C1fwr6XtfnhJbGaaYzu9uRd/xFA+ea6bR3V6bFBW0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773800751; c=relaxed/simple;
	bh=i9Xpzgwz2HfqIB8BsxC+cAUDFBQZWhL59WRBoty7yGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H12euXCIoPiX+7QlRWYJuUxxbMV2Fg8YdOXATxYs+9TsCFqkrHJRl3P7Bkba91yElGWKyxuG06loX6ZtDNEud1alxMWgm3CHoAyklGBO2KNflhzuN92gxl7IX6ZQBKtR89LFhu5UviGqEAx9laKIdkRI93YEXKS88H9et5GuHXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZyLEHEz; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZyLEHEz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so47415ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 19:25:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773800749; cv=none;
        d=google.com; s=arc-20240605;
        b=K4wrI4yMDmFI0XOw7ltQZAVd6RKpj9wsqJUWot2jWzly+46jBPT46q/3ABkX2MkcJh
         mx6gDDAfPB93rhIL3hhy9/ebkVuI/PK+r0XetjQFBoJ1+3WtXUslpUUZX96Z76COd3RZ
         SBWKvORxHDglyDJeTN9qa+/eVlgXel1ZCPJ4Z+ycJkqwFowUlNQRlOhcZ2xsgiNou/JM
         bpPopXxFu8x5WAPBVsHo8OIuFFyI7+M1tITcWqtSquQ7jcV5DPN/EhM6gBybCTlZLoXL
         TwUExW/Eap8BuBHj1F4xi3zgVPKLtxEEvalI9ZMR0KxIqMsH0Q7WFpy2A0q7YODxJu0i
         6oDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A6Owwde1eqXj0B+7IA8j78a/zoetjQzXm6vQ6ijp1Gc=;
        fh=gXynzRKNanQ8cX9QkfHy7tzgIbaupwwBtR7V/wHGQvA=;
        b=OuP5Xqg8QW+DQQ85k0au/1J+zYjhjMTr+wkTQXGU658SurhVBu/jsyLP/kpI/QNMbO
         bcdSc78fojIzYCTXh30fLdTymY+nzPGHrOaTRG3hs7OZdxus6F8TorAx8HYiwbx63NJL
         bEV+ugO0VzXWVqzVxYbI8D7wfVQZG0Sv4p3SDKW4l/TeM7bpn83yapGtfedDNoi9YDlu
         HGuOUyW2Qcs1NrY/UMKWzE3KdQ5vxgSCYLeoxnhItF8lnBY7KUpQpuZATZR5qv4WkSFZ
         3RL7QDcQsUEZSWDaH1QDLn2GRSsvJK+EvhaWIvPwyIYuEoqTiPlc+BBa7+rzuxXKpUDZ
         wyvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773800749; x=1774405549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6Owwde1eqXj0B+7IA8j78a/zoetjQzXm6vQ6ijp1Gc=;
        b=OZyLEHEzu4XDNV7acGPpMFmcu1OcgZcnLl0PHiHImPLt8VlkqnVl1FOdPzB4LegOoX
         ZkmGuTjdkUXIyPkmACq+vve5JYEKdLNoGLZSpxqygACoNnB0GaHjvnZhRZ8qbX6R0jCK
         Kb018WIhBxdcPz96pqIvKTsK8MsqQ5VytaTOn/tShoMIi28HTZPpfUhpDOn58JSdKbWM
         P8MtkECzxKtZGxe2BjmRaG9dK4r/545xRcix/2LsQMPUke5aO6WWRStIHitkF1yEqnhP
         VvOjvXPquZuzZvxzMMSKiCCuyD+AnNPizrOw8sctZuWseVcm1+3Ef08hENC4gUUuAFFo
         bMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773800749; x=1774405549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A6Owwde1eqXj0B+7IA8j78a/zoetjQzXm6vQ6ijp1Gc=;
        b=tOIOguq4u+d4xeIkQmrJOH8X7nOYEWIh/vCddCxjilMOHSuag9mbhDDbBH6fI3RYWY
         a9lITXBDMYUwa3Hg3F2yU5pJ7ECup/ZEyu3v7sFPCcUgdyk+YeKYPM3PjH4s2pPfubbb
         qQjghaEnxH6ENiIlZD7fm6vlwChsX2vhOmoNcOeb857Pm3Y257LT6SqeJ0lmpEmY3Xd0
         Ky2nIT6NPG2UlcwEqIa6gUBxC+Orwig7IMSb4+//QYywHmDGYfPfNgUI3bEeORY2xgH+
         l3ka3ZAI67LKUEFaAa30Mv+fRvWDQJqDMIpVgbWS8nHMGOJpUF2bq9mJTfo9KAweUIsH
         OKEg==
X-Forwarded-Encrypted: i=1; AJvYcCUDkoHcDRxdTZ2mHvvDv3DA/hrIX6i++jsuW6bpYkygljPS2dYSMAh8gS6U8J1Q++/9kiEcftBTfB6uEsg3zJBk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt78o2BoMw4qbSfjYSEunx8rmjc8qt34HIr/5YAPcKI9I/yqX7
	314VQKkGIQoG1iJAuLns+fSW6eYFox24wnJl6259qEGUMzbnJ6ri4yQcvMMIbutnxisyoKgdlq5
	dqn3SYGkahYnWICgsxvlEFw24UhkgJmctgifgVME6
X-Gm-Gg: ATEYQzzpyvIv+Xd8NZKfyM9Q/f6L+fVN9o6IJnT7jgguaC5xcfsKNJyc77mnDudI3gU
	gMbYmY5gVcFOoxyHtRk7DKsseOmKvwI1ctG93CFfS2pWhdI3wiITFnqvMsx94j75QNGOH3D1RzM
	WnyNzq3uddAFASJARb09WbqBdWPIrjO8sAU+WlHvX0UA/7+6la19BWJhqSci1Re81/xuTYrYXUZ
	8BM+r4VVKtQ1GGuQ81KqKqwMoSK0kuamYwK0JJseUoAdMRVjyMvZULJfKNN3GMtqNBnt6oX/K+i
	y/fuPYd3v1sI1fi7NiI=
X-Received: by 2002:a17:903:2f84:b0:2b0:5ba3:2416 with SMTP id
 d9443c01a7336-2b06f851d75mr1114175ad.7.1773800748009; Tue, 17 Mar 2026
 19:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>
 <abQq79_ajs8zFeEI@x1> <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com>
 <abmt6FhLfWrzWGwU@x1> <abmyA5q9nXjagJIL@x1> <abm1nR-2xjOUBroD@x1>
 <CAP-5=fU76bLLgorJJ0CVXwTanaZTbjtV=EWA2evy8UjGE8Sw4Q@mail.gmail.com> <abnz0pxixB7L7-7R@x1>
In-Reply-To: <abnz0pxixB7L7-7R@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Mar 2026 19:25:36 -0700
X-Gm-Features: AaiRm522jfMhi2UPT7YyIqkr4scE7_w6zLMcomDwrDJVnuTpTIPArg_XlFq_M5U
Message-ID: <CAP-5=fWmDYmyt5JGfVH77zjA6828Ocu7JP-B02=iifp+J_=9Tw@mail.gmail.com>
Subject: Re: perf stat issue with 7.0.0rc3
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	Jan Polensky <japo@linux.ibm.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 5:37=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Mar 17, 2026 at 01:50:21PM -0700, Ian Rogers wrote:
> > On Tue, Mar 17, 2026 at 1:12=E2=80=AFPM Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:
> > > On Tue, Mar 17, 2026 at 04:56:51PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > It is not trying PERF_COUNT_HW_STALLED_CYCLES_FRONTEND, is asking f=
or
> > > > PERF_COUNT_HW_STALLED_CYCLES_BACKEND instead...
>
> > > If I instead ask just for stalled-cycles-frontend and
> > > stalled-cycles-backend:
>
> > > root@number:~# strace -e perf_event_open perf stat -e stalled-cycles-=
frontend,stalled-cycles-backend sleep 1
>
> > I think you intend for this to be system wide '-a'.
>
> > > perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, co=
nfig=3D0xa9, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_=
format=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, dis=
abled=3D1, inherit=3D1, enable_on_exec=3D1, precise_ip=3D0 /* arbitrary ski=
d */, ...}, 250619, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D 3
> > > perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3DPERF_ATTR_SIZE_VER=
9, config=3DPERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=3D0, sample=
_type=3DPERF_SAMPLE_IDENTIFIER, read_format=3DPERF_FORMAT_TOTAL_TIME_ENABLE=
D|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=3D1, inherit=3D1, enable_on_exec=
=3D1, precise_ip=3D0 /* arbitrary skid */, ...}, 250619, -1, -1, PERF_FLAG_=
FD_CLOEXEC) =3D -1 ENOENT (No such file or directory)
> > > --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D25061=
9, si_uid=3D0, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
> > >
> > >  Performance counter stats for 'sleep 1':
> > >
> > >            409,276      stalled-cycles-frontend
> > >    <not supported>      stalled-cycles-backend
> > >
> > >        1.000428804 seconds time elapsed
> > >
> > >        0.000439000 seconds user
> > >        0.000000000 seconds sys
> > >
> > >
> > > --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DSI_USER, si_pid=3D250618, =
si_uid=3D0} ---
> > > +++ exited with 0 +++
> > > root@number:~#
> > >
> > > It used type=3DPERF_TYPE_RAW, config=3D0xa9 for  stalled-cycles-front=
end but
> > > type=3DPERF_TYPE_HARDWARE, config=3DPERF_COUNT_HW_STALLED_CYCLES_BACK=
END.
> > >
> > > =E2=AC=A2 [acme@toolbx perf-tools]$ git grep stalled-cycles-frontend =
tools
> > > tools/bpf/bpftool/link.c:       [PERF_COUNT_HW_STALLED_CYCLES_FRONTEN=
D] =3D "stalled-cycles-frontend",
> > > tools/perf/builtin-stat.c:     3,856,436,920 stalled-cycles-frontend =
  #   74.09% frontend cycles idle
> > > tools/perf/pmu-events/arch/common/common/legacy-hardware.json:    "Ev=
entName": "stalled-cycles-frontend",
> > > tools/perf/pmu-events/empty-pmu-events.c:/* offset=3D122795 */ "stall=
ed-cycles-frontend\000legacy hardware\000Stalled cycles during issue [This =
event is an alias of idle-cycles-frontend]\000legacy-hardware-config=3D7\00=
0\00000\000\000\000\000\000"
> > > tools/perf/pmu-events/empty-pmu-events.c:/* offset=3D122945 */ "idle-=
cycles-frontend\000legacy hardware\000Stalled cycles during issue [This eve=
nt is an alias of stalled-cycles-frontend]\000legacy-hardware-config=3D7\00=
0\00000\000\000\000\000\000"
> > > tools/perf/pmu-events/empty-pmu-events.c:{ 122795 }, /* stalled-cycle=
s-frontend\000legacy hardware\000Stalled cycles during issue [This event is=
 an alias of idle-cycles-frontend]\000legacy-hardware-config=3D7\000\00000\=
000\000\000\000\000 */
> > > tools/perf/tests/shell/stat+std_output.sh:event_name=3D(cpu-clock tas=
k-clock context-switches cpu-migrations page-faults stalled-cycles-frontend=
 stalled-cycles-backend cycles instructions branches branch-misses)
> > > tools/perf/util/evsel.c:        "stalled-cycles-frontend",
> > > =E2=AC=A2 [acme@toolbx perf-tools]$
> > >
> > > This machine is:
> > >
> > > =E2=AC=A2 [acme@toolbx perf-tools]$ grep -m1 "model name" /proc/cpuin=
fo
> > > model name      : AMD Ryzen 9 9950X3D 16-Core Processor
> >
> > Lots of missing legacy events on AMD. The problem is worse with -dd and=
 -ddd.
> >
> > > =E2=AC=A2 [acme@toolbx perf-tools]
> > >
> > > And doesn't have PERF_COUNT_HW_STALLED_CYCLES_BACKEND, but has
> > > PERF_COUNT_HW_STALLED_CYCLES_FRONTEND, that gets configured using
> > > PERF_TYPE_RAW and 0xa9 because:
> > >
> > > root@number:~# cat /sys/devices/cpu/events/stalled-cycles-frontend
> > > event=3D0xa9
> > > root@number:~#
> > >
> > > But I couldn't so far explain why in the default case it is asking fo=
r
> > > PERF_COUNT_HW_STALLED_CYCLES_BACKEND, when it should be asking for
> > > PERF_COUNT_HW_STALLED_CYCLES_FRONTEND or PERF_TYPE_RAW+config=3D0xa9.=
..
>
> So you mean that it goes on to try this:
>
>   {
>         "BriefDescription": "Max front or backend stalls per instruction"=
,
>         "MetricExpr": "max(stalled\\-cycles\\-frontend, stalled\\-cycles\=
\-backend) / instructions",
>         "MetricGroup": "Default",
>         "MetricName": "stalled_cycles_per_instruction",
>         "DefaultShowEvents": "1"
>     },
>
> Yeah, it tries both:
>
> perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, config=
=3D0xa9, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_form=
at=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FOR=
MAT_ID|PERF_FORMAT_GROUP, inherit=3D1, precise_ip=3D0 /* arbitrary skid */,=
 ...}, 865157, -1, 14, PERF_FLAG_FD_CLOEXEC) =3D 15
> perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, config=
=3D0x76, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_form=
at=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FOR=
MAT_ID|PERF_FORMAT_GROUP, disabled=3D1, inherit=3D1, enable_on_exec=3D1, pr=
ecise_ip=3D0 /* arbitrary skid */, ...}, 865157, -1, -1, PERF_FLAG_FD_CLOEX=
EC) =3D 16
> perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3DPERF_ATTR_SIZE_VER9, c=
onfig=3DPERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=3D0, sample_typ=
e=3DPERF_SAMPLE_IDENTIFIER, read_format=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PE=
RF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, inherit=3D1,=
 precise_ip=3D0 /* arbitrary skid */, ...}, 865157, -1, 16, PERF_FLAG_FD_CL=
OEXEC) =3D -1 ENOENT (No such file or directory)

perf trace? The formatting on perf_event_open is better :-)

> The RAW one is the equivalent to PERF_COUNT_HW_STALLED_CYCLES_FRONTEND,
> I see now that I looked again at the 'strace perf stat sleep 1'
>
> But in the output it also says:
>
>      <not counted>      stalled-cycles-frontend          #      nan front=
end_cycles_idle        (0.00%)
>
> And if I try just this one:
>
> root@number:~# strace -e perf_event_open perf stat -e stalled-cycles-fron=
tend sleep 1
> perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, config=
=3D0xa9, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_form=
at=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disable=
d=3D1, inherit=3D1, enable_on_exec=3D1, precise_ip=3D0 /* arbitrary skid */=
, ...}, 865273, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D 3
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D865273, s=
i_uid=3D0, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
>
>  Performance counter stats for 'sleep 1':
>
>            422,404      stalled-cycles-frontend
>
>        1.000432524 seconds time elapsed
>
>        0.000438000 seconds user
>        0.000000000 seconds sys
>
>
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DSI_USER, si_pid=3D865272, si_u=
id=3D0} ---
> +++ exited with 0 +++
> root@number:~#
>
> It works, so that line with stalled-cycles-frontend could have produced
> the value, not '<not counted>', as this call succeeded:
>
> perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, config=
=3D0xa9, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_form=
at=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FOR=
MAT_ID|PERF_FORMAT_GROUP, inherit=3D1, precise_ip=3D0 /* arbitrary skid */,=
 ...}, 865157, -1, 14, PERF_FLAG_FD_CLOEXEC) =3D 15
> perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, config=
=3D0x76, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_form=
at=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FOR=
MAT_ID|PERF_FORMAT_GROUP, disabled=3D1, inherit=3D1, enable_on_exec=3D1, pr=
ecise_ip=3D0 /* arbitrary skid */, ...}, 865157, -1, -1, PERF_FLAG_FD_CLOEX=
EC) =3D 16
>
> Maybe the explanation is that it tries the metric, that uses both
> frontend and backend, it fails at backend and then it discards the
> frontend?

The metric logic tries to be smart, creating groups of events and then
sharing events between groups to avoid programming more events. I
suspect the frontend and backend are in a group, maybe the backend is
the leader. The backend fails to open, resulting in no group_fd and a
broken group for both the metrics.

> > So the default events/metrics are now in json:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/pmu-events/arch/common/common/metrics.json?h=3Dperf-t=
ools-next
> > Relating to the stalls there are:
> > ```
> >     {
> >         "BriefDescription": "Max front or backend stalls per instructio=
n",
> >         "MetricExpr": "max(stalled\\-cycles\\-frontend,
> > stalled\\-cycles\\-backend) / instructions",
> >         "MetricGroup": "Default",
> >         "MetricName": "stalled_cycles_per_instruction",
> >         "DefaultShowEvents": "1"
> >     },
>
> root@number:~# strace -e perf_event_open perf stat -M stalled_cycles_per_=
instruction sleep 1
> perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3DPERF_ATTR_SIZE_VER9, c=
onfig=3DPERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=3D0, sample_typ=
e=3DPERF_SAMPLE_IDENTIFIER, read_format=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PE=
RF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, disabled=3D1=
, inherit=3D1, enable_on_exec=3D1, precise_ip=3D0 /* arbitrary skid */, ...=
}, 865362, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D -1 ENOENT (No such file or dir=
ectory)
> Error:
> No supported events found.
> The stalled-cycles-backend event is not supported.
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_KILLED, si_pid=3D865362, s=
i_uid=3D0, si_status=3DSIGTERM, si_utime=3D0, si_stime=3D0} ---
> +++ exited with 1 +++
> root@number:~#
>
> >     {
> >         "BriefDescription": "Frontend stalls per cycle",
> >         "MetricExpr": "stalled\\-cycles\\-frontend / cpu\\-cycles",
> >         "MetricGroup": "Default",
> >         "MetricName": "frontend_cycles_idle",
> >         "MetricThreshold": "frontend_cycles_idle > 0.1",
> >         "DefaultShowEvents": "1"
> >     },
>
> root@number:~# strace -e perf_event_open perf stat -M frontend_cycles_idl=
e sleep 1
> perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, config=
=3D0x76, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_form=
at=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FOR=
MAT_ID|PERF_FORMAT_GROUP, disabled=3D1, inherit=3D1, enable_on_exec=3D1, pr=
ecise_ip=3D0 /* arbitrary skid */, ...}, 865414, -1, -1, PERF_FLAG_FD_CLOEX=
EC) =3D 3
> perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, config=
=3D0xa9, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_form=
at=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FOR=
MAT_ID|PERF_FORMAT_GROUP, inherit=3D1, precise_ip=3D0 /* arbitrary skid */,=
 ...}, 865414, -1, 3, PERF_FLAG_FD_CLOEXEC) =3D 4
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D865414, s=
i_uid=3D0, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
>
>  Performance counter stats for 'sleep 1':
>
>            881,022      cpu-cycles                       #     0.48 front=
end_cycles_idle
>            422,386      stalled-cycles-frontend
>
>        1.000468505 seconds time elapsed
>
>        0.000504000 seconds user
>        0.000000000 seconds sys
>
>
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DSI_USER, si_pid=3D865413, si_u=
id=3D0} ---
> +++ exited with 0 +++
> root@number:~#
> >     {
> >         "BriefDescription": "Backend stalls per cycle",
> >         "MetricExpr": "stalled\\-cycles\\-backend / cpu\\-cycles",
> >         "MetricGroup": "Default",
> >         "MetricName": "backend_cycles_idle",
> >         "MetricThreshold": "backend_cycles_idle > 0.2",
> >         "DefaultShowEvents": "1"
> >     },
>
> root@number:~# strace -e perf_event_open perf stat -M backend_cycles_idle=
 sleep 1
> perf_event_open({type=3DPERF_TYPE_RAW, size=3DPERF_ATTR_SIZE_VER9, config=
=3D0x76, sample_period=3D0, sample_type=3DPERF_SAMPLE_IDENTIFIER, read_form=
at=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FOR=
MAT_ID|PERF_FORMAT_GROUP, disabled=3D1, inherit=3D1, enable_on_exec=3D1, pr=
ecise_ip=3D0 /* arbitrary skid */, ...}, 865442, -1, -1, PERF_FLAG_FD_CLOEX=
EC) =3D 3
> perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3DPERF_ATTR_SIZE_VER9, c=
onfig=3DPERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=3D0, sample_typ=
e=3DPERF_SAMPLE_IDENTIFIER, read_format=3DPERF_FORMAT_TOTAL_TIME_ENABLED|PE=
RF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, inherit=3D1,=
 precise_ip=3D0 /* arbitrary skid */, ...}, 865442, -1, 3, PERF_FLAG_FD_CLO=
EXEC) =3D -1 ENOENT (No such file or directory)
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D865442, s=
i_uid=3D0, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
>
>  Performance counter stats for 'sleep 1':
>
>      <not counted>      cpu-cycles                       #      nan backe=
nd_cycles_idle
>    <not supported>      stalled-cycles-backend
>
>        1.000739264 seconds time elapsed
>
>        0.000675000 seconds user
>        0.000000000 seconds sys
>
>
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DSI_USER, si_pid=3D865441, si_u=
id=3D0} ---
> +++ exited with 0 +++
> root@number:~#
>
> > ```
> > The stalled_cycles_per_instruction and backed_cycles_idle should fail
> > as the stalled-cycles-backend event is missing. frontend_cycles_idle
> > should work, I wonder if the 0 counts relate to trouble scheduling
> > groups of events. I'll need more verbose output to understand. Perhaps
> > for stalled_cycles_per_instruction, we should modify the metric to
> > tolerate missing events:
> >
> > max(stalled\\-cycles\\-frontend if
> > have_event(stalled\\-cycles\\-frontend) else 0,
> > stalled\\-cycles\\-backend if have_event(stalled\\-cycles\\-backend)
> > else 0) / instructions
>
> That have_event() part also have to be implemented, right?

I mistyped, has_event not have_event :-)

Thanks,
Ian

> - Arnaldo
