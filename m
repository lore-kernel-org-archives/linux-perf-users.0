Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345901A76AC
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843618; cv=none; b=rlufCeQlrjN+hZhiQB9zw6mVi/WOxMbl12Frero/tZpfJos3ySw6NumgtvMmbDP8G4kejdguieTPQdw1VFDeiZBGVOj2uB5fimsVqzNpCiMk2q+CA9E9nv8DLUp+0kongnspuGiXyuX9YVvJisTbvFLNFwaL4W3gsVUEjZJbjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843618; c=relaxed/simple;
	bh=JZUaVx+kEpG06IVhQ5Ty0L2YvyxFgJh/6CDRrOojlpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYB9Bdip54SbD6vzf8WK+Z7EH5G2MQueO2EJFGtC1/wCmjTQW1+pfY0ldHAjZiByqU5Q5r+GOxXQtU+XdyLcX4qm8OFQ//eX2s4/JvLrut7tsRRO/aAP/RBx71TfwxY5JivlU1fjD7ireUaZt9avoXYXv+dI4F4XoIJjzdcID6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYtD3900; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYtD3900"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733843615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSUC3vuZhvbgfWnyKS5tIq83Kb3yDVKWXKDJEtthRY4=;
	b=gYtD3900s1941AuH4a+ZUXvXbqfSuRyVYuOTljDRl2EPjgx7ZkxbpgcFE/AAOSEyncsnxV
	Meg+EfS1kY1mx6EvsSC6AbEHfkRi5Zm/toTGQGx1V+5JO2ztE82k+HDBhT1kvNRKtgCVD1
	E1lxIJksTGtojCWj1z/acIlqJBExxxQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-NFfL134hMsa5T8szvT201A-1; Tue, 10 Dec 2024 10:13:33 -0500
X-MC-Unique: NFfL134hMsa5T8szvT201A-1
X-Mimecast-MFC-AGG-ID: NFfL134hMsa5T8szvT201A
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e49efd59so2275958f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 07:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733843609; x=1734448409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSUC3vuZhvbgfWnyKS5tIq83Kb3yDVKWXKDJEtthRY4=;
        b=ZEV/bIe6wAjKSjjXWGFa5nPAscY+ByoJ3sSdjaFQJdxDIq9x0W5oVAbpoD/vmXgc1e
         8egC8dt3vi/slbs/3E3AXVw8/yEwOL0Ska/dFhh3oQL2wOsdMrmdZ1XEbnyPGbKXENNQ
         XxbGmz4Dn6d0DvVxuD2HFjKkNm2BBsYRxLBjYidLQCvVrtI1vHzzWZQ/dXgJ0PCVUEko
         GH0J3EYIJVVn+p95kmx/YEVEgDgEFe8nFnD7yGYgRwF/9pcynA4CcSIyRjgDkmfykH/T
         hyrtOuYUodnqYRVd2YGMN6q5vV+0H6T+v15LzkrLTHwJaHk4xy3rk2QHfOB/Xycx564X
         uscA==
X-Gm-Message-State: AOJu0Yz3rvFeS7hX46MU8eYtZy+ETWei9b9RiW1klagwzR2lGRgL6xge
	0Sxc0JgLyJN6WqZa0EQQ0ffLDJnkpML+HgMfdkDCSZaFU11WIS6AifObV2q11Y9uikl72qLjgkc
	l37X/p8W6jOqLrrEFTl/typiFKTXQE96e7v4cLO7f5NtbfeqmUcL9WoqiJgQtz4xL2l4=
X-Gm-Gg: ASbGncueEEhEakxA93XZPZjbzdPOD4nl8QJ4iGiLWciDQJV/6RSNj//6G3Nqlkr0OVs
	rNbIXr+BecTkhYbIU/PyNcjZNavIv4WptuD8RDuaQ4RNhgncjJRkAwVXHBo5aJ/us/q3kBxIrDx
	odxLL7h+pI6rTSoahqC1nFQq0t9hKA9U8QCuMY91hqbShO+GWEO/CF3wYhjJjo7jNpDa4W5d+lN
	dyBt0n/iPBH9bqlqJwdTAJ0ofPjiRJpLDY+FlJZrLMUrFnkwZNAY1RjrfrjZFBpWTMQP0i37fw0
	W70d
X-Received: by 2002:a05:6000:18ae:b0:386:4112:fc7c with SMTP id ffacd0b85a97d-386453fbe8cmr4194018f8f.56.1733843609117;
        Tue, 10 Dec 2024 07:13:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENBDYqXzjoVfd5V/xCDAajwfyDDudMKeKdJYx1ZpRRKrWqwzRHUsSUlP18Z+6TtTBk3BJyGA==
X-Received: by 2002:a05:6000:18ae:b0:386:4112:fc7c with SMTP id ffacd0b85a97d-386453fbe8cmr4193991f8f.56.1733843608757;
        Tue, 10 Dec 2024 07:13:28 -0800 (PST)
