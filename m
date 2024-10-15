Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38AC1D0E0F
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989203; cv=none; b=F5itIKWf6jzmx0V9YdUbprufHqzsuz9tuxVtl8rPJ0uvKf0v8Gmdlu+yUkE1Depn9ilpyVPLgPgwZBzWH5ibApRjanKDucSlHKQIydsO9GtAzqn1N1WOk91UCulM0wokvZrKlpiafU+kn778R/JnvW9euby79uScqivSUrJPOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989203; c=relaxed/simple;
	bh=fW476nZCmDCSRgye7UwJvzeVl9dNa+iwAAalvvIkHZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROMA5l2RTiK2NpaP00SY4BdWHD10AtKO0tgtzwVq2AiJ0bt1NwBispqkEJ0FQ+U7GOouL1oMCPYJjVKzoD5dJNMILX1oESTCbRwmiWk/pwLtZEWWxJ4oyvTyBrr0HgEO1E2ciePN8w64qcmjyMWCYqCv77F2QYC1BiHOrUWTCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4F7Y0ga; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4F7Y0ga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728989200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDU1D/r+iHdlN/95BqAJt4M/vmdPwT06riD32mBzX2I=;
	b=U4F7Y0ga9ueo4j4fdoDJgbi2y6dXhtVj6v9EIPMmgqMtpg1+gjUyNrQNN1ajumbixAAue8
	6FlTmwZGr4t9VJBnBYNORj3h+QkW99T9NFMrx3bgmwhj6xD+OElt8UEZGClPoEGg96g2vB
	UzSDGD0BJsar/5b3wwmOFia9a4IK9jY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-8_NquyS0M26XRArhO-6KaA-1; Tue, 15 Oct 2024 06:46:39 -0400
X-MC-Unique: 8_NquyS0M26XRArhO-6KaA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4312731c7bfso15616835e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 03:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989198; x=1729593998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDU1D/r+iHdlN/95BqAJt4M/vmdPwT06riD32mBzX2I=;
        b=QFJo+RjWdlsRIWgJhaa34tIeiUb1jxMwJvXZt7avvX1yVCXgs/25dyaqzYiH6Bs2Sa
         n+V4x169CCqojttan3zahOg3GmonWOYLLeeW4LI62qGoT/IAKQhxSCwC1A0KPfg10RPX
         V7sFdQjcPc4uuPotRiRY+olJKnrFdk4UcTwykPsRYM9IecRaqiKt9OYQNqqMIw8ec73O
         wjKlxiCI47H4FE8c8bhNKKnORCNVdxikbBH/2EbzZgT3BmdQzIbV9XGCluC53EKt/uUM
         v0je9k1hnt3ABPGNnBY3tVCSiW9RQrpiCai9fDkRUcf1QnaUt0TEXzwhXXNhn+A6816B
         4lvw==
X-Forwarded-Encrypted: i=1; AJvYcCVy1bzy8sjdqXI+ndky6JniHLzc619X+v08kTBS7+/JRYnIlSA5PQegJEDyETqkzj/VjKJibOswTm+iMguCbkbj@vger.kernel.org
X-Gm-Message-State: AOJu0YwXMTmKgEjupxmoHCG2d8OHl6eb71LjaWHJxt6ZqUeWid0GSrVw
	ZAHbgGpBR6PA2+ETqEI051PhV7VMY2BeqQxR9nYvae9EgsgXmy+yHjrCospbkGuu3oYCCDuEWhb
	mhaZ3nWzdUYV6JqEbxFP5d4YRJelEr2E1m46JdfWKSn2oo+XB0cBeu+9GK5EWLJjK6xY=
X-Received: by 2002:a05:600c:1c03:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-4314a35ee09mr387435e9.26.1728989198387;
        Tue, 15 Oct 2024 03:46:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5tzDNsvw78nPVMi9k1REjGUg4XGV2iEzziTWMsPaqrmq2TWxV+DN6MD4mOFzehVuI5P/yng==
X-Received: by 2002:a05:600c:1c03:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-4314a35ee09mr387165e9.26.1728989197940;
        Tue, 15 Oct 2024 03:46:37 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56ea05sm14089065e9.23.2024.10.15.03.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 03:46:37 -0700 (PDT)
