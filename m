From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf] libbpf: Fix build on read-only filesystems
Date: Sun, 22 Dec 2019 21:54:47 -0800
Message-ID: <CAEf4BzbyBgDN5svEcfpyjoViixhn2iGBs1j+jyvNhfjPp_1E=w@mail.gmail.com>
References: <20191221162158.rw6xqqktubozg6fg@ast-mbp.dhcp.thefacebook.com>
 <20191223030530.725937-1-namhyung@kernel.org> <CAEf4BzaGfsF352kWu1zZe+yXSRm4c9LQ0U57VnRq2EdtjeQutw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEf4BzaGfsF352kWu1zZe+yXSRm4c9LQ0U57VnRq2EdtjeQutw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Sun, Dec 22, 2019 at 9:45 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Dec 22, 2019 at 7:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I got the following error when I tried to build perf on a read-only
> > filesystem with O=dir option.
> >
> >   $ cd /some/where/ro/linux/tools/perf
> >   $ make O=$HOME/build/perf
> >   ...
> >     CC       /home/namhyung/build/perf/lib.o
> >   /bin/sh: bpf_helper_defs.h: Read-only file system
> >   make[3]: *** [Makefile:184: bpf_helper_defs.h] Error 1
> >   make[2]: *** [Makefile.perf:778: /home/namhyung/build/perf/libbpf.a] Error 2
> >   make[2]: *** Waiting for unfinished jobs....
> >     LD       /home/namhyung/build/perf/libperf-in.o
> >     AR       /home/namhyung/build/perf/libperf.a
> >     PERF_VERSION = 5.4.0
> >   make[1]: *** [Makefile.perf:225: sub-make] Error 2
> >   make: *** [Makefile:70: all] Error 2
> >
> > It was becaused bpf_helper_defs.h was generated in current directory.
> > Move it to OUTPUT directory.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
>
> Looks good, thanks!

just one minor thing: bpf_helper_defs.h has to be added to .gitignore
under selftests/bpf now

>
> Tested-by: Andrii Nakryiko <andriin@fb.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
>
> >  tools/lib/bpf/Makefile               | 15 ++++++++-------
> >  tools/testing/selftests/bpf/Makefile |  6 +++---
> >  2 files changed, 11 insertions(+), 10 deletions(-)
> >
>
> [...]
