Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACFA23D283
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784171640; cv=none; b=J4ks7OD/FXSYnpB9DlHdqK6F00HFJ/U2eY+tKutPrQt0XeaJ2PyE1hQd35Wjv97tJr0ePyNa3jRcGLPo6Ihw1bDGF9wCSbZcPZavi10LGonqa4ma7N72mxsOSu+cwU9DuacjLyy78MVMmPv8BJoXZdgCBVdOgCvsbTJAi4EX1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784171640; c=relaxed/simple;
	bh=QTza/p4FwGYJEfSkIqYcbkM53qia9XHbc7xdBB5cF4A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AAvlD1P2iK2ycHqq6RL1zgjiglEs3+8j5yIjmOghG0g/f5tTP5p7AVOpduqGQtetd8D8LMz6JgfkNPmi75nLe3ZdiG8FX8TOg445yIoW3rhftf9HsLVaYT2BqWNa/phCDrBAnwKPFeZMQgvHLZa/y4w8HT0nF5YDBnHqur3B3FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNrtojFo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNrtojFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F821F000E9;
	Thu, 16 Jul 2026 03:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784171638;
	bh=q1Olq+3sJhJcUnmlaY5ijojNUBH0X5deKaprGBmax4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BNrtojFo02HzLNe+1aQINJORHtVeHF0qIr8Lcjem/Hx5UuxsQjXtDl0oDx6yiebx7
	 IQhte68EdpQ5gUmuEVR6avJkYqLLn8w6YkL2g6+a3fABujT4o/9ATM9zjHwgjviRn+
	 TW7CB+c4vMaw2pwIHobH4WktA+WUkr6RR227Oj3y+V5nn/XfCdGMRUlSuX3VAIVfpt
	 /P02wWrzQFqtIne1MaW+a1FEamyX0HXS8mL9p6JOufCysY/5z7/mxc26xqyOYDY5MF
	 jdPo+kdkj8L41oZlv89XNAOvmP0UbdB+k8+22AswKO929poLWZPDHiQInS+uUIVXeU
	 HdyBLgaReiw0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/9] tracing: wprobe: Add watchpoint probe event
 based on hardware breakpoint
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178417034282.209165.5714719704203351616.stgit@devnote2>
References: <178417033089.209165.16717079876036408877.stgit@devnote2>
 <178417034282.209165.5714719704203351616.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:13:58 +0000
Message-Id: <20260716031358.90F821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Missing traceprobe_update_arg() call leaves @SYM fetch arguments u=
nresolved, causing reads from address 0.
- [Medium] Sibling probe support is broken by a hardcoded uniqueness check,=
 rendering the new rollback logic as dead code and limiting functionality.
- [Medium] The implementation fails to dynamically generate a unique event =
name for anonymous address-based watchpoints, contradicting the documentati=
on.
- [Medium] Missing group and event name parsing allows invalid characters a=
nd breaks tracefs directory creation.
--

--- Patch [1]: [PATCH v8 1/9] tracing: wprobe: Add watchpoint probe event b=
ased on hardware breakpoint ---
commit c7cef5689391cf83a545269b44666666b82afb31
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing: wprobe: Add watchpoint probe event based on hardware breakpoint

This commit adds a new wprobe-event for hardware breakpoints, allowing
users to trace memory accesses at specific addresses. It supports fetching
the accessed address and value, and can be configured via the dynamic_events
interface.

diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
new file mode 100644
--- /dev/null
+++ b/kernel/trace/trace_wprobe.c
[ ... ]
> static int register_trace_wprobe_event(struct trace_wprobe *tw)
> {
> 	struct trace_wprobe *old_tb;
> 	int ret;
>=20
> 	guard(mutex)(&event_mutex);
>=20
> 	old_tb =3D find_trace_wprobe(trace_probe_name(&tw->tp),
> 				   trace_probe_group_name(&tw->tp));
> 	if (old_tb)
> 		return -EBUSY;

[Severity: Medium]
Does this uniqueness check inadvertently break sibling probe support?

The commit message mentions rollback logic for already-enabled sibling
probes, but returning -EBUSY here unconditionally rejects adding a wprobe
to an existing event name.=20

Shouldn't this call trace_probe_append() for existing events similar to how
kprobes and fprobes handle them, instead of returning -EBUSY?

[ ... ]
> static int __trace_wprobe_create(int argc, const char *argv[])
> {
[ ... ]
> 	if (argv[0][1] !=3D '\0') {
> 		if (argv[0][1] !=3D ':') {
> 			trace_probe_log_set_index(0);
> 			trace_probe_log_err(1, BAD_MAXACT_TYPE);
> 			/* Invalid format */
> 			return -EINVAL;
> 		}
> 		event =3D &argv[0][2];
> 	}

[Severity: Medium]
Is this missing a call to traceprobe_parse_event_name()?

By assigning the remainder of the command directly to the event name, it
bypasses separating the group from the event and checking against
is_good_name().

If a user provides a group like w:mygroup/myevent, could this cause tracefs
directory creation to fail or create a malformed structure?

>=20
> 	trace_probe_log_set_index(1);
> 	ret =3D parse_address_spec(argv[1], &addr, &type, &len, &symbol);
> 	if (ret < 0)
> 		return ret;
>=20
> 	if (!event)
> 		event =3D symbol ? symbol : "wprobe";

[Severity: Medium]
If multiple anonymous address-based watchpoints are created without a symbol
(for example, w@0x12345678 and w@0xcafebabe), won't they all be assigned
the hardcoded wprobe name?

Does this need to dynamically generate a unique name based on the address
(perhaps similar to what kprobes does with snprintf) to avoid naming
collisions?

>=20
> 	argc -=3D 2; argv +=3D 2;
> 	tw =3D alloc_trace_wprobe(group, event, symbol, addr, len, type, argc);
> 	if (IS_ERR(tw))
> 		return PTR_ERR(tw);
>=20
> 	ctx =3D kzalloc_obj(*ctx);
> 	if (!ctx)
> 		return -ENOMEM;
>=20
> 	ctx->flags =3D TPARG_FL_KERNEL | TPARG_FL_WPROBE;
>=20
> 	/* parse arguments */
> 	for (i =3D 0; i < argc; i++) {
> 		trace_probe_log_set_index(i + 2);
> 		ctx->offset =3D 0;
> 		ret =3D traceprobe_parse_probe_arg(&tw->tp, i, argv[i], ctx);
> 		if (ret)
> 			return ret;	/* This can be -ENOMEM */
> 	}

[Severity: High]
Does this argument parsing loop need to call traceprobe_update_arg() to
resolve symbol references?

If a user registers a wprobe event with a symbol fetch argument like
@my_symbol, the parser generates a FETCH_NOP_SYMBOL instruction. Without
calling traceprobe_update_arg(&tw->tp.args[i]), the fetch instruction's
immediate address remains 0.

Won't this cause the probe to silently fail by attempting to read from
address 0 at runtime?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178417033089.209165=
.16717079876036408877.stgit@devnote2?part=3D1
