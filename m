Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4773290AF;
	Wed,  2 Sep 2026 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312657; cv=none; b=hXnVyVuuqja6G0gdbD17Oj16eE7MdWNRD8xM5GXUttNZsdvJdbGTRlbbIbyjUTUFgvbuCxEg2/EmPdLvmh9pwyRNm/zrQxX2s5cKLNbAae1YN9LFQBJHjxROR7bcV8KQ0eRbRREofJo5JhzkGWhlhZMjYIri9KXVoYvuqjP3QrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312657; c=relaxed/simple;
	bh=1LFvGAlJvQYRB2Qe5YT3TZoW2p4vS6hQvr0tOn8s+GY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OUP9ZlTVWfJpr6Qa9yC3kHoFElJEBW7ZrW7GEV1Elf5I5P21Cqk8QAxGaEipZtd9X+o/VlmvaCyLLOpK0wSGnW8ZRLK84zK4JAdIFc/I3yXTcJ7IKiKd3Jv9lnXuwIAM3jqY9dbf916ups70F9uCvSHKAXMT8tR5jFe+dhdrElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0RO2uW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0RO2uW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6927B1F000E9;
	Wed,  2 Sep 2026 01:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788312655;
	bh=upflwmhIkzbTAXcF1Nqhwa5DA7BS5duawjtQhsEzpXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k0RO2uW7SCCJjXJVtS4XGEMIRgC6mrQXEfhPOsk+Z1CioFZT94BnHH1WdHsFsPx/Q
	 8gyZatRyshWZOIWTwsWDgf3R5dhV1Yu24+lh5rKR7gxpnbRKwBcfygbdF+HmrRa2hj
	 1bIBjurKZDTiAYsIQFuWZ5sKWHKKIhYd/YFUZHjqitt4MY6L4XmgRx5WkoBwNd4fhS
	 xD8Knx4SnuBp0JN++cpz27x2Mlaq22qF33nN1zn0ngnski3AI2kIbnzFMf8NyFauYe
	 IsTEqGMlvFIVLqd/ts6MnFtX3WoaRByAyAd8gpo1WFgoFdOyT8BdjixklaUGZ0m+Vr
	 H+m/OdASiOdkw==
Date: Wed, 2 Sep 2026 10:30:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v14 03/14] kprobes: Protect kprobe_blacklist with RCU
Message-Id: <20260902103049.78b8a90f58ddfcc89db71237@kernel.org>
In-Reply-To: <178810004323.64882.16493230858653316962.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
	<178810004323.64882.16493230858653316962.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2026 23:27:23 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> __within_kprobe_blacklist() traverses kprobe_blacklist without holding
> kprobe_mutex. When a module is unloaded, kprobe_remove_area_blacklist()
> removes blacklist entries and immediately frees them with kfree().
> A concurrent call to within_kprobe_blacklist() can therefore dereference
> freed memory.
> 
> Furthermore, within_kprobe_blacklist() can be called in atomic or
> non-preemptible contexts where the sleeping kprobe_mutex cannot be taken.
> 
> Protect kprobe_blacklist with RCU. Use guard(rcu)() and
> list_for_each_entry_rcu() for traversal, list_add_tail_rcu() for
> insertions, list_del_rcu() for deletions, and kfree_rcu() to reclaim
> entries safely after a grace period.

I realized this is required even without wprobe. So let me take this
as a stable fix with following tags.

Fixes: 376e242429bf ("kprobes: Introduce NOKPROBE_SYMBOL() macro to maintain kprobes blacklist")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260807155802.F06041F000E9@smtp.kernel.org/

Thanks,

> 
> Assisted-by: Antigravity:gemini-3.7-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v13:
>  - Newly added.
> ---
>  include/linux/kprobes.h |    1 +
>  kernel/kprobes.c        |   14 ++++++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 8c4f3bb24429..e6de7ae55bda 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -181,6 +181,7 @@ struct kprobe_blacklist_entry {
>  	struct list_head list;
>  	unsigned long start_addr;
>  	unsigned long end_addr;
> +	struct rcu_head rcu;
>  };
>  
>  #ifdef CONFIG_KPROBES
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index bfc89083daa9..6337da5cab9e 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1447,8 +1447,14 @@ static bool __within_kprobe_blacklist(unsigned long addr)
>  	/*
>  	 * If 'kprobe_blacklist' is defined, check the address and
>  	 * reject any probe registration in the prohibited area.
> +	 * Note: this can return true during transition period where
> +	 * (start_addr, end_addr) in the black list is shrinking
> +	 * but old entry has not been removed yet. This is acceptable
> +	 * because the worst case is that we reject more probes than
> +	 * we should.
>  	 */
> -	list_for_each_entry(ent, &kprobe_blacklist, list) {
> +	guard(rcu)();
> +	list_for_each_entry_rcu(ent, &kprobe_blacklist, list) {
>  		if (addr >= ent->start_addr && addr < ent->end_addr)
>  			return true;
>  	}
> @@ -2509,7 +2515,7 @@ int kprobe_add_ksym_blacklist(unsigned long entry)
>  	ent->start_addr = entry;
>  	ent->end_addr = entry + size;
>  	INIT_LIST_HEAD(&ent->list);
> -	list_add_tail(&ent->list, &kprobe_blacklist);
> +	list_add_tail_rcu(&ent->list, &kprobe_blacklist);
>  
>  	return (int)size;
>  }
> @@ -2603,8 +2609,8 @@ static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
>  	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
>  		if (ent->start_addr < start || ent->start_addr >= end)
>  			continue;
> -		list_del(&ent->list);
> -		kfree(ent);
> +		list_del_rcu(&ent->list);
> +		kfree_rcu(ent, rcu);
>  	}
>  }
>  
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
