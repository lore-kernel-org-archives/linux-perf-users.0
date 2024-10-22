Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB34132124;
	Tue, 22 Oct 2024 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563748; cv=none; b=UqaqIgq/WG8bv5PWkvwvali5ejltA1yVAQ7Z2Y5U7+sp/iICnKIgY/G1b78M4JpGox+S9GRVXP1Y3vCkWlaFralCerMOday5mejdPkMCNYxaXAgoGYa0yL7PpLAm8Z2y0tZnn5bhIx3xo7SWcRf8sQO4eWkeYYgduyjviFryMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563748; c=relaxed/simple;
	bh=cvOmKRaGaYic+n9hOuxtcNdHZWL09dWwyvl2zywQ6YA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f+Ocb1HJ7YkU195LIm+OlNhMAPr5RKrO+tEKiKAYQazUYQhJpDozHK7fuvBuI5jx1f5r6rsmUaZg8KTcXlFJXH8hdMyzytT41zDyRW0iPiEGyy/9lspdt2mwGvMquRPvbve230vc9FcVMuekP1jBEYR+u57ur16n+C4kejdmQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBjvOxRG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBjvOxRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B84C4CEC3;
	Tue, 22 Oct 2024 02:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729563746;
	bh=cvOmKRaGaYic+n9hOuxtcNdHZWL09dWwyvl2zywQ6YA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vBjvOxRGdj9JZ0nSM7TA2sy0vRXPjqAC1D6zruQaiuk9dyPya31u1p8bAQmzZk3a3
	 9x5nFBCwPdGYk4CRPzLkxQ4g8FMfpgm5/44kbrdG3SezFZL9tUN8wnJ+zpzhbEIfoZ
	 EhFIEhRksSf1VbHTjvR7fr+1EHGkD7A3fbN0pTbgsxfWikGhu9a+/wItrxUO57uC29
	 5j6cUda1NSV3q3sDWWwqCUtquUVqGhU7d2R/VnxYV84o85n3ujbbFAzHtO1Z8AP+nL
	 CWELl1DIrHS379TaS08rbjd3VMdbSS9uIkkEFblzA54ArRR2MLiEUDWJ2lsEw+UIQP
	 Njwqo4GA6PZGg==
Date: Tue, 22 Oct 2024 11:22:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Liao Chang <liaochang1@huawei.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 mhiramat@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: Remove redundant spinlock in
 uprobe_deny_signal
Message-Id: <20241022112222.1edeeac3aee13714a53c217c@kernel.org>
In-Reply-To: <20240731141231.GB16718@redhat.com>
References: <20240731095017.1560516-1-liaochang1@huawei.com>
	<20240731141231.GB16718@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 16:12:32 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 07/31, Liao Chang wrote:
> >
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -1979,9 +1979,7 @@ bool uprobe_deny_signal(void)
> >  	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
> >  
> >  	if (task_sigpending(t)) {
> > -		spin_lock_irq(&t->sighand->siglock);
> >  		clear_tsk_thread_flag(t, TIF_SIGPENDING);
> > -		spin_unlock_irq(&t->sighand->siglock);
> 
> Agreed, in this case ->siglock buys nothing, another signal can come
> right after spin_unlock().
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Peter, can you pick this?

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
