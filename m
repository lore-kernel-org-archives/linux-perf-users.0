Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8CB33C0;
	Tue, 25 Jun 2024 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299669; cv=none; b=bWxW4Zt/dG10ayiRv43V9Fnq3EvFuR16ELDhymsDuDVP8aHDt9vWK/cK8oMt+I0X+apISvcVUJDMZKeRtaCG3QTj9waKJyzPVOVSqgPG3DiZEEagh91xXW5SE0sdpBGUSTqZt64WHeYTeRUuL3s5XUvZytYlSgqf+8uCGyriON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299669; c=relaxed/simple;
	bh=gV5H2/+wJ39fHmY1vLnJqPvHYi5BeCn6GqIMHKbRROU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juYhKCXOR9g7TgXU8LkZ9nEmVJWfgjOSyYtBNtKTa0ft3PfyuNE8FUqA6G0TtxpNDjipLwJ5yAvFcucZzqKkE9fSVnB21OXAShAPAIeyKk+hU6vxSkSafsLAx1YZqjesA2bPwjK6bl+FMnuLOBXAt0EmkkcaSRdk711UhwQBmPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XDDxzY2c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XDDxzY2c"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P6wxNb006810;
	Tue, 25 Jun 2024 07:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=R
	cmRhsFtilKqERwPnwEI5aWMqtyGlt3CqGQPHQLZ2Fo=; b=XDDxzY2cUZIJtP511
	gcnINNOd95Jt6inbpPZpzRfJH2mEEHBchV8P3FNrZYreX78Gv/E9p2TCId27pVjY
	o/Agz4WBlHk4BZORjWd+SnoCWFN94Dv3g8+LPu1tp3ka3J4acREu7uzZuA9Qf6/t
	XTeGvHusECv43xT2ZJqbUk0qp0NwOk8n/Gc/3DwI6hfcT4MpKKikMJasPO3RhFKH
	EmIPsueYiJ08mdW5liF7i7HEW4fG7EJeyQWRjECYwse4ttyqO9m30zx5rtnVaG+Z
	Zv/XsmEGsLVuDjKNlULnf4jmTU26sj5SfIOFa4oY7dXOLjICjSJayk9Zu8QyqavS
	jWkNQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yys3f01aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 07:14:08 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45P7E8Lh030436;
	Tue, 25 Jun 2024 07:14:08 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yys3f01a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 07:14:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45P4rQgF020024;
	Tue, 25 Jun 2024 07:14:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxb5mctta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 07:14:07 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45P7E45020447854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 07:14:06 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9620858057;
	Tue, 25 Jun 2024 07:14:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E73B05805D;
	Tue, 25 Jun 2024 07:13:55 +0000 (GMT)
Received: from [9.43.96.146] (unknown [9.43.96.146])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Jun 2024 07:13:55 +0000 (GMT)
Message-ID: <061fce39-3ca8-4f49-9b4a-974024a84b3f@linux.ibm.com>
Date: Tue, 25 Jun 2024 12:43:53 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] perf sched map: Add command-name, fuzzy-name options
 to filter the output map
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Athira Rajeev
 <atrajeev@linux.vnet.ibm.com>,
        Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
        Fernand Sieber <sieberf@amazon.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240618180708.14144-1-vineethr@linux.ibm.com>
 <ZnpOD-Y9nHbO861i@google.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <ZnpOD-Y9nHbO861i@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qCVg9K45l_k8xYGs2k_SZPa9gI1kIH6L
X-Proofpoint-ORIG-GUID: YFnDz_qVQ-_CpNh4569gIX5heqm6oiRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_03,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250051

Hi Namhyung,

On 25/06/24 10:26, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Jun 18, 2024 at 11:37:08PM +0530, Madadi Vineeth Reddy wrote:
>> By default, perf sched map prints sched-in events for all the tasks
>> which may not be required all the time as it prints lot of symbols
>> and rows to the terminal.
>>
>> With --command-name option, one could specify the specific command(s)
>> for which the map has to be shown. This would help in analyzing the
>> CPU usage patterns easier for that specific command(s). Since multiple
>> PID's might have the same command name, using command-name filter
>> would be more useful for debugging.
>>
>> Multiple command names can be given with a comma separator without
>> whitespace.
>>
>> The --fuzzy-name option can be used if fuzzy name matching is required.
>> For example, "taskname" can be matched to any string that contains
>> "taskname" as its substring.
> 
> Can we split the changes into separate commit?
> 
>  1. add --command-name filter, but I think --task-name is better.
>  2. add multiple name support using CSV
>  3. add --fuzzy-name support
> 
> Although change 2 and 3 can be trivial, having them separately would be
> better for reviewers.
> 

Sure, I will do that.

>>
>> For other tasks, instead of printing the symbol, ** is printed and
>> the same . is used to represent idle. ** is used instead of symbol
>> for other tasks because it helps in clear visualization of command(s)
>> of interest and secondly the symbol itself doesn't mean anything
>> because the sched-in of that symbol will not be printed(first sched-in
>> contains pid and the corresponding symbol).
> 
> I feel like '**' might be getting too much attention in the output.  As
> it's not interested, less characters like '-' could be used.
> 

Yes, '-' seems better, will do that.

>>
>> When using the --command-name option, the sched-out time is represented
>> by a '+'. Since not all task sched-in events are printed, the sched-out
>> time of the relevant commands might be lost. This representation ensures
>> that the sched-out time of the interested commands is not overlooked.
>> The sched-out values for non-current CPUs are skipped because the sched-out
>> symbol would be irrelevant.
> 
> Well, I think it's also a sched-in of another task, we can use '*- '
> instead of adding a new '+' sign for sched-out.
> 

Sure, will change it.

>>
>> 6.10.0-rc1
>> ==========
>> *A0                     794225.687532 secs A0 => migration/0:18
>>   *.                    794225.687544 secs .  => swapper:0
>>    .  *B0               794225.687628 secs B0 => migration/1:21
>>    .  *.                794225.687639 secs
>>    .   .  *C0           794225.687704 secs C0 => migration/2:26
>>    .   .  *.            794225.687715 secs
>>   *D0  .   .            794225.687829 secs D0 => perf-exec:332914
>>    D0  .   .  *.        794225.687926 secs
>>    D0  .   .  *E0       794225.689369 secs E0 => schbench:332916
>>    D0  .  *F0  E0       794225.689409 secs F0 => schbench:332917
>>
>> 6.10.0-rc1 + patch (--command-name perf)
>> =============
>>    ** *A0  **  **       794226.581112 secs A0 => perf:332915
>>       +A0               794226.581145 secs
>>    ** *A0  **  **       794227.582150 secs
>>       +A0               794227.582162 secs
>>    ** *A0  .   .        794228.583167 secs
>>       +A0               794228.583177 secs
>>    ** *A0  **  **       794229.634027 secs
>>       +A0               794229.634040 secs
>>    ** *A0  .   **       794230.635045 secs
>>       +A0               794230.635058 secs
>>    **  **  ** *B0       794231.204272 secs B0 => perf:332912
>>               +B0       794231.204352 secs
> 
> Something like:
> 
>      -  *A0  -   -
>      -  *-   -   -
>      -  *A0  -   -
>      -  *-   -   -
>   ...
>      -   -   -  *B0
>      -   -   -  *-
>
 
Got it. I will send a v5 with the suggested changes. Thank you for reviewing it.

Thanks and Regards
Madadi Vineeth Reddy

> Thanks,
> Namhyung
> 

