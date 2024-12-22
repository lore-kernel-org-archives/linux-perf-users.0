Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080F38DD8
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Dec 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734886458; cv=none; b=cEl32ayU5bYW5NqCJnAF+o9xg3Fble4d77j5vUkI41YvZ9h6qV0E/jvmIF0MwMsqm1WMZMr45TQlo+ncjpRzd0uqFeaE7Ae0msFGx7H13blwHO0ObXY6wAPt+f5Q4C6PIFZg8bFJDLgMUHItZjNudKGD2R6/EQF/RqJIItXAww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734886458; c=relaxed/simple;
	bh=oisKik0GirgJ85QDhxRMMOT7j9/4PtUK2f1+eheDYJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZSA/NcnywJtON+D/z49G6ZIVGfB0YwHFR7xOtY6FiBv6cGlrw2UcEfRZVOfpCANZozWfrH9UK1GfetLz+OZ0u2+ZM/qXAz6cJKGH1nXHvK9ljP51NLTFIclVUWCZDUNq4oyq1Gj05hzkG24VXUpgVeLmZja9OQKaSuVCaKa3tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=upyogE5S; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upyogE5S"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so416225ab.0
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Dec 2024 08:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734886455; x=1735491255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yc71mafuwad4wHWfv1EVY20QF0Z3Hu3q9DSShS/B5mQ=;
        b=upyogE5SeQM3wlkF3TkZ8xhBM6lfDoc95QBlsx8g4sAbeA8N1zTPijfg55iHShMMh4
         PVI6DhoXn5TEIYiiVLvNLgOHaGipDP0pvQ72N8DdAaear9vhHp+brWqyi2EhwOpiWPL/
         44qzxAp3MLDLyPisQG3eVLwvwq2BnLQU0F16cCdDzovCPMQSsfjNOzE9E7kKtIqjqnOR
         vKzS6EXWP3ApZmZu2ZMtTYkmD84wOWB4CmXwUT+L6rfnpWw4MbAyheIJVAn7rYTbgD5u
         4EnSDhva5jx1ZvIJnahiwL7m3fs50kGJAGyUHQzE8u4nD0IQUxnaJVGpxXm7M/HLSqpJ
         w84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734886455; x=1735491255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yc71mafuwad4wHWfv1EVY20QF0Z3Hu3q9DSShS/B5mQ=;
        b=nv8AR6i+3I9O/R+lU9laNHwIO5HC7pSZgKyEQAlVKO5sm5u/mPe5fB0L+tvbPATkAr
         i548p6khCTI6p817fLNPnFTkjtCZYqsFTI1W0JVgwYODZjSOIU//Rh2fATy53zsR9l7o
         wRUDY+qtvMJNKSDM4QYZCpN6BNnCgyFIXd6PTj4ONsEk6CPgWPUXzJf/eCuejPtrq28a
         MbgbgZA6zUJNxIJ7KdGl7R4o3ms0wfdOBhQQW1WVsajuiVPXe3uW7wrqGNLMR9fEZWaR
         c2+2i5pgd37FUV6dx4Ion4+tBS4nMMD+D0ZNfQ+OvDcsfvbol+7xkT6eCLQZQBoBMKkg
         +iLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfJ7GZhq6NJ6NLApQ0VVDikgK5JPb4B/Kdmau4Hn5G7iJhYpN56FusNE17FrU3dRI1Zj6Yn1At2h/vwybSDMqd@vger.kernel.org
X-Gm-Message-State: AOJu0YwC7f06rtZtHwVf/A5yntdTrBbMKF/uU3Jbxl7ICNsak1YB/h7O
	BOQA5vpFAjTCJ/WUHiS7iI7/hW6LvPyji2XTGGfD6QrwRuqyjQ2TW+ok6pMvZL11vaon9N3tA5p
	jm0tp1rZansq6CyK0baFCeAFqT52gkMkU2Hzt
