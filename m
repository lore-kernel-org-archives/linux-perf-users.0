Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623F7C432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 16:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462446069E
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 16:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhIAQR5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 12:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234245AbhIAQR4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 12:17:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2DD5601FD;
        Wed,  1 Sep 2021 16:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630513019;
        bh=5pSAWpSlrsZZiZRs15r0OlkZzxUGWP7tyBbPSRRp7Qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dN+iBfpRX5sAykDrQmN4mfjJw32kPp3ffOHhmnLgdVvAz2ceAeLPKIUXPFGRV+F3R
         /qnp/egFXD/YYSKOeNCsIfMXai9HDmkkthZEO34QVziCqI0NKQ19wmVz+pjbagqf1Q
         Hu2OKKEGPg14G4HXId1o5ANqYm8Zi8enH+bPMCn2aVxihucJ0c28gwzOt+0ImC86py
         /g9S9cuV0ztxAKVW/Wh9LhoNQBUcmy7g1kOkPqE5nhmH9HRMSFam+dgPrIJxMze/zL
         PxN27yHXb0cZaZi9VYGfhpXf8gxzyhOfdXIgBsYZz3gy9d0nadxXKapFxlfPksn8yQ
         MTh0mDH29Fx9g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 331A94007E; Wed,  1 Sep 2021 13:16:56 -0300 (-03)
Date:   Wed, 1 Sep 2021 13:16:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] perf cs-etm: Show a warning for an unknown magic
 number
Message-ID: <YS+neCZler56Hs2D@kernel.org>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-10-james.clark@arm.com>
 <20210824083615.GF204566@leoy-ThinkPad-X240s>
 <YS+iOrcPTzQfmbqU@kernel.org>
 <YS+lTXyuC+9VTrxd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YS+lTXyuC+9VTrxd@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Sep 01, 2021 at 01:07:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Sep 01, 2021 at 12:54:34PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Aug 24, 2021 at 04:36:15PM +0800, Leo Yan escreveu:
> > > On Fri, Aug 06, 2021 at 02:41:09PM +0100, James Clark wrote:
> > > > Currently perf reports "Cannot allocate memory" which isn't very helpful
> > > > for a potentially user facing issue. If we add a new magic number in
> > > > the future, perf will be able to report unrecognised magic numbers.
> > > > 
> > > > Signed-off-by: James Clark <james.clark@arm.com>
> > > 
> > > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > 
> > Applies cleanly to my tree, test building it now, holler if there is
> > something that prevents it from being merged.
> 
> I´m now trying to fix this up, I applied it using 'b4', so no patch
> should have gone missing...

So its probably related to:

⬢[acme@toolbox perf]$ rpm -qa | grep opencsd
opencsd-1.0.0-1.fc34.x86_64
opencsd-devel-1.0.0-1.fc34.x86_64
⬢[acme@toolbox perf]$

In which case the usual mechanism is to test if we have what is needed
via tools/build/feature/test-_____.c, lemme check...

- Arnaldo
 
