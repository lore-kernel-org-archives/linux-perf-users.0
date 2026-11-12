Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467405;
	b=qRirbH/QyaLsotqsIbqrvCE1v3Dv4QeNgwmAk+t/Rlw6Rtry1WLwNlcgbWxvXZ+X3vJX
	 V0WbQEPz5eRoO0OJv8dNdgZBSDl17prj3+ywzMpLYU7UWGyQVJD4493x21srdTmZ451/I
	 mM4cUrxAcBtTDWE8V3OV0TM9PeQlQP2p5M7VguIH1UjgC6/kfJYrrZaXLy6STzOXmFxcL
	 T/DJ2hDWazgTWfPt4RpDaOnE11ad35nFSoPM/7Sgq0qNn26etHM/g14/M8S1f6GTBro5C
	 v9q3vp69/Tso/kkx17etFrsUzfHukNyZ8l3xspwJi7PrbLIUuCDZZVlhpNbGOtkHh+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467405;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=W/rRXskn1BdufWToHVk55oYda0ns9aMsPb6IWtKmh/o=;
	b=Ld6onaL6nx3ZJ2ovLoU5Oqjr3RTDafVAr4sGCAvnE/pPKBp3En/dQ/JaJE53R2NViuIf
	 VVvgl/UcgSHAPj3qxehevUWV1IF5wqfRm2oM2ckYo34FEAzTdFZ9D7Rj3V0LXDqHvmICS
	 EsLH23P47NNQU/Gdwu1caw6zaLxyvLqo3teia52FdRmKrpJyf3MLrvD5bTMFqrD6EGAQB
	 LARkHHpT6vp7J5b6BHi8Qp6tYeIbEflnjfauTrszylYb1dHyu71dTjgYt+lGdF2r5rnmh
	 dwJpCxu/fGQabqncxFEAry9tobNAOe55LA7W2ytbnyAjPEul253P9uPmgEOnE+M3ZRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hX7xXhIe;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55E606A31C;
	Thu, 12 Nov 2026 07:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B55E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hX7xXhIe
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iGFa1214707;
	Thu, 12 Nov 2026 07:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W/rRXs
	kn1BdufWToHVk55oYda0ns9aMsPb6IWtKmh/o=; b=hX7xXhIe1rS9iGBvLMsysA
	P7q9XqY2+xa7T/d6/YbzjgQTKmy13QapG4D90CFqcJqmMKevxFkxojXtXIXL4fSp
	bumksGr0cpNfwpzEuC+ndpwdqthlzZ0DplMSfux1vz1u169ot3FGctHVVildwXP8
	RLa6k/Vzfq87DmN9rDp3TWWHZItIpbyP6fBnENflCrIRH/ZjS7K5/Y+rS6oH6IxJ
	hQVTowa+gV/3le9EYGHxv5XiaY39xFSHxwj8EC/o1V7gyg1rKwWgtLlj82kT9lR+
	moDmoMZjt0OWPTATmYnVn1qi+rMS202klnEWfJyOvbb7HjrP3YyV/qMMT5rdFzyw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunte9xx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 07:09:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2oxIe098155;
	Thu, 12 Nov 2026 07:09:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0va7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 07:09:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AC79l9T44892646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 07:09:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46DEE2004E;
	Thu, 12 Nov 2026 07:09:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F50D20043;
	Thu, 12 Nov 2026 07:09:44 +0000 (GMT)
Received: from [9.124.215.130] (unknown [9.124.215.130])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 07:09:44 +0000 (GMT)
Message-ID: <2c0599b0-4f3c-41f8-b87f-ce43dd289b9d@linux.ibm.com>
Date: Thu, 12 Nov 2026 12:39:43 +0530
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cpumask: Use cpumask_intersects* APIs where
 applicable
To: Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        linux-perf-users@vger.kernel.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, tglx@kernel.org,
        sudeep.holla@kernel.org, linux@rasmusvillemoes.dk
References: <20261111075945.3930230-1-sshegde@linux.ibm.com>
 <20261111091644.GW2668804@noisy.programming.kicks-ass.net>
 <c1e22acc-dedf-4f07-8d97-a79649826b99@linux.ibm.com>
 <20261111101013.GH2668564@noisy.programming.kicks-ass.net>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261111101013.GH2668564@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyNiBTYWx0ZWRfX4PvyeKhfj833
 JW7bzqjgDMB2663IELYHFkNJi8AmKiwr+wpqBv+tRSzUpQXj1ZJbisK5ggbbE99AwULCLWE6cZc
 aQZHwtBkkpoIAjz3nJ3EfqaTHJtcpabnohsLgSSNkm5Lu+zwMtBZIO8YzTtdvQ8xtK9wJo6puVg
 zmabmXZzAmnWTQqry+3oi/kgLCug9IOiEEh0I0sPJnSbKAhFAqH89vQ7H+oSdPsPwN/WUHLZLRR
 fcDc7CDD77lXoxM5Ahz5X++AxV17G1RwUp3Wp2tdPeFEefg1ZdeUstbfdCEFOfdvDtBuQEgOkK2
 MQ3ksK1aQPZKGxweyS88pb+Wdcp2MUs83utsBUE4KUwblf/x7sBUSoI9uHa1enekWIrl2IkzNFU
 xBji0CncnFqvkKmDet3xSQzcHD9gudJURMUrpwIP3XWSFtGDIhuD8k9HIVwYzieUaHwzobNTIBb
 ICD3Xap7Qvauf7EUsxA==
X-Proofpoint-ORIG-GUID: xDN--7a_gEM_fwoNlTL5CLxOCPjBtz3F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyNiBTYWx0ZWRfX4xKPj7JG9L1t
 2wH5cUTmlbXCTlNGxhx/TxYZdtLm0/0GZNmtS3xITeFlK49ibfK9ua6mdeNw4vPMKB4TTV/EHP3
 uF1UG2WJEA2FTBq4xmGOnxNZUL8YDOA=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af5663e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=5X_d3MmmmFLq946afM0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bhqMe7c_gQEN-kF8eXDZYVx3MaXYgu1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120026



On 11/11/26 3:40 PM, Peter Zijlstra wrote:
> On Wed, Nov 11, 2026 at 02:52:58PM +0530, Shrikanth Hegde wrote:
>>
>>
>> On 11/11/26 2:46 PM, Peter Zijlstra wrote:
>>> On Wed, Nov 11, 2026 at 01:29:40PM +0530, Shrikanth Hegde wrote:
>>>
>>>> Shrikanth Hegde (5):
>>>
>>>>     cpuidle: Use cpumask_intersects_and where applicable
>>>>     arch_topology: Use cpumask_intersects where applicable
>>>>    drivers/base/arch_topology.c | 9 +--------
>>>>    drivers/cpuidle/coupled.c    | 4 ++--
>>>
>>> That's not actually code I maintain. That's rjw stuff.
>>
>> Yes. Sorry, I should have cc'ed him.
>>
>> Should I split this series and send it to each subsystem instead?
> 
> I've taken the first 3 patches since that's all tip stuff. 

Thanks Peter.

> Feel free to
> resend the last two with appropriate Ccs. Its all independent patches
> anyway.

Rafael or greg may not have got a chance to see it.

I will wait for few days if the last two can be picked up from this series.
If not, Then I will resend last two as independent patches.
