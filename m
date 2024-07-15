Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA818EA82
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056346; cv=none; b=rdXk52U6ORpxHMTQnY3wbs9n3hJJ5hq0HawjZwXyek60fkdSwYU2flv2zL6ugasMHzvbVwRLQFOc4a/M9o8JKRygdfSqvEOE/ZhyaAy5NEs4hE3zLQoCp+S+0iuyYMdmqJvIx2CVghh0KmGRT3+m9js+/j6+kGR9noh4b5LDKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056346; c=relaxed/simple;
	bh=vTPPb89wiHICiQOG8fWTX2bCwOyiVmpTiEMAftKUxzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oI7eV+SjJ/05lZrnjAwmq7+Fb8zOXElhaGVf4hOrlBMBy08ZegG3AzUrMEzQ2TKBPBEBd8ghlccqGe0vkZQXRm9YWLHrmWZpgEVIORrWzSk+H5Sj07leFQwmmx8B0Msd/vvDLaUL7H1/vrfUjW+fQtwAec1gDjWIDjMCiFU5URk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P4dbCNus; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4dbCNus"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eee1384e0aso23380641fa.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721056343; x=1721661143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0LMPjeIem8I8RWQyMy1na91qL3SNufAU5GqVn6DPFA=;
        b=P4dbCNuspB63Ajopiq7ab39OZbvIkwbikFBC/PnMl73WrU1r6RFSXHEXQTSs771S0N
         CFfZu/aSKNO9o2oI1RKj9sFH5Q3K/4A1eYvmzVHR4XEZ8nbqfGpNnsD1oP9xF8nIwjGy
         D1vc9kZqGUQ9qwTlR8UjbfJkVjeB3eesQhFy5O8vs21XvXJEtywAeBueU/KcLumJeG4T
         t3RQDJYrN6B8rgKzBouAam+7XP3unMwXX8gTousOZw+g9eyRbqhmUHHA/iWJtNwqte0M
         O32BPEVwvkIXKhaPY+0NYvpO7DNJWIaB7aJiO6js0nfbWPCxDjfWSRA5LEf/ZC8759HX
         UmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721056343; x=1721661143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0LMPjeIem8I8RWQyMy1na91qL3SNufAU5GqVn6DPFA=;
        b=giHzRR3UzKKkiL0RiLe2xGeYpvc5XcdqNGj07o7Q8p3TXqLvgj5fpXPG28z+2cr+k4
         EaBlhTA7hbg3qTiq8GJ3IbeykDzXSbBCp1K5xWUZGvbd9BUbfmGKE5VnphnDwmmXfolI
         yjbfojkr9JSSK8QD1IUWhCCxs9gp/hh+DNiEASErD83yUWyJUyHptxxroPuQ+oPJTdz3
         fGgiyVpBYA4ZHIx3lgNMdeP50uqeN1nz8DQZWjqe5/TP7VtKNocnZ/4sVzVL3u5EiwYp
         UP1ofJZkDq5syUW1h3IoFyNebBHfPCBy7J6FXc8BsCnusNarcFMtMaqhQDvJ5B+R8Igr
         FslQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUnWIigAuqGSXDcpfz+oVBehIujTU2TQ1ngbG3D3QFiTOnAvZkrSziYjeVgDrkAGuBH/uvL8g6RfgS3OX95mQK4MgzFzULH66keh27AhS2Wg==
X-Gm-Message-State: AOJu0Yzxhy5B6wgk2VdZXGYVMp1rROIwRB47wcm4QOl4xEgpJXsFjKFY
	7gOuvnZkF13y+V+d4wxk7PX4FVeCkwQDqoe6bVrH5QxK8TLEL5aXpKtH5o7HYBU=
X-Google-Smtp-Source: AGHT+IH4kjf2TVS0nlQ8/h6DxeHoXYul1WTyfVKdOfRVWybzhF7VQMqbYFf88eb25zgwc6WnImoDwQ==
X-Received: by 2002:a2e:9b8d:0:b0:2ec:5061:d7d2 with SMTP id 38308e7fff4ca-2eef2d71881mr1245601fa.18.1721056342549;
        Mon, 15 Jul 2024 08:12:22 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f23a000sm126699565e9.5.2024.07.15.08.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 08:12:22 -0700 (PDT)
