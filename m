Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8341A904
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054566; cv=none; b=erjC/cAno1J0EVuXYUQblr2lEtxwAX2Nsrwbu/eZtPfZ8KLX4VMn7zLSWr3C2VquR38Nw1vXOcN0601rAojuKO4MhbrFCMLy0y+CnRddPTmXSCxtt8yxyIne7y1hReyi8EIW6QZadD+nc53GofI8cW4beQ68ditZSfVOKGJ/sik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054566; c=relaxed/simple;
	bh=Fxn3HrEtDwi0U8yiJkADvuXzJHcykw6fqir65QNlIjs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L5+0+Jzv2DYwdIIJUxAyxF1YltiIRcPD3SMKN7QvTADr0XjiVfIuVDOddwxRwArWwbA/fN+t31paRzZXo6En3mIGeEKelRC1P4iLTaxflTCnfTeM9zPsTm4ghJeRGvvwHPXgsziFbFsZi5FzOvKHact24mM8qdLfVQUyHxhxMhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh/BaQ6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh/BaQ6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA611F000E9;
	Tue, 14 Jul 2026 18:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784054561;
	bh=ocUw58B0JK4Hk5cQaEQAx7/ewB08NJoUIeYQScidj+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fh/BaQ6JqPEE5ijWVtEdLxyrZE4xn78o0pTaF5m2u5Cvmy83mehvW5JMMjW13Ds/2
	 WWsX8lVyfU5t/OdX3eiVbdAHyb4D/QPlmSYXRyshRJ2kTIgPea2UG8HlgF6+XqSknI
	 MeO4c+xnZ4vvT5/O6qlXmb8t4k+pzPEoV+gPHTylc2U6wvb2SUZwFr+7RTqdn36D/R
	 jn8nQFwS1kuyM4sLhFJ0n+timD7fKLupAjrat15A14Y/w0TPM9oJDJI3C4NZcftKeG
	 ANs05GcY+73jy5naO9xUT6AAB7SAKfuyKoh3fHPUC7ISJ0/pl1Ts3bI8oI3PXp12eB
	 0R1v/dm74ZhXg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/13] stacktrace: export stack_trace_save_regs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714183146.12598-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
 <20260714183146.12598-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:42:40 +0000
Message-Id: <20260714184240.CBA611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch exports `stack_trace_save_regs` so it can be used by m=
odules, but fails to update the in-tree kprobes sanity test which contains =
a workaround specifically because the symbol was previously unexported. Lea=
ving the workaround artificially reduces test coverage for module builds.
--

--- Patch [7]: [RFC PATCH 07/13] stacktrace: export stack_trace_save_regs()=
 ---
commit 594dee655bf56c8a9f1858d2d50ddbf441315c12
Author: Jinchao Wang <wangjinchao600@gmail.com>

stacktrace: export stack_trace_save_regs()

The other stack_trace_save_*() flavours are exported, but the regs
variant is not, so no module can capture a stack trace for a given
pt_regs. KWatch, which may be built as a module, uses it. Export it like
its siblings.

> diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> index afb3c116da91a..d853c40f916b2 100644
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -175,6 +175,7 @@ unsigned int stack_trace_save_regs(struct pt_regs *re=
gs, unsigned long *store,
>  	arch_stack_walk(consume_entry, &c, current, regs);
>  	return c.len;
>  }
> +EXPORT_SYMBOL_GPL(stack_trace_save_regs);

[Severity: Medium]
Since stack_trace_save_regs() is now exported for modules, should we also
update the kprobes sanity test to remove the workarounds that skip testing
this function when built as a module?

In lib/tests/test_kprobes.c:stacktrace_return_handler():

#if !IS_MODULE(CONFIG_KPROBES_SANITY_TEST)
	/*
	 * Test stacktrace from pt_regs at the return address. Thus the stack
	 * trace must start from the target return address.
	 */
	ret =3D stack_trace_save_regs(regs, stack_buf, STACK_BUF_SIZE, 0);

And similarly in lib/tests/test_kprobes.c:stacktrace_internal_return_handle=
r():

#if !IS_MODULE(CONFIG_KPROBES_SANITY_TEST)
	/* Ditto for the regs version. */
	ret =3D stack_trace_save_regs(regs, stack_buf, STACK_BUF_SIZE, 0);

Removing these checks would restore test coverage for module builds now that
the symbol is available.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714182243.1068=
7-1-wangjinchao600@gmail.com?part=3D7
