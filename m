Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB083A7858
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 02:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080901; cv=none; b=L1T2mPE401dnaK5IsWLqK1bgyEe8WZdNOgD/oICCjwKEiLCOalJInx4xYnvMXqYYRj/Shm/Fl1v7yrQOV2N3RteVCHs/uMJ1Ipi5TZa9sf0uoA/s9uLi/XUxRTl+Hi52qTezNZf160PeCLxYSDNUHbxAyhLMvNUb0PJZ1QINzbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080901; c=relaxed/simple;
	bh=LuBzkvASPKn25bxSmdA6i5HCJz/pQVvjbwHR6UT3raE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZuViUCXCvYT3AJm7VLP1MopurF5LDTKdbEYAJopDf811BNp9cyHgQBWCoarA+uDb3H5mgP31nxKYN/zwmBcMBEbPci86vzHPvoVA6+zdeQp5oWOq0MtTmCqJrW2wJ9t6MgPE8acJSd3bMYxazIXbLK+kdQ9rJih7bKUH4Dc0hY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kee0N6xp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kee0N6xp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005751F000E9;
	Wed, 15 Jul 2026 02:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784080900;
	bh=t0dLKRIU08AtprNlaZz3B8rgdgaVcMNGt6mnjY/1zlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kee0N6xpGjImKXJRC8XXySOmduUx7HyKHRdCTjnElqvKQBtvjpbHBHtaqGaruoJfY
	 iSbL/OfejGbTjSYP04BX0jASe1SbIkG4T1Lsp/kPRA9Kx7UIOn7UHVWAPS/1tpB55d
	 bRFReWTlvUYGpr45rRmVsCsDakCtRRhmLrOGYxN0gUZhu9jryzzvRbH0tBQcWq1C6G
	 hfaSdqLxtCiAywAB0K8OyiOO3hdICjOIpum8sUFOfwyYfCkarXvsloSNfAl8Zdlifo
	 zZVgpzTHanDMbjjl0sN0vkU55POXARvIyZYITrLB34ENExWqX9Qg6lQEN95OIpRNrc
	 VPlqm1OpNkdGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/10] tracing: wprobe: Add watchpoint probe event
 based on hardware breakpoint
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178407985042.95826.15157571843735900142.stgit@devnote2>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
 <178407985042.95826.15157571843735900142.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 02:01:39 +0000
Message-Id: <20260715020140.005751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Missing error rollback in enable_trace_wprobe() leaves dangling ev=
ent file links and active hardware breakpoints, leading to Use-After-Free a=
nd resource leaks.
- [High] Format string bugs in trace_wprobe_show break the dynamic_events s=
ave and restore functionality.
- [Medium] wprobes silently drop all perf events because the hardware break=
point handler lacks perf ring buffer delivery logic.
- [Medium] wprobe_trace_handler silently drops events if the hardware break=
point address was updated, contradicting the stated design.
- [Medium] Unconditional memory leak of the dynamically allocated `symbol` =
string in `__trace_wprobe_create()`.
- [Medium] Undocumented `$value` variable is implemented, contradicting the=
 commit message claims.
--

--- Patch [1]: [PATCH v7 01/10] tracing: wprobe: Add watchpoint probe event=
 based on hardware breakpoint ---
commit f8a7aeb231575f15f9227ab411134bde7408e480
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing: wprobe: Add watchpoint probe event based on hardware breakpoint
   =20
This patch adds a new dynamic event for hardware breakpoints, called a
wprobe-event. It allows users to trace memory access at specified addresses
or symbols, supporting both ftrace and perf interfaces.

Link: https://lore.kernel.org/all/175859021100.374439.8723137923620348816.s=
tgit@devnote2/

> User also can use $addr to fetch the accessed address. But no other
> variables are supported. To record updated value, use '+0($addr)'.

[Severity: Medium]
Is this documentation accurate?

Looking at parse_probe_vars(), it explicitly parses and handles a $value
variable:

