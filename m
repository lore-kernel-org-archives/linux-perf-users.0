Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794619638;
	b=OWd7Mw3icJIDHr96ca7G1O7MrWLqHUBKl3kpMj0migK/ilhx7DVDUajfuwlfv5TPR5lb
	 pk5tKcShjXHEjDTHdTPw9xITPmasHkpc8F/noZlRC+JWloKAHz7HEndDKTieh3tj1wNvB
	 KIxAiIZlzRf+y51proKEThhKN7xWjlGKP10Jw3Q+N+T6MWdjrRBLPx1P9WCgwWs8oOdDP
	 G21A9LYPwXoxsMkqULyS4MKGYoKfLzhZsQOlvv2lwDsWZiIEWZSyW4mW9Kr7LtOH9gL/0
	 PLgw2KF17WGHgCsoLJV85OGnnx5kXmphnrPtDgpppp07UBcRg/8l0pufbR1sFKkGUHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794619638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=WDQ393osPw2BrYahUhOGo4g2UUQtrhZG2XU5v+nepPg=;
	b=Z9uP9p4GNQE9HsU/vrA0jkjAzWjSPoq0R+CgDL6sAqVzdjVBtk1pyD9O/10cKIwQ5tg0
	 EJTwmCpMYIHiGHesNg4aABKUvPuGwTUATzopC2C63gNINvi10tVbGoGvk6+q5BsFPLjYO
	 L7A2o4PD0VSqy/YCOCVeosHoAyn7CSkcdoApKpBKC3AyDkhTtlW/mGGLJOxKQi9SksXy3
	 f/c6IyxIgnJJaBukeOfPsfkImxj+znfsrWma1Sp3S7VRlXO5y4V2pPhFA1basWkW4m+lr
	 4RX0+5mOOSzvUtHuJxWA5UhZnrPzI3L5zYtjBLeHWO7xeoYZH/94Dz3KFpxuE3qMCRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RcqUIirm;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2145E606A331
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 01:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2145E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RcqUIirm
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdba1b5ed8dso727658a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794619637; x=1795224437; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WDQ393osPw2BrYahUhOGo4g2UUQtrhZG2XU5v+nepPg=;
        b=RcqUIirmGxFt13gqOdd6yUruatOAAsDo1l+dPkuJjNNuzPvD3QnAij4UXbGRvhh0uc
         CB+p4HwuNb3yIanJC4StdNg1xyj6mfG+vUc2WFPzTyF32DwG5+BQTCb37qSFg8C4xNP2
         7EU9wRMdhXmem62hPbaY/57Zh5HreZ8ahJoleP2aNajewrsjE2QzfZQmv3u9/lgn+xLR
         0leWgUok/fXwoL6EEe3C6aDeqLRdVZ08ngeqDwAhBIb0EVI0R47ojMwqPRyENsER68k+
         8KyH6iF4GnqEN2lLqp3cKb+jpJCg8AE62fQm9Inm4yLXagd6DMhiRrgMYQmiYRYXqezP
         vumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794619637; x=1795224437;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDQ393osPw2BrYahUhOGo4g2UUQtrhZG2XU5v+nepPg=;
        b=G6sukY7ZgjnI/gMz1TbSiCy/hn8ZZV7msY7ESlig8TrOYlinZSLlsCw+j05a0t/U0a
         jHnpyOXe+Q7Ch46ZLizXVlOF0RxRrO8X19IK3dqbE3PxYI5mizVuktORnWnfnxhy2IM8
         COJHBTR3J+YoJKrKK8DeGYsztKkPuOrvNrCIMYchm0cRz+LdPkDdqFcWl63XHh+p1y8X
         +aMDbmz/KGfjaa0yW79feY/IhT2LhBxkMZYSH/dOPombPOMqra+J3za2CTQCVXHrUu1f
         H/SdMnE1UNqNtM/e7jVLw8OQ2w59fm1Gd7JdRt7xpI7yDL/oZPkDleO4CnuOC4HrL/rb
         zWfw==
X-Forwarded-Encrypted: i=1; AL+hErFJv6MofuTBkQ3LM0OmHQljbk5CZPRbvC1AzPwFHNHpimjL89DFeQHfKxY+dCP74o5vD+VIwO9D8yFbPJsa+C9p@vger.kernel.org
X-Gm-Message-State: APuU4Z+jOIHow7Z22fY2XMuFAND3dx+1eIcMkosW5ERzfPekmaYE4BDW
	5QYt702x8l/xQzZ+dDUJdTNZJOaMwlYkdpgwV/J107YKRznYLbUaCgkJsDGdDw==