X-Gm-Gg: ASbGnctcU5WQRFVNgc8o9YaNQ/ItNbtCNvldCaA9q7/9HbTmKmmmEON9pccqfAewCEo
	OpIoO1pq0gaEfh4xe/1eK+wd6oH3eQbf6VwvlRRI=
X-Google-Smtp-Source: AGHT+IHpwKHXYQ5JGGP81Vi48n03IFlVmT3+WEto8roRDCBYUWyJwbRRhx98z/TD3VdHENghDIHqGn0FN6im+rr+g68=
X-Received: by 2002:a05:6e02:802:b0:3a7:6126:ca3 with SMTP id
 e9e14a558f8ab-3c2e56729b0mr7029225ab.24.1734886455351; Sun, 22 Dec 2024
 08:54:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216070244.14450-1-adrian.hunter@intel.com>
 <20241216070244.14450-8-adrian.hunter@intel.com> <CAP-5=fUwjYH8uvmsgSN=1exN1FEEBEPQHFYwgq4cJEeOApFNQg@mail.gmail.com>
 <7e438859-26c3-4ad6-850b-21b9ab6078c3@intel.com>
In-Reply-To: <7e438859-26c3-4ad6-850b-21b9ab6078c3@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 22 Dec 2024 08:54:04 -0800
Message-ID: <CAP-5=fX8hWF-PaAE2VKHW3fk1W19xd0hyBVsP3653J9xw-U7VQ@mail.gmail.com>
Subject: Re: [PATCH V16 7/7] perf intel-pt: Add a test for pause / resume
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 11:30=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 21/12/24 19:10, Ian Rogers wrote:
> > On Sun, Dec 15, 2024 at 11:03=E2=80=AFPM Adrian Hunter <adrian.hunter@i=
ntel.com> wrote:
> >>
> >> Add a simple sub-test to the "Miscellaneous Intel PT testing" test to
> >> check pause / resume.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> Acked-by: Ian Rogers <irogers@google.com>
> >> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> >> ---
> >>  tools/perf/tests/shell/test_intel_pt.sh | 28 ++++++++++++++++++++++++=
+
> >>  1 file changed, 28 insertions(+)
> >>
> >> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/test=
s/shell/test_intel_pt.sh
> >> index e6f0070975f6..f3a9a040bacc 100755
> >> --- a/tools/perf/tests/shell/test_intel_pt.sh
> >> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> >> @@ -644,6 +644,33 @@ test_pipe()
> >>         return 0
> >>  }
> >>
> >> +test_pause_resume()
> >> +{
> >> +       echo "--- Test with pause / resume ---"
> >> +       if ! perf_record_no_decode -o "${perfdatafile}" -e intel_pt/au=
x-action=3Dstart-paused/u uname ; then
> >> +               echo "SKIP: pause / resume is not supported"
> >> +               return 2
> >> +       fi
> >> +       if ! perf_record_no_bpf -o "${perfdatafile}" \
> >> +                       -e intel_pt/aux-action=3Dstart-paused/u \
> >> +                       -e instructions/period=3D50000,aux-action=3Dre=
sume,name=3DResume/u \
> >> +                       -e instructions/period=3D100000,aux-action=3Dp=
ause,name=3DPause/u uname  ; then
> >> +               echo "perf record with pause / resume failed"
> >> +               return 1
> >> +       fi
> >> +       if ! perf script -i "${perfdatafile}" --itrace=3Db -Fperiod,ev=
ent | \
> >> +                       awk 'BEGIN {paused=3D1;branches=3D0}
> >> +                            /Resume/ {paused=3D0}
> >> +                            /branches/ {if (paused) exit 1;branches=
=3D1}
> >> +                            /Pause/ {paused=3D1}
> >> +                            END {if (!branches) exit 1}' ; then
> >> +               echo "perf record with pause / resume failed"
> >> +               return 1
> >> +       fi
> >> +       echo OK
> >
> > Hi,
> >
> > this new test is now constantly making "Miscellaneous Intel PT testing"=
 fail:
> >
> > ```
> > ...
> > --- Test with pause / resume ---
> > Error:
> > Failure to open event 'intel_pt/aux-action=3Dstart-paused/u' on PMU
> > 'intel_pt' which will be removed.
> > The 'aux_action' feature is not supported, update the kernel.
> > Linux
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.003 MB
> > /tmp/perf-test-intel-pt-sh.Hs8jcq0ADc/test-perf.data ]
> > Error:
> > Failure to open event 'intel_pt/aux-action=3Dstart-paused/u' on PMU
> > 'intel_pt' which will be removed.
> > The 'aux_action' feature is not supported, update the kernel.
> > Error:
> > Failure to open event 'Resume' on PMU 'cpu' which will be removed.
> > The 'aux_action' feature is not supported, update the kernel.
> > Error:
> > Failure to open event 'Pause' on PMU 'cpu' which will be removed.
> > The 'aux_action' feature is not supported, update the kernel.
> > Linux
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.005 MB
> > /tmp/perf-test-intel-pt-sh.Hs8jcq0ADc/test-perf.data ]
> > perf record with pause / resume failed
> > --- Cleaning up ---
> > ...
> > ```
> >
> > Should the fail be turned into a skip for missing kernel support?
>
> Seems to skip for me with perf-tools-next:
>
> --- Test with pause / resume ---
> Error:
> The 'aux_action' feature is not supported, update the kernel.
> SKIP: pause / resume is not supported
>
> perf version 6.13.rc2.g39c2547579aa

My mistake, I thought I tested a clean client but I was testing with:
https://lore.kernel.org/lkml/20241221192654.94344-1-irogers@google.com/
The issue there is that intel-pt is opening multiple dummy events in this t=
est:
```
Breakpoint 2, evlist__new () at util/evlist.c:89
89              struct evlist *evlist =3D zalloc(sizeof(*evlist));
(gdb) n
91              if (evlist !=3D NULL)
(gdb) p evlist->core.nr_entries
$8 =3D 0
(gdb) p &evlist->core.nr_entries
$9 =3D (int *) 0x55555618d150
(gdb) watch *$9
Hardware watchpoint 3: *$9
(gdb) c
Continuing.

Hardware watchpoint 3: *$9

Old value =3D 0
New value =3D 1
perf_evlist__add (evlist=3D0x55555618d140, evsel=3D0x5555561a6910) at evlis=
t.c:112
112             if (evlist->needs_map_propagation)
(gdb) bt
#0  perf_evlist__add (evlist=3D0x55555618d140, evsel=3D0x5555561a6910) at
evlist.c:112
#1  0x00005555557c91ba in evlist__add (evlist=3D0x55555618d140,
entry=3D0x5555561a6910)
    at util/evlist.c:197
#2  0x00005555557c9320 in evlist__splice_list_tail
(evlist=3D0x55555618d140, list=3D0x7fffffffbaa8)
    at util/evlist.c:218
#3  0x00005555557eb886 in __parse_events (evlist=3D0x55555618d140,
    str=3D0x7fffffffe5c1 "intel_pt/aux-action=3Dstart-paused/u",
pmu_filter=3D0x0, err=3D0x7fffffffbb38,
    fake_pmu=3Dfalse, warn_if_reordered=3Dtrue, fake_tp=3Dfalse) at
util/parse-events.c:2166
#4  0x00005555557ec4b4 in parse_events_option (opt=3D0x5555560e5bb0
<__record_options>,
    str=3D0x7fffffffe5c1 "intel_pt/aux-action=3Dstart-paused/u", unset=3D0)
at util/parse-events.c:2352
#5  0x00005555556acede in get_value (p=3D0x7fffffffbde0,
opt=3D0x5555560e5bb0 <__record_options>,
    flags=3D1) at parse-options.c:251
#6  0x00005555556ac13f in parse_short_opt (p=3D0x7fffffffbde0,
    options=3D0x5555560e5bb0 <__record_options>) at parse-options.c:351
#7  0x00005555556aaecb in parse_options_step (ctx=3D0x7fffffffbde0,
    options=3D0x5555560e5bb0 <__record_options>, usagestr=3D0x5555560b5bb0
<__record_usage>)
    at parse-options.c:539
#8  0x00005555556aa940 in parse_options_subcommand (argc=3D4, argv=3D0x7fff=
ffffe310,
    options=3D0x5555560e5bb0 <__record_options>, subcommands=3D0x0,
    usagestr=3D0x5555560b5bb0 <__record_usage>, flags=3D2) at parse-options=
.c:654
#9  0x00005555556ab3d7 in parse_options (argc=3D4, argv=3D0x7fffffffe310,
    options=3D0x5555560e5bb0 <__record_options>, usagestr=3D0x5555560b5bb0
<__record_usage>, flags=3D2)
    at parse-options.c:689
#10 0x00005555555f23dd in cmd_record (argc=3D4, argv=3D0x7fffffffe310) at
builtin-record.c:4021
#11 0x000055555569d42f in run_builtin (p=3D0x5555560f0cb0 <commands+288>, a=
rgc=3D4,
    argv=3D0x7fffffffe310) at perf.c:351
#12 0x000055555569cae3 in handle_internal_command (argc=3D4,
argv=3D0x7fffffffe310) at perf.c:404
#13 0x000055555569d2ff in run_argv (argcp=3D0x7fffffffe15c,
argv=3D0x7fffffffe150) at perf.c:448
#14 0x000055555569c73f in main (argc=3D4, argv=3D0x7fffffffe310) at perf.c:=
560
(gdb) c
Continuing.

Breakpoint 2, evlist__new () at util/evlist.c:89
89              struct evlist *evlist =3D zalloc(sizeof(*evlist));
(gdb) bt
#0  evlist__new () at util/evlist.c:89
#1  0x00005555558a8365 in perf_do_probe_api (fn=3D0x5555558a7e50
<perf_probe_context_switch>,
    cpu=3D..., str=3D0x5555559ba4fb "cycles:u") at util/perf_api_probe.c:22
#2  0x00005555558a7c94 in perf_probe_api (fn=3D0x5555558a7e50
<perf_probe_context_switch>)
    at util/perf_api_probe.c:74
#3  0x00005555558a7e21 in perf_can_record_switch_events () at
util/perf_api_probe.c:124
#4  0x000055555597273e in intel_pt_recording_options
(itr=3D0x5555561a9100, evlist=3D0x55555618d140,
    opts=3D0x5555560e7b58 <record+320>) at arch/x86/util/intel-pt.c:793
#5  0x00005555558be64d in auxtrace_record__options
(itr=3D0x5555561a9100, evlist=3D0x55555618d140,
    opts=3D0x5555560e7b58 <record+320>) at util/auxtrace.c:619
#6  0x00005555555f2da3 in cmd_record (argc=3D1, argv=3D0x7fffffffe310) at
builtin-record.c:4226
#7  0x000055555569d42f in run_builtin (p=3D0x5555560f0cb0 <commands+288>, a=
rgc=3D4,
    argv=3D0x7fffffffe310) at perf.c:351
#8  0x000055555569cae3 in handle_internal_command (argc=3D4,
argv=3D0x7fffffffe310) at perf.c:404
#9  0x000055555569d2ff in run_argv (argcp=3D0x7fffffffe15c,
argv=3D0x7fffffffe150) at perf.c:448
#10 0x000055555569c73f in main (argc=3D4, argv=3D0x7fffffffe310) at perf.c:=
560
(gdb) c
Continuing.

Hardware watchpoint 3: *$9

Old value =3D 1
New value =3D 2
perf_evlist__add (evlist=3D0x55555618d140, evsel=3D0x5555561a6c10) at evlis=
t.c:112
112             if (evlist->needs_map_propagation)
(gdb) bt
#0  perf_evlist__add (evlist=3D0x55555618d140, evsel=3D0x5555561a6c10) at
evlist.c:112
#1  0x00005555557c91ba in evlist__add (evlist=3D0x55555618d140,
entry=3D0x5555561a6c10)
    at util/evlist.c:197
#2  0x00005555557c980a in evlist__add_aux_dummy
(evlist=3D0x55555618d140, system_wide=3Dtrue)
    at util/evlist.c:299
#3  0x0000555555974297 in evlist__add_dummy_on_all_cpus (evlist=3D0x5555561=
8d140)
    at arch/x86/util/../../../util/evlist.h:111
#4  0x00005555559727ae in intel_pt_recording_options
(itr=3D0x5555561a9100, evlist=3D0x55555618d140,
    opts=3D0x5555560e7b58 <record+320>) at arch/x86/util/intel-pt.c:800
#5  0x00005555558be64d in auxtrace_record__options
(itr=3D0x5555561a9100, evlist=3D0x55555618d140,
    opts=3D0x5555560e7b58 <record+320>) at util/auxtrace.c:619
#6  0x00005555555f2da3 in cmd_record (argc=3D1, argv=3D0x7fffffffe310) at
builtin-record.c:4226
#7  0x000055555569d42f in run_builtin (p=3D0x5555560f0cb0 <commands+288>, a=
rgc=3D4,
    argv=3D0x7fffffffe310) at perf.c:351
#8  0x000055555569cae3 in handle_internal_command (argc=3D4,
argv=3D0x7fffffffe310) at perf.c:404
#9  0x000055555569d2ff in run_argv (argcp=3D0x7fffffffe15c,
argv=3D0x7fffffffe150) at perf.c:448
#10 0x000055555569c73f in main (argc=3D4, argv=3D0x7fffffffe310) at perf.c:=
560
(gdb) c
Continuing.

Hardware watchpoint 3: *$9

Old value =3D 2
New value =3D 3
perf_evlist__add (evlist=3D0x55555618d140, evsel=3D0x5555561a6ef0) at evlis=
t.c:112
112             if (evlist->needs_map_propagation)
(gdb) bt
#0  perf_evlist__add (evlist=3D0x55555618d140, evsel=3D0x5555561a6ef0) at
evlist.c:112
#1  0x00005555557c91ba in evlist__add (evlist=3D0x55555618d140,
entry=3D0x5555561a6ef0)
    at util/evlist.c:197
#2  0x00005555557c980a in evlist__add_aux_dummy
(evlist=3D0x55555618d140, system_wide=3Dfalse)
    at util/evlist.c:299
#3  0x00005555559729f8 in intel_pt_recording_options
(itr=3D0x5555561a9100, evlist=3D0x55555618d140,
    opts=3D0x5555560e7b58 <record+320>) at arch/x86/util/intel-pt.c:865
#4  0x00005555558be64d in auxtrace_record__options
(itr=3D0x5555561a9100, evlist=3D0x55555618d140,
    opts=3D0x5555560e7b58 <record+320>) at util/auxtrace.c:619
#5  0x00005555555f2da3 in cmd_record (argc=3D1, argv=3D0x7fffffffe310) at
builtin-record.c:4226
#6  0x000055555569d42f in run_builtin (p=3D0x5555560f0cb0 <commands+288>, a=
rgc=3D4,
    argv=3D0x7fffffffe310) at perf.c:351
#7  0x000055555569cae3 in handle_internal_command (argc=3D4,
argv=3D0x7fffffffe310) at perf.c:404
#8  0x000055555569d2ff in run_argv (argcp=3D0x7fffffffe15c,
argv=3D0x7fffffffe150) at perf.c:448
#9  0x000055555569c73f in main (argc=3D4, argv=3D0x7fffffffe310) at perf.c:=
560
(gdb)
```

That is a dummy event is added in 2 places:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/x86/util/intel-pt.c?h=3Dperf-tools-next#n800
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/x86/util/intel-pt.c?h=3Dperf-tools-next#n865

I'll need to update my patch set for things outside of record adding
dummy events, but I'm curious if the intel-pt code could share a
single dummy evsel?

Thanks,
Ian
