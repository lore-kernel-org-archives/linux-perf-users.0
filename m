Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4697C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 07:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCD260F70
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 07:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhJ1HWb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Oct 2021 03:22:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229656AbhJ1HWa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Oct 2021 03:22:30 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S6mB1N029471;
        Thu, 28 Oct 2021 07:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gkQfcZPW+HtPpAGnoBtaHMJ20DjjxnQPDkknmLyYEBI=;
 b=qOu8hm+ERGayt+pKmN8ITLhyb6owuNyWvFSVsJOYZLGnf4f6dx3f0Mo9tmEf9evkMbmO
 QDrGnpwb+2xRSglkS2ZH7dzFc0atRa3a1njrhUCj43ce/CgFYwNOe/W1ixCe/1PR4zER
 tyou2xDsOhEZc/LzIBQq4BojwgcfkD1Oi9fkIxwBlWG7EKeASi+AIfMWAhdcMdVLv/vv
 KdF96o/nFXF567e/9TbUu0xWACSO8GGziXeSH+7vt++rCvl88cAZQR0w/8O51ngDkmMs
 /wPdajQkuSnSbYoxKk0W206rCoyEG0F9gzTR3fT1+NAOYMfJCSdchfdrP+36jBXIRR2p sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bypwh0kse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 07:19:55 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19S7Fcbx014595;
        Thu, 28 Oct 2021 07:19:55 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bypwh0krw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 07:19:55 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19S7D3Vj032486;
        Thu, 28 Oct 2021 07:19:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3bx4f1pckb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 07:19:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19S7Jopx39059878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 07:19:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA3E052050;
        Thu, 28 Oct 2021 07:19:50 +0000 (GMT)
Received: from Madhavan.PrimaryTP (unknown [9.43.61.213])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 248ED52054;
        Thu, 28 Oct 2021 07:19:46 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] tools/perf: Add bitfield_swap to handle
 branch_stack endian issue
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@redhat.com, michael@ellerman.id.au, eranian@google.com,
        mark.rutland@arm.com, namhyung@kernel.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211016125059.691856-1-maddy@linux.ibm.com>
 <YXnr8xpltsVZPATC@kernel.org>
 <FD195114-27C2-4F8F-B05E-2E9D5595C4EF@gmail.com>
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
Message-ID: <31b42a66-3e56-ab72-b2cb-798955c367e0@linux.ibm.com>
Date:   Thu, 28 Oct 2021 12:49:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <FD195114-27C2-4F8F-B05E-2E9D5595C4EF@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m5VpM_chFC0sc3auDAiCA0e7x8JZ7yhk
X-Proofpoint-GUID: -4Q6BYKIMDtPq6ctS6NGV-ouwCz1wRPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110280035
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 10/28/21 8:07 AM, Arnaldo Carvalho de Melo wrote:
>
> On October 27, 2021 9:16:51 PM GMT-03:00, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>> Em Sat, Oct 16, 2021 at 06:20:58PM +0530, Madhavan Srinivasan escreveu:
>>> branch_stack struct has bit field definition which
>>> produces different bit ordering for big/little endian.
>>> Because of this, when branch_stack sample is collected
>>> in a BE system and viewed/reported in a LE system, bit
>>> fields of the branch stack are not presented properly.
>>> To address this issue, a evsel__bitfield_swap_branch_stack()
>>> is defined and introduced in evsel__parse_sample.
>>>
>>> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>>> ---
>>> Changelog v1:
>>> - Renamed function and macro
>>> - Added comments in code
> Please, run 'perf test' before submitting patches, it's not that difficult, please do so.
>
> - Arnaldo
>
>> [acme@quaco perf]$ perf test python
>> 19: 'import perf' in python                                         : FAILED!
>> [acme@quaco perf]$ perf test -v python
>> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
>> 19: 'import perf' in python                                         :
>> --- start ---
>> test child forked, pid 991284
>> python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
>> Traceback (most recent call last):
>>   File "<stdin>", line 1, in <module>
>> ImportError: /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so: undefined symbol: bigendian
>> test child finished with -1

using tep_is_bigendian() instead of bigendian() fixes it.
Will send a V3 with that changes.

Maddy

