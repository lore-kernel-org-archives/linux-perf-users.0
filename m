Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA7246766
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749679545; cv=none; b=V60Nsa+wv2g5XJvV3k1gP3gl313/ZFl+2cTv64e9Cek80HgdRyqQvOIFT7hRpxK/IZwHQBwR7szgYOYMTh/VOZQ8/JmQW8l3Ps+MmIMw1iiooSshnFCcNqUtR4W6S1SKxo5z7VUmVQOeLSeddNLnC7MOtYTUY2sJ1AmRqdRhaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749679545; c=relaxed/simple;
	bh=sEX77P0MO+vil+ZpOisgyJ/HTy6z2qtfwCCpVReEcp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaA5ZFXMJtCkKdS8gv31AM92P03mX/4Ht3Tfox5Zda9pYvssCM44AD7bQ0iBj767bqcLkOWQOQD1j1Tf0wm5GM6oDqCg4f0dt58FWNeX71mGVk/JDSGpR/Hmf663CKtTTMirl5sB6ikI8q2JTm8Kh+UTStUF0Hf/MlGld3Oz3Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CEqy3A7v; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEqy3A7v"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so57945ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749679541; x=1750284341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reLosr06TrLHFm6cpSf4Kzju6Dfoth2pVMr4f8PSzO4=;
        b=CEqy3A7v8Asr4oQi6hIX8f+6uUmteob5HvfNzQzISondBR4O6sBbBDUNtzK0L3oUTq
         TjGbZ2YovLbhqZ6xi8jMHprDyUylo5Bh/gCg2qxSBktKOBO00AqMJXD191Cu62l94Jgj
         225oEvojAWr+BMLKmKAcfBOMxhfMTQ081aBVWmq7c7rv5KgG48IIToFHP5pJonq69yKN
         Kl2rp9iStUkMAP5oo0gEMa+FSXKhK1Pu1cXwed0mx279VSVLH+dGxZAFaBm1H0sYWH+l
         ghOT83TB7zMNYm/BAjYOxnB/aL6TAzz1boNluBhJqarSKZe72swV//jXvXFXu6rU2taA
         K3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749679541; x=1750284341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reLosr06TrLHFm6cpSf4Kzju6Dfoth2pVMr4f8PSzO4=;
        b=wgJnXFq7c9fPtXSaw3ztfP89Jok6S2f7wCbYc4qVW8p4COR9ObA0jqWTZArmkqSjGh
         tg+IlATWo/YiG1TpXXieVYeRTQXITVRKBDwahvIfau/hvnMWNY6QszJViy82TXy5ZHIk
         AazEinNqfiC4aML0S9VWcl3ccvekwd+cft5jHnEgY9LLNS+mnvYfY9KKcbVLS/pdA1ai
         3ckURKfaRGHtK+qOTXMVBC/ZEiv83r3zA/eDTyr1SvH7t3LevufFEQQklmRVFhW2/tDO
         IO3T0LPSJ8KgmSgfsTHHzDaesc8AQJSnv670/Wx3hVF7r2jFm+p/erOKWJ2Oj879wK5W
         KhoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjncrdwTu3F1eUf0f5Z79nyjs9idILO93iGqiZUAvEaJ3nFWYcBtzoGyPUi2O1d7/mdUmoK0z43yj8SdDpLgr0@vger.kernel.org
X-Gm-Message-State: AOJu0YyCDGqBIIfafS5tvvUU5QL9+vC+1n+JydBt9nebYGTTA+nwG0yf
	Pkg0VNlN33Ch0NWeEBCL/VulCCJvC8Nlyh4b9uKrI59dHd5f9bnjoFZNEvWs11ydWsQsAtm+ZkY
	ldngCTTTXtmGCetbQ/3Qp5BHfxYMmBWbJVOGa8kGt
X-Gm-Gg: ASbGncsQrl2wkn0j0A7JgeplU3yk9qNoYGrY6Zf3adkd6UxUMXHTLao5+yxxkxNeibQ
	w9wj0dM8y2FjGbBEweaiQ4gnqoKLdJWt57BglVerHoHJoqZid+VH8EwFCDQwFm3SmDDd+pdpaM4
	v/xMVptmfteEwBcdxNzcfPipJ5Vlgg1mDX6CvI0eKJa0mZaHUfKBcdQSFLpdz6D0oJwfwK5xcA
