Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAA1C433DB
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A808D64EA4
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350207AbhCDAYC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1582392AbhCCICw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Mar 2021 03:02:52 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1237XYQ9161549;
        Wed, 3 Mar 2021 02:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=w5RGtsjR3zM0tt6qRagENt1Q3skCtpUR1xMc/hVsTHI=;
 b=sopsnGLTOWLQvufuc4r7okqiBmroftfcTRHEJ9zp8dSYkYQuq0obWMeUZ7ldCTdSsjQ2
 whIFjv1Ycvql4y06yWjYQCXBWAENo7SS5y28PARYhTmQD95ZKRhAw//WBqlGp7zGVImo
 nSl5102eRDEjjlfji6S/tUUHTA7MRrYoPTAqpvO9hbzZwilP1wRAsYuHcVIUztk48y5u
 Z6TRWtHh03zTpouisdxC/w4FW9uG8Oka2F/oQDczlZ9EgC8opOheXhsIDDS3AILgMKQb
 Qg1BwwD6QervnUbHo4gLeIbTggdeO1yqTDe0tJdkzmNGP4qXNYJP1oIc6ICBDDgEcnFk 7g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37254vb72x-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 02:54:42 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1237X0Qr016813;
        Wed, 3 Mar 2021 07:33:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 370c59tkhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 07:33:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1237WvfX40567094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Mar 2021 07:32:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35548A405F;
        Wed,  3 Mar 2021 07:32:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F29DA405C;
        Wed,  3 Mar 2021 07:32:38 +0000 (GMT)
