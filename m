Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C540BCBB
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968673; cv=none; b=Z6vDIfwFYXHX4/ESVZeRUotA5L6rHUteBA88So2VLar1hKcYQeWGlQjqTuOT4T/kVF2FfsySgzEzuN3zbCv+b0f6zClAC6NCnWbEZysvzGWITY+paZcnGxqWV8KfRIqrYYa9HrmuGz50fqhGTTxia0B8SH4Y7z7vFfm9BStG0os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968673; c=relaxed/simple;
	bh=PJR0h7C/VzRo3uPH48UKQj4Yt6lbJ3zv05wBAo3oTHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Amq9IYuWPCCfeucWnNCsqZ2xwZYfQ38VSGfo6nFi5VU/Y++TWeHhGBQB2mSIfO6tUeWCfxkwSZ+FsRdEPxHi5//hJJbjJYupEWU/WvFyRNxAnSZ0FzWN5s/6Ssvgw4X4VUjaKvuyNKD6JiRuxHI6qezaAjnjzIEvT+zioDrYCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ouCdA47w; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouCdA47w"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15d111ca99so349982166b.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786968670; x=1787573470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kYFZLTaPPfJf4QgXpghGqRg1zayFCFmSXU8y0/5uqUc=;
        b=ouCdA47wZCbOyPiFixwK740tpkeCjiKhH3/lj+cdw/T0LJQPhbYdxUO2zmWRd570Mb
         vy8iHyKZhjvKeLSqqXp45tO/YLHjpI5mRkPzGrPuLsgXpBfuX2Ed/Hmb/5LPkq8I5gHa
         m6AU9ZWJ+JEaaxcWSvzf21mxQ59XK2fg3yWKGsfE1qSEXhIGPG0Z9dAW8Sk3Ek45J8BR
         GYhrCUbt9CpP3p52679JQAlaluVPT0u3Y1pL5HdN7XzTekP/3kCIQH6Lr+MfOCSmyZnP
         kMQen4bPo7gWZwO3ZLvW5Kt0JmHsUX1UAkicJHqCN6hvnksZX1ZoKaohWfRlLQFSpyhp
         hrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786968670; x=1787573470;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kYFZLTaPPfJf4QgXpghGqRg1zayFCFmSXU8y0/5uqUc=;
        b=VnAsJeGtUse5nOaDeoCk0f2tbpC06tgySaA8MJZeDGtQ7IEiv3jQWNuyTx+l9DVxVI
         Equp8NmUQ6q3uClAZk7iBLPWEZ/k2Gy9gzVh+QggoTzKdGq1LZqidoFPg+k6VnUPn6nQ
         q1V6lacNt4jTTptSAqrDfP30HtLyacPjBV68v1CBOz8U+uFwo/tw5s7Pw3j2bUIPh8al
         ki9AFaXGWn5vrIzCchORyzXTVaS00kuz3vlDih+aJIFLf3S3IAi0qKIDv8ZJQE0gZ2Jz
         jKL8mRr/OePuX2qMDjklLvfUH0/IDmY2ViZzqkTkX1xmPBJdbleXUbdAEwtDl3lRfkMF
         iGcw==
X-Forwarded-Encrypted: i=1; AHgh+Rr23ZYgO04zHIHdsWYBEcaX//5dAz0GldL6ROdGhP7GmUZsP7YQwGBY+kX+wOYQOGhX10jJXUBZOgb4VzmWVETf@vger.kernel.org
X-Gm-Message-State: AOJu0YzqYmz8uWmlJumF8NUkMF6vxAnNMz1Np4MPASCzTGwb71MFKyIw
	AS0nD+DqJgEeba/Vy2ZcXrCsXPQ2T7HTay/LGI8PTrMkKQD9/o7jWLpXTowcMeRx
