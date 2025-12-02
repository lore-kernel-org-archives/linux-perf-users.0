Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22932248F6A
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708390; cv=none; b=FRUA1IsDPVcYOPUFtOcXa2bNsU3sSb1Ik6zGhQll+lqRO0jdSk8In8dpTy0Nf84zjlslEleOJcX/wBi4srvfArcYQEMup4x95gJJYQJqyfbumlp4YocakvmvW9VEoEIm9V41WEL2nXYW6+PwIMC9D+HlU/jUWLEMhSCK9t6D/YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708390; c=relaxed/simple;
	bh=GsiFRXMy8L9PhPkg76ALfPDH1U5diIE9lqQlNBADT0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9yPmEKkwvBMxhupdQUFUqO4qzR2aecxfGt2+k6btgKwaDnyyFsHE5yzGDbKLl0PzKMsLxs54GK5yovMMVmIihckuNaPb/A4cUrq04Q5wUcLS92eiDMGeRWVzyIx1HThleJjnlFwpH+f120dn4qF1iaIjU+rxOVCAcG7SFffct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iD26MBd9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iD26MBd9"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2980343d9d1so2385ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 12:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764708388; x=1765313188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvINskZdRxGj6CdSC+d1N81brpa/amBMW90S6I+Ja2I=;
        b=iD26MBd9wLT1JNBw0pY570Ylg6FMJicZHCL/5C+WRNqcxws4/EvzISHec1X+EJUXno
         sF+TmCPRQEXZraMDXhehruBC/6jWzLf3eQZzJfrFPadz9sTMCz7Rdvp53vLWdQj2p61l
         uRKzLx8ENFEuMpPeC9oelgXI9+Ah5TlVOK4r1LtbSnM2lkWR69jxeS/42duLSWR4olTf
         8Q6UldKOrhtxFhBdvK055FSr0TJPjfIGaBmBWGz1CgTyKp+iSmaiuJ0gMEshL+a0iBsv
         wzO3ic17KAuQrTMvMzkpAcV2wNMMFU6cPRFmKtbcKakhwUHkTCzZarQazxh4xodjg1VM
         Mofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764708388; x=1765313188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pvINskZdRxGj6CdSC+d1N81brpa/amBMW90S6I+Ja2I=;
        b=eHwKwHeToK8e10jwVGuCHml/pD70HeRrbtvILusWkhCoDoS9Lb0hqfiD0kZ3vqcyBQ
         oSQATdKp+I1mkKWrd6Wzjp9IYLKUeyTNMlXe7dkQDohDRi4ps+LHEfUlqhD7yhe9mgce
         xD7+smm6+RSMq/nrJ0Gqp0mV3TAkuWln30CZkX5h3OXttdyQ9K+iE1BFnk4+GYQPCCIU
         8t/vJ+4qmMt939ulnSPprR91B6IkaYH3EapltKZpbiyBtWwa3XPV1NugsyHrHnrSd6rk
         Ls8V1cCZY+fLRs2BPW7BjRtl2Lz/rJA4ahjqe9XSLZNTkjXXfnI9LYJ7E5PFf6/AUvGi
         FPjA==
X-Forwarded-Encrypted: i=1; AJvYcCXzJH8ILYn8YHxywtpLRyg2gsTOXiLobd7G+uwckzwFW2nrqf/4WmseUkpdhCmM4/8xv340PoVaAZm7h0B1aZQy@vger.kernel.org
X-Gm-Message-State: AOJu0YxM2ZZG1sUofzqihtmQbHuuBOwj4vmPERceaU5XkWMmPfWcYziD
	IBqEOX7jn7ekQt2UDl+j0RvIUMtczcxnz8a7DEUVYxuc18Vyq8YoERdvl6KnumyScntsiMX23bS
	OMeaE/iO0r7OXv36GDyZ0nnJXEebdp8LH/PlvpIir
X-Gm-Gg: ASbGncvSV2yMWtux6kGdmfCbG64kTUU8wbOdaLpsbbZ6ksUiWMLaYpWmaAez8KD4fQA
	QJdxKpSf6Qdzk2i6WZ5vClT4EkMC1OS+xAjeTqLMwMwvC/hsioBHLEliIHAn0a8VOy1Q4y09Qeo
	yrLTKNqqastCLMIqQwQQUiONOZ9GBb1b/V5zMr2VdjfSiUz24Lzik4c8T4+LifIxF0xwVPOUyB5
	37RfQ0WkdvK23NsaY87UQltK7zZhKcr56zv9IKXK1gNoL6DlIk3BgFSoSic1KKJJzoVj5mqj+TP
	AASwG8iUt10OLBxajF/2/Aa1ZDbW4dxRbyg=
X-Google-Smtp-Source: AGHT+IHNqx+x1PmLHL1NCUn+dPZNbXEMz+9XWXlqbCBYD4oJCVrDEbF9/xO1dd3uGsd2oWDmp+0xlOv3uo6ijn2NRcM=
X-Received: by 2002:a17:903:228b:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-29d6662432amr720175ad.4.1764708388072; Tue, 02 Dec 2025
 12:46:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202081645.931527-1-namhyung@kernel.org> <20251202081645.931527-6-namhyung@kernel.org>
