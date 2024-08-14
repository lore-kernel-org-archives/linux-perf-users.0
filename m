Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7828DC3
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651477; cv=none; b=St6/+nchUofTQV1hdVmYRxd1wWCREJbbaNJqkkS0Vxxfd+HR5Z4XjDMt8SMEDCsnkU4zNfHO4WG8R+HJ1pS4p0J9sDX/RKmrl8TdFNqmqygsJRhiX8jnciee9yj2mfTBwqu5RfEK2AGBfo9vEMpKmPkyuYE8xnjJRijc2uwLFk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651477; c=relaxed/simple;
	bh=x8PgHFvzAxMVbR/jMgBT2fk095iqblXhDWuMV2FEX1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsoGQ9UvEG7Le2sCRcR+JmTysfojZ0VfKkV1Ii7ZBsAHj4JPKNpaiQgwDvUgBplQsyOHeXUDmHxos6VDGJbfdh9kc1iKbqq9sgY9osfAGpXLYImeIwzXROmx6Yb+7rKqOmHVZTrax+D+9NUgepADZp5vwY87MdOqmh8d37UkmUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MolKYuz0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MolKYuz0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723651474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnelvawSpHfA80IUTea9YIjyD71H+vCGCwnL1NrHUxk=;
	b=MolKYuz09gsbYzxfNXmCfxKNPZXKJI6wM/rOAhLz0Khxz2YJEumY4Gj4wDcMF7o0/rHdtL
	G3GL0CvYJ/7i1mncmkhre/SQpNzPiTPBmFefX5wrjIu9+SBrBwrHIlJ4EUA/6mi+K2DKen
	3ak9EIsiVStgSc3V6bm0Vq261kOS3Eo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-2cje76t3PweN3mRZSvo6Mw-1; Wed, 14 Aug 2024 12:04:30 -0400
X-MC-Unique: 2cje76t3PweN3mRZSvo6Mw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280d8e685eso51736355e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 09:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651469; x=1724256269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnelvawSpHfA80IUTea9YIjyD71H+vCGCwnL1NrHUxk=;
        b=uXSXJv6avDB94XLJGHl6WLoEsYTDhJb5JNk4mICynB8ZCTSGqcSYDsdSfS3MWUoYIE
         WU2U1bbJywedPCEkve54V7Q1E2rTJGqyaFcoGuGmiYluExI67HIvX3itcDfKjANBxn6v
         PHdi+Qz8f6lOVG+o6b3eDKgpnv4mjHxz5intKYHQ1f+bujEmHabZXrr3NdlvWgQCdSKu
         fttiujb056XInKLGx0hXlpD2cNU65CAEnHRJYM7fVfGupTafNXoqEF4PumrJ7n6v23Sr
         qhoP72FlwJ9GprQ/pVAaH7KwmxjP9qMidUOredEa5QE9o7UMMc4gLBxWP8jBgVO1LLii
         BkvA==
X-Gm-Message-State: AOJu0YzNO57X78zcnIGhyHyjNe8wfrhbqaXQ/fRZb4WVFQ571swjPNhL
	PYKCZJt9Be9vKLXeH6b3DpdxvQJg+5H5j5wCiOo24ZxytD14HdWUeWGuXamciocB4vRzkgj2a/X
	SXDEbYXRlsskRHYkHObnGgc5265247IUO1sK50TQiFMNghzpgOXLsk4JxCfhvhh6O/z0=
X-Received: by 2002:a5d:5cd0:0:b0:367:f281:260e with SMTP id ffacd0b85a97d-371777567f9mr2018098f8f.3.1723651469354;
        Wed, 14 Aug 2024 09:04:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGglDvgVAAv89ryZ3WW6glCINoNhodDe5bTWpyiCgzRMrrgXDpbbvzfOBl6miQ4tIPS2cKrmA==
