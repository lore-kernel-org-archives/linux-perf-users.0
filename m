Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC12A226D1D
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Jun 2025 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748885567; cv=none; b=Dhm+ACBLB7ykQ/NCP+qL76V6BgluJbxyUtiaDPSuJEyUucdBOQDOn+fJyG/HrrSAZ01xuD59weda7M1L//88DJW7ZJt0IeqfdUzIE337bp18imnnjBmkjPh9TIStmGVMxGGXE95aS25BtO+AaavJlng+8IoNd+8UooMZOkqxioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748885567; c=relaxed/simple;
	bh=7jYWFXrW6RLJwuOEEVuDgjTHVx/PAKmRw3/YDgRK2WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxDnjmmlhEd5e+cLLas5DflzCsUAKRZ/8sYlvWFpVqXUzEQYUTdKsQL1PXLV9ApkW+y+zQNvUMf9EbuqSSFyVC5nUNvDolloHvBXe/cxUtynCT6tjSZyWYsCbUzPNgpb9rgtPkugnpeIHP5Hht60/MB+2cWoCaDfcfMyW1EsLno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJQcKhgh; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJQcKhgh"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3dd745f8839so12255ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Jun 2025 10:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748885564; x=1749490364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWyCHnPpsz5jiOCC5fkQdcz/qdjcO8jI9QCn4djS++A=;
        b=gJQcKhghhL/5+O/glMhADxeWNtzf/Q5J34btgibhm2jx81eloDiFUX1eKbr1iWx64Y
         8rw1XgcCXGzUZKUDvMocZIRR4fqPjVaQlc9zKwiMmGf7RMUH7tKV5ngq5zIJROgHYIkX
         bMEJHPItoYl2Txrob/02IjgpYedUtoHmvCdqYQldXUduNcyCAMJj2qw9xEWXsrRYTmtU
         CfyPFw2PLW+oJ0909FHxVlDiBQrQdjn1+7FZdUat23zPQ9Pl6gRi4VkicFmdKI3JDoQg
         nQ1p5kJ83vgxeAFVQcLV1xGk0Sx7ynsfGU6TsfVS8R8SmOG4yfGVEsXi2McjhWBnaIse
         WJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748885564; x=1749490364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWyCHnPpsz5jiOCC5fkQdcz/qdjcO8jI9QCn4djS++A=;
        b=GgQrzhMMONcqcEi3XxFMSoIzVdeg2QxfYM6m+46DBYuyqL871QXuSOrw9AYbP6ukZf
         i1R4NPopFG/+M6Xfw82oK7LLrNW8QxZuUt1PZ+y+iAVGW1GK1AAjJrELeWMDaSJq+2ih
         B7QTus0UcImhlrmznByaqhycT9wbxyveYESbwygiUrHpAJfmr8GokPkE7GsoSgJCNeh1
         G2qiunr0Jnw3JIxZtpFtnhz7ErIab63eWWvBoTmhLY0D3DaAlko9DQjwsOnYWwdjOGYP
         onglvVShMjOzABk/dmhXMQ0GRRAPor0rjX7IDzpO/EXDQCQTBcT6/L46Zu8Ox5objMoc
         PHPw==
X-Forwarded-Encrypted: i=1; AJvYcCU59BTQEREqulykLOKW1cAAmkusVCzoxfMy3C1FGg+JWkpiDojUhMntSrFyEjxKjJFhJwgMMmGrV1jDqtkBFoUM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/acGs3yLQYrM/7BisOOtbt1MijQBC2cfFiWy2qd5yv+KblXUK
	rN/Tf+FN8sys2Zw4kPQTTvR18npRsd67/nHF92ovF+NBCZOejYRTEAGxC4GU9Ot3xHxFDqoDgFM
	hyKinVMu80G/W7d6LaX1bwEKIyE8GJAYQtgC4LKK/
