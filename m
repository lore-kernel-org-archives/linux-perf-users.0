Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66D92FFF90
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074220; cv=pass; b=FSElv0sY1FVh3Y0eRzDekioFB7I3+6C7wwhvnYJ66l7wfTjeUA246DyUkF5kg8a7W6b4T90ftqhsFVN3omIAyAz4M1FUSxW+6SyZgbm0N3l2GoopAcoTYe7oFTmQCSHvI7ANc+YHzB+33Ewx2FMmeC89pVV1rZ+CJr+n7xfuCTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074220; c=relaxed/simple;
	bh=6D+h9DR13SbeND/68GjrbKybwyfvauIqcBzy58AFyTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEhsyPpVtvS+5k44lOoATMP3Chydl1TKYTkHIZQ6QFU9bm8lxW0XgkvCIljwLitCthbjTtQVi2U1xSErHt4kCUig+biTUbX+f5MybCs6mcKc6qs4bQaL7GIK8o5fDycwE6XEeHXrpGFsbk2/XUOq8OKqr/dWpMhnjIgkySb0Gi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DazcAkli; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DazcAkli"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2591757fbso30485ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 13:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775074216; cv=none;
        d=google.com; s=arc-20240605;
        b=FN5u9SXkZ0R6KwqdnDcDzFNwDFbMxgj5YHH5sBg/EAqkx2I2nHMshNIEVtDqtIYofh
         aVEcPx+UTj1LoQWy0LaIvs9SptS0GYBATxhZBKybSJizZlJlsERD+MNUVzposNsZVptj
         PQxHD4bI6e2k85tHX5dSbByprtFNiHaDFiHLgXEgDJh0KK6FVZs9JQATsLZmT8+P5IaU
         3V9PA10fITOPDFmNAU3lzFy7vbDl52H9wHNOAvUzAsABx4v7Y4ZkJlnww7dFEKXKsiws
         cPyyxmXKicyKGdxYy6uVXZHkO64rh+lToJlRXWTPDIS9f4ZDkW8dJw0U9Iky2UJxyJ2H
         AHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CEyUJlobxtyV0EOKMqbR2SYcKfyA6amJHlB9SjJAfbY=;
        fh=QS4ZtYlFdEo9Voy5z1ngGtGRUy6tC/XLZoTfn0cQp9w=;
        b=BaWV3cHpORP8ZbHJJ4iCjItvjpl9TlAJvDnsYKpgCid9zlg5wpU9LQCGkmQ3AZwm8o
         WncWUtyjVAScU6He9J/QxqD4T+MkbQwOCUR05CDbwMoWzj1zK/K4u3gAK08ikCcUM4V1
         vK8HKJnoEsy5Qg4sUQoeks1v/R9UEuzgBfzsMrKklf548CVva6vx1DkmTYP7Fennxlsr
         hGNVOt0dpZZt1SPk46GqcCfU6fRyDpqk9ncf3Ruh42fBifnU1FyBb/OfX/avTQoTO8wW
         dOJCLPCaxVYpXZFpsJ/PFgN9OgIqaZmv/HNg5GVFOfLp9YcXO6rk1USpKHCHA33xE41T
         QnSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775074216; x=1775679016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEyUJlobxtyV0EOKMqbR2SYcKfyA6amJHlB9SjJAfbY=;
        b=DazcAkliFnMZkIW22T7idzcEjhQElrRB/A1BSB/AZeJC+aq6PoaYpGUa1c05EtHZJM
         6Lk15PCgsjkfHRFyylLwMxvan9IQhE5mWxG70p8oog3b8z2Ak4F+oQ6B4j8tHrh0dleI
         kU21N4oDf+xHJDWIGeFuf95t93hb+1nrOxhk242CT3JVgqnHT76bpxA68hrOBw5W+f9y
         dNoYEVy9md8SWXePyhUdqkbbnkdvTOZYMksALbkDPmT9xCKB9vPHeHGpFN488LuKXMUw
         Cbe9qQ/MmFMmq2g15Ipm7vOVXkbOnT8CbvLxOddbVz6+YsX9m4vLGyywnWUte3qOPlIu
         bJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074216; x=1775679016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CEyUJlobxtyV0EOKMqbR2SYcKfyA6amJHlB9SjJAfbY=;
        b=PUll33RfeBTNyIM0Ep4T15iMLkpALAYkzumpIwKSdo1OMN97KZlnyclIUuhCEYVW2U
         /l7oWJb8bAF20tAM+k6KvST3jGK34yJeUw1DOqFoPeuwwrQEI0aPIdj4oFXfQ7d2rVto
         LRLQyT6cHX0ZgACeHQe00VjWynNZb8SupVZx7wy7Ly+mfrXtr2QMBS6DzY6g/BxUretT
         tWbkAR9NQkl50EfEGmK3+si8IJin1a/TBEEqjLochZXX5FjgeAh+EU8gCQUJ+/DQGwkE
         N+tXdtupF8eCGrJ2xLws9A+Otmne8OQiDuzHydtGzipPexVoJfqHz3LVZjwxZSeuefP+
         LN0A==
X-Forwarded-Encrypted: i=1; AJvYcCURvmGQZrvCk72cC15nqX3Ac/goWl72BNTg9Zw4J+Gys3rleIJh2YXLuAWL+vkulGR8uYZcrzQvFLrSaN8A9OOe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6RIpVYQ11iCcCLRGEX8C6hf+ahZqr6mZTKsRhLB8x7UUfjIbN
	aJQMzWWjN3EZZ1heU5cRYuuN12yT6hIL3Q0jTMWl1j60ZDGDVciTmANVAllup+SvSAgSNTNGMcl
	4jIg+sb2omgKM2ZcMnV7GJuLcrEEWGDkU9HdxJIhj
X-Gm-Gg: ATEYQzyzj8Vg224ul/1sHc7aewF3i3mFzo3osfKskrb5LSpyQwKmeBS8hbUbpfHIJkN
	Z1ajAvuNrNJkruq4oO+TJYhs1Nk49A+XMsK45oF3d2aR7J2omMw4Cppf2cQx8vWED4/B4QlQ5aE
	NwF9/6iaMr5RS290fdjNovWOmFM1lwanozMSrUnbl9wGPWM4IYa93UyW1aqC85ku6MB5YoiAe9l
	nZc4Nh0bieTQyxSnKrf+aYj2Yfwm6vnGdFCtxACZln1GhXt71+eOr4G5UYjGDNvq+BEBkdyNlLM
	dURZawl+3hTVf4HxNXnpDUBkoi0/0/IbQBeh
X-Received: by 2002:a17:903:b87:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-2b2769dbae2mr407595ad.7.1775074215436; Wed, 01 Apr 2026
 13:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204214235.589865-1-irogers@google.com> <aWGtNvi9kbBCTNVE@google.com>
 <aWa75MJy7FMyzR9P@x1> <CAP-5=fUcceQuKSu_FhOPxpsXwi2ou+iR3VHafcy1kCHa0CeVhA@mail.gmail.com>
 <ac16HyVvtutHnjuX@x1>
In-Reply-To: <ac16HyVvtutHnjuX@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 13:10:02 -0700
X-Gm-Features: AQROBzDK-ulv7ImRdY5MFsqvkOS_e5-pxW-Xq7TVnfESKKWQkT188PiT8Uk4VNE
Message-ID: <CAP-5=fVyS62hOZ-_atyRD7Fp8PQ5m4CVLoza48ZdLMDRT6Rb8g@mail.gmail.com>
Subject: Re: [PATCH v1] perf: Make more global variables static
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 1:03=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Mar 31, 2026 at 10:15:16PM -0700, Ian Rogers wrote:
> > On Tue, Jan 13, 2026 at 1:40=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Fri, Jan 09, 2026 at 05:36:54PM -0800, Namhyung Kim wrote:
> > > > On Thu, Dec 04, 2025 at 01:42:35PM -0800, Ian Rogers wrote:
> > > > > `make check` will run sparse on the perf code base. A frequent wa=
rning
> > > > > is "warning: symbol '...' was not declared. Should it be static?"=
 Go
