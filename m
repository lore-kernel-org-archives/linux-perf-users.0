Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA21F9414;
	Thu, 14 Nov 2024 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578259; cv=none; b=dnWFQ6YV1w2I/+S6g03hM6SmIQ6A0hSTE3GvI11RxIt2VVmZUCo+cID1/MeTb8/Lq7gY84cO6waV0KViYPwiEitrpEoUc80XD6pJMr+HLiPHRQA9c+f2iyRfEflZkxPPQ1Ta0z621OYkh5aJBibaiohwNuCAgh57ZoMive5eowM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578259; c=relaxed/simple;
	bh=LuJ9RFxfvwF9poxtJ6oisMDfJ6bol6LPs82/2DnPlrg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KdVZt5Zr/3736G4Wh8Us4ofolptUu6YnHbbJs53YlCUQpqsUZO9NgPpRldMHaXWKTu1GcEnbJrp4W3neTFe/3pGpMOMCyNbJcGbjv1pYMKj2vFm+v1HGcDKFaSBsazShWKKIqTDU2IH3YATo3SagtH8rV5vNKY1t5zR/y0Xk8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mFWsnrD2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mFWsnrD2"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE8ALVO021771;
	Thu, 14 Nov 2024 09:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7az27h
	/CNlQ8K2lsBhNTnLMlP/cCbq3ALIRSFw5uDZI=; b=mFWsnrD2wBFKSP19XZbjD+
	ndBUaxkBLcRH26Vid/E59y4RoIdnwsxdxJBfLZs/mvc89wPniKZFgLxwn2M6HQBz
	GgI/+IJUlKldEI+V0UAFKDZLfUXpyvqJUb3jl4t2ZE3Spl09eDvwewuSipLnN/Es
	sLDLYhtS+xbfWMeTZtEeGwVOV0UCF1uP1pITUe7lCVVevqgKnyzi+5I3iGC32bz/
	+0G7uVZhYA9s6HhYReu+dLlBwDI5Gq5MVTxZIU2eamGwBJPK1pfQ+Afnuh2OMxFM
	TvnWtUy/WBwGfa7lqUaR2mYXOEhWhqaXuocogCHVDPDVzplFkIWZwPJhEF5L1IqQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wdf00mu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 09:57:09 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AE9v8J1016643;
	Thu, 14 Nov 2024 09:57:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wdf00mu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 09:57:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE0FehL017519;
	Thu, 14 Nov 2024 09:57:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tk2n03ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 09:57:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AE9v3rH16318764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 09:57:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9281A20115;
	Thu, 14 Nov 2024 09:57:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15D302010F;
	Thu, 14 Nov 2024 09:57:03 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Nov 2024 09:57:03 +0000 (GMT)
Message-ID: <8f5f5278-bad2-42e0-862d-55f285f5bd67@linux.ibm.com>
Date: Thu, 14 Nov 2024 10:57:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
To: Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
        Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <1f83be89-b816-48a3-a7ee-9b72f07b558e@linux.ibm.com>
 <20241113155040.6a9a1bed@gandalf.local.home>
 <20241113211535.ghnw52wkgudkjvgv@jpoimboe>
 <20241113171326.6d1ddc83@gandalf.local.home>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20241113171326.6d1ddc83@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _xcw2Sm9TRgD4Bgx1V7y4IKtB4jiTYyL
X-Proofpoint-ORIG-GUID: PNE2pZeHvfUBfc6fAQGZvjQLaqf9Bi3V
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411140073

On 13.11.2024 23:13, Steven Rostedt wrote:
> On Wed, 13 Nov 2024 13:15:35 -0800

> BTW, the following changes were needed to make it work for me:

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 933e47696e29..ca4ef0b72772 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
> @@ -73,15 +73,15 @@ static int find_fde(struct sframe_section *sec, unsigned long ip,
>   		    struct sframe_fde *fde)
>   {
>   	struct sframe_fde __user *first, *last, *found = NULL;
> -	u32 ip_off, func_off_low = 0, func_off_high = -1;
> +	s32 ip_off, func_off_low = INT_MIN, func_off_high = INT_MAX;

Coincidentally I was experimenting with exactly the same changes, except 
that I used S32_MIN and S32_MAX.  Any preference?

>   
>   	ip_off = ip - sec->sframe_addr;
>   
>   	first = (void __user *)sec->fdes_addr;
> -	last = first + sec->fdes_nr;
> +	last = first + sec->fdes_nr - 1;
>   	while (first <= last) {
>   		struct sframe_fde __user *mid;
> -		u32 func_off;
> +		s32 func_off;
>   
>   		mid = first + ((last - first) / 2);
>   

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303) and z/VSE Support
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des 
Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der 
Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

