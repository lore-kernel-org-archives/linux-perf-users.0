Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EA31BD008
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567064; cv=none; b=TZHbMwbJWDLJS4hg32vth1KgSQLBVxaD7CYWOAFGsEK8ZnzW/d6z/P0rIhosF0WjhLxIh8wuiwOyrIAEgKpzDH+iYl8nnrJyJMOUhIrBfCCVt7QrdfNAXat/ls2dqjnl/fczJZo71X6Qvo0ZuhM5+uIw3lwuE3sdZM1amXFRAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567064; c=relaxed/simple;
	bh=RAeT9dWaVvX50JO8iGikj6tcJ7e+xOQyH6qeBjsxXvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nr9qxCczt1Pc6OfmPxWzfjD3gAurKGwVtQWidnlPXV9SP4ZeH6cYNWKlBGURnJ14Vl+MxgwbaY8mUNx85k68WHLU+sEcQFzmiOrTjnsBERpfXLy6Y3IGlS9OjTrFt6vLNBBdyINkiX14k7U9+cEY3ZgKpEmWAjeKGz64IhhO62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDD7U2Xg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDD7U2Xg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728567061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eTKtgjp1F3aWNeuAifuNRtvQEuoZmhxWojg4DlEXQTA=;
	b=GDD7U2XgWTjOrGJjtTtMXpjI0bB5YkyHPbNUQh0zZtBp85PNXHbtPs7pYKRDdWRWFhB+Dq
	+qN9o8Sczbp17BS4UPo16mgga2sZhn+I3Vw1G7dxfsDVreV+IRqQkUtyT3Lu+MkDGPvRTl
	kw9/21qnVhF9a5KxTzQeaEghjwaiLDY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-rpcygN8XPo6tsWwgc4PswA-1; Thu, 10 Oct 2024 09:31:00 -0400
X-MC-Unique: rpcygN8XPo6tsWwgc4PswA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb635b108so5928665e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 06:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728567059; x=1729171859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTKtgjp1F3aWNeuAifuNRtvQEuoZmhxWojg4DlEXQTA=;
        b=bDbd9KobxaQOuyy+AbA8488HQWtHhaoPTFX08gZPOx8WJr0wWXfWggQzYingzZWIYl
         5l1FfENYDp2ovCYn8fkHlTyfwGBwwe8NOcLUmpmhpa6RieSHfwSJC4f6mj/BXKoLAABf
         4I8N0xEzIlk0qnpkwqnlsvzieD5Uz4hMhBX+Azyi1XyBwi5pxvmAO7Bh9xcJmNT3nVkh
         WYEJVUJXCjLn0Jx+gdv6Sh2HfjhphMYTUVwceOuaON788lmITcTbcNIbPIgLCGKpvVNO
         clBoF/6WHg9RxyD+wtWEERiSp5Gu1gPzSVV9B5Yy03kaJ8gami2Ivmr2dS2Ddcu0kteD
         9Mng==
X-Forwarded-Encrypted: i=1; AJvYcCUxsG9VGFMTORKTu4K66hixzvakkxmyuD6/qMlC+X+KAv0ZRV4fMcDQOBKl3mv0GmljWoe2iobG8cldSnumJYZ0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq8JWiRB7136Tw7zoagUudgUyhjgZ20p045Ww68OUtKmsE7j7/
	as/kJigD4w1MhF2J2X9CPbY+tpgQH5tgizFhR6nAmTAUU07pMHtyZGWtkbbdGap+Rq1opjk5nFK
	lCc0tmJq5h3TdmLacAszYqGDXqwj6Wc9plI51UIXyDBNJzcIk57lraUJCIvmGZn6mBF0=
X-Received: by 2002:a05:600c:35d0:b0:42f:8515:e47d with SMTP id 5b1f17b1804b1-430ccf0de00mr56339395e9.11.1728567059524;
        Thu, 10 Oct 2024 06:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6oPgRswZ5lz3CiF7L4v0dfSvKhzugBSUZ0yuYpCt9k18Tu/ZJ8Tt1A1uiDFRBHqxas6HaIg==
X-Received: by 2002:a05:600c:35d0:b0:42f:8515:e47d with SMTP id 5b1f17b1804b1-430ccf0de00mr56339095e9.11.1728567059076;
        Thu, 10 Oct 2024 06:30:59 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b2780c1sm1598224f8f.0.2024.10.10.06.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 06:30:58 -0700 (PDT)
Message-ID: <af8c186d-72ba-4fcb-8737-84b665017cdd@redhat.com>
Date: Thu, 10 Oct 2024 15:30:57 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Fix probe testsuite with a new error message
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Michael Petlan <mpetlan@redhat.com>
References: <20241010051620.1066407-1-namhyung@kernel.org>
 <ZwfNL2sLL8cDy2au@x1> <ZwfNmDNzQAXf0ZQV@x1>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <ZwfNmDNzQAXf0ZQV@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/10/24 14:50, Arnaldo Carvalho de Melo wrote:
> On Thu, Oct 10, 2024 at 09:48:52AM -0300, Arnaldo Carvalho de Melo wrote:
>> On Wed, Oct 09, 2024 at 10:16:20PM -0700, Namhyung Kim wrote:
>>> On my system, it's constantly failing because of new error message from
>>> perf probe.  It should update the regex pattern to match the message -
>>> "A function DIE doesn't have decl_line. Maybe broken DWARF?".
>>>
>>>   $ sudo head -n 2 /sys/kernel/debug/kprobes/blacklist | cut -f2
>>>   warn_thunk_thunk
>>>   asm_exc_divide_error
>>>
>>>   $ sudo perf probe warn_thunk_thunk
>>>   A function DIE doesn't have decl_line. Maybe broken DWARF?
>>>   A function DIE doesn't have decl_line. Maybe broken DWARF?
>>>   Probe point 'warn_thunk_thunk' not found.
>>>     Error: Failed to add events.
>>>
>>>   $ sudo perf probe asm_exc_overflow
>>>   Failed to find scope of probe point.
>>>     Error: Failed to add events.
>>
>> We discussed this in the past, I came up with a similar patch, Veronika
>> rightly pointed out that this may point to a real problem, Masami said
>> that since these are for DWARF from assembly those are known issues, I
>> suggested Veronika checked if the CU where the function came from was
>> generated from Assembly (there are DWARF tags that have that info), IIRC
>> she said she would try to do it.
>>
>> I'll try to find out the threads and see what happened.
> 
> https://lore.kernel.org/all/ZvXhJLkJcR99Y2sF@google.com/T/#u
> 
> Veronika, was there a v3?
> 
> Thanks,
Well the patch was already applied upstream so we are talking about a fix
not v3, right? As Arnaldo mentioned, I got together a fix patch that checks
the CU for the Assembly for blacklisted probe. Michael also suggested the 
possibility to check multiple blacklisted probes if we are not able to check
for the Assembly, so I also added that.

I will send the fix patch soon as part of the perftool upstreaming patchset
to prevent conflicts happening. Hopefully, this can be at the start of the
next week if all of the checks pass.

Thanks,
Veronika
> 
> - Arnaldo
> 

