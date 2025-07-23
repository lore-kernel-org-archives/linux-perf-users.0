Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092522586DA
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753306416; cv=none; b=D+d+C0AXzvny+Ph9a9ZRi3jvLTFtFwd1cEjbseF+mdM4VvZRwWApYp6nWvC8eb1kY4AWVGPLSsm/1XXxlDvFLaKQEPPP1kitSJR2IRVO3ockbr1Zb1Tq+E/AH+icnxQxRJXA3IhwI7B4+k05hh3dlpQq4wXZXmP/bxbDUd8SuH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753306416; c=relaxed/simple;
	bh=giS4PhgAHowRACp0iAQv2s7oG1TP1moHPfASTvmUoSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCYcOByAUC9uLlwJbqJI+5z7mdOxsOek4Kvglhb7SSOcdg/HKYYOMB+/poymnklNqpPAYH2e8oY00S4NlPPtnI+m+fVpOHQNZidODgqS4oK2ARywBCzGtc5PikJTguQTTWTwcdqaZuUxbJ8STr9jwk7DtDdeXcBp2ksR1fAe3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F5zu/qie; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F5zu/qie"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so15385ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 14:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753306412; x=1753911212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2l1TvtYU06DO48M9oNAGeqm7CbRPUb25mVR46EGpM0c=;
        b=F5zu/qiewuQ1vTOgOCEi/iU6FgNfHfW0oZeqwJaXhY0aB+WT37ToJ/4fffRO1EBRU+
         Dhy7jB7ZWv72e1kTUoYgbRGged4/XVvklvjmCkVnjoC0UtECUhXa7UXXDELaQMsIb8jy
         PMqIMrc0Qv4Y3Ib8KxJvmNDi1V3Xl3TJCT+5ua5KP0MZyMy8sitUhZJotV5r9346b7mD
         fT3JRQbj9q0wJy1xpdlWX7qlExLSpBbEX5ChL/t+c34YyJk0M5889gZ6oj9Zu+f6LP5f
         /A2N795K6BzOwgaQvp4/24h0ziZlI5e9Y3GAmqrsCb/6QjDP90k7RN42ehfFeRjsvMYD
         EKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753306412; x=1753911212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2l1TvtYU06DO48M9oNAGeqm7CbRPUb25mVR46EGpM0c=;
        b=esx5p0qHFfSxQhbyKfZDpR7ryDJwawUc/EhoOeshhgGqr3CPCyU48B25Dqyki900Mx
         kTE4YaBVq3yhRk9pzAijzFqJPL2nyZXNGc6q+fXL5szovWmA0ACEGDTnheA/ZVoH4Hz8
         G9cXRBg6oxltqwienwQXyvM4IEPcfBBjj5zJUflAzhjpayIyeGhI/A5G3i6FkX1kqdVi
         BT6Q2K+wim6OfLpw/bjJSGb7vqKLHh7iAk346D+ciHJjTJp1KTQDr4937y+FTxoPsO+T
         xd+wn02e+4oHT21ggtg5JCY6UQ2qbn/mM1gLXjaK7MDaZ8MdKtk1DWD4pCW4ljPTj5Bn
         XfMw==
X-Forwarded-Encrypted: i=1; AJvYcCWdowXzI97MQwK6V8jf59bnw8bbohceHu+z3Iug16yWEH3RvH3GRt9G9c7kBMNTiPIui0f/ACK6fMIuOR0rE0QB@vger.kernel.org
X-Gm-Message-State: AOJu0YyzYWTiDPE8UUWdCImuiyRExFYayAGlasq4Pzbc9YI+vgz8ldIW
	ubSZgv0hsmseVRn7JAMtVpTHwnKHGrRs81p8s6R0revo7hGqT3P5AbSuEu+7Z/r3b1/KbBXlG1x
	oy1pSguB+sxnuWnrIQm8KfH4kPkbWwe6Esodvp8B6
X-Gm-Gg: ASbGncuOCx8oo1MaApWYXcjmU7p5ILjavflTXMqvDDjROzeihvM7io9b2dey1Wb3A3+
	Ajr/w4+em9kcUfz/PqFi7pj/wsjI9mkCzXZJBAmY+rZyigBlAeLI1Qer6LXGbvgXKC028hKpYTo
	WTqoz7xtV0f4Ayi56Vp+lso51pCRXeY3jUNu4nUrWxPyp/CF+D47WpL8ZDP3ocITTzaNwdO0MZ3
	vrXr6BaYU5sx3CADdS0txrGtSSG0A7nag/bk6S8MVZvdCo=
