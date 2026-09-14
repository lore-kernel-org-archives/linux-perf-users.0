Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0361E7660;
	Mon, 14 Sep 2026 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354158; cv=none; b=Ldneqjnm4IleSnyg4G8CfRjV/Av2/HuazbYIJ0Cpwcm3N7zy+goFkmiWgCffhG+/GEWbj5dTgmgc0G7NyVdZOLZZVMFBt0/CZpDYavJp6vBFMYOYb9axUxF3IcaTDSOU3KW12er8Przj/YoSYNElgqYZhMFjje5L1Ygl6//ncWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354158; c=relaxed/simple;
	bh=4vh9gjNXkhaXvqa+21uDOCrbVDJJ6w5SisKdKFzjLd0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=C1rG72markvQmCmhd1wO+7TpSw95KsfULskw9VbtXjfS+J5ebeqRLAnvyR+igUksQDqTQWS6Kh9iloS05qYNUW0F13sygQu88b0eUodCff/Eff6VKZ9XdoA65IYEt2tDZ382kQNghltSBfjsYub1yVciz/aqdQGWEDmDwTWjdqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyevcDcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyevcDcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7E41F000FF;
	Mon, 14 Sep 2026 02:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789354156;
	bh=Ho19rv+CrXyjO2kYe0RCDDpCrf+9WcveIFGfghODl34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dyevcDcs7PvWg4jzyqDDXyjnrKQUUsxkhJI1aRqFR2mpd15VDkx50Q1qYhhdUk7yH
	 6/qaA9WeZepHSeJLUDhoo6i34jnLR71cQvtDd38nXlFtyDpNmisUL2HNfynw/OsFS8
	 wBq3h5u9WA3P6bIGCy35vXDG0AETrVShPtTBaJRGBy8zRKJ++qAFXGg36aIE6t1yKo
	 qaUAidl/iT34V17i7C76IuAKTDCUqJ1BK7Uv/1LWTTKwxgP+X+Bdkd6xHh3CBt4V5p
	 oHuFo96Xy57fVn5zSve23LMAOnl/YB3ukgJm9ic6DyqWCuDH1ufGo0vS5WPr0W6dxY
	 V/tzajxIWeHAA==
Date: Mon, 14 Sep 2026 11:49:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v15 02/12] x86/hw_breakpoints: Make DR7 updates NMI safe
Message-Id: <20260914114912.51a8c4649d5a9e812ede1349@kernel.org>
In-Reply-To: <20260907040017.1983E1F00ACA@smtp.kernel.org>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
	<178875280112.93794.5857698342827027053.stgit@devnote2>
	<20260907040017.1983E1F00ACA@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Sep 2026 04:00:16 +0000
sashiko-bot@kernel.org wrote:

> > diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
> > index 854d82b88ff4e..3399e166d3044 100644
> > --- a/arch/x86/include/asm/debugreg.h
> > +++ b/arch/x86/include/asm/debugreg.h
> [ ... ]
> > @@ -125,40 +126,66 @@ static __always_inline bool hw_breakpoint_active(void)
> >  
> >  extern void hw_breakpoint_restore(void);
> >  
> > -static __always_inline unsigned long local_db_save(void)
> > +static __always_inline void local_db_save(unsigned long *dr7,
> > +					  unsigned int *dr7_seq)
> >  {
> > -	unsigned long dr7;
> > +	do {
> > +		*dr7_seq = this_cpu_read(cpu_dr7_seq);
> > +		*dr7 = 0;
> >  
> > -	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
> > -		return 0;
> > -
> > -	get_debugreg(dr7, 7);
> > +		if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) &&
> > +		    !hw_breakpoint_active())
> > +			return;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but could this early return
> in local_db_save() bypass the sequence retry loop?
> 
> If an NMI hits exactly before the return instruction and installs a
> breakpoint, the function exits immediately. This leaves the newly installed
> hardware breakpoint active during exception handlers like MCE, which could
> trigger a recursive #DB exception and lead to a kernel panic.

Wait... but fixing this may leak the DR7 setting to the guest. We need another
patch to solve this, which introduce a per-cpu flag to prohibit updating the
DR7 during switching to the guest.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
