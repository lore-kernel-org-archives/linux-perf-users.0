Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42813AD0F
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Nov 2024 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821842; cv=none; b=Y6r5JLTAAhmcJC+iJSn5QnEJMQm/jU/jg4c/77jMNgflgGyvg4AmBut+s9sJhWLOkVbPKqZSlJlodRnTYCKeAmLJwUm8Vdj0P0ahfTibsSAPrm1nCxwXckx3nB8vPhiXRKhM82FebYGANQIomQqFrfhlwXYNAA4RbWnshgmasDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821842; c=relaxed/simple;
	bh=pYww9KL/hDybrTt0GCKOwf5OXIm5ozIIlry1IZCbDPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmk1KvZE4GSJ2MQVf3fCNL6lQFql1IFcwqGs0GERykCYNqUt17POnlYHrHbk+CT45VXZIN7nKzCNbojZMXfcVNYWoJy/x/hepWpsxw5K5pLn4mDLOde/ZtAB7l7GovE8RQs4WK5nUxfeZ3KG7YPUnHpgwGggMo1J2yVg3s5kvhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kw6opedM; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kw6opedM"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460969c49f2so419121cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 07:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730821838; x=1731426638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10B3xZq3pNzYNd0L4SY/FR0IltNXHtBmueZ4qDd65pk=;
        b=Kw6opedMS3UX7w6ttgHD8U9A8y8BfYYgu165QS5rhMPERY7FlMF9xJS3f82Mo7V6s5
         7EOIzdu+FlMoFUFeGme6bDfe1MjM8sbmZiQkCgs6P+2hUT6TvcfaxkHtRqBAa4RYSKEu
         NCWw/kR+2Y7ut2O6FFDF092IZlkexxD7jw/xB1cZZyL10XNXte33Fw73SbnjcCvCsGMF
         JvSWiwURQ+/O38o/bgg1gYmDviSl57rGu3x8fmHloID1CEmVqVRYJq0XImr/ndAT26KP
         uz51d9xnMM29g2U1NtMaicdCA5gXP7WMU6AEuvzNBUCOMeUnLHVaI6qexLoQ5HdueaND
         NUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730821838; x=1731426638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10B3xZq3pNzYNd0L4SY/FR0IltNXHtBmueZ4qDd65pk=;
        b=m93gwQ4xB7ZQClgr4weT9aSL5p7zijH1irZ1EK1EIpzlW6OCwq5QAn4Ej9mqD2ZHcc
         q5TZdGAsjVWUosa5BO4TLBR1vNxlrVaSRQwmk+M4NabeFP8AGOpu4Agfej26X3NZNuIv
         M2naX4Sgz2ZQRQ/oKjuEDSdh+TihigxV+GWw+s7FDsmzgdBKDLEW7q0ytv0nrlNmIE3i
         SakG799pEsFlxQrUQwFJgx97cTcplyFv2eOCvrblsZvl/8WOqpNAJUyqmN+DpqSD7vbg
         iu6vQsl44XH8kkt7UAGdnFBpHCkp+0tWurPSqwiV1m9U83vMgNzgcf8qw/v2pb149/Fl
         D3Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWw825S09B0kXgGEBGMrbS98GFc1tzZGYIJv0tfBCcDfNXVmz4+cvxrZ2GAibUZyyYIeQ5+KPRRf4vW6TtlB/Iw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9tU8nSSRnYMyI2g+jKqiJyg20XnO+DQfyJJQesfZ6gk0Oep5z
	xhj8TDZ6im+5OAFwEtcZABGHraS/nGeRTWaFpwqGi17LdW8VwvfGKckNDiC6BKKL3PAHWJ/1ieO
	R9w0i9uAGWJ3fpy2MyGiL9Nd5rRjrFyXs2zc3
X-Gm-Gg: ASbGnctRraIiaTX9PwHEemewlvt0/0wp4Ol/fOm0HcWKwr4240ryyozH7jEdSvsFtlj
	SwFNr2qKDOAYGGk7TjGFpVYdEsS990c/F
X-Google-Smtp-Source: AGHT+IEumTeffzONvvlaY1PXysab76u5lX1pA8kv8AFZXJociZ11Cem/Qxd+YuWrUJKSjKlWtJmPT1ipNHUMbyL2Ac4=
X-Received: by 2002:ac8:7dcb:0:b0:461:685d:324 with SMTP id
 d75a77b69052e-462e4eb440amr4724531cf.16.1730821837371; Tue, 05 Nov 2024
 07:50:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105142616.761042-1-acme@kernel.org> <20241105142616.761042-4-acme@kernel.org>
