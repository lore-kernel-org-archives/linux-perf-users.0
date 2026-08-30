Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1CB3BA22C;
	Sun, 30 Aug 2026 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101574; cv=none; b=uHV5RLCgQ2DYYPbhbdBwf+sHlka15gSXer3ORpDyzT0/LrP1+TL/cPKk79B8xJaTxr/dIk4jtOVIKXcKL0Or1CuwK+VLZD1RNr+7Ru5haSEJ+bBfdlKbHniJAHrmtpE28lcw/XzM/gKuvaLfel8QXrDzsHUnMIT0YMo+U5C1GqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101574; c=relaxed/simple;
	bh=uOHyFLRuc+2SE6QFYbozwto90vg1cSP5ANW0W5/C05U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uBZCnALTn9lYwnw3a2L8ZtS/Job4Hu7b1GWSRRr3KwH428CcTIiPaljkOfZK/BsguJ5MFctFUCfYqFKuJDse9aNzJQJpFf/72OO4JCuc+ds3kdkSbR+l9DYJE7exJj0MAnR+3Vdboko09oiEefPla8DP65YIC5cfYJjc9UVovmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2Xdzfhf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2Xdzfhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA74A1F000E9;
	Sun, 30 Aug 2026 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788101572;
	bh=xl6NCJDud5NrLa33LNwHcrWZwaFTcKNOvQwTtBwHmqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G2XdzfhfllUpatS/H+JnSFUH7eB+U6F14dZt5aNBlvPuCQGQZJmrayUBCsvHDvHMR
	 zIB7KQ4oIg4vqFP5WvZeiLSVcmLi9aD8EQKsVIJ+18XMEzua0inCVm4Zf3+VmlHj7/
	 i+61ICxwe3QA42E9SWOG8q5F8+2uwe5dO7Nik4hmNoGzqgQ1Qw47s/6SMjKI7eSfSt
	 moQX1jA+8xeLsoxWLfZhotQhCuBkGLSDUuTJ9dx1ms5GvJuVUHWoFxomq9gQXxMyN8
	 txn+VV3nCEnMGtaueiDqMabGb1krD9a9d3LGqa4LOXVQkqzjtptzugA5ExAL4+z+xa
	 8k7SOjqnngIsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 11/14] tracing/wprobe: Add set_wprobe and
 clear_wprobe event triggers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178810013249.64882.3483637605217266271.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
 <178810013249.64882.3483637605217266271.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:52:52 +0000
Message-Id: <20260830145252.AA74A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Calling `cancel_work_sync()` on an uninitialized `work_struct` i=
n the error path triggers a kernel warning (WARN_ON).
--

commit 5e74cd56c202daf7ad5f60c9e251b2bc86cf21d8
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Subject: tracing/wprobe: Add set_wprobe and clear_wprobe event triggers

This commit adds set_wprobe and clear_wprobe event triggers to dynamically
attach and detach hardware breakpoint address monitoring based on event fie=
ld
contents.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index 6a11c55e75373..29eae708ae7bc 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c
[ ... ]
> @@ -199,14 +217,62 @@ static int __register_trace_wprobe(struct trace_wpr=
obe *tw)
[ ... ]
>  static void free_trace_wprobe(struct trace_wprobe *tw)
>  {
>  	if (tw) {
> +		irq_work_sync(&tw->irq_work);
> +		cancel_work_sync(&tw->work);

[Severity: Medium]
Will this trigger a kernel warning in __flush_work() if the work struct has
not been initialized yet?

In alloc_trace_wprobe(), if the kstrdup() allocation for the symbol fails,
the function returns early. Since the tw pointer is managed by the
__free(free_trace_wprobe) guard, it will automatically invoke this cleanup
function:

alloc_trace_wprobe() {
    ...
    tw =3D kzalloc_flex(*tw, tp.args, nargs);
    ...
    if (symbol) {
        tw->symbol =3D kstrdup(symbol, GFP_KERNEL);
        if (!tw->symbol)
            return ERR_PTR(-ENOMEM); /* triggers free_trace_wprobe(tw) */
    }
    ...
    INIT_WORK(&tw->work, wprobe_work_func);
}

Because the early return happens before INIT_WORK() is called,
cancel_work_sync() will operate on a zeroed work_struct, which can cause a
WARN_ON(!work->func).

>  		trace_probe_cleanup(&tw->tp);
>  		kfree(tw->symbol);
>  		kfree(tw);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178810001186.64882.=
2161016469449127450.stgit@devnote2?part=3D11
