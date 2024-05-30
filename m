Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE3183964;
	Thu, 30 May 2024 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717069421; cv=none; b=J73IKIt1NsomC0qW1ak5t01h5IEFm/1E6t7B+0EjEA0plJfuiPZJqb4ACyPz5c8rf+VuB73nW4iz0hUNjF5xCXrqn/5BrxGR9WYi0CK5dgXWd0I2PC8tH2+wR1iTF0TLbG/1Ax6KV0he1kepCspw5CB4gg6LEtJOaC/k5046Biw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717069421; c=relaxed/simple;
	bh=xyRAuFLJMYV4lSiV7364TDKTJTDHcBSIxtrsUYekpP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2070m+u9fASMIBgjgJOy+WVL2CcZn+FKB5aqxNlz7MrWF9IBZhI3EjOtlBIaMPnfqOZF2IQvo/80bT3DEkmhbKyZ+gBgymstsAIBX8y1Bahma+Wzk9LUNBQkk+SXVFcqlWM5DMWKv4v4Sn/OZR6qmnKEfxZ1ihLzISY+qkXwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nkqtpg9d; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nkqtpg9d"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b970e90ab8so427597eaf.3;
        Thu, 30 May 2024 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717069419; x=1717674219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XR6MPgWfqApseUbYRUcsMgK3z0xu+JQbLHd6cyyF66w=;
        b=Nkqtpg9dLZMnGjOPGY6Wq3qNqKCsFIZD+VCmbMyUW3blFeaS8im6EmfER/vxwE4gI3
         2Gm9nHTOr7Ligdto1E60rOUTUaksWrd3p4bCYeb0jhgMaQAQZXzCKa8rl9oRCdnQhLWL
         GF7GUCAAcPSgsmIOa6UwY9zEZPlfnXfGktAQKQgydwprpInG5w3GU4Q+ppoQCdJUHic1
         yPvSjbeP7aiTzdmKw7N6fvR8yYxMgTmEwUYBXemHTn1e2BnAohZCLyO30es+hPYw9/08
         lBbbSsDF27TCDY/pUxuwUUc+ZZjbNPlFoy3IRKspLKwqVOIljQgGMbLbftoE0ozaYEXj
         wKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717069419; x=1717674219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XR6MPgWfqApseUbYRUcsMgK3z0xu+JQbLHd6cyyF66w=;
        b=qmg2efG0V1YasrwY/VaBiVIQYS07Es157+98WTUDNg85YndMgAW4Ij4fgtIa6uS0mB
         qKllpckMFxwc29m3S8CVlEPcSNscD3gDp/16mEA3rINLkrJCjYdZ1VSo1+iRmaVKP0k7
         4b0ACxWDmP4ALgtoSh1leyusasD6uwN/nhr+sehXq3S6E/7Ve2Km+Ry/3dNmRJ1cD+iy
         HpGL3LA1JVNJ/SLaFHmAR7qPYAbkb5aIScfNYHxNkDp3qPBNgkRmj5GkJpslQvvY88im
         yCtOAXu+pPt2i2yMCfPfIQDzWD4hplRYayEnoFNPy5TO6DO9aB3ETA9Q09x0guanpX4l
         hLtw==
X-Forwarded-Encrypted: i=1; AJvYcCWWJ32rdc8FlDH9MpglccCXjQD78d0Pb5y7u973Y35Scp8CU2nk6HoR6SMAr1OJ2+hL7R03b9+umenGpQCdBGGYEnc92YQbMS8levENJfjCW7YZdJRaMtHU5IwXozCDykZkxv5kAI84tdS4W7LBBw==
X-Gm-Message-State: AOJu0Yzfv6JhD7X74ID3vovziWNkn6QCihJ8B7cn9YDm2/lI6wRx9zsN
	D/IAnyEj+pKLOMk/SUdRwpboHxKvv3ZDmHJYtt3vqQnzMJP/nwLE
X-Google-Smtp-Source: AGHT+IF0XWfa5jz7pE/dROU1THvnaVC3uyDp9wVakipTtEPtQp0+PpqFCbrbpSWZ2EVeOqBDiXCnbA==
X-Received: by 2002:a05:6358:787:b0:18f:81e1:dc33 with SMTP id e5c5f4694b2df-199b93900e5mr262855255d.2.1717069419194;
        Thu, 30 May 2024 04:43:39 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682227f1d6esm9120839a12.49.2024.05.30.04.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 04:43:38 -0700 (PDT)
Message-ID: <53c7cbf0-ebf9-455b-bcec-d61830c7999b@gmail.com>
Date: Thu, 30 May 2024 20:43:32 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf stat: allocation check when calculating cache
 instance ID
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Gautham Shenoy <gautham.shenoy@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, skhan@linuxfoundation.org,
 Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20240527090300.17864-1-yskelg@gmail.com>
 <CAM9d7cjhwO99e0GLKf54V+1g7cdppL3hwjpgB3cdid7YzytkMA@mail.gmail.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <CAM9d7cjhwO99e0GLKf54V+1g7cdppL3hwjpgB3cdid7YzytkMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/29/24 3:56 오전, Namhyung Kim wrote:
> Hello Yunseong,
> 
> On Mon, May 27, 2024 at 2:06 AM <yskelg@gmail.com> wrote:
>>
>> From: Yunseong Kim <yskelg@gmail.com>
>>
>> Adds an allocation check for cpu_map before perf_cpu_map__min() accessing
> 
> I think perf_cpu_map__min() works well with NULL.
> 
> Thanks,
> Namhyung

Thank you for your code review Namhyung.

I'll try to find a more useful improvement and patch it next time!

Warm Regards,
Yunseong Kim

>>
>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
>> ---
>>  tools/perf/builtin-stat.c | 24 +++++++++++++-----------
>>  1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 35f79b48e8dc..1f238824abb2 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -1291,20 +1291,22 @@ static struct option stat_options[] = {
>>   */
>>  static int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map)
>>  {
>> -       int id;
>> +       int id = cpu.cpu;
>>         struct perf_cpu_map *cpu_map = perf_cpu_map__new(map);
>>
>> -       /*
>> -        * If the map contains no CPU, consider the current CPU to
>> -        * be the first online CPU in the cache domain else use the
>> -        * first online CPU of the cache domain as the ID.
>> -        */
>> -       id = perf_cpu_map__min(cpu_map).cpu;
>> -       if (id == -1)
>> -               id = cpu.cpu;
>> +       if (cpu_map) {
>> +               /*
>> +                * If the map contains no CPU, consider the current CPU to
>> +                * be the first online CPU in the cache domain else use the
>> +                * first online CPU of the cache domain as the ID.
>> +                */
>> +               id = perf_cpu_map__min(cpu_map).cpu;
>> +               if (id == -1)
>> +                       id = cpu.cpu;
>>
>> -       /* Free the perf_cpu_map used to find the cache ID */
>> -       perf_cpu_map__put(cpu_map);
>> +               /* Free the perf_cpu_map used to find the cache ID */
>> +               perf_cpu_map__put(cpu_map);
>> +       }
>>
>>         return id;
>>  }
>> --
>> 2.34.1
>>
