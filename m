Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE75647F77;
	Wed, 10 Sep 2025 01:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757466693; cv=none; b=o3r220Yvu5mUXYfOmoAXA3N6xwKh/W2hpT6aHpTS7gc4oADKBDUBzUGv7X6jkdgZ5rh28LjZy7z9xrrm+nxPQ3DeCy3XVk7tbRIlGUycXSqAqvG26vh6+LJNuBi7KTZnbKOuaogXyyJEV7POUckd63GnmLJLiTzTIF7JvB3WyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757466693; c=relaxed/simple;
	bh=me7mm6j5bFax1a8L5hQQQttfgizgvMr7z8oH5+HxUL8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GvNHRLWf47PfsaaCY3ShrRhLCjK+0WpgtVMazdFdE+o7u9Qh5rVrQvDJiTkaz03opQ4TcX07/LIofL8xD3DnPLZAuO+q1zYXHSqWk2PhdjKH24fs+nMjRvrClQs/agWMIGpwpj5e1aPgefQyUeW+T/1prTV0t+grgR8XlRfqRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F21vkvbM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F21vkvbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85270C4CEF4;
	Wed, 10 Sep 2025 01:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757466693;
	bh=me7mm6j5bFax1a8L5hQQQttfgizgvMr7z8oH5+HxUL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F21vkvbMpUJVmoDQUmiNQw8iDZjDmmx9PEA+CM1+2eeda29pdSlbrNSS7b0FE3Gf6
	 LPVKDc0Dx2bAQB4wxzRsCLtaPRPdzz+mG8zNYkOg00mGHq4fRkRmDxmHVJvdwebEg7
	 JJEZkuWELdb6xohW9pUDBdjyJF4dtUCI3vzU5WTQTb96+A7hAfScitAY9GY3A+2LQk
	 DQRCh1SGZjhi4eojRtLtHdcp9gWbt4sbl1MlXAdz1x6KyxUeYPeb7uxHHCN8B274nU
	 0HthspDOlV0mSmR7hf+VZcbJvPIcTJA1vx6HVa/e+eRZS84lIl6nSGMKnbeDsDEF82
	 3puHQ74SP+8Pw==
Date: Wed, 10 Sep 2025 10:11:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers
 <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] tracing: wprobe: Add wprobe for watchpoint
Message-Id: <20250910101127.08c9602fe47b0eb18bde5897@kernel.org>
In-Reply-To: <bab08c27-cf0a-445e-8071-dac2a0f8c6d1@gmail.com>
References: <175673787502.478080.3342912952394010967.stgit@devnote2>
	<20250902230204.f3e81b03e7f6805caba1b717@kernel.org>
	<c8a312e9-644a-45e0-8184-6eac8d8f4af1@gmail.com>
	<20250905110852.2c9a0be5f5e5338f1a00cdd4@kernel.org>
	<bab08c27-cf0a-445e-8071-dac2a0f8c6d1@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> - trigger_data issue:
> >>     it appears that the instance being removed is not the same as
> >>     the one that was originally set.
> > 
> > Did you mean it will free invalid struct event_trigger_data by
> > wprobe_trigger_free(), or hw_breakpoint instance?
> > 
> > When trace_event_enable_disable(wprobe_data->file, 1, 1) at
> > wprobe_trigger_cmd_parse(), the trace_wprobe is enabled == call
> > enable_trace_wprobe(), which eventually call register_wide_hw_breakpoint()
> > with dummy address. IOW, the (wide)hw_breakpoint is allocated here.
> > 
> > When the trigger is hit, modify_wide_hw_breakpoint_local() is called
> > for updating local target address on the same hw_breakpoint.
> > So latter instance should be the same.
> In wprobe_trigger_cmd_parse(), consider removing:
>    echo '!set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
> The trigger_data passed to event_trigger_unregister() is freshly allocated.

Ah, thanks for pointing it out.
I confused to free newly allocated trigger_data instead of existing
one on the list.
Let me fix that.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
