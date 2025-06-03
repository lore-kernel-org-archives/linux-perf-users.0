Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C307227EB9
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Jun 2025 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748987730; cv=none; b=t88IWTKYgCMUFkdplSDA+G9Pp61ZNroOiFahPOuIp3QmLOhS0kbYEGnoTz1mtbixPcc2FvcP5rRqet2bYJTwhr/vjUDo7+MQBui1Y9Z/j8SxUutdBsEFysybYugYyGndTPVJBlDBpqieAMhf56GreeykZQRhp1A82fNc2NsB5ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748987730; c=relaxed/simple;
	bh=7Rmjf+wpT9nu7SLzn8HLQNilJSyY8PdzQaIpHL4Lm1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCpCpburgT5PcdIOh1nuXhxkcNoYSZ9g4cekPthVuj6kyQn8hMRU9Ur1W/2mBZC3yU3K91toKFisctBpZlzERXNiiGohDNjYZOHlA9hzkKQA8Ec3DzG8XeQmBoDM/2iatuGlpYItQwtsXVATRV4D2w6/RKOOM0HaFdYKr1Cc+Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IW69wF9T; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IW69wF9T"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso32475ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Jun 2025 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748987727; x=1749592527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ovCfWCZZlx1YO92lDw8QGomt0i3VjyhByOMIWGMVMk=;
        b=IW69wF9TroBhvPa0Q8M6LnGsziG0fiWctPY/YErwO14uemJ9rf49Y+63CuGWV0D3be
         uEJQ4/1QJeavR+aSriEMOCM4KYVA923gZ3GsQLRmi2/T8UENxe1MYOgInDiNkrC3II3K
         lwfgalH08rkoRIqNkxlRjAG2PYXra66NqCseTAZGbYNUlwe0wEz/s00CeWYvIGz7Ia54
         B3ufmnJcVx1JdqEuo4WkHNAuUgU+PtfLmS3GIugupi4MJ7MW9t05EMrU7WLrKQ4nGrME
         e0kXIFCM4d/sDIgzqfqZmQdmNezf6aaYH46D61Dk821vMNwsnRIqicrNHchtZxS47Gjq
         GnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748987727; x=1749592527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ovCfWCZZlx1YO92lDw8QGomt0i3VjyhByOMIWGMVMk=;
        b=G5CvboGlYuoh+EGgnzjUNCEIsmbRVrMNouip5Th9K1UhzYpVTf8X9nxwtfuHnqzvR3
         bOSb5BtMJIJnYydjSD9vXwCdkBV8za3wYw0QmTwTmN90c/8ZSPpUsSKdA8OrBWGV+cmu
         XmXnrMcb9L9c8/mGx4PqX0t5GZWNnd5dhdYzE8GQj39udN/Gimkhdeg3MxuEUIiJWrIo
         I1sUw7DdLkzsphmGIvR2yDVH1WMPCioIMLBNu06h/TYdCVzT5RGIig+UunbzXhzDJmFy
         mtlUKB46kdbXq+f55nOWOXP/OrbiDEJ6fQYczRdCKsXHVM/eHVzcZBHqR6iZeCNPPKkU
         TZuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgI/pga7NQ20uSLdohf3rYTyqdAKmdm6ZB2CTrfxfeG6Q7Cf/EW5tDHw7wkQ7mmIMgyhU9W/NeYg1qv/GLm/BR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxioh0CTVjIzQmkJOkw39P6TecJtWnhBC7ydLQqPrR2ztZBf9M
	Ieh34t9a4SQTwvda1R/MeVHPw/AblCygxyzmI4UfLUJYgQfHvT5qk1bJCMWZ8w9EOhLMnmOyCS2
	K8M65KMTgUyVrDLlEB6FWlfDnxqDVw90EwiFUd9ct
X-Gm-Gg: ASbGncvgitHB9U6XCPGww1vRfYAiAgKz/wZFdlfGleLlPb8XEQXHLTzMNPnntPDg1G4
	Dcsfra3qWpQnWgHqA1Xnya9zzU24SNr8ytuHCEm3TNUBXbb4FPS11M+OgWpSgLhRNKf7En58jbW
	GX2TvcmHs8kK/p+eBKup+bFcSq3u+h6c1cspw01xN0FpTn3y6kHbuUrla+qGrHiB/a3tw5Z22n
