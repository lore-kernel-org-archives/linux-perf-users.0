Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEC832B100
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 02:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785985125; cv=none; b=T7HntVLP5Fdy5qcFNBEAA84PAvLaWl0SOkY244w/gJM+POutvtAHIz763MAw0rMrbfKdRFXemmN41G8ufHbbQ7WAv5YOraF4n49NaIzytko8t+KiGfDwofI1zuQQvnYkEp9OM/KyNW4X5ljbwAZ+PHAFV5DwqxrHubPz1vfeAuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785985125; c=relaxed/simple;
	bh=fsWRZDHmdhpEVey7PNeiNthgILPDQgnkk9V8OIsmTHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t15vH93aXdNiymrwiRI/PcoPktAAnQ44i5LeZb0+NSZ+RpYFL290l/iM5Dnr5w9cZjdQ30uUS9oMmB0JLvwneEAq9HA5+VqVurnPCMugcC49UAChVRr4iWTC5d4CK2vDEWO94fVS7+nHGWEVz2mq4wx50q1YwI3QvPbNWDyHH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKDW0I+T; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKDW0I+T"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6ae3faeb9c3so950178eaf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 19:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785985122; x=1786589922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cb3qpMNSQjkPFBRsgWqX2QuJCQXNljC6fDwPCJ7VZBs=;
        b=LKDW0I+TS5kgEgK5PhYaJHnShgS6TQ69xoyA9jq00AsOqWA6ZXC3bpIWJOSNjOrZ+V
         +0B8gISScl19XWere4KZOr7GItxoxVqmVmavHTTLlTe94vnSDzwPjgksiCBoF55PwB8A
         BuQHRWSSNs3YUtGX66F2aB+oMd0X72WsxxAXZiIu8LycsUSB4hfc4SdzintLZLntxaQu
         lxk3tB3f6lx5rheFOkVkMu8WPFu7lftePgBPpHuDm+oSKSPj8x347aGDNrlUGOXtqHZ1
         Bqe4TwzupE98ZPkyZVC6ZB/xLU69VGZc/4XSdBmwlYOuMmhpHy1Q/td9cjKgX5k4jw4Y
         lfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785985122; x=1786589922;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cb3qpMNSQjkPFBRsgWqX2QuJCQXNljC6fDwPCJ7VZBs=;
        b=S20di+JXjjSGARVdnasIXJCzhXCtoGZ9ZTAwRHA7YB8Xzqo2/p9nc2pOmvEFoTZprt
         hdZr/jYrlTqSDuI9ObS5tKoeTgD3bxXv8yZHtzaoPaaUOGnGEN2cCsn9aFenK8a0DaND
         sHyM1ObtRQBAv/xgXiFaIQNPsggnjajVP7T72zUBZOHc33SpaKDQWHd40jHkFO9IjAwp
         Q8UoGOSUgQ4kuA5HOlc4ptZzK3oyf8ZoOE4eCf0MmLLuuP6qo2yeEGgtGdiXVN/bAG98
         fuxa6Uw7EYMJKQFCUuFdSf5wg40anYKCo+8wx06dnDtK1u/HoqeeJIl6vy2gJn3lArXD
         RNeA==
X-Forwarded-Encrypted: i=1; AHgh+Rrv+DLeCgGxuXhtNi2GptP0SuzSWDaG06zysrsf/QkqogJJnYhCb93yTjrX194/fKJYvjy9BvU8Cimc6VygqX3r@vger.kernel.org
X-Gm-Message-State: AOJu0YwxKgZpXtY2Zibi9A9OBK7JS+W3ok90LaE8gXgRKIn0ffxAr1cl
	I4BP5gIeedu+j0NhXplWCfCKtwBaygoXfbt7trbn7HopxWYeP0ssjSiT
