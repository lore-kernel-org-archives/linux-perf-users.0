Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4147E1
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694551; cv=none; b=VFbTD4XQrBQ3M6wWazp09MtudSXE9f7x4pia/DukmafZVv3Xiez5SVyRXcgPIeSpzGyQpMxThS9iYtlt8pFk1pJH1nHTONidqgmA83klraR1NdIKijZ6aECtGgBbjqsYT+/qwqxOlkPPb1IoprAH8dZ19l0fIgy2MKrIj/VAQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694551; c=relaxed/simple;
	bh=4yD9VdVYlBXa4Y7vXGfU+vsVeV+Nw2r5nAOJjHy5VZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAn6GI8r/27d35w9qKY1g8wFac6ITo0s9vLGYXFuNbuMvnCR2MouOWnQOnxYSWcsJdE0LZZ/ZS3+ZXNLG9dvy2r/0o0MIMNR7LnNwfTR8u1cvQ2QQ7qCSBYkdKSLzWwZpmvq4dZrpWoX6JN21UtbjWrdIhn2X0aTu479LR2x2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zQgm7oGo; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zQgm7oGo"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ddc10f09easo364695ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Jun 2025 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750694548; x=1751299348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVtiu9oRVGs+XWGoKltiSe+GSzP8GWJTx8DY++AI2Gc=;
        b=zQgm7oGoTLyOkauyVbsIDsEU62G1rjyMZ1ZM3fzi99iDVDscWWuA2L7gwsGnPTCZGH
         4fUBEJLXBZ8oXwSCVPAlampz/PkJjNrRxmEyLEk7Mg2XpSn5E23zHYmJNcB/GqMXpRYF
         eZKYVj95tQkjvJdyva0Et9s05zsLDSRHZ0Il17TBWbr16zYEhRJqiVQFF8HVVDnAp0Nq
         PCTzp+eDU0JftQL98eAnCCdyZrexP6r7CIT4zSWXY4YuF4OhOtIkiqxAeIKioxjkIAiv
         YeImn3gJh6b+fC59Sk9C38DiVpFw3qV4HFMi9xa1onOWW0n8IigE/btuKvcBPzRVqDwE
         8FgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750694548; x=1751299348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVtiu9oRVGs+XWGoKltiSe+GSzP8GWJTx8DY++AI2Gc=;
        b=h5oPiKsrqXNdd4i3mlWbObe6u08mM4D51XlYYN3q3Oow3x3feJSi7biVohqi43hb4R
         nKE4XEQVwhO1IQ6J8hgenNZ0VT5GwXCQaH3ZPoHZf+WJohuRnGNqdb9zLLnKEAiWZHHu
         YB43ML+7QrcmcBYw2uCgF7vz2uEkzf4K9QvZPtrc4sde0fwX5vsVPhUdr1HmpoH1VOnX
         pJDYlXNG98EBI4U3lxaJzgs6I1E5qcARrsIane/Cix7O/uIPRIQ8kvaulvB5c/c1EHfx
         VOLIqefHVn47W470HYO+70+VMScDHm03PjxN1WCM98xL41lzJMLb7MA0nxlGbrEeF5hD
         VxYw==
X-Forwarded-Encrypted: i=1; AJvYcCUP66V2ECgGEo3svoSFR4KVSN7q3HtynUp/3f5J9V4HEvYxItbQcDVn5FuOf0lV0EwkOFlMhwNMBiq1kliI2B1W@vger.kernel.org
X-Gm-Message-State: AOJu0YyZr7cABkCXsxeGPNDzQBcBXM6XFiXmRnhMpa5cHz5i8rDXOYJQ
	F1ZG5QDoXeEWg1fR+AVU/oW6WjFlfRUrYY8e3dMPLURAm+SnyYfMPHibHSD+jV12gGGf+2eGi8k
	CRd1L6kF7mXZj2Q1F2C+QeA7BpoxroYze7B2t7K/P
X-Gm-Gg: ASbGncuG0347LNhrux3ttIahMuDpSBeRjujbiAX790hx2x9T9beC0w5X7qdEXY1A+NO
	unldySbCMxy24YqjynBM3rQbKRkvPuHIx7umCGMhBdS48LEsMUVIEP72B1TwON7R8kgfgJg5Ayb
	rY0IYfRhBis+UhNuTdjONvrsmhjkw4wgxPfdtlXYrEHUIDDPxDYwyPJerh34dmrEnVRZE0msIF
X-Google-Smtp-Source: AGHT+IHmv9sTO0+wCilv/AU78OeEEroqqxp35JLCnjdEjX4riSnVC3BeOL2eD5tCQnJ5u68qVBRILmNy2iTWNDcRs4c=
X-Received: by 2002:a05:6e02:158b:b0:3dc:77c4:2cef with SMTP id
 e9e14a558f8ab-3df0ceff314mr6735715ab.22.1750694548203; Mon, 23 Jun 2025
 09:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611221521.722045-1-irogers@google.com> <aFXDKO-aLWzA3M2H@google.com>
In-Reply-To: <aFXDKO-aLWzA3M2H@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Jun 2025 09:02:16 -0700
X-Gm-Features: AX0GCFsZLPxofaWNBTzRpJaGYCEAbnf6hDQkvQK1xvAU44AYzmny7F2Olvdscvk
Message-ID: <CAP-5=fWyFDR87ojYLwwsn9+6zNzBgGXu-hHqsjSHmah8-HM-Fw@mail.gmail.com>
Subject: Re: [PATCH v3] perf debug: Add function symbols to dump_stack
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

On Fri, Jun 20, 2025 at 1:23=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jun 11, 2025 at 03:15:21PM -0700, Ian Rogers wrote:
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
> >
> > ---- unexpected signal (2) ----
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
> >  tools/perf/tests/builtin-test.c | 15 +++++++-
> >  tools/perf/ui/tui/setup.c       |  2 +-
> >  tools/perf/util/debug.c         | 64 +++++++++++++++++++++++++++------
> >  tools/perf/util/debug.h         |  1 +
> >  4 files changed, 69 insertions(+), 13 deletions(-)
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
> > index f9ef7d045c92..8987ac250079 100644
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
> > @@ -298,21 +305,56 @@ void perf_debug_setup(void)
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
, &al))
>
> It seems addr_location__exit(&al) is needed here.

Good catch. I don't think it changes the behavior of the code but is
cleaner. I'll fix in v4.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +                     continue;
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
> > 2.50.0.rc1.591.g9c95f17f64-goog
> >
