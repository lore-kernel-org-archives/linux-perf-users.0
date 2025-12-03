Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838F1F5842
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 01:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724341; cv=none; b=fr3NcJa7zIEYs/e8p0t2JUkREGUjH79QKpGHvyGIKAZm6X6bhJvw8LoUty0nnFOQY1u28eQ/osUtiPG9Fw0YVuijT/HZtKFPeXE4geBFdJv1eTpYEqh5Y8mTkDDmhdM5/jo+UcdOS3Ilq4JNzYI7Su1mLqIxbMVDjuCkhawMIns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724341; c=relaxed/simple;
	bh=BBCDmClhT7I5jLB+DXhKZX39FOgajD/bvmhMj7pJwsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIA45mXao+xIJ3waXP2wISNXWuxX4i2FxXi7OQnVUj5smE/tXpUIm+RTKjBiDC33xmMRSIAcPJOFoTaDOR2UOSY5Ynh7/GBtBD4XItQJe+tpYbs9QDLxSAqGR1sJS9g/jl3bQYy5U6KLDWF5bWjXssSS3OWbbcvI5mO4+CMmNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mWi1CBeF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWi1CBeF"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297e13bf404so90145ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 17:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764724339; x=1765329139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/FUbx8MdOculnLHyhhBxeJBDbTSKSIPDrLE+oK8xMI=;
        b=mWi1CBeFeZcdGiUCPzN2wBxeVSLSw4adXllWvVy0FRAcYY5H1+YlJ58J3kB31r1QgU
         qzxFJ6sS693h8pXbD91bs4vG30pTqdTE9RM50jcKrPY5nRHI546fjNxIJTJxmRlyQlbV
         KA8OdbgBQIkr0DLRmCqRoT/5tgoQJGjO8nkqoH70bXqyxShukmRCC17aK37v5P3e0K1w
         PCzLXesLcScfZEKSZBpnZ9emFKVaLMyaNk9J+WErYYYTQt0JfutfBWi55OVt2qxh4Bs/
         oPq8DjFOa4k2GFSLJXfHkpSENywyA5bhW33i3eZDcoLOG1Usc8Lc6rbTVb8wQ5zNEu5X
         2l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764724339; x=1765329139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z/FUbx8MdOculnLHyhhBxeJBDbTSKSIPDrLE+oK8xMI=;
        b=NINWzadtH/8Bhyes2szTIqg7viXeLJ74duC2UaXDwYPkjicVDs5wlO0z72fUCv4oyR
         Q6gPnjscxIKbUSgzPAFLVa3X107kYdRoDWZD5PmTVau1IdGgbeW0mkYpge7CsjzkgjCb
         oUiSwGupFGgrX62dFtfTeGu7hjMh+A5Qt6ow8LM8l4jubeHIqkepmQ+1sgKWKR4CMDxV
         lHTyjsgPn9vDCAwpu8rGybrlX5Ez59M214EGU5g3Bp0d5LXOtvldbPEcmmN/UAREjI8S
         IbY4mIuk6BB0zVtqm5ZPHZZqT++aP7yv1mnaeYct3T4PbcNVsjzok9/9oS3f2rt9b2AC
         Pvzg==
X-Forwarded-Encrypted: i=1; AJvYcCVtkqRaUJ6vlTAUkcw3i9IweQbr5Oguja7SiifV68uWLpDjYL7UhuH9hdF5fMdAaHTb9c8vMFrGUpwD9i4N+ubm@vger.kernel.org
X-Gm-Message-State: AOJu0YwKTw+aihARqsFMBFMhzQ5W2/3IC0KwoqTRzJhvhdNGONpcJ2LB
	4x7JdoJIoukBoQ+41yEcQ8qzJdRZDIj3nwZ87roZEVQ17nd7SbyWcjN0k/kn1sBvQg86BVxPudt
	WKBJqVsAONOQZtKQHg7LgWQDXcSl3hlK8K/4kbg6GhrGAxyT1LoQILLn6
X-Gm-Gg: ASbGncuRqQOvJrVsvDS0GSWuPRq52cMv31HwnjymUDzHb1iDvugVE/aLS1fdMK0jbME
	xyVFifxXSg9o7/Hp+RAbEiuCs+2F+Fz4dAsVlKIKc9QqBXETVD6CMVEaU21fz+yhI5eQjM3pKHb
	LF6t5XpVoEaTyzV88OtFV+pc6JT8EleGkEISFF6Bf7rkyrWXRe94jLAmkha/iARa53QAywMkPdM
	RaQxDEqtOIK+mptbQoiHEQFvqG1Oxf2xN7bXVkTDg/ltKmpYXRZJUpZuInHaHpbQ618cukB
