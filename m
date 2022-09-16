Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631F4C6FA86
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Sep 2022 13:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiIPNG1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Sep 2022 09:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiIPNG0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Sep 2022 09:06:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4789D8CF
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Sep 2022 06:06:25 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GCx8hU034336;
        Fri, 16 Sep 2022 13:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IMlYVxcVsaF9tV6IScMZUOoJC7Np9CBJK2jIAa74Q0o=;
 b=dLb9GGg2b7ZAxfvdUEWam1RPOJAhqwaC3n02I4DO3PDkNQmx5VOs8ZFYlyj366q8HU0i
 ya/OPTV21EtQKxlYEcF+FmezaiX0vljPHE8NiiS3ys4hQekJjXE8awtEReWTgmq9QOK4
 uFzscsNHmaWDoynr5crkvJzhcLsHxmyj6IWLZUPsKQLWTBE6xD+IZxySsl75JCOkAAi0
 ucEE+w13MEzIXUpdzOHdqvcLZCQaulG81PxKdcSvYbfiGqpqFqhvyXk6BCOQt7Es8QPx
 8DvELDaNJtoYQP81EUQGXZ+PMFeuJsl4lS9WpfNXh/F2saL46BmE37QPI3wxcDELd1wS Iw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jms6m1d9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 13:06:16 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28GCqxBY013846;
        Fri, 16 Sep 2022 13:06:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3jm9168rku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 13:06:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28GD6AgO28311962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 13:06:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B77CCA4051;
        Fri, 16 Sep 2022 13:06:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0690A404D;
        Fri, 16 Sep 2022 13:06:07 +0000 (GMT)
Received: from [9.43.57.125] (unknown [9.43.57.125])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Sep 2022 13:06:07 +0000 (GMT)
Message-ID: <d300ce72-a965-b2f2-03ee-535f68bcd2c0@linux.ibm.com>
Date:   Fri, 16 Sep 2022 18:36:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] powerpc/perf: Fix branch_filter support for multiple
 filters in powerpc
Content-Language: en-US
To:     Disha Goel <disgoel@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, mpe@ellerman.id.au
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
References: <20220913115546.36179-1-atrajeev@linux.vnet.ibm.com>
 <ea4db5b9-ac85-ada0-5940-23255b4106da@linux.ibm.com>
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <ea4db5b9-ac85-ada0-5940-23255b4106da@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B9elza_uuHDY2gz7hOwVDxUZm4_Alyxt
X-Proofpoint-GUID: B9elza_uuHDY2gz7hOwVDxUZm4_Alyxt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_08,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160096
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 9/16/22 17:02, Disha Goel wrote:
> 
> On 9/13/22 5:25 PM, Athira Rajeev wrote:
>> For PERF_SAMPLE_BRANCH_STACK sample type, different branch_sample_type
>> ie branch filters are supported. The branch filters are requested via
>> event attribute "branch_sample_type". Multiple branch filters can be
>> passed in event attribute.
>>
>> Example:
>> perf record -b -o- -B --branch-filter any,ind_call true
>>
>> Powerpc does not support having multiple branch filters at
>> sametime. In powerpc, branch filters for branch stack sampling
>> is set via MMCRA IFM bits [32:33]. But currently when requesting
>> for multiple filter types, the "perf record" command does not
>> report any error.
>>
>> Example:
>> perf record -b -o- -B --branch-filter any,save_type true
>> perf record -b -o- -B --branch-filter any,ind_call true
>>
>> The "bhrb_filter_map" function in PMU driver code does the
>> validity check for supported branch filters. But this check
>> is done for single filter. Hence "perf record" will proceed
>> here without reporting any error.
>>
>> Fix power_pmu_event_init to return EOPNOTSUPP when multiple
>> branch filters are requested in the event attr.
>>
>> After the fix:
>> perf record --branch-filter any,ind_call -- ls
>> Error:
>> cycles: PMU Hardware doesn't support sampling/overflow-interrupts.
>> Try 'perf stat'
>>
>> Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> 
> Tested-by: Disha Goel <disgoel@linux.vnet.ibm.com>

Patch looks good to me.

Reviewed-By: Kajol Jain <kjain@linux.ibm.com>

Thanks,
Kajol Jain

> 
>> ---
>>  arch/powerpc/perf/core-book3s.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
>> index 13919eb96931..2c2d235cb8d8 100644
>> --- a/arch/powerpc/perf/core-book3s.c
>> +++ b/arch/powerpc/perf/core-book3s.c
>> @@ -2131,6 +2131,21 @@ static int power_pmu_event_init(struct perf_event *event)
>>  	if (has_branch_stack(event)) {
>>  		u64 bhrb_filter = -1;
>>
>> +		/*
>> +		 * powerpc does not support having multiple branch filters
>> +		 * at sametime. Branch filters are set via MMCRA IFM[32:33]
>> +		 * bits for power8 and above. Return EOPNOTSUPP when multiple
>> +		 * branch filters are requested in the event attr.
>> +		 *
>> +		 * When opening event via perf_event_open, branch_sample_type
>> +		 * gets adjusted in perf_copy_attr function. Kernel will
>> +		 * automatically adjust the branch_sample_type based on the
>> +		 * event modifier settings to include PERF_SAMPLE_BRANCH_PLM_ALL.
>> +		 * Hence drop the check for PERF_SAMPLE_BRANCH_PLM_ALL.
>> +		 */
>> +		if (hweight64(event->attr.branch_sample_type & ~PERF_SAMPLE_BRANCH_PLM_ALL) > 1)
>> +			return -EOPNOTSUPP;
>> +
>>  		if (ppmu->bhrb_filter_map)
>>  			bhrb_filter = ppmu->bhrb_filter_map(
>>  					event->attr.branch_sample_type);