> ⬢[acme@toolbox perf]$ time make -C tools/perf build-test
> make: Entering directory '/var/home/acme/git/perf/tools/perf'
> - tarpkg: ./tests/perf-targz-src-pkg .
>                  make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j24  DESTDIR=/tmp/tmp.tw23W3JC1W
>               make_with_gtk2: cd . && make GTK2=1 -j24  DESTDIR=/tmp/tmp.F7gN4e98pK
>                  make_tags_O: cd . && make tags FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.tQVbhFdXKU DESTDIR=/tmp/tmp.1vbvWgUYUv
>              make_no_slang_O: cd . && make NO_SLANG=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.2L0POmKIip DESTDIR=/tmp/tmp.0qTYEQTY8e
>           make_no_demangle_O: cd . && make NO_DEMANGLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.Wh3kRYOFJo DESTDIR=/tmp/tmp.ih1nESGU6N
>                make_no_sdt_O: cd . && make NO_SDT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.zw3NugHqvZ DESTDIR=/tmp/tmp.li1bxbfYOZ
>          make_no_backtrace_O: cd . && make NO_BACKTRACE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.66VxfiD04f DESTDIR=/tmp/tmp.PIgwBwGEZz
>        make_install_prefix_O: cd . && make install prefix=/tmp/krava FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.s6u85zKKjU DESTDIR=/tmp/tmp.2FJoF1mCRB
>        make_with_coresight_O: cd . && make CORESIGHT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.kQs4YxWFpL DESTDIR=/tmp/tmp.z93leAThcc
> cd . && make CORESIGHT=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.kQs4YxWFpL DESTDIR=/tmp/tmp.z93leAThcc
>   BUILD:   Doing 'make -j24' parallel build
>   HOSTCC  /tmp/tmp.kQs4YxWFpL/fixdep.o
>   HOSTLD  /tmp/tmp.kQs4YxWFpL/fixdep-in.o
>   LINK    /tmp/tmp.kQs4YxWFpL/fixdep
> Makefile.config:1038: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
>   GEN     /tmp/tmp.kQs4YxWFpL/common-cmds.h
>   CC      /tmp/tmp.kQs4YxWFpL/exec-cmd.o
>   CC      /tmp/tmp.kQs4YxWFpL/help.o
>   <SNIP>
>   CC      /tmp/tmp.kQs4YxWFpL/util/auxtrace.o
>   MKDIR   /tmp/tmp.kQs4YxWFpL/util/intel-pt-decoder/
>   CC      /tmp/tmp.kQs4YxWFpL/util/intel-pt-decoder/intel-pt-pkt-decoder.o
>   MKDIR   /tmp/tmp.kQs4YxWFpL/util/arm-spe-decoder/
>   MKDIR   /tmp/tmp.kQs4YxWFpL/util/arm-spe-decoder/
>   CC      /tmp/tmp.kQs4YxWFpL/util/arm-spe-decoder/arm-spe-pkt-decoder.o
>   CC      /tmp/tmp.kQs4YxWFpL/util/arm-spe-decoder/arm-spe-decoder.o
>   MKDIR   /tmp/tmp.kQs4YxWFpL/util/intel-pt-decoder/
>   GEN     /tmp/tmp.kQs4YxWFpL/util/intel-pt-decoder/inat-tables.c
>   MKDIR   /tmp/tmp.kQs4YxWFpL/util/cs-etm-decoder/
>   CC      /tmp/tmp.kQs4YxWFpL/util/cs-etm-decoder/cs-etm-decoder.o
>   CC      /tmp/tmp.kQs4YxWFpL/util/intel-pt-decoder/intel-pt-log.o
>   MKDIR   /tmp/tmp.kQs4YxWFpL/util/scripting-engines/
>   CC      /tmp/tmp.kQs4YxWFpL/util/scripting-engines/trace-event-perl.o
>   CC      /tmp/tmp.kQs4YxWFpL/util/intel-bts.o
>   MKDIR   /tmp/tmp.kQs4YxWFpL/util/scripting-engines/
>   CC      /tmp/tmp.kQs4YxWFpL/util/intel-pt.o
>   CC      /tmp/tmp.kQs4YxWFpL/util/scripting-engines/trace-event-python.o
>   CC      /tmp/tmp.kQs4YxWFpL/util/arm-spe.o
>   CC      /tmp/tmp.kQs4YxWFpL/util/s390-cpumsf.o
> util/cs-etm-decoder/cs-etm-decoder.c:161:44: error: unknown type name ‘ocsd_ete_cfg’; did you mean ‘ocsd_stm_cfg’?
>   161 |                                            ocsd_ete_cfg *config)
>       |                                            ^~~~~~~~~~~~
>       |                                            ocsd_stm_cfg
> util/cs-etm-decoder/cs-etm-decoder.c: In function ‘cs_etm_decoder__create_etm_decoder’:
> util/cs-etm-decoder/cs-etm-decoder.c:620:9: error: unknown type name ‘ocsd_ete_cfg’; did you mean ‘ocsd_stm_cfg’?
>   620 |         ocsd_ete_cfg trace_config_ete;
>       |         ^~~~~~~~~~~~
>       |         ocsd_stm_cfg
> util/cs-etm-decoder/cs-etm-decoder.c:639:17: error: implicit declaration of function ‘cs_etm_decoder__gen_ete_config’; did you mean ‘cs_etm_decoder__gen_etmv4_config’? [-Werror=implicit-function-declaration]
>   639 |                 cs_etm_decoder__gen_ete_config(t_params, &trace_config_ete);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                 cs_etm_decoder__gen_etmv4_config
> cc1: all warnings being treated as errors
> make[7]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:97: /tmp/tmp.kQs4YxWFpL/util/cs-etm-decoder/cs-etm-decoder.o] Error 1
> make[6]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: cs-etm-decoder] Error 2
> make[6]: *** Waiting for unfinished jobs....
>   CC      /tmp/tmp.kQs4YxWFpL/util/intel-pt-decoder/intel-pt-decoder.o
>   CC      /tmp/tmp.kQs4YxWFpL/util/intel-pt-decoder/intel-pt-insn-decoder.o
>   LD      /tmp/tmp.kQs4YxWFpL/util/arm-spe-decoder/perf-in.o
>   LD      /tmp/tmp.kQs4YxWFpL/util/scripting-engines/perf-in.o
>   LD      /tmp/tmp.kQs4YxWFpL/util/intel-pt-decoder/perf-in.o
> make[5]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
> make[4]: *** [Makefile.perf:658: /tmp/tmp.kQs4YxWFpL/perf-in.o] Error 2
> rm /tmp/tmp.kQs4YxWFpL/dlfilters/dlfilter-test-api-v0.o
> make[3]: *** [Makefile.perf:238: sub-make] Error 2
> make[2]: *** [Makefile:70: all] Error 2
> make[1]: *** [tests/make:337: make_with_coresight_O] Error 1
> make: *** [Makefile:103: build-test] Error 2
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
> 
> real	1m23.257s
> user	13m37.871s
> sys	2m53.438s
> ⬢[acme@toolbox perf]$
> ⬢[acme@toolbox perf]$
> 
> 

-- 

- Arnaldo