X-Google-Smtp-Source: AGHT+IEqkIa+Putviu1Vg/zFkPsS4zZ/vtYWD87V7Ght7GcoQ6rWdP3+Iwnt1EsTf/4eKa7U2lGIfN/u94xiS6LQd4c=
X-Received: by 2002:a17:902:c402:b0:291:6488:5af5 with SMTP id
 d9443c01a7336-29d67e74fa2mr828305ad.1.1764724338493; Tue, 02 Dec 2025
 17:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202235718.1018752-1-namhyung@kernel.org> <20251202235718.1018752-6-namhyung@kernel.org>
In-Reply-To: <20251202235718.1018752-6-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Dec 2025 17:12:06 -0800
X-Gm-Features: AWmQ_bkmfAQk5jFZ-ISIMEdqQQLtixMH7M5HMJa9cqMfRJc3iN2spTnR54VBl9E
Message-ID: <CAP-5=fUgm63zw3Maub-JcEJyy57Bjby=jHbTzAAcGchonOamUg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] perf test: Add kallsyms split test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 3:57=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Create a fake root directory for /proc/{version,modules,kallsyms} in
> /tmp for testing.  The kallsyms has a bad symbol in the module and it
> causes the main map splitted.  The test ensures it only has two maps -
> kernel and the module and it finds the initial map after the module
> without creating the split maps like [kernel].0 and so on.
>
>   $ perf test -vv "split kallsyms"
>    69: split kallsyms:
>   --- start ---
>   test child forked, pid 1016196
>   try to create fake root directory
>   create kernel maps from the fake root directory
>   maps__set_modules_path_dir: cannot open /tmp/perf-test.Zrv6Sy/lib/modul=
es/X.Y.Z dir
>   Problems setting modules path maps, continuing anyway...
>   Failed to open /tmp/perf-test.Zrv6Sy/proc/kcore. Note /proc/kcore requi=
res CAP_SYS_RAWIO capability to access.
>   Using /tmp/perf-test.Zrv6Sy/proc/kallsyms for symbols
>   kernel map loaded - check symbol and map
>   ---- end(0) ----
>    69: split kallsyms                                                  : =
Ok
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/Build            |   1 +
>  tools/perf/tests/builtin-test.c   |   1 +
>  tools/perf/tests/kallsyms-split.c | 156 ++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h          |   1 +
>  4 files changed, 159 insertions(+)
>  create mode 100644 tools/perf/tests/kallsyms-split.c
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index af67f8ef74b49c58..c2a67ce459417e0f 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -69,6 +69,7 @@ perf-test-y +=3D util.o
>  perf-test-y +=3D hwmon_pmu.o
>  perf-test-y +=3D tool_pmu.o
>  perf-test-y +=3D subcmd-help.o
> +perf-test-y +=3D kallsyms-split.o
>
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
>  perf-test-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 9090e8238a447826..bd6ffa8e4578431a 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -140,6 +140,7 @@ static struct test_suite *generic_tests[] =3D {
>         &suite__symbols,
>         &suite__util,
>         &suite__subcmd_help,
> +       &suite__kallsyms_split,
>         NULL,
>  };
>
> diff --git a/tools/perf/tests/kallsyms-split.c b/tools/perf/tests/kallsym=
s-split.c
> new file mode 100644
> index 0000000000000000..bbbc66957e5d0453
> --- /dev/null
> +++ b/tools/perf/tests/kallsyms-split.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/compiler.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include "util/dso.h"
> +#include "util/map.h"
> +#include "util/symbol.h"
> +#include "util/debug.h"
> +#include "util/machine.h"
> +#include "tests.h"
> +
> +/*
> + * This test is to check whether a bad symbol in a module won't split ka=
llsyms maps.
> + * The main_symbol[1-3] should belong to the main [kernel.kallsyms] map =
even if the
> + * bad_symbol from the module is found in the middle.
> + */
> +static char root_template[] =3D "/tmp/perf-test.XXXXXX";
> +static char *root_dir;
> +
> +static const char proc_version[] =3D "Linux version X.Y.Z (just for perf=
 test)\n";
