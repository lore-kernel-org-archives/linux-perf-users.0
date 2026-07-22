Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DAA4582CA
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761891; cv=none; b=lbzhzO+bWJXfisYdY5nuy7QPte+OhloZtQA54QcFpH+4ekvSxvYLpJRFe0Q1Pqu6o8hOzYK5NkeA815UJQ1ab18ZCq9JiVcl+eeYARLKMbdIlH07M8ISg8UaqehFpWag2cyxINwKEGua6M4zDD20a4PfDNiZ55yTIIJiMbkF0zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761891; c=relaxed/simple;
	bh=OFlDX0+xbXkjrC30DFwlIMbjDAhFnOJdMJPRREWX89Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nRPe2lyYO5MrPYQ3h+CKXkgPYnIObabjaZP3c70D99q3juDhJDxbsPaKIUzWtJhtGRaObj+66VSHuOidHsUa6PO4I0y+A6jDZdeV9PJn1LdFwzRKnv5CVvBbLYbvbEwZ9FLlObw9EnWczLDJTbKn5A+ZsjJGCYh2eydUmzVukkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1qR6xU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1qR6xU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30B01F000E9;
	Wed, 22 Jul 2026 23:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784761890;
	bh=ULsWVXX92H1aZqlePVhxHbtHbLFk5G2cCXUnlM3FJJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R1qR6xU5L+NxEow5FsKMLbWVrBDQxtrxZuGwK3JLzmwkGGt+ClN4JuIiMGjT1hWQo
	 BtZgKFrlIgA1NSENvPXEvsFywkUn6D+xw34eIPww0ab1Bb15CriJI5V7eYQRho2usP
	 NkrNu7aqOxkXmLB6xWEvjJh2tK2rAlRbOuQhvx+4WYGPM/lSjNDCm7ekmAN1gWgdlL
	 XYk1qDPTd7IzWpRKMESI+tUIQFklV8yzWdZRLleowG1QhX4YRokHWLgzG8J9vDJ+fS
	 9draPms8C00pcLoZjrdncnfPRiTuhkQWk05QgvxwHxAWz++XP+KZPlKrrKCEmaPXS0
	 xmYfMs8IzyyOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/11] x86: hw_breakpoint: Add a kconfig to clarify
 when a breakpoint fires
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178476137184.26117.2239692963036759209.stgit@devnote2>
References: <178476134787.26117.10094977293012760490.stgit@devnote2>
 <178476137184.26117.2239692963036759209.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:11:29 +0000
Message-Id: <20260722231129.E30B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Alphabetical sorting violation in arch/x86/Kconfig.
--

--- Patch [2]: [PATCH v10 02/11] x86: hw_breakpoint: Add a kconfig to clari=
fy when a breakpoint fires ---
commit c9585173523a761e022d70aa1fafe72b621c85b9
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

x86: hw_breakpoint: Add a kconfig to clarify when a breakpoint fires

Add CONFIG_HAVE_POST_BREAKPOINT_HOOK which indicates the hw_breakpoint
on that architecture fires after the target memory has been modified.
This is currently x86 only behavior.

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index bdad90f210e4b..6b7e14ef8cfb3 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -246,6 +246,7 @@ config X86
>  	select HAVE_FUNCTION_TRACER
>  	select HAVE_GCC_PLUGINS
>  	select HAVE_HW_BREAKPOINT
> +	select HAVE_POST_BREAKPOINT_HOOK
>  	select HAVE_IOREMAP_PROT

[Severity: Low]
This isn't a bug, but should HAVE_POST_BREAKPOINT_HOOK be placed further
down in the list to maintain alphabetical sorting?

It is currently inserted before HAVE_IOREMAP_PROT.

>  	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
>  	select HAVE_IRQ_TIME_ACCOUNTING

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178476134787.26117.=
10094977293012760490.stgit@devnote2?part=3D2
