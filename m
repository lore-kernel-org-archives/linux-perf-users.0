Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C940227CB0A
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477560; cv=none; b=HhYIPJ5Yd0GUZ5ieLPBMTnltWjfJpQLIfisj42fk3UGPQLmW6BLc3jh94U5yaww3mqb8zlcMk0E5GWFNo1haVseeAXG/i9rJ5E+C4vhNYJl+ZqS6JhqM0/Mlq9nrDCQyruWMqD+fzpgoP+DXkLcVNSzKtqkkWuOEUZ2Jwp7FGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477560; c=relaxed/simple;
	bh=dCDNdc5ViwAZ31uKNNUrqN+tz+sav2geyOoaw4Tozmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRvwYUJynsANT5jchwWZ6MDbHDqyToGIwlU7s/dU/Y0yvscfGNONgftshV6r0fzEYKnJxzGcLtl+MkX9MAhxNg+y5Y8bvpkSerwzLSKJp4IyFhZeO1yEnAiHx4qnjpUaEagquiQLprvZlhAwgl7Ao5iyFgPIFURHo7d753TPT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4d8qEe2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4d8qEe2"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a102494058so29076585ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 17:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769477558; x=1770082358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uulx0WOxdrU4glIAb8OrX5ZK+yXeZwLkXoVx0Hx78Yk=;
        b=H4d8qEe2NnPVweJjX317pnbvdSbang+VSQ6UuCJvmg6ey55FJPj8XhfbPmixRyO1yy
         AvSCHv0JPnwYY/gPEd8CYuXqggXVOt4BLsgJo02s7v6t9uYpqfHq3Nvy6X9F73BZhATY
         Q+6hDhWe7xY6A+2k2AvoW3LQi9mr8rItI+94+xuTOuFhzMTtPMn60Kr1vOjnhV8MjiyB
         1yLvdhQilTYv9m/YGLUJhIESXqEDv6E+/IEXmWNSuSiL96qahw5CfW3jnWaDrN4Iy3jf
         xudHiqeYpr5M/qU/vlbF20SHruk3CnZaxpwzHBMnSncSBJxocMt1ske74L400bzzYL48
         +QxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769477558; x=1770082358;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uulx0WOxdrU4glIAb8OrX5ZK+yXeZwLkXoVx0Hx78Yk=;
        b=QKPoFBGKuKX4/WYohv9GXa5udfJfrOz3LzPxU759XuUJZFwbtcrJ1tvzcWYw+Poh6k
         aPnRHU/mLIdfWHlBselaCN+wiIcCw3EZFcx8C/1m1mNRQ/9nJ5whv+keB+aRnj0w+Wxs
         sfnC5HUKLOdhE78weGlyJnYHNW8UjThuCk+zilXT6PouB9qIwJOUZyh6iRnxdCPVXtyu
         BHcDIePsuG9J6FzwK+a/mWeH+Mzkmq3lwpwQKL/w3R9UXHV6KDJ6/If4RRSetgg52dy2
         qxQsz0RvN3DYXvOOk5VRsfZaDcyKAH3KifrfiiTLev7Bo+1fUZgc8gJMZe2YbrKQXMpy
         qStw==
X-Forwarded-Encrypted: i=1; AJvYcCUOXa1BlRb0/RxSFLhIGfVhIg56Y1AI+d6V3LJ6iaisdWeHfFpSa/HA4M47SjoeZRh/KiHMxcX3WpwxT/prxi+3@vger.kernel.org
X-Gm-Message-State: AOJu0YzceEWGlj9uUKTWIqy5UzH+oHdUmG4oOFtkPsHIwpTEy9SahDL5
	NGtOGYlv4ao+5HFtJOjidO+Dk7/vSjDSUzF3KLGh0Cg4aMgkzPW8b7vN
X-Gm-Gg: AZuq6aLfNb2XBEQF86jdyLBzoQ9c7igBKi5Xt7nJw443X10eLMjsRt56ozK3hcI6MPY
	ByAmqKh/JD2rbP1t2PaHlvNsMDQAzWINlwr1AuD562PQvCtRAzcDLVciDfBQYAbsdIhui2VMK9H
	4A+aAtgoKEAZq7R0gtll2sKqHku9QUpvGyVb0Sw34DVb3n8Vtg4qfn54gBqZ2tqK4WKP+63HJIC
	MaA/BIxDDgsDETPYpJUcEEMW1Jwxxhf7YS3sS5IqcFX6vx+r7Ckz9rsVeFLOOJqjZkcLRQFMp1l
	lFlUoyMGwtfxW3w81rKUxB2qNslvd9kXAKzVGhjgRivYeeg8BnLdwUIwMI8HmGELT7JPdSMLnL0
	XZlHX8E+765ibg9XGuHpL6CcwjJ0zSux3NKc6O7cb+ws3m78PShWTlEfJ6tuzd7rk0pcF8BE5J6
	86Ye1t/XMe0dqliSzcNjQWF9o5qJGBxrWKukrmGjwUeIP7WmtX4gJgaG+uavHc
X-Received: by 2002:a17:902:fc84:b0:2a7:9163:8e60 with SMTP id d9443c01a7336-2a8455b04e5mr60607285ad.23.1769477557920;
        Mon, 26 Jan 2026 17:32:37 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcd781sm99006485ad.24.2026.01.26.17.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 17:32:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <27f9a957-67c7-4c88-b320-0f8725e9b03d@roeck-us.net>
Date: Mon, 26 Jan 2026 17:32:35 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH 3/5] perf: Use current->flags &
 PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20250820180338.701352023@kernel.org>
 <20250820180428.592367294@kernel.org>
 <0d877e6f-41a7-4724-875d-0b0a27b8a545@roeck-us.net>
 <20260126120553.2fa79048@gandalf.local.home>
 <20260126121803.4a90c959@gandalf.local.home>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260126121803.4a90c959@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/26/26 09:18, Steven Rostedt wrote:
> On Mon, 26 Jan 2026 12:05:53 -0500
> Steven Rostedt <rostedt@kernel.org> wrote:
> 
>> I guess we need to also test for !current->mm because the flags set for an
>> exiting task is done when we can still do callchains. Thus, the only way to
>> know if it is safe to do a callchain when a task is exiting is via task->mm
>> and not task->flags :-/
> 
> Can you test this patch?
> 

Still crashing, though not as often and with a slightly different backtrace.
I added the backtrace to the bug report @ Google.

Guenter

> -- Steve
> 
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 1f6589578703..c82d61d73bd8 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -246,7 +246,14 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>   
>   	if (user && !crosstask) {
>   		if (!user_mode(regs)) {
> -			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
> +			/*
> +			 * Testing current->mm is not enough as some kernel threads
> +			 * may have one set. But testing the flags is not enough
> +			 * either as this can be called after a user task
> +			 * frees its mm just before it exits.
> +			 */
> +			if (!current->mm ||
> +			    (current->flags & (PF_KTHREAD | PF_USER_WORKER)))
>   				goto exit_put;
>   			regs = task_pt_regs(current);
>   		}

