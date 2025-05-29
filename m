Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F95EAD7
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748556157; cv=none; b=GdPsVCNTz/QUCHVCYA7nZ022TtpSGFfCZXLJAdbagDL3zKoPbu0ak/PvBSnJvkuZFOhrAwIvkOEjz58iIOjw0abIgMeLt7xF1TlBoBtrc6T8iC0GPUyBjAHO7xk3y42uyiuYhEm/6z4tI8sIg6sDHpgTVvlKcBoYvZS8axQwAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748556157; c=relaxed/simple;
	bh=++87OKnuf9VuOSOFmW6+BculkS2MjmUHgou/pQAD96E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JI5+2wET15MVp9QhNs8cagAj6RJuV4ZdvXr50A3zLx1NPuNR23DCvMjXIWAR2TyxPzENlhgcisCz77Fhv+NiZWcCyCl3TRp1NeyWphUtDl1iP+ltS1ReBJPlaEqnt1B3D7AZRMZcH91ZyJpMZ6U7rsdT6TvQK+PfU/PFDCE1NVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dkucqPec; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkucqPec"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so22445ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748556155; x=1749160955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJay22rD/a9Dofka0/+ttd8xgGUExjRWiW4AtlP3q9A=;
        b=dkucqPeci7C331VmUkd99fjTVT9ULUWZBkx40XS/z6e87UIh7l2kE6mWlZ7gr+soAW
         0tZ4TtXNwF1pJdGnjfcn2Io9CPQ6Ho6p6gpNR86V2nZgBMkfnUawrlRXfmkAb/6Hrmnr
         iZ+9HUZza5ptvY8eMf28EbNGVprRJbORqw45ZQlhcUI43U1WqOB66qySXy2BYSDfKqwg
         b2/Ecbsff2R/A+TuIlCH/tKkNsRPbLvcbq5fNNRIuO5zJAQhwrnM5XQjxTL72Z5lkmJA
         fprl026lNaa0GvkXzvBnw1vzp/sVQe/Ca4rFbN5CVL8nZa7rTGGm7Pp+RDabcvt7G9d8
         cuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748556155; x=1749160955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJay22rD/a9Dofka0/+ttd8xgGUExjRWiW4AtlP3q9A=;
        b=cDZBIvjFiS28jABKF6x8UKGZXFcBfNiAcaWhQ3RixP2Kxv61oVJNnAeso7Tq0qM7Bn
         7JlOIg+fFa0FSm/BuDht9G7uPHVNC33tTrjLSdAbz8iSZl4GplrVTNXXAVO5gYGxA+zI
         1Q7JF9NwksbaIIZZyE40SHwBAs15oOcvefDZW9kMeXJfBTv7dkl5qc0+pCO6uyDWakcK
         ZHIbsuAkZyckHmowhe+VH9C3V1GI6EztRef0CbbHxgcbcciOFWiDWznyLDqwU5hJuNfg
         taDrnG8nHFJe0PVrYD1rR1UAZLBTWqmT4IzW+Pf2nUVzvhWCgM80cjIrCsbXPuSG0tWN
         fXag==
X-Forwarded-Encrypted: i=1; AJvYcCW+i7rOMFBwiscsiuTIBd2rZbZ+THhc5ChtLjzQ5am6cxjdVmZG3c10kavkZV8waVRjnBv0mopMIKBAQKC+/Iwb@vger.kernel.org
X-Gm-Message-State: AOJu0YwhKZ6kliHPUUp3lijNypUTEGKY311JBpq1bHp7amg2ChL06LQF
	Jc8m9O6ZaeY3L5qNIxJFtcCXMhms/MzvtnUNzT8X2P7uFPYvCaT4v3njQR4502lvY36DyAZlfhU
	dDZz88zmf5hqvmOnAh4QuUGSl8ZpvZY+Jp+q51nyc
X-Gm-Gg: ASbGncvYE1pXf11NeevVBlmadaYCYaSpB+v3pZDi1KyMttvEdWIzGCe1OJ9/utNsFSd
	5TD91sRfAggl0pvky8ziC6JSUQhYXjS4D8c/Os4mDciG5KsQk1rV1x7fp5TJSW1UI3RZXiDwWv2
	rYq/QmC4WnXIjLnHVOwi/RJ0zC3u14HJ5emcPHCn+WN6nK
