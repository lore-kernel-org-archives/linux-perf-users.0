Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB0360EE8
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640325; cv=none; b=mh3TnDP2gwRJI6HUsZDPVDNnp9j3R1qpwjfWn6bD5C+DyboA0LNUiTIFrdxx4T3FhBOqHTScEfl/eLl8L43+HKMzbsp+5MPHGWZHerH9v7T2dGg8CsWHqvxWuSjd+SkfaGjeqDTLwN6WLY2ouoj2MSITVF7+AwGIQZ08jHXZzfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640325; c=relaxed/simple;
	bh=mBgn0w0K5UbBJxILaFSI5FT01iGeSBDgXfKOAFVnQbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=od3Lbmz7V52NccmnRR3jexvTaj7pxPGRspzZPa+8ADaS6CvRlIRnKDS7JmAYkLBVH4IjLIcmzPOVutNueBXkBKBzXaUiwdJvkBfHT580REfXrAt19Otn1aYpp+VIOjJGgwi4F4MfkVoS8swm3UfNZnaLUAyfJL30lU9RR0D/JNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6AsbF9D; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6AsbF9D"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so6101284a34.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 06:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784640322; x=1785245122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NUGRrLpcbADBJyrtxfRhKxWvRc1OgkKW+dNy23AsVnk=;
        b=s6AsbF9DpU8ULTgrvc0/tzsaDjesyt9YhpAhRwr//iHzIMAf/e2Mp9Lzz/HJanvhnp
         Wtfkn/VFKSY/HmZwVknlhNMwmkMhOn3YA7P9VAZ9kVTGQIlgtrYuOnsV413Rkbyj5kqg
         b8sNQ49cNrzM7sJWvphpy34Cug6H6aUhSYpIWEsI2LWj0nDSkdlwlhS6gd8eqwP2tbQD
         ZFIqjzWaXoq4NKkaVo47dH3Id+oNXw24bkah4MZtIbBsXkh2/dxb+GCfJuDK3oPUNoB5
         W9LLclVyV6JJFaTlHGniXjTf76I191z8YBschfvQShpXhYXYbl/qitJi6sd4BOVFqTy2
         kWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784640322; x=1785245122;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NUGRrLpcbADBJyrtxfRhKxWvRc1OgkKW+dNy23AsVnk=;
        b=nHE7c6/l1DaOC8sncZyIobpAIBsYVuz6Y/cGUzzn6KrS1JEl6safAgk5f3CoXNzDrU
         u8zPhsUSQ8CjJKILfR9gbjpqOUVAn9T3gd6AC+xh5fjBFDMt9n6vGSIHxbxp3XlUSdQW
         ED9SXO2bISd7SXnIC/usj+zHuvG7nLIfyR6L2dlqj9cniznH0/unCEQVH6cpafFwGr94
         4n2BCir5625gA+Hi/XXuhCbIkvZ48XsnT9w2IxJxXMR45SBZZa7N7skGBOsEsUIzPif5
         SneJ6ILLJ764+SmlEbXkECjRMla5J6xLJde19TTi76e1un785P+TNZE2RCQfeOeNfkM6
         fwpA==
X-Forwarded-Encrypted: i=1; AHgh+Rp83lpEzSw9fBvEvU/splNrWRO5UkGjPseIVaQCBIAnVgzYwLz1BhK2IVk6cCX86VspZ4WgHXFnJgr7cPp40Z5d@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ECLrbz4ABfsAJmjtUPL5jGMzx+ICvnWGLaMUsfvyCV22itc5
	4/tPtwH2liYMA/4LYIyhm6s3Y8l0F46mDPFbYqHBv31co36W/9oQbo8m
X-Gm-Gg: AfdE7ckyAU13dq4McmvYvcW0qpNe1ZF26aq0MQAbc4mFdWUKILEo6dApoXiNlNvbhT3
	sHehe92FfMYBh3bAlC9PZmGOUj/IyXZvEjuHRFutgDQdyW+ARQhPCiO6hqe5VGGq8Gso8/7DX4i
	ZsKyyGulZUNr35mJI8IsfOQqN3nElXw+Ho3Q1mvWGAs1HRhXNElExcZrnG7lBQQDgVh5rWHmD5p
	+WtGtgvFn0k9Xgl1X7f9/mknjMwB93AS6dNbnDCMuh4WZA+Ntwl5qrLIr6I6ktLQ3RUFj7PIPBL
	f6AXNRusbHvPe1AhRhVrByhcmtvXlMk26XQqguoOmStcVrvVC49M+QLQmwEIys6zoTo9CO5TBjv
	M6kiJ2Waw/s5MMXyG5trt8dQd6KaPnTmWrK0evH0FGUwSnl1ZAbQ41h2u4mGqLKToD8FcDnOdGt
	RsHuvAbA==
