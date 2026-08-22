Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890113BAD9B;
	Sat, 22 Aug 2026 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787391739; cv=none; b=K8C9woztPa5aS1dzi6E5S2GAXlrZruHOsp11sFv/m7enhqIlEocbmg4tsbtp8TO843UkrNL43vSE9C8vTpKFUISGjDLLu8RluCZRmWqSyZdUG6U3zSOg9v1ilEfz0jHC+Qjd+NWNWVPpaQvNA1vjTtYtCBTJNWYL6aC7pzjjZtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787391739; c=relaxed/simple;
	bh=zOhtWSV6G1UH9BHtX+1dKyQazfBA0CyP5pOvE9FPgBA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oe95Gqil5KeA9jFCzUEk8wr4o6t7RggqNg0vcqix3PCGLYyt1LNBGlW0gncoAIajig0HfXYTm5iML2Q6eqW5OEvNIuFFeADzrySDR4+TksAro/w1pE8sAkiJAoehDUkCdDyYmOKbgLYfaDH5IDmI5h5bwufImxFlvlNhkuiiVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpkGitHw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpkGitHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4491F000E9;
	Sat, 22 Aug 2026 09:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787391738;
	bh=MxFp+i6yA4R1eaGXAxdupbju7yBi0GNzU+jZYYfQyN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YpkGitHwh9Bhvd095U84a6dpr0NV6jLodgujMuj5wHxTR4K9GlY6SF4YyYfym9sV0
	 QqEMaSvv8f3cD15UCKAQbOQ6NlU1GLIv14unA3kPW0qsyll4nOEV20dgvKusd6Qr8f
	 ALY6izNM4SrdUPSPGhewyeE1K6Ww5oxdyxdV9sG7nCsaP2PWh7wH4XKmiOHwen1XVh
	 io7aNuq0wJAAFfgtuUXt9EwrMUiY6SZB9S4psdqWW+THQnA0RvFUH4SfMgQ7k2DnsJ
	 cbNAA9GHMtbm8QISjEbif86pqV0ob2yLcgXAXF7zoXGm8bhOLYYul0x6YCIvu88pa/
	 lBNk634Z2xVmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 09/12] tracing/wprobe: Add set_wprobe and
 clear_wprobe event triggers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178739069325.1520941.16954545333706545613.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
 <178739069325.1520941.16954545333706545613.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:42:17 +0000
Message-Id: <20260822094218.0C4491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Leaked `trigger_data` and `wprobe_data` when trigger registratio=
n fails due to unbalanced reference counts.
- [Medium] Hardware breakpoints are inadvertently left monitoring the initi=
al wprobe address (unparked) instead of the parked dummy address upon enabl=
ement.
- [Low] The `clear_wprobe` trigger cannot be removed by echoing its exact p=
rinted output if a trigger count is specified.
--

--- Patch [9]: [PATCH v13 09/12] tracing/wprobe: Add set_wprobe and clear_w=
probe event triggers ---
commit e794ff7412c73348b335e9a50aceecbbd82d9a0c
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/wprobe: Add set_wprobe and clear_wprobe event triggers

Add set_wprobe and clear_wprobe event triggers to dynamically attach
and detach hardware breakpoint address monitoring based on event field
contents.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index a8543766a245b..acb15fd018e80 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c

[ ... ]

> @@ -756,3 +827,501 @@ static __init int init_wprobe_trace(void)

[ ... ]

> +static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
> +				    struct trace_event_file *file,
> +				    char *glob, char *cmd,
> +				    char *param_and_filter)
> +{

[ ... ]

> +	} else if (param && (isalpha(param[0]) || param[0] =3D=3D '_')) {
> +		char *offs;
> +
> +		field_str =3D strsep(&param, ":");

[Severity: Low]
Does this code prevent removing the clear_wprobe trigger if it has a count
but no field?

If the user sets a count on a clear_wprobe trigger, wprobe_trigger_print()
outputs the trigger as ending with ":count=3DN". When attempting to remove =
it
by writing the exact string prepended with '!', this parser checks if the
parameter starts with a letter.

Since "count=3DN" starts with a letter ('c'), it treats it as an event field
name, and fails with -ENOENT in wprobe_trigger_field_parse(), preventing the
trigger from being unregistered.

[ ... ]

> +	/* Soft-enable (register) wprobe event on WPROBE_DEFAULT_CLEAR_ADDRESS =
*/
> +	if (!trace_event_try_get_ref(wprobe_file->event_call)) {
> +		ret =3D -ENODEV;
> +		goto out_free_trigger;
> +	}
> +
> +	ret =3D trace_event_enable_disable(wprobe_file, 1, 1);
> +	if (ret < 0)
> +		goto out_put;
> +
> +	if (!clear)
> +		WRITE_ONCE(tw->addr, WPROBE_DEFAULT_CLEAR_ADDRESS);

[Severity: Medium]
Should we update the target address before soft-enabling the event?

The documentation suggests initializing a new wprobe at address 0 and keepi=
ng
it disabled. When we call trace_event_enable_disable(wprobe_file, 1, 1) her=
e,
it installs hardware breakpoints monitoring the current address (e.g., 0).

The parked dummy address WPROBE_DEFAULT_CLEAR_ADDRESS is only assigned to
tw->addr afterwards, which means the hardware breakpoints are left actively
monitoring address 0 and could generate spurious debug exceptions.

[ ... ]

> +out_disable:
> +	trace_event_enable_disable(wprobe_file, 0, 1);
> +out_put:
> +	trace_event_put_ref(wprobe_file->event_call);
> +out_free_trigger:
> +	event_trigger_reset_filter(cmd_ops, trigger_data);
> +	event_trigger_free(trigger_data);
> +	return ret;

[Severity: Medium]
Can this leak trigger_data and wprobe_data on the error path?

When wprobe_trigger_cmd_parse() executes, it increments the trigger_data
refcount to 1 via event_trigger_init().

It then calls event_trigger_register() which calls wprobe_register_trigger()
and increments the refcount to 2 via data->cmd_ops->init(data).

If trace_event_trigger_enable_disable() fails inside wprobe_register_trigge=
r(),
it returns an error without balancing the reference count:

kernel/trace/trace_wprobe.c:wprobe_register_trigger() {
	...
	ret =3D trace_event_trigger_enable_disable(file, 1);
	if (ret < 0) {
		list_del_rcu(&data->list);
		update_cond_flag(file);
	}
	return ret;
}

The error path here then calls event_trigger_free(trigger_data), which only
decrements the refcount from 2 to 1 and skips freeing the objects.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178739053919.152094=
1.17662338993878200834.stgit@devnote2?part=3D9