>> ---- end ---- 'import perf' in python: FAILED! [acme@quaco perf]$
>>>   tools/perf/util/evsel.c | 74 +++++++++++++++++++++++++++++++++++++++--
>>>   tools/perf/util/evsel.h | 13 ++++++++
>>>   2 files changed, 85 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>> index dbfeceb2546c..746e642d4d32 100644
>>> --- a/tools/perf/util/evsel.c
>>> +++ b/tools/perf/util/evsel.c
>>> @@ -2221,6 +2221,51 @@ void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
>>>   	data->weight = *array;
>>>   }
>>>   
>>> +u64 evsel__bitfield_swap_branch_flags(u64 value)
>>> +{
>>> +	u64 new_val = 0;
>>> +
>>> +	/*
>>> +	 * branch_flags
>>> +	 * union {
>>> +	 * 	u64 values;
>>> +	 * 	struct {
>>> +	 * 		mispred:1	//target mispredicted
>>> +	 * 		predicted:1	//target predicted
>>> +	 * 		in_tx:1		//in transaction
>>> +	 * 		abort:1		//transaction abort
>>> +	 * 		cycles:16	//cycle count to last branch
>>> +	 * 		type:4		//branch type
>>> +	 * 		reserved:40
>>> +	 * 	}
>>> +	 * }
>>> +	 *
>>> +	 * Avoid bswap64() the entire branch_flag.value,
>>> +	 * as it has variable bit-field sizes. Instead the
>>> +	 * macro takes the bit-field position/size,
>>> +	 * swaps it based on the host endianness.
>>> +	 */
>>> +	if (bigendian()) {
>>> +		new_val = bitfield_swap(value, 0, 1);
>>> +		new_val |= bitfield_swap(value, 1, 1);
>>> +		new_val |= bitfield_swap(value, 2, 1);
>>> +		new_val |= bitfield_swap(value, 3, 1);
>>> +		new_val |= bitfield_swap(value, 4, 16);
>>> +		new_val |= bitfield_swap(value, 20, 4);
>>> +		new_val |= bitfield_swap(value, 24, 40);
>>> +	} else {
>>> +		new_val = bitfield_swap(value, 63, 1);
>>> +		new_val |= bitfield_swap(value, 62, 1);
>>> +		new_val |= bitfield_swap(value, 61, 1);
>>> +		new_val |= bitfield_swap(value, 60, 1);
>>> +		new_val |= bitfield_swap(value, 44, 16);
>>> +		new_val |= bitfield_swap(value, 40, 4);
>>> +		new_val |= bitfield_swap(value, 0, 40);
>>> +	}
>>> +
>>> +	return new_val;
>>> +}
>>> +
>>>   int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>>   			struct perf_sample *data)
>>>   {
>>> @@ -2408,6 +2453,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>>   	if (type & PERF_SAMPLE_BRANCH_STACK) {
>>>   		const u64 max_branch_nr = UINT64_MAX /
>>>   					  sizeof(struct branch_entry);
>>> +		struct branch_entry *e;
>>> +		unsigned int i;
>>>   
>>>   		OVERFLOW_CHECK_u64(array);
>>>   		data->branch_stack = (struct branch_stack *)array++;
>>> @@ -2416,10 +2463,33 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>>   			return -EFAULT;
>>>   
>>>   		sz = data->branch_stack->nr * sizeof(struct branch_entry);
>>> -		if (evsel__has_branch_hw_idx(evsel))
>>> +		if (evsel__has_branch_hw_idx(evsel)) {
>>>   			sz += sizeof(u64);
>>> -		else
>>> +			e = &data->branch_stack->entries[0];
>>> +		} else {
>>>   			data->no_hw_idx = true;
>>> +			/*
>>> +			 * if the PERF_SAMPLE_BRANCH_HW_INDEX is not applied,
>>> +			 * only nr and entries[] will be output by kernel.
>>> +			 */
>>> +			e = (struct branch_entry *)&data->branch_stack->hw_idx;
>>> +		}
>>> +
>>> +		if (swapped) {
>>> +			/*
>>> +			 * struct branch_flag does not have endian
>>> +			 * specific bit field definition. And bswap
>>> +			 * will not resolve the issue, since these
>>> +			 * are bit fields.
>>> +			 *
>>> +			 * evsel__bitfield_swap_branch_flags() uses a
>>> +			 * bitfield_swap macro to swap the bit position
>>> +			 * based on the host endians.
>>> +			 */
>>> +			for (i = 0; i < data->branch_stack->nr; i++, e++)
>>> +				e->flags.value = evsel__bitfield_swap_branch_flags(e->flags.value);
>>> +		}
>>> +
>>>   		OVERFLOW_CHECK(array, sz, max_size);
>>>   		array = (void *)array + sz;
>>>   	}
>>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>>> index 1f7edfa8568a..2e82cdbe2c08 100644
>>> --- a/tools/perf/util/evsel.h
>>> +++ b/tools/perf/util/evsel.h
>>> @@ -482,4 +482,17 @@ struct evsel *evsel__leader(struct evsel *evsel);
>>>   bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
>>>   bool evsel__is_leader(struct evsel *evsel);
>>>   void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
>>> +
>>> +/*
>>> + * Macro to swap the bit-field postition and size.
>>> + * Used when,
>>> + * - dont need to swap the entire u64 &&
>>> + * - when u64 has variable bit-field sizes &&
>>> + * - when presented in a host endian which is different
>>> + *   than the source endian of the perf.data file
>>> + */
>>> +#define bitfield_swap(src, pos, size)	\
>>> +	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
>>> +
>>> +u64 evsel__bitfield_swap_branch_flags(u64 value);
>>>   #endif /* __PERF_EVSEL_H */
>>> -- 
>>> 2.31.1