X-Google-Smtp-Source: AGHT+IHzdVBH834oO8Lcw+o27OrEeNpQDQLxdJapoXf2t/m8DK0uNcG4r/C4ZFy5u8MaZVT3YQGcfmPKa5Dn0P51gZs=
X-Received: by 2002:a05:6e02:1d84:b0:3dc:802f:2617 with SMTP id
 e9e14a558f8ab-3ddfb49fb55mr886665ab.28.1749679540684; Wed, 11 Jun 2025
 15:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529052322.381947-1-irogers@google.com> <20250529052322.381947-2-irogers@google.com>
 <aDjBtuxyumBrn70B@x1> <CAP-5=fXonwoMOqfK30bo1i438cDa7oTWOOWFwJNXY9UOMBpkCQ@mail.gmail.com>
 <CAP-5=fXg-gQVYwdLpWkkD+egqpq1KbPjUt3cXXa+Msm5hSU9PA@mail.gmail.com> <CAP-5=fVGptvc5KQUJ3uE9DNh693Z1oYkt6GMQG+MfFa3Nf09Hw@mail.gmail.com>
In-Reply-To: <CAP-5=fVGptvc5KQUJ3uE9DNh693Z1oYkt6GMQG+MfFa3Nf09Hw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Jun 2025 15:05:28 -0700
X-Gm-Features: AX0GCFtVCbjp6-ULeZ2SwT4D9b2MO37UUZDVM9-6Nj_kwFmhRFQOy9P4jyU3gWg
Message-ID: <CAP-5=fWbXEv+MLtsF30PTOGMz9Wcu7WG2TkF5x=so9DBm6eKvQ@mail.gmail.com>
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