X-Gm-Gg: ASbGncsB4HEYzxWkzRpRbpXDKfFC5JZfeDzjusHWheLSOWlp5VoUlyHSg9vVc8pyzpE
	FfWxaje99m9PUB2zskc2KWm9FflhrV7wU2joWN2PHo3oGusn6COFoSjdlNZ89aV/Zi10WcAdEWN
	4lgmQwVqLdnXrcuN7kvLvl1ZN3XMcCVmVMOZ4x3MrECFYk6Xcj9p5ENGZkdqo+mviAprFqqdia
X-Google-Smtp-Source: AGHT+IGcgjDveA1f2goly7nIa337NOCnuv1+3aIFsV9PYdV/9Phe1S4XNa8ammEYnRO2Px1DffFAov8T3xUobdN1Hws=
X-Received: by 2002:a05:6e02:156b:b0:3dd:a524:9470 with SMTP id
 e9e14a558f8ab-3dda5249625mr5135335ab.27.1748885546614; Mon, 02 Jun 2025
 10:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529052322.381947-1-irogers@google.com> <20250529052322.381947-2-irogers@google.com>
 <aDjBtuxyumBrn70B@x1> <CAP-5=fXonwoMOqfK30bo1i438cDa7oTWOOWFwJNXY9UOMBpkCQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXonwoMOqfK30bo1i438cDa7oTWOOWFwJNXY9UOMBpkCQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 2 Jun 2025 10:32:15 -0700
X-Gm-Features: AX0GCFtvM9h-svrhY-U-soiP0u8TEbc_-RHxISmm1FBYq42MREbKbhJ53qT0dXU
Message-ID: <CAP-5=fXg-gQVYwdLpWkkD+egqpq1KbPjUt3cXXa+Msm5hSU9PA@mail.gmail.com>
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

