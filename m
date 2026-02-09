Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA82C11D0
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658203; cv=pass; b=A+ly6xOdV9YdcgkZiePYKhHnESGxEmYGFEYGoKxwbNJLj5PtTRlRSqXyKjGNfhFRPPBZorYc8vXi9HaOIsj0edULAzfzwoT9Ocm+DRtPY0YlpEGWyBvNGpw3EIK4g6IK0vEVmG9HLc+6978d8TwNbl1WlJwLuwbOrxAt9OchtOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658203; c=relaxed/simple;
	bh=792rFntM2yrRUBjnV4eFu7TMw7FKq7tde+ujkHSE6sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4syZraKg/rYSwej0tqll5+zClMZwE9kDbVlhVx/PcBkIjJPj+5e+Lvd1Rotry+HLJfF+O8SCC0NQt53OzUgCeZxSXGte79+SF0xkcGN/MNQ/jr5ARopnUFzJh7VX2agUct3dneDhJaYqzeeMTXlpLU4+ANx3bP8xZWM9gsmPbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/FRxTMb; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/FRxTMb"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a885af8ee7so152265ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:30:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770658202; cv=none;
        d=google.com; s=arc-20240605;
        b=FMK0Wr9ph7wKWfHcoqaBhBAdOuWnU7qmrtbZDalri8iPQMTZO4zPpCY2VjX3eFI1A0
         ATJrQp0saYwlSh/UYFGEF02f+9g8RMzv/F/wpz8ZxAgvXsLTTa+lr8Dbgp8PWxEjbjbD
         DECOMb8gDO1wFvePnstSjAuq6+W7J3imb4pTtKqwmc2Fa9jM7B27gUIvG1KKUGLetQtu
         SGOdx7hUvUley1B//IiV/mZyBbeTpB4tO4GyLfihBwIcJxNJfn28Y3ooUBj2HwNnaUF2
         FBSGkiltWLiqqzmpU0XVpb2qiBDvvfhd6HtvM+RV41R4Up1vneoeK5HofyFWv2J/AJqM
         srsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x7a4CVON54VSWkRhDBy0bzGzXV0lGHq+neMqBeDAIF0=;
        fh=ypyVJdIx8hHyvr3Z9ijn2Td1aaigxlzW/tYlGZVp/vo=;
        b=Cl6ozAwt1DU3ZvZM+QxoDtzAcrXNJHaamtX0h/LDcT3PBEye0gzA8TgPVjVwHfenpk
         ALIx9GS5hAA1Dkcu3pHhJL/KVOk/c990FUKphUqSsPSd1EsScB9A6cdzCmi0WUGls3M8
         d+lAz0huNKLQkq30UzC/plmmMADEKBAUCtWMRVim3yuvqxwBoijhCrV+4dzKOog1yiuv
         Isb8ZG7I/n9bRxQyuesxNWZmCrgYJR4a1+rn2BjRmMAeiHKL7R3Mi6Dg7IUpg8OUX9wO
         Ds2zmzKVGcyV1bAOUhLpDMUfDqMuwMlhNgRjCTqtSuJ8+4epGFxidmbiL9UufvdENayt
         aAVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658202; x=1771263002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7a4CVON54VSWkRhDBy0bzGzXV0lGHq+neMqBeDAIF0=;
        b=r/FRxTMbmI8zIDrXGWCvCxWEhfOuZgfVDoIvm+WwIReO191PJDrn5UjNmXypxGgjhS
         oZxeJiyWx4oWjuoq4UzPjxFWVzL1shEGuFl6H9zY5P6h7RrouwaI7q97pDwEaHd1KHqT
         Yh0uVqz9lmaKusHq4dmQV/v/EW7Xc83Ho7bY0oTWpldqZDgzXtgB5kSRJBsZs+/KbI8R
         G2b84e3LJLJfBInnk2/sDQ3o318VV5UcVEpGIG/j66bGfbUmvdM6cVFt9JrJx7kYRWOu
         F9mzwr43uoVdGW0aeWr1oVzA0Ysq4IiALYLOkJM47vLAwH3iYS+qUrhGHSnb6uSrdQ6k
         LWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658202; x=1771263002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x7a4CVON54VSWkRhDBy0bzGzXV0lGHq+neMqBeDAIF0=;
        b=wx7w3RXYuPVBevWIV7xEtnPgoujANKTTqFlmZmFhga6DZH3lquFgEgTZO8k1ngHMoh
         pstgau2rqv35cOwLPoUxlHQsCBW8cZ5+X33BS+Vhy1/Yn8MHRuCwT3ODC9mT1PgGfNxc
         KHU4nKYAzje0sRvpTVLguWDnIXwE3lx8rROhp3M9VcREI6ZPKeb7q50Q82Gl4ZIjcQ5G
         HZrxPGq2yf8nP8F+8XjSKo47obSkfI5asIDZMBU9U4TZufRjehDlfuymN25+emDpng0W
         1lxtLeCc+UvjXthDoUtJp5mMe61T8UmGkq2Eer3RYf5/UFq7tAHiJdNWMqSDR9XpJI4E
         yERQ==
X-Gm-Message-State: AOJu0Yy3EL1ZG6Nwii11tOQZY1qqontRrjKbn4+CibDZ0iqi4OEOhI7P
	yrUa2pxhjsUu7OsZaCm3o4PCdVeo5UCv1iJ1OWmL1vHuQPawt/LQ2EXM1qCj4utihD2Hb7h4Af1
	8McbKnyyKCsUvkvshU7q3YlSgYNxOYxEzx0f6JqXF
X-Gm-Gg: AZuq6aKOzpuKmqJOsE6RiEWpVGu/NJ+Ialm3neUiMHV99V24JCIyP7wNMPY6keihq8h
	gzWP44U9ijntuPxCain4/T6aJjkdQqGzDsQGNhEr+xOzgGO4PkSD/BM0uL4mt7whd3Wn2/9grPU
	7NAL6McG6CKpad1U70zzGX+DQ5KR1DU/s4pYquGzQ0jM2imphiQnV/zYDWGZFfrcF5bZ47CnH+n
	2s8OJbFqVQg8qCLDtmoTjwu+UBLyRD29Pj0uUKkctCQsMPdNvHq4um4AEaE2qdF1kLuwBbCEc5d
	z376yLBfZ9FUik32jDbvSnjz
X-Received: by 2002:a17:902:d492:b0:2a7:6fd3:c11e with SMTP id
 d9443c01a7336-2a961edb153mr4861625ad.18.1770658201672; Mon, 09 Feb 2026
 09:30:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208122227.3524-1-9erthalion6@gmail.com> <20260208122227.3524-3-9erthalion6@gmail.com>
In-Reply-To: <20260208122227.3524-3-9erthalion6@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Feb 2026 09:29:49 -0800
X-Gm-Features: AZwV_QjiAE7m7krlXFWyzXtE1_6lUyv1rgHPHqoRTqh4v3I0VrboRwMKkPNnHos
Message-ID: <CAP-5=fXYKSfefdZ6SdjcDmw8bjobGenR9U7ePPx10a0rGpx2KQ@mail.gmail.com>
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

Does this need to be cross compilation aware? I worry that we can
detect local Rust support but not have cross compilation support and
then perf tool cross compilation builds are broken.

Thanks,
Ian

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
