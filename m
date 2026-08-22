Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A837E317;
	Sat, 22 Aug 2026 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787392155; cv=none; b=fNkPQTXsp/D2AjnLFNnIECJ1M9zf3Ve+9XOT9MLjpZU2KPgGLtG7eraU0a42UTkcoy+RjTRSrjJwPWJgxGZbfo9/mU2Sx3NfEYjQaq+DwG1deg6qDRH9puHVH8KWOtWC4Ema+EUxeILSS7RZxL09jlE0VHkyUYtO+pZITBE7SBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787392155; c=relaxed/simple;
	bh=+Y/KTjwbi7jQMfqNacHdQps0x8Q4kQ8ZGa9zg094bfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wu4v8y2vpdC1fUD+y+Z9kWnS4SutfIB9SuA23C/73u2U4sfsWzXDZNNVsrTvcYb1Pe7S0DFlCIX4ElxlqWkHqHsxVc5vMAUFOJ9U/ZOUGA4sDV15g2xlzXV+QXaKzSaVUohFvEiCKleF2Z+AtPzoTxVKukWcJ33jx8rWDtNSktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE/UhrE9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE/UhrE9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C281F000E9;
	Sat, 22 Aug 2026 09:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787392154;
	bh=qcIl28njrHQvKozrYikp/9V3dxDlpEi4pRVZextA7To=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JE/UhrE9pfqXHSaJKvv0GNPpVGKthXa7eCXsbAw8H1BpropCVDyDNeiIw9MNn+DZ0
	 uHbIhJ8aI1AecDvJ6/vvvrjB1xggNM34mzRYK6Ty0CDRJ6OiwoAecw/NIxzu7o4j3h
	 nxGvK+WvXjWPnHR7bkbSmGkO0rg01fGKvGESpUHdT35m7t5UGYc8Hv+Fq4a4Fyr764
	 V3t1mBRk5kOvwzGAF6ecFzc2ibECKxmHWTU3KmO+xV3HueyC6Br3ll6/L7cUnMnjIb
	 XVtvIO3qp7vm8Sk29Y2bjB6hdputFYH+uUkQwJCPenVnpIYdp4h3smX1uSRkFmmqNo
	 H78jRrDcm53MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 05/12] tracing/wprobe: Add wprobe (watchpoint probe)
 trace event support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178739064718.1520941.13864925402314213363.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
 <178739064718.1520941.13864925402314213363.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:49:13 +0000
Message-Id: <20260822094914.09C281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The trace_wprobe_show function uses %pS to format the symbol addre=
ss, breaking dynamic event restoration because kstrtoint() in parse_address=
_spec cannot parse the appended symbol size.
- [Medium] Address validation in parse_address_spec incorrectly exempts add=
ress 0 from the kernel space TASK_SIZE check, allowing user-space tracing a=
t address 0.
--

--- Patch [5]: [PATCH v13 05/12] tracing/wprobe: Add wprobe (watchpoint pro=
be) trace event support ---
commit 8eff80da8ae4225daa9b5646b430ded1a73ae7ae
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/wprobe: Add wprobe (watchpoint probe) trace event support
   =20
Add hardware-breakpoint-based dynamic trace event support (wprobe).
Wprobe creates a dynamic event on data read/write accesses using
hardware breakpoints and logs the access context and fetchargs.
   =20
Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> new file mode 100644
> index 0000000000000..a8543766a245b
> --- /dev/null
> +++ b/kernel/trace/trace_wprobe.c

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
> +
> +	if (_addr !=3D 0 && _addr < TASK_SIZE) {

[Severity: Medium]
Does this allow user-space tracing at address 0?

The condition explicitly exempts _addr =3D=3D 0. If a user specifies an add=
ress
of 0, it appears this would bypass the TASK_SIZE check and successfully
allow setting a hardware breakpoint in user space.

> +		trace_probe_log_err(at + 1 - _spec, BAD_ACCESS_ADDR);
> +		return -EINVAL;
> +	}
> +
> +	*addr =3D _addr;
> +	*type =3D _type;
> +	*len =3D _len;
> +	return 0;
> +}

[ ... ]

> +static int trace_wprobe_show(struct seq_file *m, struct dyn_event *ev)
> +{

[ ... ]

> +	if (tw->len =3D=3D HW_BREAKPOINT_LEN_1)
> +		len =3D 1;
> +	else if (tw->len =3D=3D HW_BREAKPOINT_LEN_2)
> +		len =3D 2;
> +	else if (tw->len =3D=3D HW_BREAKPOINT_LEN_4)
> +		len =3D 4;
> +	else
> +		len =3D 8;
> +
> +	if (tw->symbol)
> +		seq_printf(m, " %s@%pS:%d", type_str, (void *)tw->addr, len);

[Severity: High]
Will formatting the address with %pS break dynamic event restoration?

Using %pS appends the symbol size to the output string, which results in
formats like symbol+0x0/0x100.

When this string is saved and written back to restore the event,
parse_address_spec() extracts the offset part (+0x0/0x100) and passes it
to kstrtoint(). Since kstrtoint() requires a strict integer format, won't
it fail on the /size suffix and return -EINVAL, preventing restoration?

> +	else
> +		seq_printf(m, " %s@0x%lx:%d", type_str, tw->addr, len);
> +
> +	for (i =3D 0; i < tw->tp.nr_args; i++)
> +		seq_printf(m, " %s=3D%s", tw->tp.args[i].name, tw->tp.args[i].comm);
> +	seq_putc(m, '\n');
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178739053919.152094=
1.17662338993878200834.stgit@devnote2?part=3D5