X-Gm-Gg: AR+sD133d46mQ97wCLOH4qiCFlzOhJmqDI/cgZGINQ4w4TVfcr2T2718FG/BH0nNvwD
	xoUlgaz5brKh30ijG0RuUeWNay5D9IxlA5HPnHF6IaRxbR+LTzYxPTQUkWonPUp9Bf4E+g7/XYr
	i5zkm41jy2HbyWkeX9z62H+oJ2fgeuvQcfs40/qxphaGZNcZKxosrYaVxwORJgIe6p1dVoIF3+/
	E4X8QcHxNgYE8b46hkB7yYqixWF8lyejfrnsvKvJbV1GanZBjSlIR0iA9QLT8hUzGcnuXhdFRS2
	FisDTdiMsUpUvV91xmTuXromsaEJ4lJzcG+Cu8kkC6pZ4UngakM+IkrkFV827V5TxF62Tjr2E2P
	yox7oxllvW6l5K0kRneZlfvnJzBZRtwD4cVe4svAmHdNjYQAMAXA08fDcLTqcZuUtJflonLGxE1
	K5Zxn0VSGFxQW6o6mFKnOfS1fsm+Q9bfmPN6ky/tuC/jzp457FPIMrx3eg0Nm8R8U=
X-Received: by 2002:a05:6820:4dcd:b0:6a1:363d:bc42 with SMTP id 006d021491bc7-6ae96c55f8fmr6311046eaf.15.1785985121804;
        Wed, 05 Aug 2026 19:58:41 -0700 (PDT)
Received: from [127.0.0.1] ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93cbf7a9sm4532734eaf.2.2026.08.05.19.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 19:58:41 -0700 (PDT)
Message-ID: <c21f0ba6-912d-45ff-8636-b69a0ddc92e4@gmail.com>
Date: Thu, 6 Aug 2026 10:58:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/11] tracing: wprobe: Add watchpoint probe event
 based on hardware breakpoint
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
 <178565875046.714490.17724442147958346980.stgit@devnote2>
 <20260803070356.GV49951@noisy.programming.kicks-ass.net>
 <20260804080035.6b719368c9328bbdd8219867@kernel.org>
 <20260803230840.GJ687043@noisy.programming.kicks-ass.net>
 <20260806090641.e59484ac570b0f842bc930bc@kernel.org>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <20260806090641.e59484ac570b0f842bc930bc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/2026 8:06 AM, Masami Hiramatsu (Google) wrote:
> On Tue, 4 Aug 2026 01:08:40 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Tue, Aug 04, 2026 at 08:00:35AM +0900, Masami Hiramatsu wrote:
>>> On Mon, 3 Aug 2026 09:03:56 +0200
>>> Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>>> On Sun, Aug 02, 2026 at 05:19:10PM +0900, Masami Hiramatsu (Google) wrote:
>>>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>>>
>>>>> Add a new probe event for the hardware breakpoint called wprobe-event.
>>>>> This wprobe allows user to trace (watch) the memory access at the
>>>>> specified memory address.
>>>>
>>>> s/the memory/the kernel memory/
>>>
>>> Indeed.
>>>
>>>>
>>>>> The new syntax is;
>>>>>
>>>>>  w[:[GROUP/]EVENT] [r|w|rw]@[ADDR|SYM][:SIZE] [FETCH_ARGs]
>>>>>
>>>>> User also can use $addr to fetch the accessed address and $value to fetch
>>>>> the accessed memory value (shorthand for '+0($addr)'). No other variables
>>>>> are supported.
>>>>
>>>> This seems limited to kernel addresses only? Should not also userspace
>>>> addresses be supported?
>>>
>>> Hmm, for x86, yes, since it causes a trap after executing (all page fault
>>> are handled). But other architecture like arm64 may not be able to support
>>> it because it needs to enable watchpoint after major page fault.
>>> At this step, I would like to limit it just for kernel memory.
>>
>> Sure, but suppose you were to add userspace, what would the ABI be?
> 
> Ahh, sorry. It was misreading, I mean it should be only for the kernel address,
> not for user space. So I don't want to add userspace. (I answered the first one)
> 
> Thank you,
> 

Keeping wprobe limited to kernel addresses makes sense to me.
Userspace watchpoints are already supported by the perf hardware-breakpoint API,
and supporting them in wprobe would add unnecessary complexity.

An explicit address check could also make this boundary clear.

>>
>> That is, don't paint yourself in a corner etc.
> 
> 

