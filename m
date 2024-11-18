Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DDD190499
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924267; cv=none; b=emPWnWrV+4x1XVMC+1XgaI2gi2TGk1gKFgVKQzuu0E/8ZMc5xaw6zxsRelwd2wtsROChsGPfxzHBhwCjoqahsyNYT2MCEtfEDbvDuowIH+iyIz+sEuAAnMLGsAyJTu+YLVh/5SU2XJuTW70B2LDH2lELG2gAnl1AVzhSpl2rs0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924267; c=relaxed/simple;
	bh=0LKGdCjgj5HgYMHiavkhW3qYrLHTlL4EJet0LdxPXS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Io/CKIctYw9aRzJLEHDT/IiOPvOnGiPgEzUhygrcYsJ5As+qP9BCEOUK641NuOd/mtDGJsfyiYYLj+UBX16WGFuo23m637j7ggm4GYpPKub8hvmEPFekeInVnkx4xYUYNty1DV+SzLN5n6HnayqMLmbywJkx8jsU91Mflz9UGKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoGAmPZ1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoGAmPZ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731924264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37fOYBGux1iYHpWYgMBIVDN2dmiunMeV7w9/cBTo7Is=;
	b=DoGAmPZ1rXNvl1aSTe7D5lVHOmzulIkaF0A8oJa8VnM66PCO4Y+gjakGwmbS2gO1BAuoXa
	9uciufD1hpnN48rta13/wH0F0ZU3e83zWvIXGiiQIJHOPS58VuxDz9Eeq91372MTzTY/GD
	9vPSxliCpt5PJJBs3GVZT7gojhskcU4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-9DbXNMKZMXWModtbjdKxIA-1; Mon, 18 Nov 2024 05:04:21 -0500
X-MC-Unique: 9DbXNMKZMXWModtbjdKxIA-1
X-Mimecast-MFC-AGG-ID: 9DbXNMKZMXWModtbjdKxIA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4314a22ed8bso19243465e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 02:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731924260; x=1732529060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37fOYBGux1iYHpWYgMBIVDN2dmiunMeV7w9/cBTo7Is=;
        b=TKykVBj7noE0QpP52XWYC5bI0jYt7697RKo5B+hHTA63daW+N2iu8aSh8jJUd6j5c+
         2C32v7sErTdLnHpyPe9Jo6X9v8g11p4ttxk7l1hLVTlCANBS1R37l7TWHVSBkTtX4q20
         YKwTWJ2Ppiz1Fh77P92x5vO+SB7lDTM1zeYUcqoBJcnsdXC7qIqZnqwG4A9tmHbJ62XI
         mkLTWuPGQLfOhzPn14FKjJor5QA4uJLcb24Q3foLL1++lILcoy6txWt5YtMhEf/Eu6JT
         xrvhDH8PfnyEikdNayDhDbK2QfEEC5jnn5qd+4v+vhF9Ti4LAyZdCxSZcEEVwPiOq/68
         ZjcA==
X-Gm-Message-State: AOJu0Yy5ElbSAq+YKxWdo7gQqZllQ5P4OXHUhj2O1DMjIlCILBM/ALuA
	SgEbzFgNdXxT4rD0oBngfxghtgbYLNmWk7PK1PrDyY4HD6Q+6bmZsXJH02+TGqEsBBJ9LW6doM5
	TV/3mjdB8ra9mYkQwyBqvxErB9eeLNmS4t9ogTo1AiAMh/lOlQRsV/E9qUdbFE7SrivQ=
X-Received: by 2002:a05:600c:3584:b0:431:5c17:d575 with SMTP id 5b1f17b1804b1-432df72c841mr97792345e9.11.1731924260674;
        Mon, 18 Nov 2024 02:04:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMjDXiYzTrEIjT90odhF1B8kQSNFAB+CGPHkaUUHckZ8f/Q85mZ18iTq6gBo27xIFLt7Cg4g==