X-Google-Smtp-Source: AGHT+IFa6ZwrlFO0cJ7CnHtzx7vPSvPq7SdXCVVxLLLgtpzoNGTzY/hrr9zWNjsubO7PnwetD3oq9T0jhNzZgp9hx/w=
X-Received: by 2002:a92:cd85:0:b0:3dc:830e:1ce6 with SMTP id
 e9e14a558f8ab-3dd9a7339e5mr1218455ab.22.1748556154334; Thu, 29 May 2025
 15:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529052322.381947-1-irogers@google.com> <20250529052322.381947-2-irogers@google.com>
 <aDjBtuxyumBrn70B@x1>
In-Reply-To: <aDjBtuxyumBrn70B@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 May 2025 15:02:23 -0700
X-Gm-Features: AX0GCFsASawUPe2facASPJcRTHVlrvu68mPdqu9Uwzz7NaZmhPEYW08It2udgMs
Message-ID: <CAP-5=fXonwoMOqfK30bo1i438cDa7oTWOOWFwJNXY9UOMBpkCQ@mail.gmail.com>
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

On Thu, May 29, 2025 at 1:21=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, May 28, 2025 at 10:23:22PM -0700, Ian Rogers wrote:
> > Symbolize stack traces by creating a live machine. Add this
> > functionality to dump_stack and switch dump_stack users to use
> > it. Switch TUI to use it. Add stack traces to the child test function
> > which can be useful to diagnose blocked code.
> >
> > Example output:
> > ```
> >   8: PERF_RECORD_* events & perf_sample fields                       : =
Running (1 active)
> > ^C
> > Signal (2) while running tests.
> > Terminating tests with the same signal
> > Internal test harness failure. Completing any started tests:
> > :  8: PERF_RECORD_* events & perf_sample fields:
>
> So you are testing it with:
>
> root@number:~# perf test PERF_RECORD
>   8: PERF_RECORD_* events & perf_sample fields                       : Ru=
nning (1 active)
> ^C
> Signal (2) while running tests.
> Terminating tests with the same signal
> Internal test harness failure. Completing any started tests:
>   8: PERF_RECORD_* events & perf_sample fields                       : Sk=
ip (permissions)
> root@number:~#
>
> ?

You are running the test as a child and by default the child test
output is only displayed if verbose is enabled. I use verbose=3D2 below
as verbose=3D1 won't display anything unless the child test gives a fail
exit value:
```
$ git log --oneline
b9ac06abfde9 perf debug: Add function symbols to dump_stack
e561806265ed perf machine: Factor creating a "live" machine out of dwarf-un=
wind
628e124404b3 perf tests switch-tracking: Fix timestamp comparison
$ make -C tools/perf O=3D/tmp/perf
...
$ sudo /tmp/perf/perf test -vv PERF_RECORD
 8: PERF_RECORD_* events & perf_sample fields:
 8: PERF_RECORD_* events & perf_sample fields                       :
Running (1 active)
^C
Signal (2) while running tests.
Terminating tests with the same signal
Internal test harness failure. Completing any started tests:
:  8: PERF_RECORD_* events & perf_sample fields:

---- unexpected signal (2) ----
   #0 0x5617ec45e5e3 in child_test_sig_handler builtin-test.c:0
   #1 0x7f855c649df0 in __restore_rt libc_sigaction.c:0
   #2 0x7f855c699687 in __internal_syscall_cancel cancellation.c:64
   #3 0x7f855c6e5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:72
   #4 0x7f855c6f1393 in __nanosleep nanosleep.c:26
   #5 0x7f855c702d68 in __sleep sleep.c:55
   #6 0x5617ec46ebfb in test__PERF_RECORD perf-record.c:0
   #7 0x5617ec45e4f0 in run_test_child builtin-test.c:0
   #8 0x5617ec3faf0d in start_command run-command.c:127
   #9 0x5617ec45f433 in __cmd_test builtin-test.c:0
   #10 0x5617ec45faff in cmd_test perf[147aff]
   #11 0x5617ec3ed960 in run_builtin perf.c:0
   #12 0x5617ec3edc7b in handle_internal_command perf.c:0
   #13 0x5617ec368d33 in main perf[50d33]
   #14 0x7f855c633ca8 in __libc_start_call_main libc_start_call_main.h:74
   #15 0x7f855c633d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
   #16 0x5617ec369381 in _start perf[51381]

