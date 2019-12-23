From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf v3] libbpf: Fix build on read-only filesystems
Date: Sun, 22 Dec 2019 22:29:07 -0800
Message-ID: <CAEf4BzY1HvhkPzR1HE7-reGhfZnfySe-LxQ-5MS7Nx-Uv4oVug@mail.gmail.com>
References: <CAM9d7ch1=pmgkFbgGr2YignQwdNjke2QeOAFLCFYu8L8J-Z8vw@mail.gmail.com>
 <20191223061326.843366-1-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191223061326.843366-1-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andriin@fb.com>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Sun, Dec 22, 2019 at 10:14 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> I got the following error when I tried to build perf on a read-only
> filesystem with O=dir option.
>
>   $ cd /some/where/ro/linux/tools/perf
>   $ make O=$HOME/build/perf
>   ...
>     CC       /home/namhyung/build/perf/lib.o
>   /bin/sh: bpf_helper_defs.h: Read-only file system
>   make[3]: *** [Makefile:184: bpf_helper_defs.h] Error 1
>   make[2]: *** [Makefile.perf:778: /home/namhyung/build/perf/libbpf.a] Error 2
>   make[2]: *** Waiting for unfinished jobs....
>     LD       /home/namhyung/build/perf/libperf-in.o
>     AR       /home/namhyung/build/perf/libperf.a
>     PERF_VERSION = 5.4.0
>   make[1]: *** [Makefile.perf:225: sub-make] Error 2
>   make: *** [Makefile:70: all] Error 2
>
> It was becaused bpf_helper_defs.h was generated in current directory.
> Move it to OUTPUT directory.
>
> Tested-by: Andrii Nakryiko <andriin@fb.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/bpf/Makefile                 | 15 ++++++++-------
>  tools/testing/selftests/bpf/.gitignore |  1 +
>  tools/testing/selftests/bpf/Makefile   |  6 +++---
>  3 files changed, 12 insertions(+), 10 deletions(-)
>

[...]

> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 419652458da4..1ff0a9f49c01 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -40,3 +40,4 @@ xdping
>  test_cpp
>  /no_alu32
>  /bpf_gcc
> +bpf_helper_defs.h

looks good, thanks!

[...]
