Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B147A0C0;
	Wed, 15 Jul 2026 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128298; cv=none; b=Hxjv+oQSsFHx1Kbt3GEBSTHYkcaqaT42yR5nRYWAZtMzwW1sqncrv6Two2atFKKfAm7bP88E6FrHiMBXk4ibgg0yt08+sH+57ps1jxQCmaicv/o9WGQ5L6TJ5begLd6ExMPICl2+m4rh7Fy/xUhpz8sgQEE5oQIvqaJg5+VOL9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128298; c=relaxed/simple;
	bh=MXqlgAuYKkv6LAKiheIdNgpxFvsXwA0ZL84b8v5SLM0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KG7MGfxcbROiqEB2AgyuaR1U80B/sw2k+kZqLegDbBygdxOj2cS2Ul0GHTbl953TrsHQnY2m3dNx+3JiE6SSDEinMzjs1Aj+hUlYPc5pVHHlkjrZlbb4FIbxQxBw0Lp9rxo8ZcQ+a+sf8Rw9Uz7579o9T+Do75XEcy42hRu89mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKzFmIGt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKzFmIGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1901E1F00A3A;
	Wed, 15 Jul 2026 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784128297;
	bh=2T7NmRa3e4PZpXem/DpRc1JOnKNS5bUtto2fefbxDCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IKzFmIGtkcvS2gXGYPuqeyp0jvJm6q5iWG52zQ0Wi6+IaFWLllYav1MIb/dhtT05e
	 R8k6M1c1ArFiioKGU++kRahU7yNz8vaSm0oB+gUXz0SS3SLo1IUk8QInkPBD3svOrj
	 nFWGnU+pQTliV8Bob/0GTVlLsooOvsXmAdWBRGRCB5gPnNtO/2VGVvUpRejEr98XXL
	 lWckKuYAIXQVFQYNO1I8H+UPhD21oxjDmMYRnqXjM33aDsDFEb1b/nAimPxzy3wMP0
	 B+hIrpDYjM4jShinfeD4/8KIMrljN0MzKhA+AS1xLsuHqQhpEaPgujSuVVQnHTWY9a
	 iO5vjN7MH0+Lg==
Date: Thu, 16 Jul 2026 00:11:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 01/10] tracing: wprobe: Add watchpoint probe event
 based on hardware breakpoint
Message-Id: <20260716001133.657b9a4fe095965a06b218bc@kernel.org>
In-Reply-To: <20260715020140.005751F000E9@smtp.kernel.org>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
	<178407985042.95826.15157571843735900142.stgit@devnote2>
	<20260715020140.005751F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 02:01:39 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [High] Missing error rollback in enable_trace_wprobe() leaves dangling event file links and active hardware breakpoints, leading to Use-After-Free and resource leaks.
> - [High] Format string bugs in trace_wprobe_show break the dynamic_events save and restore functionality.
> - [Medium] wprobes silently drop all perf events because the hardware breakpoint handler lacks perf ring buffer delivery logic.
> - [Medium] wprobe_trace_handler silently drops events if the hardware breakpoint address was updated, contradicting the stated design.
> - [Medium] Unconditional memory leak of the dynamically allocated `symbol` string in `__trace_wprobe_create()`.
> - [Medium] Undocumented `$value` variable is implemented, contradicting the commit message claims.

Thanks for the comments.

