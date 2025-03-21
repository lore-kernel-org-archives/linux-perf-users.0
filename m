Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C32113C695
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590633; cv=none; b=nwJRY0R4v8EHmH1fuXQsi/yoregN+ipSPNVl6V8fSiZg5DwzQaMiFzWDBPlktOxFyrY+FssNDKIuFGTBfmZlAGbf0hKUOP2M08v0xrNXH4V1LtQzXXfrWaDkhSrXrtQdxAP2yDSi0qARm6uZIXEwLsB3ek6Fl7DUTbQTi5szraI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590633; c=relaxed/simple;
	bh=nawzriq4on1/iaCI5X9SVu5Slxu6nQOPXEWq0FryO9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmntdOx0J1bM/GhTf0xnb3VPWTWDSAIfpVXj1cObX8rFDbKSL8EaAowVmFyRYbi3vnx7DK788oIuZt8TNMemuB5irPM3xraQlw+sVsxSOJiuekQHxFsccI/ayg54VONHwY/Hlj+8elOMjB17wgddQErQlpMp0AT9n5fMZcnElxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=eQswZ8i5; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eQswZ8i5"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85ad83ba141so105227139f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1742590631; x=1743195431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9+5tlGWdTjjnvMyRFuoxH5wURyyyxF85+K/XRxuX8I=;
        b=eQswZ8i5d4Q5RDWegcFGBFY+oxUrK/C5S6nj7OEv+W2ZYRJLjeSOPuNU09iwdGT+8k
         v4FV8WovsimW5uSoTeWwg8O4TTj5nIeFg6fyTkWyGJjFaWHxbX6P5D4pfTkIdwjHOjmk
         PYzCIwMpEObJxu1f3ILKcPlqK+vIf+9HdMJx7FQTO4aYUYmj3rIE65CHofvlyo6OY7jM
         IoDxtRzFAeatiZOyo+sGlNBdhOY29gk4poDpxaxu8GgwHjzfOti1ZaWNYGfPs56IQ0sc
         6FW0FcJwZ3oPwsQxDKVpAaqoCzPjhQTlhvLn2KMbB3Bo9KbpNcKY7ko5K9ld3ldOvESq
         1eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590631; x=1743195431;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9+5tlGWdTjjnvMyRFuoxH5wURyyyxF85+K/XRxuX8I=;
        b=tnPwOtPq+7wOrXVRIP1ry2gYxPGRbXhcWra3QATQyvW86CvwDLdgRKDG2fD82k0aX8
         97V/g4oKOMonqXgf8yFXvFyyQ2hX4QePKkCahc5IUsA9IbnJG0Nned7xnZ+ewXHgIPL8
         FxnnETBLEMQNBBurnsIggEfDlrsqAXDUYYCOzJfo2DjHcbgp8kkcc956mycyfYa+GIlm
         xfnC0kTAppkLN4NJBoqI+7qMEtWqHztxkh1fL8DSiPMR8fjSbJQSkj/Ug083idsM1Npl
         HgsRZVuip+ObbRFdNvnoz7XruvbBxpBbn4KXgowJqBlLyDGJxqkQoF/vhcFXJzzc7PiA
         NpFA==
X-Forwarded-Encrypted: i=1; AJvYcCXghNBEgE7UK9wDtaIWINmeWbyUp0m6LwrmYG6vmG68/bJQLtKo22UV2dEveXoBxuT36GcIjcrc1XidMBD+Rd4E@vger.kernel.org
X-Gm-Message-State: AOJu0YwCre8ttSQ3ApXjU1dR4/tpfiqaaj2+xHoTZ99/qdzU/DCETrnQ
	5jkMqzJgMeEHCUsPZBeIWr6UKRiQrj2nnouR2anxSN7cqHO6hPZAxy18CSI2gek=
X-Gm-Gg: ASbGncue/9CKGvloNHFxzKYQNOGsdmQqDl41Kqveq2X6rJznEvJTzIA79DMeXxQV+6b
	faY7YYwjNtKJvwRyYlvdeeIto9e+CF4DeVC0aiuk80ill0CatFIZJgsmK8wx/TIOJ+CyyYgld+Y
	gDZAZn18qfkZu3jPSyGeH3a83tS2nD6cz8vXT2+/DVjLXhQ0xZfYzMG0/xMIxGKL8WqTROsN2RI
	rhYvsZdWGj+NXftS6HwMa8r2qOkoyQdKf0SX7pLDzxCABUNUk/XwQanZ/vH8zj9EdOcSKFLdM3A
	CACxw+HBL08IKpS1lWIMY+KZv7RxhwqqpCqoP8tmmUCFRJy1lQfgQ/0XmJe8Yg==