On Thu, May 29, 2025 at 3:02=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, May 29, 2025 at 1:21=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, May 28, 2025 at 10:23:22PM -0700, Ian Rogers wrote:
> > > Symbolize stack traces by creating a live machine. Add this
> > > functionality to dump_stack and switch dump_stack users to use
> > > it. Switch TUI to use it. Add stack traces to the child test function
> > > which can be useful to diagnose blocked code.
> > >
> > > Example output:
> > > ```
> > >   8: PERF_RECORD_* events & perf_sample fields                       =
: Running (1 active)
> > > ^C
> > > Signal (2) while running tests.
> > > Terminating tests with the same signal
> > > Internal test harness failure. Completing any started tests:
> > > :  8: PERF_RECORD_* events & perf_sample fields:
> >
> > So you are testing it with:
> >
> > root@number:~# perf test PERF_RECORD
> >   8: PERF_RECORD_* events & perf_sample fields                       : =
Running (1 active)
> > ^C
> > Signal (2) while running tests.
> > Terminating tests with the same signal
> > Internal test harness failure. Completing any started tests:
> >   8: PERF_RECORD_* events & perf_sample fields                       : =
Skip (permissions)
> > root@number:~#
> >
> > ?
>
> You are running the test as a child and by default the child test
> output is only displayed if verbose is enabled. I use verbose=3D2 below
> as verbose=3D1 won't display anything unless the child test gives a fail
> exit value:
> ```
> $ git log --oneline
> b9ac06abfde9 perf debug: Add function symbols to dump_stack
> e561806265ed perf machine: Factor creating a "live" machine out of dwarf-=
unwind
> 628e124404b3 perf tests switch-tracking: Fix timestamp comparison
> $ make -C tools/perf O=3D/tmp/perf
> ...
> $ sudo /tmp/perf/perf test -vv PERF_RECORD
>  8: PERF_RECORD_* events & perf_sample fields:
>  8: PERF_RECORD_* events & perf_sample fields                       :
> Running (1 active)
> ^C
> Signal (2) while running tests.
> Terminating tests with the same signal
> Internal test harness failure. Completing any started tests:
> :  8: PERF_RECORD_* events & perf_sample fields:
>
> ---- unexpected signal (2) ----
>    #0 0x5617ec45e5e3 in child_test_sig_handler builtin-test.c:0
>    #1 0x7f855c649df0 in __restore_rt libc_sigaction.c:0
>    #2 0x7f855c699687 in __internal_syscall_cancel cancellation.c:64
>    #3 0x7f855c6e5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:72
>    #4 0x7f855c6f1393 in __nanosleep nanosleep.c:26
>    #5 0x7f855c702d68 in __sleep sleep.c:55
>    #6 0x5617ec46ebfb in test__PERF_RECORD perf-record.c:0
>    #7 0x5617ec45e4f0 in run_test_child builtin-test.c:0
>    #8 0x5617ec3faf0d in start_command run-command.c:127
>    #9 0x5617ec45f433 in __cmd_test builtin-test.c:0
>    #10 0x5617ec45faff in cmd_test perf[147aff]
>    #11 0x5617ec3ed960 in run_builtin perf.c:0
>    #12 0x5617ec3edc7b in handle_internal_command perf.c:0
>    #13 0x5617ec368d33 in main perf[50d33]
>    #14 0x7f855c633ca8 in __libc_start_call_main libc_start_call_main.h:74
>    #15 0x7f855c633d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
>    #16 0x5617ec369381 in _start perf[51381]
>
> ---- unexpected signal (2) ----
>    #0 0x5617ec45e5e3 in child_test_sig_handler builtin-test.c:0
>    #1 0x7f855c649df0 in __restore_rt libc_sigaction.c:0
>    #2 0x7f855c6a3a14 in pthread_sigmask@GLIBC_2.2.5 pthread_sigmask.c:45
>    #3 0x7f855c649fd9 in __GI___sigprocmask sigprocmask.c:26
>    #4 0x7f855c72601b in __longjmp_chk longjmp.c:36
>    #5 0x5617ec45e600 in print_test_result.isra.0 builtin-test.c:0
>    #6 0x7f855c649df0 in __restore_rt libc_sigaction.c:0
>    #7 0x7f855c699687 in __internal_syscall_cancel cancellation.c:64
>    #8 0x7f855c6e5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:72
>    #9 0x7f855c6f1393 in __nanosleep nanosleep.c:26
>    #10 0x7f855c702d68 in __sleep sleep.c:55
>    #11 0x5617ec46ebfb in test__PERF_RECORD perf-record.c:0
>    #12 0x5617ec45e4f0 in run_test_child builtin-test.c:0
>    #13 0x5617ec3faf0d in start_command run-command.c:127
>    #14 0x5617ec45f433 in __cmd_test builtin-test.c:0
>    #15 0x5617ec45faff in cmd_test perf[147aff]
>    #16 0x5617ec3ed960 in run_builtin perf.c:0
>    #17 0x5617ec3edc7b in handle_internal_command perf.c:0
>    #18 0x5617ec368d33 in main perf[50d33]
>    #19 0x7f855c633ca8 in __libc_start_call_main libc_start_call_main.h:74
>    #20 0x7f855c633d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
>    #21 0x5617ec369381 in _start perf[51381]
>  8: PERF_RECORD_* events & perf_sample fields                       :
> Skip (permissions)
> ```
>
>
> > I built it with DEBUG=3D1 and without, and with your patch, following y=
our
> > example output, I'm not being able to reproduce.
> >
> > Tried it as well with:
> >
> > =E2=AC=A2 [acme@toolbx perf-tools-next]$ cat segv.patch
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 8b30c6f16a9eeac1..e55d86f1097d6d79 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -402,6 +402,8 @@ static struct symbol *symbols__find(struct rb_root_=
cached *symbols, u64 ip)
> >  {
> >         struct rb_node *n;
> >
> > +       *(int *)NULL =3D 0;
> > +
> >         if (symbols =3D=3D NULL)
> >                 return NULL;
> >
> > =E2=AC=A2 [acme@toolbx perf-tools-next]$ patch -p1 < segv.patch
> > patching file tools/perf/util/symbol.c
> > =E2=AC=A2 [acme@toolbx perf-tools-next]$ m
> > rm: cannot remove '/home/acme/libexec/perf-core/scripts/python/Perf-Tra=
ce-Util/lib/Perf/Trace/__pycache__/Core.cpython-313.pyc': Permission denied
> > make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> >   BUILD:   Doing 'make -j32' parallel build
> > Warning: Kernel ABI header differences:
> >   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm=
/cputype.h
> >
> > Auto-detecting system features:
> > ...                                   libdw: [ on  ]
> > ...                                   glibc: [ on  ]
> > ...                                  libelf: [ on  ]
> > ...                                 libnuma: [ on  ]
> > ...                  numa_num_possible_cpus: [ on  ]
> > ...                                 libperl: [ on  ]
> > ...                               libpython: [ on  ]
> > ...                               libcrypto: [ on  ]
> > ...                             libcapstone: [ on  ]
> > ...                               llvm-perf: [ on  ]
> > ...                                    zlib: [ on  ]
> > ...                                    lzma: [ on  ]
> > ...                               get_cpuid: [ on  ]
> > ...                                     bpf: [ on  ]
> > ...                                  libaio: [ on  ]
> > ...                                 libzstd: [ on  ]
> >
> >   INSTALL libsubcmd_headers
> >   INSTALL libperf_headers
> >   INSTALL libapi_headers
> >   INSTALL libsymbol_headers
> >   INSTALL libbpf_headers
> >   CC      /tmp/build/perf-tools-next/util/symbol.o
> >   LD      /tmp/build/perf-tools-next/util/perf-util-in.o
> >   LD      /tmp/build/perf-tools-next/perf-util-in.o
> >   AR      /tmp/build/perf-tools-next/libperf-util.a
> >   LINK    /tmp/build/perf-tools-next/perf
> >   GEN     /tmp/build/perf-tools-next/python/perf.cpython-313-x86_64-lin=
ux-gnu.so
> >   INSTALL binaries
> >   INSTALL tests
> >   INSTALL libperf-jvmti.so
> >   INSTALL libexec
> >   INSTALL perf-archive
> >   INSTALL perf-iostat
> >   INSTALL perl-scripts
> >   INSTALL python-scripts
> >   INSTALL dlfilters
> >   INSTALL perf_completion-script
> >   INSTALL perf-tip
> > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> >  18: 'import perf' in python                                         : =
Ok
> > =E2=AC=A2 [acme@toolbx perf-tools-next]$
> >
> > root@number:~# perf top
> > perf: Segmentation fault
> > -------- backtrace --------
> > Segmentation fault (core dumped)
> > root@number:~#
> >
> > Tried also with this, but probably something else is at play:
> >
> > root@number:~# perf probe -x ~/bin/perf dump_stack
> > Added new event:
> >   probe_perf:dump_stack (on dump_stack in /home/acme/bin/perf)
> >
> > You can now use it in all perf tools, such as:
> >
> >         perf record -e probe_perf:dump_stack -aR sleep 1
> >
> > root@number:~#
> > root@number:~# perf trace -e probe_perf:dump_stack/max-stack=3D16/ perf=
 top
> > perf: Segmentation fault
> > -------- backtrace --------
> > root@number:~#
> >
> > Running perf trace on a separate terminal it also doesn't catch
> > dump_stack being called (that probe point).
> >
> > root@number:~# perf top --stdio
> >    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 drop=
: 0/0 [4000Hz cycles:P],  (all, 32 CPUs)
> > -----------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------
> >
> > perf: Segmentation fault
> > Segmentation fault (core dumped)
> > root@number:~#
> >
> > root@number:~# nm ~/bin/perf | grep dump_stack
> > 0000000000637eaa T __dump_stack
> > 00000000006380fa T dump_stack
> > 000000000063816b T sighandler_dump_stack
> > root@number:~#
> >
> > =E2=AC=A2 [acme@toolbx perf-tools-next]$ rpm -q glibc
> > glibc-2.41-5.fc42.x86_64
> > root@number:~# uname -a
> > Linux number 6.14.8-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Thu May 22 1=
9:26:02 UTC 2025 x86_64 GNU/Linux
> > root@number:~#
> >
> > What am I missing?
>
> For perf top I can do:
> ```
> $ sudo /tmp/perf/perf top
> ```
> in a different terminal:
> ```
> $ sudo killall -11 perf
> ```
> then back in the first terminal:
> ```
> perf: Segmentation fault
> -------- backtrace --------
>    #0 0x55ee68647918 in ui__signal_backtrace setup.c:110
>    #1 0x7fe2d3849df0 in __restore_rt libc_sigaction.c:0
>    #2 0x7fe2d38a49ee in __syscall_cancel_arch syscall_cancel.S:56
>    #3 0x7fe2d3899668 in __internal_syscall_cancel cancellation.c:54
>    #4 0x7fe2d38996ad in __syscall_cancel cancellation.c:79
>    #5 0x7fe2d390d9c6 in __poll poll.c:43
>    #6 0x55ee6855dfcb in fdarray__poll array.c:139
>    #7 0x55ee68565a05 in perf_evlist__poll evlist.c:391
>    #8 0x55ee68673b5a in evlist__poll evlist.c:594
>    #9 0x55ee684e7a61 in __cmd_top builtin-top.c:1369
>    #10 0x55ee684e9a6c in cmd_top builtin-top.c:1856
>    #11 0x55ee6855d1f0 in run_builtin perf.c:351
>    #12 0x55ee6855d497 in handle_internal_command perf.c:404
>    #13 0x55ee6855d5f0 in run_argv perf.c:451
>    #14 0x55ee6855d939 in main perf.c:558
>    #15 0x7fe2d3833ca8 in __libc_start_call_main libc_start_call_main.h:74
>    #16 0x7fe2d3833d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
>    #17 0x55ee684b0a91 in _start perf[4ca91]
> ```
> As the same symbol code is used for the backtrace then adding the segv
> there is likely causing a segv in the signal handler in __dump_stack.

Just to note, it would be nice for this to land as I need to rebase:
https://lore.kernel.org/lkml/20250529044000.759937-19-irogers@google.com/
due to the machine changes. I believe the patches are WAI as shown in
the output.

Thanks,
Ian


> Thanks,
> Ian
>
> > - Arnaldo
> >
> > > ____ unexpected signal (2) ____
> > >     #0 0x5590fb6209b6 in child_test_sig_handler builtin-test.c:243
> > >     #1 0x7f4a91e49e20 in __restore_rt libc_sigaction.c:0
> > >     #2 0x7f4a91ee4f33 in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.=
c:71
> > >     #3 0x7f4a91ef0333 in __nanosleep nanosleep.c:26
> > >     #4 0x7f4a91f01f68 in __sleep sleep.c:55
> > >     #5 0x5590fb638c63 in test__PERF_RECORD perf-record.c:295
> > >     #6 0x5590fb620b43 in run_test_child builtin-test.c:269
> > >     #7 0x5590fb5b83ab in start_command run-command.c:127
> > >     #8 0x5590fb621572 in start_test builtin-test.c:467
> > >     #9 0x5590fb621a47 in __cmd_test builtin-test.c:573
> > >     #10 0x5590fb6225ea in cmd_test builtin-test.c:775
> > >     #11 0x5590fb5a9099 in run_builtin perf.c:351
> > >     #12 0x5590fb5a9340 in handle_internal_command perf.c:404
> > >     #13 0x5590fb5a9499 in run_argv perf.c:451
> > >     #14 0x5590fb5a97e2 in main perf.c:558
> > >     #15 0x7f4a91e33d68 in __libc_start_call_main libc_start_call_main=
.h:74
> > >     #16 0x7f4a91e33e25 in __libc_start_main@@GLIBC_2.34 libc-start.c:=
128
> > >     #17 0x5590fb4fd6d1 in _start perf[436d1]
> > > ```
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > > v2: Fix NO_BACKTRACE=3D1 build (Arnaldo)
> > > ---
> > >  tools/perf/tests/builtin-test.c | 15 +++++++-
> > >  tools/perf/ui/tui/setup.c       |  2 +-
> > >  tools/perf/util/debug.c         | 68 +++++++++++++++++++++++++++----=
--
> > >  tools/perf/util/debug.h         |  1 +
> > >  4 files changed, 73 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/built=
in-test.c
> > > index 45d3d8b3317a..80375ca39a37 100644
> > > --- a/tools/perf/tests/builtin-test.c
> > > +++ b/tools/perf/tests/builtin-test.c
> > > @@ -6,6 +6,9 @@
> > >   */
> > >  #include <fcntl.h>
> > >  #include <errno.h>
> > > +#ifdef HAVE_BACKTRACE_SUPPORT
> > > +#include <execinfo.h>
> > > +#endif
> > >  #include <poll.h>
> > >  #include <unistd.h>
> > >  #include <setjmp.h>
> > > @@ -231,6 +234,16 @@ static jmp_buf run_test_jmp_buf;
> > >
> > >  static void child_test_sig_handler(int sig)
> > >  {
> > > +#ifdef HAVE_BACKTRACE_SUPPORT
> > > +     void *stackdump[32];
> > > +     size_t stackdump_size;
> > > +#endif
> > > +
> > > +     fprintf(stderr, "\n---- unexpected signal (%d) ----\n", sig);
> > > +#ifdef HAVE_BACKTRACE_SUPPORT
> > > +     stackdump_size =3D backtrace(stackdump, ARRAY_SIZE(stackdump));
> > > +     __dump_stack(stderr, stackdump, stackdump_size);
> > > +#endif
> > >       siglongjmp(run_test_jmp_buf, sig);
> > >  }
> > >
> > > @@ -244,7 +257,7 @@ static int run_test_child(struct child_process *p=
rocess)
> > >
> > >       err =3D sigsetjmp(run_test_jmp_buf, 1);
> > >       if (err) {
> > > -             fprintf(stderr, "\n---- unexpected signal (%d) ----\n",=
 err);
> > > +             /* Received signal. */
> > >               err =3D err > 0 ? -err : -1;
> > >               goto err_out;
> > >       }
> > > diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
> > > index 16c6eff4d241..022534eed68c 100644
> > > --- a/tools/perf/ui/tui/setup.c
> > > +++ b/tools/perf/ui/tui/setup.c
> > > @@ -108,7 +108,7 @@ static void ui__signal_backtrace(int sig)
> > >
> > >       printf("-------- backtrace --------\n");
> > >       size =3D backtrace(stackdump, ARRAY_SIZE(stackdump));
> > > -     backtrace_symbols_fd(stackdump, size, STDOUT_FILENO);
> > > +     __dump_stack(stdout, stackdump, size);
> > >
> > >       exit(0);
> > >  }
> > > diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> > > index f9ef7d045c92..0c7c6a9e158b 100644
> > > --- a/tools/perf/util/debug.c
> > > +++ b/tools/perf/util/debug.c
> > > @@ -14,11 +14,18 @@
> > >  #ifdef HAVE_BACKTRACE_SUPPORT
> > >  #include <execinfo.h>
> > >  #endif
> > > +#include "addr_location.h"
> > >  #include "color.h"
> > > -#include "event.h"
> > >  #include "debug.h"
> > > +#include "event.h"
> > > +#include "machine.h"
> > > +#include "map.h"
> > >  #include "print_binary.h"
> > > +#include "srcline.h"
> > > +#include "symbol.h"
> > > +#include "synthetic-events.h"
> > >  #include "target.h"
> > > +#include "thread.h"
> > >  #include "trace-event.h"
> > >  #include "ui/helpline.h"
> > >  #include "ui/ui.h"
> > > @@ -298,21 +305,60 @@ void perf_debug_setup(void)
> > >       libapi_set_print(pr_warning_wrapper, pr_warning_wrapper, pr_deb=
ug_wrapper);
> > >  }
> > >
> > > +void __dump_stack(FILE *file, void **stackdump, size_t stackdump_siz=
e)
> > > +{
> > > +     /* TODO: async safety. printf, malloc, etc. aren't safe inside =
a signal handler. */
> > > +     pid_t pid =3D getpid();
> > > +     struct machine *machine =3D machine__new_live(/*kernel_maps=3D*=
/false, pid);
> > > +     struct thread *thread =3D NULL;
> > > +
> > > +     if (machine)
> > > +             thread =3D machine__find_thread(machine, pid, pid);
> > > +
> > > +#ifdef HAVE_BACKTRACE_SUPPORT
> > > +     if (!machine || !thread) {
> > > +             /*
> > > +              * Backtrace functions are async signal safe. Fall back=
 on them
> > > +              * if machine/thread creation fails.
> > > +              */
> > > +             backtrace_symbols_fd(stackdump, stackdump_size, fileno(=
file));
> > > +             machine__delete(machine);
> > > +             return;
> > > +     }
> > > +#endif
> > > +
> > > +     for (size_t i =3D 0; i < stackdump_size; i++) {
> > > +             struct addr_location al;
> > > +             u64 addr =3D (u64)stackdump[i];
> > > +             bool printed =3D false;
> > > +
> > > +             addr_location__init(&al);
> > > +             if (thread && thread__find_map(thread, PERF_RECORD_MISC=
_USER, addr, &al)) {
> > > +                     al.sym =3D map__find_symbol(al.map, al.addr);
> > > +                     if (al.sym) {
> > > +                             fprintf(file, "    #%zd %p in %s ", i, =
stackdump[i], al.sym->name);
> > > +                             printed =3D true;
> > > +                     }
> > > +             }
> > > +             if (!printed)
> > > +                     fprintf(file, "    #%zd %p ", i, stackdump[i]);
> > > +
> > > +             map__fprintf_srcline(al.map, al.addr, "", file);
> > > +             fprintf(file, "\n");
> > > +             addr_location__exit(&al);
> > > +     }
> > > +     thread__put(thread);
> > > +     machine__delete(machine);
> > > +}
> > > +
> > >  /* Obtain a backtrace and print it to stdout. */
> > >  #ifdef HAVE_BACKTRACE_SUPPORT
> > >  void dump_stack(void)
> > >  {
> > > -     void *array[16];
> > > -     size_t size =3D backtrace(array, ARRAY_SIZE(array));
> > > -     char **strings =3D backtrace_symbols(array, size);
> > > -     size_t i;
> > > -
> > > -     printf("Obtained %zd stack frames.\n", size);
> > > -
> > > -     for (i =3D 0; i < size; i++)
> > > -             printf("%s\n", strings[i]);
> > > +     void *stackdump[32];
> > > +     size_t size =3D backtrace(stackdump, ARRAY_SIZE(stackdump));
> > >
> > > -     free(strings);
> > > +     __dump_stack(stdout, stackdump, size);
> > >  }
> > >  #else
> > >  void dump_stack(void) {}
> > > diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
> > > index a4026d1fd6a3..6b737e195ce1 100644
> > > --- a/tools/perf/util/debug.h
> > > +++ b/tools/perf/util/debug.h
> > > @@ -85,6 +85,7 @@ void debug_set_display_time(bool set);
> > >  void perf_debug_setup(void);
> > >  int perf_quiet_option(void);
> > >
> > > +void __dump_stack(FILE *file, void **stackdump, size_t stackdump_siz=
e);
> > >  void dump_stack(void);
> > >  void sighandler_dump_stack(int sig);
> > >
> > > --
> > > 2.49.0.1204.g71687c7c1d-goog
> > >