> +static const char proc_modules[] =3D "module 4096 1 - Live 0xffffffffcd0=
00000\n";
> +static const char proc_kallsyms[] =3D
> +       "ffffffffab200000 T _stext\n"
> +       "ffffffffab200010 T good_symbol\n"
> +       "ffffffffab200020 t bad_symbol\n"
> +       "ffffffffab200030 t main_symbol1\n"
> +       "ffffffffab200040 t main_symbol2\n"
> +       "ffffffffab200050 t main_symbol3\n"
> +       "ffffffffab200060 T _etext\n"
> +       "ffffffffcd000000 T start_module\t[module]\n"
> +       "ffffffffab200020 u bad_symbol\t[module]\n"
> +       "ffffffffcd000040 T end_module\t[module]\n";
> +
> +static struct {
> +       const char *name;
> +       const char *contents;
> +       long len;
> +} proc_files[] =3D {
> +       { "version", proc_version, sizeof(proc_version) - 1 },
> +       { "modules", proc_modules, sizeof(proc_modules) - 1 },
> +       { "kallsyms", proc_kallsyms, sizeof(proc_kallsyms) - 1 },
> +};
> +
> +static void remove_proc_dir(int sig __maybe_unused)
> +{
> +       char buf[128];
> +
> +       if (root_dir =3D=3D NULL)
> +               return;
> +
> +       for (unsigned i =3D 0; i < ARRAY_SIZE(proc_files); i++) {
> +               scnprintf(buf, sizeof(buf), "%s/proc/%s", root_dir, proc_=
files[i].name);
> +               remove(buf);
> +       }
> +
> +       scnprintf(buf, sizeof(buf), "%s/proc", root_dir);
> +       rmdir(buf);
> +
> +       rmdir(root_dir);
> +       root_dir =3D NULL;
> +}
> +
> +static int create_proc_dir(void)
> +{
> +       char buf[128];
> +
> +       root_dir =3D mkdtemp(root_template);
> +       if (root_dir =3D=3D NULL)
> +               return -1;
> +
> +       scnprintf(buf, sizeof(buf), "%s/proc", root_dir);
> +       if (mkdir(buf, 0700) < 0)
> +               goto err;
> +
> +       for (unsigned i =3D 0; i < ARRAY_SIZE(proc_files); i++) {
> +               int fd, len;
> +
> +               scnprintf(buf, sizeof(buf), "%s/proc/%s", root_dir, proc_=
files[i].name);
> +               fd =3D open(buf, O_RDWR | O_CREAT, 0600);
> +               if (fd < 0)
> +                       goto err;
> +
> +               len =3D write(fd, proc_files[i].contents, proc_files[i].l=
en);
> +               close(fd);
> +               if (len !=3D proc_files[i].len)
> +                       goto err;
> +       }
> +       return 0;
> +
> +err:
> +       remove_proc_dir(0);
> +       return -1;
> +}
> +
> +static int test__kallsyms_split(struct test_suite *test __maybe_unused,
> +                               int subtest __maybe_unused)
> +{
> +       struct machine m;
> +       struct map *map =3D NULL;
> +       int ret =3D TEST_FAIL;
> +
> +       pr_debug("try to create fake root directory\n");
> +       if (create_proc_dir() < 0) {
> +               pr_debug("SKIP: cannot create a fake root directory\n");
> +               return TEST_SKIP;
> +       }
> +
> +       signal(SIGINT, remove_proc_dir);
> +       signal(SIGPIPE, remove_proc_dir);
> +       signal(SIGSEGV, remove_proc_dir);
> +       signal(SIGTERM, remove_proc_dir);
> +
> +       pr_debug("create kernel maps from the fake root directory\n");
> +       machine__init(&m, root_dir, HOST_KERNEL_ID);
> +       if (machine__create_kernel_maps(&m) < 0) {
> +               pr_debug("FAIL: failed to create kernel maps\n");
> +               goto out;
> +       }
> +
> +       /* force to use /proc/kallsyms */
> +       symbol_conf.ignore_vmlinux =3D true;
> +       symbol_conf.ignore_vmlinux_buildid =3D true;
> +       symbol_conf.allow_aliases =3D true;
> +
> +       if (map__load(machine__kernel_map(&m)) < 0) {
> +               pr_debug("FAIL: failed to load kallsyms\n");
> +               goto out;
> +       }
> +
> +       pr_debug("kernel map loaded - check symbol and map\n");
> +       if (maps__nr_maps(machine__kernel_maps(&m)) !=3D 2) {
> +               pr_debug("FAIL: it should have the kernel and a module, b=
ut has %u maps\n",
> +                        maps__nr_maps(machine__kernel_maps(&m)));
> +               goto out;
> +       }
> +
> +       if (machine__find_kernel_symbol_by_name(&m, "main_symbol3", &map)=
 =3D=3D NULL) {
> +               pr_debug("FAIL: failed to find a symbol\n");
> +               goto out;
> +       }
> +
> +       if (!RC_CHK_EQUAL(map, machine__kernel_map(&m))) {
> +               pr_debug("FAIL: the symbol is not in the kernel map\n");
> +               goto out;
> +       }
> +       ret =3D TEST_OK;
> +
> +out:
> +       remove_proc_dir(0);
> +       machine__exit(&m);
> +       return ret;
> +}
> +
> +DEFINE_SUITE("split kallsyms", kallsyms_split);
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index f5fba95b6f3ffbd3..cb67ddbd03753531 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -178,6 +178,7 @@ DECLARE_SUITE(event_groups);
>  DECLARE_SUITE(symbols);
>  DECLARE_SUITE(util);
>  DECLARE_SUITE(subcmd_help);
> +DECLARE_SUITE(kallsyms_split);
>
>  /*
>   * PowerPC and S390 do not support creation of instruction breakpoints u=
sing the
> --
> 2.52.0.158.g65b55ccf14-goog
>