Message-ID: <b3a4282a-91b6-49a0-83d1-470cc4873dc1@linaro.org>
Date: Mon, 15 Jul 2024 16:12:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf jevents: return potentially empty metrics table
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, Leo Yan <leo.yan@linux.dev>,
 James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 patchwork-lst@pengutronix.de, linux-perf-users@vger.kernel.org,
 kernel@pengutronix.de, Kan Liang <kan.liang@linux.intel.com>
References: <20240531194414.1849270-1-l.stach@pengutronix.de>
 <8b31bc0823df42e1ef4c22eac159fa58694887c7.camel@pengutronix.de>
 <ZoXRr9wcE98ijyFA@google.com>
 <CAP-5=fWxuPW1WGSOV-wqYXJ-4kiwefujprnGn3YfVzO+62-i-Q@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fWxuPW1WGSOV-wqYXJ-4kiwefujprnGn3YfVzO+62-i-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/07/2024 10:54 pm, Ian Rogers wrote:
> On Wed, Jul 3, 2024 at 3:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hello,
>>
>> On Mon, Jul 01, 2024 at 07:19:55PM +0200, Lucas Stach wrote:
>>> Hi,
>>>
>>> has this patch fallen through the cracks? It fixes a functional
>>> regression where the DDR controller metrics are completely unavailable
>>> on all i.MX8M* systems and thus would be nice if someone could have a
>>> look.
>>>
>>> Regards,
>>> Lucas
>>>
>>> Am Freitag, dem 31.05.2024 um 21:44 +0200 schrieb Lucas Stach:
>>>> Don't return NULL when a empty (num_pmus = 0) metrics table is encountered,
>>>> as this causes many of the users to bail out, which will skip matching any
>>>> potentially existing sys metrics later on. Instead return the empty table
>>>> which will be handled properly by the iterators and allows matching to
>>>> continue.
>>>>
>>>> This fixes metrics reporting on systems where only the sys, but not the
>>>> core PMUs have metrics defined.
>>>>
>>>> Fixes: f20c15d13f01 ("perf pmu-events: Remember the perf_events_map for a PMU")
>>>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>>
>> Looks ok to me.  Ian?
> 
> Sorry I missed this, I expect to see patches on LKML and so my email
> filters placed this elsewhere.
> 
> The change doesn't make sense. A search is requested with a PMU and
> you return success (the table) when there is no PMU match. If this
> behavior were expected then NULL should be passed as a PMU - this is
> the behavior in util/pmu.c and ARM is the only architecture to pass a
> PMU. The ARM pmu_metrics_table__find also specifically breaks
> heterogeneous (BIG.little) systems and this change won't impact/fix
> that. Perhaps there is some context I lack.
> 
> Thanks,
> Ian
> 

Yes it looks like the fix should possibly be higher up in the arm64 
pmu_metrics_table__find().

Which set of JSON files are you seeing the issue with exactly Lucas? I 
see that there are multiple versions of i.MX8M metrics.

James

>> Thanks,
>> Namhyung
>>
>>
>>>> ---
>>>>   tools/perf/pmu-events/jevents.py | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>>>> index e42efc16723e..0a1ed9ee1429 100755
>>>> --- a/tools/perf/pmu-events/jevents.py
>>>> +++ b/tools/perf/pmu-events/jevents.py
>>>> @@ -1081,7 +1081,7 @@ const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pm
>>>>           if (!map)
>>>>                   return NULL;
>>>>
>>>> -        if (!pmu)
>>>> +        if (!pmu || !map->metric_table.num_pmus)
>>>>                   return &map->metric_table;
>>>>
>>>>           for (size_t i = 0; i < map->metric_table.num_pmus; i++) {
>>>
> 
