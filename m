Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A589A7FBA8
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276995; cv=none; b=tRaeh1sfDeEziQ33xfnpZCOgoFB8S4mVWaJ7Pxd0B0DkRvkpTtiin5fHHSc/EdT4OCb7PYSLsnNk0p1y2zz5YuZ4FigTtIt9GZqlcAwpGBrITUw5w3PuU4RBxj4viIdCzP+GUuAh54GRANfqmPC9Y8zLK2zZ3mZU00TnQucQ8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276995; c=relaxed/simple;
	bh=t6B1LA4zqZ8ueYk8CYBnXqH9l78JsoKEpJUtrVyMUcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IO+YEYtQhDuUdiduWD8oRbKVKBrByftrhBph8PkG6HshgdOtbB/1kr9TMAyeA4A4Md1wg143ZYX9Shc6zG016PtK64m1M4xML/sQ28NQ2AEZK9RgFZim7cbWE0c61Qz/xH4Yz7OoIi0lSfk0301tZlvnjlJHgzniMHKIHNXDUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u3XSBnSQ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3XSBnSQ"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44fdc70e695so43651cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722276991; x=1722881791; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWiPyvyu7ecXoQvNdyQ0e4PXq8L8deC2fhQOyAGRWdA=;
        b=u3XSBnSQ/VvpiYDa877x1PKuP7ZQBf6DXrkxsZzCELqPd+cZREPNC6bWShl9DZT7Mw
         bH06qvLthSLnsZMCOUwdfi5GFIWFWoUreoGXrPvBkUAdCPsbpiJ2KLnGMMuy9a250quw
         qgw3tmADudf17GzknkySLig8ekrGLGDSciYfUP6PiKZfI5Wxd/t0V0FpW6A/JEX4SuNS
         khJ0dJR4XHMplSqiExcHuLBTq0eWSPkSJgHGN6yNELnHdT6vfp+cC1/fD/uMS8vusVYo
         8VJs+l32Uz91u5w2agSlRw3ndL4r6dCZdpzaepLhsrT2UazVq5vA2QtzE+Cd3mkTYtwl
         gk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722276991; x=1722881791;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWiPyvyu7ecXoQvNdyQ0e4PXq8L8deC2fhQOyAGRWdA=;
        b=kL1dovcDXw2ag8mLd37hGMpJs/bnimn4SD6ZsOPElQ3iCfxTdLdONOVE6TGe++zqAt
         tCsyt0d/n4tQ+5+UbhAhos+qMCxBbUgkKIrO/e4rSxwG02dDMcOo8YojmUU+jxHfB4Vb
         4wRq+mRYBRqd3IXksT21k8cf593ysg089saLGsXJl+omp6uiViIwJZuLe2/xJsLECFlT
         wU9tVjqwQxinlo0G1NJSjFIlqzIW292b1tFwu3qtQfmLCDrwkO2hx9MwjHNfQtyYTP90
         i7LqH1Krxzx1ZLB6y2tGUmtdXVo13Ng0Clq2Pr2sjpcwxVTE5LX13/X9Hysc5/xXylZ9
         ZmLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX04eAmJN6AdA+1Tla4TLVKoMswcwy3LjgGjIOrFcHGlT2d+472jk5/Jo2NTwugMLXArGoCefrVQ2QrXH6dULDTomZoEVyEkgku/NOY0Znu9w==
X-Gm-Message-State: AOJu0YxF5qTWy5KPj4/1J5kVY4qoh51/12We4gm+QYYdGrm9jsZTnYSL
	QmXYHH5xntuavLT7AP0EN6dctNllG0y/XWvYALzdGuObnEfJNen5BIjU9fuxfgMXu3FQeVCmuvL
	8/U1ORitWvR8fInGx8BJ1Rl1wD1hBuQG53KsJ
