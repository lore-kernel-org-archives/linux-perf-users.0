From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/44] perf augmented_raw_syscalls: Use a PERCPU_ARRAY map to copy more string bytes
Date: Tue,  2 Apr 2019 13:05:08 -0300
Message-ID: <20190402160549.13544-4-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andrii Nakryiko <andriin@fb.com>, Daniel Borkmann <borkmann@iogearbox.net>, Gianluca Borello <g.borello@gmail.com>, Jesper Dangaard Brouer <brouer@redhat.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Martin Lau <kafai@fb.com>, Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The previous method, copying to the BPF stack limited us in how many
bytes we could copy from strings, use a PERCPU_ARRAY map like devised by
the sysdig guys[1] to copy more bytes:

Before:

  # trace --no-inherit -e openat touch `python -c "print "$s" 'a' * 2000"`
  touch: cannot touch 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
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
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa':=
 File name too long
  openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
  openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) =3D 3
  openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) =
=3D 3
  openat(AT_FDCWD, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", O_CREAT|O_NOCTTY|O_NON=
BLOCK|O_WRONLY, S_IRUGO|S_IWUGO) =3D -1 ENAMETOOLONG (File name too long)
  openat(AT_FDCWD, "/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) =
=3D 3
  openat(AT_FDCWD, "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/coreutils.mo"=
, O_RDONLY) =3D -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/share/locale/en_US.utf8/LC_MESSAGES/coreutils.mo",=
 O_RDONLY) =3D -1 ENOENT (No such file or directory)
  <SNIP some openat calls>
  #

After:

  [root@quaco acme]# trace --no-inherit -e openat touch `python -c "print "=
