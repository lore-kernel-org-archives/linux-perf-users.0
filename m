Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E473264614
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407606; cv=none; b=c3V6cGagpNc6PYR4R6AYHj286/CneG/BFvZvQMkRCpCnQqAJJ+SAhmYmj24pH8KzvVcXE0yNHyCUek1+PlXR08JUpbplRO6OlVjcfNCPCvyyf10Sj30dR9buuRXn2BStxmBpiTa4PFy+LoT9ZvdnqrsVEqGmde9fHFT6xaVmYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407606; c=relaxed/simple;
	bh=nglH1992yCwgiMi9YmuQSShksMCbI7FdMzvkWdyww6Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=P3ChN4/h2S9rri88cCsLHQyWt8l4eM+aMuRPL6g0meLF9rojgw/oAcP9/zMQ1IX2aany5RTgvOx5/XI85fXCd+1RWMVcxG4/lCgLcjpFK/51TIq92ebaFaqtmHqTY6ALwfbpGKEMtqdii1gLMkVQAH++373Q+WtvDAHQowUvb1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rthHzhQv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rthHzhQv"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5Qx3c2258048
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 13:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=NEAM25QhmtwSHwN6h1JtR/UzEGoy
	Jrid/IVl+V0jOlo=; b=rthHzhQv4WiDvAtn9gklouqMq9QWKeezjAN6mCK4tfD0
	UNilPBrk3pLQSsNVp2uJiDLvQUcqDmUpb8HAQABEdQxczbtnTPNieNC3Sg/Olkof
	Sffa0dVY7fKw8texPe7lcEFa65yRYE3xtBo6X0Fk8NZEr6qJNeZ0nVCXusYXbrro
	3V9fHWGcPnPJ8fNe+OsDf3+n7h9QLaEs0swQ2XGLb6PWjHpqpL3DANZSKnQbZPGN
	9cLICaxnpHIBx20S6aDPIfU8xvrLwriE0bKGDGpBbXyKC1SZ3v5F80u5tWUdXSRW
	OFl6fy3OwwuEKeZDPV38xx0ihz6Gb4jsESBxQg+0gw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92fwfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 13:13:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAJ6x6020802;
	Fri, 13 Mar 2026 13:13:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9prff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 13:13:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DDDIgX12059070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 13:13:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A495820063;
	Fri, 13 Mar 2026 13:13:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E43E2004F;
	Fri, 13 Mar 2026 13:13:18 +0000 (GMT)
Received: from [9.111.69.213] (unknown [9.111.69.213])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 13:13:18 +0000 (GMT)
Message-ID: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>
Date: Fri, 13 Mar 2026 14:13:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Jan Polensky <japo@linux.ibm.com>
From: Thomas Richter <tmricht@linux.ibm.com>
Subject: perf stat issue with 7.0.0rc3
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: xsGvHfDOcHq3ziSgiSxoIrt8gA5PZfgF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEwMyBTYWx0ZWRfX5+Vjaady2irb
 A+7cKV6171P4qfRag8eXnb7dFWrvm4N7KtArVamt9P8X7eOaoiYH/DEkMr6/yxYgK/3Pe+RZzZK
 grJf69ua0eWqJdyTvm9wSuxHCv6zs8LydKTvwCaQH6D0VXL6OpKUUDpIWL95CPihgkSdRo3Y8Yk
 gDx4BJj3Eq4J3MRzOVfmuiMmvmEpkZVM4BOmWiYCqWfDGzpY8fgtOxUJ7OWEUq53CTheO68s3R3
 UDFWs+QvVvXLt/cXfLDfcxnJu+f/fQW5LX+XHwI0/ixgBVmnPZ/fKme44WH/f99X58j62ZHTTAp
 WWUnHHXWCjN8A/dHQSsTzH4fAvt/cNfA9XHGXd+Uitv/W3ZfB/oUvfzWeqoBWchAh+vUU4iT8VE
 Nb4Cm5AdM60eflH4es81YM3xfLsrZwjG4MD/kwriXZqJnQdoRdBPMoYIPBTQzJxk6JyFU8WU7vY
 StWwNeXFafaPLErM/YA==
X-Proofpoint-GUID: 4nqGV01Fx19qtclMJk378pTQXS38orH_
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b40d74 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=x4kxwI2lhZTCVj833_4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130103

Ian, 

I just discovered a strange behavior on linux 7.0.0rc3.

I run these commands on my x86 virtual machine:

bash-5.3# uname -m
x86_64
bash-5.3# perf -v
perf version 6.18.13-200.fc43.x86_64
bash-5.3# perf stat -- true

 Performance counter stats for 'true':

         1.108.929      task-clock                       #    0,437 CPUs utilized             
                 0      context-switches                 #    0,000 /sec                      
                 0      cpu-migrations                   #    0,000 /sec                      
                55      page-faults                      #   49,597 K/sec                     
   <not supported>      cycles                                                                

       0,002536439 seconds time elapsed

       0,001363000 seconds user
       0,001393000 seconds sys

bash-5.3#

This is the epected output, however when I use the perf version 7.0.0rc3:

bash-5.3# ./perf -v
perf version 7.0.rc3.g1f318b96cc84
bash-5.3# ./perf stat -- true
Error:
No supported events found.
trace.args_alignment
bash-5.3# 

Same happens on my s390 systems (LPAR and z/VM).
Is this a known already?
I guess this is a perf tool issue, same result when you execute this on a 7.0.0rc3
kernel.

Any ideas where to start debugging
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

