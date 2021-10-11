Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ED6C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 14:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816EF6023F
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 14:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbhJKOcG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:32:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237130AbhJKOcA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Oct 2021 10:32:00 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BEE2R7022300;
        Mon, 11 Oct 2021 10:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bWwkMFaP9VR5avZOByPBEcQrDYktXrOW+1xzfEJ15xU=;
 b=hx+AryTQj+CtYFnoIshCLCDYvcSPTTSq+CVDaUEmQmqrBQV+GY+sLMIWt1gd8I4TTISk
 P6Yjt2Q8maVIJuu7K4y3ISojJG4reQ6g2OJ06TeL2ghzdUM65ErNHxoeYRzbCoV3J51W
 FTj+6zm+1NtkQsaimGB8iFXcTQvA6VZaVDLhsqHgnmICOdCj6IaBbAsKjnLqK5OyZt/7
 TbtW/CyOU6Wv8q/YAzkxBz1BKdlhqSnqyhEt/nONBi23gaDUKAXt5gqfgI0TByX2g/lD
 ASjf2DwFwsXlJro/VYASCnnLL1Q18ZshcrbNVL70JIlj1mPHJTPTpoRKrxGvmPeFSUbX Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bmn28u96g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 10:29:52 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19BDNtxa004155;
        Mon, 11 Oct 2021 10:29:52 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bmn28u95s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 10:29:52 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19BESfce006507;
        Mon, 11 Oct 2021 14:29:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3bk2q9de88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 14:29:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19BETkvG49414554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 14:29:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90FD411C04C;
        Mon, 11 Oct 2021 14:29:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30D1611C054;
        Mon, 11 Oct 2021 14:29:43 +0000 (GMT)
Received: from Madhavan.PrimaryTP (unknown [9.43.14.36])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Oct 2021 14:29:42 +0000 (GMT)
Subject: Re: [PATCH 1/2] tools/perf: Add reverse_fn to handle branch_stack
 endian issue
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, michael@ellerman.id.au, eranian@google.com,
        mark.rutland@arm.com, namhyung@kernel.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210930070410.52703-1-maddy@linux.ibm.com>
 <YV8xbzWt7tEbBbZX@krava>
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
Message-ID: <e9504e62-63c9-de32-5c2d-1c5ca0b86bf0@linux.ibm.com>
Date:   Mon, 11 Oct 2021 19:59:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YV8xbzWt7tEbBbZX@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qVNp4E85onsCiQp_ZPeBUxjwaIZkYDQd
X-Proofpoint-GUID: 6pK2HSffoWle0l_FRryp8B6UcZTJkaCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_05,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110082
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 10/7/21 11:12 PM, Jiri Olsa wrote:
> On Thu, Sep 30, 2021 at 12:34:09PM +0530, Madhavan Srinivasan wrote:
>> branch_stack struct has bit field definition which
>> produces different bit ordering for big/little endian.
>> Because of this, when branch_stack sample is collected
>> in a BE system and viewed/reported in a LE system, bit
>> fields of the branch stack are not presented properly.
>> To address this issue, a evsel__reverse64_branch_stack_flags()
>> is defined and introduced in evsel__parse_sample.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>> ---
>>   tools/perf/util/evsel.c | 64 +++++++++++++++++++++++++++++++++++++++--
>>   tools/perf/util/evsel.h |  5 ++++
>>   2 files changed, 67 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index dbfeceb2546c..007be66b69a2 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -2221,6 +2221,46 @@ void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
>>   	data->weight = *array;
>>   }
>>   
>> +u64 evsel__reverse64_branch_stack_flags(u64 value)
>> +{
>> +	u64 new_val = 0;
>> +
>> +	/*
>> +	 * branch_stack flag (u64)
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
>> +	 */
> please describe in comment how the bitfield is swapped

Sure will do.

>> +	if (bigendian()) {
>> +		new_val = reverse_64(value, 0, 1);
>> +		new_val |= reverse_64(value, 1, 1);
>> +		new_val |= reverse_64(value, 2, 1);
>> +		new_val |= reverse_64(value, 3, 1);
>> +		new_val |= reverse_64(value, 4, 16);
>> +		new_val |= reverse_64(value, 20, 4);
>> +		new_val |= reverse_64(value, 24, 40);
>> +	} else {
>> +		new_val = reverse_64(value, 63, 1);
>> +		new_val |= reverse_64(value, 62, 1);
>> +		new_val |= reverse_64(value, 61, 1);
>> +		new_val |= reverse_64(value, 60, 1);
>> +		new_val |= reverse_64(value, 44, 16);
>> +		new_val |= reverse_64(value, 40, 4);
>> +		new_val |= reverse_64(value, 0, 40);
>> +	}
>> +
>> +	return new_val;
>> +}
>> +
>>   int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>   			struct perf_sample *data)
>>   {
>> @@ -2408,6 +2448,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>   	if (type & PERF_SAMPLE_BRANCH_STACK) {
>>   		const u64 max_branch_nr = UINT64_MAX /
>>   					  sizeof(struct branch_entry);
>> +		struct branch_entry *e;
>> +		unsigned int i;
>>   
>>   		OVERFLOW_CHECK_u64(array);
>>   		data->branch_stack = (struct branch_stack *)array++;
>> @@ -2416,10 +2458,28 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
>> +			e = (struct branch_entry *)&data->branch_stack->hw_idx;
> hum, why do we convert hw_idx? it's the same struct as entries?
> please explain this in comment as well

No. IIUC, hw_idx is valid only if PERF_SAMPLE_BRANCH_HW_INDEX is applied.
If not, then only nr and entries[] will be output-ed by kernel
42bbabed09ce ('perf tools: Add hw_idx in struct branch_stack')

>
>> +		}
>> +
>> +		if (swapped) {
>> +			/*
>> +			 * struct branch_flag does not have endian specific
>> +			 * bit field definition. And bswap will not resolve the
>> +			 * issue, since these are bit fields.
>> +			 *
>> +			 * evsel__reverse64_branch_stack_flags() uses a reverse64
>> +			 * macro to reverse the bit position based on the host
>> +			 * endians.
>> +			 */
>> +			for (i = 0; i < data->branch_stack->nr; i++, e++)
>> +				e->flags.value = evsel__reverse64_branch_stack_flags(e->flags.value);
>> +		}
>> +
>>   		OVERFLOW_CHECK(array, sz, max_size);
>>   		array = (void *)array + sz;
>>   	}
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index 1f7edfa8568a..1127c23710cf 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -482,4 +482,9 @@ struct evsel *evsel__leader(struct evsel *evsel);
>>   bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
>>   bool evsel__is_leader(struct evsel *evsel);
>>   void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
>> +
>> +#define reverse_64(src, pos, size)	\
>> +	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
> hum, is this reversing anything?
> could you please add comment describing what this is doing?

Sure will do.
Thanks for review
Maddy


> thanks, jirka
>> +
>> +u64 evsel__reverse64_branch_stack_flags(u64 value);
>>   #endif /* __PERF_EVSEL_H */
>> -- 
>> 2.31.1
>>
