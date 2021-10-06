Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225C7C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 06:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56BF610A1
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 06:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhJFGl0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 02:41:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63086 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230134AbhJFGl0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 02:41:26 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19666UST003158;
        Wed, 6 Oct 2021 02:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cL6HOH+4WU1Y3INGXhF2qJkOK58+XTyJ08dWyYHlbJA=;
 b=hJ44ig6js3QfpWoegDcBKCAFojVOMzn3L8wDQG54J1BzRhvjDjbePs9UPJg0fhiJybx0
 d5Lvoh3RaSvV9F96xzNc7x5g/dLvy5NMvsPplc9z9EjrvFLw4KNqLsiuijFOKghmRUEF
 9uATs+GwL87ZRAalh3I+I6PX/nsHuH2VCn+fi5oYmhsk4v/zGmpjoAvbwk3rEdEWt4dn
 UGA1aMa/4cE4O3BpOqQmSX3LbigLAmBNbuBb6N+a26DtIwe2+31TWFUp0KsncRDGlPlX
 W/31ATTqCCHrJfirIi7MZmKyfbVmiAV/hMqJNqa0RVQRu28HHDPJ8zxvocvLyg3ei4yF Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bh2nc4cr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 02:38:54 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1966YlFK010882;
        Wed, 6 Oct 2021 02:38:54 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bh2nc4cqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 02:38:54 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1966WiWF017801;
        Wed, 6 Oct 2021 06:38:52 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3bef29xt15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 06:38:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1966XRow38797756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Oct 2021 06:33:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C84945204E;
        Wed,  6 Oct 2021 06:38:48 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.16.33])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D1C815206B;
        Wed,  6 Oct 2021 06:38:41 +0000 (GMT)
Subject: Re: [PATCH 2/4] perf: Add mem_hops field in perf_mem_data_src
 structure
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        yao.jin@linux.intel.com, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, kan.liang@linux.intel.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        paulus@samba.org
References: <20211005091837.250044-1-kjain@linux.ibm.com>
 <20211005091837.250044-2-kjain@linux.ibm.com>
 <20211005202015.GC174703@worktop.programming.kicks-ass.net>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <be06c316-d257-4175-7b33-43220014d234@linux.ibm.com>
Date:   Wed, 6 Oct 2021 12:08:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211005202015.GC174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qp_ZlBVIm8yGc52uAbjAt6CMtcMq5gLK
X-Proofpoint-ORIG-GUID: C7MqGast4V9sEP159Y066WwXnsHTlz3P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-05_06,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060040
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/6/21 1:50 AM, Peter Zijlstra wrote:
> On Tue, Oct 05, 2021 at 02:48:35PM +0530, Kajol Jain wrote:
>> Going forward, future generation systems can have more hierarchy
>> within the chip/package level but currently we don't have any data source
>> encoding field in perf, which can be used to represent this level of data.
>>
>> Add a new field called 'mem_hops' in the perf_mem_data_src structure
>> which can be used to represent intra-chip/package or inter-chip/off-package
>> details. This field is of size 3 bits where PERF_MEM_HOPS_{NA, 0..6} value
>> can be used to present different hop levels data.
>>
>> Also add corresponding macros to define mem_hop field values
>> and shift value.
>>
>> Currently we define macro for HOPS_0 which corresponds
>> to data coming from another core but same chip.
>>
>> For ex: Encodings for mem_hops fields with L2 cache:
>>
>> L2			- local L2
>> L2 | REMOTE | HOPS_0	- remote core, same chip L2
> 
> Can we do s/chip/node/ ? Hops are something NUMA related, while chips
> come in a bag or something :-)

Hi Peter,
  Sure, I will make this change in next version of this patch-set.

Thanks,
Kajol Jain

> 
>> +/* hop level */
>> +#define PERF_MEM_HOPS_0		0x01 /* remote core, same chip */
>> +/* 2-7 available */
>> +#define PERF_MEM_HOPS_SHIFT	43
