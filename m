Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897D35CB60
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118356; cv=none; b=ZZlTGbRk3fNnddNOgkF0n87QbQp4g68L+xCU2tfoIMY3jggk3MALJPcB8ZgXR3NmSW8EhjLZ2/gA70KF2450+LKhRtecclRXiy/Ic5UjWMPiRKq/8jPZwFk13JHHFK/MgiXFi86saZaXebImFO/efb5anAOwatzZ6XCQYVUFyHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118356; c=relaxed/simple;
	bh=Mx3kTAG1T6s3v3xBtNHDSghrG8kVMKdhwD1Sx6WBnVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f24yKNLnLtXHPOpOAzvhEU02fNfFezxR+3SWUMB5wStbLCY3ic5lW952NFf79y4zlp9aHyTRMmetbsmxTXaiacRZWseyxwrSTF8rY6Z0cEPykd8pnRqK0mn+it1cq/pCeBqgKoYAVJKrsVSMUFLeZS8pSvu/BLo6eMACIQALhBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBro+okg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBro+okg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAD21F000E9;
	Fri,  7 Aug 2026 15:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118355;
	bh=tbOhJd5HqJGXpSOUBm54JYpgYsv3RQF/fGa8uO29eEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jBro+okgwknl8Fwcz4SE59Mu+zu3A/wdMwsU5k5L+WRBAwBAVCS+njm6oYkyJVjAz
	 nLk9H0eGqjVHhXN1onxub3AUyWEaUyzkdmyipE4V+Qza/w/jncsZE2Rql/eAubo2IV
	 nwehgh/vaPNgwhCOCB9Yl1MH2TIK8tIrzFMH8IED8esuS2VJ+Rd6eClhP9/w19E19v
	 +UjFrsKjKyrgGH1hqrQFi8lKXuSbqWuVasOkacACeYFSL4vi1F1MUAVxTnNGnF6rg0
	 x8aunQMakHb7WnfnRwHvJsh+xDBVBj3/VUG1N0wQ4ttn3xG6WuvN3Sxagg8V8LmhRj
	 RukMUHg1Gk0wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 04/11] tracing/wprobe: Add wprobe (watchpoint probe)
 trace event support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178611684231.237811.7919346786503289720.stgit@devnote2>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
 <178611684231.237811.7919346786503289720.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:59:14 +0000
Message-Id: <20260807155914.DDAD21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardware breakpoints are not synchronized with module unloads, l=
eading to dangling breakpoints on reallocated memory.
--

--- Patch [4]: [PATCH v12 04/11] tracing/wprobe: Add wprobe (watchpoint pro=
be) trace event support ---
commit 6f99af1ed7b9527ff7af700fbd99ed2a3d0632d9
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/wprobe: Add wprobe (watchpoint probe) trace event support

This commit adds wprobe, a hardware-breakpoint-based dynamic trace event.
It allows users to monitor memory accesses by setting hardware breakpoints
on specified addresses or symbols and logging the access context.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> new file mode 100644
> index 0000000000000..df592d9280a47
> --- /dev/null
> +++ b/kernel/trace/trace_wprobe.c
[ ... ]
> +static int __register_trace_wprobe(struct trace_wprobe *tw)
> +{
> +	struct perf_event_attr attr;
> +	int i, ret;
[ ... ]
> +	hw_breakpoint_init(&attr);
> +	attr.bp_addr =3D tw->addr;
> +	attr.bp_len =3D tw->len;
> +	attr.bp_type =3D tw->type;
> +
> +	tw->bp_event =3D register_wide_hw_breakpoint(&attr, wprobe_perf_handler=
, tw);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^

[Severity: Medium]
When a watchpoint probe is created for a module symbol, does this leave a
dangling hardware breakpoint if the module is later unloaded?

Since the wprobe subsystem doesn't seem to register a module notifier
(unlike kprobes) to clean up when modules are unloaded, the breakpoint stays
active on the raw virtual address. If that memory is freed and subsequently
reallocated for a different module or vmalloc allocation, could this lead
to spurious trace events and unintended performance overhead on the reused
memory?

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

[Severity: Medium]
Is it possible to track the module lifecycle here when resolving the symbol?
Currently, kallsyms_lookup_name() simply translates the module symbol to an
address, but without pinning the module or reacting to unload events, the
hardware breakpoint loses its relationship to the original symbol once the
module disappears.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178611679753.237811=
.10190793347982785419.stgit@devnote2?part=3D4
