Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2934B3AE6FB
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 06:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678680; cv=none; b=qxvUcytzJOFyk7V0yCpNnGhc3VUdmckV/5q194qucww0khiV3E+JqFpRjI/GM00S7eIq3MxGEUHvcrxqEE7tNLXLI//aH4YqRAwIEEPwP1RBZ8VBOR45sNmDkY+QgixoDgSJ+YWsMtCPbdGstopZmApkjb44F5N8emK6Xtig2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678680; c=relaxed/simple;
	bh=Lgw9QfBJbWOR/qzl8zwpi2KdlTn6X/zGvFYrGNheJY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rx6CBPIkbONFU21itb9RsPFisQXSJWT6WYI76sSrpy3MvktmIPWbg8mieA9eb/UWCoEx+t79/1zZ11nwWIzH4SjtWTd/rXu+hFL4SR3EvwSVca4a0jOCOVpY245O9er1+6xKKwsLtMpSytggimf7OOcN0+mlgIIWgrprAHCVFs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WFW8IzrK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WFW8IzrK"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLnGRQ2619096;
	Wed, 17 Jun 2026 06:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QGL9XU
	f8t8wmtpOfqZQ2Sa93PRgv0LQqW457H0ZOuJQ=; b=WFW8IzrKrG31irtBXXEeSG
	iCJ+gEO/RzoUhPOqxewTH6ZDA8y4tPUx1oVEGFVgGk6EGz9x570IQLpuN4r5iZ+E
	UIC5J2OhHTHaIIK47EIw9hublWQ8MR+Z0Z+SKNtU8mvgz2AMAfojOUtqCkI7mFau
	XeDWyHZ31Wg+HRHmPd3BsfNJHcrjzlbgQ0n0qjFdNTwTZCL/g+Fx9RKdp7eCssvk
	3UqUT9/gA+B4mL+YSn/Tyt5YahLS3M+HitTE6MRxDOy5HfBqOyxOQxxTim4Xe8dV
	kzp2IuW3rsm0H329PTHMMKWHuEv0OuX3jfY8nvaJTgshvMlrTzfIPwYCpENmCThQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx1jkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 06:44:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H6YdA8020913;
	Wed, 17 Jun 2026 06:44:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudva9w7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 06:44:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65H6iUuk62849348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 06:44:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4120920043;
	Wed, 17 Jun 2026 06:44:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16B1220040;
	Wed, 17 Jun 2026 06:44:30 +0000 (GMT)
Received: from [9.224.77.157] (unknown [9.224.77.157])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 06:44:30 +0000 (GMT)
Message-ID: <64b353ab-6079-49fb-8495-06087e6686fb@linux.ibm.com>
Date: Wed, 17 Jun 2026 08:44:29 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing information in HEADER_CPU_DOMAIN_INFO
To: Swapnil Sapkal <swapnil.sapkal@amd.com>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc: Jan Polensky <japo@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        ravi.bangoria@amd.com
References: <3428df2b-abdc-4cb1-98f2-afdd759919b1@linux.ibm.com>
 <46b69b4c-b7d7-4155-93aa-62d2c34e0105@amd.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <46b69b4c-b7d7-4155-93aa-62d2c34e0105@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: fq0gOBlx2-AnFavpRkbw86N9K8GXgcLC
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a324252 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=odcnNUf13kXu-11lWZ8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfXyAzH1UTVBjIy
 NPsA25TfPSYjOJouJo2T9/ib3p3pyuyfPxtEXMMWNjBlLKG18IbIG+2G5Q6fJ7etpuQt6ossSIJ
 tqMrJx70dC0tiyO345M0QCIB4tx2rVQ=
