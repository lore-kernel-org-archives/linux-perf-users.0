Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706C130AD15
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511914; cv=none; b=d0TiYif/aMopxeHjw8DgUOZlTnmpFCwFqadJhamGU+jcEjiMV+hMwl9p+kyYvJenOjOxSiVj12DgMCRqslBlbuqTgPJzBFE8yjSWQqU+lC97GLd0ArHQmqgJz/Let7RgXb1fX+8viNmQGcCwfaIIKi60/Yi5m5pxtLZ9RRG0+58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511914; c=relaxed/simple;
	bh=xJEzEfzxPGHB0yfq81C5o4HbNwmksYg5Fu7tvfPnx94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mal44EAzUMJN3za8Rul870rml6uvz8R3bLkci6JvUQgCO5S3JRGEc+lf2emd8CKKqiObw0Vs95HCmwPD+HrgRWCBBHcrdzc4MnlvU2RweSKGkDcG8Ih4FSiwN8irwZQa2AHhnxXZoQNAOfTX4ALMH6olr1L4SJu8OHpvg3yTSvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mQ/QSWwS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQ/QSWwS"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fb2314f52so3240116f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 03:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769511911; x=1770116711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UHwQB4qZyJAZDmTrAmcIXcHl7IIhHNHe4bPcL9lLXHI=;
        b=mQ/QSWwSz9NlzknQDAh1U1FSQ37FYYRnE6G4Kf2yWCR9t+nLX1ZB/50zgOUxfE+UrY
         S8H4UGm0iJpbsNUCCU7U/JLS95YCi1ubOzXbi29TUrhTa029a9bgbI5cYvw4sQWAW0b8
         V1dnE0V2vqF4i/1lEi0Yev65HuPHEEY6NoCwFzcX7oO9Slbyf+I7E8O5/sk178MXE7Yr
         PYW6MpVeqCwnhDuHMHhHm/pJ6IkiQRV3NToc02k9djqedLYewOPZLCpGzYa6TGPUgF90
         ppzZkz9JjH/kM9PeJSgaTwiLjF/EByzimnfg97icDPlGjZaVisuuWXzfBH/KCH4np8tG
         BCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769511911; x=1770116711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHwQB4qZyJAZDmTrAmcIXcHl7IIhHNHe4bPcL9lLXHI=;
        b=pda60xEednpSEq0W/aTzaHWPJ/aITh/eQ1g6k9q6NVWtRoN9xS9vPpVAxYNyT/sfM9
         EPx7D9wa8zwpG/QbkjwAnONT8LqtjWsz64vdExIuuhLWTjCtf3ZJoe2uAw7pLf6kupbg
         8yYtUCfCFvSLU119hORT4GwU0VgvPUfnLJ9u+3iA2Q4zzn2oOZKXeH7t8opG/GWBNXaf
         9RjNSv2eRVAyxq3eiIrXmdVKKEp4Mo3YzVcvZEmG7fV31bPQyno5HHlNzQRIdqiiR3NK
         FruOjBNmsZ7+LIHWdeysbEC3Orl++ctYc2e8u0njCb5D98ey01COQpB8rsfnJGt7qs66
         HJ0A==
X-Forwarded-Encrypted: i=1; AJvYcCX44SLDqIcVaQpmP98P66AVwiXBU/iG8Oel2RoMXlc2cebUej2NAKRJf9uJWADOFC73aZTjmpGmAtyFZPNNUyWE@vger.kernel.org
X-Gm-Message-State: AOJu0YyOAtZyh7rR0Yj3w7cxtMmM7WjwhsL5n1GOHvRIUcAkb3+tap5N
	O+W4kjHL3eF7tYNfZJmU2jTio3esIUxiXD0v5EPDDpHmAhDwbW3PIDpmIX08fVMdfMA=
X-Gm-Gg: AZuq6aLvEWpMJfVaHVQd5cjamBONTRPqb0QcQX9u+tN/0zO3iwZGnM6TR0gYxnilYvo
	WyC/E/jSXBKwx5sRytN5YzuVM11zbq0CSp70KKKwqzEeB/kkqtdInjZECzFsZR/K0eWo5D7Hzdo
	Ae86zh4LAznv07YNcf+vbg0lhb0tJ5iDz5EQeRBHwwWYLB5epyRbPmgKz+5nq9J7RWoJ6HFiFb3
	Ew460+SuFBKpRWMalL2nujfGdb4zVL0Xve9I87MAZpkcVLBeas1IL0zPaUykOO31OqlXzSkpTzE
	R3Jp2qgYLzm/oTIM/Kv9JmXmnUScXMnRdv6FAAVBAy4pSGp7QIfFbtCyZsPICGVltc3Ghujw1Oi
	h7BoQSRWNQzyRPv41P0jtEv7JkugXD8gKBvzVwsuh99GVvTIKcS9Rn426pgVAE4FocSY3DEAbJs
	VD6gGHkw7X//1ZxcDT6c2wt1ERxDY=
