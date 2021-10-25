Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B1FC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 11:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C86860F4F
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 11:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhJYLf2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:35:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231501AbhJYLf1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Oct 2021 07:35:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19P9X76j006143;
        Mon, 25 Oct 2021 11:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4ZL3M7S4K1PgPhcsItAqHsasq3wWtJ1uN1aP3TeoEuQ=;
 b=sLUI80nkx/3gtzlTQ8DGYiyIdEkv60MCd7s8SvRtj+W5xqkPlAN+byO9BPPme+mUKujP
 zPuicvMeKiHPzognUY9f8aT2gcF9ts8PRKwHqX2xsdKzw5rVsC1dVwzZkKp5fXI9X3lQ
 HUPgCobGgyjtJo4JfA0ww3UNyE/iz2Y4Awc8+m2jvcgoyQw8NUHsVUaA/Z0PSzeV4Ljn
 EvjYtj2Xn2ZQ68E6hXsmvGimkDoFNxy4MTceOk4+UvtohxKlGQiN1UKSxgdvrmSyjP4f
 hdYeedgm2WH62K/l01TYywN3tnz47olId3H5BKwnBRKrt6OCIvzprHutfBDz/iVaEnvX Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bwt23te07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 11:32:56 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19PBMlTE000598;
        Mon, 25 Oct 2021 11:32:56 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bwt23tdyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 11:32:56 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19PBD3Nn012026;
        Mon, 25 Oct 2021 11:32:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3bva19neum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 11:32:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19PBWqOI28836162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Oct 2021 11:32:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DD2D11C06F;
        Mon, 25 Oct 2021 11:32:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C5D011C05B;
        Mon, 25 Oct 2021 11:32:49 +0000 (GMT)