> > > > > through and make global definitions without declarations static. =
In
> > > > > some cases it is deliberate due to dlsym accessing the symbol, th=
is
> > > > > change doesn't clean up the missing declarations for perf test
> > > > > suites. Sometimes things can opportunistically be made const. Mak=
ing
> > > > > somethings static exposed unused functions warnings, so restructu=
ring
> > > > > of ifdefs was necessary for that. These changes reduce the size o=
f the
> > > > > perf binary by 3,264 bytes.
> > > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > >
> > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > > Thanks, applied to perf-tools-next,
> >
> > Hi Arnaldo, it looks like this patch got lost. I'm not seeing it in
> > perf-tools-next. I suspect it needs a hefty rebase now. Any idea what
> > happened?
>
> I think there was some issue and I removed it to make progress, then
> fell thru the cracks.
>
> I refreshed it, see below, will send together with a few other patches
> after testing it in the build containers.
>
> There were just a few adjustments and a lot of fuzz the perf regs part
> you refactored, etc.
>
> Thanks for the reminder and sorry about it,

No worries, I should re-run sparse at some point to see what else we
can clean up. Thanks for taking the time to refresh it.

Ian

> - Arnaldo
>
> From 28366a044268da5191328d62edd28fc33d5f6a1f Mon Sep 17 00:00:00 2001
> From: Ian Rogers <irogers@google.com>
> Date: Wed, 1 Apr 2026 09:53:16 -0300
> Subject: [PATCH 1/3] perf tools: Make more global variables static
>
> `make check` will run sparse on the perf code base. A frequent warning
> is "warning: symbol '...' was not declared. Should it be static?" Go
> through and make global definitions without declarations static.
>
> In some cases it is deliberate due to dlsym accessing the symbol, this
> change doesn't clean up the missing declarations for perf test suites.
>
> Sometimes things can opportunistically be made const.
>
> Making somethings static exposed unused functions warnings, so
> restructuring of ifdefs was necessary for that.
>
> These changes reduce the size of the perf binary by 568 bytes.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> Acked-by: Ankur Arora <ankur.a.arora@oracle.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Howard Chu <howardchu95@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Leo Yan <leo.yan@arm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Yujie Liu <yujie.liu@intel.com>
> [ Refreshed the patch, the original one fell thru the cracks, updated the=
 size reduction ]
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/arch/common.c                      |  22 ++--
>  tools/perf/arch/sh/include/dwarf-regs-table.h |   2 +-
>  tools/perf/bench/breakpoint.c                 |   4 +-
>  tools/perf/bench/mem-functions.c              |   2 +-
>  tools/perf/bench/numa.c                       |   2 +-
>  tools/perf/bench/uprobe.c                     |   2 +-
>  tools/perf/builtin-c2c.c                      |   7 +-
>  tools/perf/builtin-config.c                   |   2 +-
>  tools/perf/builtin-data.c                     |   8 +-
>  tools/perf/builtin-diff.c                     |   4 +-
>  tools/perf/builtin-kmem.c                     |   2 +-
>  tools/perf/builtin-kwork.c                    |  12 +-
>  tools/perf/builtin-script.c                   |   2 +-
>  tools/perf/builtin-top.c                      |   5 +-
>  tools/perf/tests/bp_signal.c                  |   2 +-
>  tools/perf/tests/dso-data.c                   |   2 +-
>  tools/perf/tests/wp.c                         |   6 +-
>  tools/perf/util/block-range.c                 |   2 +-
>  tools/perf/util/bpf_counter.c                 |   4 +-
>  tools/perf/util/bpf_off_cpu.c                 |   2 +-
>  tools/perf/util/debug.c                       |   2 +-
>  tools/perf/util/debuginfo.c                   |  19 ++--
>  tools/perf/util/sort.c                        | 104 +++++++++---------
>  tools/perf/util/trace-event-scripting.c       |  98 +++++++++--------
>  tools/perf/util/util.c                        |   2 -
>  25 files changed, 159 insertions(+), 160 deletions(-)
>
> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index 4908d54dd33b2733..21836f70f231e42d 100644
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c
> @@ -9,14 +9,14 @@
>  #include "../util/debug.h"
>  #include <linux/zalloc.h>
>
> -const char *const arc_triplets[] =3D {
> +static const char *const arc_triplets[] =3D {
>         "arc-linux-",
>         "arc-snps-linux-uclibc-",
>         "arc-snps-linux-gnu-",
>         NULL
>  };
>
> -const char *const arm_triplets[] =3D {
> +static const char *const arm_triplets[] =3D {
>         "arm-eabi-",
>         "arm-linux-androideabi-",
>         "arm-unknown-linux-",
> @@ -28,13 +28,13 @@ const char *const arm_triplets[] =3D {
>         NULL
>  };
>
> -const char *const arm64_triplets[] =3D {
> +static const char *const arm64_triplets[] =3D {
>         "aarch64-linux-android-",
>         "aarch64-linux-gnu-",
>         NULL
>  };
>
> -const char *const powerpc_triplets[] =3D {
> +static const char *const powerpc_triplets[] =3D {
>         "powerpc-unknown-linux-gnu-",
>         "powerpc-linux-gnu-",
>         "powerpc64-unknown-linux-gnu-",
> @@ -43,40 +43,40 @@ const char *const powerpc_triplets[] =3D {
>         NULL
>  };
>
> -const char *const riscv32_triplets[] =3D {
> +static const char *const riscv32_triplets[] =3D {
>         "riscv32-unknown-linux-gnu-",
>         "riscv32-linux-android-",
>         "riscv32-linux-gnu-",
>         NULL
>  };
>
> -const char *const riscv64_triplets[] =3D {
> +static const char *const riscv64_triplets[] =3D {
>         "riscv64-unknown-linux-gnu-",
>         "riscv64-linux-android-",
>         "riscv64-linux-gnu-",
>         NULL
>  };
>
> -const char *const s390_triplets[] =3D {
> +static const char *const s390_triplets[] =3D {
>         "s390-ibm-linux-",
>         "s390x-linux-gnu-",
>         NULL
>  };
>
> -const char *const sh_triplets[] =3D {
> +static const char *const sh_triplets[] =3D {
>         "sh-unknown-linux-gnu-",
>         "sh-linux-gnu-",
>         NULL
>  };
>
> -const char *const sparc_triplets[] =3D {
> +static const char *const sparc_triplets[] =3D {
>         "sparc-unknown-linux-gnu-",
>         "sparc64-unknown-linux-gnu-",
>         "sparc64-linux-gnu-",
>         NULL
>  };
>
> -const char *const x86_triplets[] =3D {
> +static const char *const x86_triplets[] =3D {
>         "x86_64-pc-linux-gnu-",
>         "x86_64-unknown-linux-gnu-",
>         "i686-pc-linux-gnu-",
> @@ -90,7 +90,7 @@ const char *const x86_triplets[] =3D {
>         NULL
>  };
>
> -const char *const mips_triplets[] =3D {
> +static const char *const mips_triplets[] =3D {
>         "mips-unknown-linux-gnu-",
>         "mipsel-linux-android-",
>         "mips-linux-gnu-",
> diff --git a/tools/perf/arch/sh/include/dwarf-regs-table.h b/tools/perf/a=
rch/sh/include/dwarf-regs-table.h
> index 900e6961997091c7..b5974a090fb44a79 100644
> --- a/tools/perf/arch/sh/include/dwarf-regs-table.h
> +++ b/tools/perf/arch/sh/include/dwarf-regs-table.h
> @@ -2,7 +2,7 @@
>  #ifdef DEFINE_DWARF_REGSTR_TABLE
>  /* This is included in perf/util/dwarf-regs.c */
>
> -const char * const sh_regstr_tbl[] =3D {
> +static const char * const sh_regstr_tbl[] =3D {
>         "r0",
>         "r1",
>         "r2",
> diff --git a/tools/perf/bench/breakpoint.c b/tools/perf/bench/breakpoint.=
c
> index dfd18f5db97dbc7e..1b7cd4481bd224aa 100644
> --- a/tools/perf/bench/breakpoint.c
> +++ b/tools/perf/bench/breakpoint.c
> @@ -16,7 +16,7 @@
>  #include "bench.h"
>  #include "futex.h"
>
> -struct {
> +static struct {
>         unsigned int nbreakpoints;
>         unsigned int nparallel;
>         unsigned int nthreads;
> @@ -173,7 +173,7 @@ int bench_breakpoint_thread(int argc, const char **ar=
gv)
>         return 0;
>  }
>
> -struct {
> +static struct {
>         unsigned int npassive;
>         unsigned int nactive;
>  } enable_params =3D {
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-func=
tions.c
> index f5ab41bb85bf67a0..5ede528539535b6a 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -399,7 +399,7 @@ static void mem_free(struct bench_mem_info *info __ma=
ybe_unused,
>         *dst =3D *src =3D NULL;
>  }
>
> -struct function memcpy_functions[] =3D {
> +static struct function memcpy_functions[] =3D {
>         { .name         =3D "default",
>           .desc         =3D "Default memcpy() provided by glibc",
>           .fn.init      =3D mem_alloc,
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index 19be2aaf4dc0c07e..6588a9b0b15aec6d 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -166,7 +166,7 @@ static struct global_info   *g =3D NULL;
>  static int parse_cpus_opt(const struct option *opt, const char *arg, int=
 unset);
>  static int parse_nodes_opt(const struct option *opt, const char *arg, in=
t unset);
>
> -struct params p0;
> +static struct params p0;
>
>  static const struct option options[] =3D {
>         OPT_INTEGER('p', "nr_proc"      , &p0.nr_proc,          "number o=
f processes"),
> diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
> index c4dac868f1eea401..89697ff788ef3035 100644
> --- a/tools/perf/bench/uprobe.c
> +++ b/tools/perf/bench/uprobe.c
> @@ -58,7 +58,7 @@ static const char * const bench_uprobe_usage[] =3D {
>                 goto cleanup; \
>         }
>
> -struct bench_uprobe_bpf *skel;
> +static struct bench_uprobe_bpf *skel;
>
>  static int bench_uprobe__setup_bpf_skel(enum bench_uprobe bench)
>  {
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index e60eea62c2fc76d6..3ce5f0adec2f31c2 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2892,9 +2892,10 @@ static int ui_quirks(void)
>
>  #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
>
> -const char callchain_help[] =3D "Display call graph (stack chain/backtra=
ce):\n\n"
> -                               CALLCHAIN_REPORT_HELP
> -                               "\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_O=
PT;
> +static const char callchain_help[] =3D
> +       "Display call graph (stack chain/backtrace):\n\n"
> +       CALLCHAIN_REPORT_HELP
> +       "\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
>
>  static int
>  parse_callchain_opt(const struct option *opt, const char *arg, int unset=
)
> diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
> index 45b5312fbe8370e8..237600643bbd6f33 100644
> --- a/tools/perf/builtin-config.c
> +++ b/tools/perf/builtin-config.c
> @@ -23,7 +23,7 @@ static const char * const config_usage[] =3D {
>         NULL
>  };
>
> -enum actions {
> +static enum actions {
>         ACTION_LIST =3D 1
>  } actions;
>
> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
> index 85f59886b5cf0045..4c08ccb8c06b7598 100644
> --- a/tools/perf/builtin-data.c
> +++ b/tools/perf/builtin-data.c
> @@ -28,15 +28,15 @@ static const char *data_usage[] =3D {
>         NULL
>  };
>
> -const char *to_json;
> -const char *to_ctf;
> -struct perf_data_convert_opts opts =3D {
> +static const char *to_json;
> +static const char *to_ctf;
> +static struct perf_data_convert_opts opts =3D {
>         .force =3D false,
>         .all =3D false,
>         .time_str =3D NULL,
>  };
>
> -const struct option data_options[] =3D {
> +static const struct option data_options[] =3D {
>                 OPT_INCR('v', "verbose", &verbose, "be more verbose"),
>                 OPT_STRING('i', "input", &input_name, "file", "input file=
 name"),
>                 OPT_STRING(0, "to-json", &to_json, NULL, "Convert to JSON=
 format"),
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 69069926dd0ba07b..e45f0ac1381ab2df 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -113,7 +113,7 @@ enum {
>         COMPUTE_STREAM, /* After COMPUTE_MAX to avoid use current compute=
 arrays */
>  };
>
> -const char *compute_names[COMPUTE_MAX] =3D {
> +static const char *compute_names[COMPUTE_MAX] =3D {
>         [COMPUTE_DELTA] =3D "delta",
>         [COMPUTE_DELTA_ABS] =3D "delta-abs",
>         [COMPUTE_RATIO] =3D "ratio",
> @@ -382,7 +382,7 @@ static void block_hist_free(void *he)
>         free(bh);
>  }
>
> -struct hist_entry_ops block_hist_ops =3D {
> +static struct hist_entry_ops block_hist_ops =3D {
>         .new    =3D block_hist_zalloc,
>         .free   =3D block_hist_free,
>  };
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 7929a5fa5f462b32..9c64a0d7482378cc 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -82,7 +82,7 @@ static unsigned long nr_allocs, nr_cross_allocs;
>
>  /* filters for controlling start and stop of time of analysis */
>  static struct perf_time_interval ptime;
> -const char *time_str;
> +static const char *time_str;
>
>  static int insert_alloc_stat(unsigned long call_site, unsigned long ptr,
>                              int bytes_req, int bytes_alloc, int cpu)
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 6f94a8f45f605f34..1140e00e874f4eed 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -985,7 +985,7 @@ static int process_irq_handler_exit_event(const struc=
t perf_tool *tool,
>         return 0;
>  }
>
> -const struct evsel_str_handler irq_tp_handlers[] =3D {
> +static const struct evsel_str_handler irq_tp_handlers[] =3D {
>         { "irq:irq_handler_entry", process_irq_handler_entry_event, },
>         { "irq:irq_handler_exit",  process_irq_handler_exit_event,  },
>  };
> @@ -1080,7 +1080,7 @@ static int process_softirq_exit_event(const struct =
perf_tool *tool,
>         return 0;
>  }
>
> -const struct evsel_str_handler softirq_tp_handlers[] =3D {
> +static const struct evsel_str_handler softirq_tp_handlers[] =3D {
>         { "irq:softirq_raise", process_softirq_raise_event, },
>         { "irq:softirq_entry", process_softirq_entry_event, },
>         { "irq:softirq_exit",  process_softirq_exit_event,  },
> @@ -1211,7 +1211,7 @@ static int process_workqueue_execute_end_event(cons=
t struct perf_tool *tool,
>         return 0;
>  }
>
> -const struct evsel_str_handler workqueue_tp_handlers[] =3D {
> +static const struct evsel_str_handler workqueue_tp_handlers[] =3D {
>         { "workqueue:workqueue_activate_work", process_workqueue_activate=
_work_event, },
>         { "workqueue:workqueue_execute_start", process_workqueue_execute_=
start_event, },
>         { "workqueue:workqueue_execute_end",   process_workqueue_execute_=
end_event,   },
> @@ -1281,7 +1281,7 @@ static int process_sched_switch_event(const struct =
perf_tool *tool,
>         return 0;
>  }
>
> -const struct evsel_str_handler sched_tp_handlers[] =3D {
> +static const struct evsel_str_handler sched_tp_handlers[] =3D {
>         { "sched:sched_switch",  process_sched_switch_event, },
>  };
>
> @@ -1561,13 +1561,13 @@ static void print_bad_events(struct perf_kwork *k=
work)
>         }
>  }
>
> -const char *graph_load =3D "||||||||||||||||||||||||||||||||||||||||||||=
||||";
> -const char *graph_idle =3D "                                            =
    ";
>  static void top_print_per_cpu_load(struct perf_kwork *kwork)
>  {
>         int i, load_width;
>         u64 total, load, load_ratio;
>         struct kwork_top_stat *stat =3D &kwork->top_stat;
> +       const char *graph_load =3D "|||||||||||||||||||||||||||||||||||||=
|||||||||||";
> +       const char *graph_idle =3D "                                     =
           ";
>
>         for (i =3D 0; i < MAX_NR_CPUS; i++) {
>                 total =3D stat->cpus_runtime[i].total;
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index b005b23f9d8cd273..15a58da599581a7b 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -166,7 +166,7 @@ struct perf_script {
>         int                     range_num;
>  };
>
> -struct output_option {
> +static struct output_option {
>         const char *str;
>         enum perf_output_field field;
>  } all_output_options[] =3D {
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 37950efb28aca8cc..35ff2495e1ee5897 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1449,11 +1449,10 @@ parse_percent_limit(const struct option *opt, con=
st char *arg,
>         return 0;
>  }
>
> -const char top_callchain_help[] =3D CALLCHAIN_RECORD_HELP CALLCHAIN_REPO=
RT_HELP
> -       "\n\t\t\t\tDefault: fp,graph,0.5,caller,function";
> -
>  int cmd_top(int argc, const char **argv)
>  {
> +       const char top_callchain_help[] =3D CALLCHAIN_RECORD_HELP CALLCHA=
IN_REPORT_HELP
> +               "\n\t\t\t\tDefault: fp,graph,0.5,caller,function";
>         char errbuf[BUFSIZ];
>         struct perf_top top =3D {
>                 .count_filter        =3D 5,
> diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> index 3faeb5b6fe0bb24a..f580ba7486b1d8ab 100644
> --- a/tools/perf/tests/bp_signal.c
> +++ b/tools/perf/tests/bp_signal.c
> @@ -36,7 +36,7 @@ static int fd3;
>  static int overflows;
>  static int overflows_2;
>
> -volatile long the_var;
> +static volatile long the_var;
>
>
>  /*
> diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
> index a1fff4203b75f665..46bc3f59726004fa 100644
> --- a/tools/perf/tests/dso-data.c
> +++ b/tools/perf/tests/dso-data.c
> @@ -58,7 +58,7 @@ struct test_data_offset {
>         int size;
>  };
>
> -struct test_data_offset offsets[] =3D {
> +static struct test_data_offset offsets[] =3D {
>         /* Fill first cache page. */
>         {
>                 .offset =3D 10,
> diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
> index 6c178985e37f5eba..69b31f00eed04c5b 100644
> --- a/tools/perf/tests/wp.c
> +++ b/tools/perf/tests/wp.c
> @@ -22,11 +22,11 @@ do {                                            \
>
>  #ifdef __i386__
>  /* Only breakpoint length less-than 8 has hardware support on i386. */
> -volatile u32 data1;
> +static volatile u32 data1;
>  #else
> -volatile u64 data1;
> +static volatile u64 data1;
>  #endif
> -volatile u8 data2[3];
> +static volatile u8 data2[3];
>
>  #ifndef __s390x__
>  static int wp_read(int fd, long long *count, int size)
> diff --git a/tools/perf/util/block-range.c b/tools/perf/util/block-range.=
c
> index 15c42196c24c8230..7c559fcfd7e0a6db 100644
> --- a/tools/perf/util/block-range.c
> +++ b/tools/perf/util/block-range.c
> @@ -4,7 +4,7 @@
>  #include <assert.h>
>  #include <stdlib.h>
>
> -struct {
> +static struct {
>         struct rb_root root;
>         u64 blocks;
>  } block_ranges;
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.=
c
> index 2ffd7aefb6eb3bf8..34b6b0da18b738c7 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -353,7 +353,7 @@ static int bpf_program_profiler__install_pe(struct ev=
sel *evsel, int cpu_map_idx
>         return 0;
>  }
>
> -struct bpf_counter_ops bpf_program_profiler_ops =3D {
> +static struct bpf_counter_ops bpf_program_profiler_ops =3D {
>         .load       =3D bpf_program_profiler__load,
>         .enable     =3D bpf_program_profiler__enable,
>         .disable    =3D bpf_program_profiler__disable,
> @@ -833,7 +833,7 @@ static int bperf__destroy(struct evsel *evsel)
>   * the leader prog.
>   */
>
> -struct bpf_counter_ops bperf_ops =3D {
> +static struct bpf_counter_ops bperf_ops =3D {
>         .load       =3D bperf__load,
>         .enable     =3D bperf__enable,
>         .disable    =3D bperf__disable,
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.=
c
> index 0891d9c736609cfa..a3b699a5322f1e51 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -39,7 +39,7 @@ union off_cpu_data {
>         u64 array[1024 / sizeof(u64)];
>  };
>
> -u64 off_cpu_raw[MAX_STACKS + 5];
> +static u64 off_cpu_raw[MAX_STACKS + 5];
>
>  static int off_cpu_config(struct evlist *evlist)
>  {
> diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> index 1dfa4d0eec4d7d5a..6b5ffe81f14121b7 100644
> --- a/tools/perf/util/debug.c
> +++ b/tools/perf/util/debug.c
> @@ -48,7 +48,7 @@ int debug_ordered_events;
>  static int redirect_to_stderr;
>  int debug_data_convert;
>  static FILE *_debug_file;
> -bool debug_display_time;
> +static bool debug_display_time;
>  int debug_type_profile;
>
>  FILE *debug_file(void)
> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index 4a559b3e8cdce60a..8b819dea36ac1ef0 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
> @@ -88,18 +88,17 @@ static struct debuginfo *__debuginfo__new(const char =
*path)
>         return dbg;
>  }
>
> -enum dso_binary_type distro_dwarf_types[] =3D {
> -       DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
> -       DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
> -       DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
> -       DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
> -       DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
> -       DSO_BINARY_TYPE__NOT_FOUND,
> -};
> -
>  struct debuginfo *debuginfo__new(const char *path)
>  {
> -       enum dso_binary_type *type;
> +       const enum dso_binary_type distro_dwarf_types[] =3D {
> +               DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
> +               DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
> +               DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
> +               DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
> +               DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
> +               DSO_BINARY_TYPE__NOT_FOUND,
> +       };
> +       const enum dso_binary_type *type;
>         char buf[PATH_MAX], nil =3D '\0';
>         struct dso *dso;
>         struct debuginfo *dinfo =3D NULL;
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index fda8fcfa46e07d38..fe482eec7d9ada28 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -43,11 +43,11 @@ regex_t             parent_regex;
>  const char     default_parent_pattern[] =3D "^sys_|^do_page_fault";
>  const char     *parent_pattern =3D default_parent_pattern;
>  const char     *default_sort_order =3D "comm,dso,symbol";
> -const char     default_branch_sort_order[] =3D "comm,dso_from,symbol_fro=
m,symbol_to,cycles";
> +static const char      default_branch_sort_order[] =3D "comm,dso_from,sy=
mbol_from,symbol_to,cycles";
>  const char     default_mem_sort_order[] =3D "local_weight,mem,sym,dso,sy=
mbol_daddr,dso_daddr,snoop,tlb,locked,blocked,local_ins_lat,local_p_stage_c=
yc";
> -const char     default_top_sort_order[] =3D "dso,symbol";
> -const char     default_diff_sort_order[] =3D "dso,symbol";
> -const char     default_tracepoint_sort_order[] =3D "trace";
> +static const char      default_top_sort_order[] =3D "dso,symbol";
> +static const char      default_diff_sort_order[] =3D "dso,symbol";
> +static const char      default_tracepoint_sort_order[] =3D "trace";
>  const char     *sort_order;
>  const char     *field_order;
>  regex_t                ignore_callees_regex;
> @@ -172,7 +172,7 @@ static int hist_entry__tgid_snprintf(struct hist_entr=
y *he, char *bf,
>         return repsep_snprintf(bf, size, "%7d:%-*.*s", tgid, width, width=
, comm ?: "");
>  }
>
> -struct sort_entry sort_tgid =3D {
> +static struct sort_entry sort_tgid =3D {
>         .se_header      =3D "   Tgid:Command",
>         .se_cmp         =3D sort__tgid_cmp,
>         .se_snprintf    =3D hist_entry__tgid_snprintf,
> @@ -218,7 +218,7 @@ static int hist_entry__simd_snprintf(struct hist_entr=
y *he, char *bf,
>         return repsep_snprintf(bf, size, "[.] %s", name);
>  }
>
> -struct sort_entry sort_simd =3D {
> +static struct sort_entry sort_simd =3D {
>         .se_header      =3D "Simd   ",
>         .se_cmp         =3D sort__simd_cmp,
>         .se_snprintf    =3D hist_entry__simd_snprintf,
> @@ -604,7 +604,7 @@ hist_entry__symoff_snprintf(struct hist_entry *he, ch=
ar *bf, size_t size, unsign
>         return repsep_snprintf(bf, size, "[%c] %s+0x%llx", he->level, sym=
->name, he->ip - sym->start);
>  }
>
> -struct sort_entry sort_sym_offset =3D {
> +static struct sort_entry sort_sym_offset =3D {
>         .se_header      =3D "Symbol Offset",
>         .se_cmp         =3D sort__symoff_cmp,
>         .se_sort        =3D sort__symoff_sort,
> @@ -715,7 +715,7 @@ static int hist_entry__srcline_from_snprintf(struct h=
ist_entry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*.*s", width, width, he->bran=
ch_info->srcline_from);
>  }
>
> -struct sort_entry sort_srcline_from =3D {
> +static struct sort_entry sort_srcline_from =3D {
>         .se_header      =3D "From Source:Line",
>         .se_cmp         =3D sort__srcline_from_cmp,
>         .se_collapse    =3D sort__srcline_from_collapse,
> @@ -763,7 +763,7 @@ static int hist_entry__srcline_to_snprintf(struct his=
t_entry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*.*s", width, width, he->bran=
ch_info->srcline_to);
>  }
>
> -struct sort_entry sort_srcline_to =3D {
> +static struct sort_entry sort_srcline_to =3D {
>         .se_header      =3D "To Source:Line",
>         .se_cmp         =3D sort__srcline_to_cmp,
>         .se_collapse    =3D sort__srcline_to_collapse,
> @@ -799,7 +799,7 @@ static int hist_entry__sym_ipc_snprintf(struct hist_e=
ntry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*s", width, tmp);
>  }
>
> -struct sort_entry sort_sym_ipc =3D {
> +static struct sort_entry sort_sym_ipc =3D {
>         .se_header      =3D "IPC   [IPC Coverage]",
>         .se_cmp         =3D sort__sym_cmp,
>         .se_snprintf    =3D hist_entry__sym_ipc_snprintf,
> @@ -817,7 +817,7 @@ static int hist_entry__sym_ipc_null_snprintf(struct h=
ist_entry *he
>         return repsep_snprintf(bf, size, "%-*s", width, tmp);
>  }
>
> -struct sort_entry sort_sym_ipc_null =3D {
> +static struct sort_entry sort_sym_ipc_null =3D {
>         .se_header      =3D "IPC   [IPC Coverage]",
>         .se_cmp         =3D sort__sym_cmp,
>         .se_snprintf    =3D hist_entry__sym_ipc_null_snprintf,
> @@ -850,7 +850,7 @@ static int hist_entry__callchain_branch_predicted_snp=
rintf(
>         return repsep_snprintf(bf, size, "%-*.*s", width, width, str);
>  }
>
> -struct sort_entry sort_callchain_branch_predicted =3D {
> +static struct sort_entry sort_callchain_branch_predicted =3D {
>         .se_header      =3D "Predicted",
>         .se_cmp         =3D sort__callchain_branch_predicted_cmp,
>         .se_snprintf    =3D hist_entry__callchain_branch_predicted_snprin=
tf,
> @@ -880,7 +880,7 @@ static int hist_entry__callchain_branch_abort_snprint=
f(struct hist_entry *he,
>         return repsep_snprintf(bf, size, "%-*.*s", width, width, str);
>  }
>
> -struct sort_entry sort_callchain_branch_abort =3D {
> +static struct sort_entry sort_callchain_branch_abort =3D {
>         .se_header      =3D "Abort",
>         .se_cmp         =3D sort__callchain_branch_abort_cmp,
>         .se_snprintf    =3D hist_entry__callchain_branch_abort_snprintf,
> @@ -913,7 +913,7 @@ static int hist_entry__callchain_branch_cycles_snprin=
tf(struct hist_entry *he,
>         return repsep_snprintf(bf, size, "%-*.*s", width, width, str);
>  }
>
> -struct sort_entry sort_callchain_branch_cycles =3D {
> +static struct sort_entry sort_callchain_branch_cycles =3D {
>         .se_header      =3D "Cycles",
>         .se_cmp         =3D sort__callchain_branch_cycles_cmp,
>         .se_snprintf    =3D hist_entry__callchain_branch_cycles_snprintf,
> @@ -980,7 +980,7 @@ static int hist_entry__srcfile_snprintf(struct hist_e=
ntry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-.*s", width, he->srcfile);
>  }
>
> -struct sort_entry sort_srcfile =3D {
> +static struct sort_entry sort_srcfile =3D {
>         .se_header      =3D "Source File",
>         .se_cmp         =3D sort__srcfile_cmp,
>         .se_collapse    =3D sort__srcfile_collapse,
> @@ -1032,7 +1032,7 @@ static int hist_entry__cpu_snprintf(struct hist_ent=
ry *he, char *bf,
>         return repsep_snprintf(bf, size, "%*.*d", width, width, he->cpu);
>  }
>
> -struct sort_entry sort_cpu =3D {
> +static struct sort_entry sort_cpu =3D {
>         .se_header      =3D "CPU",
>         .se_cmp         =3D sort__cpu_cmp,
>         .se_snprintf    =3D hist_entry__cpu_snprintf,
> @@ -1063,7 +1063,7 @@ static int hist_entry__parallelism_snprintf(struct =
hist_entry *he, char *bf,
>         return repsep_snprintf(bf, size, "%*d", width, he->parallelism);
>  }
>
> -struct sort_entry sort_parallelism =3D {
> +static struct sort_entry sort_parallelism =3D {
>         .se_header      =3D "Parallelism",
>         .se_cmp         =3D sort__parallelism_cmp,
>         .se_filter      =3D hist_entry__parallelism_filter,
> @@ -1104,7 +1104,7 @@ static int hist_entry__cgroup_id_snprintf(struct hi=
st_entry *he,
>                                he->cgroup_id.ino);
>  }
>
> -struct sort_entry sort_cgroup_id =3D {
> +static struct sort_entry sort_cgroup_id =3D {
>         .se_header      =3D "cgroup id (dev/inode)",
>         .se_cmp         =3D sort__cgroup_id_cmp,
>         .se_snprintf    =3D hist_entry__cgroup_id_snprintf,
> @@ -1137,7 +1137,7 @@ static int hist_entry__cgroup_snprintf(struct hist_=
entry *he,
>         return repsep_snprintf(bf, size, "%s", cgrp_name);
>  }
>
> -struct sort_entry sort_cgroup =3D {
> +static struct sort_entry sort_cgroup =3D {
>         .se_header      =3D "Cgroup",
>         .se_cmp         =3D sort__cgroup_cmp,
>         .se_snprintf    =3D hist_entry__cgroup_snprintf,
> @@ -1168,7 +1168,7 @@ static int hist_entry__socket_filter(struct hist_en=
try *he, int type, const void
>         return sk >=3D 0 && he->socket !=3D sk;
>  }
>
> -struct sort_entry sort_socket =3D {
> +static struct sort_entry sort_socket =3D {
>         .se_header      =3D "Socket",
>         .se_cmp         =3D sort__socket_cmp,
>         .se_snprintf    =3D hist_entry__socket_snprintf,
> @@ -1199,7 +1199,7 @@ static int hist_entry__time_snprintf(struct hist_en=
try *he, char *bf,
>         return repsep_snprintf(bf, size, "%-.*s", width, he_time);
>  }
>
> -struct sort_entry sort_time =3D {
> +static struct sort_entry sort_time =3D {
>         .se_header      =3D "Time",
>         .se_cmp         =3D sort__time_cmp,
>         .se_snprintf    =3D hist_entry__time_snprintf,
> @@ -1268,7 +1268,7 @@ static int hist_entry__trace_snprintf(struct hist_e=
ntry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-.*s", width, he->trace_output=
);
>  }
>
> -struct sort_entry sort_trace =3D {
> +static struct sort_entry sort_trace =3D {
>         .se_header      =3D "Trace output",
>         .se_cmp         =3D sort__trace_cmp,
>         .se_snprintf    =3D hist_entry__trace_snprintf,
> @@ -1563,7 +1563,7 @@ sort__addr_to_cmp(struct hist_entry *left, struct h=
ist_entry *right)
>         return _sort__addr_cmp(to_l->addr, to_r->addr);
>  }
>
> -struct sort_entry sort_addr_from =3D {
> +static struct sort_entry sort_addr_from =3D {
>         .se_header      =3D "Source Address",
>         .se_cmp         =3D sort__addr_from_cmp,
>         .se_snprintf    =3D hist_entry__addr_from_snprintf,
> @@ -1571,7 +1571,7 @@ struct sort_entry sort_addr_from =3D {
>         .se_width_idx   =3D HISTC_ADDR_FROM,
>  };
>
> -struct sort_entry sort_addr_to =3D {
> +static struct sort_entry sort_addr_to =3D {
>         .se_header      =3D "Target Address",
>         .se_cmp         =3D sort__addr_to_cmp,
>         .se_snprintf    =3D hist_entry__addr_to_snprintf,
> @@ -1628,7 +1628,7 @@ static int hist_entry__cycles_snprintf(struct hist_=
entry *he, char *bf,
>                                he->branch_info->flags.cycles);
>  }
>
> -struct sort_entry sort_cycles =3D {
> +static struct sort_entry sort_cycles =3D {
>         .se_header      =3D "Basic Block Cycles",
>         .se_cmp         =3D sort__cycles_cmp,
>         .se_snprintf    =3D hist_entry__cycles_snprintf,
> @@ -1918,7 +1918,7 @@ static int hist_entry__dcacheline_snprintf(struct h=
ist_entry *he, char *bf,
>         return _hist_entry__sym_snprintf(ms, addr, level, bf, size, width=
);
>  }
>
> -struct sort_entry sort_mispredict =3D {
> +static struct sort_entry sort_mispredict =3D {
>         .se_header      =3D "Branch Mispredicted",
>         .se_cmp         =3D sort__mispredict_cmp,
>         .se_snprintf    =3D hist_entry__mispredict_snprintf,
> @@ -1937,7 +1937,7 @@ static int hist_entry__local_weight_snprintf(struct=
 hist_entry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*llu", width, he->weight);
>  }
>
> -struct sort_entry sort_local_weight =3D {
> +static struct sort_entry sort_local_weight =3D {
>         .se_header      =3D "Local Weight",
>         .se_cmp         =3D sort__weight_cmp,
>         .se_snprintf    =3D hist_entry__local_weight_snprintf,
> @@ -1951,7 +1951,7 @@ static int hist_entry__global_weight_snprintf(struc=
t hist_entry *he, char *bf,
>                                he->weight * he->stat.nr_events);
>  }
>
> -struct sort_entry sort_global_weight =3D {
> +static struct sort_entry sort_global_weight =3D {
>         .se_header      =3D "Weight",
>         .se_cmp         =3D sort__weight_cmp,
>         .se_snprintf    =3D hist_entry__global_weight_snprintf,
> @@ -1970,7 +1970,7 @@ static int hist_entry__local_ins_lat_snprintf(struc=
t hist_entry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*u", width, he->ins_lat);
>  }
>
> -struct sort_entry sort_local_ins_lat =3D {
> +static struct sort_entry sort_local_ins_lat =3D {
>         .se_header      =3D "Local INSTR Latency",
>         .se_cmp         =3D sort__ins_lat_cmp,
>         .se_snprintf    =3D hist_entry__local_ins_lat_snprintf,
> @@ -1984,7 +1984,7 @@ static int hist_entry__global_ins_lat_snprintf(stru=
ct hist_entry *he, char *bf,
>                                he->ins_lat * he->stat.nr_events);
>  }
>
> -struct sort_entry sort_global_ins_lat =3D {
> +static struct sort_entry sort_global_ins_lat =3D {
>         .se_header      =3D "INSTR Latency",
>         .se_cmp         =3D sort__ins_lat_cmp,
>         .se_snprintf    =3D hist_entry__global_ins_lat_snprintf,
> @@ -2010,70 +2010,70 @@ static int hist_entry__p_stage_cyc_snprintf(struc=
t hist_entry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*u", width, he->weight3);
>  }
>
> -struct sort_entry sort_local_p_stage_cyc =3D {
> +static struct sort_entry sort_local_p_stage_cyc =3D {
>         .se_header      =3D "Local Pipeline Stage Cycle",
>         .se_cmp         =3D sort__p_stage_cyc_cmp,
>         .se_snprintf    =3D hist_entry__p_stage_cyc_snprintf,
>         .se_width_idx   =3D HISTC_LOCAL_P_STAGE_CYC,
>  };
>
> -struct sort_entry sort_global_p_stage_cyc =3D {
> +static struct sort_entry sort_global_p_stage_cyc =3D {
>         .se_header      =3D "Pipeline Stage Cycle",
>         .se_cmp         =3D sort__p_stage_cyc_cmp,
>         .se_snprintf    =3D hist_entry__global_p_stage_cyc_snprintf,
>         .se_width_idx   =3D HISTC_GLOBAL_P_STAGE_CYC,
>  };
>
> -struct sort_entry sort_mem_daddr_sym =3D {
> +static struct sort_entry sort_mem_daddr_sym =3D {
>         .se_header      =3D "Data Symbol",
>         .se_cmp         =3D sort__daddr_cmp,
>         .se_snprintf    =3D hist_entry__daddr_snprintf,
>         .se_width_idx   =3D HISTC_MEM_DADDR_SYMBOL,
>  };
>
> -struct sort_entry sort_mem_iaddr_sym =3D {
> +static struct sort_entry sort_mem_iaddr_sym =3D {
>         .se_header      =3D "Code Symbol",
>         .se_cmp         =3D sort__iaddr_cmp,
>         .se_snprintf    =3D hist_entry__iaddr_snprintf,
>         .se_width_idx   =3D HISTC_MEM_IADDR_SYMBOL,
>  };
>
> -struct sort_entry sort_mem_daddr_dso =3D {
> +static struct sort_entry sort_mem_daddr_dso =3D {
>         .se_header      =3D "Data Object",
>         .se_cmp         =3D sort__dso_daddr_cmp,
>         .se_snprintf    =3D hist_entry__dso_daddr_snprintf,
>         .se_width_idx   =3D HISTC_MEM_DADDR_DSO,
>  };
>
> -struct sort_entry sort_mem_locked =3D {
> +static struct sort_entry sort_mem_locked =3D {
>         .se_header      =3D "Locked",
>         .se_cmp         =3D sort__locked_cmp,
>         .se_snprintf    =3D hist_entry__locked_snprintf,
>         .se_width_idx   =3D HISTC_MEM_LOCKED,
>  };
>
> -struct sort_entry sort_mem_tlb =3D {
> +static struct sort_entry sort_mem_tlb =3D {
>         .se_header      =3D "TLB access",
>         .se_cmp         =3D sort__tlb_cmp,
>         .se_snprintf    =3D hist_entry__tlb_snprintf,
>         .se_width_idx   =3D HISTC_MEM_TLB,
>  };
>
> -struct sort_entry sort_mem_lvl =3D {
> +static struct sort_entry sort_mem_lvl =3D {
>         .se_header      =3D "Memory access",
>         .se_cmp         =3D sort__lvl_cmp,
>         .se_snprintf    =3D hist_entry__lvl_snprintf,
>         .se_width_idx   =3D HISTC_MEM_LVL,
>  };
>
> -struct sort_entry sort_mem_snoop =3D {
> +static struct sort_entry sort_mem_snoop =3D {
>         .se_header      =3D "Snoop",
>         .se_cmp         =3D sort__snoop_cmp,
>         .se_snprintf    =3D hist_entry__snoop_snprintf,
>         .se_width_idx   =3D HISTC_MEM_SNOOP,
>  };
>
> -struct sort_entry sort_mem_dcacheline =3D {
> +static struct sort_entry sort_mem_dcacheline =3D {
>         .se_header      =3D "Data Cacheline",
>         .se_cmp         =3D sort__dcacheline_cmp,
>         .se_snprintf    =3D hist_entry__dcacheline_snprintf,
> @@ -2108,7 +2108,7 @@ static int hist_entry__blocked_snprintf(struct hist=
_entry *he, char *bf,
>         return repsep_snprintf(bf, size, "%.*s", width, out);
>  }
>
> -struct sort_entry sort_mem_blocked =3D {
> +static struct sort_entry sort_mem_blocked =3D {
>         .se_header      =3D "Blocked",
>         .se_cmp         =3D sort__blocked_cmp,
>         .se_snprintf    =3D hist_entry__blocked_snprintf,
> @@ -2149,7 +2149,7 @@ static int hist_entry__phys_daddr_snprintf(struct h=
ist_entry *he, char *bf,
>         return width;
>  }
>
> -struct sort_entry sort_mem_phys_daddr =3D {
> +static struct sort_entry sort_mem_phys_daddr =3D {
>         .se_header      =3D "Data Physical Address",
>         .se_cmp         =3D sort__phys_daddr_cmp,
>         .se_snprintf    =3D hist_entry__phys_daddr_snprintf,
> @@ -2178,7 +2178,7 @@ static int hist_entry__data_page_size_snprintf(stru=
ct hist_entry *he, char *bf,
>                         get_page_size_name(mem_info__daddr(he->mem_info)-=
>data_page_size, str));
>  }
>
> -struct sort_entry sort_mem_data_page_size =3D {
> +static struct sort_entry sort_mem_data_page_size =3D {
>         .se_header      =3D "Data Page Size",
>         .se_cmp         =3D sort__data_page_size_cmp,
>         .se_snprintf    =3D hist_entry__data_page_size_snprintf,
> @@ -2203,7 +2203,7 @@ static int hist_entry__code_page_size_snprintf(stru=
ct hist_entry *he, char *bf,
>                                get_page_size_name(he->code_page_size, str=
));
>  }
>
> -struct sort_entry sort_code_page_size =3D {
> +static struct sort_entry sort_code_page_size =3D {
>         .se_header      =3D "Code Page Size",
>         .se_cmp         =3D sort__code_page_size_cmp,
>         .se_snprintf    =3D hist_entry__code_page_size_snprintf,
> @@ -2235,7 +2235,7 @@ static int hist_entry__abort_snprintf(struct hist_e=
ntry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*s", width, out);
>  }
>
> -struct sort_entry sort_abort =3D {
> +static struct sort_entry sort_abort =3D {
>         .se_header      =3D "Transaction abort",
>         .se_cmp         =3D sort__abort_cmp,
>         .se_snprintf    =3D hist_entry__abort_snprintf,
> @@ -2267,7 +2267,7 @@ static int hist_entry__in_tx_snprintf(struct hist_e=
ntry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*s", width, out);
>  }
>
> -struct sort_entry sort_in_tx =3D {
> +static struct sort_entry sort_in_tx =3D {
>         .se_header      =3D "Branch in transaction",
>         .se_cmp         =3D sort__in_tx_cmp,
>         .se_snprintf    =3D hist_entry__in_tx_snprintf,
> @@ -2339,7 +2339,7 @@ static int hist_entry__transaction_snprintf(struct =
hist_entry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*s", width, buf);
>  }
>
> -struct sort_entry sort_transaction =3D {
> +static struct sort_entry sort_transaction =3D {
>         .se_header      =3D "Transaction                ",
>         .se_cmp         =3D sort__transaction_cmp,
>         .se_snprintf    =3D hist_entry__transaction_snprintf,
> @@ -2378,7 +2378,7 @@ static int hist_entry__sym_size_snprintf(struct his=
t_entry *he, char *bf,
>         return _hist_entry__sym_size_snprintf(he->ms.sym, bf, size, width=
);
>  }
>
> -struct sort_entry sort_sym_size =3D {
> +static struct sort_entry sort_sym_size =3D {
>         .se_header      =3D "Symbol size",
>         .se_cmp         =3D sort__sym_size_cmp,
>         .se_snprintf    =3D hist_entry__sym_size_snprintf,
> @@ -2417,7 +2417,7 @@ static int hist_entry__dso_size_snprintf(struct his=
t_entry *he, char *bf,
>         return _hist_entry__dso_size_snprintf(he->ms.map, bf, size, width=
);
>  }
>
> -struct sort_entry sort_dso_size =3D {
> +static struct sort_entry sort_dso_size =3D {
>         .se_header      =3D "DSO size",
>         .se_cmp         =3D sort__dso_size_cmp,
>         .se_snprintf    =3D hist_entry__dso_size_snprintf,
> @@ -2454,7 +2454,7 @@ static int hist_entry__addr_snprintf(struct hist_en=
try *he, char *bf,
>         return repsep_snprintf(bf, size, "%-#*llx", width, ip);
>  }
>
> -struct sort_entry sort_addr =3D {
> +static struct sort_entry sort_addr =3D {
>         .se_header      =3D "Address",
>         .se_cmp         =3D sort__addr_cmp,
>         .se_snprintf    =3D hist_entry__addr_snprintf,
> @@ -2572,7 +2572,7 @@ static int hist_entry__typeoff_snprintf(struct hist=
_entry *he, char *bf,
>                                he->mem_type_off, buf);
>  }
>
> -struct sort_entry sort_type_offset =3D {
> +static struct sort_entry sort_type_offset =3D {
>         .se_header      =3D "Data Type Offset",
>         .se_cmp         =3D sort__type_cmp,
>         .se_collapse    =3D sort__typeoff_sort,
> @@ -2630,7 +2630,7 @@ static int hist_entry__typecln_snprintf(struct hist=
_entry *he, char *bf,
>                                he->mem_type_off / cln_size);
>  }
>
> -struct sort_entry sort_type_cacheline =3D {
> +static struct sort_entry sort_type_cacheline =3D {
>         .se_header      =3D "Data Type Cacheline",
>         .se_cmp         =3D sort__type_cmp,
>         .se_collapse    =3D sort__typecln_sort,
> diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/tr=
ace-event-scripting.c
> index fa850e44cb46cfd7..0745a2fe3af8c201 100644
> --- a/tools/perf/util/trace-event-scripting.c
> +++ b/tools/perf/util/trace-event-scripting.c
> @@ -122,6 +122,7 @@ void scripting_context__update(struct scripting_conte=
xt *c,
>         c->addr_al =3D addr_al;
>  }
>
> +#if !defined(HAVE_LIBPERL_SUPPORT) || !defined(HAVE_LIBPYTHON_SUPPORT)
>  static int flush_script_unsupported(void)
>  {
>         return 0;
> @@ -139,7 +140,22 @@ static void process_event_unsupported(union perf_eve=
nt *event __maybe_unused,
>                                       struct addr_location *addr_al __may=
be_unused)
>  {
>  }
> +#endif
> +
> +static void register_python_scripting(struct scripting_ops *scripting_op=
s)
> +{
> +       if (scripting_context =3D=3D NULL)
> +               scripting_context =3D malloc(sizeof(*scripting_context));
>
> +       if (scripting_context =3D=3D NULL ||
> +          script_spec_register("Python", scripting_ops) ||
> +          script_spec_register("py", scripting_ops)) {
> +               pr_err("Error registering Python script extension: disabl=
ing it\n");
> +               zfree(&scripting_context);
> +       }
> +}
> +
> +#ifndef HAVE_LIBPYTHON_SUPPORT
>  static void print_python_unsupported_msg(void)
>  {
>         fprintf(stderr, "Python scripting not supported."
> @@ -169,32 +185,18 @@ static int python_generate_script_unsupported(struc=
t tep_handle *pevent
>         return -1;
>  }
>
> -struct scripting_ops python_scripting_unsupported_ops =3D {
> -       .name =3D "Python",
> -       .dirname =3D "python",
> -       .start_script =3D python_start_script_unsupported,
> -       .flush_script =3D flush_script_unsupported,
> -       .stop_script =3D stop_script_unsupported,
> -       .process_event =3D process_event_unsupported,
> -       .generate_script =3D python_generate_script_unsupported,
> -};
> -
> -static void register_python_scripting(struct scripting_ops *scripting_op=
s)
> -{
> -       if (scripting_context =3D=3D NULL)
> -               scripting_context =3D malloc(sizeof(*scripting_context));
> -
> -       if (scripting_context =3D=3D NULL ||
> -          script_spec_register("Python", scripting_ops) ||
> -          script_spec_register("py", scripting_ops)) {
> -               pr_err("Error registering Python script extension: disabl=
ing it\n");
> -               zfree(&scripting_context);
> -       }
> -}
> -
> -#ifndef HAVE_LIBPYTHON_SUPPORT
>  void setup_python_scripting(void)
>  {
> +       static struct scripting_ops python_scripting_unsupported_ops =3D =
{
> +               .name =3D "Python",
> +               .dirname =3D "python",
> +               .start_script =3D python_start_script_unsupported,
> +               .flush_script =3D flush_script_unsupported,
> +               .stop_script =3D stop_script_unsupported,
> +               .process_event =3D process_event_unsupported,
> +               .generate_script =3D python_generate_script_unsupported,
> +       };
> +
>         register_python_scripting(&python_scripting_unsupported_ops);
>  }
>  #else
> @@ -207,6 +209,20 @@ void setup_python_scripting(void)
>  #endif
>
>  #ifdef HAVE_LIBTRACEEVENT
> +static void register_perl_scripting(struct scripting_ops *scripting_ops)
> +{
> +       if (scripting_context =3D=3D NULL)
> +               scripting_context =3D malloc(sizeof(*scripting_context));
> +
> +       if (scripting_context =3D=3D NULL ||
> +          script_spec_register("Perl", scripting_ops) ||
> +          script_spec_register("pl", scripting_ops)) {
> +               pr_err("Error registering Perl script extension: disablin=
g it\n");
> +               zfree(&scripting_context);
> +       }
> +}
> +
> +#ifndef HAVE_LIBPERL_SUPPORT
>  static void print_perl_unsupported_msg(void)
>  {
>         fprintf(stderr, "Perl scripting not supported."
> @@ -235,32 +251,18 @@ static int perl_generate_script_unsupported(struct =
tep_handle *pevent
>         return -1;
>  }
>
> -struct scripting_ops perl_scripting_unsupported_ops =3D {
> -       .name =3D "Perl",
> -       .dirname =3D "perl",
> -       .start_script =3D perl_start_script_unsupported,
> -       .flush_script =3D flush_script_unsupported,
> -       .stop_script =3D stop_script_unsupported,
> -       .process_event =3D process_event_unsupported,
> -       .generate_script =3D perl_generate_script_unsupported,
> -};
> -
> -static void register_perl_scripting(struct scripting_ops *scripting_ops)
> -{
> -       if (scripting_context =3D=3D NULL)
> -               scripting_context =3D malloc(sizeof(*scripting_context));
> -
> -       if (scripting_context =3D=3D NULL ||
> -          script_spec_register("Perl", scripting_ops) ||
> -          script_spec_register("pl", scripting_ops)) {
> -               pr_err("Error registering Perl script extension: disablin=
g it\n");
> -               zfree(&scripting_context);
> -       }
> -}
> -
> -#ifndef HAVE_LIBPERL_SUPPORT
>  void setup_perl_scripting(void)
>  {
> +       static struct scripting_ops perl_scripting_unsupported_ops =3D {
> +               .name =3D "Perl",
> +               .dirname =3D "perl",
> +               .start_script =3D perl_start_script_unsupported,
> +               .flush_script =3D flush_script_unsupported,
> +               .stop_script =3D stop_script_unsupported,
> +               .process_event =3D process_event_unsupported,
> +               .generate_script =3D perl_generate_script_unsupported,
> +       };
> +
>         register_perl_scripting(&perl_scripting_unsupported_ops);
>  }
>  #else
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 8b893de35f777db0..c5fee8e394805544 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -77,8 +77,6 @@ bool sysctl__nmi_watchdog_enabled(void)
>         return nmi_watchdog;
>  }
>
> -bool test_attr__enabled;
> -
>  bool exclude_GH_default;
>
>  bool perf_host  =3D true;
> --
> 2.53.0
>