$s" 'a' * 2000"`
  <STRIP what is the same as in the 'before' part>
  openat(AT_FDCWD, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
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
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", O_=
CREAT|O_NOCTTY|O_NONBLOC) =3D -1 ENAMETOOLONG (File name too long)
  <STRIP what is the same as in the 'before' part>

If we leave something like 'perf trace -e string' to trace all syscalls
with a string, and then do some 'perf top', to get some annotation for
the augmented_raw_syscalls.o BPF program we get:

       =E2=94=82     =E2=86=92 callq  *ffffffffc45576d1                    =
                                                                           =
           =E2=96=92
       =E2=94=82                augmented_args->filename.size =3D probe_rea=
d_str(&augmented_args->filename.value,                                     =
     =E2=96=92
  0.05 =E2=94=82       mov    %eax,0x40(%r13)

Looking with pahole, expanding types, asking for hex offsets and sizes,
and use of BTF type information to see what is at that 0x40 offset from
%r13:

  # pahole -F btf -C augmented_args_filename --expand_types --hex /home/acm=
e/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  struct augmented_args_filename {
	struct syscall_enter_args {
		long long unsigned int common_tp_fields;                                 =
/*     0   0x8 */
		long int           syscall_nr;                                           =
/*   0x8   0x8 */
		long unsigned int  args[6];                                              =
/*  0x10  0x30 */
	} args; /*     0  0x40 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct augmented_filename {
		unsigned int       size;                                                 =
/*  0x40   0x4 */
		int                reserved;                                             =
/*  0x44   0x4 */
		char               value[4096];                                          =
/*  0x48 0x1000 */
	} filename; /*  0x40 0x1008 */

	/* size: 4168, cachelines: 66, members: 2 */
	/* last cacheline: 8 bytes */
  };
  #

Then looking if PATH_MAX leaves some signature in the tests:

       =E2=94=82                if (augmented_args->filename.size < sizeof(=
augmented_args->filename.value)) {                                         =
   =E2=96=92
       =E2=94=82       cmp    $0xfff,%rdi

0xfff =3D=3D 4095
sizeof(augmented_args->filename.value) =3D=3D PATH_MAX =3D=3D 4096

[1] https://sysdig.com/blog/the-art-of-writing-ebpf-programs-a-primer/

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: Daniel Borkmann <borkmann@iogearbox.net>
Cc: Gianluca Borello <g.borello@gmail.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cl=C3=A1udio Gon=C3=A7alves <lclaudio@redhat.com>
cc: Martin Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-76gce2d2ghzq537ubwhjkone@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 46 +++++++++++--------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/=
examples/bpf/augmented_raw_syscalls.c
index 9f8b31ad7a49..2422894a8194 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -15,6 +15,7 @@
  */
=20
 #include <unistd.h>
+#include <linux/limits.h>
 #include <pid_filter.h>
=20
 /* bpf-output associated map */
@@ -41,7 +42,7 @@ struct syscall_exit_args {
 struct augmented_filename {
 	unsigned int	size;
 	int		reserved;
-	char		value[256];
+	char		value[PATH_MAX];
 };
=20
 /* syscalls where the first arg is a string */
@@ -119,23 +120,32 @@ struct augmented_filename {
=20
 pid_filter(pids_filtered);
=20
+struct augmented_args_filename {
+       struct syscall_enter_args args;
+       struct augmented_filename filename;
+};
+
+bpf_map(augmented_filename_map, PERCPU_ARRAY, int, struct augmented_args_f=
ilename, 1);
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
-	struct {
-		struct syscall_enter_args args;
-		struct augmented_filename filename;
-	} augmented_args;
-	struct syscall *syscall;
-	unsigned int len =3D sizeof(augmented_args);
+	struct augmented_args_filename *augmented_args;
+	unsigned int len =3D sizeof(*augmented_args);
 	const void *filename_arg =3D NULL;
+	struct syscall *syscall;
+	int key =3D 0;
+
+        augmented_args =3D bpf_map_lookup_elem(&augmented_filename_map, &k=
ey);
+        if (augmented_args =3D=3D NULL)
+                return 1;
=20
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
=20
-	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
+	probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
=20
-	syscall =3D bpf_map_lookup_elem(&syscalls, &augmented_args.args.syscall_n=
r);
+	syscall =3D bpf_map_lookup_elem(&syscalls, &augmented_args->args.syscall_=
nr);
 	if (syscall =3D=3D NULL || !syscall->enabled)
 		return 0;
 	/*
@@ -191,7 +201,7 @@ int sys_enter(struct syscall_enter_args *args)
 	 * processor architecture, making the kernel part the same no matter what
 	 * kernel version or processor architecture it runs on.
 	 */
-	switch (augmented_args.args.syscall_nr) {
+	switch (augmented_args->args.syscall_nr) {
 	case SYS_ACCT:
 	case SYS_ADD_KEY:
 	case SYS_CHDIR:
@@ -263,20 +273,20 @@ int sys_enter(struct syscall_enter_args *args)
 	}
=20
 	if (filename_arg !=3D NULL) {
-		augmented_args.filename.reserved =3D 0;
-		augmented_args.filename.size =3D probe_read_str(&augmented_args.filename=
.value,
-							      sizeof(augmented_args.filename.value),
+		augmented_args->filename.reserved =3D 0;
+		augmented_args->filename.size =3D probe_read_str(&augmented_args->filena=
me.value,
+							      sizeof(augmented_args->filename.value),
 							      filename_arg);
-		if (augmented_args.filename.size < sizeof(augmented_args.filename.value)=
) {
-			len -=3D sizeof(augmented_args.filename.value) - augmented_args.filenam=
e.size;
-			len &=3D sizeof(augmented_args.filename.value) - 1;
+		if (augmented_args->filename.size < sizeof(augmented_args->filename.valu=
e)) {
+			len -=3D sizeof(augmented_args->filename.value) - augmented_args->filen=
ame.size;
+			len &=3D sizeof(augmented_args->filename.value) - 1;
 		}
 	} else {
-		len =3D sizeof(augmented_args.args);
+		len =3D sizeof(augmented_args->args);
 	}
=20
 	/* If perf_event_output fails, return non-zero so that it gets recorded u=
naugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU=
, &augmented_args, len);
+	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU=
, augmented_args, len);
 }
=20
 SEC("raw_syscalls:sys_exit")
--=20
2.20.1