X-Google-Smtp-Source: AGHT+IGZ+WOUgJVVPyty8rkhJWaAzIkfT+8IeGbVFcGg+BX4EPxm6yPAXlhVQGUlQJrbAKDRWJzL6BrRIKSotArZ1Xc=
X-Received: by 2002:a05:622a:1829:b0:447:e59b:54eb with SMTP id
 d75a77b69052e-45032cdd446mr833191cf.26.1722276991339; Mon, 29 Jul 2024
 11:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729181356.2866845-1-irogers@google.com>
In-Reply-To: <20240729181356.2866845-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Jul 2024 11:16:20 -0700
Message-ID: <CAP-5=fXsOrpeLS1fE8git8FL1bjUZArE64F00OaBQPgYiKJFLg@mail.gmail.com>
Subject: Re: [PATCH v1] perf cap: Tidy up and improve capability testing
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Leo Yan <leo.yan@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:14=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Remove dependence on libcap. libcap is only used to query whether a
> capability is supported, which is just 1 capget system call.
>
> If the capget system call fails, fall back on root permission
> checking. Previously if libcap fails then the permission is assumed
> not present which may be pessimistic/wrong.
>
> Add a used_root out argument to perf_cap__capable to say whether the
> fall back root check was used. This allows the correct error message,
> "root" vs "users with the CAP_PERFMON or CAP_SYS_ADMIN capability", to
> be selected.
>
> Tidy uses of perf_cap__capable so that tests aren't repeated if capget
> isn't supported, to reduce calls or refactor similar to:
> https://lore.kernel.org/lkml/20240729004127.238611-3-namhyung@kernel.org/
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config  | 11 -------
>  tools/perf/builtin-ftrace.c | 44 ++++++++++++--------------
>  tools/perf/util/Build       |  2 +-
>  tools/perf/util/cap.c       | 63 ++++++++++++++++++++++++++-----------
>  tools/perf/util/cap.h       | 23 ++------------
>  tools/perf/util/symbol.c    |  8 ++---
>  tools/perf/util/util.c      | 12 +++++--
>  7 files changed, 81 insertions(+), 82 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a4829b6532d8..a9517272f80c 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1018,17 +1018,6 @@ ifndef NO_LIBZSTD
>    endif
>  endif
>
> -ifndef NO_LIBCAP
> -  ifeq ($(feature-libcap), 1)
> -    CFLAGS +=3D -DHAVE_LIBCAP_SUPPORT
> -    EXTLIBS +=3D -lcap
> -    $(call detected,CONFIG_LIBCAP)
> -  else
> -    $(warning No libcap found, disables capability support, please insta=
ll libcap-devel/libcap-dev)
> -    NO_LIBCAP :=3D 1
> -  endif
> -endif
> -
>  ifndef NO_BACKTRACE
>    ifeq ($(feature-backtrace), 1)
>      CFLAGS +=3D -DHAVE_BACKTRACE_SUPPORT
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index eb30c8eca488..435208288d24 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -560,6 +560,23 @@ static void select_tracer(struct perf_ftrace *ftrace=
)
>         pr_debug("%s tracer is used\n", ftrace->tracer);
>  }
>
> +static bool check_ftrace_capable(void)
> +{
> +       bool used_root;
> +
> +       if (perf_cap__capable(CAP_PERFMON, &used_root))
> +               return true;
> +
> +       if (!used_root && perf_cap__capable(CAP_SYS_ADMIN, &used_root))
> +               return true;
> +
> +       pr_err("ftrace only works for %s!\n",
> +               used_root ? "root"
> +                         : "users with the CAP_PERFMON or CAP_SYS_ADMIN =
capability"
> +               );
> +       return -1;
> +}
> +
>  static int __cmd_ftrace(struct perf_ftrace *ftrace)
>  {
>         char *trace_file;
> @@ -569,18 +586,6 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>                 .events =3D POLLIN,
>         };
>
> -       if (!(perf_cap__capable(CAP_PERFMON) ||
> -             perf_cap__capable(CAP_SYS_ADMIN))) {
> -               pr_err("ftrace only works for %s!\n",
> -#ifdef HAVE_LIBCAP_SUPPORT
> -               "users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
> -#else
> -               "root"
> -#endif
> -               );
> -               return -1;
> -       }
> -
>         select_tracer(ftrace);
>
>         if (reset_tracing_files(ftrace) < 0) {
> @@ -885,18 +890,6 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
>         };
>         int buckets[NUM_BUCKET] =3D { };
>
> -       if (!(perf_cap__capable(CAP_PERFMON) ||
> -             perf_cap__capable(CAP_SYS_ADMIN))) {
> -               pr_err("ftrace only works for %s!\n",
> -#ifdef HAVE_LIBCAP_SUPPORT
> -               "users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
> -#else
> -               "root"
> -#endif
> -               );
> -               return -1;
> -       }
> -
>         trace_fd =3D prepare_func_latency(ftrace);
>         if (trace_fd < 0)
>                 goto out;
> @@ -1197,6 +1190,9 @@ int cmd_ftrace(int argc, const char **argv)
>         INIT_LIST_HEAD(&ftrace.graph_funcs);
>         INIT_LIST_HEAD(&ftrace.nograph_funcs);
>
> +       if (!check_ftrace_capable())
> +               return -1;
> +
>         signal(SIGINT, sig_handler);
>         signal(SIGUSR1, sig_handler);
>         signal(SIGCHLD, sig_handler);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 0f18fe81ef0b..91ce0ab4defc 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -220,7 +220,7 @@ perf-util-$(CONFIG_ZLIB) +=3D zlib.o
>  perf-util-$(CONFIG_LZMA) +=3D lzma.o
>  perf-util-$(CONFIG_ZSTD) +=3D zstd.o
>
> -perf-util-$(CONFIG_LIBCAP) +=3D cap.o
> +perf-util-y +=3D cap.o
>
>  perf-util-$(CONFIG_CXX_DEMANGLE) +=3D demangle-cxx.o
>  perf-util-y +=3D demangle-ocaml.o
> diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
> index c3ba841bbf37..1ef8af0ccde9 100644
> --- a/tools/perf/util/cap.c
> +++ b/tools/perf/util/cap.c
> @@ -3,27 +3,52 @@
>   * Capability utilities
>   */
>
> -#ifdef HAVE_LIBCAP_SUPPORT
> -
>  #include "cap.h"
> -#include <stdbool.h>
> -#include <sys/capability.h>
> -
> -bool perf_cap__capable(cap_value_t cap)
> -{
> -       cap_flag_value_t val;
> -       cap_t caps =3D cap_get_proc();
> +#include "debug.h"
> +#include <errno.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <linux/capability.h>
> +#include <sys/syscall.h>
>
> -       if (!caps)
> -               return false;
> +#ifndef SYS_capget
> +#define SYS_capget 265
> +#endif
>
> -       if (cap_get_flag(caps, cap, CAP_EFFECTIVE, &val) !=3D 0)
> -               val =3D CAP_CLEAR;
> +#define MAX_LINUX_CAPABILITY_U32S _LINUX_CAPABILITY_U32S_3
>
> -       if (cap_free(caps) !=3D 0)
> -               return false;
> -
> -       return val =3D=3D CAP_SET;
> +bool perf_cap__capable(int cap, bool *used_root)
> +{
> +       struct __user_cap_header_struct header =3D {
> +               .version =3D _LINUX_CAPABILITY_VERSION_3,
> +               .pid =3D getpid(),
> +       };
> +       struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S];
> +       __u32 cap_val;
> +
> +       *used_root =3D false;
> +       while (syscall(SYS_capget, &header, &data[0]) =3D=3D -1) {
> +               /* Retry, first attempt has set the header.version correc=
tly. */
> +               if (errno =3D=3D EINVAL && header.version !=3D _LINUX_CAP=
ABILITY_VERSION_3 &&
> +                   header.version =3D=3D _LINUX_CAPABILITY_VERSION_1)
> +                       continue;
> +
> +               pr_debug2("capget syscall failed (%s - %d) fall back on r=
oot check\n",
> +                         strerror(errno), errno);
> +               *used_root =3D true;
> +               return geteuid() =3D=3D 0;
> +       }
> +
> +       /* Extract the relevant capability bit. */
> +       if (cap > 32) {

Should be >=3D, will fix in v2.

Thanks,
Ian

> +               if (header.version =3D=3D _LINUX_CAPABILITY_VERSION_3) {
> +                       cap_val =3D data[1].effective;
> +               } else {
> +                       /* Capability beyond 32 is requested but only 32 =
are supported. */
> +                       return false;
> +               }
> +       } else {
> +               cap_val =3D data[0].effective;
> +       }
> +       return (cap_val & (1 << (cap & 0x1f))) !=3D 0;
>  }
> -
> -#endif  /* HAVE_LIBCAP_SUPPORT */
> diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
> index ae52878c0b2e..0c6a1ff55f07 100644
> --- a/tools/perf/util/cap.h
> +++ b/tools/perf/util/cap.h
> @@ -3,26 +3,6 @@
>  #define __PERF_CAP_H
>
>  #include <stdbool.h>
> -#include <linux/capability.h>
> -#include <linux/compiler.h>
> -
> -#ifdef HAVE_LIBCAP_SUPPORT
> -
> -#include <sys/capability.h>
> -
> -bool perf_cap__capable(cap_value_t cap);
> -
> -#else
> -
> -#include <unistd.h>
> -#include <sys/types.h>
> -
> -static inline bool perf_cap__capable(int cap __maybe_unused)
> -{
> -       return geteuid() =3D=3D 0;
> -}
> -
> -#endif /* HAVE_LIBCAP_SUPPORT */
>
>  /* For older systems */
>  #ifndef CAP_SYSLOG
> @@ -33,4 +13,7 @@ static inline bool perf_cap__capable(int cap __maybe_un=
used)
>  #define CAP_PERFMON    38
>  #endif
>
> +/* Query if a capability is supported, used_root is set if the fallback =
root check was used. */
> +bool perf_cap__capable(int cap, bool *used_root);
> +
>  #endif /* __PERF_CAP_H */
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 19eb623e0826..a18927d792af 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2425,14 +2425,14 @@ static bool symbol__read_kptr_restrict(void)
>  {
>         bool value =3D false;
>         FILE *fp =3D fopen("/proc/sys/kernel/kptr_restrict", "r");
> +       bool used_root;
> +       bool cap_syslog =3D perf_cap__capable(CAP_SYSLOG, &used_root);
>
>         if (fp !=3D NULL) {
>                 char line[8];
>
>                 if (fgets(line, sizeof(line), fp) !=3D NULL)
> -                       value =3D perf_cap__capable(CAP_SYSLOG) ?
> -                                       (atoi(line) >=3D 2) :
> -                                       (atoi(line) !=3D 0);
> +                       value =3D cap_syslog ? (atoi(line) >=3D 2) : (ato=
i(line) !=3D 0);
>
>                 fclose(fp);
>         }
> @@ -2440,7 +2440,7 @@ static bool symbol__read_kptr_restrict(void)
>         /* Per kernel/kallsyms.c:
>          * we also restrict when perf_event_paranoid > 1 w/o CAP_SYSLOG
>          */
> -       if (perf_event_paranoid() > 1 && !perf_cap__capable(CAP_SYSLOG))
> +       if (perf_event_paranoid() > 1 && !cap_syslog)
>                 value =3D true;
>
>         return value;
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 4f561e5e4162..9d55a13787ce 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -325,9 +325,15 @@ int perf_event_paranoid(void)
>
>  bool perf_event_paranoid_check(int max_level)
>  {
> -       return perf_cap__capable(CAP_SYS_ADMIN) ||
> -                       perf_cap__capable(CAP_PERFMON) ||
> -                       perf_event_paranoid() <=3D max_level;
> +       bool used_root;
> +
> +       if (perf_cap__capable(CAP_SYS_ADMIN, &used_root))
> +               return true;
> +
> +       if (!used_root && perf_cap__capable(CAP_PERFMON, &used_root))
> +               return true;
> +
> +       return perf_event_paranoid() <=3D max_level;
>  }
>
>  static int
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>