In-Reply-To: <20241105142616.761042-4-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 Nov 2024 07:50:25 -0800
Message-ID: <CAP-5=fViyn9Khja2jPa3gDZy0onsqVt20Y3H7e584SdiWXQvQw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf test: Don't suppress the libtraceevent tests,
 skip them
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Thomas Richter <tmricht@linux.ibm.com>, Veronika Molnarova <vmolnaro@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 6:26=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> As suggested by Namhyung for the "import perf" python binding test, skip
> the tests that require perf being linked with libtraceevent, telling the
> reason:
>
>   $ make -C tools/perf NO_LIBTRACEEVENT=3D1
>   # perf check feature libtraceevent
>          libtraceevent: [ OFF ]  # HAVE_LIBTRACEEVENT
>   # ldd ~/bin/perf | grep traceevent
>   #
>   # perf test
>     1: vmlinux symtab matches kallsyms                 : Ok
>     2: Detect openat syscall event                     : Skip (not linked=
 with libtraceevent)
>     3: Detect openat syscall event on all cpus         : Skip (not linked=
 with libtraceevent)
>     4: mmap interface tests                            :
>     4.1: Read samples using the mmap interface         : Skip (not linked=
 with libtraceevent)
>     4.2: User space counter reading of instructions    : Skip (not linked=
 with libtraceevent)
>     4.3: User space counter reading of cycles          : Skip (not linked=
 with libtraceevent)
> <SNIP>
>    14: Parse sched tracepoints fields                  : Skip (not linked=
 with libtraceevent)
>    15: syscalls:sys_enter_openat event fields          : Skip (not linked=
 with libtraceevent)
> <SNIP>
>    32: Track with sched_switch                         : Skip (not linked=
 with libtraceevent)
> <SNIP>
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Howard Chu <howardchu95@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Leo Yan <leo.yan@linux.dev>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

This will conflict with:
https://lore.kernel.org/lkml/20241102165400.75785-7-irogers@google.com/

Thanks,
Ian