X-Google-Smtp-Source: AGHT+IE0v5e5VZJRL6w+PBmxwvEheQj2gMotVzZfq8y9XBsStgRHMrIshHub3eymez7yI3XacsJ4BXxBtFDAdpfRNIY=
X-Received: by 2002:a05:6e02:2206:b0:3dd:a607:3672 with SMTP id
 e9e14a558f8ab-3ddbf994a56mr367295ab.25.1748987727293; Tue, 03 Jun 2025
 14:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529052322.381947-1-irogers@google.com> <20250529052322.381947-2-irogers@google.com>
 <aDjBtuxyumBrn70B@x1> <CAP-5=fXonwoMOqfK30bo1i438cDa7oTWOOWFwJNXY9UOMBpkCQ@mail.gmail.com>
 <CAP-5=fXg-gQVYwdLpWkkD+egqpq1KbPjUt3cXXa+Msm5hSU9PA@mail.gmail.com>
In-Reply-To: <CAP-5=fXg-gQVYwdLpWkkD+egqpq1KbPjUt3cXXa+Msm5hSU9PA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Jun 2025 14:55:16 -0700
X-Gm-Features: AX0GCFsFs2vd10E43J1GVFY0oDkux1-wvR-YB894JkKGyI-LhpER9OI64FqhvNs
Message-ID: <CAP-5=fVGptvc5KQUJ3uE9DNh693Z1oYkt6GMQG+MfFa3Nf09Hw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf debug: Add function symbols to dump_stack
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Michael Petlan <mpetlan@redhat.com>, 
	Andi Kleen <ak@linux.intel.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 10:32=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, May 29, 2025 at 3:02=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, May 29, 2025 at 1:21=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Wed, May 28, 2025 at 10:23:22PM -0700, Ian Rogers wrote:
