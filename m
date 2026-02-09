Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA1C261B80
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658433; cv=pass; b=LjQN6b/pWY7l1YjJCJngwCZpL2OW4Kwrzawi4woBaogYPZv8JylGddS8X5a0bGeczQrE8QBIaiYCgN4VZVdyMIn6+Hqn4VJfQ4ia6kZTiPDKry8rNRa8PPvmzOsYDCRXxxueoimPq35ylWwHhFPkf9iLut8zquwOE4PS/l9hGuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658433; c=relaxed/simple;
	bh=DU/Jbil+tlOIDxYNeOFiIotIAxgZu7WTnpd+ohH7amw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTwQYwVV0CP47V/RX59n6ZL0W9rnPeKxASBr/uhl8f5jnAh710TetrOgvawcgYb7kWg/XZfkLz+O4IkIZ7O0/nymrEPlymoiL0rWWxx3VE8PVCIzXpFm1dcdS4veOMbNvir6EC4LPXwnErXkwhs9eQXwRBG9t35uWUmoM8MkXhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXhIvUts; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXhIvUts"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a964077671so455ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:33:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770658433; cv=none;
        d=google.com; s=arc-20240605;
        b=I4gEbTknOo3Ze+zGXIxE1OuIqAzmj7HtuEVlONlZyFVPwOw892fQ8PEF+1n7omCK8x
         gn8rQAcJzabx3Gk0S+GqwdpEshbGyQce+1To2MAkTJJA8LtXC6b+IJfdpTYtZStPNSvB
         MdukpVnlq308FFETv0ocGl6xulE/a5oRPHkWU7cQ8ekQBNy7n/o4d+5RkQSRz0tiLb2f
         nLba5Kt8t1mTOS7IGYDWH+od2IdQJ6XW20DgIdeJd2zYSnMdGaWNUwKGymfSZHyDuJOW
         tlGZjE+3wF37404dNDYSVScm8Pvb7Pqsk0nB33uRyVpZemwEE0lALe7G3pxUZMPkoCs6
         ndJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jA7LY5Yq9yHeII7mgZdzp5PTUygUlmDygkUNlKAI0tY=;
        fh=ypyVJdIx8hHyvr3Z9ijn2Td1aaigxlzW/tYlGZVp/vo=;
        b=CnoEEs/BE5H9s6pfcQegk4/BUfEFRvpEEOZauk7uXxFME4bhq5mRMDDMMS1j9eCLP3
         FvoHM1YkB66bcHA/Ua3gH5Q1EiGhhzi+k8zpOCH2Rk+4LwmG1g4jPVcVlb6m7TVXIiTG
         mc/y6aO5LSabsP8T8ml7iujDNOi+eLdsVOcIJxLklqnA3SMflrWD6osG4TzKuGoNNKrW
         Wew2RdMszxiw76WO+W5DLTavNfcaGTYrNh3qF1/03r8zJG/XEPhQLnVUAnCRh70Lf4N0
         2Fy8cX9rKMolQkl/QSdnm31ETjRSUgqo2KcQXswrLoNRc4cDJPB9HC00PpGzfgZocR9w
         aBHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658433; x=1771263233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jA7LY5Yq9yHeII7mgZdzp5PTUygUlmDygkUNlKAI0tY=;
        b=WXhIvUtsdFxW+tHRYaB8FXs2oNfJeVmWHbyGTTtSeTEm8Lnirt1w3daZgDFJ87Kc/H
         YzqNY13BjaW56YgTHf6YMSmsrzrGCynWmMnNLyaNmyrS7hajLjbhZkoaID4nC+ZhV3BQ
         lxBeO6Yymu8rHY40+bq6a1kT43XyF2XoVVRJ/jNBwlL82pwyXxil8k0sLyYxmyfLe494
         udz1eWDa2Emit3SP0QUXBfDxg3EwH1wZr9eu1wEOe5+8DdYZHKgQ30vaTvdyeshDahab
         GqAuVAZnf2z4WzWoAi3aeZ963fy0lZ6oBPCuLY995yEtPQ+xNf6zceGhHW7TQ/u3E0oU
         nAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658433; x=1771263233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jA7LY5Yq9yHeII7mgZdzp5PTUygUlmDygkUNlKAI0tY=;
        b=lpfkOTN4M2txuG2PRR6BtoGPC4idvzcKn9WJ5EHHkuJJjFPTIL5FBCV84aSH2KuZQB
         hxxI1uJWT3B3fXtIH87fM54omrDNy6BJsBZ6+Xk3pIIuxBUJehxjKqy+AF2uK55ksKex
         tmC5i41Fpp2IKeys9cbGbbmGfPB4D3lxSopbF1GbbaIDVzV4GVD69kve8KPWqCwZo2+x
         HGIWwVAYH8jWyaq/JxDAvQqYb6xazsAMHF2CV4qe7PND6J3JVhCb2Nv8NVyJikfIkoQz
         RaZIazzaWPkn6tU5R9onVrKvcGfpc6ei8b+/td/5G0B2MtGHo1LmijnO/ck3sCcsABBn
         0P1Q==