Received: from [10.43.17.72] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fc514d8sm16125287f8f.46.2024.12.10.07.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 07:13:28 -0800 (PST)
Message-ID: <51789413-f4d4-4085-afeb-aedffc36c3c3@redhat.com>
Date: Tue, 10 Dec 2024 16:13:27 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Parse perf stat Topdown events for aarch64
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
 mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.co, kan.liang@linux.intel.com, yangyicong@hisilicon.com,
 tim.c.chen@linux.intel.com
References: <20241029144347.25651-1-vmolnaro@redhat.com>
 <CAP-5=fWAH1qzLrFhVjrJBu33NSfqktM30thUohC-zA+94_sf_g@mail.gmail.com>
 <e969a01b-b6c5-4632-b626-e1e3938989ba@redhat.com>
 <CAP-5=fWfjB9O_oR7k5xCoKYHVL3t6tppvemZewW=q2PWh-da8Q@mail.gmail.com>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <CAP-5=fWfjB9O_oR7k5xCoKYHVL3t6tppvemZewW=q2PWh-da8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/18/24 22:31, Ian Rogers wrote:
> On Mon, Nov 18, 2024 at 2:04 AM Veronika Molnarova <vmolnaro@redhat.com> wrote:
>>
>>
>>
>> On 10/29/24 16:25, Ian Rogers wrote:
>>> On Tue, Oct 29, 2024 at 7:44 AM <vmolnaro@redhat.com> wrote:
>>>>
>>>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>>>
>>>> The 'perf stat' output on aarch64 machines with topdown events wasn't
>>>> counted for in the 'perf stat STD output linter' test case. Add the
>>>> topdown metric to the skip_metric list as it is done for topdown events
>>>> on other systems.
>>>>
>>>> The Topdown events are also disabled on aarch64 KVM guests because the
>>>> value of caps/slots is set to 0 due to the part of the system register
>>>> being a stub. This prevents the metric for the topdown events from being
>>>> computed, leaving the 'perf stat' topdown metric without any value at
>>>> all. Add the "TopdownL1" to the skip_metric list as well to handle this
>>>> possibility.
>>>>
>>>> Before aarch64:
>>>>
>>>>     100: perf stat STD output linter:
>>>>     --- start ---
>>>>     test child forked, pid 403305
>>>>     Checking STD output: no args Unknown event name in TopdownL1                 #      4.3 percent of slots  slots_lost_misspeculation_fraction
>>>>     ---- end(-1) ----
>>>>     100: perf stat STD output linter                                     : FAILED!
>>>>
>>>> Before aarch64 KVM:
>>>>
>>>>     100: perf stat STD output linter:
>>>>     --- start ---
>>>>     test child forked, pid 404671
>>>>     Checking STD output: no args Unknown event name in TopdownL1
>>>>     ---- end(-1) ----
>>>>     100: perf stat STD output linter                                     : FAILED!
>>>>
>>>> After:
>>>>
>>>>     100: perf stat STD output linter:
>>>>     --- start ---
>>>>     test child forked, pid 404777
>>>>     Checking STD output: no args [Success]
>>>>     Checking STD output: system wide [Success]
>>>>     Checking STD output: interval [Success]
>>>>     Checking STD output: per thread [Success]
>>>>     Checking STD output: per node [Success]
>>>>     Checking STD output: system wide no aggregation [Success]
>>>>     Checking STD output: per core [Success]
>>>>     Checking STD output: per cache instance [Success]
>>>>     Checking STD output: per cluster [Success]
>>>>     Checking STD output: per die [Success]
>>>>     Checking STD output: per socket [Success]
>>>>     ---- end(0) ----
>>>>     100: perf stat STD output linter                                     : Ok
>>>>
>>>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>>>>
>>>> ---
>>>>  tools/perf/tests/shell/stat+std_output.sh | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
>>>> index cbf2894b2c846a04..0f7967be60afdc7d 100755
>>>> --- a/tools/perf/tests/shell/stat+std_output.sh
>>>> +++ b/tools/perf/tests/shell/stat+std_output.sh
>>>> @@ -13,7 +13,7 @@ stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
>>>>
>>>>  event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
>>>>  event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
>>>> -skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound")
>>>> +skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound" "TopdownL1" "percent of slots")
>>>
>>> I saw similar issues and sent:
>>> https://lore.kernel.org/lkml/20240417183219.1208493-1-irogers@google.com/
>>> but got distracted. A difference there is automating the generation of
>>> the skip_metric list rather than hard coding it. Hard coding may be
>>> the most pragmatic thing to do in the near term.
>>>
>>> Thanks,
>>> Ian
>>>
>> Automating the skip_metric list generation would be great, but for
>> the time being, we can stick with hard coding until there is such
>> possibility.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 
Ping on this patch. Please let me know if it's missing anything.

Thanks,
Veronika