---- unexpected signal (2) ----
   #0 0x5617ec45e5e3 in child_test_sig_handler builtin-test.c:0
   #1 0x7f855c649df0 in __restore_rt libc_sigaction.c:0
   #2 0x7f855c6a3a14 in pthread_sigmask@GLIBC_2.2.5 pthread_sigmask.c:45
   #3 0x7f855c649fd9 in __GI___sigprocmask sigprocmask.c:26
   #4 0x7f855c72601b in __longjmp_chk longjmp.c:36
   #5 0x5617ec45e600 in print_test_result.isra.0 builtin-test.c:0
   #6 0x7f855c649df0 in __restore_rt libc_sigaction.c:0
   #7 0x7f855c699687 in __internal_syscall_cancel cancellation.c:64
   #8 0x7f855c6e5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:72
   #9 0x7f855c6f1393 in __nanosleep nanosleep.c:26
   #10 0x7f855c702d68 in __sleep sleep.c:55
   #11 0x5617ec46ebfb in test__PERF_RECORD perf-record.c:0
   #12 0x5617ec45e4f0 in run_test_child builtin-test.c:0
   #13 0x5617ec3faf0d in start_command run-command.c:127
   #14 0x5617ec45f433 in __cmd_test builtin-test.c:0
   #15 0x5617ec45faff in cmd_test perf[147aff]
   #16 0x5617ec3ed960 in run_builtin perf.c:0
   #17 0x5617ec3edc7b in handle_internal_command perf.c:0
   #18 0x5617ec368d33 in main perf[50d33]
   #19 0x7f855c633ca8 in __libc_start_call_main libc_start_call_main.h:74
   #20 0x7f855c633d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
   #21 0x5617ec369381 in _start perf[51381]
 8: PERF_RECORD_* events & perf_sample fields                       :
