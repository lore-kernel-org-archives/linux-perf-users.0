Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9838C40E;
	Tue, 28 Apr 2026 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387432; cv=none; b=YuoIR9HxYvn4LYI3hGzWNv4lRzZ0/3//FU8ZPLOuQnYUPN/BO9mxJ8OlLr1+7MfnNO7h4dwM2UL2H/KhMs/Iuw8zdJtkjACeUNlGg3vGUw7SUooUrlro6oRkmgSzf/v4k5PW6nKT++nW0FsyRm5tim0llKLCkNMeZNsbRlah40k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387432; c=relaxed/simple;
	bh=O329fgNiq9iP/8KjuIGPzJeCt+QLcRuMXTYRGIB7NW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9r8fWQKio9eDeeOqrtPAjuW32ZhSxSaBJQbT4mBZnyraYWuJSVcG/5DPXY/SqMDh5GCHFwU7rdqhRnuT9wgnzKRHO1nc9E0pOAgpZJnMTiFEnsRE9I9De6oOPCm4cHPoOX0Vtldp2YLPgFpnjQK1XZbBu/RXw37xMZsVfHNRWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wHjf3-00000000sGE-2kfV;
	Tue, 28 Apr 2026 16:43:41 +0200
Date: Tue, 28 Apr 2026 16:43:41 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/3] perf test: fix sys_enter_openat event test for musl
Message-ID: <afDHnTl4X2lO+s9f@nb282.user.codasip.com>
References: <20260427090225.794482-3-martin@kaiser.cx>
 <20260427094939.4FB8EC19425@smtp.kernel.org>
 <ae_kClvu1mDBE218@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae_kClvu1mDBE218@google.com>

Thus wrote Namhyung Kim (namhyung@kernel.org):

> On Mon, Apr 27, 2026 at 09:49:37AM +0000, sashiko-bot@kernel.org wrote:
> > Sashiko AI review found 1 potential issue(s):
> > - [Medium] The updated bitwise check `(tp_flags & flags) != flags` fails to verify the `O_RDONLY` access mode and permits arbitrary unrelated flags, severely weakening the test.
> > --

> > commit 0700122c98ba7f263a329cd8f9fbeef95b67603e
> > Author: Martin Kaiser <martin@kaiser.cx>

> > perf test: fix sys_enter_openat event test for musl

> > This commit updates the sys_enter_openat test to allow additional flags in the
> > captured event. It replaces the strict equality check with a bitwise mask check
> > to accommodate the O_LARGEFILE flag implicitly added by musl libc.

> > > diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
> > > --- a/tools/perf/tests/openat-syscall-tp-fields.c
> > > +++ b/tools/perf/tests/openat-syscall-tp-fields.c

> > [ ... ]

> > > @@ -120,7 +120,8 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused

> > >  				tp_flags = evsel__intval(evsel, &sample, "flags");
> > >  				perf_sample__exit(&sample);
> > > -				if (flags != tp_flags) {
> > > +				/* C library wrapper may set additional flags */
> > > +				if ((tp_flags & flags) != flags) {

> > Does this check still verify the O_RDONLY access mode?

> > Since O_RDONLY is defined as 0, the flags variable evaluates to exactly
> > O_DIRECTORY. This means the condition functionally becomes
> > (tp_flags & O_DIRECTORY) != O_DIRECTORY.

> > Does this unintentionally permit other access modes like O_WRONLY or O_RDWR,
> > and ignore other unrelated flags as long as O_DIRECTORY is set?

> I think it's ok for tp_flags to have more flags.

I added another check for the access mode flags in v2. This addresses the
sashiko comment and allows for additional flags in the syscall wrapper.

Best regards,
Martin

> Acked-by: Namhyung Kim <namhyung@kernel.org>

> Thanks,
> Namhyung


> > >  					pr_debug("%s: Expected flags=%#x, got %#x\n",
> > >  						 __func__, flags, tp_flags);
> > >  					goto out_delete_evlist;

> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260427090225.794482-1-martin@kaiser.cx?part=2