Message-ID: <2a212bcf-a8ee-4f10-9c5b-948b9f6895f3@redhat.com>
Date: Tue, 15 Oct 2024 12:46:35 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Fix probe testsuite with a new error message
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-perf-users <linux-perf-users@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Michael Petlan <mpetlan@redhat.com>
References: <20241010051620.1066407-1-namhyung@kernel.org>
 <ZwfNL2sLL8cDy2au@x1> <ZwfNmDNzQAXf0ZQV@x1>
 <af8c186d-72ba-4fcb-8737-84b665017cdd@redhat.com>
 <CA+JHD91skZHrEanhANQzWaq=4wpZomTn8Vab4j+wT2kHdibTkA@mail.gmail.com>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <CA+JHD91skZHrEanhANQzWaq=4wpZomTn8Vab4j+wT2kHdibTkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/10/24 16:40, Arnaldo Carvalho de Melo wrote:
> On Thu, Oct 10, 2024, 10:31 AM Veronika Molnarova <vmolnaro@redhat.com>
> wrote:
> 
>>
>>
>> On 10/10/24 14:50, Arnaldo Carvalho de Melo wrote:
>>> On Thu, Oct 10, 2024 at 09:48:52AM -0300, Arnaldo Carvalho de Melo wrote:
>>>> On Wed, Oct 09, 2024 at 10:16:20PM -0700, Namhyung Kim wrote:
>>>>> On my system, it's constantly failing because of new error message from
>>>>> perf probe.  It should update the regex pattern to match the message -
>>>>> "A function DIE doesn't have decl_line. Maybe broken DWARF?".
>>>>>
>>>>>   $ sudo head -n 2 /sys/kernel/debug/kprobes/blacklist | cut -f2
>>>>>   warn_thunk_thunk
>>>>>   asm_exc_divide_error
>>>>>
>>>>>   $ sudo perf probe warn_thunk_thunk
>>>>>   A function DIE doesn't have decl_line. Maybe broken DWARF?
>>>>>   A function DIE doesn't have decl_line. Maybe broken DWARF?
>>>>>   Probe point 'warn_thunk_thunk' not found.
>>>>>     Error: Failed to add events.
>>>>>
>>>>>   $ sudo perf probe asm_exc_overflow
>>>>>   Failed to find scope of probe point.
>>>>>     Error: Failed to add events.
>>>>
>>>> We discussed this in the past, I came up with a similar patch, Veronika
>>>> rightly pointed out that this may point to a real problem, Masami said
>>>> that since these are for DWARF from assembly those are known issues, I
>>>> suggested Veronika checked if the CU where the function came from was
>>>> generated from Assembly (there are DWARF tags that have that info), IIRC
>>>> she said she would try to do it.
>>>>
>>>> I'll try to find out the threads and see what happened.
>>>
>>> https://lore.kernel.org/all/ZvXhJLkJcR99Y2sF@google.com/T/#u
>>>
>>> Veronika, was there a v3?
>>>
>>> Thanks,
>> Well the patch was already applied upstream so we are talking about a fix
>> not v3, right?
> 
> 
> 
> 
> Can you provide a url for the patch that was applied upstream?
> 
> I just checked at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh?h=perf-tools-next
> 
> And I'm not seeing it.

Well the patch adding the failing test case that you can see at

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh?h=perf-tools-next

There was the whole patchset that contained the failing probe test case.
The patchset was applied and merged upstream so there won't be a v3 for 
the failing test case, instead we will send a fix patch resolving the 
mentioned issue. Hopefully this explains the confusion that I think
happened.

We will send the next patchset soon containing also the patch fixing
the probe issue with bad dwarf so if there will still be some confusion 
that should resolve that.

- Veronika

> 
> - Arnaldo
> 
> As Arnaldo mentioned, I got together a fix patch that checks
> 
>> the CU for the Assembly for blacklisted probe. Michael also suggested the
>> possibility to check multiple blacklisted probes if we are not able to
>> check
>> for the Assembly, so I also added that.
>>
>> I will send the fix patch soon as part of the perftool upstreaming patchset
>> to prevent conflicts happening. Hopefully, this can be at the start of the
>> next week if all of the checks pass.
>>
>> Thanks,
>> Veronika
>>>
>>> - Arnaldo
>>>
>>
>>
> 

