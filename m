Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264FCC07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 18:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE9961351
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 18:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhGMTCH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMTCH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 15:02:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 816AA6135A;
        Tue, 13 Jul 2021 18:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626202756;
        bh=si4fYL4ChLt8IOLWC1AXFoyPXVzpCA1lUxRe9oXN6nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5ESw2Rs0k97V7oOvjuWB3bCFYemgtyn3BiV9zoRq7c4by0SbxxmATtAFqzAG0lud
         zT7HcjjuLLsqlXzGO/l9DPJo9L0h2kktbtAuT+j4k/cazpmiQakim/Wr3qgFz6Z8sT
         tDwSqY4tx1vbmaemMQtIul4yN6211fiF05PAGsSN2Hh8nz6fF6uGDb7AWPe+iAHULh
         7DOTajL6StMmCREc26MrteUwVVtoXiOZYafz/mLdlJUBiAxQgxbAWqT09z+1lbOuuQ
         /5imuUfS6zooZ6pRUDOBVCT6beoAs1TyetktPbNw+Eyq2KwR5pvesI95saTAPi+c8H
         TPpc863/iSUBw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A222A403F2; Tue, 13 Jul 2021 15:59:13 -0300 (-03)
Date:   Tue, 13 Jul 2021 15:59:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libperf: fix build error with LIBPFM4=1
Message-ID: <YO3igX8r8YG6FdQq@kernel.org>
References: <20210713091907.1555560-1-hca@linux.ibm.com>
 <YO1dngCS/v0j3cAE@krava>
 <YO3hUUqRv5R/AxI5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YO3hUUqRv5R/AxI5@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 13, 2021 at 03:54:09PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jul 13, 2021 at 11:32:14AM +0200, Jiri Olsa escreveu:
> > On Tue, Jul 13, 2021 at 11:19:07AM +0200, Heiko Carstens wrote:
> > > Fix build error with LIBPFM4=1:
> > >   CC      util/pfm.o
> > > util/pfm.c: In function ‘parse_libpfm_events_option’:
> > > util/pfm.c:102:30: error: ‘struct evsel’ has no member named ‘leader’
> > >   102 |                         evsel->leader = grp_leader;
> > >       |                              ^~
> > > 
> > > Fixes: fba7c86601e2 ("libperf: Move 'leader' from tools/perf to perf_evsel::leader")
> > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> Argh, we have this in 'make -C tools/perf build-test'
> 
> ⬢[acme@toolbox perf]$ grep libpfm tools/perf/tests/make
> make_with_libpfm4   := LIBPFM4=1
> run += make_with_libpfm4
> ⬢[acme@toolbox perf]$
> 
> But I forgot to install libpfm-devel :-\
> 
> Thanks, applied.

Before applying this patch and after installing libpfm-devel:

⬢[acme@toolbox perf]$ time make -C tools/perf build-test
make: Entering directory '/var/home/acme/git/perf/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
                 make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j24  DESTDIR=/tmp/tmp.Yh1LFyzmRo
              make_with_gtk2: cd . && make GTK2=1 -j24  DESTDIR=/tmp/tmp.cXprMRo2l
 <SNIP>
         make_no_libcrypto_O: cd . && make NO_LIBCRYPTO=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.e04E4H4uiD DESTDIR=/tmp/tmp.iiT6ClgH6T
                make_debug_O: cd . && make DEBUG=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.hkGg8pOdRg DESTDIR=/tmp/tmp.26JyYSi0Fi
               make_perf_o_O: cd . && make perf.o FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.TF9ttNOenZ DESTDIR=/tmp/tmp.aaKrGlKAj8
         make_with_libpfm4_O: cd . && make LIBPFM4=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.R55G8uq67s DESTDIR=/tmp/tmp.dK1T5E9UNC
cd . && make LIBPFM4=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.R55G8uq67s DESTDIR=/tmp/tmp.dK1T5E9UNC
  BUILD:   Doing 'make -j24' parallel build
  HOSTCC  /tmp/tmp.R55G8uq67s/fixdep.o
  HOSTLD  /tmp/tmp.R55G8uq67s/fixdep-in.o
  LINK    /tmp/tmp.R55G8uq67s/fixdep
Makefile.config:1042: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
  GEN     /tmp/tmp.R55G8uq67s/common-cmds.h
  CC      /tmp/tmp.R55G8uq67s/exec-cmd.o
  CC      /tmp/tmp.R55G8uq67s/help.o
  CC      /tmp/tmp.R55G8uq67s/pager.o
  PERF_VERSION = 5.14.rc1.g80343ca0f906
  CC      /tmp/tmp.R55G8uq67s/cpu.o
  MKDIR   /tmp/tmp.R55G8uq67s/fd/
  MKDIR   /tmp/tmp.R55G8uq67s/pmu-events/
  MKDIR   /tmp/tmp.R55G8uq67s/fs/
  MKDIR   /tmp/tmp.R55G8uq67s/fs/
  CC      /tmp/tmp.R55G8uq67s/debug.o
  CC      /tmp/tmp.R55G8uq67s/parse-options.o
 <SNIP>
  CC      /tmp/tmp.R55G8uq67s/util/perf-hooks.o
  CC      /tmp/tmp.R55G8uq67s/util/bpf-event.o
  CC      /tmp/tmp.R55G8uq67s/util/pfm.o
  FLEX    /tmp/tmp.R55G8uq67s/util/parse-events-flex.c
  FLEX    /tmp/tmp.R55G8uq67s/util/pmu-flex.c
  CC      /tmp/tmp.R55G8uq67s/util/pmu-bison.o
  FLEX    /tmp/tmp.R55G8uq67s/util/expr-flex.c
  CC      /tmp/tmp.R55G8uq67s/util/expr-bison.o
  CC      /tmp/tmp.R55G8uq67s/util/parse-events.o
  CC      /tmp/tmp.R55G8uq67s/util/parse-events-flex.o
  CC      /tmp/tmp.R55G8uq67s/util/pmu.o
  CC      /tmp/tmp.R55G8uq67s/util/pmu-flex.o
  CC      /tmp/tmp.R55G8uq67s/util/expr-flex.o
  CC      /tmp/tmp.R55G8uq67s/util/expr.o
util/pfm.c: In function ‘parse_libpfm_events_option’:
util/pfm.c:102:30: error: ‘struct evsel’ has no member named ‘leader’
  102 |                         evsel->leader = grp_leader;
      |                              ^~
make[6]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/tmp.R55G8uq67s/util/pfm.o] Error 1
make[6]: *** Waiting for unfinished jobs....
  LD      /tmp/tmp.R55G8uq67s/util/scripting-engines/perf-in.o
  LD      /tmp/tmp.R55G8uq67s/util/intel-pt-decoder/perf-in.o
make[5]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
make[4]: *** [Makefile.perf:655: /tmp/tmp.R55G8uq67s/perf-in.o] Error 2
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [Makefile.perf:238: sub-make] Error 2
make[2]: *** [Makefile:70: all] Error 2
make[1]: *** [tests/make:337: make_with_libpfm4_O] Error 1
make: *** [Makefile:103: build-test] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

real	4m55.864s
user	52m55.075s
sys	11m27.592s
⬢[acme@toolbox perf]$ rpm -q libpfm-devel
libpfm-devel-4.11.0-4.fc34.x86_64
⬢[acme@toolbox perf]$
