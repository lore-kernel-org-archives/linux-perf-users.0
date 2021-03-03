Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64930C433DB
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 194EC64E6C
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359252AbhCDAYC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29328 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237674AbhCCK3C (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Mar 2021 05:29:02 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1238DroK076821;
        Wed, 3 Mar 2021 03:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=T9z8Tu8dz9loc0BH3nTlb50ZrY5cfdAfaEyEQEzuBkY=;
 b=HcAH0ZYiinzyJ9H8A2yKavru+R8+UuLH8Hoep+bd3K5laf21rQKFzl204DuPj2FKEFOP
 6sn1wS3k6ToY6eUJS7paUFMhQ+g6L/BGCZEsNXiqvt5wNJ2G7NkRWDswRLwkkd+vG8+l
 9FFyrhmYSUgvfdT9B5+b5liaR3OGml1COtMjq6BIEX8b2finEitn1E5R1NCRB5SfHCVK
 onpJJifiZ2n5P3BUR/i8029WAPeIe41+otPf629EqsCCAu0kA1FI/L0rcFj8WZoOjWsA
 vidAiEk0+lOuETh/cB2IxXG+ooy50av2G/FkwuaI1Kf8kZpXtD4AgxW7JJFTj6a1AUth NQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3726ru8fr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 03:23:37 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1238HPse025622;
        Wed, 3 Mar 2021 08:23:23 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 36yj531sxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 08:23:23 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1238NKEr64880988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Mar 2021 08:23:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32B6652057;
        Wed,  3 Mar 2021 08:23:20 +0000 (GMT)
Received: from li-e35baacc-2106-11b2-a85c-8f97eb669a6e.ibm.com (unknown [9.145.171.224])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CDA1152050;
        Wed,  3 Mar 2021 08:23:19 +0000 (GMT)
Subject: Re: [PATCH] perf test: Test case 27 fails on s390 and non-x86
 platforms
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20210302133119.3325530-1-tmricht@linux.ibm.com>
 <abcf63c1-8a15-14af-b449-77a943c94121@linux.intel.com>
 <7a14f6b6-967f-93bf-a030-44e358374502@linux.ibm.com>
 <785fc599-24c5-6eda-2807-2b79a9d89315@linux.intel.com>
 <753a61cb-e331-f91b-a1a9-e2fce2ecba52@linux.ibm.com>
 <2e7a6e34-12d8-004c-405f-307dc9b5ce66@linux.intel.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Message-ID: <7ced131d-962f-2615-6185-93bd01552029@linux.ibm.com>
Date:   Wed, 3 Mar 2021 09:23:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <2e7a6e34-12d8-004c-405f-307dc9b5ce66@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_08:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103030061
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 3/2/21 9:10 PM, Liang, Kan wrote:
> 
> 
> On 3/2/2021 12:08 PM, Thomas Richter wrote:
>> On 3/2/21 4:23 PM, Liang, Kan wrote:
>>>
>>>
>>> On 3/2/2021 9:48 AM, Thomas Richter wrote:
>>>> On 3/2/21 3:03 PM, Liang, Kan wrote:
>>>>>
>>>>> + Athira Rajeev
>>>>>
>>>>> On 3/2/2021 8:31 AM, Thomas Richter wrote:
>>>>>> Executing perf test 27 fails on s390:
>>>>>>     [root@t35lp46 perf]# ./perf test -Fv 27
>>>>>>     27: Sample parsing
>>>>>>     --- start ---
>>>>>>     ---- end ----
>>>>>>     Sample parsing: FAILED!
>>>>>>     [root@t35lp46 perf]#
>>>>>>
>>>>>> The root cause is
>>>>>> commit c7444297fd3769 ("perf test: Support PERF_SAMPLE_WEIGHT_STRUCT")
>>>>>> This commit introduced a test case for PERF_SAMPLE_WEIGHT_STRUCT
>>>>>> but does not adjust non-x86 weak linkage functions.
>>>>>>
>>>>>> The error is in test__sample_parsing() --> do_test()
>>>>>> Function do_test() defines two structures of type struct perf_sample named
>>>>>> sample and sample_out. The first sets member sample.ins_lat = 117
>>>>>>
>>>>>> Structure sample_out is constructed dynamically using functions
>>>>>> perf_event__synthesize_sample() and evsel__parse_sample().
>>>>>> Both functions have an x86 specific function version which sets member
>>>>>> ins_lat. The weak common functions do not set member ins_lat.
>>>>>>
>>>>>
>>>>> I don't think Power supports the instruction latency. As a request from Athira Rajeev, I moved the PERF_SAMPLE_WEIGHT_STRUCT to the X86 specific codes.
>>>>> https://lore.kernel.org/lkml/D97FEF4F-DD88-4760-885E-9A6161A9B48B@linux.vnet.ibm.com/
>>>>> https://lore.kernel.org/lkml/1612540912-6562-1-git-send-email-kan.liang@linux.intel.com/
>>>>>
>>>>> I don't think we want to add the ins_lat back in the weak common functions.
>>>>>
>>>>> Could you please update the perf test and don't apply the PERF_SAMPLE_WEIGHT_STRUCT for the non-X86 platform?
>>>>
>>>> I used offical linux git tree
>>>>    [root@t35lp46 perf]# git tag | fgrep 5.12
>>>> v5.12-rc1
>>>> [root@t35lp46 perf]#
>>>>
>>>> So this change is in the pipe. I do not plan to revert individual patches.
>>>
>>> No, we shouldn't revert the patch.
>>> I mean can you fix the issue in perf test?
>>> Don't test ins_lat or PERF_SAMPLE_WEIGHT_STRUCT for a non-X86 platform.
>>
>> That would be very ugly code. We would end up in conditional compiles like
>> #ifdef __s390x__
>> #endif
>> and other architectes like ARM/POWER etc come along. This is something I want to avoid.
>>
> 
> The ins_lat is a model specific variable. Maybe we should move it to the arch specific test.
> 
> 
>> And this fix only touches perf, not the kernel.
> 
> The patch changes the behavior of the PERF_SAMPLE_WEIGHT. The high 32 bit will be dropped. It should bring some problems if the high 32 bit contains valid information.
> 
>>
>>>>>
>>>>>
>>>>>> Later in function samples_same() both data in variable sample and sample_out
>>>>>> are compared. The comparison fails because sample.ins_lat is 117
>>>>>> and samples_out.ins_lat is 0, the weak functions never set member ins_lat.
>>>>>>
>>>>>> Output after:
>>>>>>     [root@t35lp46 perf]# ./perf test -Fv 27
>>>>>>     27: Sample parsing
>>>>>>     --- start ---
>>>>>>     ---- end ----
>>>>>>     Sample parsing: Ok
>>>>>> [root@t35lp46 perf]#
>>>>>>
>>>>>> Fixes:
>>>>>> commit c7444297fd3769 ("perf test: Support PERF_SAMPLE_WEIGHT_STRUCT")
>>>>>
>>>>> I think the regression should start from
>>>>> commit fbefe9c2f87f ("perf tools: Support arch specific PERF_SAMPLE_WEIGHT_STRUCT processing")
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Kan
>>>>
>>>> Kan,
>>>>
>>>> I do not follow you. Your commit c7444297fd3769d10c7ffb52c81d71503b3e268f
>>>> adds this line
>>>>
>>>> @@ -242,6 +245,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>>>>                   .cgroup         = 114,
>>>>                   .data_page_size = 115,
>>>>                   .code_page_size = 116,
>>>> +               .ins_lat        = 117,
>>>>
>>>> And this assignment 117 breaks the test. As mentioned before, member ins_lat is never touched
>>>> by the weak functions.
>>>>
>>>
>>> Here is the timeline for the patches.
>>>
>>> 1. The commit c7444297fd3769 and other SPR patches are merged at 2021-02-08. At that time, I don't think we have this issue. perf test should work well.
>>
>> Nope, that line above 'ins_lat = 117.' breaks the test. Comment it out and it works well!!!
> 
> If you revert the commit fbefe9c2f87f, perf test should work well too.
> 
> The root cause of the issue is that the commit fbefe9c2f87f change the ins_lat to a model-specific variable, but perf test still verify the variable in the generic test.
> 
> The below patch moves the PERF_SAMPLE_WEIGHT test into a X86 specific test.
> 
> Does it work for you?
> 
> ---
>  tools/perf/arch/x86/include/arch-tests.h   |   1 +
>  tools/perf/arch/x86/tests/Build            |   1 +
>  tools/perf/arch/x86/tests/arch-tests.c     |   4 +
>  tools/perf/arch/x86/tests/sample-parsing.c | 125 +++++++++++++++++++++++++++++
>  tools/perf/tests/sample-parsing.c          |   4 -
>  5 files changed, 131 insertions(+), 4 deletions(-)
>  create mode 100644 tools/perf/arch/x86/tests/sample-parsing.c
> 
> diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
> index 6a54b94..0e20f3d 100644
> --- a/tools/perf/arch/x86/include/arch-tests.h
> +++ b/tools/perf/arch/x86/include/arch-tests.h
> @@ -10,6 +10,7 @@ int test__rdpmc(struct test *test __maybe_unused, int subtest);
>  int test__insn_x86(struct test *test __maybe_unused, int subtest);
>  int test__intel_pt_pkt_decoder(struct test *test, int subtest);
>  int test__bp_modify(struct test *test, int subtest);
> +int test__x86_sample_parsing(struct test *test, int subtest);
> 
>  #ifdef HAVE_DWARF_UNWIND_SUPPORT
>  struct thread;
> diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
> index 36d4f24..28d7933 100644
> --- a/tools/perf/arch/x86/tests/Build
> +++ b/tools/perf/arch/x86/tests/Build
> @@ -3,5 +3,6 @@ perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
> 
>  perf-y += arch-tests.o
>  perf-y += rdpmc.o
> +perf-y += sample-parsing.o
>  perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-pkt-decoder-test.o
>  perf-$(CONFIG_X86_64) += bp-modify.o
> diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
> index bc25d72..71aa673 100644
> --- a/tools/perf/arch/x86/tests/arch-tests.c
> +++ b/tools/perf/arch/x86/tests/arch-tests.c
> @@ -31,6 +31,10 @@ struct test arch_tests[] = {
>      },
>  #endif
>      {
> +        .desc = "x86 Sample parsing",
> +        .func = test__x86_sample_parsing,
> +    },
> +    {
>          .func = NULL,
>      },
> 
> diff --git a/tools/perf/arch/x86/tests/sample-parsing.c b/tools/perf/arch/x86/tests/sample-parsing.c
> new file mode 100644
> index 0000000..28bbc61
> --- /dev/null
> +++ b/tools/perf/arch/x86/tests/sample-parsing.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdbool.h>
> +#include <inttypes.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <linux/bitops.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +
> +#include "map_symbol.h"
> +#include "branch.h"
> +#include "event.h"
> +#include "evsel.h"
> +#include "debug.h"
> +#include "util/synthetic-events.h"
> +
> +#include "tests/tests.h"
> +#include "arch-tests.h"
> +
> +#define COMP(m) do {                    \
> +    if (s1->m != s2->m) {                \
> +        pr_debug("Samples differ at '"#m"'\n");    \
> +        return false;                \
> +    }                        \
> +} while (0)
> +
> +static bool samples_same(const struct perf_sample *s1,
> +             const struct perf_sample *s2,
> +             u64 type)
> +{
> +    if (type & PERF_SAMPLE_WEIGHT_STRUCT)
> +        COMP(ins_lat);
> +
> +    return true;
> +}
> +
> +static int do_test(u64 sample_type, u64 read_format)
> +{
> +    struct evsel evsel = {
> +        .needs_swap = false,
> +        .core = {
> +            . attr = {
> +                .sample_type = sample_type,
> +                .read_format = read_format,
> +            },
> +        },
> +    };
> +    union perf_event *event;
> +    struct perf_sample sample = {
> +        .weight        = 101,
> +        .ins_lat        = 102,
> +    };
> +    struct perf_sample sample_out;
> +    size_t i, sz, bufsz;
> +    int err, ret = -1;
> +
> +    sz = perf_event__sample_event_size(&sample, sample_type, read_format);
> +    bufsz = sz + 4096; /* Add a bit for overrun checking */
> +    event = malloc(bufsz);
> +    if (!event) {
> +        pr_debug("malloc failed\n");
> +        return -1;
> +    }
> +
> +    memset(event, 0xff, bufsz);
> +    event->header.type = PERF_RECORD_SAMPLE;
> +    event->header.misc = 0;
> +    event->header.size = sz;
> +
> +    err = perf_event__synthesize_sample(event, sample_type, read_format,
> +                        &sample);
> +    if (err) {
> +        pr_debug("%s failed for sample_type %#"PRIx64", error %d\n",
> +             "perf_event__synthesize_sample", sample_type, err);
> +        goto out_free;
> +    }
> +
> +    /* The data does not contain 0xff so we use that to check the size */
> +    for (i = bufsz; i > 0; i--) {
> +        if (*(i - 1 + (u8 *)event) != 0xff)
> +            break;
> +    }
> +    if (i != sz) {
> +        pr_debug("Event size mismatch: actual %zu vs expected %zu\n",
> +             i, sz);
> +        goto out_free;
> +    }
> +
> +    evsel.sample_size = __evsel__sample_size(sample_type);
> +
> +    err = evsel__parse_sample(&evsel, event, &sample_out);
> +    if (err) {
> +        pr_debug("%s failed for sample_type %#"PRIx64", error %d\n",
> +             "evsel__parse_sample", sample_type, err);
> +        goto out_free;
> +    }
> +
> +    if (!samples_same(&sample, &sample_out, sample_type)) {
> +        pr_debug("parsing failed for sample_type %#"PRIx64"\n",
> +             sample_type);
> +        goto out_free;
> +    }
> +
> +    ret = 0;
> +out_free:
> +    free(event);
> +    if (ret && read_format)
> +        pr_debug("read_format %#"PRIx64"\n", read_format);
> +    return ret;
> +}
> +
> +/**
> + * test__x86_sample_parsing - test X86 specific sample parsing
> + *
> + * This function implements a test that synthesizes a sample event, parses it
> + * and then checks that the parsed sample matches the original sample.  The test
> + * checks sample format bits separately and together.  If the test passes %0 is
> + * returned, otherwise %-1 is returned.
> + *
> + * For now, PERF_SAMPLE_WEIGHT_STRUCT is the only X86 specific sample type.
> + */
> +int test__x86_sample_parsing(struct test *test __maybe_unused, int subtest __maybe_unused)
> +{
> +    return do_test(PERF_SAMPLE_WEIGHT_STRUCT, 0);
> +}
> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
> index 0dbe3aa..8fd8a4e 100644
> --- a/tools/perf/tests/sample-parsing.c
> +++ b/tools/perf/tests/sample-parsing.c
> @@ -129,9 +129,6 @@ static bool samples_same(const struct perf_sample *s1,
>      if (type & PERF_SAMPLE_WEIGHT)
>          COMP(weight);
> 
> -    if (type & PERF_SAMPLE_WEIGHT_STRUCT)
> -        COMP(ins_lat);
> -
>      if (type & PERF_SAMPLE_DATA_SRC)
>          COMP(data_src);
> 
> @@ -245,7 +242,6 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>          .cgroup        = 114,
>          .data_page_size = 115,
>          .code_page_size = 116,
> -        .ins_lat        = 117,
>          .aux_sample    = {
>              .size    = sizeof(aux_data),
>              .data    = (void *)aux_data,

Thanks Kan,

I had several issues applying your patch:

(Stripping trailing CRs from patch; use --binary to disable.)
patching file tools/perf/arch/x86/tests/sample-parsing.c
patch: **** malformed patch at line 421: parses it

...
[root@t35lp46 perf]# ./perf test -F 27
27: Sample parsing                                                  : Ok
[root@t35lp46 perf]# 

But as you can see, after applying your patch, the test works fine on
non-x86 platforms.

You have my Tested-by:

Please submit it to the mailing list.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
