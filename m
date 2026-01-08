Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB6326928
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767900995; cv=pass; b=aZPVCVJU8YW+X1ga4iJdOlT0iABx+utPNMYJ5pzc3ExIQzmML6qRhFAw+1FZkli4JUpZEeLnLoGTVOC52ETVaClGnc7vJVRT2uwRXySLX55QHMsJD0WvQcrdq+F5eor+eA+AqYGLILAI+CPTbJilgnJEVLxH90IpkESdT2q6iDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767900995; c=relaxed/simple;
	bh=Bfy/vuPZtfYzmdmHSIAdjjqRhRqgEC8C6/HTUaVYLww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GxxKUPpNmbF2MSS06etxjd3s6kBeUsm8p0BW9JNvfjfYwzjEHWRl8U50b1kEC6dv26zlEz/UX0gx1kwCgoy0MpJC/jTj7YLV6iiZDVHMN3Y9VLRcV9RhJaiWuI7XUMMV47vwmnJAPBSZLp2Eh9iPmi67Q6312gkFrCtLu6Wmidw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGtVDJMC; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGtVDJMC"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0d06cfa93so13145ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:36:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767900992; cv=none;
        d=google.com; s=arc-20240605;
        b=RohZSJ1d3GG+W/n2C/E6s3etWqQ8u2yQYV1YYUqHMl2EUL4ijl8Ip2YOvoBsfMBru5
         5YS5tEt58knoditdh/ApiMNil0j2O39HDa3caQktoFmYP95EXDrrYr13gYLuGb5yYPFT
         qCMF2BUysItDPOceYT0EAFHkkFKQUnmt6L2dd+Z3oOd6Tr+YMgy1gAquYlz56wXS2VuH
         GhpsmUnJGc+7SQmTV6VvzknDahbo652HIhdw8ZFQ7jcz5MavBzSwQuIQFcDt/ccLncrD
         LJReWwpkBF25tb8e24RXMdGs/pb4Kh09mGKna6OyKAxUSO/wSAoUfr5bppiyZzuVFOoV
         /oqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jUH1oDZ0XPwqH3MFK/1WRJRm1PV/bnqIdFcrfAiVSVo=;
        fh=PWyEMi7IlLvz+39DY8C+O1uquqJS/tIqStPDLyv268s=;
        b=Y/k3EgIPFUPgfUl5zHZ613QmjqBhx1vRayj5Ipk+GzqafT50lsIWn0NKoVkUVB2VU1
         /4gRRT31M3w0OuV+M2jPe9W5CwPbQ9ioxfAa0ua/PnEfBurK1sL9sx4hauIoGM9IYJOW
         jqaXbdoC1/paSxoeWf/u7oWFApPVHUbwwRj5JgTgWiSi39hi8oS3Hb7GSvtO3Pcltcm6
         CsmHjnDmTQRT1afcKwvXKE6tXIK51Y8gewNg+SKhEyqdbPXchNgfSefglaUrl3kWfDCN
         RRCiYY7DRL6oUgTKWrX1xL84aoMR+vfCt76wMI404QYsOhti8JyQEUVlioO+6+u8ialq
         uSLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767900992; x=1768505792; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUH1oDZ0XPwqH3MFK/1WRJRm1PV/bnqIdFcrfAiVSVo=;
        b=fGtVDJMCj9xC4EhHC9MJngMzyxy8jtUbIjZTvFUVGKEcfQCbMlYfKdy5hJFq7ScUMC
         x1rry0gUXHCpQqqCPFgRuY0xTyZDKb0yveoVYAnrHvATeVMT5bzCltGVN2x2VcBALpJp
         EAyviUwlLNLHgFAs1KFGSK6jlEircilQO85MnZevftKUeqfVoEGECH6EFall3cYLWJDO
         O+8UXsnK4DeGB0a+0hbe5yJuNe7meXUDM7g06v1HGpkEGVaty+7OU+y6cnTF9era/ynL
         k3adyT1oExyaxeCwHcmZA7wxB5l1B81MLzDAaNJDqqyXZF9Prt4tTX0ROs8sllb9KFgH
         gQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767900992; x=1768505792;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUH1oDZ0XPwqH3MFK/1WRJRm1PV/bnqIdFcrfAiVSVo=;
        b=wQbU27ab3IVMfoVfhvmJLzchzPqVKDWuwPEUMUi/SsCqV5iNhJOl7PJtIpMN5OOxau
         1K2Rpi9kIW8bUaGgyp7yxKJStwNwOEz3ZwMTK8fEpbJ9DOx4lnytyUz9/EZSz0pye0iH
         LgTgnG6aC6wJIy1zlSFOxtH9731qTKQj2BtajRayGnaGYDmV6T31enQ0BN2C++TteBP2
         DBIVb5FJVp6WwwDs2enB57XolnqcBA2JEVfQDeZUkvN3kuIcgk7ylnDVz3/s40feUc7h
         z9L7Z8I5JlQ7SR9N2FdxJKrA5w8bbDFmXRc35coKK12QqeIUpnraW+y/X2SAI1TXLNG7
         aMsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy5eSntL+IRmY/ckue3yYd8YD5pjObw/pPT9KnKyhjP1f36zwxcyAdx5hshFBMoJJ/SSWVozNUlB0fr5Z4EA6F@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/kNi198yjjCOEe5wpfitreR7HTCuTftKSdL3Gb+xWoc8EWy8
	7TGTjKaTn1vcq9unfg2Jl/DCllhzA5CJOL14x0E0bcSFIbWgjkcPd/0IFhH2+7TLofc6mW6JRy5
	IMzj2wR0sTDwiNDethSkwQfGTLDLs+8ZBju40pX3M