X-Gm-Gg: AR+sD11ThVYANkj3alfAvEZ84TjbM8B8hh5f28DLMAcio3TMBhH4s3k2mz2qnokvYDI
	D2YqGaMEMCN+eBXtofRqgu43au5L/XlLbNLC2OfejR3SjO7SWEi4Z//js36xvTIt9KxHrWqSEYx
	MIzfo9AyfRs+krOQgPfBECpjsG3nS1NtQnUpWNhzzGEUMIM3EK++jjh7Gt1p/OqmibKWB/jMgS3
	pCAswiUkzCLv2qWLM8oEl2N8+CnrA07358LcSJs+Uqm+gp6A1UGkqGPsatWZa0a3PP4mgCJWC+8
	JCI4CM4SXwO6BO4R0emufwsPgrAmd2PORX83lL2zMZVk9kJKibBenZRn5zXjQ5qBPe4MOyWUIl2
	XpsvfZnn0HQxeLP+lTh3Z6ecbPGOe8FXAtapPI8vkT+3hM+ckVldOA+gSZY9+5/D29mYSAPnNaT
	x3No6qm6GUWrNcZA9xtoOGiap0wD3bQZTBm9wRtgamVo6MD08mAeWkZQCyrbi4Gw==
X-Received: by 2002:a17:906:7950:b0:c12:764e:326 with SMTP id a640c23a62f3a-c212a385512mr1051411166b.27.1786968669702;
        Mon, 17 Aug 2026 05:11:09 -0700 (PDT)
Received: from [127.0.0.1] ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fe6aa89sm46476466b.2.2026.08.17.05.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 05:11:08 -0700 (PDT)
Message-ID: <d80c8e99-7062-4d41-b47f-e45f1dde5745@gmail.com>
Date: Mon, 17 Aug 2026 20:10:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/11] x86: hw_breakpoint: Add a kconfig to clarify
 when a breakpoint fires
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
 <178611685388.237811.14452013458905879452.stgit@devnote2>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <178611685388.237811.14452013458905879452.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/2026 11:34 PM, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add CONFIG_HAVE_POST_BREAKPOINT_HOOK which indicates the hw_breakpoint
> on that architecture fires after the target memory has been modified.
> This is currently x86 only behavior.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v11:
>   - Move select to alphabetically sorted place.
> ---
>  arch/Kconfig         |   10 ++++++++++
>  arch/x86/Kconfig     |    1 +
>  kernel/trace/Kconfig |    1 +
>  3 files changed, 12 insertions(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index bea383408e32..a096952987a8 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -457,6 +457,16 @@ config HAVE_MIXED_BREAKPOINTS_REGS
>  	  Select this option if your arch implements breakpoints under the
>  	  latter fashion.
>  
> +config HAVE_POST_BREAKPOINT_HOOK
> +	bool
> +	depends on HAVE_HW_BREAKPOINT
> +	help
> +	  Depending on the arch implementation of hardware breakpoints,
> +	  some of them provide breakpoint hook after the target memory
> +	  is modified.
> +	  Select this option if your arch implements breakpoints overflow
> +	  handler hooks after the target memory is modified.
> +
>  config HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
>  	bool
>  	depends on HAVE_HW_BREAKPOINT
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 33908103d9a0..533010ab29a9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -287,6 +287,7 @@ config X86
>  	select MMU_GATHER_RCU_TABLE_FREE
>  	select MMU_GATHER_MERGE_VMAS
>  	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
> +	select HAVE_POST_BREAKPOINT_HOOK
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_RELIABLE_STACKTRACE		if UNWINDER_ORC || STACK_VALIDATION
>  	select HAVE_FUNCTION_ARG_ACCESS_API
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index b58c2565024f..d9b6fa5c35d9 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -866,6 +866,7 @@ config WPROBE_EVENTS
>  	bool "Enable wprobe-based dynamic events"
>  	depends on TRACING
>  	depends on HAVE_HW_BREAKPOINT
> +	depends on HAVE_POST_BREAKPOINT_HOOK
>  	select PROBE_EVENTS
>  	select DYNAMIC_EVENTS
>  	help
> 
Reviewed-by: Jinchao Wang <wangjinchao600@gmail.com>
