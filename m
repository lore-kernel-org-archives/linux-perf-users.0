Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302722425B
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448571; cv=none; b=Skki1wWYe4697L1q3FsonJzqPMForbFjJZUFr9AF9IHTzcMA4PTnaw1T2+SFrDEpMWMv53Ba+fzvGSGwwCOD7yHwDM5ZX1DW7gKIQ4mDZPKeSCW+hz+qQZFYjyQaJ5Wi4GnTAs+q8Av3vjF6EtGoxZhp+SF+mR7tVK2nuW8LtzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448571; c=relaxed/simple;
	bh=b9otfwPO/QWyBt4niwtGfGXz1WCDPLmmsC/I6QYBPkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxx2f3CNc75ZD4jfgoayOilVqFiCzR+r+PDKhn/iRdHseDKntHgX/hsKtPGSUGo4iJzvFK2tCtMgjk0E2cJEtqjmphW+YPknUf63ipBFqG3rQON5oDWo2X/+8DWeEm77lvGbn5sbvSF0G9LyfAamrW+BFXWrQ9/fX53uPw8xuNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+tj8Qsp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+tj8Qsp"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so2390342b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 09:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769448570; x=1770053370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bxcil9kziVi0UiAXso3TgZFyUXSquwsekaO3e8uWgWc=;
        b=G+tj8QspzR3WDb8UnmKhLpKopixQdzdhBtfOzT4nRmDIcwyr3S6gMAp5sb6ewJenYQ
         q/O0CSOSZCZ8NIh6cO4NyuuPQG4DHiPBRGYv/arN2cNR96jVqKiSEwMUzyBeO72FEY7m
         sxdKJL78ODuJIvadjPqxpn15AonRrWVD5tak3oqGws8lXx7+ujzsYyNw9EmRcG0SE52A
         67d1R/z+VWdJLet2ChpOR0oPvj7kQfiMYN1KhcHj7OiY/l5sibCZg6TSD0SaKVOfeLID
         p8OfaZnnT9MRWBKKUhHu/tkPi2YySEENgNMh0pZ0du8x8D0ur7NZKP4GTT6IYsPgcjAB
         +vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769448570; x=1770053370;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxcil9kziVi0UiAXso3TgZFyUXSquwsekaO3e8uWgWc=;
        b=ZVoHGssJY7m4xYbfxegsWcN4hz57b1aC+CYtLhN4rd02YQoPqB4E7DdD2AbEeqZaNu
         ljdf6glb3Xmql7oXVrnMv25JUluL8jwlRCwJMAqNGSC5x5/CW7q/EStlno4dSO1DDn5s
         CZhhbGrAgBhGznHp7JSIaITs2VVXLSFNUGfWnE6OKdTPUAc2PSbbzG2MwKj6D7zMnTeI
         xeTPYFptqJsQ7ysqau6MyB32kLsJqovEVb1MMCeiICIMhhX5aXt5uXlaNj7ljqwyye1a
         xGoc20UXiVdNE59SHlGrDc40BcsvmsvcOWkrLzNIj4mPpLZuKPMYPQxpdT+lTLIYHSna
         lBhw==
X-Forwarded-Encrypted: i=1; AJvYcCUfvhEM03KhR99V6Icmmkk8u8KR7KfFPxu1Nn+bfFxwPGpg67Rp5niqrwLJn5UvAqPQpZ23mshg1SXV3RXEJjAG@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnWnUDBq/QgXwMMirauV2nREOC8X+1s8GqWsBKn2UlsmmTbpx
	Z9/z+CEJ1gHHoKJlJAYoxf5DF2wGN6yI01Lr8czE2rTfY9MzbS4+Tm+H
X-Gm-Gg: AZuq6aKgXVO+Vtwd1a5IT8ux9o9tNflCB6Iy2CREUMrTGOnqg/b0nXkbOwIGYBQV8A7
	eNuUI1vxAd1M7qb42B44W4eKkkma3RlgdXZrMLTAHzUeEhYtVgtYBKhMl23gIO0vAswW8JIK+gM
	cMSw9DTtpnnNbNL2lioIsajCLjBe8ny/9sYQCuCHYjdWo7xXXdVBjp6qHAYrAXmZG+dfgUM2XsL
	UPwyHfIHam0gowaeHLK9mLBoZU08kZf7HlgdeBdQd0e8e4cWXRpzQtjEN8pK9r/DYoD5rGWDx6u
	ESV31ysoos5+eeQmYhX+qdGqvoci9n6Z9k7rNT6c50zwGG/I7qebXJNCwNivSi1PaMonebJUqJv
	Jge+okviqDxcOKf8VU8yvTbCupHH4IXNQjyZRpI7c4tHlxaSSXuNNia6me9yA4dytSr7JgGPO8Y
	dCRysRzx4hUjTT9UhWg+GGrdvOfNST6VqdzEl0zjoWwKtZr2x8lH6xlt/XJ4HT
X-Received: by 2002:a05:6a00:218d:b0:7b9:4e34:621b with SMTP id d2e1a72fcca58-823411dba02mr5090654b3a.12.1769448569676;
        Mon, 26 Jan 2026 09:29:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318662dd9sm9739777b3a.19.2026.01.26.09.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 09:29:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8c612fbd-2f23-486c-9f6b-8bf4d0c23705@roeck-us.net>
Date: Mon, 26 Jan 2026 09:29:27 -0800
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

Sure, though we had dropped the offending patch from the LTS backport, so that
will take a bit.

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

