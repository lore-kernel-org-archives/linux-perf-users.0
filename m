Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B293A7D91
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080927; cv=none; b=QA0pDNS6fZXrc7Lzk93EdmHiKJh9iuTLOGDPc1MsrOd2e7Dg7VEWHie+L34AQAd9T7yfMoojFozBHvGpCavI5JwjO+bSDYKlxQYUYnZDDsrERbp5Xst14yTVrTsYxonXNL6exoiAyGa8qfNy8eaKKlwyCzzTda4inrFGeixznLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080927; c=relaxed/simple;
	bh=Ive9c/Fu1Xp9qibBahEfHN8BOMyp3DlmR0gSpk8p3Ic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q4a7iKnRME3EB/bqqnv1Qc5gHyGNEPMN8AttSEKtanhu2kztNts5bZGEcybZgd68AbyeLKmh7X10Q0j31+f7eeldPApTMtCDLmnJb9sro/zRz5mQRdaB6+27bBpYDSl2mbQaPPxCLz7d4Qhe3LPlxUFmbUkNsfsv9Os8NagXqvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj7Qutzo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj7Qutzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8211F000E9;
	Wed, 15 Jul 2026 02:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784080926;
	bh=bie8z8i1H0QiVSJxckrykHOGTG2wiCSm8Zjgw8O56lM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gj7QutzomKcRNQXcrSV8StBqKmuAxFul9FnzYHFXoSjhQFGSPdNw99RZJ4PJwfifm
	 GxyyPeeOgXv0e8o/15NM7jQ5meotoTesUM06FEE+68qxl58WUS4okGscvDbqaEGE/4
	 GUIavkzqxP7qjPRlsovIxMvtdqEbls5U/Eg3vrKRkKA8gtlINPSSxOpME+2Ek4+eMM
	 T4i2tUOd6BOYJnb5HeBgB7UAbq86E4QvXVKpzRGu59YEmHozx1OwG29bl4AeRpu4AJ
	 LxItNI+wsSXWLapE2qW4agcTi0XMJs+CRmGiwO9hr4F461BHQ/PfX5jsXWZpy5TyG0
	 nAvsp+NK1pq9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/10] tracing: wprobe: Use a new
 seq_print_ip_sym_offset() wrapper
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178407989708.95826.17630423823637072384.stgit@devnote2>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
 <178407989708.95826.17630423823637072384.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 02:02:05 +0000
Message-Id: <20260715020206.0D8211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Symbol offsets are discarded in wprobe definitions when displayed =
via tracefs, preventing round-tripping of event specifications.
- [High] Failure to register hardware breakpoints leaves the trace_probe in=
 a corrupted, pseudo-enabled state, causing future enablement attempts to s=
ilently fail.
- [High] The dynamically allocated `symbol` string is permanently leaked ev=
ery time a wprobe with a symbol is created.
- [Medium] Meaningful code and commit message mismatch regarding the use of=
 a new wrapper function.
--

--- Patch [5]: [PATCH v7 05/10] tracing: wprobe: Use a new seq_print_ip_sym=
_offset() wrapper ---
commit f3a4507e611a20fcf1578dc82ce81258e7452d39
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing: wprobe: Use a new seq_print_ip_sym_offset() wrapper

The commit message states it refactors code to use a new seq_print_ip_sym_o=
ffset()
wrapper. However, the commit only adds an include statement, missing the=20
expected implementation changes.

Link: https://lore.kernel.org/all/176226550596.59499.18020648957674458755.s=
tgit@devnote2/

> tracing: wprobe: Use a new seq_print_ip_sym_offset() wrapper
>=20
> Use a new seq_print_ip_sym_offset() wrapper function instead of
> using TRACE_ITER(SYM_OFFSET) mask directly.

[Severity: Medium]
Is this commit missing the actual implementation changes? The commit
message claims to refactor code to use a new wrapper function, but the
diff only adds an include directive.

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index b52f3eac719f9..dd310a87b3333 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c
> @@ -20,6 +20,7 @@
>  #include <asm/ptrace.h>
> =20
>  #include "trace_dynevent.h"
> +#include "trace_output.h"
>  #include "trace_probe.h"
>  #include "trace_probe_kernel.h"
>  #include "trace_probe_tmpl.h"

I also noticed a few other concerns in this file:

[Severity: High]
Does parse_address_spec() drop the offset from the base symbol?

kernel/trace/trace_wprobe.c:parse_address_spec() {
    ...
		if (off_str) {
			if (kstrtoint(off_str, 0, &offset) !=3D 0) {
				trace_probe_log_err(off_str - _spec, BAD_PROBE_ADDR);
				return -EINVAL;
			}
			*off_str =3D '\0';
    ...
}

If the offset string is stripped and discarded here, it causes the
offset to be dropped from the probe's symbol representation.=20

When trace_wprobe_show() emits the symbol, it is truncated:

kernel/trace/trace_wprobe.c:trace_wprobe_show() {
    ...
	if (tw->symbol)
		seq_printf(m, " %c@%s:%d", type_char, tw->symbol, len);
    ...
}

If a user reads the event definition via tracefs, it will display the
probe as simply w@jiffies instead of w@jiffies+10. If this definition
is saved and loaded back, it attaches to the base symbol instead of
the offset address, leading to incorrect behavior.

[Severity: High]
Does enable_trace_wprobe() fail to handle rollback properly on error?

kernel/trace/trace_wprobe.c:enable_trace_wprobe() {
    ...
	if (!enabled) {
		list_for_each_entry(tw, trace_probe_probe_list(tp), tp.list) {
			ret =3D __register_trace_wprobe(tw);
			if (ret < 0) {
				/* TODO: rollback */
				return ret;
			}
		}
	}
    ...
}

If __register_trace_wprobe() fails, it returns an error immediately
without clearing the flags set earlier (TP_FLAG_PROFILE or file links).=20

Could this missing rollback leave the trace_probe in an incorrectly
enabled state, causing future enablement attempts to silently fail
because trace_probe_is_enabled() will return true?

[Severity: High]
Does this code leak the symbol string?

kernel/trace/trace_wprobe.c:parse_address_spec() {
    ...
		_addr +=3D offset;
		*symbol =3D kstrdup(at + 1, GFP_KERNEL);
		if (!*symbol)
			return -ENOMEM;
    ...
}

The string pointed to by symbol is allocated here. Then
__trace_wprobe_create() passes it to alloc_trace_wprobe():

kernel/trace/trace_wprobe.c:__trace_wprobe_create() {
    ...
	ret =3D parse_address_spec(argv[1], &addr, &type, &len, &symbol);
	if (ret < 0)
		return ret;
    ...
	tw =3D alloc_trace_wprobe(group, event, symbol, addr, len, type, argc);
    ...
}

But alloc_trace_wprobe() duplicates the string again:

kernel/trace/trace_wprobe.c:alloc_trace_wprobe() {
    ...
	if (symbol) {
		tw->symbol =3D kstrdup(symbol, GFP_KERNEL);
		if (!tw->symbol)
			return ERR_PTR(-ENOMEM);
	}
    ...
}

The original symbol pointer in __trace_wprobe_create() is never freed
before the function returns on either success or error paths, which
might leak the string memory on every wprobe creation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178407983818.95826.=
12714571928538799781.stgit@devnote2?part=3D5
