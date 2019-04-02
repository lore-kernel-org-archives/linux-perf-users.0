From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH 03/44] perf augmented_raw_syscalls: Use a PERCPU_ARRAY map
 to copy more string bytes
Date: Tue, 2 Apr 2019 09:44:51 -0700
Message-ID: <CAEf4Bzagyaycg7aWrwx9D8_A5p0LgD2-fg94sq7+5xiL_tHh2g@mail.gmail.com>
References: <20190402160549.13544-1-acme@kernel.org> <20190402160549.13544-4-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-4-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andrii Nakryiko <andriin@fb.com>, Daniel Borkmann <borkmann@iogearbox.net>, Gianluca Borello <g.borello@gmail.com>, Jesper Dangaard Brouer <brouer@redhat.com>, =?UTF-8?B?THVpcyBDbMOhdWRpbyBHb27Dp2FsdmVz?= <lclaudio@redhat.com>, Martin Lau <kafai@fb.com>, Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Apr 2, 2019 at 9:12 AM Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> The previous method, copying to the BPF stack limited us in how many
> bytes we could copy from strings, use a PERCPU_ARRAY map like devised by
> the sysdig guys[1] to copy more bytes:
>
> Before:
>
>   # trace --no-inherit -e openat touch `python -c "print "$s" 'a' * 2000"=
`
>   touch: cannot touch 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
': File name too long
>   openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
>   openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) =3D 3
>   openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) =
=3D 3
>   openat(AT_FDCWD, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", O_CREAT|O_NOCTTY|O_N=
ONBLOCK|O_WRONLY, S_IRUGO|S_IWUGO) =3D -1 ENAMETOOLONG (File name too long)
>   openat(AT_FDCWD, "/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) =
=3D 3
>   openat(AT_FDCWD, "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/coreutils.m=
o", O_RDONLY) =3D -1 ENOENT (No such file or directory)
>   openat(AT_FDCWD, "/usr/share/locale/en_US.utf8/LC_MESSAGES/coreutils.mo=
", O_RDONLY) =3D -1 ENOENT (No such file or directory)
>   <SNIP some openat calls>
>   #
>
> After:
>
>   [root@quaco acme]# trace --no-inherit -e openat touch `python -c "print=
 "$s" 'a' * 2000"`
>   <STRIP what is the same as in the 'before' part>
>   openat(AT_FDCWD, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", =
O_CREAT|O_NOCTTY|O_NONBLOC) =3D -1 ENAMETOOLONG (File name too long)
>   <STRIP what is the same as in the 'before' part>
>
> If we leave something like 'perf trace -e string' to trace all syscalls
> with a string, and then do some 'perf top', to get some annotation for
> the augmented_raw_syscalls.o BPF program we get:
>
>        =E2=94=82     =E2=86=92 callq  *ffffffffc45576d1                  =
                                                                           =
             =E2=96=92
