Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8052472B1;
	Tue,  9 Sep 2025 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407167; cv=none; b=loyzoF8eAifIP843UYKtPGkY59bRBvTt7maxJMmEqZgpdkFUycvx/n3/QSzO0B7rl1VUR0jzehnvZaAzeewqVICj8ym7dsRBJI6GzvkQ7jpdxrkQZ0hQu1E5NGd5jkQlLEY77ImjwdmgHAmJKnOAlhYFH9wU1xQ/4lD2Qfs1nvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407167; c=relaxed/simple;
	bh=RCYRfp6jJxuY/4HpNJ3hTnLOaTIfQzXg3q/KFldcVYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmwC/bsfuCDhDBj45IdbT9F4XNOOrRrcN7lWwweDcdM6LAF0fVCV1p29vAFLcvbGAjfvZW5I2DrL+mQGMoUTVYzXA7AjYwX0ipE2u6AokG0+4jHsJczT26F+cWEU7G0wvvrTgiaWGKLkmsnsptgKkM8SQ1R49uclUDHc4XlfYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6IBo9JG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6IBo9JG"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7723f0924a3so7064704b3a.2;
        Tue, 09 Sep 2025 01:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757407165; x=1758011965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cCEi5TXqHrjB+a+Qnvw/4IXVrSNxPFGRspDA4CqFOK8=;
        b=O6IBo9JGMfitO+8Kb1y3dPcQGjU1ZHRXk7/bjX6ugMKxhdq6e/EXf42lT+Nb/CHcX8
         HQ9B1CuE9Hz6SgPnqkjREIpphoAPeo5ihSBmm6EbLfXeBa3JtepzQx1r6DcNWxG24LqT
         OuscPBYldr+1Xq0wkCAagwmSEAe+qJJC96JPEaY9cv2c0WvWW/dFteJ3uh5IuZZ2qVLt
         dOXsgaDHbkUf0y8c+Ffi4zNufbQR29RIvZLilpQ8LG2cbiLZ7XoVCU2E2zMH2+I4ITAw
         n0J8XS3qugNJEm33LOB0he7QqJiBw0ys5yGjaQdqomKJR3lvdp/NiPDTTzSdSVok+wev
         0Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757407165; x=1758011965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCEi5TXqHrjB+a+Qnvw/4IXVrSNxPFGRspDA4CqFOK8=;
        b=gFR0Bnps28oQ52orxmkUtfD5ijN3fr+w/6l5172g7siazNiGqFjMgSGHo9eoth2WFX
         oCkklYgUhyKmdQqkFhwNfHNbZ7TUHzbhVGV2c3Hxsds4VBE2F3p9H+eGPSxXIkgUjyOt
         tp7usFToYzoYJnyxkMXFVFnInXIrv68wM+3iEaBNSTfQ+cHOBecZQ/AhwsAJzD4qkH9K
         kyASdl3dEDgehXdqs0c0U2575TwrrFG2uDMZ3pTuELcC5AJdaThu8zurnOBBYurU7PT7
         9nTqFRUOl9Kc+31EOwkK7CrAtHSgYZBR1n2jlK84gwJL/ykbQjqzdI756hOdP8Qw/t6r
         kb0g==
X-Forwarded-Encrypted: i=1; AJvYcCUqxbYle7JG9LXv4avC+SRQnph9t6G9l2AEOhYt1Do/C9EHV5ykVazXj+8FFD7ldLBiGHCfePld4I6hLai7FToiyvyt@vger.kernel.org, AJvYcCWZHI+/UgZsYdt9/XckP0V4YjeqhMV0HSh2a3IPJvbGFeQz0cgaDim9sNsyf6mDuL28LTRsVXvAIozt05ALlWf5Tw==@vger.kernel.org, AJvYcCX/8pEsqYTHEOTryd+eNHM073W+UHplCAT4igxyHAqgbx4B55wuFeBnM4gIOU0tfgr9zqWirKM97y2Tubs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMnuI31EUTnVwmYQTOdXnlNnX8evJVZfs0BkVQbYm8IXn+pIsc
	cM9sy2zpYGBLtNsrmDMxVvSzc6FDS9j0pjq9g6ZpPXUHZww1dpqW2Z+5
X-Gm-Gg: ASbGncsN8JgqGPFv1aK9pDfRQ74pHDBOuIfrxwv8q4lwDEeWgguwhry48x4FZqcAVz6
	3ZFS/U3QOlren7DWBK+UcxckDNYSZX7WwN97E+5uclODofaa85cRTHu0+1EElgaz+PbSiymkzq/
	BeQ1iqizr/UDlzi2wG9NCNe+bPO+yKS27mTJdi0+9enpXlWpC+yTiyW6h4DjIk5IxAndNMVD/VU
	BQMdOryHi572DT7/4J8HdSKHiD0dMOcJdCoJnCxPlGYIMFjnbuQj+lZWDkIgJhPij36fq1Qcppz
	GqvldLfVst/bh+0W+dSjJiBdLfFR5FTlyWyMpK5fp+ya0t2ydUBau+g1iClhHC8ZzTQPjWcvAO3
	CImPyrrTXqaxhFWo/iqg=
X-Google-Smtp-Source: AGHT+IEqDdTDuoBLWzTwJjBUZvu7QFNnG2+UEDgnZAiaxek/ZB8pmRsjGPRE1NnETcQe5FjLxfbPGg==
X-Received: by 2002:a05:6300:8806:b0:245:fbee:52ec with SMTP id adf61e73a8af0-253444159bamr15811368637.36.1757407164725;
        Tue, 09 Sep 2025 01:39:24 -0700 (PDT)
