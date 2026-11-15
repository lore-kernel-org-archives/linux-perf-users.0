Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794779149;
	b=SNsEBREAfzAM6mFWDYZDykMeyhG95i/Ruq5no0SxnOze/ynvda/csAMEjyIQ34AIe+nN
	 Ai/89H1sx5CBfXJGFMYbwekqkgadXNHdWAlkO9EuVXJgIXYmcrWUzMfeZvoro+j5IhuY9
	 ZlNsrG1uSFB123GSuSHq3UrprNTMy+2qMlNZy1VpNYzdZ2uW2QXwz8jGDwcNK1XZHPlkH
	 GCZxodqoNgPOvBImqNW8N/x6jAOXOxVhwox0xuggdLbCD76Nt/7fjY7OwzLPIq9n0aaBr
	 BHUCFxoYHZq0lDgc6advtXvtlfk+8k67w4e0v6UX2yHpG2Vta8mOfmZJ2bw3djAloow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794779149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Yu/mwnlh1+tlXjcPePSAJCAcRFJjqqArEI26Dps0J28=;
	b=CiQzwtkTzsAUN3+vfLcG7b9dBo1WFFVmeQPUu4s2py3b3Zflhs8F2XR74VflNBOcdoyC
	 zIzy4reLa8lWoYoUxGJ8F3qSZPUE1dI6lMwYLp9m7Kdfb14OCGK33oerTTphmyjCu8VCg
	 zGSxqICiHunLD1taifZGvl7khCRCYHK/DmndLuLZ8ntCYcsfQKZ/O8GjsQf0i9tq/IKZs
	 QJPZFJrL8W8XPNkMcQwNw56clty1E88O0jSmr68T6xxp1IeC1DpnVGt3l/cKd8NsqHihl
	 V/aRqz9bbbF8uu3rUtbzgopSZSZXC03bXH+I/HDN6YYajL8GvWHGDpI6dcRvi9O7Z4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AqsbNkYO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1614A606A323
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 21:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1614A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AqsbNkYO
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-54492d8a988so199671cf.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 13:45:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794779148; cv=none;
        d=google.com; s=arc-20260327;
        b=WI2TPDINPGJ6fDC+9kK9l56Yl6wjFWGNF/6ciTC4YLZn3+98/BPu2RCnMz3AMxJqhO
         ytaOGoGW637cnPEF4fqq4XYzMqk+CMn3kspWvvQQfwe08pVefLu9OW5qkgYFRvh2ZWaI
         hC+cvdd3mrA0rVTIfu1oWN03LoUnO8vOSRphBzcjH+luD1FCWV0EbR494k2WENlr6l8i
         ZWVeecJMDXK7xv7MIij0PISUwBEw9xt5FkbZ9pRmGlzKj3pdF4pzNVOxtw2hoOyNfYa0
         VO1JllZlUH/kCZNoiq2uL2lZWIONvzalKlUCz2Q2XM4tDcgPyrhaiOgIHovu5XR4EXNL
         ia7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yu/mwnlh1+tlXjcPePSAJCAcRFJjqqArEI26Dps0J28=;
        fh=dJ8ktk9j1nz9dDpjqai0LCp55mGekIS2f6zUoj3F9d0=;
        b=axmzXWmCeuG+d4WIuY6HZbYWUveh29SitmSmbw2L7RV1FdUC2V7I16y50o9JNvX5Dv
         5QlfEc/APNwDdhLRlVLeA12vdaqHk7n9dioD06vdXU5U7SQ41AUdneG82wVmOPko6f5i
         6BprQaFi5nWD0lcc6vvrGPKkRuYom+oRTrQFHtZIgxym3rRo6p/1PqE8dooMpqqZxRsX
         C/A+aUfbDG13z45yHG1rVo0iidL/PX+tU/aELUsrxmosqdxEHO32JU9oifE/rmKdJN0z
         m4eeAUA88JLjPkvO1R5BIFhXEJAZMYdK7qg9gFIfO3B078gpNUJqncgd2CEHISYyEG1k
         MigQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794779148; x=1795383948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yu/mwnlh1+tlXjcPePSAJCAcRFJjqqArEI26Dps0J28=;
        b=AqsbNkYOJNKCCr7jmy8b4WakApka7vt0Mi7qhptnnf5Cw+PCI0wxjPJPPBS7qZjMkG
         zEbYH94y6/iorO7bJ6ulZNNHj5ts9KLQDFKLe2HZqZOK8BKEv3JWGtp4Bad7fAKdB6rm
         6zS05yBsMUOaHNgNIuL4JC/jv+xQMNwNGWiIhZKXN5AlfnvHMl5WbTs7G47pY8uWeS0P
         qFaYAWqg3ro6IoLBkzRvVxyVcqBptNXD+jNBB5BJs/Jh3okOxPQVUi/wnOe+bx8WU6Zx
         Z+sQolMu0kUcv21FX1pyQCXaQEnKenqgp6+GjKrwF4UnSoiRM50h7w6uGSCnGbu+iywf
         KxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794779148; x=1795383948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yu/mwnlh1+tlXjcPePSAJCAcRFJjqqArEI26Dps0J28=;
        b=uX3yoi+3OZomOYM7IMl1vP824jZKkcQj3D5HpGMnCfqFAaaVr+lj7W/ZgghTq+Zvmx
         esxNpkkrpBAL09BbRGyukbkhEvwbT7suAV+CGQIHzZibcb9MmbsQ2Gt91D2tan41neCf
         1+dK1E5K2rX2acYRQIouQ0vYg4g21Bi015Q60GeQRco1bawh+zaSzASF/vCbge3DzWbT
         pmquvGlDKlvlUpmr0M2p+0DTkGdPWSBx1fSf6xZmvFYMtSQaDN6KzWJk00uHOfcfB1YM
         8BR2Mv56I+xq+Ppio4glnoMdAcD5jNsqmZunkM/4d3Auw8djow9bx48Do3yXae0sFPLq
         SKvQ==
