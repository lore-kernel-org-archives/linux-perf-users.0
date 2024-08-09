Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A060012B93
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Aug 2024 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168759; cv=none; b=FcFA+GotOHCYUV6XZO4MIzl/aI+z+Pmha96V4tYVJUEn1MJL2DdPG+SfRCvz4bJt87VLJgC+rSZ3n/VHGbzUDK+d9n2sNjYcPtETEpTvT72OQirZGUx/baIhZhXCYGCcpo3YYOKFcUdLM3RgPQ2RENkMfD6C3NXTiixqVQEkUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168759; c=relaxed/simple;
	bh=WqapPhJd4up6BabgiqCpDKyWdkUYttxWT5ytTZDJLbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxU0HzMUD6JpNjL9DZCzLl7IU8tphbvHVYhNdFbnRordVX0Ms8sX463UfifKhTNu5hgkteKkBoSZ2GE4xPJ6VNYaHCxBvxjU2D420++GdGpuFDs9WDM6Fu9FVHNo6Rfb18iOot2uxd0b19TmP4nRLgTNPi3zyUHTdSYNnx9xjEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HBXFiyUt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HBXFiyUt"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70eae5896bcso1439641b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Aug 2024 18:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723168757; x=1723773557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bc6qffhUwkcXDacAW5Q78/sO/0S1JDVscanGD2RO8to=;
        b=HBXFiyUtYcWRcCnJHOY6POPe5ik2oERcs65MVdkhe/R8xtK/WEabeLTTOhW9BudO2m
         egR6JaR8IIkDT/VJ/HUVTNI3i/X/Rq5fa8sC/hTHxcW/t5MB5EZdt1YVv5pQirFvnm+M
         2PGlj7Hd6aIKkmH5tWhlc/9Tb2s8ZR4lboE+TMTgkT4UeigF+6KfCDd4upUCjByHmjew
         3vCt08ChUjotiGptNjwXDHi7oS3eJ/0Zo6OWDYtMafaPOzMbqWMMMa1mZt+qcGWwPSfn
         beWl+1WsOiAPxiLhvcZWzK1QYLsCY8NGaBM5U1SgfYbW+FNlLkM9/5eMRHPVjzbws+mC
         KqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723168757; x=1723773557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc6qffhUwkcXDacAW5Q78/sO/0S1JDVscanGD2RO8to=;
        b=ns5DhHvlFXaBuDUvSYmAb9KzLcJ+F+nsT6ZKGmsRIkDkvQHudmwKVuESY1JWWrABIU
         lfJKAEo1jgg9LFS2UfWEUjBzwF7XvINNh5+bieiPCrLqJE6FSeobGGwByiyMgvyLm95f
         MUHnBz+xk13FbevKrksZ12WGOeaa10iEL1rG+X9VdwE+o1ySugqBnAT9ZHxqfVNF6bxK
         n3e87xYAHWyQ6FoKVjpdMHOjv+F3zeW/ZyLaEcrEnpS5uapmf2tIfe3UwCYhOO9FIlOH
         CTaV6+EvoqHC71nZL9uQNVuzKOXByDroO6U+bpHBoYKKG/XsMM0QHBEe9azmOzMoBGwU
         y49A==
X-Forwarded-Encrypted: i=1; AJvYcCXTDWhMXvQqYwO5s1/DOwJoWU3zhzPkYnezwKIogrnJwX/DaksaLuUjylcGlHeLlsQAYteqAwnFAfkNX1uPQ+l1ENWTD8ZsayVdsGh7g6lYrA==
X-Gm-Message-State: AOJu0YwQISb9fwsGcT/AuQZzU5mE9KXj7Ai4qmmsRpjG+nkOv5qDX9JE
	5bLPg2i4AN2G7yqoOJwBTjSROOmg+1j3l2/dgVgHk74ynsP2rrHhruHdvcXgDKw=
X-Google-Smtp-Source: AGHT+IG3he0uCvXiEW00NgfKnLWgtrpdEAA57ga0AU/qpFPwIontak7wRj1ywcp/+A5LgcQbO6J1eg==
X-Received: by 2002:a05:6a00:3a04:b0:70a:ffc7:f921 with SMTP id d2e1a72fcca58-710dc79c714mr17715b3a.22.1723168756859;
        Thu, 08 Aug 2024 18:59:16 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb209337sm1784092b3a.15.2024.08.08.18.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 18:59:16 -0700 (PDT)
Message-ID: <aa5b5bf5-64cd-4c23-a491-5e04acf53d23@bytedance.com>
Date: Fri, 9 Aug 2024 09:59:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH 1/2] perf sched timehist: Add --show-prio
 option
Content-Language: en-US
To: vineethr@linux.ibm.com
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240806015701.1309833-1-yangjihong@bytedance.com>
 <20240806015701.1309833-2-yangjihong@bytedance.com>
 <3f4a68aa-8a74-4698-bf90-d69c315d5ffd@linux.ibm.com>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <3f4a68aa-8a74-4698-bf90-d69c315d5ffd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 8/9/24 02:42, Madadi Vineeth Reddy wrote:
> Hi Yang Jihong,
> 
> On 06/08/24 07:27, Yang Jihong wrote:
>> The --show-prio option is used to display the priority of task.
>> It is disabled by default, which is consistent with original behavior.
>>
>> The display format is xxx (priority does not change during task running)
>> or xxx->yyy (priority changes during task running)
>>
> 
> I had done the following steps.
> 1) Ran 'perf sched record stress-ng --cpu 32 -l 50 --timeout 40s'
> 2) Changed the nice value of stress-ng while the record was going on.
> ps -C stress-ng -o pid=
> 64195
> 
> renice -n 10 -p 64195
> 
> 3) Then ran 'perf sched timehist --show-prio'
> 
> 343918.720052 [0015]  stress-ng[64195]    120  0.013      0.013   21.719
> .
> .
> 343958.797257 [0009]  stress-ng[64195]    130  40076.812  0.007   0.393
> 
> The output shows the final priority change of stress-ng from 120 to 130,
> but the transition format xxx->yyy is not displayed.
> 
> Am I missing something?
> 

1. I think it may be because when change the priority of stress-ng, the 
stress-ng task had been sched_out and did not run.

2.
sched_switch: A         ->  B(prio1)
sched_switch: B(prio_2) ->  C

The specific details are that:
first process the first sched_switch event, read the priority of task B, 
as prio1.
then process the second sched_switch event, read the priority of task B, 
as prio2.

Only when change the priority of task B, it is in the running state, 
will show prio1->prio2

Thanks,
Yang.