X-Gm-Gg: AY/fxX7mwOogSuZmpEcy5Z2pUo0ZgX7NMFFNpDwOsEaEWQch2S0qyxf2LxyEByYzKAM
	inS6KsNNzKcnkytijbovLa9st+Ien6QQFXnsC7cKV7JxZhF1LnewGdrLd4a4BRiSod+yQzMzGDN
	hlrSgyXKJUofACtJcFFq9D11B9LOi3tsSC3wTvMx5u7tB5psmgpgeW7n9xvLfjCr3Jp/Rux6S4f
	2hkpWh2y2DLL04d6n5s8zCL/YMcdQAeibYM6e37JMPVPyVB6zXQBeS5+kJB2oJqweLXqovbwLQK
	EerowHMM6EHYC6lIh3WjIXgnMo4s2Y1xkmuq
X-Received: by 2002:a17:902:ecd0:b0:290:dd42:eb5f with SMTP id
 d9443c01a7336-2a409ab0b0cmr475925ad.12.1767900991059; Thu, 08 Jan 2026
 11:36:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204214235.589865-1-irogers@google.com>
In-Reply-To: <20251204214235.589865-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Jan 2026 11:36:18 -0800
X-Gm-Features: AQt7F2pYwfX-DOAL-8yYNOZEmu4-8XiIoM7oQBopz4AZNsNM2UAZi-vg6luNGF0
Message-ID: <CAP-5=fVSDb-Vn6Vupjh_FB0VVLp0khj7DHY1hhxkng4KC6FTCQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf: Make more global variables static
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Guo Ren <guoren@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 1:43=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> `make check` will run sparse on the perf code base. A frequent warning
> is "warning: symbol '...' was not declared. Should it be static?" Go
> through and make global definitions without declarations static. In
> some cases it is deliberate due to dlsym accessing the symbol, this
> change doesn't clean up the missing declarations for perf test
> suites. Sometimes things can opportunistically be made const. Making
> somethings static exposed unused functions warnings, so restructuring
> of ifdefs was necessary for that. These changes reduce the size of the
> perf binary by 3,264 bytes.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

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
>  tools/perf/perf.c                             |   4 +-
>  tools/perf/tests/bp_signal.c                  |   2 +-
>  tools/perf/tests/dso-data.c                   |   2 +-
>  tools/perf/tests/wp.c                         |   6 +-
>  tools/perf/util/block-range.c                 |   2 +-
>  tools/perf/util/bpf_counter.c                 |   4 +-
>  tools/perf/util/bpf_off_cpu.c                 |   2 +-
>  tools/perf/util/debug.c                       |   2 +-
>  tools/perf/util/debuginfo.c                   |  19 ++--
>  tools/perf/util/dwarf-regs-csky.c             |   4 +-
>  tools/perf/util/sort.c                        | 104 +++++++++---------
>  tools/perf/util/trace-event-scripting.c       |  98 +++++++++--------
>  tools/perf/util/util.c                        |   2 -
>  27 files changed, 163 insertions(+), 164 deletions(-)
>
> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index 4908d54dd33b..21836f70f231 100644
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
> index 900e69619970..b5974a090fb4 100644
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
> index dfd18f5db97d..1b7cd4481bd2 100644
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
> index 2908a3a796c9..c1a84be1c50b 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -388,7 +388,7 @@ static void mem_free(struct bench_mem_info *info __ma=
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
> index 19be2aaf4dc0..6588a9b0b15a 100644
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
> index 0b90275862e1..99c3f9d2f28d 100644
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
> index 14c3823f8fed..348c69224a91 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2900,9 +2900,10 @@ static int ui_quirks(void)
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
> index 45b5312fbe83..237600643bbd 100644
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
> index ce51cbf6dc97..638b67f7c1d8 100644
> --- a/tools/perf/builtin-data.c
> +++ b/tools/perf/builtin-data.c
> @@ -28,14 +28,14 @@ static const char *data_usage[] =3D {
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
> index 53d5ea4a6a4f..41a40d94b053 100644
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
> @@ -384,7 +384,7 @@ static void block_hist_free(void *he)
>         free(bh);
>  }
>
> -struct hist_entry_ops block_hist_ops =3D {
> +static struct hist_entry_ops block_hist_ops =3D {
>         .new    =3D block_hist_zalloc,
>         .free   =3D block_hist_free,
>  };
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 7929a5fa5f46..9c64a0d74823 100644
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
> index 7f3068264568..97be06ba3ad9 100644
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
> index 62e43d3c5ad7..6b7985121ec9 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -168,7 +168,7 @@ struct perf_script {
>         int                     range_num;
>  };
>
> -struct output_option {
> +static struct output_option {
>         const char *str;
>         enum perf_output_field field;
>  } all_output_options[] =3D {
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 710604c4f6f6..0628e5f2023c 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1437,11 +1437,10 @@ parse_percent_limit(const struct option *opt, con=
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
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 88c60ecf3395..318455d7b4d4 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -178,7 +178,7 @@ static int set_debug_file(const char *path)
>         return 0;
>  }
>
> -struct option options[] =3D {
> +static const struct option options[] =3D {
>         OPT_ARGUMENT("help", "help"),
>         OPT_ARGUMENT("version", "version"),
>         OPT_ARGUMENT("exec-path", "exec-path"),
> @@ -289,7 +289,7 @@ static int handle_options(const char ***argv, int *ar=
gc, int *envchanged)
>                         unsigned int i;
>
>                         for (i =3D 0; i < ARRAY_SIZE(options)-1; i++) {
> -                               struct option *p =3D options+i;
> +                               const struct option *p =3D options+i;
>                                 printf("--%s ", p->long_name);
>                         }
>                         putchar('\n');
> diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> index 3faeb5b6fe0b..f580ba7486b1 100644
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
> index a1fff4203b75..46bc3f597260 100644
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
> index 6c178985e37f..69b31f00eed0 100644
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
> index 15c42196c24c..7c559fcfd7e0 100644
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
> index a5882b582205..32455dc42498 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -351,7 +351,7 @@ static int bpf_program_profiler__install_pe(struct ev=
sel *evsel, int cpu_map_idx
>         return 0;
>  }
>
> -struct bpf_counter_ops bpf_program_profiler_ops =3D {
> +static struct bpf_counter_ops bpf_program_profiler_ops =3D {
>         .load       =3D bpf_program_profiler__load,
>         .enable     =3D bpf_program_profiler__enable,
>         .disable    =3D bpf_program_profiler__disable,
> @@ -831,7 +831,7 @@ static int bperf__destroy(struct evsel *evsel)
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
> index 88e0660c4bff..eaff3c0bd9dd 100644
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
> index 1dfa4d0eec4d..6b5ffe81f141 100644
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
> index 4a559b3e8cdc..8b819dea36ac 100644
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
> diff --git a/tools/perf/util/dwarf-regs-csky.c b/tools/perf/util/dwarf-re=
gs-csky.c
> index d38ef1f07f3e..f6645cf770db 100644
> --- a/tools/perf/util/dwarf-regs-csky.c
> +++ b/tools/perf/util/dwarf-regs-csky.c
> @@ -6,7 +6,7 @@
>  #include <dwarf-regs.h>
>
>  #define CSKY_ABIV2_MAX_REGS 73
> -const char *csky_dwarf_regs_table_abiv2[CSKY_ABIV2_MAX_REGS] =3D {
> +static const char *csky_dwarf_regs_table_abiv2[CSKY_ABIV2_MAX_REGS] =3D =
{
>         /* r0 ~ r8 */
>         "%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1", "%regs2", "%regs3=
",
>         /* r9 ~ r15 */
> @@ -27,7 +27,7 @@ const char *csky_dwarf_regs_table_abiv2[CSKY_ABIV2_MAX_=
REGS] =3D {
>  };
>
>  #define CSKY_ABIV1_MAX_REGS 57
> -const char *csky_dwarf_regs_table_abiv1[CSKY_ABIV1_MAX_REGS] =3D {
> +static const char *csky_dwarf_regs_table_abiv1[CSKY_ABIV1_MAX_REGS] =3D =
{
>         /* r0 ~ r8 */
>         "%sp", "%regs9", "%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1",
>         /* r9 ~ r15 */
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index f3a565b0e230..2fa2b11c655c 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -42,11 +42,11 @@ regex_t             parent_regex;
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
> @@ -171,7 +171,7 @@ static int hist_entry__tgid_snprintf(struct hist_entr=
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
> @@ -217,7 +217,7 @@ static int hist_entry__simd_snprintf(struct hist_entr=
y *he, char *bf,
>         return repsep_snprintf(bf, size, "[.] %s", name);
>  }
>
> -struct sort_entry sort_simd =3D {
> +static struct sort_entry sort_simd =3D {
>         .se_header      =3D "Simd   ",
>         .se_cmp         =3D sort__simd_cmp,
>         .se_snprintf    =3D hist_entry__simd_snprintf,
> @@ -494,7 +494,7 @@ hist_entry__symoff_snprintf(struct hist_entry *he, ch=
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
> @@ -605,7 +605,7 @@ static int hist_entry__srcline_from_snprintf(struct h=
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
> @@ -653,7 +653,7 @@ static int hist_entry__srcline_to_snprintf(struct his=
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
> @@ -689,7 +689,7 @@ static int hist_entry__sym_ipc_snprintf(struct hist_e=
ntry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*s", width, tmp);
>  }
>
> -struct sort_entry sort_sym_ipc =3D {
> +static struct sort_entry sort_sym_ipc =3D {
>         .se_header      =3D "IPC   [IPC Coverage]",
>         .se_cmp         =3D sort__sym_cmp,
>         .se_snprintf    =3D hist_entry__sym_ipc_snprintf,
> @@ -707,7 +707,7 @@ static int hist_entry__sym_ipc_null_snprintf(struct h=
ist_entry *he
>         return repsep_snprintf(bf, size, "%-*s", width, tmp);
>  }
>
> -struct sort_entry sort_sym_ipc_null =3D {
> +static struct sort_entry sort_sym_ipc_null =3D {
>         .se_header      =3D "IPC   [IPC Coverage]",
>         .se_cmp         =3D sort__sym_cmp,
>         .se_snprintf    =3D hist_entry__sym_ipc_null_snprintf,
> @@ -740,7 +740,7 @@ static int hist_entry__callchain_branch_predicted_snp=
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
> @@ -770,7 +770,7 @@ static int hist_entry__callchain_branch_abort_snprint=
f(struct hist_entry *he,
>         return repsep_snprintf(bf, size, "%-*.*s", width, width, str);
>  }
>
> -struct sort_entry sort_callchain_branch_abort =3D {
> +static struct sort_entry sort_callchain_branch_abort =3D {
>         .se_header      =3D "Abort",
>         .se_cmp         =3D sort__callchain_branch_abort_cmp,
>         .se_snprintf    =3D hist_entry__callchain_branch_abort_snprintf,
> @@ -803,7 +803,7 @@ static int hist_entry__callchain_branch_cycles_snprin=
tf(struct hist_entry *he,
>         return repsep_snprintf(bf, size, "%-*.*s", width, width, str);
>  }
>
> -struct sort_entry sort_callchain_branch_cycles =3D {
> +static struct sort_entry sort_callchain_branch_cycles =3D {
>         .se_header      =3D "Cycles",
>         .se_cmp         =3D sort__callchain_branch_cycles_cmp,
>         .se_snprintf    =3D hist_entry__callchain_branch_cycles_snprintf,
> @@ -870,7 +870,7 @@ static int hist_entry__srcfile_snprintf(struct hist_e=
ntry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-.*s", width, he->srcfile);
>  }
>
> -struct sort_entry sort_srcfile =3D {
> +static struct sort_entry sort_srcfile =3D {
>         .se_header      =3D "Source File",
>         .se_cmp         =3D sort__srcfile_cmp,
>         .se_collapse    =3D sort__srcfile_collapse,
> @@ -922,7 +922,7 @@ static int hist_entry__cpu_snprintf(struct hist_entry=
 *he, char *bf,
>         return repsep_snprintf(bf, size, "%*.*d", width, width, he->cpu);
>  }
>
> -struct sort_entry sort_cpu =3D {
> +static struct sort_entry sort_cpu =3D {
>         .se_header      =3D "CPU",
>         .se_cmp         =3D sort__cpu_cmp,
>         .se_snprintf    =3D hist_entry__cpu_snprintf,
> @@ -953,7 +953,7 @@ static int hist_entry__parallelism_snprintf(struct hi=
st_entry *he, char *bf,
>         return repsep_snprintf(bf, size, "%*d", width, he->parallelism);
>  }
>
> -struct sort_entry sort_parallelism =3D {
> +static struct sort_entry sort_parallelism =3D {
>         .se_header      =3D "Parallelism",
>         .se_cmp         =3D sort__parallelism_cmp,
>         .se_filter      =3D hist_entry__parallelism_filter,
> @@ -994,7 +994,7 @@ static int hist_entry__cgroup_id_snprintf(struct hist=
_entry *he,
>                                he->cgroup_id.ino);
>  }
>
> -struct sort_entry sort_cgroup_id =3D {
> +static struct sort_entry sort_cgroup_id =3D {
>         .se_header      =3D "cgroup id (dev/inode)",
>         .se_cmp         =3D sort__cgroup_id_cmp,
>         .se_snprintf    =3D hist_entry__cgroup_id_snprintf,
> @@ -1027,7 +1027,7 @@ static int hist_entry__cgroup_snprintf(struct hist_=
entry *he,
>         return repsep_snprintf(bf, size, "%s", cgrp_name);
>  }
>
> -struct sort_entry sort_cgroup =3D {
> +static struct sort_entry sort_cgroup =3D {
>         .se_header      =3D "Cgroup",
>         .se_cmp         =3D sort__cgroup_cmp,
>         .se_snprintf    =3D hist_entry__cgroup_snprintf,
> @@ -1058,7 +1058,7 @@ static int hist_entry__socket_filter(struct hist_en=
try *he, int type, const void
>         return sk >=3D 0 && he->socket !=3D sk;
>  }
>
> -struct sort_entry sort_socket =3D {
> +static struct sort_entry sort_socket =3D {
>         .se_header      =3D "Socket",
>         .se_cmp         =3D sort__socket_cmp,
>         .se_snprintf    =3D hist_entry__socket_snprintf,
> @@ -1089,7 +1089,7 @@ static int hist_entry__time_snprintf(struct hist_en=
try *he, char *bf,
>         return repsep_snprintf(bf, size, "%-.*s", width, he_time);
>  }
>
> -struct sort_entry sort_time =3D {
> +static struct sort_entry sort_time =3D {
>         .se_header      =3D "Time",
>         .se_cmp         =3D sort__time_cmp,
>         .se_snprintf    =3D hist_entry__time_snprintf,
> @@ -1158,7 +1158,7 @@ static int hist_entry__trace_snprintf(struct hist_e=
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
> @@ -1453,7 +1453,7 @@ sort__addr_to_cmp(struct hist_entry *left, struct h=
ist_entry *right)
>         return _sort__addr_cmp(to_l->addr, to_r->addr);
>  }
>
> -struct sort_entry sort_addr_from =3D {
> +static struct sort_entry sort_addr_from =3D {
>         .se_header      =3D "Source Address",
>         .se_cmp         =3D sort__addr_from_cmp,
>         .se_snprintf    =3D hist_entry__addr_from_snprintf,
> @@ -1461,7 +1461,7 @@ struct sort_entry sort_addr_from =3D {
>         .se_width_idx   =3D HISTC_ADDR_FROM,
>  };
>
> -struct sort_entry sort_addr_to =3D {
> +static struct sort_entry sort_addr_to =3D {
>         .se_header      =3D "Target Address",
>         .se_cmp         =3D sort__addr_to_cmp,
>         .se_snprintf    =3D hist_entry__addr_to_snprintf,
> @@ -1518,7 +1518,7 @@ static int hist_entry__cycles_snprintf(struct hist_=
entry *he, char *bf,
>                                he->branch_info->flags.cycles);
>  }
>
> -struct sort_entry sort_cycles =3D {
> +static struct sort_entry sort_cycles =3D {
>         .se_header      =3D "Basic Block Cycles",
>         .se_cmp         =3D sort__cycles_cmp,
>         .se_snprintf    =3D hist_entry__cycles_snprintf,
> @@ -1808,7 +1808,7 @@ static int hist_entry__dcacheline_snprintf(struct h=
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
> @@ -1827,7 +1827,7 @@ static int hist_entry__local_weight_snprintf(struct=
 hist_entry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*llu", width, he->weight);
>  }
>
> -struct sort_entry sort_local_weight =3D {
> +static struct sort_entry sort_local_weight =3D {
>         .se_header      =3D "Local Weight",
>         .se_cmp         =3D sort__weight_cmp,
>         .se_snprintf    =3D hist_entry__local_weight_snprintf,
> @@ -1841,7 +1841,7 @@ static int hist_entry__global_weight_snprintf(struc=
t hist_entry *he, char *bf,
>                                he->weight * he->stat.nr_events);
>  }
>
> -struct sort_entry sort_global_weight =3D {
> +static struct sort_entry sort_global_weight =3D {
>         .se_header      =3D "Weight",
>         .se_cmp         =3D sort__weight_cmp,
>         .se_snprintf    =3D hist_entry__global_weight_snprintf,
> @@ -1860,7 +1860,7 @@ static int hist_entry__local_ins_lat_snprintf(struc=
t hist_entry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*u", width, he->ins_lat);
>  }
>
> -struct sort_entry sort_local_ins_lat =3D {
> +static struct sort_entry sort_local_ins_lat =3D {
>         .se_header      =3D "Local INSTR Latency",
>         .se_cmp         =3D sort__ins_lat_cmp,
>         .se_snprintf    =3D hist_entry__local_ins_lat_snprintf,
> @@ -1874,7 +1874,7 @@ static int hist_entry__global_ins_lat_snprintf(stru=
ct hist_entry *he, char *bf,
>                                he->ins_lat * he->stat.nr_events);
>  }
>
> -struct sort_entry sort_global_ins_lat =3D {
> +static struct sort_entry sort_global_ins_lat =3D {
>         .se_header      =3D "INSTR Latency",
>         .se_cmp         =3D sort__ins_lat_cmp,
>         .se_snprintf    =3D hist_entry__global_ins_lat_snprintf,
> @@ -1900,70 +1900,70 @@ static int hist_entry__p_stage_cyc_snprintf(struc=
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
> @@ -1998,7 +1998,7 @@ static int hist_entry__blocked_snprintf(struct hist=
_entry *he, char *bf,
>         return repsep_snprintf(bf, size, "%.*s", width, out);
>  }
>
> -struct sort_entry sort_mem_blocked =3D {
> +static struct sort_entry sort_mem_blocked =3D {
>         .se_header      =3D "Blocked",
>         .se_cmp         =3D sort__blocked_cmp,
>         .se_snprintf    =3D hist_entry__blocked_snprintf,
> @@ -2039,7 +2039,7 @@ static int hist_entry__phys_daddr_snprintf(struct h=
ist_entry *he, char *bf,
>         return width;
>  }
>
> -struct sort_entry sort_mem_phys_daddr =3D {
> +static struct sort_entry sort_mem_phys_daddr =3D {
>         .se_header      =3D "Data Physical Address",
>         .se_cmp         =3D sort__phys_daddr_cmp,
>         .se_snprintf    =3D hist_entry__phys_daddr_snprintf,
> @@ -2068,7 +2068,7 @@ static int hist_entry__data_page_size_snprintf(stru=
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
> @@ -2093,7 +2093,7 @@ static int hist_entry__code_page_size_snprintf(stru=
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
> @@ -2125,7 +2125,7 @@ static int hist_entry__abort_snprintf(struct hist_e=
ntry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*s", width, out);
>  }
>
> -struct sort_entry sort_abort =3D {
> +static struct sort_entry sort_abort =3D {
>         .se_header      =3D "Transaction abort",
>         .se_cmp         =3D sort__abort_cmp,
>         .se_snprintf    =3D hist_entry__abort_snprintf,
> @@ -2157,7 +2157,7 @@ static int hist_entry__in_tx_snprintf(struct hist_e=
ntry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*s", width, out);
>  }
>
> -struct sort_entry sort_in_tx =3D {
> +static struct sort_entry sort_in_tx =3D {
>         .se_header      =3D "Branch in transaction",
>         .se_cmp         =3D sort__in_tx_cmp,
>         .se_snprintf    =3D hist_entry__in_tx_snprintf,
> @@ -2229,7 +2229,7 @@ static int hist_entry__transaction_snprintf(struct =
hist_entry *he, char *bf,
>         return repsep_snprintf(bf, size, "%-*s", width, buf);
>  }
>
> -struct sort_entry sort_transaction =3D {
> +static struct sort_entry sort_transaction =3D {
>         .se_header      =3D "Transaction                ",
>         .se_cmp         =3D sort__transaction_cmp,
>         .se_snprintf    =3D hist_entry__transaction_snprintf,
> @@ -2268,7 +2268,7 @@ static int hist_entry__sym_size_snprintf(struct his=
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
> @@ -2307,7 +2307,7 @@ static int hist_entry__dso_size_snprintf(struct his=
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
> @@ -2344,7 +2344,7 @@ static int hist_entry__addr_snprintf(struct hist_en=
try *he, char *bf,
>         return repsep_snprintf(bf, size, "%-#*llx", width, ip);
>  }
>
> -struct sort_entry sort_addr =3D {
> +static struct sort_entry sort_addr =3D {
>         .se_header      =3D "Address",
>         .se_cmp         =3D sort__addr_cmp,
>         .se_snprintf    =3D hist_entry__addr_snprintf,
> @@ -2462,7 +2462,7 @@ static int hist_entry__typeoff_snprintf(struct hist=
_entry *he, char *bf,
>                                he->mem_type_off, buf);
>  }
>
> -struct sort_entry sort_type_offset =3D {
> +static struct sort_entry sort_type_offset =3D {
>         .se_header      =3D "Data Type Offset",
>         .se_cmp         =3D sort__type_cmp,
>         .se_collapse    =3D sort__typeoff_sort,
> @@ -2513,7 +2513,7 @@ static int hist_entry__typecln_snprintf(struct hist=
_entry *he, char *bf,
>                                he->mem_type_off / TYPE_CACHELINE_SIZE);
>  }
>
> -struct sort_entry sort_type_cacheline =3D {
> +static struct sort_entry sort_type_cacheline =3D {
>         .se_header      =3D "Data Type Cacheline",
>         .se_cmp         =3D sort__type_cmp,
>         .se_collapse    =3D sort__typecln_sort,
> diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/tr=
ace-event-scripting.c
> index 72abb28b7b5a..7353af6148ea 100644
> --- a/tools/perf/util/trace-event-scripting.c
> +++ b/tools/perf/util/trace-event-scripting.c
> @@ -123,6 +123,7 @@ void scripting_context__update(struct scripting_conte=
xt *c,
>         c->addr_al =3D addr_al;
>  }
>
> +#if !defined(HAVE_LIBPERL_SUPPORT) || !defined(HAVE_LIBPYTHON_SUPPORT)
>  static int flush_script_unsupported(void)
>  {
>         return 0;
> @@ -140,7 +141,22 @@ static void process_event_unsupported(union perf_eve=
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
> @@ -170,32 +186,18 @@ static int python_generate_script_unsupported(struc=
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
> @@ -208,6 +210,20 @@ void setup_python_scripting(void)
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
> @@ -236,32 +252,18 @@ static int perl_generate_script_unsupported(struct =
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
> index 0f031eb80b4c..ce2c020247fd 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -76,8 +76,6 @@ bool sysctl__nmi_watchdog_enabled(void)
>         return nmi_watchdog;
>  }
>
> -bool test_attr__enabled;
> -
>  bool exclude_GH_default;
>
>  bool perf_host  =3D true;
> --
> 2.52.0.223.gf5cc29aaa4-goog
>
