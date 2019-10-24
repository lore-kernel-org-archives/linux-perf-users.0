From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Subject: Re: Linux-next: 20191022: perf: bpf_helpers_doc.py: not found
Date: Thu, 24 Oct 2019 13:05:54 -0500
Message-ID: <CAEUSe79P0z4N=3TnF9ytWfemX8NqY1Mr_zt6PDgMAZQb=4ChpA@mail.gmail.com>
References: <CA+G9fYvWdkmmkrq7hvADZ-1qnUNEwRULoTPfOQDnu1aZW8cDEA@mail.gmail.com>
 <20191023024149.GA29009@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191023024149.GA29009@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>, sfr@canb.auug.org.au
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, open list <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, lkft-triage@lists.linaro.org
List-Id: linux-perf-users.vger.kernel.org

Hello!

On Tue, 22 Oct 2019 at 21:42, Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Naresh,
>
> On Tue, Oct 22, 2019 at 09:04:04PM +0530, Naresh Kamboju wrote:
> > We have noticed perf (OE recipe) build failure on linux next 20191022.
> > do you see this failure ?
> >
> > /bin/sh: 1: perf/1.0-r9/perf-1.0/scripts/bpf_helpers_doc.py: not found
> > Makefile:184: recipe for target 'bpf_helper_defs.h' failed
> > make[3]: *** [bpf_helper_defs.h] Error 127
> > make[3]: *** Deleting file 'bpf_helper_defs.h'
> > Makefile.perf:765: recipe for target 'perf/1.0-r9/perf-1.0/libbpf.a' fa=
iled
> > make[2]: *** [perf/1.0-r9/perf-1.0/libbpf.a] Error 2
>
> I tested for two methods with linux-next, one is native building mode
> for Arm64 building on DB410c board, another is cross compiling Arm64
> binary on my x86 laptop.  Both cannot reproduce this failure.
>
> After read your shared build log and I think the building process is
> expected: Perf tool tries to build libbpf, so it changes to the
> building folder 'BPF_DIR' (which is under $(srctree)/tools/lib/bpf/),
> then failed to find file $(srctree)/scripts/bpf_helpers_doc.py.
>
> Here $(srctree) means the kernel's root folder.
>
> Seems to me, this failure is caused by missing to sync kernel files
> $linux_src/scripts to the OE folder 'perf/1.0-r9/perf-1.0/scripts'?

Yes, this is exactly the reason. As of e01a75c159691 (merged on
next-20191022), we need to include linux/scripts into the source
directory for OpenEmbedded to build Perf. We have now sent a fix to
OE-core.

By the way, while looking at this, we found this unresolved conflict
in the tree:
-----8<----------8<----------8<-----
  $ git show 2b5d5b1927a8c
  commit 2b5d5b1927a8c17bf3ce5b4f781c6ba11e02cadd
  Merge: c1e45431c592 ae79d5588a04
  Author: Ingo Molnar <mingo@kernel.org>
  Date:   Mon Oct 21 07:13:15 2019 +0200

      Merge branch 'perf/core'

      Conflicts:
              tools/perf/check-headers.sh

  diff --cc tools/perf/check-headers.sh
  index 499235a41162,93c46d38024e..1f73e6f7438c
  --- a/tools/perf/check-headers.sh
  +++ b/tools/perf/check-headers.sh
  @@@ -28,7 -28,7 +28,11 @@@ arch/x86/include/asm/disabled-features.
    arch/x86/include/asm/required-features.h
    arch/x86/include/asm/cpufeatures.h
    arch/x86/include/asm/inat_types.h
  ++<<<<<<< HEAD
   +arch/x86/include/asm/emulate_prefix.h
  ++=3D=3D=3D=3D=3D=3D=3D
  + arch/x86/include/asm/msr-index.h
  ++>>>>>>> perf/core
    arch/x86/include/uapi/asm/prctl.h
    arch/x86/lib/x86-opcode-map.txt
    arch/x86/tools/gen-insn-attr-x86.awk
----->8---------->8---------->8-----

That's still on next-20191024.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org



> Thanks,
> Leo Yan
>
> > Metadata:
> > -----------------------------------------------------------------------=
-
> > kernel: 5.4.0-rc4
> > git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-ne=
xt.git
> > git branch: master
> > git commit: a722f75b2923b4fd44c17e7255e822ac48fe85f0
> > git describe: next-20191022
> > Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/ne=
xt-20191022
> >
> > Full build log:
> > https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=
=3Dlkft,MACHINE=3Dhikey,label=3Ddocker-lkft/631/consoleText
> >
> > - Naresh