parse_probe_vars() {
    ...
    if (!strcmp(arg, "value")) {
        code->op =3D FETCH_OP_BADDR;
        code++;
        code->op =3D FETCH_OP_DEREF;
...

Should the commit message be updated to reflect that $value is actually
supported?

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> new file mode 100644
> index 0000000000000..b52f3eac719f9
> --- /dev/null
> +++ b/kernel/trace/trace_wprobe.c

[ ... ]

> +static void wprobe_trace_handler(struct trace_wprobe *tw,
> +				 unsigned long addr,
> +				 struct pt_regs *regs,
> +				 struct trace_event_file *trace_file)
> +{

[ ... ]

> +	if (trace_trigger_soft_disabled(trace_file))
> +		return;
> +
> +	if (tw->addr !=3D addr)
> +		return;

[Severity: Medium]
Does this strict address comparison inadvertently drop valid events if the
hardware breakpoint address was updated dynamically?

The v7 changelog mentions using the dynamic address because the original
address can be updated from another CPU, but this check causes the handler
to exit immediately if the updated address differs from the statically
recorded tw->addr.

[ ... ]

> +static void wprobe_perf_handler(struct perf_event *bp,
> +			      struct perf_sample_data *data,
> +			      struct pt_regs *regs)
> +{
> +	struct trace_wprobe *tw =3D bp->overflow_handler_context;
> +	struct event_file_link *link;
> +	unsigned long addr =3D bp->attr.bp_addr;
> +
> +	trace_probe_for_each_link_rcu(link, &tw->tp)
> +		wprobe_trace_handler(tw, addr, regs, link->file);
> +}

[Severity: Medium]
Does this handler omit the necessary logic to generate and submit perf
samples?

Since wprobe_register() accepts TRACE_REG_PERF_REGISTER, users can open
these events via the perf syscalls.

However, this handler only iterates over ftrace ring buffer links and
calls wprobe_trace_handler().

Without perf ring buffer delivery logic, will perf recordings of wprobe
events contain zero samples?

[ ... ]

> +static int enable_trace_wprobe(struct trace_event_call *call,
> +			       struct trace_event_file *file)
> +{

[ ... ]

> +	if (file) {
> +		ret =3D trace_probe_add_file(tp, file);
> +		if (ret)
> +			return ret;
> +	} else {
> +		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
> +	}
> +
> +	if (!enabled) {
> +		list_for_each_entry(tw, trace_probe_probe_list(tp), tp.list) {
> +			ret =3D __register_trace_wprobe(tw);
> +			if (ret < 0) {
> +				/* TODO: rollback */
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Could this missing rollback logic lead to a use-after-free or memory
corruption if a later hardware breakpoint registration fails?

When __register_trace_wprobe() fails partway through the loop, the function
returns immediately without unlinking the trace_event_file (via
trace_probe_remove_file) or unregistering any successfully enabled sibling
breakpoints.

If the user then deletes the trace instance, the trace_event_file is freed.
Should one of the still-active breakpoints fire later, wprobe_perf_handler()
would iterate over the corrupted file list and dereference the freed memory:

wprobe_perf_handler() {
    ...
    trace_probe_for_each_link_rcu(link, &tw->tp)
        wprobe_trace_handler(tw, addr, regs, link->file);
}

[ ... ]

> +static int parse_address_spec(const char *spec, unsigned long *addr, int=
 *type,
> +			      int *len, char **symbol)
> +{

[ ... ]

> +	if (kstrtoul(at + 1, 0, &_addr) !=3D 0) {
> +		char *off_str =3D strpbrk(at + 1, "+-");
> +		int offset =3D 0;
> +
> +		if (off_str) {
> +			if (kstrtoint(off_str, 0, &offset) !=3D 0) {
> +				trace_probe_log_err(off_str - _spec, BAD_PROBE_ADDR);
> +				return -EINVAL;
> +			}
> +			*off_str =3D '\0';
> +		}
> +		_addr =3D kallsyms_lookup_name(at + 1);
> +		if (!_addr) {
> +			trace_probe_log_err(at + 1 - _spec, BAD_ACCESS_ADDR);
> +			return -ENOENT;
> +		}
> +		_addr +=3D offset;
> +		*symbol =3D kstrdup(at + 1, GFP_KERNEL);
> +		if (!*symbol)
> +			return -ENOMEM;
> +	}

[Severity: High]
Could the null terminator injection here break dynamic_events save and
restore functionality for events with symbol offsets?

When the event is created with a symbol offset (like symbol+8), *off_str
is overwritten with a null byte. This truncates the string before it gets
duplicated into *symbol.

Later, trace_wprobe_show() outputs the truncated base symbol without the
offset, meaning the restored event will monitor the wrong memory address.

[ ... ]

> +static int __trace_wprobe_create(int argc, const char *argv[])
> +{

[ ... ]

> +	char *symbol =3D NULL;
> +	unsigned long addr;
> +	int len, type, i;
> +	int ret =3D 0;
> +

[ ... ]

> +	trace_probe_log_set_index(1);
> +	ret =3D parse_address_spec(argv[1], &addr, &type, &len, &symbol);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!event)
> +		event =3D symbol ? symbol : "wprobe";
> +
> +	argc -=3D 2; argv +=3D 2;
> +	tw =3D alloc_trace_wprobe(group, event, symbol, addr, len, type, argc);
> +	if (IS_ERR(tw))
> +		return PTR_ERR(tw);

[Severity: Medium]
Does this leak the dynamically allocated symbol string?

The symbol variable is populated with an allocated string from
parse_address_spec(). When passed to alloc_trace_wprobe(), that function
duplicates the string again:

alloc_trace_wprobe() {
    ...
    if (symbol) {
        tw->symbol =3D kstrdup(symbol, GFP_KERNEL);
    ...
}

However, __trace_wprobe_create() never frees the original symbol string on
either the success or error paths.

[ ... ]

> +static int trace_wprobe_show(struct seq_file *m, struct dyn_event *ev)
> +{
> +	struct trace_wprobe *tw =3D to_trace_wprobe(ev);
> +	int i;
> +
> +	seq_printf(m, "w:%s/%s", trace_probe_group_name(&tw->tp),
> +		   trace_probe_name(&tw->tp));
> +
> +	char type_char;
> +
> +	if (tw->type =3D=3D HW_BREAKPOINT_R)
> +		type_char =3D 'r';
> +	else if (tw->type =3D=3D HW_BREAKPOINT_W)
> +		type_char =3D 'w';
> +	else
> +		type_char =3D 'x'; /* Should be rw */

[Severity: High]
Will outputting 'x' for HW_BREAKPOINT_RW cause parse_address_spec() to
reject the configuration upon restore?

If type_char is set to 'x', the formatted string saved to dynamic_events
will be invalid. When the system attempts to restore the event across
reboots, parse_address_spec() checks strictly for 'r', 'w', or 'rw', and
will fail with -EINVAL for 'x'.

Should this be adjusted to output a string like "rw" instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178407983818.95826.=
12714571928538799781.stgit@devnote2?part=3D1