X-Gm-Gg: AYBFou29jQU/CX/qeDU0cB0/IS1mluC3si05efNfO53Oqfl+JGwDigghjfEOQ0ksCJU
	sy81baCoSwZFA5VtwIvMyitElh3QQ15hlg4l1U1HTUuWqH2WpHA8vKjoDxny3J/fbrpe7Hsu0If
	vWJW0pMn6Tuii6hi0XOnzHI0y3bpBijvgetoSgZg2czjeFFsnyJT9RHzqKgbleWnwaCUnFlfDWx
	BLRTI6z7bGlTvLTngxlLNC+4NqupR9hb7hrLkXFua9Df7cCZa6zL4fB37aQq+1dQmoqGO4MRAUC
	P1nA2o++Kb1wjj7oTCcys4N/tUGm0Y2EMq6yY03OL6GJyuUpxfMFpcRnrVsBSCuXIh8FczQqyRn
	PuIbiC9HZKVnpHVnyLqH3o7Eonx0wB8W66ZLvJZnuWUCIWUn/OaDPwNUzXXRQhLO53LMyQh92bU
	ffBPpUboPWa3mGVAmFMSWPqrxbDFFVoneExWJj/HgkWRvdB31PQYTeMq74DhpZrBCISloSFalQb
	Uorf1r73cTpSucuqz2+PXfrzJ54ye4g5MGxV5xO75n/QJ3xBmQT8Hjp4oWhxSHKpZ5XK+8DOhbS
	mq2Vn6CK5G3oue1tHUsKploZUD7Ngllw6AgvpV9zrelr1r3VCI7sIfG2sXpKpSBvuydHnqdUat4
	k3NHZCWwIO97abP7z9SKgoPciciXk7BWOFQ==
X-Received: by 2002:a17:90b:5107:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3b1b0cdafd9mr2717852a91.32.1794619637389;
        Fri, 13 Nov 2026 17:27:17 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec66f4csm6809102a91.14.2026.11.13.17.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 17:27:16 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 01:27:16 +0000
Message-Id: <DMUJKFF59EU0.3D4OXJLXB2N6B@gmail.com>
To: "Andrii Nakryiko" <andrii@kernel.org>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Cc: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
 <linux-perf-users@vger.kernel.org>, <peterz@infradead.org>,
 <jolsa@kernel.org>, <rostedt@goodmis.org>
Subject: Re: [PATCH bpf-next 1/3] arm64: perf: Don't report the caller twice
 in caller-regs callchains
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261114001846.873499-2-andrii@kernel.org>
References: <20261114001846.873499-1-andrii@kernel.org> <20261114001846.873499-2-andrii@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 13, 2026 at 04:18 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> perf_arch_fetch_caller_regs() sets regs->pc to the return address of
> the function it is used in (CALLER_ADDR0), but points regs->regs[29]
> at that function's own frame record, whose saved LR is that same
> return address. perf_callchain_kernel() reports regs->pc and then
> unwinds from the frame record at x29, so the caller shows up twice at
> the top of every kernel callchain built from perf_fetch_caller_regs():
> tracepoint events, software events emitted by __perf_sw_event_sched()
> (context-switches, cgroup-switches, cpu-migrations), and
> bpf_get_stack() and bpf_get_stackid() in tracepoint, raw tracepoint,
> tp_btf and fentry/fexit programs. E.g., for a tracepoint program
> attached to sched_process_fork:
>
>   __traceiter_sched_process_fork+0x44
>   __traceiter_sched_process_fork+0x44
>   kernel_clone+0x250
>   ...
>
> Use __builtin_frame_address(1), the caller's frame record, the same
> way kunwind_init_from_caller() does, so that pc and x29 describe the
> same frame.
>
> x86 had the same duplicate entry, fixed by commit 6d08340d1e35
> ("Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"").

riscv has the same duplicate it seems.
Its perf_arch_fetch_caller_regs() stores __builtin_frame_address(0)
in s0. walk_stackframe() reports epc, then frame->ra of that frame.
Can be a follow up by riscv folks.

> @@ -15,7 +15,7 @@
>
>  #define perf_arch_fetch_caller_regs(regs, __ip) { \
>  	(regs)->pc = (__ip);    \
> -	(regs)->regs[29] = (unsigned long) __builtin_frame_address(0); \
> +	(regs)->regs[29] = (unsigned long) __builtin_frame_address(1); \
>  	(regs)->sp = current_stack_pointer; \
>  	(regs)->pstate = PSR_MODE_EL1h;	\
>  }

Will, Mark,
this looks correct to me.
Mind if I take it via bpf-next together with the selftests?

