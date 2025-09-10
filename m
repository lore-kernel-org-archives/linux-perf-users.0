Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0A331D368;
	Wed, 10 Sep 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498088; cv=none; b=YfLqbDMS34rOCBk19wLm2LeTYtBfil5tMU7U63b0xLElMS1zZ9sDJCF9eaitioWGhLmv2jymA6p/3orxjjaN8O1m3clwBBXV2bLo/YxRnoZ8Ch7N5p+1JF60AnRtSD4sPzBOGlruB3xvz9lvp9f+NvK7qoPNh2S7MMTUO9dwpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498088; c=relaxed/simple;
	bh=KNkOR0Z9qGvk9oDedwcGOrAW6Cbf+ee9mMU+W/a+YNM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sCIOcwck4GYJAE+XsSEmMjFSn5jgb/vJZPxK+9oUYBdfm8XxPvFtu2bypxAfB+PhsPwcvL9air1gHO9GOkHhVFd+VV/LWSrtbWCfzFbCI/GsyiR1tdd8hfXlR4u1vgG8XkbWlK29i/z22IwlQe1nsNxEk9d2ZjCAPC4ITCBj1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjfThhHa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjfThhHa"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24b2de2e427so46553805ad.2;
        Wed, 10 Sep 2025 02:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757498086; x=1758102886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fjDGSSxl1bgO/LE+E1oRlyEFsW9DteTvLANxRnkvDNs=;
        b=kjfThhHaUBOL87Hlgls4UES900Zv6Oc6FtribngfPFFmZJarMKxqUFdtiT7ycrkrqc
         jjdQZcL/qYH66QaZMNsXBmoHxEZUqn5Creij/IpuG3hmkzp99XaSi3PvijiWYkMvmlg9
         B4BC0aExci9ExlAcDzEL8qn8ZQNk/mLQ0BkHa1e9LInrArhfRhUacEqu6YdWfNo4ZbU6
         cI+5h3x5JWiIuF1ygHlFrnFszmdsUMsTs4haJGgrDBiSQHCAn/a9I94YE41RC6hPMD4U
         JWwG5hE8zKojNeRcr6vhF4R3Mfc4sgUcGQGAWuS1Q6AQso8aS4wo/q6Pc/Crc1PyfKUW
         Ppiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757498086; x=1758102886;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjDGSSxl1bgO/LE+E1oRlyEFsW9DteTvLANxRnkvDNs=;
        b=s3KcTvbdlLIZVu20YVXEyd1X23EdqlZVtbl3Ba4+kD19VxooLSOE1ce7y3gH3Iitiz
         e9vZFWHopNmGvRbkrDxUmWH7fv9EXCodBwslwrR/TJWInpB0b964vycY3uJPWvs2rEpQ
         yl1w59C37evtZDbjMiaomgTYiustEC6nat8Ru9AqOfpcOMxs9/16k7TfF0qHvKOODUj4
         Z1EqwapwBJndRowhr6CEUzRra5nvvK9QGpAElDN1cVWlv5WQiKtSMwx+Iflu0nImflf3
         AP8v163GRRfYi2zE1MiNxDOQvZlYGN5N9+GWHW75u+Oh0A6LieQ7DvKJC603j7u33Jiz
         5GmA==
X-Forwarded-Encrypted: i=1; AJvYcCVWZXLhwcffSXf3ML9PCgMl+Qft6HbW+6ZS1dlXe1Pj9qT0N5qd3UEfKIcikel8dkixUDvfpvzLiY3mtQfFAD4tgMX7@vger.kernel.org, AJvYcCVfSpS0sqQXMpR7+wWciKW/++oGpKcD3rpkHAy5NxSnNfp7YZKj1kNPmeLJCc9xwUT5YphksZ2zNRJs29U=@vger.kernel.org, AJvYcCX8sUDZ03eapldFrnhKY/M0X0IM++Gk/cm7PM7VhNVgBaQAuNUd6HJ+8h69GpUrQv1D7290gWpRprYq7n2pAZxGOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEH5mzladAb2MlcjFX2wOQxHoTCEmiwV6SCN9VIG8MMnzoHcyS
	ReGtHwWNQbCOPy+mTwPIt4fikAQoZozsKEr4kyXhsDwPtuzGu0NzjdRO
