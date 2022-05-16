Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2A5C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 May 2022 12:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiEPMvS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 May 2022 08:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243160AbiEPMvJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 May 2022 08:51:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49793DEE2
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 05:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07117B811CE
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 12:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC17C34115;
        Mon, 16 May 2022 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652705465;
        bh=7hLBh5wKEwnDJOPkUv7iIYkrCY7K2aourchCDeUKtnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b84RNEvDycxval1K2fAixDVk6Spa6pdKqkfanM17LadyKFPgIKSotj+mEldCVL2wY
         wFJytCTEGUA1pfKczsszn/QBQFOYUtymIauSzUIkBM49M3vxQ+CboaQ8Sqvurbco5a
         /fpyQKbPg+MqUp7hmdyzOPx1+b0m2IFfJBpVbGivcZKdfBgBTqoOO5hApdLx72e8WB
         iab4Jpeg97haT09J1T69Hoa91BfRXzbgXMdzoHaRxQOfT1PvnMSa/9rdN2gnqnmAWx
         Acxoq3UC2KJLixSBu7WNiqILTTZn8RTex0LxLm4mf0cYkXwMbMR9L2qft/umYr4pHX
         IBWqg7HXSIxvw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 26155400B1; Mon, 16 May 2022 09:51:02 -0300 (-03)
Date:   Mon, 16 May 2022 09:51:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>
Subject: Re: File bench/numa.c compiler error on s390
Message-ID: <YoJItiE0xWDutZKR@kernel.org>
References: <00a443b1-92e0-8992-18ae-10e0e8489658@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00a443b1-92e0-8992-18ae-10e0e8489658@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, May 16, 2022 at 09:24:52AM +0200, Thomas Richter escreveu:
> Hi all,
> 
> I just upgraded to Fedora 36 and gcc version 12.0.1 20220308 (Red Hat 12.0.1-0) (GCC) 
> and run into this compiler error:

Humm, I regularly build on fedora 36 and didn't catch this :-\

[perfbuilder@five ~]$ grep gcc dm.log/fedora\:36
perf-5.18.0-rc6/tools/include/asm-generic/atomic-gcc.h
perf-5.18.0-rc6/tools/include/linux/compiler-gcc.h
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/12/lto-wrapper
Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,objc,obj-c++,ada,go,d,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --enable-libstdcxx-backtrace --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl=/builddir/build/BUILD/gcc-12.0.1-20220413/obj-x86_64-redhat-linux/isl-install --enable-offload-targets=nvptx-none --without-cuda-driver --enable-offload-defaulted --enable-gnu-indirect-function --enable-cet --with-tune=generic --with-arch_32=i686 --build=x86_64-redhat-linux --with-build-config=bootstrap-lto --enable-link-serialization=1
gcc version 12.0.1 20220413 (Red Hat 12.0.1-0) (GCC)
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/12
Selected GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/12
[perfbuilder@five ~]$

[perfbuilder@five ~]$ grep fedora:36 dm.log/summary
  51   125.79 fedora:36                     : Ok   gcc (GCC) 12.0.1 20220413 (Red Hat 12.0.1-0) , clang version 14.0.0 (Fedora 14.0.0-1.fc36)
[perfbuilder@five ~]$

[perfbuilder@five ~]$ grep TARBALL_HEAD dm.log/fedora\:36
BUILD_TARBALL_HEAD=c46721e4604f260918e660550a16d1e28637d66c
[perfbuilder@five ~]$

[acme@quaco perf-urgent]$ git log --oneline -5 
c46721e4604f2609 (HEAD -> perf/urgent, tag: perf-tools-fixes-for-v5.18-2022-05-14, five/perf/urgent, acme.korg/tmp.perf/urgent, acme.korg/perf/urgent) MAINTAINERS: Add James and Mike as Arm64 performance events reviewers
474e76c4075c1046 tools headers UAPI: Sync linux/kvm.h with the kernel sources
45fa7c38696bae63 perf tests: Fix coresight `perf test` failure.
183d4f2d23acecb2 perf bench: Fix two numa NDEBUG warnings
c5eb0a61238dd6fa (tag: v5.18-rc6) Linux 5.18-rc6
[acme@quaco perf-urgent]$

[acme@quaco perf-urgent]$ git log --oneline -10 tools/perf/bench/numa.c
183d4f2d23acecb2 perf bench: Fix two numa NDEBUG warnings
f58faed7fb3f784e (tag: perf-tools-fixes-for-v5.18-2022-04-14) perf bench: Fix numa bench to fix usage of affinity for machines with #CPUs > 1K
8cb7a188ac33b71e perf bench: Fix numa testcase to check if CPU used to bind task is online
4d39c89f0b94bf4a perf tools: Fix various typos in comments
394e4306b093d037 perf bench numa: Fix the condition checks for max number of NUMA nodes
f92993851f01fa5d perf bench: Use condition variables in numa.
a508d061ef04b163 perf bench numa: Remove dead code in parse_nodes_opt()
2db13a9b30f7e438 perf bench numa: Use numa_node_to_cpus() to bind tasks to nodes
509f68e327d0c87e perf bench numa: Fix cpumask memory leak in node_has_cpus()
85372c6974aad0e4 perf bench numa: Fix benchmark names
[acme@quaco perf-urgent]$

> CC      bench/numa.o
> bench/numa.c: In function ‘__bench_numa’:
> bench/numa.c:1749:81: error: ‘%d’ directive output may be truncated writing between 1 and 11
>  bytes into a region of size between 10 and 20 [-Werror=format-truncation=]
>  1749 |           snprintf(tname, sizeof(tname), "process%d:thread%d", p, t);
>       |                                                           ^~
> bench/numa.c:1749:64: note: directive argument in the range [-2147483647, 2147483646]
>  1749 |           snprintf(tname, sizeof(tname), "process%d:thread%d", p, t);
>       |                                                   ^~~~~~~~~~~~~~~~~~~~
> bench/numa.c:1749:33: note: ‘snprintf’ output between 17 and 37 bytes into a destination of size 35
>  1749 |           snprintf(tname, sizeof(tname), "process%d:thread%d", p, t);
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [/root/linux/tools/build/Makefile.build:97: bench/numa.o] Error 1
> 
> Does this also show up on other plattforms?
> 
> Looks like commit 3aff8ba0a4c9 ("perf bench numa: Avoid possible truncation when using snprintf()")
> has fixed this issue before and now it reappeared.
> 
> -- 
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Geschäftsführung: David Faller
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

-- 

- Arnaldo
