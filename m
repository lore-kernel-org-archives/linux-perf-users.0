From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] libbpf: Use PRIu64 for sym->st_value to fix build on
 32-bit arches
Date: Tue, 3 Dec 2019 19:20:08 +0530
Message-ID: <CA+G9fYsK8zn3jqF=Wz6=8BBx4i1JTkv2h-LCbjE11UJkcz_NEA@mail.gmail.com>
References: <20191126183451.GC29071@kernel.org> <87d0dexyij.fsf@toke.dk>
 <20191126190450.GD29071@kernel.org> <CAEf4Bzbq3J9g7cP=KMqR=bMFcs=qPiNZwnkvCKz3-SAp_m0GzA@mail.gmail.com>
 <20191126221018.GA22719@kernel.org> <20191126221733.GB22719@kernel.org>
 <CAEf4BzbZLiJnUb+BdUMEwcgcKCjJBWx1895p8qS8rK2r5TYu3w@mail.gmail.com>
 <20191126231030.GE3145429@mini-arch.hsd1.ca.comcast.net> <20191126155228.0e6ed54c@cakuba.netronome.com>
 <20191127013901.GE29071@kernel.org> <20191127134553.GC22719@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191127134553.GC22719@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, Stanislav Fomichev <sdf@fomichev.me>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, Andrii Nakryiko <andriin@fb.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Quentin Monnet <quentin.monnet@netronome.com>, Leo Yan <leo.yan@linaro.org>
List-Id: linux-perf-users.vger.kernel.org

Hi Arnaldo,

FYI,

On Wed, 27 Nov 2019 at 19:15, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Another fix I'm carrying in my perf/core branch,
>
> Regards,
>
> - Arnaldo
>
> commit 98bb09f90a0ae33125fabc8f41529345382f1498
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Wed Nov 27 09:26:54 2019 -0300
>
>     libbpf: Use PRIu64 for sym->st_value to fix build on 32-bit arches
>
>     The st_value field is a 64-bit value, so use PRIu64 to fix this error on
>     32-bit arches:
>
>       In file included from libbpf.c:52:
>       libbpf.c: In function 'bpf_program__record_reloc':
>       libbpf_internal.h:59:22: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'Elf64_Addr' {aka 'const long long unsigned int'} [-Werror=format=]
>         libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__); \
>                             ^~~~~~~~~~
>       libbpf_internal.h:62:27: note: in expansion of macro '__pr'
>        #define pr_warn(fmt, ...) __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
>                                  ^~~~
>       libbpf.c:1822:4: note: in expansion of macro 'pr_warn'
>           pr_warn("bad call relo offset: %lu\n", sym->st_value);
>           ^~~~~~~
>       libbpf.c:1822:37: note: format string is defined here
>           pr_warn("bad call relo offset: %lu\n", sym->st_value);
>                                          ~~^
>                                          %llu

This build error is been noticed on Linux mainline kernel for 32-bit
architectures from Nov 26.

Full build log,
https://ci.linaro.org/job/openembedded-lkft-linux-mainline/DISTRO=lkft,MACHINE=intel-core2-32,label=docker-lkft/2297/consoleText
https://ci.linaro.org/job/openembedded-lkft-linux-mainline/

- Naresh
