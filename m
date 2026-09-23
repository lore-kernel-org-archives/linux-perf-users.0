Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E4941D652;
	Wed, 23 Sep 2026 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153809; cv=none; b=HAMERTBV+X9LP8ISkggoN2oQsU0zrMEw0eAXCDSe4w4s60K0EdktQRFspIuDnBVXjKl9f8T8aqtMd9LgfQbusZy6v054peFnmKVK2IoznOJj9eRnW0fZ37NA5SanzaGIQ2wjhbNRKqrWkWljighOcvw8Ks8uQYoFAHR/qXoMCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153809; c=relaxed/simple;
	bh=D+PRfodcb5DeYcdICrW1OrpyffEkbwC4VHviyDXCiY4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WxaevH9f7rPFXFe1mlmydhXh0yOVN/hgtOR+EzHaLENx+CUWoozP1PM3Ka3+P1UW+LK+1PdrwjRa7GeBfB0gqG2taWc3gNImoFtzq+WBEIuYGx3YcwzaO1Xt+aFocxNKrerzkH7LUg+xiiflpYagIKbzfDBXVXbrm6lLrZeljH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3cr94nW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3cr94nW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3EE1F000FF;
	Wed, 23 Sep 2026 08:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790153807;
	bh=peEgk85oW0o45UEk+b/f1O4XOFTkrbbpNKdH9tZIxrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R3cr94nWvED/W8J4yBUH6ftLMuhyyHma6K/pTW4JT9FLiWtaRj+uRuCeL5BLUAeLB
	 aGfV/WAIMXemugLY+j/hmXoZ+4Rle7iPgaXAzQfraKHXhV8VxKDOnRnagoNpbP90NA
	 68QQyaQgzvPuLpypffKoSeoVgi1OCPtq57yP/SKpJmt2UPlAyNEz0MvrnhWbtWa00R
	 PzkU3ld9Gp9zu8mQ5N9fjRXi7nxze2GkWNm+xxZkhaGeUlKVnB78EZvI3Va/SKCHmh
	 FjmDuJ3MdShYxJTPYuxbKD/rp2Akbdzz+W4cy9dJyvdWKrAfDinjPm10c8T5P8R7hW
	 peCzBfAHiMWbw==
Date: Wed, 23 Sep 2026 17:56:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Sean Christopherson
 <seanjc@google.com>, Jinchao Wang <wangjinchao600@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner
 <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org,
 x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v17 01/13] x86/mce: Fix hardware debug register
 corruption on task migration
Message-Id: <20260923175640.e8d80d19e63a77b75a8968d4@kernel.org>
In-Reply-To: <20260923002740.GAarMc_PJBsgo8Z-G9@fat_crate.local>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
	<179005109564.388919.3937970081044095776.stgit@devnote2>
	<20260923002740.GAarMc_PJBsgo8Z-G9@fat_crate.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 17:27:40 -0700
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Sep 22, 2026 at 01:24:55PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > In exc_machine_check_user(), local_db_save() and local_db_restore() are
> > invoked in the outer entry stubs (DEFINE_IDTENTRY_MCE_USER,
> > DEFINE_FREDENTRY_MCE, and DEFINE_IDTENTRY_RAW), surrounding
> > exc_machine_check_user().
> > 
> > However, exc_machine_check_user() calls irqentry_exit_to_user_mode(),
> > which handles pending thread work and may schedule() if TIF_NEED_RESCHED
> > is set. If the task migrates to another CPU during schedule(),
> > local_db_restore() runs on the new CPU with the dr7 state saved from the
> > old CPU. This corrupts the new CPU's DR7 hardware debug register and
> > leaves the old CPU's DR7 disabled.
> > In short, local_db_save() and local_db_restore() pair must be run
> > on the same CPU.
> > 
> > To fix this, move local_db_save() and local_db_restore() inside
> > exc_machine_check_user() and exc_machine_check_kernel(). In
> > exc_machine_check_user(), DR7 is saved and restored strictly around
> > do_machine_check() to avoid schedule() during migration. In
> > exc_machine_check_kernel(), local_db_save() is called at the entry point
> > to prevent early memory accesses from triggering nested #DB exceptions,
> > and restored on all exits.
> > 
> > Fixes: cd840e424f27 ("x86/entry, mce: Disallow #DB during #MC")
> > Assisted-by: Antigravity:gemini-3.8-flash
> 
> verify_tags: WARNING: Zapping LLM ads tag: ['Antigravity:gemini-3.8-flash'].
> 
> Needs to be:
> 
> Assisted-by: LLM
> 
> Please fix all your patches.

Ah, let me fix it.

> 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> > Changes in v15:
> >  - Move local_db_save() to the entry of exc_machine_check_kernel() and
> >    restore it on early return from mce_check_crashing_cpu() to prevent
> >    nested #DB on watched variables.
> > Changes in v14:
> >  - Newly added.
> > ---
> >  arch/x86/kernel/cpu/mce/core.c |   27 ++++++++++-----------------
> >  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> Yah, makes sense.
> 
> I'm thinking this needs to be CC:stable and I should take it in now.

OK. thanks for review!

> 
> Peter?
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
