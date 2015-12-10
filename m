From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: [PATCH perf/core  00/22] perf refcnt debugger API and fixes
Date: Thu, 10 Dec 2015 20:52:02 +0800
Message-ID: <56697572.90701@huawei.com>
References: <20151209021047.10245.8918.stgit@localhost.localdomain> <20151209134138.GB15864@kernel.org> <50399556C9727B4D88A595C8584AAB375264FB48@GSjpTKYDCembx32.service.hitachi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:64141 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbbLJMw3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Dec 2015 07:52:29 -0500
In-Reply-To: <50399556C9727B4D88A595C8584AAB375264FB48@GSjpTKYDCembx32.service.hitachi.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?UTF-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, 'Arnaldo Carvalho de Melo' <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Alexei Starovoitov <ast@plumgrid.com>



On 2015/12/10 19:04, =E5=B9=B3=E6=9D=BE=E9=9B=85=E5=B7=B3 / HIRAMATU=EF=
=BC=8CMASAMI wrote:
>> From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
>>
>> Em Wed, Dec 09, 2015 at 11:10:48AM +0900, Masami Hiramatsu escreveu:
>>> Hi Arnaldo,
>>>
>>> Here is a series of patches for perf refcnt debugger and
>>> some fixes.
>>>
>>> In this series I've replaced all atomic reference counters
>>> with the refcnt interface, including dso, map, map_groups,
>>> thread, cpu_map, comm_str, cgroup_sel, thread_map, and
>>> perf_mmap.
>>>
>>>    refcnt debugger (or refcnt leak checker)
>>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> At first, note that this change doesn't affect any compiled
>>> code unless building with REFCNT_DEBUG=3D1 (see macros in
>>> refcnt.h). So, this feature is only enabled in the debug binary.
>>> But before releasing, we can ensure that all objects are safely
>>> reclaimed before exit in -rc phase.
>> That helps and is finding bugs and is really great stuff, thank you!
>>
>> But I wonder if we couldn't get the same results on an unmodified bi=
nary
>> by using things like 'perf probe', the BPF code we're introducing, h=
ave
>> you thought about this possibility?
> That's possible, but it will require pre-analysis of the binary, beca=
use
> refcnt interface is not fixed API like a "systemcall" (moreover, it c=
ould
> be just a non-atomic variable).
>
> Thus we need a kind of "annotation" event by source code level.
>
>> I.e. trying to use 'perf probe' to do this would help in using the s=
ame
>> technique in other code bases where we can't change the sources, etc=
=2E
>>
>> For perf we could perhaps use a 'noinline' on the __get/__put
>> operations, so that we could have the right places to hook using
>> uprobes, other codebases would have to rely in the 'perf probe'
>> infrastructure that knows where inlines were expanded, etc.
>>
>> Such a toold could work like:
>>
>>    perf dbgrefcnt ~/bin/perf thread
> This works only for the binary which is coded as you said.
> I actually doubt that this is universal solution. We'd better introdu=
ce
> librefcnt.so if you need more general solution, so that we can fix th=
e
> refcnt API and we can also hook the interface easily.
>
> But with this way, we don't need ebpf/uprobes anymore, since we've al=
ready
> have LD_PRELOAD (like valgrind does). :(
>
> So, IMHO, using ebpf and perf probe for this issue sounds like using
> a sledge=E2=80=90hammer...

But this is an interesting problem and can inspire us the direction
for eBPF improvement. I guess if we can solve this problem with eBPF
we can also solve many similar problems with much lower cost than what
you have done in first 5 patches?

This is what we have done today:

With a much simpler patch which create 4 stub functions:

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 65fef59..2c45478 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -87,6 +87,7 @@ libperf-$(CONFIG_AUXTRACE) +=3D intel-bts.o
  libperf-y +=3D parse-branch-options.o
  libperf-y +=3D parse-regs-options.o
  libperf-y +=3D term.o
+libperf-y +=3D refcnt.o

  libperf-$(CONFIG_LIBBPF) +=3D bpf-loader.o
  libperf-$(CONFIG_BPF_PROLOGUE) +=3D bpf-prologue.o
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e8e9a9d..de52ae8 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1,6 +1,7 @@
  #include <asm/bug.h>
  #include <sys/time.h>
  #include <sys/resource.h>
+#include "refcnt.h"
  #include "symbol.h"
  #include "dso.h"
  #include "machine.h"
diff --git a/tools/perf/util/refcnt.c b/tools/perf/util/refcnt.c
new file mode 100644
index 0000000..f5a6659
--- /dev/null
+++ b/tools/perf/util/refcnt.c
@@ -0,0 +1,29 @@
+#include <linux/compiler.h>
+#include "util/refcnt.h"
+
+void __attribute__ ((noinline))
+__refcnt__init(atomic_t *refcnt, int n,
+              void *obj __maybe_unused,
+              const char *name __maybe_unused)
+{
+       atomic_set(refcnt, n);
+}
+
+void __attribute__ ((noinline))
+refcnt__delete(void *obj __maybe_unused)
+{
+}
+
+void __attribute__ ((noinline))
+__refcnt__get(atomic_t *refcnt, void *obj __maybe_unused,
+             const char *name __maybe_unused)
+{
+       atomic_inc(refcnt);
+}
+
+int __attribute__ ((noinline))
+__refcnt__put(atomic_t *refcnt, void *obj __maybe_unused,
+             const char *name __maybe_unused)
+{
+       return atomic_dec_and_test(refcnt);
+}
diff --git a/tools/perf/util/refcnt.h b/tools/perf/util/refcnt.h
new file mode 100644
index 0000000..04f5390
--- /dev/null
+++ b/tools/perf/util/refcnt.h
@@ -0,0 +1,21 @@
+#ifndef PERF_REFCNT_H
+#define PERF_REFCNT_H
+#include <linux/atomic.h>
+
+void __refcnt__init(atomic_t *refcnt, int n, void *obj, const char *na=
me);
+void refcnt__delete(void *obj);
+void __refcnt__get(atomic_t *refcnt, void *obj, const char *name);
+int __refcnt__put(atomic_t *refcnt, void *obj, const char *name);
+
+#define refcnt__init(obj, member, n)   \
+       __refcnt__init(&(obj)->member, n, obj, #obj)
+#define refcnt__init_as(obj, member, n, name)  \
+       __refcnt__init(&(obj)->member, n, obj, name)
+#define refcnt__exit(obj, member)      \
+       refcnt__delete(obj)
+#define refcnt__get(obj, member)       \
+       __refcnt__get(&(obj)->member, obj, #obj)
+#define refcnt__put(obj, member)       \
+       __refcnt__put(&(obj)->member, obj, #obj)
+
+#endif

And a relative complex eBPF script attached at the end of
this mail, with following cmdline:

  # ./perf record -e ./refcnt.c ./perf probe vfs_read
  # cat /sys/kernel/debug/tracing/trace
             ...
             perf-18419 [004] d... 613572.513083: : Type 0 leak 2
             perf-18419 [004] d... 613572.513084: : Type 1 leak 1

I know we have 2 dsos and 1 map get leak.

However I have to analysis full stack trace from 'perf script' to find
which one get leak, because currently my eBPF script is unable to repor=
t
which object is leak. I know I can use a hashtable with object address
as key, but currently I don't know how to enumerate keys in a hash tabl=
e,
except maintaining a relationship between index and object address.
Now I'm waiting for Daniel's persistent map to be enforced for that. Wh=
en
it ready we can create a tool with the following eBPF script embedded i=
nto
perf as a small subcommand, and report call stack of 'alloc' method of
leak object in 'perf report' style, so we can solve similar problem eas=
ier.
To make it genereic, we can even make it attach to '{m,c}alloc%return' =
and
'free', or 'mmap/munmap'.

Thank you.


-------------- eBPF script --------------

typedef int u32;
typedef unsigned long long u64;
#define NULL    ((void *)(0))

#define BPF_ANY         0 /* create new element or update existing */
#define BPF_NOEXIST     1 /* create new element if it didn't exist */
#define BPF_EXIST       2 /* update existing element */

enum bpf_map_type {
         BPF_MAP_TYPE_UNSPEC,
         BPF_MAP_TYPE_HASH,
         BPF_MAP_TYPE_ARRAY,
         BPF_MAP_TYPE_PROG_ARRAY,
         BPF_MAP_TYPE_PERF_EVENT_ARRAY,
};

struct bpf_map_def {
         unsigned int type;
         unsigned int key_size;
         unsigned int value_size;
         unsigned int max_entries;
};

#define SEC(NAME) __attribute__((section(NAME), used))
static int (*bpf_probe_read)(void *dst, int size, void *src) =3D
         (void *)4;
static int (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) =3D
         (void *)6;
static int (*bpf_get_smp_processor_id)(void) =3D
         (void *)8;
static int (*map_update_elem)(struct bpf_map_def *, void *, void *,=20
unsigned long long flags) =3D
         (void *)2;
static void *(*map_lookup_elem)(struct bpf_map_def *, void *) =3D
         (void *)1;
static unsigned long long (*get_current_pid_tgid)(void) =3D
         (void *)14;
static unsigned long long (*get_current_comm)(char *buf, int size_of_bu=
f) =3D
         (void *)16;

char _license[] SEC("license") =3D "GPL";
int _version SEC("version") =3D LINUX_VERSION_CODE;

enum global_var {
         G_pid,
         G_LEAK_START,
         G_dso_leak =3D G_LEAK_START,
         G_map_group_leak,
         G_LEAK_END,
         G_NR =3D G_LEAK_END,
};

struct bpf_map_def SEC("maps") global_vars =3D {
         .type =3D BPF_MAP_TYPE_ARRAY,
         .key_size =3D sizeof(int),
         .value_size =3D sizeof(u64),
         .max_entries =3D G_NR,
};

static inline int filter_pid(void)
{
         int key_pid =3D G_pid;
         unsigned long long *p_pid, pid;

         char fmt[] =3D "%d vs %d\n";

         p_pid =3D map_lookup_elem(&global_vars, &key_pid);
         if (!p_pid)
                 return 0;

         pid =3D get_current_pid_tgid() & 0xffffffff;

         if (*p_pid !=3D pid)
                 return 0;
         return 1;
}

static inline void print_leak(int type)
{
         unsigned long long *p_cnt;
         char fmt[] =3D "Type %d leak %llu\n";

         p_cnt =3D map_lookup_elem(&global_vars, &type);
         if (!p_cnt)
                 return;
         bpf_trace_printk(fmt, sizeof(fmt), type - G_LEAK_START, *p_cnt=
);
}

SEC("execve=3Dsys_execve")
int execve(void *ctx)
{
         char name[sizeof(u64)] =3D "";
         char name_perf[sizeof(u64)] =3D "perf";
         unsigned long long *p_pid, pid;
         int key =3D G_pid;

         p_pid =3D map_lookup_elem(&global_vars, &key);
         if (!p_pid)
                 return 0;
         pid =3D *p_pid;
         if (pid)
                 return 0;
         if (get_current_comm(name, sizeof(name)))
                 return 0;
         if (*(u32*)name !=3D *(u32*)name_perf)
                 return 0;

         pid =3D get_current_pid_tgid() & 0xffffffff;
         map_update_elem(&global_vars, &key, &pid, BPF_ANY);
         return 0;
}

static inline int func_exit(void *ctx)
{
         if (!filter_pid())
                 return 0;
         print_leak(G_dso_leak);
         print_leak(G_map_group_leak);
         return 0;
}

SEC("exit_group=3Dsys_exit_group")
int exit_group(void *ctx)
{
         return func_exit(ctx);
}

SEC("exit_=3Dsys_exit")
int exit_(void *ctx)
{
         return func_exit(ctx);
}
static inline void inc_leak_from_type(int type, int n)
{
         u64 *p_cnt, cnt;

         type +=3D G_LEAK_START;
         if (type >=3D G_LEAK_END)
                 return;

         p_cnt =3D map_lookup_elem(&global_vars, &type);
         if (!p_cnt)
                 cnt =3D n;
         else
                 cnt =3D *p_cnt + n;

         map_update_elem(&global_vars, &type, &cnt, BPF_ANY);
         return;
}

SEC("exec=3D/home/wangnan/perf;"
     "refcnt_init=3D__refcnt__init n obj type")
int refcnt_init(void *ctx, int err, int n, void *obj, int type)
{
         if (!filter_pid())
                 return 0;
         inc_leak_from_type(type, n);
         return 0;
}
SEC("exec=3D/home/wangnan/perf;"
     "refcnt_del=3Drefcnt__delete obj type")
int refcnt_del(void *ctx, int err, void *obj, int type)
{
         if (!filter_pid())
                 return 0;
         return 0;
}

SEC("exec=3D/home/wangnan/perf;"
     "refcnt_get=3D__refcnt__get obj type")
int refcnt_get(void *ctx, int err, void *obj, int type)
{
         if (!filter_pid())
                 return 0;
         inc_leak_from_type(type, 1);
         return 0;
}

SEC("exec=3D/home/wangnan/perf;"
     "refcnt_put=3D__refcnt__put refcnt obj type")
int refcnt_put(void *ctx, int err, void *refcnt, void *obj, int type)
{
         int old_cnt =3D -1;

         if (!filter_pid())
                 return 0;
         if (bpf_probe_read(&old_cnt, sizeof(int), refcnt))
                 return 0;
         if (old_cnt)
                 inc_leak_from_type(type, -1);
         return 0;
}
