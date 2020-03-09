From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 3/6] perf python: Fix clang detection when using CC=clang-version
Date: Mon, 9 Mar 2020 11:58:33 -0700
Message-ID: <CAKwvOdm5RrdpOCMgRezLeHJ9GuocVoKqSUQGHjaCEcZdSr4AwA@mail.gmail.com>
References: <20200309185323.22583-1-acme@kernel.org> <20200309185323.22583-4-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200309185323.22583-4-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Ilie Halip <ilie.halip@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Igor Lubashev <ilubashe@akamai.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 9, 2020 at 11:53 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Ilie Halip <ilie.halip@gmail.com>
>
> Currently, the setup.py script detects the clang compiler only when invok=
ed
> with CC=3Dclang. But when using a specific version (e.g. CC=3Dclang-11), =
this
> doesn't work correctly and wrong compiler flags are set, leading to build
> errors.
>
> To properly detect clang, invoke the compiler with -v and check the outpu=
t.
> The first line should start with "clang version ...".
>
> Committer testing:
>
>   $ make CC=3Dclang-9 O=3D/tmp/build/perf -C tools/perf install-bin
>   <SNIP>
>   $ readelf -wi /tmp/build/perf/python/perf.cpython-37m-x86_64-linux-gnu.=
so | grep DW_AT_producer | head -1
>     <c>   DW_AT_producer    : (indirect string, offset: 0x0): clang versi=
on 9.0.1 (Fedora 9.0.1-2.fc31) /usr/bin/clang-9 -Wno-unused-result -Wsign-c=
ompare -D DYNAMIC_ANNOTATIONS_ENABLED=3D1 -D NDEBUG -O2 -g -pipe -Wall -Wer=
ror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -=
fexceptions -fstack-protector-strong -grecord-command-line -m64 -mtune=3Dge=
neric -fasynchronous-unwind-tables -fcf-protection=3Dfull -D _GNU_SOURCE -f=
PIC -fwrapv -Wbad-function-cast -Wdeclaration-after-statement -Wformat-secu=
rity -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -=
Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredun=
dant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwri=
te-strings -Wformat -Wshadow -D HAVE_ARCH_X86_64_SUPPORT -I /tmp/build/perf=
/arch/x86/include/generated -D HAVE_SYSCALL_TABLE_SUPPORT -D HAVE_PERF_REGS=
_SUPPORT -D HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET -Werror -O3 -fno-omit-fram=
e-pointer -ggdb3 -funwind-tables -Wall -Wextra -std=3Dgnu99 -fstack-protect=
or-all -D _FORTIFY_SOURCE=3D2 -D _LARGEFILE64_SOURCE -D _FILE_OFFSET_BITS=
=3D64 -D _GNU_SOURCE -I /home/acme/git/perf/tools/lib/perf/include -I /home=
/acme/git/perf/tools/perf/util/include -I /home/acme/git/perf/tools/perf/ar=
ch/x86/include -I /home/acme/git/perf/tools/include/ -I /home/acme/git/perf=
/tools/arch/x86/include/uapi -I /home/acme/git/perf/tools/include/uapi -I /=
home/acme/git/perf/tools/arch/x86/include/ -I /home/acme/git/perf/tools/arc=
h/x86/ -I /tmp/build/perf//util -I /tmp/build/perf/ -I /home/acme/git/perf/=
tools/perf/util -I /home/acme/git/perf/tools/perf -I /home/acme/git/perf/to=
ols/lib/ -D HAVE_PTHREAD_ATTR_SETAFFINITY_NP -D HAVE_PTHREAD_BARRIER -D HAV=
E_EVENTFD -D HAVE_GET_CURRENT_DIR_NAME -D HAVE_GETTID -D HAVE_DWARF_GETLOCA=
TIONS_SUPPORT -D HAVE_GLIBC_SUPPORT -D HAVE_AIO_SUPPORT -D HAVE_SCHED_GETCP=
U_SUPPORT -D HAVE_SETNS_SUPPORT -D HAVE_LIBELF_SUPPORT -D HAVE_LIBELF_MMAP_=
SUPPORT -D HAVE_ELF_GETPHDRNUM_SUPPORT -D HAVE_GELF_GETNOTE_SUPPORT -D HAVE=
_ELF_GETSHDRSTRNDX_SUPPORT -D HAVE_DWARF_SUPPORT -D HAVE_LIBBPF_SUPPORT -D =
HAVE_BPF_PROLOGUE -D HAVE_SDT_EVENT -D HAVE_JITDUMP -D HAVE_DWARF_UNWIND_SU=
PPORT -D NO_LIBUNWIND_DEBUG_FRAME -D HAVE_LIBUNWIND_SUPPORT -D HAVE_LIBCRYP=
TO_SUPPORT -D HAVE_SLANG_SUPPORT -D HAVE_GTK2_SUPPORT -D NO_LIBPERL -D HAVE=
_TIMERFD_SUPPORT -D HAVE_LIBPYTHON_SUPPORT -D HAVE_CPLUS_DEMANGLE_SUPPORT -=
D HAVE_LIBBFD_SUPPORT -D HAVE_ZLIB_SUPPORT -D HAVE_LZMA_SUPPORT -D HAVE_ZST=
D_SUPPORT -D HAVE_LIBCAP_SUPPORT -D HAVE_BACKTRACE_SUPPORT -D HAVE_LIBNUMA_=
SUPPORT -D HAVE_KVM_STAT_SUPPORT -D DISASM_FOUR_ARGS_SIGNATURE -D HAVE_LIBB=
ABELTRACE_SUPPORT -D HAVE_AUXTRACE_SUPPORT -D HAVE_JVMTI_CMLR -I /tmp/build=
/perf/ -fPIC -I util/include -I /usr/include/python3.7m -c /home/acme/git/p=
erf/tools/perf/util/python.c -o /tmp/build/perf/python_ext_build/tmp/home/a=
cme/git/perf/tools/perf/util/python.o -Wbad-function-cast -Wdeclaration-aft=
er-statement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarati=
ons -Wmissing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-d=
efinition -Wpacked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -=
Wswitch-enum -Wundef -Wwrite-strings -Wformat -Wshadow -D HAVE_ARCH_X86_64_=
SUPPORT -I /tmp/build/perf/arch/x86/include/generated -D HAVE_SYSCALL_TABLE=
_SUPPORT -D HAVE_PERF_REGS_SUPPORT -D HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET =
-Werror -O3 -fno-omit-frame-pointer -ggdb3 -funwind-tables -Wall -Wextra -s=
td=3Dgnu99 -fstack-protector-all -D _FORTIFY_SOURCE=3D2 -D _LARGEFILE64_SOU=
RCE -D _FILE_OFFSET_BITS=3D64 -D _GNU_SOURCE -I /home/acme/git/perf/tools/l=
ib/perf/include -I /home/acme/git/perf/tools/perf/util/include -I /home/acm=
e/git/perf/tools/perf/arch/x86/include -I /home/acme/git/perf/tools/include=
/ -I /home/acme/git/perf/tools/arch/x86/include/uapi -I /home/acme/git/perf=
/tools/include/uapi -I /home/acme/git/perf/tools/arch/x86/include/ -I /home=
/acme/git/perf/tools/arch/x86/ -I /tmp/build/perf//util -I /tmp/build/perf/=
 -I /home/acme/git/perf/tools/perf/util -I /home/acme/git/perf/tools/perf -=
