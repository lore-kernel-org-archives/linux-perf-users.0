From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Linux-next: 20191022: perf: bpf_helpers_doc.py: not found
Date: Tue, 22 Oct 2019 21:04:04 +0530
Message-ID: <CA+G9fYvWdkmmkrq7hvADZ-1qnUNEwRULoTPfOQDnu1aZW8cDEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux-Next Mailing List <linux-next@vger.kernel.org>, acme@kernel.org, open list <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Leo Yan <leo.yan@linaro.org>
Cc: lkft-triage@lists.linaro.org
List-Id: linux-perf-users.vger.kernel.org

We have noticed perf (OE recipe) build failure on linux next 20191022.
do you see this failure ?

/bin/sh: 1: perf/1.0-r9/perf-1.0/scripts/bpf_helpers_doc.py: not found
Makefile:184: recipe for target 'bpf_helper_defs.h' failed
make[3]: *** [bpf_helper_defs.h] Error 127
make[3]: *** Deleting file 'bpf_helper_defs.h'
Makefile.perf:765: recipe for target 'perf/1.0-r9/perf-1.0/libbpf.a' failed
make[2]: *** [perf/1.0-r9/perf-1.0/libbpf.a] Error 2

Metadata:
------------------------------------------------------------------------
kernel: 5.4.0-rc4
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: a722f75b2923b4fd44c17e7255e822ac48fe85f0
git describe: next-20191022
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191022

Full build log:
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=hikey,label=docker-lkft/631/consoleText

- Naresh