Received: from [9.124.216.130] (unknown [9.124.216.130])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  3 Mar 2021 07:32:37 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] perf test: Test case 27 fails on s390 and non-x86
 platforms
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <2e7a6e34-12d8-004c-405f-307dc9b5ce66@linux.intel.com>
Date:   Wed, 3 Mar 2021 13:02:32 +0530
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CFD4BAE2-CE77-46CC-B9B5-BC13AD2C8C1B@linux.vnet.ibm.com>
References: <20210302133119.3325530-1-tmricht@linux.ibm.com>
 <abcf63c1-8a15-14af-b449-77a943c94121@linux.intel.com>
 <7a14f6b6-967f-93bf-a030-44e358374502@linux.ibm.com>
 <785fc599-24c5-6eda-2807-2b79a9d89315@linux.intel.com>
 <753a61cb-e331-f91b-a1a9-e2fce2ecba52@linux.ibm.com>
 <2e7a6e34-12d8-004c-405f-307dc9b5ce66@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_08:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030057
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 03-Mar-2021, at 1:40 AM, Liang, Kan <kan.liang@linux.intel.com> =
wrote:
>=20
>=20
>=20
> On 3/2/2021 12:08 PM, Thomas Richter wrote:
>> On 3/2/21 4:23 PM, Liang, Kan wrote:
>>>=20
>>>=20
>>> On 3/2/2021 9:48 AM, Thomas Richter wrote:
>>>> On 3/2/21 3:03 PM, Liang, Kan wrote:
>>>>>=20
>>>>> + Athira Rajeev
>>>>>=20
>>>>> On 3/2/2021 8:31 AM, Thomas Richter wrote:
>>>>>> Executing perf test 27 fails on s390:
>>>>>>    [root@t35lp46 perf]# ./perf test -Fv 27
>>>>>>    27: Sample parsing
>>>>>>    --- start ---
>>>>>>    ---- end ----
>>>>>>    Sample parsing: FAILED!
>>>>>>    [root@t35lp46 perf]#
>>>>>>=20
>>>>>> The root cause is
>>>>>> commit c7444297fd3769 ("perf test: Support =
PERF_SAMPLE_WEIGHT_STRUCT")
>>>>>> This commit introduced a test case for PERF_SAMPLE_WEIGHT_STRUCT
>>>>>> but does not adjust non-x86 weak linkage functions.
>>>>>>=20
>>>>>> The error is in test__sample_parsing() --> do_test()
>>>>>> Function do_test() defines two structures of type struct =
perf_sample named
>>>>>> sample and sample_out. The first sets member sample.ins_lat =3D =
117
>>>>>>=20
>>>>>> Structure sample_out is constructed dynamically using functions
>>>>>> perf_event__synthesize_sample() and evsel__parse_sample().
>>>>>> Both functions have an x86 specific function version which sets =
member
>>>>>> ins_lat. The weak common functions do not set member ins_lat.
>>>>>>=20
>>>>>=20
>>>>> I don't think Power supports the instruction latency. As a request =
from Athira Rajeev, I moved the PERF_SAMPLE_WEIGHT_STRUCT to the X86 =
specific codes.
>>>>> =
https://lore.kernel.org/lkml/D97FEF4F-DD88-4760-885E-9A6161A9B48B@linux.vn=
et.ibm.com/
>>>>> =
https://lore.kernel.org/lkml/1612540912-6562-1-git-send-email-kan.liang@li=
nux.intel.com/
>>>>>=20
>>>>> I don't think we want to add the ins_lat back in the weak common =
functions.


Hi Kan Liang,

Yes, presently in powerpc we are not using PERF_SAMPLE_WEIGHT_STRUCT.
But I am working on a patch set to expose some of the pipeline stalls =
details using PERF_SAMPLE_WEIGHT_STRUCT,
by using the two 16-bit fields of sample weight. I could use the same =
"ins_lat" field and then use an arch specific header string while =
displaying with "perf report=E2=80=9D. I will be sharing an RFC patch on =
this soon.

But I believe it is good to keep the weak function =
"arch_perf_parse_sample_weight" if we want to create different field for =
'weight->var2_w' in future.

Thanks
Athira

>>>>>=20
>>>>> Could you please update the perf test and don't apply the =
PERF_SAMPLE_WEIGHT_STRUCT for the non-X86 platform?
>>>>=20
>>>> I used offical linux git tree
>>>>   [root@t35lp46 perf]# git tag | fgrep 5.12
>>>> v5.12-rc1
>>>> [root@t35lp46 perf]#
>>>>=20
>>>> So this change is in the pipe. I do not plan to revert individual =
patches.
>>>=20
>>> No, we shouldn't revert the patch.
>>> I mean can you fix the issue in perf test?
>>> Don't test ins_lat or PERF_SAMPLE_WEIGHT_STRUCT for a non-X86 =
platform.
>> That would be very ugly code. We would end up in conditional compiles =
like
>> #ifdef __s390x__
>> #endif
>> and other architectes like ARM/POWER etc come along. This is =
something I want to avoid.
>=20
> The ins_lat is a model specific variable. Maybe we should move it to =
the arch specific test.
>=20
>=20
>> And this fix only touches perf, not the kernel.
>=20
> The patch changes the behavior of the PERF_SAMPLE_WEIGHT. The high 32 =
bit will be dropped. It should bring some problems if the high 32 bit =
contains valid information.
>=20
>>>>>=20
>>>>>=20
>>>>>> Later in function samples_same() both data in variable sample and =
sample_out
>>>>>> are compared. The comparison fails because sample.ins_lat is 117
>>>>>> and samples_out.ins_lat is 0, the weak functions never set member =
ins_lat.
>>>>>>=20
>>>>>> Output after:
>>>>>>    [root@t35lp46 perf]# ./perf test -Fv 27
>>>>>>    27: Sample parsing
>>>>>>    --- start ---
>>>>>>    ---- end ----
>>>>>>    Sample parsing: Ok
>>>>>> [root@t35lp46 perf]#
>>>>>>=20
>>>>>> Fixes:
>>>>>> commit c7444297fd3769 ("perf test: Support =
PERF_SAMPLE_WEIGHT_STRUCT")
>>>>>=20
>>>>> I think the regression should start from
>>>>> commit fbefe9c2f87f ("perf tools: Support arch specific =
PERF_SAMPLE_WEIGHT_STRUCT processing")
>>>>>=20
>>>>>=20
>>>>> Thanks,
>>>>> Kan
>>>>=20
>>>> Kan,
>>>>=20
>>>> I do not follow you. Your commit =
c7444297fd3769d10c7ffb52c81d71503b3e268f
>>>> adds this line
>>>>=20
>>>> @@ -242,6 +245,7 @@ static int do_test(u64 sample_type, u64 =
sample_regs, u64 read_format)
>>>>                  .cgroup         =3D 114,
>>>>                  .data_page_size =3D 115,
>>>>                  .code_page_size =3D 116,
>>>> +               .ins_lat        =3D 117,
>>>>=20
>>>> And this assignment 117 breaks the test. As mentioned before, =
member ins_lat is never touched
>>>> by the weak functions.
>>>>=20
>>>=20
>>> Here is the timeline for the patches.
>>>=20
>>> 1. The commit c7444297fd3769 and other SPR patches are merged at =
2021-02-08. At that time, I don't think we have this issue. perf test =
should work well.
>> Nope, that line above 'ins_lat =3D 117.' breaks the test. Comment it =
out and it works well!!!
>=20
> If you revert the commit fbefe9c2f87f, perf test should work well too.
>=20
> The root cause of the issue is that the commit fbefe9c2f87f change the =
ins_lat to a model-specific variable, but perf test still verify the =
variable in the generic test.
>=20
> The below patch moves the PERF_SAMPLE_WEIGHT test into a X86 specific =
test.
>=20
> Does it work for you?
>=20
> ---
> tools/perf/arch/x86/include/arch-tests.h   |   1 +
> tools/perf/arch/x86/tests/Build            |   1 +
> tools/perf/arch/x86/tests/arch-tests.c     |   4 +
> tools/perf/arch/x86/tests/sample-parsing.c | 125 =
+++++++++++++++++++++++++++++
> tools/perf/tests/sample-parsing.c          |   4 -
> 5 files changed, 131 insertions(+), 4 deletions(-)
> create mode 100644 tools/perf/arch/x86/tests/sample-parsing.c
>=20
> diff --git a/tools/perf/arch/x86/include/arch-tests.h =
b/tools/perf/arch/x86/include/arch-tests.h
> index 6a54b94..0e20f3d 100644
> --- a/tools/perf/arch/x86/include/arch-tests.h
> +++ b/tools/perf/arch/x86/include/arch-tests.h
> @@ -10,6 +10,7 @@ int test__rdpmc(struct test *test __maybe_unused, =
int subtest);
> int test__insn_x86(struct test *test __maybe_unused, int subtest);
> int test__intel_pt_pkt_decoder(struct test *test, int subtest);
> int test__bp_modify(struct test *test, int subtest);
> +int test__x86_sample_parsing(struct test *test, int subtest);
>=20
> #ifdef HAVE_DWARF_UNWIND_SUPPORT
> struct thread;
> diff --git a/tools/perf/arch/x86/tests/Build =
b/tools/perf/arch/x86/tests/Build
> index 36d4f24..28d7933 100644
> --- a/tools/perf/arch/x86/tests/Build
> +++ b/tools/perf/arch/x86/tests/Build
> @@ -3,5 +3,6 @@ perf-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
>=20
> perf-y +=3D arch-tests.o
> perf-y +=3D rdpmc.o
> +perf-y +=3D sample-parsing.o
> perf-$(CONFIG_AUXTRACE) +=3D insn-x86.o intel-pt-pkt-decoder-test.o
> perf-$(CONFIG_X86_64) +=3D bp-modify.o
> diff --git a/tools/perf/arch/x86/tests/arch-tests.c =
b/tools/perf/arch/x86/tests/arch-tests.c
> index bc25d72..71aa673 100644
> --- a/tools/perf/arch/x86/tests/arch-tests.c
> +++ b/tools/perf/arch/x86/tests/arch-tests.c
> @@ -31,6 +31,10 @@ struct test arch_tests[] =3D {
> 	},
> #endif
> 	{
> +		.desc =3D "x86 Sample parsing",
> +		.func =3D test__x86_sample_parsing,
> +	},
> +	{
> 		.func =3D NULL,
> 	},
>=20
> diff --git a/tools/perf/arch/x86/tests/sample-parsing.c =
b/tools/perf/arch/x86/tests/sample-parsing.c
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
> +#define COMP(m) do {					\
> +	if (s1->m !=3D s2->m) {				\
> +		pr_debug("Samples differ at '"#m"'\n");	\
> +		return false;				\
> +	}						\
> +} while (0)
> +
> +static bool samples_same(const struct perf_sample *s1,
> +			 const struct perf_sample *s2,
> +			 u64 type)
> +{
> +	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
> +		COMP(ins_lat);
> +
> +	return true;
> +}
> +
> +static int do_test(u64 sample_type, u64 read_format)
> +{
> +	struct evsel evsel =3D {
> +		.needs_swap =3D false,
> +		.core =3D {
> +			. attr =3D {
> +				.sample_type =3D sample_type,
> +				.read_format =3D read_format,
> +			},
> +		},
> +	};
> +	union perf_event *event;
> +	struct perf_sample sample =3D {
> +		.weight		=3D 101,
> +		.ins_lat        =3D 102,
> +	};
> +	struct perf_sample sample_out;
> +	size_t i, sz, bufsz;
> +	int err, ret =3D -1;
> +
> +	sz =3D perf_event__sample_event_size(&sample, sample_type, =
read_format);
> +	bufsz =3D sz + 4096; /* Add a bit for overrun checking */
> +	event =3D malloc(bufsz);
> +	if (!event) {
> +		pr_debug("malloc failed\n");
> +		return -1;
> +	}
> +
> +	memset(event, 0xff, bufsz);
> +	event->header.type =3D PERF_RECORD_SAMPLE;
> +	event->header.misc =3D 0;
> +	event->header.size =3D sz;
> +
> +	err =3D perf_event__synthesize_sample(event, sample_type, =
read_format,
> +					    &sample);
> +	if (err) {
> +		pr_debug("%s failed for sample_type %#"PRIx64", error =
%d\n",
> +			 "perf_event__synthesize_sample", sample_type, =
err);
> +		goto out_free;
> +	}
> +
> +	/* The data does not contain 0xff so we use that to check the =
size */
> +	for (i =3D bufsz; i > 0; i--) {
> +		if (*(i - 1 + (u8 *)event) !=3D 0xff)
> +			break;
> +	}
> +	if (i !=3D sz) {
> +		pr_debug("Event size mismatch: actual %zu vs expected =
%zu\n",
> +			 i, sz);
> +		goto out_free;
> +	}
> +
> +	evsel.sample_size =3D __evsel__sample_size(sample_type);
> +
> +	err =3D evsel__parse_sample(&evsel, event, &sample_out);
> +	if (err) {
> +		pr_debug("%s failed for sample_type %#"PRIx64", error =
%d\n",
> +			 "evsel__parse_sample", sample_type, err);
> +		goto out_free;
> +	}
> +
> +	if (!samples_same(&sample, &sample_out, sample_type)) {
> +		pr_debug("parsing failed for sample_type %#"PRIx64"\n",
> +			 sample_type);
> +		goto out_free;
> +	}
> +
> +	ret =3D 0;
> +out_free:
> +	free(event);
> +	if (ret && read_format)
> +		pr_debug("read_format %#"PRIx64"\n", read_format);
> +	return ret;
> +}
> +
> +/**
> + * test__x86_sample_parsing - test X86 specific sample parsing
> + *
> + * This function implements a test that synthesizes a sample event, =
parses it
> + * and then checks that the parsed sample matches the original =
sample.  The test
> + * checks sample format bits separately and together.  If the test =
passes %0 is
> + * returned, otherwise %-1 is returned.
> + *
> + * For now, PERF_SAMPLE_WEIGHT_STRUCT is the only X86 specific sample =
type.
> + */
> +int test__x86_sample_parsing(struct test *test __maybe_unused, int =
subtest __maybe_unused)
> +{
> +	return do_test(PERF_SAMPLE_WEIGHT_STRUCT, 0);
> +}
> diff --git a/tools/perf/tests/sample-parsing.c =
b/tools/perf/tests/sample-parsing.c
> index 0dbe3aa..8fd8a4e 100644
> --- a/tools/perf/tests/sample-parsing.c
> +++ b/tools/perf/tests/sample-parsing.c
> @@ -129,9 +129,6 @@ static bool samples_same(const struct perf_sample =
*s1,
> 	if (type & PERF_SAMPLE_WEIGHT)
> 		COMP(weight);
>=20
> -	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
> -		COMP(ins_lat);
> -
> 	if (type & PERF_SAMPLE_DATA_SRC)
> 		COMP(data_src);
>=20
> @@ -245,7 +242,6 @@ static int do_test(u64 sample_type, u64 =
sample_regs, u64 read_format)
> 		.cgroup		=3D 114,
> 		.data_page_size =3D 115,
> 		.code_page_size =3D 116,
> -		.ins_lat        =3D 117,
> 		.aux_sample	=3D {
> 			.size	=3D sizeof(aux_data),
> 			.data	=3D (void *)aux_data,
> --=20
> 2.7.4
>=20
>=20
> Thanks,
> Kan

