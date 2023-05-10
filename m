Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E208BC77B7C
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 May 2023 15:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbjEJPlb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 11:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbjEJPlY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 11:41:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBECC3584
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 08:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 775096349F
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 15:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD639C4339B;
        Wed, 10 May 2023 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683733282;
        bh=sffcxF6jaSSBAUFYMT4AvfFyLh6ZF89eTtVZ38ITZOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N3KcdeMQeU0wcITt9rM2vGNUJctCq0UeymxAVyA1U539HApeyWu7eU6AHfRYMmknc
         7tym+iLaJ9FTVfnoBy0UMQ5G1Opmg83dzItPk3zfgJaJ5uBXEx4Ttilxe+b0GBJSEN
         AyXt/EOV7mNTdhCuYR/Tald1g8es6x3L32IjhHM4hejqj9i0hvtHWczABpVZV6v6Gf
         9e0FHVbodqiIGXIc9/7fF0obwP7guqRaI+xRjvmh9qfQRB13+my2WOnu0jcNHnGsJ1
         hfPTvVtdc9tz6QSGx8qIM/uGfiN/Qv8o/obQ2uC4fENs0Ku3JJYfUO0wRvBWW1DnQg
         RIQ+4clslySTg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5532E403B5; Wed, 10 May 2023 12:41:20 -0300 (-03)
Date:   Wed, 10 May 2023 12:41:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 05/17] tools headers UAPI: Sync the coresight-pmu
 headers copy with the kernel sources
Message-ID: <ZFu7IG14QBQmIYJz@kernel.org>
References: <cover.1683712944.git.siyanteng@loongson.cn>
 <3fffc3f39619d060dfbaa348904e1149f379638c.1683712945.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fffc3f39619d060dfbaa348904e1149f379638c.1683712945.git.siyanteng@loongson.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, May 10, 2023 at 06:22:50PM +0800, Yanteng Si escreveu:
> Removing CORESIGHT_TRACE_ID_UNUSED_FLAG and CORESIGHT_TRACE_ID_UNUSED_VAL.
> 
> Silencing these perf build warnings:
> 
>   Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h'
>    differs from latest version at 'include/linux/coresight-pmu.h'
>   diff -u tools/include/linux/coresight-pmu.h include/linux
>    /coresight-pmu.h
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

I think this one, when built with 'make -DCORESIGHT=1' breaks the build,
so I'm not applying it:

  CC      /tmp/build/perf-tools/util/parse-branch-options.o
util/cs-etm-decoder/cs-etm-decoder.c: In function ‘cs_etm_decoder__create_etm_decoder’:
util/cs-etm-decoder/cs-etm-decoder.c:671:51: error: ‘CORESIGHT_TRACE_ID_VAL_MASK’ undeclared (first use in this function)
  671 |                 csid = (t_params->etmv3.reg_idr & CORESIGHT_TRACE_ID_VAL_MASK);
      |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
util/cs-etm-decoder/cs-etm-decoder.c:671:51: note: each undeclared identifier is reported only once for each function it appears in
util/cs-etm-decoder/cs-etm-decoder.c:695:21: error: ‘CORESIGHT_TRACE_ID_UNUSED_VAL’ undeclared (first use in this function)
  695 |         if (csid == CORESIGHT_TRACE_ID_UNUSED_VAL)
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[5]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:98: /tmp/build/perf-tools/util/cs-etm-decoder/cs-etm-decoder.o] Error 1
make[4]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:140: cs-etm-decoder] Error 2
make[4]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf-tools/util/hisi-ptt-decoder/perf-in.o
  LD      /tmp/build/perf-tools/util/arm-spe-decoder/perf-in.o
util/cs-etm.c: In function ‘cs_etm__metadata_get_trace_id’:
util/cs-etm.c:246:39: error: ‘CORESIGHT_TRACE_ID_VAL_MASK’ undeclared (first use in this function)
  246 |                                       CORESIGHT_TRACE_ID_VAL_MASK);
      |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
util/cs-etm.c:246:39: note: each undeclared identifier is reported only once for each function it appears in
util/cs-etm.c: In function ‘cs_etm__map_trace_ids_metadata’:
util/cs-etm.c:3112:60: error: ‘CORESIGHT_TRACE_ID_VAL_MASK’ undeclared (first use in this function)
 3112 |                         metadata[i][CS_ETM_ETMTRACEIDR] &= CORESIGHT_TRACE_ID_VAL_MASK;
      |                                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
util/cs-etm.c: In function ‘cs_etm__clear_unused_trace_ids_metadata’:
util/cs-etm.c:3144:63: error: ‘CORESIGHT_TRACE_ID_UNUSED_FLAG’ undeclared (first use in this function)
 3144 |                         if (metadata[i][CS_ETM_ETMTRACEIDR] & CORESIGHT_TRACE_ID_UNUSED_FLAG)
      |                                                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
util/cs-etm.c:3145:67: error: ‘CORESIGHT_TRACE_ID_UNUSED_VAL’ undeclared (first use in this function)
 3145 |                                 metadata[i][CS_ETM_ETMTRACEIDR] = CORESIGHT_TRACE_ID_UNUSED_VAL;
      |                                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[4]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:97: /tmp/build/perf-tools/util/cs-etm.o] Error 1
  LD      /tmp/build/perf-tools/util/scripting-engines/perf-in.o
  LD      /tmp/build/perf-tools/util/intel-pt-decoder/perf-in.o
make[3]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:140: util] Error 2
make[2]: *** [Makefile.perf:676: /tmp/build/perf-tools/perf-in.o] Error 2
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf-tools/tools/perf'