X-Forwarded-Encrypted: i=1; AL+hErE9zVaPDe1a3fyKmgFmghksK+djkLc/VMBD1bXqpu2fELbkYp5CF9CTA52ID/cvZnH0c/xb5BRJYrTRi2DQuSL8@vger.kernel.org
X-Gm-Message-State: APuU4Z/TGXivEyhrOA0YojSQHKi2ho5yKF7vkkahRXZEVIWsMCzBXVGn
	XyiGeU3nj6fDAMMZhHZym0ZI3NjKFweOHKfpCoRHyCCC7KRgiXPdiY1HRtVcShVPvEco/8693iv
	Hzq+Vk0+vAKPJiIuXSeB9B4jxgHajtQbsbUu0XsrU
X-Gm-Gg: AYBFou05SuGrUFw8FT+t3UpbBZL3NiS2wkLeczNSZ/iiUzvwBZhP2zBaLZpbhn7upbF
	/lLcxkulrHq9MEWmUNsJYkf28W+q3PiVXdojYBMPaqkd+e6XaDRM0fDePNI94RgiqtkBFGJzZIJ
	h8ViqdZZtjnH0tvnyp4t4wXtMDieVOCN+aXf9SUNCqjZ6+CAcPVSfxSP5ZY5x/PL0HvzPC6gTmj
	Kh92mn2ePzb5+UD52plKxanGVxDKNF8jiyUZ9pzeVKFuCcR2/u86LvFeQIduk7wG/GhViy6mnnq
	P/eFnXKmz22iFdonc19uFq/qHPYqSRNUe02FmSa+0oa2/hceYaRY9On7l4eDUwBa4ttdRG2bw1y
	FfwsNbvqh055bbugw3mFwfoDsqo7G2AX2dQzT
X-Received: by 2002:a05:622a:681c:10b0:55d:3243:574a with SMTP id
 d75a77b69052e-55d324358d1mr7746991cf.3.1794779147434; Sun, 15 Nov 2026
 13:45:47 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115014102.2879372-1-acme@kernel.org> <20261115014102.2879372-5-acme@kernel.org>
