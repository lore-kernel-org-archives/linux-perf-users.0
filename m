Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB12BDC0A
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Oct 2025 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759388181; cv=none; b=Ik+wHhdFAEf2ai5tbH2zpD6PHbH4gTe8qvLB8lCsnJFj7HrHIo7Tw7xYpB/x95E2jv1e+u1WM4bMOXSI6FO0OBsfWyYVra2hgeZhOo9MugTqlYNgcRi9qiFoAFjUxPHVYHewzEC1OSN5Bwal5jiQ5HH/LqXyT7mgrQVgKtabAeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759388181; c=relaxed/simple;
	bh=TCG0XBO2cDWAPeFMoOMAdNOiY5guxLz9+hoi/Iw68bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6bOkVd6bzl87XdZBt9qe0974ZpjuK9DjaT2kQuVUyP5/7HlxpuIe5kX2X1PfS52s6JAnu8u7sWODnPPMGeLdvB5x7UsVtjr4+Lz9LaEC5+k6prYRlelKcS+K3HyXts9203H4KFPJUKyCFt0+7X5+svU0jZOstz5J4J00GkmtL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i2zhHIUV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i2zhHIUV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IK7NL020668;
	Thu, 2 Oct 2025 06:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ee2fIa
	uvZ8SLkHUrSVrrmIs6na02a2pGcm2lcFo03pE=; b=i2zhHIUVE/zSJ3F5fPoHLf
	9Sos+IsV04IdZK8cTr6sfvb/cH1OIBNE8En5BLX2iSKRCpZml8J9Zz1c7npW3UOj
	fJSXFdWPvUUCB3EHw+ddjTzf+uRFxMERwOk/D9Z3B4vsA8EwSPEll4rw95Dl+aRr
	qnWm2tYap5eH2w3U9DfM+MDoQ/1d0j3lhunqL0QAoPXX/u/HEbI/cmglhR5+y4v4
	GUgEhYlom7iJAIdSivpfuN0/1ogxs+9Pi8cy3oLYFJzAze+OJUKQI8Es1HLkkRJR
	+TdmG5hAIP2rUIsQI4lIFOPS39MJuQxeF9menQaKQyp9mmQW0WIHTVnOVRrj4CWQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7kum1cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 06:55:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5926p3ri022306;
	Thu, 2 Oct 2025 06:55:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7kum1cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 06:55:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59231rsA003325;
	Thu, 2 Oct 2025 06:55:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmy4xvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 06:55:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5926tpaG62390770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Oct 2025 06:55:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 675E420043;
	Thu,  2 Oct 2025 06:55:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DF2F20040;
	Thu,  2 Oct 2025 06:55:51 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Oct 2025 06:55:51 +0000 (GMT)
Message-ID: <906a9e47-ec19-4897-bbc0-06101d7afd24@linux.ibm.com>
Date: Thu, 2 Oct 2025 08:55:50 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: Anubhav Shelat <ashelat@redhat.com>, mpetlan@redhat.com, acme@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        dapeng1.mi@linux.intel.com, james.clark@linaro.org
References: <20251001195047.541745-2-ashelat@redhat.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20251001195047.541745-2-ashelat@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=68de21fb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=jG6JC8piQt_4cliN:21 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=j_7JRSEJEw7eidmCOrYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: aZP5r1sg0TJsqn01e4kVRqxar-6F5Y_4
X-Proofpoint-ORIG-GUID: wysA076bUj1EkEKZ9Ewhdb34sy9wyHzG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX0KKN45jDEuq6
 +ZPmYAmkIlj9S34NLz6+n6UgGcT9pRm0CpNJc72fo7PacOzFPhCpuqggoUoBHrUB41SLxZYdvCs
 2MpFhnVWCHXCZq0NdlxPL/CD9vxNL2FrBm1KDqN4TJT/WdLcgRsyiX9wCPpSExQ+YnvJaDyiqiN
 fDnLUBClh4EIX7b6QmVfNfC0+V0NPHG8uh/OjhuHcE9f1APATNAvH3szHoiuDCI2us1bEQFr28Q
 phEspiOSFhLCGcYoO6kJ9y8XzO55bOb9/E+m+RSpFdc38jed2wsL8YbYjtVi3v+psP0OEpc36vk
 Do6n4lujBEIX/RvSz2G9PkVdqdOMxGxhnLSQ/Fsa+YE1/4FU+H5md9Meb4zqb/zF923jwG8JJ8p
 qZghqjqOzdbGOh6vzu23sf/E6ve0PA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

On 10/1/25 21:50, Anubhav Shelat wrote:
> On aarch64 systems, when running the leader sampling test, the cycle
> count on the leader is consistently ~30 cycles less than the cycle count
> on the slave event causing the test to fail. This looks like the result
> of some hardware property of aarch64 processors, so allow for a small
> difference in cycles between the leader and slave events on aarch64
> systems.

I have observed the same behavior on s390 too and I guess other
platforms run into similar issues as well.

Can we use a larger range to allow the test to pass?

I suggest we 'ignore'  a small percentage of hits which
violate the range, lets say 10 %.
So if 90% of the cycles are in the allowed range, the test is good.

Just my 2 cents from debugging this on about 5 different s390
machine generations with and without virtualization and different
work-loads.

[...]

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