Received: from Madhavan.PrimaryTP (unknown [9.43.112.146])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Oct 2021 11:32:48 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] tools/perf: Add bitfield_swap to handle
 branch_stack endian issue
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, michael@ellerman.id.au, eranian@google.com,
        mark.rutland@arm.com, namhyung@kernel.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211016125059.691856-1-maddy@linux.ibm.com>
 <YXFqO+8N61a9Cqy+@krava>
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
Message-ID: <8dc46783-5fb6-205b-4af1-eb37bb7cd875@linux.ibm.com>
Date:   Mon, 25 Oct 2021 17:02:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YXFqO+8N61a9Cqy+@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5PuJLa-nXeInsYTce35uP3enmwePoNr0
X-Proofpoint-ORIG-GUID: 1Milk7scDIm3IoN0l0p6Rb01fWkfLFEF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_04,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110250071
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 10/21/21 6:55 PM, Jiri Olsa wrote:
> On Sat, Oct 16, 2021 at 06:20:58PM +0530, Madhavan Srinivasan wrote:
>> branch_stack struct has bit field definition which
>> produces different bit ordering for big/little endian.
>> Because of this, when branch_stack sample is collected
>> in a BE system and viewed/reported in a LE system, bit
>> fields of the branch stack are not presented properly.
>> To address this issue, a evsel__bitfield_swap_branch_stack()
>> is defined and introduced in evsel__parse_sample.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>> ---
>> Changelog v1:
>> - Renamed function and macro
>> - Added comments in code
>>
>>   tools/perf/util/evsel.c | 74 +++++++++++++++++++++++++++++++++++++++--
>>   tools/perf/util/evsel.h | 13 ++++++++
>>   2 files changed, 85 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index dbfeceb2546c..746e642d4d32 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -2221,6 +2221,51 @@ void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
>>   	data->weight = *array;
>>   }
>>   
>> +u64 evsel__bitfield_swap_branch_flags(u64 value)
>> +{
>> +	u64 new_val = 0;
>> +
>> +	/*
>> +	 * branch_flags
>> +	 * union {
>> +	 * 	u64 values;
>> +	 * 	struct {
>> +	 * 		mispred:1	//target mispredicted
>> +	 * 		predicted:1	//target predicted
>> +	 * 		in_tx:1		//in transaction
>> +	 * 		abort:1		//transaction abort
>> +	 * 		cycles:16	//cycle count to last branch
>> +	 * 		type:4		//branch type
>> +	 * 		reserved:40
>> +	 * 	}
>> +	 * }
>> +	 *
>> +	 * Avoid bswap64() the entire branch_flag.value,
>> +	 * as it has variable bit-field sizes. Instead the
>> +	 * macro takes the bit-field position/size,
>> +	 * swaps it based on the host endianness.
>> +	 */
>> +	if (bigendian()) {
>> +		new_val = bitfield_swap(value, 0, 1);
>> +		new_val |= bitfield_swap(value, 1, 1);
>> +		new_val |= bitfield_swap(value, 2, 1);
>> +		new_val |= bitfield_swap(value, 3, 1);
>> +		new_val |= bitfield_swap(value, 4, 16);
>> +		new_val |= bitfield_swap(value, 20, 4);
>> +		new_val |= bitfield_swap(value, 24, 40);
>> +	} else {
>> +		new_val = bitfield_swap(value, 63, 1);
>> +		new_val |= bitfield_swap(value, 62, 1);
>> +		new_val |= bitfield_swap(value, 61, 1);
>> +		new_val |= bitfield_swap(value, 60, 1);
>> +		new_val |= bitfield_swap(value, 44, 16);
>> +		new_val |= bitfield_swap(value, 40, 4);
>> +		new_val |= bitfield_swap(value, 0, 40);
>> +	}
>> +
>> +	return new_val;
>> +}
>> +
>>   int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>   			struct perf_sample *data)
>>   {
>> @@ -2408,6 +2453,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>   	if (type & PERF_SAMPLE_BRANCH_STACK) {
>>   		const u64 max_branch_nr = UINT64_MAX /
>>   					  sizeof(struct branch_entry);
>> +		struct branch_entry *e;
>> +		unsigned int i;
>>   
>>   		OVERFLOW_CHECK_u64(array);
>>   		data->branch_stack = (struct branch_stack *)array++;
>> @@ -2416,10 +2463,33 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>   			return -EFAULT;
>>   
>>   		sz = data->branch_stack->nr * sizeof(struct branch_entry);
>> -		if (evsel__has_branch_hw_idx(evsel))
>> +		if (evsel__has_branch_hw_idx(evsel)) {
>>   			sz += sizeof(u64);
>> -		else
>> +			e = &data->branch_stack->entries[0];
>> +		} else {
>>   			data->no_hw_idx = true;
>> +			/*
>> +			 * if the PERF_SAMPLE_BRANCH_HW_INDEX is not applied,
>> +			 * only nr and entries[] will be output by kernel.
>> +			 */
>> +			e = (struct branch_entry *)&data->branch_stack->hw_idx;
>> +		}
>> +
>> +		if (swapped) {
> thanks for all the comments, make it easy to review
>
>> +			/*
>> +			 * struct branch_flag does not have endian
>> +			 * specific bit field definition. And bswap
>> +			 * will not resolve the issue, since these
>> +			 * are bit fields.
>> +			 *
>> +			 * evsel__bitfield_swap_branch_flags() uses a
>> +			 * bitfield_swap macro to swap the bit position
>> +			 * based on the host endians.
>> +			 */
>> +			for (i = 0; i < data->branch_stack->nr; i++, e++)
>> +				e->flags.value = evsel__bitfield_swap_branch_flags(e->flags.value);
> one last thing that confuses me.. the sample is already swapped at this
> point, right? with perf_event__all64_swap function
>
> should you swap it back first and then do the proper bitfield swap?
> like we do in PERF_SAMPLE_RAW to get proper u32 values

No, in case of PERF_SAMPLE_RAW type, first word contains the size.

Let me explain with an example (hope will not confuse further :) ),
say we have branch_flag.value as 0x4000000000000000 generated in a
BE system, which has predict set, now if we undo the swap done by
perf_event__all64_swap, value comes out as 0x40 (in a LE system) and
if this value fed to bitswap macro, we end up 0x0000000040000000,
which is wrong. Instead, by not swapping back, we feed the value
in the source-endian to the new macro.

Maddy

> thanks,
> jirka
>
>> +		}
>> +
>>   		OVERFLOW_CHECK(array, sz, max_size);
>>   		array = (void *)array + sz;
>>   	}
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index 1f7edfa8568a..2e82cdbe2c08 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -482,4 +482,17 @@ struct evsel *evsel__leader(struct evsel *evsel);
>>   bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
>>   bool evsel__is_leader(struct evsel *evsel);
>>   void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
>> +
>> +/*
>> + * Macro to swap the bit-field postition and size.
>> + * Used when,
>> + * - dont need to swap the entire u64 &&
>> + * - when u64 has variable bit-field sizes &&
>> + * - when presented in a host endian which is different
>> + *   than the source endian of the perf.data file
>> + */
>> +#define bitfield_swap(src, pos, size)	\
>> +	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
>> +
>> +u64 evsel__bitfield_swap_branch_flags(u64 value);
>>   #endif /* __PERF_EVSEL_H */
>> -- 
>> 2.31.1
>>
