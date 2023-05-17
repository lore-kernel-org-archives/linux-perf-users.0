Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3554CC77B75
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 May 2023 15:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjEQPGH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 May 2023 11:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjEQPFr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 May 2023 11:05:47 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16810A5EA
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 08:05:14 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-ba1815e12efso676987276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684335911; x=1686927911;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Hy3S/uLeBJ9wbvFj8d26FLWVZjY/CD9djb2cwqZy34=;
        b=T/WYkkiHWMusiXUZTwjMzyHLY6Orz4UuXXFlZJTaouPK9IL7H5ErB2u7JAXXvtF3vI
         HTMnAKIGK7Oh0Xp0COrXEW8A5zrC9dV14isKDfm+5bIv9QNmdP990cCbsXM8ZGOWxPHl
         uyzSJTDQ/b/tAEfnjl+rdPX89NP9BHmM0ZK8o+qgCHfYmSL9F0ezWCrpTu1NJk2MiFya
         jAHg5qZAEPchSZeHY27XeMVC2FxYbRiZO4YIFRBCKXoeTiQN2zEArWTHvvZF9hiuT3DH
         QXpFdymSj93HmlqqlhQU+cIIxTxqz+2npp4HkWW+C9yWPhmlFokj+86wf+i9ua9LR/9W
         VgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335911; x=1686927911;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Hy3S/uLeBJ9wbvFj8d26FLWVZjY/CD9djb2cwqZy34=;
        b=fekQoamDN4tUFNgchCG3Zf16HpoGNQDZLDND1A0EHCRgqa+1BevoPR97NA1CqzXUrc
         6qXcXcO/WvZEyc/D00v94W+s6OdWZVYJ/FOzUNt0kaBRN67iCEwQ4yStyWyoksEVphRL
         WlX7wczgAcexpaDvDziNOnmUMigS9LTtfp6TyfwgXTMgUWXQu92nhoYEgtabDoSTI9bl
         XNq3qSBd5mKAC0kfl8FTihjR9jZDPQtR1aJ+wn35TEs0ShCg3wjU+aDrraqfsCZLlR8O
         qLB7TUprrEwk/fbgVMerHjvErsSSE6Nmuz+HApbvNM4P4cKWQmVffyH8rt1KxNVzMUxG
         Z5wg==
X-Gm-Message-State: AC+VfDwpy79Aa8gPX2hT5q64wVBjwyTGFt2vhD+v8K8Q6J6RLoishq2E
        s+uz013XGkoPMnjXhMVTSsEyHPm80P08Cd3v5NYrRQ==
X-Google-Smtp-Source: ACHHUZ7D6NuHwORKshX3NmiXkO5zOiVNEny2VwT8YmVta8L5cjWpUWNB5G+eC5ugovKpugcv3xQ6RidsBuX4195wB/E=
X-Received: by 2002:a05:7500:2cb:b0:101:b5c1:6721 with SMTP id
 i11-20020a05750002cb00b00101b5c16721mr61462gai.27.1684335910923; Wed, 17 May
 2023 08:05:10 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 May 2023 20:34:59 +0530
Message-ID: <CA+G9fYvgBR1iB0CorM8OC4AM_w_tFzyQKHc+rF6qPzJL=TbfDQ@mail.gmail.com>
Subject: next: perf: i386: bench/syscall.c:101:22: error: '__NR_execve'
 undeclared (first use in this function)
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, lkft-triage@lists.linaro.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Linux next perf build failing for i386 architecture.
 - build/gcc-11-lkftconfig-perf

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
  CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/bench/syscall.o
  CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/tests/parse-events.o
  CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/build-id.o
  CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/cacheline.o
  CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/config.o
  CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/copyfile.o
  CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/bench/mem-functions.o
bench/syscall.c: In function 'bench_syscall_common':
bench/syscall.c:101:22: error: '__NR_execve' undeclared (first use in
this function)
  101 |                 case __NR_execve:
      |                      ^~~~~~~~~~~
bench/syscall.c:101:22: note: each undeclared identifier is reported
only once for each function it appears in
bench/syscall.c: In function 'bench_syscall_execve':
bench/syscall.c:183:49: error: '__NR_execve' undeclared (first use in
this function)
  183 |         return bench_syscall_common(argc, argv, __NR_execve);
      |                                                 ^~~~~~~~~~~
bench/syscall.c:184:1: error: control reaches end of non-void function
[-Werror=return-type]
  184 | }
      | ^
cc1: all warnings being treated as errors

logs:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230517/testrun/17031014/suite/build/test/gcc-11-lkftconfig-perf/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230517/testrun/17031014/suite/build/test/gcc-11-lkftconfig-perf/history/


Steps to reproduce:
=============
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.
# tuxmake   \
 --runtime podman   \
 --target-arch i386   \
 --toolchain gcc-11   \
 --kconfig defconfig   \
 --kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/lkft.config
  \
 --kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/lkft-crypto.config
  \
 --kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/distro-overrides.config
  \
 --kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/systemd.config
  \
 --kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/virtio.config
  \
 --kconfig-add CONFIG_IGB=y   \
 --kconfig-add CONFIG_UNWINDER_FRAME_POINTER=y   \
 --kconfig-add CONFIG_SYN_COOKIES=y   \
 --kconfig-add CONFIG_FTRACE_SYSCALLS=y NO_BPF_SKEL=1 debugkernel
headers kernel modules perf


--
Linaro LKFT
https://lkft.linaro.org
