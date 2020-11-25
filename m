Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD13C56201
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Nov 2020 17:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243EC206D9
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Nov 2020 17:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0k3UB1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbgKYR17 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Nov 2020 12:27:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732784AbgKYR17 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Nov 2020 12:27:59 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED6DA206B5;
        Wed, 25 Nov 2020 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606325278;
        bh=XOC0jPLSISCUMYFn8Jyd1Jb8ebro+R0p/1c3lAiWF2w=;
        h=Date:From:To:Cc:Subject:From;
        b=b0k3UB1b0JhTC+Qzq4fgNuYtQTyVMRlD25BqxhOYRILtpdaIqNDFvWODjGn6DAXxq
         EjGi6sRgruoIE5o0GItGTnKGA3CIfbWjN/m+rjU9p/OYQJqSi+iSrJNvs55hlfnCYU
         g1G+m6ghVKeT/SxTXv2EmK6fmE/zZkwHtOiMSsH4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3FBA140E29; Wed, 25 Nov 2020 14:27:55 -0300 (-03)
Date:   Wed, 25 Nov 2020 14:27:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: [BUG] perf probe can't remove probes
Message-ID: <20201125172755.GA53351@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


Masami, have you stumbled on this already?

[root@seventh ~]# perf probe security_locked_down%return 'ret=$retval'
Added new event:
  probe:security_locked_down__return (on security_locked_down%return with ret=$retval)

You can now use it in all perf tools, such as:

	perf record -e probe:security_locked_down__return -aR sleep 1

[root@seventh ~]# perf probe security_locked_down what
Added new event:
  probe:security_locked_down (on security_locked_down with what)

You can now use it in all perf tools, such as:

	perf record -e probe:security_locked_down -aR sleep 1

[root@seventh ~]#


[root@seventh ~]# uname -r
5.10.0-rc3.bpfsign+
[root@seventh ~]# perf probe -l
  probe:security_locked_down (on security_locked_down@git/bpf/security/security.c with what)
  probe:security_locked_down__return (on security_locked_down%return@git/bpf/security/security.c with ret)
[root@seventh ~]# perf probe -D '*:*'
Semantic error :There is non-digit char in line number.

 Usage: perf probe [<options>] 'PROBEDEF' ['PROBEDEF' ...]
    or: perf probe [<options>] --add 'PROBEDEF' [--add 'PROBEDEF' ...]
    or: perf probe [<options>] --del '[GROUP:]EVENT' ...
    or: perf probe --list [GROUP:]EVENT ...
    or: perf probe [<options>] --line 'LINEDESC'
    or: perf probe [<options>] --vars 'PROBEPOINT'
    or: perf probe [<options>] --funcs

    -D, --definition <[EVENT=]FUNC[@SRC][+OFF|%return|:RL|;PT]|SRC:AL|SRC;PT [[NAME=]ARG ...]>
                          Show trace event definition of given traceevent for k/uprobe_events.
[root@seventh ~]# perf probe probe:security_locked_down
Semantic error :There is non-digit char in line number.
  Error: Command Parse Error.
[root@seventh ~]# perf probe probe:security_locked_down__return
Semantic error :There is non-digit char in line number.
  Error: Command Parse Error.
[root@seventh ~]# cat /sys/kernel/debug/kprobes/
blacklist  enabled    list
[root@seventh ~]# cat /sys/kernel/debug/kprobes/list
ffffffff8248b350  k  security_locked_down+0x0    [FTRACE]
ffffffff8248b350  r  security_locked_down+0x0    [FTRACE]
[root@seventh ~]#

[root@seventh ~]# cat /etc/fedora-release
Fedora release 33 (Thirty Three)
[root@seventh ~]# gcc -v
Using built-in specs.
COLLECT_GCC=/usr/bin/gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/10/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none
OFFLOAD_TARGET_DEFAULT=1
Target: x86_64-redhat-linux
Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,objc,obj-c++,ada,go,d,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl --enable-offload-targets=nvptx-none --without-cuda-driver --enable-gnu-indirect-function --enable-cet --with-tune=generic --with-arch_32=i686 --build=x86_64-redhat-linux
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 10.2.1 20201016 (Red Hat 10.2.1-6) (GCC)
[root@seventh ~]# rpm -q elfutils
elfutils-0.182-1.fc33.x86_64
[root@seventh ~]#

- Arnaldo
