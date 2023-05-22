Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E52C7EE26
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 09:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjEVJ4e (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 05:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjEVJ4d (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 05:56:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F47D91
        for <linux-perf-users@vger.kernel.org>; Mon, 22 May 2023 02:56:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC26F11FB;
        Mon, 22 May 2023 02:57:11 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E77B3F6C4;
        Mon, 22 May 2023 02:56:25 -0700 (PDT)
Message-ID: <70a3b28e-9d44-3390-ce39-c2ea4d63eedc@arm.com>
Date:   Mon, 22 May 2023 10:56:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 05/17] tools headers UAPI: Sync the coresight-pmu
 headers copy with the kernel sources
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <cover.1683712944.git.siyanteng@loongson.cn>
 <3fffc3f39619d060dfbaa348904e1149f379638c.1683712945.git.siyanteng@loongson.cn>
 <ZFu7IG14QBQmIYJz@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <ZFu7IG14QBQmIYJz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/05/2023 16:41, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 10, 2023 at 06:22:50PM +0800, Yanteng Si escreveu:
>> Removing CORESIGHT_TRACE_ID_UNUSED_FLAG and CORESIGHT_TRACE_ID_UNUSED_VAL.
>>
>> Silencing these perf build warnings:
>>
>>   Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h'
>>    differs from latest version at 'include/linux/coresight-pmu.h'
>>   diff -u tools/include/linux/coresight-pmu.h include/linux
>>    /coresight-pmu.h
>>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> 
> I think this one, when built with 'make -DCORESIGHT=1' breaks the build,
> so I'm not applying it:
> 
>   CC      /tmp/build/perf-tools/util/parse-branch-options.o
> util/cs-etm-decoder/cs-etm-decoder.c: In function ‘cs_etm_decoder__create_etm_decoder’:
> util/cs-etm-decoder/cs-etm-decoder.c:671:51: error: ‘CORESIGHT_TRACE_ID_VAL_MASK’ undeclared (first use in this function)
>   671 |                 csid = (t_params->etmv3.reg_idr & CORESIGHT_TRACE_ID_VAL_MASK);
>       |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/cs-etm-decoder/cs-etm-decoder.c:671:51: note: each undeclared identifier is reported only once for each function it appears in
> util/cs-etm-decoder/cs-etm-decoder.c:695:21: error: ‘CORESIGHT_TRACE_ID_UNUSED_VAL’ undeclared (first use in this function)
>   695 |         if (csid == CORESIGHT_TRACE_ID_UNUSED_VAL)
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> make[5]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:98: /tmp/build/perf-tools/util/cs-etm-decoder/cs-etm-decoder.o] Error 1
> make[4]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:140: cs-etm-decoder] Error 2
> make[4]: *** Waiting for unfinished jobs....
>   LD      /tmp/build/perf-tools/util/hisi-ptt-decoder/perf-in.o
>   LD      /tmp/build/perf-tools/util/arm-spe-decoder/perf-in.o
> util/cs-etm.c: In function ‘cs_etm__metadata_get_trace_id’:
> util/cs-etm.c:246:39: error: ‘CORESIGHT_TRACE_ID_VAL_MASK’ undeclared (first use in this function)
>   246 |                                       CORESIGHT_TRACE_ID_VAL_MASK);
>       |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/cs-etm.c:246:39: note: each undeclared identifier is reported only once for each function it appears in
> util/cs-etm.c: In function ‘cs_etm__map_trace_ids_metadata’:
> util/cs-etm.c:3112:60: error: ‘CORESIGHT_TRACE_ID_VAL_MASK’ undeclared (first use in this function)
>  3112 |                         metadata[i][CS_ETM_ETMTRACEIDR] &= CORESIGHT_TRACE_ID_VAL_MASK;
>       |                                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/cs-etm.c: In function ‘cs_etm__clear_unused_trace_ids_metadata’:
> util/cs-etm.c:3144:63: error: ‘CORESIGHT_TRACE_ID_UNUSED_FLAG’ undeclared (first use in this function)
>  3144 |                         if (metadata[i][CS_ETM_ETMTRACEIDR] & CORESIGHT_TRACE_ID_UNUSED_FLAG)
>       |                                                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/cs-etm.c:3145:67: error: ‘CORESIGHT_TRACE_ID_UNUSED_VAL’ undeclared (first use in this function)
>  3145 |                                 metadata[i][CS_ETM_ETMTRACEIDR] = CORESIGHT_TRACE_ID_UNUSED_VAL;
>       |                                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> make[4]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:97: /tmp/build/perf-tools/util/cs-etm.o] Error 1
>   LD      /tmp/build/perf-tools/util/scripting-engines/perf-in.o
>   LD      /tmp/build/perf-tools/util/intel-pt-decoder/perf-in.o
> make[3]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:140: util] Error 2
> make[2]: *** [Makefile.perf:676: /tmp/build/perf-tools/perf-in.o] Error 2
> make[1]: *** [Makefile.perf:236: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf-tools/tools/perf'

Looks like these were only ever added to the tools side header which was
probably a mistake.

I can send a fix to move them and then re-copy the kernel header.
