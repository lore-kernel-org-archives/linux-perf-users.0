Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70663B14B1
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118082; cv=none; b=snu/fYNcJOEFl38H8sJ35zrvxLE2h/FJQ83UUIvNXp+Z0LZHTgduR4ZL8bp7t/z0a1Y0ESfkJDgrzfd5ZEzvMK8Rei9GQw5jA1UCqbMTAK/SQTZjylNx2JrQAgPq+A8Ve/1tEVJ6ajbILk5VmJuWBfMfkDqgXEMjYRWDiZrwaCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118082; c=relaxed/simple;
	bh=JcTI9A3MkBxieS7TBMH9y6IGivF31ev+Pa+2yTDrEcY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kbUwKWr3el/Jm3hQ1WK/Ys/EbQzN/uyd8VZ8i+DMgBHcYtgwshNOKd5ndczdMnpiJ47WuyA2F/o0364yhryMxB12Pbf0033l3YGWdW83whWHpmhGdMaHDmQ3BLazu/+607meYXdn3uNJiHXXqm0nGjrbT3aTnNybWeQWbw8BiqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFhFG2f4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFhFG2f4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C461F000E9;
	Fri,  7 Aug 2026 15:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118080;
	bh=BvOpO7cIgK0Yc5yTeuVAe9YPaCDwulEOHGeDp9vSBAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YFhFG2f4wG8YINBLMEzTsOX4hzBkcLhKkKCgYAZLoamUSvgR/tKaMky8mCpN+wnHh
	 mg5k+q9RKVpoWGB4KFm9mLTOEj2F02I3wdRJrBdRZDn1ITm0nHRfq+esEwnxk1urU6
	 BkaqniZMSwSv74gDurjwnfUplpYCAb066Xyd2MJvqqiuBPoCQ0gr8Io6skOMvW+7a7
	 DqZ5RzXvkN60fImelqxyPOyxELT47Z1iLlsaICx2N4tJZrPLFGY+EuBDsAuS7YwVsh
	 +050kHi3n0C4cYnXyqPr6zxqkz2GppmlbNfTCEkjEiV0HCoSDe0yTGtmqt3u09skdt
	 +cuP5tRNboIfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 08/11] tracing/wprobe: Add set_wprobe and
 clear_wprobe event triggers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178611688737.237811.17143803996766057381.stgit@devnote2>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
 <178611688737.237811.17143803996766057381.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:54:39 +0000
Message-Id: <20260807155440.66C461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Mixing scope-based cleanup (`__free()`) with explicit resource man=
agement causes double-frees and memory leaks.
- [High] Hardware breakpoint fallback address spans adjacent kernel variabl=
es, causing NMI storms.
- [High] Double initialization of the event trigger reference count causes =
unconditional memory leaks.
- [Medium] Trigger `count` is double-decremented, breaking the `:count=3D1`=
 feature.
- [Medium] The `clear_wprobe` trigger fails to parse its documented optiona=
l FIELD parameter.
--

--- Patch [8]: [PATCH v12 08/11] tracing/wprobe: Add set_wprobe and clear_w=
probe event triggers ---
commit cb59d7e61a8c78c308ca9ae32e1de403900f7a05
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Subject: tracing/wprobe: Add set_wprobe and clear_wprobe event triggers

This commit adds set_wprobe and clear_wprobe event triggers to dynamically
attach and detach hardware breakpoint address monitoring based on event fie=
ld
contents.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c

[ ... ]

> +static int wprobe_trigger_global_enabled;
> +
> +#define SET_WPROBE_STR		"set_wprobe"
> +#define CLEAR_WPROBE_STR	"clear_wprobe"
> +#define WPROBE_DEFAULT_CLEAR_ADDRESS ((unsigned long)&wprobe_trigger_glo=
bal_enabled)

[Severity: High]
Will this 4-byte fallback variable safely accommodate 8-byte hardware
breakpoints?=20

When a wprobe is temporarily disabled, its hardware breakpoint is pointed h=
ere
at WPROBE_DEFAULT_CLEAR_ADDRESS, but it retains its configured length (e.g.=
, 8
bytes for a 64-bit pointer).=20