X-Google-Smtp-Source: AGHT+IGIhc6f43oVUMs3yKpZ/Qi3MN06te1GZdlnQ8JYifCqR1/BD6VFgf6pM5hzDXs+HJFOuNTjfg==
X-Received: by 2002:a05:6602:4c03:b0:85d:a211:9883 with SMTP id ca18e2360f4ac-85e2cb59528mr567711439f.10.1742590631162;
        Fri, 21 Mar 2025 13:57:11 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.166])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdcfef4sm613828173.31.2025.03.21.13.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 13:57:10 -0700 (PDT)
Message-ID: <7c42afed-e877-4136-a6d6-8ebc9864cc04@sifive.com>
Date: Fri, 21 Mar 2025 15:57:09 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 0/7] perf vendor events riscv: Update SiFive CPU
 PMU events
To: Atish Patra <atishp@atishpatra.org>
Cc: linux-riscv@lists.infradead.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Ian Rogers <irogers@google.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-perf-users@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, Adrian Hunter
 <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Atish Patra <atishp@rivosinc.com>
References: <20250213220341.3215660-1-samuel.holland@sifive.com>
 <Z7ZLB-wZY9wTZSBZ@google.com>
 <CAOnJCUJYKkGXOJiLTnPOgPSnEiCeXFaoGQRiT5Au+rbvP1unZQ@mail.gmail.com>
 <1198d3ac-d715-4f82-853e-bf9d0ad9dde7@sifive.com>
 <CAOnJCUKUY8YQ0UtLa39EkGEjckiOqdnuqEsf2ak4Dcp779iY+Q@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CAOnJCUKUY8YQ0UtLa39EkGEjckiOqdnuqEsf2ak4Dcp779iY+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Atish,

On 2025-03-21 1:31 PM, Atish Patra wrote:
> On Fri, Mar 7, 2025 at 1:19 AM Samuel Holland <samuel.holland@sifive.com> wrote:
>> On 2025-03-01 3:21 AM, Atish Patra wrote:
>>> On Wed, Feb 19, 2025 at 1:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>> On Wed, Feb 12, 2025 at 05:21:33PM -0800, Samuel Holland wrote:
>>>>> This series updates the PMU event JSON files to add support for newer
>>>>> SiFive CPUs, including those used in the HiFive Premier P550 board.
>>>>> Since most changes are incremental, symbolic links are used when a set
>>>>> of events is unchanged from the previous CPU series.
>>>>>
>>>>> I originally sent this series about a year ago[1], but received no
>>>>> feedback. The P550 board is now available (and I have tested this series
>>>>> on it), so it would be good to get perf support for it upstream.
>>>>>
>>>>> [1]: https://lore.kernel.org/linux-perf-users/20240509021531.680920-1-samuel.holland@sifive.com/
>>>>>
>>>
>>> Tested the patches that are part of sifive's release tree for p550.
>>> Both perf stat/record seems to work fine
>>> for a bunch of events.
>>>
>>> Based on that
>>> Tested-by: Atish Patra <atishp@rivosinc.com>
>>
>> Thanks for testing!
>>
>>> @Samuel Holland : perf report that the following two events are not
>>> supported on the p550 board.
>>>
>>> cycle and instruction count:
>>>   core_clock_cycles
>>>        [Counts core clock cycles]
>>>   instructions_retired
>>>        [Counts instructions retired]
>>>
>>> I assumed that these are raw events cycle/instruction retired events
>>> that can support
>>> perf sampling as well. Maybe I am missing something ? DT binding ?
>>
>> perf is correct. Those two events are not supported on P550, only by the newer
>> cores (bulled-0d and p650). Yes, those are aliases of cycles and instructions
>> that were added to support sampling.
>>
> 
> Thanks for the confirmation. Are there other events that can be used to sample
> instruction count on P550 ? I did not find anything in the perf list
> or the json file.
> I am not sure if I missed something.

Likely the closest approximation is ORing together the instruction class
retirement events from instruction.json: cpu/r0x3fffe00/. The difference between
that and "instructions" looks to be well within 1% for CPU-intensive workloads.
Maybe it makes sense to add an entry for this combination in the JSON? Would it
be appropriate to call it "instructions_retired"? The same thing could be done
for the older SiFive cores.

Regards,
Samuel