In-Reply-To: <20251202081645.931527-6-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Dec 2025 12:46:16 -0800
X-Gm-Features: AWmQ_blW5io6L-ARd_wl-VwYeUBVqnclmQA2zpb4zMR1Otde3fcqWMkftcELDZg
Message-ID: <CAP-5=fVQz--juRTRg82_oWUpWrt=kzwhEgR=c_zCQ3X3sf5sdg@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf test: Add kallsyms split test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 12:16=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Add fake_root directory for /proc/{version,modules,kallsyms}.  The
> kallsyms has a bad symbol in the module and it causes the main map
> splitted.  The test ensures it only has two maps - kernel and the module
> and it finds the initial map after the module without creating the split
> maps like [kernel].0 and so on.
>
>   $ perf test -vv "split kallsyms"
>    69: split kallsyms:
>   --- start ---
>   test child forked, pid 921678
>   try to find fake root directory
>   maps__set_modules_path_dir: cannot open tests/fake_root/lib/modules/X.Y=
.Z dir
>   Problems setting modules path maps, continuing anyway...
>   Failed to open tests/fake_root/proc/kcore. Note /proc/kcore requires CA=
P_SYS_RAWIO capability to access.
>   Using tests/fake_root/proc/kallsyms for symbols
>   kernel map loaded - check symbol and map
>   ---- end(0) ----
>    69: split kallsyms                                                  : =
Ok
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/Build                   |  1 +
>  tools/perf/tests/builtin-test.c          |  1 +
>  tools/perf/tests/fake_root/proc/kallsyms | 10 ++++
>  tools/perf/tests/fake_root/proc/modules  |  1 +
>  tools/perf/tests/fake_root/proc/version  |  1 +
>  tools/perf/tests/kallsyms-split.c        | 72 ++++++++++++++++++++++++
>  tools/perf/tests/tests.h                 |  1 +
>  7 files changed, 87 insertions(+)
>  create mode 100644 tools/perf/tests/fake_root/proc/kallsyms
>  create mode 100644 tools/perf/tests/fake_root/proc/modules
>  create mode 100644 tools/perf/tests/fake_root/proc/version
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
> diff --git a/tools/perf/tests/fake_root/proc/kallsyms b/tools/perf/tests/=
fake_root/proc/kallsyms
> new file mode 100644
> index 0000000000000000..75d65639e6889c69
> --- /dev/null
> +++ b/tools/perf/tests/fake_root/proc/kallsyms
> @@ -0,0 +1,10 @@
> +ffffffffab200000 T _stext
> +ffffffffab200010 T good_symbol
> +ffffffffab200020 t bad_symbol
> +ffffffffab200030 t main_symbol1
> +ffffffffab200040 t main_symbol2
> +ffffffffab200050 t main_symbol3
> +ffffffffab200060 T _etext
> +ffffffffcd000000 T start_module        [module]
> +ffffffffab200020 u bad_symbol  [module]
> +ffffffffcd000040 T end_module  [module]
> diff --git a/tools/perf/tests/fake_root/proc/modules b/tools/perf/tests/f=
ake_root/proc/modules
> new file mode 100644
> index 0000000000000000..608c6e2599f08d08
> --- /dev/null
> +++ b/tools/perf/tests/fake_root/proc/modules
> @@ -0,0 +1 @@
> +module 4096 1 - Live 0xffffffffcd000000
> diff --git a/tools/perf/tests/fake_root/proc/version b/tools/perf/tests/f=
ake_root/proc/version
> new file mode 100644
> index 0000000000000000..9de114d87d5e940e
> --- /dev/null
> +++ b/tools/perf/tests/fake_root/proc/version
> @@ -0,0 +1 @@
> +Linux version X.Y.Z (just for perf test)
> diff --git a/tools/perf/tests/kallsyms-split.c b/tools/perf/tests/kallsym=
s-split.c
> new file mode 100644
> index 0000000000000000..b71a2ea6fa696895
> --- /dev/null
> +++ b/tools/perf/tests/kallsyms-split.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/compiler.h>
> +#include <unistd.h>
> +#include "util/dso.h"
> +#include "util/map.h"
> +#include "util/symbol.h"
> +#include "util/debug.h"
> +#include "util/machine.h"
> +#include "tests.h"
> +
> +static int test__kallsyms_split(struct test_suite *test __maybe_unused,
> +                               int subtest __maybe_unused)
> +{
> +       struct machine m;
> +       struct map *map =3D NULL;
> +       int ret =3D TEST_FAIL;
> +       const char *root_dirs[] =3D { "tests/fake_root", "tools/perf/test=
s/fake_root", "fake_root" };

I'm a little concerned about what will happen with the fake_root and
installation. I think it'd be easier to just create the kallsyms file
on the fly. We do similar for PMU testing in:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/pmu.c?h=3Dperf-tools-next#n41
that'd avoid the need to search paths looking for the file. It'd also
mean that creating a kallsyms file could be done for multiple
different contexts for greater kallsyms testing.

Thanks,
Ian

> +       unsigned int root_idx;
> +
> +       /* force to use /proc/kallsyms */
> +       symbol_conf.ignore_vmlinux =3D true;
> +       symbol_conf.ignore_vmlinux_buildid =3D true;
> +
> +       pr_debug("try to find fake root directory\n");
> +       for (root_idx =3D 0; root_idx < ARRAY_SIZE(root_dirs); root_idx++=
) {
> +               char buf[128];
> +
> +               scnprintf(buf, sizeof(buf), "%s/proc/kallsyms", root_dirs=
[root_idx]);
> +               if (!access(buf, F_OK))
> +                       break;
> +       }
> +
> +       if (root_idx =3D=3D ARRAY_SIZE(root_dirs)) {
> +               pr_debug("SKIP: cannot find the fake root directory and f=
iles\n");
> +               return TEST_SKIP;
> +       }
> +
> +       machine__init(&m, root_dirs[root_idx], HOST_KERNEL_ID);
> +       if (machine__create_kernel_maps(&m) < 0) {
> +               pr_debug("FAIL: failed to create kernel maps\n");
> +               goto out;
> +       }
> +
> +       if (map__load(machine__kernel_map(&m)) < 0) {
> +               pr_debug("SKIP: failed to load kallsyms\n");
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
