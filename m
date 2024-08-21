Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225315B0E2;
	Wed, 21 Aug 2024 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724236133; cv=none; b=epgSWZuZN0fRJNUD4NdvMYVDa2e85Gw0fXUHTX3+FKT+Z3goWyNsLPKd/OKX4oQVhUsSghiG+xeSzQB/DiHubvl6Lx+IFZcM92TA88DtZZej4ND+F2H+/c+fF/mGK+J9R6NIBHp7pBwtvL1k7zWQ/u18/yJt4u2ushheFLydZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724236133; c=relaxed/simple;
	bh=psQJ368lmoItRD+OtUCpNjg6+VZdCyakyvcPbwCNjLE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=UkmVvRTCeLPKTJKich9O9JRHjRKVeFh9Wp2q83t7R8iYESrn+fHLaixL0BiQ9/s96A1N5sox5q9SZXyRMvnwoy58Ywc8uhyAICmX9yDojH3bYP1Mz1X0i4yNo1ifhgZmrlUOmhN+byvEI+/7phcCqCkVC7AgnTWfv9LqSfyOdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n8XwSPua; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n8XwSPua"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L5l8xr014037;
	Wed, 21 Aug 2024 10:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:subject; s=pp1; bh=0kn/L
	8tmX35lwBBzOfEhIW6RlLv7NUHX8o7GQujLtL0=; b=n8XwSPuaneejFZwTprkGw
	GYG2P0AYDZj6805xpIiDXLe1dy1XSdzAvBNrGqKrrt1+LKKJ49CDdHNkDzMWVcqv
	tWgocJUaWtApVZam9v3EzyPBIbWbmAP+ETr/pxiSnanjkVVvGIdkVWDkPo+gAbCS
	s8UFshkBI2mG/MlY3ZJDhs4vvbHmCE+eZO4Mv4ueyDZf9/pJeuUfG+BMzYObTcDU
	o/wXwEpnrYJTuRRmjovPX0nsVI3dAFDokAGIz5dvgwSuyYkKqaUYvRQMcnrnaOzx
	lXpgGIs/o4vd5Ev49VVq/E4xKpHpsLiDQyG1hFd99n8kpysOZ/dFF8BbGq7p2UjS
	Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mcyhk1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 10:28:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47LASSdJ027593;
	Wed, 21 Aug 2024 10:28:28 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mcyhk1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 10:28:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47L81mD4013098;
	Wed, 21 Aug 2024 10:28:27 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41366u7g9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 10:28:27 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47LASOYp30147110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 10:28:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF95A58060;
	Wed, 21 Aug 2024 10:28:24 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84DD258068;
	Wed, 21 Aug 2024 10:28:17 +0000 (GMT)
Received: from [9.43.53.186] (unknown [9.43.53.186])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Aug 2024 10:28:17 +0000 (GMT)
Message-ID: <ab337b83-ac74-43ce-83f0-25885c136574@linux.ibm.com>
Date: Wed, 21 Aug 2024 15:58:15 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yangjihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240819024720.2405244-1-yangjihong@bytedance.com>
 <05cd1773-d0c9-4c89-a6f3-f4daa4371b21@linux.ibm.com>
 <CAPePreJCahzH0LwfXN_X+UdxU54_UMRPZgDgGqt7+PC+ky997Q@mail.gmail.com>
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <CAPePreJCahzH0LwfXN_X+UdxU54_UMRPZgDgGqt7+PC+ky997Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EtkNfrq9WshBDv2Zc73isDz38OlcQm0U
X-Proofpoint-GUID: H1EumoHcvITDUWAFquR9hdigT6l95Wi7
Subject: RE: [PATCH v2] perf sched timehist: Fixed timestamp error when unable to
 confirm event sched_in time
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408210073

Hi Yang Jihong,

On 21/08/24 11:46, yangjihong wrote:
> Hello,
> 
> On 2024/8/21 2:00, Madadi Vineeth Reddy wrote:
>> Hi Yang Jihong,
>>
>> On 19/08/24 08:17, Yang Jihong wrote:
>>> If sched_in event for current task is not recorded, sched_in timestamp
>>> will be set to end_time of time window interest, causing an error in
>>> timestamp show. In this case, we choose to ignore this event.
>>>
>>
>> Why sched-in is not happening for the perf task continuously
>>
>> perf sched record -a sleep 5
>>
>> perf sched script
>> perf 19593 [000] 42668.450179: sched:sched_stat_runtime: comm=perf
> pid=19593 runtime=69449 [ns] vruntime=7303687 [ns]
>> perf 19593 [000] 42668.450190: sched:sched_stat_runtime: comm=perf
> pid=19593 runtime=6039 [ns] vruntime=7309726 [ns]
>> perf 19593 [000] 42668.450191: sched:sched_waking: comm=migration/0
> pid=19 prio=0 target_cpu=000
>> perf 19593 [000] 42668.450192: sched:sched_stat_runtime: comm=perf
> pid=19593 runtime=2397 [ns] vruntime=7312123 [ns]
>> perf 19593 [000] 42668.450193: sched:sched_switch: perf:19593 [120] R ==>
> migration/0:19 [0]
>> migration/0 19 [000] 42668.450195: sched:sched_migrate_task: comm=perf
> pid=19593 prio=120 orig_cpu=0 dest_cpu=1
>> migration/0 19 [000] 42668.450200: sched:sched_switch: migration/0:19 [0]
> S ==> swapper/0:0 [120]
>> perf 19593 [001] 42668.450308: sched:sched_stat_runtime: comm=perf
> pid=19593 runtime=112515 [ns] vruntime=9972397 [ns]
>> perf 19593 [001] 42668.450311: sched:sched_waking: comm=migration/1
> pid=24 prio=0 target_cpu=001
>> perf 19593 [001] 42668.450313: sched:sched_stat_runtime: comm=perf
> pid=19593 runtime=4690 [ns] vruntime=9977087 [ns]
>> perf 19593 [001] 42668.450314: sched:sched_switch: perf:19593 [120] R ==>
> migration/1:24 [0]
>> migration/1 24 [001] 42668.450316: sched:sched_migrate_task: comm=perf
> pid=19593 prio=120 orig_cpu=1 dest_cpu=2
>> migration/1 24 [001] 42668.450322: sched:sched_switch: migration/1:24 [0]
> S ==> swapper/1:0 [120]
>> perf 19593 [002] 42668.450385: sched:sched_stat_runtime: comm=perf
> pid=19593 runtime=67379 [ns] vruntime=2885994 [ns]
>> perf 19593 [002] 42668.450389: sched:sched_waking: comm=migration/2
> pid=30 prio=0 target_cpu=002
>> perf 19593 [002] 42668.450391: sched:sched_stat_runtime: comm=perf
> pid=19593 runtime=5526 [ns] vruntime=2891520 [ns]
>> perf 19593 [002] 42668.450392: sched:sched_switch: perf:19593 [120] R ==>
> migration/2:30 [0]
>>
>> The perf task (PID 19593) is being switched out without being switched in
> after CPU migration. The task migrates to a different CPU,
>> and then immediately switches out without a sched_in event in between.
>>
> Because the perf tool sets CPU affinity first (which causes perf process
> to migrate to the target core) and then enables events, by the time
> starts recording, task is likely to have migrated to the target core and
> started running. In this case, the sched_in event is not recorded.
> 

Got it. Thanks for the explanation!

Thanks and Regards
Madadi Vineeth Reddy

> Thanks,
> Yang
> 