Received: from [127.0.0.1] ([2604:a840:3::10f3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd3095df7sm28092073a12.36.2025.09.09.01.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:39:24 -0700 (PDT)
Message-ID: <f73e6e8c-282e-4d3d-9dc9-49f13b20a255@gmail.com>
Date: Tue, 9 Sep 2025 16:39:15 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/18] x86/hw_breakpoint: introduce
 arch_reinstall_hw_breakpoint() for atomic context
Content-Language: en-US
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
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <20250909170017.dae27d8be77f9ec634e0d56c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/25 16:00, Masami Hiramatsu (Google) wrote:
> On Mon, 8 Sep 2025 13:20:51 +0800
> Jinchao Wang <wangjinchao600@gmail.com> wrote:
>
>> On Thu, Sep 04, 2025 at 08:38:32AM +0200, Peter Zijlstra wrote:
>>> On Thu, Sep 04, 2025 at 08:21:02AM +0800, Jinchao Wang wrote:
>>>> Introduce arch_reinstall_hw_breakpoint() to update hardware breakpoint
>>>> parameters (address, length, type) without freeing and reallocating the
>>>> debug register slot.
>>>>
>>>> This allows atomic updates in contexts where memory allocation is not
>>>> permitted, such as kprobe handlers.
>>>>
>>>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
>>>> ---
>>>>   arch/x86/include/asm/hw_breakpoint.h |  1 +
>>>>   arch/x86/kernel/hw_breakpoint.c      | 50 ++++++++++++++++++++++++++++
>>>>   2 files changed, 51 insertions(+)
>>>>
>>>> diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
>>>> index 0bc931cd0698..bb7c70ad22fe 100644
>>>> --- a/arch/x86/include/asm/hw_breakpoint.h
>>>> +++ b/arch/x86/include/asm/hw_breakpoint.h
>>>> @@ -59,6 +59,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
>>>>   
>>>>   
>>>>   int arch_install_hw_breakpoint(struct perf_event *bp);
>>>> +int arch_reinstall_hw_breakpoint(struct perf_event *bp);
>>>>   void arch_uninstall_hw_breakpoint(struct perf_event *bp);
>>>>   void hw_breakpoint_pmu_read(struct perf_event *bp);
>>>>   void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
>>>> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
>>>> index b01644c949b2..89135229ed21 100644
>>>> --- a/arch/x86/kernel/hw_breakpoint.c
>>>> +++ b/arch/x86/kernel/hw_breakpoint.c
>>>> @@ -132,6 +132,56 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>>>>   	return 0;
>>>>   }
>>>>   
>>>> +/*
>>>> + * Reinstall a hardware breakpoint on the current CPU.
>>>> + *
>>>> + * This function is used to re-establish a perf counter hardware breakpoint.
>>>> + * It finds the debug address register slot previously allocated for the
>>>> + * breakpoint and re-enables it by writing the address to the debug register
>>>> + * and setting the corresponding bits in the debug control register (DR7).
>>>> + *
>>>> + * It is expected that the breakpoint's event context lock is already held
>>>> + * and interrupts are disabled, ensuring atomicity and safety from other
>>>> + * event handlers.
>>>> + */
>>>> +int arch_reinstall_hw_breakpoint(struct perf_event *bp)
>>>> +{
>>>> +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
>>>> +	unsigned long *dr7;
>>>> +	int i;
>>>> +
>>>> +	lockdep_assert_irqs_disabled();
>>>> +
>>>> +	for (i = 0; i < HBP_NUM; i++) {
>>>> +		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
>>>> +
>>>> +		if (*slot == bp)
>>>> +			break;
>>>> +	}
>>>> +
>>>> +	if (WARN_ONCE(i == HBP_NUM, "Can't find a matching breakpoint slot"))
>>>> +		return -EINVAL;
>>>> +
>>>> +	set_debugreg(info->address, i);
>>>> +	__this_cpu_write(cpu_debugreg[i], info->address);
>>>> +
>>>> +	dr7 = this_cpu_ptr(&cpu_dr7);
>>>> +	*dr7 |= encode_dr7(i, info->len, info->type);
>>>> +
>>>> +	/*
>>>> +	 * Ensure we first write cpu_dr7 before we set the DR7 register.
>>>> +	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
>>>> +	 */
>>>> +	barrier();
>>>> +
>>>> +	set_debugreg(*dr7, 7);
>>>> +	if (info->mask)
>>>> +		amd_set_dr_addr_mask(info->mask, i);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(arch_reinstall_hw_breakpoint);
>>> Yeah, I think not. For one this is an almost verbatim copy of
>>> arch_install_hw_breakpoint() with zero re-use. Surely you've been taught
>>> better?
>> I introduced this to modify bp_addr in atomic context in my RFC series.
>> I thought it was clearer to split the introduction and refactor.
>> And then It was used in the wprobe series, so I left it as introduced
>> in the RFC series.
>>
>> I agree your suggestion is right. I am willing to refactor after wprobe.
> I'm OK to refactor it to reuse arch_install_hw_breakpoint().
> My point is to have CONFIG_HAVE_REINSTALL_HW_BREAKPOINT so that
> we can easily implement the dependency for other features which
> requires this feature in Kconfig level.
>
>>> And why would we want to export guts like this?
>> I wanted to introduce a real-time stack corruption debugging tool,
>> which needs a helper to change bp_addr in atomic context (kprobe handler).
>> And wprobe needs it also.
> I agree with Peter, it should not expose the architecture
> dependent code directly. Instead, we need a wrapper.
>
> Thank you,
Understood, I will use the wrapper instead.

