Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBDC1B5808
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651107; cv=none; b=RfjGlYLUP91hFis0H9dcU1yzRekLpjObwg6tHMF0kRxq3E2gVvxECLzI6xP4bKzxfwkcJIWsE4TcmOhaf2ztOskI7JoNoUz/wfOHieUzVy3Dmbx1BG2T4fxclIkw864EXt+HOgnB7TDqhjyvbZwBeyn+5sSg3KwtwE3Fl3CerM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651107; c=relaxed/simple;
	bh=AcbDYYWPdTNlHwpS8mDd/p/eEIPj0lolgdTUQTaunY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBeRkH7+hnJbtd/ZknZr8mp4Xv62TDJrMw7DFxdq1cZolwiorxV+h1YMnJl1RwP9n28nkEuaIqHJTnQ4el3KFjx0x+SWipwvG7N3yhrLRKhwAOa33fqA3Y0ko3y6P99TRmSUBbSLrL8U5iDW2+PL+PV/WPJOQ7FGciaQ6vUG1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBVLlznE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBVLlznE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723651104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeCWDlq5u7YVBDhrqdZQCNswhazO3zxtIgjkorLFiog=;
	b=QBVLlznEbFBaI2ovK7OGj1fNZrVkWMtF/ew5LhyJEb21WjSd8zEGLBpNDoF9upEXrxijwM
	6rnfhZZmRf2xy+JQUVpnroE+N4cksORf1NqVPQJSbeVFgwp9zfstJqfe7ositGGh421hQZ
	u71WFq9TVaR7LlFh/ksRuTCjKgb/698=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-RXAIEcPhPKOL0tT0_FAhOQ-1; Wed, 14 Aug 2024 11:58:23 -0400
X-MC-Unique: RXAIEcPhPKOL0tT0_FAhOQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280291f739so51639835e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 08:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651102; x=1724255902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EeCWDlq5u7YVBDhrqdZQCNswhazO3zxtIgjkorLFiog=;
        b=KyN0lmDEdG6cdMxY7kdrC1TGW6P3TMhY7hPchd+vSZBi7Zmn2w1T02MlzMpEPsS0N5
         T7bhnotFdbWRxHCH1Kv1A47whM3fnSRPYvxr1/LS7YaZvz3vEbQr0jug7KRSZQvoY9AP
         qhPBTyotvuz5Bau9zEVBZJXnqnUiFoSEGuqcLSzZwMgDRNjFIKD2+L/HZ50LX5RvalOa
         evTszFORnJT133+icISrm/RiiulDKnf04xt+KPwcBXabRzzQPmzPIGq2/UIQ8iwJrViE
         3LVvRgA9jTLwW46ci5TPH+ltPYQfSQeOo+iPDi8/zaMZqpmQHaMSMerPvWeZcO8htVxA
         dz9A==
X-Gm-Message-State: AOJu0Yxo9j0exI6NmCb6Wr+nlblQtDv9YmJVXNyNOf3246Xm5CMBnRlx
	8Ltnql7FJhsfWIZBjODaPWFMTDQOhijNkIoq83WFkOIsXfWV5xHR5H+VY0UMhzWFb7XawaMzaHn
	1T0t/x1humqLaa9BRJ/s4ELbekr0r4/xzOm9/BVDIQ81mVUV/xaVMzgss5+LsCcGVRJU=
X-Received: by 2002:a05:600c:354b:b0:426:654e:16d0 with SMTP id 5b1f17b1804b1-429dd1e5775mr26414825e9.0.1723651102116;
        Wed, 14 Aug 2024 08:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPFaBxnwyFXTTokRjjCbfA2y3hUFyCd59+hQSXw/jr8oZFXBbG2T8Glgxvc2aEgwjdWr9qCQ==
X-Received: by 2002:a05:600c:354b:b0:426:654e:16d0 with SMTP id 5b1f17b1804b1-429dd1e5775mr26414325e9.0.1723651101114;
        Wed, 14 Aug 2024 08:58:21 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d780ba5dsm64859295e9.0.2024.08.14.08.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 08:58:20 -0700 (PDT)
Message-ID: <58a96e3e-8422-4769-8590-096ea0f1bd42@redhat.com>
Date: Wed, 14 Aug 2024 17:58:20 +0200
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
 <ZrzTS46l3Ct_I0Oj@x1>
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <ZrzTS46l3Ct_I0Oj@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/24 17:54, Arnaldo Carvalho de Melo wrote:
> On Wed, Aug 14, 2024 at 05:42:01PM +0200, Veronika Molnarova wrote:
>>
>>
>> On 8/14/24 17:35, Arnaldo Carvalho de Melo wrote:
>>> On Wed, Aug 14, 2024 at 12:32:39PM -0300, Arnaldo Carvalho de Melo wrote:
>>>> On Wed, Aug 14, 2024 at 05:17:34PM +0200, vmolnaro@redhat.com wrote:
>>>>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>>>
>>>> Ok? I'm applying it with this change. Thanks,
>>>
>>> So I added this to the log message:
>>>
>>> Committer notes:
>>>
>>> Instead of disabling ShellCheck warnings all the uses of 'uname -n',
>>> i.e. those:
>>>
>>>   In tests/shell/record.sh line 35:
>>>   default_fd_limit=$(ulimit -Sn)
>>>                             ^-^ SC3045 (warning): In POSIX sh, ulimit -S is undefined.
>>>
>>> We can just switch from using '/bin/sh' to '/bin/bash' for this test, as
>>> bash _has_ 'ulimit -n', so ShellCheck will not emit that warning.
>>>
>>> There are dozens of 'perf test' shell tests that do just that,
>>> '/bin/bash' is a reasonable expectation for those tests.
>>>
>>> ----------------------------------------------------------
>>>
>>> Please let me know if you find any issues with this course of action,
>>>
>>> Thanks,
>>>
>>> - Arnaldo
>>>
>> If so then the check whether the ulimit is supported doesn't need to be done
>> as bash is given as a requirement. Thought that it should be supporting all
>> possible shells, even though couldn't find shell not supporting 'ulimit -Sn'.
>>
>> Can I send a quick fix that just changes to the '/bin/bash' so that the code
>> won't have unnecessary code?
> 
> See my last message, I went with your v2 + switch from /bin/sh to
> /bin/bash, as you suggest above.
> 
> - Arnaldo
> 

Yeah, that's what I have just sent. Hopefully all good. Either way works fine.

Thanks,
Veronika

