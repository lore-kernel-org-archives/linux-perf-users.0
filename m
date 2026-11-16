Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794804230;
	b=pT98eBXQ9oUehp6ee8pW23U5kvExwAQh5XgTzJ3jwUk9fsMF4Un0DlL15sSJaXdKsWyx
	 5JRDXq8hslgrTO0uvRsHprC/NkXWRuNhncDfDBT5Rtp7kGzCfdlzphepWegb1eOAaNSgY
	 MUH3E/kJWmYevsLus/LHhBHZkNAFsYcFgHWG2t2yRTgMcCcflWlDvkz9aOcoL1SfD/ZtF
	 v25IUDYv/Ji8BVddABb5oW60aUgnVt002Nw3o2eiFar7iF8lVjxMKVct8QzmV9i+h2r6g
	 O+SMj/BMWCyJBiZEL9HVaAcYX9D5U8qiPdiXMQdfPRpFYbCDP4s11esWAzxC6f1ErJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794804230;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RUI0JHvfgidgz/0eQOLWkGRn+KPexmQv3YIIFpeyEXM=;
	b=2q6p8FMEdXuoxR2pRqUhil3r5bBJNuLaCHwfGWkorMKq85CNFv11lQjbQHmfDmhMSbOH
	 /v5ODQb4iDGJGby4N0Fcs0K4TVEIZOyFuiRrg0M9cWZxePBY2SvQxcV/a2FHT6ipSVgu1
	 EKBpT7ftoECKbxGSbm3X86pvtyVyJrYuNfrENO++NOAPKLISKexFP1J8YpzmmyAS/8iym
	 BJ5iRw5V58mPkcX6ytvQmNZMfrud6eilO8GuR7FXB5uGR70q0GtLE7Lk1Uwf/HQ8JzZWA
	 5GzQJRYsF+MVt323+VH9WY+adg/Q5W6cvj5kw5nr6sy2EAYaF2XGKTQJ1qw2nAeZ1OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8gOFG4w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195B8606A321;
	Mon, 16 Nov 2026 04:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8gOFG4w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023AA1F000C4;
	Mon, 16 Nov 2026 04:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794804229;
	bh=RUI0JHvfgidgz/0eQOLWkGRn+KPexmQv3YIIFpeyEXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H8gOFG4wEUhu06Pfx+ndVWDohjDi5LQHia7PsiK6VVKhg+Iq/hMUBXR4YCqe2ZPGs
	 a6VdWHGiA/OXnCl6tgJ6BvSnr+jTYa2DnU+l4ZUWneHY+JUooEbsnQxZFthctzgfGB
	 txuqRCnCLUsGcuLHF4KABoc3b6K7+uGsIWBczLPiihD0gETnWr1ez9qM+Xr0sSILOO
	 1Y3jt6BBuaHJYOBbvEpV5dqCP1RLHUGsm+63jqWzoaimH4CG3bLKn7WmiHiveyAaCI
	 UXJghr+ikcwtSSInUm8K11wlWMr03iBS98qJ/nZ/IXzsEmKkh/JpQxZTIXh7gGuCxi
	 0UX+/sVmMXQDQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v19 08/11] tracing/wprobe: Add set_wprobe and clear_wprobe event triggers
Date: Mon, 16 Nov 2026 13:43:45 +0900
Message-ID: <undine-1794804225555740397-c2e0363b3e35f8a3@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <179101402530.22872.12892814568115529973.stgit@devnote2>
References: <179101393469.22872.5895666191299551553.stgit@devnote2> <179101402530.22872.12892814568115529973.stgit@devnote2>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sat,  3 Oct 2026 16:53:45 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c
> @@ -767,9 +928,632 @@ static int trace_wprobe_show(struct seq_file *m, struct dyn_event *ev)
> +		 * mode so that if the user did not explicitly enable this
> +		 * event, __ftrace_event_enable_disable() unregisters it.
> +		 */
> +		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &wprobe_data->file->flags);

It seems I should not touch this, because when a wprobe has set_wprobe and
clear_wprobe triggers, and remove clear_wprobe trigger after hitting
set_wprobe trigger, this unconditionally soft disables it.


> +		/* Remove the SOFT_MODE flag */
> +		trace_event_enable_disable(wprobe_data->file, 0, 1);
> +		trace_event_put_ref(wprobe_data->file->event_call);

`trace_event_put_ref()` is called here before `trigger_data_free(data)`
schedules RCU/tracepoint synchronization via `trigger_kthread`. When
`wprobe_trigger_free()` is called from `clear_event_triggers()` (which does
not call `tracepoint_synchronize_unregister()` synchronously), dropping the
target event reference here allows `wprobe_data->tw` to be freed while an
in-flight tracepoint is still executing `wprobe_trigger()`.
This put-ref should be done in data->private_data_free().

Thanks,
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
