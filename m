Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9316DC07E95
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 18:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A90561CC9
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 18:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhGGShD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 14:37:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230481AbhGGShD (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 14:37:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3425161CBE;
        Wed,  7 Jul 2021 18:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625682862;
        bh=EZhXqLJ9GU0ND6GPzxWqhR9qRBz/WNLDPFdlJUX8i8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZS+dmzAgiWsGUZztqLO/NVaUAdIp47XMY+/e6SNSUlP0ZTv6u1dMneFCwVAkhtYU
         w0gnfIZhwtZ1RXnnCH5hhZSk8WZ3eymS7cCtQX8WE0PbdhNty3wESG1HXtgZt4KaZS
         6Lv2OVBDtdEzuo19bfJ9eUCwNTZpW7S6/ue2pp/e827nkDCB28fE+vuVPD16A+/NCX
         e0jUORbIfPAdqqi0xndFKeW00auUhXrW8scDQYPTkrug/1gLZh0zGxJ/fBmKWceosn
         nv6j2fKea4duRG1mVAIIO+lsT3p3dhRBSx57buiZ5uxbs6wehqMhwUvGV7/CWG7wtO
         JbdXRbUtb6xSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CFFF540B1A; Wed,  7 Jul 2021 15:34:19 -0300 (-03)
Date:   Wed, 7 Jul 2021 15:34:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/7] libperf: Move leader to perf_evsel::leader
Message-ID: <YOXzq9irKEL2mMmr@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-4-jolsa@kernel.org>
 <YOW/5+Ep7JpL4qLL@kernel.org>
 <YOXu7PPoaJ0cpeQI@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOXu7PPoaJ0cpeQI@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jul 07, 2021 at 08:14:04PM +0200, Jiri Olsa escreveu:
> On Wed, Jul 07, 2021 at 11:53:27AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jul 06, 2021 at 05:17:00PM +0200, Jiri Olsa escreveu:
> > > Moving evsel::leader to perf_evsel::leader, so we can move
> > > the group interface to libperf.
> > 
> > I also had to apply this, because you didn't build with
> > BUILD_BPF_SKEL=1, right?
> 
> ah right.. I also plan to build in arm/s390/ppc,
> so I'll take what you have in tmp.perf/core

Ok, just pushed, so far so good, the android ones are unrelated, some
cross-builds already passed with debian:experimental

[perfbuilder@five ~]$ export PERF_TARBALL=http://192.168.100.2/perf/perf-5.13.0.tar.xz
[perfbuilder@five ~]$ time dm
Wed Jul  7 02:56:10 PM -03 2021
# export PERF_TARBALL=http://192.168.100.2/perf/perf-5.13.0.tar.xz
# dm
   1    95.13 almalinux:8                   : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.0 (Red Hat 11.0.0-1.module_el8.4.0+2107+39fed697)
   2    69.95 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   3    71.37 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   4    75.00 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   5    91.85 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   6    83.13 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   7    86.74 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   8   113.74 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   9   134.59 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
  10   117.15 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  11   125.76 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1
  12   112.50 alpine:edge                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  13    68.75 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  14    86.52 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
  15    84.62 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 10.2.1 20210313 (ALT Sisyphus 10.2.1-alt3) , clang version 10.0.1
  16    64.95 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  17    90.32 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  18     6.80 android-ndk:r12b-arm          : FAIL gcc version 4.9.x 20150123 (prerelease) (GCC)
                     from util/intel-pt-decoder/intel-pt-insn-decoder.c:15:
    /git/perf-5.13.0/tools/include/linux/kconfig.h:10:0: error: "__LITTLE_ENDIAN" redefined [-Werror]
     #define __LITTLE_ENDIAN 1234
     ^
    In file included from /opt/android-ndk-r12b/platforms/android-24/arch-arm/usr/include/endian.h:31:0,
                     from /git/perf-5.13.0/tools/include/linux/kernel.h:10,
                     from util/intel-pt-decoder/intel-pt-insn-decoder.c:7:
    /opt/android-ndk-r12b/platforms/android-24/arch-arm/usr/include/sys/endian.h:39:0: note: this is the location of the previous definition
     #define __LITTLE_ENDIAN _LITTLE_ENDIAN
     ^
    cc1: all warnings being treated as errors
    make[4]: *** [/git/perf-5.13.0/tools/build/Makefile.build:139: intel-pt-decoder] Error 2
  19     6.99 android-ndk:r15c-arm          : FAIL gcc version 4.9.x 20150123 (prerelease) (GCC)
                     from util/intel-pt-decoder/intel-pt-insn-decoder.c:15:
    /git/perf-5.13.0/tools/include/linux/kconfig.h:10:0: error: "__LITTLE_ENDIAN" redefined [-Werror]
     #define __LITTLE_ENDIAN 1234
     ^
    In file included from /opt/android-ndk-r15c/platforms/android-26/arch-arm/usr/include/endian.h:31:0,
                     from /git/perf-5.13.0/tools/include/linux/kernel.h:10,
                     from util/intel-pt-decoder/intel-pt-insn-decoder.c:7:
    /opt/android-ndk-r15c/platforms/android-26/arch-arm/usr/include/sys/endian.h:39:0: note: this is the location of the previous definition
     #define __LITTLE_ENDIAN _LITTLE_ENDIAN
     ^
    cc1: all warnings being treated as errors
    make[4]: *** [/git/perf-5.13.0/tools/build/Makefile.build:139: intel-pt-decoder] Error 2
  20    98.76 centos:8                      : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5) , clang version 10.0.1 (Red Hat 10.0.1-1.module_el8.3.0+467+cb298d5b)
  21    59.86 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.1.1 20210624 releases/gcc-11.1.0-356-gf19b20de1b , clang version 11.1.0
  22    79.48 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  23    72.76 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  24    72.25 debian:experimental           : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  25    28.49 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
  26    24.46 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
  27    26.17 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110
  28    26.97 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
  29    24.97 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  30    64.61 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
