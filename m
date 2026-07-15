Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC4C37B016
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 01:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080662; cv=none; b=mpUUcXpMXG9/+Ce0m62B221ZIK5TAOmqypw2mb7ZyXA/gxsFPQpZoTie4Gj0WqYM++juJYHkr6aQu5qu+ORzuDXPdPWW07Hh6eMUBCGtvyFEHcJEQnBBiz3NFlsROV2ZeYu/qAXOjCwweD6hCRfstlLxFBXoIGkeU6rCncysmdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080662; c=relaxed/simple;
	bh=b9VsnIHw2u8TyZeCOYtYwlHNrbIHA5NX190PXPQTbwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r+qP3/orxqQrjIGhcoX5Zi45HWZdjMxkuJOhkWZIDanjcxwjXwmhH6SoKMoVxSbjze9amD39cLtISC/32IAuVS3Y8bHIv7VPVhW/ZLEQdJwFMohn0HWfkZp2fF8VEbhnyqDBQEnx2cB1NZJNzZUkqJYPubQhei4LxIdJ5AEGDvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klYV/PFb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klYV/PFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1394D1F000E9;
	Wed, 15 Jul 2026 01:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784080661;
	bh=89qXhHnj7Cwy8Aywty1/SuE74x7Esy5dk41j+BIDOIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=klYV/PFbe84ETzSzqraxJXbQdAd423ycm1izOYvcgYeUOCE0hez7/iFmff8oVdKp+
	 EK0WLzoDqdPvNE4az6kuolgF6zU7EnMECi04J1ZmwlElmGHtBD9lme2x3sv5//KBG6
	 Y9vLGDeIn10IsoikiU9G4vI9S/ZPgeLJLeovhquQzz6Rr1TTuKw1xAHTLY0vhHFsCB
	 aCD1NOrsZuQEM9+IVcu4/zS8t30RO5eQAQBFJB2am+Ey9cTfg3FnfXg+iJbYitVIpl
	 9cvwUaZ0goDcmTQcyD0bhZu1+ogWJaEoOqz5C5wzj8hEnDjcp0D2ao5hwzaYiXFuKu
	 NvLkM0Mm62aEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/10] x86: hw_breakpoint: Add a kconfig to clarify
 when a breakpoint fires
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178407986179.95826.1630626264869856006.stgit@devnote2>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
 <178407986179.95826.1630626264869856006.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 01:57:40 +0000
Message-Id: <20260715015741.1394D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Memory leak of the `symbol` string in `__trace_wprobe_create()`.
- [Medium] `enable_trace_wprobe()` fails to rollback trace probe state on h=
ardware breakpoint registration error, leading to state inconsistency and s=
ilent tracing failures.
--

--- Patch [2]: [PATCH v7 02/10] x86: hw_breakpoint: Add a kconfig to clarif=
y when a breakpoint fires ---
commit f8a7aeb231575f15f9227ab411134bde7408e480
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing: wprobe: Add watchpoint probe event based on hardware breakpoint

Add a new probe event for the hardware breakpoint called wprobe-event.
This wprobe allows user to trace (watch) the memory access at the
specified memory address. The events can be defined via the dynamic_events
interface file.

Link: https://lore.kernel.org/all/175859021100.374439.8723137923620348816.s=
tgit@devnote2/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> new file mode 100644
> index 0000000000000..b52f3eac719f9
> --- /dev/null
> +++ b/kernel/trace/trace_wprobe.c
> @@ -0,0 +1,692 @@

[ ... ]

> +static int enable_trace_wprobe(struct trace_event_call *call,
> +			       struct trace_event_file *file)
> +{
> +	struct trace_probe *tp;
> +	struct trace_wprobe *tw;
> +	bool enabled;
> +	int ret =3D 0;
> +
> +	tp =3D trace_probe_primary_from_call(call);
> +	if (WARN_ON_ONCE(!tp))
> +		return -ENODEV;
> +	enabled =3D trace_probe_is_enabled(tp);
> +
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

[Severity: Medium]
Will this leave the trace probe state inconsistent if hardware breakpoint
registration fails?

Earlier in enable_trace_wprobe(), trace_probe_add_file() or
trace_probe_set_flag() modify the probe state. If __register_trace_wprobe()
returns an error, the function returns immediately without rolling back tho=
se
changes.

Could this cause subsequent enable attempts to skip registration entirely a=
nd
silently fail to trace?

> +			}
> +		}
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int __trace_wprobe_create(int argc, const char *argv[])
> +{
> +	/*
> +	 * Argument syntax:
> +	 *  b[:[GRP/][EVENT]] SPEC
> +	 *
> +	 * SPEC:
> +	 *  [r|w|rw]@[ADDR|SYMBOL[+OFFS]][:LEN]
> +	 */
> +	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) =
=3D NULL;
> +	struct trace_wprobe *tw __free(free_trace_wprobe) =3D NULL;
> +	const char *event =3D NULL, *group =3D WPROBE_EVENT_SYSTEM;
> +	const char *tplog __free(trace_probe_log_clear) =3D NULL;
> +	char *symbol =3D NULL;
> +	unsigned long addr;
> +	int len, type, i;
> +	int ret =3D 0;
> +
> +	if (argv[0][0] !=3D 'w')
> +		return -ECANCELED;
> +
> +	if (argc < 2)
> +		return -EINVAL;
> +
> +	tplog =3D trace_probe_log_init("wprobe", argc, argv);
> +
> +	if (argv[0][1] !=3D '\0') {
> +		if (argv[0][1] !=3D ':') {
> +			trace_probe_log_set_index(0);
> +			trace_probe_log_err(1, BAD_MAXACT_TYPE);
> +			/* Invalid format */
> +			return -EINVAL;
> +		}
> +		event =3D &argv[0][2];
> +	}
> +
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
Does this code leak the symbol string?

When a wprobe event is created using a symbol name, parse_address_spec()
allocates a string for symbol. This string is then passed to
alloc_trace_wprobe() which duplicates it again using kstrdup().

However, the original symbol pointer does not appear to be freed before
__trace_wprobe_create() returns. Should symbol be annotated with __free(kfr=
ee)
or explicitly freed?

> +
> +	ctx =3D kzalloc_obj(*ctx);
> +	if (!ctx)
> +		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178407983818.95826.=
12714571928538799781.stgit@devnote2?part=3D2