X-Received: by 2002:a05:6830:6a97:b0:7e9:b4cf:d8cc with SMTP id 46e09a7af769-7eda4d90dd0mr12044065a34.32.1784640322334;
        Tue, 21 Jul 2026 06:25:22 -0700 (PDT)
Received: from [198.18.0.1] ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edad94e86csm11116231a34.7.2026.07.21.06.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 06:25:21 -0700 (PDT)
Message-ID: <c3fc1db1-5199-42b1-9e29-e7766b23a599@gmail.com>
Date: Tue, 21 Jul 2026 09:25:09 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/13] mm/kwatch: dynamic hardware watchpoints for
 hunting memory corruption
Content-Language: en-US
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Matthew Wilcox <willy@infradead.org>, Alan Stern
 <stern@rowland.harvard.edu>, Randy Dunlap <rdunlap@infradead.org>,
 Alexander Potapenko <glider@google.com>, Mike Rapoport <rppt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
 <CANpmjNMpKXxk2KsZORakwwdOpDG=pRbtJKi7doBt7QmQwUKdgw@mail.gmail.com>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <CANpmjNMpKXxk2KsZORakwwdOpDG=pRbtJKi7doBt7QmQwUKdgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/20/2026 11:26 AM, Marco Elver wrote:
> On Fri, 17 Jul 2026 at 14:50, Jinchao Wang <wangjinchao600@gmail.com> wrote:
>>
>> Motivation
>> ==========
>>
>> The hardest memory corruption bugs are the silent ones: a rogue writer
>> scribbles over a live object through a stale pointer or a race, and
> 
Thanks, Marco. These are good points. My cover letter did not clearly
separate two different classes of bugs.

> The stale/dangling pointer (use-after-free) case is the main one you're after?

Not exclusively. KASAN already does a good job as a general
use-after-free detector. However, a stale-pointer write after the
storage has been recycled, which may no longer be reported by Generic
KASAN, is one of the cases that the scoped watchpoint can help
localize.

The broader target is silent corruption of a known live victim object,
including non-UAF cases such as an in-bounds racing write to an object
whose allocation is still live.

>> the victim crashes in a code path far away from the culprit. Any
>> single developer hits such a bug rarely, but across the kernel's code
>> base and install base they keep arriving, and each one is
>> disproportionately expensive to localize. The question to answer is
>> "who wrote to this object, and from where?", and it is hard to get at
>> with the existing tools:
>>
>>  - The kernel's own reports - an oops on a clobbered pointer, a
>>    BUG_ON, a list-corruption warning - fire at the victim's access,
>>    not at the corrupting write.
>>  - KASAN/KFENCE catch memory-safety violations: out-of-bounds
>>    accesses and use-after-free. But they have a blind spot: a
>>    corrupting write can be fully memory-safe - a *valid* pointer, in
> 
> Language-semantically speaking, a use-after-free write to recycled
> memory (be it in heap or stack) is NOT memory-safe. The detectors may
> not always catch these (KASAN relies on quarantine for that to
> increase the chances, but yeah, not guaranteed..).
> 

You are right that a stale-pointer write to recycled storage remains a
use-after-free, so "memory-safe" was the wrong term. What I meant was
that such a corrupting write may not be detected by Generic KASAN at
the point where it occurs. KWatch was intended to use a hardware
watchpoint to catch the write and report the actual writer and its call
stack.

>>    bounds, to a live object, written just at the wrong time or to the
>>    wrong place - and then they stay silent by design. And even for
>>    the bugs they can catch, KASAN's rebuild, overhead and redzones
>>    change timing and layout enough that racy corruption often no
>>    longer reproduces.
> 
> There's also tag-based KASAN (KASAN_SW_TAGS or KASAN_HW_TAGS), of
> which KASAN_SW_TAGS has an x86 version based on LAM (not yet merged
> though? see https://lwn.net/ml/all/cover.1773164688.git.m.wieczorretman@pm.me/).
> 
> One property of tag-based schemes (and any other lock+key detection
> scheme) is that upon recycling some memory, the tag (or key) to that
> location changes, and any previous pointer that still has the old tag
> will fault. The caveat with current pointer-tagging schemes is that
> entropy is relatively low (4 bit tags).
Thanks for pointing this out. I agree that tag-based KASAN can detect a
recycled-storage UAF when the new allocation receives a different tag,
so it covers part of the intended use case.

There are still cases it cannot detect, such as an in-bounds corrupting
write to the same still-live allocation, or a recycled allocation which
reuses the same tag. Software tag-based KASAN also still instruments
memory accesses and can perturb a timing-sensitive bug enough that it
no longer reproduces; hardware tag checking reduces this overhead but
is not available everywhere.

The original goal of KWatch, which I now plan to pursue through wprobe,
was to provide a simple and targeted interface to hardware watchpoints.
It does not instrument every memory access system-wide, so it can have
lower overall overhead and less timing perturbation while identifying
the actual writer. I see this as complementary to KASAN rather than a
replacement for it.

Thanks,
Jinchao