X-Received: by 2002:a05:6000:40dc:b0:430:c76b:fadd with SMTP id ffacd0b85a97d-435dd073a76mr2097783f8f.28.1769511910615;
        Tue, 27 Jan 2026 03:05:10 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24b54sm38065624f8f.15.2026.01.27.03.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 03:05:10 -0800 (PST)
Message-ID: <584441e8-ffff-4cce-939a-43b297d645c4@linaro.org>
Date: Tue, 27 Jan 2026 11:05:09 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf jevents: Handle deleted JSONS in out of source
 builds
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
References: <20260120-james-perf-json-delete-fix-v1-1-bae2194b1dcf@linaro.org>
 <CAP-5=fVxMcMt=red5+D9_m4+wrUdPGkNP0irNqr5PU1UPJSO6A@mail.gmail.com>
 <aW_PXct-oIyOyrNe@x1> <185f91de-f0cc-4a84-9e41-56370df718fd@linaro.org>
 <aXfSdRS0qG_T7tO5@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aXfSdRS0qG_T7tO5@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/01/2026 8:45 pm, Arnaldo Carvalho de Melo wrote:
> On Wed, Jan 21, 2026 at 09:51:30AM +0000, James Clark wrote:
>> On 1/20/26 6:54 PM, Arnaldo Carvalho de Melo wrote:
>>> On Tue, Jan 20, 2026 at 10:01:52AM -0800, Ian Rogers wrote:
>>>> On Tue, Jan 20, 2026 at 7:39 AM James Clark <james.clark@linaro.org> wrote:
>>>>> The cp command here doesn't remove files that have been removed from the
>>>>> sourcetree. That means incremental builds can either succeed with stale
>>>>> events or will fail completely if a stale json file has a broken
>>>>> reference in it.
> 
>>>>> Fix it by using rsync instead of cp. legacy-cache.json has to be
>>>>> excluded as this is a generated file isn't present in the source tree.
> 
>>>>> This only happens when deleting a JSON file, which has only happened
>>>>> once since the linked commit. The fixes commit is marked as the origin
>>>>> of the problem in case any future changes that delete JSONs are back
>>>>> ported, rather than the first commit that deleted a JSON file.
> 
>>>>> Reported-by: Mark Brown <broonie@kernel.org>
>>>>> Closes: https://lore.kernel.org/linux-next/aW5XSAo88_LBPSYI@sirena.org.uk/
>>>>> Fixes: 4bb55de4ff03 ("perf jevents: Support copying the source json files to OUTPUT")
>>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>>> ---
>>>>> This is a bit of a hack and I thought that making jevents.py handle
>>>>> multiple input folders would be a much better solution than this. Then
>>>>> we could have "gen-pmu-events" for only generated files and "pmu-events"
>>>>> for only in-tree input files. It would be very clear what's generated
>>>>> and what's not and all copying rules and special clean rules just
>>>>> disappear (and this isn't the first time these rules have caused build
>>>>> issues).
>>>>>
>>>>> Unfortunately, after a while of trying to modify the script I thought it
>>>>> was too invasive for now. The script does output per-file at the very
>>>>> bottom of the logic in process_one_file(), so adding files in another
>>>>> folder ends up re-emitting section headers when another chunk is output.
>>>>> Although other parts of the script do build things up in memory before
>>>>> outputting so it was possible to make those parts work with multiple
>>>>> folders transparently.
>>>>
>>>> Thanks James!
>>>> Acked-by: Ian Rogers <irogers@google.com>
>>>> I see other rsync uses in:
>>>> tools/testing/selftests/sparc64/Makefile
>>>> tools/testing/selftests/bpf/Makefile
>>>> but they aren't the most compelling mainstream uses. I wonder whether
>>>> we can test for rsync's availability and if not fall back on cp?
>   
>> That will work if we completely wipe the destination directory every time.
>> But it would be an untested path, because in reality everyone is going to
>> have rsync. It might be better to re-implement rsync and then at least the
>> same thing runs everywhere.
>   
>>> It is not mentioned at all in Documentation, so probably its best not to
>>> add a requirement for it?
>   
>> I can hack together something that does the delete in a few lines of bash or
>> make then? I did consider that originally but I thought that's what rsync
>> does so I'll just use it.
> 
> Did this progress?
> 
> - Arnaldo

Yes I sent a v2 here: 
https://lore.kernel.org/linux-perf-users/20260121-james-perf-json-delete-fix-v2-1-2e10f895bfd7@linaro.org/

If it looks ok to you it should be good to apply.

