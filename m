Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB842E0914;
	Wed, 23 Sep 2026 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123297; cv=none; b=NbRsDLdzZAFNRa7rObyHNh0yc8uZ+7DSt9rwWybpvJgjjFmvZ1/gSB82oKSubZo/hKir1oUXk0YQEo/KpfqvoGILLJZM2hTu5pIb/7guZ6Z/bUovENXpnVl4ZLrlEVcaKW9MJdfnihl2rq1VyJeEuZW04j0jAwsZ0/X45rtX6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123297; c=relaxed/simple;
	bh=e/8AUG/U+Kxf1s5zTCI9RybjwZNolay9RX9f+zXPy9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjuxpugz0WrccF7ORp6VEPbU/PlinQ1ULMn3LGo9wGab8cUmrB5MPx1ywLUhJ+mWRwYkJfH+jVaEc3fgXSfREOzWHMc4obSwjOu34iwwXAvkHUtMFDvnQqmPI9bsdmV8m88A5sdzIZwTtWY8TCCsPJ3n0BjcZ6PnR+JOWe+eklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MQK7JvYj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MQK7JvYj"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1C0D840E0173;
	Wed, 23 Sep 2026 00:28:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2CL9VprPB2RT; Wed, 23 Sep 2026 00:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790123283; bh=Aei0PnNzOTQ4gUUS/HiOefLQYuJlYg4D48KXdNRhLDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQK7JvYj3uTqo4iUnmytE6B5PDXhZoHcJ3o/w4h4dEhyK+MtCeOiu2G2pxo22Ydds
	 yO56SIIGgm6XzZST5WFFu7gOeB2fZb4DaznqdN/85dtnA3jMfdSGUEQk8tYxkF64Fq
	 NHBYNCotYo8eIEZQUf5UzDDXoD3QF8mgGHCS93ThPVcvnwfhQ0uEouyTgzvRoharKx
	 OA+cwI9oy6qb0rPVAeBL5BRc7UqrsdMDSkUa9QHk8IR6ko52rdlKBS50K1iUnoYVN5
	 +/XdhL/TckndyuB0WZQB4kTLRrYI9BlpVfqrcmabOl0brkPsDg66U8M+9oO0R/Smr4
	 O7aGjmfiaVkDXLA1HSeHnFL2qmYHq4PTKFcNvrzLYFEbD2wtKhP3ACspeF4u3IEvOZ
	 xjyBPOHI+H6jjKDnV0Ycem0FnkLcXVFm8QNb0d6/s7cR5TM6p5oBOgFqnrO9hKbYNf
	 lFazQltkWOpOC1fIm6wy65dG53wFcrdj6pzDsF6btEHJflW+2afwzSA5pEsNU8IPop
	 EtyaOCkvwj3n0x8BBaaJNjd7kMNzXbSfM6GuLA5A6nsF+BlBAPisVt/d1Lp4qapRGo
	 3O5FPuJ6QMqrav1S8AFqxhESdv+FRYQ73VtM3vK3dc9DSrw6gLg8Z3POwVCvg452Ao
	 gF0g9uZVEPi69dLu4GxxvA2Q=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6899640E015D;
	Wed, 23 Sep 2026 00:27:43 +0000 (UTC)
Date: Tue, 22 Sep 2026 17:27:40 -0700
From: Borislav Petkov <bp@alien8.de>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v17 01/13] x86/mce: Fix hardware debug register
 corruption on task migration
Message-ID: <20260923002740.GAarMc_PJBsgo8Z-G9@fat_crate.local>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005109564.388919.3937970081044095776.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179005109564.388919.3937970081044095776.stgit@devnote2>

On Tue, Sep 22, 2026 at 01:24:55PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> In exc_machine_check_user(), local_db_save() and local_db_restore() are
> invoked in the outer entry stubs (DEFINE_IDTENTRY_MCE_USER,
> DEFINE_FREDENTRY_MCE, and DEFINE_IDTENTRY_RAW), surrounding
> exc_machine_check_user().
> 
> However, exc_machine_check_user() calls irqentry_exit_to_user_mode(),
> which handles pending thread work and may schedule() if TIF_NEED_RESCHED
> is set. If the task migrates to another CPU during schedule(),
> local_db_restore() runs on the new CPU with the dr7 state saved from the
> old CPU. This corrupts the new CPU's DR7 hardware debug register and
> leaves the old CPU's DR7 disabled.
> In short, local_db_save() and local_db_restore() pair must be run
> on the same CPU.
> 
> To fix this, move local_db_save() and local_db_restore() inside
> exc_machine_check_user() and exc_machine_check_kernel(). In
> exc_machine_check_user(), DR7 is saved and restored strictly around
> do_machine_check() to avoid schedule() during migration. In
> exc_machine_check_kernel(), local_db_save() is called at the entry point
> to prevent early memory accesses from triggering nested #DB exceptions,
> and restored on all exits.
> 
> Fixes: cd840e424f27 ("x86/entry, mce: Disallow #DB during #MC")
> Assisted-by: Antigravity:gemini-3.8-flash

verify_tags: WARNING: Zapping LLM ads tag: ['Antigravity:gemini-3.8-flash'].

Needs to be:

Assisted-by: LLM

Please fix all your patches.

> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v15:
>  - Move local_db_save() to the entry of exc_machine_check_kernel() and
>    restore it on early return from mce_check_crashing_cpu() to prevent
>    nested #DB on watched variables.
> Changes in v14:
>  - Newly added.
> ---
>  arch/x86/kernel/cpu/mce/core.c |   27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)

Yah, makes sense.

I'm thinking this needs to be CC:stable and I should take it in now.

Peter?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
