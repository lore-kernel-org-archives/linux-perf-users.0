Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0853FB1B
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750797600; cv=none; b=Pop9hH0Fg1a+5nHR9iR0p62kec/PHWk/1ddMywhKbKZzTP7hQtsiAqY3zdrv/Z1pYpFCeFuKidwYoM0GW7wHA/FSNA8tTRVh+8QbkOQazKE8gFkZjPgTSXwMLrLDiEhfkLXsm1e0L/0BdbNK4KtFM/dVukya+kiubVk7nAVmvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750797600; c=relaxed/simple;
	bh=TI+vHYColUEeT4cJr1e2MzcYbdEHD7r3/vABuxIVqmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3rtMtvCzN6sZ7XPmQ53+ica8J8ykxlQXhnl2bDTtXVhrvbJXG0Jf5JkZ5otlTZisY+eJ5gbpgdg4o6byK+FpK5XlBffr9mIJu//Qe+H/g/uoIPf2+4n52wFhispHnYopfj/sVhnmNccgW4nodbJBWLoXexvHt4LPinPqOLXngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGs+uXnG; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGs+uXnG"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ddc10f09easo41015ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750797597; x=1751402397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDQMvsvxVdcWyKrHAZfBMSMsgkzG99yJx0n1B5k7RVk=;
        b=QGs+uXnGiodpoCkBnQmbipLLzXsK3pOwieXdWNnySeVqzEv2NqSIrAQ1VyJUlAT/z2
         BfRvIGKdGKoylR85hR5GVpxTLkRyLCc1kUMee7G3O4NgEOW2t/SxUlGEcOuytGKi+Pod
         lLfO4mNT9f0pFg1liFA6MqTXlND/1CkVgrtSHLOV44QKy6DD+bMuQwNwZMUamjK8RnG8
         9Io8uRULmhjW1r4KPLMxQ7PCLp7unbmDQXY7cq0jdYDKPqjNw/ftL7+SQEsTpAt7i22Y
         heqnRfnN2byGjRqOy58tfVbOmlfvfxw9IF5QgLRNpYy+/aM1X9YsnQcPnxgyLilggGO2
         cpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750797597; x=1751402397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDQMvsvxVdcWyKrHAZfBMSMsgkzG99yJx0n1B5k7RVk=;
        b=lBoOWjJPA0pf+7FwRdSYyWwRprJDf2uqGj9z89scvCdqdAgJP5C3TtgBgKqzcWCdvK
         2o64JpMPzGfaCWW2zs/E8y21qcNCX181Fg0UdSDzG1Q/slM+z6/0RTfdGnoKX5OVhp0f
         e+QJPHFM0ycO1x16ulsz6CrhxCTN8khYZg9bgA+2CL4hDrSiNO10DQsLT3KLPOmW8Jq2
         B98ORAuhrCccsLv3vHuyTS+kC3PfWpcsx/RM5RfgFZ7SOHb2ubV+pNvql0HKboCeuNda
         bSigg6Z2v0RgVN9kaB6SIRbTCiWZl9aMB3JGA8YLfMt+q5cGOe7Ausvy/ms5znR++9T9
         0BeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwFxYgdQFjY/JbjJktNsAoHVSUbI8OTCkZ0j/RpxVPoavh1AAYRYWV8U+rNVT4dRHN9y3tCfQ2vY+EcRPrl0ds@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfe9M4JXKiWspGwFhHlJjkMxNm4L0w+18lgK2XbEj61DNOCeA3
	LBsQI/4PPiZWOPCwmRTVGGwebl0m3yAlEK7UgNhVu2sE7ysIa6Psz6DJe/SbeBjVJcZl9SxN+ZE
	VAWFyZ+9W6zJ/8HDyy3fR3ghJ4IuLPGNI28uv9XUh
X-Gm-Gg: ASbGnctmVdwtwY8T0KsHas6ljL56jPMF+BrGZva76H6R3fQ3vULlTn/4sckPS8bfzZC
	ZfcpkI2Xi7hklAela4fJRk8dt5JVBT8qLNg27AlvmsY43Hy/sztP6KSO5XN9dHKLkUEuE1CcwFl
	r0jbpnWAI9exZgj2RvtPOSm5s9rj4qMRTCJyF1LvkL5WcGYSKedkL6GAIRqzslfWQKhmbyKiIcO
	OhVdazkdAM=
