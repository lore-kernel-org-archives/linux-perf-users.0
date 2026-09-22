Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D81441DE11
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109225; cv=none; b=Jn4iLTHFEC3a+jMnpK//v0EgAzy+rbebCh0yQ5sNr61XROyi81x/Jg75An/Xoy7SewDuYWjR7PeTZYd+cn8zQ5p13RDUnMvhBqFDVbS9PlAn3ucqCELQMcvNqjAgD8Z4wLGr9A3NV9EJWa1CsmzzIQ5ZjmWpQCFm8BmT3dKV3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109225; c=relaxed/simple;
	bh=ZfxNUiAXLjZA1FAZStXH1Z55oMZRkZi3ztxzNRmLKqE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AdiqIO7WnG9BMoUoqbWcTz+DIoQVx6B3NfDDKa+iN7glXSOVLjn/h8sEQwEQ5f+Q7Add3RlvRfXaNpXWR/V2LHLtJ8Cw/vR/t7qviAtyhAeZgC0RG/Fxtzcr692YWbuiMnQqvEtvG1qCvlK9iyDfLMQC897wnlRfvdj+3TeNThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+3Gy6UF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+3Gy6UF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EEF1F000FF;
	Tue, 22 Sep 2026 20:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790109211;
	bh=9u0H2gAsuScwceJi1XBwisIueDNyVsDXYZUfzxr854c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T+3Gy6UFps08WAyz8i0+SEgsCqnhsPqocUomAaZ8ia/UhgKxIg0yGDFJhdJpfziLe
	 b7m3Q0J0tEeHSpcyh+OAJnLuoBZXpC62sas1px/4zQ+Y3m/RpR4L1LlqtfL+D2tYDK
	 4pRUcfceXvLjaHYc1mlB/eoivfo28mly/EyLdz9hZs81xxs3FbOGWpg95IpnjkXYiG
	 WW3Yap/0dS6SaprLzNxrGa7h27NoNkI7J1rSEaCcUiJtXVRclI05W5KMorwex4Tm93
	 xfsjvxg2GxgjTtgs7JdoH3DnTkZ/tNaGzEXuQyGJgiURpWHsR8wNKTYD0SU+8OEe8J
	 eCq+wCbWZ0QMQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/3] sparc64: Support PERF_SAMPLE_REGS_USER and
 PERF_SAMPLE_STACK_USER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922201507.1719668-3-stian@itx.no>
References: <20260922201507.1719668-1-stian@itx.no>
 <20260922201507.1719668-3-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:33:30 +0000
Message-Id: <20260922203330.F2EEF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf: sparc64: infoleak of uninitialized kernel stack via PERF_REG=
_SPARC_G0
- [Medium] perf: sparc64: PERF_SAMPLE_STACK_USER fails due to 2047-byte sta=
ck bias
--

commit dc2931cc8aec6bb17c7d08c4adfcf954bfdf3a68
Author: Stian Halseth <stian@itx.no>

sparc64: Support PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER
   =20
Select HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP and add the
perf_regs implementation. The exposed registers mirror struct pt_regs:
%g0-%g7, %o0-%o7 (named from the user's point of view; pt_regs calls
them UREG_I*), %tstate, PC, NPC and %y.

> diff --git a/arch/sparc/kernel/perf_regs.c b/arch/sparc/kernel/perf_regs.c
> new file mode 100644
> index 0000000000000..726516abf5a74
> --- /dev/null
> +++ b/arch/sparc/kernel/perf_regs.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/perf_event.h>
> +#include <linux/perf_regs.h>
> +#include <linux/sched/task_stack.h>
> +#include <asm/cacheflush.h>
> +#include <asm/ptrace.h>
> +
> +u64 perf_reg_value(struct pt_regs *regs, int idx)
> +{
> +	u64 val;
> +
> +	switch (idx) {
> +	case PERF_REG_SPARC_G0 ... PERF_REG_SPARC_O7:
> +		val =3D regs->u_regs[idx];
> +		break;

[Severity: High]
Since %g0 is hardwired to zero on the SPARC architecture, the trap entry
code does not save it into the PT_V9_G0 slot (u_regs[0]) of the pt_regs
structure on the kernel stack.

When an unprivileged user configures a perf event to sample
PERF_SAMPLE_REGS_USER or PERF_SAMPLE_REGS_INTR and requests the %g0
register (where idx=3D0), does returning regs->u_regs[0] here expose
uninitialized kernel stack memory to userspace per sample?

[Severity: Medium]
For PERF_REG_SPARC_O6 (%sp), returning the raw register means the stack
pointer remains biased by 2047 bytes on SPARC64.

While the commit message notes this biased address is expected by
consumers, when perf_output_sample_ustack() attempts to copy the stack, it
will start 2047 bytes below the actual mapped stack frame.

Could this high probability (~25% for 8KB pages) of starting in an unmapped
page cause __copy_from_user_inatomic() to immediately fault and abort the
copy? Would this result in a 0-byte dynamic stack dump even for perfectly
valid stack frames, breaking userspace DWARF unwinding and profiling tools?

> +	case PERF_REG_SPARC_TSTATE:
> +		return regs->tstate;
> +	case PERF_REG_SPARC_PC:
> +		val =3D regs->tpc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922201507.1719=
668-1-stian@itx.no?part=3D2
