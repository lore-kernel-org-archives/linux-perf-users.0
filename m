Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D0194089
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Dec 2024 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301331; cv=none; b=nbX1V+V3U43CYjigO8JzAQEXnSDY4mShNt5iOOWTx2drqPtyvjejHmLRZseFT6POEHLegA35Y8XyPeWM3MlejqtaL29Do/uj9WMv2LBpzix89DXU4qWQBBs5weFcbf/DD2aPL77/CtC3js9Bb91UKSHtH/E3gj/4hadJrh0cSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301331; c=relaxed/simple;
	bh=N8uMZFgG8IHSfB+xh9lOEEmCYexY5E4/rl/05Fq3mMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIDhVENTNasbH10w0RbmAkr8T/78uC9UwQJXl/klHzOKomM6W+L+GdDnoJzUwGDxgk4FzY1jgm97n+jijAVs5ORRZVlkRiXWzTOYhziIDBcUQBvGDgcCSkHD82hZEUBD1aytlasC83mwuwOwXxxDUJeJ2nZ9w94KUblcJyKpt6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Sqr/6y2B; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Sqr/6y2B"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215909152c5so31642985ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Dec 2024 00:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733301329; x=1733906129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDQBqsq8re1syUGB3EUPVoBBUgfRGo2j82iuE5TLduw=;
        b=Sqr/6y2BnmYeYSMvr+994IlHKdbQMYTqlEe6uzQ683T2UpAFrEy8mZWsMh24wE8jmQ
         Bb/7efozcKuImY4mES0BuxQlHmhFK6ILv9NWmc0T8jz2puMOuxbRprzHduoLR/hBdyqN
         vr3NdByOxPb9ZOgNBJZ1e9y9L3oA82HSdQcXKFwJbE+oDmJdv1qWbfl05p9fh6nOSLAO
         22601U5WSFNR8SOGhwvypfCaA4eKzkmy8tp1bpDf2v5/jzAufp3jE/SYSB5ot4jb6sMK
         FO5MpPMIhpwjOKQC70lAZgiga9f/5i4lg7U8ZVfKSHAhHngNmjhzzaCccWk6WjP8hCoC
         jCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733301329; x=1733906129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDQBqsq8re1syUGB3EUPVoBBUgfRGo2j82iuE5TLduw=;
        b=P3i0VQhZa1IHOf3lnmDRgnZeLm/RyeloWV40uhbHHhM8jA5qa4gRqK34fQhoa2OXIV
         3qbPYAt2r6ENZz2PSQjzx04zBLD013hBlAzqC/Iugm1a+oBWX01aWjZdVU9kohGnDvWc
         q6gwoMnrztBVogh/mchp1phH8uaWFxlrj2UVAHFcZLXjfIQ8fTsQA8AtHBko71Z781QX
         vnfLMuHauFYdy3F4Z+S1sekfi7YRUW7n+gld1CGxEEV1drUmCADSf2/f+E4xAYd9SOoX
         R+uIxuZUiSXm3onT80njdmnHVgkebbOePyBeRG6KRLkk60NGPr0foAPSmwSzk2oEy4Sf
         XP2A==
X-Forwarded-Encrypted: i=1; AJvYcCWEo3LP+MEJK/Qb1HnVrFOM0YdccuFypYmfmWIXIwpILJweM48j820L4DCzNiqiu33MIL0J7t5J/oCBwd1c9fyS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywabw1UJ9XQ78rPRdQlcnxTte8x38tYWlkcplw4YxIpAwFSE950
	qTKAEkUZUcJuqmBIzJ+d7mn9gxpC2DfJcI3iwyyqUZTPwM6kwabstmQjT7sswkA=
X-Gm-Gg: ASbGncv9jXBXjRs3QI2FrFSRKRyH1/5vDUeB6uu4isTrjtxqeYCDtZBK1COzDJ6vdhH
	MUY64LNbLGUepAuj94CV5kBCEZmOGiovaKHiiO5QxF9faxIbgVbZImmR5e8uxj69ZFfMEgfftpS
	VDx4gtiEmZp7nqGXExN2QnwzOn6xBDKFkQyuWX0rDrBqYPW7isokHipi/8LS77USowFM4ZhexPf
	bfquPkYJHLuX5GKHsksomT/0/bcq7xUKG39POuHSXyIJRokcjfCf9nMxvdwhnc=
X-Google-Smtp-Source: AGHT+IHIl88GiRtSS5H37kVtzh2/vkqMLiMw9siwTdcB9OxC1muKop0oVW5neyOE9Pa/33e6ZIS/kQ==
X-Received: by 2002:a17:902:cec2:b0:215:b190:de6 with SMTP id d9443c01a7336-215bd1b44d4mr67634975ad.3.1733301328995;
        Wed, 04 Dec 2024 00:35:28 -0800 (PST)
Received: from [10.255.194.25] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2158394eb05sm55580675ad.82.2024.12.04.00.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:35:28 -0800 (PST)
Message-ID: <ff9bc82e-669b-44b7-a02c-f5c704c0cd9b@bytedance.com>
Date: Wed, 4 Dec 2024 16:35:21 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC 00/12] perf record: Add event action support
Content-Language: en-US
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, james.clark@arm.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <Z0jPPRA8JXSrwyaC@x1> <Z04qmNnt86zcGE5Q@google.com>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <Z04qmNnt86zcGE5Q@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 12/3/24 05:46, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Nov 28, 2024 at 05:14:53PM -0300, Arnaldo Carvalho de Melo wrote:
>> On Thu, Nov 28, 2024 at 09:35:41PM +0800, Yang Jihong wrote:
>>> In perf-record, when an event is triggered, default behavior is to
>>> save sample data to perf.data. Sometimes, we may just want to do
>>> some lightweight actions, such as printing a log.
>>
>>> Based on this requirement, add the --action option to the event to
>>> specify the behavior when the event occurs.
>>
>> 'perf record' is centered on saving data to disk without processing
>> events, while it has sideband events for some needs, like processing BPF
>> related events (PERF_RECORD_BPF_EVENT to catch PERF_BPF_EVENT_PROG_LOAD
>> and UNLOAD), doing things in a "live" way as your patchkit does seems
>> more appropriate to do in 'perf trace' :-)
> 
> Agreed, 'perf trace' looks like a better place as you seem to target
> tracepoint events mostly.
> 
Okay, will do it in 'perf trace'.

Attaching to a kprobe events will also be supported in the future.

Thanks,
Yang
