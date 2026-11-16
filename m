Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808609;
	b=x5egvlUjTQvHu3uQGUcXxbM1aQev6h98Fq1WWjJh62vTbmauFJs/s+ViiW9Hz99J6RHQ
	 nefr6gfsNvTqwPcJJQi09SjwuFYcYtL6X6vIzZxxVuAaXvtKNiM7jisOoHUOo2I5KWhSM
	 KizZATl2zUxQs+o6cdFB10xGBYLr587klg8SO3wEA8rNqcTfcK8Bo7qL1DIXXqia0cruE
	 vl/w0JSEPHzd1l3JFFcZdWtT94LFUNsZlSf+oZFIzjTvWv/YJX1g8D/L5Ps37dYkiFXFP
	 ZcGCDLyh4IsICRxf9u1OcVdjsJmZPHO+uIgdyEe0RSW93vZjvbMJFuCSsNkIk8gCo2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808609;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8ikGpskDhsfYR6LF1VxG+4qcHnBuW3PWj6qvNRfOBHk=;
	b=JOh7fHTNoWVls25Tb8HTKlzSoS+kjKviESy60TsQy1y4qg2fMoIzVwHiFtB0hg4Q0qAE
	 G5SF/icnYqyJieoCSAB3d5wmSRXp3j4KWS5KAoXUZxLrsl3yx4sPSyaYe/doG8cH+8oxw
	 HIRFtzPdc4hmAPDjd0kJnfZ8o4VJw8q/RCwqvgU7vitTiZTMtdkLqLCP69BvG509bvrZ9
	 0Xz7/lr/hLoVp+VIrRNzFexfAYaewipifGUgzy9Vsq4jDn2s1s/zMNwXFUp32Jw5av8JE
	 nzSr6n2p00Cmes+lFDTF85sYPP+78Kmw02Fmsh/S0hsRNubLVappX5NEjuIzfswa9Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Hmk/AZnq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70208606A329;
	Mon, 16 Nov 2026 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hmk/AZnq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195C71F000C5;
	Mon, 16 Nov 2026 05:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808609;
	bh=8ikGpskDhsfYR6LF1VxG+4qcHnBuW3PWj6qvNRfOBHk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hmk/AZnqirOzpN9I41cD/AzrSKjc9bETXMddsZnrmSdq4nSpGfqpnrv5eJ9MoYp2Q
	 tuo08glsL53/qTcUgAXVfbZFZPnyosKB/rEyJfHgkVf78AM4KoIszxYINsfrVrsYux
	 6MnhhRrp72llzK0XxiL/OoSQ3voaXLYC3sKV5A/SahzOhFDpnwcLiT1fMt0aKWsBZO
	 VDqdKVAAA/kRLUUeIWkZwzwMh8Dyv3jxLEM4X98ol2NNbKsmbYBLfFm/QeAlRXyg4u
	 TMnI164p9QeKxUaM302TrozguOaZbbSufq72BBbPfb8T3rIp2duh0bKl/KIvvOi41N
	 Q0x7Saj0AiITA==
Message-ID: <sashiko-outbox-216236@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 04/11] tracing/wprobe: Add wprobe (watchpoint probe)
 trace event support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179480679855.38065.12988926948228161902.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
 <179480679855.38065.12988926948228161902.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 05:56:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] tracing/wprobe: unheld lock and symbol lookup in
  trace_wprobe_match()
- [Medium] tracing/wprobe: TASK_SIZE check in
  trace_wprobe_is_valid_addr()
- [Medium] tracing/wprobe: trace_ctx underflow in wprobe_trace_handler()
--

commit ba36417426baa731cd50929b7289160f5b44d5a3
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/wprobe: Add wprobe (watchpoint probe) trace event support

This commit adds hardware-breakpoint-based dynamic trace event support
(wprobe) to trace data read and write accesses and log the access context
and fetchargs.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> new file mode 100644
> index 0000000000000..644183cf5155e
> --- /dev/null
> +++ b/kernel/trace/trace_wprobe.c
[ ... ]
> +static bool trace_wprobe_match_command_head(struct trace_wprobe *tw,
> +					    int argc, const char **argv)
> +{
> +	char *symbol __free(kfree) =3D NULL;
> +	unsigned long addr;
> +	int type, len, offset;
> +
> +	if (!argc)
> +		return true;
> +
> +	if (parse_address_spec(argv[0], &addr, &type, &len, &symbol, &offset))
> +		return false;
> +
> +	if (tw->type !=3D type || tw->len !=3D len)
> +		return false;
> +
> +	if (tw->symbol) {
> +		if (!symbol || strcmp(tw->symbol, symbol) !=3D 0 ||
> +		    tw->offset !=3D offset)
> +			return false;
> +	} else if (symbol || tw->addr !=3D addr) {
> +		return false;
> +	}
> +
> +	argc--;
> +	argv++;
> +	return trace_probe_match_command_args(&tw->tp, argc, argv);
> +}

