From: Leo Yan <leo.yan@linaro.org>
Subject: Re: Linux-next: 20191022: perf: bpf_helpers_doc.py: not found
Date: Wed, 23 Oct 2019 10:41:49 +0800
Message-ID: <20191023024149.GA29009@leoy-ThinkPad-X240s>
References: <CA+G9fYvWdkmmkrq7hvADZ-1qnUNEwRULoTPfOQDnu1aZW8cDEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+G9fYvWdkmmkrq7hvADZ-1qnUNEwRULoTPfOQDnu1aZW8cDEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, acme@kernel.org, open list <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, lkft-triage@lists.linaro.org
List-Id: linux-perf-users.vger.kernel.org

Hi Naresh,

On Tue, Oct 22, 2019 at 09:04:04PM +0530, Naresh Kamboju wrote:
> We have noticed perf (OE recipe) build failure on linux next 20191022.
> do you see this failure ?
> 
> /bin/sh: 1: perf/1.0-r9/perf-1.0/scripts/bpf_helpers_doc.py: not found
> Makefile:184: recipe for target 'bpf_helper_defs.h' failed
> make[3]: *** [bpf_helper_defs.h] Error 127
> make[3]: *** Deleting file 'bpf_helper_defs.h'
> Makefile.perf:765: recipe for target 'perf/1.0-r9/perf-1.0/libbpf.a' failed
> make[2]: *** [perf/1.0-r9/perf-1.0/libbpf.a] Error 2

I tested for two methods with linux-next, one is native building mode
for Arm64 building on DB410c board, another is cross compiling Arm64
binary on my x86 laptop.  Both cannot reproduce this failure.

After read your shared build log and I think the building process is
expected: Perf tool tries to build libbpf, so it changes to the
building folder 'BPF_DIR' (which is under $(srctree)/tools/lib/bpf/),
then failed to find file $(srctree)/scripts/bpf_helpers_doc.py.

Here $(srctree) means the kernel's root folder.

Seems to me, this failure is caused by missing to sync kernel files
$linux_src/scripts to the OE folder 'perf/1.0-r9/perf-1.0/scripts'?

Thanks,
Leo Yan

> Metadata:
> ------------------------------------------------------------------------
> kernel: 5.4.0-rc4
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> git branch: master
> git commit: a722f75b2923b4fd44c17e7255e822ac48fe85f0
> git describe: next-20191022
> Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191022
> 
> Full build log:
> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=hikey,label=docker-lkft/631/consoleText
> 
> - Naresh
