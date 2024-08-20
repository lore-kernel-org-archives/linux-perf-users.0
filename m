Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03910A24;
	Tue, 20 Aug 2024 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724176970; cv=none; b=jA/yB//Gw4kdTbpGbY5wZt/1B6J/NVjq22GMerG2M3dNw1QFdzY5F88RsblsUuWgdNfnfJ1klu6GIcb/NcfZ5PwrHXcFZv6YUSvnjw3v00FR0XxAEloGM0MkqhS1m2S2bgnTwCD0MMZzztqSlhzdvI1PshAT0mBauQqZuH18AjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724176970; c=relaxed/simple;
	bh=iSqNOsCxBquraU6mIesrLuVfzrgI3A6X/HDSmIqZno8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=XOobO6buM9vuPyTC4sNhN3dQ2fat/k0BITVH4cXnsqwt1yTRn8Vo6G9/HeSQvaBDko8t4cXqWFummUZ8hK5qMVGEkzhiJi8MPm+BhHmWN/chE3oHcq6mWbytc5+4v/BGrqT2K5wyWq2eXIqUjryIR+5gi+72xD3XpCuI1XEeWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aV8O4s4m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aV8O4s4m"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KDnUvA027428;
	Tue, 20 Aug 2024 18:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:references:from:cc
	:reply-to:in-reply-to:content-type:content-transfer-encoding; s=
	pp1; bh=Rikyvsd0HhNcc2B9hSzBfYnTTE1dA/oGWZIVAoBhWwE=; b=aV8O4s4m
	sUuTVA4secYek5Hm+C+NDGhZecMVj1VkiWFPp7UabaRRoAVLa3K3JiVAQWUw5yoD
	GSVXMieiL9ZVdwdqKVg98rjufq3d32+Q1AUghSIsi85oOW/uDsCFSwc5c8Mq95oi
	itQdKT2jdnDhEiIuK1V9HPk0eBi1GA7fVDatmQYgzDBMXHL0hGUzvjgwfPTrH3d/
	NwUMnUCpZuOwkv1whn1tcywexBz0Rx7SyvhjtUulumyQlpWrs7NTq0i9kwPRv3Qb
	NZdNJ0YMZcV6IoupNcCi/8qS6pmVdUJogUEEi2Ig9Y2/H1tyYYEYoIV2fwgFgWwy
	6YM60vnL89bNzA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1qf21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 18:00:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47KHvjs5022873;
	Tue, 20 Aug 2024 18:00:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y1qf1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 18:00:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47KEE9Tq003097;
	Tue, 20 Aug 2024 18:00:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k0m5k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 18:00:28 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47KI0Qc51704676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 18:00:28 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 557A258056;
	Tue, 20 Aug 2024 18:00:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9375358045;
	Tue, 20 Aug 2024 18:00:17 +0000 (GMT)
Received: from [9.43.7.117] (unknown [9.43.7.117])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 18:00:17 +0000 (GMT)
Message-ID: <05cd1773-d0c9-4c89-a6f3-f4daa4371b21@linux.ibm.com>
Date: Tue, 20 Aug 2024 23:30:15 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf sched timehist: Fixed timestamp error when unable
 to confirm event sched_in time
To: Yang Jihong <yangjihong@bytedance.com>
References: <20240819024720.2405244-1-yangjihong@bytedance.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reply-To: 20240819024720.2405244-1-yangjihong@bytedance.com
In-Reply-To: <20240819024720.2405244-1-yangjihong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -Yc2PHsg-VvG3ZbLgxrBkzQYYcg5KbjX
X-Proofpoint-ORIG-GUID: fYONtE1AXefq_w_11F5A-CGYTr5W59SF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_13,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200131

Hi Yang Jihong,

On 19/08/24 08:17, Yang Jihong wrote:
> If sched_in event for current task is not recorded, sched_in timestamp
> will be set to end_time of time window interest, causing an error in
> timestamp show. In this case, we choose to ignore this event.
> 

Why sched-in is not happening for the perf task continuously

perf sched record -a sleep 5

perf sched script
            perf   19593 [000] 42668.450179: sched:sched_stat_runtime: comm=perf pid=19593 runtime=69449 [ns] vruntime=7303687 [ns]
            perf   19593 [000] 42668.450190: sched:sched_stat_runtime: comm=perf pid=19593 runtime=6039 [ns] vruntime=7309726 [ns]
            perf   19593 [000] 42668.450191:       sched:sched_waking: comm=migration/0 pid=19 prio=0 target_cpu=000
            perf   19593 [000] 42668.450192: sched:sched_stat_runtime: comm=perf pid=19593 runtime=2397 [ns] vruntime=7312123 [ns]
            perf   19593 [000] 42668.450193:       sched:sched_switch: perf:19593 [120] R ==> migration/0:19 [0]
     migration/0      19 [000] 42668.450195: sched:sched_migrate_task: comm=perf pid=19593 prio=120 orig_cpu=0 dest_cpu=1
     migration/0      19 [000] 42668.450200:       sched:sched_switch: migration/0:19 [0] S ==> swapper/0:0 [120]
            perf   19593 [001] 42668.450308: sched:sched_stat_runtime: comm=perf pid=19593 runtime=112515 [ns] vruntime=9972397 [ns]
            perf   19593 [001] 42668.450311:       sched:sched_waking: comm=migration/1 pid=24 prio=0 target_cpu=001
            perf   19593 [001] 42668.450313: sched:sched_stat_runtime: comm=perf pid=19593 runtime=4690 [ns] vruntime=9977087 [ns]
            perf   19593 [001] 42668.450314:       sched:sched_switch: perf:19593 [120] R ==> migration/1:24 [0]
     migration/1      24 [001] 42668.450316: sched:sched_migrate_task: comm=perf pid=19593 prio=120 orig_cpu=1 dest_cpu=2
     migration/1      24 [001] 42668.450322:       sched:sched_switch: migration/1:24 [0] S ==> swapper/1:0 [120]
            perf   19593 [002] 42668.450385: sched:sched_stat_runtime: comm=perf pid=19593 runtime=67379 [ns] vruntime=2885994 [ns]
            perf   19593 [002] 42668.450389:       sched:sched_waking: comm=migration/2 pid=30 prio=0 target_cpu=002
            perf   19593 [002] 42668.450391: sched:sched_stat_runtime: comm=perf pid=19593 runtime=5526 [ns] vruntime=2891520 [ns]
            perf   19593 [002] 42668.450392:       sched:sched_switch: perf:19593 [120] R ==> migration/2:30 [0]

The perf task (PID 19593) is being switched out without being switched in after CPU migration. The task migrates to a different CPU,
and then immediately switches out without a sched_in event in between.

Thanks and Regards
Madadi Vineeth Reddy

> Test scenario:
>   perf[1229608] does not record the first sched_in event, run time and sch delay are both 0
          
