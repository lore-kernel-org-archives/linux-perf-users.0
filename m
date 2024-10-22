Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C313D29A;
	Tue, 22 Oct 2024 03:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568705; cv=none; b=F40Sqj5C+9SyAfQUqH6HFThYEoU15pJC5Xnx6I+J/3rax8O+zHkqZXpG+gxvIlZSeUJGrPJV4NNlE6azNJIihNw5dP8JU9zf4hsPEo8to63EMkO+jcwc79jrqSHUtIWAbo0HAnub4Vr/r+qbwNEz6fgntM+jVj2hj6CZLgTaLJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568705; c=relaxed/simple;
	bh=6I0mvst7lAdIAG/bfAktuB/3E3GlhodpBxthzqVy7cQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k8A7UD/di/cvwSjt7XG4D2s+qmtlWHDvnedoIJE4A6hYMirFcOa4eeTcU+kirxfd3J/5xAJt/vXploKeLv23hDl8eSyUz97CGnxIpgkWVyeAHvb04oBA/sULOS6KGFn/yI8K6OOVGOHagHG6xqEBgBVAh1gEQ8ZSMC8f8a5k5fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5bdybK4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5bdybK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BB1C4CEC3;
	Tue, 22 Oct 2024 03:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729568705;
	bh=6I0mvst7lAdIAG/bfAktuB/3E3GlhodpBxthzqVy7cQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d5bdybK4RuBAXeLp91kyhWHk5c1QSAm9qh6NefwRT1IlS1atiIFfCMtRAbBS28yDZ
	 LUUmvf6kEUH7/jOT4LO2iN2UAPOIlBqP/tX9TgJ65eDXhgyZD3Y2JUN80mDeLk5EpR
	 AQaphyirqlxWbuyHlhEd4XJplldmlfJfieIl8Q4DGDpts0kWEs5spBvPi7UPw3F8Pl
	 1CNLJL9mOiP75+8W73wSBBKCx5Psd/tE96tmrH0DXZVFTEGrlpnQJsttA6TXg5XI/M
	 N2d0KSzog8nr6qLu2OtjN6AfVq+bq30q8+flvJB70K6Hk0KZXSST9udAXVpUV3iQOC
	 rRmdc83dI5tqA==
Date: Tue, 22 Oct 2024 12:45:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Liao Chang <liaochang1@huawei.com>,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: Remove redundant spinlock in
 uprobe_deny_signal
Message-Id: <20241022124501.5a6875f4d1725e2864cdcc48@kernel.org>
In-Reply-To: <20241022112222.1edeeac3aee13714a53c217c@kernel.org>
References: <20240731095017.1560516-1-liaochang1@huawei.com>
	<20240731141231.GB16718@redhat.com>
	<20241022112222.1edeeac3aee13714a53c217c@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 11:22:22 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 31 Jul 2024 16:12:32 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
> 
> > On 07/31, Liao Chang wrote:
> > >
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -1979,9 +1979,7 @@ bool uprobe_deny_signal(void)
> > >  	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
> > >  
> > >  	if (task_sigpending(t)) {
> > > -		spin_lock_irq(&t->sighand->siglock);
> > >  		clear_tsk_thread_flag(t, TIF_SIGPENDING);
> > > -		spin_unlock_irq(&t->sighand->siglock);
> > 
> > Agreed, in this case ->siglock buys nothing, another signal can come
> > right after spin_unlock().
> > 
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > 
> > 
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Peter, can you pick this?

Oops, there is v3.

https://lore.kernel.org/linux-trace-kernel/20240815014629.2685155-2-liaochang1@huawei.com/

> 
> Thanks,
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