X-Google-Smtp-Source: AGHT+IHboYtQXjS0l9l2eeZw4V4NPWUdJyvH73iBU6KOOIahIsryDG4w11+MdEnLw1e6AUlWsW6H12RjMOjXxUlJT20=
X-Received: by 2002:a05:6e02:170a:b0:3e0:5511:9796 with SMTP id
 e9e14a558f8ab-3e3b7328ac6mr316165ab.1.1753306411619; Wed, 23 Jul 2025
 14:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com> <20250714164405.111477-12-irogers@google.com>
 <66fd717b870b63ec703b4bf0bbcc50a6d0742c30.camel@intel.com>
In-Reply-To: <66fd717b870b63ec703b4bf0bbcc50a6d0742c30.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Jul 2025 14:33:20 -0700
X-Gm-Features: Ac12FXwv-_8wU8X10St6rrGy9T61TOJxJK17E_R-NBsu01kZIPmOulTOm1Q0KOA
Message-ID: <CAP-5=fWBMRTg+rcRVZRNZA5MirZrQ+_kgYWwAvNQ3EZJBkdeNA@mail.gmail.com>
Subject: Re: [PATCH v7 11/16] perf ilist: Add new python ilist command
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>, 
	"xu.yang_2@nxp.com" <xu.yang_2@nxp.com>, "howardchu95@gmail.com" <howardchu95@gmail.com>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, "ak@linux.intel.com" <ak@linux.intel.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "gautam@linux.ibm.com" <gautam@linux.ibm.com>, 
	"ctshao@google.com" <ctshao@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"james.clark@linaro.org" <james.clark@linaro.org>, "collin.funk1@gmail.com" <collin.funk1@gmail.com>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"linux@treblig.org" <linux@treblig.org>, "Wang, Weilin" <weilin.wang@intel.com>, 
	"yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>, "acme@kernel.org" <acme@kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"namhyung@kernel.org" <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 11:33=E2=80=AFAM Falcon, Thomas <thomas.falcon@inte=
l.com> wrote:
>
> On Mon, 2025-07-14 at 09:43 -0700, Ian Rogers wrote:
> > The perf ilist command is a textual app [1] similar to perf list. In
> > the top-left pane a tree of PMUs is displayed. Selecting a PMU expands
> > the events within it. Selecting an event displays the `perf list`
> > style event information in the top-right pane.
> >
> > When an event is selected it is opened and the counters on each CPU
> > the event is for are periodically read. The bottom of the screen
> > contains a scrollable set of sparklines showing the events in total
> > and on each CPU. Scrolling below the sparklines shows the same data as
> > raw counts. The sparklines are small graphs where the height of the
> > bar is in relation to maximum of the other counts in the graph.
> >
> > By default the counts are read with an interval of 0.1 seconds (10
> > times per second). A -I/--interval command line option allows the
> > interval to be changed. The oldest read counts are dropped when the
> > counts fill the line causing the sparkline to move from right to left.
> >
> > A search box can be pulled up with the 's' key. 'n' and 'p' iterate
> > through the search results. As some PMUs have hundreds of events a 'c'
> > key will collapse the events in the current PMU to make navigating the
> > PMUs easier.
> >
> > [1] https://textual.textualize.io/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Hi Ian, I hit a segfault playing around with the ilist search feature. I =
can recreate it pretty
> reliably by searching for something then holding down 'n' to quickly cycl=
e through the results.
> After a few seconds, the program crashes.
>
> I've attached a backtrace from gdb below.

Thanks! I suspect that maybe you got the app to somehow read from an
event that wasn't opened or enabled or some such. I'll have a go at
reproducing.

Thanks,
Ian