X-Received: by 2002:a05:600c:3584:b0:431:5c17:d575 with SMTP id 5b1f17b1804b1-432df72c841mr97792185e9.11.1731924260343;
        Mon, 18 Nov 2024 02:04:20 -0800 (PST)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab721d7sm152759865e9.9.2024.11.18.02.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:04:20 -0800 (PST)
Message-ID: <e969a01b-b6c5-4632-b626-e1e3938989ba@redhat.com>
Date: Mon, 18 Nov 2024 11:04:19 +0100
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
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <CAP-5=fWAH1qzLrFhVjrJBu33NSfqktM30thUohC-zA+94_sf_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/29/24 16:25, Ian Rogers wrote:
> On Tue, Oct 29, 2024 at 7:44 AM <vmolnaro@redhat.com> wrote:
>>
>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>
>> The 'perf stat' output on aarch64 machines with topdown events wasn't
>> counted for in the 'perf stat STD output linter' test case. Add the
>> topdown metric to the skip_metric list as it is done for topdown events
>> on other systems.
>>
>> The Topdown events are also disabled on aarch64 KVM guests because the
>> value of caps/slots is set to 0 due to the part of the system register
>> being a stub. This prevents the metric for the topdown events from being
>> computed, leaving the 'perf stat' topdown metric without any value at
>> all. Add the "TopdownL1" to the skip_metric list as well to handle this
>> possibility.
>>
>> Before aarch64:
>>
>>     100: perf stat STD output linter:
>>     --- start ---
>>     test child forked, pid 403305
>>     Checking STD output: no args Unknown event name in TopdownL1                 #      4.3 percent of slots  slots_lost_misspeculation_fraction
>>     ---- end(-1) ----
>>     100: perf stat STD output linter                                     : FAILED!
>>
>> Before aarch64 KVM:
>>
>>     100: perf stat STD output linter:
>>     --- start ---
>>     test child forked, pid 404671
>>     Checking STD output: no args Unknown event name in TopdownL1
>>     ---- end(-1) ----
>>     100: perf stat STD output linter                                     : FAILED!
>>
>> After:
>>
>>     100: perf stat STD output linter:
>>     --- start ---
>>     test child forked, pid 404777
>>     Checking STD output: no args [Success]
>>     Checking STD output: system wide [Success]
>>     Checking STD output: interval [Success]
>>     Checking STD output: per thread [Success]
>>     Checking STD output: per node [Success]
>>     Checking STD output: system wide no aggregation [Success]
>>     Checking STD output: per core [Success]
>>     Checking STD output: per cache instance [Success]
>>     Checking STD output: per cluster [Success]
>>     Checking STD output: per die [Success]
>>     Checking STD output: per socket [Success]
>>     ---- end(0) ----
>>     100: perf stat STD output linter                                     : Ok
>>
>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>>
>> ---
>>  tools/perf/tests/shell/stat+std_output.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
>> index cbf2894b2c846a04..0f7967be60afdc7d 100755
>> --- a/tools/perf/tests/shell/stat+std_output.sh
>> +++ b/tools/perf/tests/shell/stat+std_output.sh
>> @@ -13,7 +13,7 @@ stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
>>
>>  event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
>>  event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
>> -skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound")
>> +skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound" "TopdownL1" "percent of slots")
> 
> I saw similar issues and sent:
> https://lore.kernel.org/lkml/20240417183219.1208493-1-irogers@google.com/
> but got distracted. A difference there is automating the generation of
> the skip_metric list rather than hard coding it. Hard coding may be
> the most pragmatic thing to do in the near term.
> 
> Thanks,
> Ian
> 
Automating the skip_metric list generation would be great, but for
the time being, we can stick with hard coding until there is such
possibility.

Thanks,
Veronika
>>  cleanup() {
>>    rm -f "${stat_output}"
>> --
>> 2.43.0
>>
> 

