Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BADBC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 04:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38BAB610A0
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 04:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhJ1EdS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Oct 2021 00:33:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhJ1EdQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Oct 2021 00:33:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S4INo4002577;
        Thu, 28 Oct 2021 04:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gWZQxtC5mAazBi5uYz7gq8iDpyHzF/Gg6yAloyjZWPA=;
 b=cnhQMxqIyICjNS/0mKjmk3MrPVIGLIG6Y/BliebMDIUsyHxeiMntb0hTkzlEVaFCZWx2
 MauXBsl1RpfpJH1aNUANgFBPT5CxfNFKelKerv8bka36OTGVI0sl6Ce9FkNQxvsZxD1m
 GzORvn2O5oiD7chBp7vlzw9xVNdkgR82xPrIgc9cKNVW9ovLBk+pcx8VPKZli/sVm+dY
 d36oUMyr7Wnp9SfTOA8Ja6mslg80cuGbRFuk2pG52JMTgNIZz215C/8+Ae6Vo/w+sCzE
 Z7V5tuuDHFJqTPgp5RNsRoTGXTE9aSKI+kw7I0irQU192ncsA5CTsc/hz76+wdqd/7j6 GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bymqjr59h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 04:30:40 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19S4UIck013112;
        Thu, 28 Oct 2021 04:30:40 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bymqjr58a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 04:30:40 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19S4HYxw027557;
        Thu, 28 Oct 2021 04:30:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3bx4f7uyyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 04:30:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19S4UX1t48103690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 04:30:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 053D742045;
        Thu, 28 Oct 2021 04:30:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26D7742047;
        Thu, 28 Oct 2021 04:30:29 +0000 (GMT)
Received: from Madhavan.PrimaryTP (unknown [9.43.20.1])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Oct 2021 04:30:28 +0000 (GMT)
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
Message-ID: <63711ad2-a62e-e4b1-4321-b8de8314e2c3@linux.ibm.com>
Date:   Thu, 28 Oct 2021 10:00:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <FD195114-27C2-4F8F-B05E-2E9D5595C4EF@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Vfzycd9Zz66R2mTv3v8xC4xtIH6rjdNf
X-Proofpoint-GUID: ru05VoRYMhWpysqSESY9WdcwtBu7LcfC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110280021
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

I did. I ran 'perf test' and did not see any fail. I did not do 'perf 
test python', will check that out. My bad.

Maddy


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
>> ---- end ----
>> 'import perf' in python: FAILED!
>> [acme@quaco perf]$
>>
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