> ---
>  tools/perf/tests/Build                      | 12 +++++-----
>  tools/perf/tests/builtin-test.c             |  6 -----
>  tools/perf/tests/evsel-tp-sched.c           | 16 +++++++++++--
>  tools/perf/tests/mmap-basic.c               | 26 +++++++++++++++++++--
>  tools/perf/tests/openat-syscall-all-cpus.c  | 11 ++++++++-
>  tools/perf/tests/openat-syscall-tp-fields.c | 11 ++++++++-
>  tools/perf/tests/openat-syscall.c           | 11 ++++++++-
>  tools/perf/tests/switch-tracking.c          | 23 +++++++++++++++++-
>  8 files changed, 96 insertions(+), 20 deletions(-)
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 01ed9335db4dba4e..c57ac14e7114e291 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -5,13 +5,13 @@ perf-test-y +=3D tests-scripts.o
>  perf-test-y +=3D parse-events.o
>  perf-test-y +=3D dso-data.o
>  perf-test-y +=3D vmlinux-kallsyms.o
> -perf-test-$(CONFIG_LIBTRACEEVENT) +=3D openat-syscall.o
> -perf-test-$(CONFIG_LIBTRACEEVENT) +=3D openat-syscall-all-cpus.o
> -perf-test-$(CONFIG_LIBTRACEEVENT) +=3D openat-syscall-tp-fields.o
> -perf-test-$(CONFIG_LIBTRACEEVENT) +=3D mmap-basic.o
> +perf-test-y +=3D openat-syscall.o
> +perf-test-y +=3D openat-syscall-all-cpus.o
> +perf-test-y +=3D openat-syscall-tp-fields.o
> +perf-test-y +=3D mmap-basic.o
>  perf-test-y +=3D perf-record.o
>  perf-test-y +=3D evsel-roundtrip-name.o
> -perf-test-$(CONFIG_LIBTRACEEVENT) +=3D evsel-tp-sched.o
> +perf-test-y +=3D evsel-tp-sched.o
>  perf-test-y +=3D fdarray.o
>  perf-test-y +=3D pmu.o
>  perf-test-y +=3D pmu-events.o
> @@ -29,7 +29,7 @@ perf-test-y +=3D task-exit.o
>  perf-test-y +=3D sw-clock.o
>  perf-test-y +=3D mmap-thread-lookup.o
>  perf-test-y +=3D thread-maps-share.o
> -perf-test-$(CONFIG_LIBTRACEEVENT) +=3D switch-tracking.o
> +perf-test-y +=3D switch-tracking.o
>  perf-test-y +=3D keep-tracking.o
>  perf-test-y +=3D code-reading.o
>  perf-test-y +=3D sample-parsing.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index d2cabaa8ad922d68..5ebeaf3d7b69a8d0 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -60,11 +60,9 @@ static struct test_suite *arch_tests[] =3D {
>
>  static struct test_suite *generic_tests[] =3D {
>         &suite__vmlinux_matches_kallsyms,
> -#ifdef HAVE_LIBTRACEEVENT
>         &suite__openat_syscall_event,
>         &suite__openat_syscall_event_on_all_cpus,
>         &suite__basic_mmap,
> -#endif
>         &suite__mem,
>         &suite__parse_events,
>         &suite__expr,
> @@ -74,10 +72,8 @@ static struct test_suite *generic_tests[] =3D {
>         &suite__tool_pmu,
>         &suite__dso_data,
>         &suite__perf_evsel__roundtrip_name_test,
> -#ifdef HAVE_LIBTRACEEVENT
>         &suite__perf_evsel__tp_sched_test,
>         &suite__syscall_openat_tp_fields,
> -#endif
>         &suite__hists_link,
>         &suite__python_use,
>         &suite__bp_signal,
> @@ -95,9 +91,7 @@ static struct test_suite *generic_tests[] =3D {
>         &suite__thread_maps_share,
>         &suite__hists_output,
>         &suite__hists_cumulate,
> -#ifdef HAVE_LIBTRACEEVENT
>         &suite__switch_tracking,
> -#endif
>         &suite__fdarray__filter,
>         &suite__fdarray__add,
>         &suite__kmod_path__parse,
> diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-t=
p-sched.c
> index 3da6a76eac3856d1..a7d3a59f01217280 100644
> --- a/tools/perf/tests/evsel-tp-sched.c
> +++ b/tools/perf/tests/evsel-tp-sched.c
> @@ -1,10 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/err.h>
> -#include <traceevent/event-parse.h>
>  #include "evsel.h"
>  #include "tests.h"
>  #include "debug.h"
>
> +#ifdef HAVE_LIBTRACEEVENT
> +#include <traceevent/event-parse.h>
> +
>  static int evsel__test_field(struct evsel *evsel, const char *name, int =
size, bool should_be_signed)
>  {
>         struct tep_format_field *field =3D evsel__field(evsel, name);
> @@ -31,10 +33,12 @@ static int evsel__test_field(struct evsel *evsel, con=
st char *name, int size, bo
>
>         return ret;
>  }
> +#endif // HAVE_LIBTRACEEVENT
>
>  static int test__perf_evsel__tp_sched_test(struct test_suite *test __may=
be_unused,
>                                            int subtest __maybe_unused)
>  {
> +#ifdef HAVE_LIBTRACEEVENT
>         struct evsel *evsel =3D evsel__newtp("sched", "sched_switch");
>         int ret =3D TEST_OK;
>
> @@ -87,12 +91,20 @@ static int test__perf_evsel__tp_sched_test(struct tes=
t_suite *test __maybe_unuse
>
>         evsel__delete(evsel);
>         return ret;
> +#else
> +       return TEST_SKIP;
> +#endif // HAVE_LIBTRACEEVENT
>  }
>
>  static struct test_case tests__perf_evsel__tp_sched_test[] =3D {
>         TEST_CASE_REASON("Parse sched tracepoints fields",
>                          perf_evsel__tp_sched_test,
> -                        "permissions"),
> +#ifdef HAVE_LIBTRACEEVENT
> +                        "permissions"
> +#else
> +                        "not linked with libtraceevent"
> +#endif
> +                       ),
>         {       .name =3D NULL, }
>  };
>
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.=
c
> index 012c8ae439fdcf56..f87ec3c40e091d5d 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -10,6 +10,7 @@
>  #include "evsel.h"
>  #include "thread_map.h"
>  #include "tests.h"
> +#include "tests/tests.h"
>  #include "util/mmap.h"
>  #include "util/sample.h"
>  #include <linux/err.h>
> @@ -31,6 +32,7 @@
>   */
>  static int test__basic_mmap(struct test_suite *test __maybe_unused, int =
subtest __maybe_unused)
>  {
> +#ifdef HAVE_LIBTRACEEVENT
>         int err =3D TEST_FAIL;
>         union perf_event *event;
>         struct perf_thread_map *threads;
> @@ -167,10 +169,14 @@ static int test__basic_mmap(struct test_suite *test=
 __maybe_unused, int subtest
>  out_free_threads:
>         perf_thread_map__put(threads);
>         return err;
> +#else
> +       return TEST_SKIP;
> +#endif // HAVE_LIBTRACEEVENT
>  }
>
> -static int test_stat_user_read(int event)
> +static int test_stat_user_read(int event __maybe_unused)
>  {
> +#ifdef HAVE_LIBTRACEEVENT
>         struct perf_counts_values counts =3D { .val =3D 0 };
>         struct perf_thread_map *threads;
>         struct perf_evsel *evsel;
> @@ -264,6 +270,9 @@ static int test_stat_user_read(int event)
>
>         perf_thread_map__put(threads);
>         return ret;
> +#else
> +       return TEST_SKIP;
> +#endif // HAVE_LIBTRACEEVENT
>  }
>
>  static int test__mmap_user_read_instr(struct test_suite *test __maybe_un=
used,
> @@ -281,23 +290,36 @@ static int test__mmap_user_read_cycles(struct test_=
suite *test __maybe_unused,
>  static struct test_case tests__basic_mmap[] =3D {
>         TEST_CASE_REASON("Read samples using the mmap interface",
>                          basic_mmap,
> -                        "permissions"),
> +#ifdef HAVE_LIBTRACEEVENT
> +                        "permissions"
> +#else
> +                        "not linked with libtraceevent"
> +#endif
> +                       ),
>         TEST_CASE_REASON("User space counter reading of instructions",
>                          mmap_user_read_instr,
> +#ifdef HAVE_LIBTRACEEVENT
>  #if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || =
\
>                          (defined(__riscv) && __riscv_xlen =3D=3D 64)
>                          "permissions"
>  #else
>                          "unsupported"
> +#endif
> +#else
> +                        "not linked with libtraceevent"
>  #endif
>                 ),
>         TEST_CASE_REASON("User space counter reading of cycles",
>                          mmap_user_read_cycles,
> +#ifdef HAVE_LIBTRACEEVENT
>  #if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || =
\
>                          (defined(__riscv) && __riscv_xlen =3D=3D 64)
>                          "permissions"
>  #else
>                          "unsupported"
> +#endif
> +#else
> +                        "not linked with libtraceevent"
>  #endif
>                 ),
>         {       .name =3D NULL, }
> diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/test=
s/openat-syscall-all-cpus.c
> index fb114118c87640b8..72dc22bef917f17d 100644
> --- a/tools/perf/tests/openat-syscall-all-cpus.c
> +++ b/tools/perf/tests/openat-syscall-all-cpus.c
> @@ -22,6 +22,7 @@
>  static int test__openat_syscall_event_on_all_cpus(struct test_suite *tes=
t __maybe_unused,
>                                                   int subtest __maybe_unu=
sed)
>  {
> +#ifdef HAVE_LIBTRACEEVENT
>         int err =3D TEST_FAIL, fd, idx;
>         struct perf_cpu cpu;
>         struct perf_cpu_map *cpus;
> @@ -122,13 +123,21 @@ static int test__openat_syscall_event_on_all_cpus(s=
truct test_suite *test __mayb
>  out_thread_map_delete:
>         perf_thread_map__put(threads);
>         return err;
> +#else
> +       return TEST_SKIP;
> +#endif // HAVE_LIBTRACEEVENT
>  }
>
>
>  static struct test_case tests__openat_syscall_event_on_all_cpus[] =3D {
>         TEST_CASE_REASON("Detect openat syscall event on all cpus",
>                          openat_syscall_event_on_all_cpus,
> -                        "permissions"),
> +#ifdef HAVE_LIBTRACEEVENT
> +                        "permissions"
> +#else
> +                        "not linked with libtraceevent"
> +#endif
> +                       ),
>         {       .name =3D NULL, }
>  };
>
> diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tes=
ts/openat-syscall-tp-fields.c
> index 3943da441979c0fc..cc0e31958646e88c 100644
> --- a/tools/perf/tests/openat-syscall-tp-fields.c
> +++ b/tools/perf/tests/openat-syscall-tp-fields.c
> @@ -26,6 +26,7 @@
>  static int test__syscall_openat_tp_fields(struct test_suite *test __mayb=
e_unused,
>                                           int subtest __maybe_unused)
>  {
> +#ifdef HAVE_LIBTRACEEVENT
>         struct record_opts opts =3D {
>                 .target =3D {
>                         .uid =3D UINT_MAX,
> @@ -144,12 +145,20 @@ static int test__syscall_openat_tp_fields(struct te=
st_suite *test __maybe_unused
>         evlist__delete(evlist);
>  out:
>         return ret;
> +#else
> +       return TEST_SKIP;
> +#endif // HAVE_LIBTRACEEVENT
>  }
>
>  static struct test_case tests__syscall_openat_tp_fields[] =3D {
>         TEST_CASE_REASON("syscalls:sys_enter_openat event fields",
>                          syscall_openat_tp_fields,
> -                        "permissions"),
> +#ifdef HAVE_LIBTRACEEVENT
> +                        "permissions"
> +#else
> +                        "not linked with libtraceevent"
> +#endif
> +                       ),
>         {       .name =3D NULL, }
>  };
>
> diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-=
syscall.c
> index 131b62271bfa270b..2ca0b7d2cca7672e 100644
> --- a/tools/perf/tests/openat-syscall.c
> +++ b/tools/perf/tests/openat-syscall.c
> @@ -17,6 +17,7 @@
>  static int test__openat_syscall_event(struct test_suite *test __maybe_un=
used,
>                                       int subtest __maybe_unused)
>  {
> +#ifdef HAVE_LIBTRACEEVENT
>         int err =3D TEST_FAIL, fd;
>         struct evsel *evsel;
>         unsigned int nr_openat_calls =3D 111, i;
> @@ -69,12 +70,20 @@ static int test__openat_syscall_event(struct test_sui=
te *test __maybe_unused,
>  out_thread_map_delete:
>         perf_thread_map__put(threads);
>         return err;
> +#else
> +       return TEST_SKIP;
> +#endif // HAVE_LIBTRACEEVENT
>  }
>
>  static struct test_case tests__openat_syscall_event[] =3D {
>         TEST_CASE_REASON("Detect openat syscall event",
>                          openat_syscall_event,
> -                        "permissions"),
> +#ifdef HAVE_LIBTRACEEVENT
> +                        "permissions"
> +#else
> +                        "not linked with libtraceevent"
> +#endif
> +                       ),
>         {       .name =3D NULL, }
>  };
>
> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch=
-tracking.c
> index 5cab17a1942e67d7..591ae74b663af3c1 100644
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
> @@ -22,6 +22,7 @@
>  #include "util/sample.h"
>  #include "pmus.h"
>
> +#ifdef HAVE_LIBTRACEEVENT
>  static int spin_sleep(void)
>  {
>         struct timeval start, now, diff, maxtime;
> @@ -314,6 +315,7 @@ static int process_events(struct evlist *evlist,
>         free_event_nodes(&events);
>         return ret;
>  }
> +#endif // HAVE_LIBTRACEEVENT
>
>  /**
>   * test__switch_tracking - test using sched_switch and tracking events.
> @@ -325,6 +327,7 @@ static int process_events(struct evlist *evlist,
>   */
>  static int test__switch_tracking(struct test_suite *test __maybe_unused,=
 int subtest __maybe_unused)
>  {
> +#ifdef HAVE_LIBTRACEEVENT
>         const char *sched_switch =3D "sched:sched_switch";
>         const char *cycles =3D "cycles:u";
>         struct switch_tracking switch_tracking =3D { .tids =3D NULL, };
> @@ -581,6 +584,24 @@ static int test__switch_tracking(struct test_suite *=
test __maybe_unused, int sub
>  out_err:
>         err =3D -1;
>         goto out;
> +#else
> +       return TEST_SKIP;
> +#endif // HAVE_LIBTRACEEVENT
>  }
>
> -DEFINE_SUITE("Track with sched_switch", switch_tracking);
> +static struct test_case tests__switch_tracking[] =3D {
> +       {
> +               .name =3D "switch_tracking",
> +               .desc =3D "Track with sched_switch",
> +               .run_case =3D test__switch_tracking,
> +#ifndef HAVE_LIBTRACEEVENT
> +               .skip_reason =3D "not linked with libtraceevent",
> +#endif
> +       },
> +       {       .name =3D NULL, }
> +};
> +
> +struct test_suite suite__switch_tracking =3D {
> +       .desc =3D "Track with sched_switch",
> +       .test_cases =3D tests__switch_tracking,
> +};
> --
> 2.47.0
>
