Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B337167
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2023 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FlEijclt"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7915212A
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2023 08:00:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40853f2e93eso85215e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2023 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698418817; x=1699023617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=In2w2XAnYFFzI3oDxSHEa9Ny2CIQ+xaG4Im4ZzOyKqU=;
        b=FlEijcltFgz485hcnEWkN3Cg8cNf4sMAczZuzLyot9khuMVyNelf7XeAnvNGBQCrhu
         dbx4xpuXp84OlLwhlmtGbUo1p6qE6tReBVUAC7U0InY9AdqaLEH7BkQ3UAWgYmplZwzQ
         PTVj4jsv7vhqfSc2/lNF3111VaVkzjuJOdmSeX/c9ybCfV1XEKDD53lVRh7Lm9FadfuL
         7qjRFoMsCYIUOgfG+z1Pe1hR5rIgk2kGyFZ4jA1sZlQjjYp/XHv4MMTMB3G8ogXqcnRe
         UCHITDOq0QwNpz5iEyzmQZTGtEKMuma5+bdqL1OSEhZ3JeEtdYd1jMJIKofT0nWXCQMC
         tjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698418817; x=1699023617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=In2w2XAnYFFzI3oDxSHEa9Ny2CIQ+xaG4Im4ZzOyKqU=;
        b=F+GuzpfEw0SDGVvZE7duehdflfuEBoYdxf/7wMbTLfQ6F6903Z12wwvS5fMBvetVkp
         dT1HeED+9gAEdeTyTnY7sCxIgBptpD4UwhamK6BA0y4iSL8EyjnXWdgSbU9/qKXlmiW+
         gpNagz8nIbwyiZd7z+5h8vONuLVEM53DytCakRPE/7/3un7y2clO0K4gv2qb9IdUySbP
         Zb+zHuRZHQtztnDaE4wcm4e8BWzPdOLXx7UIlmLSXAPIPqzkBeH6ZKIAK6YpBRY/YKqS
         QTUFATk+WLUllsn2HfFDkEX8AC0A8yoeeT1bZuBlYDITWYFtD2sNgVQWGkUqBx2dn6ll
         BUCw==
X-Gm-Message-State: AOJu0Yw5zZ0+anjiSwarEeL10F5yn95zjEOoizwMUlhv+++5az5USkCo
	0e81iMmNtxQvwFEdcQBw/YpaDvqLjPyATmfFQW+51Q==
X-Google-Smtp-Source: AGHT+IHONKENQ9qinfgNvj/OXRTa77knD7izur4HaKYaTZhE3a13eoK1E1qDQ2pNsmFOX61jgM8j4IU+OTbtHanhvbU=
X-Received: by 2002:a05:600c:1d95:b0:3fe:e9ea:9653 with SMTP id
 p21-20020a05600c1d9500b003fee9ea9653mr114964wms.4.1698418816657; Fri, 27 Oct
 2023 08:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTvGx/Ou6BVnYBqi@kernel.org>
In-Reply-To: <ZTvGx/Ou6BVnYBqi@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 27 Oct 2023 08:00:05 -0700
Message-ID: <CAP-5=fUv2=hKHPEYsx9kmni=fsLu6-g5qjJgSCFxPnTqHVY4LQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: Disable BPF skeletons if clang version is
 < 12.0.1
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 7:18=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> While building on a wide range of distros and clang versions it was
> noticed that at least version 12.0.1 (noticed on Alpine 3.15 with
> "Alpine clang version 12.0.1") is needed to not fail with BTF generation
> errors such as:
>
> Debian:10
>
>   Debian clang version 11.0.1-2~deb10u1:
>
>     CLANG   /tmp/build/perf/util/bpf_skel/.tmp/sample_filter.bpf.o
>   <SNIP>
>     GENSKEL /tmp/build/perf/util/bpf_skel/sample_filter.skel.h
>   libbpf: failed to find BTF for extern 'bpf_cast_to_kern_ctx' [21] secti=
on: -2
>   Error: failed to open BPF object file: No such file or directory
>   make[2]: *** [Makefile.perf:1121: /tmp/build/perf/util/bpf_skel/sample_=
filter.skel.h] Error 254
>   make[2]: *** Deleting file '/tmp/build/perf/util/bpf_skel/sample_filter=
.skel.h'
>
> Amazon Linux 2:
>
>   clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
>
>     GENSKEL /tmp/build/perf/util/bpf_skel/sample_filter.skel.h
>   libbpf: elf: skipping unrecognized data section(18) .eh_frame
>   libbpf: elf: skipping relo section(19) .rel.eh_frame for section(18) .e=
h_frame
>   libbpf: failed to find BTF for extern 'bpf_cast_to_kern_ctx' [21] secti=
on: -2
>   Error: failed to open BPF object file: No such file or directory
>   make[2]: *** [/tmp/build/perf/util/bpf_skel/sample_filter.skel.h] Error=
 254
>   make[2]: *** Deleting file `/tmp/build/perf/util/bpf_skel/sample_filter=
.skel.h'
>
> Ubuntu 20.04:
>
>   clang version 10.0.0-4ubuntu1
>
>     CLANG   /tmp/build/perf/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf=
.o
>     GENSKEL /tmp/build/perf/util/bpf_skel/bench_uprobe.skel.h
>     GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
>   libbpf: sec '.reluprobe': corrupted symbol #27 pointing to invalid sect=
ion #65522 for relo #0
>     GENSKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
>   Error: failed to open BPF object file: BPF object format invalid
>   make[2]: *** [Makefile.perf:1121: /tmp/build/perf/util/bpf_skel/bench_u=
probe.skel.h] Error 95
>   make[2]: *** Deleting file '/tmp/build/perf/util/bpf_skel/bench_uprobe.=
skel.h'
>
> So check if the version is at least 12.0.1 otherwise disable building
> BPF skels and provide a message about it, continuing the build.
>
> The message, when running on amazonlinux:2:
>
>   Makefile.config:698: Warning: Disabled BPF skeletons as reliable BTF ge=
neration needs at least clang version 12.0.1
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.config | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 4300a9e4253a0c87..8b6cffbc485834c8 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -693,6 +693,13 @@ ifeq ($(BUILD_BPF_SKEL),1)
>      dummy :=3D $(warning Warning: Disabled BPF skeletons as clang ($(CLA=
NG)) is missing)
>      BUILD_BPF_SKEL :=3D 0
>    else
> +    CLANG_VERSION :=3D $(shell $(CLANG) --version | head -1 | sed 's/.*c=
lang version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
> +    ifeq ($(call version-lt3,$(CLANG_VERSION),12.0.1),1)
> +      dummy :=3D $(warning Warning: Disabled BPF skeletons as reliable B=
TF generation needs at least $(CLANG) version 12.0.1)
> +      BUILD_BPF_SKEL :=3D 0
> +    endif
> +  endif
> +  ifeq ($(BUILD_BPF_SKEL),1)
>      $(call feature_check,clang-bpf-co-re)
>      ifeq ($(feature-clang-bpf-co-re), 0)
>        dummy :=3D $(warning Warning: Disabled BPF skeletons as clang is t=
oo old)
> --
> 2.41.0
>