> --
> 
> --- Patch [1]: [PATCH v7 01/10] tracing: wprobe: Add watchpoint probe event based on hardware breakpoint ---
> commit f8a7aeb231575f15f9227ab411134bde7408e480
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing: wprobe: Add watchpoint probe event based on hardware breakpoint
>     
> This patch adds a new dynamic event for hardware breakpoints, called a
> wprobe-event. It allows users to trace memory access at specified addresses
> or symbols, supporting both ftrace and perf interfaces.
> 
> Link: https://lore.kernel.org/all/175859021100.374439.8723137923620348816.stgit@devnote2/
> 
> > User also can use $addr to fetch the accessed address. But no other
> > variables are supported. To record updated value, use '+0($addr)'.
> 
> [Severity: Medium]
> Is this documentation accurate?
> 
> Looking at parse_probe_vars(), it explicitly parses and handles a $value
> variable:
> 
> parse_probe_vars() {
>     ...
>     if (!strcmp(arg, "value")) {
>         code->op = FETCH_OP_BADDR;
>         code++;
>         code->op = FETCH_OP_DEREF;
> ...
> 
> Should the commit message be updated to reflect that $value is actually
> supported?

Good catch! Yeah $value was added, so we don't need to use +0($addr).
The $addr is used for ensuring watching address. That will be useful when
wprobe trigger is introduced.

> 
> > diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> > new file mode 100644
> > index 0000000000000..b52f3eac719f9
> > --- /dev/null
> > +++ b/kernel/trace/trace_wprobe.c
> 
> [ ... ]
> 
> > +static void wprobe_trace_handler(struct trace_wprobe *tw,
> > +				 unsigned long addr,
> > +				 struct pt_regs *regs,
> > +				 struct trace_event_file *trace_file)
> > +{
> 
> [ ... ]
> 
> > +	if (trace_trigger_soft_disabled(trace_file))
> > +		return;
> > +
> > +	if (tw->addr != addr)
> > +		return;
> 
> [Severity: Medium]
> Does this strict address comparison inadvertently drop valid events if the
> hardware breakpoint address was updated dynamically?

Yes, to avoid confusion, if the watchpoint is changed on another CPU,
it is better to be skipped.

> 
> The v7 changelog mentions using the dynamic address because the original
> address can be updated from another CPU, but this check causes the handler
> to exit immediately if the updated address differs from the statically
> recorded tw->addr.

Yeah, this is something for wprobe trigger, which will dynamically update
the tw->addr. So maybe we can move this in wprobe event trigger patch.

> 
> [ ... ]
> 
> > +static void wprobe_perf_handler(struct perf_event *bp,
> > +			      struct perf_sample_data *data,
> > +			      struct pt_regs *regs)
> > +{
> > +	struct trace_wprobe *tw = bp->overflow_handler_context;
> > +	struct event_file_link *link;
> > +	unsigned long addr = bp->attr.bp_addr;
> > +
> > +	trace_probe_for_each_link_rcu(link, &tw->tp)
> > +		wprobe_trace_handler(tw, addr, regs, link->file);
> > +}
> 
> [Severity: Medium]
> Does this handler omit the necessary logic to generate and submit perf
> samples?

Ah, OK. This should not be used from perf. I think this should be
explicitly prohibited at this moment.


> 
> [ ... ]
> 
> > +static int enable_trace_wprobe(struct trace_event_call *call,
> > +			       struct trace_event_file *file)
> > +{
> 
> [ ... ]
> 
> > +	if (file) {
> > +		ret = trace_probe_add_file(tp, file);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
> > +	}
> > +
> > +	if (!enabled) {
> > +		list_for_each_entry(tw, trace_probe_probe_list(tp), tp.list) {
> > +			ret = __register_trace_wprobe(tw);
> > +			if (ret < 0) {
> > +				/* TODO: rollback */
> > +				return ret;
> > +			}
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> 
> [Severity: High]
> Could this missing rollback logic lead to a use-after-free or memory
> corruption if a later hardware breakpoint registration fails?

OK, to avoid memory corruption add a rollback logic here.

> [ ... ]
> 
> > +static int parse_address_spec(const char *spec, unsigned long *addr, int *type,
> > +			      int *len, char **symbol)
> > +{
> 
> [ ... ]
> 
> > +	if (kstrtoul(at + 1, 0, &_addr) != 0) {
> > +		char *off_str = strpbrk(at + 1, "+-");
> > +		int offset = 0;
> > +
> > +		if (off_str) {
> > +			if (kstrtoint(off_str, 0, &offset) != 0) {
> > +				trace_probe_log_err(off_str - _spec, BAD_PROBE_ADDR);
> > +				return -EINVAL;
> > +			}
> > +			*off_str = '\0';
> > +		}
> > +		_addr = kallsyms_lookup_name(at + 1);
> > +		if (!_addr) {
> > +			trace_probe_log_err(at + 1 - _spec, BAD_ACCESS_ADDR);
> > +			return -ENOENT;
> > +		}
> > +		_addr += offset;
> > +		*symbol = kstrdup(at + 1, GFP_KERNEL);
> > +		if (!*symbol)
> > +			return -ENOMEM;
> > +	}
> 
> [Severity: High]
> Could the null terminator injection here break dynamic_events save and
> restore functionality for events with symbol offsets?
> 
> When the event is created with a symbol offset (like symbol+8), *off_str
> is overwritten with a null byte. This truncates the string before it gets
> duplicated into *symbol.
> 
> Later, trace_wprobe_show() outputs the truncated base symbol without the
> offset, meaning the restored event will monitor the wrong memory address.

Since the symbol is used for making the event name, it should not have
offset.  However, in trace_wprobe_show(), the symbol is directly used
to show the target address. Thus, instead of changing
parse_address_spec(), we need to update trace_wprobe_show() to use
kallsyms_lookup_name() to find the symbol address and calculate the
offset from tw->addr and symbol address, and print out the "symbol+offset".

> 
> [ ... ]
> 
> > +static int __trace_wprobe_create(int argc, const char *argv[])
> > +{
> 
> [ ... ]
> 
> > +	char *symbol = NULL;
> > +	unsigned long addr;
> > +	int len, type, i;
> > +	int ret = 0;
> > +
> 
> [ ... ]
> 
> > +	trace_probe_log_set_index(1);
> > +	ret = parse_address_spec(argv[1], &addr, &type, &len, &symbol);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (!event)
> > +		event = symbol ? symbol : "wprobe";
> > +
> > +	argc -= 2; argv += 2;
> > +	tw = alloc_trace_wprobe(group, event, symbol, addr, len, type, argc);
> > +	if (IS_ERR(tw))
> > +		return PTR_ERR(tw);
> 
> [Severity: Medium]
> Does this leak the dynamically allocated symbol string?
> 
> The symbol variable is populated with an allocated string from
> parse_address_spec(). When passed to alloc_trace_wprobe(), that function
> duplicates the string again:
> 
> alloc_trace_wprobe() {
>     ...
>     if (symbol) {
>         tw->symbol = kstrdup(symbol, GFP_KERNEL);
>     ...
> }
> 
> However, __trace_wprobe_create() never frees the original symbol string on
> either the success or error paths.

Yes, let me use __free() macro to free it.

> 
> [ ... ]
> 
> > +static int trace_wprobe_show(struct seq_file *m, struct dyn_event *ev)
> > +{
> > +	struct trace_wprobe *tw = to_trace_wprobe(ev);
> > +	int i;
> > +
> > +	seq_printf(m, "w:%s/%s", trace_probe_group_name(&tw->tp),
> > +		   trace_probe_name(&tw->tp));
> > +
> > +	char type_char;
> > +
> > +	if (tw->type == HW_BREAKPOINT_R)
> > +		type_char = 'r';
> > +	else if (tw->type == HW_BREAKPOINT_W)
> > +		type_char = 'w';
> > +	else
> > +		type_char = 'x'; /* Should be rw */
> 
> [Severity: High]
> Will outputting 'x' for HW_BREAKPOINT_RW cause parse_address_spec() to
> reject the configuration upon restore?
> 
> If type_char is set to 'x', the formatted string saved to dynamic_events
> will be invalid. When the system attempts to restore the event across
> reboots, parse_address_spec() checks strictly for 'r', 'w', or 'rw', and
> will fail with -EINVAL for 'x'.
> 
> Should this be adjusted to output a string like "rw" instead?

Ah, good catch. Let me use rw instead.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