>        =E2=94=82                augmented_args->filename.size =3D probe_r=
ead_str(&augmented_args->filename.value,                                   =
       =E2=96=92
>   0.05 =E2=94=82       mov    %eax,0x40(%r13)
>
> Looking with pahole, expanding types, asking for hex offsets and sizes,
> and use of BTF type information to see what is at that 0x40 offset from
> %r13:
>
>   # pahole -F btf -C augmented_args_filename --expand_types --hex /home/a=
cme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
>   struct augmented_args_filename {
>         struct syscall_enter_args {
>                 long long unsigned int common_tp_fields;                 =
                /*     0   0x8 */
>                 long int           syscall_nr;                           =
                /*   0x8   0x8 */
>                 long unsigned int  args[6];                              =
                /*  0x10  0x30 */
>         } args; /*     0  0x40 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         struct augmented_filename {
>                 unsigned int       size;                                 =
                /*  0x40   0x4 */
>                 int                reserved;                             =
                /*  0x44   0x4 */
>                 char               value[4096];                          =
                /*  0x48 0x1000 */
>         } filename; /*  0x40 0x1008 */
>
>         /* size: 4168, cachelines: 66, members: 2 */
>         /* last cacheline: 8 bytes */
>   };
>   #
>
> Then looking if PATH_MAX leaves some signature in the tests:
>
>        =E2=94=82                if (augmented_args->filename.size < sizeo=
f(augmented_args->filename.value)) {                                       =
     =E2=96=92
>        =E2=94=82       cmp    $0xfff,%rdi
>
> 0xfff =3D=3D 4095
> sizeof(augmented_args->filename.value) =3D=3D PATH_MAX =3D=3D 4096
>
> [1] https://sysdig.com/blog/the-art-of-writing-ebpf-programs-a-primer/
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andrii Nakryiko <andriin@fb.com>
> Cc: Daniel Borkmann <borkmann@iogearbox.net>
> Cc: Gianluca Borello <g.borello@gmail.com>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Luis Cl=C3=A1udio Gon=C3=A7alves <lclaudio@redhat.com>
> cc: Martin Lau <kafai@fb.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Cc: Yonghong Song <yhs@fb.com>
> Link: https://lkml.kernel.org/n/tip-76gce2d2ghzq537ubwhjkone@git.kernel.o=
rg
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---

Looks good to me. I've been using PERCPU_ARRAY as a sort of heap for
many things that don't fit on BPF stack.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  .../examples/bpf/augmented_raw_syscalls.c     | 46 +++++++++++--------
>  1 file changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/per=
f/examples/bpf/augmented_raw_syscalls.c
> index 9f8b31ad7a49..2422894a8194 100644
> --- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
> +++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
> @@ -15,6 +15,7 @@
>   */
>
>  #include <unistd.h>
> +#include <linux/limits.h>
>  #include <pid_filter.h>
>
>  /* bpf-output associated map */
> @@ -41,7 +42,7 @@ struct syscall_exit_args {
>  struct augmented_filename {
>         unsigned int    size;
>         int             reserved;
> -       char            value[256];
> +       char            value[PATH_MAX];
>  };
>
>  /* syscalls where the first arg is a string */
> @@ -119,23 +120,32 @@ struct augmented_filename {
>
>  pid_filter(pids_filtered);
>
> +struct augmented_args_filename {
> +       struct syscall_enter_args args;
> +       struct augmented_filename filename;
> +};
> +
> +bpf_map(augmented_filename_map, PERCPU_ARRAY, int, struct augmented_args=
_filename, 1);
> +
>  SEC("raw_syscalls:sys_enter")
>  int sys_enter(struct syscall_enter_args *args)
>  {
> -       struct {
> -               struct syscall_enter_args args;
> -               struct augmented_filename filename;
> -       } augmented_args;
> -       struct syscall *syscall;
> -       unsigned int len =3D sizeof(augmented_args);
> +       struct augmented_args_filename *augmented_args;
> +       unsigned int len =3D sizeof(*augmented_args);
>         const void *filename_arg =3D NULL;
> +       struct syscall *syscall;
> +       int key =3D 0;
> +
> +        augmented_args =3D bpf_map_lookup_elem(&augmented_filename_map, =
&key);
> +        if (augmented_args =3D=3D NULL)
> +                return 1;
>
>         if (pid_filter__has(&pids_filtered, getpid()))
>                 return 0;
>
> -       probe_read(&augmented_args.args, sizeof(augmented_args.args), arg=
s);
> +       probe_read(&augmented_args->args, sizeof(augmented_args->args), a=
rgs);
>
> -       syscall =3D bpf_map_lookup_elem(&syscalls, &augmented_args.args.s=
yscall_nr);
> +       syscall =3D bpf_map_lookup_elem(&syscalls, &augmented_args->args.=
syscall_nr);
>         if (syscall =3D=3D NULL || !syscall->enabled)
>                 return 0;
>         /*
> @@ -191,7 +201,7 @@ int sys_enter(struct syscall_enter_args *args)
>          * processor architecture, making the kernel part the same no mat=
ter what
>          * kernel version or processor architecture it runs on.
>          */
> -       switch (augmented_args.args.syscall_nr) {
> +       switch (augmented_args->args.syscall_nr) {
>         case SYS_ACCT:
>         case SYS_ADD_KEY:
>         case SYS_CHDIR:
> @@ -263,20 +273,20 @@ int sys_enter(struct syscall_enter_args *args)
>         }
>
>         if (filename_arg !=3D NULL) {
> -               augmented_args.filename.reserved =3D 0;
> -               augmented_args.filename.size =3D probe_read_str(&augmente=
d_args.filename.value,
> -                                                             sizeof(augm=
ented_args.filename.value),
> +               augmented_args->filename.reserved =3D 0;
> +               augmented_args->filename.size =3D probe_read_str(&augment=
ed_args->filename.value,
> +                                                             sizeof(augm=
ented_args->filename.value),
>                                                               filename_ar=
g);
> -               if (augmented_args.filename.size < sizeof(augmented_args.=
filename.value)) {
> -                       len -=3D sizeof(augmented_args.filename.value) - =
augmented_args.filename.size;
> -                       len &=3D sizeof(augmented_args.filename.value) - =
1;
> +               if (augmented_args->filename.size < sizeof(augmented_args=
->filename.value)) {
> +                       len -=3D sizeof(augmented_args->filename.value) -=
 augmented_args->filename.size;
> +                       len &=3D sizeof(augmented_args->filename.value) -=
 1;
>                 }
>         } else {
> -               len =3D sizeof(augmented_args.args);
> +               len =3D sizeof(augmented_args->args);
>         }
>
>         /* If perf_event_output fails, return non-zero so that it gets re=
corded unaugmented */
> -       return perf_event_output(args, &__augmented_syscalls__, BPF_F_CUR=
RENT_CPU, &augmented_args, len);
> +       return perf_event_output(args, &__augmented_syscalls__, BPF_F_CUR=
RENT_CPU, augmented_args, len);
>  }
>
>  SEC("raw_syscalls:sys_exit")
> --
> 2.20.1
>
