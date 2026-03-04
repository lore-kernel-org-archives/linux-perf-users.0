Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0D311C1D;
	Wed,  4 Mar 2026 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772588681; cv=none; b=VhQKVbrOPkoYDEyU4gYIS/Z0rO0yyMqlFXeALRV8phcSwYEf2dMY0AHH5FLhzpivWQSabH/sAFICvuL7/Ra9NW32OwGLBjSjG9mB3A3ev8kegmxyHMP4RTM6JWnobdcbufTMxYCYskLR5V+rmy2IPetoFCeUDSKt3NlXgtWUzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772588681; c=relaxed/simple;
	bh=oZwjviSkhyeuq9R/+idT1YLDI73C8Z1XUZqzYEKeDKM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ewj0kAkkoiB7Og/ClVlfu0MzVmkI0mIhvio1hcxtcA3qiGKrnKckE/UyIbvE8LQaXZdIT/qWNFYJ3zLGji28kb6gSO9kt0IaRE80G+ZNLNYtf9pWM1Te2whTEPsa1fzIKUW3hqcYWNfPW/Q3APeieKxKrng6HQIRPx7sxuNPxVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3LvK95J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3LvK95J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726AAC116C6;
	Wed,  4 Mar 2026 01:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772588680;
	bh=oZwjviSkhyeuq9R/+idT1YLDI73C8Z1XUZqzYEKeDKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N3LvK95JeeEesjvzjvQtq8U213vHtZUX2m85PgKqiH2x1G/neNv3yJS1YAjfBeA6Q
	 G0jnkev1MnzhYiGl09WaIvRXDM8OxSKVYxF8z+ZSWZQzACnNS9OjGzN5rGZrFjltK9
	 Ok5XuuyJbgVv4JJW5FbQROJHg8J8bVOv+UdlScgtfrN7P54t+vWDgVnuy2uJ83u/G/
	 9sAE+0T7JtZxqu8c0aMQQvH9IylTJEjd2L7tErSCtTeCX5YEkum8fcpwPoL34ns1Zv
	 vZBD5i4NLcAe1HN95xNBvV3QsmnYtr5yiZs1blmawVeffvnEmNKy981GZdUWpRWtKV
	 XXXUfnpktjyrw==
Date: Wed, 4 Mar 2026 10:44:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Zw Tang <shicenci@gmail.com>, Naveen N Rao <naveen@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, "David S . Miller"
 <davem@davemloft.net>
Subject: Re: [BUG] kprobes: WARNING in __arm_kprobe_ftrace when
 kprobe-ftrace arming fails with -ENOMEM under fault injection
Message-Id: <20260304104437.e8eda558a0bc64789fe2ed91@kernel.org>
In-Reply-To: <20260302173551.2555701-1-sashal@kernel.org>
References: <CAPHJ_V+J6YDb_wX2nhXU6kh466Dt_nyDSas-1i_Y8s7tqY-Mzw@mail.gmail.com>
	<20260302173551.2555701-1-sashal@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon,  2 Mar 2026 12:35:49 -0500
Sasha Levin <sashal@kernel.org> wrote:

> https://lore.kernel.org/all/CAPHJ_V+J6YDb_wX2nhXU6kh466Dt_nyDSas-1i_Y8s7tqY-Mzw@mail.gmail.com/
> 
> ## 1. Bug Summary
> 
> A WARNING is triggered in `__arm_kprobe_ftrace()` at `kernel/kprobes.c:1147` when fault injection causes `ftrace_set_filter_ip()` to return `-ENOMEM` during kprobe arming via `perf_event_open()`. This is a false-positive warning — the error path itself is correct and the error propagates cleanly to userspace, but the `WARN_ONCE()` macro fires a kernel warning splat that is inappropriate for a recoverable allocation failure. The affected subsystem is kprobes/ftrace. Severity: warning only (no crash, hang, or data corruption).

Thanks for analysis and Nice catch Zw Tang!
This looks good analysis to me.