X-Gm-Gg: ASbGnctrzKbwKWZwcScErTQbRXcKMmLCclylyZzvNpg7+W8UaIwt11jmNXWNUb8wOTN
	7JZprzgMtTEKV3KwT+pa+JrIFoyNPVT06/GpXVIKkHe6PqPkXN3q7GDXQfJRcasdayHxDD0pZGq
	K5rV+s2hs/oVylolYsi+XQ/eGpAokppuRwgJFjXgbH1mAteNsfCmqhql06qg5OCKKc/x6YfCh0r
	AS/jmr8FAJimFndVAgZ0QhtX9cjKQgzwDCVAT7gE+LJTf0XITNpZ29M0kbUpAA0jPStoH3oLlNj
	4xZgT7Mh5ug7hbgrr+cqWAsvUQtPuYsKh9xrlw9sNPY8Nim3iNXj+J8pqA2S6fn1jyQoUgFuj5x
	NHNqAYCHqGjPxltV9sspQI2tPYFLnuVkuG6Q=
X-Google-Smtp-Source: AGHT+IEehJ5C2SQUPQ7Bd8LiQM6dU3/TuGbQPJS5Qg6w1+VDRG8A11HZd7aW9ORjaQ+YrxZYqL3kzg==
X-Received: by 2002:a17:903:3d06:b0:258:2476:77db with SMTP id d9443c01a7336-25824767953mr100948585ad.42.1757498085855;
        Wed, 10 Sep 2025 02:54:45 -0700 (PDT)
Received: from [127.0.0.1] ([2403:2c80:17::10:4006])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a344af8sm21714385ad.78.2025.09.10.02.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:54:45 -0700 (PDT)
Message-ID: <e82bc49b-a1fe-419a-8a5e-fda70603d2e3@gmail.com>
Date: Wed, 10 Sep 2025 17:54:33 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/18] x86/hw_breakpoint: introduce
 arch_reinstall_hw_breakpoint() for atomic context
From: Jinchao Wang <wangjinchao600@gmail.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, "Naveen N . Rao"
 <naveen@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-perf-users@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
 <20250904002126.1514566-6-wangjinchao600@gmail.com>
 <20250904063832.GT4067720@noisy.programming.kicks-ass.net>
 <aL5ns7h1NaoD9LPg@mdev> <20250909170017.dae27d8be77f9ec634e0d56c@kernel.org>
 <f73e6e8c-282e-4d3d-9dc9-49f13b20a255@gmail.com>
Content-Language: en-US
In-Reply-To: <f73e6e8c-282e-4d3d-9dc9-49f13b20a255@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/25 16:39, Jinchao Wang wrote:
>
> On 9/9/25 16:00, Masami Hiramatsu (Google) wrote:
>> On Mon, 8 Sep 2025 13:20:51 +0800
>> Jinchao Wang <wangjinchao600@gmail.com> wrote:
>>>> ...
>>>>
>>>> Yeah, I think not. For one this is an almost verbatim copy of
>>>> arch_install_hw_breakpoint() with zero re-use. Surely you've been 
>>>> taught
>>>> better?
>>> I introduced this to modify bp_addr in atomic context in my RFC series.
>>> I thought it was clearer to split the introduction and refactor.
>>> And then It was used in the wprobe series, so I left it as introduced
>>> in the RFC series.
>>>
>>> I agree your suggestion is right. I am willing to refactor after 
>>> wprobe.
>> I'm OK to refactor it to reuse arch_install_hw_breakpoint().
>> My point is to have CONFIG_HAVE_REINSTALL_HW_BREAKPOINT so that
>> we can easily implement the dependency for other features which
>> requires this feature in Kconfig level.
>>
>>>> And why would we want to export guts like this?
>>> I wanted to introduce a real-time stack corruption debugging tool,
>>> which needs a helper to change bp_addr in atomic context (kprobe 
>>> handler).
>>> And wprobe needs it also.
>> I agree with Peter, it should not expose the architecture
>> dependent code directly. Instead, we need a wrapper.
>>
>> Thank you,
> Understood, I will use the wrapper instead.
>
>
Hi Masami,
I would like to ask for your advice regarding a development workflow issue.

I have a patch series that refactors |arch_reinstall_hw_breakpoint|, which
I know you are using in your |wprobe| series. My new feature, 
|kstackwatch|, is
dependent on my patches and also on your wrapper patch for 
|modify_wide_hw_breakpoint_local|.

Since we are working on different subsystems with different maintainers,
I am concerned about how to handle the dependencies between our patches 
to avoid
introducing trouble.

What is the best practice for this type of cross-subsystem dependency?
Should one of us carry all the patches until they are merged, or is there a
standard procedure for this situation?

Thank you for your guidance.

-- 
Thanks,
Jinchao

