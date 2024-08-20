Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3289190671
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Aug 2024 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171046; cv=none; b=ERQXLyg6vtPci7nORoCpZRJ0Z14YJLRMitJan7MQ5ap2vdxht/sK99VZ/j7wd25ZnGN9J4BNF6dKTYGoMfhHzlNj349OmznhWQcTx1hnp/OIJkCj5KYxY0wW0cEU4jf/3zEZ+XB3Yx+ZbjqxKMvB9mvF9/kvu+aFOkxBZOjgXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171046; c=relaxed/simple;
	bh=4k+s4YO3Hy+CWFesWYwNFzAF5MNfDwpDXFAaMaImg0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LuVOEWbtxKYXRhtK89uKDI/zg4PminFYvQtUzO18VzRbEWzVua4CrpRGKoIBdswMFo4XmdDaPUyndt6fxHAHzYZUOaPbNOzEsc6WSyvzqo8VQzahxQrwBgto4l7dGQvzhLhOfrTqsqsb8irNnf3blIpwvirqhGlOaSB9kjPT87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2UlyOhll; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2UlyOhll"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-202018541afso118375ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Aug 2024 09:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724171044; x=1724775844; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TN4jMg0OxJ5q97VBngUzGeWPosFAHW2jqYW6n7n/G0=;
        b=2UlyOhll7oQiqESF9DygKHV4+B731dw/aB/zHfl7shJtMHtxiarxtBi8+z86okJZ5o
         5QdJevm0PfUMBInv6dPnQmTknFIRsZaqzGclAjSLfUqSP9WombJ4fGOe9t76gDCJp69v
         d6/VaMA4iTH0CSs/0GeU2/ax32WNbm78Le3IM/4wBUAWoJDLQ3doQOYhl47ovXFetMlT
         1YSB53dW8gq59MsvxTDiz+gOyX2ptr9AWbj2mpQ7h+N5we8+IRwVamJ8IcEm2yR+2I3B
         Le9mpPZecZGIQlzIQcGXnCSHxikYJ5kZ3OqC7m2xrQyGZE9R1az6wEJcTjdlEq4OOKtd
         j+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171044; x=1724775844;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TN4jMg0OxJ5q97VBngUzGeWPosFAHW2jqYW6n7n/G0=;
        b=GiFOq6K/KIo51ZKTeSggFR6SiHTuNcfqu5dUtID5LchJdZOlF72/mq1p1fUZCo2qgU
         rYVVLPd7quvH3dQWq82/SB0Sem0In6RTVSzOzFbD2EknQR4iNiYiW7z8m/bN/qpIx4r9
         4Pc6PrS/ZKw6q5ylE+FeOI6Cc5GxG45Z9IszmpgIvXz6L8woTRjOuWZ9J/EFVavzLiid
         t3anMNWSj2Iwot3qch8NYgDQrau0jmS5KYAf2gRDdYPpo4mmHI3fdLuGdpkvbRBK+RA1
         iWIWqNqhjzmAZk12daymQs59ZMWXl3dXWrNnCcWQixdzt4nkW83SXENlT4GP2yvdi/zh
         zi+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6eGgWNKcnjhU4HZkiku9R/CW+S1m60+dutiAIg2qKyCo8BF45Lh1OoqoqfvwJwfFD7gZSVGKKh+tPOtVLZ1kK@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZfVbMODB+4bSqyDDGtkONn7b+Hp/Wa5Rz4i1FtdP8Xz8yG7P
	qc6n4VsEiRDdmJX9any3F+Eao9R3blP7QWkbCIYoM5XBOGEL/OcUXDD5vwsPG6I8dXFqEB/anMr
	r0ILQnn61/he+g877XkZLc3fl3xHNEt/nPdjp
X-Google-Smtp-Source: AGHT+IH9+HswIKSue9tbinWSCbFaxM44Z4MveZEgdvZVAJq6LajSaXPVLVYHfMuDSk7YdHiO4zsrdR7LzVmYOCjzTDo=
X-Received: by 2002:a17:902:ea02:b0:201:dc7b:a882 with SMTP id
 d9443c01a7336-202e629dfbcmr2012145ad.26.1724171043500; Tue, 20 Aug 2024
 09:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806220614.831914-1-irogers@google.com>
In-Reply-To: <20240806220614.831914-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Aug 2024 09:23:51 -0700
Message-ID: <CAP-5=fUWdyp++BKgwZoKWv_mYNGhKj2LKG8p2Ghfg74T+6PLXg@mail.gmail.com>
Subject: Re: [PATCH v3] perf cap: Tidy up and improve capability testing
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

On Tue, Aug 6, 2024 at 3:06=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
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
> isn't supported.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
> v3: rebase resolving builtin-ftrace.c conflicts and incorporating
>     change in:
> https://lore.kernel.org/lkml/20240729004127.238611-3-namhyung@kernel.org/
> v2: fix syscall number and '>' should have been '>=3D'.
> ---
>  tools/perf/Makefile.config  | 11 -------
>  tools/perf/builtin-ftrace.c | 28 ++++++++---------
>  tools/perf/util/Build       |  2 +-
>  tools/perf/util/cap.c       | 63 ++++++++++++++++++++++++++-----------
>  tools/perf/util/cap.h       | 23 ++------------
>  tools/perf/util/symbol.c    |  8 ++---
>  tools/perf/util/util.c      | 12 +++++--
>  7 files changed, 75 insertions(+), 72 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index fa679db61f62..4eb1fc897baf 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1031,17 +1031,6 @@ ifndef NO_LIBZSTD
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
> index a615c405d98f..88a87bf387d2 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -63,20 +63,21 @@ static void ftrace__workload_exec_failed_signal(int s=
igno __maybe_unused,
>         done =3D true;
>  }
>
> -static int check_ftrace_capable(void)
> +static bool check_ftrace_capable(void)
>  {
> -       if (!(perf_cap__capable(CAP_PERFMON) ||
> -             perf_cap__capable(CAP_SYS_ADMIN))) {
> -               pr_err("ftrace only works for %s!\n",
> -#ifdef HAVE_LIBCAP_SUPPORT
> -               "users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
> -#else
> -               "root"
> -#endif
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
>                 );
> -               return -1;
> -       }
> -       return 0;
> +       return false;
>  }
>
>  static int __write_tracing_file(const char *name, const char *val, bool =
append)
> @@ -1579,8 +1580,7 @@ int cmd_ftrace(int argc, const char **argv)
>         signal(SIGCHLD, sig_handler);
>         signal(SIGPIPE, sig_handler);
>
> -       ret =3D check_ftrace_capable();
> -       if (ret < 0)
> +       if (!check_ftrace_capable())
>                 return -1;
>
>         ret =3D perf_config(perf_ftrace_config, &ftrace);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index b24360c04aae..adbaf7748019 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -221,7 +221,7 @@ perf-util-$(CONFIG_ZLIB) +=3D zlib.o
>  perf-util-$(CONFIG_LZMA) +=3D lzma.o
>  perf-util-$(CONFIG_ZSTD) +=3D zstd.o
>
> -perf-util-$(CONFIG_LIBCAP) +=3D cap.o
> +perf-util-y +=3D cap.o
>
>  perf-util-$(CONFIG_CXX_DEMANGLE) +=3D demangle-cxx.o
>  perf-util-y +=3D demangle-ocaml.o
> diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
> index c3ba841bbf37..7574a67651bc 100644
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
> +#define SYS_capget 90
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
> +       if (cap >=3D 32) {
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
> 2.46.0.rc2.264.g509ed76dc8-goog
>