X-Google-Smtp-Source: AGHT+IGVDSMl2MQkyFFsjcCckmozHouz4wxqCqe4XuS2McaE4ZXpCGkSqme49d8qpSOgS8+MzRZO76G0zUQOkpKb7fw=
X-Received: by 2002:a05:6e02:17c9:b0:3dd:d8e6:9545 with SMTP id
 e9e14a558f8ab-3df324c7b18mr1033065ab.14.1750797596854; Tue, 24 Jun 2025
 13:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623161930.1421216-1-irogers@google.com> <aFrkQDcKpZilSOpj@google.com>
In-Reply-To: <aFrkQDcKpZilSOpj@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Jun 2025 13:39:45 -0700
X-Gm-Features: AX0GCFtktOqExmIbuooAAoWL9gyo3ThexEYilnDytgwkyYcj4s8Qh_Y1LMRdSyo
Message-ID: <CAP-5=fUUsx+aRE=KeFjc2CUw_ZvEVQ92_fJ=KGE34ep2QozFtw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] perf debug: Add function symbols to dump_stack
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 10:45=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Mon, Jun 23, 2025 at 09:19:28AM -0700, Ian Rogers wrote:
> > Symbolize stack traces by creating a live machine. Add this
> > functionality to dump_stack and switch dump_stack users to use
> > it. Switch TUI to use it. Add stack traces to the child test function
> > which can be useful to diagnose blocked code.
> >
> > Example output:
> > ```
> > $ perf test -vv PERF_RECORD_
> > ...
> >   7: PERF_RECORD_* events & perf_sample fields:
> >   7: PERF_RECORD_* events & perf_sample fields                       : =
Running (1 active)
> > ^C
> > Signal (2) while running tests.
> > Terminating tests with the same signal
> > Internal test harness failure. Completing any started tests:
> > :  7: PERF_RECORD_* events & perf_sample fields:
> >
> > ---- unexpected signal (2) ----
> >     #0 0x5628ad5570a3 in child_test_sig_handler builtin-test.c:0
> >     #1 0x7f561de49df0 in __restore_rt libc_sigaction.c:0
> >     #2 0x7f561de99687 in __internal_syscall_cancel cancellation.c:64
> >     #3 0x7f561dee5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:=
72
> >     #4 0x7f561def1393 in __nanosleep nanosleep.c:26
> >     #5 0x7f561df02d68 in __sleep sleep.c:55
> >     #6 0x5628ad5679ab in test__PERF_RECORD perf-record.c:0
> >     #7 0x5628ad556fb0 in run_test_child builtin-test.c:0
> >     #8 0x5628ad4f318d in start_command run-command.c:127
> >     #9 0x5628ad557ef3 in __cmd_test builtin-test.c:0
> >     #10 0x5628ad5585bf in cmd_test ??:0
> >     #11 0x5628ad4e5bb0 in run_builtin perf.c:0
> >     #12 0x5628ad4e5ecb in handle_internal_command perf.c:0
> >     #13 0x5628ad461383 in main ??:0
> >     #14 0x7f561de33ca8 in __libc_start_call_main libc_start_call_main.h=
:74
> >     #15 0x7f561de33d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:12=
8
> >     #16 0x5628ad4619d1 in _start ??:0
> >
> > ---- unexpected signal (2) ----
> >     #0 0x5628ad5570a3 in child_test_sig_handler builtin-test.c:0
> >     #1 0x7f561de49df0 in __restore_rt libc_sigaction.c:0
> >     #2 0x7f561dea3a14 in pthread_sigmask@GLIBC_2.2.5 pthread_sigmask.c:=
45
> >     #3 0x7f561de49fd9 in __GI___sigprocmask sigprocmask.c:26
> >     #4 0x7f561df2601b in __longjmp_chk longjmp.c:36
> >     #5 0x5628ad5570c0 in print_test_result.isra.0 builtin-test.c:0
> >     #6 0x7f561de49df0 in __restore_rt libc_sigaction.c:0
> >     #7 0x7f561de99687 in __internal_syscall_cancel cancellation.c:64
> >     #8 0x7f561dee5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:=
72
> >     #9 0x7f561def1393 in __nanosleep nanosleep.c:26
> >     #10 0x7f561df02d68 in __sleep sleep.c:55
> >     #11 0x5628ad5679ab in test__PERF_RECORD perf-record.c:0
> >     #12 0x5628ad556fb0 in run_test_child builtin-test.c:0
> >     #13 0x5628ad4f318d in start_command run-command.c:127
> >     #14 0x5628ad557ef3 in __cmd_test builtin-test.c:0
> >     #15 0x5628ad5585bf in cmd_test ??:0
> >     #16 0x5628ad4e5bb0 in run_builtin perf.c:0
> >     #17 0x5628ad4e5ecb in handle_internal_command perf.c:0
> >     #18 0x5628ad461383 in main ??:0
> >     #19 0x7f561de33ca8 in __libc_start_call_main libc_start_call_main.h=
:74
> >     #20 0x7f561de33d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:12=
8
> >     #21 0x5628ad4619d1 in _start ??:0
> >   7: PERF_RECORD_* events & perf_sample fields                       : =
Skip (permissions)
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Unfortunately it has some build errors so I had to remove it from the
> tree.  I'll keep the patch 2/2 btw.
>
> The NO_BACKTRACE=3D1 build caused a trouble like below.
>
>     CC      /tmp/tmp.huqYLzBWIi/util/debug.o
>   util/debug.c: In function '__dump_stack':
>   util/debug.c:323:17: error: implicit declaration of function 'backtrace=
_symbols_fd' [-Wimplicit-function-declaration]
>     323 |                 backtrace_symbols_fd(stackdump, stackdump_size,=
 fileno(file));
>         |                 ^~~~~~~~~~~~~~~~~~~~
>   make[6]: *** [/usr/local/google/home/namhyung/project/linux/tools/build=
/Makefile.build:86: /tmp/tmp.huqYLzBWIi/util/debug.o] Error 1
>   make[5]: *** [/usr/local/google/home/namhyung/project/linux/tools/build=
/Makefile.build:142: util] Error 2
>   make[4]: *** [Makefile.perf:798: /tmp/tmp.huqYLzBWIi/perf-util-in.o] Er=
ror 2
>   make[4]: *** Waiting for unfinished jobs....
>   make[3]: *** [Makefile.perf:290: sub-make] Error 2
>   make[2]: *** [Makefile:76: all] Error 2
>   make[1]: *** [tests/make:341: make_no_backtrace_O] Error 1
>   make: *** [Makefile:109: build-test] Error 2
>
> And on 32-bit, it also shows:
>
>     CC      /build/util/debug.o
>   util/debug.c: In function '__dump_stack':
>   util/debug.c:331:28: error: cast from pointer to integer of different s=
ize [-Werror=3Dpointer-to-int-cast]
>     331 |                 u64 addr =3D (u64)stackdump[i];
>         |                            ^
>
>   cc1: all warnings being treated as errors
>   make[4]: *** [/linux/tools/build/Makefile.build:85: /build/util/debug.o=
] Error 1
>   make[4]: *** Waiting for unfinished jobs....
>   make[3]: *** [/linux/tools/build/Makefile.build:142: util] Error 2
>   make[2]: *** [Makefile.perf:798: /build/perf-util-in.o] Error 2
>   make[2]: *** Waiting for unfinished jobs....
>   make[1]: *** [Makefile.perf:290: sub-make] Error 2
>   make: *** [Makefile:76: all] Error 2
>
> Thanks,
> Namhyung

Sorry Namhyung, I accidentally rebased the v1 rather than the v2
patch. I'll address the issues and repost as v5.

Thanks,
Ian

> > ---
> > v4: Additional addr_location__exit (Namhyung)
> > v3: Rebase
> > v2: Fix NO_BACKTRACE=3D1 build (Arnaldo)
> > ---
> >  tools/perf/tests/builtin-test.c | 15 +++++++-
> >  tools/perf/ui/tui/setup.c       |  2 +-
> >  tools/perf/util/debug.c         | 66 +++++++++++++++++++++++++++------
> >  tools/perf/util/debug.h         |  1 +
> >  4 files changed, 71 insertions(+), 13 deletions(-)
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
> > index f9ef7d045c92..efc9d2c6448d 100644
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
> > @@ -298,21 +305,58 @@ void perf_debug_setup(void)
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
> > +
> > +     for (size_t i =3D 0; i < stackdump_size; i++) {
> > +             struct addr_location al;
> > +             u64 addr =3D (u64)stackdump[i];
> > +
> > +             addr_location__init(&al);
> > +             if (!thread__find_map(thread, PERF_RECORD_MISC_USER, addr=
, &al)) {
> > +                     addr_location__exit(&al);
> > +                     continue;
> > +             }
> > +
> > +             al.sym =3D map__find_symbol(al.map, al.addr);
> > +             if (al.sym)
> > +                     fprintf(file, "    #%zd %p in %s ", i, stackdump[=
i], al.sym->name);
> > +             else
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
> > 2.50.0.rc2.761.g2dc52ea45b-goog
> >