On Tue, Jun 3, 2025 at 2:55=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Mon, Jun 2, 2025 at 10:32=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, May 29, 2025 at 3:02=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Thu, May 29, 2025 at 1:21=E2=80=AFPM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Wed, May 28, 2025 at 10:23:22PM -0700, Ian Rogers wrote:
> > > > > Symbolize stack traces by creating a live machine. Add this
> > > > > functionality to dump_stack and switch dump_stack users to use
> > > > > it. Switch TUI to use it. Add stack traces to the child test func=
tion
> > > > > which can be useful to diagnose blocked code.
> > > > >
> > > > > Example output:
> > > > > ```
> > > > >   8: PERF_RECORD_* events & perf_sample fields                   =
    : Running (1 active)
> > > > > ^C
> > > > > Signal (2) while running tests.
> > > > > Terminating tests with the same signal
> > > > > Internal test harness failure. Completing any started tests:
> > > > > :  8: PERF_RECORD_* events & perf_sample fields:
> > > >
> > > > So you are testing it with:
> > > >
> > > > root@number:~# perf test PERF_RECORD
> > > >   8: PERF_RECORD_* events & perf_sample fields                     =
  : Running (1 active)
> > > > ^C
> > > > Signal (2) while running tests.
> > > > Terminating tests with the same signal
> > > > Internal test harness failure. Completing any started tests:
> > > >   8: PERF_RECORD_* events & perf_sample fields                     =
  : Skip (permissions)
> > > > root@number:~#
> > > >
> > > > ?
> > >
> > > You are running the test as a child and by default the child test
> > > output is only displayed if verbose is enabled. I use verbose=3D2 bel=
ow
> > > as verbose=3D1 won't display anything unless the child test gives a f=
ail
> > > exit value:
> > > ```
> > > $ git log --oneline
> > > b9ac06abfde9 perf debug: Add function symbols to dump_stack
> > > e561806265ed perf machine: Factor creating a "live" machine out of dw=
arf-unwind
> > > 628e124404b3 perf tests switch-tracking: Fix timestamp comparison
> > > $ make -C tools/perf O=3D/tmp/perf
> > > ...
> > > $ sudo /tmp/perf/perf test -vv PERF_RECORD
> > >  8: PERF_RECORD_* events & perf_sample fields:
> > >  8: PERF_RECORD_* events & perf_sample fields                       :
> > > Running (1 active)
> > > ^C
> > > Signal (2) while running tests.
> > > Terminating tests with the same signal
> > > Internal test harness failure. Completing any started tests:
> > > :  8: PERF_RECORD_* events & perf_sample fields:
> > >
> > > ---- unexpected signal (2) ----
> > >    #0 0x5617ec45e5e3 in child_test_sig_handler builtin-test.c:0
> > >    #1 0x7f855c649df0 in __restore_rt libc_sigaction.c:0
> > >    #2 0x7f855c699687 in __internal_syscall_cancel cancellation.c:64
> > >    #3 0x7f855c6e5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c=
:72
> > >    #4 0x7f855c6f1393 in __nanosleep nanosleep.c:26
> > >    #5 0x7f855c702d68 in __sleep sleep.c:55
> > >    #6 0x5617ec46ebfb in test__PERF_RECORD perf-record.c:0
> > >    #7 0x5617ec45e4f0 in run_test_child builtin-test.c:0
> > >    #8 0x5617ec3faf0d in start_command run-command.c:127
> > >    #9 0x5617ec45f433 in __cmd_test builtin-test.c:0
> > >    #10 0x5617ec45faff in cmd_test perf[147aff]
> > >    #11 0x5617ec3ed960 in run_builtin perf.c:0
> > >    #12 0x5617ec3edc7b in handle_internal_command perf.c:0
> > >    #13 0x5617ec368d33 in main perf[50d33]
> > >    #14 0x7f855c633ca8 in __libc_start_call_main libc_start_call_main.=
h:74
> > >    #15 0x7f855c633d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:1=
28
> > >    #16 0x5617ec369381 in _start perf[51381]
> > >
> > > ---- unexpected signal (2) ----
> > >    #0 0x5617ec45e5e3 in child_test_sig_handler builtin-test.c:0
> > >    #1 0x7f855c649df0 in __restore_rt libc_sigaction.c:0
> > >    #2 0x7f855c6a3a14 in pthread_sigmask@GLIBC_2.2.5 pthread_sigmask.c=
:45
> > >    #3 0x7f855c649fd9 in __GI___sigprocmask sigprocmask.c:26
> > >    #4 0x7f855c72601b in __longjmp_chk longjmp.c:36
> > >    #5 0x5617ec45e600 in print_test_result.isra.0 builtin-test.c:0
> > >    #6 0x7f855c649df0 in __restore_rt libc_sigaction.c:0
> > >    #7 0x7f855c699687 in __internal_syscall_cancel cancellation.c:64
> > >    #8 0x7f855c6e5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c=
:72
> > >    #9 0x7f855c6f1393 in __nanosleep nanosleep.c:26
> > >    #10 0x7f855c702d68 in __sleep sleep.c:55
> > >    #11 0x5617ec46ebfb in test__PERF_RECORD perf-record.c:0
> > >    #12 0x5617ec45e4f0 in run_test_child builtin-test.c:0
> > >    #13 0x5617ec3faf0d in start_command run-command.c:127
> > >    #14 0x5617ec45f433 in __cmd_test builtin-test.c:0
> > >    #15 0x5617ec45faff in cmd_test perf[147aff]
> > >    #16 0x5617ec3ed960 in run_builtin perf.c:0
> > >    #17 0x5617ec3edc7b in handle_internal_command perf.c:0
> > >    #18 0x5617ec368d33 in main perf[50d33]
> > >    #19 0x7f855c633ca8 in __libc_start_call_main libc_start_call_main.=
h:74
> > >    #20 0x7f855c633d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:1=
28
> > >    #21 0x5617ec369381 in _start perf[51381]
> > >  8: PERF_RECORD_* events & perf_sample fields                       :
> > > Skip (permissions)
> > > ```
> > >
> > >
> > > > I built it with DEBUG=3D1 and without, and with your patch, followi=
ng your
> > > > example output, I'm not being able to reproduce.
> > > >
> > > > Tried it as well with:
> > > >
> > > > =E2=AC=A2 [acme@toolbx perf-tools-next]$ cat segv.patch
> > > > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > > > index 8b30c6f16a9eeac1..e55d86f1097d6d79 100644
> > > > --- a/tools/perf/util/symbol.c
> > > > +++ b/tools/perf/util/symbol.c
> > > > @@ -402,6 +402,8 @@ static struct symbol *symbols__find(struct rb_r=
oot_cached *symbols, u64 ip)
> > > >  {
> > > >         struct rb_node *n;
> > > >
> > > > +       *(int *)NULL =3D 0;
> > > > +
> > > >         if (symbols =3D=3D NULL)
> > > >                 return NULL;
> > > >
> > > > =E2=AC=A2 [acme@toolbx perf-tools-next]$ patch -p1 < segv.patch
> > > > patching file tools/perf/util/symbol.c
> > > > =E2=AC=A2 [acme@toolbx perf-tools-next]$ m
> > > > rm: cannot remove '/home/acme/libexec/perf-core/scripts/python/Perf=
-Trace-Util/lib/Perf/Trace/__pycache__/Core.cpython-313.pyc': Permission de=
nied
> > > > make: Entering directory '/home/acme/git/perf-tools-next/tools/perf=
'
> > > >   BUILD:   Doing 'make -j32' parallel build
> > > > Warning: Kernel ABI header differences:
> > > >   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include=
/asm/cputype.h
> > > >
> > > > Auto-detecting system features:
> > > > ...                                   libdw: [ on  ]
> > > > ...                                   glibc: [ on  ]
> > > > ...                                  libelf: [ on  ]
> > > > ...                                 libnuma: [ on  ]
> > > > ...                  numa_num_possible_cpus: [ on  ]
> > > > ...                                 libperl: [ on  ]
> > > > ...                               libpython: [ on  ]
> > > > ...                               libcrypto: [ on  ]
> > > > ...                             libcapstone: [ on  ]
> > > > ...                               llvm-perf: [ on  ]
> > > > ...                                    zlib: [ on  ]
> > > > ...                                    lzma: [ on  ]
> > > > ...                               get_cpuid: [ on  ]
> > > > ...                                     bpf: [ on  ]
> > > > ...                                  libaio: [ on  ]
> > > > ...                                 libzstd: [ on  ]
> > > >
> > > >   INSTALL libsubcmd_headers
> > > >   INSTALL libperf_headers
> > > >   INSTALL libapi_headers
> > > >   INSTALL libsymbol_headers
> > > >   INSTALL libbpf_headers
> > > >   CC      /tmp/build/perf-tools-next/util/symbol.o
> > > >   LD      /tmp/build/perf-tools-next/util/perf-util-in.o
> > > >   LD      /tmp/build/perf-tools-next/perf-util-in.o
> > > >   AR      /tmp/build/perf-tools-next/libperf-util.a
> > > >   LINK    /tmp/build/perf-tools-next/perf
> > > >   GEN     /tmp/build/perf-tools-next/python/perf.cpython-313-x86_64=
-linux-gnu.so
> > > >   INSTALL binaries
> > > >   INSTALL tests
> > > >   INSTALL libperf-jvmti.so
> > > >   INSTALL libexec
> > > >   INSTALL perf-archive
> > > >   INSTALL perf-iostat
> > > >   INSTALL perl-scripts
> > > >   INSTALL python-scripts
> > > >   INSTALL dlfilters
> > > >   INSTALL perf_completion-script
> > > >   INSTALL perf-tip
> > > > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> > > >  18: 'import perf' in python                                       =
  : Ok
> > > > =E2=AC=A2 [acme@toolbx perf-tools-next]$
> > > >
> > > > root@number:~# perf top
> > > > perf: Segmentation fault
> > > > -------- backtrace --------
> > > > Segmentation fault (core dumped)
> > > > root@number:~#
> > > >
> > > > Tried also with this, but probably something else is at play:
> > > >
> > > > root@number:~# perf probe -x ~/bin/perf dump_stack
> > > > Added new event:
> > > >   probe_perf:dump_stack (on dump_stack in /home/acme/bin/perf)
> > > >
> > > > You can now use it in all perf tools, such as:
> > > >
> > > >         perf record -e probe_perf:dump_stack -aR sleep 1
> > > >
> > > > root@number:~#
> > > > root@number:~# perf trace -e probe_perf:dump_stack/max-stack=3D16/ =
perf top
> > > > perf: Segmentation fault
> > > > -------- backtrace --------
> > > > root@number:~#
> > > >
> > > > Running perf trace on a separate terminal it also doesn't catch
> > > > dump_stack being called (that probe point).
> > > >
> > > > root@number:~# perf top --stdio
> > > >    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 =
drop: 0/0 [4000Hz cycles:P],  (all, 32 CPUs)
> > > > -------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------------
> > > >
> > > > perf: Segmentation fault
> > > > Segmentation fault (core dumped)
> > > > root@number:~#
> > > >
> > > > root@number:~# nm ~/bin/perf | grep dump_stack
> > > > 0000000000637eaa T __dump_stack
> > > > 00000000006380fa T dump_stack
> > > > 000000000063816b T sighandler_dump_stack
> > > > root@number:~#
> > > >
> > > > =E2=AC=A2 [acme@toolbx perf-tools-next]$ rpm -q glibc
> > > > glibc-2.41-5.fc42.x86_64
> > > > root@number:~# uname -a
> > > > Linux number 6.14.8-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Thu May =
22 19:26:02 UTC 2025 x86_64 GNU/Linux
> > > > root@number:~#
> > > >
> > > > What am I missing?
> > >
> > > For perf top I can do:
> > > ```
> > > $ sudo /tmp/perf/perf top
> > > ```
> > > in a different terminal:
> > > ```
> > > $ sudo killall -11 perf
> > > ```
> > > then back in the first terminal:
> > > ```
> > > perf: Segmentation fault
> > > -------- backtrace --------
> > >    #0 0x55ee68647918 in ui__signal_backtrace setup.c:110
> > >    #1 0x7fe2d3849df0 in __restore_rt libc_sigaction.c:0
> > >    #2 0x7fe2d38a49ee in __syscall_cancel_arch syscall_cancel.S:56
> > >    #3 0x7fe2d3899668 in __internal_syscall_cancel cancellation.c:54
> > >    #4 0x7fe2d38996ad in __syscall_cancel cancellation.c:79
> > >    #5 0x7fe2d390d9c6 in __poll poll.c:43
> > >    #6 0x55ee6855dfcb in fdarray__poll array.c:139
> > >    #7 0x55ee68565a05 in perf_evlist__poll evlist.c:391
> > >    #8 0x55ee68673b5a in evlist__poll evlist.c:594
> > >    #9 0x55ee684e7a61 in __cmd_top builtin-top.c:1369
> > >    #10 0x55ee684e9a6c in cmd_top builtin-top.c:1856
> > >    #11 0x55ee6855d1f0 in run_builtin perf.c:351
> > >    #12 0x55ee6855d497 in handle_internal_command perf.c:404
> > >    #13 0x55ee6855d5f0 in run_argv perf.c:451
> > >    #14 0x55ee6855d939 in main perf.c:558
> > >    #15 0x7fe2d3833ca8 in __libc_start_call_main libc_start_call_main.=
h:74
> > >    #16 0x7fe2d3833d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:1=
28
> > >    #17 0x55ee684b0a91 in _start perf[4ca91]
> > > ```
> > > As the same symbol code is used for the backtrace then adding the seg=
v
> > > there is likely causing a segv in the signal handler in __dump_stack.
> >
> > Just to note, it would be nice for this to land as I need to rebase:
> > https://lore.kernel.org/lkml/20250529044000.759937-19-irogers@google.co=
m/
> > due to the machine changes. I believe the patches are WAI as shown in
> > the output.
>
> Ok, I see this made it into v6.16 PR:
> https://lore.kernel.org/lkml/20250603203501.1961487-1-acme@kernel.org/

Actually just the first patch. I'll rebase and resend just patch 2 as v3.

Thanks,
Ian