I /home/acme/git/perf/tools/lib/ -D HAVE_PTHREAD_ATTR_SETAFFINITY_NP -D HAV=
E_PTHREAD_BARRIER -D HAVE_EVENTFD -D HAVE_GET_CURRENT_DIR_NAME -D HAVE_GETT=
ID -D HAVE_DWARF_GETLOCATIONS_SUPPORT -D HAVE_GLIBC_SUPPORT -D HAVE_AIO_SUP=
PORT -D HAVE_SCHED_GETCPU_SUPPORT -D HAVE_SETNS_SUPPORT -D HAVE_LIBELF_SUPP=
ORT -D HAVE_LIBELF_MMAP_SUPPORT -D HAVE_ELF_GETPHDRNUM_SUPPORT -D HAVE_GELF=
_GETNOTE_SUPPORT -D HAVE_ELF_GETSHDRSTRNDX_SUPPORT -D HAVE_DWARF_SUPPORT -D=
 HAVE_LIBBPF_SUPPORT -D HAVE_BPF_PROLOGUE -D HAVE_SDT_EVENT -D HAVE_JITDUMP=
 -D HAVE_DWARF_UNWIND_SUPPORT -D NO_LIBUNWIND_DEBUG_FRAME -D HAVE_LIBUNWIND=
