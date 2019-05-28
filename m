From: Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 05/14] tools headers UAPI: Sync linux/sched.h with the kernel
Date: Tue, 28 May 2019 19:53:41 +0200
Message-ID: <5DED7BD2-76E6-4647-8794-348EC25A4690@brauner.io>
References: <20190528175020.13343-1-acme@kernel.org> <20190528175020.13343-6-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528175020.13343-6-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, =?ISO-8859-1?Q?Luis_Cl=E1udio_Gon=E7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On May 28, 2019 7:50:11 PM GMT+02:00, Arnaldo Carvalho de Melo <acme@kernel=
=2Eorg> wrote:
>From: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>
>To pick up the change in:
>
>  b3e583825266 ("clone: add CLONE_PIDFD")
>
>This requires changes in the 'perf trace' beautification routines for
>the 'clone' syscall args, which is done in a followup patch=2E
>
>This silences the following perf build warning:
>
>Warning: Kernel ABI header at 'tools/include/uapi/linux/sched=2Eh'
>differs from latest version at 'include/uapi/linux/sched=2Eh'
>  diff -u tools/include/uapi/linux/sched=2Eh include/uapi/linux/sched=2Eh
>
>Cc: Adrian Hunter <adrian=2Ehunter@intel=2Ecom>
>Cc: Brendan Gregg <brendan=2Ed=2Egregg@gmail=2Ecom>
>Cc: Christian Brauner <christian@brauner=2Eio>
>Cc: Jiri Olsa <jolsa@kernel=2Eorg>
>Cc: Luis Cl=C3=A1udio Gon=C3=A7alves <lclaudio@redhat=2Ecom>
>Cc: Namhyung Kim <namhyung@kernel=2Eorg>
>Link:
>https://lkml=2Ekernel=2Eorg/n/tip-lenja6gmy26dkt0ybk747qgq@git=2Ekernel=
=2Eorg
>Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>---
> tools/include/uapi/linux/sched=2Eh | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/tools/include/uapi/linux/sched=2Eh
>b/tools/include/uapi/linux/sched=2Eh
>index 22627f80063e=2E=2Eed4ee170bee2 100644
>--- a/tools/include/uapi/linux/sched=2Eh
>+++ b/tools/include/uapi/linux/sched=2Eh
>@@ -10,6 +10,7 @@
>#define CLONE_FS	0x00000200	/* set if fs info shared between processes
>*/
>#define CLONE_FILES	0x00000400	/* set if open files shared between
>processes */
>#define CLONE_SIGHAND	0x00000800	/* set if signal handlers and blocked
>signals shared */
>+#define CLONE_PIDFD	0x00001000	/* set if a pidfd should be placed in
>parent */
>#define CLONE_PTRACE	0x00002000	/* set if we want to let tracing
>continue on the child too */
>#define CLONE_VFORK	0x00004000	/* set if the parent wants the child to
>wake it up on mm_release */
>#define CLONE_PARENT	0x00008000	/* set if we want to have the same
>parent as the cloner */

Thanks for doing that!

Reviewed-by: Christian Brauner <christian@brauner=2Eio>