> Thanks,
> Tom
>
> #0  __memset_avx2_unaligned_erms () at ../sysdeps/x86_64/multiarch/memset=
-vec-unaligned-erms.S:210
> #1  0x00007fffe88121a7 in perf_evsel__read (evsel=3D0x555557b16390, cpu_m=
ap_idx=3D8, thread=3D0,
> count=3D0x0) at evsel.c:403
> #2  0x00007fffe88cbf97 in evsel__read_one (evsel=3D0x555557b16390, cpu_ma=
p_idx=3D8, thread=3D0) at
> util/evsel.c:1719
> #3  0x00007fffe88cc794 in evsel__read_counter (evsel=3D0x555557b16390, cp=
u_map_idx=3D8, thread=3D0) at
> util/evsel.c:1896
> #4  0x00007fffe880c0a8 in prepare_metric (mexp=3D0x555555d25660, evsel=3D=
<optimized out>,
> pctx=3D0x5555579b5d00, cpu_idx=3D8, thread_idx=3D0)
>     at /home/tfalcon/perf-tools-next/tools/perf/util/python.c:1353
> #5  pyrf_evlist__compute_metric (pevlist=3D<optimized out>, args=3D<optim=
ized out>, kwargs=3D<optimized
> out>) at /home/tfalcon/perf-tools-next/tools/perf/util/python.c:1428
> #6  0x00007ffff7978655 in method_vectorcall_VARARGS_KEYWORDS (func=3D<opt=
imized out>,
> args=3D0x7ffff7fb1680, nargsf=3D<optimized out>, kwnames=3D<optimized out=
>)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Objects/descrobject=
.c:358
> #7  0x00007ffff793f337 in _PyObject_VectorcallTstate (tstate=3D0x7ffff7d5=
99d0 <_PyRuntime+283024>,
> callable=3D0x7fffe94f3dd0, args=3D<optimized out>, nargsf=3D<optimized ou=
t>,
>     kwnames=3D<optimized out>) at /usr/src/debug/python3.13-3.13.5-
> 1.fc41.x86_64/Include/internal/pycore_call.h:168
> #8  PyObject_Vectorcall (callable=3D0x7fffe94f3dd0, args=3D<optimized out=
>, nargsf=3D<optimized out>,
> kwnames=3D<optimized out>)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Objects/call.c:327
> #9  0x00007ffff794f1c1 in _PyEval_EvalFrameDefault (tstate=3D<optimized o=
ut>, frame=3D<optimized out>,
> throwflag=3D<optimized out>)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Python/generated_ca=
ses.c.h:1843
> #10 0x00007ffff79ab59f in _PyEval_EvalFrame (tstate=3D0x7ffff7d599d0 <_Py=
Runtime+283024>,
> frame=3D<optimized out>, throwflag=3D0)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Include/internal/py=
core_ceval.h:119
> #11 _PyEval_Vector (tstate=3D0x7ffff7d599d0 <_PyRuntime+283024>, func=3D0=
x7fffdde34400, locals=3D0x0,
> args=3D0x7fffffffc9a8, argcount=3D1, kwnames=3D0x0)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Python/ceval.c:1816
> #12 _PyFunction_Vectorcall (func=3D0x7fffdde34400, stack=3D0x7fffffffc9a8=
, nargsf=3D1, kwnames=3D0x0) at
> /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Objects/call.c:413
> #13 _PyObject_VectorcallTstate (tstate=3D0x7ffff7d599d0 <_PyRuntime+28302=
4>, callable=3D0x7fffdde34400,
> args=3D0x7fffffffc9a8, nargsf=3D1, kwnames=3D0x0)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Include/internal/py=
core_call.h:168
> #14 method_vectorcall (method=3D<optimized out>, args=3D0x7ffff7d2a140 <_=
PyRuntime+88320>,
> nargsf=3D<optimized out>, kwnames=3D<optimized out>)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Objects/classobject=
.c:70
> #15 0x00007ffff795369d in PyObject_Call (callable=3D0x7fffcfc978c0, args=
=3D0x7ffff7d2a128
> <_PyRuntime+88296>, kwargs=3D0x0)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Objects/call.c:373
> #16 PyCFunction_Call (callable=3D0x7fffcfc978c0, args=3D0x7ffff7d2a128 <_=
PyRuntime+88296>, kwargs=3D0x0)
> at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Objects/call.c:381
> #17 _PyEval_EvalFrameDefault (tstate=3D<optimized out>, frame=3D<optimize=
d out>, throwflag=3D<optimized
> out>)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Python/generated_ca=
ses.c.h:1355
> #18 0x00007ffff7a3a861 in _PyEval_EvalFrame (tstate=3D0x7ffff7d599d0 <_Py=
Runtime+283024>,
> frame=3D<optimized out>, throwflag=3D0)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Include/internal/py=
core_ceval.h:119
> #19 gen_send_ex2 (gen=3D0x7fffdccfcba0, arg=3D0x7ffff7d0bd30 <_Py_NoneStr=
uct>, presult=3D0x7fffffffcc68,
> exc=3D0, closing=3D<optimized out>)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Objects/genobject.c=
:229
> #20 0x00007fffde564149 in task_step_impl (state=3Dstate@entry=3D0x7fffde8=
9dfd0,
> task=3Dtask@entry=3D0x7fffdcd443c0, exc=3Dexc@entry=3D0x0)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Modules/_asynciomod=
ule.c:2782
> #21 0x00007fffde5657a5 in task_step (state=3D0x7fffde89dfd0, task=3D0x7ff=
fdcd443c0, exc=3D0x0) at
> /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Modules/_asynciomodule.c:3=
101
> #22 0x00007ffff79700a7 in cfunction_vectorcall_O (func=3D0x7fffcc0b1ad0, =
args=3D0x7fffcc37e860,
> nargsf=3D<optimized out>, kwnames=3D<optimized out>)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Include/cpython/met=
hodobject.h:50
> #23 0x00007ffff7ad6a3f in _PyObject_VectorcallTstate (tstate=3D0x7ffff7d5=
99d0 <_PyRuntime+283024>,
> callable=3D0x7fffcc0b1ad0, args=3D<optimized out>, nargsf=3D<optimized ou=
t>,
>     kwnames=3D<optimized out>) at /usr/src/debug/python3.13-3.13.5-
> 1.fc41.x86_64/Include/internal/pycore_call.h:168
> #24 0x00007ffff78ef15b in context_run (self=3D0x7fffddf2a440, args=3D0x7f=
ffcc37e858, nargs=3D2,
> kwnames=3D0x0)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Python/context.c:66=
4
> #25 0x00007ffff7969b4b in cfunction_vectorcall_FASTCALL_KEYWORDS (func=3D=
<optimized out>,
> args=3D0x7fffcc37e858, nargsf=3D<optimized out>, kwnames=3D<optimized out=
>)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Objects/methodobjec=
t.c:441
> #26 0x00007ffff795369d in PyObject_Call (callable=3D0x7fffcdff8950, args=
=3D0x7fffcc37e840, kwargs=3D0x0)
> at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Objects/call.c:373
> #27 PyCFunction_Call (callable=3D0x7fffcdff8950, args=3D0x7fffcc37e840, k=
wargs=3D0x0) at
> /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Objects/call.c:381
> #28 _PyEval_EvalFrameDefault (tstate=3D<optimized out>, frame=3D<optimize=
d out>, throwflag=3D<optimized
> out>)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Python/generated_ca=
ses.c.h:1355
> #29 0x00007ffff7a25fcb in PyEval_EvalCode (co=3D0x5555555d9a90, globals=
=3D<optimized out>,
> locals=3D0x7fffe9634c80)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Python/ceval.c:604
> #30 0x00007ffff7a640c3 in run_eval_code_obj (tstate=3Dtstate@entry=3D0x7f=
fff7d599d0 <_PyRuntime+283024>,
> co=3Dco@entry=3D0x5555555d9a90, globals=3Dglobals@entry=3D0x7fffe9634c80,
>     locals=3Dlocals@entry=3D0x7fffe9634c80) at /usr/src/debug/python3.13-=
3.13.5-
> 1.fc41.x86_64/Python/pythonrun.c:1381
> #31 0x00007ffff7a615f3 in run_mod (mod=3Dmod@entry=3D0x555555710ec8,
> filename=3Dfilename@entry=3D0x7fffe96568e0, globals=3Dglobals@entry=3D0x7=
fffe9634c80,
>     locals=3Dlocals@entry=3D0x7fffe9634c80, flags=3Dflags@entry=3D0x7ffff=
fffd298,
> arena=3Darena@entry=3D0x7fffe971bdb0, interactive_src=3D0x0, generate_new=
_source=3D0)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Python/pythonrun.c:=
1466
> #32 0x00007ffff7a5dfd6 in pyrun_file (fp=3Dfp@entry=3D0x5555555703a0,
> filename=3Dfilename@entry=3D0x7fffe96568e0, start=3Dstart@entry=3D257, gl=
obals=3Dglobals@entry=3D0x7fffe9634c80,
>     locals=3Dlocals@entry=3D0x7fffe9634c80, closeit=3Dcloseit@entry=3D1, =
flags=3D0x7fffffffd298) at
> /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Python/pythonrun.c:1295
> #33 0x00007ffff7a5dc4f in _PyRun_SimpleFileObject (fp=3Dfp@entry=3D0x5555=
555703a0,
> filename=3Dfilename@entry=3D0x7fffe96568e0, closeit=3Dcloseit@entry=3D1,
>     flags=3Dflags@entry=3D0x7fffffffd298) at /usr/src/debug/python3.13-3.=
13.5-
> 1.fc41.x86_64/Python/pythonrun.c:517
> #34 0x00007ffff7a5d881 in _PyRun_AnyFileObject (fp=3Dfp@entry=3D0x5555555=
703a0,
> filename=3Dfilename@entry=3D0x7fffe96568e0, closeit=3Dcloseit@entry=3D1,
>     flags=3Dflags@entry=3D0x7fffffffd298) at /usr/src/debug/python3.13-3.=
13.5-
> 1.fc41.x86_64/Python/pythonrun.c:77
> #35 0x00007ffff7a5beda in pymain_run_file_obj (program_name=3D0x7fffe9634=
db0, filename=3D0x7fffe96568e0,
> skip_source_first_line=3D0)
>     at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Modules/main.c:410
> #36 pymain_run_file (config=3D0x7ffff7d2c0c8 <_PyRuntime+96392>) at /usr/=
src/debug/python3.13-3.13.5-
> 1.fc41.x86_64/Modules/main.c:429
> #37 pymain_run_python (exitcode=3D0x7fffffffd28c) at /usr/src/debug/pytho=
n3.13-3.13.5-
> 1.fc41.x86_64/Modules/main.c:696
> #38 Py_RunMain () at /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Modul=
es/main.c:775
> #39 0x00007ffff7a1396c in Py_BytesMain (argc=3D<optimized out>, argv=3D<o=
ptimized out>) at
> /usr/src/debug/python3.13-3.13.5-1.fc41.x86_64/Modules/main.c:829
> #40 0x00007ffff760f488 in __libc_start_call_main (main=3Dmain@entry=3D0x5=
55555555160 <main>,
> argc=3Dargc@entry=3D2, argv=3Dargv@entry=3D0x7fffffffd4f8)
>     at ../sysdeps/nptl/libc_start_call_main.h:58
> #41 0x00007ffff760f54b in __libc_start_main_impl (main=3D0x555555555160 <=
main>, argc=3D2,
> argv=3D0x7fffffffd4f8, init=3D<optimized out>, fini=3D<optimized out>,
>     rtld_fini=3D<optimized out>, stack_end=3D0x7fffffffd4e8) at ../csu/li=
bc-start.c:360
> #42 0x0000555555555095 in _start ()
>
>
> > ---
> >  tools/perf/python/ilist.py | 392 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 392 insertions(+)
> >  create mode 100755 tools/perf/python/ilist.py
> >
> > diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
> > new file mode 100755
> > index 000000000000..b21f4c93247e
> > --- /dev/null
> > +++ b/tools/perf/python/ilist.py
> > @@ -0,0 +1,392 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +"""Interactive perf list."""
> > +
> > +import argparse
> > +from typing import Any, Dict, Tuple
> > +import perf
> > +from textual import on
> > +from textual.app import App, ComposeResult
> > +from textual.binding import Binding
> > +from textual.containers import Horizontal, HorizontalGroup, Vertical, =
VerticalScroll
> > +from textual.command import SearchIcon
> > +from textual.screen import ModalScreen
> > +from textual.widgets import Button, Footer, Header, Input, Label, Spar=
kline, Static, Tree
> > +from textual.widgets.tree import TreeNode
> > +
> > +class ErrorScreen(ModalScreen[bool]):
> > +    """Pop up dialog for errors."""
> > +
> > +    CSS=3D"""
> > +    ErrorScreen {
> > +        align: center middle;
> > +    }
> > +    """
> > +    def __init__(self, error: str):
> > +        self.error =3D error
> > +        super().__init__()
> > +
> > +    def compose(self) -> ComposeResult:
> > +        yield Button(f"Error: {self.error}", variant=3D"primary", id=
=3D"error")
> > +
> > +    def on_button_pressed(self, event: Button.Pressed) -> None:
> > +        self.dismiss(True)
> > +
> > +
> > +class SearchScreen(ModalScreen[str]):
> > +    """Pop up dialog for search."""
> > +
> > +    CSS=3D"""
> > +    SearchScreen Horizontal {
> > +        align: center middle;
> > +        margin-top: 1;
> > +    }
> > +    SearchScreen Input {
> > +        width: 1fr;
> > +    }
> > +    """
> > +    def compose(self) -> ComposeResult:
> > +        yield Horizontal(SearchIcon(), Input(placeholder=3D"Event name=
"))
> > +
> > +    def on_input_submitted(self, event: Input.Submitted) -> None:
> > +        """Handle the user pressing Enter in the input field."""
> > +        self.dismiss(event.value)
> > +
> > +
> > +class Counter(HorizontalGroup):
> > +    """Two labels for a CPU and its counter value."""
> > +
> > +    CSS=3D"""
> > +    Label {
> > +        gutter: 1;
> > +    }
> > +    """
> > +
> > +    def __init__(self, cpu: int) -> None:
> > +        self.cpu =3D cpu
> > +        super().__init__()
> > +
> > +    def compose(self) -> ComposeResult:
> > +        label =3D f"cpu{self.cpu}" if self.cpu >=3D 0 else "total"
> > +        yield Label(label + " ")
> > +        yield Label("0", id=3Df"counter_{label}")
> > +
> > +
> > +class CounterSparkline(HorizontalGroup):
> > +    """A Sparkline for a performance counter."""
> > +
> > +    def __init__(self, cpu: int) -> None:
> > +        self.cpu =3D cpu
> > +        super().__init__()
> > +
> > +    def compose(self) -> ComposeResult:
> > +        label =3D f"cpu{self.cpu}" if self.cpu >=3D 0 else "total"
> > +        yield Label(label)
> > +        yield Sparkline([], summary_function=3Dmax, id=3Df"sparkline_{=
label}")
> > +
> > +
> > +class IListApp(App):
> > +    TITLE =3D "Interactive Perf List"
> > +
> > +    BINDINGS =3D [
> > +        Binding(key=3D"s", action=3D"search", description=3D"Search",
> > +                tooltip=3D"Search events and PMUs"),
> > +        Binding(key=3D"n", action=3D"next", description=3D"Next",
> > +                tooltip=3D"Next search result or item"),
> > +        Binding(key=3D"p", action=3D"prev", description=3D"Previous",
> > +                tooltip=3D"Previous search result or item"),
> > +        Binding(key=3D"c", action=3D"collapse", description=3D"Collaps=
e",
> > +                tooltip=3D"Collapse the current PMU"),
> > +        Binding(key=3D"^q", action=3D"quit", description=3D"Quit",
> > +                tooltip=3D"Quit the app"),
> > +    ]
> > +
> > +    CSS =3D """
> > +        /* Make the 'total' sparkline a different color. */
> > +        #sparkline_total > .sparkline--min-color {
> > +            color: $accent;
> > +        }
> > +        #sparkline_total > .sparkline--max-color {
> > +            color: $accent 30%;
> > +        }
> > +        /*
> > +         * Make the active_search initially not displayed with the tex=
t in
> > +         * the middle of the line.
> > +         */
> > +        #active_search {
> > +            display: none;
> > +            width: 100%;
> > +            text-align: center;
> > +        }
> > +    """
> > +
> > +    def __init__(self, interval: float) -> None:
> > +        self.interval =3D interval
> > +        self.evlist =3D None
> > +        self.search_results: list[TreeNode[str]] =3D []
> > +        self.cur_search_result: TreeNode[str] | None =3D None
> > +        super().__init__()
> > +
> > +
> > +
> > +    def expand_and_select(self, node: TreeNode[Any]) -> None:
> > +        """Expand select a node in the tree."""
> > +        if node.parent:
> > +            node.parent.expand()
> > +            if node.parent.parent:
> > +                node.parent.parent.expand()
> > +        node.expand()
> > +        node.tree.select_node(node)
> > +        node.tree.scroll_to_node(node)
> > +
> > +
> > +    def set_searched_tree_node(self, previous: bool) -> None:
> > +        """Set the cur_search_result node to either the next or previo=
us."""
> > +        l =3D len(self.search_results)
> > +
> > +        if l < 1:
> > +            tree: Tree[str] =3D self.query_one("#pmus", Tree)
> > +            if previous:
> > +                tree.action_cursor_up()
> > +            else:
> > +                tree.action_cursor_down()
> > +            return
> > +
> > +        if self.cur_search_result:
> > +            idx =3D self.search_results.index(self.cur_search_result)
> > +            if previous:
> > +                idx =3D idx - 1 if idx > 0 else l - 1
> > +            else:
> > +                idx =3D idx + 1 if idx < l - 1 else 0
> > +        else:
> > +            idx =3D l - 1 if previous else 0
> > +
> > +        node =3D self.search_results[idx]
> > +        if node =3D=3D self.cur_search_result:
> > +            return
> > +
> > +        self.cur_search_result =3D node
> > +        self.expand_and_select(node)
> > +
> > +    def action_search(self) -> None:
> > +        """Search was chosen."""
> > +        def set_initial_focus(event: str | None) -> None:
> > +            """Sets the focus after the SearchScreen is dismissed."""
> > +
> > +            search_label =3D self.query_one("#active_search", Label)
> > +            search_label.display =3D True if event else False
> > +            if not event:
> > +                return
> > +            event =3D event.lower()
> > +            search_label.update(f'Searching for events matching "{even=
t}"')
> > +
> > +            tree: Tree[str] =3D self.query_one("#pmus", Tree)
> > +            def find_search_results(event: str, node: TreeNode[str], \
> > +                                    cursor_seen: bool =3D False, \
> > +                                    match_after_cursor: TreeNode[str] =
| None =3D None) \
> > +                    -> Tuple[bool, TreeNode[str] | None]:
> > +                """Find nodes that match the search remembering the on=
e after the cursor."""
> > +                if not cursor_seen and node =3D=3D tree.cursor_node:
> > +                    cursor_seen =3D True
> > +                if node.data and event in node.data:
> > +                    if cursor_seen and not match_after_cursor:
> > +                        match_after_cursor =3D node
> > +                    self.search_results.append(node)
> > +
> > +                if node.children:
> > +                    for child in node.children:
> > +                        (cursor_seen, match_after_cursor) =3D \
> > +                            find_search_results(event, child, cursor_s=
een, match_after_cursor)
> > +                return (cursor_seen, match_after_cursor)
> > +
> > +            self.search_results.clear()
> > +            (_ , self.cur_search_result) =3D find_search_results(event=
, tree.root)
> > +            if len(self.search_results) < 1:
> > +                self.push_screen(ErrorScreen(f"Failed to find pmu/even=
t {event}"))
> > +                search_label.display =3D False
> > +            elif self.cur_search_result:
> > +                self.expand_and_select(self.cur_search_result)
> > +            else:
> > +                self.set_searched_tree_node(previous=3DFalse)
> > +
> > +        self.push_screen(SearchScreen(), set_initial_focus)
> > +
> > +
> > +    def action_next(self) -> None:
> > +        """Next was chosen."""
> > +        self.set_searched_tree_node(previous=3DFalse)
> > +
> > +
> > +    def action_prev(self) -> None:
> > +        """Previous was chosen."""
> > +        self.set_searched_tree_node(previous=3DTrue)
> > +
> > +
> > +    def action_collapse(self) -> None:
> > +        """Collapse the potentially large number of events under a PMU=
."""
> > +        tree: Tree[str] =3D self.query_one("#pmus", Tree)
> > +        node =3D tree.cursor_node
> > +        if node and node.parent and node.parent.parent:
> > +            node.parent.collapse_all()
> > +            node.tree.scroll_to_node(node.parent)
> > +
> > +
> > +    def update_counts(self) -> None:
> > +        """Called every interval to update counts."""
> > +        if not self.evlist:
> > +            return
> > +
> > +        def update_count(cpu: int, count: int):
> > +            # Update the raw count display.
> > +            counter: Label =3D self.query(f"#counter_cpu{cpu}" if cpu =
>=3D 0 else "#counter_total")
> > +            if not counter:
> > +                return
> > +            counter =3D counter.first(Label)
> > +            counter.update(str(count))
> > +
> > +            # Update the sparkline.
> > +            line: Sparkline =3D self.query(f"#sparkline_cpu{cpu}" if c=
pu >=3D 0 else "#sparkline_total")
> > +            if not line:
> > +                return
> > +            line =3D line.first(Sparkline)
> > +            # If there are more events than the width, remove the fron=
t event.
> > +            if len(line.data) > line.size.width:
> > +                line.data.pop(0)
> > +            line.data.append(count)
> > +            line.mutate_reactive(Sparkline.data)
> > +
> > +        # Update the total and each CPU counts, assume there's just 1 =
evsel.
> > +        total =3D 0
> > +        self.evlist.disable()
> > +        for evsel in self.evlist:
> > +            for cpu in evsel.cpus():
> > +                aggr =3D 0
> > +                for thread in evsel.threads():
> > +                    counts =3D evsel.read(cpu, thread)
> > +                    aggr +=3D counts.val
> > +                update_count(cpu, aggr)
> > +                total +=3D aggr
> > +        update_count(-1, total)
> > +        self.evlist.enable()
> > +
> > +
> > +    def on_mount(self) -> None:
> > +        """When App starts set up periodic event updating."""
> > +        self.update_counts()
> > +        self.set_interval(self.interval, self.update_counts)
> > +
> > +
> > +    def set_pmu_and_event(self, pmu: str, event: str) -> None:
> > +        """Updates the event/description and starts the counters."""
> > +        # Remove previous event information.
> > +        if self.evlist:
> > +            self.evlist.disable()
> > +            self.evlist.close()
> > +            lines =3D self.query(CounterSparkline)
> > +            for line in lines:
> > +                line.remove()
> > +            lines =3D self.query(Counter)
> > +            for line in lines:
> > +                line.remove()
> > +
> > +        def pmu_event_description(pmu: str, event: str) -> str:
> > +            """Find and format event description for {pmu}/{event}/.""=
"
> > +            def get_info(info: Dict[str, str], key: str):
> > +                return (info[key] + "\n") if key in info else ""
> > +
> > +            for p in perf.pmus():
> > +                if p.name() !=3D pmu:
> > +                    continue
> > +                for info in p.events():
> > +                    if "name" not in info or info["name"] !=3D event:
> > +                        continue
> > +
> > +                    desc =3D get_info(info, "topic")
> > +                    desc +=3D get_info(info, "event_type_desc")
> > +                    desc +=3D get_info(info, "desc")
> > +                    desc +=3D get_info(info, "long_desc")
> > +                    desc +=3D get_info(info, "encoding_desc")
> > +                    return desc
> > +            return "description"
> > +
> > +        # Parse event, update event text and description.
> > +        full_name =3D event if event.startswith(pmu) or ':' in event e=
lse f"{pmu}/{event}/"
> > +        self.query_one("#event_name", Label).update(full_name)
> > +        self.query_one("#event_description", Static).update(pmu_event_=
description(pmu, event))
> > +
> > +        # Open the event.
> > +        try:
> > +            self.evlist =3D perf.parse_events(full_name)
> > +            if self.evlist:
> > +                self.evlist.open()
> > +                self.evlist.enable()
> > +        except:
> > +            self.evlist =3D None
> > +
> > +        if not self.evlist:
> > +            self.push_screen(ErrorScreen(f"Failed to open {full_name}"=
))
> > +            return
> > +
> > +        # Add spark lines for all the CPUs. Note, must be done after
> > +        # open so that the evlist CPUs have been computed by propagate
> > +        # maps.
> > +        lines =3D self.query_one("#lines")
> > +        line =3D CounterSparkline(cpu=3D-1)
> > +        lines.mount(line)
> > +        for cpu in self.evlist.all_cpus():
> > +            line =3D CounterSparkline(cpu)
> > +            lines.mount(line)
> > +        line =3D Counter(cpu=3D-1)
> > +        lines.mount(line)
> > +        for cpu in self.evlist.all_cpus():
> > +            line =3D Counter(cpu)
> > +            lines.mount(line)
> > +
> > +
> > +    def compose(self) -> ComposeResult:
> > +        """Draws the app."""
> > +        def pmu_event_tree() -> Tree:
> > +            """Create tree of PMUs with events under."""
> > +            tree: Tree[str] =3D Tree("PMUs", id=3D"pmus")
> > +            tree.root.expand()
> > +            for pmu in perf.pmus():
> > +                pmu_name =3D pmu.name().lower()
> > +                pmu_node =3D tree.root.add(pmu_name, data=3Dpmu_name)
> > +                try:
> > +                    for event in sorted(pmu.events(), key=3Dlambda x: =
x["name"]):
> > +                        if "name" in event:
> > +                            e =3D event["name"].lower()
> > +                            if "alias" in event:
> > +                                pmu_node.add_leaf(f'{e} ({event["alias=
"]})', data=3De)
> > +                            else:
> > +                                pmu_node.add_leaf(e, data=3De)
> > +                except:
> > +                    # Reading events may fail with EPERM, ignore.
> > +                    pass
> > +            return tree
> > +
> > +        yield Header(id=3D"header")
> > +        yield Horizontal(Vertical(pmu_event_tree(), id=3D"events"),
> > +                         Vertical(Label("event name", id=3D"event_name=
"),
> > +                                  Static("description", markup=3DFalse=
, id=3D"event_description"),
> > +                                  ))
> > +        yield Label(id=3D"active_search")
> > +        yield VerticalScroll(id=3D"lines")
> > +        yield Footer(id=3D"footer")
> > +
> > +
> > +    @on(Tree.NodeSelected)
> > +    def on_tree_node_selected(self, event: Tree.NodeSelected[str]) -> =
None:
> > +        """Called when a tree node is selected, selecting the event.""=
"
> > +        if event.node.parent and event.node.parent.parent:
> > +            assert event.node.parent.data is not None
> > +            assert event.node.data is not None
> > +            self.set_pmu_and_event(event.node.parent.data, event.node.=
data)
> > +
> > +
> > +if __name__ =3D=3D "__main__":
> > +    ap =3D argparse.ArgumentParser()
> > +    ap.add_argument('-I', '--interval', help=3D"Counter update interva=
l in seconds", default=3D0.1)
> > +    args =3D ap.parse_args()
> > +    app =3D IListApp(float(args.interval))
> > +    app.run()
>