_SUPPORT -D HAVE_LIBCRYPTO_SUPPORT -D HAVE_SLANG_SUPPORT -D HAVE_GTK2_SUPPO=
RT -D NO_LIBPERL -D HAVE_TIMERFD_SUPPORT -D HAVE_LIBPYTHON_SUPPORT -D HAVE_=
CPLUS_DEMANGLE_SUPPORT -D HAVE_LIBBFD_SUPPORT -D HAVE_ZLIB_SUPPORT -D HAVE_=
LZMA_SUPPORT -D HAVE_ZSTD_SUPPORT -D HAVE_LIBCAP_SUPPORT -D HAVE_BACKTRACE_=
SUPPORT -D HAVE_LIBNUMA_SUPPORT -D HAVE_KVM_STAT_SUPPORT -D DISASM_FOUR_ARG=
S_SIGNATURE -D HAVE_LIBBABELTRACE_SUPPORT -D HAVE_AUXTRACE_SUPPORT -D HAVE_=
JVMTI_CMLR -I /tmp/build/perf/ -fno-strict-aliasing -Wno-write-strings -Wno=
-unused-parameter -Wno-redundant-decls

Sorry for not speaking up sooner, but if you don't want to include
that mass of command line options above, I generally check which
toolchain has been used to produce a binary via:
$ readelf --string-dump=3D.comment <foo>
which may be more concise, but sometimes we strip out the `.comment`
section from binaries.

>   $
>
> And here is how tools/perf/util/setup.py checks if the used clang has
> options that the distro specific python extension building compiler
> defaults:
>
>   if cc_is_clang:
>       from distutils.sysconfig import get_config_vars
>       vars =3D get_config_vars()
>       for var in ('CFLAGS', 'OPT'):
>           vars[var] =3D sub("-specs=3D[^ ]+", "", vars[var])
>           if not clang_has_option("-mcet"):
>               vars[var] =3D sub("-mcet", "", vars[var])
>           if not clang_has_option("-fcf-protection"):
>               vars[var] =3D sub("-fcf-protection", "", vars[var])
>           if not clang_has_option("-fstack-clash-protection"):
>               vars[var] =3D sub("-fstack-clash-protection", "", vars[var]=
)
>           if not clang_has_option("-fstack-protector-strong"):
>               vars[var] =3D sub("-fstack-protector-strong", "", vars[var]=
)
>
> So "-fcf-protection=3Dfull" is used, clang-9 has this option and thus it
> was kept, the perf python extension was built with it and the build
> completed successfully.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/903
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Igor Lubashev <ilubashe@akamai.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: clang-built-linux@googlegroups.com
> Link: http://lore.kernel.org/lkml/20200309085618.14307-1-ilie.halip@gmail=
.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/setup.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index aa344a163eaf..8a065a6f9713 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -2,11 +2,13 @@ from os import getenv
>  from subprocess import Popen, PIPE
>  from re import sub
>
> +cc =3D getenv("CC")
> +cc_is_clang =3D b"clang version" in Popen([cc, "-v"], stderr=3DPIPE).std=
err.readline()
> +
>  def clang_has_option(option):
> -    return [o for o in Popen(['clang', option], stderr=3DPIPE).stderr.re=
adlines() if b"unknown argument" in o] =3D=3D [ ]
> +    return [o for o in Popen([cc, option], stderr=3DPIPE).stderr.readlin=
es() if b"unknown argument" in o] =3D=3D [ ]
>
> -cc =3D getenv("CC")
> -if cc =3D=3D "clang":
> +if cc_is_clang:
>      from distutils.sysconfig import get_config_vars
>      vars =3D get_config_vars()
>      for var in ('CFLAGS', 'OPT'):
> @@ -40,7 +42,7 @@ class install_lib(_install_lib):
>  cflags =3D getenv('CFLAGS', '').split()
>  # switch off several checks (need to be at the end of cflags list)
>  cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-=
parameter', '-Wno-redundant-decls' ]
> -if cc !=3D "clang":
> +if not cc_is_clang:
>      cflags +=3D ['-Wno-cast-function-type' ]
>
>  src_perf  =3D getenv('srctree') + '/tools/perf'
> --
> 2.21.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/clang-built-linux/20200309185323.22583-4-acme%40kernel.org.



--=20
Thanks,
~Nick Desaulniers