> 
> ## 2. Stack Trace Analysis
> 
> ```
> WARNING: kernel/kprobes.c:1147 at arm_kprobe+0x563/0x620, CPU#0
> Call Trace:
>  <TASK>
>  enable_kprobe+0x1fc/0x2c0
>  enable_trace_kprobe+0x227/0x4b0
>  kprobe_register+0x84/0xc0
>  perf_trace_event_init+0x527/0xa20
>  perf_kprobe_init+0x156/0x200
>  perf_kprobe_event_init+0x101/0x1c0
>  perf_try_init_event+0x145/0xa10
>  perf_event_alloc+0x1f91/0x5390
>  __do_sys_perf_event_open+0x557/0x2d50
>  do_syscall_64+0x129/0x1160
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  </TASK>
> ```
> 
> The crash point is `__arm_kprobe_ftrace()` at `kernel/kprobes.c:1147`, inlined into `arm_kprobe()`. The calling chain is process context: `perf_event_open()` syscall -> `perf_kprobe_event_init()` -> `enable_trace_kprobe()` -> `enable_kprobe()` -> `arm_kprobe()` -> `__arm_kprobe_ftrace()`. R12 holds `0xfffffff4` which is `-12` (`-ENOMEM`), confirming the allocation failure injected by fault injection.
> 
> ## 3. Root Cause Analysis
> 
> The root cause is an overly aggressive `WARN_ONCE()` in `__arm_kprobe_ftrace()` at `kernel/kprobes.c:1147`:
> 
> ```c
> ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
> if (WARN_ONCE(ret < 0, "Failed to arm kprobe-ftrace at %pS (error %d)\n", p->addr, ret))
>     return ret;
> ```
> 
> Prior to commit 9c89bb8e3272 ("kprobes: treewide: Cleanup the error messages for kprobes"), this was a simple `pr_debug()`. That commit promoted it to `WARN_ONCE()` as part of a treewide message cleanup, under the rationale that failures here indicate unexpected conditions. However, `ftrace_set_filter_ip()` calls into memory allocation paths (e.g., `ftrace_hash_move_and_update_ops()` -> `__ftrace_hash_update_ipmodify()` or `ftrace_hash` allocation), and those allocations can legitimately fail under memory pressure or fault injection.
> 
> The error handling is actually correct — the `-ENOMEM` propagates back through `arm_kprobe()` -> `enable_kprobe()` and ultimately causes the `perf_event_open()` syscall to return an error to userspace. The only problem is the spurious `WARN_ONCE()` which triggers a kernel warning splat and stack trace for what is a recoverable, non-buggy situation.
> 
> The same issue also applies to the `WARN()` on line 1152 for `register_ftrace_function()`, which can also fail with `-ENOMEM`.
> 
> ## 4. Affected Versions
> 
> This issue was introduced by commit 9c89bb8e3272 ("kprobes: treewide: Cleanup the error messages for kprobes"), which first appeared in v5.16-rc1. All kernel versions from v5.16 onward are affected, including the reporter's v7.0.0-rc1.
> 
> This is a regression from v5.15, where the same failure path used `pr_debug()` and did not emit any warning.
> 
> ## 5. Relevant Commits and Fixes
> 
> Introducing commit:
>   9c89bb8e3272 ("kprobes: treewide: Cleanup the error messages for kprobes")
>   Author: Masami Hiramatsu <mhiramat@kernel.org>
>   Merged in v5.16-rc1
> 
> This commit changed `pr_debug()` to `WARN_ONCE()` in `__arm_kprobe_ftrace()` for the `ftrace_set_filter_ip()` failure path, and changed a `pr_debug()` to `WARN()` for the `register_ftrace_function()` failure path.
> 
> No fix for this issue exists in mainline or stable as of the reporter's kernel version.
> 
> The suggested fix is to downgrade both `WARN_ONCE()` (line 1147) and `WARN()` (line 1152) in `__arm_kprobe_ftrace()` back to `pr_warn_once()` / `pr_warn()` respectively. This preserves the improved error messages from 9c89bb8e3272 while avoiding spurious warning splats on recoverable failures. The error code is already propagated correctly to the caller.
> 
> ## 6. Prior Discussions
> 
> No prior reports of this specific issue were found on lore.kernel.org. No related mailing list discussions or proposed patches addressing the WARN severity in `__arm_kprobe_ftrace()` were found.
> 
> ## 7. Suggested Actions
> 
> 1. The fix is to downgrade the WARN_ONCE/WARN in __arm_kprobe_ftrace()
>    (kernel/kprobes.c lines 1147 and 1152) to pr_warn_once/pr_warn.
>    Specifically:
> 
>    - Line 1147: Change WARN_ONCE(ret < 0, ...) to a simple
>      if (ret < 0) { pr_warn_once(...); return ret; }
> 
>    - Line 1152: Change WARN(ret < 0, ...) to a simple
>      if (ret < 0) { pr_warn(...); goto err_ftrace; }

Sounds reasonable. Let's fix it.

> 
> 2. This is a low-severity issue that only manifests with fault injection
>    enabled. No data corruption or crash occurs — the error is correctly
>    propagated to userspace. The warning is cosmetic but noisy and can
>    cause false-positive syzbot/syzkaller reports.
> 

Yeah, it is just too aggressive warnings. Let me remove if the error
can be handled correctly.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