X-Gm-Message-State: AOJu0YzqHFK02VeWcoJc6CcIRPTSH8bbJtrpQcUKL6iQNGRrYWvwpGDq
	cZRUaWGoyEdIuYZqFvg0sphx/c0Uhn9aM1Zj2hGLuQHtchk6Lk56oCjt9ER8m4ftD95/JMzilHA
	Vrz0uAsglhdIC8htoU0Bi3h97g+Hhj3rxLnvBRfS+
X-Gm-Gg: AZuq6aK4Rq1kqCkoDl94jURyLQ1nhBLElADJt7vyLq5ayTHPR8lOadndzvtV8+rmYSm
	zuvJNyaMAGcB4fWsl3KXPMzoRcc2j3H1G9ISMjU+Q1hCs/MNwFqtwUxRDodZK3iN9s32c0CI02P
	fDJ/Djml2vfN1HJ2ryo2VJBkcZwIs9iEvGrkwOD7s4UN5LjMyb6kj1Qfb5vLgAjXTygxvIS5C4q
	V7PMquqci8qLTuAk3m3xGwzijrID90yxn+XbWkJj4vtYxNZ0WCoE6nnSEO0B/D8FdQlMPRvX5w6
	kgt+IRt1clgZPs8OTh/7k4X6
X-Received: by 2002:a17:902:cec4:b0:2a3:cd98:f07 with SMTP id
 d9443c01a7336-2a963102e38mr5904475ad.3.1770658432328; Mon, 09 Feb 2026
 09:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208122227.3524-1-9erthalion6@gmail.com> <20260208122227.3524-3-9erthalion6@gmail.com>
