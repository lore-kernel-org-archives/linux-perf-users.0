Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53EB40D587;
	Tue, 14 Jul 2026 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784063693; cv=none; b=AKJG34vgbXjGTz+Dz1oBXd5ETYpxegnOnIYRzRMaF/miAmp+zG0ueK6lzfVBRWY5dSrF8TJ/Vr0TNJwFYJnqbV+Ul47PDXCV/GWFo26f/iXC03qh4d5xb3ufLGe3HKO5QhBopYuqpZZIoMxrAnKBjxaYabM9SYKSGKh0vvrtEhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784063693; c=relaxed/simple;
	bh=YpFOvdHNbooxq1qa2KJjA9MM8vmvHHa1fIOhAJ9X2D4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDEniRvONO5jKyOIoPAC1xhegMSqpUG/plTLVI8W5hNkLvAeXiQuABvcwWORSKbz7vilTtPYq1mJFC7spTs+dV91oPOcH4ArYRiDXsuwU4OhBPnFhQ65QXJu61+EyoWlMddVSMgslycjkrFslulVNH3ZSew7Jjb32CVEaumKM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 5AA0440522;
	Tue, 14 Jul 2026 21:14:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 15C226000D;
	Tue, 14 Jul 2026 21:14:35 +0000 (UTC)
Date: Tue, 14 Jul 2026 17:14:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter
 Anvin" <hpa@zytor.com>, x86@kernel.org, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 08/13] mm/kwatch: add hardware breakpoint backend
Message-ID: <20260714171438.226faf7b@gandalf.local.home>
In-Reply-To: <20260714183206.12688-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
	<20260714183206.12688-1-wangjinchao600@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 15C226000D
X-Stat-Signature: ofukrydpoaufx6f8q8s6anx3wj8ecikd
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/+jUG/wma6bXPaXNDDF4uPI966CzmydeA=
X-HE-Tag: 1784063675-113700
X-HE-Meta: U2FsdGVkX1+BwHjks+RcUuzIPHfbSeUChRislj0v1kLLaY98NAKF6cdZylAtqcI59w4fbE1UaMDFXzng8xvt0r2W54B6xPwD9aR33+AJde3xxYHmB3Xqy97uhwKNAjrEFHbwMYr8N+8lsjMIeaRezBQgyf4EPvq0NQyxCRRifw46VeA3PQuB85l2wH4sIawolc51TlXnBbIf/t6zg2PpDxpQ0xONaCpVs5SuoR/zHifYoqD66Sr0/ekUURTsxJf3+xmOBWatOhJM00GlJgkk1ANhdqTl8Jgjzp1LQGeDovN3/JPet+YhwAnTHMWlMR4NDTHuDFZrVnyepQjaQfBPmFF0Dc8n1a0i

On Wed, 15 Jul 2026 02:32:06 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> --- /dev/null
> +++ b/include/trace/events/kwatch.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM kwatch
> +
> +#if !defined(_TRACE_KWATCH_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_KWATCH_H
> +
> +#include <linux/tracepoint.h>
> +#include <linux/ptrace.h>
> +
> +#define KWATCH_STACK_DEPTH 8
> +
> +struct trace_seq;
> +const char *kwatch_trace_print_stack(struct trace_seq *p,
> +				     const unsigned long *stack,
> +				     unsigned int nr);
> +
> +TRACE_EVENT(kwatch_hit,
> +	TP_PROTO(unsigned long ip, unsigned long sp, unsigned long addr,
> +		 u64 time_ns,
> +		 unsigned long *stack_entries, unsigned int stack_nr),
> +	TP_ARGS(ip, sp, addr, time_ns, stack_entries, stack_nr),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, ip)
> +		__field(unsigned long, sp)
> +		__field(unsigned long, addr)
> +		__field(u64, time_ns)

Move the time_ns to the first field, as unsigned long on 32 bit
architectures is 4 bytes, and this will make 4 byte "hole" in the event.


> +		__field(unsigned int, stack_nr)

Make stack_nr the last element for the same reason.

> +		__array(unsigned long, stack, KWATCH_STACK_DEPTH)

Make the above a dynamic array based on stack entries.

		__dynamic_array(unsigned long, stack, min_t(unsigned int, stack_nr,
			  KWATCH_STACK_DEPTH);


> +	),
> +
> +	TP_fast_assign(
> +		unsigned int i;
		unsigned long *stack = __get_dynamic_array(stack);
> +
> +		__entry->ip = ip;
> +		__entry->sp = sp;
> +		__entry->addr = addr;
> +		__entry->time_ns = time_ns;
> +		__entry->stack_nr = min_t(unsigned int, stack_nr,
> +					  KWATCH_STACK_DEPTH);
> +		for (i = 0; i < __entry->stack_nr; i++)
> +			__entry->stack[i] = stack_entries[i];

			stack[i] = stack_entries[i];

> +	),
> +
> +	TP_printk("KWatch HIT: time=%llu.%06lu ip=%pS addr=0x%lx%s",
> +		  __entry->time_ns / 1000000000ULL,
> +		  (unsigned long)((__entry->time_ns / 1000ULL) % 1000000ULL),
> +		  (void *)__entry->ip, __entry->addr,
> +		  kwatch_trace_print_stack(p, __entry->stack,

		  kwatch_trace_print_stack(p, __get_dynamic_array(stack),

> +					   __entry->stack_nr))
> +);
> +

-- Steve
