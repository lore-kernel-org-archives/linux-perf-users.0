Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794779232;
	b=tjlNJFutpo7uR4w7bgG1zYf3EZXO391wgoujiNlcUsPlmqTS+u8P3O5uI4rAaL+kN0n4
	 leliNR6p4P6B7hYtRyuudCVQ5ugL02QywBLDvQhAaT6Ba0AEXCbDD6+uZ8ZuynsTexWo5
	 Fvan2ms15nnlqdI8PWj411fhAofZWkvJXD+5QdW0gimCqaLbozJ0ac2L81KCIJms7g6Fe
	 djn4Y4p+vuJ7JhGptMwMEXO8/F2mlLeQYFZ3hCPWLDrxGuP49LTjHBHzDu2aOcJDvQ45n
	 WIcmz6zWeFArui8Az1/ZhzGITVI96sdpyL5KnCTEjzwV6IXK7y73mBMhGKHI+xydjRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794779232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KY524zcDaF9JzpVhBPlIGXmBZ70a6nSskpmzif1Nzw0=;
	b=fI2HHoUn3mtqz/Q964LS7ItcApVrWNnz2v8pNCY/semIFGqSFUTq0++y3rYlxcMlo9qX
	 YVdSdAZZFCPMApAIixRoyOUjo6U62G7UlACUXdGTj+lix1R6oDXfENA+u3s4LJhsO082x
	 x970/pFN6Fp9mDOWlNmxzkDZiOgPP5imKijuCtHj0tGoZvYBI/vLh7KKMXO+8RSuudK+y
	 M/DfWsAASXKfSFya5hqs2Uk18vwK4iax53FJOA45CzNhKvpD0o7V4XXYmMatGakA1ENj3
	 /nV65zMlyFqDcwhC1wjYfOl1gWU3X00LGE/4szO2yeBRJU/xvU708xF7D5gPqy66dyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ITMNhRTT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4AE606A329
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 21:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC4AE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ITMNhRTT
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-55c7445cf85so208511cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 13:47:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794779231; cv=none;
        d=google.com; s=arc-20260327;
        b=kgRHnzonFVsvOPigM0AeKqTqOhdf3kieVc3AgGPE6RgZEXpZrvkYm+g2uTHMr0hnnP
         uY+O+fYc9fXc4v+QwLwaWXxLOsTyGr4YBtrq/PASVEsoyZmnMZxEIup9hxpl3b3aBahV
         E1AOmcbF/sOMMSfpF1RTCPIf/efZSAcKurqUD3/In8qyCxtOcHs/Ef2xV83Dj2B73evC
         BZlPwOXeNOptx3gRkHhrDkIegEF+Rt1qZr5mI1Fl/AjzianFj717A6AcelHIAe4MYfRU
         oBr/hfISqS2d2MyoQQ7UWYVjDoc9JQS9gm+ybN/Fpj5/6heW57hf2uEef5BXFA/1fhvO
         bBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KY524zcDaF9JzpVhBPlIGXmBZ70a6nSskpmzif1Nzw0=;
        fh=tvODfnRGnYKnPCVvanfAhiUwBU4v7PWuiIQgU1q9d5Q=;
        b=adkc9xlv7RmN8UP0LHT6+2vatyh9yYcMIdmPl4DsB2KlP/ThXH8b7UMPYDkzt9jeJH
         YjBu2Ptqc1bXvIP7rQdVk0ThRucvadlifjAq6EfTtB6FsPRyKDN/JRR11mnoF5Fys40D
         NalyfMOty/x1Ug8A9xbkPqMpPAPkVEfzqWJyKv4OARTFy8dpBkM/BUq/jZfOdfkCdC2H
         YA88Bp6wZx6bTCOo7sptm0/7FsjBTwFKTUvsXPq1LlXJCyKftLe0iu96aK+1ZMwAplsI
         LPtYzUbWPOZGxdsPLKpYADbXWowDUyypMak2Wl+YbfGYtiphMTBeZwc3eZFgXM0QSWQY
         2HeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794779231; x=1795384031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KY524zcDaF9JzpVhBPlIGXmBZ70a6nSskpmzif1Nzw0=;
        b=ITMNhRTTLZ90oDqyrVkePblvLODyiBaBeHrSEx00EZMVhstHaEmfFoW8Sej7KYziCX
         AK/TDM6xxtwVf1o6d0Ulqip2gnuT0YOr77Y5CGGBRaHMc14MG3FVdkMTo1ebuujQWROl
         Y1AMZDYDVdnB60tDgbADaO+IJI7a25hVOV/yyDIrK6+5AQ6O10lL0tPHokSl29EYs5Ek
         7K4WDWwBSdNdVHfTfmJm29XBpG2dX9pK9jI5ekUKqYHtvm1YVONF/fSpEK8T5WyxwY2B
         zbVqY7T3mC70r5GMlKPVorn0Lf4EgXKntTY6raM0Y2i16QVlF7PauJUoxYIQ1BB0EmtM
         YAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794779231; x=1795384031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KY524zcDaF9JzpVhBPlIGXmBZ70a6nSskpmzif1Nzw0=;
        b=lcyiyJOJpPrU/O4gXmn/oJ0aTvJ3AE6PCiHugQKftouPu2a745/KLg7dWsXWo37cZd
         m8xqA3+1p0aJIycC/XUAvwoCCiJvl+knJGHVdKKrOlLwX56oZ6k+xkPhVlB1DckLP0pV
         xvmpjdIHbLUkFOgGHruY9prkidLJ4VNoP683/IBd2SgUWJCbRPIDEs0y4Fvss57ADBWT
         VV+l2Qrj3e/b/bIfFfMw6qVzn7iMX+4PSNPDil1Z67f1z3Qk9fiSubyLxW/4mARd/s5b
         1qcj7L+VBYei7asD/eA8FyQlMT3CeiVtpaIB6p7AotQZhvuT7RfjzI1zSKp52o5KTiPb
         DTZg==