In-Reply-To: <20260208122227.3524-3-9erthalion6@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Feb 2026 09:33:41 -0800
X-Gm-Features: AZwV_QiweSYKOKSnWezmCE2H7Aq6aIMfKFRZdAZGWNHzOJPdATEIdOBda_tBmxs
Message-ID: <CAP-5=fV8GOLeHc8ZN_ddUPdWTCP2hykeApLZ80N9AwNzR+=LMw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] perf test workload: Add code_with_type test workload
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 4:22=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.co=
m> wrote:
>
> The purpose of the workload is to gather samples of rust runtime. To
> achiever that it has a dummy rust library linked with it. Per
> recommendations for such scenarios [1], the rust library is statically
> linked.
>
> An example:
>
> $ perf record perf test -w code_with_type
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.160 MB perf.data (4074 samples) ]
>
> $ perf report --stdio --dso perf -s srcfile,srcline
>     45.16%  ub_checks.rs       ub_checks.rs:72
>      6.72%  code_with_type.rs  code_with_type.rs:15
>      6.64%  range.rs           range.rs:767
>      4.26%  code_with_type.rs  code_with_type.rs:21
>      4.23%  range.rs           range.rs:0
>      3.99%  code_with_type.rs  code_with_type.rs:16
>     [...]
>
> [1]: https://doc.rust-lang.org/reference/linkage.html#mixed-rust-and-fore=
ign-codebases
>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
>  tools/build/Makefile.build                   | 14 ++++++
>  tools/perf/Makefile.perf                     |  2 +-
>  tools/perf/tests/builtin-test.c              |  4 ++
>  tools/perf/tests/tests.h                     |  4 ++
>  tools/perf/tests/workloads/Build             |  5 +++
>  tools/perf/tests/workloads/code_with_type.c  | 46 ++++++++++++++++++++
>  tools/perf/tests/workloads/code_with_type.rs | 23 ++++++++++
>  tools/scripts/Makefile.include               |  2 +
>  8 files changed, 99 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/tests/workloads/code_with_type.c
>  create mode 100644 tools/perf/tests/workloads/code_with_type.rs
>
> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> index 3584ff30860..60e65870eae 100644
> --- a/tools/build/Makefile.build
> +++ b/tools/build/Makefile.build
> @@ -76,6 +76,14 @@ quiet_cmd_host_ld_multi =3D HOSTLD  $@
>        cmd_host_ld_multi =3D $(if $(strip $(obj-y)),\
>                            $(HOSTLD) -r -o $@  $(filter $(obj-y),$^),rm -=
f $@; $(HOSTAR) rcs $@)
>
> +rust_common_cmd =3D \
> +       $(RUSTC) $(rust_flags) \
> +       --crate-type staticlib -L $(objtree)/rust/ \
> +       --emit=3Ddep-info=3D$(depfile),link
> +
> +quiet_cmd_rustc_a_rs =3D $(RUSTC) $(quiet_modtag) $@
> +      cmd_rustc_a_rs =3D $(rust_common_cmd) -o $@ -g $< $(cmd_objtool)
> +
>  ifneq ($(filter $(obj),$(hostprogs)),)
>    host =3D host_
>  endif
> @@ -105,6 +113,12 @@ $(OUTPUT)%.s: %.c FORCE
>         $(call rule_mkdir)
>         $(call if_changed_dep,cc_s_c)
>
> +# it's recommended to build a static rust library, when a foreight (to r=
ust)
> +# linker is used.
> +$(OUTPUT)%.a: %.rs FORCE
> +       $(call rule_mkdir)
> +       $(call if_changed_dep,rustc_a_rs)
> +
>  # bison and flex files are generated in the OUTPUT directory
>  # so it needs a separate rule to depend on them properly
>  $(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 2a7e5814b15..a6d8ca3e923 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -271,7 +271,7 @@ ifeq ($(PYLINT),1)
>    PYLINT :=3D $(shell which pylint 2> /dev/null)
>  endif
>
> -export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
> +export srctree OUTPUT RM CC CXX RUSTC LD AR CFLAGS CXXFLAGS V BISON FLEX=
 AWK
>  export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT
>
>  include $(srctree)/tools/build/Makefile.include
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index e2490652f03..06507066213 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -154,6 +154,10 @@ static struct test_workload *workloads[] =3D {
>         &workload__landlock,
>         &workload__traploop,
>         &workload__inlineloop,
> +
> +#ifdef HAVE_RUST_SUPPORT
> +       &workload__code_with_type,
> +#endif
>  };
>
>  #define workloads__for_each(workload) \
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 1f0f8b267fb..f5f1238d1f7 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -242,6 +242,10 @@ DECLARE_WORKLOAD(landlock);
>  DECLARE_WORKLOAD(traploop);
>  DECLARE_WORKLOAD(inlineloop);
>
> +#ifdef HAVE_RUST_SUPPORT
> +DECLARE_WORKLOAD(code_with_type);
> +#endif
> +
>  extern const char *dso_to_test;
>  extern const char *test_objdump_path;
>
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workload=
s/Build
> index 866a00bd14a..2ef97f7affc 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -10,6 +10,11 @@ perf-test-y +=3D landlock.o
>  perf-test-y +=3D traploop.o
>  perf-test-y +=3D inlineloop.o
>
> +ifeq ($(CONFIG_RUST_SUPPORT),y)
> +    perf-test-y +=3D code_with_type.o
> +    perf-test-y +=3D code_with_type.a

nit: It'd be more normal to write this as:
perf-test-$(CONFIG_RUST_SUPPORT) +=3D code_with_type.o
perf-test-$(CONFIG_RUST_SUPPORT) +=3D code_with_type.a

I did an update this morning but found I needed to install rustc to
get the build working. I'm not sure things work without rustc
installed as advertised.

Thanks,
Ian

> +endif
> +
>  CFLAGS_sqrtloop.o         =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_leafloop.o         =3D -g -O0 -fno-inline -fno-omit-frame-pointer=
 -U_FORTIFY_SOURCE
>  CFLAGS_brstack.o          =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
> diff --git a/tools/perf/tests/workloads/code_with_type.c b/tools/perf/tes=
ts/workloads/code_with_type.c
> new file mode 100644
> index 00000000000..65d7be7dac2
> --- /dev/null
> +++ b/tools/perf/tests/workloads/code_with_type.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <pthread.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <linux/compiler.h>
> +#include "../tests.h"
> +
> +extern void test_rs(uint count);
> +
> +static volatile sig_atomic_t done;
> +
> +static void sighandler(int sig __maybe_unused)
> +{
> +       done =3D 1;
> +}
> +
> +static int code_with_type(int argc, const char **argv)
> +{
> +       int sec =3D 1, num_loops =3D 100;
> +
> +       pthread_setname_np(pthread_self(), "perf-code-with-type");
> +       if (argc > 0)
> +               sec =3D atoi(argv[0]);
> +
> +       if (argc > 1)
> +               num_loops =3D atoi(argv[1]);
> +
> +       signal(SIGINT, sighandler);
> +       signal(SIGALRM, sighandler);
> +       alarm(sec);
> +
> +       /*
> +        * Rust doesn't have signal management in the standard library. T=
o
> +        * not deal with any external crates, offload signal handling to =
the
> +        * outside code.
> +        */
> +       while (!done) {
> +               test_rs(num_loops);
> +               continue;
> +       }
> +
> +       return 0;
> +}
> +
> +DEFINE_WORKLOAD(code_with_type);
> diff --git a/tools/perf/tests/workloads/code_with_type.rs b/tools/perf/te=
sts/workloads/code_with_type.rs
> new file mode 100644
> index 00000000000..3b91e51919d
> --- /dev/null
> +++ b/tools/perf/tests/workloads/code_with_type.rs
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// We're going to look for this structure in the data type profiling rep=
ort
> +#[allow(dead_code)]
> +struct Buf {
> +    data1: u64,
> +    data2: String,
> +    data3: u64,
> +}
> +
> +#[no_mangle]
> +pub extern "C" fn test_rs(count: u32) {
> +    let mut b =3D  Buf { data1: 0, data2: String::from("data"), data3: 0=
};
> +
> +    for _ in 1..count {
> +        b.data1 +=3D 1;
> +        if b.data1 =3D=3D 123 {
> +            b.data1 +=3D 1;
> +        }
> +
> +        b.data3 +=3D b.data1;
> +    }
> +}
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
> index ded48263dd5..b5ecf137feb 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -94,6 +94,8 @@ LLVM_STRIP    ?=3D llvm-strip
>  # Some tools require bpftool
>  SYSTEM_BPFTOOL ?=3D bpftool
>
> +RUSTC          ?=3D rustc
> +
>  ifeq ($(CC_NO_CLANG), 1)
>  EXTRA_WARNINGS +=3D -Wstrict-aliasing=3D3
>
> --
> 2.52.0
>
