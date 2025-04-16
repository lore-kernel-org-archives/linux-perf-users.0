Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F072185BD;
	Wed, 16 Apr 2025 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792642; cv=none; b=QQRKDmzQfEYg5vqAi9GPYc1OjZgXrJdvkmQxiHD46CzOntIIrLKZgmg3aIMJ0GZY358RIVDO66DxQJj56bfvDrezTqwOgmt8iAnDcdFrGCtHteWtkP4djyFv1xjAKkpkKASyWL5Bk1V8sjzZC35z0tSz1gX0UiCJXar43UV2xig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792642; c=relaxed/simple;
	bh=ogzpi81KH+w/7HXMs304OiOGXhuTe00W5RyaDiJkoDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5KyiJxiVEzmovwW+POnUd0RL5zTuj/3jb2m770ixFr1+1WfJ+kERqSG9Gi5XLTn5RZX90mp6OGQvn9GKX0oAU8IbIaFouDcAP5LB5+hkvQR/Q89SzRr3TxlphkJA2AdOxIJN7gN27PmAoS9eGRmTfiXVwBuduv7monjBwvruPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dwS6jXWb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dwS6jXWb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FNkW2t028300;
	Wed, 16 Apr 2025 08:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FMoqNz
	TmTJ2Oj5C3aEVY7IxAXr7C72lelVsy1QG8Tmk=; b=dwS6jXWb5CxwBLfSvmIOUr
	Cs7OU10+lZlr6sQ46bZ2W/yTluD5Sc0OplTG8Xhltg9cwoZcM78KosWlpNrjQyzK
	Esg12fHQek/9FBtnuWSPGLZugOk+ERExJ6U/QxhSW7ojHGQybaHSW0wgdfkhH2sz
	Okd4HTi0Xu7pM7HMSqTd8PJ4vQPCjmYYVvFVs1BuhRrC/UNOrGhoQwYpJ5/QJp9p
	gVZcLhxyiitc5kEXhQ+PYZwfPGgOBFk4egkqDllLtVxgFznlwViXmNnkLuU4uHZ2
	2l8e9p+1m8782lgzz4eJb7/Qv538dXFLf8Ktmy4vRWQyDZn0ULvs9EmPLDYsxliQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4621dx9vxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 08:37:02 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53G8I2BX007463;
	Wed, 16 Apr 2025 08:37:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4621dx9vxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 08:37:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53G8aouI016431;
	Wed, 16 Apr 2025 08:37:00 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4605727128-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 08:37:00 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53G8axNW23069322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 08:36:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D57558060;
	Wed, 16 Apr 2025 08:36:59 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E25AA5803F;
	Wed, 16 Apr 2025 08:36:54 +0000 (GMT)
Received: from [9.61.241.145] (unknown [9.61.241.145])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 08:36:54 +0000 (GMT)
Message-ID: <7a9d6df0-7263-45a9-a7d1-8acf2770fa69@linux.ibm.com>
Date: Wed, 16 Apr 2025 14:06:53 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:perf/core] [perf] da916e96e2:
 BUG:KASAN:null-ptr-deref_in_put_event
Content-Language: en-GB
To: Peter Zijlstra <peterz@infradead.org>,
        James Clark <james.clark@linaro.org>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker
 <fweisbec@gmail.com>, venkat88@linux.ibm.com,
        Athira Rajeev <atrajeev@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
References: <202504131701.941039cd-lkp@intel.com>
 <20250414190138.GB13096@noisy.programming.kicks-ass.net>
 <Z/3krxHJLaWJTj4R@xsang-OptiPlex-9020>
 <5bc5f54b-ce6a-4834-86d4-5014d44c7217@linaro.org>
 <20250415100840.GM5600@noisy.programming.kicks-ass.net>
 <20250415131446.GN5600@noisy.programming.kicks-ass.net>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20250415131446.GN5600@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VnYRnYY7GOII2cgWQLEZgixkqUPmNb0S
X-Proofpoint-GUID: d_c1ZgAWx9vlE-UN0fQ6UAlFhvfu4Ana
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1011 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160069


On 15/04/25 6:44 pm, Peter Zijlstra wrote:
> On Tue, Apr 15, 2025 at 12:08:40PM +0200, Peter Zijlstra wrote:
>> On Tue, Apr 15, 2025 at 10:14:05AM +0100, James Clark wrote:
>>> On 15/04/2025 5:46 am, Oliver Sang wrote:
>>>> yes, below patch fixes the issues we observed for da916e96e2. thanks
>>>>
>>>> Tested-by: kernel test robot <oliver.sang@intel.com>
>>>>
>>> Also fixes the same issues we were seeing:
>>>
>>> Tested-by: James Clark <james.clark@linaro.org>
>> Excellent, thank you both! Now I gotta go write me a Changelog :-)
> Hmm, so while writing Changelog, I noticed something else was off. The
> case where event->parent was set to EVENT_TOMBSTONE now didn't have a
> put_event(parent) anymore. So that needs to be put back in as well.
>
> Frederic, afaict this should still be okay, since if we're detached,
> then nothing will try and access event->parent in the free path.
>
> Also, nothing in perf_pending_task() will try and access either
> event->parent or event->pmu.
>
> ---
> Subject: perf: Fix event->parent life-time issue
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Apr 15 12:12:52 CEST 2025
>
> Due to an oversight in merging da916e96e2de ("perf: Make
> perf_pmu_unregister() useable") on top of 56799bc03565 ("perf: Fix
> hang while freeing sigtrap event"), it is now possible to hit
> put_event(EVENT_TOMBSTONE), which makes the computer sad.
>
> This also means that for the event->parent == EVENT_TOMBSTONE, the
> put_event() matching inherit_event() has gone missing.
>
> Previously this was done in perf_event_release_kernel() after calling
> perf_remove_from_context(), but with it delegated to put_event(), this
> case is now entirely missed, leading to leaks.
>
> Fixes: da916e96e2de ("perf: Make perf_pmu_unregister() useable")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   kernel/events/core.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2343,6 +2343,7 @@ static void perf_child_detach(struct per
>   	 * not being a child event. See for example unaccount_event().
>   	 */
>   	event->parent = EVENT_TOMBSTONE;
> +	put_event(parent_event);
>   }
>   
>   static bool is_orphaned_event(struct perf_event *event)
> @@ -5688,7 +5689,7 @@ static void put_event(struct perf_event
>   	_free_event(event);
>   
>   	/* Matches the refcount bump in inherit_event() */
> -	if (parent)
> +	if (parent && parent != EVENT_TOMBSTONE)
>   		put_event(parent);
>   }
>   


This issue is reported on IBM Power9 servers also. Tested the above 
patch, and issue is fixed. Hence,


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.