X-Received: by 2002:a5d:5cd0:0:b0:367:f281:260e with SMTP id ffacd0b85a97d-371777567f9mr2018049f8f.3.1723651468422;
        Wed, 14 Aug 2024 09:04:28 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c937b23sm13165753f8f.35.2024.08.14.09.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 09:04:28 -0700 (PDT)
Message-ID: <15098bfe-e1c1-4d97-bbb8-be26d589664b@redhat.com>
Date: Wed, 14 Aug 2024 18:04:27 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf test record.sh: Raise limit of open file
 descriptors
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com,
 adrian.hunter@intel.com, atrajeev@linux.vnet.ibm.com, irogers@google.com,
 jolsa@kernel.org, kjain@linux.ibm.com, mpetlan@redhat.com,
 rstoyano@redhat.com
References: <20240814151734.15409-1-vmolnaro@redhat.com> <ZrzOFDmwl9Z8F8NP@x1>
 <ZrzO2T1s_tIpqizG@x1> <d847f760-896e-4bdf-9f8c-933f52a5aed8@redhat.com>
 <ZrzTS46l3Ct_I0Oj@x1> <ZrzTyVLQCQPiV_D3@x1>
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <ZrzTyVLQCQPiV_D3@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/24 17:56, Arnaldo Carvalho de Melo wrote:
> On Wed, Aug 14, 2024 at 12:54:51PM -0300, Arnaldo Carvalho de Melo wrote:
>> On Wed, Aug 14, 2024 at 05:42:01PM +0200, Veronika Molnarova wrote:
>>>
>>>
>>> On 8/14/24 17:35, Arnaldo Carvalho de Melo wrote:
>>>> On Wed, Aug 14, 2024 at 12:32:39PM -0300, Arnaldo Carvalho de Melo wrote:
>>>>> On Wed, Aug 14, 2024 at 05:17:34PM +0200, vmolnaro@redhat.com wrote:
>>>>>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>>>>
>>>>> Ok? I'm applying it with this change. Thanks,
>>>>
>>>> So I added this to the log message:
>>>>
>>>> Committer notes:
>>>>
>>>> Instead of disabling ShellCheck warnings all the uses of 'uname -n',
>>>> i.e. those:
>>>>
>>>>   In tests/shell/record.sh line 35:
>>>>   default_fd_limit=$(ulimit -Sn)
>>>>                             ^-^ SC3045 (warning): In POSIX sh, ulimit -S is undefined.
>>>>
>>>> We can just switch from using '/bin/sh' to '/bin/bash' for this test, as
>>>> bash _has_ 'ulimit -n', so ShellCheck will not emit that warning.
>>>>
>>>> There are dozens of 'perf test' shell tests that do just that,
>>>> '/bin/bash' is a reasonable expectation for those tests.
>>>>
>>>> ----------------------------------------------------------
>>>>
>>>> Please let me know if you find any issues with this course of action,
>>>>
>>>> Thanks,
>>>>
>>>> - Arnaldo
>>>>
>>> If so then the check whether the ulimit is supported doesn't need to be done
>>> as bash is given as a requirement. Thought that it should be supporting all
>>> possible shells, even though couldn't find shell not supporting 'ulimit -Sn'.
>>>
>>> Can I send a quick fix that just changes to the '/bin/bash' so that the code
>>> won't have unnecessary code?
>>
>> See my last message, I went with your v2 + switch from /bin/sh to
>> /bin/bash, as you suggest above.
> 
> And added the '-S' to ulimit, since you changed that from v2, are you
> sure that is better than using just -n? Why?
> 
> - Arnaldo
> 

It doesn't matter for checking the value, 'ulimit -n' is the same as 'ulimit -Sn'.
But when setting up the value without the option -S, both soft and hard limits are
set to the provided value. For us, only raising the soft limit is important, as it
is very unlikely that that hard limit would need to be raised. Also, then the hard
limit would have to be restored separately to its original value.

- Veronika

 