In-Reply-To: <20261115014102.2879372-5-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 15 Nov 2026 13:45:35 -0800
X-Gm-Features: AclHuK87ku3Ic3VwqaHoz4gZQLMSdOPP2my3uM8kg5YJavnqSFb7CuULDms5lgc
Message-ID: <CAP-5=fU3Zix_mZcT8LURFwUZXH9EMGepdXmhn+PaA9Z_uiegxg@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] perf tests: Exercise the flexible array member path
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
> No test covered find_flex_array() and get_flex_array_member().  Add a
> flex_array workload that keeps a struct with a trailing data[] behind a
> global pointer, and a test that checks the accesses past the struct size
> are resolved and named after the flexible array member.  The test skips
> on 32-bit PIE builds, which load globals through the GOT.
>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/builtin-test.c               |  1 +
>  .../perf/tests/shell/data_type_flex_array.sh  | 70 +++++++++++++++++++
>  tools/perf/tests/tests.h                      |  1 +
>  tools/perf/tests/workloads/Build              |  2 +
>  tools/perf/tests/workloads/flex_array.c       | 54 ++++++++++++++
>  5 files changed, 128 insertions(+)
>  create mode 100755 tools/perf/tests/shell/data_type_flex_array.sh
>  create mode 100644 tools/perf/tests/workloads/flex_array.c
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 299e07bd16a5a53f..18311673b231e657 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -200,6 +200,7 @@ static struct test_workload *workloads[] =3D {
>         &workload__callchain,
>         &workload__false_sharing,
>         &workload__global_data,
> +       &workload__flex_array,
>
>  #ifdef HAVE_RUST_SUPPORT
>         &workload__code_with_type,
> diff --git a/tools/perf/tests/shell/data_type_flex_array.sh b/tools/perf/=
tests/shell/data_type_flex_array.sh
> new file mode 100755
> index 0000000000000000..8d6b277991aea96e
> --- /dev/null
> +++ b/tools/perf/tests/shell/data_type_flex_array.sh
> @@ -0,0 +1,70 @@
> +#!/bin/bash
> +# perf data type profiling tests for flexible array members
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
> +# 32-bit PIE loads globals through the GOT, which the resolver does not =
follow
> +if [ "$(getconf LONG_BIT)" =3D 32 ] &&
> +   [ "$(od -An -tx1 -j16 -N2 "$(command -v perf)" | awk '{print $1}')" =
=3D 03 ]; then
> +       echo "Skip: 32-bit PIE uses GOT-relative global accesses"
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
> +if ! perf mem record -o "$perfdata" -- perf test -w flex_array 1 > /dev/=
null 2>&1; then
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
> +if ! grep -Fq "# data-type: struct flex +0x4 (data)" "$perfout"; then
> +       echo "FAIL: flexible array member not resolved"
> +       cleanup
> +       exit 1
> +fi
> +
> +echo "flexible array member resolved"
> +cleanup
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index bbd23dd7e0455a9d..f99910b0f8d93a82 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -273,6 +273,7 @@ DECLARE_WORKLOAD(deterministic);
>  DECLARE_WORKLOAD(callchain);
>  DECLARE_WORKLOAD(false_sharing);
>  DECLARE_WORKLOAD(global_data);
> +DECLARE_WORKLOAD(flex_array);
>
>  #ifdef HAVE_RUST_SUPPORT
>  DECLARE_WORKLOAD(code_with_type);
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workload=
s/Build
> index 03017aaaaa0bec32..74a0cbe49dc93533 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -18,6 +18,7 @@ perf-test-y +=3D deterministic.o
>  perf-test-y +=3D callchain.o
>  perf-test-y +=3D false_sharing.o
>  perf-test-y +=3D global_data.o
> +perf-test-y +=3D flex_array.o
>
>  ifeq ($(CONFIG_RUST_SUPPORT),y)
>      perf-test-y +=3D code_with_type.o
> @@ -37,3 +38,4 @@ CFLAGS_named_threads.o    =3D -g -O0 -fno-inline -U_FOR=
TIFY_SOURCE
>  CFLAGS_callchain.o        =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_false_sharing.o    =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_global_data.o      =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
> +CFLAGS_flex_array.o       =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
> diff --git a/tools/perf/tests/workloads/flex_array.c b/tools/perf/tests/w=
orkloads/flex_array.c
> new file mode 100644
> index 0000000000000000..20f9b0ec17969909
> --- /dev/null
> +++ b/tools/perf/tests/workloads/flex_array.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Flexible array member workload for data type profiling: the accesses =
to
> + * the array are past the end of the struct, where the resolver has to f=
ind
> + * the flexible array member.
> + *
> + * See tests/shell/data_type_flex_array.sh.
> + */
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <linux/compiler.h>
> +#include "../tests.h"
> +
> +struct flex {
> +       int len;
> +       char data[];
> +};
> +
> +static struct flex *gp;
> +static volatile unsigned long flex_sink;
> +static volatile sig_atomic_t done;
> +
> +static void sighandler(int sig __maybe_unused)
> +{
> +       done =3D 1;
> +}
> +
> +static int flex_array(int argc, const char **argv)
> +{
> +       unsigned long sum =3D 0;
> +       int sec =3D 1;
> +
> +       if (argc > 0)
> +               sec =3D atoi(argv[0]);
> +
> +       gp =3D calloc(1, sizeof(*gp) + 4096);
> +       if (gp =3D=3D NULL)
> +               return 1;
> +       gp->len =3D 4096;
> +
> +       signal(SIGINT, sighandler);
> +       signal(SIGALRM, sighandler);
> +       alarm(sec);
> +
> +       while (!done) {
> +               sum +=3D gp->data[3];
> +               gp->data[5] =3D 1;
> +       }
> +       flex_sink =3D sum;
> +       return 0;
> +}
> +
> +DEFINE_WORKLOAD(flex_array);
> --
> 2.56.0
>
