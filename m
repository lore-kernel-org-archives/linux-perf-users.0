Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E76C433E0
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Mar 2021 07:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C3F619F6
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Mar 2021 07:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhCXHSs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Mar 2021 03:18:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232230AbhCXHSm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Mar 2021 03:18:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12O77jia013236;
        Wed, 24 Mar 2021 03:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hOPWf5uLYS8MSJmd5l/SPND9xclp5e9VTd1t0JEFVsw=;
 b=Lvvo3SnBA2hIxh+uqQpdQ5IjsKtcIYsMJ+NZ7DweNOTmqV209v1tJVvefdrlbiveAIDf
 xFL3vzCO6j7PFeG9f8pHONkeSvnPHGMNgQtIkHch+HGsCg1TUJv7jB9xVF+hv0Lm98AP
 duKvvPTbzt7TZJFkqedFP3LH77ETyHnxM9ToAFuas7NWXycsNIJTWhbqU7RbcDbAKTbj
 FacEXV9NSwvhDNM8xcqE8USDAh3zq+lgLQmqMHZ5xxxKw/gp2epZj6AvnKan5falO+aV
 8sFtlAEeBoN5nXD94rw34kNuvGETUuvmTKK+WmphrZIi5aGkg1obgSE4QJSVaTlwcCKk ug== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37fsm0h90a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 03:18:39 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12O7Hi1g023981;
        Wed, 24 Mar 2021 07:18:38 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 37d99xj4nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 07:18:38 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12O7IZeN22872360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 07:18:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23AF54204B;
        Wed, 24 Mar 2021 07:18:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0A7342045;
        Wed, 24 Mar 2021 07:18:34 +0000 (GMT)
Received: from li-e35baacc-2106-11b2-a85c-8f97eb669a6e.ibm.com (unknown [9.145.88.230])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Mar 2021 07:18:34 +0000 (GMT)
Subject: Re: [PATCH] perf test: Fix perf test 42
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
References: <20210322125339.1384351-1-tmricht@linux.ibm.com>
 <YFouKGT7oS1T/oMS@kernel.org>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
Message-ID: <e4b0b5a6-8e7f-1915-0e10-843ec00bc403@linux.ibm.com>
Date:   Wed, 24 Mar 2021 08:18:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFouKGT7oS1T/oMS@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_04:2021-03-23,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240053
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 3/23/21 7:06 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 22, 2021 at 01:53:39PM +0100, Thomas Richter escreveu:
>> For some time now the perf test 42: BPF filter returns an error
>> on bpf relocation subtest, at least on x86 and s390. This is caused by
>>
>> commit d859900c4c56 ("bpf, libbpf: support global data/bss/rodata sections")
>>
>> which introduces support for global variables in eBPF programs. At least
>> for global variables defined static.
>>
>> Perf test 42 checks that the eBPF relocation fails when the eBPF program
>> contains a global variable. It returns OK when the eBPF program
>> could not be loaded and FAILED otherwise.
>>
>> With above commit the test logic for the eBPF relocation need to change:
>> 1. The function prepare_bpf() now always succeeds, the eBPF program
>>    compiled without errors and returns a valid object pointer instead of
>>    NULL.
>> 2. There is no kprobe named sys_write, it now named ksys_write.
>> 3. The function do_test() now returns TEST_FAIL because function
>>    parse_events_load_bpf_obj() can not execute the eBPF program. The
>>    eBPF verifier complains on an invalid map pointer:
>>       libbpf: load bpf program failed: Permission denied
>>       libbpf: -- BEGIN DUMP LOG ---
>>       libbpf:
>>       0: (b7) r1 = 0
>>       1: (63) *(u32 *)(r10 -4) = r1
>>       last_idx 1 first_idx 0
>>       regs=2 stack=0 before 0: (b7) r1 = 0
>>       2: (63) *(u32 *)(r10 -8) = r1
>>       3: (bf) r2 = r10
>>       4: (07) r2 += -4
>>       5: (bf) r3 = r10
>>       6: (07) r3 += -8
>>       7: (18) r1 = 0x380006ce000
>>       9: (b7) r4 = 0
>>       10: (85) call bpf_map_update_elem#2
>>       R1 type=map_value expected=map_ptr
>>
>> Fix this by added logic to handle the kernel verifier return code:
>> 1. Add function myksys_write() to cope with successful compile.
>> 2. Use kprobe ksys_write
>> 3. Handle eBPF verifier error.
>>
>> Output after:
>>  42: BPF filter                          :
>>  42.1: Basic BPF filtering               : Ok
>>  42.2: BPF pinning                       : Ok
>>  42.3: BPF prologue generation           : Ok
>>  42.4: BPF relocation checker            : Failed
>>  #
>>
>> Output after:
>>  # ./perf test -F 42
>>  42: BPF filter                          :
>>  42.1: Basic BPF filtering               : Ok
>>  42.2: BPF pinning                       : Ok
>>  42.3: BPF prologue generation           : Ok
>>  42.4: BPF relocation checker            : Ok
>>  #
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>  tools/perf/tests/bpf-script-test-relocation.c |  4 ++--
>>  tools/perf/tests/bpf.c                        | 11 +++++++++++
>>  2 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/tests/bpf-script-test-relocation.c b/tools/perf/tests/bpf-script-test-relocation.c
>> index 74006e4b2d24..f8f8176ad4d1 100644
>> --- a/tools/perf/tests/bpf-script-test-relocation.c
>> +++ b/tools/perf/tests/bpf-script-test-relocation.c
>> @@ -34,8 +34,8 @@ struct bpf_map_def SEC("maps") my_table = {
>>  
>>  int this_is_a_global_val;
>>  
>> -SEC("func=sys_write")
>> -int bpf_func__sys_write(void *ctx)
>> +SEC("func=ksys_write")
>> +int bpf_func__ksys_write(void *ctx)
>>  {
>>  	int key = 0;
>>  	int value = 0;
>> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
>> index f57e075b0ed2..d60ef9472d3d 100644
>> --- a/tools/perf/tests/bpf.c
>> +++ b/tools/perf/tests/bpf.c
>> @@ -59,6 +59,11 @@ static int llseek_loop(void)
>>  
>>  #endif
>>  
>> +static int myksys_write(void)
>> +{
>> +	return 0;
>> +}
>> +
>>  static struct {
>>  	enum test_llvm__testcase prog_id;
>>  	const char *desc;
>> @@ -105,6 +110,7 @@ static struct {
>>  		.name		  = "[bpf_relocation_test]",
>>  		.msg_compile_fail = "fix 'perf test LLVM' first",
>>  		.msg_load_fail	  = "libbpf error when dealing with relocation",
>> +		.target_func	  = &myksys_write,
>>  	},
>>  };
>>  
>> @@ -258,6 +264,11 @@ static int __test__bpf(int idx)
>>  		ret = do_test(obj,
>>  			      bpf_testcase_table[idx].target_func,
>>  			      bpf_testcase_table[idx].expect_result);
>> +		if (bpf_testcase_table[idx].prog_id == LLVM_TESTCASE_BPF_RELOCATION
>> +		    && ret == TEST_FAIL) {
>> +			ret = TEST_OK;
>> +			goto out;
>> +		}
> 
> At this point, if it doesn't matter if it fails or succeeds, just drop
> this test case?
> 
> - Arnaldo
> 

Arnaldo,

dropping this test case is fine with me. Support for eBPF global variables is now
part of the linux kernel and there are test programs in the 
.../testing/selftests/bpf directory. File prog_tests/global_data.c for example.

If you agree, I will provide a patch to remove the test case 42.4.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