[Severity: Medium]
Can calling parse_address_spec() from trace_wprobe_match_command_head()
trigger a lockdep warning and race on trace_probe_log?

dyn_event_release() invokes pos->ops->match() under event_mutex without
holding dyn_event_ops_mutex.  When argv[0] does not parse as a valid wprobe
specification (for example, while dyn_event_release() walks past a wprobe
when removing another probe type with arguments, or when a user passes a
non-matching spec), parse_address_spec() calls trace_probe_log_err() ->
__trace_probe_log_err():

kernel/trace/trace_probe.c:__trace_probe_log_err() {
	lockdep_assert_held(&dyn_event_ops_mutex);

	if (!trace_probe_log.argv || !trace_probe_log.argc)
		return;
    ...
}

Because dyn_event_ops_mutex is not held, lockdep_assert_held() fires and
__trace_probe_log_err() can race with a concurrent dyn_event_create() thread
initializing or freeing trace_probe_log.argv.

In addition, parse_address_spec() requires kallsyms_lookup_name() to succeed
even when matching a symbol-based wprobe where only tw->symbol and tw->offs=
et
are compared.  If the watched module has been unloaded, kallsyms_lookup_nam=
e()
returns 0 and prevents removing the wprobe using its full specification.

[ ... ]

> +static void wprobe_trace_handler(struct trace_wprobe *tw,
> +				 unsigned long addr,
> +				 struct pt_regs *regs,
> +				 struct trace_event_file *trace_file)
> +{
> +	struct wprobe_trace_entry_head *entry;
> +	struct trace_event_call *call =3D trace_probe_event_call(&tw->tp);
> +	struct trace_event_buffer fbuffer;
> +	int dsize;
> +
> +	if (WARN_ON_ONCE(call !=3D trace_file->event_call))
> +		return;
> +
> +	if (trace_trigger_soft_disabled(trace_file))
> +		return;
> +
> +	if (READ_ONCE(tw->addr) !=3D addr)
> +		return;
> +
> +	dsize =3D __get_data_size(&tw->tp, (void *)addr, NULL);
> +
> +	entry =3D trace_event_buffer_reserve(&fbuffer, trace_file,
> +					   sizeof(*entry) + tw->tp.size + dsize);
> +	if (!entry)
> +		return;

[Severity: Medium]
Does calling trace_event_buffer_reserve() without disabling preemption
underflow trace_ctx when CONFIG_PREEMPTION is enabled?

Hardware breakpoint exceptions invoke perf_bp_event() -> ... ->
wprobe_perf_handler() with interrupts disabled, without incrementing the low
8-bit preemption count.  trace_event_buffer_reserve() calls
tracing_gen_ctx_dec(), which decrements trace_ctx assuming the caller disab=
led
preemption.  When a watchpoint hits in preemptible kernel context where the
preemption and migration-disable counts are 0, subtracting 1 underflows tho=
se
fields to 0xff and borrows from bit 16 (TRACE_FLAG_IRQS_OFF), corrupting the
recorded preempt_count and clearing the irqs-off flag in the trace entry.
Acquiring guard(preempt_notrace)() before trace_event_buffer_reserve() (as =
in
trace_fprobe.c) avoids the underflow.

[ ... ]

> +static bool trace_wprobe_is_valid_addr(unsigned long addr, int len)
> +{
> +	if (addr < TASK_SIZE)
> +		return false;
> +
> +	if (addr & (len - 1))
> +		return false;
> +
> +	return true;
> +}

[Severity: Medium]
Should trace_wprobe_is_valid_addr() check TASK_SIZE_MAX (or
arch_check_bp_in_kernelspace()) instead of TASK_SIZE?

On 64-bit architectures with CONFIG_COMPAT, TASK_SIZE evaluates to the
current task's address limit (such as IA32_PAGE_OFFSET when a 32-bit task
writes to dynamic_events), which allows addresses in [TASK_SIZE,
TASK_SIZE_MAX) to pass validation and register a CPU-wide hardware watchpoi=
nt
on a 64-bit user-space address.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179480675130.38065.=
3086970856119381693.stgit@devnote2?part=3D4