> > > > Symbolize stack traces by creating a live machine. Add this
> > > > functionality to dump_stack and switch dump_stack users to use
> > > > it. Switch TUI to use it. Add stack traces to the child test functi=
on
> > > > which can be useful to diagnose blocked code.
> > > >
> > > > Example output:
> > > > ```
> > > >   8: PERF_RECORD_* events & perf_sample fields                     =
  : Running (1 active)
> > > > ^C
> > > > Signal (2) while running tests.
> > > > Terminating tests with the same signal
> > > > Internal test harness failure. Completing any started tests:
> > > > :  8: PERF_RECORD_* events & perf_sample fields:
> > >
> > > So you are testing it with:
> > >
> > > root@number:~# perf test PERF_RECORD
> > >   8: PERF_RECORD_* events & perf_sample fields                       =
: Running (1 active)
> > > ^C
> > > Signal (2) while running tests.
> > > Terminating tests with the same signal
> > > Internal test harness failure. Completing any started tests:
> > >   8: PERF_RECORD_* events & perf_sample fields                       =
: Skip (permissions)
> > > root@number:~#
> > >
> > > ?
> >
> > You are running the test as a child and by default the child test
> > output is only displayed if verbose is enabled. I use verbose=3D2 below
> > as verbose=3D1 won't display anything unless the child test gives a fai=
l
> > exit value:
> > ```
> > $ git log --oneline
> > b9ac06abfde9 perf debug: Add function symbols to dump_stack
> > e561806265ed perf machine: Factor creating a "live" machine out of dwar=
f-unwind
> > 628e124404b3 perf tests switch-tracking: Fix timestamp comparison
> > $ make -C tools/perf O=3D/tmp/perf
> > ...
> > $ sudo /tmp/perf/perf test -vv PERF_RECORD
> >  8: PERF_RECORD_* events & perf_sample fields:
> >  8: PERF_RECORD_* events & perf_sample fields                       :
> > Running (1 active)
> > ^C
> > Signal (2) while running tests.
> > Terminating tests with the same signal
> > Internal test harness failure. Completing any started tests:
> > :  8: PERF_RECORD_* events & perf_sample fields:
> >
> > ---- unexpected signal (2) ----
> >    #0 0x5617ec45e5e3 in child_test_sig_handler builtin-test.c:0
> >    #1 0x7f855c649df0 in __restore_rt libc_sigaction.c:0
> >    #2 0x7f855c699687 in __internal_syscall_cancel cancellation.c:64
> >    #3 0x7f855c6e5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:7=
2
> >    #4 0x7f855c6f1393 in __nanosleep nanosleep.c:26
> >    #5 0x7f855c702d68 in __sleep sleep.c:55
> >    #6 0x5617ec46ebfb in test__PERF_RECORD perf-record.c:0
> >    #7 0x5617ec45e4f0 in run_test_child builtin-test.c:0
> >    #8 0x5617ec3faf0d in start_command run-command.c:127
> >    #9 0x5617ec45f433 in __cmd_test builtin-test.c:0
> >    #10 0x5617ec45faff in cmd_test perf[147aff]
> >    #11 0x5617ec3ed960 in run_builtin perf.c:0
> >    #12 0x5617ec3edc7b in handle_internal_command perf.c:0
> >    #13 0x5617ec368d33 in main perf[50d33]
> >    #14 0x7f855c633ca8 in __libc_start_call_main libc_start_call_main.h:=
74
> >    #15 0x7f855c633d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
> >    #16 0x5617ec369381 in _start perf[51381]
> >
> > ---- unexpected signal (2) ----
> >    #0 0x5617ec45e5e3 in child_test_sig_handler builtin-test.c:0
> >    #1 0x7f855c649df0 in __restore_rt libc_sigaction.c:0
> >    #2 0x7f855c6a3a14 in pthread_sigmask@GLIBC_2.2.5 pthread_sigmask.c:4=
5
> >    #3 0x7f855c649fd9 in __GI___sigprocmask sigprocmask.c:26
> >    #4 0x7f855c72601b in __longjmp_chk longjmp.c:36
> >    #5 0x5617ec45e600 in print_test_result.isra.0 builtin-test.c:0
> >    #6 0x7f855c649df0 in __restore_rt libc_sigaction.c:0
> >    #7 0x7f855c699687 in __internal_syscall_cancel cancellation.c:64
> >    #8 0x7f855c6e5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:7=
2
> >    #9 0x7f855c6f1393 in __nanosleep nanosleep.c:26
> >    #10 0x7f855c702d68 in __sleep sleep.c:55
> >    #11 0x5617ec46ebfb in test__PERF_RECORD perf-record.c:0
> >    #12 0x5617ec45e4f0 in run_test_child builtin-test.c:0
> >    #13 0x5617ec3faf0d in start_command run-command.c:127
> >    #14 0x5617ec45f433 in __cmd_test builtin-test.c:0
> >    #15 0x5617ec45faff in cmd_test perf[147aff]
> >    #16 0x5617ec3ed960 in run_builtin perf.c:0
> >    #17 0x5617ec3edc7b in handle_internal_command perf.c:0
> >    #18 0x5617ec368d33 in main perf[50d33]
> >    #19 0x7f855c633ca8 in __libc_start_call_main libc_start_call_main.h:=
74
> >    #20 0x7f855c633d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
> >    #21 0x5617ec369381 in _start perf[51381]
> >  8: PERF_RECORD_* events & perf_sample fields                       :
> > Skip (permissions)
> > ```
> >
> >
> > > I built it with DEBUG=3D1 and without, and with your patch, following=
 your
> > > example output, I'm not being able to reproduce.
> > >
> > > Tried it as well with:
> > >
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$ cat segv.patch
> > > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > > index 8b30c6f16a9eeac1..e55d86f1097d6d79 100644
> > > --- a/tools/perf/util/symbol.c
> > > +++ b/tools/perf/util/symbol.c
> > > @@ -402,6 +402,8 @@ static struct symbol *symbols__find(struct rb_roo=
t_cached *symbols, u64 ip)
> > >  {
> > >         struct rb_node *n;
> > >
> > > +       *(int *)NULL =3D 0;
> > > +
> > >         if (symbols =3D=3D NULL)
> > >                 return NULL;
> > >
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$ patch -p1 < segv.patch
> > > patching file tools/perf/util/symbol.c
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$ m
> > > rm: cannot remove '/home/acme/libexec/perf-core/scripts/python/Perf-T=
race-Util/lib/Perf/Trace/__pycache__/Core.cpython-313.pyc': Permission deni=
ed
> > > make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> > >   BUILD:   Doing 'make -j32' parallel build
> > > Warning: Kernel ABI header differences:
> > >   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/a=
sm/cputype.h
> > >
> > > Auto-detecting system features:
> > > ...                                   libdw: [ on  ]
> > > ...                                   glibc: [ on  ]
> > > ...                                  libelf: [ on  ]
> > > ...                                 libnuma: [ on  ]
> > > ...                  numa_num_possible_cpus: [ on  ]
> > > ...                                 libperl: [ on  ]
> > > ...                               libpython: [ on  ]
> > > ...                               libcrypto: [ on  ]
> > > ...                             libcapstone: [ on  ]
> > > ...                               llvm-perf: [ on  ]
> > > ...                                    zlib: [ on  ]
> > > ...                                    lzma: [ on  ]
> > > ...                               get_cpuid: [ on  ]
> > > ...                                     bpf: [ on  ]
> > > ...                                  libaio: [ on  ]
> > > ...                                 libzstd: [ on  ]
> > >
> > >   INSTALL libsubcmd_headers
> > >   INSTALL libperf_headers
> > >   INSTALL libapi_headers
> > >   INSTALL libsymbol_headers
> > >   INSTALL libbpf_headers
> > >   CC      /tmp/build/perf-tools-next/util/symbol.o
> > >   LD      /tmp/build/perf-tools-next/util/perf-util-in.o
> > >   LD      /tmp/build/perf-tools-next/perf-util-in.o
> > >   AR      /tmp/build/perf-tools-next/libperf-util.a
> > >   LINK    /tmp/build/perf-tools-next/perf
> > >   GEN     /tmp/build/perf-tools-next/python/perf.cpython-313-x86_64-l=
inux-gnu.so
> > >   INSTALL binaries
> > >   INSTALL tests
> > >   INSTALL libperf-jvmti.so
> > >   INSTALL libexec
> > >   INSTALL perf-archive
> > >   INSTALL perf-iostat
> > >   INSTALL perl-scripts
> > >   INSTALL python-scripts
> > >   INSTALL dlfilters
> > >   INSTALL perf_completion-script
> > >   INSTALL perf-tip
> > > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> > >  18: 'import perf' in python                                         =
: Ok
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$
> > >
> > > root@number:~# perf top
> > > perf: Segmentation fault
> > > -------- backtrace --------
> > > Segmentation fault (core dumped)
> > > root@number:~#
> > >
> > > Tried also with this, but probably something else is at play:
> > >
> > > root@number:~# perf probe -x ~/bin/perf dump_stack
> > > Added new event:
> > >   probe_perf:dump_stack (on dump_stack in /home/acme/bin/perf)
> > >
> > > You can now use it in all perf tools, such as:
> > >
> > >         perf record -e probe_perf:dump_stack -aR sleep 1
> > >
> > > root@number:~#
> > > root@number:~# perf trace -e probe_perf:dump_stack/max-stack=3D16/ pe=
rf top
> > > perf: Segmentation fault
> > > -------- backtrace --------
> > > root@number:~#
> > >
> > > Running perf trace on a separate terminal it also doesn't catch
> > > dump_stack being called (that probe point).
> > >
> > > root@number:~# perf top --stdio
> > >    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 dr=
op: 0/0 [4000Hz cycles:P],  (all, 32 CPUs)
> > > ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------------
> > >
> > > perf: Segmentation fault
> > > Segmentation fault (core dumped)
> > > root@number:~#
> > >
> > > root@number:~# nm ~/bin/perf | grep dump_stack
> > > 0000000000637eaa T __dump_stack
> > > 00000000006380fa T dump_stack
> > > 000000000063816b T sighandler_dump_stack
> > > root@number:~#
> > >
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$ rpm -q glibc
> > > glibc-2.41-5.fc42.x86_64
> > > root@number:~# uname -a
> > > Linux number 6.14.8-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Thu May 22=
 19:26:02 UTC 2025 x86_64 GNU/Linux
> > > root@number:~#
> > >
> > > What am I missing?
> >
> > For perf top I can do:
> > ```
> > $ sudo /tmp/perf/perf top
> > ```
> > in a different terminal:
> > ```
> > $ sudo killall -11 perf
> > ```
> > then back in the first terminal:
> > ```
> > perf: Segmentation fault
> > -------- backtrace --------
> >    #0 0x55ee68647918 in ui__signal_backtrace setup.c:110
> >    #1 0x7fe2d3849df0 in __restore_rt libc_sigaction.c:0
> >    #2 0x7fe2d38a49ee in __syscall_cancel_arch syscall_cancel.S:56
> >    #3 0x7fe2d3899668 in __internal_syscall_cancel cancellation.c:54
> >    #4 0x7fe2d38996ad in __syscall_cancel cancellation.c:79
> >    #5 0x7fe2d390d9c6 in __poll poll.c:43
> >    #6 0x55ee6855dfcb in fdarray__poll array.c:139
> >    #7 0x55ee68565a05 in perf_evlist__poll evlist.c:391
> >    #8 0x55ee68673b5a in evlist__poll evlist.c:594
> >    #9 0x55ee684e7a61 in __cmd_top builtin-top.c:1369
> >    #10 0x55ee684e9a6c in cmd_top builtin-top.c:1856
> >    #11 0x55ee6855d1f0 in run_builtin perf.c:351
> >    #12 0x55ee6855d497 in handle_internal_command perf.c:404
> >    #13 0x55ee6855d5f0 in run_argv perf.c:451
> >    #14 0x55ee6855d939 in main perf.c:558
> >    #15 0x7fe2d3833ca8 in __libc_start_call_main libc_start_call_main.h:=
74
> >    #16 0x7fe2d3833d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
> >    #17 0x55ee684b0a91 in _start perf[4ca91]
> > ```
> > As the same symbol code is used for the backtrace then adding the segv
> > there is likely causing a segv in the signal handler in __dump_stack.
>
> Just to note, it would be nice for this to land as I need to rebase:
> https://lore.kernel.org/lkml/20250529044000.759937-19-irogers@google.com/
> due to the machine changes. I believe the patches are WAI as shown in
> the output.

Ok, I see this made it into v6.16 PR:
https://lore.kernel.org/lkml/20250603203501.1961487-1-acme@kernel.org/

Thanks Arnaldo!
Ian
