Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85E51EB5EA;
	Thu, 10 Apr 2025 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300168; cv=none; b=VovrbHcPYzGPNN5n4LSK3bljVZb1V7JPCw5Amav+TbMkpy7DuddQzyXfQsJ/DmxU1b/kTSP3Qhm2E2YJKbbWAJSb88CQ4YVL9pqgZ1f7uURXzKgiwlnIUh16k2mH6fuLRsDxgGHpqr/XOFpoki/DRAIMqnCFuDYZrYSFlmWZoMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300168; c=relaxed/simple;
	bh=TumBwfA3bM/zLR60iDBfPvHTjAo0gUKZX34lLw0gDy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5nIPrz/2GD9IlrZxd4ywndpLtMgAuWbXRARYDZaMhxHd251bDsFnt+PZiChmxVTYErTvCNue4XYeXkTTNET3RRlqY5TJAfjuV56XA3IzOlZYNx/Hii2N5snqagdaD67g9uKtxc1b+mc87qskuxIAamm5C1bPnovd+fYQRYTLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S45c1rUj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S45c1rUj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ACS4Ht003741;
	Thu, 10 Apr 2025 15:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yzSzjC
	iPSU54x5J110sqkDRqoduFVAsQAn5NqJ1YDrY=; b=S45c1rUj+0b1d3udzFSMZ+
	AT//OUNfYyjZD/ggkJtM3jkqtc/6adZNYyZhiVoP6lAKF6j7fo68Jqs33U4zFjmF
	YkQ3i1cEYASjh0GKng68UVbAkW3c0E9WC/vqcSSquaS/S6Mty/yepbcZVv1q+NRQ
	n/XDiQgubR1N2x8pVj3cRS0lSxh5jCYg/TTk+E50GBiS1ZTsMnt3Djz+dt6m/n0M
	k3F9JFDf7OHHNoT1btnVJ5ZxICKFEI+32+muIvZOG48/yOc/BFN7dyCtWvhYC5C6
	bg5sAnR/z9myUYMSJrl6UvCwnTsD3a8YcIQo30/V/kPdMaLxf/wlcoFNHV7EpokQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xe13s41c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 15:49:04 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53AFQ5Yq020882;
	Thu, 10 Apr 2025 15:49:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xe13s418-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 15:49:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53ADawx0013858;
	Thu, 10 Apr 2025 15:49:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunxnwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 15:49:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53AFn0D934144740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 15:49:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2724F20043;
	Thu, 10 Apr 2025 15:49:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67AD020040;
	Thu, 10 Apr 2025 15:48:56 +0000 (GMT)
Received: from [9.124.208.29] (unknown [9.124.208.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 15:48:56 +0000 (GMT)
Message-ID: <7f6028fd-99f4-4f91-a660-cd036712844e@linux.ibm.com>
Date: Thu, 10 Apr 2025 21:18:55 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 19/19] futex: Allow to make the private hash
 immutable.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
References: <20250407155742.968816-1-bigeasy@linutronix.de>
 <20250407155742.968816-20-bigeasy@linutronix.de>
 <ced9c08c-a017-495f-978b-0c4d13992e5e@linux.ibm.com>
 <20250410152841.KypBTUMq@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250410152841.KypBTUMq@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sLO1o9SBXaHS2NqkpNMkjUD7kKMwUt6O
X-Proofpoint-GUID: cwdYC3Pp8-y04t_1GNsMfz48tD2g1RKt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100112



On 4/10/25 20:58, Sebastian Andrzej Siewior wrote:
> On 2025-04-10 20:22:08 [+0530], Shrikanth Hegde wrote:
>> Hi Sebastian.
> Hi Shrikanth,
> 
>> It would be good option for the application to decide if it needs this.
> 
> You mean to have it as I introduced it here or something else?
> 

as you have introduced it here.

>> Using this option makes the perf regression goes away using previous number of buckets.
> 
> Okay, good to know. You test this on on ppc64le?

Yes.

> 
>> Acked-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>
>> base:
>> ./perf bench futex hash
>> Averaged 1556023 operations/sec (+- 0.08%), total secs = 10  <<-- 1.5M
>>
>> with series:
>> ./perf bench futex hash -b32768
>> Averaged 126499 operations/sec (+- 0.41%), total secs = 10   <<-- .12M
>>
>> ./perf bench futex hash -Ib32768
>> Averaged 1549339 operations/sec (+- 0.08%), total secs = 10  <<-- 1.5M
> Thank you for testing.
> …
>> nit: Does it makes sense to split this patch into futex and perf?
> 
> First I wanted to figure if we really do this. I have no idea if this
> regression would show up in real world use case or just here as part of
> the micro benchmark.
> And if we do this, it would probably make sense to have one perf patch
> which introduces -b & -I.  And then figure out if the additional option
> to prctl should be part of the resize patch or not. Probably we should
> enforce 0/1 of arg4 from the beginning so maybe folding this in makes
> sense.
>

ok.

> Sebastian