Skip (permissions)
```


> I built it with DEBUG=3D1 and without, and with your patch, following you=
r
> example output, I'm not being able to reproduce.
>
> Tried it as well with:
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ cat segv.patch
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 8b30c6f16a9eeac1..e55d86f1097d6d79 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -402,6 +402,8 @@ static struct symbol *symbols__find(struct rb_root_ca=
ched *symbols, u64 ip)
>  {
>         struct rb_node *n;
>
> +       *(int *)NULL =3D 0;
> +
>         if (symbols =3D=3D NULL)
>                 return NULL;
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ patch -p1 < segv.patch
> patching file tools/perf/util/symbol.c
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ m
> rm: cannot remove '/home/acme/libexec/perf-core/scripts/python/Perf-Trace=
-Util/lib/Perf/Trace/__pycache__/Core.cpython-313.pyc': Permission denied
> make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
>   BUILD:   Doing 'make -j32' parallel build
> Warning: Kernel ABI header differences:
>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/c=
putype.h
>
> Auto-detecting system features:
> ...                                   libdw: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                                 libperl: [ on  ]
> ...                               libpython: [ on  ]
> ...                               libcrypto: [ on  ]
> ...                             libcapstone: [ on  ]
> ...                               llvm-perf: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                               get_cpuid: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
>
>   INSTALL libsubcmd_headers
>   INSTALL libperf_headers
>   INSTALL libapi_headers
>   INSTALL libsymbol_headers
>   INSTALL libbpf_headers
>   CC      /tmp/build/perf-tools-next/util/symbol.o
>   LD      /tmp/build/perf-tools-next/util/perf-util-in.o
>   LD      /tmp/build/perf-tools-next/perf-util-in.o
>   AR      /tmp/build/perf-tools-next/libperf-util.a
>   LINK    /tmp/build/perf-tools-next/perf
>   GEN     /tmp/build/perf-tools-next/python/perf.cpython-313-x86_64-linux=
-gnu.so
>   INSTALL binaries
>   INSTALL tests
>   INSTALL libperf-jvmti.so
>   INSTALL libexec
>   INSTALL perf-archive
>   INSTALL perf-iostat
>   INSTALL perl-scripts
>   INSTALL python-scripts
>   INSTALL dlfilters
>   INSTALL perf_completion-script
>   INSTALL perf-tip
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
>  18: 'import perf' in python                                         : Ok
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> root@number:~# perf top
> perf: Segmentation fault
> -------- backtrace --------
> Segmentation fault (core dumped)
> root@number:~#
>
> Tried also with this, but probably something else is at play:
>
> root@number:~# perf probe -x ~/bin/perf dump_stack
> Added new event:
>   probe_perf:dump_stack (on dump_stack in /home/acme/bin/perf)
>
> You can now use it in all perf tools, such as:
>
>         perf record -e probe_perf:dump_stack -aR sleep 1
>
> root@number:~#
> root@number:~# perf trace -e probe_perf:dump_stack/max-stack=3D16/ perf t=
op
> perf: Segmentation fault
> -------- backtrace --------
> root@number:~#
>
> Running perf trace on a separate terminal it also doesn't catch
> dump_stack being called (that probe point).
>
> root@number:~# perf top --stdio
>    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 drop: =
0/0 [4000Hz cycles:P],  (all, 32 CPUs)
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------
>
> perf: Segmentation fault
> Segmentation fault (core dumped)
> root@number:~#
>
> root@number:~# nm ~/bin/perf | grep dump_stack
> 0000000000637eaa T __dump_stack
> 00000000006380fa T dump_stack
> 000000000063816b T sighandler_dump_stack
> root@number:~#
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ rpm -q glibc
> glibc-2.41-5.fc42.x86_64
> root@number:~# uname -a
> Linux number 6.14.8-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Thu May 22 19:=
26:02 UTC 2025 x86_64 GNU/Linux
> root@number:~#
>
> What am I missing?

For perf top I can do:
```
$ sudo /tmp/perf/perf top
```
in a different terminal:
```
$ sudo killall -11 perf
```
then back in the first terminal:
```
perf: Segmentation fault
-------- backtrace --------
   #0 0x55ee68647918 in ui__signal_backtrace setup.c:110
   #1 0x7fe2d3849df0 in __restore_rt libc_sigaction.c:0
   #2 0x7fe2d38a49ee in __syscall_cancel_arch syscall_cancel.S:56
   #3 0x7fe2d3899668 in __internal_syscall_cancel cancellation.c:54
   #4 0x7fe2d38996ad in __syscall_cancel cancellation.c:79
   #5 0x7fe2d390d9c6 in __poll poll.c:43
   #6 0x55ee6855dfcb in fdarray__poll array.c:139
   #7 0x55ee68565a05 in perf_evlist__poll evlist.c:391
   #8 0x55ee68673b5a in evlist__poll evlist.c:594
   #9 0x55ee684e7a61 in __cmd_top builtin-top.c:1369
   #10 0x55ee684e9a6c in cmd_top builtin-top.c:1856
   #11 0x55ee6855d1f0 in run_builtin perf.c:351
   #12 0x55ee6855d497 in handle_internal_command perf.c:404
   #13 0x55ee6855d5f0 in run_argv perf.c:451
   #14 0x55ee6855d939 in main perf.c:558
   #15 0x7fe2d3833ca8 in __libc_start_call_main libc_start_call_main.h:74
   #16 0x7fe2d3833d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
   #17 0x55ee684b0a91 in _start perf[4ca91]