X-Proofpoint-ORIG-GUID: IR3Nja91-OHUg7Hcn3De76j_Ga-5pkzF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfXy/BzEm2Ztrcg
 67FYgeZ3awV7lK/Pj7KzSnNFvNAQaqJZIxsRSswGcpoD0U/u1xvht013Q284st9sxvD12BuiB5Z
 ZHf/pfd1yXmu0ulim6WTmKsf68UgbzEpUBWYAWXlDF7RE1OEX0T9McBMApttARDToMOd73cwW7P
 mrsIdF4EaLFzL9PYE1bPSkfLGJmPl7m9wpeV6B7h5Z6ePUB1ao2hUDU7K3Yr8BfTq9Vp44Uf7u1
 QlNHeMbwat1VtBYCcp5e10WlCSnIA45ypsDMceWC2sHXaa+6Xyg+JHbuzzxLOwXQZfB4xl9Y+fQ
 LerAs7C1HeARG+4R2nH1oXt6ugHDqjh6UFmTe3uf6TGQusV191HZ7UbWs/iQoz/+KdWcxlqkDah
 jJRqiWprn/8i+giPYfj3PgdaGvzozCUoHn4tuiajd0DN07OLbzuYs05+BBGBVZEfq9zmk2OdHYh
 SJrtHtiOpVO/etrQ9+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170057

On 6/16/26 15:21, Swapnil Sapkal wrote:
> Hi Thomas,
> 
> Thank you for pointing this issues.
> 
> On 12-06-2026 19:03, Thomas Richter wrote:
>>
>> Hi Swapnil,
>>
>> Commit d40c68a49f69 ("perf header: Support CPU DOMAIN relation info")
>> introduced the HEADER_CPU_DOMAIN_INFO bit and the necessary data.
>>
>> However two issues came to my attention.
>>
>> 1. The documentation is incomplete.
>> File Documentation/perf.data-file-format.txt differs from the data written
>> in function write_cpu_domain_info().
>> The first two values written to the header section are schedstat_version
>> and max_sched_domains. They are missing in the documentation.
>>
> 
> I agree with this. I will update the documentation for the same.

Great Thanks

> 
>> 2. The function write_cpu_domain_info() writes a variable amount of data,
>> but does not indicate how much CPU members have actually been written.
>> This makes it much harder to read back that data from a perf.data file,
>> because the reader does not know in advance how much data to read.
>> Since the data structures also contain strings, the file section size does
>> not help at all, because strings are of variable size.
>>
>> In my opinion the structure should contain the number of CPU data to read.
>> My suggestion:
>> Modify structure cpu_domain_info, which contains the
>> missing schedstat_version and max_sched_domains fields and contains the
>> number of CPU records actually written to that header section.
>> Here is an idea:
>>
>>          HEADER_CPU_DOMAIN_INFO = 32,
>>
>>   List of cpu-domain relation info. The format of the data is as below.
>>
>>   struct domain_info {
>>          int domain;
>>          char dname[];
>>          char cpumask[];
>>          char cpulist[];
>>   };
>>
>>   struct cpu_domain_info {
>>          int schedstat_version;
>>          int max_sched_domains;
>>          int nr_cpus;             <--- new
>>          struct {
>>                  u32 cpu;
>>                  u32 nr_domains;
>>                  struct domain_info [nr_domains];
>>          } [nr_cpus];
>>   };
>>
>> The above syntax is also in sync the other sections of that documentation file.
>>
>> What do you think?
>>
> 
> I agree with you on addition of schedstat_version and max_sched_domains fields to struct cpu_domain_info.
> 
> Regarding nr_cpus: since /proc/schedstat only contains stats for online CPUs, the number of CPU stats written equals env->nr_cpus_online. This information is already available via HEADER_NRCPUS, so I didn't include it in cpu_domain_info. Please let me know if I've overlooked something.
> 

Ah, now I get it. This is fine with me but should be mentioned in the documentation as well.
See header feature HEADER_CPU_TOPOLOGY documentation. 
There is a similar situation and is expained in the comment:

       struct {
              uint32_t core_id;
              uint32_t socket_id;
       } cpus[nr]; /* Variable length records */
       /* 'nr' comes from previously processed HEADER_NRCPUS's nr_cpu_avail */  <--- here

So the reader is aware of the cross reference and what value to use when reading the feature file section.

> -- 
> Thanks and Regards,
> Swapnil
> 


Thanks.


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
