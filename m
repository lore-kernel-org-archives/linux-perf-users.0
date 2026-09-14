Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04FF30C632;
	Mon, 14 Sep 2026 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397927; cv=none; b=nheoTB5owEQSAHOzC/OQd/hW8U+eloFqGNNd8rq5gD1Xmj8EKtOJ+Pkin5rloQMlg4vq1nu2UqGDzw5BdUOFUVODRt4eBz7MmXg0rDSr6ne9jm/3y6wWunqUub1A8YWJ4Xr5cJsHllhLUVTEmUi+2cmUKEiXrpu0fw4yzV+NHLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397927; c=relaxed/simple;
	bh=FbELH71esAO0fQJSHCq8pF01QMgtk57LcUPkKAPtk4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rk1/3FhMAF9mFcb1fLspSIipbFl2xuPl7/eJyVzTY8LBGQiP8iQXBtswovMPDLUpXK/OP9Vp77IuRwOJInlhpAEAzAUHTChdeEystetC8b7irEswu19SxqhwS8IwtIhNm9+tEjDWP6qQYL6S74iP9ph2IEKi1ocf+64Bfz2T2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpANku1s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpANku1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9D21F000FF;
	Mon, 14 Sep 2026 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397925;
	bh=Dpe1tP2ZJwNqlNVNVv8SYgVA9M/PRiFAvZUXoVKVbBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QpANku1sTrGa9fapooEe4zaHSAvVQMXFF2PVvMrPGps+jgwknvrXV/ksvBhp8xv4+
	 a3v3YFYt0G9ChrbRYNepI4smkdRQ7TDPAqQHfmGBIlrqrPR3nzOw3Dkn248bVg8TZ5
	 j/u1cKMtZqhbO7Pwl06M13uc+RN3ZNDK08j6BqVtxcb/b3hqhh/3BB7C1+NCe5Wdgt
	 s1X/YiNgS1+zHlMhZNE6r79kYQaBg7TVzLNa9mIQvj7lnLcL7YzWwBJmMzt48HcSJW
	 jmr3jsBED0oRWuE0F8wWibJFZdxaKwFrnoSKMS0mXrvLXgcjgSyWt0zJX0+5dRRTMd
	 r/WqpvsvN62qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 10/13] tracing/wprobe: Add set_wprobe and
 clear_wprobe event triggers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <178939029574.94750.11636803595861231046.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
 <178939029574.94750.11636803595861231046.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:58:44 +0000
Message-Id: <20260914145845.1D9D21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Missing RCU synchronization in the error path of wprobe trigger re=
gistration leads to a Use-After-Free of hardware breakpoint perf_event stru=
ctures.
- [High] Hardware breakpoint addresses are not updated for offline CPUs, le=
ading to stale addresses when CPUs come online.
- [Medium] The 'count' parameter is decremented on trigger evaluation misse=
s, causing the trigger to exhaust its count without actually modifying the =
watchpoint.
- [Medium] The wprobe event permanently leaks as enabled when the trigger i=
s unregistered because `EVENT_FILE_FL_SOFT_DISABLED_BIT` is manually cleare=
d.
- [Low] A field named 'unlimited' is silently ignored by `clear_wprobe` if =
no count keyword is provided.
--

commit 146ca411781d7203b266aa3745d30641c87b97d2
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/wprobe: Add set_wprobe and clear_wprobe event triggers

Add set_wprobe and clear_wprobe event triggers to dynamically attach
and detach hardware breakpoint address monitoring based on event field
contents.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index 9c6100b63e8d9..55a201504bb0b 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c

[ ... ]

