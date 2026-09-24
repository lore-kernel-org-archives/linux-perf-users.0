Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDF3242BD;
	Thu, 24 Sep 2026 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213508; cv=none; b=pNxUm9Zqs+Tc84LXNBJsNilNrRGwPYYb2AnJb2cV+/bROyM1QaRiKzPfIPKMm1uAPCPqzxhJpApiVuUD+zny0Y0eWRR2MnfvrvF7TD2m/IJIqEij2aVib+HkJ3wxHC5gZX1xOZzSBQ3YJAKMHdIXpf9QsKpzqS3U0srwt+/asNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213508; c=relaxed/simple;
	bh=AfbUml1zJZuQ7JQDHXkKhPCakS6f3z7l1oMwGfmQH8w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CwDghJxuCRqqHtlL8oaxydnHvommFG5ZAyZ3f9nBXJngqJ2k8hMTIYzdefvlz3Ujsj3y8IJz+8/ZwiEBvUjS53FBQTxxI2RfxbR3uJokKoONP+Vb3bKLTuCTd55WNTDoLMC/y/zy+faMlkSYRPjL60VbWdFzCMWArNsS/+fRUFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgtzvATJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgtzvATJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E9F1F000FF;
	Thu, 24 Sep 2026 01:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790213506;
	bh=VuGY/Y4MYw5Lk44aMfqov/6Tvy5hvDKuLf8QBS3Ct+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CgtzvATJ8hrijhakctAOEKQonRdEqfGNIX4T10dnY0tszwSl7UtIb3O90PE1k3h9+
	 vpIxzLi0tlhs632g8SGvZe7MTRl5MHgEVYwmT9qjrPnIx3OEziMQngAfZsR9+iscEx
	 KilQmaZxjVBCNJiQrTNUzkalNR3kZMVBRavdIksd7xZqvZT4IPaiM+GmZ1aQCK1vr8
	 xu/0mBkSfGgcZR3b02udLurUOwa3SpvZNn3/hy+XtBLego51MSNVNQuUWxsDjRWMZ/
	 DImLrOAVfaOoIA0HjrjG7m2iB2VeVERW5rZSQXdA3IUJUerm2mO7cpjcz2y2HDwJwr
	 BZ7d2NmoFfJog==
Date: Thu, 24 Sep 2026 10:31:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar
 <mingo@kernel.org>, Jinchao Wang <wangjinchao600@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers
 <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org, x86@kernel.org, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v17 02/13] perf/x86, KVM: Prevent host debug register
 leak into guest OS on NMI
Message-Id: <20260924103140.0a40bb18812cbb913be5e662@kernel.org>
In-Reply-To: <arPjK1-PVp_UqAsQ@google.com>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
	<179005110742.388919.1509641807739909065.stgit@devnote2>
	<20260923085139.GV776954@noisy.programming.kicks-ass.net>
	<arPjK1-PVp_UqAsQ@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 07:33:15 -0700
Sean Christopherson <seanjc@google.com> wrote:

> On Wed, Sep 23, 2026, Peter Zijlstra wrote:
> > On Tue, Sep 22, 2026 at 01:25:07PM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > When KVM enters a guest OS, host hardware breakpoints are disabled
> > > before running the guest. However, an NMI can occur while executing
> > > in guest mode or during guest transition, where
> > > arch_install_hw_breakpoint() can be invoked from NMI context.
> > 
> > How? AFAICT perf doesn't do that. arch_install_hw_breakpoint() is called
> > through pmu::add() which is strictly IPI context.
> 
> I assume it's:
> 
>   kgdb_nmi_handler()
>   |
>   -> kgdb_nmicallin()
>      |
>      -> kgdb_cpu_enter()
>         |
>         -> arch_kgdb_ops.correct_hw_break()
>            |
>            -> kgdb_correct_hw_break()
>               |
>               -> arch_install_hw_breakpoint()

Yes, it is done by KGDB. perf has no problem with it.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