```
As the same symbol code is used for the backtrace then adding the segv
there is likely causing a segv in the signal handler in __dump_stack.

Thanks,
Ian

> - Arnaldo
>
> > ____ unexpected signal (2) ____
> >     #0 0x5590fb6209b6 in child_test_sig_handler builtin-test.c:243
> >     #1 0x7f4a91e49e20 in __restore_rt libc_sigaction.c:0
> >     #2 0x7f4a91ee4f33 in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:=
71
> >     #3 0x7f4a91ef0333 in __nanosleep nanosleep.c:26
> >     #4 0x7f4a91f01f68 in __sleep sleep.c:55
> >     #5 0x5590fb638c63 in test__PERF_RECORD perf-record.c:295
> >     #6 0x5590fb620b43 in run_test_child builtin-test.c:269
> >     #7 0x5590fb5b83ab in start_command run-command.c:127
> >     #8 0x5590fb621572 in start_test builtin-test.c:467
> >     #9 0x5590fb621a47 in __cmd_test builtin-test.c:573
> >     #10 0x5590fb6225ea in cmd_test builtin-test.c:775
> >     #11 0x5590fb5a9099 in run_builtin perf.c:351
> >     #12 0x5590fb5a9340 in handle_internal_command perf.c:404
> >     #13 0x5590fb5a9499 in run_argv perf.c:451
> >     #14 0x5590fb5a97e2 in main perf.c:558
> >     #15 0x7f4a91e33d68 in __libc_start_call_main libc_start_call_main.h=
:74
> >     #16 0x7f4a91e33e25 in __libc_start_main@@GLIBC_2.34 libc-start.c:12=
8
> >     #17 0x5590fb4fd6d1 in _start perf[436d1]
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > v2: Fix NO_BACKTRACE=3D1 build (Arnaldo)
> > ---
> >  tools/perf/tests/builtin-test.c | 15 +++++++-
> >  tools/perf/ui/tui/setup.c       |  2 +-
> >  tools/perf/util/debug.c         | 68 +++++++++++++++++++++++++++------
> >  tools/perf/util/debug.h         |  1 +
> >  4 files changed, 73 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index 45d3d8b3317a..80375ca39a37 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -6,6 +6,9 @@
> >   */
> >  #include <fcntl.h>
> >  #include <errno.h>
> > +#ifdef HAVE_BACKTRACE_SUPPORT
> > +#include <execinfo.h>
> > +#endif
> >  #include <poll.h>
> >  #include <unistd.h>
> >  #include <setjmp.h>
> > @@ -231,6 +234,16 @@ static jmp_buf run_test_jmp_buf;
> >
> >  static void child_test_sig_handler(int sig)
> >  {
> > +#ifdef HAVE_BACKTRACE_SUPPORT
> > +     void *stackdump[32];
> > +     size_t stackdump_size;
> > +#endif
> > +
> > +     fprintf(stderr, "\n---- unexpected signal (%d) ----\n", sig);
> > +#ifdef HAVE_BACKTRACE_SUPPORT
> > +     stackdump_size =3D backtrace(stackdump, ARRAY_SIZE(stackdump));
> > +     __dump_stack(stderr, stackdump, stackdump_size);
> > +#endif
> >       siglongjmp(run_test_jmp_buf, sig);
> >  }
> >
> > @@ -244,7 +257,7 @@ static int run_test_child(struct child_process *pro=
cess)
> >
> >       err =3D sigsetjmp(run_test_jmp_buf, 1);
> >       if (err) {
> > -             fprintf(stderr, "\n---- unexpected signal (%d) ----\n", e=
rr);
> > +             /* Received signal. */
> >               err =3D err > 0 ? -err : -1;
> >               goto err_out;
> >       }
> > diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
> > index 16c6eff4d241..022534eed68c 100644
> > --- a/tools/perf/ui/tui/setup.c
> > +++ b/tools/perf/ui/tui/setup.c
> > @@ -108,7 +108,7 @@ static void ui__signal_backtrace(int sig)
> >
> >       printf("-------- backtrace --------\n");
> >       size =3D backtrace(stackdump, ARRAY_SIZE(stackdump));
> > -     backtrace_symbols_fd(stackdump, size, STDOUT_FILENO);
> > +     __dump_stack(stdout, stackdump, size);
> >
> >       exit(0);
> >  }
> > diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> > index f9ef7d045c92..0c7c6a9e158b 100644
> > --- a/tools/perf/util/debug.c
> > +++ b/tools/perf/util/debug.c
> > @@ -14,11 +14,18 @@
> >  #ifdef HAVE_BACKTRACE_SUPPORT
> >  #include <execinfo.h>
> >  #endif
> > +#include "addr_location.h"
> >  #include "color.h"
> > -#include "event.h"
> >  #include "debug.h"
> > +#include "event.h"
> > +#include "machine.h"
> > +#include "map.h"
> >  #include "print_binary.h"
> > +#include "srcline.h"
> > +#include "symbol.h"
> > +#include "synthetic-events.h"
> >  #include "target.h"
> > +#include "thread.h"
> >  #include "trace-event.h"
> >  #include "ui/helpline.h"
> >  #include "ui/ui.h"
> > @@ -298,21 +305,60 @@ void perf_debug_setup(void)
> >       libapi_set_print(pr_warning_wrapper, pr_warning_wrapper, pr_debug=
_wrapper);
> >  }
> >
> > +void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size)
> > +{
> > +     /* TODO: async safety. printf, malloc, etc. aren't safe inside a =
signal handler. */
> > +     pid_t pid =3D getpid();
> > +     struct machine *machine =3D machine__new_live(/*kernel_maps=3D*/f=
alse, pid);
> > +     struct thread *thread =3D NULL;
> > +
> > +     if (machine)
> > +             thread =3D machine__find_thread(machine, pid, pid);
> > +
> > +#ifdef HAVE_BACKTRACE_SUPPORT
> > +     if (!machine || !thread) {
> > +             /*
> > +              * Backtrace functions are async signal safe. Fall back o=
n them
> > +              * if machine/thread creation fails.
> > +              */
> > +             backtrace_symbols_fd(stackdump, stackdump_size, fileno(fi=
le));
> > +             machine__delete(machine);
> > +             return;
> > +     }
> > +#endif
> > +
> > +     for (size_t i =3D 0; i < stackdump_size; i++) {
> > +             struct addr_location al;
> > +             u64 addr =3D (u64)stackdump[i];
> > +             bool printed =3D false;
> > +
> > +             addr_location__init(&al);
> > +             if (thread && thread__find_map(thread, PERF_RECORD_MISC_U=
SER, addr, &al)) {
> > +                     al.sym =3D map__find_symbol(al.map, al.addr);
> > +                     if (al.sym) {
> > +                             fprintf(file, "    #%zd %p in %s ", i, st=
ackdump[i], al.sym->name);
> > +                             printed =3D true;
> > +                     }
> > +             }
> > +             if (!printed)
> > +                     fprintf(file, "    #%zd %p ", i, stackdump[i]);
> > +
> > +             map__fprintf_srcline(al.map, al.addr, "", file);
> > +             fprintf(file, "\n");
> > +             addr_location__exit(&al);
> > +     }
> > +     thread__put(thread);
> > +     machine__delete(machine);
> > +}
> > +
> >  /* Obtain a backtrace and print it to stdout. */
> >  #ifdef HAVE_BACKTRACE_SUPPORT
> >  void dump_stack(void)
> >  {
> > -     void *array[16];
> > -     size_t size =3D backtrace(array, ARRAY_SIZE(array));
> > -     char **strings =3D backtrace_symbols(array, size);
> > -     size_t i;
> > -
> > -     printf("Obtained %zd stack frames.\n", size);
> > -
> > -     for (i =3D 0; i < size; i++)
> > -             printf("%s\n", strings[i]);
> > +     void *stackdump[32];
> > +     size_t size =3D backtrace(stackdump, ARRAY_SIZE(stackdump));
> >
> > -     free(strings);
> > +     __dump_stack(stdout, stackdump, size);
> >  }
> >  #else
> >  void dump_stack(void) {}
> > diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
> > index a4026d1fd6a3..6b737e195ce1 100644
> > --- a/tools/perf/util/debug.h
> > +++ b/tools/perf/util/debug.h
> > @@ -85,6 +85,7 @@ void debug_set_display_time(bool set);
> >  void perf_debug_setup(void);
> >  int perf_quiet_option(void);
> >
> > +void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size)=
;
> >  void dump_stack(void);
> >  void sighandler_dump_stack(int sig);
> >
> > --
> > 2.49.0.1204.g71687c7c1d-goog
> >