X-Forwarded-Encrypted: i=1; AL+hErHSiBfADcu8YQ9ipt2q1c8h6LXO6tb1gbl9Ow+PR9AgygEx3fG3ufYfHfRuTOUb/a6PBd7NBd8iXSqh+RaZoPQq@vger.kernel.org
X-Gm-Message-State: APuU4Z8FaNh06bN8dLlvGq8GlJT9Pr7/YR8EmGeergn3mgIK0czQKEDa
	i+Or4QPkpcL4nYZYb/zTOwaTZAXwDS7C6tMQciM0h9OPzwMPkNfWWKQtobFmy02afQwDSVmrpzC
	bRp3AUgFqSQYNe4uKWyaVUiR4BfSO10V1UI17Uaqp
X-Gm-Gg: AYBFou3KtnGBgas8nPVl/XKhnCzm+efsTu6nIzTVDrYk9t89S1dBvlkgni8e+z8RAca
	yxLy+HesLWmUR6dNONZilUxf+4ZzS+fbNfmre83KfN8WAg4rDgX6q6KKfJX8cYyoFihotnlB1ix
	eiNeKk8hDMO504MNyG8t8pS9wjuJfmF744pF/WVF1WkKTel3Y+Ubs5H+waMsoUsXW231b8aeSGn
	XnXiRssoASzKaut/48b+6BQ6qIrzlloJRQFZwmoUFNBoUClqCn9A44sXJh2fy3lMfPmT+2hpA5V
	1RbHMBCKpGpiAi7Um6zRrsgP6Xbvb+ICvOqgk/IUaYwHdXkmGD1l/SdoogmYF1N3mYss7o4riE7
	assS+CsYJnzGC/riPmENSecl2wBCuvfAVKd0i
X-Received: by 2002:a05:622a:5917:b0:54b:648d:9ab5 with SMTP id
 d75a77b69052e-55c67bc6fa6mr24530791cf.11.1794779230155; Sun, 15 Nov 2026
 13:47:10 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115014102.2879372-1-acme@kernel.org> <20261115014102.2879372-7-acme@kernel.org>