Could this cause the breakpoint to monitor the 4-byte variable plus 4 adjac=
ent
bytes in the .bss section, potentially triggering NMI storms if a frequently
accessed kernel variable happens to reside in those adjacent bytes?

[ ... ]

> +static void wprobe_trigger(struct event_trigger_data *data,
> +			   struct trace_buffer *buffer,  void *rec,
> +			   struct ring_buffer_event *event)
> +{
[ ... ]
> +	/* count < 0 means endless, 0 means trigger count exhausted */
> +	if (!data->count)
> +		goto out;
[ ... ]
> +	if (changed) {
> +		if (data->count > 0)
> +			data->count--;

[ ... ]

> +static struct event_command trigger_wprobe_set_cmd =3D {
> +	.name			=3D SET_WPROBE_STR,
[ ... ]
> +	.trigger		=3D wprobe_trigger,
> +	.count_func		=3D event_trigger_count,

[Severity: Medium]
Does this manual decrement in wprobe_trigger() conflict with the core
event_trigger_count decrement function?=20

The trigger commands are assigned .count_func =3D event_trigger_count, which
unconditionally executes before the main .trigger callback and pre-decremen=
ts
the count.=20

If a user specifies :count=3D1, the core framework reduces it to 0.=20
wprobe_trigger() will then see a count of 0 and abort immediately. Does this
render a single-count trigger completely non-functional?

[ ... ]

> +static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
> +				    struct trace_event_file *file,
> +				    char *glob, char *cmd,
> +				    char *param_and_filter)
> +{
> +	/*
> +	 * set_wprobe:EVENT:FIELD[+OFFS]
> +	 * clear_wprobe:EVENT[:FIELD[+OFFS]]
> +	 */
> +	struct wprobe_trigger_data *wprobe_data __free(free_wprobe_trigger_data=
) =3D NULL;
> +	struct event_trigger_data *trigger_data __free(kfree) =3D NULL;

[ ... ]

> +	/* clear_wprobe does not need field. */
> +	if (!clear) {
> +		char *offs;

[Severity: Medium]
Does skipping the field parsing here break the documented optional FIELD
parameter for clear_wprobe?=20

The documentation claims clear_wprobe:WPEVENT[:FIELD] conditionally clears a
watchpoint, but if clear is true, the parsing code skips extracting the fie=
ld
string.=20

It looks like the unparsed string is then passed to event_trigger_parse_num=
(),
which expects a numeric string and fails with -EINVAL.

[ ... ]

> +	ret =3D event_trigger_parse_num(param, trigger_data);
> +	if (ret) {
> +		wprobe_trigger_log_err(file, glob, param - glob, BAD_IMM);
> +		return ret;
> +	}

[Severity: High]
Can this early error path leak memory?=20

The trigger_data uses __free(kfree), which performs a shallow free. If
event_trigger_parse_num() fails and returns early, does this permanently le=
ak
internal allocations like data->name?

[ ... ]

> +	event_trigger_init(trigger_data);
> +
> +	ret =3D event_trigger_register(cmd_ops, file, glob, trigger_data);

[Severity: High]
Will this result in a double initialization of the reference count?=20

We call event_trigger_init(trigger_data) explicitly here, which increments =
the
reference count. Then event_trigger_register() calls the .reg callback
wprobe_register_trigger(), which executes data->cmd_ops->init(data) and
increments the reference count a second time.=20

When the trigger is later unregistered, wprobe_trigger_free() decrements the
count by only 1, leaving a permanent reference and memory leak.

> +	if (ret) {
> +		event_trigger_reset_filter(cmd_ops, trigger_data);
> +		trace_event_enable_disable(wprobe_file, 0, 1);
> +		trace_event_put_ref(wprobe_file->event_call);
> +		tracepoint_synchronize_unregister();
> +		event_trigger_free(trigger_data);
> +		return ret;
> +	}

[Severity: High]
Can this late error path cause a double-free?=20

Both trigger_data and wprobe_data are declared with scope-based cleanup
(__free). If event_trigger_register() fails, the code manually calls
event_trigger_free(trigger_data), freeing both objects.=20

When the function returns, the __free macros will execute and attempt to fr=
ee
them a second time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178611679753.237811=
.10190793347982785419.stgit@devnote2?part=3D8