> @@ -231,6 +303,12 @@ static struct trace_wprobe *alloc_trace_wprobe(const=
 char *group,
>=20
> +static void wprobe_work_func(struct work_struct *work)
> +{
> +	struct trace_wprobe *tw =3D container_of(work, struct trace_wprobe, wor=
k);
> +
> +	on_each_cpu(wprobe_smp_update_func, tw, true);

[Severity: High]
Could this leave hardware breakpoints with stale addresses on offline CPUs?

on_each_cpu() only broadcasts to currently online CPUs, so offline CPUs
won't execute trace_wprobe_update_local(). When an offline CPU comes
online, won't the perf event core reinstall the hardware breakpoint using
the old, stale address since it wasn't updated here?

[ ... ]

> @@ -773,3 +866,538 @@ static __init int init_wprobe_trace(void)

[ ... ]

> +static void wprobe_trigger(struct event_trigger_data *data,
> +			   struct trace_buffer *buffer,  void *rec,
> +			   struct ring_buffer_event *event)
> +{
> +	struct wprobe_trigger_data *wprobe_data =3D data->private_data;
> +	struct trace_wprobe *tw =3D wprobe_data->tw;
> +	unsigned long addr =3D 0, flags;
> +	bool changed =3D false;

[ ... ]

> +	raw_spin_lock_irqsave(&tw->lock, flags);
> +
> +	if (!wprobe_data->clear) {
> +		if (!trace_wprobe_is_valid_addr(addr, tw->len)) {
> +			atomic_inc(&tw->missed);
> +			goto out;
> +		}
> +		if (tw->addr =3D=3D WPROBE_DEFAULT_CLEAR_ADDRESS) {
> +			/* Skip if a previous work is still propagating the address */
> +			if (atomic_read(&tw->work_pending)) {
> +				atomic_inc(&tw->missed);
> +				goto out;
> +			}
> +			WRITE_ONCE(tw->addr, addr);
> +			changed =3D true;
> +			clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &wprobe_data->file->flags);

[Severity: Medium]
Does manually clearing EVENT_FILE_FL_SOFT_DISABLED_BIT cause the event to l=
eak
as enabled?

When the trigger is unregistered, wprobe_trigger_free() calls
trace_event_enable_disable(file, 0, 1). Because the soft-disabled bit was
cleared here, won't the core event logic skip the unregister step, leaving
the wprobe tracepoint permanently enabled in the kernel?

[ ... ]

> +static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
> +				    struct trace_event_file *file,
> +				    char *glob, char *cmd,
> +				    char *param_and_filter)
> +{

[ ... ]

> +	} else if (param && (isalpha(param[0]) || param[0] =3D=3D '_')) {
> +		if (strncmp(param, "count=3D", 6) !=3D 0 &&
> +		    strcmp(param, "unlimited") !=3D 0) {

[Severity: Low]
Is this intended to skip fields named "unlimited"?

If a user configures a clear_wprobe trigger on an event that happens to have
a field named "unlimited", this parser matches the keyword and skips parsing
it as a field, which defaults to an unconditional clear action.

[ ... ]

> +static int wprobe_register_trigger(char *glob,
> +				   struct event_trigger_data *data,
> +				   struct trace_event_file *file)
> +{
> +	int ret =3D 0;
> +
> +	lockdep_assert_held(&event_mutex);
> +
> +	/* The same wprobe is not accept on the same file (event) */
> +	if (wprobe_trigger_find_same(data, file))
> +		return -EEXIST;
> +
> +	if (data->cmd_ops->init) {
> +		ret =3D data->cmd_ops->init(data);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	list_add_rcu(&data->list, &file->triggers);
> +
> +	update_cond_flag(file);
> +	ret =3D trace_event_trigger_enable_disable(file, 1);
> +	if (ret < 0) {
> +		list_del_rcu(&data->list);
> +		update_cond_flag(file);
> +		if (data->cmd_ops->free)
> +			data->cmd_ops->free(data);
> +	}

[Severity: High]
Does this error path need RCU synchronization?

If trace_event_trigger_enable_disable() fails, list_del_rcu() is called
without a subsequent synchronize_rcu(). The cmd_ops->free callback
(wprobe_trigger_free) will then synchronously disable the wprobe, which
frees the tw->bp_event array.

Could a concurrent tracepoint reader still observe the trigger data,
execute wprobe_trigger(), and dereference the freed tw->bp_event via
this_cpu_ptr() inside trace_wprobe_update_local()?

[ ... ]

> +static struct event_command trigger_wprobe_set_cmd =3D {
> +	.name			=3D SET_WPROBE_STR,
> +	.trigger_type		=3D ETT_EVENT_WPROBE,
> +	/* This triggers after when the event is recorded. */
> +	.flags			=3D EVENT_CMD_FL_NEEDS_REC,
> +	.parse			=3D wprobe_trigger_cmd_parse,
> +	.reg			=3D wprobe_register_trigger,
> +	.unreg			=3D wprobe_unregister_trigger,
> +	.set_filter		=3D set_trigger_filter,
> +	.trigger		=3D wprobe_trigger,
> +	.count_func		=3D event_trigger_count,

[Severity: Medium]
Will this unconditionally exhaust the trigger's count parameter even on mis=
ses?

Because .count_func is set to event_trigger_count, the count is decremented
before wprobe_trigger() runs. If the trigger fails its implicit checks insi=
de
wprobe_trigger() (such as checking if the field matches the watched address=
),
the count has already been consumed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178939017565.94750.=
9431053336761330458.stgit@devnote2?part=3D10