In-Reply-To: <20261115014102.2879372-7-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 15 Nov 2026 13:46:59 -0800
X-Gm-Features: AclHuK9p5dgPwGyyxBwCuXNSFy44RKEFivTqM1rf_pMJqsUSRrhbOaxGt66nG_g
Message-ID: <CAP-5=fVAgPPC7UMo85udqK2zsT-8PQ6QRSOCikRwVv8eX7wXmA@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] perf tests: Exercise data type resolution from a register
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 5:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> At -O2 a struct pointer lives in a register and DWARF describes it with
> a register location, while the unoptimized workloads the data type tests
> profile keep their variables on the stack.
>
> Add a regptr workload with a noinline function that gets the pointer from
> a volatile global, which keeps it in a register, and check that its three
> member accesses are resolved from that location.
>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/builtin-test.c              |  1 +
>  tools/perf/tests/shell/data_type_register.sh | 64 ++++++++++++++++++++
>  tools/perf/tests/tests.h                     |  1 +
>  tools/perf/tests/workloads/Build             |  2 +
>  tools/perf/tests/workloads/regptr.c          | 60 ++++++++++++++++++
>  5 files changed, 128 insertions(+)
>  create mode 100755 tools/perf/tests/shell/data_type_register.sh
>  create mode 100644 tools/perf/tests/workloads/regptr.c
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 18311673b231e657..b6d31f5f009d206b 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -201,6 +201,7 @@ static struct test_workload *workloads[] =3D {
>         &workload__false_sharing,
>         &workload__global_data,
>         &workload__flex_array,
> +       &workload__regptr,
>
>  #ifdef HAVE_RUST_SUPPORT
>         &workload__code_with_type,
> diff --git a/tools/perf/tests/shell/data_type_register.sh b/tools/perf/te=
sts/shell/data_type_register.sh
> new file mode 100755
> index 0000000000000000..0b7cb4bfe0aacfbe
> --- /dev/null
> +++ b/tools/perf/tests/shell/data_type_register.sh
> @@ -0,0 +1,64 @@
> +#!/bin/bash
> +# perf data type profiling tests for register variables
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +perfout=3D$(mktemp /tmp/__perf_test.perf.out.XXXXX)
> +
> +cleanup()
> +{
> +       rm -f "$perfdata" "$perfout"
> +       trap - EXIT TERM INT
> +}
> +
> +trap_cleanup()
> +{
> +       echo "Unexpected signal in ${FUNCNAME[1]}"
> +       cleanup
> +       exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +if ! perf check feature -q dwarf; then
> +       echo "Skip: no DWARF (libdw) support"
> +       cleanup
> +       exit 2
> +fi
> +
> +# No point in recording if the PMU cannot do memory events.
> +if perf mem record -o /dev/null -- true 2>&1 | \
> +               grep -q "failed: no PMU supports the memory events"; then
> +       cleanup
> +       exit 2
> +fi
> +if ! perf mem record -o /dev/null -- true 2>/dev/null; then
> +       echo "Skip: cannot record memory events on this PMU"
> +       cleanup
> +       exit 2
> +fi
> +
> +if ! perf mem record -o "$perfdata" -- perf test -w regptr 1 > /dev/null=
 2>&1; then
> +       echo "FAIL: perf mem record"
> +       cleanup
> +       exit 1
> +fi
> +
> +if ! perf annotate --code-with-type -i "$perfdata" --stdio \
> +               --percent-limit 1 > "$perfout" 2>/dev/null; then
> +       echo "FAIL: perf annotate"
> +       cleanup
> +       exit 1
> +fi
> +
> +for member in "+0 (a)" "+0x8 (b)" "+0x10 (c)"; do
> +       if ! grep -Fq "# data-type: struct node ${member}" "$perfout"; th=
en
> +               echo "FAIL: member ${member} not resolved from the regist=
er"
> +               cleanup
> +               exit 1
> +       fi
> +done
> +
> +echo "register held access resolved"
> +cleanup
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index f99910b0f8d93a82..6d284bc79cc31779 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -274,6 +274,7 @@ DECLARE_WORKLOAD(callchain);
>  DECLARE_WORKLOAD(false_sharing);
>  DECLARE_WORKLOAD(global_data);
>  DECLARE_WORKLOAD(flex_array);
> +DECLARE_WORKLOAD(regptr);
>
>  #ifdef HAVE_RUST_SUPPORT
>  DECLARE_WORKLOAD(code_with_type);
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workload=
s/Build
> index 74a0cbe49dc93533..17189458032c0a17 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -19,6 +19,7 @@ perf-test-y +=3D callchain.o
>  perf-test-y +=3D false_sharing.o
>  perf-test-y +=3D global_data.o
>  perf-test-y +=3D flex_array.o
> +perf-test-y +=3D regptr.o
>
>  ifeq ($(CONFIG_RUST_SUPPORT),y)
>      perf-test-y +=3D code_with_type.o
> @@ -39,3 +40,4 @@ CFLAGS_callchain.o        =3D -g -O0 -fno-inline -U_FOR=
TIFY_SOURCE
>  CFLAGS_false_sharing.o    =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_global_data.o      =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_flex_array.o       =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
> +CFLAGS_regptr.o           =3D -g -O2
> diff --git a/tools/perf/tests/workloads/regptr.c b/tools/perf/tests/workl=
oads/regptr.c
> new file mode 100644
> index 0000000000000000..d5d357b047e1cfd1
> --- /dev/null
> +++ b/tools/perf/tests/workloads/regptr.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A struct pointer that -O2 keeps in a register, so the member accesses
> + * have to be resolved from the register's type state and not from a
> + * stack slot.
> + *
> + * See tests/shell/data_type_register.sh.
> + */
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <linux/compiler.h>
> +#include "../tests.h"
> +
> +struct node {
> +       long long a;
> +       long long b;
> +       long long c;
> +};
> +
> +static struct node n;
> +static struct node *volatile vp;
> +static volatile unsigned long long reg_sink;
> +static volatile sig_atomic_t done;
> +
> +static void sighandler(int sig __maybe_unused)
> +{
> +       done =3D 1;
> +}
> +
> +static noinline long long touch(struct node *p)
> +{
> +       long long sum =3D 0;
> +
> +       sum +=3D p->a;
> +       p->b =3D sum;
> +       sum +=3D p->c;
> +       return sum;
> +}
> +
> +static int regptr(int argc, const char **argv)
> +{
> +       unsigned long long sum =3D 0;
> +       int sec =3D 1;
> +
> +       if (argc > 0)
> +               sec =3D atoi(argv[0]);
> +
> +       vp =3D &n;
> +       signal(SIGINT, sighandler);
> +       signal(SIGALRM, sighandler);
> +       alarm(sec);
> +
> +       while (!done)
> +               sum +=3D touch(vp);
> +       reg_sink =3D sum;
> +       return 0;
> +}
> +
> +DEFINE_WORKLOAD(regptr);
> --
> 2.56.0
>
